Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADA9C4332F
	for <virtualization@archiver.kernel.org>; Tue, 13 Dec 2022 06:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41D6081DCB;
	Tue, 13 Dec 2022 06:23:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 41D6081DCB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TEUcTCe6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WbhlDzs2H7oU; Tue, 13 Dec 2022 06:23:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AAE2B81D5F;
	Tue, 13 Dec 2022 06:23:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AAE2B81D5F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B058C0032;
	Tue, 13 Dec 2022 06:23:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96457C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 06:23:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4D8E5416C2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 06:23:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D8E5416C2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TEUcTCe6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vns17Prm9JFo
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 06:23:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 334E24163D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 334E24163D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 06:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670912629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zdosc0+4UprGU1f9HW8VSDzkH/4Gm3wZqjmhjmwHaoc=;
 b=TEUcTCe6Dy4qlCXRrmfnFldFoBtD1Emh8sDSHp9/bdvFgHouBzdqlGwofAYhvvKfaASv1C
 DUfyNSIT5k6lWEvE3yrO33silByTchh5GdpcxVktbtfqPa9/yITZkTbkHnd8/rzgZloCuV
 vl/rnrq+IT6Y3JswMxCqsc2FqXyHORI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-361-EyIWT6IZOxG0rHgcNmopcQ-1; Tue, 13 Dec 2022 01:23:48 -0500
X-MC-Unique: EyIWT6IZOxG0rHgcNmopcQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 9-20020a1c0209000000b003d1c0a147f6so5178188wmc.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 22:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zdosc0+4UprGU1f9HW8VSDzkH/4Gm3wZqjmhjmwHaoc=;
 b=vXl0P5mVhDTu2AuiTaiBjAO5X607yx6NBo3PPsbBoCQYqM8TOBz/vVTwSlN5DV3n/4
 7R0KN3UZxynOj+T6Je4Olxp1rKJoIEqESmsCj8QeJcicuxzcopt+lbObrr/n8Pmn150K
 xoJ9KHXwX0ibeoEUtSqIkA/T/tMcC+KU/Onksq61R+ByVs3MCFKxvhwjhlcbcBW3Gntx
 vUxk+KMIM6/Nxxtw+x7rfKBrwmWolo3YH1Wzz+tYPPOVS4+3a1oV70Rzs+5EuRtS15fO
 y8kHIwUNWnUI6N8KbjZPRD0UGksl9m7ahknFhUzj0UVUnGuMhbT/9nysl2UWu833T/Fy
 wN6Q==
X-Gm-Message-State: ANoB5pmVoddEx1ACstpKrRvEjw9zd8Rny6M/GWtGJK5CVB50Onn8Tn62
 Ebf+0lvWe+d7c/cOXlPxBFq/gv/51OPiBncmv3bGhNoSB/dj/CULT0tAvlxtwejynBtnBfP2FtB
 5zTkZ9ZpFSTGo/K2ndxlcicDUEk/8ouKlpU5uoIh4xg==
X-Received: by 2002:a5d:4b0b:0:b0:241:f8b6:9693 with SMTP id
 v11-20020a5d4b0b000000b00241f8b69693mr10657859wrq.37.1670912627219; 
 Mon, 12 Dec 2022 22:23:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4I9L5F8Y2mNHOKhXS0GG3uRTSVP0X4b9ULK97I3031/HbGTKYGoQr9e4elbaLdVkvuI9TpMQ==
X-Received: by 2002:a5d:4b0b:0:b0:241:f8b6:9693 with SMTP id
 v11-20020a5d4b0b000000b00241f8b69693mr10657848wrq.37.1670912626982; 
 Mon, 12 Dec 2022 22:23:46 -0800 (PST)
Received: from redhat.com ([2.52.138.183]) by smtp.gmail.com with ESMTPSA id
 q4-20020adffec4000000b00241c6729c2bsm10574835wrs.26.2022.12.12.22.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Dec 2022 22:23:46 -0800 (PST)
Date: Tue, 13 Dec 2022 01:23:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221213001034-mutt-send-email-mst@kernel.org>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <Y5BCQ/9/uhXdu35W@infradead.org>
 <20221207052001-mutt-send-email-mst@kernel.org>
 <Y5C/4H7Ettg/DcRz@infradead.org>
 <20221207152116-mutt-send-email-mst@kernel.org>
 <ccb5388d-4976-31a3-0559-e94c14c90573@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <ccb5388d-4976-31a3-0559-e94c14c90573@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

On Tue, Dec 13, 2022 at 04:58:47AM +0000, Chaitanya Kulkarni wrote:
> Michael,
> 
> On 12/7/22 12:28, Michael S. Tsirkin wrote:
> > On Wed, Dec 07, 2022 at 08:31:28AM -0800, Christoph Hellwig wrote:
> >> On Wed, Dec 07, 2022 at 05:21:48AM -0500, Michael S. Tsirkin wrote:
> >>> Christoph you acked the spec patch adding this to virtio blk:
> >>>
> >>> 	Still not a fan of the encoding, but at least it is properly documented
> >>> 	now:
> >>>
> >>> 	Acked-by: Christoph Hellwig <hch@lst.de>
> >>>
> >>> Did you change your mind then? Or do you prefer a different encoding for
> >>> the ioctl then? could you help sugesting what kind?
> >>
> >> Well, it is good enough documented for a spec.  I don't think it is
> >> a useful feature for Linux where virtio-blk is our minimum viable
> >> paravirtualized block driver.
> > 
> > No idea what this means, sorry.  Now that's in the spec I expect (some)
> > devices to implement it and if they do I see no reason not to expose the
> > data to userspace.
> > 
> 
> Even if any device implements is it can always use passthru commands.
> See below for more info...
> 
> > Alvaro could you pls explain the use-case? Christoph has doubts that
> > it's useful. Do you have a device implementing this?
> > 
> 
>  From what I know, virtio-blk should be kept minimal and should not
> add any storage specific IOCTLs or features that will end up loosing
> its generic nature.
> 
> The IOCTL we are trying to add is Flash storage specific which
> goes against the nature of generic storage and makes it non-generic.
> In case we approve this it will open the door for non-generic
> code/IOCTL in the virtio-blk and that needs to be avoided.

Wrt these fields that horse has bolted, it's in the spec.

> For any storage specific features or IOCTL (flash/HDD) it should
> be using it's own frontend such as virtio-scsi or e.g. nvme and
> not virtio-blk.
> 
> Hope this helps.
> 
> -ck

I don't understand what you are suggesting, sorry. It's a hardware
device. It can't just "switch to a different frontend".

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
