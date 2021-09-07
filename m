Return-Path: <SRS0=fvq/=N5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755A0C433F5
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 09:29:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7FC60F25
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 09:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B7FC60F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA4304010E;
	Tue,  7 Sep 2021 09:29:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mm6O7Vl-LGrB; Tue,  7 Sep 2021 09:29:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2B7F440111;
	Tue,  7 Sep 2021 09:29:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9E4BC000F;
	Tue,  7 Sep 2021 09:29:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E46CC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 09:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CDC040111
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 09:28:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UxmEP7UQdeZ2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 09:28:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FCC54010E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 09:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631006936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c+ELEzoQ4QAn8Ie286H/WnwUwtKE7bF9TZ17FSYZ65E=;
 b=ZBnjjgD88JOEx29JmXvTQkCyvlc2d2G03XtgZ7jQ0Aq8gK16yht03xnX2k7xYumPjROTYV
 u4/unRLzl1EWt3VIhLgjEfYmHxd0lO+XAuxooxdownfOlDej/cwy+EgR0BcAAXiWah+eje
 vS48SMxWnzXRTpZfoUhefSqTjE52nM8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-DvQC_vH0O6K0j3L4IKDoyg-1; Tue, 07 Sep 2021 05:28:54 -0400
X-MC-Unique: DvQC_vH0O6K0j3L4IKDoyg-1
Received: by mail-ed1-f69.google.com with SMTP id
 d25-20020a056402517900b003c7225c36c2so4986215ede.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Sep 2021 02:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=c+ELEzoQ4QAn8Ie286H/WnwUwtKE7bF9TZ17FSYZ65E=;
 b=n7XcLtI/Uk/J8IlZLDQah1fhn4NbN/BAB1LPgvz2y9LXW3ZUqkNNuSrp+DmwX+rf9Q
 Xngrfttm+0cfFrxKkU6ino7AJ/iUROiE3ECFK3GgI+BBSondIMX3h/Ytx4Rv2JkzELIg
 P4ZAmqXlR6Wv01EGCgIIhobjdBudJqEdWScYII1Fkl1e1JPIH6JTH2Kb0JZN00R15vkW
 kII+rJUwW2vWDfSLsBG7FPUoNBwFBUmUDgIoQRUmGqK3FE4GeX5NgcqVIl5rbYEbGapH
 YXPucuHUco4um5/fZZ9shUQgbXAtN89ZUUOVmXqYyliOuIe0XAGPyTfnbpkJyFdEdjo5
 RzqQ==
X-Gm-Message-State: AOAM5313ynMLPIs/YNTkMy5D9tnvIzHsoTdJuCyEC/6bDDnl6KMaZKS8
 09shoL9tqtYPnmm+M4Ger4xhxl0L4XiO74kMwQ7oyLc4Ps7r9tVI6N5cxusa14FN4VEodXcEXo8
 n657u+i+6yvGy0uUkx+dA6QabDSNA25kas6Q/6bNuNw==
X-Received: by 2002:a17:906:abcd:: with SMTP id
 kq13mr17989142ejb.195.1631006933042; 
 Tue, 07 Sep 2021 02:28:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMcKctpuayKd5CoMXMfA26llSiCRSTKNXTGJGOGy4mjgRMoo81oyolso+1R0iv2oiVG325ww==
X-Received: by 2002:a17:906:abcd:: with SMTP id
 kq13mr17989132ejb.195.1631006932878; 
 Tue, 07 Sep 2021 02:28:52 -0700 (PDT)
Received: from steredhat (host-79-51-2-59.retail.telecomitalia.it.
 [79.51.2.59])
 by smtp.gmail.com with ESMTPSA id 8sm5362506ejy.65.2021.09.07.02.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Sep 2021 02:28:52 -0700 (PDT)
Date: Tue, 7 Sep 2021 11:28:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] vdpa: potential uninitialized return in
 vhost_vdpa_va_map()
Message-ID: <20210907092849.hl56jaog7pouwxdn@steredhat>
References: <20210907073253.GB18254@kili>
MIME-Version: 1.0
In-Reply-To: <20210907073253.GB18254@kili>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xie Yongji <xieyongji@bytedance.com>,
 virtualization@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Tue, Sep 07, 2021 at 10:32:53AM +0300, Dan Carpenter wrote:
>The concern here is that "ret" can be uninitialized if we hit the
>"goto next" condition on every iteration through the loop.
>
>Fixes: 41ba1b5f9d4b ("vdpa: Support transferring virtual addressing during DMA mapping")
>Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>---
> drivers/vhost/vdpa.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>index d0c0fedf2c09..170166806714 100644
>--- a/drivers/vhost/vdpa.c
>+++ b/drivers/vhost/vdpa.c
>@@ -640,7 +640,7 @@ static int vhost_vdpa_va_map(struct vhost_vdpa *v,
> 	u64 offset, map_size, map_iova = iova;
> 	struct vdpa_map_file *map_file;
> 	struct vm_area_struct *vma;
>-	int ret;
>+	int ret = 0;
>
> 	mmap_read_lock(dev->mm);
>
>-- 
>2.20.1
>
>_______________________________________________
>Virtualization mailing list
>Virtualization@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
