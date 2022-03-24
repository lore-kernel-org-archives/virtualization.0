Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5964AC433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 13:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EEF22400EA;
	Thu, 24 Mar 2022 13:21:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mrSYHEWUO07E; Thu, 24 Mar 2022 13:21:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 47CB8400D6;
	Thu, 24 Mar 2022 13:21:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 292EEC0012;
	Thu, 24 Mar 2022 13:21:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73F77C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 13:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C0D560D5C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 13:21:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Djpcq3oW8usj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 13:21:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97C0D600C6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 13:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648128075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KbUfq5Ttn9TLVrkbv/r2vzp1qmLsYDSRFfW64UUbX/Y=;
 b=XE8C8Ri8f8MiKwbv2KTfJ7h+t1GiWX7jaWVmBZc4DccGqgMeJJBcJCe+vR5hmwcS5Ij+bL
 XLl54BIev8RQNtdDtlLrvBZFuhvelSlFYKrhwkXLTFMSZkRV2n+LOrIiAxE2fHI7TxWx7a
 DyKUhP1yx31zxpeFfanHaqrpUXb6hdo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75--3M2yY4qM3Gzbj6tGKQFfA-1; Thu, 24 Mar 2022 09:21:12 -0400
X-MC-Unique: -3M2yY4qM3Gzbj6tGKQFfA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D83182A682;
 Thu, 24 Mar 2022 13:21:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.196.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD4C5142B94F;
 Thu, 24 Mar 2022 13:21:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 62C5318003B8; Thu, 24 Mar 2022 14:21:09 +0100 (CET)
Date: Thu, 24 Mar 2022 14:21:09 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: liucong2@kylinos.cn
Subject: Re: =?utf-8?B?5Zue5aSNOiBSZTog5Zue5aSNOiBSZTog5Zue5aSNOiBSZTog?=
 =?utf-8?B?5Zue5aSNOiBSZTogW1BBVEM=?= =?utf-8?Q?H?= v1 1/2] drm/qxl: replace
 ioremap by ioremap_cache on arm64
Message-ID: <20220324132109.3ox6k2wif6tkp47n@sirius.home.kraxel.org>
References: <olr8fzd5ad-olr8fzd5ae@nsmail6.0>
MIME-Version: 1.0
In-Reply-To: <olr8fzd5ad-olr8fzd5ae@nsmail6.0>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, ray.huang@amd.com, daniel@ffwll.ch,
 spice-devel@lists.freedesktop.org, airlied@redhat.com,
 Robin Murphy <robin.murphy@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
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

On Thu, Mar 24, 2022 at 06:34:02PM +0800, liucong2@kylinos.cn wrote:
>    ok, thanks, a lot of our customer use qxl on x86 before, so it still need
>    to supoort qxl on arm64.

Well, qxl isn't the best choice even on x86.  The main advantage it
offers (2d acceleration) is basically useless today because pretty much
everything moved on to use 3d acceleration instead.  So qxl ends up
being used as dumb framebuffer with software 3d rendering.

So, I'm still recommending to just use virtio-gpu ...

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
