Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A247C25B0C
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 03:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B62AA40499;
	Tue,  9 Aug 2022 03:13:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B62AA40499
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XShre5KG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9oVE8LyLJz5m; Tue,  9 Aug 2022 03:13:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 183CC4048A;
	Tue,  9 Aug 2022 03:13:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 183CC4048A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0D2AC0032;
	Tue,  9 Aug 2022 03:12:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA75EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 03:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 81B044048A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 03:12:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 81B044048A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AGFK2m6BqPLO
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 03:12:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6DC4440489
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DC4440489
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 03:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660014775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p7pA+XrnNoTq27MsRVHmfaaizOofAZ0f/q24EJV9Tu8=;
 b=XShre5KG+nsA26BewIAf2fNlQIlR6tcYkQNoUUs600Q8gO/2MHAPjGSOjmU2yL0p6GdDA6
 1yI3bqM+C2oYtnswaHY9zYs+vqQLlWDzE0zoxc05llN1TV150EJ73D6jeYIyyzg5MqroH7
 EcfxFEU2jIa1/2Ig3kHsb5iSHdQKv88=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-CU_rkgV6OAyxy_5zN0Bggw-1; Mon, 08 Aug 2022 23:12:52 -0400
X-MC-Unique: CU_rkgV6OAyxy_5zN0Bggw-1
Received: by mail-lj1-f199.google.com with SMTP id
 g3-20020a2e9cc3000000b00253cc2b5ab5so3016641ljj.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Aug 2022 20:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p7pA+XrnNoTq27MsRVHmfaaizOofAZ0f/q24EJV9Tu8=;
 b=DtjbvfIbpIfCC/OtrbnyKDQhpC8CZkgJJidm4AVq97H6O25FKAOi9RqoCaRkyJ+iMv
 0302zJO6mb6rsBwEe3qF0VQYlGA5C2CR3ceV/zJNYFMhEJxlGV7fzBwq5Q6nSZreRyzR
 FWKJ7t6op7ohJji0raLsm9TMo02ETJyA/yjnuXkl1aRDxmyhx4pnOXLAJ+Mi73v1OQet
 iLdHlboJceGp6348Bb3TLkDAEvFAWfLAJy3A6dP/FHgwp0Zv1oCWEx2iJQftR7KVuZJX
 bE7VtsaSA/kMOoUSFQYwyisdPLclVCpaDz0sA7T7fCbzJJWk2Vd7mLXTAwRWbd3pLv42
 m4NQ==
X-Gm-Message-State: ACgBeo3LTaOiKCDTW7PRv/nPcdR4NiuPZkXX4/QkeeihkGdOBEDtCqiw
 MwYtfgCusiTP0qoITL+TJ2RZ2PVoe3uykQbBKeFJLxLvTsf78Xvf8DAyRRbC5rIVOgrfKeTsSHw
 wfSZ9ICj3jUxmdk8piUHrouhfQ3w/4QLc58nbQgwAND+Jq5QeN64+02pGFg==
X-Received: by 2002:a2e:9e17:0:b0:25d:7654:4c6b with SMTP id
 e23-20020a2e9e17000000b0025d76544c6bmr6972614ljk.130.1660014770552; 
 Mon, 08 Aug 2022 20:12:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6boT+iBnbPVgXbWA6rjvFTGc9v5SjET/xDocWM+VDJq5V2uUoZJS7vWnr8ti+xkcDaQh9jq6hAvubkFqcxfHs=
X-Received: by 2002:a2e:9e17:0:b0:25d:7654:4c6b with SMTP id
 e23-20020a2e9e17000000b0025d76544c6bmr6972603ljk.130.1660014770167; Mon, 08
 Aug 2022 20:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220805181105.GA29848@willie-the-truck>
 <20220807042408-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220807042408-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Aug 2022 11:12:39 +0800
Message-ID: <CACGkMEtd_8gu7nMjLFmw7dcXJ0rvsQYiVcUdi3CaY-DBQ4=JZg@mail.gmail.com>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: jiyong@google.com, kvm <kvm@vger.kernel.org>, kernel-team@android.com,
 Will Deacon <will@kernel.org>, Keir Fraser <keirf@google.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>, ascull@google.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
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

On Sun, Aug 7, 2022 at 9:14 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Will, thanks very much for the analysis and the writeup!
>
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
>                              (1 << VIRTIO_NET_F_RX_MRG) | .... )
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

Yes, in the original patch it is called VHOST_F_DEVICE_IOTLB actually
to make it differ from virtio like VHOST_F_LOG_ALL etc. And I remember
I tried to post patch to avoid the bit duplication but the conclusion
is that it's too late for the changes.

> We should have also taken greater pains to document what
> we expect userspace to do. I remember now how I thought about something
> like this but after coding this up in QEMU I forgot to document this :(
> Also, I suspect given the history the GET/SET features ioctl and burned
> wrt extending it and we have to use a new when we add new features.
> All this we can do going forward.
>
>
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

I think this breaks the security assumptions of some setups.

>
> I am a bit nervous about breaking some *other* userspace which actually
> wants device to be blocked from accessing memory until IOTLB
> has been setup. If we get it wrong we are making guest
> and possibly even host vulnerable.

Yes.


> And of course just revering is not an option either since there
> are now whole stacks depending on the feature.
>
> Will I'd like your input on whether you feel a hack in the kernel
> is justified here.
>
> Also yes, I think it's a good idea to change crosvm anyway.  While the
> work around I describe might make sense upstream I don't think it's a
> reasonable thing to do in stable kernels.

+1

Thanks

> I think I'll prepare a patch documenting the legal vhost features
> as a 1st step even though crosvm is rust so it's not importing
> the header directly, right?
>
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
