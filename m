Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9BAC433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:17:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27436113A
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C27436113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A5E160836;
	Mon,  4 Oct 2021 19:17:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OI0aCKV2DEwW; Mon,  4 Oct 2021 19:17:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F398B60684;
	Mon,  4 Oct 2021 19:17:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5D2EC0011;
	Mon,  4 Oct 2021 19:17:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C68CC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F429405A7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:17:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w-V737noJbEr
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:17:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B7DD4056A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633375065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dnrMZKgYsa9zV3N6XQLhjXsAPJjau0Q+eDXogTmvyUM=;
 b=jAVML846LhtdykentVRExTqXMV0Lm1oXnIztTdjQQjlA96br5qbPZI44qS+3jVVPrfbXxc
 SLMoP6LV5YePWHCg4CeMjk26zZPyJnSoBwyBUbYR5EplkYttH6oACYo+Hls0mvLeOURVcE
 p4gHN83TutX5ewmyDqctCaGCpr3J6Vs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-PzfAbkrSP1u02L4azpPs3Q-1; Mon, 04 Oct 2021 15:17:42 -0400
X-MC-Unique: PzfAbkrSP1u02L4azpPs3Q-1
Received: by mail-ed1-f70.google.com with SMTP id
 w6-20020a50d786000000b003dabc563406so13814406edi.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Oct 2021 12:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dnrMZKgYsa9zV3N6XQLhjXsAPJjau0Q+eDXogTmvyUM=;
 b=EgzAmBrsIGMqMKNSGEzyZ4E2oiTqsEGPafRsd4WhE8KHHf+8JpOLblfnahLbAhEZTL
 ZmYzwQZZs8Y/uQ5eHksFYg5Ambj+35FwSaFV1fjLhAOhevoxxfo3sK8gtByefPphjQ5W
 80cKc8On6/i709/xvPo2iw1ihbDT+4Vujn2qyK0VBININCA0oLgVugV7agsbDKSURbk5
 WTCyiumwjWET4zJ0DaPXHq8ew/hpZKYtXHVHzMrxM9ic1tSAPdJqREwjUifAWAtN+KyR
 jhsiGjV9BCBB8/iOp2D5mloJbe0g0mwMHiMbqT/FFou9r1ENIFBUKWLaebxbHUgtikUp
 npHg==
X-Gm-Message-State: AOAM530LQ08g5v3g0LscoddacTXDXY9zdtcv+kdfyso/oQAWbmBrYZMx
 4ig4hUiY4lkuJVUZgNRgYCiJZPKhILbe5jXhExiTn0d/p7ijSl2f0F7k3Bql2ZSz6dP3i8I6qcV
 IGGIxeRA950fhbNUv0d+MdjKAMS6ksbOgOLptPEig9Q==
X-Received: by 2002:a17:906:e2cf:: with SMTP id
 gr15mr19049428ejb.468.1633375060991; 
 Mon, 04 Oct 2021 12:17:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCcdDaBL4+0xApN30GKptZMox4I6k3d/U5sfhai9+VR+XWMkZ5SQ/aYkIFBgB630xlyuuMdg==
X-Received: by 2002:a17:906:e2cf:: with SMTP id
 gr15mr19049399ejb.468.1633375060739; 
 Mon, 04 Oct 2021 12:17:40 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
 by smtp.gmail.com with ESMTPSA id t15sm5652453edq.93.2021.10.04.12.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 12:17:39 -0700 (PDT)
Date: Mon, 4 Oct 2021 15:17:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211004151408-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <20211001092125.64fef348.pasic@linux.ibm.com>
 <20211002055605-mutt-send-email-mst@kernel.org>
 <87bl452d90.fsf@redhat.com>
 <20211004090018-mutt-send-email-mst@kernel.org>
 <875yuc3ln2.fsf@redhat.com>
 <20211004110537-mutt-send-email-mst@kernel.org>
 <87wnms23hn.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87wnms23hn.fsf@redhat.com>
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

