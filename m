Return-Path: <SRS0=G2sl=NU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4916FC432BE
	for <virtualization@archiver.kernel.org>; Sun, 29 Aug 2021 15:54:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDAC060F45
	for <virtualization@archiver.kernel.org>; Sun, 29 Aug 2021 15:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DDAC060F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A17F380C55;
	Sun, 29 Aug 2021 15:53:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9X35m6PfObd0; Sun, 29 Aug 2021 15:53:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4568880C11;
	Sun, 29 Aug 2021 15:53:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1861BC001A;
	Sun, 29 Aug 2021 15:53:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35234C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Aug 2021 15:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1775580B8E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Aug 2021 15:53:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FV7-Ngslv9Pl
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Aug 2021 15:53:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3761580893
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Aug 2021 15:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630252430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=/jaF7jZC8q/DpP5yyhldi4uUkfv/Q/aJYUDR7M+5EQ4=;
 b=C8/iuRsr/0CZwwWxbVUPkK/nQrkh1JN3aTER8xKJe3MZVBqX2H5rjl6Vxhou3hkxoThzCM
 t6pgQVVq8zQkVmUomtFKY9xDzsOwQ42/fcOwXoj+heqOLEM4law4sxdp5cdOmn5GqzUXJ/
 g31xDXFvGRarfUvVt6DBOvLvb7NqUWE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-0PUYvNXeOnGrBH3yPVQl8A-1; Sun, 29 Aug 2021 11:53:49 -0400
X-MC-Unique: 0PUYvNXeOnGrBH3yPVQl8A-1
Received: by mail-ej1-f70.google.com with SMTP id
 x21-20020a170906135500b005d8d4900c5eso1322209ejb.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Aug 2021 08:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=/jaF7jZC8q/DpP5yyhldi4uUkfv/Q/aJYUDR7M+5EQ4=;
 b=RirgTOLiHqtyi51D/lngBWkGglYxE88H9rF0LW+WVkVwMv8hDQQFO1g2Usy8uXFVBX
 DCxwgydJNmIlIKBUOzSpLIcWq8PP8HbspuIIMBFEC+IvdqRnygNLA+VmEvMxlvxablQn
 KNTQJjs5HaB6aNpRx8ztGZ1Vnjda2Z7Vh6k10SwI3ulU0k25qPbMyduL8tFOvO2fVLsk
 qKgVPHt73Sm9SW4DvShI9cvnHV9lycTxVrFIVEWyXjRGZuOMIVXdZr0ct9YBODSlzZ/y
 DCuT0smrHoxxlZSQQgFxf6HKgIN4d2C9tuJIXKrZWH0+iRSRsZmO/QfccctahnGZZa5/
 kO+A==
X-Gm-Message-State: AOAM533tt/Dq/tw2Y98b5L87dvh2XUQaX0OFHVXGVKOT9L36nSRpw2kE
 1dLW831BBRkdamsx9SMD5oWBuAAkOKSJCbGPBO7UUxe7NLZ/eBTL6hgVkY5I0OSSUuL287Iklvc
 iS5UUA9OQVoFqFii4teX2S6q1ZOQYt/6r9FY9FKOL1w==
X-Received: by 2002:a17:907:212e:: with SMTP id
 qo14mr19145565ejb.501.1630252427534; 
 Sun, 29 Aug 2021 08:53:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzobXz3Ef1GROPF3oUnWQrRnebrjXnwnoH6TBBe6U6SyFAGgXQrD00rBwtykUugZTIDZOQ8Lw==
X-Received: by 2002:a17:907:212e:: with SMTP id
 qo14mr19145554ejb.501.1630252427363; 
 Sun, 29 Aug 2021 08:53:47 -0700 (PDT)
Received: from redhat.com ([2.55.137.4])
 by smtp.gmail.com with ESMTPSA id s3sm5652608ejm.49.2021.08.29.08.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Aug 2021 08:53:46 -0700 (PDT)
Date: Sun, 29 Aug 2021 11:53:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: a last minute fix
Message-ID: <20210829115343-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 dan.carpenter@oracle.com
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

Donnu if it's too late - was on vacation and this only arrived
Wednesday. Seems to be necessary to avoid introducing a regression
in virtio-mem.

The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:

  Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 816ff7595135948efde558221c8551bdd1869243:

  virtio-mem: fix sleeping in RCU read side section in virtio_mem_online_page_cb() (2021-08-29 11:50:04 -0400)

----------------------------------------------------------------
virtio: a last minute fix

Fix a regression in virtio-mem.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
David Hildenbrand (1):
      virtio-mem: fix sleeping in RCU read side section in virtio_mem_online_page_cb()

 drivers/virtio/virtio_mem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
