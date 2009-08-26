From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/1] XEN: enlighten, use uninitialized_var(cx)
Date: Wed, 26 Aug 2009 08:09:25 +0200
Message-ID: <20090826060925.GA6194@elte.hu>
References: <1251234044-6943-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756789AbZHZGJi@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1251234044-6943-1-git-send-email-jirislaby@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: jeremy@xensource.com, chrisw@sous-sol.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


* Jiri Slaby <jirislaby@gmail.com> wrote:

> To avoid a wrong compiler warning, use unitialized_var(cx) in
> xen_init_cpuid_mask.
> 
> cx needn't be initialized for cpuid when ax is 1.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> Cc: Jeremy Fitzhardinge <jeremy@xensource.com>
> Cc: Chris Wright <chrisw@sous-sol.org>
> ---
>  arch/x86/xen/enlighten.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> index e90540a..5ab75e2 100644
> --- a/arch/x86/xen/enlighten.c
> +++ b/arch/x86/xen/enlighten.c
> @@ -202,7 +202,7 @@ static void xen_cpuid(unsigned int *ax, unsigned int *bx,
>  
>  static __init void xen_init_cpuid_mask(void)
>  {
> -	unsigned int ax, bx, cx, dx;
> +	unsigned int ax, bx, uninitialized_var(cx), dx;

Please dont use uninitialized_var(), it's an unreliable facility: if 
this variable ever grows a real used-without-initialization bug in 
the future, the compiler warning is turned off permanently. It's 
rare but might happen. We are better off with initializing it to 
zero.

	Ingo
