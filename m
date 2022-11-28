Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E544FC43217
	for <virtualization@archiver.kernel.org>; Mon, 28 Nov 2022 10:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FA7281D19;
	Mon, 28 Nov 2022 10:53:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6FA7281D19
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=brGz8uhL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tydXWNy63VkK; Mon, 28 Nov 2022 10:53:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 147E481B70;
	Mon, 28 Nov 2022 10:53:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 147E481B70
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD89DC0033;
	Mon, 28 Nov 2022 10:53:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92F82C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 10:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C83740253
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 10:53:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C83740253
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=brGz8uhL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 27aJNyKKcleK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 10:53:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8DF6C402A9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8DF6C402A9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 10:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669632801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YDfD1JOkqPMGxzR8BVcFFJShtzyZOZFKwtYn5KBR2Gs=;
 b=brGz8uhL34UtHRMJvGbNGARrBUmm73I7Y+Oqz5jRgHNJ5TF2j6bSodYnabg3Mfi/O+C+rk
 A5HVagftFg3jsRUTV7h4HNxRVOhR6MfJkpLIVZ3y++oZHociVA2NpNuGQ0/W82yg67fI68
 +TEp71NTN7l1r1KuMiCn7+aw/iA3iek=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-278-VWanPipmMnCjat8ys-ZnCA-1; Mon, 28 Nov 2022 05:53:20 -0500
X-MC-Unique: VWanPipmMnCjat8ys-ZnCA-1
Received: by mail-wm1-f72.google.com with SMTP id
 m17-20020a05600c3b1100b003cf9cc47da5so6128507wms.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 02:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YDfD1JOkqPMGxzR8BVcFFJShtzyZOZFKwtYn5KBR2Gs=;
 b=fhwb13NNQEFlSKtTdKBYo3lcKiluXlFkyaz2IlXtIOUKvhATflRaq0bV+htKJJFXXR
 0W/NsTwbxO+jqSDXqQVFKGWbvqXfSdkCRozVgHkrVkJCzqy5bRS//ylXc+cQU0HMvH49
 jsAhyVrxAikVqeQRLFT27WDWRQQjkQk1OF0HR32E0mnueEm6WPwgZ4LH2F7ZwsoWi4Z7
 LAJk00NCBGoyhMTGT6DSkahEXOw/pSJtM4x8LdxdbVhwIxVoiHVdk7Inzo25qMvTeshd
 SxNJGimWCNDnMfNSUXJlxs2DncOaaVMt+2cb7T592xR76KjGMTOjCE8gxHy9NMR8H8Ta
 ZfbQ==
X-Gm-Message-State: ANoB5pmbe/kj46rh+i1HEDmkZJZ+5MsNSUTpzy8F8hzhEkC5sc22l2ph
 LabZlyQe/11yle/KnYQadUDKb75DHTtkPK9IsXtmp9NVXi8sWIwDsPvPzIJFfhBfLe6HKap9v+9
 YrWtg2/SfuhkWRFFEDAppD9b6wl8G0kEBWZwXjzNOrg==
X-Received: by 2002:a05:6000:181:b0:241:c6f9:3e5a with SMTP id
 p1-20020a056000018100b00241c6f93e5amr21815614wrx.157.1669632798959; 
 Mon, 28 Nov 2022 02:53:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6gWk1ySTRc2DfRA9Ss8vYdNRCoIrlRwT5xJgp0LUb00UHbS4nCbgmdTHrvXKHl8njzMTuT8w==
X-Received: by 2002:a05:6000:181:b0:241:c6f9:3e5a with SMTP id
 p1-20020a056000018100b00241c6f93e5amr21815603wrx.157.1669632798764; 
 Mon, 28 Nov 2022 02:53:18 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 k17-20020a05600c1c9100b003c6b874a0dfsm19180098wms.14.2022.11.28.02.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Nov 2022 02:53:18 -0800 (PST)
Date: Mon, 28 Nov 2022 11:53:12 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v2] vduse: Validate vq_num in vduse_validate_config()
Message-ID: <20221128105312.3ajursuudvmysiie@sgarzare-redhat>
References: <20221128083627.1199512-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20221128083627.1199512-1-harshit.m.mogalapalli@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: error27@gmail.com, "Michael S . Tsirkin" <mst@redhat.com>,
 harshit.m.mogalapalli@gmail.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, Gautam Dawar <gautam.dawar@xilinx.com>,
 Eli Cohen <elic@nvidia.com>
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

On Mon, Nov 28, 2022 at 12:36:26AM -0800, Harshit Mogalapalli wrote:
>Add a limit to 'config->vq_num' which is user controlled data which
>comes from an vduse_ioctl to prevent large memory allocations.
>
>This is found using static analysis with smatch.
>
>Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>---
>v1->v2: Change title of the commit and description, add a limit to
>	vq_num.
>
>Note: I think here 0xffff is the max size of vring =  no: of vqueues.
>Only compile and boot tested.
>---
> drivers/vdpa/vdpa_user/vduse_dev.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
>index 35dceee3ed56..31017ebc4d7c 100644
>--- a/drivers/vdpa/vdpa_user/vduse_dev.c
>+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>@@ -1440,6 +1440,9 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
> 	if (config->config_size > PAGE_SIZE)
> 		return false;
>
>+	if (config->vq_num > 0xffff)

What about using U16_MAX here?

Thanks,
Stefano

>+		return false;
>+
> 	if (!device_is_allowed(config->device_id))
> 		return false;
>
>-- 
>2.38.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
