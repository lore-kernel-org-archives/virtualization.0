Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795674264;
	b=wTxHGNUpfwhsBF/6Ne3F7WADpeR67XxIttCYVEll+iCyhoo5NfEjR8fr4NE62kY9v+gL
	 7g8aMITdMaLkP0JHkUWn/2IIOveuDaYLNng6GzGvRPNlg2Mxik+KmwT7xfd5UXNmf644O
	 KGn6srRLIMofjjJwIkaBJkG1CEECgyg/WPcK84YGUfPHv+00mbaHjgha2+s26K9+ZLSHc
	 MJ03vfgA8lsT92+6bYw9jQ4T+k6lE7rkPQO/XQXsP8m4j0c9ofZSG2vicZkRiaJV9vIeb
	 ni6D0AbgaLm13dPku//B/NS8d82rRL8Cd/ZGWGWwi9p7UW+hhYzGQIUYOnoNkZ4o19w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674264;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VRWFQMmfOhAdXsj6YFM6m5s/YKM/cmFaiuqWjca59kY=;
	b=eX3Fzi5gViURXucADbsxQ/iicWcjjKUUMVmkZ+Zj4HJWCFFY8t0Ijft+5OX08rwxJD7d
	 z7bGcyRmPsAb3spfClOIY2HBMcyR4OdYwmFUO7VA0IwMCfsvWNrQtxQuSPfszVFCjGvu6
	 L1ZlfKt4xQO+BUeNWvTtYWHOIj8n7hI4eue4PSvlxoPykcWaLyN0MkXnRJhvU6qqpobwJ
	 7WB0KGmPhRnxaX7jPJvQ6cHt/99mh6pxHE3lx3S07Ldf3TVWhhEP/OB2N0iKb6+VzMe6c
	 q8RsQuh4tLN8b3yfMI9M7/QsIiuTh+8mWAkJOuNm31Sjr96eLMY85REWwJXUUcQhyUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OdolxAgf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B0Uenaer;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ED6606A321
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 06:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42ED6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OdolxAgf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B0Uenaer
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ36F0n2068376
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 06:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VRWFQMmfOhAdXsj6YFM6m5s/YKM/cmFaiuqWjca59kY=; b=OdolxAgfqI2pDZuw
	7lIVRaBaousaXsnNZ+J5PaZizpOz55gw6EmPH8qKWw1Mogj6LTpRSmawjc+FDa4w
	xGb/KApM92k6X1bisxZbLUUwblWajRykzQl9QDwovTGnBYek/nC+5tlDE0uB8QFr
	VltDBQILEM7X0BwghxaLbux1APLBF9b51+7ZPymBtPF3JD66KbXOOfZ2af92J+Ky
	/0Q4xOCGg4WJNrVJYGNj0X5NA9YjU/N4UFPB3092UastC8eGRXFMREH6fxZWHAM2
	p4NQhzQwja3/nr25OdOZnnlL26PD0JJFtzOPSfH95ese/O5gMQdfaWsq0QdtGDED
	OBtP6A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662s9qvv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 06:24:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b4ca90ed93so2992622a91.3
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 22:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795674263; x=1796279063; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VRWFQMmfOhAdXsj6YFM6m5s/YKM/cmFaiuqWjca59kY=;
        b=B0Uenaerydq5RCuZ0wb/mZRuGsn1LMHOhBB+2o0n2XV0oMVSKvd4igpBeFHoxc8HUl
         iPP2vPSI7a+FMoFNeWadeW0Oqzhm6lCyeruvoVzLhy+yKmi/LAsymNfcLC8GtgFqk69O
         w6bchLAZbga6rSV3JzqbAwfwbccnkp31nuikYHJe2FIlKnI3lQ5LatFX5K93GXNhhqi2
         XSAw2zsHNcDFQQKdtMuCZfd4xPK7/n0hM8xGpDfvusLxyRZ7Xe38pegnbEpoOYo+xGH9
         H++sAoCweKKfmdTHKEqqwaQUkmj5hDxXoG3ce/VlydtM6bvSRn4GPCb81ZG6jznTO+1M
         He9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795674263; x=1796279063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VRWFQMmfOhAdXsj6YFM6m5s/YKM/cmFaiuqWjca59kY=;
        b=DVbaldTl1pHl+N2/DKBTVoI6Ir/23ehv5uSOqnlCzJz4JfBIE9O27TbhpBFb2+eVZq
         WucHUQTDWsS7zlOndEloItXISDe41F4TSl+sjREZ7XALFFHm+uNkux8xFsYqRyFdpl/W
         3WdVFhYcUMuI0l19HdE9gTDBS51zjm4c8RclL0uXPmtI+oEXRQC3qv00i1bBGO2jNM4+
         QTohmGra+Gic9R5X7gYDBnP1a+0HBX+x09hH/Hf26w63J1tVysmTpsvUGCgTq8vVaP+L
         zYtNyBhfjR8HybiKQqUk5aeodbwdUrVjrrs3nbpXDapUGAHulBdDMkd7UmdoGsjKeuLr
         lyiw==
X-Forwarded-Encrypted: i=1; AL+hErGA90QEr5D5YIJLiew5OXtlbDggDjuMOiMvZDLm+Bp7kWKo9SLlLD3fCXes5LRZP2zHLPKdhJ+1o96juI9J7Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/4X4LRSmUhiZIdCL6GX09u/EgSCamSKFBoeVokIZwXHC1tw7PX
	WJ5QVWa12msxQ31SY6d24C/3fcOYZ/Hzvt0aXUGp4iLp8aTTBaNA0egyak7joExsIDAA7OKPxsR
	K/DQKEZpEsTI9OCchpUxwYla2jh1vXppVvf2cS2En3DypBAE8IA8pWux91KAuYxJvrMxctw==
