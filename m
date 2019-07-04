From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 1/3] vsock/virtio: use RCU to avoid use-after-free on
	the_virtio_vsock
Date: Thu, 4 Jul 2019 11:17:01 +0100
Message-ID: <20190704101701.GD1609__5923.67219958163$1562235450$gmane$org@stefanha-x1.localdomain>
References: <20190628123659.139576-1-sgarzare@redhat.com>
	<20190628123659.139576-2-sgarzare@redhat.com>
	<05311244-ed23-d061-a620-7b83d83c11f5@redhat.com>
	<20190703104135.wg34dobv64k7u4jo@steredhat>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3869138262992494930=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190703104135.wg34dobv64k7u4jo@steredhat>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============3869138262992494930==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Content-Disposition: inline


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2019 at 12:41:35PM +0200, Stefano Garzarella wrote:
> On Wed, Jul 03, 2019 at 05:53:58PM +0800, Jason Wang wrote:
> > On 2019/6/28 =E4=B8=8B=E5=8D=888:36, Stefano Garzarella wrote:
> > Another more interesting question, I believe we will do singleton for
> > virtio_vsock structure. Then what's the point of using vdev->priv to ac=
cess
> > the_virtio_vsock? It looks to me we can it brings extra troubles for do=
ing
> > synchronization.
>=20
> I thought about it when I tried to use RCU to stop the worker and I
> think make sense. Maybe can be another series after this will be merged.
>=20
> @Stefan, what do you think about that?

Yes, let's make it a singleton and keep no other references to it.

Stefan

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0d0h0ACgkQnKSrs4Gr
c8i7uAf/QXuDj1LvILBy4mvMHIq38SqbW5mFIsodkTbGDB7yc/P8sUakOgHd3iqg
B7T4t6bHfBmin86sSvgINZoQ2Ce0Cl5gfAUArX22oxCNNwo5U0rb6uLLj0aIi66M
JgXi44ww1uhDIqrgJAVltxIQCV6jjLNNR0Qz19oTEV1qNl4UkY4+iew3ebbt/sid
lBqxCSTTuA6dhA2R74j7mNtahfRXHiKqfz/fvnMIt6eayMHvx9cIpGJn+ZcJ5wNr
n55WOBLvBc+xom4siTtiE+R5ZOATuxyfbvCncpj5a6p3wfMDtYIWTh/UeAEyDesp
lL1CmfZat5mLZ1F0gxgjgE5alpkjuw==
=02pH
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--

--===============3869138262992494930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3869138262992494930==--
