Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10047273D66
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Aug 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304420; cv=none; b=aowS+D84z9CeHL7VBHccSlyNAIzss7ST3O6ofw61pCCStagOrMQFxi+MRitUjZLrhHn8ue0pjyK9YoQnhxtFynzsqtX6V+zWmTlLt4cnUOF9rjbNqFtysRA2zwgJgC04gVBfo0Vmgc9qzlHDaB4B7QVxkeIH+qUAA0P2TvQ5C68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304420; c=relaxed/simple;
	bh=HHk2BSgl9+A5isTV0Es7jKwwEf6+byROFUjgpG/p04U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YDA1rT5IjezxFgWAUDdLg4oVyIvd2I6gIMWqZho8hqcbk7tUdDePRf8HnIkJ/gb2RKXWjfT7OgmE80ImwjaiasDbK+WXnGyYoEyxMy14OWdW3TEM7iEciTeqZqq/HVjOqEWTTXLrwhuq0GPmKfWEG+dVqM/u/Ct4DRvLPW6qYdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=byRv1DeI; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byRv1DeI"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D8A440C09
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Aug 2025 14:20:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.651
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DQZbIcR_eELM for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Aug 2025 14:20:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C390940C08
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C390940C08
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=byRv1DeI
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C390940C08
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Aug 2025 14:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756304416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=opDJ3bmxpJeKk5jilIGi+lkf0qL9GQCfD0EA1RSLjbc=;
	b=byRv1DeIXj9HMcHdEcqVyM0fTmWxPjeMmYZSHX/PTCyGX5yh2FDT+Bf/Z6dge7FyY4Xqao
	KQgrCjPDHa8jB/XmLSqowYjdd3NjqI/w0Tbp89HbC/9T6NOq9gGLGU+tdAU+zfILKEep9n
	H6ykvAC2IWuT8DnG1nmV/qjgpQb7AVE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-TKzOz2w4MyqWVSvHFuWaHw-1; Wed, 27 Aug 2025 10:20:11 -0400
X-MC-Unique: TKzOz2w4MyqWVSvHFuWaHw-1
X-Mimecast-MFC-AGG-ID: TKzOz2w4MyqWVSvHFuWaHw_1756304410
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b72ef3455so2595225e9.3
        for <virtualization@lists.linux-foundation.org>; Wed, 27 Aug 2025 07:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756304410; x=1756909210;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opDJ3bmxpJeKk5jilIGi+lkf0qL9GQCfD0EA1RSLjbc=;
        b=en0Vpi2rPjIYm6frqc28kEI494uvRo5SWlBHFI0QFeWgRXkJoXPDKanVT26ISmK29F
         QshXnV6k9bJjrEYN1jLoi31LL5J9Ni/qnCPTsHXWVvxWHqKnpZZvK4AeL82b1p4YL4YE
         9JZdx0bb95fcqp7HG/EHyFv1dK0A+1/4M8CSstlSdW/4hi/C3PonrgcH/7J67JRbnJon
         xFX2ObdIw+oHl/Cno7m3w3BehJ42QEuZOx1K+3bC0NFpq7qci74svkC7HcTnxS8mE1lY
         HmB5lTwjY04g6A5LDmhcjL9oKSKfYnCk9wD1V6UNsD5zreM90KIRoQIKyhYIRr1ERvDU
         EMiA==
X-Forwarded-Encrypted: i=1; AJvYcCVu0w5SgNFEBLgMSCQvUbO1YZx1oIotH5Ajm0OTZNW8HIFr+3eBlQFYyzGz00NWvvNIjhXHf1Ql60W3+E1bmQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwDEwogRJcmvDvqWkfrQdFQo4kNlv3AM+dxHQ1G+Y+XHohw0c79
	8f6XKjledowpWCyW0Arr/C0r860asFxHjfmKkY4SCOIq2it+2nYcPNZTgAjEqcGTBfhX1S75uFG
	MiRnwf0xtbABM+5dJllU0vsVrWamccI5k2twOatdgNU6auoylEYNGmYg8HCBffC8NbfHrzdNYYE
	BKJ1E8Xu0=
