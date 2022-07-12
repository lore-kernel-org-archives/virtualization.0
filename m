Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C280BC43334
	for <virtualization@archiver.kernel.org>; Tue, 12 Jul 2022 07:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EC5740319;
	Tue, 12 Jul 2022 07:58:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2EC5740319
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HFBzafmQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id si362YHnrj6b; Tue, 12 Jul 2022 07:58:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 612CA4030C;
	Tue, 12 Jul 2022 07:58:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 612CA4030C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CF8BC0035;
	Tue, 12 Jul 2022 07:58:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5682BC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 07:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E77740319
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 07:58:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E77740319
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xTcu2Xzkydmz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 07:58:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3EFE04030C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3EFE04030C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 07:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657612704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6y5QO8QLMxjrAPHgVqEqjiyLqZrGBzA2B37SGd8Ms8s=;
 b=HFBzafmQRNqqmTfhKZ6UH6IituTN/JvFX9eJb91i1z0oz3i7fF1YYYTY2URAUttxe3hFbo
 rnC5VKxKUhL2oH6QQM8N3JOEUz3WmfU933cfO7E8RNTkSzlc65tOt9yGfcdzcVOFr22+e+
 mE9QLPSCYffnOriQ3qcSB+3q5Gxs8vk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-Wc8yF6l3NPGMouKmjDudWw-1; Tue, 12 Jul 2022 03:58:22 -0400
X-MC-Unique: Wc8yF6l3NPGMouKmjDudWw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 322F4280F2A2;
 Tue, 12 Jul 2022 07:58:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F0F13492C3B;
 Tue, 12 Jul 2022 07:58:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6C50118000A9; Tue, 12 Jul 2022 09:58:20 +0200 (CEST)
Date: Tue, 12 Jul 2022 09:58:20 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Zack Rusin <zackr@vmware.com>
Subject: Re: [PATCH v2 4/8] drm/qxl: Use the hotspot properties from cursor
 planes
Message-ID: <20220712075820.fpouky7uovabujvt@sirius.home.kraxel.org>
References: <20220712033246.1148476-1-zack@kde.org>
 <20220712033246.1148476-5-zack@kde.org>
MIME-Version: 1.0
In-Reply-To: <20220712033246.1148476-5-zack@kde.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 krastevm@vmware.com, ppaalanen@gmail.com, Dave Airlie <airlied@redhat.com>,
 spice-devel@lists.freedesktop.org, mombasawalam@vmware.com
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

On Mon, Jul 11, 2022 at 11:32:42PM -0400, Zack Rusin wrote:
> From: Zack Rusin <zackr@vmware.com>
> 
> Atomic modesetting got support for mouse hotspots via the hotspot
> properties. Port the legacy kms hotspot handling to the new properties
> on cursor planes.
> 
> Signed-off-by: Zack Rusin <zackr@vmware.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: virtualization@lists.linux-foundation.org
> Cc: spice-devel@lists.freedesktop.org

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
