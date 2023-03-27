Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B156C76195
	for <virtualization@archiver.kernel.org>; Mon, 27 Mar 2023 13:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E28BA61032;
	Mon, 27 Mar 2023 13:19:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E28BA61032
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a6La+48u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U4DI461hqqp9; Mon, 27 Mar 2023 13:19:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7E8A260BD1;
	Mon, 27 Mar 2023 13:19:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E8A260BD1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E678C0035;
	Mon, 27 Mar 2023 13:19:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 620F4C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3CA2660FA1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:19:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CA2660FA1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O3HSkpnHunAH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:19:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E90F260BD1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E90F260BD1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679923192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=fp97bd4egAyMlz94O+W8oRAJLsbe6t9my51Gm91T/aM=;
 b=a6La+48uF1wwhBHmYLfNCk0mzYxOeFLRbpl738We7+ghtDeFwY4/9d0UVQb4pLDyKMxaNK
 8bpMCVmT1CpP3huJtpgGayE+qX1iQsT+CMUK3HU6MIh8KaLzg+ZpXrc3o8xPm+jA3ZM6Uu
 XJSBBxxiGgnBs2Hl/pIABbAmHbWEj6I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-n4gIXESuOfWaVEAVFpfDbA-1; Mon, 27 Mar 2023 09:19:51 -0400
X-MC-Unique: n4gIXESuOfWaVEAVFpfDbA-1
Received: by mail-wm1-f69.google.com with SMTP id
 bh19-20020a05600c3d1300b003ee93fac4a9so5364572wmb.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 06:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679923190;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fp97bd4egAyMlz94O+W8oRAJLsbe6t9my51Gm91T/aM=;
 b=L4mMwsp8wWOae9iR7L8/grNeGPDHJMNt45dl6Ujv717fdVNyxqblrWY+DyCkvntfVe
 tqx6mjwYR4fRrIuAK3GmeRfLF4OWmlP8VlPXxarLMeO1HhJ4BLFNgbL2jw48vEGg34UG
 07FrHP7fqAjsjX/FvZ/HEJ8/Vxjp71G6RZLPnDKKBr8QVc/yer9rp6lNcYXfDtyPFr4V
 bk/3mpbeScARn9S6v6Hbb44SlnohQvq4NEBB8/k6wN83LyKycfAHIH8IBiY6Vu4WL9ad
 W2utugAwPjMsKE0HZPX5oBt8YUzayFfjPEYMiQfe+Ls/6NhH2ZRr26a6osl03w9ba2w+
 9kBg==
X-Gm-Message-State: AO0yUKXqlvH8BYMjTEa2BNqRDqA/LX9UrZZqL7eQJnAZwYvBybV3s+a4
 rUCwVYVpNVnI0DSR5kVShInVoyze0++syEVuJbOYL+JL/0WMC+MuKs3stLRnBMG+ko4ov0Ax2xi
 KSOPPy6D/Q6RmTox+G0JVYtloUCzUEuADHT0wILMD1Q==
X-Received: by 2002:a1c:7c1a:0:b0:3ee:6d88:774a with SMTP id
 x26-20020a1c7c1a000000b003ee6d88774amr8075072wmc.14.1679923190461; 
 Mon, 27 Mar 2023 06:19:50 -0700 (PDT)
X-Google-Smtp-Source: AK7set+a3nlhZjRZvrUa3ZYlE0VCFu21NVVFHGZYCsteCubT34r2yrI5XsBkcW+x/td8mODOzUHdhw==
X-Received: by 2002:a1c:7c1a:0:b0:3ee:6d88:774a with SMTP id
 x26-20020a1c7c1a000000b003ee6d88774amr8075048wmc.14.1679923190202; 
 Mon, 27 Mar 2023 06:19:50 -0700 (PDT)
Received: from redhat.com ([2.52.153.142]) by smtp.gmail.com with ESMTPSA id
 p5-20020a05600c358500b003ef6f87118dsm2752456wmq.42.2023.03.27.06.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 06:19:49 -0700 (PDT)
Date: Mon, 27 Mar 2023 09:19:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] vdpa: bugfix
Message-ID: <20230327091947-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com
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

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 8fc9ce051f22581f60325fd87a0fd0f37a7b70c3:

  vdpa/mlx5: Remove debugfs file after device unregister (2023-03-21 16:39:02 -0400)

----------------------------------------------------------------
vdpa: bugfix

An error handling fix in mlx5.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eli Cohen (1):
      vdpa/mlx5: Remove debugfs file after device unregister

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
