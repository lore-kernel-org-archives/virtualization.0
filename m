Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39184430CF3
	for <virtualization@lists.linux.dev>; Mon,  6 Jul 2026 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354939; cv=none; b=cFKy85GiGgWV+rCrkEXEySokUM7zEhA54De60dqneGM+NnmwS873DNyjWKmwRutn48p+8EQHH2WBSeZv1j5Oe0SH8i3VJBpzTa8SACZd6+VuYC0xxSpDcfbjG6gZotJsqV50TMrxsYAT0Iq+ThYlCwwsea0AXtOyAp4A4i8CPzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354939; c=relaxed/simple;
	bh=7xTrGMnL+4cj4eWIO+B0MoJb2WZm7bwu1vitrQyyCsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gNX1Ee3GZ4pbj1vMOl1ZeXMuRQnImcvKqQuxwgrKPLJ6a8gLDhdcFMLccJFa5Ct1k2rmS4O/KXYgoK5XD7NFaKkeiXsGVhpUaB6a7OLuOn+Xp/O/6YDgjmxXESVHE1taHyS++gjkwJughWHNXz5IhrXurKBFykgvYMYggCSf8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=m/lLjgfb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="m/lLjgfb"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47d6c634f45so1241926f8f.3
        for <virtualization@lists.linux.dev>; Mon, 06 Jul 2026 09:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783354935; x=1783959735; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2i9khTuhmtZ03Nc+j6h6Oy/miIUQv5xUcvwKtFwmx0=;
        b=m/lLjgfb3zGmE2JNjgi7t4oKpcDWwX7xm7jCVIKGnIU9ilKe/52+ABLdbN4KY94t4B
         DLqRFcjQUkjT//4RN5+/hprecFPP3KNOQU2/EbNZCxu+Lma4j0RCEbt78gXGnPQhSrWf
         Ha9U4lSAwNlIY8z9mThHyt5DHfxUb8pdzBfrK2tZPvp57XLJ4/lypufR+2T5ZPNB33BT
         11sk1sB/7GGkqUeEoeRtsJ+bTgQGSZwk6E6/YmTJ1YDQ7z8f5OjvE4VNM+RrIN6ht/cL
         XnV4a9Z5V5eNj2JYaJMYNav+q7ifJqnwA+c7kdFyzM3kh1nceXKrpMZwy4OaMJZlkrMo
         bl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783354935; x=1783959735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2i9khTuhmtZ03Nc+j6h6Oy/miIUQv5xUcvwKtFwmx0=;
        b=qkzuCmqIfg0jCWXPOo4FKYWJrohZUG6Bg5FnaNDPwB5RQzqGRE2QwrrhvNRvARhUmv
         sgE9PnOktTITbl5pCHQ8WAScqSY7QltMesly6gYribMO/nkazRV+0V8WKwBco0UFFEff
         9rDHMJvLhmC9ybTZ+vP52yi/yYmpkGJM0JoUoILDTP2BoF9bNkxNyukku2BeKGg1Doy/
         377eXSZSdnbmQtrQr2crh5HhzmkDxWl3thar6HW6Wi+VAP/9zw0o/sm+Xu1DzlhwC29g
         el9chTvnzCPCZCtPDt+k5GhP35ck3IIoGM7JdlpTJK+8slbWYm/Auoa6+mtJImQEJhKM
         E70w==
X-Forwarded-Encrypted: i=1; AHgh+Ro1VwHxZVPvFuufrVjJ4w3Y7D+lzlC/hZYn8pT0IODLdgUFCVFonRsRwMnEvVmD3x4jD4IW/BGVwbbVB4aDIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkExjqk08SN7BvNdaVdLjdT2656g9bwCRsr2njFLtXui+Fra3O
	kqvNtx9ibUpV4QPSNub5DWrQ0Rka/9ZIgLaBPqNB4hZI2Qas26glkKubdo2xyC3t+zk=
