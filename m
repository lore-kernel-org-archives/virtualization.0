Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F96BC64EC7
	for <virtualization@archiver.kernel.org>; Tue, 28 Feb 2023 12:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1CE5740467;
	Tue, 28 Feb 2023 12:46:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1CE5740467
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BNYXnkJX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3eSwINydGaSM; Tue, 28 Feb 2023 12:46:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9914C4026E;
	Tue, 28 Feb 2023 12:46:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9914C4026E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5790DC0032;
	Tue, 28 Feb 2023 12:46:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A7A6C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 12:46:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DCC4C81ECE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 12:46:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DCC4C81ECE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BNYXnkJX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B7Q0WlRXwwXo
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 12:46:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BF6F80BBF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BF6F80BBF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 12:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677588386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2AR9g0+21GGmCwkSUOYa0isQeV+cYWFL+wM4f9rZ618=;
 b=BNYXnkJX941N5v8sZamxYDPXxAz5fwuAGHj4qSghlqY6ikFwNwqsitwLXzmZS3gMX8Pgwa
 wGrDGpZcpE7KBCaMKeJ9hmCQpYHx4n35sQYUYXN8Fi69TWZ/EvgWk6f930EWCWBLs5RzXy
 akwm7CFNfSXJgHTvAHJzKtXn/hh88no=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-q4eF9EK2NU6fW6LtVkickg-1; Tue, 28 Feb 2023 07:46:22 -0500
X-MC-Unique: q4eF9EK2NU6fW6LtVkickg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC83838221C3;
 Tue, 28 Feb 2023 12:46:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EE90492B0E;
 Tue, 28 Feb 2023 12:46:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3C10E180099A; Tue, 28 Feb 2023 13:46:20 +0100 (CET)
Date: Tue, 28 Feb 2023 13:46:20 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v3] drm/virtio: Add option to disable KMS support
Message-ID: <20230228124620.pfjvj372rifiljew@sirius.home.kraxel.org>
References: <20230227173800.2809727-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230227173800.2809727-1-robdclark@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Cc: Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
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

  Hi,

> +		if (!vgdev->num_scanouts) {
> +			/*
> +			 * Having an EDID but no scanouts is non-sensical,
> +			 * but it is permitted to have no scanouts and no
> +			 * EDID (in which case DRIVER_MODESET and
> +			 * DRIVER_ATOMIC are not advertised)
> +			 */
> +			if (vgdev->has_edid) {
> +				DRM_ERROR("num_scanouts is zero\n");

That error message isn't very clear.

Also I'd suggest to just drop the edid check.  It's about commands
being supported by the device, not about the actual presence of an EDID
blob, so the check doesn't look very useful to me.

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
