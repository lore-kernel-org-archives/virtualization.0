Return-Path: <SRS0=IaGE=IX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6EBC433E0
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 11:08:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF3B46192D
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 11:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3B46192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6B87040540;
	Thu, 25 Mar 2021 11:08:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ANcD4_Ccn63; Thu, 25 Mar 2021 11:08:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0FF5640193;
	Thu, 25 Mar 2021 11:08:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E666BC000D;
	Thu, 25 Mar 2021 11:08:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3181C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 11:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A249C60B2A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 11:08:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2fNarsSuz66j
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 11:08:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A576960B1A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 11:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616670517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fKj3N7qjc3wKOxA3NoAZDiYAxmrNm7GOxG509L79+1k=;
 b=cu7S7EHiaulfggoULBC4P4taWnfY/OR6EnUoKO/WN792PjJI4fzLuch2hn/dlD6/F1Kntt
 OKVl8FLVZDRNllWHTLCmxa4/O2NpYGjA2GZwXyUbbIAZhol6X8bWokErwYdeNMaoDqO4sA
 hgWoGtnty2pz+sQgmurf/iAonWYij0Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-Hwcx-aJ9PDqQFb8X38Obcg-1; Thu, 25 Mar 2021 07:08:35 -0400
X-MC-Unique: Hwcx-aJ9PDqQFb8X38Obcg-1
Received: by mail-wr1-f70.google.com with SMTP id t16so2475282wrn.20
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 04:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fKj3N7qjc3wKOxA3NoAZDiYAxmrNm7GOxG509L79+1k=;
 b=mVaTQCaDErujBn/3jT21/klpXA2Z1QNs5V0MQYyoOM/sOT/6BV/LgCTQEXkmDvZDPK
 XZtyxJz9aidXZm6d0OfYeSKeOedZUMxj3Eds+9SBoNkyz9yifX6s+/0Dxz7UvJsf/72B
 bfke55W4iyR1u6KiSsgO1+ovFRjsxFiqazyhakyEejaO+fq3UQPei4sBKlgVru3yU6MD
 iHvziAyK0g3y8TtVr2SSlEV3LQDKqwCsVlV2/zpaXBSyRCJbZ/yA64/kgCfEElRWyGqV
 ehBxr1pAvlHS89fZ0FlPUUBm8gyt2v2GQ0s/dT7ywCT8e6folv7IVA2QaLAk8sMmbH3Q
 JTgQ==
X-Gm-Message-State: AOAM530EjnhhERuqfxiikHElVL/wBOB9VIyDlDPEdvQMm7yRK52ZSFIF
 mz7HLAmBopifJY52BkcN1BxxK+1d70VtpVNETmiKDm9QcHYq0MGk2DTWIR9ZxWfvbNUBybl9zDc
 AVeVvOj5GJNj7NLq41jz1WdZARoB6m5bjjqPBcY9oMQ==
X-Received: by 2002:a05:600c:204f:: with SMTP id
 p15mr7394503wmg.165.1616670514586; 
 Thu, 25 Mar 2021 04:08:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiEtLL2V7byI4WDi3Jbt4TeRDQzSQxBNNRwTIXQ/L2sd55YH0ycog2gsdgUk7sVz7dGg2BRg==
X-Received: by 2002:a05:600c:204f:: with SMTP id
 p15mr7394472wmg.165.1616670514357; 
 Thu, 25 Mar 2021 04:08:34 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id w22sm5958086wmi.22.2021.03.25.04.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 04:08:33 -0700 (PDT)
Date: Thu, 25 Mar 2021 12:08:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v5 03/11] vhost-vdpa: protect concurrent access to vhost
 device iotlb
Message-ID: <20210325110831.v57e4xg7twzzcu7n@steredhat>
References: <20210315053721.189-1-xieyongji@bytedance.com>
 <20210315053721.189-4-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210315053721.189-4-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, corbet@lwn.net, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, rdunlap@infradead.org, willy@infradead.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 bob.liu@oracle.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
 stefanha@redhat.com, linux-fsdevel@vger.kernel.org, dan.carpenter@oracle.com,
 mika.penttila@nextfour.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Mar 15, 2021 at 01:37:13PM +0800, Xie Yongji wrote:
>Use vhost_dev->mutex to protect vhost device iotlb from
>concurrent access.
>
>Fixes: 4c8cf318("vhost: introduce vDPA-based backend")
>Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>---
> drivers/vhost/vdpa.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)


Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
