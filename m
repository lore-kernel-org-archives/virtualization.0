From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [PATCH 3/10] I386 mcheck p4 grotesque and needless warning fix.patch
Date: Tue, 10 Apr 2007 10:06:09 -0400
Message-ID: <461B99D1.2010109@redhat.com>
References: <200704100006.l3A068Xk020608@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753811AbXDJOHH@vger.kernel.org>
In-Reply-To: <200704100006.l3A068Xk020608@zach-dev.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> No, just no.  You do not use goto to skip a code block.  You do not
> return an obvious variable from a singly-inlined function and give
> the function a return value.  You don't put unexplained comments
> about kmalloc in code which doesn't do dynamic allocation.  And
> you don't leave stray warnings around for no good reason.
> 
> Also, when possible, it is better to use block scoped variables
> because gcc can sometime generate better code.
> 
> Signed-off-by: Zachary Amsden <zach@vmware.com>
> 
> diff -r ed741f57dae8 arch/i386/kernel/cpu/mcheck/p4.c
> --- a/arch/i386/kernel/cpu/mcheck/p4.c	Fri Apr 06 14:29:52 2007 -0700
> +++ b/arch/i386/kernel/cpu/mcheck/p4.c	Fri Apr 06 14:43:24 2007 -0700
> @@ -124,12 +124,9 @@ static void intel_init_thermal(struct cp
>  
>  
>  /* P4/Xeon Extended MCE MSR retrieval, return 0 if unsupported */
> -static inline int intel_get_extended_msrs(struct intel_mce_extended_msrs *r)
> +static inline void intel_get_extended_msrs(struct intel_mce_extended_msrs *r)
>  {

The comment needs fixing.
