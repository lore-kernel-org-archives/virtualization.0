Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03CDC05027
	for <virtualization@archiver.kernel.org>; Wed,  1 Feb 2023 16:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 797E681317;
	Wed,  1 Feb 2023 16:07:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 797E681317
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dZgeLs8m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0e3MTNRJiwNl; Wed,  1 Feb 2023 16:07:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F081E81DE9;
	Wed,  1 Feb 2023 16:07:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F081E81DE9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3D77C0032;
	Wed,  1 Feb 2023 16:07:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44B1FC002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 16:07:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1ECF44088F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 16:07:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1ECF44088F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dZgeLs8m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6GglhvnvNuzW
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 16:07:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6BFD740884
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6BFD740884
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 16:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675267641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=ds+bcOZr5heYmlSzGupYn5r7OWFEs+A7chvOhxHR7is=;
 b=dZgeLs8mMDLhiCUx2AanxNbf8/Cl6IVhcD9FL79wPn17oixEH0Y1+yq2BslyHi8SYSNOur
 7o6oVeqGXtuodSRYp4S8WlOR4xgAIKwwxgDSKpjFF7S36cQ/x8DE1i0g8t1TAlwGken8Qa
 Abe7onEab2LOMkRwPFtUNxx0xth7xBk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-lxnL0xpkPhue7yPaqwTRKw-1; Wed, 01 Feb 2023 11:06:45 -0500
X-MC-Unique: lxnL0xpkPhue7yPaqwTRKw-1
Received: by mail-wm1-f70.google.com with SMTP id
 bg25-20020a05600c3c9900b003da1f6a7b2dso1327715wmb.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Feb 2023 08:06:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ds+bcOZr5heYmlSzGupYn5r7OWFEs+A7chvOhxHR7is=;
 b=8CVyC+lDrU3p33xnQ76Bl1P/Bs87fQK/fcKUk9ZQYF7hyBk4EhfFLrzoqL1xNzgouP
 fuWx+YAfHH2NIobg3x0wPQcRHQo14G53h92kz0Wu7iI+j8bcKaH+coEFsPlZt3oTuZ1w
 zWQivEuCnTJJYHYz5ggC/gXAy3EPck6+vZtQhEemERwG2uH2csO2mFEtm7xBkG+YX2Yu
 bWX6uLFOnIJf4ySPARxAGPweoOPQALwCPSz8jUY+r08G5h5me+deePK2JwAPEYjRFLny
 /YUPGUVk0vIBN6umuiBtkNzjjtqE6uLcwsVhcjPoSm80mpir4/rS2+Ef4XZ3x+mYnu8g
 vrCw==
X-Gm-Message-State: AO0yUKUAevYAD+19cQQu0yn0G6KPf8MTt7MYssO934upVS5UMGGJPV5I
 3fEV03SpRbix8O4KHnscANPimWEaDmPwlnsobcKBKr6bqOvkMtXwhSh1LS8gcA77OrbHtMXlZDv
 hCap7eVbbEgxV0tfxIXg1iEWaZPDCOCSegQsWQ38QxQ==
X-Received: by 2002:a7b:c85a:0:b0:3d2:392e:905f with SMTP id
 c26-20020a7bc85a000000b003d2392e905fmr2555825wml.24.1675267604394; 
 Wed, 01 Feb 2023 08:06:44 -0800 (PST)
X-Google-Smtp-Source: AK7set/jVf+CtAKaPX7i2XRfI1mq5BUZBWlGIqJzw98LsyTbSpvTi0jhWMgxZEzgBzcbZq6TokPTHg==
X-Received: by 2002:a7b:c85a:0:b0:3d2:392e:905f with SMTP id
 c26-20020a7bc85a000000b003d2392e905fmr2555797wml.24.1675267604200; 
 Wed, 01 Feb 2023 08:06:44 -0800 (PST)
Received: from redhat.com ([2.52.144.173]) by smtp.gmail.com with ESMTPSA id
 m13-20020a05600c3b0d00b003dc51c48f0bsm2433516wms.19.2023.02.01.08.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Feb 2023 08:06:43 -0800 (PST)
Date: Wed, 1 Feb 2023 11:06:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio,vhost,vdpa: fixes
Message-ID: <20230201110640-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eric.auger@redhat.com, bcodding@redhat.com, 007047221b@gmail.com,
 viro@zeniv.linux.org.uk, mie@igel.co.jp
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

The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 6b04456e248761cf68f562f2fd7c04e591fcac94:

  vdpa: ifcvf: Do proper cleanup if IFCVF init fails (2023-01-27 06:18:41 -0500)

----------------------------------------------------------------
virtio,vhost,vdpa: fixes

Just small bugfixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eric Auger (1):
      vhost/net: Clear the pending messages when the backend is removed

Jason Wang (1):
      vhost-scsi: unbreak any layout for response

Shunsuke Mie (1):
      tools/virtio: fix the vringh test for virtio ring changes

Tanmay Bhushan (1):
      vdpa: ifcvf: Do proper cleanup if IFCVF init fails

 drivers/vdpa/ifcvf/ifcvf_main.c  |  2 +-
 drivers/vhost/net.c              |  3 +++
 drivers/vhost/scsi.c             | 21 +++++++++++++++++----
 drivers/vhost/vhost.c            |  3 ++-
 drivers/vhost/vhost.h            |  1 +
 tools/virtio/linux/bug.h         |  8 +++-----
 tools/virtio/linux/build_bug.h   |  7 +++++++
 tools/virtio/linux/cpumask.h     |  7 +++++++
 tools/virtio/linux/gfp.h         |  7 +++++++
 tools/virtio/linux/kernel.h      |  1 +
 tools/virtio/linux/kmsan.h       | 12 ++++++++++++
 tools/virtio/linux/scatterlist.h |  1 +
 tools/virtio/linux/topology.h    |  7 +++++++
 13 files changed, 69 insertions(+), 11 deletions(-)
 create mode 100644 tools/virtio/linux/build_bug.h
 create mode 100644 tools/virtio/linux/cpumask.h
 create mode 100644 tools/virtio/linux/gfp.h
 create mode 100644 tools/virtio/linux/kmsan.h
 create mode 100644 tools/virtio/linux/topology.h

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
