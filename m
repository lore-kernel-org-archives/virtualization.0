Return-Path: <SRS0=+kt1=PK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411EEC433FE
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 09:16:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECAF61108
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 09:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DECAF61108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A36A2606C5;
	Fri, 22 Oct 2021 09:16:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ByP_rqku-50J; Fri, 22 Oct 2021 09:15:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3519D60629;
	Fri, 22 Oct 2021 09:15:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E52FC001F;
	Fri, 22 Oct 2021 09:15:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06299C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA87160665
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:15:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y4CgVwIqXZ2M
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:15:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D47AD60629
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634894155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G3cW3zoVlu4oi/52XaFtkNhCU8dR251sfiAlQbdZmxw=;
 b=VsBSEFrI65sryTfKimMmOuEcd8aQUYsvm93TygY6/ED2R/fJgiFd1kp48ysZFqyA9d4r3h
 8FqIsd3/nGVK3KOUEDbUfKyEt2ObTJQcpTE+v/TCZWtIutcx3P+DDYFYXSBuxEpnWNhhje
 Qmn1MvCqxFHQC33h7ylcvmWBK5ekeWo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-FhCYUJ6gPJmoacYJOtf_vQ-1; Fri, 22 Oct 2021 05:15:53 -0400
X-MC-Unique: FhCYUJ6gPJmoacYJOtf_vQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 k5-20020a7bc3050000b02901e081f69d80so746125wmj.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 02:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=G3cW3zoVlu4oi/52XaFtkNhCU8dR251sfiAlQbdZmxw=;
 b=5/Ekj1c9jKAXmXGDMV6Q0dUpZT9Qv9KSdF2Ph/vwqbI8I3w1cLKORCXsHaqVaoU5jF
 O3U8RIbqlarM0AwP1FZlddcAtpL6vXEcANCD3EXz43wOfMgBJtC8ifT9bys+97SlkKrC
 EEwvZqre9ReB7+4QNcUsFezBB+cupWWkWvttotHJ26ywcTCzFSQdO/P7TmicnmeR9wZ6
 zHxoVFk6Py2082HCtKmAP811Sro43AEpPtnMSDZwvT21JFrc5L+JqD3yIWymSkuFIXfM
 QH7PNDRjZv0eQ6iGaHL/c0WajvATjnXuEDcQAvKUXKZoyLCnGWxwCYrMZRgFeZJ6TkCx
 FkjA==
X-Gm-Message-State: AOAM532bmSoSAS4IXj3PAC054ZruSmUwCq3dOppd1BHVt5+pGnIm/on5
 PqOmhWqK81+oR5aiAlXvVOkVcwSglfUwtZjWXt+XzFA0jAUTxG+hNj5n1bcWj42zggU7rV212d1
 zghIIanBAthLIQ6O/RR/4Dno5lDx1CszBRuW8hCrUoQ==
X-Received: by 2002:adf:c986:: with SMTP id f6mr14715338wrh.216.1634894152798; 
 Fri, 22 Oct 2021 02:15:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9UzrJ47jd8AVMlb0zsnyhbeLN4MbCsLDsxpH5rzw33A79i6LywRRy6NMmtWFyEM7afYZFuw==
X-Received: by 2002:adf:c986:: with SMTP id f6mr14715317wrh.216.1634894152607; 
 Fri, 22 Oct 2021 02:15:52 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id q18sm10324419wmc.7.2021.10.22.02.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Oct 2021 02:15:51 -0700 (PDT)
Date: Fri, 22 Oct 2021 05:15:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v3 1/1] virtio-blk: avoid preallocating big SGL for data
Message-ID: <20211022051343-mutt-send-email-mst@kernel.org>
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

My tree is ok.
Looks like your patch was developed on top of some other tree,
not plan upstream linux, so git am fails. I applied it using
patch and some manual tweaking, and it seems to work for
me but please do test it in linux-next and confirm -
will push to a linux-next branch in my tree soon.

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
