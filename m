From: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/5] KVM: Implement CR read caching for KVM
	paravirt_ops
Date: Mon, 18 Jun 2007 11:11:33 +0300
Message-ID: <46763E35.8020108@qumranet.com>
References: <4675F462.1010708@codemonkey.ws> <4675F4F1.5090207@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4675F4F1.5090207-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
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
> +/*
> + * Control register reads can be trapped.  Since trapping is relatively
> + * expensive, we can avoid paying the cost by caching logically.
> + */
> +static unsigned long kvm_read_cr(int reg)
> +{
> +	struct kvm_paravirt_state *state
> +		= per_cpu(paravirt_state, smp_processor_id());
> +
> +	if (unlikely(!state->cr_valid[reg])) {
> +		if (reg == 0)
> +			state->cached_cr[reg] = native_read_cr0();
> +		else if (reg == 3)
> +			state->cached_cr[reg] = native_read_cr3();
> +		else if (reg == 4)
> +			state->cached_cr[reg] = native_read_cr4();
> +		else
> +			BUG();
> +		state->cr_valid[reg] = 1;
> +	}
> +	return state->cached_cr[reg];
> +}
> +

It would be good to declare this (and kvm_write_cr) always_inline.  
These functions are never called with a non-constant reg parameters, and 
the unsightly if tree (more readable as a switch, IMO) will fold nicely 
when inlined.


-- 
error compiling committee.c: too many arguments to function


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
