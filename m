From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/5] iommu: Implement iommu_put_resv_regions_simple()
Date: Wed, 16 Oct 2019 14:46:40 +0200
Message-ID: <20191016124640.GA1772382__25745.5998960481$1571230018$gmane$org@ulmo>
References: <20190829111752.17513-1-thierry.reding@gmail.com>
	<20190829111752.17513-2-thierry.reding@gmail.com>
	<20190918153737.dea2z5dddhuus25g@willie-the-truck>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2040086399292798659=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190918153737.dea2z5dddhuus25g@willie-the-truck>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org


--===============2040086399292798659==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 04:37:38PM +0100, Will Deacon wrote:
> On Thu, Aug 29, 2019 at 01:17:48PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Implement a generic function for removing reserved regions. This can be
> > used by drivers that don't do anything fancy with these regions other
> > than allocating memory for them.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/iommu/iommu.c | 19 +++++++++++++++++++
> >  include/linux/iommu.h |  2 ++
> >  2 files changed, 21 insertions(+)
> >=20
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 0f585b614657..73a2a6b13507 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -2170,6 +2170,25 @@ void iommu_put_resv_regions(struct device *dev, =
struct list_head *list)
> >  		ops->put_resv_regions(dev, list);
> >  }
> > =20
> > +/**
> > + * iommu_put_resv_regions_simple - Reserved region driver helper
> > + * @dev: device for which to free reserved regions
> > + * @list: reserved region list for device
> > + *
> > + * IOMMU drivers can use this to implement their .put_resv_regions() c=
allback
> > + * for simple reservations. Memory allocated for each reserved region =
will be
> > + * freed. If an IOMMU driver allocates additional resources per region=
, it is
> > + * going to have to implement a custom callback.
> > + */
> > +void iommu_put_resv_regions_simple(struct device *dev, struct list_hea=
d *list)
> > +{
> > +	struct iommu_resv_region *entry, *next;
> > +
> > +	list_for_each_entry_safe(entry, next, list, list)
> > +		kfree(entry);
> > +}
> > +EXPORT_SYMBOL(iommu_put_resv_regions_simple);
>=20
> Can you call this directly from iommu_put_resv_regions() if the function
> pointer in ops is NULL? That would save having to plumb the default callb=
ack
> into a bunch of drivers.

I probably could, but I don't think that necessarily improves things.
The reason is that that would cause the helper to get called even if the
driver doesn't support reserved regions. That's likely harmless because
in that case the list of regions passed to it would be empty. However, I
think the current way to do this, where we have to implement both hooks
for ->get_resv_regions() and ->put_resv_regions() is nicely symmetric.

Thierry

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2nES4ACgkQ3SOs138+
s6EONg//ZrYWm5ShwdyQ9XivGxuuU1NxmrAJMtWHz2z0xMVhLv8vVlvNeGNNepm/
AYozw/NMlEZokXfJVW9zNHDpOdr+MB6EchafhOZo9kK592CE18NhVrpVDptMvf29
K1QsQvgCq5Lu9EHBeDMxpx6Kn9VNBFJuAeYCIVzD5GOm80sHdAp1eKMwu/od+oTQ
IwZLB0K82tKdvnwYDYjN/JUW0dbrthH+fW843oOxAqQgrJYApL64k6WuPn6evN11
V7xbw3/Yk3LMqxmBzve7b7ATYXdGRuN7TdMX7aZmLX8xyu11L6LbK+Lss10BbBKi
Vja3MbZgoD54Eam3zOvj+b7tfdiRry4jhqqVksJ/Q2U7KOygrzLORgYR6wTgtz9g
opzD+i9cGdaSj1k8kvVeFPqX9TL/er2hy05MIEWYYTuVh3Y6xiPekH988bHvxf9X
bcl8I5YARin8U2n5R9kaS+drtuo3HvgeQMfszEf9UDNLQc+Pl5niTQPJzljWiZ36
zI8Tq7Sq8Fph33gOGbpcZMTDux4cjlYtGWle7U5tkS38Xte7+IgRxmpwWDC6Y0jX
muP1UNGkXJMLvJtssGseFZZw9qkJcq0NPRdjaN4k+LTdbrw0B10f1CDST8g/9Z4H
xvmbe6SyeWzgcBc43Fs4V3YjZXAYWxf66eD2B9h9AdAEHSmCgD4=
=LljU
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--

--===============2040086399292798659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2040086399292798659==--
