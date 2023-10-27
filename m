Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A8FC25B47
	for <virtualization@archiver.kernel.org>; Fri, 27 Oct 2023 10:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 617857064D;
	Fri, 27 Oct 2023 10:16:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 617857064D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=DflqaZEw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kkgX5OBSEudK; Fri, 27 Oct 2023 10:16:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BEFAF60ACE;
	Fri, 27 Oct 2023 10:16:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BEFAF60ACE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9ADCDC0071;
	Fri, 27 Oct 2023 10:16:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B559C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 10:16:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 45FE9433B5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 10:16:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 45FE9433B5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=DflqaZEw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VVMEsdbDNvp5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 10:16:08 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC78C433BF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 10:16:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC78C433BF
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53e70b0a218so2879367a12.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 03:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1698401766; x=1699006566;
 darn=lists.linux-foundation.org; 
 h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
 :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
 bh=VD8qxUSefDVjPXgNPb04+1sZrR4xz+3Ht2LV1rsGWpY=;
 b=DflqaZEw/6UXi3yS1WHC2QiCLuR3TYvz5Rf8MWjtSj6ECR6eSZ6KJDRAk8tfv3Zwjv
 aoi0hu+7CcWnXCgVTXoNyLb1qvO7mYcgCYkxfmOOEnURL/bLTpGcYyCta7xhisCYyFSW
 ivfDWI2NTC6Nc1IE8WldFUJCjnGkF1FVJzL3Byd6U4WMs0/xe9yB9kBD+HWqlulDvb+C
 GxvvsnLrvxXgNF7kN9tv7fiTo4UvPSvte2kIYN0qPUVPpXQHm+DECcDkSuxwuKnnwRP2
 wpbx60b8jl/fX4DWBpt4HS9VHRGrknFNm+xmh9zdHaK3LvsRcf8MjNOrpDPzgfeGP/tm
 OWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698401766; x=1699006566;
 h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
 :user-agent:references:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VD8qxUSefDVjPXgNPb04+1sZrR4xz+3Ht2LV1rsGWpY=;
 b=Wm4Qw8v7es6QVhyElpzSRpAfJZAAuxnZyCO0ir+HyadM1rVhn/BT28rv/d3bWHEMiA
 sMZ4oOYillitS5cJXQcmqeIw569X/xk/9uqtj/MbkPWgLBUvLFf5WQjJEz+3CNtk5jVc
 lk9pZPgAPLzSZwswyoH5P552UL4LskGXmn1agKBuAZmxzX32Zf3NOQXLeVCP+nDT1Af4
 owDaDbRe+ruZv/GgSSqcCM0z8FfAK+iQryFgPReuWA8EAVI+fupYssdUchzKOmDxk13V
 KVEv1c4nFxgCir/OiLnW6spPGCtMKRhzNjXawibvy6XXTMqLkPZLY3l0sz3X1JLA+xWr
 YRPg==
X-Gm-Message-State: AOJu0YxM13ag5CtmfApHwP8mCCmm4sILct2YBFR/sXmeSiKTHT/twgPq
 MSsR1Nf5wstHY6j+LcT2PYL8lg==
X-Google-Smtp-Source: AGHT+IFfkizWmVU9WhARM2yRlhPHHxfYCuFmgAqgyUq5hVDUDfcXjYqHhdjR8kiXeJWlGUksz1K1wQ==
X-Received: by 2002:aa7:d653:0:b0:541:2bb8:7a9f with SMTP id
 v19-20020aa7d653000000b005412bb87a9fmr1972835edr.38.1698401765948; 
 Fri, 27 Oct 2023 03:16:05 -0700 (PDT)
Received: from cloudflare.com (79.184.154.62.ipv4.supernova.orange.pl.
 [79.184.154.62]) by smtp.gmail.com with ESMTPSA id
 y8-20020a50bb08000000b005400dc94f43sm1011571ede.45.2023.10.27.03.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 03:16:05 -0700 (PDT)
References: <20231025145319.380775-1-jakub@cloudflare.com>
 <87wmv91h3p.fsf@cloudflare.com>
 <20231026131830-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.6.10; emacs 28.3
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio_pci: Switch away from deprecated
 irq_set_affinity_hint
Date: Fri, 27 Oct 2023 12:03:17 +0200
In-reply-to: <20231026131830-mutt-send-email-mst@kernel.org>
Message-ID: <87sf5w1ica.fsf@cloudflare.com>
MIME-Version: 1.0
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
From: Jakub Sitnicki via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Oct 26, 2023 at 01:20 PM -04, Michael S. Tsirkin wrote:
> On Thu, Oct 26, 2023 at 06:25:08PM +0200, Jakub Sitnicki wrote:
>> On Wed, Oct 25, 2023 at 04:53 PM +02, Jakub Sitnicki wrote:
>> > Since commit 65c7cdedeb30 ("genirq: Provide new interfaces for affinity
>> > hints") irq_set_affinity_hint is being phased out.
>> >
>> > Switch to new interfaces for setting and applying irq affinity hints.
>> >
>> > Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> > ---
>> > v2:
>> >  - Leave cpumask_copy as is. We can't pass pointer to stack memory as hint.
>> >    Proposed a change to IRQ affinity interface to address this limitation:
>> >    https://lore.kernel.org/r/20231025141517.375378-1-jakub@cloudflare.com
>> 
>> Just a note to the ^ - if we wanted to get rid of msix_affinity_masks,
>> we could call irq_set_affinity directly, instead of calling it through
>> irq_set_affinity[_and]_hint.
>> 
>> The hint wouldn't be available any more in /proc/irq/N/affinity_hint,
>> but the same information can be gathered from /proc/irq/N/smp_affinity.
>> 
>> [...]
>
>
> So we are potentially breaking some userspace - what's the value we
> gain?  Is there some way we can make disable_irq/enable_irq work?
> That would have a lot of value.
> There is an actual need for that in virtio for coco but we can't use
> these APIs with affinity managed IRQs.

Sorry, that is beyond my ken today.

I saw the comment in vp_modern_disable_vq_and_reset:

	/* For the case where vq has an exclusive irq, call synchronize_irq() to
	 * wait for completion.
	 *
	 * note: We can't use disable_irq() since it conflicts with the affinity
	 * managed IRQ that is used by some drivers.
	 */

... but I fail to follow how the two conflict.

Perhaps Xuah could shed some light here.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
