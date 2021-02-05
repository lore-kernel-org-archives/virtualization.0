Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60592C433DB
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 07:43:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4BC764E4A
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 07:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BC764E4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7632D81EE9;
	Fri,  5 Feb 2021 07:43:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KUOWfO48rHDY; Fri,  5 Feb 2021 07:43:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5779381392;
	Fri,  5 Feb 2021 07:43:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31E06C08A1;
	Fri,  5 Feb 2021 07:43:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9CCAC0174
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 07:43:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A1799872F8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 07:43:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RB0xmVfa22cc
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 07:43:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2B88E87277
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 07:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612511016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QkctUj4JntN0l9IjN3mm31aWsWyPBr920PgHhtiFxa4=;
 b=K2WCE6/yn+0pm+1o9GnzpbMki9nz0SdXy4NWpoynMoZ7xEv6RCyRpbBvCAo2Ff+NhvLUyh
 aBfPAQWTTjC6NaTnyn1FycU08WHksddYC65ozmVhKDNrtPs1mOlX5vC8AsS8UMStfypzze
 Caxg+nsMsX1OCox+BaR0xt/JJvXmlDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-Id3HAsG6MuSpw28xyN0ZAw-1; Fri, 05 Feb 2021 02:43:33 -0500
X-MC-Unique: Id3HAsG6MuSpw28xyN0ZAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EECD5192CC41;
 Fri,  5 Feb 2021 07:43:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-108.ams2.redhat.com
 [10.36.113.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF35C5C1B4;
 Fri,  5 Feb 2021 07:43:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 35D6918000B6; Fri,  5 Feb 2021 08:43:30 +0100 (CET)
Date: Fri, 5 Feb 2021 08:43:30 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Tong Zhang <ztong0001@gmail.com>
Subject: Re: [PATCH v2] drm/qxl: do not run release if qxl failed to init
Message-ID: <20210205074330.zsb2lg5umgkxh2p3@sirius.home.kraxel.org>
References: <20210204163050.1232756-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210204163050.1232756-1-ztong0001@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, spice-devel@lists.freedesktop.org,
 Dave Airlie <airlied@redhat.com>
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

On Thu, Feb 04, 2021 at 11:30:50AM -0500, Tong Zhang wrote:
> if qxl_device_init() fail, drm device will not be registered,
> in this case, do not run qxl_drm_release()

How do you trigger this?

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
