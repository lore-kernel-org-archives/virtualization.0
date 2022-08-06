Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20E4C19F2D
	for <virtualization@archiver.kernel.org>; Sat,  6 Aug 2022 14:34:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1EB5C404D0;
	Sat,  6 Aug 2022 14:34:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1EB5C404D0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eNB6fQqT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vC0vGeZvu4Dw; Sat,  6 Aug 2022 14:34:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6C2C0400DB;
	Sat,  6 Aug 2022 14:34:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C2C0400DB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36A5BC0033;
	Sat,  6 Aug 2022 14:34:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F2A6C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 14:34:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 630DF60B52
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 14:34:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 630DF60B52
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=eNB6fQqT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S9ytgKHOP_wV
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 14:34:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 61F0B60AE8
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61F0B60AE8
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 14:34:52 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5417D6108C;
 Sat,  6 Aug 2022 14:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2C5C433D6;
 Sat,  6 Aug 2022 14:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659796490;
 bh=AhYiIWPnTRlaUDS/vZCjq5TqXn2f3QFoArzUU29QEUs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eNB6fQqT5MNjaMAbJuyqpQainl+7tJva/dlj6asR4fCfCRtWmMLF75hedwfO04MPi
 SPZ1B5m94OuVDgYau+aijbNcvFZV3bZXFyqkWPZGhIkBTQ40DrYSm0P54QMVyKoQ9T
 qazWakgcHICQADGjVye7cMzR2TRGEKIjH8nttApyhRTfNUjMld6L/COSlDuf806Es9
 QhuFw86EG1sXPru2WOc9IaP+6TMkweTuQXQMq7u783rSDiM79cUgnWFEjI8900X7Uk
 eIFWPoAZagGdNtojBlXDF1TnrC6R3x/r9Rqo/ONSLL3pjGyEPYBkuZwDz3PG6EDXs+
 cAT2z7Vev5wmQ==
Date: Sat, 6 Aug 2022 15:34:44 +0100
From: Will Deacon <will@kernel.org>
To: Stefan Hajnoczi <shajnocz@redhat.com>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <20220806143443.GA30658@willie-the-truck>
References: <20220805181105.GA29848@willie-the-truck>
 <20220806074828.zwzgn5gj47gjx5og@sgarzare-redhat>
 <20220806094239.GA30268@willie-the-truck>
 <CAD60JZMbbkwFHqCm_iCrOrKgRLBUMkDQfuJ=Q1T-sZt59eTBrw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD60JZMbbkwFHqCm_iCrOrKgRLBUMkDQfuJ=Q1T-sZt59eTBrw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jiyong@google.com, kvm@vger.kernel.org, mst@redhat.com, maz@kernel.org,
 keirf@google.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, ascull@google.com,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel-team@android.com,
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

On Sat, Aug 06, 2022 at 06:52:15AM -0400, Stefan Hajnoczi wrote:
> On Sat, Aug 6, 2022 at 5:50 AM Will Deacon <will@kernel.org> wrote:
> > On Sat, Aug 06, 2022 at 09:48:28AM +0200, Stefano Garzarella wrote:
> > > On Fri, Aug 05, 2022 at 07:11:06PM +0100, Will Deacon wrote:
> > > If the VMM implements the translation feature, it is right in my opinion
> > > that it does not enable the feature for the vhost device. Otherwise, if it
> > > wants the vhost device to do the translation, enable the feature and send
> > > the IOTLB messages to set the translation.
> > >
> > > QEMU for example masks features when not required or supported.
> > > crosvm should negotiate only the features it supports.
> > >
> > > @Michael and @Jason can correct me, but if a vhost device negotiates
> > > VIRTIO_F_ACCESS_PLATFORM, then it expects the VMM to send IOTLB messages to
> > > set the translation.
> >
> > As above, the issue is that vhost now unconditionally advertises this in
> > VHOST_GET_FEATURES and so a VMM with no knowledge of IOTLB can end up
> > enabling it by accident.
> 
> Unconditionally exposing all vhost feature bits to the guest is
> incorrect. The emulator must filter out only the feature bits that it
> supports.

I've evidently done a bad job of explaining this, sorry.

crosvm _does_ filter the feature bits which it passes to vhost. It takes the
feature set which it has negotiated with the guest and then takes the
intersection of this set with the set of features which vhost advertises.
The result is what is passed to VHOST_SET_FEATURES. I included the rust
for this in my initial mail, but in C it might look something like:

	u64 features = negotiate_features_with_guest(dev);

	ioctl(vhost_fd, VHOST_GET_FEATURES, &vhost_features);
	vhost_features &= features;	/* Mask out unsupported features */
	ioctl(vhost_fd, VHOST_SET_FEATURES, &vhost_features);

The problem is that crosvm has negotiated VIRTIO_F_ACCESS_PLATFORM with
the guest so that restricted DMA is used for the virtio devices. With
e13a6915a03f, VIRTIO_F_ACCESS_PLATFORM is now advertised by
VHOST_GET_FEATURES and so IOTLB is enabled by the sequence above.

> For example, see QEMU's vhost-net device's vhost feature bit allowlist:
> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/net/vhost_net.c#L40

I agree that changing crosvm to use an allowlist would fix the problem,
I'm just questioning whether we should be changing userspace at all to
resolve this issue.

> The reason why the emulator (crosvm/QEMU/etc) must filter out feature
> bits is that vhost devices are full VIRTIO devices. They are a subset
> of a VIRTIO device and the emulator is responsible for the rest of the
> device. Some features will require both vhost and emulator support.
> Therefore it is incorrect to expect the device to work correctly if
> the vhost feature bits are passed through to the guest.

I think crosvm is trying to cater for this by masking out the features
it doesn't know about.

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
