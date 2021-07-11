Return-Path: <SRS0=5BC2=MD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD52C07E96
	for <virtualization@archiver.kernel.org>; Sun, 11 Jul 2021 16:08:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2EF61175
	for <virtualization@archiver.kernel.org>; Sun, 11 Jul 2021 16:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2EF61175
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 516D6400A9;
	Sun, 11 Jul 2021 16:08:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id waBhTPq4Zn3i; Sun, 11 Jul 2021 16:08:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 99E4A40182;
	Sun, 11 Jul 2021 16:08:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E444C0010;
	Sun, 11 Jul 2021 16:08:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11682C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 16:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F422B834F1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 16:08:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pVUQh_L_04Jb
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 16:08:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 43B8683490
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626019726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=plvdWyXd4qV9pRAdncULs2MVIZL8MtO+i2JcuYf646o=;
 b=Ucn408Q1FoS3dzmyRF51WXK7I1TJSpir/307vw/dKN8h59NSXfS+q9I33wnEGz2fqyqtuX
 7vOtqD83eNU9CKr59feVOhqGf0/rSrImlAIoqKwAjNDo0rsIgT9zspqywMbajfu0iFnCYy
 scMKtuPTdTYyTVSRHCTPoNSzbu0dOsY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-NXTFmODAOyqP-z8BVRmWbQ-1; Sun, 11 Jul 2021 12:08:44 -0400
X-MC-Unique: NXTFmODAOyqP-z8BVRmWbQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 bx13-20020a0564020b4db02903a02214fad8so6284639edb.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 09:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=plvdWyXd4qV9pRAdncULs2MVIZL8MtO+i2JcuYf646o=;
 b=kaZzEbRVxcXuemyY20sfWkrOef50FR9hAb6K4qzg8QXJl4dyzCsMVoKHagL5oMDC7J
 UR/wx4SwiQJj0FamIEKqUlK90AbO+Mao3obeRzUZqilxgJgYv9Ee4jaAJcxWBUs3msjg
 ROML+H+yEruIuZFqYlL9OXALwUeOFyRXitc02///IB2mnOMMG1AcYFaccl7D869bRRgC
 eujCWzFQ1glaOt+ifo+5hqTasb+F7EyhnKJzZXuydFodLvTSB+WBGGGmYc+K6SRSutYV
 JbBjkDCUEDmEejbiUcWj0A5waxFD1TLs57gfVd/XnKIS3cSUL0s04+OqEMccQYCcH0LD
 3XEA==
X-Gm-Message-State: AOAM531i8jHzZwJ86+8l0Ar1U9eMEuFNJmNl2aGmKa28hajlh9R1/atJ
 /7S5YmLXg2AYu6XH+G+W9OqxPdQQGS7tklDxIIP662IN/CzpVIe1y+v6273UfaLIpog5Xa0uZ9I
 HHc1hsOTnbZeKYPSlCoMvQf5fOZOYBokosPzG+0pRiA==
X-Received: by 2002:a05:6402:334:: with SMTP id
 q20mr7782577edw.384.1626019723356; 
 Sun, 11 Jul 2021 09:08:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5DbXTPixgKQ7SAA5myg1QUAzpzti+8oHSmlPRSSCZOaBtsoWfnjplFHvrs4qVGWvzNiKsUw==
X-Received: by 2002:a05:6402:334:: with SMTP id
 q20mr7782566edw.384.1626019723238; 
 Sun, 11 Jul 2021 09:08:43 -0700 (PDT)
Received: from redhat.com ([2.55.136.76])
 by smtp.gmail.com with ESMTPSA id f12sm5266367ejz.99.2021.07.11.09.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jul 2021 09:08:42 -0700 (PDT)
Date: Sun, 11 Jul 2021 12:08:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/7] Do not read from descriptor ring
Message-ID: <20210711120824-mutt-send-email-mst@kernel.org>
References: <20210604055350.58753-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210604055350.58753-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: ashish.kalra@amd.com, ak@linux.intel.com, file@sect.tu-berlin.de,
 luto@kernel.org, kvm@vger.kernel.org, konrad.wilk@oracle.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, xieyongji@bytedance.com, stefanha@redhat.com
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

On Fri, Jun 04, 2021 at 01:53:43PM +0800, Jason Wang wrote:
> Hi:
> 
> The virtio driver should not trust the device. This beame more urgent
> for the case of encrtpyed VM or VDUSE[1]. In both cases, technology
> like swiotlb/IOMMU is used to prevent the poking/mangling of memory
> from the device. But this is not sufficient since current virtio
> driver may trust what is stored in the descriptor table (coherent
> mapping) for performing the DMA operations like unmap and bounce so
> the device may choose to utilize the behaviour of swiotlb to perform
> attacks[2].
> 
> To protect from a malicous device, this series store and use the
> descriptor metadata in an auxiliay structure which can not be accessed
> via swiotlb/device instead of the ones in the descriptor table. This
> means the descriptor table is write-only from the view of the driver.
> 
> Actually, we've almost achieved that through packed virtqueue and we
> just need to fix a corner case of handling mapping errors. For split
> virtqueue we just follow what's done in the packed.
> 
> Note that we don't duplicate descriptor medata for indirect
> descriptors since it uses stream mapping which is read only so it's
> safe if the metadata of non-indirect descriptors are correct.
> 
> For split virtqueue, the change increase the footprint due the the
> auxiliary metadata but it's almost neglectlable in simple test like
> pktgen and netperf TCP stream (slightly noticed in a 40GBE environment
> with more CPU usage).
> 
> Slightly tested with packed on/off, iommu on/of, swiotlb force/off in
> the guest.
> 
> Note that this series tries to fix the attack via descriptor
> ring. The other cases (used ring and config space) will be fixed by
> other series or patches.
> 
> Please review.

This needs a rebase - can you do it pls?

> Changes from RFC V2:
> - no code change
> - twaeak the commit log a little bit
> 
> Changes from RFC V1:
> - Always use auxiliary metadata for split virtqueue
> - Don't read from descripto when detaching indirect descriptor
> 
> Jason Wang (7):
>   virtio-ring: maintain next in extra state for packed virtqueue
>   virtio_ring: rename vring_desc_extra_packed
>   virtio-ring: factor out desc_extra allocation
>   virtio_ring: secure handling of mapping errors
>   virtio_ring: introduce virtqueue_desc_add_split()
>   virtio: use err label in __vring_new_virtqueue()
>   virtio-ring: store DMA metadata in desc_extra for split virtqueue
> 
>  drivers/virtio/virtio_ring.c | 201 +++++++++++++++++++++++++----------
>  1 file changed, 144 insertions(+), 57 deletions(-)
> 
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
