From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH RFC v6 05/20] virtio: support more feature
	bits
Date: Thu, 29 Jan 2015 11:11:32 +1100
Message-ID: <20150129001132.GE14681@voom>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-6-git-send-email-cornelia.huck@de.ibm.com>
	<20150122014343.GG27371@voom.fritz.box>
	<20150128165945.530d3a11.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2405395024216291420=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150128165945.530d3a11.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


--===============2405395024216291420==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WK3l2KTTmXPVedZ6"
Content-Disposition: inline


--WK3l2KTTmXPVedZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2015 at 04:59:45PM +0100, Cornelia Huck wrote:
> On Thu, 22 Jan 2015 12:43:43 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Dec 11, 2014 at 02:25:07PM +0100, Cornelia Huck wrote:
> > > With virtio-1, we support more than 32 feature bits. Let's extend both
> > > host and guest features to 64, which should suffice for a while.
> > >=20
> > > vhost and migration have been ignored for now.
> >=20
> > [snip]
> >=20
> > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > > index f6c0379..08141c7 100644
> > > --- a/include/hw/virtio/virtio.h
> > > +++ b/include/hw/virtio/virtio.h
> > > @@ -55,6 +55,12 @@
> > >  /* A guest should never accept this.  It implies negotiation is brok=
en. */
> > >  #define VIRTIO_F_BAD_FEATURE		30
> > > =20
> > > +/* v1.0 compliant. */
> > > +#define VIRTIO_F_VERSION_1              32
> >=20
> > This is already in the kernel header, isn't it?

>=20
> Yes. But nearly all files include this header but not the kernel
> header.

Can't you change that?  Or this file include the kernel header?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WK3l2KTTmXPVedZ6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUyXqzAAoJEGw4ysog2bOSsEUP/2kd6s65aXi+wPnDL/MSzHyQ
sftJS7xBWV+nz0ipXs2zeJNBxvDJyrWfsO/ecBtF8EBTovv3IVvIjzUH4iBsBpE8
a+FKrcvhcPIPWIRRMjrfr43PGDHTSZOWBL5VzNtDmnmMyoVyFmSPr0/DgSOfhiT+
NAwMCfo69w7iXTRIX0rJdFGjb+moTJf9yOTYlRQe4uD1lWHEG/hnEQ2ACBbk/HUR
tT9iITA3xhkJmSrrz94VUmf35HD95BRYHPuRe4Mn+6+5QjSTmIyuPlSK1sYOOFS9
aO25YW/bJhi3lpNt1mq5QzHDeTNcDITqHiWKJ9B7s2YyksEAeBlFUEXvrHoy5+9h
3CwkCi8WDp9O8MJ6fC6yjKmRPqJtTvO2J0h9cWX+Dc+ztqlJvId6qjjMs1EkJFI3
70kG5OeD5kF7V4ofDAyEKRVzDOFFd6F/LUbXQQc+gGkbJ6mluBZfs9WNCUe5umnY
t6GWz/4iCw+tVIBhZb2zhzWQz4PK6/wyT4LjKfoR9hPgcw3lgPX9sN3HUS1N9d2q
hdi7/ziU14NfStHiYaYmpKWb6RFiNtnze9xdHJ9V73N//XnXYAZnz5BQRqdRuDS8
ua7Hm9F38bihrSPwG0eUkJhVlWnt4rghh6XNxLFbjQC2hYB1dFV/yrQPsASBcSIg
WmvrtKCscWUIUdPJaXtc
=JSlG
-----END PGP SIGNATURE-----

--WK3l2KTTmXPVedZ6--

--===============2405395024216291420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2405395024216291420==--
