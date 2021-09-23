Return-Path: <SRS0=2rcL=ON=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ADEC433FE
	for <virtualization@archiver.kernel.org>; Thu, 23 Sep 2021 15:37:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A5461038
	for <virtualization@archiver.kernel.org>; Thu, 23 Sep 2021 15:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 39A5461038
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 057C140713;
	Thu, 23 Sep 2021 15:37:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CedIZP-FOFJA; Thu, 23 Sep 2021 15:37:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7C71F40712;
	Thu, 23 Sep 2021 15:37:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56A90C0011;
	Thu, 23 Sep 2021 15:37:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E892C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 15:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B15983FBA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 15:37:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p06dULO14559
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 15:37:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D074683FB1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632411471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AOSJdORroeY+L8lMWoT/k2QmeHNRD0UxneSQj0X18oA=;
 b=SGKrJ72+QbZsCz2Wc4n0VFxztRC18W23zMWtMguGb39HpIuvz5HGcKUdCV3S8HhStgEZYg
 41it/F7g6noEjsPXtm6KfN0lK8nBfW3EuIdEc5BOVI59svTQRH4x2BpSxUiItGW5ltxRvU
 blViAp4dnPtzuECSNu3yBzeIv4pIxzc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-8aCZbVKrNaibxdUGsgKdxA-1; Thu, 23 Sep 2021 11:37:49 -0400
X-MC-Unique: 8aCZbVKrNaibxdUGsgKdxA-1
Received: by mail-ed1-f70.google.com with SMTP id
 a6-20020a50c306000000b003da30a380e1so2485288edb.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 08:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AOSJdORroeY+L8lMWoT/k2QmeHNRD0UxneSQj0X18oA=;
 b=W1ubCiZOKN0BLZJ3s3vepWh5OSAAG1wkxLhx+j5w9eSqKlKxGlVHq2qcHHOQKw3MkD
 mXhmmg0hMgPV9Ka9OR9fKdJeWp2yTfYtVEJdHIBIjcWhb0Pmbo+FmugqHVjnbg1DsAu4
 VOjAWzFpyX5023zOtyhf7Zf0cfgfw6bavXLsH9jiICQSqjuSC1Ut3N3xVqyBoAwCNp9o
 LFcPpVPlZ7RJJ0Bhs+PUPZwxKHoAsNrW/qnSAE4D21Ca/+4mwbk+Zxy4l9gwsvhO7MQH
 OAyn9PGM0zDn2djxI8iW8IN3rZKDjoB82id0hV6ymE18n5wqgMKE9V5AijYKUqcTgbXG
 lHCg==
X-Gm-Message-State: AOAM533A+wq9SS3rsLtTQUoULuD6x/GTOaAa8S+4o6s4vi7LRpqLcSo4
 +3iW+e4+QZdCNsSe9nIE3CPvNm+pWPi4ymaW2972HB9wDFpNdFmCIvPfivCg2lJ2hxbeaS8gpWG
 2g3huWrF8RhsDnd07Y+/bcpiZ8+y8Fn80cW9pQGA/og==
X-Received: by 2002:a50:d84c:: with SMTP id v12mr6078247edj.201.1632411468255; 
 Thu, 23 Sep 2021 08:37:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8DaBe4I+LkOVyQLu6cfQoWkqvgiBaOR5+1qn3bcBVQnRix8ZU/+hekqhUIynodgC4qCiRWw==
X-Received: by 2002:a50:d84c:: with SMTP id v12mr6078219edj.201.1632411468054; 
 Thu, 23 Sep 2021 08:37:48 -0700 (PDT)
Received: from redhat.com ([2.55.11.56])
 by smtp.gmail.com with ESMTPSA id d3sm3738711edv.87.2021.09.23.08.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Sep 2021 08:37:47 -0700 (PDT)
Date: Thu, 23 Sep 2021 11:37:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v3 1/1] virtio-blk: avoid preallocating big SGL for data
Message-ID: <20210923113644-mutt-send-email-mst@kernel.org>
References: <20210901131434.31158-1-mgurtovoy@nvidia.com>
 <YTYvOetMHvocg9UZ@stefanha-x1.localdomain>
 <692f8e81-8585-1d39-e7a4-576ae01438a1@nvidia.com>
 <YUCUF7co94CRGkGU@stefanha-x1.localdomain>
 <56cf84e2-fec0-08e8-0a47-24bb1df71883@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <56cf84e2-fec0-08e8-0a47-24bb1df71883@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 kvm@vger.kernel.org, israelr@nvidia.com,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 nitzanc@nvidia.com, Stefan Hajnoczi <stefanha@redhat.com>, oren@nvidia.com
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

