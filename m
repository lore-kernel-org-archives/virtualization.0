Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EDEC77B73
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 13:55:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 311FE820F1;
	Mon,  5 Jun 2023 13:55:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 311FE820F1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NtDloFDU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i5c_hL805W6m; Mon,  5 Jun 2023 13:55:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA1C78203B;
	Mon,  5 Jun 2023 13:55:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA1C78203B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7032DC007A;
	Mon,  5 Jun 2023 13:55:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C7CDC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4523F41721
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:55:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4523F41721
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NtDloFDU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id diM3U-VHtgwx
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:55:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A29641615
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A29641615
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 13:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685973305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jb5+j0WuGaWQLAokH8FJzOfd9IpoIc69UMNApn2Um/Q=;
 b=NtDloFDUgixowRUbDERLQfkddV+3Owad9tXYPpR4QVlVUIjOzm3kNiT5J5bOPA5vQdi1ue
 JhNPNBmXteYXxJWtKBzFeRUz4L8cW2SASR5g6W1z9/xp9HqrKcTmPNZEu2iTLz8V1YtJCd
 JfHFIz6m5JjaL0b7+BYcjd2YYQnt4Xg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-stT_NPqMNFG2MUllhefa0g-1; Mon, 05 Jun 2023 09:55:03 -0400
X-MC-Unique: stT_NPqMNFG2MUllhefa0g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30a5d4e5731so2205536f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jun 2023 06:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685973302; x=1688565302;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jb5+j0WuGaWQLAokH8FJzOfd9IpoIc69UMNApn2Um/Q=;
 b=WQVSGAb3dgwSgC9emXX+G7wdz1trG87BZIP2oPq8WD1x5Sra/2PCGRpOgu4aK4KEPU
 a/bpc/hVIQ98W/P7MgjuZOWNBbQxwOJKhefFuFAAjWycdjfTggr0JOlHcMxFcxOsLWuw
 7SO946Yb2a9I+6gAfJaAtbCTXZYmuWV4SeK27Yk/UJvaNchd++Q5JzpO+tw2Geiru5MY
 /rRslTNIHItNCVP3AdCDcUZUGsyDXV+XpChEMnrFxACVNk+Y3cT/F/L1SiOfshjC8LM+
 Pqcrd98k2vnhoKXaTcQ8FKQqAwyZ7Cpd64pbythhjDMxxJhDZkkVIB5UZVbT3TW+VXHT
 Q+Ig==
X-Gm-Message-State: AC+VfDwVqDlMkR5Nnl3kwqKWlLIxKAA1x0KE/NjHkBXJG3Q0Tiz/ME5e
 ZhWzc74z+3VCz/cXO9vypJPeh2+yXLDgDscCt8KJF+OBq4G43RtkH8lxw0FLZwIsD2eKtykFyd0
 XZ95ViJah7hNvP4i3a/ScSNauc55rW+CfMmuTpad+yQ==
X-Received: by 2002:a5d:6203:0:b0:309:a4e:52d3 with SMTP id
 y3-20020a5d6203000000b003090a4e52d3mr5095733wru.5.1685973301862; 
 Mon, 05 Jun 2023 06:55:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ZHD4gDUdlfGTiduMiqY+ojv/UUc0qqNDYq2hzP027LaDqgTMXJjGDzbnCN0fSb2MNMtWn6g==
X-Received: by 2002:a5d:6203:0:b0:309:a4e:52d3 with SMTP id
 y3-20020a5d6203000000b003090a4e52d3mr5095714wru.5.1685973301499; 
 Mon, 05 Jun 2023 06:55:01 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 t18-20020a05600001d200b0030ae09c5efdsm9932198wrx.42.2023.06.05.06.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 06:55:00 -0700 (PDT)
Date: Mon, 5 Jun 2023 09:54:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <20230605095404-mutt-send-email-mst@kernel.org>
References: <20230605110644.151211-1-sgarzare@redhat.com>
 <20230605084104-mutt-send-email-mst@kernel.org>
 <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
 <20230605085840-mutt-send-email-mst@kernel.org>
 <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
MIME-Version: 1.0
In-Reply-To: <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
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

On Mon, Jun 05, 2023 at 03:30:35PM +0200, Stefano Garzarella wrote:
> On Mon, Jun 05, 2023 at 09:00:25AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jun 05, 2023 at 02:54:20PM +0200, Stefano Garzarella wrote:
> > > On Mon, Jun 05, 2023 at 08:41:54AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Garzarella wrote:
> > > > > vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE)
> > > > > don't support packed virtqueue well yet, so let's filter the
> > > > > VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_features().
> > > > >
> > > > > This way, even if the device supports it, we don't risk it being
> > > > > negotiated, then the VMM is unable to set the vring state properly.
> > > > >
> > > > > Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > > ---
> > > > >
> > > > > Notes:
> > > > >     This patch should be applied before the "[PATCH v2 0/3] vhost_vdpa:
> > > > >     better PACKED support" series [1] and backported in stable branches.
> > > > >
> > > > >     We can revert it when we are sure that everything is working with
> > > > >     packed virtqueues.
> > > > >
> > > > >     Thanks,
> > > > >     Stefano
> > > > >
> > > > >     [1] https://lore.kernel.org/virtualization/20230424225031.18947-1-shannon.nelson@amd.com/
> > > >
> > > > I'm a bit lost here. So why am I merging "better PACKED support" then?
> > > 
> > > To really support packed virtqueue with vhost-vdpa, at that point we would
> > > also have to revert this patch.
> > > 
> > > I wasn't sure if you wanted to queue the series for this merge window.
> > > In that case do you think it is better to send this patch only for stable
> > > branches?
> > > > Does this patch make them a NOP?
> > > 
> > > Yep, after applying the "better PACKED support" series and being
> > > sure that
> > > the IOCTLs of vhost-vdpa support packed virtqueue, we should revert this
> > > patch.
> > > 
> > > Let me know if you prefer a different approach.
> > > 
> > > I'm concerned that QEMU uses vhost-vdpa IOCTLs thinking that the kernel
> > > interprets them the right way, when it does not.
> > > 
> > > Thanks,
> > > Stefano
> > > 
> > 
> > If this fixes a bug can you add Fixes tags to each of them? Then it's ok
> > to merge in this window. Probably easier than the elaborate
> > mask/unmask dance.
> 
> CCing Shannon (the original author of the "better PACKED support"
> series).
> 
> IIUC Shannon is going to send a v3 of that series to fix the
> documentation, so Shannon can you also add the Fixes tags?
> 
> Thanks,
> Stefano

Well this is in my tree already. Just reply with
Fixes: <>
to each and I will add these tags.

If I start dropping and rebasing this won't make it in this window.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
