Return-Path: <SRS0=bZ0l=OF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4EBC433F5
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 06:29:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD3E61212
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 06:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1AD3E61212
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA8DD403CA;
	Wed, 15 Sep 2021 06:29:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ew0v1Tx0qbeO; Wed, 15 Sep 2021 06:29:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A08E1403BA;
	Wed, 15 Sep 2021 06:29:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75CC5C0011;
	Wed, 15 Sep 2021 06:29:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0680AC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 06:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E473E403CA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 06:29:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2GHXPYsbIwvP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 06:29:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2938D403BA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 06:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631687387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+C6oOXnSiXCMxV5e9+CpUPoeNdMOGB3oYk9FF4IqK+A=;
 b=Bb5yZdOHp0aLqXvbVhb52ZaGAH26MO7sFuX1C257089zdMFPObp/6KdxBigYKy8jOp0+b9
 oQAoBpyPP8RaxJEnM/5EEej40BNUz3o4N69hxSRYrASGoueaw902iTBRHOIlsN0Rtzzw7V
 bUcwkHKj/rWOWafgjcF8wd+07xxHlZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-PpDkW-RaNMSdhiRoBpC_4w-1; Wed, 15 Sep 2021 02:29:44 -0400
X-MC-Unique: PpDkW-RaNMSdhiRoBpC_4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3146824FAF;
 Wed, 15 Sep 2021 06:29:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A68666D982;
 Wed, 15 Sep 2021 06:29:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DF43618003BF; Wed, 15 Sep 2021 08:29:40 +0200 (CEST)
Date: Wed, 15 Sep 2021 08:29:40 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: Re: [PATCH] drm/bochs: add Bochs PCI ID for Simics model
Message-ID: <20210915062940.m3q2fwbipkq7ki6s@sirius.home.kraxel.org>
References: <20210910010655.2356245-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210910010655.2356245-1-hpa@zytor.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
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

On Thu, Sep 09, 2021 at 06:06:55PM -0700, H. Peter Anvin (Intel) wrote:
> Current (and older) Simics models for the Bochs VGA used the wrong PCI
> vendor ID (0x4321 instead of 0x1234).  Although this can hopefully be
> fixed in the future, it is a problem for users of the current version,
> not the least because to update the device ID the BIOS has to be
> rebuilt in order to see BIOS output.
> 
> Add support for the 4321:1111 device number in addition to the
> 1234:1111 one.
> 
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>

Pusged to drm-misc-next.

thanks,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
