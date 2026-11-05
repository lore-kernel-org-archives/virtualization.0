Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907051;
	b=uSHDyvuuKrXP0V/yssudRLSvxRLADjFMIJpKSeDzCb7i0zk3fT+pjRxsXuQcRxwgWu0u
	 /1wtLxD/JNxHC76MWzKdjBbTaq2mMcPgAujb4noNMFZ/6HH8lflwl8++X9IMdcKjsxO29
	 fgjnJFaswTjJAoxyYniLrSBGee36snMPtX5ptQ7JgA79se++AVHZhMqCB5DBkzQ4k0gbL
	 sZZSrf/Ze77gNoUdRSnBC6jmcSHqjY8zXFoS19B8TBEyo+7/u6daz0+otx2jIQF59SI6r
	 MICAP7WBRqxUelwwkeDa0DZWWQUOSv8K9AnnZi313KOVfFd79iJyBtWDtlGGnQhkSog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907051;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=pULgvz+O+Ksyia7Vwa188Bus55VbJhS0nH9N4n8YrsE=;
	b=alMOCAkG3T0tvu/UdS2Skk0AQEIx7wyC1Uy7qKqQTVhbd+MIz0REMp9/kEoWTX2pMQkH
	 s78GbpHW200fex4Q+7F0+WWHKqaxiTXfqkpfePEe9ZMOp/EjjXS0hpo3+r5k+4qqNGIk7
	 pl/fixI3DgIm6qT4Iv6WBjiam021MSHWkOC44dtT4kWRIGF624urkbpEFtrQqLGoaTDER
	 ApYeUd9Z35wtc1rLxblRhpJP9Kbw6iXCnAJgxJ6PJege7u27qUVfZph9O/KxI6qxaJylh
	 5sw/8GUWlOixTnGg3pi2hTv3MergL48J5Eyn563Kby0AZDts4LV5igGrzQNGaJTx9Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b="ckb/ZG0p";
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB61606D528
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 19:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBB61606D528
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ckb/ZG0p
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5J5oNb3790915;
	Thu, 5 Nov 2026 11:30:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=pULgvz+O+Ksyia7Vwa188Bus55VbJhS0nH9N4
	n8YrsE=; b=ckb/ZG0pSPSS2iGLNGbhAKEZoMIcqsd7sri8K4r500B7N+v2cPcjq
	PMPi9wctXGCM6D+OBCxxoVRx5a8RCfHwOmuJ35XZ3KdgqnJ4nW/w57MUCx1iWWg7
	3THfG/DFYkXziqy1Jr1CmR6SzWVRfxwP1sU4IBLIMsuca0X+LlFSFJdwHl/UALhW
	aqzJc39IWPYPRU9y6ToDvNM3qibUhhbmtgXDg5Xh2G1+KRkhXGVWGbwprvt4SIZn
	RtLTvAK83jRvcMYXxki90koiTL5w3h8KeXV/bGYMNUYtEV5AwA5rmMuQOqqLJvY6
	9B7kFNhwwe53biY4r3xfTJcM9QFdyJ5/Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hrtsp2t8x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Nov 2026 11:30:47 -0800 (PST)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Thu, 5 Nov
 2026 19:30:45 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Thu, 5 Nov 2026 11:30:35 -0800
Subject: [PATCH RFC iproute2-next 1/2] uapi: add vsock_netlink.h
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
Message-ID: <20261105-vsock-guest-ns-v1-1-b1c11b3b69c7@meta.com>
References: <20261105-vsock-guest-ns-v1-0-b1c11b3b69c7@meta.com>
In-Reply-To: <20261105-vsock-guest-ns-v1-0-b1c11b3b69c7@meta.com>
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@kernel.org>,
        Stephen Hemminger
	<stephen@networkplumber.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        <virtualization@lists.linux.dev>,
        Bobby Eshleman <bobbyeshleman@meta.com>,
        Bobby Eshleman <bobbyeshleman@gmail.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3NyBTYWx0ZWRfX2Dclig+DfsxB
 2rNYCyRa4BxehPyWf5OmOaJ0KGEtqbmBdoJRxKkKFyRVxxULMSQpsz9MFTx0jcxly5O+HSiY+zn
 qTdWCxDRXIx7byWc6VtaGKhxOvE1qnKDPTir+JXCk+wQeu3xbbudFvgv6ZgaUQ07N2bhmgAWhWK
 q9qljjbE8De2GMxfVQgQy8WerOGaT/VonXINVmRsO87d/aH36bHnAs7jL/dS7vwk8W2RMhi23Jy
 fSr0yx15t+uJAOxNAePnu9UA/kQ4vsWSpeLrEqDOkn/AjQIO/PUe9AxFOyyxAdpAE9OQiiOTFBg
 KchYjj32xqJ0FL3uLtuTJGR3v5HPLMxAj6aF6DGqyhty1g/VyeTbUC7/u9HxUhgRJhsHDzV+HZW
 AIdgIaT1ByZltlPMMORV4vm3j4/x5QaNaKzfKngtDOTADbkabownFgWAMsmG9LadYAWdt3fGvvJ
 DthKxGtDt9pZPfIMGDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3NyBTYWx0ZWRfXwpY+I1Sj+Yfb
 NtoV/sD22wvQko4ISNqbMwTgxpRKeMnokkHF1thBDyC4lp2qwOMMaf9Mzozj0Lh0q0/fmnbalZo
 cxN01yq2rNhC+b6+5268k9nh/cW4X/A=
X-Proofpoint-ORIG-GUID: IFWTiIwmWqaBSh0kY0QvXT2VAZ4BBosg
X-Proofpoint-GUID: IFWTiIwmWqaBSh0kY0QvXT2VAZ4BBosg
X-Authority-Analysis: v=2.4 cv=NqlE4MdJ c=1 sm=1 tr=0 ts=6aecd967 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=5sR36CSIlAS8tFYd-hEA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01

Add the uapi header for the "vsock" generic netlink family, from the
pending kernel series that adds it. This is only here so that the
following patch builds, and is meant to be replaced by the usual kernel
header sync once the series is merged.

Link: https://lore.kernel.org/all/20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com/
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/uapi/linux/vsock_netlink.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/uapi/linux/vsock_netlink.h b/include/uapi/linux/vsock_netlink.h
new file mode 100644
index 000000000000..adf0fbc50ad5
--- /dev/null
+++ b/include/uapi/linux/vsock_netlink.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/vsock.yaml */
+/* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _UAPI_LINUX_VSOCK_NETLINK_H
+#define _UAPI_LINUX_VSOCK_NETLINK_H
+
+#define VSOCK_FAMILY_NAME	"vsock"
+#define VSOCK_FAMILY_VERSION	1
+
+enum {
+	VSOCK_A_NETNS_ID = 1,
+
+	__VSOCK_A_MAX,
+	VSOCK_A_MAX = (__VSOCK_A_MAX - 1)
+};
+
+enum {
+	VSOCK_CMD_DEV_NETNS_SET = 1,
+	VSOCK_CMD_DEV_NETNS_GET,
+
+	__VSOCK_CMD_MAX,
+	VSOCK_CMD_MAX = (__VSOCK_CMD_MAX - 1)
+};
+
+#endif /* _UAPI_LINUX_VSOCK_NETLINK_H */

-- 
2.53.0-Meta

