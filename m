Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADC43D88EC
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781091733; cv=none; b=OONlTy3lvrwzQUbKk4jaAPcHvxQ+cmNanxai/bLpyQ93SnM/veGM8JkTeDdlOGZ+d1HfLP9aDYhyamqD2wUhdf/dxOdUu8CjAa7voDuT5/OYMVgPuTxzX88s5FnfFCUhq5CwQIpy18DcGKC6a2mk5L/6Ei3lmHToy3qVF8kyTgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781091733; c=relaxed/simple;
	bh=jgKmE1kKV3b0d5YkmqgCMwOqD04XBbTPa52jDu60x38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tmh0ZOW//oHHNNAG68WpEV8TYCxhVkO4mZeMtWW9pRR/UhG7CO/zvqp4cbfQVy14iPFZFOsZm9hOYT96d6mizDulBts2E2j8gsDhD4lMP0cvqTzzyJZtK80AWInTwGrWZqR6niTftxFGEzrfyW9gmJAZax+3rhrwrl1WUlX1rvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXMQki93; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXMQki93"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5177ad0cc67so53178751cf.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 04:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781091731; x=1781696531; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6hVbBOpXU3AVgTPjwcETSFcTXwEq2neK+pOPLd5Ot08=;
        b=bXMQki93bgOHWWSI1qIU9XPp2HbPiCS1UW5+RoOBayuLKKQRm89oIYTmQE+LrUPlqU
         jUw/dok0+tfmsazit+otwJ4cClnUPqgRWxmheJ8vyo0VQWM4TlVU+r0Jmwl9kmY+MQOR
         ZzyouVMo5NlgkKQ9DgjuLfBoI4sSowsDl0sNvlchONWWIugzNcyxhv+qjTjYJ3wl7hYd
         HMjqCnJ+1tYwaSOSJP+J+2PwqkBp2DyGPR1te9p4WdHNjFjkmKYmp0YqfsZltvdfoiWY
         dhsu2diXsAsqI2leVmy+AVhGhuWTPXXJmwfEWANHMiyRGcQ9uu1VPotMmCxovkbCPGbE
         tvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781091731; x=1781696531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hVbBOpXU3AVgTPjwcETSFcTXwEq2neK+pOPLd5Ot08=;
        b=XVyhqWrS8nptkbHhe7ZR/7jXSL5C2aG+vLcBBCNxHQwVveKjUiU0ccz/KJakBJ56X2
         Ko4MS9H6aEkyKY7R/DSgQI/4LIZ1VPjkxk1eHvM9mGw9WLyhJF5Tj63Vkn9euydOxes+
         uks/7wzaTYxUUfdeU2IiXLdpaFbMTMjO7gQ/X+Na9rfd+H6Nq/G9/If1dfcUdJgj+Fqc
         2sFnPslcOdul4nbEfmYB4qVcod0yEOvE4AwHa7QQdsTSnmP0iAyJqR88rgGaUCVhCI3c
         ZGYbbpvRoOAwzSVY6dZqbaBFozI/xMHO/BMCbt5JTgPwmU/a1NOhI35c4dX27ZV1z4FL
         3/DQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bxlh8zIk1APQCSF+d+qwK6sddEAcz9D4KrfhR1Fk+eeatolFj9Xp3PNpbrjQS73kZmbOAzS/+hhNt/800/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbK577H/D7qCLiR1w47b/MDbQ7GU49Jnl1m8YDXA71N7RC8EPF
	FRx6bRZS00LvLPc87RU6iruXpe3HhxxBIYTl+19p5k9api/tvdsmnTMj
X-Gm-Gg: Acq92OHpa1rYzQEZ/PAutxP+9ABhWDnR8aG8O0ElHcPGe5/3TH5yHOg51SMbo5FmzdY
	oCurqTemGY0WTFaQDRyj3dzWvGDBu3EMWt7/06vvCn85umt9xs5nNp+4JvkulWrOOgw5KQCez/2
	p6UIB+l0qVN0/I9BvSBHc7jSIckYDOp7gUqja2VBmuGFBShHpFjeWSIT8ATTBjM+jiM4D+QIIIe
	aBxM/JcfM663s+9tCDVFJwTtTxxe+lT7e2lDJMFkoFE0T+6XLLrrBV7Pac+otj7EUAjphM6ilHS
	CMeyYkPLXDZI4sdJNkWdX44LuM7E4lt9mjdHnEMK+bI4BDWlkK3WZpWGseguapqUV5g8gD9nGmS
	rxqTBKdY1SumZJP1qETTRC5DgfHAuMs+/LhuACF5vIH2eu8k1rW3bE2CW1uboJd4AyJ3EUfQWOC
	/7v0twf4L45QSa0qFF1t0I9aq1UpGm+37SqQmDSPqS3M3HXaDosXbtT0oNEauc24NlXpsfBqiHG
	eFhN+xBSp3CNgLAtrDfFsszYIqrVyw=
X-Received: by 2002:a05:622a:8d04:b0:517:a02f:171e with SMTP id d75a77b69052e-517a02f1fb5mr305363591cf.30.1781091730803;
        Wed, 10 Jun 2026 04:42:10 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c07e91sm216095931cf.4.2026.06.10.04.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:42:09 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] 9p/trans_virtio: bound mount_tag show copy to one page
Date: Wed, 10 Jun 2026 07:42:06 -0400
Message-ID: <20260610114206.3749904-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

p9_mount_tag_show() copies strlen(chan->tag) + 1 bytes into the
single-page buffer the sysfs core provides, with no upper bound. The
mount tag length comes from virtio_9p_config.tag_len, a 16-bit field read
from the device at probe in p9_virtio_probe() with no cap. Under the
confidential-computing threat model, where the guest does not trust the
host, a malicious or compromised host can present a 65535-byte tag with
no embedded NUL. A read of the world-readable /sys/.../mount_tag
attribute (udev reads it at probe) then copies ~64 KiB into the 4 KiB
sysfs page, a slab-out-of-bounds write of host-controlled content.

Bound the copy to the page size in the show handler.

Fixes: 179a5bc4b8cb ("net/9p: use memcpy() instead of snprintf() in p9_mount_tag_show()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/9p/trans_virtio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 4cdab7094b273..b62aa7b309f1c 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -573,7 +573,11 @@ static ssize_t p9_mount_tag_show(struct device *dev,
 	chan = vdev->priv;
 	tag_len = strlen(chan->tag);
 
-	memcpy(buf, chan->tag, tag_len + 1);
+	if (tag_len > PAGE_SIZE - 2)
+		tag_len = PAGE_SIZE - 2;
+
+	memcpy(buf, chan->tag, tag_len);
+	buf[tag_len] = '\0';
 
 	return tag_len + 1;
 }
-- 
2.53.0

