Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EA1C433EF
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 13:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50931408B0;
	Wed,  2 Mar 2022 13:15:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FyM87s6pverd; Wed,  2 Mar 2022 13:15:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E4B69405AA;
	Wed,  2 Mar 2022 13:15:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B84DBC0082;
	Wed,  2 Mar 2022 13:15:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 742AAC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 62E9B81448
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:15:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dxrjRqK9Zw6f
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:15:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB53F81447
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646226932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Du9bGCJyeYUBZfdICrU8RSrBiIwvIrsG9nwUtijwSEs=;
 b=OSWg5Lq1SuaxO9Y3iiSKXrfdF+qgOGkG00yqtbgYMIEhqzLoYv7EjVrr6V2ZenVDjQiMab
 7qQV8ueKlvkdiCmzeN4lGADnMTSKy/Apppa6QjU2xSQfq8dKIUL4kPHr+e4QerPFis3uZI
 VrygsxbfzsQjhDjS+mIrayvBbbvutfs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-1K7T_aLlN9S4cJqaBsHxDg-1; Wed, 02 Mar 2022 08:15:31 -0500
X-MC-Unique: 1K7T_aLlN9S4cJqaBsHxDg-1
Received: by mail-wm1-f71.google.com with SMTP id
 l2-20020a1ced02000000b0038482a47e7eso576331wmh.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 05:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Du9bGCJyeYUBZfdICrU8RSrBiIwvIrsG9nwUtijwSEs=;
 b=e3BmyyXMZu3a2YCa9fhJYlnIXQMqDo+kc0tweL+VsUhjn+gO2iniaGEyFimY5F4xT3
 qTYsa4D3PtmQbNwOJCVVNxMxZ3F6Yns/YhMTfGG9Tz2rjc83iIm1AD8BCpJ6cw9A+thB
 nEhVMjQQdjB6q06DW4OcYrUbyu9GP8+z3cjjj5OmohS25/n6pyZ8EQutyWh9CFv65gwP
 ZDhpayc2Zofp07ZOlD7sVoAiHKoQ3M2dtuxrnaNpNj1jEjq0nWsTsGouMObab/Xtn1t1
 uYcEbPKiSXinEKyW9ULfyLUyif3vsRPOGagiFGd+8HPHuVLPG2K9qqIO13fAYaMlQsO9
 UFuQ==
X-Gm-Message-State: AOAM531g3BtaCe2SDWhUdXuKTTDxSP0wBn6Cdn4UwVQhXMJDgm1r3ggE
 tA4VFPlXQj6tpBjKHlHdW6/PKNJCt4ykbH7z4yGGzIUlQOv9GNwj4jUouJHHW6LVWJVrc8XOwZQ
 yCo1GAMAQoNYwz+yQ9OtABDpSOkdNtCP0h1tGVzOzGg==
X-Received: by 2002:a05:600c:252:b0:381:3461:1c64 with SMTP id
 18-20020a05600c025200b0038134611c64mr21144419wmj.94.1646226930028; 
 Wed, 02 Mar 2022 05:15:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZJmM2k8Z2gkRZ6tQ2eyXfqvnd5MRyL0aZPeaUpRONJZZWaNLdaPzAsWX9cAQOFDBaEdSYZw==
X-Received: by 2002:a05:600c:252:b0:381:3461:1c64 with SMTP id
 18-20020a05600c025200b0038134611c64mr21144400wmj.94.1646226929824; 
 Wed, 02 Mar 2022 05:15:29 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
 by smtp.gmail.com with ESMTPSA id
 f16-20020adff450000000b001f0122f63dbsm5028342wrp.86.2022.03.02.05.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 05:15:28 -0800 (PST)
Date: Wed, 2 Mar 2022 08:15:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Message-ID: <20220302081017-mutt-send-email-mst@kernel.org>
References: <20220228065720.100-1-xieyongji@bytedance.com>
 <20220301104039-mutt-send-email-mst@kernel.org>
 <CACycT3uGFUjmuESUi9=Kkeg4FboVifAHD0D0gPTkEprcTP=x+g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3uGFUjmuESUi9=Kkeg4FboVifAHD0D0gPTkEprcTP=x+g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 linux-block@vger.kernel.org,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, Mar 02, 2022 at 06:46:03PM +0800, Yongji Xie wrote:
> On Tue, Mar 1, 2022 at 11:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
> > > Currently we have a BUG_ON() to make sure the number of sg
> > > list does not exceed queue_max_segments() in virtio_queue_rq().
> > > However, the block layer uses queue_max_discard_segments()
> > > instead of queue_max_segments() to limit the sg list for
> > > discard requests. So the BUG_ON() might be triggered if
> > > virtio-blk device reports a larger value for max discard
> > > segment than queue_max_segments().
> >
> > Hmm the spec does not say what should happen if max_discard_seg
> > exceeds seg_max. Is this the config you have in mind? how do you
> > create it?
> >
> 
> One example: the device doesn't specify the value of max_discard_seg
> in the config space, then the virtio-blk driver will use
> MAX_DISCARD_SEGMENTS (256) by default. Then we're able to trigger the
> BUG_ON() if the seg_max is less than 256.
> 
> While the spec didn't say what should happen if max_discard_seg
> exceeds seg_max, it also doesn't explicitly prohibit this
> configuration. So I think we should at least not panic the kernel in
> this case.
> 
> Thanks,
> Yongji

Oh that last one sounds like a bug, I think it should be
min(MAX_DISCARD_SEGMENTS, seg_max)

When max_discard_seg and seg_max both exist, that's a different question. We can
- do min(max_discard_seg, seg_max)
- fail probe
- clear the relevant feature flag

I feel we need a better plan than submitting an invalid request to device.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
