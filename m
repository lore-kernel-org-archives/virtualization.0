Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BB7C7EE25
	for <virtualization@archiver.kernel.org>; Wed,  7 Jun 2023 20:53:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57CCD83388;
	Wed,  7 Jun 2023 20:53:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57CCD83388
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HYqQy44y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1tAqg9DtNXFl; Wed,  7 Jun 2023 20:53:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D2CCF833CA;
	Wed,  7 Jun 2023 20:53:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D2CCF833CA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A65CAC007A;
	Wed,  7 Jun 2023 20:53:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8098C0029
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 20:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8FFBF41142
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 20:53:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8FFBF41142
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HYqQy44y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7SSY-V5-zSCu
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 20:53:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 79A7E40558
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 79A7E40558
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 20:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686171186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ft5xiF/Ta3lHBxFgPgTJpXvjBg2+fN90ep4jurEd3BE=;
 b=HYqQy44yTPd3obRjQyvQ1G+KTMKa+urRv5HDgEHRyAon4tgJOutOfKwPwK2u0CNPUvzvgA
 rLRijb9uTD2XAo7yCCQVqD1ma1E5sRP+GQwppbo8rvrs4Z9gJq2WMzIyaCYpRDLshBAIXZ
 Km1iFlYHez6OxPooWWK6QDMUqT7usnU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-Cj7BiKFEMFa6fw-VyOy08g-1; Wed, 07 Jun 2023 16:53:05 -0400
X-MC-Unique: Cj7BiKFEMFa6fw-VyOy08g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30793c16c78so10694575f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Jun 2023 13:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686171184; x=1688763184;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ft5xiF/Ta3lHBxFgPgTJpXvjBg2+fN90ep4jurEd3BE=;
 b=Uyi2lv/cbNLQ41UtZE9umV9/HQP6Wj8ZB1XhW7W8vruvxmqedt5kFL5wGiL7vfLU+H
 8hm7PPfqu5i9h//5n646gSuWDSLuF3KHh2rruwSjMgsD3ehkBuxDV5daWtYbdUrpzHKR
 hRlBe6D2YingDwH8eDR75BqyyMq4gYRiHKbYgcUR3sFAJl+1JeDkdY8xY2MRjXX3KbvU
 y9kGRcdeE7v2cOBHw4wA3i79GTzbaDcbiGpfMKpHlCXeqtQfkS9yokrw/N+g8VqIOueo
 PGhWCKLnUBQO/iADrcHuMQOJOdfrr3FLT0pHWe6I62eZsfbqKj1MHkT26Hfw4IGl3FVv
 Y2vg==
X-Gm-Message-State: AC+VfDwcur+SmmZrdyPh6ZTtYQ8b/FciVTz4wmDO27IFC8+7i44Ag+xw
 QRv4KF96LdtA65F26wUHCgWmNYmdYFNS2YoMv/j8dzNcLn+3rwCuWKcaUKYL+sf3BUJp+ZaWTGl
 08CHQKIjfehFQZd/W32Exst/ctHilbZk57jBsxCWSPw==
X-Received: by 2002:a5d:58e7:0:b0:30a:e5b7:a290 with SMTP id
 f7-20020a5d58e7000000b0030ae5b7a290mr5386609wrd.15.1686171184001; 
 Wed, 07 Jun 2023 13:53:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Uq6PcUd+YOTWXVp6ailbjy7D3AfyP/yNhUjsRFNK0FKM+EidonNaUBgJwfcpN5SMVyMEYIw==
X-Received: by 2002:a5d:58e7:0:b0:30a:e5b7:a290 with SMTP id
 f7-20020a5d58e7000000b0030ae5b7a290mr5386597wrd.15.1686171183665; 
 Wed, 07 Jun 2023 13:53:03 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 j10-20020adff54a000000b003047ae72b14sm16389987wrp.82.2023.06.07.13.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 13:53:03 -0700 (PDT)
Date: Wed, 7 Jun 2023 16:52:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <20230607165205-mutt-send-email-mst@kernel.org>
References: <20230605110644.151211-1-sgarzare@redhat.com>
 <20230605084104-mutt-send-email-mst@kernel.org>
 <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
 <20230605085840-mutt-send-email-mst@kernel.org>
 <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
 <20230605095404-mutt-send-email-mst@kernel.org>
 <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
 <20230605173958-mutt-send-email-mst@kernel.org>
 <kpcujul6foyvw66qhy3wck5bzgedka2gzzixupnaog7byr4h45@6ddbvcy32db4>
MIME-Version: 1.0
In-Reply-To: <kpcujul6foyvw66qhy3wck5bzgedka2gzzixupnaog7byr4h45@6ddbvcy32db4>
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

