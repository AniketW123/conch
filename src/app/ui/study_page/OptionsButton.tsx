import React, { useEffect, useState } from "react";
import { AlertDialog, AlertDialogBody, AlertDialogContent, AlertDialogFooter, AlertDialogHeader, 
    AlertDialogOverlay, Button, Checkbox, Input, NumberDecrementStepper, NumberIncrementStepper, NumberInput, NumberInputField, NumberInputStepper, Spinner, useDisclosure } from "@chakra-ui/react"
import { getOptions, saveOptions } from "../../lib/firebase/firestore";

interface OptionsButtonProps {
    uid: string;
    studyMode: string;
    options: any;
    setOptions: React.Dispatch<React.SetStateAction<any>>
}

export const OptionsButton = ({ uid, options, setOptions, studyMode }: OptionsButtonProps) => {
    const { isOpen, onOpen, onClose } = useDisclosure()
    const cancelRef = React.useRef<HTMLButtonElement | null>(null)

    useEffect(() => {
        getOptions(uid, studyMode).then((options) => {
            setOptions(options);
        });
    }, [isOpen, setOptions, studyMode, uid]);

    function handleOption(key: string, value: any, optionKey: number) {
        switch (typeof value) {
            case "boolean":
                return(
                    <div key={optionKey} className="flex flex-row items-center my-2">
                        <p className="ml-3 mr-auto text-lg">{key}</p>
                        <Checkbox
                            defaultChecked={value} checked={value} className="mr-3" size={"lg"} 
                            disabled={
                                (key === "True/False Questions" && options["True/False Questions"] && !options["Multiple Choice Questions"] && !options["Free Response Questions"]) ||
                                (key === "Multiple Choice Questions" && !options["True/False Questions"] && options["Multiple Choice Questions"] && !options["Free Response Questions"]) ||
                                (key === "Free Response Questions" && !options["True/False Questions"] && !options["Multiple Choice Questions"] && options["Free Response Questions"])
                            }
                            onChange={(e) => setOptions({ ...options, [key]: e.target.checked })}
                        >
                        </Checkbox>
                    </div>
                )
            case "number":
                return(
                    <div key={optionKey} className="flex flex-row items-center my-2">
                        <p className="ml-3 mr-auto text-lg">{key}</p>
                        <NumberInput
                            variant={"outline"} className="mr-3" width={"80px"} 
                            defaultValue={value} min={-1}
                            onChange={(e) => {
                                setOptions({ ...options, [key]: Number(e) })
                            }}
                        >
                            <NumberInputField />
                            <NumberInputStepper>
                                <NumberIncrementStepper />
                                <NumberDecrementStepper />
                            </NumberInputStepper>
                        </NumberInput>
                    </div>
                )
            default:
                return <p>{typeof value}</p>
        }
    }

    return (
        <>
            <Button variant="outline" className="ml-auto w-20 rounded-lg" onClick={onOpen}>Options</Button>
            <AlertDialog isOpen={isOpen} leastDestructiveRef={cancelRef} onClose={onClose}>
                <AlertDialogOverlay>
                    <AlertDialogContent>
                        <AlertDialogHeader fontSize='3xl' fontWeight='bold'>Options</AlertDialogHeader>

                        <AlertDialogBody justifyContent={"space-between"}>
                            {
                                !options ? <Spinner className="m-auto"/> : Object.entries(options)
                                    .sort(([keyA], [keyB]) => keyA.localeCompare(keyB))
                                    .map(([key, value], optionKey) => handleOption(key, value, optionKey))
                            }
                        </AlertDialogBody>

                        <AlertDialogFooter>
                            <Button ref={cancelRef} onClick={() => {
                                saveOptions(uid, options, studyMode)
                                onClose()
                            }}>
                                Update
                            </Button>
                            <Button colorScheme='red' onClick={onClose} ml={3}>
                                Cancel
                            </Button>
                        </AlertDialogFooter>
                    </AlertDialogContent>
                </AlertDialogOverlay>
            </AlertDialog>
        </>
    )
}