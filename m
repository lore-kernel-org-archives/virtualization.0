Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7294CC77B75
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 06:10:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 002A140122;
	Wed, 17 May 2023 06:10:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 002A140122
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ONcWDIdI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id luovjcKua-SN; Wed, 17 May 2023 06:10:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DEE4A40101;
	Wed, 17 May 2023 06:10:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DEE4A40101
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACBEFC0036;
	Wed, 17 May 2023 06:10:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D46BBC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 06:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B527981E96
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 06:10:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B527981E96
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ONcWDIdI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NoGTF-jY-kkN
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 06:10:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A318A81E85
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A318A81E85
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 06:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684303825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7k7pF0B18nkLr+NjCb47Ij0PMr/KmJbhEjNycbRjuVg=;
 b=ONcWDIdIwTvjX/gGnHHHmQ3ik5DBeEnFDnMVjUJi/LCaBoEe1t12jtp/ksgK4JInB3O2h9
 J/dhGayK82iB6LUMDX8knqdycboe4PnUjpEweePBjpo3Mbv9wEQ7tzQQTz1q1VXfhSCmCh
 ipx89wXNGbL7jtLjNgjt3hcmESrWbEs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-qFxMav4aPXWZe65pQryaEg-1; Wed, 17 May 2023 02:10:24 -0400
X-MC-Unique: qFxMav4aPXWZe65pQryaEg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30635d18e55so108642f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 23:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684303823; x=1686895823;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7k7pF0B18nkLr+NjCb47Ij0PMr/KmJbhEjNycbRjuVg=;
 b=ZcjXspyI4OKgvmFziuDlSAnlZzDcPsyQ8s7Ub4eqnnlTxruLGgNI6xqXb63UXOL5xK
 xiixltfWaCbwjZJRucnuYxqy+S0mjnAbwppsw5m7l0CH02ogYV6t+4pIhYTQE9bWJCq4
 rLHvvbgtZlh9PqH/Z7hY/7rjer4hVfs8Gii+YBpTC48n1ujbLIwOMTGag+zv3X5lCDmp
 2pmQ09OogdUfH4M482/5NWPYvjr32qeyfmM2/vRwdWmuBdDAAK3GbLZGmhUJVCgaqggb
 pfX1Fojb0/6Tc+7XJwMhLXmA4v6PcO+j+gYaFiKDGCLTwTXDAvYzKk4gftD2cNNTBgTq
 gg5A==
X-Gm-Message-State: AC+VfDyKVrcpzxEjg96mh+WK9oE2/x5jxMh9QlBZjAu1MMFq8SC4lpYn
 W+30zJMSEPvPdvdFiNEKensc7I9cIaqDgTZU9+NtJ0StQPC7AJUYSDrcJ3xNQVVAnOj0y82qwnE
 uvB5U0d4lXRUhQrahqPz6MmlMSC+EhKSVF4y2Vf+kEQ==
X-Received: by 2002:a5d:58da:0:b0:307:7d1a:2100 with SMTP id
 o26-20020a5d58da000000b003077d1a2100mr29946143wrf.22.1684303823013; 
 Tue, 16 May 2023 23:10:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4bkIb2CjCg5ouxlAmzd4JzhURgicC1Ja4DMt3QZaJJ7w/7hrm1Do1sRnRF24r+3WNhaqvboQ==
X-Received: by 2002:a5d:58da:0:b0:307:7d1a:2100 with SMTP id
 o26-20020a5d58da000000b003077d1a2100mr29946126wrf.22.1684303822707; 
 Tue, 16 May 2023 23:10:22 -0700 (PDT)
Received: from redhat.com ([2.52.6.43]) by smtp.gmail.com with ESMTPSA id
 y18-20020a5d4ad2000000b003012030a0c6sm1708138wrs.18.2023.05.16.23.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 23:10:21 -0700 (PDT)
Date: Wed, 17 May 2023 02:10:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: Re: Re: [PATCH v2 0/2] virtio: abstract virtqueue related methods
Message-ID: <20230517020947-mutt-send-email-mst@kernel.org>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230516234444-mutt-send-email-mst@kernel.org>
 <8f3ca136-0276-49ca-d703-715c83cff557@bytedance.com>
 <20230516235541-mutt-send-email-mst@kernel.org>
 <949dd4db-89ea-4331-5fa7-700f96874ab3@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <949dd4db-89ea-4331-5fa7-700f96874ab3@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Wed, May 17, 2023 at 12:58:10PM +0800, zhenwei pi wrote:
