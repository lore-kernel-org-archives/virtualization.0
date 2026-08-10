Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9606306764
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369262; cv=none; b=QNWUsfUayCYWpO3EK5+mSAap5e6NwMxyKbt2uLg/CElDpCSZ/bmAfBv3foXpdxZAbAOjjm9fjX1Bw8ZD2j8D6FdTpf9iQedfxQ9Ki5UuYumCkf2Gc/z2m2N3qcCcGyS3BxvWLw8/LEN0NIX5SixK2QdXTI8nEAg4u80a2QwnClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369262; c=relaxed/simple;
	bh=AUbwQjIMvFKx3j6iyCHUmQeCfVu5WpUz9Qg7tHjkwWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CKFyqAgM5d9uv4VHRk016G0X4wjYagXMX5CzXJ7A520wUy8Ih1wgS3m6HlLeFWIdpmSgLxvHhubjeco+BK2Xq7RSw0o2rFIeUcImLj1rw64BfZK+dI187mFPopVu8+by6RR5OyP1RJYOm1yQtJRHGrLd7K0YB8N5g26p3c3upIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwehvW7X; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwehvW7X"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84830c774a0so1795780b3a.1
        for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786369259; x=1786974059; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rN0NY1JfJxx/3rIRMWpYI9WN4m1+geIAl9racAyY7U0=;
        b=FwehvW7XBy6vHAsgZOO3lA9ii4V4g0LHp0OFZDdrKagWZkhsRc3W6SD5Q9SKUuwmTB
         vdq4cPcjOhablJFy+TWVgvi2CmTaxqhZDoE61Dqt6wQipIN+zrS3bplQj2z0KjyqMiQa
         VM+CP+umRHuAvaTCYuyvpq30b3tBDwQiH2n4kIUeHvqPsew8yS7cP3BncW4D5u5X7A9h
         6qewHQoozVghGcWWM0DbXPAq0p0C9Rb9A1B8x4DUv2gVnw2Yp7VUOr6tqkxuvkgqk6d6
         7YvsO7Wpa4xMFYIzmUDPnF88VZgvn23SzIeAJgcPD14UwGh2rmJSCpLbxdfabHcVAxQp
         7dVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786369259; x=1786974059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rN0NY1JfJxx/3rIRMWpYI9WN4m1+geIAl9racAyY7U0=;
        b=N37w4HeXCjxzELQkXw7ImTlckWo7wmDg4WkL0IcSIT1xiEiQuShhGDuSWKbijl16oW
         b3a+aDo5qkfrlxBYwpxBo+GTP70z0a3587z6JkxV/+3lZzaZ/T5l2xXO4XRpCt8G/AXm
         gV5qJcnZEaIPM0JNdAn0Xzg4mJ9S28cPGWVJauDNmFhdxlZAAbBkkZUewgEgZs7Y8eRl
         akUyvmbPsiqU9HZcPp520pjjvXjhw7mLk/YFIVq0CuUDe2UZPNVipgU94qnmGQXtw+0p
         b0OdDVqMRD6JZCIK+DdSexRmwJox9zFPnvk841OSSGiLdriVXcPijL3QLWSCLhfWr0EM
         7JXw==
X-Forwarded-Encrypted: i=1; AHgh+Ro7eHEZXuAcw9bcptj2TeLIpc+oxiRckPIxFPa0cqIbKw+vyfpg0zzvx/s5bOuCoBXea1Gp78cO0+dAqBskVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YytTBAtLedaDtL5XrjCFaO1LR+DoTHvvDU8L/m94PIdjB+pvkgJ
	yAIgtRyCcSz/o+bNiiMeO/aM2fNI1d6s2RzBFGoFWG1fm4ahAZ8mQE/lg40Jjw==
X-Gm-Gg: AR+sD10JBxuZaEev/ULwZh6A/JshWI4nIdZU7cIuiP33lY3Oon0lEuhFyogOFdBUNfY
	/2LImRq3I/x6AoIM8OGNOzArRII5WEXKH3zkaespSxhgqkzjWY7tWp5/P7PacI2I2Y/0pymYNwV
	CftQaxoqKyV++WZfc+2npem94zfC4rWOVgA2Heu6VwYdgo00S0UuuFY0JiU1Dqk5yXR8pzWuDVI
	dn1vEZQq1ql1yivCxPer4g8rtm72/xXv0Conx7WrcKLtttAUyjyY47kmMyoPnrtH87kXDb8fnjU
	nwu4ZDfylrq/rntQq3ZsxZhmhCfd14a5LNa+691TFzpa2+XYgousx+w1lrS0EaEeKGlNfj3KfSN
	GAZ7lxHCSRHn5nFZm6KGF01ICvkm4VsV2sYQvxqyjeYbg/gb3rIQwmGmGRmynjToiem3A32Y916
	fkbrEepQyHZSbWaOlwW/cqHWQ8CD3WLxFRGxnahmukgicSW4MRgM1W41EnmcVkXYOmITuH/gM=
X-Received: by 2002:a05:6a00:982:b0:845:3d82:10fc with SMTP id d2e1a72fcca58-84f6926b235mr20673646b3a.0.1786369258800;
        Mon, 10 Aug 2026 06:40:58 -0700 (PDT)
Received: from gmail.com ([123.118.75.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51f166sm4006236b3a.35.2026.08.10.06.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:40:58 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] vhost/vsock: fix device IOTLB feature lifecycle
Date: Mon, 10 Aug 2026 21:40:16 +0800
Message-Id: <20260810134018.143973-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost-vsock leaves the device IOTLB attached when userspace clears
VIRTIO_F_ACCESS_PLATFORM. It also replaces an existing IOTLB with an
empty one whenever a later feature update keeps ACCESS_PLATFORM enabled.

Patch 1 detaches and frees the old IOTLB when ACCESS_PLATFORM is
cleared. Each virtqueue drops its IOTLB pointer and metadata cache while
holding its own mutex. The old IOTLB remains alive until all virtqueues
have dropped their references. Queued IOTLB miss messages are then
cleared and blocked readers are woken.

Patch 2 keeps the current IOTLB when ACCESS_PLATFORM remains enabled,
so a runtime logging update does not discard valid translations.

Changes since v2:
- update each virtqueue under its own mutex instead of locking all
  virtqueues at once, as suggested by Michael S. Tsirkin
- keep the old IOTLB alive until all per-virtqueue references are gone
- clarify that the teardown drops queued IOTLB miss messages

Changes since v1:
- discard the existing IOTLB instead of returning -EBUSY
- split IOTLB teardown and preservation into separate patches
- clear queued IOTLB miss messages and wake blocked readers

Jia Jia (2):
  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
  vhost/vsock: keep IOTLB across feature updates

 drivers/vhost/vsock.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

-- 
2.34.1
