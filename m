Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03622C433FE
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 15:07:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45C26124D
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 15:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B45C26124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 73D1540873;
	Mon,  4 Oct 2021 15:07:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mtVoj4rLYovw; Mon,  4 Oct 2021 15:07:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9A327402DD;
	Mon,  4 Oct 2021 15:07:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B36BC0011;
	Mon,  4 Oct 2021 15:07:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 026EEC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:07:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E066D40871
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:07:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bWTR4E_6-Fin
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:07:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A908B402DD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633360062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=985LDnfzYRs2ce2VWBJ5EWrnvqpFRI7lu5SFcPvp2wc=;
 b=YAY8fhM7LCWRaBI4D/XKFQNxnL2YmC0NI6+bAa7+pLsVBMZ7JG2kr5H/BsihY8OenTK7Bt
 Z59RBAcxBiXpcCRVTCZ6sBGauMQP4gAab3D2l/reWglMALa6ZGmtkk9NvECwQFgF8hvkcM
 JcmWtQt33jdnDY3ntotGbgA8U9D32Ak=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-Q9wGCTSDM9Kc8YZVXapgIQ-1; Mon, 04 Oct 2021 11:07:41 -0400
X-MC-Unique: Q9wGCTSDM9Kc8YZVXapgIQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 u17-20020a50d511000000b003daa3828c13so17471783edi.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Oct 2021 08:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=985LDnfzYRs2ce2VWBJ5EWrnvqpFRI7lu5SFcPvp2wc=;
 b=W/+RDHHbY6whwd2DIC5tLx3PYO9o1t2hjW76iTwpUPn/kqfrqDDt98NUjQa26be8Mq
 TtUTd5qvhAL9Gfh9mi6cncw8yPcpdWjcdsT2rp2d+HliVyKG1pG//nJB0UVfTps8ql/7
 awFJIyujwmm9XnYb8dJ4xBlIKMY3e+oSBhl02U+fN3lGLQSAQ/m4yJSt1qODgGlGEQ+m
 RPwq4W9K+aAf2gzHndcbg/mp31UUb84pOIEyLH5VDXvYUeCM3V7qjMPcGPDlDMgpQmdK
 pqHwH3KRxToWYmGae7Eumuz5EooZUqz9q8FHUu97DObzNz4Eels7ll0AOwTuVu3hzbv9
 gQ1A==
X-Gm-Message-State: AOAM530qz3Gl4ip7aGPkQGFOCXEfAGyJ2+essN45KFNfYUuXcpa3A00P
 y4xbhz1GTT5ziUgFI0XbNEXnnfJ5Egf9C4/+4F/zOv1iwTWS2Hycox2w5XeA3k2/zopi3LGUQ9b
 Z7NWkfxJE9Q+qKVJJ3Bt57ZfdTPggDLXO9Xb1VuTJ1g==
X-Received: by 2002:a50:cf02:: with SMTP id c2mr19027268edk.325.1633360060385; 
 Mon, 04 Oct 2021 08:07:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2R3Yw9rloBmg/pn4N4NgpeHLThvy4ibN5NrAyU9aRc3amYe7O7XoVjZkHq3LcnnrMqExsaQ==
X-Received: by 2002:a50:cf02:: with SMTP id c2mr19027231edk.325.1633360060137; 
 Mon, 04 Oct 2021 08:07:40 -0700 (PDT)
Received: from redhat.com (93-172-224-64.bb.netvision.net.il. [93.172.224.64])
 by smtp.gmail.com with ESMTPSA id
 j22sm6750947ejt.11.2021.10.04.08.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 08:07:39 -0700 (PDT)
Date: Mon, 4 Oct 2021 11:07:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211004110537-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <20211001092125.64fef348.pasic@linux.ibm.com>
 <20211002055605-mutt-send-email-mst@kernel.org>
 <87bl452d90.fsf@redhat.com>
 <20211004090018-mutt-send-email-mst@kernel.org>
 <875yuc3ln2.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <875yuc3ln2.fsf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Halil Pasic <pasic@linux.ibm.com>, Xie Yongji <xieyongji@bytedance.com>
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