On Mon, Oct 04, 2021 at 05:50:44PM +0200, Cornelia Huck wrote:
> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Oct 04, 2021 at 04:33:21PM +0200, Cornelia Huck wrote:
> >> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> 
> >> > On Mon, Oct 04, 2021 at 02:19:55PM +0200, Cornelia Huck wrote:
> >> >> 
> >> >> [cc:qemu-devel]
> >> >> 
> >> >> On Sat, Oct 02 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> 
> >> >> > On Fri, Oct 01, 2021 at 09:21:25AM +0200, Halil Pasic wrote:
> >> >> >> On Thu, 30 Sep 2021 07:12:21 -0400
> >> >> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> >> 
> >> >> >> > On Thu, Sep 30, 2021 at 03:20:49AM +0200, Halil Pasic wrote:
> >> >> >> > > This patch fixes a regression introduced by commit 82e89ea077b9
> >> >> >> > > ("virtio-blk: Add validation for block size in config space") and
> >> >> >> > > enables similar checks in verify() on big endian platforms.
> >> >> >> > > 
> >> >> >> > > The problem with checking multi-byte config fields in the verify
> >> >> >> > > callback, on big endian platforms, and with a possibly transitional
> >> >> >> > > device is the following. The verify() callback is called between
> >> >> >> > > config->get_features() and virtio_finalize_features(). That we have a
> >> >> >> > > device that offered F_VERSION_1 then we have the following options
> >> >> >> > > either the device is transitional, and then it has to present the legacy
> >> >> >> > > interface, i.e. a big endian config space until F_VERSION_1 is
> >> >> >> > > negotiated, or we have a non-transitional device, which makes
> >> >> >> > > F_VERSION_1 mandatory, and only implements the non-legacy interface and
> >> >> >> > > thus presents a little endian config space. Because at this point we
> >> >> >> > > can't know if the device is transitional or non-transitional, we can't
> >> >> >> > > know do we need to byte swap or not.  
> >> >> >> > 
> >> >> >> > Hmm which transport does this refer to?
> >> >> >> 
> >> >> >> It is the same with virtio-ccw and virtio-pci. I see the same problem
> >> >> >> with both on s390x. I didn't try with virtio-blk-pci-non-transitional
> >> >> >> yet (have to figure out how to do that with libvirt) for pci I used
> >> >> >> virtio-blk-pci.
> >> >> >> 
> >> >> >> > Distinguishing between legacy and modern drivers is transport
> >> >> >> > specific.  PCI presents
> >> >> >> > legacy and modern at separate addresses so distinguishing
> >> >> >> > between these two should be no trouble.
> >> >> >> 
> >> >> >> You mean the device id? Yes that is bolted down in the spec, but
> >> >> >> currently we don't exploit that information. Furthermore there
> >> >> >> is a fat chance that with QEMU even the allegedly non-transitional
> >> >> >> devices only present a little endian config space after VERSION_1
> >> >> >> was negotiated. Namely get_config for virtio-blk is implemented in
> >> >> >> virtio_blk_update_config() which does virtio_stl_p(vdev,
> >> >> >> &blkcfg.blk_size, blk_size) and in there we don't care
> >> >> >> about transitional or not:
> >> >> >> 
> >> >> >> static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
> >> >> >> {
> >> >> >> #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
> >> >> >>     return virtio_is_big_endian(vdev);
> >> >> >> #elif defined(TARGET_WORDS_BIGENDIAN)
> >> >> >>     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> >> >> >>         /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> >> >> >>         return false;
> >> >> >>     }
> >> >> >>     return true;
> >> >> >> #else
> >> >> >>     return false;
> >> >> >> #endif
> >> >> >> }
> >> >> >> 
> >> >> >
> >> >> > ok so that's a QEMU bug. Any virtio 1.0 and up
> >> >> > compatible device must use LE.
> >> >> > It can also present a legacy config space where the
> >> >> > endian depends on the guest.
> >> >> 
> >> >> So, how is the virtio core supposed to determine this? A
> >> >> transport-specific callback?
> >> >
> >> > I'd say a field in VirtIODevice is easiest.
> >> 
> >> The transport needs to set this as soon as it has figured out whether
> >> we're using legacy or not.
> >
> > Basically on each device config access?
> 
> Prior to the first one, I think. It should not change again, should it?

Well yes but we never prohibited someone from poking at both ..
Doing it on each access means we don't have state to migrate.

> >
> >> I guess we also need to fence off any
> >> accesses respectively error out the device if the driver tries any
> >> read/write operations that would depend on that knowledge?
> >> 
> >> And using a field in VirtIODevice would probably need some care when
> >> migrating. Hm...
> >
> > It's just a shorthand to minimize changes. No need to migrate I think.
> 
> If we migrate in from an older QEMU, we don't know whether we are
> dealing with legacy or not, until feature negotiation is already
> done... don't we have to ask the transport?

Right but the only thing that can happen is config access.
Well and for legacy a kick I guess.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
