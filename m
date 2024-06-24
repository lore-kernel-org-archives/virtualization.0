Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D721805E
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219901; cv=none; b=lNI+YdQxQYJ/trgMQMFiVfeO5G4sQSeJN00jczlNZUkias1em251pBYgAfPAJ8yH+o1Kanwdwd/mj8tzXHuvB41+8oyUAWZspOSVQJkWyN+aaq5vBaAqBSvLbNwopORsGbGqpyGp4OLSafLCotF5p8X9k4WLmKjdAdmxefZO2xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219901; c=relaxed/simple;
	bh=LYwlii5fWUIRm63wbj3yCLbUGuIM17q04TgWFocXfHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PuNZ3jMGn15tobEb0xuzdfofw5wBYmI8Dh4yCZjHNv+pgM44aysK6jjlxsVr8JYE/GsRnSQhywROTypL61wCdvmpcZ6BXN7rtyJ/SBvdAp5EbMBpwUI4n3f6aba8S5xW6BZKoByBBOxrfWB9vrFPVzv/H5lOSfIKklLVfQwhUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=mjkpKSCJ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mjkpKSCJ"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec5779b423so16612751fa.0
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 02:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719219895; x=1719824695; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5v9eSTD0lZ4zwBOHnapE3GfLJ8VI0ftKFJRQU9E+C8=;
        b=mjkpKSCJvQ4rRp86xJvoKCE2pJvrSqzraAF7xEW3umy/YTESNrOp9qSyDD0rNqSnNG
         Qe3JLXAKivapD077q0E/xl9PJKbNNtEXdnOd21GuHRqRXuYDS1ue7z/28ub4QjJjhmMA
         Nx/qR8pBfzfszHZPmoHYCgA6ZksDdZNjADM9XsmR3xabevJ+JzQO5Na+96H0KDjO49in
         SwSbWWZS6R6SWz34GqBn5aSPc+xbTmWFSRtP9W61lGdAQ2FlfRJsT0bNFgjaA1pz1fnc
         /oWeQbN6WUNSLC40ljNdHaGa7rPflMR7s1hyhLSG7KG1lsk+4IrDK9746SV5kzFlmoDx
         vkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219895; x=1719824695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5v9eSTD0lZ4zwBOHnapE3GfLJ8VI0ftKFJRQU9E+C8=;
        b=YH9qAxWE0TaDI+N+gnIj2CXi2luSS3plnXavosC9L3RrnUtZzh/L6AnaBuZj6rvGER
         kt2P1rEc/Pr11qnVCxT0l+Y3RLpHc49cc/qvB7e9ld1yeRUFgKIOFKnvFDQ66KkYI3hU
         txG9cp+mtS8gtde/0C5hQbL3+oydYbnRtsHCrCOzJypzXRJeQc8J1RoobUZZgZCCNWhl
         fI/mrJkrl3lSdhKE/NkTxS95dIqvwieBaXnBVo/KdUTeF8Cp0eJp9yhIl2/RNe5vvZQp
         YvNjKjwNfb2w6mcsX4Rr08pU1vBYnWPCHTCtV6Quuz6svAcu3b5i2h51kkrqbyVocXui
         xckg==
X-Gm-Message-State: AOJu0YxHBWl8zcnAZjLnYgHuZIoBZL+QesV0TXxskI79MsSGxlzkTvXe
	v12r8pwDIGoJ8/vZI4IqC4ugu+XT7qA8qNJcIKf7oqXaKgGdvYh1rCKt0/abmBcvUCn10+FZ6Iq
	HcSk=
X-Google-Smtp-Source: AGHT+IGaSwz8ww4IUZD2uDktlaSecN2PFcz3hP4Umou4FioEqv4KhNQuApJ+VtdQnNeCsI/GRhcNBg==
X-Received: by 2002:a2e:3512:0:b0:2ec:5488:da with SMTP id 38308e7fff4ca-2ec5937382amr29228891fa.40.1719219895317;
        Mon, 24 Jun 2024 02:04:55 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0bea05sm165840145e9.18.2024.06.24.02.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:04:54 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com
Subject: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue commands execution
Date: Mon, 24 Jun 2024 11:04:43 +0200
Message-ID: <20240624090451.2683976-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently the admin queue command execution is serialized by a lock.
This patchsets lifts this limitation allowing to execute admin queue
commands in parallel. To do that, admin queue processing needs to be
converted from polling to interrupt based completion.

Patches #1-#6 are preparations, making things a bit smoother as well.
Patch #7 implements interrupt based completion for admin queue.
Patch #8 finally removes the admin queue serialization lock.

Jiri Pirko (8):
  virtio_pci: push out single vq find code to vp_find_one_vq_msix()
  virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
  virtio: push out code to vp_avq_index()
  virtio: create admin queues alongside other virtqueues
  virtio_pci_modern: create admin queue of queried size
  virtio_pci_modern: pass cmd as an identification token
  virtio_pci_modern: use completion instead of busy loop to wait on
    admin cmd result
  virtio_pci_modern: remove admin queue serialization lock

 drivers/virtio/virtio.c            |  28 +----
 drivers/virtio/virtio_pci_common.c | 109 ++++++++++++++------
 drivers/virtio/virtio_pci_common.h |   9 +-
 drivers/virtio/virtio_pci_modern.c | 160 ++++++++++++-----------------
 include/linux/virtio.h             |   2 +
 include/linux/virtio_config.h      |   2 -
 6 files changed, 150 insertions(+), 160 deletions(-)

-- 
2.45.1

