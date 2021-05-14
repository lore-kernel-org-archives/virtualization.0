Return-Path: <SRS0=Tn2H=KJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24924C433ED
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 07:12:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA6A61446
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 07:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA6A61446
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D44C60636;
	Fri, 14 May 2021 07:12:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I8C87cyB3VpH; Fri, 14 May 2021 07:12:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEFC1605DC;
	Fri, 14 May 2021 07:12:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1A8CC000E;
	Fri, 14 May 2021 07:12:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63BA3C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 07:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D2814012D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 07:12:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lZyiFti-HcJS
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 07:12:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B56F4012A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 07:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620976348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=coVnp21qHs3g1zUzdD/v9oVQ2VSsjSE0G6biYzm153E=;
 b=RKrJrreNM1VFk/YGm2ekwddQRPSsA7adCf7EmDIyf0eSiS/0JZLrajrqwK41l4KGifE/T+
 rUeUm47klGEQU2YnM2D8+EhgFosRCH68tIh+CGRVAbnE7wMMGZN8waNHWVjDqOF2lmSmaf
 vy/FCgTHY/8W7r3MwbImn8fxfVvd8Ck=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-cCxNlY3FNqOJMXgT_6wBBA-1; Fri, 14 May 2021 03:12:25 -0400
X-MC-Unique: cCxNlY3FNqOJMXgT_6wBBA-1
Received: by mail-lj1-f198.google.com with SMTP id
 h1-20020a2e9ec10000b02900edf305c2e1so6045357ljk.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 00:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=coVnp21qHs3g1zUzdD/v9oVQ2VSsjSE0G6biYzm153E=;
 b=FvwFXuTNaNRagArHxyqF4BFrltYab50fuKvBuM3UsKrF1lrUNvXSGP8aH5itBBBe2D
 0kSQsuSBEdBkkWyKTmb+w9lm9sSbFyj09fQPEw/5GyhZXAevPtR/MmIo7WJN8n0MUy4S
 uSRy3WAWOyVXKGhRDtdqQ8F7G6xhi8gQzPY71HGJmEu6OyR0SwNA8wO4L5zHtUKLPE7Y
 rmdzhcpSEDPuvs9WnpVWOOIQYjyHdjffEpbD8K3NKVGKtZWtgica9Xr9ZUiaibVgJMCC
 xCzs/f2VWzR/W0rSoAutajD5psSnupP9WRfUzkg6hM/A0kHqf1z3x49GtbCBLC+aIihE
 lqDg==
X-Gm-Message-State: AOAM530m49t030NDdWSrYG0kgmynnKwPib4y7Uv8ZJDvmcG/9TYynHdr
 MOywwxdkIChkt6/2XKa9Xz5FQQ/g+qjziC9fmowrxYNTbUt0Qa069eVg5t6jmWOfVWgG8pm5OwN
 8Fe3z4G5+JlSMsGyuoQG/Cp7tehi7jvFtPYIOGlEYEdtGdqR6BfGkH3Mj3w==
X-Received: by 2002:ac2:43ac:: with SMTP id t12mr31034129lfl.258.1620976344386; 
 Fri, 14 May 2021 00:12:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5EyQYx5qCs6YL+71OUtGBJyqEb7whqcU6FBBTbi0dlrL1AGLNFUrL4i8UEYyd0Rm3HmYeZTm3uHUiQz6VaOM=
X-Received: by 2002:ac2:43ac:: with SMTP id t12mr31034107lfl.258.1620976344198; 
 Fri, 14 May 2021 00:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210208185558.995292-1-willemdebruijn.kernel@gmail.com>
 <CA+FuTSewRRBMkbdKzKoQv+E749jgcO9rgB4DsDTCJG2OcRQH5Q@mail.gmail.com>
In-Reply-To: <CA+FuTSewRRBMkbdKzKoQv+E749jgcO9rgB4DsDTCJG2OcRQH5Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 May 2021 15:12:09 +0800
Message-ID: <CACGkMEszcyhb+QXCuOeJcgDCDrLHVMQ6n6Z-1f2=DN+7+dKA=Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/4] virtio-net: add tx-hash, rx-tstamp, tx-tstamp
 and tx-time
To: Willem de Bruijn <willemb@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Network Development <netdev@vger.kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Fri, May 14, 2021 at 6:50 AM Willem de Bruijn <willemb@google.com> wrote:
>
> On Mon, Feb 8, 2021 at 1:56 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > From: Willem de Bruijn <willemb@google.com>
> >
> > RFCv2 for four new features to the virtio network device:
> >
> > 1. pass tx flow state to host, for routing + telemetry
> > 2. pass rx tstamp to guest, for better RTT estimation
> > 3. pass tx tstamp to guest, idem
> > 3. pass tx delivery time to host, for accurate pacing
> >
> > All would introduce an extension to the virtio spec.
> > Concurrently with code review I will write ballots to
> > https://www.oasis-open.org/committees/ballots.php?wg_abbrev=virtio
> >
> > These changes are to the driver side. Evaluation additionally requires
> > achanges to qemu and at least one back-end. I implemented preliminary
> > support in Linux vhost-net. Both patches available through github at
> >
> > https://github.com/wdebruij/linux/tree/virtio-net-txhash-2
> > https://github.com/wdebruij/qemu/tree/virtio-net-txhash-2
> >
> > Changes RFC -> RFCv2
> >   - add transmit timestamp patch
> >   - see individual patches for other changes
> >
> > Willem de Bruijn (4):
> >   virtio-net: support transmit hash report
> >   virtio-net: support receive timestamp
> >   virtio-net: support transmit timestamp
> >   virtio-net: support future packet transmit time
>
> Seeing Yuri's patchset adding new features reminded me that I did not
> follow-up on this patch series on the list.
>
> The patches themselves are mostly in good shape. The last tx tstamp
> issue can be resolved.
>
> But the device implementation I target only supports legacy mode.
> Below conversation that we had in one of the patches makes clear that
> supporting this in legacy is not feasible. Nor is upgrading that
> device in the short term. Until there is a device implementation that
> implements these offloads, these features are a dead letter. Not moving
> forward for now.
>
> Somewhat related: is there a plan for when we run out of 64 feature bits?

A quick thought: we need add (or reserve) a new feature bit to
indicate that we need more bits, and have transport specific
implementation of those extra bits negotiation. E.g for PCI, we can
introduce new fields in the capability.

Thanks

>
> > > > Actually, would it be possible to make new features available on
> > > > legacy devices? There is nothing in the features bits precluding it.
> > >
> > > I think it won't be possible: you are using feature bit 55,
> > > legacy devices have up to 32 feature bits. And of course the
> > > header looks a bit differently for legacy, you would have to add special
> > > code to handle that when mergeable buffers are off.
> >
> > I think I can make the latter work. I did start without a dependency
> > on the v1 header initially.
> >
> > Feature bit array length I had not considered. Good point. Need to
> > think about that. It would be very appealing if in particular the
> > tx-hash feature could work in legacy mode.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
