Return-Path: <SRS0=gqJU=JY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D676C43460
	for <virtualization@archiver.kernel.org>; Tue, 27 Apr 2021 09:56:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A04613C7
	for <virtualization@archiver.kernel.org>; Tue, 27 Apr 2021 09:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A04613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8ED496069A;
	Tue, 27 Apr 2021 09:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FeZktCAHqJge; Tue, 27 Apr 2021 09:56:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46B4760623;
	Tue, 27 Apr 2021 09:56:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 181D4C000F;
	Tue, 27 Apr 2021 09:56:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F615C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 09:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9A6540454
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 09:56:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kqrV1fk5YuUP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 09:56:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 22BBD40172
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 09:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619517371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CqBHus7kNunXCOzNNE8SVUvJLOs32xdLfSR01IvYTjU=;
 b=cx46+i78TZkiiJrbOMnVvCkJP1b13mcQ23KUCc3C5sMzDKhgenXBB0T7ShYRpXJhWlDPgw
 yRWmbc5htuNMKOYLWZatglWh8ZwThuw24qzG0k4RV4gS8q9jcw7fx2cIOZh2NLJZyOIXZA
 Sql551LmJMAE17+6a15vo50a0MH85As=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-FkEAHZAiN6iRONCgF87vEA-1; Tue, 27 Apr 2021 05:56:09 -0400
X-MC-Unique: FkEAHZAiN6iRONCgF87vEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C10C96D241;
 Tue, 27 Apr 2021 09:56:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-203.ams2.redhat.com
 [10.36.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63C7D5D9C0;
 Tue, 27 Apr 2021 09:56:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4A7B61800393; Tue, 27 Apr 2021 11:56:04 +0200 (CEST)
Date: Tue, 27 Apr 2021 11:56:04 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2] drm/bochs: Add screen blanking support
Message-ID: <20210427095604.razo3nrqbfhcjrmd@sirius.home.kraxel.org>
References: <20210421080859.14869-1-tiwai@suse.de>
 <d1b1fa01-2254-f5cf-0ed0-f8e9c1c3f9ae@suse.de>
 <s5hk0oo1c9d.wl-tiwai@suse.de>
 <a557e727-d866-3dd3-ec96-741e7da7cf62@suse.de>
MIME-Version: 1.0
In-Reply-To: <a557e727-d866-3dd3-ec96-741e7da7cf62@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Takashi Iwai <tiwai@suse.de>, dri-devel@lists.freedesktop.org,
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

> > I'm fine to change in any better way, of course, so feel free to
> > modify the patch.
> 
> If no one objects, I'll merge it as-is. It's somewhat wrong wrt to VGA, but
> apparently what qemu wants.

No objections.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

FYI: cirrus is in the same situation, the modesetting works with qemu
but is possibly incomplete and might not work on cirrus real hardware
(it only binds to the qemu subsystem id for that reason).

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