OK by me.
Acked-by: Michael S. Tsirkin <mst@redhat.com>

I will queue it for the next kernel.
Thanks!


On Thu, Sep 23, 2021 at 04:40:56PM +0300, Max Gurtovoy wrote:
> Hi MST/Jens,
> 
> Do we need more review here or are we ok with the code and the test matrix ?
> 
> If we're ok, we need to decide if this goes through virtio PR or block PR.
> 
> Cheers,
> 
> -Max.
> 
> On 9/14/2021 3:22 PM, Stefan Hajnoczi wrote:
> > On Mon, Sep 13, 2021 at 05:50:21PM +0300, Max Gurtovoy wrote:
> > > On 9/6/2021 6:09 PM, Stefan Hajnoczi wrote:
> > > > On Wed, Sep 01, 2021 at 04:14:34PM +0300, Max Gurtovoy wrote:
> > > > > No need to pre-allocate a big buffer for the IO SGL anymore. If a device
> > > > > has lots of deep queues, preallocation for the sg list can consume
> > > > > substantial amounts of memory. For HW virtio-blk device, nr_hw_queues
> > > > > can be 64 or 128 and each queue's depth might be 128. This means the
> > > > > resulting preallocation for the data SGLs is big.
> > > > > 
> > > > > Switch to runtime allocation for SGL for lists longer than 2 entries.
> > > > > This is the approach used by NVMe drivers so it should be reasonable for
> > > > > virtio block as well. Runtime SGL allocation has always been the case
> > > > > for the legacy I/O path so this is nothing new.
> > > > > 
> > > > > The preallocated small SGL depends on SG_CHAIN so if the ARCH doesn't
> > > > > support SG_CHAIN, use only runtime allocation for the SGL.
> > > > > 
> > > > > Re-organize the setup of the IO request to fit the new sg chain
> > > > > mechanism.
> > > > > 
> > > > > No performance degradation was seen (fio libaio engine with 16 jobs and
> > > > > 128 iodepth):
> > > > > 
> > > > > IO size      IOPs Rand Read (before/after)         IOPs Rand Write (before/after)
> > > > > --------     ---------------------------------    ----------------------------------
> > > > > 512B          318K/316K                                    329K/325K
> > > > > 
> > > > > 4KB           323K/321K                                    353K/349K
> > > > > 
> > > > > 16KB          199K/208K                                    250K/275K
> > > > > 
> > > > > 128KB         36K/36.1K                                    39.2K/41.7K
> > > > I ran fio randread benchmarks with 4k, 16k, 64k, and 128k at iodepth 1,
> > > > 8, and 64 on two vCPUs. The results look fine, there is no significant
> > > > regression.
> > > > 
> > > > iodepth=1 and iodepth=64 are very consistent. For some reason the
> > > > iodepth=8 has significant variance but I don't think it's the fault of
> > > > this patch.
> > > > 
> > > > Fio results and the Jupyter notebook export are available here (check
> > > > out benchmark.html to see the graphs):
> > > > 
> > > > https://gitlab.com/stefanha/virt-playbooks/-/tree/virtio-blk-sgl-allocation-benchmark/notebook
> > > > 
> > > > Guest:
> > > > - Fedora 34
> > > > - Linux v5.14
> > > > - 2 vCPUs (pinned), 4 GB RAM (single host NUMA node)
> > > > - 1 IOThread (pinned)
> > > > - virtio-blk aio=native,cache=none,format=raw
> > > > - QEMU 6.1.0
> > > > 
> > > > Host:
> > > > - RHEL 8.3
> > > > - Linux 4.18.0-240.22.1.el8_3.x86_64
> > > > - Intel(R) Xeon(R) Silver 4214 CPU @ 2.20GHz
> > > > - Intel Optane DC P4800X
> > > > 
> > > > Stefan
> > > Thanks, Stefan.
> > > 
> > > Would you like me to add some of the results in my commit msg ? or Tested-By
> > > sign ?
> > Thanks, there's no need to change the commit description.
> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Tested-by: Stefan Hajnoczi <stefanha@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
