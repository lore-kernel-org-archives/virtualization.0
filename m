Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A1DC7EE36
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 08:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1486F4013F;
	Thu,  2 Mar 2023 08:33:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1486F4013F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EJ8O7lb/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uefa1PHpQxfA; Thu,  2 Mar 2023 08:33:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6FD0C40025;
	Thu,  2 Mar 2023 08:33:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6FD0C40025
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4109BC0071;
	Thu,  2 Mar 2023 08:33:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B79AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 08:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2893A80FB9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 08:33:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2893A80FB9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EJ8O7lb/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eNWzmleXUVyU
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 08:33:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C85F180C53
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C85F180C53
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 08:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677746009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J2wWYhw4IbCn2jiud1m9fHjCN/hg14p3hY5/TY/f9/s=;
 b=EJ8O7lb/BaF1WzZscLWAQvJKrUX2B9an/qXahaGczc9/e9dxJnHCtcgfZHaJrYq3yP8nO8
 0tRoxmeWNt4pINfWe099QJbabzvDYJEX+AlLSPBB3lgax1FCYzpEUZosyodJ3Dygwwn0+j
 6tVpgvIoMwSjvfk02UfuEKToTQjtDWw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-vXMYtn19ONygfb4VQ66x8g-1; Thu, 02 Mar 2023 03:33:28 -0500
X-MC-Unique: vXMYtn19ONygfb4VQ66x8g-1
Received: by mail-qk1-f199.google.com with SMTP id
 z23-20020a05620a101700b0073b328e7d17so9595383qkj.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 00:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677746008;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J2wWYhw4IbCn2jiud1m9fHjCN/hg14p3hY5/TY/f9/s=;
 b=REzHOaTGhnaZNARKvOcKHWofPSRNrPJKzTHKQrFBVyJHvBuhWtWcRocCERTOVODlSi
 5w6KcsBKWX/6T5HlS8CydA4tnfTgYJq8GhzXqwxO5dJDpKTP3QRw8uiUQpxr7BlaMrVm
 gLuD4qJKheKmA7usf1pyuCsvWThbX/jc2XrBJQBu9GoYB6frApIG++agJYPUXZOHcnT8
 keBFER8oTJrB+n1LnUHj1TeaEAY3IIBCF5OttWrsPiqrJAvn1uKwDVWygGYA7XiC+YEr
 goy4Z3fMkVf04YtUVvqqaeXNr1dxl3BEwaJNRBjegyh/6ZeYSv6rSFzW6XmMtjh5f2hi
 WNrg==
X-Gm-Message-State: AO0yUKVRAyHPMDsBhk2nI3/oCXiQMV4WEn5YQHnR2hbSIgFzWhz51BvB
 E9IQofvE8PDyithSUyZiyYZYHF2+2M2DzE0C/BsMODWfa0yNq6U91STrI9GjebUWhOMdP3sUWYd
 W9tE5GKP4z4ccJHgqv/xdkFfOGSEBeEOR30F1Ojvbww==
X-Received: by 2002:a05:6214:19c6:b0:56e:b5a0:29eb with SMTP id
 j6-20020a05621419c600b0056eb5a029ebmr17272854qvc.40.1677746007954; 
 Thu, 02 Mar 2023 00:33:27 -0800 (PST)
X-Google-Smtp-Source: AK7set99YYiQIT3q7u8Fs8YEPbCbxaT865af9SQwhTIhLrsPHZ5cKOxrj+xqsWWZYUHwSbbTr5OKZw==
X-Received: by 2002:a05:6214:19c6:b0:56e:b5a0:29eb with SMTP id
 j6-20020a05621419c600b0056eb5a029ebmr17272835qvc.40.1677746007699; 
 Thu, 02 Mar 2023 00:33:27 -0800 (PST)
Received: from sgarzare-redhat ([212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 d187-20020ae9efc4000000b007428e743508sm9907618qkg.70.2023.03.02.00.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Mar 2023 00:33:27 -0800 (PST)
Date: Thu, 2 Mar 2023 09:33:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gautam Dawar <gautam.dawar@amd.com>
Subject: Re: [PATCH] vhost-vdpa: free iommu domain after last use during
 cleanup
Message-ID: <20230302083314.xj2wlzkarvsmofd6@sgarzare-redhat>
References: <20230301163203.29883-1-gautam.dawar@amd.com>
MIME-Version: 1.0
In-Reply-To: <20230301163203.29883-1-gautam.dawar@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: tanuj.kamde@amd.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-net-drivers@amd.com,
 netdev@vger.kernel.org, harpreet.anand@amd.com, linux-kernel@vger.kernel.org,
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

On Wed, Mar 01, 2023 at 10:02:01PM +0530, Gautam Dawar wrote:
>Currently vhost_vdpa_cleanup() unmaps the DMA mappings by calling
>`iommu_unmap(v->domain, map->start, map->size);`
>from vhost_vdpa_general_unmap() when the parent vDPA driver doesn't
>provide DMA config operations.
>
>However, the IOMMU domain referred to by `v->domain` is freed in
>vhost_vdpa_free_domain() before vhost_vdpa_cleanup() in
>vhost_vdpa_release() which results in NULL pointer de-reference.
>Accordingly, moving the call to vhost_vdpa_free_domain() in
>vhost_vdpa_cleanup() would makes sense. This will also help
>detaching the dma device in error handling of vhost_vdpa_alloc_domain().

Yep, good cleanup!

>
>This issue was observed on terminating QEMU with SIGQUIT.
>
>Fixes: 037d4305569a ("vhost-vdpa: call vhost_vdpa_cleanup during the release")
>Signed-off-by: Gautam Dawar <gautam.dawar@amd.com>
>---
> drivers/vhost/vdpa.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
