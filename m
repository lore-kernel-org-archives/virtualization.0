Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673E7C004C0
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 11:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E30A04148F;
	Mon, 23 Oct 2023 11:18:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E30A04148F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qu6LImUT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tAFn9nDPqz0P; Mon, 23 Oct 2023 11:18:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DAA4E40A6F;
	Mon, 23 Oct 2023 11:18:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DAA4E40A6F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3FDCC0039;
	Mon, 23 Oct 2023 11:18:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26881C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 11:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E88F160B6C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 11:18:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E88F160B6C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qu6LImUT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xfhg6wcUr_wm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 11:18:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 236DE610C2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 11:18:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 236DE610C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698059933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jnC1GGwxL9Zbpu28wAk0w4sz4UIRk93Qqt6FyBIuiIY=;
 b=Qu6LImUTePSNU6FTqtsqGPns69DG4Oqhs+9BuPdJhvVw4J6at6lrKH5tFbFl8diR13+d/2
 xDEIOz1oMyRO0mBf0jCdyZW20UO3vCYVdWe8241yx0QRnmC0N2tJyb+vvtbE7DSutPOZNs
 JcmNvzBjVPLB7jd+OVWzuHJ4uToeYTA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-ehf9w_UqNZuL2UdygHlgmg-1; Mon, 23 Oct 2023 07:18:45 -0400
X-MC-Unique: ehf9w_UqNZuL2UdygHlgmg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4084a9e637eso20359885e9.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 04:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698059924; x=1698664724;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnC1GGwxL9Zbpu28wAk0w4sz4UIRk93Qqt6FyBIuiIY=;
 b=v5p3BabptkDoUyA44yzm/ZP8gsY36PRUic/e5g/DxA/2Isi1ksq7v7MIFc4ZkeNnyw
 ksUfFDsiKdqjjziIAwCfpWrTeGmrktWI+q7SZNo4h3/l53WQJH4JTZ47Y9Wy97cnUYnc
 7wJFfCQFsEDgl+h16bcdXcHTMQMrLnl+V4O1KsFyZYgC9uGvoHWfgpQP6Nzjm7EoZuY8
 MhF8JtAMqRY807MZHkJnPnpqraOTHuGSbgiq7f5Eh2WfbTLzpVMVmJff/NDdN91VnGfN
 xBM7WKMKhRGxqWlkrxArUoN/ytBGAAdknc8X0j522FZf5nH9D6HmCIMsep3i0ai8BBU+
 gcUg==
X-Gm-Message-State: AOJu0Yx/4Zs9s7CFRdxaXFiE7QgZfChVudQaV5JW1vnNlhjdW5sdnNmo
 j7QwjPYp2ZAPSffw2RDFBmW10FmhMa0yUAqs0oG55arcC90evpBaW5g6QzsazmsNm2/xjLecsIL
 6zdOl3TzmhGMgQGyuy4z831GbbEp8jNF962NiSiU3IA==
X-Received: by 2002:a05:600c:3b17:b0:405:39c1:a98b with SMTP id
 m23-20020a05600c3b1700b0040539c1a98bmr6781858wms.20.1698059924735; 
 Mon, 23 Oct 2023 04:18:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlNOSbGZV0psNxYVAdk0xozr8uaYafLwOEKQtbvzrUCUXDsWv/S3FBPkSASbIRrVthMSMMVg==
X-Received: by 2002:a05:600c:3b17:b0:405:39c1:a98b with SMTP id
 m23-20020a05600c3b1700b0040539c1a98bmr6781844wms.20.1698059924402; 
 Mon, 23 Oct 2023 04:18:44 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:e88f:2c2c:db43:583d:d30e])
 by smtp.gmail.com with ESMTPSA id
 c39-20020a05600c4a2700b0040588d85b3asm13601617wmp.15.2023.10.23.04.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 04:18:43 -0700 (PDT)
Date: Mon, 23 Oct 2023 07:18:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Message-ID: <20231023071752-mutt-send-email-mst@kernel.org>
References: <1697795422.0986886-1-xuanzhuo@linux.alibaba.com>
 <20231020055943-mutt-send-email-mst@kernel.org>
 <1698028017.8052797-1-xuanzhuo@linux.alibaba.com>
 <d4aa3f76-3e08-a852-a948-b88226a37fdd@nfschina.com>
 <1698029596.5404413-3-xuanzhuo@linux.alibaba.com>
 <46aee820-6c01-ed8a-613b-5c57258d749e@nfschina.com>
 <1698040004.5365264-4-xuanzhuo@linux.alibaba.com>
 <6a7d1006-0988-77ea-0991-9c7b422d78e1@nfschina.com>
 <1698054722.2894735-1-xuanzhuo@linux.alibaba.com>
 <1698058354.8316164-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1698058354.8316164-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Su Hui <suhui@nfschina.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Oct 23, 2023 at 06:52:34PM +0800, Xuan Zhuo wrote:
