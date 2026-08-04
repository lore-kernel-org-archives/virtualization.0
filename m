Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAB343BDD7
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Aug 2026 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877596; cv=none; b=RiZEJXGegwqIax6/ljzHYjjOnDP2ETOpFShN8tRneHDsgn65OAXdPQ7d1U33JRI6HVZVFtDRM1LNLd/yJrr5Icv81QvEd6rnYq7E4aH9M8oCtkUJScIITS+qUS2aD0X7mZjD1e6FCQzoW9Z8nofO4KI64/WaVeePRgMpIG1bFHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877596; c=relaxed/simple;
	bh=/8DQzTwgTLijC2ECNXK7PMuHIRZhvXM6dV0bMACsCz0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lJlYBK7yrBhUt5AC3513iIizvflJmSDPHaqYs0UMBOnAtchsI7EgH7lHtWx5Y0kAqQrYC413zaejdzJ7KWOvpKrDg+pm1Vz9vZRj1wOxjBXRECd/vcAi6oapsJSqeiufCJ72x4SwMZTj13BXHkd5LiPJ2J9a3Zus/bUrEt+gJBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpHH1Nue; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpHH1Nue"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AC2FE401DE
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Aug 2026 21:06:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2UjOxk2RFMqe for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2026 21:06:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8C294401DD
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C294401DD
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fpHH1Nue
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C294401DD
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Aug 2026 21:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785877591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XBEFLiJGzT1OCUxcX75MonJY16dYU9oCUCgSXPQ6riM=;
	b=fpHH1Nueh1E+ax1h6oTmHVOfnTQfQkW1r4XBAscroDN8LGw98X8eCXg47KkeOfW10OiRS+
	SnJMOY2iJPWhVHiIdRJUPtaNRDTPEc5PUen7dtNtq5EUizWxuBMDKCPV/j7Nayw9+w78oI
	Hd2TqVcTi8NRrSi55CYD9JVv7EQnvro=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-jT6JjVJUPmuKzlsBYYnF-g-1; Tue, 04 Aug 2026 17:06:29 -0400
X-MC-Unique: jT6JjVJUPmuKzlsBYYnF-g-1
X-Mimecast-MFC-AGG-ID: jT6JjVJUPmuKzlsBYYnF-g_1785877588
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47407691804so163490f8f.1
        for <virtualization@lists.linux-foundation.org>; Tue, 04 Aug 2026 14:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785877588; x=1786482388;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XBEFLiJGzT1OCUxcX75MonJY16dYU9oCUCgSXPQ6riM=;
        b=pK7alq47A2owqO3Ya733bYINObBTB+j7A16/hq2zAg3Uu1hyC+BEy5ReftyHwFTSz7
         NRJQ1J6OUB6LjJtjOMTUjnyzTvBnBA/kyujj7q+VsAY7JtV0ZDYTnIKNL2+kOa2hpknD
         /qNabwdoihx09FDVzGpC7ghO++zt6XFjBCwBU+GpFIjq7qFLtlSFW9AWkXYi8n6dsA7Y
         E0fgK9onDI0rY6iCbqVIFB2nxFftNKUe/mIdZ0C3MXsz7NRvIN7IuCPZyddcm2xICtWD
         NTSi8eHm0NF9JM7OuqD0+vuMJPw8H1VEGeFizoGbMsD+zb7HyI1DtjIkzQST9TnKIjXZ
         2ILw==
X-Forwarded-Encrypted: i=1; AHgh+RrDjmKNoR7aZtUutb9wM01iKp3SuMkRj/gECkYQFMYYklpYMTqjZjyhyVJRMoBQVFbDEO77m9QaBmep9gTgwg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw9RkOQ9SNeROz0SxGaTiw4msX2WXYAMeKJZP9Z7chyxYvMrvA6
	oGOycPxr3VwXOskhrfbAl+hhGD4wd+CPnAcCIWew6eLVP3Z7zD8Nk7hh7GqNdbWpJPPWOfi7ce4
	unEcTmesJx50fMurnqaziJtas8jxP3npbvfxIuBWcCCPbwbqUXSY4alqHIFm5pJVbu0hXE0rAvu
	S/rX6YGw0=
