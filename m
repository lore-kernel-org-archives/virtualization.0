Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CBD74068;
	Thu, 21 Nov 2024 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732197360; cv=none; b=Dhu5YqcwUBPNnL2Edreo6hVhVrMutjXaAT3TL7VE14aeq+0jEjJ83GA9pkvsFE6LY36AsB5TbolI/l1OouVg9g0VsEF2aWaxwRheOxIUn+8M1aT+e/fuEpPxiRbeJaCGYZWrmug/bd/L3u52jnNHpU7b8U0DJRzFDtVsmSHB+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732197360; c=relaxed/simple;
	bh=e50TRD6Cs0BTrjJjeFWpivqEfvc1nYqjaWdHTsyA+vI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCkzZUSPOpMWb9C8KxImRBVa42x7jyzfFTvg4/im89HCo28BvERNyM6u6NbLuhb2knF3lirp3tjDcxfF0LPwVLkh8MK4i6CzxzfOEuar/JQpsoY9SnsqdakKowcZKsN7Jp0BMoQ92Njdfu8jGy4lyWXGHznUg8IJi8A6Y3vgt20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ww6nYahv; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ww6nYahv"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALBhHCP018102;
	Thu, 21 Nov 2024 05:43:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
	B+69McQh3A+v4jhyZkxKKXfktsJP8OMLiiiavgDycw=; b=Ww6nYahv7lCJUn7Ah
	683DnMYU/pjeDEydk11iEPW9IbCPRmazMBvRYXuLMqX5CI+hPAlIycVZe+4jguhS
	lPp8Wyk/Ew4WF9K2+kCqIt+hz5pEmAbIaFQaymXU1qBALs0V3hceDsbbnzW1D37G
	YQgT7fAIr80qUQ9TZCXk3OuZ+p0S8/XYh40fl1NfG9sAAy71vHaJohEkyi1tGNfA
	8Xw36hFzC3s5wnBIUz6QJcOyOihHpJ1fKdWpkqnrqGprcHsmRmIwZIkr0fpGpBQQ
	XwOvSBr2oo73uqoSIERG2GxuMknjETbwSykvzJge1PnVb01O+ShnzP7gLT2p+Tg5
	K6Pgw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4322bjgbuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 05:43:12 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 21 Nov 2024 05:43:10 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 21 Nov 2024 05:43:10 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
	by maili.marvell.com (Postfix) with ESMTP id 8BED53F7067;
	Thu, 21 Nov 2024 05:43:06 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <virtualization@lists.linux.dev>, <mst@redhat.com>, <jasowang@redhat.com>,
        <dan.carpenter@linaro.org>
CC: Satha Rao <skoteshwar@marvell.com>, <schalla@marvell.com>,
        <vattunuru@marvell.com>, <ndabilpuram@marvell.com>,
        <jerinj@marvell.com>, Shijith Thotton <sthotton@marvell.com>,
        Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] vdpa/octeon_ep: handle device config change events
Date: Thu, 21 Nov 2024 19:09:44 +0530
Message-ID: <20241121134002.990285-2-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241121134002.990285-1-sthotton@marvell.com>
References: <20241121134002.990285-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TWPEryN5sKniibWXpkIsVrp-z7L7v--k
X-Proofpoint-GUID: TWPEryN5sKniibWXpkIsVrp-z7L7v--k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

From: Satha Rao <skoteshwar@marvell.com>

The first interrupt of the device is used to notify the host about
device configuration changes, such as link status updates. The ISR
configuration area is updated to indicate a config change event when
triggered.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index e10cb26a3206..b060df57bb59 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -74,6 +74,14 @@ static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
 		}
 	}
 
+	/* Check for config interrupt. Config uses the first interrupt */
+	if (unlikely(ring_start == 0 && ioread8(oct_hw->isr))) {
+		iowrite8(0, oct_hw->isr);
+
+		if (oct_hw->config_cb.callback)
+			oct_hw->config_cb.callback(oct_hw->config_cb.private);
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
2.25.1

