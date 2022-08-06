Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D05C25B0C
	for <virtualization@archiver.kernel.org>; Sat,  6 Aug 2022 09:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64B05829EE;
	Sat,  6 Aug 2022 09:42:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64B05829EE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C2Q6OxPP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V8EMo5gVReLj; Sat,  6 Aug 2022 09:42:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E317B8300C;
	Sat,  6 Aug 2022 09:42:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E317B8300C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF5C3C0032;
	Sat,  6 Aug 2022 09:42:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 482E2C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 09:42:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B75F40382
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 09:42:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B75F40382
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=C2Q6OxPP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kNtuQm3C21fb
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 09:42:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3C8D34010C
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3C8D34010C
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 09:42:48 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 24C6160DD3;
 Sat,  6 Aug 2022 09:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC11C433C1;
 Sat,  6 Aug 2022 09:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659778966;
 bh=qCrb+uhGHZLFEcmNx8yyS2wZACamZkAd0f+2rHn1FlI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C2Q6OxPPUGczZlpitW1/uOZHT9OupTEQXxjwJre6xcp75fW/drWAZeqWoUT/ta9po
 ET6KMun7iV9u9yvsd4eTiTrNhICPjO3KZKLuu+TXNDPNz8JnfMODeoor6W/oqPs7se
 SRN7IrrjNP5iGhGdq7L/2qzFfxYYvgMZadLe0lDK3jtepOsXv3IyPXjLfrBR9tGGZz
 QEQ661z5Uzo2PJjWFz3h6A88FMWH5BtdF4ucDVy1oxcvNyEFJ0YnR/lsYBAyfvkXO2
 YnO8BvLN0d3aLKt9d8GDMgKrZ1L3BYcjkncr8F/TJdAvLYq4KancdBDgfhmLy4/P32
 SC+34qEAcsywQ==
Date: Sat, 6 Aug 2022 10:42:40 +0100
From: Will Deacon <will@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <20220806094239.GA30268@willie-the-truck>
References: <20220805181105.GA29848@willie-the-truck>
 <20220806074828.zwzgn5gj47gjx5og@sgarzare-redhat>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220806074828.zwzgn5gj47gjx5og@sgarzare-redhat>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Stefano,

On Sat, Aug 06, 2022 at 09:48:28AM +0200, Stefano Garzarella wrote:
> On Fri, Aug 05, 2022 at 07:11:06PM +0100, Will Deacon wrote:
> > The fundamental issue is, I think, that VIRTIO_F_ACCESS_PLATFORM is
> > being used for two very different things within the same device; for the
> > guest it basically means "use the DMA API, it knows what to do" but for
> > vhost it very specifically means "enable IOTLB". We've recently had
> > other problems with this flag [3] but in this case it used to work
> > reliably and now it doesn't anymore.
> > 
> > So how should we fix this? One possibility is for us to hack crosvm to
> > clear the VIRTIO_F_ACCESS_PLATFORM flag when setting the vhost
> 
> Why do you consider this a hack?

I think it's a hack for two reasons:

  (1) We're changing userspace to avoid a breaking change in kernel behaviour
  (2) I think that crosvm's approach is actually pretty reasonable

To elaborate on (2), crosvm has a set of device features that it has
negotiated with the guest. It then takes the intersection of these features
with those advertised by VHOST_GET_FEATURES and calls VHOST_SET_FEATURES
with the result. If there was a common interpretation of what these features
do, then this would work and would mean we wouldn't have to opt-in on a
per-flag basis for vhost. Since VIRTIO_F_ACCESS_PLATFORM is being overloaded
to mean two completely different things, then it breaks and I think masking
out that specific flag is a hack because it's basically crosvm saying "yeah,
I may have negotiated this with the driver but vhost _actually_ means
'IOTLB' when it says it supports this flag so I'll mask it out because I
know better".

> If the VMM implements the translation feature, it is right in my opinion
> that it does not enable the feature for the vhost device. Otherwise, if it
> wants the vhost device to do the translation, enable the feature and send
> the IOTLB messages to set the translation.
> 
> QEMU for example masks features when not required or supported.
> crosvm should negotiate only the features it supports.
> 
> @Michael and @Jason can correct me, but if a vhost device negotiates
> VIRTIO_F_ACCESS_PLATFORM, then it expects the VMM to send IOTLB messages to
> set the translation.

As above, the issue is that vhost now unconditionally advertises this in
VHOST_GET_FEATURES and so a VMM with no knowledge of IOTLB can end up
enabling it by accident.

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
