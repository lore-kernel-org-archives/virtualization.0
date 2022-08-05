Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96723C00140
	for <virtualization@archiver.kernel.org>; Fri,  5 Aug 2022 18:11:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AF6860AC4;
	Fri,  5 Aug 2022 18:11:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1AF6860AC4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gH90EbPR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vc0maQN2yPn9; Fri,  5 Aug 2022 18:11:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7590760A70;
	Fri,  5 Aug 2022 18:11:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7590760A70
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DB86C0033;
	Fri,  5 Aug 2022 18:11:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF0B7C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 18:11:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 82CDB40AA1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 18:11:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 82CDB40AA1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=gH90EbPR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3KGyeQPhLNhN
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 18:11:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 36237405AD
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 36237405AD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 18:11:17 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 331FCB829ED;
 Fri,  5 Aug 2022 18:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F51C433D6;
 Fri,  5 Aug 2022 18:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659723072;
 bh=uhsU2yeYQMb8fBkEMlPeo+n2vx1ZR0ocIn28vvJncwk=;
 h=Date:From:To:Cc:Subject:From;
 b=gH90EbPR6ETqG2olJRa1NFfdoe3plAI05vQYCjX6mFcgIMfmxFSa5ozj6KJVkGTkG
 c5e6m8r4VDePVhDczpr4ExiZ1GXLYnFCDAEEHQymVkeynv+8aKWoVM2zB8xJy3BYzk
 y3Iz9xaLfoiHTa7k1DFkKN+0nGySY2xVHA1kPngSr57yDMyL1SVIV4plCxDvBD4XS1
 qnubREx0SXLIIogO2ESbJVDfkX17Pw7C9BO/7FszG2ADDnqEfekjtCUL+7B4zrleMq
 HlRJNuera50lgcaP3n5+SNykti/JkDFJ1+n5mTkN6IQOjCTQ6bHqKOEdoQeRKbis8d
 vG/XVRTGMMusA==
Date: Fri, 5 Aug 2022 19:11:06 +0100
From: Will Deacon <will@kernel.org>
To: mst@redhat.com, stefanha@redhat.com
Subject: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <20220805181105.GA29848@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jiyong@google.com, kvm@vger.kernel.org, kernel-team@android.com,
 maz@kernel.org, keirf@google.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, ascull@google.com,
 torvalds@linux-foundation.org
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

Hi folks,

[tl;dr a change from ~18 months ago breaks Android userspace and I don't
 know what to do about it]

As part of the development work for next year's Android, we've recently
been bringing up a 5.15 KVM host and have observed that vsock no longer
works for communicating with a guest because crosvm gets an unexpected
-EFAULT back from the VHOST_VSOCK_SET_RUNNING ioctl():

 | E crosvm : vpipe worker thread exited with error: VhostVsockStart(IoctlError(Os { code: 14, kind: Uncategorized, message: "Bad address" }))

The same guest payload works correctly on a 5.10 KVM host kernel.

After some digging, we narrowed this change in behaviour down to
e13a6915a03f ("vhost/vsock: add IOTLB API support") and further digging
reveals that the infamous VIRTIO_F_ACCESS_PLATFORM feature flag is to
blame. Indeed, our tests once again pass if we revert that patch (there's
a trivial conflict with the later addition of VIRTIO_VSOCK_F_SEQPACKET
but otherwise it reverts cleanly).

On Android, KVM runs in a mode where the host kernel is, by default,
unable to access guest memory [1] and so memory used for virtio (e.g.
the rings and descriptor data) needs to be shared explicitly with the
host using hypercalls issued by the guest. We implement this on top of
restricted DMA [2], whereby the guest allocates a pool of shared memory
during boot and bounces all virtio transfers through this window. In
order to get the guest to use the DMA API for virtio devices (which is
required for the SWIOTLB code to kick in and do the aforementioned
bouncing), crosvm sets the VIRTIO_F_ACCESS_PLATFORM feature flag on its
emulated devices and this is picked up by virtio_has_dma_quirk() in the
guest kernel. This has been working well for us so far.

With e13a6915a03f, the vhost backend for vsock now advertises
VIRTIO_F_ACCESS_PLATFORM in its response to the VHOST_GET_FEATURES
ioctl() and accepts it in the VHOST_SET_FEATURES as a mechanism to
enable the IOTLB feature (note: this is nothing to do with SWIOTLB!).
This feature is used for emulation of a virtual IOMMU and requires
explicit support for issuing IOTLB messages (see VHOST_IOTLB_MSG and
VHOST_IOTLB_MSG_V2) from userspace to manage address translations for
the virtio device.

Looking at how crosvm uses these vhost ioctl()s, we can see:

        let avail_features = self
            .vhost_handle
            .get_features()
            .map_err(Error::VhostGetFeatures)?;

        let features: c_ulonglong = self.acked_features & avail_features;
        self.vhost_handle
            .set_features(features)
            .map_err(Error::VhostSetFeatures)?;

where 'acked_features' is the feature set negotiated between crosvm and
the guest, while 'avail_features' is the supported feature set
advertised by vhost. The intersection of these now includes
VIRTIO_F_ACCESS_PLATFORM in the 5.15 kernel and so we quietly start
enabling IOTLB, despite not having any of the necessary support in
crosvm and therefore the vsock thread effectively grinds to a halt and
we cannot communicate with the guest.

The fundamental issue is, I think, that VIRTIO_F_ACCESS_PLATFORM is
being used for two very different things within the same device; for the
guest it basically means "use the DMA API, it knows what to do" but for
vhost it very specifically means "enable IOTLB". We've recently had
other problems with this flag [3] but in this case it used to work
reliably and now it doesn't anymore.

So how should we fix this? One possibility is for us to hack crosvm to
clear the VIRTIO_F_ACCESS_PLATFORM flag when setting the vhost features,
but others here have reasonably pointed out that they didn't expect a
kernel change to break userspace. On the flip side, the offending commit
in the kernel isn't exactly new (it's from the end of 2020!) and so it's
likely that others (e.g. QEMU) are using this feature. I also strongly
suspect that vhost net suffers from exactly the same issue, we just
don't happen to be using that (yet) in Android.

Thanks,

Will

[1] https://lwn.net/Articles/836693/
[2] https://lwn.net/Articles/841916/
[3] https://lore.kernel.org/lkml/YtkCQsSvE9AZyrys@google.com/
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
