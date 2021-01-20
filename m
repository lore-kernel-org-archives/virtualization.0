Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F63C433E0
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 11:03:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334082250F
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 11:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334082250F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BAA5784CA5;
	Wed, 20 Jan 2021 11:03:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XYLSG14dKOb5; Wed, 20 Jan 2021 11:03:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 441F984D09;
	Wed, 20 Jan 2021 11:03:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FE31C08A1;
	Wed, 20 Jan 2021 11:03:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE8B9C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 11:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C7F4E84D09
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 11:03:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dBHSFg6ptf40
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 11:03:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2D09684CA5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 11:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611140614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IgKWadVO4IhTvmcLY56retKTp5qCTT4hdx8ojgzPM6c=;
 b=FBCaGJ+9HeMb/6QsrEJB4/VYFXoFfaBVKGfqVsCBDuGzHKmMI3ysMitKkAq3czc+T4uiEO
 aun7ikf2gexJKafbY4ofsSutl1pn0XspQy2ol+jnnWpxCIkKpVV/EvaFeBsNSAiKlxGKBF
 HwJXI+TMNoidb+S/4mFjip6Z9Nkf6Hg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-TARKrKKdNIe9m0ol0Uw24g-1; Wed, 20 Jan 2021 06:03:32 -0500
X-MC-Unique: TARKrKKdNIe9m0ol0Uw24g-1
Received: by mail-wr1-f70.google.com with SMTP id q2so11262894wrp.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:03:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IgKWadVO4IhTvmcLY56retKTp5qCTT4hdx8ojgzPM6c=;
 b=BmSy2Qm8GDHmQmaxySoaQjkJMj5cpxtaao3pNCMRRCYyia5okiIufn8RsdSbOPAQeO
 ail/z8BpTHyFNgwRUY3yIrqg7ZREAbfuvzVpS/GEZ0dYd4ob03ngO4oEJbJc2yLDvZC2
 Ag+tYQ8wXwM1bUOaN7UFTsKhbdjlqunH81w/4g8oocLomxp2fq1SD7DEDbTRkZLo1Qoi
 9PA3TSXH9WWviqJPCZqZY8YDhWUSnkKmouGWnzI4Azcs1E6waXys53/IoPpY/tpKrk2t
 64azEpd3I13Egxu6AOkNF1byGVEGKedPLHW/e24vbdleBqOJmZzh3Er9D1ZlhOol7DIz
 2+hQ==
X-Gm-Message-State: AOAM530NgnQvB+RaTtW/qCpvng4289+T6gMV8rvbulqs62fa7ocrApFD
 g9I/gXtIeb6AiwCxREhBqzdr7+7MrSfj/Zx7SG/Spv+mVhAnqqLki5wH5jGTAw7kMaIeSk0EFap
 PaTsF9RNhJapNjapkwxvWjvMeajQwXhrVM1QJVRmD9g==
X-Received: by 2002:a5d:4902:: with SMTP id x2mr8612005wrq.272.1611140610905; 
 Wed, 20 Jan 2021 03:03:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwywLoNdtS4lCyWc3ZmurPe1dJfsEyxg1TTUlkT27LGHLKaXnUgjJOjYxEkBqAW7+WZS9nbEg==
X-Received: by 2002:a5d:4902:: with SMTP id x2mr8611973wrq.272.1611140610655; 
 Wed, 20 Jan 2021 03:03:30 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id g12sm3393102wmh.14.2021.01.20.03.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jan 2021 03:03:29 -0800 (PST)
Date: Wed, 20 Jan 2021 06:03:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] virtio-mem: Assign boolean values to a bool variable
Message-ID: <20210120060301-mutt-send-email-mst@kernel.org>
References: <1611129031-82818-1-git-send-email-abaci-bugfix@linux.alibaba.com>
 <81a1817d-a1f5-dfca-550c-3e3f62cf3a9d@redhat.com>
 <20210120045736-mutt-send-email-mst@kernel.org>
 <da2cb3fb-0ea5-5afd-afb5-a9e7f474e148@redhat.com>
MIME-Version: 1.0
In-Reply-To: <da2cb3fb-0ea5-5afd-afb5-a9e7f474e148@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Tian Tao <tiantao6@hisilicon.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
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

On Wed, Jan 20, 2021 at 11:04:18AM +0100, David Hildenbrand wrote:
> On 20.01.21 10:57, Michael S. Tsirkin wrote:
> > On Wed, Jan 20, 2021 at 10:40:37AM +0100, David Hildenbrand wrote:
> >> On 20.01.21 08:50, Jiapeng Zhong wrote:
> >>> Fix the following coccicheck warnings:
> >>>
> >>> ./drivers/virtio/virtio_mem.c:2580:2-25: WARNING: Assignment
> >>> of 0/1 to bool variable.
> >>>
> >>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> >>> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
> >>> ---
> >>>  drivers/virtio/virtio_mem.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> >>> index 9fc9ec4..85a272c 100644
> >>> --- a/drivers/virtio/virtio_mem.c
> >>> +++ b/drivers/virtio/virtio_mem.c
> >>> @@ -2577,7 +2577,7 @@ static int virtio_mem_probe(struct virtio_device *vdev)
> >>>  	 * actually in use (e.g., trying to reload the driver).
> >>>  	 */
> >>>  	if (vm->plugged_size) {
> >>> -		vm->unplug_all_required = 1;
> >>> +		vm->unplug_all_required = true;
> >>>  		dev_info(&vm->vdev->dev, "unplugging all memory is required\n");
> >>>  	}
> >>>  
> >>>
> >>
> >> Hi,
> >>
> >> we already had a fix on the list for quite a while:
> >>
> >> https://lkml.kernel.org/r/1609233239-60313-1-git-send-email-tiantao6@hisilicon.com
> > 
> > Can't find that one.
> 
> Looks like it was only on virtualization@ and a couple of people on cc.
> 
> https://lists.linuxfoundation.org/pipermail/virtualization/2020-December/051662.html
> 
> Interestingly, I cannot find the follow-up ("[PATCH] virtio-mem: use
> boolean value when setting vm->unplug_all_required") in the mailing list
> archives, even though it has virtualization@ on cc.


Unsurprising that I didn't merge it then ;)
Want to send your ack on this one?

> -- 
> Thanks,
> 
> David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
