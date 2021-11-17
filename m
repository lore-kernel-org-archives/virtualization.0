Return-Path: <SRS0=9pi5=QE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CF0C433FE
	for <virtualization@archiver.kernel.org>; Wed, 17 Nov 2021 09:20:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A6A61BD3
	for <virtualization@archiver.kernel.org>; Wed, 17 Nov 2021 09:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B4A6A61BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7699880F5D;
	Wed, 17 Nov 2021 09:20:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FzzCEXIoAeyI; Wed, 17 Nov 2021 09:20:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 43C8380F7B;
	Wed, 17 Nov 2021 09:20:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F24C6C002E;
	Wed, 17 Nov 2021 09:20:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BC10C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 09:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 68BE540236
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 09:20:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G1dhMt3zElLm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 09:20:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 43937403F7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 09:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637140820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=77rEDu/reg/YJ6amwbhAgjZqXAbfYRFP4sr85cH8gm4=;
 b=ag+dyQo2AvlxAw6gQe94MJ2D+ZgiT5Ref0HtOjcHpzUQsrwCrMmwRYz/Dg6u6doh/Qfk/c
 MaKGUCCShVkoXB6a4C6Ir5ZIzIMXaVCk1s4w+NyIMpa/+j11yA3xPAMz4Ffe7miWnq1gUP
 JYbJQGYtE5h+wztniBqz6QcxnClp2fs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-9G32jFsdPk2QLkL5OnWX_g-1; Wed, 17 Nov 2021 04:20:18 -0500
X-MC-Unique: 9G32jFsdPk2QLkL5OnWX_g-1
Received: by mail-ed1-f70.google.com with SMTP id
 c1-20020aa7c741000000b003e7bf1da4bcso1524889eds.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 01:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=77rEDu/reg/YJ6amwbhAgjZqXAbfYRFP4sr85cH8gm4=;
 b=0hAwSi9cF+ndJyv74dgYT1OmNczjzgCmbvSi43nfPi/RBKNNETYpFaD8MwWehFm4i4
 BP6E1d2JpE9xTs6HQowq6jmQ+7oJsXC+sQV9Xkyk12LMpMbDIyNbrZKmuq2j3tmaU3B3
 gCT+1tWIwQel0CxyGa/EeISPooZ+3yL9/Tyd2GANXAU4EChGxhYKqAJKrMOJ8uonoNJD
 AsznZ+DeIsQJC+YkDqhROkUeTKEMiCQSl89AjnFEyw0/MUVWBIYTJ3C4xxVti2RH8Cxs
 N/DRB9hlVogDDcHHwmKTm86A2Ifva/gyQCrNS6jTENhYmc4iHcziccZtjS5L48m3l6B1
 l8vg==
X-Gm-Message-State: AOAM532DykVwkGfgTtzOwTj0K1TpBBXQZdEU2zkmw+dlk6FBVeK+rTA/
 CkJdsCZKzVLF3IDHmFHeIUlpezQP1O7mOOjVoJAEXAEKK7Fwby+18Fe+U2eJQU6esQ+LGuYGLc5
 P52c1aiX2guuGkPAeTnx4izIxUmRoFJsZ7zo5JZ+Lhw==
X-Received: by 2002:aa7:c714:: with SMTP id i20mr19958653edq.180.1637140817840; 
 Wed, 17 Nov 2021 01:20:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYtu97PwkW2A1yYGpWopI7K1d4sbVlbcdvIekk7lLEy/KSy29AQt851GD79KmBNlKEUMRrUw==
X-Received: by 2002:aa7:c714:: with SMTP id i20mr19958629edq.180.1637140817719; 
 Wed, 17 Nov 2021 01:20:17 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id hw8sm9777163ejc.58.2021.11.17.01.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Nov 2021 01:20:17 -0800 (PST)
Date: Wed, 17 Nov 2021 10:20:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: cgel.zte@gmail.com
Subject: Re: [PATCH] virtio-blk: modify the value type of num in
 virtio_queue_rq()
Message-ID: <20211117092014.qyqhtg2y5etoxrqe@steredhat>
References: <20211117063955.160777-1-ye.guojin@zte.com.cn>
MIME-Version: 1.0
In-Reply-To: <20211117063955.160777-1-ye.guojin@zte.com.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 stefanha@redhat.com, Ye Guojin <ye.guojin@zte.com.cn>, pbonzini@redhat.com,
 Zeal Robot <zealci@zte.com.cn>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Nov 17, 2021 at 06:39:55AM +0000, cgel.zte@gmail.com wrote:
>From: Ye Guojin <ye.guojin@zte.com.cn>
>
>This was found by coccicheck:
>./drivers/block/virtio_blk.c, 334, 14-17, WARNING Unsigned expression
>compared with zero  num < 0
>

We should add the Fixes tag:

Fixes: 02746e26c39e ("virtio-blk: avoid preallocating big SGL for data")

>Reported-by: Zeal Robot <zealci@zte.com.cn>
>Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
>---
> drivers/block/virtio_blk.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>index 97bf051a50ce..eed1666eff31 100644
>--- a/drivers/block/virtio_blk.c
>+++ b/drivers/block/virtio_blk.c
>@@ -316,7 +316,7 @@ static blk_status_t virtio_queue_rq(struct 
>blk_mq_hw_ctx *hctx,
> 	struct request *req = bd->rq;
> 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> 	unsigned long flags;
>-	unsigned int num;
>+	int num;
> 	int qid = hctx->queue_num;
> 	bool notify = false;
> 	blk_status_t status;
>-- 
>2.25.1
>

The patch LGTM.

With the Fixes tag added:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
