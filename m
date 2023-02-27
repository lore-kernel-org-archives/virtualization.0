Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96185C64ED8
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 06:38:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE34540937;
	Mon, 27 Feb 2023 06:38:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE34540937
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I1Up907j
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XljczUd036T1; Mon, 27 Feb 2023 06:38:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 13F5C408CA;
	Mon, 27 Feb 2023 06:38:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13F5C408CA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5217C0033;
	Mon, 27 Feb 2023 06:38:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4097C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 06:38:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB39F40438
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 06:38:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB39F40438
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=I1Up907j
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gzUCm1jZULNV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 06:38:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 645CC403D6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 645CC403D6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 06:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677479909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+UG2oWxtK4UHFvkDOIm8sJ8ImrluBqKEzcmgsSAFFPA=;
 b=I1Up907jCmK3XlvYJekYbo7Z+WZZzbqpzI7W480dq6RHBrxnd2u1Hg0JAuzsuvEOFOWb7j
 SYDXTy/goZCltzXA5j4gbSJ3c1ixNnEP+QErSO8DVLVw4nIq6A3Fnin4xYGiOIiQ7ZoKrK
 T8QQaEcJkST8m7adwSrc+c3GWiPxhWA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-8ceeMC1mP9mgVdcbxYFawQ-1; Mon, 27 Feb 2023 01:38:23 -0500
X-MC-Unique: 8ceeMC1mP9mgVdcbxYFawQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E53395D605;
 Mon, 27 Feb 2023 06:38:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 134CDC15BAD;
 Mon, 27 Feb 2023 06:38:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8BCF61800393; Mon, 27 Feb 2023 07:38:21 +0100 (CET)
Date: Mon, 27 Feb 2023 07:38:21 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] drm/virtio: Add option to disable KMS support
Message-ID: <20230227063821.dg2gbjjwcekbxyzw@sirius.home.kraxel.org>
References: <20230224180225.2477641-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230224180225.2477641-1-robdclark@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Cc: Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Ryan Neph <ryanneph@chromium.org>, David Airlie <airlied@redhat.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Chia-I Wu <olvaffe@gmail.com>
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

On Fri, Feb 24, 2023 at 10:02:24AM -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Add a build option to disable modesetting support.  This is useful in
> cases where the guest only needs to use the GPU in a headless mode, or
> (such as in the CrOS usage) window surfaces are proxied to a host
> compositor.

Why make that a compile time option?  There is a config option for the
number of scanouts (aka virtual displays) a device has.  Just set that
to zero (and fix the driver to not consider that configuration an
error).

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