X-Gm-Gg: ASbGnctGPh74LgplxqUX3RPepfVkt+/SdLGxwYdGkhCvOKsQE8H/1Fwl31NNtBLkBUt
	Q8xBn0rkAaNR/Ozk6i4C2VNbsScIF2I8mjMyA9fzFWG1q1pjqipqWwMtbUxNVvR8SEBImxvlzQi
	n6H1f065fimKxC8Hfu5t53q255X0V/LX9Bh17oLyj+gQuLWJz3LfZyOsRAsPAu0q9pRKWpyO2HH
	heQtRnT3HAWstnOXuC5Xde6vUf8T2M0FhKkZexca1b5QdaYa9ykM13TqqzdCcfiHN+V9ppz8NIv
	HWTsDopdI8AjXZOAEIuodW4feRXKHaM=
X-Received: by 2002:a05:600c:4746:b0:459:d494:faf9 with SMTP id 5b1f17b1804b1-45b517a0bacmr187068695e9.10.1756304409965;
        Wed, 27 Aug 2025 07:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFKNOtqoYfcFfl5BN6DYFKW7ddCHHcODDT/GXLs1RNGvAT7ubO6RW2Y1yIY5L1Dbp0HoJT5Q==
X-Received: by 2002:a05:600c:4746:b0:459:d494:faf9 with SMTP id 5b1f17b1804b1-45b517a0bacmr187068355e9.10.1756304409549;
        Wed, 27 Aug 2025 07:20:09 -0700 (PDT)
Received: from redhat.com ([185.137.39.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f3125ccsm32582585e9.19.2025.08.27.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:20:09 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:20:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	arbn@yandex-team.com, igor.torrente@collabora.com,
	junnan01.wu@samsung.com, kniv@yandex-team.ru, leiyang@redhat.com,
	liming.wu@jaguarmicro.com, mst@redhat.com, namhyung@kernel.org,
	stable@vger.kernel.org, ying01.gao@samsung.com,
	ying123.xu@samsung.com
Subject: [GIT PULL] virtio,vhost: fixes
Message-ID: <20250827102004-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u19b1NcTweIGpAqOFWAeA62tr7XAlkpPi1v514AcbtY_1756304410
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 45d8ef6322b8a828d3b1e2cfb8893e2ff882cb23:

  virtio_net: adjust the execution order of function `virtnet_close` during freeze (2025-08-26 03:38:20 -0400)

----------------------------------------------------------------
virtio,vhost: fixes

More small fixes. Most notably this fixes a messed up ioctl #,
and a regression in shmem affecting drm users.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Igor Torrente (1):
      Revert "virtio: reject shm region if length is zero"

Junnan Wu (1):
      virtio_net: adjust the execution order of function `virtnet_close` during freeze

Liming Wu (1):
      virtio_pci: Fix misleading comment for queue vector

Namhyung Kim (1):
      vhost: Fix ioctl # for VHOST_[GS]ET_FORK_FROM_OWNER

Nikolay Kuratov (1):
      vhost/net: Protect ubufs with rcu read lock in vhost_net_ubuf_put()

Ying Gao (1):
      virtio_input: Improve freeze handling

 drivers/net/virtio_net.c               | 7 ++++---
 drivers/vhost/net.c                    | 9 +++++++--
 drivers/virtio/virtio_input.c          | 4 ++++
 drivers/virtio/virtio_pci_legacy_dev.c | 4 ++--
 drivers/virtio/virtio_pci_modern_dev.c | 4 ++--
 include/linux/virtio_config.h          | 2 --
 include/uapi/linux/vhost.h             | 4 ++--
 7 files changed, 21 insertions(+), 13 deletions(-)

