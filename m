Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4229C433ED
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 07:29:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB7B613B1
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 07:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB7B613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48CEC40400;
	Tue, 13 Apr 2021 07:29:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mIDnDitHciQF; Tue, 13 Apr 2021 07:29:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 126C2403FC;
	Tue, 13 Apr 2021 07:29:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0293C000B;
	Tue, 13 Apr 2021 07:29:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAABDC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 07:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C3AF40400
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 07:29:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TDYagngDb0F7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 07:29:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B0022403FC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 07:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618298980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YudAFqILa3mOOE+t1TyWZ2gFUm2V6rY++OIJXhuuw1I=;
 b=GVFECx12o1HxFMFDi+vKfUZpJyldeRU3GqaOaZAL33IlUdEti5n+MXWu9OP0hh7u7wRhe8
 TB8ZofjrRkF6FcQSlnJUO2g9FK9lwOVnOr3FnNZk5s3TUTklLDzdmz1ChdAeugi9dHyrkZ
 1l0++xy5yXZAO5soWr6+JhPspJXAABU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-ZXzPK8bwPhSWUOactdNkwQ-1; Tue, 13 Apr 2021 03:29:38 -0400
X-MC-Unique: ZXzPK8bwPhSWUOactdNkwQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 ay2-20020a0564022022b02903824b52f2d8so797922edb.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 00:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YudAFqILa3mOOE+t1TyWZ2gFUm2V6rY++OIJXhuuw1I=;
 b=qqep63xpgxuz+Zku5U/eY3xBnAL2UaaP4KLr2k46ZtEFC0AnF9FBKEug192RLbd+bu
 2nZN46xo+/ah0nuKOymZ4B3nUM3Mes1cg3YlavKkFHYeGMChaXyoOOUA3y7PRy6f/+p5
 UcGGoZC193QMN6LMFQBhdzeV9TOmWAn1dcxR8IauCFkJXg9UdPqbPw1MhUPbN/vV6BwD
 61ZJSF6PZElsFR0K77A/bOz7YC6zIu37D7Csr3I9nHZfe1TjunD7JZHkRp6xU2rNN6pA
 Fs2sdl6Uz0u6nOQL69OSWSKPhlnp86+oLp/3TTOXRi0ck0q3cRQv1Iwu9RPCIpbsEdI4
 JPSg==
X-Gm-Message-State: AOAM532nsH5yr3zu63pYwhOrEZPCL6Rc2m9k95jdP+qHvMhCEGVbky0x
 +pNgcMRc1ALrqUaFe+fUmdpswwvN+SwmzyHgRXP17V3/qtMqwmxsIGatov2kLMiDa1EX/mDgk5p
 Epaw78eaaJSwDr1yUxgIYfGOZIcNW9qn4kGO7qY5F1Q==
X-Received: by 2002:a05:6402:3445:: with SMTP id
 l5mr33576463edc.27.1618298977497; 
 Tue, 13 Apr 2021 00:29:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQrY+VYWzozoHawW7aNAan46NiQL9riVrwylV8GXb98pXD2+8ryZFNg9lKT4PGXF62dZbE/g==
X-Received: by 2002:a05:6402:3445:: with SMTP id
 l5mr33576447edc.27.1618298977323; 
 Tue, 13 Apr 2021 00:29:37 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id gt37sm7169639ejc.12.2021.04.13.00.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 00:29:37 -0700 (PDT)
Date: Tue, 13 Apr 2021 09:29:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Colin King <colin.king@canonical.com>
Subject: Re: [PATCH][next] vdpa/mlx5: Fix resource leak of mgtdev due to
 incorrect kfree
Message-ID: <20210413072934.ibz7iersn5byad3h@steredhat>
References: <20210412162804.1628738-1-colin.king@canonical.com>
MIME-Version: 1.0
In-Reply-To: <20210412162804.1628738-1-colin.king@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Michael S . Tsirkin" <mst@redhat.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Apr 12, 2021 at 05:28:04PM +0100, Colin King wrote:
>From: Colin Ian King <colin.king@canonical.com>
>
>Static analysis is reporting a memory leak on mgtdev, it appears
>that the wrong object is being kfree'd. Fix this by kfree'ing
>mgtdev rather than mdev.
>
>Addresses-Coverity: ("Resource leak")
>Fixes: c8a2d4c73e70 ("vdpa/mlx5: Enable user to add/delete vdpa device")
>Signed-off-by: Colin Ian King <colin.king@canonical.com>
>---
> drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>index 10c5fef3c020..25533db01f5f 100644
>--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>@@ -2089,7 +2089,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
> 	return 0;
>
> reg_err:
>-	kfree(mdev);
>+	kfree(mgtdev);
> 	return err;
> }
>
>-- 
>2.30.2
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
