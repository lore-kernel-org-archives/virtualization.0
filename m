Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9775C4338F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 03:12:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CFFA610F7
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 03:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4CFFA610F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F01F3401F8;
	Thu, 19 Aug 2021 03:12:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lqoLqASvBzU0; Thu, 19 Aug 2021 03:12:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4A493400B9;
	Thu, 19 Aug 2021 03:12:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DAC1C001A;
	Thu, 19 Aug 2021 03:12:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF88EC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D76C140752
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:12:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canb.auug.org.au
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U2v8flLZVdtO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:12:35 +0000 (UTC)
X-Greylist: delayed 00:05:40 by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6FEFD4074C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:12:35 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GqqRw47HGz9sVw;
 Thu, 19 Aug 2021 13:06:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
 s=201702; t=1629342413;
 bh=3CY+GC+/4FbWVWTR9SwmZRjFqyi6hW0w0sxX9wtxZ2g=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EcY9FQD9xHkLJzKWddIICTtnVSADJTSBGCHqSZG1/ciVaw3IESCfGLzJ3hWvsbn5t
 usgGuEZMt8bafYKikvU4NaBej4avIVUMza0iA1lwm5EunCUasopHdW4DK6iztlEhKF
 VhsRR3NIC5Gsfh0LhSoPyKBHAaLu35BUjFF7SkDYHa3PmHOrIAx8my7cBz3Z/REO7B
 xrSmWfsM9M/o2dI1mgcTJzMAPZtThEOYjZJCIrgg7UkvZW6KztZxLtBlK7etSgHb9+
 OghhDLR4sHpUSEzkilJUuYJyrsCbQsJqLvKr46vygycM5JgPcuvl3fiDOmbYsnH9Tt
 e782oNJ34kwEg==
Date: Thu, 19 Aug 2021 13:06:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH] i2c: virtio: Fix the compiler warning when CONFIG_ACPI
 is not set
Message-ID: <20210819130651.73945bcc@canb.auug.org.au>
In-Reply-To: <4309f869890e70810f2c40a8d60495240e318303.1629333590.git.jie.deng@intel.com>
References: <4309f869890e70810f2c40a8d60495240e318303.1629333590.git.jie.deng@intel.com>
MIME-Version: 1.0
Cc: viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org,
 linux-i2c@vger.kernel.org, conghui.chen@intel.com
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
Content-Type: multipart/mixed; boundary="===============8272095173847349350=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============8272095173847349350==
Content-Type: multipart/signed; boundary="Sig_/QJA95UnxUR0M=zAmKUp0atE";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/QJA95UnxUR0M=zAmKUp0atE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jie,

On Thu, 19 Aug 2021 08:48:41 +0800 Jie Deng <jie.deng@intel.com> wrote:
>
> Fix the compiler warning "drivers/i2c/busses/i2c-virtio.c:208:17:
> warning: unused variable 'pdev' [-Wunused-variable]" when CONFIG_ACPI
> is not set.
>=20
> Fixes: 8fb12751ac78 ("i2c: virtio: add a virtio i2c frontend driver")

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

> Signed-off-by: Jie Deng <jie.deng@intel.com>
> ---
>  drivers/i2c/busses/i2c-virtio.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-vir=
tio.c
> index d3e60d9..964c601 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -205,7 +205,6 @@ static const struct i2c_adapter_quirks virtio_i2c_qui=
rks =3D {
> =20
>  static int virtio_i2c_probe(struct virtio_device *vdev)
>  {
> -	struct device *pdev =3D vdev->dev.parent;
>  	struct virtio_i2c *vi;
>  	int ret;
> =20
> @@ -234,7 +233,7 @@ static int virtio_i2c_probe(struct virtio_device *vde=
v)
>  	 * Setup ACPI node for controlled devices which will be probed through
>  	 * ACPI.
>  	 */
> -	ACPI_COMPANION_SET(&vi->adap.dev, ACPI_COMPANION(pdev));
> +	ACPI_COMPANION_SET(&vi->adap.dev, ACPI_COMPANION(vdev->dev.parent));
> =20
>  	ret =3D i2c_add_adapter(&vi->adap);
>  	if (ret)

Looks good to me.

--=20
Cheers,
Stephen Rothwell

--Sig_/QJA95UnxUR0M=zAmKUp0atE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmEdyssACgkQAVBC80lX
0Gxw7Qf/fdlmIsM8h5nIZGD7ptVdJSD3poHXXbuM7T9D+8HSLed0ci4jpDOaO7rW
cC4bcMYOQQHYT3ZgalMDSQmf+nlwWbgFyQ8RPZ6RnssrwOG0CH8LKtU+HBYSBgZu
ETkW58Ny+0dUUXD88MPatdr/1+VnSVEGNnUrQSoegkOBrbU3GNhQ0AnCG8CLh/5D
5chhc6aU2GumqlcsWcl6jhyEVtlzZyqTBe9GaC1sbCamsqHluIc7XV38vz+q1Q4R
nIWedufbBlcPNJWsyDQlzay2A1YaT/7QX+aEOqo/mClRADMJw9kxE7xF1hMecH+f
FcWBGpkAwyhDkZu/xpleFsc1+Pwg+w==
=Sc41
-----END PGP SIGNATURE-----

--Sig_/QJA95UnxUR0M=zAmKUp0atE--

--===============8272095173847349350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8272095173847349350==--
