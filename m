Return-Path: <SRS0=Wmx8=KA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02629C433B4
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 20:11:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FABE613AA
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 20:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FABE613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4AC37405F3;
	Wed,  5 May 2021 20:11:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V3eQmE5otKaz; Wed,  5 May 2021 20:11:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B50AF405E4;
	Wed,  5 May 2021 20:11:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EC5EC000D;
	Wed,  5 May 2021 20:11:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE971C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 20:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 979D7405EE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 20:11:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wIUfXDoMVkpl
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 20:11:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99FFA405EB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 20:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620245462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GBjBuvXE2zdfbkNFPE3Y99JvsZ5ACCeZzTetq8hkZVc=;
 b=K8PqxHXmXv46Qtscyj7xQtgeT+vnsjjJe47SEGcr1K1CXx4womGbW8K46Z/4GxsomFIDtv
 eDFwsNdpFsfQc1Ith7avBh1lm24ajAYGXM+77iWOSEhP8IAgXdywL+cwgK93LyJ1PX50Y9
 al+PjyjC3Xj8q+9wuk9UVh6IltSj/gw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-lcMFB4OWMfeKin_yRsy_Tw-1; Wed, 05 May 2021 16:11:00 -0400
X-MC-Unique: lcMFB4OWMfeKin_yRsy_Tw-1
Received: by mail-wr1-f70.google.com with SMTP id
 93-20020adf80e60000b0290106fab45006so1135306wrl.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 May 2021 13:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GBjBuvXE2zdfbkNFPE3Y99JvsZ5ACCeZzTetq8hkZVc=;
 b=uO5BOItQkWsm7MBnmfTLwZI3L6mcZ0Q0CW8UQfCtX8YaGQC5iDa9Q3yXtl81iTfTq2
 e/tEpkWmfLbc8r7JhBTLQwKLI2TV1Dfy56IMIUtxAXZaWiYyP70Bmx3kerfJLZlTtKfw
 QO8qfkDC8nU2w2TVTUusH4k2jfoQfAu26pNpHc+TSG8uUJxRZWPIcpkUx02a8/jYsijk
 Jn44fBWyViX6+AqAvqHCW3cdvDWEAV6WKkdLJPSDIxUUWT156Ikofc44YWIC3BqKtI98
 9LHO6g+ii8LiVE73d7MP9KAKYdAP/A3Y/UOtFb3aoG1elj6uX7vi23Eswig8i4imNt2a
 T/Ig==
X-Gm-Message-State: AOAM531FlVXqd0AtYu9L5e1bsPOhTJsyTqnyEibNtVHeuolbbg4CaWw3
 owEJuHYyLAGhebCzNGnM6V+dGOd3xBY2wvAg4LDEHtOxrqtO6uqKs5n3D123heS60FaHpLm0r+p
 cXdETxidj650jfqRoeI1zbaFWQKvTBqLsqjR0pU89Yw==
X-Received: by 2002:adf:8b02:: with SMTP id n2mr791493wra.259.1620245459320;
 Wed, 05 May 2021 13:10:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDflhaV7bAW0iap9r6++Bu8H9qbZHW9/oqickGwKuCFU5RhENuf37swcdkBGO2bwY6uiQ9Mw==
X-Received: by 2002:adf:8b02:: with SMTP id n2mr791483wra.259.1620245459202;
 Wed, 05 May 2021 13:10:59 -0700 (PDT)
Received: from redhat.com ([2a10:800c:8fce:0:8e1b:40f0:6a74:513b])
 by smtp.gmail.com with ESMTPSA id p5sm372953wma.45.2021.05.05.13.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 May 2021 13:10:58 -0700 (PDT)
Date: Wed, 5 May 2021 16:10:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Provide detailed specification of virtio-blk lifetime
 metrics
Message-ID: <20210505161022-mutt-send-email-mst@kernel.org>
References: <20210420162556.217350-1-egranata@google.com>
 <20210505054314.GA4179527@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20210505054314.GA4179527@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-block@vger.kernel.org, virtio-dev@lists.oasis-open.org,
 Enrico Granata <egranata@google.com>,
 virtualization@lists.linux-foundation.org
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

On Wed, May 05, 2021 at 06:43:14AM +0100, Christoph Hellwig wrote:
> On Tue, Apr 20, 2021 at 04:25:56PM +0000, Enrico Granata wrote:
> > In the course of review, some concerns were surfaced about the
> > original virtio-blk lifetime proposal, as it depends on the eMMC
> > spec which is not open
> > 
> > Add a more detailed description of the meaning of the fields
> > added by that proposal to the virtio-blk specification, as to
> > make it feasible to understand and implement the new lifetime
> > metrics feature without needing to refer to JEDEC's specification
> > 
> > This patch does not change the meaning of those fields nor add
> > any new fields, but it is intended to provide an open and more
> > clear description of the meaning associated with those fields.
> > 
> > Signed-off-by: Enrico Granata <egranata@google.com>
> 
> Still not a fan of the encoding, but at least it is properly documented
> now:
> 
> Acked-by: Christoph Hellwig <hch@lst.de>

With that, would you like to ack the virtip-blk patch too?
The format didn't actually change ...

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
