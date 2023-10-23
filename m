Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74123CDB474
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 11:17:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E88FE41FE4;
	Mon, 23 Oct 2023 11:17:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E88FE41FE4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LBtLWdrI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SmjN4ShBaWKA; Mon, 23 Oct 2023 11:17:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6C74841FE3;
	Mon, 23 Oct 2023 11:17:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C74841FE3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35BA9C0039;
	Mon, 23 Oct 2023 11:17:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 819BDC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 11:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47C91411A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 11:17:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47C91411A6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LBtLWdrI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sOh__gxj-l-A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 11:17:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37B4B41020
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 11:17:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37B4B41020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698059862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FRvwFPWkQbIxAzQKKTcIQ5FvgRLAZ9CwY2jeSsJtJyI=;
 b=LBtLWdrI4RawVrrk+ub05TqO0i11YDOVmU/EKm7z+Dp93cZUTjU324gktceDZTE5ppbNUW
 cjHRXCJOFJJXPMnFWtvBGvg10aDZOisOP4TA2NA/qah8DbbUE+lRvRbg+I6z7WJnpyWChN
 c4zVSrY1RNbrgNtU9qhAtVFbmeuH2TY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-dHV6nQ3jPOC7HaQegG_eBw-1; Mon, 23 Oct 2023 07:17:40 -0400
X-MC-Unique: dHV6nQ3jPOC7HaQegG_eBw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32d83fd3765so1375250f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 04:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698059859; x=1698664659;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRvwFPWkQbIxAzQKKTcIQ5FvgRLAZ9CwY2jeSsJtJyI=;
 b=QbDlqeEI2H7ER/sS2Z4EZRtfRisNugO2/1WLlQic7MQZgIla2fY9sDclDm/6KK65h2
 0rhvZMAdukknLTi7Q0AVrPeTBhdaUIrxfXMMFy1vMydp7zL0JdmFW+NydixmWxV0hyC7
 tU8UCzfmckfjXOrAm4C9rYwHmk2OYKBrqb4yMAAjaN3uhFZuwVdVrSGyjbdNipvFSt5j
 zEeXU+A0rGEXIuEnotnI5iKos4x6LaiEGX1hgMUvxh0MYpqpJCul5X2TTEVnm9q7/4Sn
 8/wpvOs6A4Mde9j1Hnxz2MDEwfdbFdAsRd6fpOzZCJsOM5POVPUyUYsthadAat4LWdA5
 +yBQ==
X-Gm-Message-State: AOJu0YyinuCloYRYPM0hym8C4H3xFNts1LAjRXcrg6Bu6IyaDegoknGV
 JyaR5WXznTCB3fT3vSp1zhYu8oBS9UcExTnh7N+LPrht7GtAJKmMCjPPcSpCAUwI5rJkkNQ9mQ4
 12tueqZVxTGrQ0bIz3Zeb409X7kEp9Z5XLK9e2NHinA==
X-Received: by 2002:adf:e5c8:0:b0:32d:6891:f819 with SMTP id
 a8-20020adfe5c8000000b0032d6891f819mr6249179wrn.41.1698059859678; 
 Mon, 23 Oct 2023 04:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3YM+O+5Ir2R/imQr9O2Lyuez5zl/LJuvoKLWz1oCP1WKa/8vgH0KWzIiS0y5qulyw5jOYDA==
X-Received: by 2002:adf:e5c8:0:b0:32d:6891:f819 with SMTP id
 a8-20020adfe5c8000000b0032d6891f819mr6249168wrn.41.1698059859310; 
 Mon, 23 Oct 2023 04:17:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:e88f:2c2c:db43:583d:d30e])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a5d4151000000b0032d87b13240sm7629863wrq.73.2023.10.23.04.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 04:17:38 -0700 (PDT)
Date: Mon, 23 Oct 2023 07:17:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Message-ID: <20231023071548-mutt-send-email-mst@kernel.org>
References: <20231020054140-mutt-send-email-mst@kernel.org>
 <1697795422.0986886-1-xuanzhuo@linux.alibaba.com>
 <20231020055943-mutt-send-email-mst@kernel.org>
 <1698028017.8052797-1-xuanzhuo@linux.alibaba.com>
 <d4aa3f76-3e08-a852-a948-b88226a37fdd@nfschina.com>
 <1698029596.5404413-3-xuanzhuo@linux.alibaba.com>
 <46aee820-6c01-ed8a-613b-5c57258d749e@nfschina.com>
 <1698040004.5365264-4-xuanzhuo@linux.alibaba.com>
 <6a7d1006-0988-77ea-0991-9c7b422d78e1@nfschina.com>
 <1698054722.2894735-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1698054722.2894735-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
 Su Hui <suhui@nfschina.com>, linux-kernel@vger.kernel.org
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

On Mon, Oct 23, 2023 at 05:52:02PM +0800, Xuan Zhuo wrote:
> On Mon, 23 Oct 2023 17:50:46 +0800, Su Hui <suhui@nfschina.com> wrote:
> > On 2023/10/23 13:46, Xuan Zhuo wrote:
> > >>>>>>>> Well, what are the cases where it can happen practically?
> > >>>>>>> Device error. Such as vp_active_vq()
> > >>>>>>>
> > >>>>>>> Thanks.
> > >>>>>> Hmm interesting. OK. But do callers know to recover?
> > >>>>> No.
> > >>>>>
> > >>>>> So I think WARN + broken is suitable.
> > >>>>>
> > >>>>> Thanks.
> > >>>> Sorry for the late, is the following code okay?
> > >>>>
> > >>>> @@ -2739,7 +2739,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > >>>>                         void (*recycle)(struct virtqueue *vq, void *buf))
> > >>>>     {
> > >>>>            struct vring_virtqueue *vq = to_vvq(_vq);
> > >>>> -       int err;
> > >>>> +       int err, err_reset;
> > >>>>
> > >>>>            if (num > vq->vq.num_max)
> > >>>>                    return -E2BIG;
> > >>>> @@ -2759,7 +2759,15 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > >>>>            else
> > >>>>                    err = virtqueue_resize_split(_vq, num);
> > >>>>
> > >>>> -       return virtqueue_enable_after_reset(_vq);
> > >>>> +       err_reset = virtqueue_enable_after_reset(_vq);
> > >>>> +
> > >>>> +       if (err) {
> > >>> No err.
> > >>>
> > >>> err is not important.
> > >>> You can remove that.
> > >> Emm, I'm a little confused that which code should I remove ?
> > >>
> > >>
> > >> like this:
> > >> 	if (vq->packed_ring)
> > >> 		virtqueue_resize_packed(_vq, num);
> > >> 	else
> > >> 		virtqueue_resize_split(_vq, num);
> > >>
> > >> And we should set broken and warn inside virtqueue_enable_after_reset()?
> >
> > In my opinion, we should return the error code of virtqueue_resize_packed() / virtqueue_resize_split().
> > But if this err is not important, this patch makes no sense.
> > Maybe I misunderstand somewhere...
> > If you think it's worth sending a patch, you can send it :).(I'm not familiar with this code).
> 
> OK.
> 
> Thanks.

I would first try to recover by re-enabling.
If that fails we can set broken.


> 
> >
> > Thanks,
> > Su Hui
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
