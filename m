Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB7EC6FA83
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 10:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CAEC813B5;
	Wed,  7 Sep 2022 10:16:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8CAEC813B5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G7oqIi9v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0k11GEaymUU6; Wed,  7 Sep 2022 10:16:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 26DC981364;
	Wed,  7 Sep 2022 10:16:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 26DC981364
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1CD2C0033;
	Wed,  7 Sep 2022 10:16:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B1F6C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 10:16:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E911607E3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 10:16:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5E911607E3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=G7oqIi9v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aTAqKxg5_1DI
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 10:16:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA58D60783
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AA58D60783
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 10:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662545778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SLJpV2WoX8SK2vuj4fI8Y4TMwvJeZNVPNe+ZDugqX0U=;
 b=G7oqIi9vXVXaEIwuiHhMylKdP8wYuThbnJPORvEu5wlTF8KvaCHSFliQE3lTtl5NSNfN+M
 xvWBKYqsVPCWhvHTC2jlbFEaH1hvxv6a6FXIseSfZDGd8/LQGOz8vpL6qhrb83Q5fXeNrT
 OLJB8jNDaaqDt1HJ/1tgfTqYH9yB2Vg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-9rAV9vdMN_uMEAynE-c_zg-1; Wed, 07 Sep 2022 06:16:15 -0400
X-MC-Unique: 9rAV9vdMN_uMEAynE-c_zg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2238185A794;
 Wed,  7 Sep 2022 10:16:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.195.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABE692166B26;
 Wed,  7 Sep 2022 10:16:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6EAF5180039B; Wed,  7 Sep 2022 12:16:12 +0200 (CEST)
Date: Wed, 7 Sep 2022 12:16:12 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH] drm/virtio: set fb_modifiers_not_supported
Message-ID: <20220907101612.wn5toutzsvi4l5tb@sirius.home.kraxel.org>
References: <20220831190601.1295129-1-olvaffe@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220831190601.1295129-1-olvaffe@gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Shao-Chuan Lee <shaochuan@chromium.org>, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux-foundation.org,
 Tomohito Esaki <etom@igel.co.jp>
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

On Wed, Aug 31, 2022 at 12:06:01PM -0700, Chia-I Wu wrote:
> Without this, the drm core advertises LINEAR modifier which is
> incorrect.
> 
> Also userspace virgl does not support modifiers.  For example, it causes
> chrome on ozone/drm to fail with "Failed to create scanout buffer".
> 
> Fixes: 2af104290da5 ("drm: introduce fb_modifiers_not_supported flag in mode_config")
> Suggested-by: Shao-Chuan Lee <shaochuan@chromium.org>
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>

Pushed to drm-misc-next.

thanks,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
