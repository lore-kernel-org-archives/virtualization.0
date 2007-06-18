From: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Subject: Re: [PATCH 5/5] KVM: paravirt time source
Date: Mon, 18 Jun 2007 12:11:32 -0700
Message-ID: <4676D8E4.3020806@goop.org>
References: <4675F462.1010708@codemonkey.ws> <4675F601.3090706@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4675F601.3090706-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> +static cycle_t read_hyper(void)
> +{
> +	struct timespec now;
> +	int ret;
> +
> +	ret = kvm_hypercall(KVM_HYPERCALL_GET_KTIME, (u32)&now, 0, 0, 0);
> +	WARN_ON(ret);
> +
> +	return now.tv_nsec + now.tv_sec * (cycles_t)1e9;
>   

Hm, use of FP looks pretty odd.  I guess its OK to assume the compiler
will completely remove all the FP stuff at compile time.  Or you could
use NSEC_PER_SEC.

> +}
> +
> +static struct clocksource clocksource_hyper = {
> +	.name			= "hyper",
> +	.rating			= 200,
>   

We should probably standardize on this.  I guess that if you're in a
paravirt environment, and there's a paravirt clocksource, that would
always be the best clocksource to use.

> +	.read			= read_hyper,
> +	.mask			= CLOCKSOURCE_MASK(64),
> +	.mult			= 1,
> +	.shift			= 0,
>   

It would be better to use a scale and shift here, so that adjtime has
something to work with when warping time.

    J

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
