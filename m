Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F4FC25B08
	for <virtualization@archiver.kernel.org>; Fri,  5 Aug 2022 22:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0D4C83F54;
	Fri,  5 Aug 2022 22:57:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C0D4C83F54
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=PNM6Y8lm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MSS9SjNEjaq3; Fri,  5 Aug 2022 22:57:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 42CDB83F4F;
	Fri,  5 Aug 2022 22:57:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42CDB83F4F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13D64C0032;
	Fri,  5 Aug 2022 22:57:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12569C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 22:57:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D34E383F50
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 22:57:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D34E383F50
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mxk0_UOZYK1M
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 22:57:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CEDC983F4F
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CEDC983F4F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 22:57:27 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id s11so4995782edd.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Aug 2022 15:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=NC4cysuywW8XEpGdMjzU9OYVRS8Z3YSMAD203AMlbrk=;
 b=PNM6Y8lm9ttp+NtlMA+qdF4huhKjki+bO3qHRvhBcY+z3fHP/eUCW5t5Gi/UerFvRG
 kz0DAnJwoIcevopFDxtDsQgEAG8CrQpDfXEGOJ1PH0xz1l7AMECbSvLvUELV++v9xVlY
 H/TFMy3P0J0tlCY9z9/FBqus6oF44i1nNmUY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=NC4cysuywW8XEpGdMjzU9OYVRS8Z3YSMAD203AMlbrk=;
 b=nuSV/jAgXb1NponU8c1yD1QAwnkrXvyPKgHhgy4KBwCPLHor/7P+ZaCDnxJn9Zbytk
 Rj31MNpIBa0DJ3MDbpARJeFs5ghtRKNpq2mGLmJmsOe71QGBwoZ5RiAcpD8GJEJ9AVFf
 lBvJPI1UTnyXAJirhrS6gewE9+J+uOww9yxGkLNY3xuxtn8HezPi/oz/vdO+1Ct/vk8R
 s4z2f3gp/oKow8btYJNW6D1kgcBIpVDtSJjtbjphvnLW18tFDtegixabn20bYwA4S9Al
 XN3oBT1SqPXTTrXYWRmDjFT45kB6uz7h7uCJJkhu1P3xbNfINABkhB4Ftugoj5okdXcs
 39aQ==
X-Gm-Message-State: ACgBeo1RTuOIUIw6WmJ2NvesyYzSfGCPT5vL1qitDSQLNwX7nwbzD/VU
 N+UjLPgP2x4Csf8LxUXenGTmwNg0crBmzl89Uzs=
X-Google-Smtp-Source: AA6agR6JJB346iEeSDAP6sTHLVYsrdC0qrcrsprKof/xRB4/Mo8xVds0LVxtaPVsHYgddHPCJTQrDw==
X-Received: by 2002:a05:6402:440f:b0:435:2e63:aca9 with SMTP id
 y15-20020a056402440f00b004352e63aca9mr8383867eda.162.1659740245585; 
 Fri, 05 Aug 2022 15:57:25 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com.
 [209.85.128.53]) by smtp.gmail.com with ESMTPSA id
 11-20020a170906308b00b006fec4ee28d0sm2057501ejv.189.2022.08.05.15.57.25
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Aug 2022 15:57:25 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id
 p8-20020a05600c05c800b003a50311d75cso4095183wmd.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Aug 2022 15:57:24 -0700 (PDT)
X-Received: by 2002:a05:600c:1d94:b0:3a4:ffd9:bb4a with SMTP id
 p20-20020a05600c1d9400b003a4ffd9bb4amr5768966wms.8.1659740244625; Fri, 05 Aug
 2022 15:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220805181105.GA29848@willie-the-truck>
In-Reply-To: <20220805181105.GA29848@willie-the-truck>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Aug 2022 15:57:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wip-Lju3ZdNwknS6ouyw+nKXeRSnhqVyNo8WSEdk-BfGw@mail.gmail.com>
Message-ID: <CAHk-=wip-Lju3ZdNwknS6ouyw+nKXeRSnhqVyNo8WSEdk-BfGw@mail.gmail.com>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
To: Will Deacon <will@kernel.org>
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

On Fri, Aug 5, 2022 at 11:11 AM Will Deacon <will@kernel.org> wrote:
>
> [tl;dr a change from ~18 months ago breaks Android userspace and I don't
>  know what to do about it]

Augh.

I had hoped that android being "closer" to upstream would have meant
that somebody actually tests android with upstream kernels. People
occasionally talk about it, but apparently it's not actually done.

Or maybe it's done onl;y with a very limited android user space.

The whole "we notice that something that happened 18 months ago broke
our environment" is kind of broken.

> After some digging, we narrowed this change in behaviour down to
> e13a6915a03f ("vhost/vsock: add IOTLB API support") and further digging
> reveals that the infamous VIRTIO_F_ACCESS_PLATFORM feature flag is to
> blame. Indeed, our tests once again pass if we revert that patch (there's
> a trivial conflict with the later addition of VIRTIO_VSOCK_F_SEQPACKET
> but otherwise it reverts cleanly).

I have to say, this smells for *so* many reasons.

Why is "IOMMU support" called "VIRTIO_F_ACCESS_PLATFORM"?

That seems insane, but seems fundamental in that commit e13a6915a03f
("vhost/vsock: add IOTLB API support")

This code

        if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
                if (vhost_init_device_iotlb(&vsock->dev, true))
                        goto err;
        }

just makes me go "What?"  It makes no sense. Why isn't that feature
called something-something-IOTLB?

Can we please just split that flag into two, and have that odd
"platform access" be one bit, and the "enable iommu" be an entirely
different bit?

Now, since clearly nobody runs Android on newer kernels, I do think
that the actual bit number choice should probably be one that makes
the non-android use case binaries continue to work. And then the
android system binaries that use this could maybe be compiled to know
about *both* bits,. and work regardless?

I'm also hoping that maybe Google android people could actually do
some *testing*? I know, that sounds like a lot to ask, but humor me.
Even if the product team runs stuff that is 18 months old, how about
the dev team have a machine or two that actually tests current
kernels, so that it's not a "oh, a few years have passed, and now we
notice that a change doesn't work for us" situation any more.

Is that really too much to ask for a big company like google?

And hey, it's possible that the bit encoding is *so* incestuous that
it's really hard to split it into two. But it really sounds to me like
somebody mindlessly re-used a feature bit for a *completely* different
thing. Why?

Why have feature bits at all, when you then re-use the same bit for
two different features? It kind of seems to defeat the whole purpose.

                 Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
