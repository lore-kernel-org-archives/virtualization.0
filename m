Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CD2C7EE24
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 21:45:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92BFF813EF;
	Mon,  5 Jun 2023 21:45:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 92BFF813EF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PC2MjuDJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xko9PdyfZncw; Mon,  5 Jun 2023 21:45:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0DAEC813E9;
	Mon,  5 Jun 2023 21:45:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0DAEC813E9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF2C5C007A;
	Mon,  5 Jun 2023 21:45:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9C6CC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 21:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ADD13813EF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 21:45:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ADD13813EF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f1BnDOYqiLdE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 21:44:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B9AF813E9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B9AF813E9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 21:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686001497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WpKIMI7QM/wVRTxo2f7IQpPSM5zVOF2jBBbDgfwLd/0=;
 b=PC2MjuDJ0X6p3EDliUsdGz0RXtNxmjXIsgwnCob7+pNm5RNfwi9wzNNEO71mVksSeibCj7
 DYVRjUgqTTwz2afGclyxYWrmkk9rU1aH0HayCqJMY4PGaOPXJMVdpHywweK4Pdu+wJri2g
 XIN45RnlgNp4TA9v8mCEN4or6OctXJs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-gleLJJDyMuilzLsS8oRggA-1; Mon, 05 Jun 2023 17:44:56 -0400
X-MC-Unique: gleLJJDyMuilzLsS8oRggA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f6038dc351so22932335e9.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jun 2023 14:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686001495; x=1688593495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WpKIMI7QM/wVRTxo2f7IQpPSM5zVOF2jBBbDgfwLd/0=;
 b=H+U05wphd4rhFAmV1K31m28x+AVRI1ot0heABfkImhnTu/9O2i/yQsShbydezpFdX+
 FLIdYiLJXRZ3vUnVojKEG3t2/UUIIcB0+cyTEIcqfjlPzTkazDk/SCgBvRmba99E8wWq
 NCGq/9LbysDEUoTS1fbmuALpaslNRrZDU7LcNojOHEf7MPjnNIzHET7LcAjuOJgBpqYa
 pwjemRzaRQ13PnozRqN5GHVu+sm9grna7O6b2o4FcKeFfWzCPdi5G0Zajjqanmhh3tRG
 6qZQvQ0+0YZycC6R6caZjaDqaAiiXFGXyIkdrRyAVfLOaUd8Rh//iVvDtYBSuCrfCCxT
 iVYg==
X-Gm-Message-State: AC+VfDzksHBS8BGpCTwZZwa/UJs5cqud3cfjqQxiMQ3oZk88QTU1hV5X
 R2JJzKfXdE2JcA/crBVyvum2i9BbGYTLanNADg1xRc6Hvae14RFOzKjE9tQy9pdArmJgO1NNH1w
 ZbqeGuyNPc5IGkTePuHBDBII0b0+AgaWx4pYl3f1QSg==
X-Received: by 2002:a7b:c40f:0:b0:3f7:5e08:7a04 with SMTP id
 k15-20020a7bc40f000000b003f75e087a04mr324442wmi.25.1686001495373; 
 Mon, 05 Jun 2023 14:44:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4u8Ic/y4eCXxAW8Bpwr/2TMDw54kNLZMenywFlEZSHsc+nxVJwRBB1hWlaJzPhaz3ai/scQA==
X-Received: by 2002:a7b:c40f:0:b0:3f7:5e08:7a04 with SMTP id
 k15-20020a7bc40f000000b003f75e087a04mr324432wmi.25.1686001495049; 
 Mon, 05 Jun 2023 14:44:55 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 b14-20020a5d40ce000000b002e5ff05765esm10931997wrq.73.2023.06.05.14.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 14:44:54 -0700 (PDT)
Date: Mon, 5 Jun 2023 17:44:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <20230605173958-mutt-send-email-mst@kernel.org>
References: <20230605110644.151211-1-sgarzare@redhat.com>
 <20230605084104-mutt-send-email-mst@kernel.org>
 <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
 <20230605085840-mutt-send-email-mst@kernel.org>
 <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
 <20230605095404-mutt-send-email-mst@kernel.org>
 <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