On Mon, Oct 04, 2021 at 04:33:21PM +0200, Cornelia Huck wrote:
> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Oct 04, 2021 at 02:19:55PM +0200, Cornelia Huck wrote:
> >> 
> >> [cc:qemu-devel]
> >> 
> >> On Sat, Oct 02 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> 
> >> > On Fri, Oct 01, 2021 at 09:21:25AM +0200, Halil Pasic wrote:
> >> >> On Thu, 30 Sep 2021 07:12:21 -0400
> >> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> 
> >> >> > On Thu, Sep 30, 2021 at 03:20:49AM +0200, Halil Pasic wrote:
> >> >> > > This patch fixes a regression introduced by commit 82e89ea077b9
> >> >> > > ("virtio-blk: Add validation for block size in config space") and
> >> >> > > enables similar checks in verify() on big endian platforms.
> >> >> > > 
> >> >> > > The problem with checking multi-byte config fields in the verify
> >> >> > > callback, on big endian platforms, and with a possibly transitional
> >> >> > > device is the following. The verify() callback is called between
> >> >> > > config->get_features() and virtio_finalize_features(). That we have a
> >> >> > > device that offered F_VERSION_1 then we have the following options
> >> >> > > either the device is transitional, and then it has to present the legacy
> >> >> > > interface, i.e. a big endian config space until F_VERSION_1 is
> >> >> > > negotiated, or we have a non-transitional device, which makes
> >> >> > > F_VERSION_1 mandatory, and only implements the non-legacy interface and
> >> >> > > thus presents a little endian config space. Because at this point we
> >> >> > > can't know if the device is transitional or non-transitional, we can't
> >> >> > > know do we need to byte swap or not.  
> >> >> > 
> >> >> > Hmm which transport does this refer to?
> >> >> 
> >> >> It is the same with virtio-ccw and virtio-pci. I see the same problem
> >> >> with both on s390x. I didn't try with virtio-blk-pci-non-transitional
> >> >> yet (have to figure out how to do that with libvirt) for pci I used
> >> >> virtio-blk-pci.
> >> >> 
> >> >> > Distinguishing between legacy and modern drivers is transport
> >> >> > specific.  PCI presents
> >> >> > legacy and modern at separate addresses so distinguishing
> >> >> > between these two should be no trouble.
> >> >> 
> >> >> You mean the device id? Yes that is bolted down in the spec, but
> >> >> currently we don't exploit that information. Furthermore there
> >> >> is a fat chance that with QEMU even the allegedly non-transitional
> >> >> devices only present a little endian config space after VERSION_1
> >> >> was negotiated. Namely get_config for virtio-blk is implemented in
> >> >> virtio_blk_update_config() which does virtio_stl_p(vdev,
> >> >> &blkcfg.blk_size, blk_size) and in there we don't care
> >> >> about transitional or not:
> >> >> 
> >> >> static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
> >> >> {
> >> >> #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
> >> >>     return virtio_is_big_endian(vdev);
> >> >> #elif defined(TARGET_WORDS_BIGENDIAN)
> >> >>     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> >> >>         /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> >> >>         return false;
> >> >>     }
> >> >>     return true;
> >> >> #else
> >> >>     return false;
> >> >> #endif
> >> >> }
> >> >> 
> >> >
> >> > ok so that's a QEMU bug. Any virtio 1.0 and up
> >> > compatible device must use LE.
> >> > It can also present a legacy config space where the
> >> > endian depends on the guest.
> >> 
> >> So, how is the virtio core supposed to determine this? A
> >> transport-specific callback?
> >
> > I'd say a field in VirtIODevice is easiest.
> 
> The transport needs to set this as soon as it has figured out whether
> we're using legacy or not.

Basically on each device config access?

> I guess we also need to fence off any
> accesses respectively error out the device if the driver tries any
> read/write operations that would depend on that knowledge?
> 
> And using a field in VirtIODevice would probably need some care when
> migrating. Hm...

It's just a shorthand to minimize changes. No need to migrate I think.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
