Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B870173453
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718777877; cv=none; b=tVlfaqm28mYa+/SCPhROlM/99GPa/vEsWRrnP0e5XnPbwNiOdmnAlvu4xeiJYgYiWo6N7yebeNd56G/vLzby3+jpCg1Fa4p9BAoqfZgZxV2e1Es9dqTjblrqCvYSr6fe59rTEtb94kJfJ3uMaxCrO7QI8SgkKH9vJNPregzi2+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718777877; c=relaxed/simple;
	bh=9JxSuB2e5zHpPnsceJPM2Z4u5/cle2vjrbTlQxjKR8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hzEObybfvWNbktf2QQGm9U/+k3nv7uIm127kj9ih0iMDVppYiNQAXfvg8VRs2EX57Iz4W+SrSw/pNTlgy6r7uEW1+X1hYMcVEnPCYxNahj8pbXLYoh3LknEp7OsO0ew+2Cxapxq3HLD6Fy7EbQbbEkg/mNKmjeZ3MJZK5Ft22gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GM7orkCx; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GM7orkCx"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-35f1bc2ab37so5580934f8f.1
        for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 23:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718777873; x=1719382673; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q9tHSYcUn51SyAd1faMtIy/AKsEtmmYSS3K41DfIPoQ=;
        b=GM7orkCxG4bjtDjUYsju2+xARoFOWQUiRd3g56z8GeCmQhj2zfKlmd6Pf84mxE6UMe
         3xsngjJ5Uyf8XPBFYXNpTIpTOPk9cGug2lqjxEIMN0zAe+dRl0LuuRiCP4UHVxXBERd0
         x8HLq0v0nk3EKuiAX5HLekyLakc8a9ZEyZ91YGCeR1Mjw8Iu4ilr8nm8/MW2V/Ix+7Ox
         s/P7lR3TTs6n7xWDHvYsn+Y6dA5SRmn2E258jcLOpHMVqFmO9s2S11FCJWh1tKm3bLVK
         4zqOvhaScQE4byiKDDQ1YxjvSlkLAfqyE72lf2qsYztygVo4zP4Iacdm91WzxgTajVLH
         xzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718777873; x=1719382673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9tHSYcUn51SyAd1faMtIy/AKsEtmmYSS3K41DfIPoQ=;
        b=csUUuWAkOdPCUBGQUZK+4cdmakXJ8Xn1de0J1++H0VdiIkZ1MlXS86IPQBxQpQKRQI
         ZgLV+3+V8wAbsNUyPN6BH2PHvsMMojxrUKUe3iExRNWMdqc2GQur4YFPgoGhDVfCegr6
         imlxLudp5go9Ja5cR/GE9lVtW9M7WuwTG6E0GLWm3rFk4pcUFacF/N2/CjteJgvZiDdm
         iHzMhNRvLoreprippXEBJvJojN7+YO4NclvGXfXreaSJRH+JJQ4R9I1cSiekxN7GvAR9
         GRUFuH/UtX9QeEmBDKpEbzMqbxCJY4AkHhutE8EIEpWYOoHN+Ed76w3esxp3c3SWwqw1
         GOcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+prGpXImoAOQJ5l2AmzjAql9PHnLa812cPoZMvTQHgGcagAlTaSt3h9bud8Oi6JybepegV4IG48bGfmUPAFkEZXjp00q05FJN4cRZkJ8=
X-Gm-Message-State: AOJu0Yyw3YCVIyTtqcY9uBuPyD5xa2MIzUUx5mhXJOtR1anRRM3F1hBC
	iFEkCeEkYTqeAQztIcJU8ZK54BOivNvwJJI3A7L6GJMAnHiFI9E3TxN1XSX7A9I=
X-Google-Smtp-Source: AGHT+IEdGqwuPmkL1V/kYBiEFfGbh6LP5DzFOB/llA59skIBzGQ4ntMUTADfLf03eLYt7oZOFgktEg==
X-Received: by 2002:a5d:51ce:0:b0:362:f853:603c with SMTP id ffacd0b85a97d-36317c77507mr1035090f8f.32.1718777872719;
        Tue, 18 Jun 2024 23:17:52 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3608fb0b145sm9878962f8f.102.2024.06.18.23.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 23:17:52 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	matttbe@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH net] selftests: virtio_net: add forgotten config options
Date: Wed, 19 Jun 2024 08:17:48 +0200
Message-ID: <20240619061748.1869404-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

One may use tools/testing/selftests/drivers/net/virtio_net/config
for example for vng build command like this one:
$ vng -v -b -f tools/testing/selftests/drivers/net/virtio_net/config

In that case, the needed kernel config options are not turned on.
Add the missed kernel config options.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20240617072614.75fe79e7@kernel.org/
Reported-by: Matthieu Baerts <matttbe@kernel.org>
Closes: https://lore.kernel.org/netdev/1a63f209-b1d4-4809-bc30-295a5cafa296@kernel.org/
Fixes: ccfaed04db5e ("selftests: virtio_net: add initial tests")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/testing/selftests/drivers/net/virtio_net/config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/virtio_net/config b/tools/testing/selftests/drivers/net/virtio_net/config
index f35de0542b60..040b600d52f1 100644
--- a/tools/testing/selftests/drivers/net/virtio_net/config
+++ b/tools/testing/selftests/drivers/net/virtio_net/config
@@ -1,2 +1,8 @@
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_DEBUG=y
+CONFIG_NET_L3_MASTER_DEV=y
+CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_NET_VRF=m
+CONFIG_BPF_SYSCALL=y
+CONFIG_CGROUP_BPF=y
+CONFIG_IPV6=y
-- 
2.45.1

