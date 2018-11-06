From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
Date: Tue, 6 Nov 2018 15:21:55 +0000
Message-ID: <20181106152155.GA31579__31550.1503217549$1541517598$gmane$org@stefanha-x1.localdomain>
References: <20181102182123.29420-1-v.mayatskih@gmail.com>
	<6a7f1668-bf2d-0caa-2efd-c8fab5f1db24@redhat.com>
	<c042686f-db95-514d-8bd8-92b72e4e087a@de.ibm.com>
	<CAGF4SLjC5Gs33k1XzK8vFF5FWE0pwHvB56iQ--DJ_4ADw5yuGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5532248005380586386=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAGF4SLjC5Gs33k1XzK8vFF5FWE0pwHvB56iQ--DJ_4ADw5yuGg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vitaly Mayatskih <v.mayatskih@gmail.com>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============5532248005380586386==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 11:15:04AM -0500, Vitaly Mayatskih wrote:
> On Mon, Nov 5, 2018 at 10:48 AM Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>=20
> > For the record, we still do use virtio-blk a lot. As we see new things =
like discard/write zero
> > support it seems that others do as well.
>=20
> Yes, trim/discard and writesame support is planned, at least for
> submit_bio path (not in this patch).

I agree, virtio_blk is quite popular and not deprecated/frozen.

Stefan

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb4bGTAAoJEJykq7OBq3PINHAH/RMVu0n4qzOEyEky9DGqqMzA
03ZEJGv9GOSA9R/BywE6uDHWcFvn80MOx52U91O9Cz1wDwZsjVwujBLW/BXOQKGR
ZansMQbTdlEYLGtrmNV5y/O/Von2/FZuhHhhbACgMKM3VifByI3yYQgfyoItql+X
hZDRlaNFr59u9Ib8lOswPoXvMF/HiM3QsRKvYdd0QTGtItUuBRMaYuZgG40dsgdh
o8+9bk/FkmhY8QT6qx26vPp0Qc02A+6Opvf/MYBRDqbaHPqmL+gmIEYG6BGfyxaV
NdYjXPzOCve0OcvHtd2fmboYrlGeoduN/q0guVZgp6XC0cEvcw+HhH7IP56zirA=
=fSFj
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--

--===============5532248005380586386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5532248005380586386==--
