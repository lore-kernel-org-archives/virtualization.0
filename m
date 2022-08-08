Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8EDC25B0C
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 10:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3100410D6;
	Mon,  8 Aug 2022 10:19:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C3100410D6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mPr1rVff
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gv7TRlc6rgT6; Mon,  8 Aug 2022 10:19:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7CE654094B;
	Mon,  8 Aug 2022 10:19:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CE654094B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 515C0C0033;
	Mon,  8 Aug 2022 10:19:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 245A7C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5E7440609
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:18:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E5E7440609
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=mPr1rVff
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 68qYuIhuvZUX
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:18:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CCF55402E5
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CCF55402E5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:18:58 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B66666102A;
 Mon,  8 Aug 2022 10:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7ADC433D6;
 Mon,  8 Aug 2022 10:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659953937;
 bh=ngKdrHPPGQycLh/g1tjJowsh64MZ7HYYVtSZuwLBhDw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mPr1rVffPPJhu6WgJNp5Uww3hXXtLdrKyCUJB439k/dXUPz2yUQ3ISIDxuQKWeOPd
 /VNZ7QwkAS0s5l5tNcDK1xoJnSnaOko2XpciZAGq40b8TAgE9FSm4s8ArS7js+Yhg1
 NbUonhGZInnD/WFda2qKyw/G7kM1dHeADT3O7AvmDyrdahms1xQecgl6qhIBSjFZNa
 sgnD611KuQclGHte+N3p5FdSZkZNFVX0AmppnLqk8O3MbIn/cnhSpRmddkBKNn/xWw
 YbkqVzuIYUi19CBOGCgkc84MqYymfiI2NvwWKFT6hNHMRnJmm23/YRJCB/uLjVv8tq
 /g1y8jUorBRyg==
Date: Mon, 8 Aug 2022 11:18:50 +0100
From: Will Deacon <will@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <20220808101850.GA31984@willie-the-truck>
References: <20220805181105.GA29848@willie-the-truck>
 <20220807042408-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220807042408-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jiyong@google.com, kvm@vger.kernel.org, kernel-team@android.com,
 maz@kernel.org, keirf@google.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, ascull@google.com,
 stefanha@redhat.com, torvalds@linux-foundation.org
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

Hi Michael,

On Sun, Aug 07, 2022 at 09:14:43AM -0400, Michael S. Tsirkin wrote:
> Will, thanks very much for the analysis and the writeup!

No problem, and thanks for following up.

> On Fri, Aug 05, 2022 at 07:11:06PM +0100, Will Deacon wrote:
> > So how should we fix this? One possibility is for us to hack crosvm to
> > clear the VIRTIO_F_ACCESS_PLATFORM flag when setting the vhost features,
> > but others here have reasonably pointed out that they didn't expect a
> > kernel change to break userspace. On the flip side, the offending commit
> > in the kernel isn't exactly new (it's from the end of 2020!) and so it's
> > likely that others (e.g. QEMU) are using this feature.
> 
> Exactly, that's the problem.
> 
> vhost is reusing the virtio bits and it's only natural that
> what you are doing would happen.
> 
> To be precise, this is what we expected people to do (and what QEMU does):
> 
> 
> #define QEMU_VHOST_FEATURES ((1 << VIRTIO_F_VERSION_1) |
> 			     (1 << VIRTIO_NET_F_RX_MRG) | .... )
> 
> VHOST_GET_FEATURES(... &host_features);
> host_features &= QEMU_VHOST_FEATURES
> VHOST_SET_FEATURES(host_features & guest_features)
> 
> 
> Here QEMU_VHOST_FEATURES are the bits userspace knows about.
> 
> Our assumption was that whatever userspace enables, it
> knows what the effect on vhost is going to be.
> 
> But yes, I understand absolutely how someone would instead just use the
> guest features. It is unfortunate that we did not catch this in time.
> 
> 
> In hindsight, we should have just created vhost level macros
> instead of reusing virtio ones. Would address the concern
> about naming: PLATFORM_ACCESS makes sense for the
> guest since there it means "whatever access rules platform has",
> but for vhost a better name would be VHOST_F_IOTLB.
> We should have also taken greater pains to document what
> we expect userspace to do. I remember now how I thought about something
> like this but after coding this up in QEMU I forgot to document this :(
> Also, I suspect given the history the GET/SET features ioctl and burned
> wrt extending it and we have to use a new when we add new features.
> All this we can do going forward.

Makes sense. The crosvm developers are also pretty friendly in my
experience, so I'm sure they wouldn't mind being involved in discussions
around any future ABI extensions. Just be aware that they _very_ recently
moved their mailing lists, so I think it lives here now:

https://groups.google.com/a/chromium.org/g/crosvm-dev

> But what can we do about the specific issue?
> I am not 100% sure since as Will points out, QEMU and other
> userspace already rely on the current behaviour.
> 
> Looking at QEMU specifically, it always sends some translations at
> startup, this in order to handle device rings.
> 
> So, *maybe* we can get away with assuming that if no IOTLB ioctl was
> ever invoked then this userspace does not know about IOTLB and
> translation should ignore IOTLB completely.

There was a similar suggestion from Stefano:

https://lore.kernel.org/r/20220806105225.crkui6nw53kbm5ge@sgarzare-redhat

about spotting the backend ioctl for IOTLB and using that to enable
the negotiation of F_ACCESS_PLATFORM. Would that work for qemu?

> I am a bit nervous about breaking some *other* userspace which actually
> wants device to be blocked from accessing memory until IOTLB
> has been setup. If we get it wrong we are making guest
> and possibly even host vulnerable.
> And of course just revering is not an option either since there
> are now whole stacks depending on the feature.

Absolutely, I'm not seriously suggesting the revert. I just did it locally
to confirm the issue I was seeing.

> Will I'd like your input on whether you feel a hack in the kernel
> is justified here.

If we can come up with something that we have confidence in and won't be a
pig to maintain, then I think we should do it, but otherwise we can go ahead
and change crosvm to mask out this feature flag on the vhost side for now.
We mainly wanted to raise the issue to illustrate that this flag continues
to attract problems in the hope that it might inform further usage and/or
spec work in this area.

In any case, I'm happy to test any kernel patches with our setup if you
want to give it a shot.

> Also yes, I think it's a good idea to change crosvm anyway.  While the
> work around I describe might make sense upstream I don't think it's a
> reasonable thing to do in stable kernels.
> I think I'll prepare a patch documenting the legal vhost features
> as a 1st step even though crosvm is rust so it's not importing
> the header directly, right?

Documentation is a good idea regardless, so thanks for that. Even though
crosvm has its own bindings for the vhost ioctl()s, the documentation
can be reference or duplicated once it's available in the kernel headers.

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
