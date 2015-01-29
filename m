From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH RFC v6 05/20] virtio: support more feature
	bits
Date: Thu, 29 Jan 2015 21:01:45 +1100
Message-ID: <20150129100145.GB10150@voom.fritz.box>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-6-git-send-email-cornelia.huck@de.ibm.com>
	<20150122014343.GG27371@voom.fritz.box>
	<20150128165945.530d3a11.cornelia.huck@de.ibm.com>
	<20150129001132.GE14681@voom>
	<20150129102400.100982a3@oc7435384737.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7375497207604515552=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150129102400.100982a3@oc7435384737.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Huth <thuth@linux.vnet.ibm.com>
Cc: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


--===============7375497207604515552==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2015 at 10:24:00AM +0100, Thomas Huth wrote:
>=20
>  Hi,
>=20
> On Thu, 29 Jan 2015 11:11:32 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Jan 28, 2015 at 04:59:45PM +0100, Cornelia Huck wrote:
> > > On Thu, 22 Jan 2015 12:43:43 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > > On Thu, Dec 11, 2014 at 02:25:07PM +0100, Cornelia Huck wrote:
> > > > > With virtio-1, we support more than 32 feature bits. Let's extend=
 both
> > > > > host and guest features to 64, which should suffice for a while.
> > > > >=20
> > > > > vhost and migration have been ignored for now.
> > > >=20
> > > > [snip]
> > > >=20
> > > > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virti=
o.h
> > > > > index f6c0379..08141c7 100644
> > > > > --- a/include/hw/virtio/virtio.h
> > > > > +++ b/include/hw/virtio/virtio.h
> > > > > @@ -55,6 +55,12 @@
> > > > >  /* A guest should never accept this.  It implies negotiation is =
broken. */
> > > > >  #define VIRTIO_F_BAD_FEATURE		30
> > > > > =20
> > > > > +/* v1.0 compliant. */
> > > > > +#define VIRTIO_F_VERSION_1              32
> > > >=20
> > > > This is already in the kernel header, isn't it?
> >=20
> > >=20
> > > Yes. But nearly all files include this header but not the kernel
> > > header.
> >=20
> > Can't you change that?  Or this file include the kernel header?
> =20
> AFAIK non-KVM code should never try to include one of the Linux headers
> to avoid breaking on non-Linux platforms (for example <linux/types.h> is
> not available on OS X, see http://patchwork.ozlabs.org/patch/424655/ ).
> So it's a little bit ugly to define these things twice, but it seems
> the only way to stay portable.

Ah, yeah, good point.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUygUJAAoJEGw4ysog2bOSkOwP/2buJNRbvSEjmnonjzdWh1nQ
V1cXzazcsZFChjkMBi37atx3yYY3u+nYB8FQuHqZIDysiAC/RKT9+jiuZEiguJhA
bHsjVxovyFPznK9LaUr4/wXveiQaTkBHth4i65J0xpehAHSY0tYPwDPfCN7GlVid
Nc1jgEChJ5PdrpKhwnrOxk6WekyOc604vd+nhkWCsy92XzrUyeBYKxEsKmy329Ex
ttS6uhOZqZ28xoI8YJqDEen042bzp7x52tIJhRjzovv2xRm/2vGJm6u3//G2ITZE
KhBhnoxNToEh1HPcMr5if7KfBrhqzwtaAZIBSQ+SRtqyBnhe9mOT97gpveiWhXkf
/TAq9I/WCzfbiKKSrVL5UPvgruKS/COVNfLPnL9QcvpJATcUswRKXSrtMe/Ny/pp
3Pdc26ISSxvgjCUh6bADuuJIFERiZPn83OCw4OD2/9vMHojFN9Tp8RkQ4aeCTTuV
n3d49EGNRJu7iLwiz+SQg5uncjCuXdj1XIZ2I1OMNPSg6K6gn8nbAjpbSZ5L4LCm
51/t0QqDd72HDBF3QdmIVbbEIOLlvfNCZNKL3QgClInMB3ul8TfLR7D/usydFRMS
LUTg2PvdW3iydWDWlvNZn9Pp4jeYP5SMsfZq4Ld9x3iiySoujiGDqEyAYQooDpki
8+eeoiul6nh40TYxIO71
=toJ9
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--

--===============7375497207604515552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7375497207604515552==--