MIME-Version: 1.0
In-Reply-To: <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
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

On Mon, Jun 05, 2023 at 04:56:37PM +0200, Stefano Garzarella wrote:
> On Mon, Jun 05, 2023 at 09:54:57AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jun 05, 2023 at 03:30:35PM +0200, Stefano Garzarella wrote:
> > > On Mon, Jun 05, 2023 at 09:00:25AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Jun 05, 2023 at 02:54:20PM +0200, Stefano Garzarella wrote:
> > > > > On Mon, Jun 05, 2023 at 08:41:54AM -0400, Michael S. Tsirkin wrote:
> > > > > > On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Garzarella wrote:
> > > > > > > vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE)
> > > > > > > don't support packed virtqueue well yet, so let's filter the
> > > > > > > VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_features().
> > > > > > >
> > > > > > > This way, even if the device supports it, we don't risk it being
> > > > > > > negotiated, then the VMM is unable to set the vring state properly.
> > > > > > >
> > > > > > > Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > > > > ---
> > > > > > >
> > > > > > > Notes:
> > > > > > >     This patch should be applied before the "[PATCH v2 0/3] vhost_vdpa:
> > > > > > >     better PACKED support" series [1] and backported in stable branches.
> > > > > > >
> > > > > > >     We can revert it when we are sure that everything is working with
> > > > > > >     packed virtqueues.
> > > > > > >
> > > > > > >     Thanks,
> > > > > > >     Stefano
> > > > > > >
> > > > > > >     [1] https://lore.kernel.org/virtualization/20230424225031.18947-1-shannon.nelson@amd.com/
> > > > > >
> > > > > > I'm a bit lost here. So why am I merging "better PACKED support" then?
> > > > >
> > > > > To really support packed virtqueue with vhost-vdpa, at that point we would
> > > > > also have to revert this patch.
> > > > >
> > > > > I wasn't sure if you wanted to queue the series for this merge window.
> > > > > In that case do you think it is better to send this patch only for stable
> > > > > branches?
> > > > > > Does this patch make them a NOP?
> > > > >
> > > > > Yep, after applying the "better PACKED support" series and being
> > > > > sure that
> > > > > the IOCTLs of vhost-vdpa support packed virtqueue, we should revert this
> > > > > patch.
> > > > >
> > > > > Let me know if you prefer a different approach.
> > > > >
> > > > > I'm concerned that QEMU uses vhost-vdpa IOCTLs thinking that the kernel
> > > > > interprets them the right way, when it does not.
> > > > >
> > > > > Thanks,
> > > > > Stefano
> > > > >
> > > >
> > > > If this fixes a bug can you add Fixes tags to each of them? Then it's ok
> > > > to merge in this window. Probably easier than the elaborate
> > > > mask/unmask dance.
> > > 
> > > CCing Shannon (the original author of the "better PACKED support"
> > > series).
> > > 
> > > IIUC Shannon is going to send a v3 of that series to fix the
> > > documentation, so Shannon can you also add the Fixes tags?
> > > 
> > > Thanks,
> > > Stefano
> > 
> > Well this is in my tree already. Just reply with
> > Fixes: <>
> > to each and I will add these tags.
> 
> I tried, but it is not easy since we added the support for packed virtqueue
> in vdpa and vhost incrementally.
> 
> Initially I was thinking of adding the same tag used here:
> 
> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> 
> Then I discovered that vq_state wasn't there, so I was thinking of
> 
> Fixes: 530a5678bc00 ("vdpa: support packed virtqueue for set/get_vq_state()")
> 
> So we would have to backport quite a few patches into the stable branches.
> I don't know if it's worth it...
> 
> I still think it is better to disable packed in the stable branches,
> otherwise I have to make a list of all the patches we need.
> 
> Any other ideas?
> 
> Thanks,
> Stefano

OK so. You want me to apply this one now, and fixes in the next
kernel?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