X-Gm-Gg: AfdE7cnd6TpL5P29yTmEsYHxnSbG8zyWBYH1YV879N4TO6eE7i4JlytgipYcDhbLHhs
	8gINdh3Q8zUNG4s6a+RE1KY6n8PzcuoP6xwNqWQqCtZRfV4lxar8e3kZoPAplOQp4kJfUM9PoT+
	h1cfcZjUbx+PD0vg3pSt5Kf1DILAQPbndzxEesAuWeLfzatYOM4v4GxBm0Kc7OqhiHLqzjNLknX
	yW2n9n9qK55yJ2paSR5z+MOHv8/uLBCdSkTCJjZhBLbKLvfr9ZZdc7D166QstV5yFRdRpYri0Rr
	uoKHFnSdkfVyy7GaI8CuhR00H6YXDVuuxu0wXqMECX+5J+RiRDIBqWC0LHfMjqF8d0jhpur3p07
	nE7USLYcctFh4A/VRbR8cKhjAPNjZr3XANmXw2PDdS8Jk1lBKb/afWfw63D3KMKF4bshgKdplT+
	j00/9y/u+etRoZP+EABPiG1dX7ubZFGb5QRDfG+l0ag2RTovV1XLTU7DXnsEnBCcpd3ukB08mYJ
	gw=
X-Received: by 2002:a05:600c:584c:b0:493:df11:eab4 with SMTP id 5b1f17b1804b1-493df11ebcdmr10124085e9.8.1783354935506;
        Mon, 06 Jul 2026 09:22:15 -0700 (PDT)
Received: from localhost (p200300f65f47db0404eb41111570ffdc.dip0.t-ipconnect.de. [2003:f6:5f47:db04:4eb:4111:1570:ffdc])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47a9de1d905sm26158027f8f.2.2026.07.06.09.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:22:15 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] virtio-pci: Drop inclusion of <linux/mod_devicetable.h>
Date: Mon,  6 Jul 2026 18:22:08 +0200
Message-ID:  <fc69191474ffd49d50d7e39b13dfe6586f4d3f75.1783354857.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=7xTrGMnL+4cj4eWIO+B0MoJb2WZm7bwu1vitrQyyCsE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqS9YxFLSStod7u0q1rTr2l/Hm6TwV5T2gAvrVc WvraNNiRT+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakvWMQAKCRCPgPtYfRL+ TnYfCACZClIN0F99T6wCsnEWw+vp4nqek49usowA3FsRYcFH4b2NVaRWSQN22Jq/J73ZDOBkhqB C8F8CTkBlg6j2Moe243MuT3nQL5RqzoHAd8LPy2cFdf+tzlf0aCSNFK5h6jWt8GkExocnYIGpi9 N8ZCo7Jkdty0uKL561TEilP5VYjCxRMdTwxu7RR1RhnbjEx2Teagv5Ds4Ia4Ch4ttF0G0dXdGGq CI0v8ABiqduZfQ+sjt4h2VPfsbUiJRipGS6Q5c0a2egdwpG4DYRF00c/Q6UxKRc0NvvLhpWQncp bpOZtroGXmS8lkzgVSy1/dSNd9EwDcO1mBoUb6pCb3lmRs4f
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Among the different device id structures <linux/virtio_pci_legacy.h>
only uses struct virtio_device_id. Include <linux/device-id/virtio.h>
instead of <linux/mod_devicetable.h> to provide that which is more
lightweight and doesn't introduce that many dependencies.

The users of <linux/virtio_pci_legacy.h> also don't rely on this header
to provide the full plethora of definitions. (There are only
drivers/vdpa/alibaba/eni_vdpa.c and drivers/virtio/virtio_pci_common.c
using pci_device_id and these include <linux/pci.h> which is enough to
get it.)

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

note that <linux/device-id/virtio.h> only exists since v7.2-rc2, so make
sure your base is new enough when applying this patch.

Best regards
Uwe

 include/linux/virtio_pci_legacy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_pci_legacy.h b/include/linux/virtio_pci_legacy.h
index a8dc757d0367..96a9523e985d 100644
--- a/include/linux/virtio_pci_legacy.h
+++ b/include/linux/virtio_pci_legacy.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_VIRTIO_PCI_LEGACY_H
 #define _LINUX_VIRTIO_PCI_LEGACY_H
 
-#include "linux/mod_devicetable.h"
+#include <linux/device-id/virtio.h>
 #include <linux/pci.h>
 #include <linux/virtio_pci.h>
 

base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.55.0.11.g153666a7d9bb

