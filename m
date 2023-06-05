Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CE2C77B73
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 13:00:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 186E360FA1;
	Mon,  5 Jun 2023 13:00:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 186E360FA1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PaDyhoi5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8RC5Ci3l2gME; Mon,  5 Jun 2023 13:00:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 86FA760F85;
	Mon,  5 Jun 2023 13:00:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 86FA760F85
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AFA1C0037;
	Mon,  5 Jun 2023 13:00:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF235C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:00:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA3F360F8D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:00:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA3F360F8D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GD12Qd1tMtQP
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:00:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A4A1060F76
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A4A1060F76
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685970033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bbubscZftjyRYYL2p4m/teVFWDkt0vBAkgkuXdu/w1E=;
 b=PaDyhoi5M2Wybz2aXAWRKa6Qow24lnGuV4raeaysBnOTf3r9uIHRze36Qw4RNK5QjOe64i
 FuhYZqZVXzL/QkIQySHwdHiTYzlBI8oPRyvovHUs/GMiAQb16luScqGGHI0E5eB/Kz8dNl
 FjalMmXDHQeU9usi0YDviduEOZ0+6oA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-Np4asaTLNdGwpbXplRKPlg-1; Mon, 05 Jun 2023 09:00:30 -0400
X-MC-Unique: Np4asaTLNdGwpbXplRKPlg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30c5d31b567so1524324f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jun 2023 06:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685970030; x=1688562030;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbubscZftjyRYYL2p4m/teVFWDkt0vBAkgkuXdu/w1E=;
 b=GLGHpgvZVfcbLQSqmUc8Cpp9imYhDBPs61A7HPJ0Q500+R+m2fLeW6HtAs9xkMOOqT
 +upxJwpy9a69NmwBdiO39ya/AEIBdTO4fxCzGCil3oMpObTxEdWaIIjnv05HPWw8eGPo
 x+mWTuRzpmHzCsGMjPaVW0MU+Ri9agYffmIAEVDD9sQYlPY62XUvX/rA8a8p+Qf60nY7
 x1GHJOvMxsWC93LHjWsmaJe+xusbc4wXNAzTfehPdZW+H3fC6KxFw+QnN0dkNizmxUHv
 hRvRxsgE9fRBRPEqxSLVsXEA2hdHbnuDc8R5fD8Od0INZIqjTga6QD7wl6wtb6XWaETO
 q41Q==
X-Gm-Message-State: AC+VfDwE+fFmvOXeZBqv3InJIS44shlNcGbWZ6NMy6h/SnSPFTcp8bOF
 CYHS0UQXjugOt9yEBonYHHmCiPY06VIwrFQlixzI2r6z4qxzs8zLmQdx7Po1M4FceIa1NwxgmtV
 MWJfgcDZkOR+MAk8HC5Hk1/XTupKcEK95IGSI5VslAA==
X-Received: by 2002:a5d:4d4a:0:b0:30a:f1dd:dc55 with SMTP id
 a10-20020a5d4d4a000000b0030af1dddc55mr3686138wru.53.1685970029830; 
 Mon, 05 Jun 2023 06:00:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6DD3cwjpmZBvtInHDuWJuM4v9sDwnhYfReDafcIwBsT4j0UbFV+PmO399VIFuafC8KUQM2Tg==
X-Received: by 2002:a5d:4d4a:0:b0:30a:f1dd:dc55 with SMTP id
 a10-20020a5d4d4a000000b0030af1dddc55mr3686125wru.53.1685970029458; 
 Mon, 05 Jun 2023 06:00:29 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 p6-20020a056000018600b0030aefd11892sm9708331wrx.41.2023.06.05.06.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 06:00:28 -0700 (PDT)
Date: Mon, 5 Jun 2023 09:00:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <20230605085840-mutt-send-email-mst@kernel.org>
References: <20230605110644.151211-1-sgarzare@redhat.com>
 <20230605084104-mutt-send-email-mst@kernel.org>
 <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
MIME-Version: 1.0
In-Reply-To: <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
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

On Mon, Jun 05, 2023 at 02:54:20PM +0200, Stefano Garzarella wrote:
> On Mon, Jun 05, 2023 at 08:41:54AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Garzarella wrote:
> > > vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE)
> > > don't support packed virtqueue well yet, so let's filter the
> > > VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_features().
> > > 
> > > This way, even if the device supports it, we don't risk it being
> > > negotiated, then the VMM is unable to set the vring state properly.
> > > 
> > > Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > > 
> > > Notes:
> > >     This patch should be applied before the "[PATCH v2 0/3] vhost_vdpa:
> > >     better PACKED support" series [1] and backported in stable branches.
> > > 
> > >     We can revert it when we are sure that everything is working with
> > >     packed virtqueues.
> > > 
> > >     Thanks,
> > >     Stefano
> > > 
> > >     [1] https://lore.kernel.org/virtualization/20230424225031.18947-1-shannon.nelson@amd.com/
> > 
> > I'm a bit lost here. So why am I merging "better PACKED support" then?
> 
> To really support packed virtqueue with vhost-vdpa, at that point we would
> also have to revert this patch.
> 
> I wasn't sure if you wanted to queue the series for this merge window.
> In that case do you think it is better to send this patch only for stable
> branches?
> > Does this patch make them a NOP?
> 
> Yep, after applying the "better PACKED support" series and being sure that
> the IOCTLs of vhost-vdpa support packed virtqueue, we should revert this
> patch.
> 
> Let me know if you prefer a different approach.
> 
> I'm concerned that QEMU uses vhost-vdpa IOCTLs thinking that the kernel
> interprets them the right way, when it does not.
> 
> Thanks,
> Stefano
> 

If this fixes a bug can you add Fixes tags to each of them? Then it's ok
to merge in this window. Probably easier than the elaborate
mask/unmask dance.

> > 
> > >  drivers/vhost/vdpa.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index 8c1aefc865f0..ac2152135b23 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -397,6 +397,12 @@ static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
> > > 
> > >  	features = ops->get_device_features(vdpa);
> > > 
> > > +	/*
> > > +	 * IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE) don't support
> > > +	 * packed virtqueue well yet, so let's filter the feature for now.
> > > +	 */
> > > +	features &= ~BIT_ULL(VIRTIO_F_RING_PACKED);
> > > +
> > >  	if (copy_to_user(featurep, &features, sizeof(features)))
> > >  		return -EFAULT;
> > > 
> > > 
> > > base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
> > > --
> > > 2.40.1
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
