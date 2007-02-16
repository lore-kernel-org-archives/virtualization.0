From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 18/21] Xen-paravirt: Add Xen grant table support
Date: Thu, 15 Feb 2007 22:52:29 -0800
Message-ID: <20070215225229.6b63d050.akpm@linux-foundation.org>
References: <20070216022449.739760547@goop.org>
	<20070216022531.904462260@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070216022531.904462260@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 15 Feb 2007 18:25:07 -0800 Jeremy Fitzhardinge <jeremy@goop.org> wr=
ote:

> +int gnttab_grant_foreign_access(domid_t domid, unsigned long frame,
> +				int readonly)
> +{
> +	int ref;
> +
> +	if (unlikely((ref =3D get_free_entry()) =3D=3D -1))
> +		return -ENOSPC;
> +
> +	shared[ref].frame =3D frame;
> +	shared[ref].domid =3D domid;
> +	wmb();
> +	shared[ref].flags =3D GTF_permit_access | (readonly ? GTF_readonly : 0);
> +
> +	return ref;
> +}
> +EXPORT_SYMBOL_GPL(gnttab_grant_foreign_access);

We have lots of open-coded mysteriously unexplained barriers in here.

I assume they're not smp_wmb() because this could be a !SMP guest talking
to an SMP host?
