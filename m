Return-Path: <SRS0=YToA=IC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08F7C433E0
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 17:16:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330DB64F57
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 17:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330DB64F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DCF6D4327B;
	Thu,  4 Mar 2021 17:16:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uR57Nusjh2P8; Thu,  4 Mar 2021 17:16:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6FA4C4326E;
	Thu,  4 Mar 2021 17:16:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 536DEC000B;
	Thu,  4 Mar 2021 17:16:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49041C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 17:16:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 377D843282
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 17:16:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nlnK1JYIY_l0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 17:16:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2AB7F4326E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 17:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614878177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SY3y/fjQ9gcJBSAM3ZTh/kWFdCD5EKEzVNMAsrCAGpU=;
 b=hbl1h6YKessYnMibtP0E4P8FuM0vhtkwCryIuht5jbeBloy2BcfcSwwDtty1PLdVbIEpOh
 vBMdEhIElONlrnid2D76jWudQn3PDdyDnCNx6H+aYye6hGdUB7S3HAUSbB9wkn1L5sZSZS
 S437msiAPYwZ1CGUnW2skCZaUjXHPdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-h9RhXSbPOKGq3Iq6rZJaxg-1; Thu, 04 Mar 2021 12:16:13 -0500
X-MC-Unique: h9RhXSbPOKGq3Iq6rZJaxg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 361B592535;
 Thu,  4 Mar 2021 17:16:09 +0000 (UTC)
Received: from localhost (ovpn-114-199.ams2.redhat.com [10.36.114.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B78EF19645;
 Thu,  4 Mar 2021 17:15:55 +0000 (UTC)
Date: Thu, 4 Mar 2021 17:15:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Colin King <colin.king@canonical.com>
Subject: Re: [PATCH] scsi: target: vhost-scsi: remove redundant
 initialization of variable ret
Message-ID: <YEEVypxRJloK/CRk@stefanha-x1.localdomain>
References: <20210303134339.67339-1-colin.king@canonical.com>
MIME-Version: 1.0
In-Reply-To: <20210303134339.67339-1-colin.king@canonical.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Paolo Bonzini <pbonzini@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============4503942160195540894=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4503942160195540894==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O/Mw4/hwfMu4pg68"
Content-Disposition: inline


--O/Mw4/hwfMu4pg68
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 03, 2021 at 01:43:39PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The variable ret is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
>=20
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/vhost/scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Which kernel version is this patch based on?

If it's a fix for a patch that hasn't landed yet, please indicate this.
A "Fixes: ..." tag should be added to this patch as well.

I looked at linux.git/master commit f69d02e37a85645aa90d18cacfff36dba370f79=
7 and see this:

  static int __init vhost_scsi_init(void)
  {
          int ret =3D -ENOMEM;

          pr_debug("TCM_VHOST fabric module %s on %s/%s"
                  " on "UTS_RELEASE"\n", VHOST_SCSI_VERSION, utsname()->sys=
name,
                  utsname()->machine);

          /*
           * Use our own dedicated workqueue for submitting I/O into
           * target core to avoid contention within system_wq.
           */
          vhost_scsi_workqueue =3D alloc_workqueue("vhost_scsi", 0, 0);
          if (!vhost_scsi_workqueue)
                  goto out;

We need ret's initialization value here ^

          ret =3D vhost_scsi_register();
          if (ret < 0)
                  goto out_destroy_workqueue;

          ret =3D target_register_template(&vhost_scsi_ops);
          if (ret < 0)
                  goto out_vhost_scsi_deregister;

          return 0;

  out_vhost_scsi_deregister:
          vhost_scsi_deregister();
  out_destroy_workqueue:
          destroy_workqueue(vhost_scsi_workqueue);
  out:
          return ret;
  };


>=20
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index d16c04dcc144..9129ab8187fd 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -2465,7 +2465,7 @@ static const struct target_core_fabric_ops vhost_sc=
si_ops =3D {
> =20
>  static int __init vhost_scsi_init(void)
>  {
> -	int ret =3D -ENOMEM;
> +	int ret;
> =20
>  	pr_debug("TCM_VHOST fabric module %s on %s/%s"
>  		" on "UTS_RELEASE"\n", VHOST_SCSI_VERSION, utsname()->sysname,
> --=20
> 2.30.0
>=20

--O/Mw4/hwfMu4pg68
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBBFcoACgkQnKSrs4Gr
c8gNDQgAxM4D7kpB9RqQmwD/pZXfh57rpPDY0uHmPrBOq7MKsTXUfM1+n3cqcck5
qp5XiRpnP8mgoJ374YNyayk8ce7uB5z24/A56unCdzgC5cPPPmxvckd7RvG/3aTS
cKAUbh+I1wNWJCcbzJS/aGI/VOtMRHC3XoWGvXRA8N+FaeCRvyR+I7jyj+iTIeW+
hZNlQPI5da9WIcsUKyhq3963CdDjCuudTFIQNP8/EhsimQiWgt4DIqc+yJP+H2ny
Ai1LQxhQskm7QSAnVZz9QhfWdnF5HUK+46Dy0xeO3OzbgeHJBN2y32g1d+5kL1kj
hL+eyNKX93GZqvoeq8Lh7RVfhQkmFQ==
=yn4t
-----END PGP SIGNATURE-----

--O/Mw4/hwfMu4pg68--


--===============4503942160195540894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4503942160195540894==--

