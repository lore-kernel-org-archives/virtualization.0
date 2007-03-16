From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 21/26] Xen-paravirt_ops: Use the hvc console
	infrastructure for Xen console
Date: Fri, 16 Mar 2007 09:54:51 +0100
Message-ID: <20070316085451.GE23174@elte.hu>
References: <20070301232443.195603797@goop.org>
	<20070301232528.926984984@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20070301232528.926984984@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Implement a Xen back-end for hvc console.

> +	cons = intf->out_cons;
> +	prod = intf->out_prod;
> +	mb();
> +	BUG_ON((prod - cons) > sizeof(intf->out));
> +
> +	while ((sent < len) && ((prod - cons) < sizeof(intf->out)))
> +		intf->out[MASK_XENCONS_IDX(prod++, intf->out)] = data[sent++];
> +
> +	wmb();
> +	intf->out_prod = prod;

> +	prod = intf->in_prod;
> +	mb();
> +	BUG_ON((prod - cons) > sizeof(intf->in));

such mb()'s are typically a sign of "i have no clear idea what SMP 
serialization rules apply here, but something is needed because 
otherwise it breaks" ?

	Ingo
