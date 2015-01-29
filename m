From: Thomas Huth <thuth@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v6 05/20] virtio: support more feature
	bits
Date: Thu, 29 Jan 2015 10:24:00 +0100
Message-ID: <20150129102400.100982a3@oc7435384737.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-6-git-send-email-cornelia.huck@de.ibm.com>
	<20150122014343.GG27371@voom.fritz.box>
	<20150128165945.530d3a11.cornelia.huck@de.ibm.com>
	<20150129001132.GE14681@voom>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6877558733020892363=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150129001132.GE14681@voom>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

--===============6877558733020892363==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/cFF8NFyjmZxhWiLbG+gOz6b"; protocol="application/pgp-signature"

--Sig_/cFF8NFyjmZxhWiLbG+gOz6b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


 Hi,

On Thu, 29 Jan 2015 11:11:32 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jan 28, 2015 at 04:59:45PM +0100, Cornelia Huck wrote:
> > On Thu, 22 Jan 2015 12:43:43 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Thu, Dec 11, 2014 at 02:25:07PM +0100, Cornelia Huck wrote:
> > > > With virtio-1, we support more than 32 feature bits. Let's extend b=
oth
> > > > host and guest features to 64, which should suffice for a while.
> > > >=20
> > > > vhost and migration have been ignored for now.
> > >=20
> > > [snip]
> > >=20
> > > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > > > index f6c0379..08141c7 100644
> > > > --- a/include/hw/virtio/virtio.h
> > > > +++ b/include/hw/virtio/virtio.h
> > > > @@ -55,6 +55,12 @@
> > > >  /* A guest should never accept this.  It implies negotiation is br=
oken. */
> > > >  #define VIRTIO_F_BAD_FEATURE		30
> > > > =20
> > > > +/* v1.0 compliant. */
> > > > +#define VIRTIO_F_VERSION_1              32
> > >=20
> > > This is already in the kernel header, isn't it?
>=20
> >=20
> > Yes. But nearly all files include this header but not the kernel
> > header.
>=20
> Can't you change that?  Or this file include the kernel header?
=20
AFAIK non-KVM code should never try to include one of the Linux headers
to avoid breaking on non-Linux platforms (for example <linux/types.h> is
not available on OS X, see http://patchwork.ozlabs.org/patch/424655/ ).
So it's a little bit ugly to define these things twice, but it seems
the only way to stay portable.

 Thomas

--Sig_/cFF8NFyjmZxhWiLbG+gOz6b
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAEBAgAGBQJUyfw2AAoJEC7Z13T+cC21ze8P/AjAUnN5CMkloJ/mKckCwc9y
Tj0KiFOF3yjC52PVIkzOzljfy0404MUjIleK7w4D29ZWg1czRHCY29NXKuuDC4HT
6fM1LEMOFaKFhdqlh+4hUHbpDBMSG8mWSLfvqmB0uoAOwK3xc1PfZxxjvpizto+V
n9nyDX9+AqKweDVG81A0CdMoJ4NkU8+53JCUeF5nhHoCd6gX3+bKn00nGfdcxxE9
6zbmp5/v44WtPw4tYV6T8jC7g8NcfLFKHGYVcguYr5BxsauqpqmSe3+WeJhHjGTh
P1cain8z/nNOaRH5g5apb+kIhXrn+Usg+tlDHc24D/B26BERABCSL7MjEEy0R8ku
v2af9tfGdq+eyqbKBFrYrQKRoKp1rtavnHeA9vRRuRsM97gfHcpKO5Y7/BmVIu0i
ldBiY5ZNMA/iJIEhkxJJVy5YmmACmL4B+LM83Ibl4zPP34Zmxu8xAvAckyA+kheG
UynTsjjd+7E80gAjHrQKvu2UGQxVAYUsUC2jNqc704K3NfHdyDmKlQfEzWBGh2ol
UJvX03dfsy4SbuViargxOAsK2hMprCMfbNcM1bf34g5xOF1AjxgUBbFjcegtCVXm
FzKjvmX+bYWdaxxhxm/T1ouAjuJHX5ssWvCe0i52BA4/AQB2AvyQTKUukFExziws
PVGVa5ZGGOTTpBvAX9yw
=iqI6
-----END PGP SIGNATURE-----

--Sig_/cFF8NFyjmZxhWiLbG+gOz6b--


--===============6877558733020892363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6877558733020892363==--
