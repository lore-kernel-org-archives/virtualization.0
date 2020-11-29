Return-Path: <SRS0=PU37=FD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B04C3E8C5
	for <virtualization@archiver.kernel.org>; Sun, 29 Nov 2020 22:12:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7162078D
	for <virtualization@archiver.kernel.org>; Sun, 29 Nov 2020 22:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XDpBE+Nc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7162078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 23271872CD;
	Sun, 29 Nov 2020 22:12:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kmMdKi04Li0l; Sun, 29 Nov 2020 22:12:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5E4EB87283;
	Sun, 29 Nov 2020 22:12:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24C53C0859;
	Sun, 29 Nov 2020 22:12:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A095C0052
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 22:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 04E4785C62
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 22:12:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id olHN0ouKJfqu
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 22:12:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4CBD3854D0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 22:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1606687859;
 bh=iXkhSMriV5maLLXF4ec2emP2gdExku4QakTNWEWxKUk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=XDpBE+Ncm04FRwJ8vuODrGgKLku41S/SLjyJKexDsg8yKXkkz1nq4E0r8hWZmkYVa
 sBpJNwquAuFevwavdDte9KcxOQtU30m39ANkaqQ28WzThFVrCaEZIdi6bBGkog4oqh
 NxDUHpDDQvRiIFnkufGLiPnZYponASPII+rH28Ns=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNcA-1kARCk3xVg-00ZPKJ; Sun, 29
 Nov 2020 23:10:59 +0100
Date: Sun, 29 Nov 2020 23:10:50 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: Re: [PATCH] drivers: gpio: add virtio-gpio guest driver
Message-ID: <20201129221050.GH456020@latitude>
References: <20201127183003.2849-1-info@metux.net>
MIME-Version: 1.0
In-Reply-To: <20201127183003.2849-1-info@metux.net>
X-Provags-ID: V03:K1:3k7JLc2Hawk0Hil86ZD/XR/DnpRxdu29H+22sf1XPZsO3A3cFlf
 SxQ/j3JYOOj5W/6OrAzXx2V3O076zc9+NrzDyDM8AZ8wqGocU5aewHzEQInNuo92+4UlsDD
 B+dmWGwciIxLEEEY8/RzK2w4ZvuG/ZUrlNEM1WfjP/lYlfRxEUuSgC0+llkx1LTYcu8lE+t
 5QoHc123fP+9CRYN/+MfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PPw4bc4Tusg=:mupDuzXAshUvS65GdN+8BR
 /rLiFI9/5Z0tUqMq/dJViG9x/bF6MH+06xhtAoJa4XdVbdXG9tF0yqZT2SrwnWJdWJc0O2V1y
 /8orh1WzXNoHT4PDDB6CxJr5GN/b9oPnZxkL15TSkf5daQMQuWAhJxE+URDXtXg7nRXI6yg9Y
 OHO9ZYljwUriW6RjUL97GZi3dfGfFTZ8LLNNqfy4MZiCC6eed4zuXrSMRa0Wmu3lLZ9Qozhcr
 KlO/RYtp7kbxVsi2EBOxH0qDUytd1D4dbAILaedAkTzDzEz+IpJ7q50RPYzhJti03COA1W7Vz
 H+FtdxZMc7y6Zf6sGh1m614l3EMkplr9YWk4fPWjNM/SgO7x0BEWzdg1ShVOM1uw9dBeaXZor
 HAIhZ8O1zZ52a0Y9dsuZkDLUwc4ijHvM+zvdtNCyMcxz8MFHbMz2sDfNw6voWfYJYE3oskXS9
 j+jB22Xgo+tFP2Goi23ChJgRfVkrpjo6OruoCK9JVA11U9YvcWkYQ3r/t0Xaod5Jlt22SOkRS
 +GTlzhdh6mgjtkXssxIYHDfFcn0+nIcmfJRXr+8SYreTE5WlMpasDD2bwINEp2rjWpYwYAuKt
 vU15CgqAhGOUGIl3saac33BVUO6+cZG9QIAoA5FCKsbdrCrJn5ue/PrMh9fcCzhUsuyDS4agE
 5w27uuRB/sM6SaHV0nk0L0PlheUy+BU5IZuhmB4OlEhluox3EGWNXTxWkSreqkGidHG8uj0cT
 J6uRwXLBB6ahsp/+cWSb9xQ16VzOeBv/23hmvrlbFvMPiV8UgvnvwTS0DjEUcN8+/h+5tlcpy
 E60TDZ70kJKQCg/v1fJCS0aVHce6fgkz6h7atHTyw9of9lFauyayNnkf8vt28V8znk0nTVxJT
 SwhCuFdz7xvXV2yUt3fA==
Cc: bgolaszewski@baylibre.com, linus.walleij@linaro.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1515342841783196856=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============1515342841783196856==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rV8arf8D5Dod9UkK"
Content-Disposition: inline


--rV8arf8D5Dod9UkK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 27, 2020 at 07:30:03PM +0100, Enrico Weigelt, metux IT consult =
wrote:
> Introducing new gpio driver for virtual GPIO devices via virtio.
>=20
> The driver allows routing gpio control into VM guests, eg. brigding
> virtual gpios to specific host gpios, or attaching simulators for
> automatic application testing.
>=20
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

is there a spec of the virtio-gpio protocol available? If so, linking it
in the commit message and/or driver/Kconfig would be nice.


Best regards,
Jonathan Neusch=C3=A4fer

--rV8arf8D5Dod9UkK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl/EHGIACgkQCDBEmo7z
X9vgjQ/7BGdfYQq78KeC7gpheGKolr7itYaIjyPeiwVUbLBnd98RdTr2u5bLTMJL
bcE7IrgMjDos6NW2AvHqwS/n2McBo07w3mW2u0CcWPNn2T31cgjvMRPacVpm6SXk
jYQ2Y9Yu/12fBWd6Bqp/GZH7brS00onhkkdjwpLJ85Kmj4T3BtPDVdteSgNyNQ+9
q0T06QDzgstQCOUN8Rizjfmm/kP62VyV1H8fGeFIbqWyChIeNy3CpA1y1cNH2YOx
8Qfot8iwWzAWjSHsYVZk5Nkf+4kV4/qVRNbVPvAhPBfge7zGJfwEmAmReEND4N4d
6TOeEmEPDNLPHv3TynOtUWgGVB4RFblVh2PDqynP5cEvF+m7zhv2ZN14hJL8R146
mPCU2pfEldzCloaiYEquriAXG+fTc7872OI7eF3oSzF+UyEs0HuZpsYZS17TVbhi
cNT1JZ2unfZmcFOM5Xp1J+VrJ1zYGHp+9EPTX8Cp6DEDG+HL5zxv5Vaa7tjrmmIN
7krg65s3g61Jo839BQQlJtb8P5BLU+RLDQYpiBS3X2YR3iCqCH4r3UWQyiRl3tcn
Sa6qNES5SHMhTXWS8FFCelolQei7XVJ19aqN1mtz+zSS85I5U1kxbVOuMTFLgzu3
K34XZBYz5Gj7Glv1uIF48IifPI5UVo1wlUy3roHIGBh36W4+fv0=
=SCq+
-----END PGP SIGNATURE-----

--rV8arf8D5Dod9UkK--

--===============1515342841783196856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1515342841783196856==--
