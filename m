Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723A1C5CB8
	for <virtualization@lists.linux.dev>; Mon,  9 Dec 2024 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757369; cv=none; b=AjpS9FdpI1hnTRYbD8H17tcGmY/xVj/fhlIacUyh1tU0kIMKg2AQxSY6C9xFKbpFSL6SwzwjEbvXoFiVIOPdmUStAJuFPCWhAXW7Ie8HlcTS4N02nSyQG0PoQmKbDKbkJhNNTMU7VhLtOv+PZQ8V2ebzIehHEWUSQv+cFyCs5rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757369; c=relaxed/simple;
	bh=Vujdt7DLhHGDbGg1QEYGcYzP1OPkNagvuJCtpYffJmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eik9BbWn1uqpwzn/rcWhZB0g+6xaEK0Qwwq7MCkyBIHqK10jvhTcdaVNhwtzxUhQNrc+tPwBdEzPVzboW1sieRDjDxdl+kHWU9On5IEejLQFwIis9ieNdXs7BVNJn4Sh/tV+SoTLidgz0CPT5BUWfmefXJDknRL/GagQh+LYz4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dSdOKos1; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dSdOKos1"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9AWFpV011702;
	Mon, 9 Dec 2024 07:16:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
	o92DuOs6mj35zWcZ0o3G87DATI8fAkn6M9jAusN56o=; b=dSdOKos1BWRDpkqEz
	nEEcFHsoBVm+OucXN1jCXF1KPJNdPB54jia0B2DhEWT/8C3sET7D5mez7lbAbbmT
	i/ZeTOHhiWFoxMiQ9A6tfVcLCTVEOJIQFTuz9r7ZdKqqf5hp7SWlirVS/eF74PMV
	60UfzI7H1JzynlPjr+hfS5d9H1l+cwro3lnJinvhimI5GKqXj0LYOy1jRG/qAhvZ
	EWnaAOCfeDjstTKqkZ4tSHsOwEwANtLT7b3P7K6zYO1iLCO0HVuoX2gdPk6es3kw
	ondcXeaZFAiMS/j5EuoUx1f3HSrSB4BwccUdyFUUhcsqgHmQ+m5b4447+GA+oJ8v
	jjQxg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43dxv4gk59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 07:16:03 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Dec 2024 07:16:01 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Dec 2024 07:16:01 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
	by maili.marvell.com (Postfix) with ESMTP id 056EC5B6937;
	Mon,  9 Dec 2024 07:15:57 -0800 (PST)
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
Subject: [PATCH v3 2/4] vdpa/octeon_ep: handle device config change events
Date: Mon, 9 Dec 2024 20:42:14 +0530
Message-ID: <20241209151427.3720026-2-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241209151427.3720026-1-sthotton@marvell.com>
References: <20241209151427.3720026-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CfdepBjvakr96pZuCNpeaxYXPztbX2CK
X-Proofpoint-ORIG-GUID: CfdepBjvakr96pZuCNpeaxYXPztbX2CK
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

