Return-Path: <SRS0=zxqJ=OA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E98C433EF
	for <virtualization@archiver.kernel.org>; Fri, 10 Sep 2021 06:32:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E12F61100
	for <virtualization@archiver.kernel.org>; Fri, 10 Sep 2021 06:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4E12F61100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BD4B60644;
	Fri, 10 Sep 2021 06:32:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0nvIdxbE2Wqj; Fri, 10 Sep 2021 06:32:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8EDE6605F4;
	Fri, 10 Sep 2021 06:32:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 591E5C000F;
	Fri, 10 Sep 2021 06:32:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36ACBC000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 06:32:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F43240391
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 06:32:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GBXT2alkujJ0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 06:32:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D52E40370
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 06:32:51 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id a66so955026qkc.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Sep 2021 23:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wsf5hPUH3MYL5lrAiO50lKX+4L4mH3UTRgfpXirFAAc=;
 b=MqCiBW484db2PJ93autlPemRbVAD+dtdje6igzgdnXOevdZ8+oS7fRLZzImz5JgvHR
 WD7R9YxkJoiLVnXiSBRmBPSPqOISMirRnS9bohHAKYAC+Y0vOcJ8I7Ci0QIMU60chC4f
 Vpm2kTh3nhiStHP3XzBBTP87H4Yk6Tdwo28RGpX2/EIm+mPuRSQZ9B6Rhk2fwoSBuuX8
 9MaIyUDddS1m5RumUkcU9yyGBSNQbe+b2UR+t7Yl8h2EgcZeRtppHDKsdlO2yov9EU5d
 lDa6gFwMIv7hnxsMlX4OP4Zw4cKqUSdVuSpUfWzgFQq9PP/AQIfOGSVoryGeAKmcDveY
 /Teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wsf5hPUH3MYL5lrAiO50lKX+4L4mH3UTRgfpXirFAAc=;
 b=AlMBQsIei1DL+Xax0VJQNRFz0Vi+0QwCMffaCjXQN76bkKk9MJk8hg5W5VxTnlr4BP
 x591wx7KxXW0bufrmksnuV1M2Hd7GDZw1uFB6JyW9ow8P5M1j7lc2qBYj+N4ygjUlZRj
 EglNcbPNUIw5oeLtzAllzl0frv2bBjPprQvEskG721RSKF9QUdG+8NaevVyyRIbOXna/
 J0fa+PHJ3MV6e7557u/HbzhSGgb7MaYCbx2IH8gsROniO6BDwhzgRCswhsxzmsizgBXd
 ucbCR5BmNqEWSZMATGqIea2o5lQSQyzRmJcsyr0FZrWBVn5LsRZ4SJ8gzgay/v0Y0cEi
 hIKQ==
X-Gm-Message-State: AOAM533+cgE3/OnkfEbfVQQus1S0Ap83AAbawbaOGkBmo0HEIM71NayM
 h0QpAfWLR5/aNvTMEXIj4wGJ+YEPiOc2oQgwoX81jdQlby0qdrBk3B1s2Q==
X-Google-Smtp-Source: ABdhPJxqdfwJQrz4egs3WTw1rREh6nLLPa50d7pE/eI+qOfEwebXuNf0LVXhG896eTPiHPbk9X1g/3EqxxDE7UZ795c=
X-Received: by 2002:a05:620a:4042:: with SMTP id
 i2mr6511644qko.336.1631255570807; 
 Thu, 09 Sep 2021 23:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210901131434.31158-1-mgurtovoy@nvidia.com>
 <YTYvOetMHvocg9UZ@stefanha-x1.localdomain>
In-Reply-To: <YTYvOetMHvocg9UZ@stefanha-x1.localdomain>
From: Feng Li <lifeng1519@gmail.com>
Date: Fri, 10 Sep 2021 14:32:24 +0800
Message-ID: <CAEK8JBAz8Y6b1a2v+_EhXowdSEQgpv0CxmYX1kMP+wN8W1qOdA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] virtio-blk: avoid preallocating big SGL for data
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
 linux-block <linux-block@vger.kernel.org>, kvm@vger.kernel.org, mst@redhat.com,
 israelr@nvidia.com, virtualization@lists.linux-foundation.org,
 hch@infradead.org, nitzanc@nvidia.com, Jens Axboe <axboe@kernel.dk>,
 oren@nvidia.com
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

On Mon, Sep 6, 2021 at 11:39 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Wed, Sep 01, 2021 at 04:14:34PM +0300, Max Gurtovoy wrote:
> > No need to pre-allocate a big buffer for the IO SGL anymore. If a device
> > has lots of deep queues, preallocation for the sg list can consume
> > substantial amounts of memory. For HW virtio-blk device, nr_hw_queues
> > can be 64 or 128 and each queue's depth might be 128. This means the
> > resulting preallocation for the data SGLs is big.
> >
> > Switch to runtime allocation for SGL for lists longer than 2 entries.
> > This is the approach used by NVMe drivers so it should be reasonable for
> > virtio block as well. Runtime SGL allocation has always been the case
> > for the legacy I/O path so this is nothing new.
> >
> > The preallocated small SGL depends on SG_CHAIN so if the ARCH doesn't
> > support SG_CHAIN, use only runtime allocation for the SGL.
> >
> > Re-organize the setup of the IO request to fit the new sg chain
> > mechanism.
> >
> > No performance degradation was seen (fio libaio engine with 16 jobs and
> > 128 iodepth):
> >
> > IO size      IOPs Rand Read (before/after)         IOPs Rand Write (before/after)
> > --------     ---------------------------------    ----------------------------------
> > 512B          318K/316K                                    329K/325K
> >
> > 4KB           323K/321K                                    353K/349K
> >
> > 16KB          199K/208K                                    250K/275K
> >
> > 128KB         36K/36.1K                                    39.2K/41.7K
>
> I ran fio randread benchmarks with 4k, 16k, 64k, and 128k at iodepth 1,
> 8, and 64 on two vCPUs. The results look fine, there is no significant
> regression.
>
> iodepth=1 and iodepth=64 are very consistent. For some reason the
> iodepth=8 has significant variance but I don't think it's the fault of
> this patch.
>
> Fio results and the Jupyter notebook export are available here (check
> out benchmark.html to see the graphs):
>
> https://gitlab.com/stefanha/virt-playbooks/-/tree/virtio-blk-sgl-allocation-benchmark/notebook
>
> Guest:
> - Fedora 34
> - Linux v5.14
> - 2 vCPUs (pinned), 4 GB RAM (single host NUMA node)
> - 1 IOThread (pinned)
> - virtio-blk aio=native,cache=none,format=raw
> - QEMU 6.1.0
>
> Host:
> - RHEL 8.3
> - Linux 4.18.0-240.22.1.el8_3.x86_64
> - Intel(R) Xeon(R) Silver 4214 CPU @ 2.20GHz
> - Intel Optane DC P4800X
>
> Stefan

Reviewed-by: Feng Li <lifeng1519@gmail.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
