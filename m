From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 00/18] virtiofs: Fix various races and
	cleanups round 1
Date: Mon, 9 Sep 2019 18:14:55 +0200
Message-ID: <20190909161455.GG20875__5362.28180151142$1568045721$gmane$org@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
	<CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
	<20190906103613.GH5900@stefanha-x1.localdomain>
	<CAJfpegudNVZitQ5L8gPvA45mRPFDk9fhyboceVW6xShpJ4mLww@mail.gmail.com>
	<866a1469-2c4b-59ce-cf3f-32f65e861b99@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1934599203622109080=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <866a1469-2c4b-59ce-cf3f-32f65e861b99@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: piaojun <piaojun@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============1934599203622109080==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 08, 2019 at 07:53:55PM +0800, piaojun wrote:
>=20
>=20
> On 2019/9/6 19:52, Miklos Szeredi wrote:
> > On Fri, Sep 6, 2019 at 12:36 PM Stefan Hajnoczi <stefanha@redhat.com> w=
rote:
> >>
> >> On Fri, Sep 06, 2019 at 10:15:14AM +0200, Miklos Szeredi wrote:
> >>> On Thu, Sep 5, 2019 at 9:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> Michael Tsirkin pointed out issues w.r.t various locking related TODO
> >>>> items and races w.r.t device removal.
> >>>>
> >>>> In this first round of cleanups, I have taken care of most pressing
> >>>> issues.
> >>>>
> >>>> These patches apply on top of following.
> >>>>
> >>>> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virt=
iofs-v4
> >>>>
> >>>> I have tested these patches with mount/umount and device removal usi=
ng
> >>>> qemu monitor. For example.
> >>>
> >>> Is device removal mandatory?  Can't this be made a non-removable
> >>> device?  Is there a good reason why removing the virtio-fs device
> >>> makes sense?
> >>
> >> Hot plugging and unplugging virtio PCI adapters is common.  I'd very
> >> much like removal to work from the beginning.
> >=20
> > Can you give an example use case?
>=20
> I think VirtFS migration need hot plugging, or it may cause QEMU crash
> or some problems.

Live migration is currently unsupported.  Hot unplugging the virtio-fs
device would allow the guest to live migrate successfully, so it's a
useful feature to work around the missing live migration support.

Is this what you mean?

Stefan

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl12en8ACgkQnKSrs4Gr
c8j5Gwf+PMUBgG0DDiGxgIJ9i33+mYbozJP8G8CAlJzhYOlYXTssDTBCI4KVr4+L
whMUfQBmjkS5vgoxrqktdwUX96bfRf1OgqwMe39jj82/GfFlyt3tF2kK/olvv7Ft
3IRp3H9IjDbPQecA9uTK8sMphB+wz9oEIFBbdQ3TjXaKxsoybJ8fpneKbTdcAv9B
0FVPgSuSCnTJfYZnMVaMO80HY9BDZet02NAKc1Pk1vcYoLrsjZkIjIHITI2FcKWs
gw2scF509EL/gGlYnAIzTeZpdkvn24ukIsBUGOwSBggPDMC7/EiK9YXOm0DFJCvn
m7UpoL8u4SB5YbzaQQBO1AAxjGbK4w==
=wp+o
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--

--===============1934599203622109080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1934599203622109080==--
