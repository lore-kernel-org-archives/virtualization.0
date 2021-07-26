Return-Path: <SRS0=Dg4u=MS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEBEC4320A
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 09:29:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CB460F02
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 09:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D9CB460F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A8959402B7;
	Mon, 26 Jul 2021 09:29:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XkpFj0wEATf7; Mon, 26 Jul 2021 09:29:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3E1224010E;
	Mon, 26 Jul 2021 09:29:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A565C001A;
	Mon, 26 Jul 2021 09:29:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 909FFC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:29:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F76340243
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:29:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bZKgxVdBVzo6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:29:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B263A401E5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627291787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VpxBo3UczXFpVeP5pHdpdgsu9E4RieUqE2581sjbAzU=;
 b=Ctv4AXlMEtEs6Iy/manF1QdxNYJ3J26iZ30Db91LT199OuVFekGoB89Wbo0YAm5wl8qBYX
 JXJVlO18G105FtlGoxQMMaDnNl+DbD7Xm54rEvW3Qxi9t6cGv7hLug8scybik7j7POxrsM
 0uA6DkXDlb+GqRl8TXkeb3Jw/xwEB0Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-m3CN1BB3Osi9KgUbZZ4QVg-1; Mon, 26 Jul 2021 05:29:46 -0400
X-MC-Unique: m3CN1BB3Osi9KgUbZZ4QVg-1
Received: by mail-ej1-f72.google.com with SMTP id
 gg35-20020a17090689a3b0290580ff45a075so831121ejc.20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 02:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VpxBo3UczXFpVeP5pHdpdgsu9E4RieUqE2581sjbAzU=;
 b=M4HaJTwgg7fvihO3HvwHnNJ4Jbx1a8GHtCxl0AegCaAPqoQ+chQ1fgz4srvDekVO/5
 4XD5wT58DiITerrvsXxI3RRbSo4+z+NINtSwO52LoZf+X3XZbFSJ5Bf3EEuZxuMzHqDy
 W6/l3YJ0m4NGTALKUCDKdBtYmCJlbYgdGMVMQ0tX+Q5UKqHZfpP/lGFN3EOUZtU2b2DA
 vz8fkZ641ZCIjqGMvPVsQaVZ506hf1do9rTdNqGl77ZZ6sR6EbZBXDm2jsKU20ovqhx9
 rf+/xkElFBCc4/hBF/7vz4FpzP1sF5p7EMuvxeNyZ2JZY2NYdnaAXjNvywzMkSLrzPDI
 Pa9w==
X-Gm-Message-State: AOAM531+xb9NouvEmGFkvfja9A5JP1QTzQkDFaQilUIRjug6viWEcKU3
 05xoRKv89sN9bEpVVNKB6r5akvD3QEMPk05JX09673kCURLYmA8sQ15FgAFTFns8JqpZI2H6wWd
 UVmFy006NuBe8GwFQGW3nOU2Ux2TaGRTpuuBOsWYHiA==
X-Received: by 2002:a17:906:f84a:: with SMTP id
 ks10mr15772496ejb.537.1627291785055; 
 Mon, 26 Jul 2021 02:29:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMEmdi8xJQjU6oStMXxQAZgGekDcKyG8uDyL0mkKdYpwEsm87S+Jh2cnw64hwZeitbYlDynQ==
X-Received: by 2002:a17:906:f84a:: with SMTP id
 ks10mr15772483ejb.537.1627291784923; 
 Mon, 26 Jul 2021 02:29:44 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id d4sm13887040ejy.86.2021.07.26.02.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jul 2021 02:29:44 -0700 (PDT)
Date: Mon, 26 Jul 2021 11:29:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH 4/4] vdpa: Add documentation for vdpa_alloc_device() macro
Message-ID: <20210726092942.cyh4djfevy7vcgjc@steredhat>
References: <20210715080026.242-1-xieyongji@bytedance.com>
 <20210715080026.242-4-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210715080026.242-4-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 dan.carpenter@oracle.com, mst@redhat.com
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

On Thu, Jul 15, 2021 at 04:00:26PM +0800, Xie Yongji wrote:
>The return value of vdpa_alloc_device() macro is not very
>clear, so that most of callers did the wrong check. Let's
>add some comments to better document it.
>
>Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>---
> include/linux/vdpa.h | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>
>diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>index 3357ac98878d..8cfe49d201dd 100644
>--- a/include/linux/vdpa.h
>+++ b/include/linux/vdpa.h
>@@ -277,6 +277,17 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
> 					const struct vdpa_config_ops *config,
> 					size_t size, const char *name);
>
>+/**
>+ * vdpa_alloc_device - allocate and initilaize a vDPA device
>+ *
>+ * @dev_struct: the type of the parent structure
>+ * @member: the name of struct vdpa_device within the @dev_struct
>+ * @parent: the parent device
>+ * @config: the bus operations that is supported by this device
>+ * @name: name of the vdpa device
>+ *
>+ * Return allocated data structure or ERR_PTR upon error
>+ */
> #define vdpa_alloc_device(dev_struct, member, parent, config, name)   \
> 			  container_of(__vdpa_alloc_device( \
> 				       parent, config, \
>-- 
>2.11.0
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
