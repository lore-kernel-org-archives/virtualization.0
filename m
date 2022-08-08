Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7EDC00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 12:46:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C33DF411C6;
	Mon,  8 Aug 2022 12:46:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C33DF411C6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EdXW0FF4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uXuako1ctSJ9; Mon,  8 Aug 2022 12:46:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 05146409B1;
	Mon,  8 Aug 2022 12:46:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 05146409B1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA1F8C0033;
	Mon,  8 Aug 2022 12:46:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 814FFC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:46:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 67A9A81CAD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:46:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 67A9A81CAD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EdXW0FF4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ymduaeq47ouo
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:45:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 99C2781C67
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 99C2781C67
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659962757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bIkebALpaCzzfrhDIO+eiB2cWrwHJfvl0+w6H8aCeL4=;
 b=EdXW0FF4JjeuO0Ej4xVDjjq/v3j87qBmjgQSvTtYWfdyeeNUhaU/vRAxDi5pgL1+w70wt8
 DXC0CjtgUpfn2bixxrw3eVqt4+Z3G9nckJupPYpcFm90qMXK0aGzZDwQD46wUr/3pT32fN
 IcFQIiZO4iBnHVbW1toMFA2j1Q07l9E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-243laOYZM8-giHm4ICfCLA-1; Mon, 08 Aug 2022 08:45:56 -0400
X-MC-Unique: 243laOYZM8-giHm4ICfCLA-1
Received: by mail-wm1-f70.google.com with SMTP id
 j22-20020a05600c485600b003a50fa6981bso6494533wmo.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Aug 2022 05:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=bIkebALpaCzzfrhDIO+eiB2cWrwHJfvl0+w6H8aCeL4=;
 b=0lMPDFnwZauWz/nYbliIuR7jzFseLCQefmcGkePpM96Vp8pmKuZWkwpnT+UO1pIslC
 ZgAQoNBJXHraG0/tx+fZ3p3+MzS0kKSVwLO+ptVezkl/21HQOrlGJHJWzvnuXmiDnn0O
 SzAbh//kv9NoM3JHpHW7kZa0Qr53RYLj49VUcY2rjnyf4peeRT1ERAVKi3Mtbe3McbZa
 xjZ6Vo3YWVmLk4ya8QUTMGGUlnbU7iJmHZ51hL8uxiaUYiN1J75rjJ8JNjgEnj63zxLR
 3EXHzRjdrMsQbETlq9Y/vYwBqEsx380zut91EFgpPw2A+xzgsDnzJQI0VjdDQIaDyVfr
 hd+w==
X-Gm-Message-State: ACgBeo0VahjrmPij4BsfuSw6M9G6dLq9FG/uEgHb59XnYMiHZ1ENaysF
 RXlL7jVVUlVqcLeMCJf8mCB4LE/BD5WD1XPsk9I+IQBToZnmM6nZSiFrB6w174lRXkZnWbKHjba
 ZWIsUxA2KmjB5ph+ZssKneaDwFErE+X0zC4HxpGzGbQ==
X-Received: by 2002:adf:edc1:0:b0:21d:7157:f4aa with SMTP id
 v1-20020adfedc1000000b0021d7157f4aamr11472386wro.454.1659962755060; 
 Mon, 08 Aug 2022 05:45:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7y23sTRwxFjBB3chjfhaxjBgzCe4ggCoRLOu7gMl1oiH8Vh+fKGZgk7NrsdFQfO8IwywQBsg==
X-Received: by 2002:adf:edc1:0:b0:21d:7157:f4aa with SMTP id
 v1-20020adfedc1000000b0021d7157f4aamr11472372wro.454.1659962754783; 
 Mon, 08 Aug 2022 05:45:54 -0700 (PDT)
Received: from redhat.com ([2.52.21.123]) by smtp.gmail.com with ESMTPSA id
 m8-20020a5d56c8000000b00222d4dfcdffsm1715765wrw.87.2022.08.08.05.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Aug 2022 05:45:53 -0700 (PDT)
Date: Mon, 8 Aug 2022 08:45:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <20220808083958-mutt-send-email-mst@kernel.org>
References: <20220805181105.GA29848@willie-the-truck>
 <20220807042408-mutt-send-email-mst@kernel.org>
 <20220808101850.GA31984@willie-the-truck>
MIME-Version: 1.0
In-Reply-To: <20220808101850.GA31984@willie-the-truck>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: jiyong@google.com, kvm@vger.kernel.org, kernel-team@android.com,
 maz@kernel.org, keirf@google.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, ascull@google.com,
 stefanha@redhat.com, crosvm-dev@chromium.org, torvalds@linux-foundation.org
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

