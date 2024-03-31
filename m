Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87115144D29
	for <virtualization@lists.linux.dev>; Sun, 31 Mar 2024 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874764; cv=none; b=Z0ucpg02j9oVIbgpWeWonRLbt0t5zxwl41R3evsZ+MxAWoJ0zmWOq5zZVl8KlKn5I/nuR48lNCE8bFpVGrsfGHvN8fQ+1ApIkB/L1SvGzGli4vuO2cll0LVlrxJRm0WW4homsNjIqMAaEQUTkYFwdNWycefUlshTa/8sJ3rblW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874764; c=relaxed/simple;
	bh=NiQjVjMZFYqKExZsObNgm/DCszic+bAl+n8BqmPOZX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bSFjjXr2+sPQu6r5OIeJ1wTLZrGqe4yxMDinNhp17VdDX6odhJRMVSclEq1pWVAlJMCcm10BO2pILlFCs6PrBddb+VG07q9uVXYNI2ShT1L8CRmPS8bXKSZ+YaGo/hgo0mnhCuwal97nFOwCp/QPuDgGSUa7kgA5Rs9pxGZspK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QpKurnzz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpKurnzz"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-341cf28e013so2263368f8f.3
        for <virtualization@lists.linux.dev>; Sun, 31 Mar 2024 01:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874760; x=1712479560; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAdnlTchQh8FlREm+ioloxT9FS6Bj5xt9o2Hrx59/ek=;
        b=QpKurnzzBI+g5L9vMpQn53v0QFmEbfzUj7eYfuUvWtjm7qUoKZ4iCw2Ed7QDqC3sWn
         lzulV0vehAMcGLHidYt7uiJu7f6EG6wQDe4u3E02DMYYjq70XXhekfX9Nmzm31yU2KWz
         0dcm3i3jIqeVTMC/azt02wlWIHOaIg1/dwhFrM91Jv2ZRFTQVUqVHN+20V+4dcvTqty9
         RA9Ebmku5CMDYUHn+lodUE7DMyfzTiH27US7MIFN3RyXsFebU+ThxZo+tx5sz5cxx62N
         mvpW6Ki+sBdQ0er30gPR5uUZSYtUt8CgwNfV9yGrgqtlDpJQ2gp6g61BqRKtHk/fy+cL
         wc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874760; x=1712479560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAdnlTchQh8FlREm+ioloxT9FS6Bj5xt9o2Hrx59/ek=;
        b=cfwWmv/ZevP0GIxOUiNY4ZGoKGLY83G4r717uKWV4Qzxi/2+LNjVMmNJHj0Q1f/GUp
         8slbsowd0iloW/Zb/npnbNNzYQWU3u9FhhYMtQToLV1mKJi2nmdBywbvhm+ZrycuvHB7
         FKQmOpvJ0+yDfd+Y76rUuOwWW222ZJYRbLeiiuvqninfL21Zv5olNXMEr9+AtY8lINdq
         2XbAiHZ/NHVdbPf/9wi8QmCytRH+mz1EUOdXdJ3X85pIOvBoFUU+BDrF39rMzNvnKT9z
         9Evh7FyKxArAmkHMv94nO6NxPhik93RVDRUKWmsh6uopP5XSqh9cu2lFlIiXHmRgLaZR
         vU6g==
X-Gm-Message-State: AOJu0Yx15IIYfZE/z0mmzWwzGa2PipPotpplccuEIgFfhbuUG8twgFKO
	iHIlKm5gE5CDbdPCBEMIYS0aDfKf8spOvlEr9lr6uPJioadQYCYMpdlDUCkqK5s=
X-Google-Smtp-Source: AGHT+IGz2LpPwhQY80sjD7cN8u8zFvxhFrt83Qh2uspjyZZar+MqP10mw3FpKFF2x5Oa/ktMacEZzQ==
X-Received: by 2002:adf:efcf:0:b0:342:2ea8:18fa with SMTP id i15-20020adfefcf000000b003422ea818famr4808562wrp.15.1711874759984;
        Sun, 31 Mar 2024 01:45:59 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:45:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:44:07 +0200
Subject: [PATCH v2 20/25] wifi: mac80211_hwsim: drop owner assignment
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-20-98f04bfaf46a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=807;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=NiQjVjMZFYqKExZsObNgm/DCszic+bAl+n8BqmPOZX4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJhWw5LbpvzVhFws+zmYGQbgqyzkihUAHIKP
 oZSMQPlSqWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiYQAKCRDBN2bmhouD
 139YEACIQuJ27qQd8eW1dGY27mv+DorF909fjdUQk9218e/PqSQf78sWt8Dwka7RhDehlGI5/jY
 KavPWJS8WmZupYTGwpWwO29uzaCgHZ2UkfSQaCt6QC21Sm2ZSIe5YSORBj73pm4F3aV1pqEG7Zf
 uEKF5SdJn8BL3Sq/8djgih8czEuNasmRrepanUNhtq4BZRUfa9b3d2hIu8czIoxIJ06K8gRv37w
 AsYE4wIp4r8/fbIlRYOdzERJeEbZy971KJWlKSO5MKy6kQgvEcu+ONjd1iR+Fdgfc8CKD9+R7qi
 j0rF0tfjdBKJZQxSDK4OGG7rYqAMfQW1dkb3Wwbs5BfrUc5FsD7sSNfdW4wSQNMO49JRC48Waai
 qcy5cn2TASJYAsl+9siLBtqYDCg8A+zkmblcAz+f8Tg0ZC7adlCFQKf3ab0eBEnC5H1P6JPY3k/
 P+KB2oUo3GGvXUKm0bsUYt4+bB28pkoKTNLzltigIgQGLvc6nx67bmM242YaJrj73rp9q+nHvKI
 69piU8bV2WDZcuDckA55wir1b4ShB3Fxjfw6pOqJxbJCSjvj0a5IvzYr2s2rFI+rEXi3dULTh3W
 8TMJIXX6xAyGSgH1txSm+cdudXTNKT96YWGp98mSXYwNEyRh2EUTl37ZRn/If53EnPmAxYVEX+Z
 M38gpeSfQm/346A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index b55fe320633c..ef38b7cc9fdf 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -6662,7 +6662,6 @@ MODULE_DEVICE_TABLE(virtio, id_table);
 
 static struct virtio_driver virtio_hwsim = {
 	.driver.name = KBUILD_MODNAME,
-	.driver.owner = THIS_MODULE,
 	.id_table = id_table,
 	.probe = hwsim_virtio_probe,
 	.remove = hwsim_virtio_remove,

-- 
2.34.1

