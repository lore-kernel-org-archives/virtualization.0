From: Pekka Paalanen <ppaalanen@gmail.com>
Subject: Re: [PATCH] Add virtio gpu driver.
Date: Tue, 31 May 2016 10:00:41 +0300
Message-ID: <20160531100041.22293fb1__17572.6125053645$1464705620$gmane$org@eldfell>
References: <1427213239-8775-1-git-send-email-kraxel@redhat.com>
	<20150324165057.GN1349@phenom.ffwll.local>
	<1427718227.3372.33.camel@nilsson.home.kraxel.org>
	<20150330144927.GN23521@phenom.ffwll.local>
	<CAKMK7uFUNT193f5djZD6T8cgRxxnZL73yrqbupPHOd2P-+Y=pQ@mail.gmail.com>
	<1464335302.10663.10.camel@redhat.com>
	<20160527090313.GX27098@phenom.ffwll.local>
	<1464616236.5179.41.camel@redhat.com>
	<20160530144755.GK27098@phenom.ffwll.local>
	<1464676160.5978.24.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6982827988525732388=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1464676160.5978.24.camel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, "open list:ABI/API" <linux-api@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============6982827988525732388==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1qnxE2_Z05zj9Luy7uAtylT"; protocol="application/pgp-signature"

--Sig_/1qnxE2_Z05zj9Luy7uAtylT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 31 May 2016 08:29:20 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>=20
> > > Why attach the hotspot to the plane?  Wouldn't it make more sense to
> > > make it a framebuffer property? =20
> >=20
> > We don't have properties on the framebuffer. I guess you /could/ just a=
dd
> > it internally to struct drm_framebuffer, and not bother exposing to
> > userspace. I guess that would be a lot simpler, =20
>=20
> Yes.  I can simply stick the hotspot into drm_framebuffer in
> drm_mode_cursor_universal() and pick up the values in the driver's plane
> update function.
>=20
> >  but it also means that
> > atomic userspace can't use hotspots before we add properties to fbs. And
> > doing that is a bit tricky since drm_framebuffer objects are meant to be
> > invariant - this assumption is deeply in-grained into the code all over
> > the place, everything just compares pointers when semantically it means=
 to
> > compare the entire fb (including backing storage pointer/offsets and
> > everything). =20
>=20
> Hmm, the hotspot location for a given cursor image is invariant too, so
> I don't think that would be a big issue.
>=20
> I'd expect userspace define a bunch of cursors, then switch between them
> (instead of defining a single cursor, then constantly updating it).

Except updating a single cursor (well, two alternating buffers) is
exactly what Weston does, since there is no "set of cursors". On
Wayland, a cursor is just a regular surface like any other with
arbitrary content from a client, except it happens to be associated
with a pointer device.

Furthermore, in Weston a cursor plane is not special in any way. *Any*
client surface can go on the cursor plane if it fits. Universal planes,
and all that.

That's one existing userspace. I suppose that is sub-optimal for
virtual drivers, isn't it? But what else could Weston do without having
separate paths for "normal DRM" vs. "virtual DRM"?


Thanks,
pq

--Sig_/1qnxE2_Z05zj9Luy7uAtylT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBV002nyNf5bQRqqqnAQj6uhAAgYUQP50d2eXolcxTR5FCGy/jbuVsHXnn
GBt4muGN8WWLePt5A8tWWjlGVDa7cHscyiL8xQVGGO9Tft+NkVZZInnQhz2cDwU0
esHHvyWdygZtZIwzcV07dPwg10tOzEd2/7jG18k7Zq47rSTO0xw9rVkH6d+l7knw
iQ0VW7oE1Of5B/BCWpaeXxcKcjzH80vsMlr9mG15ucdF/Ol1/lOIl8BQtHPYTdGY
1vJ1Bb7nwMJLobKM7yatcem5AdqVEF4h/0IORabc30wIjBKDXTnhY2ZZHIDqbgY2
d8bxNNG4Nws8ec3CMmf4yWt7fjV7c8ny/GzCtFuB3ckvXxT6OnzRXejEAPxg0MIa
ChWfhW6zYWfLC3LRSZjHbH+X56zgfDQzFmiGX8/J4qrPqtf8Oz+fhgWMBo8Ap6dC
NonDW47IHTzNz9GeJaMgWLJd9FzoMi391CtTai5IdrW+qbnmCYpddVEwW9OKNM/A
rNFGnSF46URAZv16fmx/FkhtJuVrfYKiYJKNticAcGLriCrM9L3QVk311xnmGthc
nv36y+HTejQ8V1HZaibAmE9rqcg5jyZmEvOf5anU1BPW9RMdArY2Flj3vBnqmM92
sBYm6j5yzLUxMwadEfuzx8ofGpSNZ76L7Y7GnzpQfasPhqbogL/DvU1IPDhr8m5q
3Bq33k8T1mM=
=P5YI
-----END PGP SIGNATURE-----

--Sig_/1qnxE2_Z05zj9Luy7uAtylT--

--===============6982827988525732388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6982827988525732388==--
