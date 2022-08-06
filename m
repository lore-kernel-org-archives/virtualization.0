Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA3BC25B0C
	for <virtualization@archiver.kernel.org>; Sat,  6 Aug 2022 09:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 878E383386;
	Sat,  6 Aug 2022 09:43:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 878E383386
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=io6jGK2e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JLVD-J1c3FMY; Sat,  6 Aug 2022 09:43:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 28D748300C;
	Sat,  6 Aug 2022 09:43:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 28D748300C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 117D5C0032;
	Sat,  6 Aug 2022 09:43:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82E38C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 09:43:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4ED2C40294
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 09:43:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4ED2C40294
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=io6jGK2e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZufUtOsmxpP1
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 09:43:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4CC5040258
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4CC5040258
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Aug 2022 09:43:09 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8BB0060DC9;
 Sat,  6 Aug 2022 09:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D6FC433D6;
 Sat,  6 Aug 2022 09:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659778988;
 bh=DG8963oGkbXx7+vUNEIN89246XtvxOsDYOhzpif+4Bw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=io6jGK2eLDlbNgZznh0Ml+gDbu6fzixfoCSL47VciYG0jkJktTJNV5U6ODlOag2D1
 SfxqOnCxchomXiDfDdbM0boizya5mW1o3S3EKHTxSa62vxV5KUptQiEOhHO+WcPWcN
 SD4+iNrrxzIhVUabAejBiec8+aBbrkbIdrPINdHwQV7w4G3IfVE2GQqoWOv1/SE2Tu
 /d7SfuZfdemcTZCVtff9izuNa+TiDG4PZdbYRgoqt8VajXSO/P4PUyBKZh8YSTtU69
 GiWxC1GhlpfYFT9wq4bOg10Twx1ni2lKLQHQCROFKDDImoq5HacC76ngLh2Q5WkWbS
 U0SXB8xCiscdQ==
Date: Sat, 6 Aug 2022 10:42:59 +0100
From: Will Deacon <will@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <20220806094258.GB30268@willie-the-truck>
References: <20220805181105.GA29848@willie-the-truck>
 <CAHk-=wip-Lju3ZdNwknS6ouyw+nKXeRSnhqVyNo8WSEdk-BfGw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wip-Lju3ZdNwknS6ouyw+nKXeRSnhqVyNo8WSEdk-BfGw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jiyong@google.com, kvm@vger.kernel.org, mst@redhat.com, maz@kernel.org,
 keirf@google.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, ascull@google.com,
 stefanha@redhat.com, kernel-team@android.com
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

On Fri, Aug 05, 2022 at 03:57:08PM -0700, Linus Torvalds wrote:
> On Fri, Aug 5, 2022 at 11:11 AM Will Deacon <will@kernel.org> wrote:
> >
> > [tl;dr a change from ~18 months ago breaks Android userspace and I don't
> >  know what to do about it]
> 
> Augh.
> 
> I had hoped that android being "closer" to upstream would have meant
> that somebody actually tests android with upstream kernels. People
> occasionally talk about it, but apparently it's not actually done.
> 
> Or maybe it's done onl;y with a very limited android user space.

We do actually test every -rc with Android (and run a whole bunch of
regression tests), this is largely using x86 builds for convenience
but we've been bringing up arm64 recently and are getting increasingly
more coverage there. So this _will_ improve and relatively soon.

The kicker in this case is that we'd only catch it on systems using pKVM
(arm64 host only; upstreaming ongoing) with restricted DMA (requires
device-tree) and so it slipped through. This is made more challenging
for CI because arm64 devices don't tend to have support for nested
virtualisation and so we have to run bare-metal but, as I say, we're
getting there.

> > After some digging, we narrowed this change in behaviour down to
> > e13a6915a03f ("vhost/vsock: add IOTLB API support") and further digging
> > reveals that the infamous VIRTIO_F_ACCESS_PLATFORM feature flag is to
> > blame. Indeed, our tests once again pass if we revert that patch (there's
> > a trivial conflict with the later addition of VIRTIO_VSOCK_F_SEQPACKET
> > but otherwise it reverts cleanly).
> 
> I have to say, this smells for *so* many reasons.
> 
> Why is "IOMMU support" called "VIRTIO_F_ACCESS_PLATFORM"?

It was already renamed once (!) It used to be VIRTIO_F_IOMMU_PLATFORM...

> That seems insane, but seems fundamental in that commit e13a6915a03f
> ("vhost/vsock: add IOTLB API support")
> 
> This code
> 
>         if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
>                 if (vhost_init_device_iotlb(&vsock->dev, true))
>                         goto err;
>         }
> 
> just makes me go "What?"  It makes no sense. Why isn't that feature
> called something-something-IOTLB?
> 
> Can we please just split that flag into two, and have that odd
> "platform access" be one bit, and the "enable iommu" be an entirely
> different bit?

Something along those lines makes sense to me, but it's fiddly because
the bits being used here are part of the virtio spec and we can't freely
allocate them in Linux. I reckon it would probably be better to have a
separate mechanism to enable IOTLB and not repurpose this flag for it.
Hindsight is a wonderful thing.

> And hey, it's possible that the bit encoding is *so* incestuous that
> it's really hard to split it into two. But it really sounds to me like
> somebody mindlessly re-used a feature bit for a *completely* different
> thing. Why?
> 
> Why have feature bits at all, when you then re-use the same bit for
> two different features? It kind of seems to defeat the whole purpose.

No argument here, and it's a big part of the reason I made the effort to
write this up. Yes, we hit this in Android. Yes, we should've hit it
sooner.  But is it specific to Android? No. Anybody wanting a guest to
use the DMA API for its virtio devices is going to be setting this flag
and if they implement the same algorithm as crosvm then they're going to
hit exactly the same problem that we did.

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
