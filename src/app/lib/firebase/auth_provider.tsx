import React, { createContext, useContext, useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { auth, signInWithIdToken } from './auth';
import { getUserTokenCookie } from '../cookies';
import { usePathname } from 'next/navigation';
import { User, inMemoryPersistence, setPersistence } from 'firebase/auth';
import firebase from 'firebase/auth';

interface AuthContextValue {
    user: firebase.User | null;
    authLoading: boolean;
}

export const AuthContext = createContext<AuthContextValue>({user: null, authLoading: true});

export default function AuthProvider({ children }: { children: React.ReactNode }) {
    const [user, setUser] = useState<firebase.User | null>(null);
    const [authLoading, setAuthLoading] = useState(true);
    //TODO: add loading
    const router = useRouter();
    const pathname = usePathname();

    useEffect(() => {   
        setPersistence(auth, inMemoryPersistence)
        const unregisterAuthObserver = auth.onAuthStateChanged((user) => {
            console.log("auth state changed - user is: ", user);
            setUser(user);
            if(user) {
                if(pathname === "/log_in" || pathname === "/") {
                    router.push('/home');
                }
            } else {
                getUserTokenCookie().then((user_token) => {
                    if ((user_token ?? "") !== "") {
                        signInWithIdToken(user_token!).then((success) => {
                            if(success) {
                                if(pathname === "/log_in" || pathname === "/") {
                                    router.push('/home');
                                }
                            } else {
                                router.push('/log_in');
                            }
                        })
                    } else {
                        router.push('/log_in');
                    }
                });
            }
            setAuthLoading(false);
        })

        return () => unregisterAuthObserver();
  }, [pathname, router]);

    return (
        <AuthContext.Provider value={{user, authLoading}}>
            {children}
        </AuthContext.Provider>
    );
}

export function useAuth() {
    return useContext(AuthContext);
}