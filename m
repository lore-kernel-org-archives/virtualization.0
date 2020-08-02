Return-Path: <SRS0=o/aD=BM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069E0C433E0
	for <virtualization@archiver.kernel.org>; Sun,  2 Aug 2020 06:25:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58DC2076B
	for <virtualization@archiver.kernel.org>; Sun,  2 Aug 2020 06:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+SoEQ78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58DC2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8277E860FE;
	Sun,  2 Aug 2020 06:25:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bxfx6ZiaSllJ; Sun,  2 Aug 2020 06:25:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E99DA85F66;
	Sun,  2 Aug 2020 06:25:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBC58C0050;
	Sun,  2 Aug 2020 06:25:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C2E6C004D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Aug 2020 06:25:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 01F8185F87
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Aug 2020 06:25:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xU0QrZ-DJpgc
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Aug 2020 06:25:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DAF3785F66
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Aug 2020 06:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596349551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S6OYCdbGW3vcu3y+tw3bsh0JBnWwiCW5p61nwH6OSdk=;
 b=V+SoEQ787U/3fwVfj9KRjVe4O31leUb36UCrNo6+lFkRpx5qRS8xgo3ShvKAmPN1NnTQDP
 0Ar0ceKgy1tY9ko3gnT0Tym4QaW29moBodcvC4foDvbOyxgiJcLKznXIrA0WmJCZEtZde9
 dANVW2IkHYE5g4qHOBDlYcgd1RTH4Z4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-7OxJf2PpMr2QZe6N3EcJYw-1; Sun, 02 Aug 2020 02:25:47 -0400
X-MC-Unique: 7OxJf2PpMr2QZe6N3EcJYw-1
Received: by mail-wr1-f70.google.com with SMTP id 5so10281991wrc.17
 for <virtualization@lists.linux-foundation.org>;
 Sat, 01 Aug 2020 23:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S6OYCdbGW3vcu3y+tw3bsh0JBnWwiCW5p61nwH6OSdk=;
 b=Xzb86ICinDmVaKsi4MY+ufsKyW4tboV/U9rdvv+ozuZziH/CqgJ7DqiUiKk+Bwebwy
 51JG7ivlNXv40x979yzs7X22R2k6aH6QBpmMOmCjP1Qq5h88jgR6j79BC7gLOf3kEuL7
 /BxkMfiqmZF/RoSbKyTEvdBb1D3BMRRabdyBGH2Bd9Cdr1euW0g0NlkVahcGPN8pai/o
 4sKMC9WiNunDlYZJDsZaUHTR9EzY/sMPbQVpknnieubv1XA6qolMHpNNXUVxjaGYQroi
 wr2Z6BOB5DlQwjwR7ISWhc2vaBpH9tXmr6JRfy71qnD8m475WEhpe+rYIDXzI2NHIc2r
 EOEA==
X-Gm-Message-State: AOAM531ZGr/ycPXPoH4wUWx2c3hbi5a6cx2RV7uPkkz5BK656KykjzTP
 lG9oj0kRl8Ph2wHeDzO0bq1eImteotImhy4uNZG0uiWBSDcK9HUxPIi5nTJ6BadVoAcaTD40vhv
 H+HLz5WhY1P1vPiIzRfzhKVjzWt69Y3xdBGeeLC9ogw==
X-Received: by 2002:a7b:c154:: with SMTP id z20mr11102325wmi.118.1596349545752; 
 Sat, 01 Aug 2020 23:25:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynZI0DXpqHK+lKgKMB/Q7mJUqK4kYuqt49mPCgR78Fj5Qunpo174be0PRlqdzVRrBirQfRJw==
X-Received: by 2002:a7b:c154:: with SMTP id z20mr11102318wmi.118.1596349545515; 
 Sat, 01 Aug 2020 23:25:45 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id 68sm19668139wra.39.2020.08.01.23.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2020 23:25:44 -0700 (PDT)
Date: Sun, 2 Aug 2020 02:25:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mao Wenan <wenan.mao@linux.alibaba.com>
Subject: Re: [PATCH -next v2] virtio_net: Avoid loop in virtnet_poll
Message-ID: <20200802022521-mutt-send-email-mst@kernel.org>
References: <20200802003818-mutt-send-email-mst@kernel.org>
 <1596347793-55894-1-git-send-email-wenan.mao@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1596347793-55894-1-git-send-email-wenan.mao@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sun, Aug 02, 2020 at 01:56:33PM +0800, Mao Wenan wrote:
> The loop may exist if vq->broken is true,
> virtqueue_get_buf_ctx_packed or virtqueue_get_buf_ctx_split
> will return NULL, so virtnet_poll will reschedule napi to
> receive packet, it will lead cpu usage(si) to 100%.
> 
> call trace as below:
> virtnet_poll
> 	virtnet_receive
> 		virtqueue_get_buf_ctx
> 			virtqueue_get_buf_ctx_packed
> 			virtqueue_get_buf_ctx_split
> 	virtqueue_napi_complete
> 		virtqueue_poll           //return true
> 		virtqueue_napi_schedule //it will reschedule napi
> 
> To fix this, return false if vq is broken in virtqueue_poll.
> 
> Signed-off-by: Mao Wenan <wenan.mao@linux.alibaba.com>

Looks good:
Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  v1->v2: fix it in virtqueue_poll suggested by Michael S. Tsirkin <mst@redhat.com>
>  drivers/virtio/virtio_ring.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 58b96ba..4f7c73e 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1960,6 +1960,9 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> +	if (unlikely(vq->broken))
> +		return false;
> +
>  	virtio_mb(vq->weak_barriers);
>  	return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
>  				 virtqueue_poll_split(_vq, last_used_idx);
> -- 
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