On Mon, Aug 08, 2022 at 11:18:50AM +0100, Will Deacon wrote:
> Hi Michael,
> 
> On Sun, Aug 07, 2022 at 09:14:43AM -0400, Michael S. Tsirkin wrote:
> > Will, thanks very much for the analysis and the writeup!
> 
> No problem, and thanks for following up.
> 
> > On Fri, Aug 05, 2022 at 07:11:06PM +0100, Will Deacon wrote:
> > > So how should we fix this? One possibility is for us to hack crosvm to
> > > clear the VIRTIO_F_ACCESS_PLATFORM flag when setting the vhost features,
> > > but others here have reasonably pointed out that they didn't expect a
> > > kernel change to break userspace. On the flip side, the offending commit
> > > in the kernel isn't exactly new (it's from the end of 2020!) and so it's
> > > likely that others (e.g. QEMU) are using this feature.
> > 
> > Exactly, that's the problem.
> > 
> > vhost is reusing the virtio bits and it's only natural that
> > what you are doing would happen.
> > 
> > To be precise, this is what we expected people to do (and what QEMU does):
> > 
> > 
> > #define QEMU_VHOST_FEATURES ((1 << VIRTIO_F_VERSION_1) |
> > 			     (1 << VIRTIO_NET_F_RX_MRG) | .... )
> > 
> > VHOST_GET_FEATURES(... &host_features);
> > host_features &= QEMU_VHOST_FEATURES
> > VHOST_SET_FEATURES(host_features & guest_features)
> > 
> > 
> > Here QEMU_VHOST_FEATURES are the bits userspace knows about.
> > 
> > Our assumption was that whatever userspace enables, it
> > knows what the effect on vhost is going to be.
> > 
> > But yes, I understand absolutely how someone would instead just use the
> > guest features. It is unfortunate that we did not catch this in time.
> > 
> > 
> > In hindsight, we should have just created vhost level macros
> > instead of reusing virtio ones. Would address the concern
> > about naming: PLATFORM_ACCESS makes sense for the
> > guest since there it means "whatever access rules platform has",
> > but for vhost a better name would be VHOST_F_IOTLB.
> > We should have also taken greater pains to document what
> > we expect userspace to do. I remember now how I thought about something
> > like this but after coding this up in QEMU I forgot to document this :(
> > Also, I suspect given the history the GET/SET features ioctl and burned
> > wrt extending it and we have to use a new when we add new features.
> > All this we can do going forward.
> 
> Makes sense. The crosvm developers are also pretty friendly in my
> experience, so I'm sure they wouldn't mind being involved in discussions
> around any future ABI extensions. Just be aware that they _very_ recently
> moved their mailing lists, so I think it lives here now:
> 
> https://groups.google.com/a/chromium.org/g/crosvm-dev
> 
> > But what can we do about the specific issue?
> > I am not 100% sure since as Will points out, QEMU and other
> > userspace already rely on the current behaviour.
> > 
> > Looking at QEMU specifically, it always sends some translations at
> > startup, this in order to handle device rings.
> > 
> > So, *maybe* we can get away with assuming that if no IOTLB ioctl was
> > ever invoked then this userspace does not know about IOTLB and
> > translation should ignore IOTLB completely.
> 
> There was a similar suggestion from Stefano:
> 
> https://lore.kernel.org/r/20220806105225.crkui6nw53kbm5ge@sgarzare-redhat
> 
> about spotting the backend ioctl for IOTLB and using that to enable
> the negotiation of F_ACCESS_PLATFORM. Would that work for qemu?

Hmm I would worry that this disables the feature for old QEMU :(


> > I am a bit nervous about breaking some *other* userspace which actually
> > wants device to be blocked from accessing memory until IOTLB
> > has been setup. If we get it wrong we are making guest
> > and possibly even host vulnerable.
> > And of course just revering is not an option either since there
> > are now whole stacks depending on the feature.
> 
> Absolutely, I'm not seriously suggesting the revert. I just did it locally
> to confirm the issue I was seeing.
> 
> > Will I'd like your input on whether you feel a hack in the kernel
> > is justified here.
> 
> If we can come up with something that we have confidence in and won't be a
> pig to maintain, then I think we should do it, but otherwise we can go ahead
> and change crosvm to mask out this feature flag on the vhost side for now.
> We mainly wanted to raise the issue to illustrate that this flag continues
> to attract problems in the hope that it might inform further usage and/or
> spec work in this area.
> 
> In any case, I'm happy to test any kernel patches with our setup if you
> want to give it a shot.

Thanks!
I'm a bit concerned that the trick I proposed changes the configuration
where iotlb was not set up from "access to memory not allowed" to
"access to all memory allowed". This just might have security
implications if some application assumed the former.
And the one Stefano proposed disables IOTLB for old QEMU versions.



> > Also yes, I think it's a good idea to change crosvm anyway.  While the
> > work around I describe might make sense upstream I don't think it's a
> > reasonable thing to do in stable kernels.
> > I think I'll prepare a patch documenting the legal vhost features
> > as a 1st step even though crosvm is rust so it's not importing
> > the header directly, right?
> 
> Documentation is a good idea regardless, so thanks for that. Even though
> crosvm has its own bindings for the vhost ioctl()s, the documentation
> can be reference or duplicated once it's available in the kernel headers.
> 
> Will

So for crosvm change, I will post the documentation change and
you guys can discuss?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