X-Gm-Gg: AZFdTZcGh5RpZFSP07kLQ+J0R1Yy0fvOifJECsYJdP4hyUN55Q6L+amEGSmKHrFtmjF
	qjI/CKR8DlkgDeQJ7DdGf6lTGn1+8DZzPmsWyMveNzCfS7UMwBMll1/UciXEZDnRqSFcSwhxHFf
	7ZEma5qHb9vcujCN3+SNyVxigwAiEN0kIwbubpvvnziuWWPswyQ/5ofn0RqGl47fIag08e2v7+v
	BN8xl9cPfX3q1y18T64az7Riq9FBA7BSbAMoFwOfBDuoeQZK7amTRld1ywfkpTxOKzS+sehMAvI
	7ydAYcSOwTzJoo8pPwTgfpcZScaawaYH4wvwfJx79g3kozjTnakMNSQtNo6eLvB2oHTTBrgRll5
	y4zhIqL8o+5pOSjnlURczeZk08pcVXIoxw/vymXp8k+T01sMbKJGNlWcS4syeX0efR7cMXbDAZ1
	g+LD2B3rQ1
X-Received: by 2002:a17:90b:554d:b0:3ad:d29c:5e64 with SMTP id 98e67ed59e1d1-3b41c9b361fmr19232474a91.65.1795674262873;
        Wed, 25 Nov 2026 22:24:22 -0800 (PST)
X-Received: by 2002:a17:90b:554d:b0:3ad:d29c:5e64 with SMTP id 98e67ed59e1d1-3b41c9b361fmr19232454a91.65.1795674262406;
        Wed, 25 Nov 2026 22:24:22 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b6fc28asm14988015a91.1.2026.11.25.22.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:24:22 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:54:00 +0530
Subject: [PATCH 2/3] virtio: Add vendor-specific device ID
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-jshekhar-qcom-virtio-dcp-v1-2-7b49bda74916@oss.qualcomm.com>
References: <20261126-jshekhar-qcom-virtio-dcp-v1-0-7b49bda74916@oss.qualcomm.com>
In-Reply-To: <20261126-jshekhar-qcom-virtio-dcp-v1-0-7b49bda74916@oss.qualcomm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674248; l=1122;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=GarfczuQMc+vTCQFOwF20nMoLmGibGyTdxH8fgzaj4Y=;
 b=xLVT2dFjo27JP30KZLWo89YMNzpxh6pFxM2QaR2byRBSxWn8dA4BXKdb8GXuJjoxbEQrnxjmq
 O96QgrXg7C/B94GfmaYJ7hOthasfXBM8g50jzhTiloiGHkGBoG18Kl4
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6b07d097 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Gva-buRrl8eeyeTSwpAA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: SXxTtkPmzOVssRdlB7D_X49bxso_lhPE
X-Proofpoint-ORIG-GUID: SXxTtkPmzOVssRdlB7D_X49bxso_lhPE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX5Wc719Pk9KEL
 8DLk7S1BgGD0qVvoQ9EEr9rY1Ovt2z6YRxPSJlX6egnE1VEI9hQ2PcOpv4HHYf3GdBqD2+9W0/L
 1qQhqPqR0+UHwFtC7k2UjsAel1EcXen/M9Jj3mZZqNDixV3Ft1bXMoapj8VdxY5cSjOv1omeQ/O
 dS1fLcPEG45atSDJcB2UaPdFpN1yWahpGa9GXvxnu/0XSGCF2pPqEGscpCB+k3uy3zIxDJjTPnf
 wSwJn7isun9VpWgteFjYJ4lJ5my8iGYTd04S/4JxB5iq8ifvN6Bv0kT2DeJae5VF2FN31VMKpF0
 pQZYyj30ANQg3HHhyEnEM4BiYxbRbD7mldpnqLuKR347rPKnCCXAWoBYrX4shIKh77L1W1ZkHs5
 0IgqTgaTNUlZk67vvM2pII2Roajbv8idce3u0qB6aU3/gOGX2mQmesjE4nhtMRR1PU7pcA5BDCI
 1yo5QegC7JMvtSmgU4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfXx1mZKPncsDdz
 NEU9Vv57CkzGMK1m6sl0D2YI8aD7sZaPTMhOjwofmrITl5KXWpHJmYVO6xl5vMo0WOtGm5rn/To
 WKFlcqmuUkodE9yfUHhAeZRj4BmgGZA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260024

Define VIRTIO_ID_VENDOR with the proposed device ID value 52 for generic
vendor-specific VirtIO devices. This allows vendor-specific functions to
share one VirtIO device ID and be distinguished using their vendor ID and
platform description.

The value is proposed for VirtIO TC allocation and must not be merged
until the ID is formally allocated. The DCP function driver should match
the generic device ID together with Qualcomm vendor identification and
the DT-described transport.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 include/uapi/linux/virtio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index f9056af0c622..9a8b6a6a03a4 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -70,6 +70,7 @@
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
 #define VIRTIO_ID_SPI			45 /* virtio spi */
 #define VIRTIO_ID_MEDIA			48 /* virtio media */
+#define VIRTIO_ID_VENDOR		52 /* virtio vendor-specific device */
 
 /*
  * Virtio Transitional IDs

-- 
2.43.0

