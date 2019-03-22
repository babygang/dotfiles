if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi


# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
# export COCOS_ROOT=/Applications/Cocos/Cocos2d-x/cocos2d-x-3.10
COCOS_ROOT=~/work/cocos/cocos2d-x-3.13.1
COCOS_CONSOLE_ROOT=$COCOS_ROOT/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_X_ROOT for cocos2d-x
COCOS_X_ROOT=/Applications/Cocos/Cocos2d-x
export PATH=$COCOS_X_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
COCOS_TEMPLATES_ROOT=$COCOS_ROOT/templates
export PATH=$COCOS_TEMPLATES_ROOT:$PATH
