Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E97C433F5
	for <virtualization@archiver.kernel.org>; Mon, 30 May 2022 15:49:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEBB841B3A;
	Mon, 30 May 2022 15:49:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WzuY__CB70ne; Mon, 30 May 2022 15:49:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F072D41B31;
	Mon, 30 May 2022 15:49:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCACCC0039;
	Mon, 30 May 2022 15:49:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5C05C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 15:49:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9FFFA83F11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 15:49:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BThrMX9bfu7O
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 15:49:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D125B83E09
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653925775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3rYstiXH+DFFxpN0eJSYZFfNb9vwPKdu6j6eGmXRMcc=;
 b=JAwscdthbr4lZNUQLHC9qcsZpFrGlkTIG+7bMauksNnlcrx0UHThjQId2sGhrhpPtjGp9W
 hpZ2i1jzucRKxNxKKAy+TgvFJrrDjyxZczBa3a7BeZ9P9OAVopEYUxsediyT6t0K8i1/XQ
 JN049SkwsCfa3LyA2L3GHjQjvxDcnmY=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-T1EdjxoFO6-nTfeL2yLUuw-1; Mon, 30 May 2022 11:49:24 -0400
X-MC-Unique: T1EdjxoFO6-nTfeL2yLUuw-1
Received: by mail-il1-f200.google.com with SMTP id
 x8-20020a056e021ca800b002d1332831deso8556355ill.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 08:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3rYstiXH+DFFxpN0eJSYZFfNb9vwPKdu6j6eGmXRMcc=;
 b=i2Z4KunZgCLlLcUh9Yi57Decmr1d8j61zw9+lick7n22PzsgNEJr7KiEKi/bbghoUV
 TU/ekzK/r3LnlL2MPW2E2AJw2IghaEzGOp7fNx7Kw/sgHhpKns5BUr9WpUzS0oRH2kCv
 fWKF2b282XoE7s3jD5oQuESNnvk68MnllNGUZeSG4r9RCASHUfmS0TSic22YOoSDf6RO
 4tIh6EONoz7pTUM1/NoGjRQ6YxNTTQ2cWHs/v24tkiV+X4B4saJYlWptZGUgNALnqVlM
 T3MRZBtM2/q1jnku2maLNJ3tFMuaAZ6mononS3Vo+pk2mVqz/jVjted9cfn1Kn9uEldq
 K0pw==
X-Gm-Message-State: AOAM533wLWnHK6aX+oj9cBRIig0tFO1TJzUUWm2+xfB0IBDxpjOSURcy
 ylRb9z0b4jwVseIuan1DcNj5YJposYnV/GwbkW6LYJZL/2ifvPWbVmVpdLc00Rts2rEg7iFtHaJ
 6AKXujMTUHTGzp8oP61s9GvWcvKLDwexqJToD5/KwKA==
X-Received: by 2002:a05:6e02:1c4e:b0:2d1:a8d:e94d with SMTP id
 d14-20020a056e021c4e00b002d10a8de94dmr29213931ilg.194.1653925763929; 
 Mon, 30 May 2022 08:49:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyavXgOOvyHvCgnhXUybuBh2qRd2Dsuuan5kKliX95y7YWU6WnNJ4Q63813uIsXDGIP+OZk1Q==
X-Received: by 2002:a05:6e02:1c4e:b0:2d1:a8d:e94d with SMTP id
 d14-20020a056e021c4e00b002d10a8de94dmr29213912ilg.194.1653925763620; 
 Mon, 30 May 2022 08:49:23 -0700 (PDT)
Received: from xz-m1.local
 (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a926014000000b002cde6e35302sm3764514ilb.76.2022.05.30.08.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 May 2022 08:49:22 -0700 (PDT)
Date: Mon, 30 May 2022 11:49:21 -0400
From: Peter Xu <peterx@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
Message-ID: <YpTngZ5Qr0KIvL0H@xz-m1.local>
References: <CAPcxDJ5pduUyMA0rf+-aTjK_2eBvig05UTiTptX1nVkWE-_g8w@mail.gmail.com>
 <Yo/I3oLkd9OU0ice@xz-m1.local>
 <24a95dea-9ea6-a904-7c0b-197961afa1d1@bytedance.com>
 <0d266c61-605d-ce0c-4274-b0c7e10f845a@redhat.com>
 <4b0c3e37-b882-681a-36fc-16cee7e1fff0@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <4b0c3e37-b882-681a-36fc-16cee7e1fff0@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mst@redhat.com, HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?=
 <naoya.horiguchi@nec.com>, LKML <linux-kernel@vger.kernel.org>,
 qemu-devel@nongnu.org, Linux MM <linux-mm@kvack.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 virtualization@lists.linux-foundation.org, Jue Wang <juew@google.com>
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

On Mon, May 30, 2022 at 07:33:35PM +0800, zhenwei pi wrote:
> A VM uses RAM of 2M huge page. Once a MCE(@HVAy in [HVAx,HVAz)) occurs, the
> 2M([HVAx,HVAz)) of hypervisor becomes unaccessible, but the guest poisons 4K
> (@GPAy in [GPAx, GPAz)) only, it may hit another 511 MCE ([GPAx, GPAz)
> except GPAy). This is the worse case, so I want to add
>  '__le32 corrupted_pages' in struct virtio_balloon_config, it is used in the
> next step: reporting 512 * 4K 'corrupted_pages' to the guest, the guest has
> a chance to isolate the other 511 pages ahead of time. And the guest
> actually loses 2M, fixing 512*4K seems to help significantly.

It sounds hackish to teach a virtio device to assume one page will always
be poisoned in huge page granule.  That's only a limitation to host kernel
not virtio itself.

E.g. there're upstream effort ongoing with enabling doublemap on hugetlbfs
pages so hugetlb pages can be mapped in 4k with it.  It provides potential
possibility to do page poisoning with huge pages in 4k too.  When that'll
be ready the assumption can go away, and that does sound like a better
approach towards this problem.

> 
> > 
> > I assume when talking about "the performance memory drops a lot", you
> > imply that this patch set can mitigate that performance drop?
> > 
> > But why do you see a performance drop? Because we might lose some
> > possible THP candidates (in the host or the guest) and you want to plug
> > does holes? I assume you'll see a performance drop simply because
> > poisoning memory is expensive, including migrating pages around on CE.
> > 
> > If you have some numbers to share, especially before/after this change,
> > that would be great.
> > 
> 
> The CE storm leads 2 problems I have even seen:
> 1, the memory bandwidth slows down to 10%~20%, and the cycles per
> instruction of CPU increases a lot.
> 2, the THR (/proc/interrupts) interrupts frequently, the CPU has to use a
> lot time to handle IRQ.

Totally no good knowledge on CMCI, but if 2) is true then I'm wondering
whether it's necessary to handle the interrupts that frequently.  When I
was reading the Intel CMCI vector handler I stumbled over this comment:

/*
 * The interrupt handler. This is called on every event.
 * Just call the poller directly to log any events.
 * This could in theory increase the threshold under high load,
 * but doesn't for now.
 */
static void intel_threshold_interrupt(void)

I think that matches with what I was thinking..  I mean for 2) not sure
whether it can be seen as a CMCI problem and potentially can be optimized
by adjust the cmci threshold dynamically.

-- 
Peter Xu

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
