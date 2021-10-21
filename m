Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83316C433F5
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 11:52:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7DF606A5
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 11:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D7DF606A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BCE444026D;
	Thu, 21 Oct 2021 11:52:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eM1bKWiCqKpY; Thu, 21 Oct 2021 11:52:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 40F814024E;
	Thu, 21 Oct 2021 11:52:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0181EC001C;
	Thu, 21 Oct 2021 11:52:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0855DC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 11:52:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F12A640253
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 11:52:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FIx8eOMylnEk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 11:52:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D29A4024E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 11:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634817139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nkR+oFxKKFhfvl+Z7jaZhoo5MOuwspO0iqnEPlialBQ=;
 b=O5p2sBFyrzw4afZbxG+HI0s5BHtQREnBCSpdwfVSkT4kBjdGUxH2E0yqmVfFvoi8DI6BeC
 0bKECe2UnDt7cO549KK+2GNTgtT/bbrzowi4C2vSd/222bZwjToarhDl5rlcjn+7WwHGQV
 CyK5rzzP1euyAgNcBU0Rc9hyakN6M8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-OMUUkmnpMmiO8tjOKpbysg-1; Thu, 21 Oct 2021 07:52:16 -0400
X-MC-Unique: OMUUkmnpMmiO8tjOKpbysg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF4A619253C3;
 Thu, 21 Oct 2021 11:52:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 533AB13C8A;
 Thu, 21 Oct 2021 11:52:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C668E1800796; Thu, 21 Oct 2021 13:52:12 +0200 (CEST)
Date: Thu, 21 Oct 2021 13:52:12 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Maksym Wezdecki <maksym.wezdecki@collabora.co.uk>
Subject: Re: drm/virtio: not pin pages on demand
Message-ID: <20211021115212.dk2kl2vbl6qotjwa@sirius.home.kraxel.org>
References: <20211021074445.452309-1-maksym.wezdecki@collabora.com>
 <20211021092535.ozafsijlakj7ccwc@sirius.home.kraxel.org>
 <327a5c8a-d82d-f115-27bb-37125affe24b@collabora.co.uk>
MIME-Version: 1.0
In-Reply-To: <327a5c8a-d82d-f115-27bb-37125affe24b@collabora.co.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
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

On Thu, Oct 21, 2021 at 11:55:47AM +0200, Maksym Wezdecki wrote:
> I get your point. However, we need to make resource_create ioctl,
> in order to create corresponding resource on the host.

That used to be the case but isn't true any more with the new
blob resources.  virglrenderer allows to create gpu objects
via execbuffer.  Those gpu objects can be linked to a
virtio-gpu resources, but it's optional.  In your case you
would do that only for your staging buffer.  The other textures
(which you fill with a host-side copy from the staging buffer)
do not need a virtio-gpu resource in the first place.

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
