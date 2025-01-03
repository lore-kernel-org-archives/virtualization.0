Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB0F1AC88B
	for <virtualization@lists.linux.dev>; Fri,  3 Jan 2025 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735918463; cv=none; b=CVulHRdUdvDhWAxoyUEBxaaMWRwsPaXJM2Q4pOI6jRTKw13lBZuo7GbTNKZpb4urw8kAyMya3JpPtNMp7joYn6iO8DizJb/ZOKzUOIQ399eOiSy1jHyQ6Ta85Pfx85Tpbu40ubbMZo1HK5YGKSWwZahhHPY9K9PMHiIFRLGf9zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735918463; c=relaxed/simple;
	bh=Vujdt7DLhHGDbGg1QEYGcYzP1OPkNagvuJCtpYffJmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpGbD7gYbr09z45S7P06p02vhTtYvovjYOWFzQBs5NlzJ955BbGbWJGlOBZIV7OIh/jhT+pyD0jVCNMtzTz/hAhqkGh+HX+xd3YtwDAgy35bSY1I5ADKtozdSsmCEd5JdyFKR47UjQOPqWyQsQRk/d2fX/xLItDHgw3qFXigPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EqLNjhK2; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EqLNjhK2"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503FUBEU009615;
	Fri, 3 Jan 2025 07:34:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
	o92DuOs6mj35zWcZ0o3G87DATI8fAkn6M9jAusN56o=; b=EqLNjhK2cq4WtY2Xs
	vEws+3ezayZrM4pK0IOyr6vnIaL8hkrHecgUnvrOBQE9clfFo3jZ5wz2Xp3chUPv
	9C2QuO0EoJGa5MHS06ktSk3v7Q7xWuJQz78VhIKnI2O287JP28I2gjdoUOwdSStB
	jnk6b7EG2vyBvS33iKUtxatxnbC0Lut8jS04Nq+aWNNTV8mtejwxxAZblT2qqqx9
	khvmUM/ai0+G8tTXleT1DK2y3qk5Dqya2cw/ijpL1O14KxWFMNsKFuHEj5UlYprw
	PmsZxCAEjUY4cf7DcVUdRSefHhZIVMemUxcmolqICkxXCxYz9hWrPJ2BT7leV1Dl
	dSIug==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43xje1g0pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 07:34:08 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 3 Jan 2025 07:34:07 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 Jan 2025 07:34:06 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
	by maili.marvell.com (Postfix) with ESMTP id 1942C3F704A;
	Fri,  3 Jan 2025 07:34:02 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <jasowang@redhat.com>, <mst@redhat.com>, <virtualization@lists.linux.dev>
CC: Satha Rao <skoteshwar@marvell.com>, <dan.carpenter@linaro.org>,
        <eperezma@redhat.com>, <jerinj@marvell.com>,
        <linux-kernel@vger.kernel.org>, <ndabilpuram@marvell.com>,
        <schalla@marvell.com>, <vattunuru@marvell.com>,
        <xuanzhuo@linux.alibaba.com>, Shijith Thotton <sthotton@marvell.com>
Subject: [PATCH v5 2/4] vdpa/octeon_ep: handle device config change events
Date: Fri, 3 Jan 2025 21:01:35 +0530
Message-ID: <20250103153226.1933479-2-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250103153226.1933479-1-sthotton@marvell.com>
References: <20250103153226.1933479-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Rny1QAruk-tBDTBQd9AZdon7tnnu9n-t
X-Proofpoint-ORIG-GUID: Rny1QAruk-tBDTBQd9AZdon7tnnu9n-t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

From: Satha Rao <skoteshwar@marvell.com>

The first interrupt of the device is used to notify the host about
device configuration changes, such as link status updates. The ISR
configuration area is updated to indicate a config change event when
triggered.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index e9c3e57b321f..4d56be64ae56 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -71,6 +71,14 @@ static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
 		}
 	}
 
+	/* Check for config interrupt. Config uses the first interrupt */
+	if (unlikely(irq == oct_hw->irqs[0] && ioread8(oct_hw->isr))) {
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

