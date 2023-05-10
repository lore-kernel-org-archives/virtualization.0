Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97598C77B7C
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 03:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 259CE84662;
	Wed, 10 May 2023 03:39:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 259CE84662
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WzF84Ci6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id El26iDWkXHH2; Wed, 10 May 2023 03:39:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 82B5F84649;
	Wed, 10 May 2023 03:39:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82B5F84649
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C81FC0036;
	Wed, 10 May 2023 03:39:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70984C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 38A7A60AF2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:39:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 38A7A60AF2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WzF84Ci6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pdR0edfZbTXP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:39:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 534E560AE6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 534E560AE6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683689967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wlZl2fAPuTd3JqB/fZvLboX3nUwjokftAJ3jxxwO4YM=;
 b=WzF84Ci65Er40Hwb/ONRCLaQ/UxuKtONcLaiEib56e3+0/QynsOdXBx4UxZYnB2g7cRjmi
 xW2VXKMMEX+SRdQx5HtDsRD9CF7k4ueB6MMuJKlSfy1iK4Pgtrf1AwMeAvt+8T+4aE4QfE
 IG/bo/sM6uegF/6Xhb3RGhNbYEDXgi4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-hEypMprsMmqzXxsAxi26pA-1; Tue, 09 May 2023 23:39:26 -0400
X-MC-Unique: hEypMprsMmqzXxsAxi26pA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-50bc6c6b9dbso10298148a12.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 May 2023 20:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683689965; x=1686281965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlZl2fAPuTd3JqB/fZvLboX3nUwjokftAJ3jxxwO4YM=;
 b=PiaccgeS6ZHJj2hXkXh5NX5aaKwpuAvoBBthnAYJjLChSi+GzNMJ6EOJK+nr/2pE4W
 uYlRD+aVIL+tyEOMihJT+4ejOlsG9YMclK5xF5f9NH0IePU9KOGjom6ZmFqNFA/R44v5
 iVa7Oms+f4J83yWJMSmBIugnUhHfNWUmavQnGvasl4wboRnWYtEVTDsD7qdN7+sQzoYL
 EKB2zgTH9EtXBURwFwfKquo3E2wdSjuv/f6pAUW7qmuVLzTbOfeLguDMZn0G54LjfybL
 rUbdCgqmzRJw9W+7RSjeTYOeIWaVloX8M3RWKTihxy3oBJVcxqklsNLRs6nVGhOHqXBm
 FRaw==
X-Gm-Message-State: AC+VfDxOQNNqU7FWizaAUv4UrI/mpiUbdiGjkhpQdNbU7E/g+IVFta8u
 LiqzDIr14IGE/gX7xzJ/nliQDN7D8ae1aZbXKSZDgS6gzwUR14swEURH7oM0e5d42O2FZB+FhCH
 TCxu5HgqomXkBhoduXmvwq/u0ruTuzPNs72SsJgQDAQ==
X-Received: by 2002:a17:907:a429:b0:94a:8e19:6aba with SMTP id
 sg41-20020a170907a42900b0094a8e196abamr12998183ejc.21.1683689965216; 
 Tue, 09 May 2023 20:39:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6sYk9M1+ioaOc46/jtM0pADUa1SIsRL3bgJIdk7tzU+GlllerCbudekFfug0+600+8xihsEw==
X-Received: by 2002:a17:907:a429:b0:94a:8e19:6aba with SMTP id
 sg41-20020a170907a42900b0094a8e196abamr12998174ejc.21.1683689964809; 
 Tue, 09 May 2023 20:39:24 -0700 (PDT)
Received: from redhat.com ([176.119.195.36]) by smtp.gmail.com with ESMTPSA id
 bn13-20020a170906c0cd00b0096599bf7029sm2129152ejb.145.2023.05.09.20.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 May 2023 20:39:24 -0700 (PDT)
Date: Tue, 9 May 2023 23:39:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
Message-ID: <20230509233907-mutt-send-email-mst@kernel.org>
References: <20230510025437.377807-1-pizhenwei@bytedance.com>
 <1683689214.9647853-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1683689214.9647853-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
 zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org
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

On Wed, May 10, 2023 at 11:26:54AM +0800, Xuan Zhuo wrote:
> On Wed, 10 May 2023 10:54:37 +0800, zhenwei pi <pizhenwei@bytedance.com> wrote:
> > Both split ring and packed ring use 32bits to describe the length of
> > a descriptor: see struct vring_desc and struct vring_packed_desc.
> > This means the max segment size supported by virtio is U32_MAX.
> >
> > An example of virtio_max_dma_size in virtio_blk.c:
> >   u32 v, max_size;
> >
> >   max_size = virtio_max_dma_size(vdev);  -> implicit convert
> >   err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
> >                              struct virtio_blk_config, size_max, &v);
> >   max_size = min(max_size, v);
> >
> > There is a risk during implicit convert here, once virtio_max_dma_size
> > returns 4G, max_size becomes 0.
> >
> > Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
> > Cc: Joerg Roedel <jroedel@suse.de>
> > Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 12 ++++++++----
> >  include/linux/virtio.h       |  2 +-
> >  2 files changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index c5310eaf8b46..55cfecf030a1 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -289,12 +289,16 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
> >  	return false;
> >  }
> >
> > -size_t virtio_max_dma_size(const struct virtio_device *vdev)
> > +u32 virtio_max_dma_size(const struct virtio_device *vdev)
> 
> 
> LGTM
> 
> But, should we change the parameter to vq, then use the dma_dev?
> 
> @Jason
> 
> Thanks.
> 


that would be an unrelated rework.

> >  {
> > -	size_t max_segment_size = SIZE_MAX;
> > +	u32 max_segment_size = U32_MAX;
> >
> > -	if (vring_use_dma_api(vdev))
> > -		max_segment_size = dma_max_mapping_size(vdev->dev.parent);
> > +	if (vring_use_dma_api(vdev)) {
> > +		size_t max_dma_size = dma_max_mapping_size(vdev->dev.parent);
> > +
> > +		if (max_dma_size < max_segment_size)
> > +			max_segment_size = max_dma_size;
> > +	}
> >
> >  	return max_segment_size;
> >  }
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index b93238db94e3..1a605f408329 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -147,7 +147,7 @@ int virtio_device_restore(struct virtio_device *dev);
> >  #endif
> >  void virtio_reset_device(struct virtio_device *dev);
> >
> > -size_t virtio_max_dma_size(const struct virtio_device *vdev);
> > +u32 virtio_max_dma_size(const struct virtio_device *vdev);
> >
> >  #define virtio_device_for_each_vq(vdev, vq) \
> >  	list_for_each_entry(vq, &vdev->vqs, list)
> > --
> > 2.20.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
