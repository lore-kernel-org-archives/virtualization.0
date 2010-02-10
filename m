From: Jan Engelhardt <jengelh@medozas.de>
Subject: Paravirt compile failure with gcc33
Date: Wed, 10 Feb 2010 19:13:24 +0100 (CET)
Message-ID: <alpine.LSU.2.01.1002101909560.29808@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,


As I was compile-testing 2.6.33-rc with gcc-3.3,
binutils-2.19.51-10.26.4.x86_64, I observed a failure when 
CONFIG_PARAVIRT is turned on:


[any file]
/home/jengelh/code/linux/arch/x86/include/asm/paravirt.h: In function 
`rif_seq_stop':
/home/jengelh/code/linux/arch/x86/include/asm/paravirt.h:763: warning: 
asm operand 5 probably doesn't match constraints
/home/jengelh/code/linux/arch/x86/include/asm/paravirt.h:858: warning: 
asm operand 2 probably doesn't match constraints
/home/jengelh/code/linux/arch/x86/include/asm/paravirt.h:763: error: 
impossible constraint in `asm'
/home/jengelh/code/linux/arch/x86/include/asm/paravirt.h:858: error: 
impossible constraint in `asm'

Disabling either PARAVIRT or using GCC4.x works around this.
