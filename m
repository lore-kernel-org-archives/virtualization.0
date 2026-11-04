Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822200;
	b=ut2UsQHwXKdsitmBe8Mn1Eg9L/go8in8NcyGwx+s/GSR/QNECiQXPbLchDVXw3Nbb2eT
	 TOywYNQP857LN4tU2eEwmNNx09ksR9YwavM6gA68nUkFm0RBJIIJ+s9ZKKhH1uPFsCOUG
	 OnR6vQAclakNxZ6srpXi2QxkyJUCxXbmTgCuH+Mbd8ySOxZKCloWUzAe+5rhBI0VvCood
	 rK1Tl56eGCZ65ClX91ChfvmatjzvsBGHMAQ8+czSmUxDsXnuGDIi2fpJCI98yubpymm8+
	 NQQQeycxagfuxqVSHPx3YL1ZsOPCaIDmQMD7LCwtZ3flvpi3dhhks6CNi/Emuk5XLeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6kpL4kjKXO5+zpcv/2EB9Ui2OiV7DWWpQ4VPKolISpI=;
	b=R9Eh1B2stBbLSWIroLvdiobMvrQAP0YgKn9EikLOW2VHjkWI+4SZfqttoxpWGXfTjV0C
	 b3+FWjCKxaKzQfTsXSiduQQOiD/eWQXmxaE+s5mXKcTKwJhQQ//nQ6rF85JgkV1JU3J1B
	 OaxXmRuKbwWpi5pKYxWGLn4G8JiHGBp10VkgWOIDxeUcBV+gmJa627C12xTN3u8sKEnxm
	 9uT6lVdvx1VkKW4ocZ9WYNUifv10DzmN0Iu2SbCbn3pj/ydNnb2hABtVuurdO2syECLLi
	 c+CH7KA6iMN2vqLYgMBq30umaDm1PubG+caHhpKdbazN4swX06i5WEB4bE8yqjp5Vdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=0l8mgGt6;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0559609D0BA
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 19:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0559609D0BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=0l8mgGt6
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36cad25b8b0so1652221eec.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 11:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1793822199; x=1794426999; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6kpL4kjKXO5+zpcv/2EB9Ui2OiV7DWWpQ4VPKolISpI=;
        b=0l8mgGt61uqqjoB0dIgwPvFinXc/B7acslWRJLxxKJ5TeI4kY2O9VcRklQ+feQfFg8
         /DoiQuBC3C2/UPpwsxYnp7TMkhivkV9mtypCfsTULxdjyjyUWESSZV0dOOkK60O6fvlf
         pp5uoduqOrkkl+ocC25gdkqjq3xK1cH9FOuzlrB4MjwTBhwBMmv28a5uNvNHljS4y2iS
         OrU3wGJhcagb4k3byoyf8wxgJ+psjOFYA9t4GkJG22ihEa1xNyUD1KwQiYOJFWN1WwyR
         7bEbHa4iC292r8plsKOUFxNBX5LeJlz55CDKL9+9dn+rklRdyPKzoj8kzf7QlbQiP1AW
         lVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822199; x=1794426999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6kpL4kjKXO5+zpcv/2EB9Ui2OiV7DWWpQ4VPKolISpI=;
        b=Nge5H5Ip955MLYikPRVFi4ZvH8578t04rOaJoJhZRDJv2cI4EE13HiyzwMtcvuJMbj
         4p4AodREaNlOZ50ktndkOo3LbqxJZhLzD7+gQ8Ukshm85GfpiTN/RJKu/u0ScRDpNiKz
         w80Skc2iAZYMQip03nu3FkIn8REN9F2mrh+3RTwstYgfrjcj+ZK+vGwZslqdgTNxe7+j
         3bBHDKnSW3NDuou3PJWsqmlYDkBh3s4yTYYdHs0IpFpLyGvdjwBe0NHKotXk3d9wtbaU
         dxB5KN5sRvTyxV9Btiev/wTA7jlntC7/vxl2WY0R5CjQrzLaws5gmZutjW6cP974W3d8
         Hjow==
