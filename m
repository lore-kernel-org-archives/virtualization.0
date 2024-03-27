Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8091914A4DB
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543485; cv=none; b=a/Xq+4Wk5nP+ZBIWnK0gwgQ8ojPw6LBkciLNgJIlhk6MSnUiLkgRqPCvpnXdsJ76o1pieHD1ioZ//c6OK55fnIykGQrGkMXPO4s4agIZOt5cYJvOoNbLCidC4uHELYepk6OPHigupoBCzMupID4DKDE9JqWjS/BlgNm7dLmFJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543485; c=relaxed/simple;
	bh=+TTEvPeSyDKzVSSZ0ChnkaU38LId0eko0vuS5jdKWCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FdpWdpC0DBNw+vPfzPt5k7hhDAU/74ZWc60511s5A4rnQl+okROiwjU/qNzVGWAiF1pBhlOzTXC0etZ9PAu2P7oYp9nLuk02xfhT1mVIlXHmRxkcne4E+mEWQ2hwkWlLPETh9pC+kFf4NNB982IRg9UYNfKFVCSxpXzU/Uy9hGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XCh7ln5Y; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCh7ln5Y"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46f0da1b4fso854229166b.2
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543481; x=1712148281; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLTRp2vTdiF6En9+dHZ3QcMOJs6Q2EWbLSRJcvapXSg=;
        b=XCh7ln5YgYbvvdlByqpz/RpgeokydFyYIjCWzDoTqXTclkemxSSk4dRLOyDZ9vg8zE
         PJRRn9pmf/GJdwSWbLJC7VA4DgCKh4lFErDon4eOuR/S+hWUtRoLWufLNeUfI6oj98EX
         iCywyrN+vESeGxYAqv3C3FCHt4n6UWFmyftCLxFVBzq79tu7xEm7fYGnYlFWYx41QQ/e
         CBMRBwH5gKv1yp3bbPeOJDsYKmsnMB19rKRZPeDhxAAplbfjsddX9VpRaDTi9alGTybq
         e37HhpEQ07LIKPRWMb8zolwPAx0+mtpkRF9sQ53bmrJyrsyslhJZTqBxdPt3gLxaldr4
         yAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543481; x=1712148281;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLTRp2vTdiF6En9+dHZ3QcMOJs6Q2EWbLSRJcvapXSg=;
        b=pxsn6XDdvi1OCmbEYBpzSCNv1vcfnNzbocIS/YPDvQJJWJLfPCGmFxI0hdo7mjittx
         8TNTv3lYiyQvl+ZpegU2nxFAyFLhwXLMbNsfbOj7gGtBuX3WuV6kd6wPmamK5bjnteTJ
         ACWraOhTX4orJeRwu0wDpDZhfpuumRSwg/MlFslsimO58Bw5wdeEYDYx3ECdlU3G9YjO
         lrB5htcQerkTe+tUEy4ZWw628rzHd6HIO/AuJ+8tDJHhIg2y9RfP2fzdoS0pqoXtVl+J
         zRAtmnMjgAVxOqIQ9Dmlz5Blk6XvGnk+NNvik1cBkatKCyXApjx7IoID62oTzgPYqGGO
         xQow==
X-Gm-Message-State: AOJu0YzDxVgRu9JJw4PZiz6i27hAxTTTIjtQH6xGXd5O5i1dkw2k2oTm
	x3f8gYvZLYKiZefJDZrYBlCG1IK9tu7vyI/tNMMeZDpoq5KqDrgccapjFI4Nmy8=
X-Google-Smtp-Source: AGHT+IHhazMmScpDCVE5i2KB2spuKKBHY96umDzN4+tbnuRVjM0nNvNgt07FxjvGx72WnVTtepaPNQ==
X-Received: by 2002:a17:906:c7c4:b0:a47:4ae0:3bb9 with SMTP id dc4-20020a170906c7c400b00a474ae03bb9mr1746143ejb.23.1711543480699;
        Wed, 27 Mar 2024 05:44:40 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:44:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 13:41:01 +0100
Subject: [PATCH 08/22] firmware: arm_scmi: virtio: drop owner assignment
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-virtio-v1-8-0feffab77d99@linaro.org>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
In-Reply-To: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Richard Weinberger <richard@nod.at>, 
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
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=779;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+TTEvPeSyDKzVSSZ0ChnkaU38LId0eko0vuS5jdKWCQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPgrxhxsNBNmJJQCHKExyWHnP8ODMwEsvhWt
 n/mycDlzamJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT4AAKCRDBN2bmhouD
 10y3D/4z3M+4KkLsY4QC3Xn4tvrxIjQ5Wb5DPTrn24JMZBhJ0G36SkzajGkhIsJvlZAWAN5cjth
 BGRcFpee63p66hs/5nlr7xvsuuUaFToUJGB1MEtOMPJVcGgxdwT+QY608PsisH3k7Q5LfND+vtd
 a00SB8S8bdFeo/J6QR+Lo4WVzn4MmQ6bQUUO0x+w6j9u2ApDWUpbn4lQFBXyeB6M9QvhtpKKT18
 WIlAR+9+r+YSy1Jv1Alf8VtzMU5ZrE2C4/22VDZfP/KjTOokwZprIl+pdQS2AfNe/Ov/Um8lFzP
 LAcx4A+9rIPngAmQgBppsvGcueE06F1zjch2eVeKOCJfzpMUIa8YMWxzrmDoz9DhFTK2fLHILan
 PRiM3f7a9Tz1k0IHaxCdiTlw89mA9VaCF9BFGTcX5VDzbukPSs/J7S6jmkkXYum2exhtLNOZ4X4
 gCG9UW75vXSFzlKKDrxGjGn+4JQxdKpNyd1/8uEaDXO23Fl8L5Ivv7rB+UEoBnPrG26oOMmLi9h
 0pFF+gXPq1C693H4Fh6zYpvN8MTP+GmO3O+kgxgNgIQXapBUXSVJXHcUY8in0h+Y3Zw8XhDa7fY
 thDmSLGfYHMHtGA5AdIZ4s0FpTgXieMccsEo2WE/DQoaAEKsnyro00wnY0zbQWRvD26KY1iP+dv
 LPx5k0S9Vk6nZYA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/firmware/arm_scmi/virtio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index d68c01cb7aa0..4892058445ce 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -908,7 +908,6 @@ static const struct virtio_device_id id_table[] = {
 
 static struct virtio_driver virtio_scmi_driver = {
 	.driver.name = "scmi-virtio",
-	.driver.owner = THIS_MODULE,
 	.feature_table = features,
 	.feature_table_size = ARRAY_SIZE(features),
 	.id_table = id_table,

-- 
2.34.1

