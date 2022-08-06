Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EBFC25B06
	for <virtualization@archiver.kernel.org>; Sat,  6 Aug 2022 07:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95D354033B;
	Sat,  6 Aug 2022 07:48:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95D354033B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X7R6Wbqw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c4v5VjUIjryB; Sat,  6 Aug 2022 07:48:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 903744176C;
	Sat,  6 Aug 2022 07:48:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 903744176C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C8CFC0032;
	Sat,  6 Aug 2022 07:48:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62F90C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 07:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2ECBC4033B
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 07:48:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2ECBC4033B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qQ-yXB1RUOsP
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 07:48:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 76F844176C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 76F844176C
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 07:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659772115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HKJdR7LmnnVRebjUrt3OcGVl+hsgXLOn3cSlJAzVRJE=;
 b=X7R6Wbqw5Uotgxq2toBSU9QB41VQGYVeVsiv8hE3/B6AuamsN58xDnLOObX6a860uQVdK6
 3ntJsJMAOFshjJrv7ggSBsnQhtONEZP66qZFqbp/ylnVBdEzqzmo248Dn6vzAfbgcgArsu
 4BFUMnl/miBgjR9u5E0niaPCdDoCMcY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-LaRBDLcyOkKABIwvv3kAUw-1; Sat, 06 Aug 2022 03:48:34 -0400
X-MC-Unique: LaRBDLcyOkKABIwvv3kAUw-1
Received: by mail-wm1-f69.google.com with SMTP id
 r10-20020a05600c284a00b003a2ff6c9d6aso5337818wmb.4
 for <virtualization@lists.linux-foundation.org>;
 Sat, 06 Aug 2022 00:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=HKJdR7LmnnVRebjUrt3OcGVl+hsgXLOn3cSlJAzVRJE=;
 b=nFbFoX8zBDWPbxCttKUbPS/NyHh3dU4UOpumYvXIFU+2MLHa4N5ScZBlbqXVNzL1wR
 mDHEWcaSBWo9mUHQ2l/ACRB3WtNHlnFl4u+YrF5UiLQ9iECLGxuz1/gVHmm5xvAl2NQs
 4u9bzynYcysiOX2hG7IiE96hJDc1/gr4qJtH08vM3Ej88jfMyePiw2+7WcoJymzhLZyU
 nr439yRpGULWOZVQ/o0KnI/gX9wlrbBox/MYwmPZpAuJlkEh2AAELjtUcOWfQ4683fOw
 3HkvvE0q7DcpwJASJ5BeSnSVavIdQir6HQWe0aFUO9g9J1AOaP1PteBnpWmoNkznultl
 YH4Q==
X-Gm-Message-State: ACgBeo1b1cSeneAEeCxPfQAuqjCKFLYl8sIIs8jdjxkXXxp1eK8aMm9n
 4RYIoStP2zKUxXBJianJYUOmtQLrwYHbVxLVhU9gMk24KoDWo9QQeGQ9NK3G3KuymsqIk+xh1Fd
 W10nDezdzTyLZRtsM8RA3MJYC72CHLHUV2ZGL73w8qg==
X-Received: by 2002:a7b:c4d7:0:b0:3a4:f135:cae5 with SMTP id
 g23-20020a7bc4d7000000b003a4f135cae5mr11772918wmk.201.1659772113085; 
 Sat, 06 Aug 2022 00:48:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4rrYxYHIgJq15RsQNATquLdbvDE9omfk3WwIkXFCvrg+NGUdxv0J2OY4G92BAAYWQDoOPCsQ==
X-Received: by 2002:a7b:c4d7:0:b0:3a4:f135:cae5 with SMTP id
 g23-20020a7bc4d7000000b003a4f135cae5mr11772902wmk.201.1659772112862; 
 Sat, 06 Aug 2022 00:48:32 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 p3-20020a05600c1d8300b003a3186fa559sm7389606wms.29.2022.08.06.00.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Aug 2022 00:48:32 -0700 (PDT)
Date: Sat, 6 Aug 2022 09:48:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <20220806074828.zwzgn5gj47gjx5og@sgarzare-redhat>
References: <20220805181105.GA29848@willie-the-truck>
MIME-Version: 1.0
In-Reply-To: <20220805181105.GA29848@willie-the-truck>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: jiyong@google.com, kvm@vger.kernel.org, mst@redhat.com, maz@kernel.org,
 keirf@google.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, ascull@google.com,
 stefanha@redhat.com, kernel-team@android.com, torvalds@linux-foundation.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Will,

