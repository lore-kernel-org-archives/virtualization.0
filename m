Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D044219F424
	for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291821; cv=none; b=UhNEGsyT7ysjRjwukRHEahyct1wQkUw0qeg4wI+EZ8zB147VCqiCggYsWM+FlamjnZzvvoHIJpvj21b3aFcQ1IYl4lZjdnHzsCw+VbzIacEkSc3SyPA7RsxmXR1XScJJHMnAfjBKzm4Cgh9NLQCPJhh/YokYSUWAVPZs5WTc1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291821; c=relaxed/simple;
	bh=V0LTKhHSeqp8axFnG3MXcESZ5lvqeqj7WVpujBwX9cU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rXJ2xg4AOwTzEifsylZLAcLHYxG/O0BYY8z4GtdW9yPSwoxdEA1GrFP9aE2xribHejA3r2bJuHjJJ2g9dWhVZ55seh0VBcbAPpi9Xev1nvC4OiJc8qLOJA65h/kK3XCXytNdpZSZoYzeHFlJd59bBJcqlZjCX0JGlybuwvZueAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=1Pu8Dl/o; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="1Pu8Dl/o"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22438c356c8so92871395ad.1
        for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 02:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742291819; x=1742896619; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DYxrtds9WuAyx/VMy5k9Yihosia715CLjXw9v61XzK8=;
        b=1Pu8Dl/o1hM1jPDD0TQwUkOXGbKnySXkgfk0IB76HRZDdl7nj5Dtwt2wzl0J5+3hUM
         IvB5Qlj3QKXbs2rIhpnYjrgM/C0k0FPX7vI5/hCsYJtmj4XtaPAPCQYhwwaeUHbTZIHh
         OScXhZWrvwktdcoTnYr8jU0B16PMl6CYqOpHchh/dD2vs9nTl2a6PuC+int5MnfBFnj1
         Wl6j3c+oZ15AthcBo2lAWOLiZoNmGAquNV1rSewlC5oraux2rPEwUWOeADhsDzMaCoDj
         1WztER30zW3bZb5U3fnX62Xl+tHQazY5av/0bxDQEUw1SUlRk5eGlINUKGxtCAqoPsz/
         JWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291819; x=1742896619;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYxrtds9WuAyx/VMy5k9Yihosia715CLjXw9v61XzK8=;
        b=F6S8v5EdarNE6M2J7t0GPzCLPEJ2nYPFweioFg/zodrUY3xnPs8+D8znr8evBpUIwJ
         wyWFxThv+amt9w2SmwUVhk/uUnAG4TdM5F0W90iHgwByyWOs3gzml5fHC0Z3rVYmxwBT
         +AGGuC+/nZjw2j4vxyo2/KNzdxSFFEoHChl12i78PfX/6TUsSfg/SZl8mL/wpWkHCyDM
         sfwhN2wxofsYfP63cotocDa2LhS1UsOKkVSIFhgY0sGF74vgqp6Zg2YQGizjyH1jggWX
         XfD591XFwyoxI5ZXfs/IF1TucMBUd0ImAUcAfkHLW31xrKjaQZ2BYAtOb59BkTHN3vXO
         Oi8w==
X-Gm-Message-State: AOJu0YzQlSzFLumynZeJ78jaGiGVwPO/bX/Pg6QZsvmEGvbiJr5svBn7
	GFrrHpRIEvrz6ZzvEYrZtJ1RKAFi3WXwt8fQwJd/I24XKNNts7U/DOdoyFVXnuI=
X-Gm-Gg: ASbGncs7gn7N9LJxqV79T6KiFNfnxkxV4PSqh9UKfGt2JVx3lth1Z/X/8M+HHpi3TRx
	Q1g4SDxIKn1kdFSwOjuORTrQEUnNqk6hbTJ9v2GQPWz3jIqmD2VaxQgfzTus832o1MtdsCUd6Aa
	f0iYvi6WJmYPIJsrDU9nR2OEm3I4eZg+/420zAuG+A71Q8ZyepxVWd763iyvyHtZxqtSiJ/R8IU
	NyZyJVrZORrUHnZaYr3kvkLD60MXhc28pfANh9L3WXrFuk7dZg6oA5Su0T65cAa0lHBmJ0bbmdZ
	s3tCxuwNV/OHMr/FxukmF8Th0lBlmb60345l34gXkviWkO4CuWQ1lkkzbhc=
X-Google-Smtp-Source: AGHT+IHrk0Ye2VW3IkLXWNA3Y7JUi4Z0k3Yg5or8rzVPS9hPOf7HJ1+PfOM0m9d8tJMNA1KQW6fotA==
X-Received: by 2002:a05:6a21:9185:b0:1f5:70af:a32a with SMTP id adf61e73a8af0-1f5c1386049mr24959333637.32.1742291819121;
        Tue, 18 Mar 2025 02:56:59 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af56e9ccb0csm8634097a12.2.2025.03.18.02.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:56:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH net-next 0/4] virtio_net: Fixes and improvements
Date: Tue, 18 Mar 2025 18:56:50 +0900
Message-Id: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGJD2WcC/x3MQQqAIBBA0avErBvIQrOuEi0qp5qNhooI0t2Tl
 g8+v0AgzxRgbgp4ShzY2QrRNnDcm70I2VRD3/WyG4TGxD6yQyXlZNQk9Gh2qPHj6eT8jxawFNF
 SjrC+7wfuSPvWYgAAAA==
X-Change-ID: 20250318-virtio-6559d69187db
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
 Philo Lu <lulie@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

Jason Wang recently proposed an improvement to struct
virtio_net_rss_config:
https://lore.kernel.org/r/CACGkMEud0Ki8p=z299Q7b4qEDONpYDzbVqhHxCNVk_vo-KdP9A@mail.gmail.com

This patch series implements it and also fixes a few minor bugs I found
when writing patches.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (4):
      virtio_net: Split struct virtio_net_rss_config
      virtio_net: Fix endian with virtio_net_ctrl_rss
      virtio_net: Use new RSS config structs
      virtio_net: Allocate rss_hdr with devres

 drivers/net/virtio_net.c        | 119 +++++++++++++++-------------------------
 include/uapi/linux/virtio_net.h |  13 +++++
 2 files changed, 56 insertions(+), 76 deletions(-)
---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250318-virtio-6559d69187db

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

