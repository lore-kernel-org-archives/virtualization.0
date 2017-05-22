From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 2/2] vhost/scsi: Delete error messages for failed memory
	allocations in five functions
Date: Mon, 22 May 2017 12:23:20 +0100
Message-ID: <20170522112320.GA22806__37364.6891829141$1495452215$gmane$org@stefanha-x1.localdomain>
References: <bafa65e4-08fe-efdb-d836-7657e8a64749@users.sourceforge.net>
	<babc429d-6440-92aa-e1d0-eee2636a8d0f@users.sourceforge.net>
	<20170522094320.GE12205@stefanha-x1.localdomain>
	<557bdff4-6dc2-756d-0d59-9f688ef11f0a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5124469629172581799=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <557bdff4-6dc2-756d-0d59-9f688ef11f0a@users.sourceforge.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============5124469629172581799==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 12:50:39PM +0200, SF Markus Elfring wrote:
> > Why are you trying to get rid of memory allocation failure messages?
>=20
> Do you find information from a Linux allocation failure report sufficient
> for any function implementations here?

If kmalloc() and friends guarantee to print a warning and backtrace on
every allocation failure, then there's no need for error messages in
callers.

That seems like good justification that can go in the commit
description, but I'm not sure if kmalloc() and friends guarantee to show
a message (not just the first time, but for every failed allocation)?

> >> +++ b/drivers/vhost/scsi.c
> >> @@ -417,5 +417,4 @@ vhost_scsi_allocate_evt(struct vhost_scsi *vs,
> >>  	if (!evt) {
> >> -		vq_err(vq, "Failed to allocate vhost_scsi_evt\n");
> >=20
> > #define vq_err(vq, fmt, ...) do {                                  \
> >                 pr_debug(pr_fmt(fmt), ##__VA_ARGS__);       \
> >                 if ((vq)->error_ctx)                               \
> >                                 eventfd_signal((vq)->error_ctx, 1);\
> >         } while (0)
> >=20
> > You silently dropped the eventfd_signal() call.
>=20
> Do you prefer to preserve this special error handling then?

Yes, please leave vq_err() calls.

Stefan

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZIsooAAoJEJykq7OBq3PI48MH/2SBVJUIO7vINQTZv9NB3QY1
hVDMY0sUVSJ3paY40CVqN6yRyVUc3UjO1UnhDVY8rVbLQsmfkC3BQibiARHTDbdM
bczzrUq14IZ02R12gRrsfPUNOVmCZR7VdxkZ2U42h4TFqADx6UThHfMqv47aOZZU
IDoafGkNLKkVI3U31Yd99J7KwIWN1U7Tes1Tt6M29vBgm7YgdE/QaW0mpk+Df2+O
zZEONqjKC1DrI2etKnFUJ08w/eh0EtWEigPdrBK7G04b7atiVw6PK1fgKJ4mFn9u
5/5xn/N52JcXKiUOotffPgY9WXmseBkGkEogBCuhyaayVc66fAD5l1neFx4X4eE=
=0dh5
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--

--===============5124469629172581799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5124469629172581799==--
