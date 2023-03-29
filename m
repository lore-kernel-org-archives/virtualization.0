Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF51C74A5B
	for <virtualization@archiver.kernel.org>; Wed, 29 Mar 2023 05:37:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64C5683FBF;
	Wed, 29 Mar 2023 05:37:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64C5683FBF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FBRY2eQZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fAU1Bwd0Eu-b; Wed, 29 Mar 2023 05:37:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C867F83EEA;
	Wed, 29 Mar 2023 05:37:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C867F83EEA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85251C0037;
	Wed, 29 Mar 2023 05:37:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C749C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 05:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E641141C53
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 05:37:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E641141C53
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FBRY2eQZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uSvOKcbpu3S6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 05:37:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D28DB408C6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D28DB408C6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 05:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680068221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hla3Qnsgd5UPmON5n9RR870xL1b8aSKIkUrN0GzbMGw=;
 b=FBRY2eQZl1cbB9zmNhJoEZpGHC4x9SGxUuZlvhzp2eSAwtdYicU1dZQZ5nCmA6nmNcxl+v
 49+KG5a5D7rsxBopk9TJ15BB3CSZEGkwBsPN5H6tah4RTFN6ia+vS80Zu7IECBo/9wUMZz
 L7++lFVnlp2v51Lt5EqSu8V1ETLNbq4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-xvrhSCq7OM2xgM3dRssBrw-1; Wed, 29 Mar 2023 01:37:00 -0400
X-MC-Unique: xvrhSCq7OM2xgM3dRssBrw-1
Received: by mail-wm1-f69.google.com with SMTP id
 n33-20020a05600c3ba100b003ee6335b6adso7290643wms.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 22:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680068219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hla3Qnsgd5UPmON5n9RR870xL1b8aSKIkUrN0GzbMGw=;
 b=D6If8Hlz+P3zUyHIwUbnmeA1Ol2LcTTI5E8zxVXrrQFHN378NCPXdD3LwxByQo+Ab0
 JWSaRV/4T46qAh96MY3JVa9Aq3fK58sbHlUmSHag6uC+c9N7PkruZZOt53WdClioLHJS
 TWJQMTPcq32Ew7oGY8YBH4cXjMx0MunQx/i0zXc9Hpqz04N3mc5tb/0RhEHSqyScMJ+K
 hn3raJdQHjRQSeQjFXDTHjwG9Q3WvtduihIdSJLZ2WmEa3dPqKEw5Nd1W9jjP9/7UGx4
 g7Rps7TwFyMcqUz8tKrEx+rJmshJR5jQr1B5UnB3fjrrAnuX/+Ct2P1aczESAYPuxmA8
 s2vg==
X-Gm-Message-State: AAQBX9fpRi5SJ0ZRGO3Bi7Nin8qiEsrMddkx151VKCQNX9IhpQ8MrJ/f
 PgPjDeqYIZyo9CQhEZAbmayW7SW+Vda9I2sVFxMMedGDXEXCG4WPjnMigeTDC1YqNa3fPIeq+PU
 2RUVv7VIoT/bnU0pdnpFw2+pyd4UrauRG6GQcautl2Q==
X-Received: by 2002:adf:ee0c:0:b0:2d8:908c:8fa0 with SMTP id
 y12-20020adfee0c000000b002d8908c8fa0mr15090849wrn.9.1680068218834; 
 Tue, 28 Mar 2023 22:36:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y06HXL9L5OeExITLNa0kaQS5mr7hukl/oOQCa72DJkzos37Pccw/+PbWD3EAjVhwrN5OJ3XQ==
X-Received: by 2002:adf:ee0c:0:b0:2d8:908c:8fa0 with SMTP id
 y12-20020adfee0c000000b002d8908c8fa0mr15090838wrn.9.1680068218505; 
 Tue, 28 Mar 2023 22:36:58 -0700 (PDT)
Received: from redhat.com ([2.52.18.165]) by smtp.gmail.com with ESMTPSA id
 b9-20020adfde09000000b002daeb108304sm16094294wrm.33.2023.03.28.22.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Mar 2023 22:36:57 -0700 (PDT)
Date: Wed, 29 Mar 2023 01:36:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Huang <huangjie.albert@bytedance.com>
Subject: Re: [PATCH v2] virtio_ring: don't update event idx on get_buf
Message-ID: <20230329013434-mutt-send-email-mst@kernel.org>
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230325105633.58592-1-huangjie.albert@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Sat, Mar 25, 2023 at 06:56:33PM +0800, Albert Huang wrote:
> in virtio_net, if we disable the napi_tx, when we triger a tx interrupt,
> the vq->event_triggered will be set to true. It will no longer be set to
> false. Unless we explicitly call virtqueue_enable_cb_delayed or
> virtqueue_enable_cb_prepare.
> 
> If we disable the napi_tx, it will only be called when the tx ring
> buffer is relatively small.
> 
> Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> every time we call virtqueue_get_buf_ctx. This will bring more interruptions.
> 
> To summarize:
> 1) event_triggered was set to true in vring_interrupt()
> 2) after this nothing will happen for virtqueue_disable_cb() so
>    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
>    then it tries to publish new event
> 
> To fix, if event_triggered is set to true, do not update
> vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> 
> Tested with iperf:
> iperf3 tcp stream:
> vm1 -----------------> vm2
> vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> there are many tx interrupts in vm2.
> but without event_triggered there are just a few tx interrupts.
> 
> Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> Message-Id: <20230321085953.24949-1-huangjie.albert@bytedance.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

dropped for now due to breakage of 9p.
Pls post v3 with the fix you suggested (moving the check
of vq->event_triggered).

> ---
>  drivers/virtio/virtio_ring.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cbeeea1b0439..1c36fa477966 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -914,7 +914,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	/* If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call. */
> -	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> +	if (unlikely(!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) &&
> +		     !vq->event_triggered))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vring_used_event(&vq->split.vring),
>  				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> @@ -1744,7 +1745,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call.
>  	 */
> -	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
> +	if (unlikely(vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC &&
> +		     !vq->event_triggered))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vq->packed.vring.driver->off_wrap,
>  				cpu_to_le16(vq->last_used_idx));
> -- 
> 2.37.0 (Apple Git-136)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
