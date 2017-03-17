From: James Hogan <james.hogan@imgtec.com>
Subject: [BUG] virtio-net linux driver fails to probe on MIPS Malta since
	'hw/virtio-pci: fix virtio behaviour'
Date: Fri, 17 Mar 2017 21:57:25 +0000
Message-ID: <20170317215725.GJ996@jhogan-linux.le.imgtec.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4761584495463777756=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============4761584495463777756==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b2kq0H0UHH9HR3v2"
Content-Disposition: inline

--b2kq0H0UHH9HR3v2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

I've bisected the following failure of the virtio_net linux v4.10 driver
to probe in QEMU v2.9.0-rc1 emulating a MIPS Malta machine:

virtio_net virtio0: virtio: device uses modern interface but does not have VIRTIO_F_VERSION_1
virtio_net: probe of virtio0 failed with error -22

To QEMU commit 9a4c0e220d8a ("hw/virtio-pci: fix virtio behaviour").

It appears that adding ",disable-modern=on,disable-legacy=off" to the
virtio-net -device makes it work again.

I presume this should really just work out of the box. Any ideas why it
isn't?

Cheers
James

--b2kq0H0UHH9HR3v2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYzFu+AAoJEGwLaZPeOHZ6IWIQAK3U2bObQkB4OIciXq5H0esi
bewn7ECE2gsVk0VLmbw612zQAwwjwj2frU43+nz2W3tQ8LDyDeCyfz1f4PqQawt6
e0WiqOcPwjF7N8nw790AsRc0xK/N2Kjkg+aoipq9hNTJxETaChTso5KeilWHKxM6
/RWXcyCy7sA2gYK2brnxmqMoJNY1+x4Fko3qMveSaWBm1t7Ia60c3p8AUuscU/H+
Av9WIzurEkaN6RMaas014osea290fC169JzUAUMwzlfibxy5FmA4J/8lSDMeB/F3
hp8XhV2OAgWqzSXSdB2n2SIwUJgBju6qTZQmjiWw+vOUIXGNO24OrsBm0pKiVHfX
VJzCyeaTg6I0Pjs0GD6WUJJFf8IEP+e4WHOlBsbPtkPBDt8CXoKnXxdnPiQVK/11
dom9ihXN4bGOlJBenrVhfydVe2kdIL0X9HPny9CXVdljjKm6JmzjAqXqou9NqK1J
XikEUZTgzGw8THkTzyktKYwctl1++7W9oJsVdRGNR+v+XVkEsKNx+dIPwToPRnTU
0PSF+TRAAOqDgVu9Jd8ZVBr/3N1bg/VataPWuKOeGuOIuaB+HRb9YxydjtBFqoeX
AquU+PHVBaB9Nt1OzhYkuTXfXIgD5URp8dWUiNPOTgXQhzpFLTbRWokazHWw1E/H
r8kZB0+T9RewbIOTvAOg
=bkeO
-----END PGP SIGNATURE-----

--b2kq0H0UHH9HR3v2--

--===============4761584495463777756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4761584495463777756==--
