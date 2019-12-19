From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 4/5] iommu: intel: Use generic_iommu_put_resv_regions()
Date: Thu, 19 Dec 2019 13:47:47 +0100
Message-ID: <20191219124747.GA1440537__2224.09100258432$1576759685$gmane$org@ulmo>
References: <20191218134205.1271740-1-thierry.reding@gmail.com>
 <20191218134205.1271740-5-thierry.reding@gmail.com>
 <2b3020a1-221c-f86b-6440-e9ef65f0c12e@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2227956216585943089=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2b3020a1-221c-f86b-6440-e9ef65f0c12e@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org


--===============2227956216585943089==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 09:53:22AM +0800, Lu Baolu wrote:
> Please tweak the title to
>=20
> "iommu/vt-d: Use generic_iommu_put_resv_regions()"
>=20
> then,
>=20
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> Best regards,
> baolu

Joerg, do you want me to resend with this change or is it more efficient
if you fix up the subject while applying?

Thierry

> On 12/18/19 9:42 PM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Use the new standard function instead of open-coding it.
> >=20
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >   drivers/iommu/intel-iommu.c | 11 +----------
> >   1 file changed, 1 insertion(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 42966611a192..a6d5b7cf9183 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -5744,15 +5744,6 @@ static void intel_iommu_get_resv_regions(struct =
device *device,
> >   	list_add_tail(&reg->list, head);
> >   }
> > -static void intel_iommu_put_resv_regions(struct device *dev,
> > -					 struct list_head *head)
> > -{
> > -	struct iommu_resv_region *entry, *next;
> > -
> > -	list_for_each_entry_safe(entry, next, head, list)
> > -		kfree(entry);
> > -}
> > -
> >   int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device=
 *dev)
> >   {
> >   	struct device_domain_info *info;
> > @@ -5987,7 +5978,7 @@ const struct iommu_ops intel_iommu_ops =3D {
> >   	.add_device		=3D intel_iommu_add_device,
> >   	.remove_device		=3D intel_iommu_remove_device,
> >   	.get_resv_regions	=3D intel_iommu_get_resv_regions,
> > -	.put_resv_regions	=3D intel_iommu_put_resv_regions,
> > +	.put_resv_regions	=3D generic_iommu_put_resv_regions,
> >   	.apply_resv_region	=3D intel_iommu_apply_resv_region,
> >   	.device_group		=3D pci_device_group,
> >   	.dev_has_feat		=3D intel_iommu_dev_has_feat,
> >=20

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl37cW8ACgkQ3SOs138+
s6HwMg//QTaq9qdL6boTSg1EAx8bgcGx/ElOv3yPZusDHrNbEG7C19YElgpyGquj
7x+Amfj9QD/8vIKJg+w2Z7VpKwUgrVyteYw+dOyFzSx5gjqLE7/r5klBFwR32/Uz
pGffIE2X3N6xtCfdzYrFt1ay9wM+cHJA0lvMy7oFX+XEOxc/eAorwm68g+UgkYAm
QigqZ/5cjjlkIkQL2FThNHnwpwd9zAhOMchjlyz+4UZv/4AvQqX0YSilx72T4JP0
3LOCto7pCGTmvv/4/E0bCOzIa+FOMZf56LLqOstqBhIoPeBWGuGNXUerZ5iV22E0
ah5RgWxHM0YwGufRGyHiJ8niUQlIuuIzFsJmjvXbDHdaIM7/tZMGRVRGNcZuINBb
5Addl123iKthkOTBBqNMoZwg9Y30E3mG07wZbH8tkZj91CRJPJ1Ui5uQsEtxlwvS
jwGcb9kVFk3PJO0AuKvDC9VTi40K1MDYW8NLAtTYV4UhLKA5XGuOWawKZWC20Q+X
88ie9W4l5+HhW9hgpSfawGdKAlOeeCzXTVmqzm8o5vaAIZ6qGnaf4peVVZ59YF70
HSty77b43BATtE0oL3ps6hzLgNMNQYSAd8hOnA1cqEwK4+wyCsRgfzx64jxyMOSB
vCaXjNxdpNsgZWqwqw5NVrsV2z3Jn/f11Wvsob4EMM5C3/ZDuVE=
=lKCJ
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

--===============2227956216585943089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2227956216585943089==--
