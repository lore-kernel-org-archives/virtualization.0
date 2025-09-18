Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600AC30C36A
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206517; cv=none; b=Tq3C6EzAVcsNqSmpYD1JjjD0vOVZz0sdEFClEjadrbCNrhNGXJRRYTVPpxTqUjXuxwLu+2jMnCK3wXiHyXMetU9dZXoNtbqKO/+M2Spabmh6oEu1Pb1zyhKKbWctB9006ouYuzsa/C5ofFTrLqhVhVFRJMoG8J83ubX2OzF2TrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206517; c=relaxed/simple;
	bh=52mzwF50ZysPik2mfGb84bky8NEzJW1dDbmZc78Gl3o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kXGJ7xEgi9OECM2ebGniKftbmWRTQfT7ZQzRa3tpDtpfyBiMCPU4aeMMxywzGR1BTFU6UOPBiZL2GMc8wkvu1Pye3Dzw7OL/+2NKuKQ4NR6R4MhtXhVV6Ky5saJCrqFM8DdBlij0EzFViP8bCbR5+cAD+e6JbVWc6NFi4n3rlUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I92hhvne; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I92hhvne"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBCBA84AC7
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 14:41:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LdE0gepNDnFv for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Sep 2025 14:41:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E6DF08487D
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E6DF08487D
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I92hhvne
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E6DF08487D
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 14:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758206509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XGS8iYxGjjgCtPNfLtzzgPnXWY2Ig3ulBcoQ+vUpdX4=;
	b=I92hhvnejmVFbYB1S4O6uxwKDCpPHQ9DOb2YpM26hWG4p4nbx8ei6HCKEK8VNBvAK3S9H4
	NpY8HJqsuRAtYlVJf36K/NA+GW8z6wbWEoCzcUwnpnRMCCKEXDvXwq9WJVinbN4g3rnxvF
	DuGWUMobI4l3nH1P8swRrFc76XznV98=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-fTihK81FPqS08wfj77ienQ-1; Thu, 18 Sep 2025 10:41:48 -0400
X-MC-Unique: fTihK81FPqS08wfj77ienQ-1
X-Mimecast-MFC-AGG-ID: fTihK81FPqS08wfj77ienQ_1758206507
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45f29eb22f8so5421175e9.0
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 07:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758206507; x=1758811307;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGS8iYxGjjgCtPNfLtzzgPnXWY2Ig3ulBcoQ+vUpdX4=;
        b=MI2HMWzbq3D3zufy9O8uK3u8na4BzJjFEXk5sHVQ0r+MHaLtyS3sJ1f9yPZ4wpk7Js
         HV8dIKBq6PMBqf8ZNwIA0pG2hrqzJUey9+M7HzB+hYnJ13MJaKoCTwbNGyEIsP+L7CVt
         jULi9MbbRET10N1pThT6aXz8D7oc/sA8E+K3I2CVAweNbRBrYF6BS+q77uDEgdN7YKtD
         BW4Fhnf9R0R+CoTmK5Aie+bgp4gPNBo2gCvWmmpZ+mzkcYXGgK2U/LBVD+tHFtVE8ydC
         FV1b2Zd3U2iVTY6rdw5oXxNquAWFRGsO6z5Mrl6+0nIIpPgpQg0NPCpW3XM5hUFyOgGK
         QwUw==
X-Forwarded-Encrypted: i=1; AJvYcCVDZ14cCLkJdHWs9L/eXwoQ1UKwudNAgYG5I0+STd+P6wOT+KMxTSVhQEzpbUL3Rz+mw6rZZD7Tg345ABaKSg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yztt4QhnWASQJzVmoM0+oDOK37XYzEUnezEad/LgbbZ7iKPigEI
	NswRoSLwoSl75tNNRrJrIJCA2nSpTijVbNmV9oucPRQfOoLewmlTS6rniNaLLIf/1XLfWYMTLme
	RkEDoRsDWRth7Q31fJl+zTUnlBwpRlMR1GvgfYnDKpxdd8zggBAZVXS6dVm5nI8tzrQIFwNMWCB
	xSYLT2C5U=
X-Gm-Gg: ASbGncvk6H5HdtVLEo8u07m9RYaF9YSTs4GeitL2bKw98W8hRet7FroqOk93pkCkiQi
	HNlNQJBJC/bI17B/zAkXUW3MhaO2l2d9M6yTNLeB4EkJK2KFyCL2dXvodqjmv8gkpsxFQOUz0iw
	8IX1ninu3VomgmhxRoSIZuCL8SUZk7n1CQ6oNAWg2RGyJ2unFD0dzVQJkQ5MfYK7b4arZymx1ER
	qPBGlIK7f5qKGrvou2o6edLaah7kHl0dRtMgUGPv/D9hWO+itn2BJrLzj3Iiab5OxcYseFxl9Mj
	6EheS/47u9osCOcgW5zAKhMkEoCW9JEJGdI=
X-Received: by 2002:a05:600c:3b05:b0:461:8b9d:db1d with SMTP id 5b1f17b1804b1-46201f8aa61mr51947645e9.7.1758206507307;
        Thu, 18 Sep 2025 07:41:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6KtyNG51lUBBb+796Ksha+xJ3k91Ah4nN79uv8tPH32cwmgf4CIFGIqg2jBve/wowaCq5Rg==
X-Received: by 2002:a05:600c:3b05:b0:461:8b9d:db1d with SMTP id 5b1f17b1804b1-46201f8aa61mr51947335e9.7.1758206506772;
        Thu, 18 Sep 2025 07:41:46 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac3fdsm42562565e9.1.2025.09.18.07.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:41:46 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:41:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, ashwini@wisig.com, filip.hejsek@gmail.com,
	hi@alyssa.is, leiyang@redhat.com, maxbr@linux.ibm.com,
	mst@redhat.com, seanjc@google.com, stable@vger.kernel.org,
	zhangjiao2@cmss.chinamobile.com
Subject: [GIT PULL] virtio,vhost: last minute fixes
Message-ID: <20250918104144-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dKtXWB1O3ehQZi0RpTIfQWP7kWiB0sFI1Tfi6qGVG7M_1758206507
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 549db78d951726646ae9468e86c92cbd1fe73595:

  virtio_config: clarify output parameters (2025-09-16 05:37:03 -0400)

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

Sean Christopherson (3):
      vhost_task: Don't wake KVM x86's recovery thread if vhost task was killed
      vhost_task: Allow caller to omit handle_sigkill() callback
      KVM: x86/mmu: Don't register a sigkill callback for NX hugepage recovery tasks

zhang jiao (1):
      vhost: vringh: Modify the return value check

 arch/x86/kvm/mmu/mmu.c           |  7 +-----
 drivers/char/virtio_console.c    |  2 +-
 drivers/vhost/scsi.c             |  2 +-
 drivers/vhost/vhost.c            |  2 +-
 drivers/vhost/vringh.c           |  7 +++---
 include/linux/sched/vhost_task.h |  1 +
 include/linux/virtio_config.h    | 11 ++++----
 include/uapi/linux/vduse.h       |  2 +-
 kernel/vhost_task.c              | 54 ++++++++++++++++++++++++++++++++++++----
 9 files changed, 65 insertions(+), 23 deletions(-)

