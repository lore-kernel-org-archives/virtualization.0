Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49982F7CF8
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761415; cv=none; b=ZLbfH/DBesOr1IWJp2ZOPDypg7efNSzq3t0EwvCpKoehPQ3YC9RSKcPhzinVsoH9581+1U/mVauCdDDgZ2ktq3MRxd3k/Bz3PeJUlNMkl7DQvWQHCKTnLsN1ffx1fwYvUOMCbdiB0ksDjYdTcn436uIMiHeW3CBbRmXZUT3Hx5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761415; c=relaxed/simple;
	bh=h5BQC9mByxJDY26rU4tjCerVWmoNcd7LyS6Ii5OUcRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4ru26j24fPH3qsShBiGMDWiCWM2TJ8jbjxB601nC9jJzLJzBfClBVai5BRAPlKA3O1SEeiV024Oc2DV9A/zDxvBmyhxSV4mDDGxRqWPaSWIW/+nAtx3zHE4qZdlhecGAKIRqLUhhiR99o600eByXmNdKpOlPr6odzj/nNfoO/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JjGN1Juh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JjGN1Juh"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCguFw008506
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 14:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CP6Jzze8Me6
	quyVOR0tDc8eWtyKvcOPnSUsVWLWiMeI=; b=JjGN1Juhbvrx2DCkK48QI84KfNJ
	h9kF6Hp/RYpRTMPYyB0QbwYnxcTujmCSxGb8xoQ9m5ge0BFuvYyljGg/diZTOyuU
	k+M0Fc29hkezz3K4Aw0KzN2K2TbWCQlFYXgoiQd4XUa+W3/TX0qj8Io/Rq2P5DBr
	Mffyp2YK/IvKy4MNTkS0FNYjub6IvCqMf7VZ7XJRMrJySBs8cC+dFu62vPiAintT
	9TtDtDKQfAunyjvekbt0hwU0mt2mDCCCD8bvFUjX53a74qWkdXxMCcv0M0+a36x9
	DLXIkvBAakMJA6AE/U7Exrn2t93ojlEfofJvQ8Kpdae9zCrPANLe0PS+ZPQ==
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxb7xsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 14:10:12 +0000 (GMT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3df2d0b7c50so10220725ab.1
        for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 07:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752761411; x=1753366211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CP6Jzze8Me6quyVOR0tDc8eWtyKvcOPnSUsVWLWiMeI=;
        b=gfgBDgY4DQB1BpILYM9YuIlFH+V/KT3LTEMeUyzoLjpx3j1/evOYWECisaH0LyeUzg
         hkv+Y9l8TgAhL95Zn196SMrmIZRzgcLnSAWfqKJNFK2lvhT5sVYx+0TymIatNlNA+qyU
         UtJjcqa6iaHjeZWMGbnRXQwnM3DYPrkAL6SQePmj3vbR9gqxwOUudrxX90wVjVvc9/g1
         AxVxLx7+UWpx+IDZ4UI5SQ3YCDlg+zJTaqNC8uJ6yC7OVhtQ7z8bbvTMZJfndQ70dfuD
         G9+Z5xq2pdRNgmV1mW1RZJgHD8HVw4JqXguqRQvACpiFADI0AAe9XKQJVbluQTlfeZ9y
         xiWA==
X-Forwarded-Encrypted: i=1; AJvYcCV19nTgdSi6lKooMvw3T+OqQ73ojrZjpqk0eCRKXMv8BEP0KDxSnzoRqrLpZJxcNhSIkTzuMyZMVZskkj95yQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxO57u9tbcN1OwBEAU1JiWTHCg5/sSzDl65pNLIz7M21Qi7nZpn
	Ac8+evKGBjBo0wtSdlnLS5wfVLKyFZZK18IMiRGXBZo8xzTbXa2QSzgRIBswNvxaZ+lY6+5uAWp
	qEVU2ccHYptVE0E5Ug+/lHc6ptQB68KjM0/XX4J1CT+m5bpdreg+TQp2K3caqywUfoARhQQ==
X-Gm-Gg: ASbGncsXxYhxd0wY8HYca/qfoOZCy9SKeDR+vy830ZD3a7MOZLoWkUTdV4RXKXnBr8s
	exnXjRa0eOwDSMNLZZX0KLpMoRmCw7gy4/nywyR2ysoo4ng2tcVZhqtBAyfc95ice2SwhUdpIsN
	fjqp3rdtYCzvcp69ULh6N1/5ZA3mZs4ZTOuXp+lcLm5OmJQON2EBM/p5x4qi+enF7vOVdOROiQj
	m4UK9b6UjemBwvjUlr/k5MRxfBYpIJ1Zg4HoJwZY0meXg5pY1ayrqPYT4XwcidhhjiQt3oLSqk0
	QcDZMdBYbUCpDR3OVn9G53P2THGRqxqfCmwd+BQm1DvIClf5u5BX1ahsrXQCz2W3nQ==
X-Received: by 2002:a05:6e02:144b:b0:3df:29c5:2976 with SMTP id e9e14a558f8ab-3e282e65b56mr66949325ab.14.1752761406710;
        Thu, 17 Jul 2025 07:10:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwLDzrUusnEpv0HUYrf1+V/UgFGINfO9sa196Vx7jwWsOTv7qAHuTrm2DCVfwE5RzjtmmlSA==
X-Received: by 2002:a05:6e02:144b:b0:3df:29c5:2976 with SMTP id e9e14a558f8ab-3e282e65b56mr66949015ab.14.1752761406251;
        Thu, 17 Jul 2025 07:10:06 -0700 (PDT)
Received: from HMOMMER.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90c4dsm1391452366b.19.2025.07.17.07.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:10:05 -0700 (PDT)
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
To: Enrico Weigelt <info@metux.net>, Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] gpio: virtio: Fix config space reading.
Date: Thu, 17 Jul 2025 16:09:10 +0200
Message-ID: <20250717141000.41740-2-harald.mommer@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717141000.41740-1-harald.mommer@oss.qualcomm.com>
References: <20250717141000.41740-1-harald.mommer@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uFVwsSghQuf68DMtrOADJ3ji9cHMSQFV
X-Proofpoint-ORIG-GUID: uFVwsSghQuf68DMtrOADJ3ji9cHMSQFV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyNCBTYWx0ZWRfX4olhFOvARJ0j
 YIeJGVXRPz6tW9JJGnLdBdDwx4h2F78IyCUul7fVNSeLmp4NMDayXudAr8utldOpDucDNI8vlxv
 q60MjQhEa0U5R/AJh2B+1RyTp/r2c3el2pwqdCIQy6rTIaUvSwYqkNTghpDpEcHa1c9+2PqrF4z
 WSmCyA+PIEc9WSFgIsZh4xMqAzMRzOA4n7s/luP+kvTNReIp10n+LpEaslTYRiR8CGHgYXxg2mp
 wsBcKTfctYobw/Y4JHGNB5l2x/xRBSW3pS1FC+5mWcaBvLEYBe2f+FFIibUDpGZ3odd49IGJQgg
 JLrL+p0qihi1C17irrembFU+7250M0w9RvplyV6y3BGgORC3ZPWfPFqCbnP1hcC2qbmcowVcz4V
 iDBpLBhFXhG9LYfVkO0nJ1/fZBV6hncrDfMMqx/ySbEcGFJugB+zKrLrNEthYIWS1xb1Yu5i
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=68790444 cx=c_pps
 a=knIvlqb+BQeIC/0qDTJ88A==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=x8YHxakxDffKOoiCecoA:9
 a=8vIIu0IPYQVSORyX1RVL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170124

