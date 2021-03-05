Return-Path: <SRS0=gmSK=ID=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3297FC433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 09:40:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA5064FCF
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 09:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA5064FCF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2ACC66FB6B;
	Fri,  5 Mar 2021 09:40:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JZKFEMFYLwun; Fri,  5 Mar 2021 09:40:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCF006E548;
	Fri,  5 Mar 2021 09:40:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A47A6C000A;
	Fri,  5 Mar 2021 09:40:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A165C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 09:40:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 67E6A4EC3D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 09:40:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gkmbtkCYvKJy
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 09:39:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7417D4EC30
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 09:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614937198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q6N/JHvwR3DDe0EEB+dV0FhguwPKEzi443GmKZ0bZ4c=;
 b=EgdvEfI/mfR1604gcY1vH3cIHaLnsp/gXNufyjUIEuL+Qzqv7Qx32uE7RjZe+i6acCCQmO
 rJqib7VWlzVQnD5E+3s9i390c5iNm4jSstWXmG1six4si3rz62dWGcNRLnYjRr/SZmuVm+
 yHcpAYzY6MzGcyt3YOwKd8i/ltpfzAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-dgJAmS8ZNp2A4lgOGFa89w-1; Fri, 05 Mar 2021 04:39:56 -0500
X-MC-Unique: dgJAmS8ZNp2A4lgOGFa89w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26F4B108BD06;
 Fri,  5 Mar 2021 09:39:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-10.ams2.redhat.com
 [10.36.114.10])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54E051002382;
 Fri,  5 Mar 2021 09:39:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5BEA018000AE; Fri,  5 Mar 2021 09:22:41 +0100 (CET)
Date: Fri, 5 Mar 2021 09:22:41 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Colin King <colin.king@canonical.com>
Subject: Re: [PATCH] qxl: Fix uninitialised struct field head.surface_id
Message-ID: <20210305082241.dt53hczrvds3qoz2@sirius.home.kraxel.org>
References: <20210304094928.2280722-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210304094928.2280722-1-colin.king@canonical.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 spice-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>
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

On Thu, Mar 04, 2021 at 09:49:28AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The surface_id struct field in head is not being initialized and
> static analysis warns that this is being passed through to
> dev->monitors_config->heads[i] on an assignment. Clear up this
> warning by initializing it to zero.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: a6d3c4d79822 ("qxl: hook monitors_config updates into crtc, not encoder.")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Pushed to drm-misc-fixes.

thanks,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
