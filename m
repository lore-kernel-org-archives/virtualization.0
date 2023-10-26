Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3ACDC25B67
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 17:21:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7008B42201;
	Thu, 26 Oct 2023 17:21:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7008B42201
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ahk67NXS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y5TMQS91lVZY; Thu, 26 Oct 2023 17:21:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E48014214D;
	Thu, 26 Oct 2023 17:21:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E48014214D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5777C0071;
	Thu, 26 Oct 2023 17:21:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5798BC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 17:21:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1EAEF42495
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 17:21:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1EAEF42495
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ahk67NXS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1wqLSiHY0zlv
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 17:20:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D34624012D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 17:20:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D34624012D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698340855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5kLaQtEOk7UbV1uqygBEcoktd0GtHWmaS2i+eVzn0zA=;
 b=ahk67NXStyH3aKane9/cxS4CxVRQz8dni4xdhY5NiTDe7jaKKujBKkUDVdMhOtAbslPGLy
 JzAls2uaK+F3OOp3w/HtifpMhXm1SsDQShzRNzs+n8vpCHRICZcpbyjw+Re4QCcw6gqTxv
 fJJrQRNfs9Y/coqpvOFEt6Pmlov/fsY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-8q2ye_a7OCy3uj9EwpLrsg-1; Thu, 26 Oct 2023 13:20:44 -0400
X-MC-Unique: 8q2ye_a7OCy3uj9EwpLrsg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507b8ac8007so1334396e87.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 10:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698340842; x=1698945642;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5kLaQtEOk7UbV1uqygBEcoktd0GtHWmaS2i+eVzn0zA=;
 b=wLmKmmCBcVFvmzm6wgG215kLJz7dakaOiUYuQ93RF9aWqA1RbwYZVOjSQN5kjyk2K1
 6LIyEUNTRvbw8Y7/asXZhm/cpiIzU+LcE8NaOgZT09dmmUw7hLnngDCnND8/Bia9uXHn
 V8dYCG+xiOfm9g7tv4BTBhCQvgR60Klpu6fOzwFup3PKPCvmnUik/2tvQAu98dluaSGD
 kXJ+LmkM/qUKJqR09d5FkJWKlLJJg1ncDKhrf4nacsrXJM3FMb1csZB5OR9m1l9ekzRV
 FN11uy9x+E25ws9nGUiyjGvCHdk899fBdoExfzt/RQ+BQUAuDo5dtOJcHsTRSUs61sOG
 Ybqg==
X-Gm-Message-State: AOJu0Ywu49ti8AJqFHItgPbd+SEUUHzdIWEkMVkUJhiAL+VChwsMg826
 x6KRNOQuWn9hVgzZmY74rckLxNCntUmuZqwkOTLuMLKem9vnyayuTmiOc28gkwCEwFotFoNc1/4
 PNRBfn2DwBaIxRb9jODTjSYpuXWYWf8TZ7oHsjcBZnA==
X-Received: by 2002:a19:771a:0:b0:507:9784:644c with SMTP id
 s26-20020a19771a000000b005079784644cmr13650lfc.26.1698340842617; 
 Thu, 26 Oct 2023 10:20:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBuY88F57kBvZ8DBFENBLOEu6PPi0md4h+oiVlvlZqcMwMkNddTglwsedLiad4JyDOl/3LWg==
X-Received: by 2002:a19:771a:0:b0:507:9784:644c with SMTP id
 s26-20020a19771a000000b005079784644cmr13641lfc.26.1698340842258; 
 Thu, 26 Oct 2023 10:20:42 -0700 (PDT)
Received: from redhat.com ([2.52.26.119]) by smtp.gmail.com with ESMTPSA id
 r6-20020a5d6946000000b00318147fd2d3sm14569272wrw.41.2023.10.26.10.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 10:20:41 -0700 (PDT)
Date: Thu, 26 Oct 2023 13:20:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: [PATCH v2] virtio_pci: Switch away from deprecated
 irq_set_affinity_hint
Message-ID: <20231026131830-mutt-send-email-mst@kernel.org>
References: <20231025145319.380775-1-jakub@cloudflare.com>
 <87wmv91h3p.fsf@cloudflare.com>
MIME-Version: 1.0
In-Reply-To: <87wmv91h3p.fsf@cloudflare.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kernel-team@cloudflare.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Thu, Oct 26, 2023 at 06:25:08PM +0200, Jakub Sitnicki wrote:
> On Wed, Oct 25, 2023 at 04:53 PM +02, Jakub Sitnicki wrote:
> > Since commit 65c7cdedeb30 ("genirq: Provide new interfaces for affinity
> > hints") irq_set_affinity_hint is being phased out.
> >
> > Switch to new interfaces for setting and applying irq affinity hints.
> >
> > Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> > ---
> > v2:
> >  - Leave cpumask_copy as is. We can't pass pointer to stack memory as hint.
> >    Proposed a change to IRQ affinity interface to address this limitation:
> >    https://lore.kernel.org/r/20231025141517.375378-1-jakub@cloudflare.com
> 
> Just a note to the ^ - if we wanted to get rid of msix_affinity_masks,
> we could call irq_set_affinity directly, instead of calling it through
> irq_set_affinity[_and]_hint.
> 
> The hint wouldn't be available any more in /proc/irq/N/affinity_hint,
> but the same information can be gathered from /proc/irq/N/smp_affinity.
> 
> [...]


So we are potentially breaking some userspace - what's the value we
gain?  Is there some way we can make disable_irq/enable_irq work?
That would have a lot of value.
There is an actual need for that in virtio for coco but we can't use
these APIs with affinity managed IRQs.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
