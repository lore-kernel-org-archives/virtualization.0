Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A68C05027
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 15:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 909294099F;
	Mon, 20 Feb 2023 15:39:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 909294099F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cuUZ54Ay
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6h56dpzhJmdT; Mon, 20 Feb 2023 15:39:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ADDE5408EC;
	Mon, 20 Feb 2023 15:39:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ADDE5408EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E3D0C0033;
	Mon, 20 Feb 2023 15:39:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A677C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 15:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0502E60B9A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 15:39:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0502E60B9A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cuUZ54Ay
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C-tadO9lgxEK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 15:39:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6B3460BD3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D6B3460BD3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 15:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676907556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=blwIGNmJhagExeJthlnkpjNNfOF38rzxP15q8EfcTVM=;
 b=cuUZ54AykaQqubc8ycrUzc9ZO+n6xEvr2aeFdVe4R+gjyOJWcGe+xa1R0bLdPA27Jrr9Nh
 mbPn2V2MYZSHuNjTZdNk0Vhe+TrZyUt674AaXtNTw6EcACGn2/yUUgP8W2FH1Dx4z2XhU3
 1wYoNxTJ7qYGLZpADfd+maSDMYsu79k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-lI2gB4BFO9aCq9rkMLSXWQ-1; Mon, 20 Feb 2023 10:39:12 -0500
X-MC-Unique: lI2gB4BFO9aCq9rkMLSXWQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46D17100F82A;
 Mon, 20 Feb 2023 15:39:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8F20492B00;
 Mon, 20 Feb 2023 15:39:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 77451180091D; Mon, 20 Feb 2023 16:39:10 +0100 (CET)
Date: Mon, 20 Feb 2023 16:39:10 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 17/17] drm/cirrus: Use VGA macro constants to unblank
Message-ID: <20230220153910.wurtq3jpz3llq3v6@sirius.home.kraxel.org>
References: <20230215161517.5113-1-tzimmermann@suse.de>
 <20230215161517.5113-18-tzimmermann@suse.de>
 <20230216113330.rmzmkdvpxdqk2nrd@sirius.home.kraxel.org>
 <edafc067-f8f1-e45b-9b0b-da0f1cabac4b@suse.de>
MIME-Version: 1.0
In-Reply-To: <edafc067-f8f1-e45b-9b0b-da0f1cabac4b@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: airlied@redhat.com, sam@ravnborg.org, javierm@redhat.com,
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

On Mon, Feb 20, 2023 at 03:22:03PM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 16.02.23 um 12:33 schrieb Gerd Hoffmann:
> > On Wed, Feb 15, 2023 at 05:15:17PM +0100, Thomas Zimmermann wrote:
> > > Set the VGA bit for unblanking with macro constants instead of magic
> > > values. No functional changes.
> > 
> > blank/unblank should work simliar to bochs (see commit 250e743915d4),
> > that is maybe a nice thing to add of you modernize the driver anyway.
> > 
> > take care,
> >    Gerd
> > 
> 
> Do you have comments on the other patches?

Checked briefly only, looked sane overall.  Seems the blit and format
conversions helpers improved alot since I've added them initially (don't
follow drm that closely any more, busy with other stuff), nice to see
cirrus being updated to that and getting dirty tracking support.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