On Tue, Jun 06, 2023 at 12:09:11PM +0200, Stefano Garzarella wrote:
> On Mon, Jun 05, 2023 at 05:44:50PM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jun 05, 2023 at 04:56:37PM +0200, Stefano Garzarella wrote:
> > > On Mon, Jun 05, 2023 at 09:54:57AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Jun 05, 2023 at 03:30:35PM +0200, Stefano Garzarella wrote:
> > > > > On Mon, Jun 05, 2023 at 09:00:25AM -0400, Michael S. Tsirkin wrote:
> > > > > > On Mon, Jun 05, 2023 at 02:54:20PM +0200, Stefano Garzarella wrote:
> > > > > > > On Mon, Jun 05, 2023 at 08:41:54AM -0400, Michael S. Tsirkin wrote:
> > > > > > > > On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Garzarella wrote:
> > > > > > > > > vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE)
> > > > > > > > > don't support packed virtqueue well yet, so let's filter the
> > > > > > > > > VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_features().
> > > > > > > > >
> > > > > > > > > This way, even if the device supports it, we don't risk it being
> > > > > > > > > negotiated, then the VMM is unable to set the vring state properly.
> > > > > > > > >
> > > > > > > > > Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > Notes:
> > > > > > > > >     This patch should be applied before the "[PATCH v2 0/3] vhost_vdpa:
> > > > > > > > >     better PACKED support" series [1] and backported in stable branches.
> > > > > > > > >
> > > > > > > > >     We can revert it when we are sure that everything is working with
> > > > > > > > >     packed virtqueues.
> > > > > > > > >
> > > > > > > > >     Thanks,
> > > > > > > > >     Stefano
> > > > > > > > >
> > > > > > > > >     [1] https://lore.kernel.org/virtualization/20230424225031.18947-1-shannon.nelson@amd.com/
> > > > > > > >
> > > > > > > > I'm a bit lost here. So why am I merging "better PACKED support" then?
> > > > > > >
> > > > > > > To really support packed virtqueue with vhost-vdpa, at that point we would
> > > > > > > also have to revert this patch.
> > > > > > >
> > > > > > > I wasn't sure if you wanted to queue the series for this merge window.
> > > > > > > In that case do you think it is better to send this patch only for stable
> > > > > > > branches?
> > > > > > > > Does this patch make them a NOP?
> > > > > > >
> > > > > > > Yep, after applying the "better PACKED support" series and being
> > > > > > > sure that
> > > > > > > the IOCTLs of vhost-vdpa support packed virtqueue, we should revert this
> > > > > > > patch.
> > > > > > >
> > > > > > > Let me know if you prefer a different approach.
> > > > > > >
> > > > > > > I'm concerned that QEMU uses vhost-vdpa IOCTLs thinking that the kernel
> > > > > > > interprets them the right way, when it does not.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Stefano
> > > > > > >
> > > > > >
> > > > > > If this fixes a bug can you add Fixes tags to each of them? Then it's ok
> > > > > > to merge in this window. Probably easier than the elaborate
> > > > > > mask/unmask dance.
> > > > >
> > > > > CCing Shannon (the original author of the "better PACKED support"
> > > > > series).
> > > > >
> > > > > IIUC Shannon is going to send a v3 of that series to fix the
> > > > > documentation, so Shannon can you also add the Fixes tags?
> > > > >
> > > > > Thanks,
> > > > > Stefano
> > > >
> > > > Well this is in my tree already. Just reply with
> > > > Fixes: <>
> > > > to each and I will add these tags.
> > > 
> > > I tried, but it is not easy since we added the support for packed virtqueue
> > > in vdpa and vhost incrementally.
> > > 
> > > Initially I was thinking of adding the same tag used here:
> > > 
> > > Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> > > 
> > > Then I discovered that vq_state wasn't there, so I was thinking of
> > > 
> > > Fixes: 530a5678bc00 ("vdpa: support packed virtqueue for set/get_vq_state()")
> > > 
> > > So we would have to backport quite a few patches into the stable branches.
> > > I don't know if it's worth it...
> > > 
> > > I still think it is better to disable packed in the stable branches,
> > > otherwise I have to make a list of all the patches we need.
> > > 
> > > Any other ideas?
> > > 
> > > Thanks,
> > > Stefano
> > 
> > OK so. You want me to apply this one now, and fixes in the next
> > kernel?
> 
> Yep, it seems to me the least risky approach.
> 
> Thanks,
> Stefano

I'd like something more general though. Bring back the allowlist?
Jason, your thoughts?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
