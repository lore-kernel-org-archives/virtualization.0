Return-Path: <SRS0=jkwN=O7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF615C433EF
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 09:20:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEFF60EB6
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 09:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8DEFF60EB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A60240372;
	Mon, 11 Oct 2021 09:20:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lnVxtH51COOU; Mon, 11 Oct 2021 09:20:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0667940346;
	Mon, 11 Oct 2021 09:20:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAB78C000F;
	Mon, 11 Oct 2021 09:20:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72B80C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 09:20:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61D8C4035D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 09:20:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 88QC5eCrY0Xn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 09:20:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B63B240346
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 09:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633943999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LUZhr1weIZB5Mgjnu+H1Acau2hOu5RQNiImQsCT566c=;
 b=NlBxMb+/cuRu5DSDMsf+QT2uxN3oN5AQPGjawXcZ5wtcl5Agq91D0l+QdofjvSCu/A9UFL
 A+MagpBkMBiIfBIg22888B+0M4U99cHS3piS1ci8l1zwVzmMa+v9ZdT4k6UzS0bswe5o61
 TdPxeEZ3FOVb8genx2x6JhO2y+d+K8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-7pgL72FvMBiUe_PGPZMK2Q-1; Mon, 11 Oct 2021 05:19:56 -0400
X-MC-Unique: 7pgL72FvMBiUe_PGPZMK2Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C4F8801A92;
 Mon, 11 Oct 2021 09:19:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE4CB4180;
 Mon, 11 Oct 2021 09:19:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8EB6018009D4; Mon, 11 Oct 2021 11:19:51 +0200 (CEST)
Date: Mon, 11 Oct 2021 11:19:51 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Jing Xiangfeng <jingxiangfeng@huawei.com>
Subject: Re: [PATCH] drm/virtio: fix the missed drm_gem_object_put() in
 virtio_gpu_user_framebuffer_create()
Message-ID: <20211011091951.3ncpolbsiavke6rr@sirius.home.kraxel.org>
References: <1633770560-11658-1-git-send-email-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1633770560-11658-1-git-send-email-jingxiangfeng@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, Oct 09, 2021 at 05:09:20PM +0800, Jing Xiangfeng wrote:
> virtio_gpu_user_framebuffer_create() misses to call drm_gem_object_put()
> in an error path. Add the missed function call to fix it.

Pushed to drm-misc-next.

thanks,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
