Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC65EC6FD19
	for <virtualization@archiver.kernel.org>; Mon,  6 Mar 2023 07:32:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39C6A60644;
	Mon,  6 Mar 2023 07:32:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 39C6A60644
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HNWImabm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DqkvMNymou5s; Mon,  6 Mar 2023 07:32:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C24A6600C5;
	Mon,  6 Mar 2023 07:32:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C24A6600C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20A2DC0071;
	Mon,  6 Mar 2023 07:32:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AACD6C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 07:32:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C44440979
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 07:32:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C44440979
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HNWImabm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id baJD3qEWJDK2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 07:32:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93A0D40977
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 93A0D40977
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 07:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678087954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3OsqXLKNd2dBJmm8rJgq17jFb+t8dN7wBJ5vGDrT1jE=;
 b=HNWImabmizV1E3BxnnrYCsG9wYSwymsopNmH+jRdDMq+5iwwCsgxvSzypvoU0UOsLs2G1K
 IqataGOaUSQNBo6SrgZGwpSzYP9Y0ZWNarttpq8acntGxbJOgdUi76Qc7Wxcm8o0is//lq
 mu+1nDykT290vifrenJ3Y2PBT9yK+Tc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-kBwuc6YxM4-fE9t2ts8G2w-1; Mon, 06 Mar 2023 02:32:32 -0500
X-MC-Unique: kBwuc6YxM4-fE9t2ts8G2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B23E1C04322;
 Mon,  6 Mar 2023 07:32:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85BE540C83B6;
 Mon,  6 Mar 2023 07:32:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 32FAE1800613; Mon,  6 Mar 2023 08:32:30 +0100 (CET)
Date: Mon, 6 Mar 2023 08:32:30 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v1] drm/virtio: Fix handling CONFIG_DRM_VIRTIO_GPU_KMS
 option
Message-ID: <20230306073230.cka4j44sdteqrpao@sirius.home.kraxel.org>
References: <20230304220510.964715-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230304220510.964715-1-dmitry.osipenko@collabora.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Rob Clark <robdclark@gmail.com>,
 Ryan Neph <ryanneph@chromium.org>, David Airlie <airlied@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>, kernel@collabora.com,
 virtualization@lists.linux-foundation.org, Chia-I Wu <olvaffe@gmail.com>
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

> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -45,9 +45,11 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
>  	if (events_read & VIRTIO_GPU_EVENT_DISPLAY) {
>  		if (vgdev->has_edid)
>  			virtio_gpu_cmd_get_edids(vgdev);
> -		virtio_gpu_cmd_get_display_info(vgdev);
> -		virtio_gpu_notify(vgdev);
> -		drm_helper_hpd_irq_event(vgdev->ddev);
> +		if (vgdev->num_scanouts) {
> +			virtio_gpu_cmd_get_display_info(vgdev);
> +			virtio_gpu_notify(vgdev);
> +			drm_helper_hpd_irq_event(vgdev->ddev);
> +		}

I'd suggest to make the edid lines conditional too.

> -	if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS) || !vgdev->num_scanouts) {
> +	if (!IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS) || !vgdev->num_scanouts) {
>  		DRM_INFO("KMS disabled\n");
>  		vgdev->num_scanouts = 0;
>  		vgdev->has_edid = false;

Doesn't make a difference because has_edid gets set to false here,
but IMHO it is less confusing that way.

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
