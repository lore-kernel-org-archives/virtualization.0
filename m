From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC] virtio: support VIRTIO_F_IO_BARRIER
Date: Thu, 3 May 2018 10:06:52 +0100
Message-ID: <20180503090652.GB5301__25519.5499318235$1525350741$gmane$org@stefanha-x1.localdomain>
References: <20180503025955.28816-1-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8833794240571668891=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180503025955.28816-1-tiwei.bie@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, zhihong.wang@intel.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


--===============8833794240571668891==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 10:59:55AM +0800, Tiwei Bie wrote:
> This patch introduces the support for VIRTIO_F_IO_BARRIER.
> When this feature is negotiated, driver will use the barriers
> suitable for hardware devices.
>=20
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>

I should have thought of this earlier, but why is a new feature bit
necessary?  If a hardware virtio device is in use, then the device
should already negotiate VIRTIO_F_IOMMU_PLATFORM (i.e. use DMA APIs and
IOMMU callbacks).

Does disabling weak_barriers when VIRTIO_F_IOMMU_PLATFORM is set solve
the problem?

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa6tEsAAoJEJykq7OBq3PId/QIALdwBH9xWwEQVvM6d304pF6L
xzcV8Swsp88sZDWASg+U4bAHqwEu7GHZV8uL5D7cL0wj/GzosiL8UXg5gRMbCewJ
+WqmRO650s3yMrYWkSODwIVA1ecJ4z7ij43NCVFDYn2INVec5PbVxW0lDgtCG0KD
+EU5IWUK4JMU25x4f+mQSYQkrsV89msupTw/qdxF634+qHitlj79JOL4ZmcvmOg6
DrSD11OXbpKDi8KEOJb+9KJ1ky69L9xUn29Me5YMK3mYbfte1kZYLSzE4JvQmKHS
Rf68rErinhJeAxDU4txxaIb2jOq3dUwqSQLuj5MjtNf4KhJbSB3A+BkZHSY4HM0=
=X31/
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--

--===============8833794240571668891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8833794240571668891==--
