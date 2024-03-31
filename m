Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B633D12FB39
	for <virtualization@lists.linux.dev>; Sun, 31 Mar 2024 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874705; cv=none; b=HDZlwkl0AEb2GiZddZtc2vIH/CnUTxMUN5AbQ7U+6JYaItZyWWLTaLyewRLLou3NEP6jTlCSD6C7XR840lNLEtYME7uEfDwCjtZODywxX+SfWQuYpx02dSAOjR6LP0yVG5VfNGVY27Np6FUHVxgKcDH1EkFfTERr26OckHsizk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874705; c=relaxed/simple;
	bh=RVE008LGGmmk5WXgZGxtm6p/ays+12n/AyoNVnX9umo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZzWZV/vv8uUAvFTVCKeL/uYCOttlbuFbB8Ahivi9Q7653Ks3SoC8C3M5aixGqoq/W0BCMVpHpqK9DsxB2rl/RG8i2A5UwBmvyTNUYRoQWjBHOPDvbT8XmOOiMKDDE/4FjIupLbj3Dh5lBDuuCeUgBnNliFGft4tM6e9SwN2bjZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CbO6GJ5u; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CbO6GJ5u"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3416a975840so2611926f8f.0
        for <virtualization@lists.linux.dev>; Sun, 31 Mar 2024 01:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874700; x=1712479500; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vBka3ABZcniwH/u8QWX2xHT7esEXtapMcD7AcTvpic=;
        b=CbO6GJ5u+b1+23JrBbUY1CiTBuhr3Tt5CG8qI+gyO/T6U0pQuyu/j0aA6w4gVAaERa
         uY4KdDGbya1iarNt6xSX63gUUM/kYBVdiXY5zRemPX7uwvvnRaFmM/IOQElfZ4ugLkZz
         UF7UO75wrd/sITb3/W1DkYPks3imxky0xIf2Xxt9usdKyClSp5HiwdDh++edo9qGi8Qd
         vSuOtgfM24OchhlyCbr/4QOc58/NZ2MGNqlnz81dXyb69p0k+MOGvfGk9sE+pxP8aJfE
         B9RZ4FnXQkt5QXVa/s3xMiWrh3ta85qhUCrtKBz+1CC5NYWcJ0mMVNH/VUcjnxg0J+UL
         nZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874700; x=1712479500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vBka3ABZcniwH/u8QWX2xHT7esEXtapMcD7AcTvpic=;
        b=lqMAaU8/2Jecu+IdMjwnXYNWcDruGLrv/Gg0dnTVKS3LW/RK8IPItD9kT0zN/LBzJ7
         sHbntdXnG66g82z1cKtl9oPIRoYuNa8YXlqjplzFGOwHs1hcDiTRYD9uft5SbPUYx6it
         893QFbli6EIAc3TfjA8cZSCv5F4hpgC0GK0agHVwNMKdw5VB2EnuMWby1zFWHWZWyLA+
         L35tSoCqWC/bRHbIfmLWSXBVh02vgKXgYRZ9FySUgXvhw5eQ/t2W1iMmAnvX4Dfy/MDU
         02NXDqsvpHTbU3DqAHLeLaqJOX8yPXcibKSdCzQiQeFftKKiKNLrVhBuObzKPxRpbZHc
         x1yA==
X-Gm-Message-State: AOJu0YxCk4Dpl3gYd3GfUeWl/s6wKYZvnGy1Kl5cf9hIFFZKK1ce0xkV
	Er2Kg6jb8h8zLHE/nwSvKYvInaRNfL6K0Ry5UuzXNS6rRkj/mCpkTWxPdNeDNhI=
X-Google-Smtp-Source: AGHT+IGHu2FLUbvwsuKAjPidSr353dvDp7GuCk2BJH42ai3YiGwqE+E/4IAqydG6le1xjhRiCRJmlw==
X-Received: by 2002:a5d:4246:0:b0:341:bf35:5088 with SMTP id s6-20020a5d4246000000b00341bf355088mr3888713wrr.52.1711874700246;
        Sun, 31 Mar 2024 01:45:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:44:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:43:54 +0200
Subject: [PATCH v2 07/25] bluetooth: virtio: drop owner assignment
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-7-98f04bfaf46a@linaro.org>
References: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
In-Reply-To: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, 
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Jens Axboe <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Gonglei <arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Alexander Graf <graf@amazon.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, 
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev, 
 kvm@vger.kernel.org, linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=797;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=RVE008LGGmmk5WXgZGxtm6p/ays+12n/AyoNVnX9umo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJWgux1UKxOir90nq5+7EUMXVeKU7DwLrCzk
 Bafs1coq9uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiVgAKCRDBN2bmhouD
 15K8EACUu9gS/2wREcsuKbu+4sGKqkB6ND2x9NAo7i3nS2L/g7FIP1Gc2f2b1l8GlP/qgmcBRbN
 TJjhPbgppsLyX5MMxYZertsyVFSDRJBiGa3jDd8mSsTsoYqXIt2UoVs3ZeO2Jki+GcyhW32Pgld
 m26G72p2dXSd3XuTzpVDgu3bOz34rS+9oLDdRYLTX7+To0LTokkqgw/e/+xMhymvX829JWhBVnH
 /dt3ZSSONvJohlbPbFwK76FJmeWWcXhZtc9Gh6gM5CWsPWu5dH18kKxnzKLVvCLsy3mmuaAiZFG
 6RwnaAnltaplfrZ1DDLtUO6vPioQnE1Fm30MZy3AU9bmL9q6+Dz8OllTFWiQNp5V6TyvPbjwNG4
 5PB7mKgdP89TmkRPG1O/jdnh/ZuvWyId6soz08SjKDH11xgp2rB4OUqCXiBBxPVG3uSkB8tCopY
 KsZe6kFLp18/n+fx5upudyi72boGRNmz29kOvLkwQv3WMSb3Yd5t7r1stSxwLbCzkFW6jRc2x+e
 DWXW3ZLyHFjkYGy2XwPdkGs/ERm+7prUHx/AKf5MOHewCtJKunxib85KPyF1E9qXwxjhL95S5eK
 z+nGbNkOAyQC1HwpKNQz+jh76cI3BSefUT0gDs+XTiN/JnmB1sg06tEJ98+Ed1Gym7uUR9QUMXw
 52ZuE329cJlElMQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/bluetooth/virtio_bt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 2ac70b560c46..463b49ca2492 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -417,7 +417,6 @@ static const unsigned int virtbt_features[] = {
 
 static struct virtio_driver virtbt_driver = {
 	.driver.name         = KBUILD_MODNAME,
-	.driver.owner        = THIS_MODULE,
 	.feature_table       = virtbt_features,
 	.feature_table_size  = ARRAY_SIZE(virtbt_features),
 	.id_table            = virtbt_table,

-- 
2.34.1

