From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1/1] XEN: enlighten,
	use uninitialized_var(cx)
Date: Tue, 25 Aug 2009 15:29:50 -0700
Message-ID: <4A9465DE.2030709@goop.org>
References: <1251234044-6943-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1251234044-6943-1-git-send-email-jirislaby@gmail.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jiri Slaby <jirislaby@gmail.com>
Cc: xen-devel@lists.xensource.com, jeremy@xensource.com, the arch/x86 maintainers <x86@kernel.org>, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, virtualization@lists.osdl.org, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 08/25/09 14:00, Jiri Slaby wrote:
> To avoid a wrong compiler warning, use unitialized_var(cx) in
> xen_init_cpuid_mask.
>
> cx needn't be initialized for cpuid when ax is 1.
>
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> Cc: Jeremy Fitzhardinge <jeremy@xensource.com>
> Cc: Chris Wright <chrisw@sous-sol.org>
>   
Acked-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

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
>  
>  	cpuid_leaf1_edx_mask =
>  		~((1 << X86_FEATURE_MCE)  |  /* disable MCE */
>   
