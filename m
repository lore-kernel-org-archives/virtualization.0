From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC 0/3] virtio: NUMA-aware memory allocation
Date: Tue, 30 Jun 2020 09:47:38 +0100
Message-ID: <20200630084738.GC81930@stefanha-x1.localdomain>
References: <20200625135752.227293-1-stefanha@redhat.com>
 <9cd725b5-4954-efd9-4d1b-3a448a436472@redhat.com>
 <20200629092646.GC31392@stefanha-x1.localdomain>
 <20200629112212-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6220193414567200161=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200629112212-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============6220193414567200161==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline

--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 11:28:41AM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 29, 2020 at 10:26:46AM +0100, Stefan Hajnoczi wrote:
> > On Sun, Jun 28, 2020 at 02:34:37PM +0800, Jason Wang wrote:
> > >=20
> > > On 2020/6/25 =E4=B8=8B=E5=8D=889:57, Stefan Hajnoczi wrote:
> > > > These patches are not ready to be merged because I was unable to me=
asure a
> > > > performance improvement. I'm publishing them so they are archived i=
n case
> > > > someone picks up this work again in the future.
> > > >=20
> > > > The goal of these patches is to allocate virtqueues and driver stat=
e from the
> > > > device's NUMA node for optimal memory access latency. Only guests w=
ith a vNUMA
> > > > topology and virtio devices spread across vNUMA nodes benefit from =
this.  In
> > > > other cases the memory placement is fine and we don't need to take =
NUMA into
> > > > account inside the guest.
> > > >=20
> > > > These patches could be extended to virtio_net.ko and other devices =
in the
> > > > future. I only tested virtio_blk.ko.
> > > >=20
> > > > The benchmark configuration was designed to trigger worst-case NUMA=
 placement:
> > > >   * Physical NVMe storage controller on host NUMA node 0
>=20
> It's possible that numa is not such a big deal for NVMe.
> And it's possible that bios misconfigures ACPI reporting NUMA placement
> incorrectly.
> I think that the best thing to try is to use a ramdisk
> on a specific numa node.

Using ramdisk is an interesting idea, thanks.

Stefan

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl76/CoACgkQnKSrs4Gr
c8hYXAf9F4LW8ilmyRTvhYffEkf/Y5C/wzheDL39Si1gk1+C0wfmY3ddEKKLk+fq
W90McRJ1hjeo8BAKagw8M298S6EN3dDOr29dyA3G3DtFFrMW+zgetEw8gAVHRRmm
SxDyIJE3g3VrpCCY2w7sZp/uyxod7ozRCXqy+HLq2zVu2LuJg5eitoP15VBQQOIR
tGNeIFgMRLAFG9ps4XYtgyRtqpgnu69sh29h+lIcFA6oSn1cHbn6cdcuqlJKrz1j
CsTdPuw/nL66XjFvBnj68Tlugj0VTyTcTw9HJAhyCF396jaVZ4/9HP6vGYV7y1xX
Nfp+b8mto6LeNbICxCU0x0wpk/y0EQ==
=eAaL
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--


--===============6220193414567200161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6220193414567200161==--
