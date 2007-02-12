From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 5/7] cleanup: Rename cpu_gdt_descr and remove extern	declaration
 from smpboot.c
Date: Mon, 12 Feb 2007 01:16:44 -0800
Message-ID: <45D0307C.1040302@vmware.com>
References: <1171251120.10409.2.camel@localhost.localdomain>	 <1171251185.10409.4.camel@localhost.localdomain>	 <1171251258.10409.7.camel@localhost.localdomain>	 <1171251335.10409.10.camel@localhost.localdomain> <1171251406.10409.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964804AbXBLJQq@vger.kernel.org>
In-Reply-To: <1171251406.10409.13.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>, Paul Mackerras <paulus@samba.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> When I implemented the DECLARE_PER_CPU(var) macros, I was careful that
> people couldn't use "var" in a non-percpu context, by prepending
> percpu__.  I never considered that this would allow them to overload
> the same name for a per-cpu and a non-percpu variable.
>
> It is only one of many horrors in the i386 boot code, but let's rename
> the non-perpcu cpu_gdt_descr to early_gdt_descr (not boot_gdt_descr,
> that's something else...)
>   

Finally, someone not just noticed, but fixed it!  Thank you Rusty.  Was 
on my todo list, but never bubbled up.

Acked-by: Zachary Amsden <zach@vmware.com>
