Return-Path: <SRS0=o/aD=BM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87611C433DF
	for <virtualization@archiver.kernel.org>; Sun,  2 Aug 2020 06:26:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E5122B49
	for <virtualization@archiver.kernel.org>; Sun,  2 Aug 2020 06:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/4hoMMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E5122B49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 26CD386C12;
	Sun,  2 Aug 2020 06:26:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o9SkdbSIBjH1; Sun,  2 Aug 2020 06:26:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2ADFC86B9E;
	Sun,  2 Aug 2020 06:26:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1295AC0050;
	Sun,  2 Aug 2020 06:26:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F7A4C004D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Aug 2020 06:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 52E4120468
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Aug 2020 06:26:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0b8KiIOWgUaO
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Aug 2020 06:26:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id ED02E20034
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Aug 2020 06:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596349582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qtRwpw8KaYzbjOwsQk1RkKr/x7ohfyLS11IO8SCvDmU=;
 b=N/4hoMMpDntozC/YLWPXOkpRUJTYUKEOJOp9DZItDedN2u1EpEtfaEYBm4bC6/s0TBBcVD
 nTMkoDusDNtI/qv6r3OV+uodw5ztcGQtgRwFck28rcLF3tKw/KO1y+nXx+NH8wVzinVpNH
 55GlVNjbqvAalZhM7s/aErU6mt+ffJw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-70nR6TZzOWWt2gtE9xBvqw-1; Sun, 02 Aug 2020 02:26:20 -0400
X-MC-Unique: 70nR6TZzOWWt2gtE9xBvqw-1
Received: by mail-wr1-f69.google.com with SMTP id z1so10315909wrn.18
 for <virtualization@lists.linux-foundation.org>;
 Sat, 01 Aug 2020 23:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qtRwpw8KaYzbjOwsQk1RkKr/x7ohfyLS11IO8SCvDmU=;
 b=TyxIZkrUDrWTM/aJgKCyw5EaLlM11i8UKftBg4elVQJBcBz9tGgqsVGNRGvmi9QSE9
 Mf+tTAeZfHEhmFVDO9wjP54WUqvNnKx7y0HXYgs4RFMB0mxdCloamPZGu5C6ibbbhAQe
 UNIaxKj2jrrOrd2oMjk9B5VeHuK1V+hOw16YY3T5Kov0Yh3BsqnVN60+0mWkM+ybD0xr
 y6uZ+R4uZLuzzOsqMmRn0joeJbWNGLAmVrI4i1Z0gQ/PoEh8hCUZKiJjcVjh0Aw/AKbv
 9uzR5vBKdx1cxZPUzyRN+6MlpKNMLkpAEUxivFcpTYLagTj8C98DEteLT+rrV51orF6P
 mPpw==
X-Gm-Message-State: AOAM532i2caHnn0laioL0iMEhluAztPLZ6VG2HsIjxQk6lqgLDlFYJ0q
 FsNqgvNAEm+eMFqaEK4oIzemt6InpE/SKCiLnlM+IK7RjuHua39zwhuoa1TQBfBgSokOcyYHCvf
 p5b43+O/fB/+/7h/DjG6ATcqvYowjl6vYH9v0bEktuw==
X-Received: by 2002:a7b:ca5a:: with SMTP id m26mr10442557wml.27.1596349579713; 
 Sat, 01 Aug 2020 23:26:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvAvq/rmcOFNmC2cQwRvUGwvvyAevu+DIBOVOyEZmkvs+orMCEXN40U/UCKI6wBOhbPYCqoA==
X-Received: by 2002:a7b:ca5a:: with SMTP id m26mr10442550wml.27.1596349579514; 
 Sat, 01 Aug 2020 23:26:19 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id 65sm20037688wre.6.2020.08.01.23.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2020 23:26:18 -0700 (PDT)
Date: Sun, 2 Aug 2020 02:26:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mao Wenan <wenan.mao@linux.alibaba.com>
Subject: Re: [PATCH -next v2] virtio_net: Avoid loop in virtnet_poll
Message-ID: <20200802022549-mutt-send-email-mst@kernel.org>
References: <20200802003818-mutt-send-email-mst@kernel.org>
 <1596347793-55894-1-git-send-email-wenan.mao@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1596347793-55894-1-git-send-email-wenan.mao@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
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


Just noticed the subject is wrong: this is no longer
a virtio_net patch.

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
