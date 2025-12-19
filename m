Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4602BE029
	for <virtualization@lists.linux.dev>; Fri, 19 Dec 2025 05:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766121062; cv=none; b=bSzDvtWWZPeRMWHtFm3hAeKPcizUFdW3iw08wLtbyC1JFQGPakANmSQ6Buhi0q+pqN3jslEu3yYcv6BJCUe2xonu2HdUqjnDm/tMN1IECcWkWaLfqhRNH2imj22TKH+K0bsJxuu/6SDU6WReBtNDpTpy2VfmXm4UHECwsMOJBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766121062; c=relaxed/simple;
	bh=Gv85btUjugFXTHwUwePB/9qVQ9Hx7+oyROqNjqEtnwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jm1mUwSoZBZKsw5fGoxvCLxhNgwmDu0AMAiUHLnTGZIX7NdLKgyXELlMH6kegcYztZp118XUe3Km1xceUGH9O/n63Z4NEIYbe61Wqa+PIMKDClsfuXLrMWiAjAlqDr9We6eQASS+LTzuBQ8bwY3oYveKX+Sk9XzgHMxvs5n9tKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0SSiHys; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0SSiHys"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3ec3cdcda4eso1062149fac.1
        for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 21:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766121060; x=1766725860; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wjQdGAmN4N+e1fEd/c98w7+FBrt2fHW/7wWBacKGb2Q=;
        b=l0SSiHysPbbgLMDBJQul9F0i2LG5+5712Jj9WYh93rnj21r2TGmkUkaOSWUsX+htl9
         PcxE8gXVY7rXPr15wuWeabIKCG2pg/Foel0CZuDFLxU+oPIuCTCv+uRxSKrRNS1mG5OQ
         FMlaqdeLNAhgzM+WBy3nuM8f6KbN35UZx+t32IMcDpmJHURV0hi30AFafjpgYbYUYQJT
         ZdOHgL4JUzirjolwPaiNczprdtpTogVoQW7ZBWarmLGS/tUsZuqPcLPi46EBI13gf7gg
         E8bDEF/E4fc/dsfcjCNKBPzI3JeKAtOrwOvpUrfJNSORNBVsGgJdk5OvYDfP3xSR9Mqj
         bpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766121060; x=1766725860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjQdGAmN4N+e1fEd/c98w7+FBrt2fHW/7wWBacKGb2Q=;
        b=f0uO8fhscBBTVnPQA4qkCJKzmmmaPm/d2sdtUdYKipa+HN0qo4BYrkhpbQuPnyCt+7
         btdXvkhMQNBJk3arBM8kz8ybnMqZX80EhHXbCMKtzXvKlnSNaf4kcJmq7cc2OmzOjb4Y
         lGUXun3Id+yDsz3Ne7FcdL+h2uGvwivDb1PtO86EZsqQGyNpAsX06e58Bq1mEoeKGfFJ
         jMHli9ZQoTSSQBoVcQQkhe4umqt/WqYqPxHXDvSbQXTsESs0FEvF9unF3k8vnzhXdyhK
         FkA50WV+G1BIm6PEmPp85LmsQtABG2fEX7cP9Z3N3NNLm3oC2fRTX4ygA7OWwiJmM7Vz
         iyOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhrGfJ6SDnlCffZpJtDw/+4i0h8FKLgV2cWaAer+HlIE729ZGwZe+9RgZC1q9PNZcMYA5ntprKKxQE4UWAAA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx44En52dE0jLmy0dQPV3FxdWhbho4whKgL0cpuGZoklV395DfC
	BfHRtZwJTlKKzSvpfjBvoFC+MKVtq3LeLugWGx6eaudz9HIihtz39dspPkwlQ/vY
