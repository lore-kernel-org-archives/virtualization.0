Return-Path: <SRS0=Q5yb=F2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E25C433E0
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 19:14:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9CE23130
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 19:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9CE23130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 02C2D229D4;
	Tue, 22 Dec 2020 19:14:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z1ADnzWp+nSP; Tue, 22 Dec 2020 19:14:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 50DFB2042C;
	Tue, 22 Dec 2020 19:14:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 341E5C1787;
	Tue, 22 Dec 2020 19:14:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA31EC0893
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 19:13:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C36B387244
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 19:13:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a380fmEZ2Uhz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 19:13:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com
 [209.85.166.49])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 03E9E87228
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 19:13:58 +0000 (UTC)
Received: by mail-io1-f49.google.com with SMTP id q137so12917463iod.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 11:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=QJAkIaRAmbTjT49QW8oYv7QzM88P6GE6t4wSLLc/GcU=;
 b=aPF/YAZ9erWveRdWO/2hLJheEsEUVZm7epizh5j/VC7kd5b1Or/+tJGPitWc8dSQJP
 GYAtfRS/iPRCqfuJh9isOkZeiQaHR/W9ZPkmeyYncwIgToIvh4y8xmVs/5oK/tqpHpwj
 DICtixudSLvfYeRUBOCe0XmxF9mvT+NZwpUa5M36qLPwiW0Jlpze8AF/V0Ql5w9Q8O3W
 iOShXZkUa915bP42rj1Dmmjh3R4RqVNe7xyqCdswjsY1+7z8cdkhDh0KBMYV/9fVQFm8
 +CutoBZSQk7bBC50n1TqdRbxekHfa/PPIO3Fh2PHqlr9OAzu5NuuAc/fmBau3hVgVHb7
 SWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=QJAkIaRAmbTjT49QW8oYv7QzM88P6GE6t4wSLLc/GcU=;
 b=G6usF7A6nJZSKjlH7TzCAKuXKPSR5OpneX4UvhwP94i/+z37sS0fhGN9YjZQDSnHyo
 l0C5SUDf3jTUfkdUl/xH4u6tL5DxRclkex9btX5rH1fOrelUqjQeT4q20xOM6GZ3Y4e5
 5gn+X/LygigfMFQ7vY8sKQ/MqBMZ2Iv6l7245//D1NKxPjX9UCV3EJ6UNH9py/WlOtSK
 +oLKXR+tmUpXguLaSSfQ4/D6BgUebfP9LR4Ye20me7sNbAQucYODovyUQoAfEZZEt+Oa
 P+131WW6o1yOF8p1gNE9Ff6BjVZdIVV7oN1KetPuOM9rc2LNEdWA2CqSb2w5l4JCCiNO
 f5mQ==
X-Gm-Message-State: AOAM531N7TGkUCVXE7tgbIXFzLL8LF2J4BM2/pXixXBTtQ7Fmk4YQ8j5
 HT1Zts7xnze9gMxjtIp+HykHMx0GW6aS2WA3QUw=
X-Google-Smtp-Source: ABdhPJwiH4X66f06EOxSYK8GgRP7F1wU/QPbZByPqPm8NohKnqOwio5inBXgbitqxNy/JmW3UyhM48dXA4yo6r9vqWA=
X-Received: by 2002:a05:6602:150b:: with SMTP id
 g11mr18941096iow.88.1608664437267; 
 Tue, 22 Dec 2020 11:13:57 -0800 (PST)
MIME-Version: 1.0
References: <20201221162519.GA22504@open-light-1.localdomain>
In-Reply-To: <20201221162519.GA22504@open-light-1.localdomain>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 22 Dec 2020 11:13:46 -0800
Message-ID: <CAKgT0UcT8YafkMzGLV1Bnoys4qFsJP-e9cxLUEr_xQZKn1r+bg@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>, 
 Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>, 
 Andrea Arcangeli <aarcange@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>, 
 Liang Li <liliangleo@didiglobal.com>, linux-mm <linux-mm@kvack.org>, 
 LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
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

On Mon, Dec 21, 2020 at 8:25 AM Liang Li <liliang.opensource@gmail.com> wrote:
>
> The first version can be found at: https://lkml.org/lkml/2020/4/12/42
>
> Zero out the page content usually happens when allocating pages with
> the flag of __GFP_ZERO, this is a time consuming operation, it makes
> the population of a large vma area very slowly. This patch introduce
> a new feature for zero out pages before page allocation, it can help
> to speed up page allocation with __GFP_ZERO.
>
> My original intention for adding this feature is to shorten VM
> creation time when SR-IOV devicde is attached, it works good and the
> VM creation time is reduced by about 90%.
>
> Creating a VM [64G RAM, 32 CPUs] with GPU passthrough
> =====================================================
> QEMU use 4K pages, THP is off
>                   round1      round2      round3
> w/o this patch:    23.5s       24.7s       24.6s
> w/ this patch:     10.2s       10.3s       11.2s
>
> QEMU use 4K pages, THP is on
>                   round1      round2      round3
> w/o this patch:    17.9s       14.8s       14.9s
> w/ this patch:     1.9s        1.8s        1.9s
> =====================================================
>
> Obviously, it can do more than this. We can benefit from this feature
> in the flowing case:

So I am not sure page reporting is the best thing to base this page
zeroing setup on. The idea with page reporting is to essentially act
as a leaky bucket and allow the guest to drop memory it isn't using
slowly so if it needs to reinflate it won't clash with the
applications that need memory. What you are doing here seems far more
aggressive in that you are going down to low order pages and sleeping
instead of rescheduling for the next time interval.

Also I am not sure your SR-IOV creation time test is a good
justification for this extra overhead. With your patches applied all
you are doing is making use of the free time before the test to do the
page zeroing instead of doing it during your test. As such your CPU
overhead prior to running the test would be higher and you haven't
captured that information.

One thing I would be interested in seeing is what is the load this is
adding when you are running simple memory allocation/free type tests
on the system. For example it might be useful to see what the
will-it-scale page_fault1 tests look like with this patch applied
versus not applied. I suspect it would be adding some amount of
overhead as you have to spend a ton of time scanning all the pages and
that will be considerable overhead.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
