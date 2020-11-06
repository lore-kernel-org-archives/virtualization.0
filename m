Return-Path: <SRS0=3a2n=EM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F053EC2D0A3
	for <virtualization@archiver.kernel.org>; Fri,  6 Nov 2020 08:24:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3041220936
	for <virtualization@archiver.kernel.org>; Fri,  6 Nov 2020 08:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPH2/oAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3041220936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8C8DE85551;
	Fri,  6 Nov 2020 08:24:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6hE1EdMPhoeA; Fri,  6 Nov 2020 08:24:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8BAAD85516;
	Fri,  6 Nov 2020 08:24:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 729D9C088B;
	Fri,  6 Nov 2020 08:24:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47478C0889
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 08:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3B910868D0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 08:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TNDYeCQ9fhBY
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 08:24:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3A2C4868BB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 08:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604651087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=29qfegGrh7AruURuvpgC8HtdchFL+7zQsPXILi0X3v4=;
 b=YPH2/oAlqvoc5NHN/oy92a2TlYwJ2voYeGwHuI/0RJ2VFp7bVGhgChIWB/eVdwbCoyTlXM
 tPy+q0n6VyQkb5GSHLBJaPxveQfakZHOTnwWG8nYTLLoGMSNBNn0snVT4vGqLVbxm+aFWE
 KlhXc0xRG/6LuQ8SIxNlNu/BT4BSzWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-ah-6QZFOO9-4DqOVgv1XMw-1; Fri, 06 Nov 2020 03:24:46 -0500
X-MC-Unique: ah-6QZFOO9-4DqOVgv1XMw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A301B1009E39;
 Fri,  6 Nov 2020 08:24:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 055505578B;
 Fri,  6 Nov 2020 08:24:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D5F6A11AB5; Fri,  6 Nov 2020 09:24:41 +0100 (CET)
Date: Fri, 6 Nov 2020 09:24:41 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Deepak R Varma <mh12gx2825@gmail.com>
Subject: Re: [PATCH] drm/qxl: replace idr_init() by idr_init_base()
Message-ID: <20201106082441.x2e5mmycikwd22pj@sirius.home.kraxel.org>
References: <20201105185016.GA71797@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105185016.GA71797@localhost>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

On Fri, Nov 06, 2020 at 12:20:16AM +0530, Deepak R Varma wrote:
> idr_init() uses base 0 which is an invalid identifier for this driver.
> The idr_alloc for this driver uses 1 as start value for ID range. The
> new function idr_init_base allows IDR to set the ID lookup from base 1.
> This avoids all lookups that otherwise starts from 0 since 0 is always
> unused / available.
> 
> References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")
> 
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>

Pushed to drm-misc-next.

thanks,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