X-Gm-Gg: AY/fxX7VsiEWfoib2jUn3M5j2k/D+akXKAi+iZKbZB4Zd1LYkvYZjYF0cTsuffEgc95
	MPoS02KZTFGATVkQ6qX7Ems8MRie+hsZgXdVkqj4WGyRX34fnY+wMoL3wpdHy7B8+aZ4FiiL2x0
	MF+fedquyCsf4CWZmkN22upv9j/Boul+IaEMZhXV2gu18S9IU65f0aUrLXflXg2PuXs2o/4cg+3
	B/Nf/CTLd1Ghj8vlkpuLHtS1PuZtvu3eINCL/J7sK1eu0D/UEqnTHeiG4bojxw77REeOC6tJheO
	9uBQHGAq5uZTOm50tDbXvAC9V1HZtWS6HCMMdIgMiCkdH5ZLxFg9ZpA68wzuprUo8KjRHcSGKMU
	2gs0Aytd27y1cCuGtFrXw6ODAHUzRoKKUTjcQqnmB9i4QFxGN/MrWr/CDF3PPesFG3+fbs6OOUQ
	LkVjA8m4f5uTo=
X-Google-Smtp-Source: AGHT+IHTyW9c4eUV4UjKBsyVRBnECyP4QSFZiarCr76+3j0lVsYzghfGx1wTeaOuelDxS3SZVqkPrw==
X-Received: by 2002:a05:6a00:a90a:b0:7e8:4587:e8d3 with SMTP id d2e1a72fcca58-7ff66a6ecd2mr1389456b3a.70.1766114222208;
        Thu, 18 Dec 2025 19:17:02 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f258sm702078b3a.47.2025.12.18.19.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 19:17:01 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 97F8B420A9C8; Fri, 19 Dec 2025 10:16:59 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Virtualization <virtualization@lists.linux.dev>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] virtio: Describe @map and @vmap members in virtio_device struct
Date: Fri, 19 Dec 2025 10:16:47 +0700
Message-ID: <20251219031647.25264-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=bagasdotme@gmail.com; s=Zp7juWIhw0R1; h=from:subject; bh=Gv85btUjugFXTHwUwePB/9qVQ9Hx7+oyROqNjqEtnwc=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkuh8033zbxzJvsYSyyUmCnb+jXRqENGfJrrTRulSs5y fLtbzXqKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwEQOfmP4n37nxbojC8J1k45/ 6Do2b+4x3zzPRyqbve7uOHRizZq0ShZGhvveCrF6Cb/n+Mdtt928fvXn+dz7DPaFiypmMslu2Sp 5kxcA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warnings:

WARNING: ./include/linux/virtio.h:181 struct member 'map' not described in 'virtio_device'
WARNING: ./include/linux/virtio.h:181 struct member 'vmap' not described in 'virtio_device'

Describe these members.

Fixes: bee8c7c24b7373 ("virtio: introduce map ops in virtio core")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
This patch is split from kernel-doc fixup series [1].

Changes since v1 [2]:

  - Apply review trailers (Michael, Jason)

[1]: https://lore.kernel.org/lkml/20251215113903.46555-1-bagasdotme@gmail.com/
[2]: https://lore.kernel.org/lkml/20251215113903.46555-7-bagasdotme@gmail.com/

 include/linux/virtio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 132a474e59140a..68ead8fda9c921 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -150,11 +150,13 @@ struct virtio_admin_cmd {
  * @id: the device type identification (used to match it with a driver).
  * @config: the configuration ops for this device.
  * @vringh_config: configuration ops for host vrings.
+ * @map: configuration ops for device's mapping buffer
  * @vqs: the list of virtqueues for this device.
  * @features: the 64 lower features supported by both driver and device.
  * @features_array: the full features space supported by both driver and
  *		    device.
  * @priv: private pointer for the driver's use.
+ * @vmap: device virtual map
  * @debugfs_dir: debugfs directory entry.
  * @debugfs_filter_features: features to be filtered set by debugfs.
  */

base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
-- 
An old man doll... just what I always wanted! - Clara

