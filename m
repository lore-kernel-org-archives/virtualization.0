Return-Path: <SRS0=3a2n=EM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DF6C388F2
	for <virtualization@archiver.kernel.org>; Fri,  6 Nov 2020 08:25:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2FB520936
	for <virtualization@archiver.kernel.org>; Fri,  6 Nov 2020 08:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDA16VNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FB520936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1896E2E0F0;
	Fri,  6 Nov 2020 08:25:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7QZyD5Ss9yHf; Fri,  6 Nov 2020 08:25:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C1AAC20470;
	Fri,  6 Nov 2020 08:25:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B96E0C088B;
	Fri,  6 Nov 2020 08:25:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06FF7C0889
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 08:25:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E4CBE868DB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 08:25:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YzCnLvH7tsBN
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 08:25:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 56351868D7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 08:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604651112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7EY7KZLT69FMPExC55DtbsXIf+PtOVltQz0z2/bK6wM=;
 b=HDA16VNSGzSdAvZHjrVzIMbwlZLgWJkpfNCWlKquXANhwZChdRwe0Bx0RYg09K4W+IejVX
 YFtr0rm02REwtBCaTRZTtTyfkJafhFSCUHh77SKX7lqO6bGJcRYqd8QTYA+cQWuFsya0vq
 kFQmkNyNdHd8Yl8dAJBKPMSbTpzqOtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-ZAuNZxcGPIi5iKX0d4PmqA-1; Fri, 06 Nov 2020 03:25:08 -0500
X-MC-Unique: ZAuNZxcGPIi5iKX0d4PmqA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8A81186DD24;
 Fri,  6 Nov 2020 08:25:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E852C19C66;
 Fri,  6 Nov 2020 08:25:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 30F9611AB5; Fri,  6 Nov 2020 09:25:05 +0100 (CET)
Date: Fri, 6 Nov 2020 09:25:05 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] drm/virtio: Fix a double free in virtio_gpu_cmd_map()
Message-ID: <20201106082505.oieppl6xpc3cng7q@sirius.home.kraxel.org>
References: <20201030114808.GD3251003@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201030114808.GD3251003@mwanda>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>,
 kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Gurchetan Singh <gurchetansingh@chromium.org>
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

On Fri, Oct 30, 2020 at 02:48:08PM +0300, Dan Carpenter wrote:
> This is freed both here and in the caller (virtio_gpu_vram_map()) so
> it's a double free.  The correct place is only in the caller.
> 
> Fixes: 16845c5d5409 ("drm/virtio: implement blob resources: implement vram object")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Pushed to drm-misc-next.

thanks,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
