Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1724ECAAA1
	for <virtualization@archiver.kernel.org>; Mon, 24 Oct 2022 13:34:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA92B8136C;
	Mon, 24 Oct 2022 13:34:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA92B8136C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R/PjRTXD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fci0Uk-xXqBl; Mon, 24 Oct 2022 13:34:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 34CB08134B;
	Mon, 24 Oct 2022 13:34:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34CB08134B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8AE5C0032;
	Mon, 24 Oct 2022 13:34:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D3C8C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 13:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51F7B40598
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 13:34:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 51F7B40598
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=R/PjRTXD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zvz8bpCcvR3n
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 13:33:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8673E40588
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8673E40588
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 13:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666618438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Co+mZwrA6BtWICFuluqHpcYHUEFY3CVy1+yDBlYoNG0=;
 b=R/PjRTXDQvlYk53zBlJ/ivrR+lLtUT+uzfn9E6dRNddC4q0gegEnfOzo2DknVm0RcdG9A9
 v8xH2D6K4e+9GIEYSq89FOA8eZMLFHTOiebvCBh7FdDeOFoc75RK/sPtRoRuXYK8pCFEyU
 BDnjibdAJFuoor0tBiR0PuqMyLwFXv0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-549-vP2rxKdyM_itSNHClNJV5A-1; Mon, 24 Oct 2022 09:33:53 -0400
X-MC-Unique: vP2rxKdyM_itSNHClNJV5A-1
Received: by mail-qv1-f69.google.com with SMTP id
 c2-20020a05621401c200b004bb71b13dfcso1006929qvt.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 06:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Co+mZwrA6BtWICFuluqHpcYHUEFY3CVy1+yDBlYoNG0=;
 b=QunqoI0EHhRvn2InIG+NQ4mvgdis17yk19RVWWu+QTM7HcnrixjyWS4tZvrNgQhWdd
 vj+SyDVP0NAA+MtYy8k/EBDWhqdFFy3uBUU79hRYSSIxEKMuYRtZ90mJ5C+pcp3P34vX
 L9nv1idH0unp5v2rGWvYOkQhydpphjPmFG8Nv1W7x3nNQlArTx/B/qFdayD80d0g8aAm
 zjEIaYb6DeEkiNuDPi+vaolw+ATmQPcSpLYltOh28gZPF9kDRBtqqrvjUZ+7zcPz+LuX
 3DLYa/gv7lSmqJDSy9DF+o9Rcjvu8chXI48DNqwzkOxs4JG6/04qZn+9nMMSongfNUQ/
 woyw==
X-Gm-Message-State: ACrzQf2PXzx2lwsl2xReL+J0VlGNDcmj0dZ9AmvPTigPOUagqZMt9oj1
 xOmHHQFDnV1aIj/6IA2mpWYZhSUZejQD8L4SW+yIdWnCh0qnCrrZrnc7Gjd6tMzIZGwQlwjV+aM
 zSEdPEci18nxohkyLtcUGUsRrTlhIN2fGPu0Fji+OKQ==
X-Received: by 2002:a05:620a:2991:b0:6ee:92ee:5165 with SMTP id
 r17-20020a05620a299100b006ee92ee5165mr23277319qkp.177.1666618432978; 
 Mon, 24 Oct 2022 06:33:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Yg9OJr5t+PzjIlFe7DyeWZYWlKJigBrJ2zA777WAfcBRrHdX5Mzg+wwVEGTHNrqihr8BU8g==
X-Received: by 2002:a05:620a:2991:b0:6ee:92ee:5165 with SMTP id
 r17-20020a05620a299100b006ee92ee5165mr23277283qkp.177.1666618432728; 
 Mon, 24 Oct 2022 06:33:52 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-34.retail.telecomitalia.it.
 [87.11.6.34]) by smtp.gmail.com with ESMTPSA id
 ay11-20020a05620a178b00b006ee96d82188sm13005230qkb.1.2022.10.24.06.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Oct 2022 06:33:52 -0700 (PDT)
Date: Mon, 24 Oct 2022 15:33:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Rafael Mendonca <rafaelmendsr@gmail.com>
Subject: Re: [PATCH] virtio_blk: Fix signedness bug in virtblk_prep_rq()
Message-ID: <20221024133346.whuejusy333o3vqd@sgarzare-redhat>
References: <20221021204126.927603-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20221021204126.927603-1-rafaelmendsr@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Suwan Kim <suwan.kim027@gmail.com>
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

On Fri, Oct 21, 2022 at 05:41:26PM -0300, Rafael Mendonca wrote:
>The virtblk_map_data() function returns negative error codes, however, the
>'nents' field of vbr->sg_table is an unsigned int, which causes the error
>handling not to work correctly.
>
>Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
>Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
>---
> drivers/block/virtio_blk.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

Good catch!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>index 19da5defd734..291f705e61a8 100644
>--- a/drivers/block/virtio_blk.c
>+++ b/drivers/block/virtio_blk.c
>@@ -321,16 +321,18 @@ static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
> 					struct virtblk_req *vbr)
> {
> 	blk_status_t status;
>+	int num;
>
> 	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
> 	if (unlikely(status))
> 		return status;
>
>-	vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
>-	if (unlikely(vbr->sg_table.nents < 0)) {
>+	num = virtblk_map_data(hctx, req, vbr);
>+	if (unlikely(num < 0)) {
> 		virtblk_cleanup_cmd(req);
> 		return BLK_STS_RESOURCE;
> 	}
>+	vbr->sg_table.nents = num;
>
> 	blk_mq_start_request(req);
>
>-- 
>2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
