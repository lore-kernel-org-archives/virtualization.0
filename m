Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F91C43334
	for <virtualization@archiver.kernel.org>; Wed, 22 Jun 2022 12:15:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 493BB84531;
	Wed, 22 Jun 2022 12:15:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 493BB84531
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L/kzFopk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CPnk6i694Dxu; Wed, 22 Jun 2022 12:15:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D1EDF8452E;
	Wed, 22 Jun 2022 12:15:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D1EDF8452E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFE41C0039;
	Wed, 22 Jun 2022 12:15:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DE18C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 12:15:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6229D40C90
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 12:15:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6229D40C90
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=L/kzFopk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VWRiSPCgEkQN
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 12:15:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4C8F40517
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4C8F40517
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 12:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655900118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EQ0/S4hTGe/CYe8u/0j1fhgzO/f/h03uTX6vN/h92Tk=;
 b=L/kzFopkjj44Iwv2d5vETvH/QJStftSRhoM7dWI8be6xerQBt7eLaVLrvfAin3IJapjEOo
 2ZAc8yROZXay+m0wvM8Kqo641X/TyxpVih0jZwyOEi4sRz85vehpKpuZ4fdDPwpOLJFx65
 2ZgZgAa9vNgBpcAeiQUxRJBh0uk2qIM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-DHFcwN9gMROA-VnoHexYWA-1; Wed, 22 Jun 2022 08:15:17 -0400
X-MC-Unique: DHFcwN9gMROA-VnoHexYWA-1
Received: by mail-wm1-f70.google.com with SMTP id
 m23-20020a05600c3b1700b0039c6e3c169aso7755424wms.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 05:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EQ0/S4hTGe/CYe8u/0j1fhgzO/f/h03uTX6vN/h92Tk=;
 b=QeedTdb+ICMAZtPMGUEnHsjye3IdchYZYb4ZY+FyEF+7Ae/TAWTUKICr9CMlY7eeqn
 JRqr/7B21mYpg8vEbrOipObJ8FGl/VCDKr1j2EqZ8H8r7Vw/u6gXhIKbhLetEfXZd1os
 +RdCP6kM15rSyDO+nx6srY9IMnsSzXedUcPauKEPjgS3giZxqLfoomrTCLqcXh9aS35j
 lx/r4PxqDzPhX0sMCkXRxGk5zLfiqiSaHBenIZX7B+rnczo6em9ca5yVZJ4LtZWWFYyQ
 3MNK6s0t6mkpH7+DBK7g/6IjfbvGo06XBslnVVoC7Ux/rbEW4x+qpkAdQIrhcpgCUaqk
 ac5A==
X-Gm-Message-State: AJIora9XBfjWy13q+W8saTzuvdA2wKv+3ThSzcaLrCdL9zDFx0WegjEE
 DcCyziNhA9qBj7X4LDpupyds5Gl3rpRemx0PzXBiT3DJRMMHnUflkpDQ7PEra0DVOi8brwNR0M1
 LWyCdujH6Mfu4bKlriSyRwl7mJXlHeKJecgYFBz/udQ==
X-Received: by 2002:adf:f7c7:0:b0:21b:9452:e8fe with SMTP id
 a7-20020adff7c7000000b0021b9452e8femr3211547wrq.640.1655900115861; 
 Wed, 22 Jun 2022 05:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uw/M5KspGlqskc/kFQvcJ3XkxHAQCDS3r8X8uIM7gfQdn0B5UzoYAktVnD2Jx/JTdYhXLqyA==
X-Received: by 2002:adf:f7c7:0:b0:21b:9452:e8fe with SMTP id
 a7-20020adff7c7000000b0021b9452e8femr3211525wrq.640.1655900115574; 
 Wed, 22 Jun 2022 05:15:15 -0700 (PDT)
Received: from redhat.com ([147.235.217.93]) by smtp.gmail.com with ESMTPSA id
 l15-20020a05600c2ccf00b003974a00697esm26140287wmc.38.2022.06.22.05.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jun 2022 05:15:14 -0700 (PDT)
Date: Wed, 22 Jun 2022 08:15:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Deming Wang <wangdeming@inspur.com>
Subject: Re: [PATCH] virtio_ring: remove unnecessary to_vvq call in
 virtqueue_disable_cb_packed
Message-ID: <20220622081411-mutt-send-email-mst@kernel.org>
References: <20220622075052.1560-1-wangdeming@inspur.com>
MIME-Version: 1.0
In-Reply-To: <20220622075052.1560-1-wangdeming@inspur.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
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

On Wed, Jun 22, 2022 at 03:50:52AM -0400, Deming Wang wrote:
> It passes '_vq' to virtqueue_use_indirect(), which still calls
> to_vvq to get 'vq', let's directly pass 'vq'. It can avoid
> unnecessary call of to_vvq in hot path.
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>

I do not see the point of any of these patches. Sorry.
If this is supposed to be an optimization, post some numbers pls.


> ---
>  drivers/virtio/virtio_ring.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 13a7348cedff..af2b7785ed77 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1475,10 +1475,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	return ret;
>  }
>  
> -static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
> +static void virtqueue_disable_cb_packed(struct vring_virtqueue *vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> -
>  	if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
>  		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
>  		vq->packed.vring.driver->flags =
> @@ -2007,7 +2005,7 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  		return;
>  
>  	if (vq->packed_ring)
> -		virtqueue_disable_cb_packed(_vq);
> +		virtqueue_disable_cb_packed(vq);
>  	else
>  		virtqueue_disable_cb_split(_vq);
>  }
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