X-Gm-Gg: AR+sD11dtYGr/9gGxLh4+ET5lyq33/SCuqcx33a2RY0IGmNzV1a+N+2IEJDUMwuQQfZ
	2tTa4k5R4y27fSJIalLCLaiwCJuCnRNbpnJh8DuA9I9fzwAqUKOXrqpZfUx0OrXsnz/0Ln6dAAD
	7ILwStuLLnEN4dPddmmMLhQnm1MhNWE33mkBYAa5TYvKDV63Ig2uDJWT+/zRDKa1mtwNNJm47rC
	WesU9A72j0E5g6RRVmUVyFbFFbHdJyjK0I50FuthVGAltnCatIhq4E8gSoi4feRRiJasi7ajuoQ
	iTHOnorNG+13FZXqlQiH3t4O/EfSlFlnoNLTCYRW3tjRMk7CDRrJX8cBfYzejY0qK76m+PdX8TD
	kw1pe2JiGz7O/wYDOS5KIDg==
X-Received: by 2002:a05:6000:480e:b0:472:3090:d878 with SMTP id ffacd0b85a97d-47fec509a06mr3321438f8f.4.1785877588399;
        Tue, 04 Aug 2026 14:06:28 -0700 (PDT)
X-Received: by 2002:a05:6000:480e:b0:472:3090:d878 with SMTP id ffacd0b85a97d-47fec509a06mr3321388f8f.4.1785877587944;
        Tue, 04 Aug 2026 14:06:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec249a5fsm2985791f8f.33.2026.08.04.14.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:06:27 -0700 (PDT)
Date: Tue, 4 Aug 2026 17:06:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alhouseenyousef@gmail.com, borntraeger@linux.ibm.com,
	dtatulea@nvidia.com, junvyyang@tencent.com,
	linfeng.sun.dev@gamil.com, linfeng.sun.dev@gmail.com,
	mst@redhat.com, physicalmtea@gmail.com, slf@hdu.edu.cn,
	stable@vger.kernel.org
Subject: [GIT PULL] vhost,vdpa: last minute fixes
Message-ID: <20260804170624-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JT9i2LChbKLNi5iSZr--kM_58h6js3spBtEJ6Tk-d9E_1785877588
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 075b74841bd0065a3bda3440873c747938e69b68:

  Linux 7.2-rc6 (2026-08-02 16:24:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 42bc45df5905e2b7dccb72adaf7730f66cfbe03f:

  vhost-scsi: reject feature changes after endpoint (2026-08-03 23:08:15 -0400)

----------------------------------------------------------------
vhost,vdpa: last minute fixes

A small number of fixes that seem too important to
wait until the next release.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Christian Borntraeger (1):
      vdpa/mlx5: Fix buffer length in create_direct_keys()

Jia Jia (2):
      vhost-scsi: flush backend after device ioctls
      vhost-scsi: reject feature changes after endpoint

Jun Yang (1):
      vhost: reset the vring metadata cache on vring reconfiguration

Linfeng Sun (1):
      vhost-scsi: Validate T10 PI scatterlist counts

Linfeng Sun  (1):
      vhost_iotlb: bound map allocation in add_range

Yousef Alhouseen (1):
      vhost/vdpa: reject overflowing PA map page counts on 32-bit

 drivers/vdpa/mlx5/core/mlx5_vdpa.h   |  2 ++
 drivers/vdpa/mlx5/core/mr.c          |  8 ++++--
 drivers/vdpa/mlx5/core/resources.c   | 11 ++++++++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 10 +++++---
 drivers/vdpa/vdpa_user/iova_domain.c | 11 ++++++++-
 drivers/vhost/iotlb.c                | 47 +++++++++++++++++++++++++-----------
 drivers/vhost/scsi.c                 | 20 ++++++++++++++-
 drivers/vhost/vdpa.c                 | 18 ++++++++++++--
 drivers/vhost/vhost.c                | 16 ++++++++++++
 9 files changed, 119 insertions(+), 24 deletions(-)

