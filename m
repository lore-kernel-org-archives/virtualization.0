From: Don Mullis <dwm@meer.net>
Subject: Re: [PATCH 1/4] Prep for paravirt: Be careful about touching BIOS
	address space
Date: Sun, 29 Oct 2006 12:01:09 -0800
Message-ID: <1162152070.23311.27.camel@localhost.localdomain>
References: <1161920325.17807.29.camel@localhost.localdomain>
	 <1161920535.17807.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751887AbWJ2UH5@vger.kernel.org>
In-Reply-To: <1161920535.17807.33.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> @@ -301,7 +302,7 @@ static struct pci_raw_ops pci_bios_acces
>  
>  static struct pci_raw_ops * __devinit pci_find_bios(void)
>  {
> -	union bios32 *check;
> +	union bios32 *check, sig;

This "sig" definition has no references, and is shadowed by the definition below.

> @@ -314,6 +315,10 @@ static struct pci_raw_ops * __devinit pc
>  	for (check = (union bios32 *) __va(0xe0000);
>  	     check <= (union bios32 *) __va(0xffff0);
>  	     ++check) {
> +		long sig;
> +		if (__get_user(sig, &check->fields.signature))

But, no complaint from gcc.  Trying to elicit a complaint by configuring
CC_OPTIMIZE_FOR_SIZE='n' breaks the build with:

  include/asm/desc.h: In function 'set_ldt':
  include/asm/desc.h:92: error: implicit declaration of function 'write_gdt_entry'

See reply to "[PATCH 3/4]" for a fix.

DM
