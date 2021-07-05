Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B64BC07E99
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 15:51:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2BD26196A
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 15:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BD26196A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F900608A1;
	Mon,  5 Jul 2021 15:51:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aPzbncHTxVgE; Mon,  5 Jul 2021 15:51:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 505BE605B3;
	Mon,  5 Jul 2021 15:51:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2150FC0010;
	Mon,  5 Jul 2021 15:51:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB5E1C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 15:51:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AEAA3403AD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 15:51:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SuKz3iYpuJkj
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 15:51:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A6A80403A0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625500299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=26ujWV3iaTeltft8yvSHJqU2fP8edooVCaKqVkKh4l0=;
 b=hy7aWNqJFA7Lao4QOU3a4MAv6CfvSinxkrfJVDsXl2LW9gb8cnuwRFuMEc5h0PKEmIHn05
 6bRT9aTsl1+czMdGrVlJFiXznmpj/FlP+LwvWroWZfGCP8ZHyr/V3Zyz+pcfvZzDBZQgiX
 WK/NBLmNicgcLxJnxqlPv8MNKfJDG/4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-wKmFhQQUPIiKzah9A8psRQ-1; Mon, 05 Jul 2021 11:51:38 -0400
X-MC-Unique: wKmFhQQUPIiKzah9A8psRQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 u64-20020a1cdd430000b02901ed0109da5fso10030733wmg.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 08:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=26ujWV3iaTeltft8yvSHJqU2fP8edooVCaKqVkKh4l0=;
 b=MLYrCz4xU6u2IBdh18H0AVm2wXaSXLjvNLykN3L52guI7nPcco0aK9rP3IrwvyByoF
 3PzFm/MqV4hkijF/CtqOaVF3yImtvIkmZLYtA0So2kIxJYgZkNz/JGgJ2E/FkxYXDcfL
 FlLuO8nWQvDb14YnIfuqOyN11jvKU3dvh0ficzyjBiChln+FK2ozZ1NFvrZV+sdHErg2
 29JbkbnhAMGgJ6sg1dBRzuCzutUG16holL2bnRB3JKGiKyQosP8feE71xhvaamiQF//Q
 dym9gAC5aDF0JkQ9bVt101TK1u7a8KjXJJ0f+5jj2iwzTid+sEvKKzusvCOaH60E0fnl
 +fwg==
X-Gm-Message-State: AOAM531Ld93z9fkvDn3t5O0CmgU0HVKsGI+a1zIxKhKV7JLjc+5LPx65
 pT6JVUnvd87W88gXOPnQo+AgPRClhxN4ANA3YQ72m7RhHG1zQ5/HMBEwAElnlxgaqE7tS0tAI1v
 cqZHNX/VZ6Hs/DHNHt1KuXoNjG49UuUBZQ2TWLDvLuQ==
X-Received: by 2002:a1c:7915:: with SMTP id l21mr15748824wme.62.1625500296956; 
 Mon, 05 Jul 2021 08:51:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyA878XcDRnse+gcAZSzI29tEdNmCd/Z3W7NWMOpuhzNnpIHRR5+5VU7DyKelRLKJAKif34Qg==
X-Received: by 2002:a1c:7915:: with SMTP id l21mr15748800wme.62.1625500296747; 
 Mon, 05 Jul 2021 08:51:36 -0700 (PDT)
Received: from steredhat (host-87-7-214-34.retail.telecomitalia.it.
 [87.7.214.34])
 by smtp.gmail.com with ESMTPSA id b9sm16260403wrh.81.2021.07.05.08.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 08:51:36 -0700 (PDT)
Date: Mon, 5 Jul 2021 17:51:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH] virtio_vdpa: reject invalid vq indices
Message-ID: <20210705155133.zas2p4lebsgifz5i@steredhat>
References: <20210701114652.21956-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
In-Reply-To: <20210701114652.21956-1-vincent.whitchurch@axis.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, kernel@axis.com,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

On Thu, Jul 01, 2021 at 01:46:52PM +0200, Vincent Whitchurch wrote:
>Do not call vDPA drivers' callbacks with vq indicies larger than what
>the drivers indicate that they support.  vDPA drivers do not bounds
>check the indices.
>
>Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
>---
> drivers/virtio/virtio_vdpa.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
>index e28acf482e0c..e9b9dd03f44a 100644
>--- a/drivers/virtio/virtio_vdpa.c
>+++ b/drivers/virtio/virtio_vdpa.c
>@@ -149,6 +149,9 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> 	if (!name)
> 		return NULL;
>
>+	if (index >= vdpa->nvqs)
>+		return ERR_PTR(-ENOENT);
>+
> 	/* Queue shouldn't already be set up. */
> 	if (ops->get_vq_ready(vdpa, index))
> 		return ERR_PTR(-ENOENT);
>-- 
>2.28.0
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
