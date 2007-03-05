From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch] paravirt: VDSO page is essential
Date: Mon, 05 Mar 2007 12:33:13 -0800
Message-ID: <45EC7E89.7040007@vmware.com>
References: <20070305120631.GA14105@elte.hu> <20070305143437.GF22829@bingen.suse.de> <45EC796D.5050705@vmware.com> <200703052116.42807.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932314AbXCEUdP@vger.kernel.org>
In-Reply-To: <200703052116.42807.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> The boot option is already there, but boot options for is not my
> idea of user friendly binary compatibility.
>   

Yes, not friendly.  Perhaps we can reverse the boot option?  I.e make 
vdso_enable=force re-activate the vdso even if it gets moved by a 
hypervisor and COMPAT_VDSO was compiled in.

But how many actual users are affected by these old glibc's that we need 
to care so much about them running new technology, especially if that 
technology can be built with the ability to warn them that they probably 
need to boot with vdso=disabled?


>> and a printk warning if you take #GPs and kill the init  
>> proc, because for us, this is not an expected support scenario.  We 
>> would much rather support the VDSO by default in paravirt kernels even 
>> with COMPAT_VDSO turned on.
>>     
>
> But you can't have it at the compatible fixed address, right?
>   

While technically possible, is is not possible to do that anytime soon, 
and the drawbacks might overshadow the performance gain of the VDSO - 
and I don't think any of the other hypervisors (lhype, Xen) will be able 
to do that either.  KVM can do it, only because it relies on hardware virt.

Zach
