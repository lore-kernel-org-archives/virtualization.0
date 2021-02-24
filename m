Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC78C433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 11:53:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27A464D5D
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 11:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27A464D5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59F4860737;
	Wed, 24 Feb 2021 11:53:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dudi_7zHo7C4; Wed, 24 Feb 2021 11:53:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 145DB60652;
	Wed, 24 Feb 2021 11:53:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE89FC000B;
	Wed, 24 Feb 2021 11:53:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAAE8C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 11:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0F88606D0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 11:53:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5zOoC4zdLSGp
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 11:53:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BCC8360652
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 11:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614167631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rL0rqJykzi+068H31HVXzImuu55OZFksWorJVNSie2w=;
 b=AVFfWoIB1B0wob/EqO4FUTrrCsPT9d5RuCqmIva9C54I23kINCZpVWlAQo/vqklVHP3MnQ
 BnAZ3eK4hNpoz62TNme8iLb0kUe4m7y/ZM1/dInBsB3yT2OGSjOrZIZ8cOFn69bF3ZVMCh
 q8u9ypQQFIr++Ozu2DBDNH6Hx0u0Vmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-f_kFJMjjM8aoNLA5ErJwfQ-1; Wed, 24 Feb 2021 06:53:48 -0500
X-MC-Unique: f_kFJMjjM8aoNLA5ErJwfQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EB0A18B6142;
 Wed, 24 Feb 2021 11:53:42 +0000 (UTC)
Received: from localhost (ovpn-115-137.ams2.redhat.com [10.36.115.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A20EE10016F0;
 Wed, 24 Feb 2021 11:53:30 +0000 (UTC)
Date: Wed, 24 Feb 2021 11:53:29 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [RFC PATCH] blk-core: remove blk_put_request()
Message-ID: <YDY+ObNNiBMMuSEt@stefanha-x1.localdomain>
References: <20210222211115.30416-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
In-Reply-To: <20210222211115.30416-1-chaitanya.kulkarni@wdc.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: snitzer@redhat.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, bfields@fieldses.org,
 linux-ide@vger.kernel.org, dm-devel@redhat.com, target-devel@vger.kernel.org,
 alim.akhtar@samsung.com, agk@redhat.com, beanhuo@micron.com,
 stanley.chu@mediatek.com, linux-scsi@vger.kernel.org, cang@codeaurora.org,
 tim@cyberelk.net, dgilbert@interlog.com, vbadigan@codeaurora.org,
 richard.peng@oppo.com, jejb@linux.ibm.com, linux-block@vger.kernel.org,
 avri.altman@wdc.com, bp@alien8.de, jaegeuk@kernel.org,
 Kai.Makisara@kolumbus.fi, axboe@kernel.dk, linux-nfs@vger.kernel.org,
 martin.petersen@oracle.com, baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp,
 chuck.lever@oracle.com, zliua@micron.com, pbonzini@redhat.com,
 davem@davemloft.net, asutoshd@codeaurora.org
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
Content-Type: multipart/mixed; boundary="===============0472417221839146792=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0472417221839146792==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nED3gpEEOc5iD8Dg"
Content-Disposition: inline


--nED3gpEEOc5iD8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22, 2021 at 01:11:15PM -0800, Chaitanya Kulkarni wrote:
> The function blk_put_request() is just a wrapper to
> blk_mq_free_request(), remove the unnecessary wrapper.
>=20
> Any feedback is welcome on this RFC.
>=20
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  block/blk-core.c                   |  6 ------
>  block/blk-merge.c                  |  2 +-
>  block/bsg-lib.c                    |  4 ++--
>  block/bsg.c                        |  4 ++--
>  block/scsi_ioctl.c                 |  6 +++---
>  drivers/block/paride/pd.c          |  2 +-
>  drivers/block/pktcdvd.c            |  2 +-
>  drivers/block/virtio_blk.c         |  2 +-
>  drivers/cdrom/cdrom.c              |  4 ++--
>  drivers/ide/ide-atapi.c            |  2 +-
>  drivers/ide/ide-cd.c               |  4 ++--
>  drivers/ide/ide-cd_ioctl.c         |  2 +-
>  drivers/ide/ide-devsets.c          |  2 +-
>  drivers/ide/ide-disk.c             |  2 +-
>  drivers/ide/ide-ioctls.c           |  4 ++--
>  drivers/ide/ide-park.c             |  2 +-
>  drivers/ide/ide-pm.c               |  4 ++--
>  drivers/ide/ide-tape.c             |  2 +-
>  drivers/ide/ide-taskfile.c         |  2 +-
>  drivers/md/dm-mpath.c              |  2 +-
>  drivers/mmc/core/block.c           | 10 +++++-----
>  drivers/scsi/scsi_error.c          |  2 +-
>  drivers/scsi/scsi_lib.c            |  2 +-
>  drivers/scsi/sg.c                  |  6 +++---
>  drivers/scsi/st.c                  |  4 ++--
>  drivers/scsi/ufs/ufshcd.c          |  6 +++---
>  drivers/target/target_core_pscsi.c |  4 ++--
>  fs/nfsd/blocklayout.c              |  4 ++--
>  include/linux/blkdev.h             |  1 -
>  29 files changed, 46 insertions(+), 53 deletions(-)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fc60ff208497..1754f5e7cc80 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -642,12 +642,6 @@ struct request *blk_get_request(struct request_queue=
 *q, unsigned int op,
>  }
>  EXPORT_SYMBOL(blk_get_request);
> =20
> -void blk_put_request(struct request *req)
> -{
> -	blk_mq_free_request(req);
> -}
> -EXPORT_SYMBOL(blk_put_request);

blk_get_request() still exists after this patch. A "get" API usually has
a corresponding "put" API. I'm not sure this patch helps the consistency
and clarity of the code.

If you do go ahead, please update the blk_get_request() doc comment
explicitly mentioning that blk_mq_free_request() needs to be called.

Stefan

--nED3gpEEOc5iD8Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmA2PjkACgkQnKSrs4Gr
c8hCowf/apCHcJenx6DM1jzpYo1NNnpfJb2nifukyVLP2UVasntjvQM1WD7v1t84
WZMQu4BXSLlqhke4oxGQpx0/dNYaC3vi0/XB4yedtojqiAeLYqUgZf17ZDRybfvo
o0JmcTVjGtEm48hmt4kulUe9VTeIBaMh8c+IkEjxAEjFN45LgERG9YKRDdTVDCIg
ozqQR2DJJDN7ND80Mu397WnT32WJAJnpU5fLYIKrp8Y3ZINRly5h9F6rn87RmbHq
KdfZiGjiKMHIOnF1hP1oXi+a9xckj9US9MbvSBiMovQhs5zxuI0hBnpmsO1J6Pnl
6OYJzeRg/xtmqSUt8yY53YS9Hur9zg==
=4OR2
-----END PGP SIGNATURE-----

--nED3gpEEOc5iD8Dg--


--===============0472417221839146792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0472417221839146792==--

