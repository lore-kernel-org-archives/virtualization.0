From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Extending boot protocol & bzImage for paravirt_ops
Date: Fri, 01 Jun 2007 13:55:43 -0700
Message-ID: <466087CF.70708@goop.org>
References: <4656FB8F.4090604@goop.org> <m14pm0c0m2.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764855AbXFAU4F@vger.kernel.org>
In-Reply-To: <m14pm0c0m2.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, "H. Peter Anvin" <hpa@zytor.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> ....
> +Field name:	hardware_subarch
> +Type:		write
> +Offset/size:	0x23c/4
> +Protocol:	2.07+
> +
> +  In a paravirtualized environment the hardware low level architectural 
> +  pieces such as interrupt handling, page table handling, and
> +  accessing process control registers needs to be done differently.
> +
> +  This field allows the bootloader to inform the kernel we are in one
> +  one of those environments.
> +
> +  0x00000000	The default x86/PC environment
> +  0x00000001	lguest
> +  0x00000002	Xen
> +
> +Field name:	hardware_subarch_data
> +Type:		write
> +Offset/size:	0x23c/8
>   

offset = 240

> +Protocol:	2.07+
> +
> +  A pointer to data that is specific to hardware subarch
>   

Do we care particularly? If 8 bytes is enough for the subarch, do we
care whether its a pointer or literal? After all, this is just a private
channel between the bootloader and some subarch-specific piece of code
in the kernel.

J
