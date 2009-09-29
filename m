From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Tue, 29 Sep 2009 10:27:50 -0700
Message-ID: <4AC24396.4080402@zytor.com>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com>	 <20090919224430.GB9567@kroah.com>	 <1253419185.3253.21.camel@ank32.eng.vmware.com>	 <20090920074247.GA5733@elte.hu>	 <1253647845.10565.20.camel@ank32.eng.vmware.com>	 <4AB9CE66.1030504@redhat.com>	 <1254185107.13456.32.camel@ank32.eng.vmware.com>	 <4AC17018.4040600@zytor.com>	 <1254193238.13456.48.camel@ank32.eng.vmware.com>	 <20090929090130.GD3958@sequoia.sous-sol.org> <1254245124.7803.34.camel@ank32.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753545AbZI2Rab@vger.kernel.org>
In-Reply-To: <1254245124.7803.34.camel@ank32.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akataria@vmware.com
Cc: Chris Wright <chrisw@sous-sol.org>, Gerd Hoffmann <kraxel@redhat.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 09/29/2009 10:25 AM, Alok Kataria wrote:
> diff --git a/arch/x86/kernel/vmi_32.c b/arch/x86/kernel/vmi_32.c
> index 31e6f6c..d430e4c 100644
> --- a/arch/x86/kernel/vmi_32.c
> +++ b/arch/x86/kernel/vmi_32.c
> @@ -648,7 +648,7 @@ static inline int __init activate_vmi(void)
>  
>  	pv_info.paravirt_enabled = 1;
>  	pv_info.kernel_rpl = kernel_cs & SEGMENT_RPL_MASK;
> -	pv_info.name = "vmi";
> +	pv_info.name = "vmi [deprecated]";
>  
>  	pv_init_ops.patch = vmi_patch;
>  
> 
> 

Where is this string used, and could this break something?

	-hpa
