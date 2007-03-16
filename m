From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch 00/26] Xen-paravirt_ops: Xen guest implementation for
	paravirt_ops interface
Date: Fri, 16 Mar 2007 18:59:23 +0000
Message-ID: <20070316185923.GA15209@infradead.org>
References: <20070301232443.195603797@goop.org>
	<20070316092137.GL23174@elte.hu> <45FAD35F.8040404@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <45FAD35F.8040404@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 16, 2007 at 10:26:55AM -0700, Jeremy Fitzhardinge wrote:
> +#ifdef CONFIG_HIGHPTE
> +	.kmap_atomic_pte =3D native_kmap_atomic_pte,
> +#else
> +	.kmap_atomic_pte =3D paravirt_nop,
> +#endif

This is ifdefing is quite ugly.  Shouldn't native_kmap_atomic_pte
just be a noop in the !CONFIG_HIGHPTE case?

> -void *kmap_atomic(struct page *page, enum km_type type)
> +void *_kmap_atomic(struct page *page, enum km_type type, pgprot_t prot)

We normally call our "secial" function __foo, not _foo.  But in this
case it really should have a more meaningfull name like
kmap_atomic_prot anyway.

> +void *kmap_atomic(struct page *page, enum km_type type)
> +{
> +	return _kmap_atomic(page, type, kmap_prot);

And this one should probably be an inline.

> +static inline void *native_kmap_atomic_pte(struct page *page, enum km_ty=
pe type)
> +{
> +	return kmap_atomic(page, type);
> +}
> +
> +#ifndef CONFIG_PARAVIRT
> +#define kmap_atomic_pte(page, type)	kmap_atomic(page, type)
> +#endif

This is all getting rather ugly just for your pagetable hackery.
