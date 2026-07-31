Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A583E5A19
	for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494102; cv=none; b=fTSlkXTYNrpok4ijga0kX917TM8Ge1mjB3X/VPelsa661VhA5qaUanmekUSvV8yrY5aTXZUTIjRq8oLqdOQKalLOFEMogfaNmbY+l7wnw1FvOo/zxsUK88166OBiEf9AHJQza3YBNiau9eWrg/lJETGi+fD3RNwPwgWnVTIPfw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494102; c=relaxed/simple;
	bh=U469aFp4Lp1fRTMeW5nd1UcvqPVbOxTPZGKcaDLzNjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DYfBStgbkf+N3D6Oi0iL7Q1t1kBvBOw91eZgARe3pIhySHA+sjn2UXGqbr3nWX9LfvpJGuH74tk/47lxxwwSq4EMO4kbIc2SRl8jcAnQC0mGTZTOvNi16MZWlCg8aKsJp0B5ra9D/UHMIV1YMxPVNOmAjta0M5NlDQ1aoJB3YQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/5rjpXi; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/5rjpXi"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso445373a12.0
        for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 03:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785494063; x=1786098863; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sbNYQDbxVpxt5RpgjMtZTIhW1qly1fVv3fTNwcQpnVY=;
        b=C/5rjpXiSgkfBx2OkZpgK2Rg6XTpb1S4vI/3favBnTSGrgYIWmaF8+oUNsROICHuzv
         iQvwCevBpf5OcCY8gdr748tPBe50vucwcIzofq/coRQhDg7dZ+tDMd0SEE86J526Oo2O
         sNwdNTnGF7cZi3JzT6l4q1Trru8KIw/d7lWccv7rx/gscrLld+0viOAMi7M1mm6vxb/g
         W+hAJPRqyJYSKFcaYQpglnGqlOkXrUJGKvivlAlprhTi13yV7Y11cqPyoi/WTFTuOSq5
         Sr8mXcZ7goiU/XaHBVYWJz7DRLKtim2cQ9z0u4hWP05eHdwZVsfy4daaJyh4fIge/tfE
         mJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494063; x=1786098863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sbNYQDbxVpxt5RpgjMtZTIhW1qly1fVv3fTNwcQpnVY=;
        b=VXfaX10jbouKJEfa4cYpbIunvj5VjKUsAjmSuEZ93ZxQlSQRaQe/zx1QQUWQnjiyt7
         CGOc6DZVPMO2ys0+MdgTeSr0scy/NcludbCwuQqX+E/MY+ffKKx62tZ3DKJC9wKUfcA0
         f6HYURhRjlVoTrfF1bHhkkX31ux082/cLoRsxVgP1TekylXWi+2nSQRgZUqCLLZ5egdC
         ELKw17qHt4gDLhAGo2asXQXfTf0Z4pRAJ4pHyawwm49bQ0c4/MGCq/wv3GHwmO/d8BX9
         IWwJhk1/oRq3LhYALAyiPcsiuq6yIn5IU7fFStcjmabPDo4dwwu5XYgpQYvTxoxCjmQB
         yS+Q==
X-Forwarded-Encrypted: i=1; AHgh+RpJvSoFyM88VDj8ERqpWN4az05PUbQwoOzz8cKHIWPQdkBT7He5q0tzgiT+CkpA4Rga+xuaO67KN859/BEZtg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzchRBaO2EnE9cXgqWtJ+45smzxtTq1Vs2Ht2XIczR+vSmCjf84
	Nx0xB+tI7DZSowoj4oMnsaYT8EPiIiaPPM3gWCaNYmwcNNP62Zb3duJn
X-Gm-Gg: AR+sD12crOm06SDMFOHObXGtXULiQjn7xoFif4RgtxynQM5EwpVTNpinETZgeI0pxv5
	uOjq7wdZFZB2RNziBHhVK6CDpkrRiyoZZAoHt+flQXj3U58bVdTKxuoFYEVmEtrunLRxljVH0t+
	d5XxMZrWHq4d2D3Ay5mOE90+iIVl/hVRJexXWJRDqoEFoMg82LSYcpEH2SF9z/8Im2o8pa4Yc0v
	2NyptM1HjpxkvPuKfj3AYpz5urGD0A+PZ76awWh9b0+hZBCba5AgHmYyI9WpA8VOHJlsocMiKx2
	3/dGG81EiJ9wpxznsoManFxcd1QoY49mEGpyC822Im6ZgjM3h3KpMs3H3HDADVy6Nrx1QWaOM26
	vBWrEijUYFz5WPMFw62fVOmc8WWMqCThlpeStJCpAEUMOHuRe+wAL0H+MtlIF0nLUwgOzIaH5Sj
	m2AGo4efUCYO8sntrhL0/LYp+uxSOlzPGtjXf7s2boc5daNbHASqzpbB/HoySwLzFgZ/ThzPY1U
	A==
X-Received: by 2002:a05:6a21:1fc3:b0:3bf:a543:e7f5 with SMTP id adf61e73a8af0-3c91b05e368mr1197360637.3.1785494062695;
        Fri, 31 Jul 2026 03:34:22 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e0700e8sm4510601eec.24.2026.07.31.03.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:34:22 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: stefanha@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] vhost/vsock: fix device IOTLB feature lifecycle
Date: Fri, 31 Jul 2026 18:34:12 +0800
Message-Id: <20260731103414.1746316-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730104857-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested, split the changes into two patches.

Patch 1 detaches and frees the device IOTLB when ACCESS_PLATFORM is
cleared. The device and virtqueue IOTLB pointers, metadata caches, and
acked features are updated while all virtqueue mutexes are held. It also
drops old IOTLB miss messages and wakes readers.

Patch 2 keeps the current IOTLB when ACCESS_PLATFORM remains enabled,
so a runtime logging update does not discard valid translations.

Changes since v1:
- discard the existing IOTLB instead of returning -EBUSY
- serialize the switch against all virtqueues
- clear old IOTLB messages and wake readers
- move the existing-IOTLB preservation change to a separate patch

Jia Jia (2):
  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
  vhost/vsock: keep IOTLB across feature updates

 drivers/vhost/vsock.c | 46 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

-- 
2.34.1