> On 5/17/23 11:57, Michael S. Tsirkin wrote:
> > On Wed, May 17, 2023 at 11:51:03AM +0800, zhenwei pi wrote:
> > > 
> > > 
> > > On 5/17/23 11:46, Michael S. Tsirkin wrote:
> > > > On Wed, May 17, 2023 at 10:54:22AM +0800, zhenwei pi wrote:
> > > > > v1 -> v2:
> > > > > - Suggested by MST, use fast path for vring based performance
> > > > > sensitive API.
> > > > > - Reduce changes in tools/virtio.
> > > > > 
> > > > > Add test result(no obvious change):
> > > > > Before:
> > > > > time ./vringh_test --parallel
> > > > > Using CPUS 0 and 191
> > > > > Guest: notified 10036893, pinged 68278
> > > > > Host: notified 68278, pinged 3093532
> > > > > 
> > > > > real	0m14.463s
> > > > > user	0m6.437s
> > > > > sys	0m8.010s
> > > > > 
> > > > > After:
> > > > > time ./vringh_test --parallel
> > > > > Using CPUS 0 and 191
> > > > > Guest: notified 10036709, pinged 68347
> > > > > Host: notified 68347, pinged 3085292
> > > > > 
> > > > > real	0m14.196s
> > > > > user	0m6.289s
> > > > > sys	0m7.885s
> > > > > 
> > > > > v1:
> > > > > Hi,
> > > > > 
> > > > > 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
> > > > > https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
> > > > > 
> > > > > Jason and Stefan pointed out that a non-vring based virtqueue has a
> > > > > chance to overwrite virtqueue instead of using vring virtqueue.
> > > > > 
> > > > > Then I try to abstract virtqueue related methods in this series, the
> > > > > details changes see the comment of patch 'virtio: abstract virtqueue related methods'.
> > > > > 
> > > > > Something is still remained:
> > > > > - __virtqueue_break/__virtqueue_unbreak is supposed to use by internal
> > > > >     virtio core, I'd like to rename them to vring_virtqueue_break
> > > > >     /vring_virtqueue_unbreak. Is this reasonable?
> > > > 
> > > > Why? These just set a flag?
> > > > 
> > > 
> > > Rename '__virtqueue_break' to 'vring_virtqueue_break', to make symbols
> > > exported from virtio_ring.ko have unified prefix 'vring_virtqueue_xxx'.
> > 
> > I just do not see why you need these callbacks at all.
> > 
> 
> I use these callbacks for break/unbreak device like:
> static inline void virtio_break_device(struct virtio_device *dev)
> {
> 	struct virtqueue *vq;
> 
> 	spin_lock(&dev->vqs_list_lock);
> 	list_for_each_entry(vq, &dev->vqs, list) {
> 		vq->__break(vq);
> 	}
> 	spin_unlock(&dev->vqs_list_lock);
> }

why do this? backend knows they are broken.

> > > > > - virtqueue_get_desc_addr/virtqueue_get_avail_addr/virtqueue_get_used_addr
> > > > >     /virtqueue_get_vring is vring specific, I'd like to rename them like
> > > > >     vring_virtqueue_get_desc_addr. Is this reasonable?
> > > > > - there are still some functions in virtio_ring.c with prefix *virtqueue*,
> > > > >     for example 'virtqueue_add_split', just keep it or rename it to
> > > > >     'vring_virtqueue_add_split'?
> > > > > zhenwei pi (2):
> > > > >     virtio: abstract virtqueue related methods
> > > > >     tools/virtio: implement virtqueue in test
> > > > > 
> > > > >    drivers/virtio/virtio_ring.c | 285 +++++-----------------
> > > > >    include/linux/virtio.h       | 441 +++++++++++++++++++++++++++++++----
> > > > >    include/linux/virtio_ring.h  |  26 +++
> > > > >    tools/virtio/linux/virtio.h  | 355 +++++++++++++++++++++++++---
> > > > >    4 files changed, 807 insertions(+), 300 deletions(-)
> > > > > 
> > > > > -- 
> > > > > 2.20.1
> > > > 
> > > 
> > > -- 
> > > zhenwei pi
> > 
> 
> -- 
> zhenwei pi

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