> On Mon, 23 Oct 2023 17:52:02 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > On Mon, 23 Oct 2023 17:50:46 +0800, Su Hui <suhui@nfschina.com> wrote:
> > > On 2023/10/23 13:46, Xuan Zhuo wrote:
> > > >>>>>>>> Well, what are the cases where it can happen practically?
> > > >>>>>>> Device error. Such as vp_active_vq()
> > > >>>>>>>
> > > >>>>>>> Thanks.
> > > >>>>>> Hmm interesting. OK. But do callers know to recover?
> > > >>>>> No.
> > > >>>>>
> > > >>>>> So I think WARN + broken is suitable.
> > > >>>>>
> > > >>>>> Thanks.
> > > >>>> Sorry for the late, is the following code okay?
> > > >>>>
> > > >>>> @@ -2739,7 +2739,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > > >>>>                         void (*recycle)(struct virtqueue *vq, void *buf))
> > > >>>>     {
> > > >>>>            struct vring_virtqueue *vq = to_vvq(_vq);
> > > >>>> -       int err;
> > > >>>> +       int err, err_reset;
> > > >>>>
> > > >>>>            if (num > vq->vq.num_max)
> > > >>>>                    return -E2BIG;
> > > >>>> @@ -2759,7 +2759,15 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > > >>>>            else
> > > >>>>                    err = virtqueue_resize_split(_vq, num);
> > > >>>>
> > > >>>> -       return virtqueue_enable_after_reset(_vq);
> > > >>>> +       err_reset = virtqueue_enable_after_reset(_vq);
> > > >>>> +
> > > >>>> +       if (err) {
> > > >>> No err.
> > > >>>
> > > >>> err is not important.
> > > >>> You can remove that.
> > > >> Emm, I'm a little confused that which code should I remove ?
> > > >>
> > > >>
> > > >> like this:
> > > >> 	if (vq->packed_ring)
> > > >> 		virtqueue_resize_packed(_vq, num);
> > > >> 	else
> > > >> 		virtqueue_resize_split(_vq, num);
> > > >>
> > > >> And we should set broken and warn inside virtqueue_enable_after_reset()?
> > >
> > > In my opinion, we should return the error code of virtqueue_resize_packed() / virtqueue_resize_split().
> > > But if this err is not important, this patch makes no sense.
> > > Maybe I misunderstand somewhere...
> > > If you think it's worth sending a patch, you can send it :).(I'm not familiar with this code).
> >
> > OK.
> 
> Hi Michael,
> 
> The queue reset code is wrote with the CONFIG_VIRTIO_HARDEN_NOTIFICATION.
> 
> When we disable the vq, the broken is true until we re-enable it.
> 
> So when we re-enable it fail, the vq is broken status.
> 
> Normally, this just happens on the buggy device.
> So I think that is enough.
> 
> Thanks.

I don't know what to do about CONFIG_VIRTIO_HARDEN_NOTIFICATION.
It's known to be broken and it does not look like there's
active effort to revive it - should we just drop it for now?


> 
> 	static int vp_modern_disable_vq_and_reset(struct virtqueue *vq)
> 	{
> 		[...]
> 
> 		vp_modern_set_queue_reset(mdev, vq->index);
> 
> 		[...]
> 
> 	#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> ->>		__virtqueue_break(vq);
> 	#endif
> 
> 		[...]
> 	}
> 
> 	static int vp_modern_enable_vq_after_reset(struct virtqueue *vq)
> 	{
> 		[...]
> 
> 		if (vp_modern_get_queue_reset(mdev, index))
> 			return -EBUSY;
> 
> 		if (vp_modern_get_queue_enable(mdev, index))
> 			return -EBUSY;
> 
> 		err = vp_active_vq(vq, info->msix_vector);
> 		if (err)
> 			return err;
> 
> 		}
> 
> 		[...]
> 
> 	#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> ->>		__virtqueue_unbreak(vq);
> 	#endif
> 
> 		[...]
> 	}
> 
> 
> 
> 
> >
> > Thanks.
> >
> >
> > >
> > > Thanks,
> > > Su Hui
> > >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
