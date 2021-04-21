Return-Path: <SRS0=p2bm=JS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477EEC43460
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 07:19:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BBC61424
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 07:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BBC61424
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4351140662;
	Wed, 21 Apr 2021 07:19:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 22wIwP3q5kcw; Wed, 21 Apr 2021 07:19:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id A777740582;
	Wed, 21 Apr 2021 07:19:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C714C000F;
	Wed, 21 Apr 2021 07:19:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AF2CC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 07:19:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E86CD40635
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 07:19:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FKYlXqWEqy3y
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 07:19:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7B4340582
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 07:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618989588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bpJvWuAak+WCSJcZ0A3y08kYBdBcvdyj4u51SSX61Nc=;
 b=eYvaa8p5n/KSYj788Sg7UTsB/1JadT6OJfPviIYkGLZn+6MBe/YW1LtoSUfLQZr0dfiJJj
 cl1LnknDZ2jBVUyw8rTtr1qdGD3+jm0Ayj5ZgsQrC84GsoaiePKWyJ7DlMKfI1yh8ymQym
 buABLyk6344CGLFivHhLW8pGb15GE5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-ZEMhuHKQPiSF4Io-fVMqtQ-1; Wed, 21 Apr 2021 03:19:45 -0400
X-MC-Unique: ZEMhuHKQPiSF4Io-fVMqtQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 442C9343A2;
 Wed, 21 Apr 2021 07:19:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-178.ams2.redhat.com
 [10.36.112.178])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 057321007604;
 Wed, 21 Apr 2021 07:19:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6AF14180084D; Wed, 21 Apr 2021 09:19:42 +0200 (CEST)
Date: Wed, 21 Apr 2021 09:19:42 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drm/bochs: Add screen blanking support
Message-ID: <20210421071942.eyzbao63pn54loj2@sirius.home.kraxel.org>
References: <20210420165659.23163-1-tiwai@suse.de>
 <6d2f59c0-113f-2d9e-1fb3-a794dafbd74a@suse.de>
MIME-Version: 1.0
In-Reply-To: <6d2f59c0-113f-2d9e-1fb3-a794dafbd74a@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

> > However, a tricky part is that the QEMU vga code does treat VGA_ATT_IW
> > register always as "flip-flop"; the first write is for index and the
> > second write is for the data like palette.  Meanwhile, in the current
> > bochs DRM driver, the flip-flop wasn't considered, and it calls only
> > the register update once with the value 0x20.
> > 
> 
> Unless bochs does things very different, the index should first be reset by
> reading 0x3da. Then write the index, then the data.
> 
> https://web.stanford.edu/class/cs140/projects/pintos/specs/freevga/vga/vgareg.htm#attribute

bochs should follow standard vga logic here.
Also a bochs_set_blank(true/false) helper function probably makes sense.

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
