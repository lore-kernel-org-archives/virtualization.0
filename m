Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13342EB64DC
	for <virtualization@archiver.kernel.org>; Wed, 21 Jun 2023 07:57:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 780EC417D7;
	Wed, 21 Jun 2023 07:57:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 780EC417D7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hhChswf/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jZpYtrRxw1ES; Wed, 21 Jun 2023 07:57:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E7D2B400B8;
	Wed, 21 Jun 2023 07:57:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7D2B400B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF535C007A;
	Wed, 21 Jun 2023 07:57:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F26CC0029
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jun 2023 07:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 76F0541E49
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jun 2023 07:57:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 76F0541E49
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hhChswf/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BSsJhz7-AiDW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jun 2023 07:57:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9DA0441E05
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9DA0441E05
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jun 2023 07:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687334240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7HTmOa2A1R44TEuczs4wdI2fVqvdbq/sEU4yXPclC74=;
 b=hhChswf/aRy0HEwOcXEjnRcTgiMokJ2zu7BJEB3juQFwAr4irOHRZxG/nGzIJ4Sx8t5Jx2
 Szie1DUxk/fwzPD5rY89f56aXtbKe0IvQe4/KFmC5mH7QQrcBxMD5WCetpf8eEpe2ePpwh
 nHyD8dUkRo039eYvg3zrc3rrBT/h+gQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-dMAjkMmkOrOgmjnFM4vjaw-1; Wed, 21 Jun 2023 03:57:17 -0400
X-MC-Unique: dMAjkMmkOrOgmjnFM4vjaw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D2E6800CA5;
 Wed, 21 Jun 2023 07:57:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3501B492C13;
 Wed, 21 Jun 2023 07:57:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CFE341800381; Wed, 21 Jun 2023 09:57:14 +0200 (CEST)
Date: Wed, 21 Jun 2023 09:57:14 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drm/virtgpu: Replace dev_private by helper function
Message-ID: <brjzelisopxjpqhy7shhkm6azyhwpyhw4vqurglfhouvtk2whf@ewnboldp64dy>
References: <20230620103343.910-1-tzimmermann@suse.de>
MIME-Version: 1.0
In-Reply-To: <20230620103343.910-1-tzimmermann@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 daniel@ffwll.ch, airlied@redhat.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com
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

On Tue, Jun 20, 2023 at 12:33:28PM +0200, Thomas Zimmermann wrote:
> Dereference struct drm_device.dev_private in the helper function
> do_virtio_gpu_device(). The dev_private field is deprecated and
> drivers are advised not ot use it. Encapsulating it in a helper
> function will help with a later removal. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
