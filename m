From: David Vrabel <dvrabel@cantab.net>
Subject: Re: [Xen-devel] [PATCH linux-next] xen/multicall: xen_mc_callback():
	avoid buffer overflow
Date: Fri, 08 Feb 2013 21:13:53 +0000
Message-ID: <51156A91.5070801__35014.6783785478$1360626700$gmane$org@cantab.net>
References: <1360355677-52442-1-git-send-email-tim.gardner@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1360355677-52442-1-git-send-email-tim.gardner@canonical.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tim Gardner <tim.gardner@canonical.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On 08/02/2013 20:34, Tim Gardner wrote:
> This buffer overflow was introduced with 91e0c5f3dad47838cb2ecc1865ce789a0b7182b1
> (2.6.24).

There's no buffer overflow here. xen_mc_flush() resets b->cbidx.

David

>  arch/x86/xen/multicalls.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/xen/multicalls.c b/arch/x86/xen/multicalls.c
> index 0d82003..5270407 100644
> --- a/arch/x86/xen/multicalls.c
> +++ b/arch/x86/xen/multicalls.c
> @@ -195,9 +195,10 @@ void xen_mc_callback(void (*fn)(void *), void *data)
>  	struct mc_buffer *b = &__get_cpu_var(mc_buffer);
>  	struct callback *cb;
>  
> -	if (b->cbidx == MC_BATCH) {
> +	if (b->cbidx >= MC_BATCH) {
>  		trace_xen_mc_flush_reason(XEN_MC_FL_CALLBACK);
>  		xen_mc_flush();
> +		return;
>  	}
>  
>  	trace_xen_mc_callback(fn, data);
> 