X-Forwarded-Encrypted: i=1; AKwUvBwGVVFLvlzwXrQZVFksUcqGm641zk2vr/7zbMriuPen7I9syL0GNTNBDBvIEF2UR12Dq88/h+xe8FoEif9TVw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+DxrvVlgXDuSxo6isspB9Kb9pnAQ9g0d5lw8yw62ZB0JVMnMqZ
	Ynq9u3LbW1y1WSv1bd5xlL5GwDsY+JChFGNlJ2S2U+Ry/UYkLZr/3aU8sD823noB1Q==
X-Gm-Gg: AYBFou2HbpYG/bwxvuydkLad4u9v/0ptWLJMRrj8r6OOUZBD0bgA6j1SfhsCERoezVi
	3g26O67mpwqe/31dngQSuFjLyHNSdiN6Hw9iRm9uWiE4OR467z87LGvXiv0I5AZzApEW4JBDK1W
	kfWzuF8+IW9YAxQVhd3GuJSW8WQgnkSVFFhrcKzxMP6icIIkiDhrznOz2fxmeY4/g96TlWLF0g3
	7K1iovxSm/WKlOeQ8XFWwa3t0gCtU7vutfJVUp9qY7pgUQgTf3qx0N04BzP/hCcHRYC/Lpn2NRk
	GV3VdLgCmZH+nH40VBYJIM7kAIgphFmBQgsn3QZPc0786E6Ar1bsBgiLl5ZDord9NsZar3H+Xhv
	TaqwMWAE4Ob1llNWRuIxm6sxy5wPtidLAH1rKQTTTEdRIDRbxkLsEeWtdRwxBUjP9RAsLICuuAv
	HjBTs7nevknTjVqQjLywX7DwZ8YYYFmKZaU9pAsttCSJ27LHWtTp398pc3CDD4gdCuCGdMVD3kB
	5SvOngIYWk+JNcN7z+pmccPxoxQAviRFRgW6H85v3Y3WM/v9WQ1hdPQGOHGGwoBGB8BIOxnRoq/
	1ML0c3KHWOSdqM6uxb0rlnGSpFxTtCxYbGXCkQ==
X-Received: by 2002:a05:7300:e9cd:10b0:36a:ac68:c745 with SMTP id 5a478bee46e88-36aac68c84amr10067389eec.25.1793822198657;
        Wed, 04 Nov 2026 11:56:38 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38f53a6sm8941712eec.15.2026.11.04.11.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:56:38 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: "Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] gpio: virtio: compute the line names size in a size_t
Date: Thu,  5 Nov 2026 04:56:32 +0900
Message-ID: <20261104195632.1702765-2-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>
References: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_gpio_get_names() computes the size of the GET_LINE_NAMES response
as sizeof(*res) + gpio_names_size in an int, where gpio_names_size is a
u32 from the config space. A gpio_names_size of 0xffffffff makes the
size 0, devm_kzalloc() returns ZERO_SIZE_PTR, and reading the status
byte of the response through it oopses:

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] SMP KASAN PTI
  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:_virtio_gpio_req+0x2b8/0x550
  Call Trace:
   virtio_gpio_probe+0xc2a/0xfc0
   virtio_dev_probe+0xa7a/0xc50

Compute the size with struct_size() into a size_t.

This patch is assisted by Claude Opus 5.5.

Fixes: 3a29355a22c0 ("gpio: Add virtio-gpio driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
 drivers/gpio/gpio-virtio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 32326d91f33d6..fb7b40eff37dd 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -494,12 +494,13 @@ static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,
 	struct device *dev = &vgpio->vdev->dev;
 	u8 *gpio_names, *str;
 	const char **names;
-	int i, ret, len;
+	size_t len;
+	int i, ret;
 
 	if (!gpio_names_size)
 		return NULL;
 
-	len = sizeof(*res) + gpio_names_size;
+	len = struct_size(res, value, gpio_names_size);
 	res = devm_kzalloc(dev, len, GFP_KERNEL);
 	if (!res)
 		return NULL;
-- 
2.56.0

