Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D1EC433F5
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 10:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 119EF8176C;
	Wed, 22 Dec 2021 10:21:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4HZ9E_WmP2Oq; Wed, 22 Dec 2021 10:21:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5BF75812C3;
	Wed, 22 Dec 2021 10:21:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30335C002F;
	Wed, 22 Dec 2021 10:21:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 220C2C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 10:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 18A6460D9D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 10:21:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KESEV5j6NfUF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 10:21:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1DFF160C19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 10:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640168502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J3yvO4cXgbZxOlydhSiK2v9Tckc8inZjlFWlSIoyww0=;
 b=dO89bPlANqMfBQVxGfC60nJJz4tJDjCSeAp7gKopGDlB9FwWkBRDnTrO1BD6Ia8uQHrin8
 GnFvF0foR0DMcUrmbsWK/0UcL22AQoOhevLo6EitGg1yZCtfqm/UhCu2lzRU89wwKLTEoJ
 AVs4bfH5Ulh0W8C6kL5kogzNfDHQLyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-3KUcni5SOvazGs4afVTvLw-1; Wed, 22 Dec 2021 05:21:39 -0500
X-MC-Unique: 3KUcni5SOvazGs4afVTvLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0364A100C612;
 Wed, 22 Dec 2021 10:21:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F7C94E2CD;
 Wed, 22 Dec 2021 10:21:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 968651800616; Wed, 22 Dec 2021 11:21:35 +0100 (CET)
Date: Wed, 22 Dec 2021 11:21:35 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v3 03/10] drm/bochs: Replace module-init boiler-plate
 code with DRM helpers
Message-ID: <20211222102135.fhtfkinp2u6yjwx3@sirius.home.kraxel.org>
References: <20211222082831.196562-1-javierm@redhat.com>
 <20211222082831.196562-4-javierm@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211222082831.196562-4-javierm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>
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

On Wed, Dec 22, 2021 at 09:28:24AM +0100, Javier Martinez Canillas wrote:
> -static int __init bochs_init(void)
> -{
> -	if (drm_firmware_drivers_only() && bochs_modeset == -1)
> -		return -EINVAL;

Also cleanup bochs_modeset?  I guess its not used any more after this
patch ...

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
