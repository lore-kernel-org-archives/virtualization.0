Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA1B2505B2
	for <virtualization@lists.linux.dev>; Wed,  5 Mar 2025 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188397; cv=none; b=ImVBzB4l2RIf56g/2k5lSU+cPBIcAwl1EisKWtHaeCK3XzzLDTj4N3u/4nG/H8VbF8WVDo7ICBrpR1sstwL1EaZ3yRYG5vVUIihhLdNUdC0mJIZkQOPjl+U6WSXeLdUH8EKtLMEjd71wrY4laWolNjt+c0r9Rds9uVXJFZI5VEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188397; c=relaxed/simple;
	bh=ZFMnP29tRojoZAYRWn2YoJlKwVnOhe/hYMgtVR64B/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=i8az7OdhBLgXPm36Fbc1O+Sp14A/LQeUMS9NhTccqGr7cOZ1L9MXNN9g/U4xltzp9mi7BOYaPjvvStBUZwfF/bJig9R9Ts6+ZcZQ+S5YV38BAA8wlmk5FaVm9invN6GRAkPbdu0UG9Q3h2CelZsZ6vvWE3SVjjt1cqf7Mwj7n5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHYfMMNL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHYfMMNL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741188395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EWytTCujcELs5/4BiTEaWtlYBtC+JW3njDIGrLsFaXA=;
	b=NHYfMMNLrhgpLmnP7HIgF/+KBGvVwmAO75J8dnvbqeZSanK5CNdiSd0cwejivd07f5CRsi
	gTH2qoT1Kto6KqP1spMeir+qVA47OzIB/0bAfU44EEyqNC8H4pWK/gTxFcw81KXSi0x8aG
	tFIDZY7uuzEJBiNfywPWPiGBjrQegr0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-pFuxlgkSPe26YVszzpcaBQ-1; Wed, 05 Mar 2025 10:26:33 -0500
X-MC-Unique: pFuxlgkSPe26YVszzpcaBQ-1
X-Mimecast-MFC-AGG-ID: pFuxlgkSPe26YVszzpcaBQ_1741188392
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-223fd6e9408so6415375ad.1
        for <virtualization@lists.linux.dev>; Wed, 05 Mar 2025 07:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741188392; x=1741793192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWytTCujcELs5/4BiTEaWtlYBtC+JW3njDIGrLsFaXA=;
        b=VjgF38qNFa1AroePVDnijWaSDA9xA/4cpZJnEARGHlqdyZsIHOFcX6xmVXXHlj7afH
         eMVhEuVHALXrXGyjgp78GZrDA9PJcq7aoaVy8r4FNoBYXxoBe26xQp9JEopTy2/5z7jW
         vMeYiayYwBc7Lv3tqWLyPuRcH/oDGG5VrVWa+aPCDcL4H5Y4E2Ez3b9K9UmwuIe2S6Cu
         q3Ez6hNcY9vQxcgNlFBGcPOhJAmDfZ36jcBtZ/+47kv0Wmm4Wu045SjmTzriwc50Hdkk
         h/R1Di8x8PWIPv9diAoGq2CfnjFgkTCqtkDocnxzaL49d/EJ+RVdGjwOrbUDGISEa574
         ioKw==
X-Forwarded-Encrypted: i=1; AJvYcCUJd//21G+sHwALAR0v7AndrZUgjhaIyLPrhBZClUfDr05T83hcP5cfpI1c7K8qoL1esvqyReKOBXoz3fBBLg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2QMSuG2fEXwOw1j/zWLmMtfGs5Rlc1+rYVoIVASbGuY8FsQW+
	9fhLQxt9LPSY/UELm6ROzdSA190K/GimgTIATIZfXynb5/mQuv4+wBO+rFBsp5Lpe2TvO4z45cj
	C/1BPLmT9Hn2NCuG7z/HNKDMvDwIdHDzyMBzpmY5TlnBn2kkxv+S+i7gtEb0lU+ve
X-Gm-Gg: ASbGncvxn5Udm7HqR/yFK6rLUOX5j9mbCLhcB3axCPZ4g8PvRCJvr0YkSwKHX/4Efs+
	gEFPvqTpbrks4Wudd7nEsOfghh99K1xX7wty4+ymPUrUywqC/sGoOrIigQse29Ag70AqvYythIL
	iUbzriFbhCP1IvJ4BWT8W1yRarNcKhn5dL9+TyqC7V/0nyEdGflbiMkW6ODTOFWw7s0ZiA031KF
	St7KbAnP5huG/t65ZfGAheVHCGpr+Zav+Fw65a0a24YbOs+8WhCXMeXEABtDrtIa+r+06gtQEa+
	K84m3nBv7Hg7gw0h
X-Received: by 2002:a05:6a00:9a0:b0:736:38b1:51c3 with SMTP id d2e1a72fcca58-7366e75b316mr13315914b3a.10.1741188392434;
        Wed, 05 Mar 2025 07:26:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1AgdJworx0wc6ga7cTSTBOuDEcumamKctgiwANw8/Rb3cfxQmtMLlo6lyVJUiuFftqJ0LQA==
X-Received: by 2002:a05:6a00:9a0:b0:736:38b1:51c3 with SMTP id d2e1a72fcca58-7366e75b316mr13315865b3a.10.1741188392100;
        Wed, 05 Mar 2025 07:26:32 -0800 (PST)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7364b4eff66sm6983292b3a.83.2025.03.05.07.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:26:31 -0800 (PST)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	kraxel@redhat.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	dmitry.osipenko@collabora.com,
	jfalempe@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH drm-next 0/2] Enhance drm_panic Support for Virtio-GPU
Date: Thu,  6 Mar 2025 00:25:52 +0900
Message-ID: <20250305152555.318159-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mu_yJ39ktI1N4kewz5krFTAsDpDJeTuJmcas3VtStwY_1741188392
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Hi

This patch series proposes enhancement for drm_panic. While virtio-gpu
currently supports drm_panic [1], it is limited to vmapped shmem BOs.
IOW, it does not work in non-VT FB environments, such as GUI desktops.
This limitation arises because shmem BOs require vmap, which cannot be
used in a panic handler since vmap is sleepable and takes locks. To
address this, drm_panic needs an atomic variant of vmap.

The first patch (1/2) introduces atomic_vmap, and the second patch (2/2)
updates the existing virtio drm_panic implementation to use the
atomic_vmap. I've tested these changes in both Gnome and VT
environments, and they work correctly.

Best regards,
Ryosuke

[1] https://patchwork.freedesktop.org/patch/635658/ 

Ryosuke Yasuoka (2):
  vmalloc: Add atomic_vmap
  drm/virtio: Use atomic_vmap to work drm_panic in GUI

 drivers/gpu/drm/drm_gem.c              |  51 ++++++++++++
 drivers/gpu/drm/drm_gem_shmem_helper.c |  51 ++++++++++++
 drivers/gpu/drm/virtio/virtgpu_plane.c |  14 +++-
 include/drm/drm_gem.h                  |   1 +
 include/drm/drm_gem_shmem_helper.h     |   2 +
 include/linux/vmalloc.h                |   2 +
 mm/internal.h                          |   5 ++
 mm/vmalloc.c                           | 105 +++++++++++++++++++++++++
 8 files changed, 228 insertions(+), 3 deletions(-)


base-commit: e21cba704714c301d04c5fd37a693734b623872a
-- 
2.48.1

