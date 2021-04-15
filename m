Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05393C433B4
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 13:48:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7562613B4
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 13:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7562613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D1BB403FA;
	Thu, 15 Apr 2021 13:48:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CXN3Rm61HVks; Thu, 15 Apr 2021 13:48:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC726401BE;
	Thu, 15 Apr 2021 13:48:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96ED5C000B;
	Thu, 15 Apr 2021 13:48:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7418BC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 13:48:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 634594021B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 13:48:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dhwn9h-GN9Ke
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 13:48:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F2F340207
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 13:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618494525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QwQaOKgb78JkHs6ad6W1DSo80pvudYA+6ShjnGRvp3I=;
 b=hA8EwXySYbWglOJaesyraxkJamd8LH/Rw1zUkykC/S7i28pe6kGsgRlIffgB8f6OA2AR5y
 1/ZQLSxObrVZ2n4FZUjL6t7F++zkq4r0N2XSXgwzOoM/0GxmIrrkViUVjQLXYblG4VOj5R
 dMIoxQYmZvF5I8SrDHJ+LFfZUukzHyg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-VGARZrIDPhSfl2CixI0mJg-1; Thu, 15 Apr 2021 09:48:43 -0400
X-MC-Unique: VGARZrIDPhSfl2CixI0mJg-1
Received: by mail-ej1-f70.google.com with SMTP id
 ho12-20020a1709070e8cb029037000abbb92so949063ejc.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QwQaOKgb78JkHs6ad6W1DSo80pvudYA+6ShjnGRvp3I=;
 b=eb1YVG/9q3biGqYiLXzqDybnQQdu15M4bVAVboBB8/0qkg/jhNMR67dbXzDaSYOehu
 UkvYuvzAonluMyLe7us1pFxeePU8LI3mpknp4jjDkBhnbrTVoqOEYdX0oMaze6gXt2zt
 5XWqUWJfHfRI3uSrV0kTKXrZx1rVZIEM51jsy0/818cdEtXB0Ny0IXwLs4MpXuvk8scE
 oevv9Mz1CypZMfeSkkDHolI29kZVMzUezphRmQ/DYWZmNMbwezBc2RLL/RntJRDT1SAq
 FGf2ZBEhexJtfaVYkxBKzWKuAbR8rKnoLkTZwCTAINZQ+IUP4SBYPWxGPnmE02c/zyAg
 t/ZQ==
X-Gm-Message-State: AOAM533iqieNiFYS0dkkd8+elpxqVF/AmnzIyLD7DLZ+oX7aClgOgIDN
 CE4/tOs9RpneYxWIfHoGHByXHDK0mT+nkj4sZ+lHLdhsMF8QIyapuuyM1K96+zGVzxXriUrjRjB
 A6uP/NNj5cEJjoNWHyz7TmZkQ2nsPWNgUKps5QPG6xw==
X-Received: by 2002:a05:6402:270e:: with SMTP id
 y14mr4333840edd.283.1618494522360; 
 Thu, 15 Apr 2021 06:48:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOtgD4WdYc2KT9f0JKG73xwBG/uagcBhRoEFoQdUeQykyoHKeWJx+aqlCXoC29Ap77HRT5+Q==
X-Received: by 2002:a05:6402:270e:: with SMTP id
 y14mr4333823edd.283.1618494522219; 
 Thu, 15 Apr 2021 06:48:42 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id df8sm2608432edb.4.2021.04.15.06.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 06:48:41 -0700 (PDT)
Date: Thu, 15 Apr 2021 15:48:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH V2 3/3] vDPA/ifcvf: get_config_size should return dev
 specific config size
Message-ID: <20210415134838.3hn33estolycag4p@steredhat>
References: <20210415095336.4792-1-lingshan.zhu@intel.com>
 <20210415095336.4792-4-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20210415095336.4792-4-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Apr 15, 2021 at 05:53:36PM +0800, Zhu Lingshan wrote:
>get_config_size() should return the size based on the decected
>device type.
>
>Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>---
> drivers/vdpa/ifcvf/ifcvf_main.c | 18 +++++++++++++++++-
> 1 file changed, 17 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>index cea1313b1a3f..6844c49fe1de 100644
>--- a/drivers/vdpa/ifcvf/ifcvf_main.c
>+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>@@ -347,7 +347,23 @@ static u32 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
>
> static size_t ifcvf_vdpa_get_config_size(struct vdpa_device *vdpa_dev)
> {
>-	return sizeof(struct virtio_net_config);
>+	struct ifcvf_adapter *adapter = vdpa_to_adapter(vdpa_dev);
>+	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>+	struct pci_dev *pdev = adapter->pdev;
>+	size_t size;
>+
>+	if (vf->dev_type == VIRTIO_ID_NET)
>+		size = sizeof(struct virtio_net_config);
>+
>+	else if (vf->dev_type == VIRTIO_ID_BLOCK)
>+		size = sizeof(struct virtio_blk_config);
>+
>+	else {
>+		size = 0;
>+		IFCVF_ERR(pdev, "VIRTIO ID %u not supported\n", vf->dev_type);
>+	}

I slightly prefer the switch, but I don't have a strong opinion.

However, if we want to use if/else, we should follow 
`Documentation/process/coding-style.rst` line 166:
     Note that the closing brace is empty on a line of its own, **except** in
     the cases where it is followed by a continuation of the same statement,
     ie a ``while`` in a do-statement or an ``else`` in an if-statement, like

also `scripts/checkpatch.pl --strict` complains:

     CHECK: braces {} should be used on all arms of this statement
     #209: FILE: drivers/vdpa/ifcvf/ifcvf_main.c:355:
     +	if (vf->dev_type == VIRTIO_ID_NET)
     [...]
     +	else if (vf->dev_type == VIRTIO_ID_BLOCK)
     [...]
     +	else {
     [...]

     CHECK: Unbalanced braces around else statement
     #215: FILE: drivers/vdpa/ifcvf/ifcvf_main.c:361:
     +	else {

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
