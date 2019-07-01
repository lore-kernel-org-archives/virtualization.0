From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 0/3] vsock/virtio: several fixes in the .probe() and
	.remove()
Date: Mon, 1 Jul 2019 16:11:13 +0100
Message-ID: <20190701151113.GE11900@stefanha-x1.localdomain>
References: <20190628123659.139576-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4222670797951173493=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190628123659.139576-1-sgarzare@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============4222670797951173493==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Content-Disposition: inline


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2019 at 02:36:56PM +0200, Stefano Garzarella wrote:
> During the review of "[PATCH] vsock/virtio: Initialize core virtio vsock
> before registering the driver", Stefan pointed out some possible issues
> in the .probe() and .remove() callbacks of the virtio-vsock driver.
>=20
> This series tries to solve these issues:
> - Patch 1 adds RCU critical sections to avoid use-after-free of
>   'the_virtio_vsock' pointer.
> - Patch 2 stops workers before to call vdev->config->reset(vdev) to
>   be sure that no one is accessing the device.
> - Patch 3 moves the works flush at the end of the .remove() to avoid
>   use-after-free of 'vsock' object.
>=20
> v2:
> - Patch 1: use RCU to protect 'the_virtio_vsock' pointer
> - Patch 2: no changes
> - Patch 3: flush works only at the end of .remove()
> - Removed patch 4 because virtqueue_detach_unused_buf() returns all the b=
uffers
>   allocated.
>=20
> v1: https://patchwork.kernel.org/cover/10964733/

This looks good to me.

Did you run any stress tests?  For example an SMP guest constantly
connecting and sending packets together with a script that
hotplug/unplugs vhost-vsock-pci from the host side.

Stefan

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0aIpEACgkQnKSrs4Gr
c8g5Jgf9G47hJtpF3hJgsnc8qwgARpo4Lohr/kRFkPTC8LuzDXag2AES8zYJIA9E
R/ceQTEan3skEuPHBJEaRxTq0jpx9nKUL+LET20Z9HjmaCZFAMk/WnpYTAI/AZJj
89qIba5WlL9ba+ykkaW1rTBFKSRucoIdmN1sdE0cPR8S9zHSxLQN3C3WmFORXVMQ
nac3hTkbAr3g2twfAT3mcwKpmoODk2T1E0kyWHVXdTuTCr0KajxlZ/kWLRarbbYH
VucypkcnmbBnJ8rc6UXajx+C25ijyqJteBbBjMD8Z3RdeK43TIpNp7uFCyGDUipS
wwhzu5J3xB8hbhp3YtvK/+BTqfIAHg==
=Dzpp
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--

--===============4222670797951173493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4222670797951173493==--