Quote from the virtio specification chapter 4.2.2.2:

"For the device-specific configuration space, the driver MUST use 8 bit
wide accesses for 8 bit wide fields, 16 bit wide and aligned accesses
for 16 bit wide fields and 32 bit wide and aligned accesses for 32 and
64 bit wide fields."

Signed-off-by: Harald Mommer <harald.mommer@oss.qualcomm.com>
---
 drivers/gpio/gpio-virtio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 92b456475d89..07552611da98 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -527,7 +527,6 @@ static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,
 
 static int virtio_gpio_probe(struct virtio_device *vdev)
 {
-	struct virtio_gpio_config config;
 	struct device *dev = &vdev->dev;
 	struct virtio_gpio *vgpio;
 	struct irq_chip *gpio_irq_chip;
@@ -540,9 +539,11 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 		return -ENOMEM;
 
 	/* Read configuration */
-	virtio_cread_bytes(vdev, 0, &config, sizeof(config));
-	gpio_names_size = le32_to_cpu(config.gpio_names_size);
-	ngpio = le16_to_cpu(config.ngpio);
+	gpio_names_size =
+		virtio_cread32(vdev, offsetof(struct virtio_gpio_config,
+					      gpio_names_size));
+	ngpio =  virtio_cread16(vdev, offsetof(struct virtio_gpio_config,
+					       ngpio));
 	if (!ngpio) {
 		dev_err(dev, "Number of GPIOs can't be zero\n");
 		return -EINVAL;
-- 
2.43.0

