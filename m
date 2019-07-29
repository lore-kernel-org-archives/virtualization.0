From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v4 0/5] vsock/virtio: optimizations to increase the
	throughput
Date: Mon, 29 Jul 2019 14:12:59 +0100
Message-ID: <20190729131259.GA6771__36169.8413662211$1564406091$gmane$org@stefanha-x1.localdomain>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190722090835.GF24934@stefanha-x1.localdomain>
	<20190722091434.tzf7lxw3tvrs5w5v@steredhat>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6154588238952013834=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190722091434.tzf7lxw3tvrs5w5v@steredhat>
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


--===============6154588238952013834==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 11:14:34AM +0200, Stefano Garzarella wrote:
> On Mon, Jul 22, 2019 at 10:08:35AM +0100, Stefan Hajnoczi wrote:
> > On Wed, Jul 17, 2019 at 01:30:25PM +0200, Stefano Garzarella wrote:
> > > This series tries to increase the throughput of virtio-vsock with sli=
ght
> > > changes.
> > > While I was testing the v2 of this series I discovered an huge use of=
 memory,
> > > so I added patch 1 to mitigate this issue. I put it in this series in=
 order
> > > to better track the performance trends.
> > >=20
> > > v4:
> > > - rebased all patches on current master (conflicts is Patch 4)
> > > - Patch 1: added Stefan's R-b
> > > - Patch 3: removed lock when buf_alloc is written [David];
> > >            moved this patch after "vsock/virtio: reduce credit update=
 messages"
> > >            to make it clearer
> > > - Patch 4: vhost_exceeds_weight() is recently introduced, so I've sol=
ved some
> > >            conflicts
> >=20
> > Stefano: Do you want to continue experimenting before we merge this
> > patch series?  The code looks functionally correct and the performance
> > increases, so I'm happy for it to be merged.
>=20
> I think we can merge this series.
>=20
> I'll continue to do other experiments (e.g. removing TX workers, allocati=
ng
> pages, etc.) but I think these changes are prerequisites for the other pa=
tches,
> so we can merge them.
>=20
> Thank you very much for the reviews!

All patches have been reviewed by here.  Have an Ack for good measure:

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

The topics discussed in sub-threads relate to longer-term optimization
work that doesn't block this series.  Please merge.

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0+8NsACgkQnKSrs4Gr
c8gLNgf/Y63sHjZ3yrw3pup1KDkZmcZX9U+gUxzFkEnpGo8Uz20pFa0UQ8EgfdIP
Ow+qZ9hm77WDbeAx8lyWTwAV1C2WS1k5RMpqWJzBdI45MixObQ2+2/ddp+igHDAJ
L7pDH+Wwc/7p0FcMuUqqQKl6MM2yJ9zHrRu/5xVtrWNuw4Hdt7BvWshvE0G496kv
0itr7U5WqDstqYPBWm1DbGBr6Nnwv7a3R/3lslRsTiN3em63/Gl+hVgb+jvk/wSl
W8BS+9/UJkaBG0vv+f89e7xqqvCP90S8CPGtk3LhUhufdf+5I/Hekm+eY7MDN+Au
xX2HJr/ZEPFdghVj8F+OODK+aDR6aw==
=tIn+
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--

--===============6154588238952013834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6154588238952013834==--
