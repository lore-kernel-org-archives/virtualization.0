Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969702C868
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 08:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169114; cv=none; b=FQN5Pj+SDSc3V+IDArWnWXFWG0fkn6hQ9nt5tm3uLMRfN11MSNdyMXNSSSi9z+DiIu1iAYzaffNHpe2s84/pf30xpEyv4jrvvfC6B2MKPkIYv17RXtUDUJBQtQIf1JjsHw8cPh3Dnh+AxcjXyoVvKL1EaziEXfzYtHgD7l+/7wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169114; c=relaxed/simple;
	bh=JB7v20ff7Xb02F6Y10LFP5M+IvHG6sO11iwPnmzSaoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i12cGj1N7IxyM0BfQxTLnynCq2e9qzw/9HidLyF9k9aoj+f9l6FEqI/LN43EZusn8hkOc52p3vBnfYZDWGi6YhgX6JFmFaEQabNSxnKx8rniGspcIXey8JsuDmeXTK2ADNP4PV5aekjfm6nLAdB3NRvioPr3t2a7ysl7+O6CDD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyzJm/yt; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyzJm/yt"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ecf3943040so2281238b3a.0
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 01:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713169113; x=1713773913; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2S+amZgScg+Tgd2wJVdpk38S0yUSHLTCilKi/2bme+I=;
        b=hyzJm/yt3ZtFBZDkQO42VzLEFoT5xXsheH3hJbysXK/S8P29RDaw2rH5yklbMImJ/R
         Z0qAz18P197p88EoDn1UwgPXrVOL78prwewgN/A6M8CKj+OmOxZazR5eyQprwkdQ8aBw
         QOh5IoYJoLzxfMegFMbf/cIMxMEDrjEvFl3SVneh7H2JnizAs/cFGaKretahi72vM9m8
         z38hTnnwRIox6ydW6QoqFM8LXzWMDUaImCfOFXBqUe4gCXyEWEBG0TYK6w9gKcebc+KM
         ZPgSIJm2PeFE8tu8jnQmDwKmiForGS9Wl777I9rksNBbJn4TNQFl0PkK+sg/E0IAD1dt
         7lKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713169113; x=1713773913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2S+amZgScg+Tgd2wJVdpk38S0yUSHLTCilKi/2bme+I=;
        b=Ni7hrC2pa7AwmAzdwpI+R03zqvx51nLddTlzpOdusPLPsJNCWQPKbsGe7cJLCBWPkL
         Vd6oQ7hAIvpehk0GB9nk6KfnjNTCO+5z8lgL+H4W6ye/nFGHhrlk5sX4qV8nBX1Xy26D
         0Mc25P1YOqxsJWYWRKMpi7zqBEWZ005gNxsjJNKxP4L/f5UtgODA1iyCpQxlyTzhYzz+
         wYcYvMbwvOwhedWy+PNp1KCxVlh1kWiWhQtgyJ1+uoGZXatK+Ik8IfQCOaYltqgmW+4b
         Ior4OnOIfAl+KU+xg+HijHDq9g+4GtZepE3S8dyQYkPCj0B1YUkkiZ24ET2uJMVu7CWq
         m3XQ==
X-Gm-Message-State: AOJu0YzymoE8KbmbBfi+kc6s7I3iedMj+O/r3GNJH1blEs/dp8jhlIqf
	uR11fuMu1Jz9L5uudBcyXz/aVhhzv4GW6MnN4+0IBPedfg4bwlf5
X-Google-Smtp-Source: AGHT+IEwP7QZ13YsK6+R9yCqj164VBqhtdxtkAH//Nz9UjDAJasVZSQ+HmHZy15K6uqBXK3SgjzsFA==
X-Received: by 2002:a05:6a21:3283:b0:1a9:68c6:c0a7 with SMTP id yt3-20020a056a21328300b001a968c6c0a7mr10649798pzb.9.1713169112824;
        Mon, 15 Apr 2024 01:18:32 -0700 (PDT)
Received: from FLYINGPENG-MB1.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id p13-20020a170902b08d00b001dc391cc28fsm7343157plr.121.2024.04.15.01.18.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Apr 2024 01:18:32 -0700 (PDT)
From: flyingpenghao@gmail.com
X-Google-Original-From: flyingpeng@tencent.com
To: jean-philippe@linaro.org
Cc: virtualization@lists.linux.dev,
	Peng Hao <flyingpeng@tencent.com>
Subject: [PATCH]  viommu: return error code for unknown probe type
Date: Mon, 15 Apr 2024 16:18:23 +0800
Message-Id: <20240415081823.18847-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Hao <flyingpeng@tencent.com>

If the probe types processed by the loop are all unknown,
no error will be returned.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 drivers/iommu/virtio-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 04048f64a2c0..80352505b762 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -555,6 +555,7 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 			break;
 		default:
 			dev_err(dev, "unknown viommu prop 0x%x\n", type);
+			ret = -EINVAL;
 		}
 
 		if (ret)
-- 
2.31.1

