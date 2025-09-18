Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6CC31195D
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208199; cv=none; b=hxQZBSPidw0e1l6hOy+NyWSt1ctmbzry79/evArii56bVXTfY7bJkRqN/QtVhJRaeyt5PHlaR6MEDadKxC7SwaSRygAZqFxWCnmAcSfDdOCiIUeaYOIQ53bskZijREIdoKOUE9lqhFNwHjhaW0Q/EItT7r5KOxpDgSXr3SW94b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208199; c=relaxed/simple;
	bh=Pw/MjLea6UioSwSASZnpZ8AAsRX5LWCOIOgzJejjR58=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q+WflDohwaereEBkg5s69CXRRPsq5caHT9LRGLiTaVeeAhEeWXkMLysdGwPLeIhAxqwx/hZ9uQAphHU0ir02sYvK31+0ez4l1q+NcQyUedDtrDNBxUgYObyYVYWDjzk+81i/nniUQkO97/yTcJuXQbhNqm9oEZUOSzxNCoppSUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITeteHoM; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITeteHoM"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 632188044F
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 15:09:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I9-eQ6hHdje5 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Sep 2025 15:09:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6389A80458
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6389A80458
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ITeteHoM
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6389A80458
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758208194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=OTSr1wJjkB666s7wnjnpL8189wpCEBf5U1utvv7uWvc=;
	b=ITeteHoMmVXWs3On/daRkbF+MyzvSplNpKeh/SowiFcBPyUyvjw0oyvpXrmlqwGEGJWe2G
	1DBC0ZHwLhh08WQiA24/Z15fLFQ8U2ZVgXoAxXCdd16vlq49xymwyRWKdiZxkydrNj0XUd
	PiINxg3Z0ob4WyvFWWIUkx+YmKh0TSI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-14pGDwBJPwGuR7onIK4ing-1; Thu, 18 Sep 2025 11:09:51 -0400
X-MC-Unique: 14pGDwBJPwGuR7onIK4ing-1
X-Mimecast-MFC-AGG-ID: 14pGDwBJPwGuR7onIK4ing_1758208190
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f2b9b99f0so6761965e9.1
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 08:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758208190; x=1758812990;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTSr1wJjkB666s7wnjnpL8189wpCEBf5U1utvv7uWvc=;
        b=flalPKU2ll1nkvL5R934HS1PuRq18nOLjE1BAoTgH/kkMj6YKQjke0pMChrKtZ3svT
         LHcVuTUBvr8nYwldY9+VOmdayJiBcTIkJKnyu91/Phs+HvoTYImJ1HlvyX7RWhWFIp1T
         ub9JE/XUjcLemX9Kj6Z9y5/q5qBAD6R3MRV61rYTY+EZJ2XXbn9Ta2Z4hALnKmWptaCd
         +01hOk59eYoo/Ah0vHusxq3l1OKoImV4EbBeLy9+UPkmuWkUQmhXsPlWphaik03+qy7c
         um6qQ0+iXwieOOP6oGAoftxdtn5PAxdtoYmf8aSU75ukMuQ9iQzVYeDzQt3EqIfl0xkz
         o3Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVWxUxSmBjh4pe6ERiEtIjtXflbpWPwKxGxsYy5JYSYjFuaZT5bUMn+E9xyyjrVSEhZvSkvJLZ8uoMv/9BGgg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy4A/GloxDBihQ2ZwosTuwUeLphpVDoA1Np33B3M43XIxwkybhk
	l3+poE5joeoxPX63bebpCXmYWjsVGcnBSONLjjeGpMT3TJ1Vq8OXqJYNh1Ohdve1z9/tKmIUVT9
	u2W/dJcAuYds3bBXnL551e6cA7wD7EcWj+URK/W1JnkcCUh+lkOYixEjW51yJaCl53S3cRgtL5w
	hMHuLKW2c=
X-Gm-Gg: ASbGncvJQIifyaWBC7xzcXuZ+OJ0+TJnWG91Fsp+zxKe76niZzogdFOVhgjmoJUqtMa
	6W+HDqFMLJDmOQO3DBvKhl37cuvltqEcZ33lGt5xw5AO+mWJFdo95UPyAhPo8A8a0HyJ5T2ddY9
	fiBIq8XJ/UsM+XvZ0U+gGTekEU0XYTHdeKyXrBzPAZNq/NkCMWIT8Z/qOJhdQgeuoMfoVx+XXZd
	+4N01C4/YOXMOdrAxgQFrCHjl7ZuRmy3BcYRPuLU6VUCmdI0XtVSK349qApZDamxuzfJvDU1SfQ
	KTzhR+XZGREcJBc9UBIn3PivPVDMgi2p02g=
X-Received: by 2002:a05:600c:1d1d:b0:45d:d259:9a48 with SMTP id 5b1f17b1804b1-467aad147bcmr382885e9.9.1758208189541;
        Thu, 18 Sep 2025 08:09:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaJ2Mef73Q+HoINKzwUEsC1cVU7zVeFESpyDHECaEl4JHKCNZY7hJUwLmFSP/kpoOzvVa5TQ==
X-Received: by 2002:a05:600c:1d1d:b0:45d:d259:9a48 with SMTP id 5b1f17b1804b1-467aad147bcmr382485e9.9.1758208188954;
        Thu, 18 Sep 2025 08:09:48 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7478sm4120284f8f.38.2025.09.18.08.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:09:48 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:09:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, ashwini@wisig.com, filip.hejsek@gmail.com,
	hi@alyssa.is, maxbr@linux.ibm.com, mst@redhat.com,
	zhangjiao2@cmss.chinamobile.com
Subject: [GIT PULL v2] virtio,vhost: last minute fixes
Message-ID: <20250918110946-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8rk6C3F2tX9SY0t8UdpEEaX15-FyVvMrih61HE7w0eE_1758208190
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

changes from v1:
drop Sean's patches as an issue was found there.

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 1cedefff4a75baba48b9e4cfba8a6832005f89fe:

  virtio_config: clarify output parameters (2025-09-18 11:05:32 -0400)

----------------------------------------------------------------
virtio,vhost: last minute fixes

More small fixes. Most notably this reverts a virtio console
change since we made it without considering compatibility
sufficiently.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alok Tiwari (1):
      vhost-scsi: fix argument order in tport allocation error message

Alyssa Ross (1):
      virtio_config: clarify output parameters

Ashwini Sahu (1):
      uapi: vduse: fix typo in comment

Michael S. Tsirkin (1):
      Revert "virtio_console: fix order of fields cols and rows"

zhang jiao (1):
      vhost: vringh: Modify the return value check

 drivers/char/virtio_console.c |  2 +-
 drivers/vhost/scsi.c          |  2 +-
 drivers/vhost/vringh.c        |  7 ++++---
 include/linux/virtio_config.h | 11 ++++++-----
 include/uapi/linux/vduse.h    |  2 +-
 5 files changed, 13 insertions(+), 11 deletions(-)

