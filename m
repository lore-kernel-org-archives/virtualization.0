Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79489C433FE
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 09:25:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164BD60E96
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 09:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 164BD60E96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D915B40480;
	Thu, 21 Oct 2021 09:25:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sQCM1fUFH4ij; Thu, 21 Oct 2021 09:25:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 891B14036A;
	Thu, 21 Oct 2021 09:25:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6731BC001C;
	Thu, 21 Oct 2021 09:25:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D55DC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:25:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05D5F40438
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:25:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KvmDCsFp7-XI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:25:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 427154036A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634808343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YJQKG503ZNKkyZmKV0Jhtz+/MLcMYe7jL+aDtTbLusA=;
 b=QZpSTGQv5gWPR6Ulu2qeJTCUTkh+PXaduhVUAXWdNGqdI4K49wZaXtzG0mWjCCOH+u5wCH
 pUCPrQ+7TRoIqiChgWZjN8AQCKaClaowjLvSggME5lUevUFnK9nrsip1QiExHPMwhULJmM
 EzOaX0U8umLlIQ0KWSA4O4MfDej08V0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-iixGFGxMPGSxaTRYOLSRlw-1; Thu, 21 Oct 2021 05:25:39 -0400
X-MC-Unique: iixGFGxMPGSxaTRYOLSRlw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C49B1922960;
 Thu, 21 Oct 2021 09:25:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 373B15BAE0;
 Thu, 21 Oct 2021 09:25:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 616C31800796; Thu, 21 Oct 2021 11:25:35 +0200 (CEST)
Date: Thu, 21 Oct 2021 11:25:35 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Maksym Wezdecki <maksym.wezdecki@collabora.com>
Subject: Re: drm/virtio: not pin pages on demand
Message-ID: <20211021092535.ozafsijlakj7ccwc@sirius.home.kraxel.org>
References: <20211021074445.452309-1-maksym.wezdecki@collabora.com>
MIME-Version: 1.0
In-Reply-To: <20211021074445.452309-1-maksym.wezdecki@collabora.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: David Airlie <airlied@linux.ie>, mwezdeck <maksym.wezdecki@collabora.co.uk>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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

On Thu, Oct 21, 2021 at 09:44:45AM +0200, Maksym Wezdecki wrote:
> From: mwezdeck <maksym.wezdecki@collabora.co.uk>
> 
> The idea behind the commit:
>   1. when resource is created, let user space decide
>      if resource should be pinned or not
>   2. transfer_*_host needs pinned memory. If it is not
>      pinned, then pin it.
>   3. during execbuffer, decide which bo handles should
>      be pinned based on the list provided by user space

When you never need cpu access to your gpu object there is
no need to create a resource in the first place.

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