On Fri, Aug 05, 2022 at 07:11:06PM +0100, Will Deacon wrote:
>Hi folks,
>
>[tl;dr a change from ~18 months ago breaks Android userspace and I don't
> know what to do about it]
>
>As part of the development work for next year's Android, we've recently
>been bringing up a 5.15 KVM host and have observed that vsock no longer
>works for communicating with a guest because crosvm gets an unexpected
>-EFAULT back from the VHOST_VSOCK_SET_RUNNING ioctl():
>
> | E crosvm : vpipe worker thread exited with error: VhostVsockStart(IoctlError(Os { code: 14, kind: Uncategorized, message: "Bad address" }))
>
>The same guest payload works correctly on a 5.10 KVM host kernel.
>
>After some digging, we narrowed this change in behaviour down to
>e13a6915a03f ("vhost/vsock: add IOTLB API support") and further digging
>reveals that the infamous VIRTIO_F_ACCESS_PLATFORM feature flag is to
>blame. Indeed, our tests once again pass if we revert that patch (there's
>a trivial conflict with the later addition of VIRTIO_VSOCK_F_SEQPACKET
>but otherwise it reverts cleanly).
>
>On Android, KVM runs in a mode where the host kernel is, by default,
>unable to access guest memory [1] and so memory used for virtio (e.g.
>the rings and descriptor data) needs to be shared explicitly with the
>host using hypercalls issued by the guest. We implement this on top of
>restricted DMA [2], whereby the guest allocates a pool of shared memory
>during boot and bounces all virtio transfers through this window. In
>order to get the guest to use the DMA API for virtio devices (which is
>required for the SWIOTLB code to kick in and do the aforementioned
>bouncing), crosvm sets the VIRTIO_F_ACCESS_PLATFORM feature flag on its
>emulated devices and this is picked up by virtio_has_dma_quirk() in the
>guest kernel. This has been working well for us so far.
>
>With e13a6915a03f, the vhost backend for vsock now advertises
>VIRTIO_F_ACCESS_PLATFORM in its response to the VHOST_GET_FEATURES
>ioctl() and accepts it in the VHOST_SET_FEATURES as a mechanism to
>enable the IOTLB feature (note: this is nothing to do with SWIOTLB!).
>This feature is used for emulation of a virtual IOMMU and requires
>explicit support for issuing IOTLB messages (see VHOST_IOTLB_MSG and
>VHOST_IOTLB_MSG_V2) from userspace to manage address translations for
>the virtio device.
>
>Looking at how crosvm uses these vhost ioctl()s, we can see:
>
>        let avail_features = self
>            .vhost_handle
>            .get_features()
>            .map_err(Error::VhostGetFeatures)?;
>
>        let features: c_ulonglong = self.acked_features & avail_features;
>        self.vhost_handle
>            .set_features(features)
>            .map_err(Error::VhostSetFeatures)?;

>
>where 'acked_features' is the feature set negotiated between crosvm and
>the guest, while 'avail_features' is the supported feature set
>advertised by vhost. The intersection of these now includes
>VIRTIO_F_ACCESS_PLATFORM in the 5.15 kernel and so we quietly start
>enabling IOTLB, despite not having any of the necessary support in
>crosvm and therefore the vsock thread effectively grinds to a halt and
>we cannot communicate with the guest.
>
>The fundamental issue is, I think, that VIRTIO_F_ACCESS_PLATFORM is
>being used for two very different things within the same device; for the
>guest it basically means "use the DMA API, it knows what to do" but for
>vhost it very specifically means "enable IOTLB". We've recently had
>other problems with this flag [3] but in this case it used to work
>reliably and now it doesn't anymore.
>
>So how should we fix this? One possibility is for us to hack crosvm to
>clear the VIRTIO_F_ACCESS_PLATFORM flag when setting the vhost 

Why do you consider this a hack?

If the VMM implements the translation feature, it is right in my opinion 
that it does not enable the feature for the vhost device. Otherwise, if 
it wants the vhost device to do the translation, enable the feature and 
send the IOTLB messages to set the translation.

QEMU for example masks features when not required or supported.
crosvm should negotiate only the features it supports.

@Michael and @Jason can correct me, but if a vhost device negotiates 
VIRTIO_F_ACCESS_PLATFORM, then it expects the VMM to send IOTLB messages 
to set the translation.

Indeed that patch was to fix 
https://bugzilla.redhat.com/show_bug.cgi?id=1894101

>features,
>but others here have reasonably pointed out that they didn't expect a
>kernel change to break userspace. On the flip side, the offending commit
>in the kernel isn't exactly new (it's from the end of 2020!) and so it's
>likely that others (e.g. QEMU) are using this feature.

Yep, QEMU can use it.

>I also strongly
>suspect that vhost net suffers from exactly the same issue, we just
>don't happen to be using that (yet) in Android.

I think so too, the implementation in vsock was done following 
vhost-net.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
