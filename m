Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0E7C678D4
	for <virtualization@archiver.kernel.org>; Mon,  6 Mar 2023 14:46:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E19ED4093A;
	Mon,  6 Mar 2023 14:46:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E19ED4093A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y2RDdAHS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d3ag6RPsdXDe; Mon,  6 Mar 2023 14:46:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F05C940936;
	Mon,  6 Mar 2023 14:46:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F05C940936
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1D8DC0071;
	Mon,  6 Mar 2023 14:46:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 698EEC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 14:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30F6360AC0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 14:46:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30F6360AC0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y2RDdAHS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eF0JuTtKJqdI
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 14:46:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 463C2607C1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 463C2607C1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 14:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678114007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ePnoIICLAgX5+yYDBioH0vdLJ6br42cKaUY5oT5Uciw=;
 b=Y2RDdAHSwbhMF4FWuM3uk1BtjZbj/mZjA8mwAs2/jiJG6vz5NvPI+7icdsKlI+iXpd/XPj
 mdkLButgANJvj14A5Oi22LrJOOdCsRaojr4uoCxTBmD7FKHjnGZyIr4wHoeP4j6NI+bLN4
 wg6mkT5x/7Bvk0Ju0tRA+zhVr9bdmPc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-su8vUQvyPQKmkMm2FULrTQ-1; Mon, 06 Mar 2023 09:46:43 -0500
X-MC-Unique: su8vUQvyPQKmkMm2FULrTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D50B229AA39C;
 Mon,  6 Mar 2023 14:46:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87CDE1410DD9;
 Mon,  6 Mar 2023 14:46:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 05829180062C; Mon,  6 Mar 2023 15:46:40 +0100 (CET)
Date: Mon, 6 Mar 2023 15:46:40 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v2] drm/virtio: Fix handling CONFIG_DRM_VIRTIO_GPU_KMS
 option
Message-ID: <20230306144640.ta7jca5iabg66uoy@sirius.home.kraxel.org>
References: <20230306143234.1561759-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230306143234.1561759-1-dmitry.osipenko@collabora.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

On Mon, Mar 06, 2023 at 05:32:34PM +0300, Dmitry Osipenko wrote:
> VirtIO-GPU got a new config option for disabling KMS. There were two
> problems left unnoticed during review when the new option was added:
> 
> 1. The IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS) check in the code was
> inverted, hence KMS was disabled when it should be enabled and vice versa.
> 
> 2. The disabled KMS crashed kernel with a NULL dereference in
> drm_kms_helper_hotplug_event(), which shall not be invoked with a
> disabled KMS.
> 
> Fix the inverted config option check in the code and skip handling the
> VIRTIO_GPU_EVENT_DISPLAY sent by host when KMS is disabled in guest to fix
> the crash.
> 
> Fixes: 72122c69d717 ("drm/virtio: Add option to disable KMS support")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
> 
> Changelog:
> 
> v2: - Moved the "has_edid" under the "num_scanouts" condition, like was
>       suggested by Gerd Hoffmann.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
