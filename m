Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378614659D
	for <virtualization@lists.linux.dev>; Sun, 31 Mar 2024 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874769; cv=none; b=GNSK/AsSGlpk0UWXiE3L+/1NOMc4Rf+K41MH3jtzOvu8IsIilbxCas2c5fCmIv3GBmMrvy0B8RRwR2+0GfD6IAz58fTEfwKzG67dKEtS3nblCvZsH9p2wiVeZZT1nXOe9H838hZ3ZW+9/l3rSCpnvmVprGzCqPd0Nd/DH6910PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874769; c=relaxed/simple;
	bh=djiFy5u3KBh7sxz0UqH9tQzKO6FqFPG/J3nA2oWVUvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gz5esVDc0FQ1JqYzEQaQlSdvS8ag82NidTntrgDKm4d+Nm+4Uw/8lAV4jWz8yMa7jpZqgN5U2ilez/LDCRrHCKcDyx0R0kmOnh8wCqvwj6QNykADEQXZl6/RH47MSsY1bmNjp0/xPGIuhUvWMs5J4ksSRVT2mkR0+K9YSfBWozQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nOi2R0jB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nOi2R0jB"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso1561306f8f.0
        for <virtualization@lists.linux.dev>; Sun, 31 Mar 2024 01:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874765; x=1712479565; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynnKTjrcpie+nYJ7zJCc1O/bqKJjh6+n6bK0J+8BU9g=;
        b=nOi2R0jBAW8qr5A0xqar1AIdrqsSFC1ExukeDz80nm8dXY6gguaJUolA3VZzXYGB5L
         779qKnMFNxoMo/Jz0ffFMoT3n/WD7X9Sj4HDtPcbxxo+7Y8ecvL3fuF4oPWPifHjpG04
         CCKRFsXHRJKDxjBo4xi83igolDhxE20OmKNC4Bi7+VhKGBIIOzQ/j9kzEyWwvO8V1pDl
         f8+6Mhz+QIpQ2xd3a4nHXYhMOuj5IahDukaEn97/7uojbBD4/SsjJwloylUSW8AWVjLe
         AquuaRUOiELlG7tsRU0h1JQKzbZgJz241dRVBzBWDlSY9BBDmJNbj9aKpumdG0JoSfT4
         zFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874765; x=1712479565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynnKTjrcpie+nYJ7zJCc1O/bqKJjh6+n6bK0J+8BU9g=;
        b=WrINXBHFF6ncxoKbGQjIZqPL3dVuCMNdgigwKPif3hxu+VkW0WIIziqqT/MD3ylsdr
         7zbTIJf7R9BxyVY2qsp6adn+j5p9dYaLirtLCzLsytaQ4QPwBFVeJLvFjjoC/DgYlJuy
         MnPmFBWSQR3KsLqmQV/42Gi1ioZzOku+Z84HUloG68cSfXZOOaXJx5dPCwjKiK8hAfuY
         ny6lGkwwtjaSnhiHWtFWDqp9VQNCd3IVvfvH9JgcllRtLV3p5Su5mtrdn/eW6/bFAmn7
         9OV9psAgsGuCCS3oaIrk5OVyiCfwy+2KorwdnyyXAdYeeGOxy0uraGf163Oe8P9F2+TR
         /jRg==
X-Gm-Message-State: AOJu0YxffuyXqGUra1mLYRTbKXD5o5e5EBzM9/PBKP7ywkglVQcOkr9P
	Go2usF4Bk8Yo0FZvUlPFBFcYnHKU0RVQg9FjDtJya305o0JKLhSIYUcQtX+CzmU=
X-Google-Smtp-Source: AGHT+IE9HCbYqXr10WjNVCL6+bCwlLWbV/NMZIwtw1PAsCjjTRvMs1pGxGA/oXfJxTVFO3HnB1qqrw==
X-Received: by 2002:a05:6000:18a1:b0:341:e1b1:a5b5 with SMTP id b1-20020a05600018a100b00341e1b1a5b5mr6504132wri.13.1711874764733;
        Sun, 31 Mar 2024 01:46:04 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:46:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:44:08 +0200
Subject: [PATCH v2 21/25] nvdimm: virtio_pmem: drop owner assignment
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-21-98f04bfaf46a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=811;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=djiFy5u3KBh7sxz0UqH9tQzKO6FqFPG/J3nA2oWVUvM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJiCUA1oHxtanMlVDa3B0IS2vFZjLtjegvnB
 r2LktHu/TmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiYgAKCRDBN2bmhouD
 1+fCD/9rVUL5S9fAYP2Cn2joknxd9GcyxZ1ZcSysBEormmSyzUriEDIqirrsKi680bEbDylBOX9
 x2MmTBvkQvu/rIQaoQX/tKOG7I91b1Vbkk+M/NAsbbgnagkOSShnc3shFsc3rXApauvlxnO1qvb
 z8DY07D/WFV3/ayX9Pc0+PnpUDKtjympuX6u7ZHB4k6EwKFN2I+M+HiqBoPn3/ikV3qi8Pl5ABn
 dVmokdreeUGTxM3sQFHK02cmnhLTPk71xIHNooat+Oh5ZT6rcdAvm0AG4WFUisCpcckAFMO+cX6
 PQoSym3RhOSPNBuSGE69s0aBavxd4IuhZiI4o/Jw+0VdzvVble2tpHu+anv+0Glt6Ng5f1OPaYi
 CXmDxjyV03jkc2tlsgpIdfrBwo4k9U+5eOoACVeHWRlxa6eDLI8ViIyEzujQpnD8ueNX2Q8XFgl
 S2ARJ2DUcykXT3jv1xRLTcRYkjqbSrBQ4N13gZPLY2T8UnZrpAwIylFubiw1Ahd+W3KV1JUzxwL
 vUBVwDlontFEzLJVXp78UAxmuAChFTir9BJsAENfp8Sn6B+wzUxU1X5IwJrmDBoO/JvPuQAW3N1
 eQRSKA5Wuv0EaRhEEMBePFtrM57giBzRXdSf97ZWQDn40PWYCC+66dK7kdUzInryIhsEEMdcmlc
 cYX7/PO50bomQrA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Acked-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Depends on the first patch.
---
 drivers/nvdimm/virtio_pmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index 4ceced5cefcf..c9b97aeabf85 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -151,7 +151,6 @@ static struct virtio_driver virtio_pmem_driver = {
 	.feature_table		= features,
 	.feature_table_size	= ARRAY_SIZE(features),
 	.driver.name		= KBUILD_MODNAME,
-	.driver.owner		= THIS_MODULE,
 	.id_table		= id_table,
 	.validate		= virtio_pmem_validate,
 	.probe			= virtio_pmem_probe,

-- 
2.34.1

