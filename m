Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF60C001DE
	for <virtualization@archiver.kernel.org>; Sun,  6 Aug 2023 15:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E1A360A69;
	Sun,  6 Aug 2023 15:17:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E1A360A69
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dCwIKOi6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8-4AnycYOvkc; Sun,  6 Aug 2023 15:17:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AD16E60608;
	Sun,  6 Aug 2023 15:17:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD16E60608
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84E18C0071;
	Sun,  6 Aug 2023 15:17:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C82BC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  6 Aug 2023 15:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60E8340258
 for <virtualization@lists.linux-foundation.org>;
 Sun,  6 Aug 2023 15:17:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60E8340258
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dCwIKOi6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3LOKl_XjQWg5
 for <virtualization@lists.linux-foundation.org>;
 Sun,  6 Aug 2023 15:17:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1B5D2409F2
 for <virtualization@lists.linux-foundation.org>;
 Sun,  6 Aug 2023 15:17:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1B5D2409F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691335067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jmKB9tnmoSW66PnBBOCrXWK1ePidGDAnxGSMu5crApw=;
 b=dCwIKOi6roPJxSqUcHVHuUTE77CRU9R1fQI4zHN/SGnyaBOvdYFuenlZMOER3+UChPjH19
 HbhlaHxTM57sii206bphuyHZfA1zHJRUrCdwAy6PvjzT1fpUU9HC/iCXoZWqgY0ux/7KIF
 WI/xsg8qHc4a3zWDR8wcAn6pQuXHLpQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-1SoxKjUzMW6ry_98DG7KJw-1; Sun, 06 Aug 2023 11:17:46 -0400
X-MC-Unique: 1SoxKjUzMW6ry_98DG7KJw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a34d3e5ebso241919966b.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Aug 2023 08:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691335065; x=1691939865;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jmKB9tnmoSW66PnBBOCrXWK1ePidGDAnxGSMu5crApw=;
 b=goUPO4tJ1Pjs+suHY7NfGrCa3JN1ZbQbhVZYf9oOrdbe7xvX+XhYoxIJhzYwAeYXOP
 KQiN6W6uhXJl1gQzldh8JC9D7vzeCgBliBWinUOziihd7VE0Zh6e4A9t2G3YrKznB2tL
 X+KGRajLRyTj4n34XoXATJILw8GrlbaueMYs5qS+nuPamht0lXAJMf03azMcZFokPkNt
 86N5tQItUDIxeuPtJzLldTQrjcBJj9yykvwU1QcgDaLzLBofigcb7qCBegb47FMSppYP
 SCHpXYpROHiAB2abcnX86xWrod1P9CsN4fzZcffrC9xsH20rGAsQi664zmWOGVsM1j81
 quuA==
X-Gm-Message-State: AOJu0Yz8BQ4DH2EhIRNgexlQ6kkCSyo3XhWV/xUiCpZF8aDmHYWkDx1Z
 hpY8JxgAhUELDSM5q7lWvOhcAkxXkoEx9eShKzrbZa9x7xX2HsUUM2uCvdOTkue3ZzjuCt95oL5
 lXYHFpopPI+m3R5ZotbXJC63SxdLMGIFuBZBhX+aonA==
X-Received: by 2002:a17:907:2bca:b0:97d:2bcc:47d5 with SMTP id
 gv10-20020a1709072bca00b0097d2bcc47d5mr6414193ejc.49.1691335064957; 
 Sun, 06 Aug 2023 08:17:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtapW82Hb1Zd8BBSQHwutyuDtCwq2yQg3/1rQjZzPMqZ9Z/8LbFdyhFBBVmpsYlocZxyvMvg==
X-Received: by 2002:a17:907:2bca:b0:97d:2bcc:47d5 with SMTP id
 gv10-20020a1709072bca00b0097d2bcc47d5mr6414173ejc.49.1691335064609; 
 Sun, 06 Aug 2023 08:17:44 -0700 (PDT)
Received: from redhat.com ([91.242.248.114]) by smtp.gmail.com with ESMTPSA id
 bj10-20020a170906b04a00b0099bd6026f45sm4018477ejb.198.2023.08.06.08.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Aug 2023 08:17:43 -0700 (PDT)
Date: Sun, 6 Aug 2023 11:10:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [PATCH v4] virtio_pmem: add the missing REQ_OP_WRITE for flush bio
Message-ID: <20230806110854-mutt-send-email-mst@kernel.org>
References: <CAM9Jb+g5rrvmw8xCcwe3REK4x=RymrcqQ8cZavwWoWu7BH+8wA@mail.gmail.com>
 <20230713135413.2946622-1-houtao@huaweicloud.com>
 <CAM9Jb+jjg_By+A2F+HVBsHCMsVz1AEVWbBPtLTRTfOmtFao5hA@mail.gmail.com>
 <47f9753353d07e3beb60b6254632d740682376f9.camel@intel.com>
