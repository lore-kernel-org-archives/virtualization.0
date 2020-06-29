From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC 0/3] virtio: NUMA-aware memory allocation
Date: Mon, 29 Jun 2020 10:26:46 +0100
Message-ID: <20200629092646.GC31392@stefanha-x1.localdomain>
References: <20200625135752.227293-1-stefanha@redhat.com>
 <9cd725b5-4954-efd9-4d1b-3a448a436472@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3542228649958609992=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <9cd725b5-4954-efd9-4d1b-3a448a436472@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============3542228649958609992==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 28, 2020 at 02:34:37PM +0800, Jason Wang wrote:
>=20
> On 2020/6/25 =E4=B8=8B=E5=8D=889:57, Stefan Hajnoczi wrote:
> > These patches are not ready to be merged because I was unable to measur=
e a
> > performance improvement. I'm publishing them so they are archived in ca=
se
> > someone picks up this work again in the future.
> >=20
> > The goal of these patches is to allocate virtqueues and driver state fr=
om the
> > device's NUMA node for optimal memory access latency. Only guests with =
a vNUMA
> > topology and virtio devices spread across vNUMA nodes benefit from this=
=2E  In
> > other cases the memory placement is fine and we don't need to take NUMA=
 into
> > account inside the guest.
> >=20
> > These patches could be extended to virtio_net.ko and other devices in t=
he
> > future. I only tested virtio_blk.ko.
> >=20
> > The benchmark configuration was designed to trigger worst-case NUMA pla=
cement:
> >   * Physical NVMe storage controller on host NUMA node 0
> >   * IOThread pinned to host NUMA node 0
> >   * virtio-blk-pci device in vNUMA node 1
> >   * vCPU 0 on host NUMA node 1 and vCPU 1 on host NUMA node 0
> >   * vCPU 0 in vNUMA node 0 and vCPU 1 in vNUMA node 1
> >=20
> > The intent is to have .probe() code run on vCPU 0 in vNUMA node 0 (host=
 NUMA
> > node 1) so that memory is in the wrong NUMA node for the virtio-blk-pci=
 devic=3D
> > e.
> > Applying these patches fixes memory placement so that virtqueues and dr=
iver
> > state is allocated in vNUMA node 1 where the virtio-blk-pci device is l=
ocated.
> >=20
> > The fio 4KB randread benchmark results do not show a significant improv=
ement:
> >=20
> > Name                  IOPS   Error
> > virtio-blk        42373.79 =3DC2=3DB1 0.54%
> > virtio-blk-numa   42517.07 =3DC2=3DB1 0.79%
>=20
>=20
> I remember I did something similar in vhost by using page_to_nid() for
> descriptor ring. And I get little improvement as shown here.
>=20
> Michael reminds that it was probably because all data were cached. So I
> doubt if the test lacks sufficient stress on the cache ...

Yes, that sounds likely. If there's no real-world performance
improvement then I'm happy to leave these patches unmerged.

Stefan

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl75s9YACgkQnKSrs4Gr
c8jAlQgAkxcrX8BwizJMukF4LIVrZHVVDcZjCvl+WEazZ8s6RpSCMj1yeg1wyplH
lt34UesBkGMWTyRQPfQTC16lAQy9hn1nPLhrqyFPk9oiQUEK9Kzf5j7I3JnLVNnI
jBGARfiyb0nKnhfqx0y/ixeAOLDNf9d2swoEc4lnqCo584dlMliJLIC/2jE7AvwF
M6xsrjW6JNxLuV4shp0CaWVgsPd/6OR8PMPy9XatWVPgyF9fpPn6pZJsb6B8d+gL
8lCvNa0+Deq/ruy67yyzenpuqvyMmA11HeQocFFqIvaEdCHA6QCGil0fmXVb0Ile
4X2GnES1wsHbGId3ofPrpM4rjxm7Rw==
=IwcF
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--

--===============3542228649958609992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3542228649958609992==--