MIME-Version: 1.0
In-Reply-To: <47f9753353d07e3beb60b6254632d740682376f9.camel@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "pankaj.gupta.linux@gmail.com" <pankaj.gupta.linux@gmail.com>, "Jiang,
 Dave" <dave.jiang@intel.com>,
 "houtao@huaweicloud.com" <houtao@huaweicloud.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "hch@infradead.org" <hch@infradead.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "houtao1@huawei.com" <houtao1@huawei.com>,
 "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Aug 04, 2023 at 09:03:20PM +0000, Verma, Vishal L wrote:
> On Fri, 2023-08-04 at 20:39 +0200, Pankaj Gupta wrote:
> > Gentle ping!
> > =

> > Dan, Vishal for suggestion/review on this patch and request for merging.
> > +Cc Michael for awareness, as virtio-pmem device is currently broken.
> =

> Looks good to me,
> =

> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> =

> Dave, will you queue this for 6.6.


Generally if you expect me to merge a patch I should be CC'd.


> > =

> > Thanks,
> > Pankaj
> > =

> > > From: Hou Tao <houtao1@huawei.com>
> > > =

> > > When doing mkfs.xfs on a pmem device, the following warning was
> > > reported:
> > > =

> > > =A0------------[ cut here ]------------
> > > =A0WARNING: CPU: 2 PID: 384 at block/blk-core.c:751 submit_bio_noacct
> > > =A0Modules linked in:
> > > =A0CPU: 2 PID: 384 Comm: mkfs.xfs Not tainted 6.4.0-rc7+ #154
> > > =A0Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> > > =A0RIP: 0010:submit_bio_noacct+0x340/0x520
> > > =A0......
> > > =A0Call Trace:
> > > =A0 <TASK>
> > > =A0 ? submit_bio_noacct+0xd5/0x520
> > > =A0 submit_bio+0x37/0x60
> > > =A0 async_pmem_flush+0x79/0xa0
> > > =A0 nvdimm_flush+0x17/0x40
> > > =A0 pmem_submit_bio+0x370/0x390
> > > =A0 __submit_bio+0xbc/0x190
> > > =A0 submit_bio_noacct_nocheck+0x14d/0x370
> > > =A0 submit_bio_noacct+0x1ef/0x520
> > > =A0 submit_bio+0x55/0x60
> > > =A0 submit_bio_wait+0x5a/0xc0
> > > =A0 blkdev_issue_flush+0x44/0x60
> > > =

> > > The root cause is that submit_bio_noacct() needs bio_op() is either
> > > WRITE or ZONE_APPEND for flush bio and async_pmem_flush() doesn't ass=
ign
> > > REQ_OP_WRITE when allocating flush bio, so submit_bio_noacct just fail
> > > the flush bio.
> > > =

> > > Simply fix it by adding the missing REQ_OP_WRITE for flush bio. And we
> > > could fix the flush order issue and do flush optimization later.
> > > =

> > > Cc: stable@vger.kernel.org=A0# 6.3+
> > > Fixes: b4a6bb3a67aa ("block: add a sanity check for non-write flush/f=
ua bios")
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
> > > Tested-by: Pankaj Gupta <pankaj.gupta@amd.com>
> > > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > > ---
> > > v4:
> > > =A0* add stable Cc
> > > =A0* collect Rvb and Tested-by tags
> > > =

> > > v3: https://lore.kernel.org/linux-block/20230625022633.2753877-1-hout=
ao@huaweicloud.com
> > > =A0* adjust the overly long lines in both commit message and code
> > > =

> > > v2: https://lore.kernel.org/linux-block/20230621134340.878461-1-houta=
o@huaweicloud.com
> > > =A0* do a minimal fix first (Suggested by Christoph)
> > > =

> > > v1: https://lore.kernel.org/linux-block/ZJLpYMC8FgtZ0k2k@infradead.or=
g/T/#t
> > > =

> > > =A0drivers/nvdimm/nd_virtio.c | 3 ++-
> > > =A01 file changed, 2 insertions(+), 1 deletion(-)
> > > =

> > > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > > index c6a648fd8744..1f8c667c6f1e 100644
> > > --- a/drivers/nvdimm/nd_virtio.c
> > > +++ b/drivers/nvdimm/nd_virtio.c
> > > @@ -105,7 +105,8 @@ int async_pmem_flush(struct nd_region *nd_region,=
 struct bio *bio)
> > > =A0=A0=A0=A0=A0=A0=A0=A0 * parent bio. Otherwise directly call nd_reg=
ion flush.
> > > =A0=A0=A0=A0=A0=A0=A0=A0 */
> > > =A0=A0=A0=A0=A0=A0=A0 if (bio && bio->bi_iter.bi_sector !=3D -1) {
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct bio *child =3D bio=
_alloc(bio->bi_bdev, 0, REQ_PREFLUSH,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct bio *child =3D bio=
_alloc(bio->bi_bdev, 0,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 REQ_OP_W=
RITE | REQ_PREFLUSH,
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 GFP_ATOM=
IC);
> > > =

> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!child)
> > > --
> > > 2.29.2
> > > =

> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
