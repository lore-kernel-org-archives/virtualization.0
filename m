Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0A242A92
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Jan 2025 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738184972; cv=fail; b=lxquFXZJORshmYrNPvkpn/Camhh80W46F0Gs2qE8gNACEdKd5/ws5i4ahuLOK6N9SBQs1wGU8WZ1zJyq3flUxTembNrwJHjtTkbkE3HfIPQumk/qWzmP+qV2vMZgGRGKovOB8k4qs2/cCT/l+hJX2pTs8VgspqA5xKPAX25xO0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738184972; c=relaxed/simple;
	bh=Qz/hROWSgw02Ftc8I3cdRqOVFWxb0McxspV3Jq6Zd70=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CUPw3+W132s61o9dsWyg2N62l9/3buApZHuRzaBiasN8n8oXASXJMoeIdbNnoOAZe0f2sUfpzVqQxqA9ovG8NYnxMPsHTz7aJfVtJWKG8Rjm68DtJDaMe8uyuy/dG2hs9Uke9EqO4qYOHFMuJH+ZYpeDoAwq0nM/GKrLng7t0hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dvHilM0i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HCxd4tqO; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dvHilM0i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HCxd4tqO"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B06EE607F5
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Jan 2025 21:09:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.492
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YH-hqYvVRuFi for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jan 2025 21:09:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C405160751
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C405160751
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=dvHilM0i;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=HCxd4tqO
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C405160751
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Jan 2025 21:09:28 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TKtt87010002;
	Wed, 29 Jan 2025 21:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=bnziHzsRNvPhBzB/
	O3TKo2B5t5nQRb2xeUGzOBMV6v8=; b=dvHilM0iqUjwerJefITpaNjRzqtDetLU
	2aPZGEt+vSEsUorUnCO42EPmjNbJv1Xyl9qWcVcYt8oCmy+S8YISK3ZPcG4GigyL
	/w8+nAqP9+CqRRYsMCW+Py719QzXLWJPm/NlIMBTW9xrDsBtEF/lhYP/hgKTf8oG
	g3UILiMycxmBfVZFc3V/2XKYy6rcFkEH7ayS8EKC7M8AkIQG7R4HUJHYO06HH9WN
	K7qbDJL7tjJHHsPqTp582UubDdYFWJ2krBoei8BcPuBSIULETlJehxeCgzGR0NZD
	R7N49vlKX8be12KBqqa9eQXYtKXXABc2K54pqEZkyu9HR9cLhVlQ3Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fu9p85tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 21:09:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TKLfaV034111;
	Wed, 29 Jan 2025 21:09:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpda8wet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 21:09:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkDM7CcqV69f14nOQao+V8PTmnFClN7yQeVZRLmZzOf9oINCZe4l/bF03YSSa9V1FVSGWKlMSiGJbDErWdXmFM5FcnC3tc+rIPbwXXvxfrihmXs53gt6krTxzSyETGyxBtYZ4jRZr+6Ke3Ze2IEGAIO9HDVGzRlg9BsDOL6fjvTv7+1akPabQbdYKWVsMLGDEsNv6fnUMULjtAmjLRwEAWFfJ9X2u7I+A32cuh1Jdp3RE36ieHRZHMnx8b0yMh8AMHE79f0YUZo8poVxMQAKy9PeY7LoUCkYET5+qUW9WNWaasQhxEfdR1mGPnGtzdsMGp0uHI/wsowOwILZaDSs5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnziHzsRNvPhBzB/O3TKo2B5t5nQRb2xeUGzOBMV6v8=;
 b=tFXREdozP9symeV6Sl0F2ojFs6i+EZGTlfpfbwpFq752BoTv0jtCFpXOyEW2C2Pem6tAIh173iQBeilucmliP9rHj+IPK6MKWD3uplCjQWr+GeG7ELPxpgl87HCuXayKz690Te1Bmfp2jH9HaIqrqI8cgJCUgCMXbxh+OhZLOMGMSv9vGYSlpWZT4Uvz/Zk7r2WTn8lPdY8e0vC2XiEHnn4tFpkt6NjhnD6TaVVUtMmQuZRERr21ApgUztIDL4EL2ylc2Kw6FAXgUu8APDL1mhp1zwcR5MlWNK8QW73NAa6SWBrQinmuUjdqGmz+B/YPtdAXtJc+FqQGhPwJeEiAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnziHzsRNvPhBzB/O3TKo2B5t5nQRb2xeUGzOBMV6v8=;
 b=HCxd4tqOLBT2+9Bvi9IsYww4tcG6Tz6knJAKVVLg6f2WXY/drQykendE/EsbFE9ZpZWUHBxQlD7Tu20I/bQ9CGC8YXCX6erepqpiNwl5n65YmA5Fk/LtFPcHgvYwlvLdvTEqFUNeR5D8APMQw8iS2V5AvTGhuKEIBT5NGGuMR2I=
Received: from IA0PR10MB7255.namprd10.prod.outlook.com (2603:10b6:208:40c::10)
 by LV3PR10MB7916.namprd10.prod.outlook.com (2603:10b6:408:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 21:09:24 +0000
Received: from IA0PR10MB7255.namprd10.prod.outlook.com
 ([fe80::a82c:ceec:cd7f:8c64]) by IA0PR10MB7255.namprd10.prod.outlook.com
 ([fe80::a82c:ceec:cd7f:8c64%4]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 21:09:24 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, wh1sper@zju.edu.cn,
        virtualization@lists.linux-foundation.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v2 1/1] vhost-scsi: Fix handling of multiple calls to vhost_scsi_set_endpoint
Date: Wed, 29 Jan 2025 15:09:22 -0600
Message-ID: <20250129210922.121533-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:610:74::29) To IA0PR10MB7255.namprd10.prod.outlook.com
 (2603:10b6:208:40c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7255:EE_|LV3PR10MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: be0b978b-f347-46a9-c288-08dd40a93542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lQqpGQvHCSoKXkyLDzGychB/VjNATazVkGkbVZFrZ6JUkOyVbtU2RdkcNvQp?=
 =?us-ascii?Q?CwuwIZJ6orKbeM+UE2adbByToql1YRj2CN1Fx2j8irYHv7Q0Vf3bzsw5Vsx5?=
 =?us-ascii?Q?Vtwd39lUoP5iKdBpND59v5bjsCpOhTZlDGa2LMVAKeZXxq15hoTC57NUYZ5r?=
 =?us-ascii?Q?+EE17ClFMS25bWcd1B5mqj+MZkyEmPxOUN/5WCuP5g237/S6cpgwVIj5f7Bl?=
 =?us-ascii?Q?6C26s6R22iAvff16tLJxMdgfHFgoFJiltg+ZHK1uCxbGleKI8so3fo9m5u4a?=
 =?us-ascii?Q?b+rq3/NdQs7C4Uxkyf3d6YmUtPcz4BecngkN5f8B+n/NXL9VAyc881uROOH5?=
 =?us-ascii?Q?SzmfKirDhSMSWoKxxDE8mqaY5Br1RwpTW+a6FiyWCw/NZZMpcAGL7oi53FP5?=
 =?us-ascii?Q?bXIEaDYpmGizFr73JQ8ncGAJIXdc1fLa+01N+kiLVLyLNR2ibJBgqmZzG+p8?=
 =?us-ascii?Q?am5n0sqhnTipxfeHKOvYg+32lJHpn2ZUS33Kh77D+HfbJjGC2a5LQToVjCfY?=
 =?us-ascii?Q?UCw8uqleU77x2S0I5QJLKONfH3btqUpkIVKkHvGqyWPNwfRQqribPhBbMYqV?=
 =?us-ascii?Q?o9HtkFgI0HqN72vyrT25TeCeg93e1PMgn8iNjZOS5iBafU6ghlK/dEDKtHKl?=
 =?us-ascii?Q?PwQ5pkOidXsXK8qIvBHwCb8RmoCaev/ApAFXYEfjvR3j9elhRkj3Wj0FPYHI?=
 =?us-ascii?Q?mcoiL8YI+y9bIxPdZxad3X74gglrc/CHPrpFVAPLx/MHoY8AFtNXG2iJb02O?=
 =?us-ascii?Q?YDMWznunPuL8fExWLWcMNe5nJDADePWlCqB9wIbMDD8l3yCNtFNXTqFs2b9c?=
 =?us-ascii?Q?jfDYEqA0uMCRG2C96X4PkgAZbQDIBhUNvhiHHAzQZfGp1rWs/uttmq9d0J53?=
 =?us-ascii?Q?LRYCVLlKcSu65JzDpXPVNWz4xby9zUa24UsUc7LOmZBUxaQwKpAiXR+GszbC?=
 =?us-ascii?Q?1k0tyeWrjRFHcpXIl8+jJlEjSYZPezGjBIHCG221p7d2YdLte1bmlasgR4Ti?=
 =?us-ascii?Q?3kZk0wdoi6e+Np3sbWIB2AWBvUwY8mem/v92xMB3hkXrILapVwM5RJ9VNFte?=
 =?us-ascii?Q?d0+K5UcMQ3ppA7E6QXr0YKej5okpKq+1785QGDnFG9mnktUlbPE+60d76EHO?=
 =?us-ascii?Q?7Mk7HS/rmbszggET4KP+68PCrRW0CwqgGuWoMIe7o5LqeW0anR/ykFcDyD8a?=
 =?us-ascii?Q?/VnZwkapppsDlVVFp7T2WPTaoZjarGkfAEXd3MokTerFadhEQrYR5unJNURG?=
 =?us-ascii?Q?95FfbDFceUVTRrLjbl97W1aOGFdiFC2bSVCL+DMsGbO2LLJb52/WvY6bQP7Y?=
 =?us-ascii?Q?JNzjUnThMxlHmRYhCdeBtRuXeexcBVX+ZOgnELm15ZeG1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7255.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nIb4WYYmY/G7Tx1teNIpM4LLmyuun4bArOxzjqreQJc8Fuuz3fKV9+pt2ohX?=
 =?us-ascii?Q?VZVArQgaVelxN9F9hYykMoy38r7f9bBCzpqSUlGuSi6gPjX0HJlCw89T3prc?=
 =?us-ascii?Q?ppsQe+nrbox7QvtAR+xgcLeh8tVnvx7bmJtLE/Ta9SipQ6sGZ4xwFl72cJdM?=
 =?us-ascii?Q?YlGuZI5ep0dqKIjb44BvToprOTGqyrI5LxQHsoYEW8X3VjFZ92sZWXBl9eJp?=
 =?us-ascii?Q?lq405xD/ta8TmA+eetEtXv5luRq5TFipwuihEzxJdm6wsH4qlSxs7BB4BkSX?=
 =?us-ascii?Q?yOD4Gmy0K2qcCkxgRiuvg9gRN/DhktxkeMq6r6S2ZusBXyA1FWyIwTStnNIq?=
 =?us-ascii?Q?U/ktLWYpP6KNW7gnEMssnX1/psDNlz2La8q4CyQ15XOFMS3NX3hUgpUdSLEU?=
 =?us-ascii?Q?lOcal3LWfCMAk0zLICFS/9QSwVKo+t2ngd9MH7/uVfskfbWEkYvmHgdfm95d?=
 =?us-ascii?Q?VShx+TToPWtJRpYsU5ahXbtKHlHuuqwJMCZuDABVqhXj3OS8EAOEOKq1pGuh?=
 =?us-ascii?Q?0Gesu2TaEyY0oX/+JipyNac29l83duCijs55m0VRuPvD4UG+n18wZxAXPuom?=
 =?us-ascii?Q?Q/QOBN5rYf5l/6ZwIAXEL/0hDUZxmJFItbKNi9150gb0X1H7HQY6xl29Wjqo?=
 =?us-ascii?Q?yLq3yQ99GZ8eSolMhzy+f01NEsroyHRNSZLarTyXOfLnggve+IULzMZStmJI?=
 =?us-ascii?Q?rsAUrCsml1bAt1hSbE/o9kPkHwEX8t2BoHXJOH38MJL+eBtLD6JHkMpsHXTd?=
 =?us-ascii?Q?GjyvbAw3w2WlbqYJvwi4QO6Nd87QkFIhHiC/1J/l8pFsIFFaTlQiDDZ7uSDq?=
 =?us-ascii?Q?pDTEIQdNLWfw0++aZsvSYdN7XVuviSivGU0EZzA4RbS6H31sizzRyv6Tqd+k?=
 =?us-ascii?Q?mXnS9cErZGeVtsHHWCwjSfv03Vc94wj+qP5PVaJKf7TDvoFuhU5swJBNPBuy?=
 =?us-ascii?Q?MctL8URFf+KAVM8QWpSobD7s8LHoUJhTNtX0NXgEJt0H0U003jMHyfdBVCcH?=
 =?us-ascii?Q?7Ako+40VuIWNErBTaE/H0T5+92aLmNzJlTcgVXDPszfr+/xMxKBciqr5XqFg?=
 =?us-ascii?Q?8gkVnBDdAQH9AaKNRH4PXBiW3KTmoAaixhBkCfriFEit74xzeObRL4Lr90OD?=
 =?us-ascii?Q?uLJdOO7TZof+s7/zHGHnKAS58rhLf6tjO8hDJbXHjiZbJJrIOLfrTqicSJKD?=
 =?us-ascii?Q?j91PNQxHezN/b5DOzM+TrC77DvMcjoECHMuUAg42hOJRhxJLH5wCGL5ATK3N?=
 =?us-ascii?Q?xrzqysa2Rpyt+u1+zvht2C4TiE8w17FruYhl0AivTUnPu2QftYC/5fLLcyVT?=
 =?us-ascii?Q?LM9FZARNtS2Gpct6vuoGeGY8RX+s9ylfrLQiyeolSB1Z1N5mhQz1w1+KDP5Q?=
 =?us-ascii?Q?X85AAMQrLsJHPDud4dJoMVrW1s2RLayex7PDrfpQTwgaXMWQoR/5txyI5fh8?=
 =?us-ascii?Q?30GnWwGz/G9lbTT1ihRLAbpeJ3fbQGJ6PpJ5+RsrPTEXXIlNQWlXwmgIktSW?=
 =?us-ascii?Q?vZa+X3s4zvenfN4tHnwAdTnaM/7bsKaVpWPelevCwjrHQAlq8eLzkGrBWWp+?=
 =?us-ascii?Q?lyMofeRM7ZUfNKWvCaKsr3Rl0FxppZnhf9zfBo4sYLmNxwaCnV8aWBF61gD0?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QX/JLMVOeNIsFJPYcfEFRLBghb7At2kptwF6baU6/7oZsNN64u3hZsdlEi5Ueo6b9aYXdty4/SYvs10Kr42jPDQxAIKNubySQcTpxeDuNUid9tiQfy/hihLbK0JWAK2U2K5XUBZDhPVkhDE1Z6psNHiaZA2iGxAO6asnS2UahcQgh06ocDyZqFXq2lx9OCLID3I6hmwcpTDtGKdh88z721aIaxqUGn6s7ya1dnhp1ZfrLRQSIai6Hfc1197ZzbX+YfB7eIwSlTUSgffXIETGXkFO10/tNpvXOhoQIPrFpOVDfoWLC4ZDc50W1Ioxw3gLviZJ2Bqk6UoJ7dccijlBm/Banxg9LcA/qXD0vMSKQh+aTHs+qtSwCftnuy9gJK+/TvDymcA7pCXuwJgaYFtNXX4twIgRgWxnWDg+el7F0WEJcf94pxPtxG558C2v0g3OdJjyJbRw/+RfonjbEhT7HW2BmVOsb1z6FZG4ImPm3LeIFsPPIcCwa01TgI/bb0gOO29exhqkkFLOj/QW7FMVBBfEfA7sxScJV6AxsDN8Eb0jYSl1QmrpgpMnfxmfnXRJJ1F4T+v4klrrSUlEa+57vXpBFihx2UFg9eLvgqHG3dk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0b978b-f347-46a9-c288-08dd40a93542
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7255.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 21:09:24.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfnX1nlfhwZ+Ju/6BvKPqXv2APGK7rtM4AL4BonYlxniUXp4d1W5pWHNwJlTxfqOOnV4hbjfiEIvgPbijxi/k2TQwq/GKIXJjAH+Y/z8Cxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_04,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290160
X-Proofpoint-GUID: TXNTioyfgrUOqDEw-uaxDnA0Vsw_YbWx
X-Proofpoint-ORIG-GUID: TXNTioyfgrUOqDEw-uaxDnA0Vsw_YbWx

If vhost_scsi_set_endpoint is called multiple times without a
vhost_scsi_clear_endpoint between them, we can hit multiple bugs
found by Haoran Zhang:

1. Use-after-free when no tpgs are found:

This fixes a use after free that occurs when vhost_scsi_set_endpoint is
called more than once and calls after the first call do not find any
tpgs to add to the vs_tpg. When vhost_scsi_set_endpoint first finds
tpgs to add to the vs_tpg array match=true, so we will do:

vhost_vq_set_backend(vq, vs_tpg);
...

kfree(vs->vs_tpg);
vs->vs_tpg = vs_tpg;

If vhost_scsi_set_endpoint is called again and no tpgs are found
match=false so we skip the vhost_vq_set_backend call leaving the
pointer to the vs_tpg we then free via:

kfree(vs->vs_tpg);
vs->vs_tpg = vs_tpg;

If a scsi request is then sent we do:

vhost_scsi_handle_vq -> vhost_scsi_get_req -> vhost_vq_get_backend

which sees the vs_tpg we just did a kfree on.

2. Tpg dir removal hang:

This patch fixes an issue where we cannot remove a LIO/target layer
tpg (and structs above it like the target) dir due to the refcount
dropping to -1.

The problem is that if vhost_scsi_set_endpoint detects a tpg is already
in the vs->vs_tpg array or if the tpg has been removed so
target_depend_item fails, the undepend goto handler will do
target_undepend_item on all tpgs in the vs_tpg array dropping their
refcount to 0. At this time vs_tpg contains both the tpgs we have added
in the current vhost_scsi_set_endpoint call as well as tpgs we added in
previous calls which are also in vs->vs_tpg.

Later, when vhost_scsi_clear_endpoint runs it will do
target_undepend_item on all the tpgs in the vs->vs_tpg which will drop
their refcount to -1. Userspace will then not be able to remove the tpg
and will hang when it tries to do rmdir on the tpg dir.

3. Tpg leak:

This fixes a bug where we can leak tpgs and cause them to be
un-removable because the target name is overwritten when
vhost_scsi_set_endpoint is called multiple times but with different
target names.

The bug occurs if a user has called VHOST_SCSI_SET_ENDPOINT and setup
a vhost-scsi device to target/tpg mapping, then calls
VHOST_SCSI_SET_ENDPOINT again with a new target name that has tpgs we
haven't seen before (target1 has tpg1 but target2 has tpg2). When this
happens we don't teardown the old target tpg mapping and just overwrite
the target name and the vs->vs_tpg array. Later when we do
vhost_scsi_clear_endpoint, we are passed in either target1 or target2's
name and we will only match that target's tpgs when we loop over the
vs->vs_tpg. We will then return from the function without doing
target_undepend_item on the tpgs.

Because of all these bugs, it looks like being able to call
vhost_scsi_set_endpoint multiple times was never supported. The major
user, QEMU, already has checks to prevent this use case. So to fix the
issues, this patch prevents vhost_scsi_set_endpoint from being called
if it's already successfully added tpgs. To add, remove or change the
tpg config or target name, you must do a vhost_scsi_clear_endpoint
first.

Fixes: 25b98b64e284 ("vhost scsi: alloc cmds per vq instead of session")
Fixes: 4f7f46d32c98 ("tcm_vhost: Use vq->private_data to indicate if the endpoint is setup")
Reported-by: Haoran Zhang <wh1sper@zju.edu.cn>
Closes: https://lore.kernel.org/virtualization/e418a5ee-45ca-4d18-9b5d-6f8b6b1add8e@oracle.com/T/#me6c0041ce376677419b9b2563494172a01487ecb
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2
- Drop kfree that's no longer needed.
- Update comment.

 drivers/vhost/scsi.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 718fa4e0b31e..7aeff435c1d8 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1699,14 +1699,19 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 		}
 	}
 
+	if (vs->vs_tpg) {
+		pr_err("vhost-scsi endpoint already set for %s.\n",
+		       vs->vs_vhost_wwpn);
+		ret = -EEXIST;
+		goto out;
+	}
+
 	len = sizeof(vs_tpg[0]) * VHOST_SCSI_MAX_TARGET;
 	vs_tpg = kzalloc(len, GFP_KERNEL);
 	if (!vs_tpg) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	if (vs->vs_tpg)
-		memcpy(vs_tpg, vs->vs_tpg, len);
 
 	mutex_lock(&vhost_scsi_mutex);
 	list_for_each_entry(tpg, &vhost_scsi_list, tv_tpg_list) {
@@ -1722,12 +1727,6 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 		tv_tport = tpg->tport;
 
 		if (!strcmp(tv_tport->tport_name, t->vhost_wwpn)) {
-			if (vs->vs_tpg && vs->vs_tpg[tpg->tport_tpgt]) {
-				mutex_unlock(&tpg->tv_tpg_mutex);
-				mutex_unlock(&vhost_scsi_mutex);
-				ret = -EEXIST;
-				goto undepend;
-			}
 			/*
 			 * In order to ensure individual vhost-scsi configfs
 			 * groups cannot be removed while in use by vhost ioctl,
@@ -1774,15 +1773,15 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 		}
 		ret = 0;
 	} else {
-		ret = -EEXIST;
+		ret = -ENODEV;
+		goto free_tpg;
 	}
 
 	/*
-	 * Act as synchronize_rcu to make sure access to
-	 * old vs->vs_tpg is finished.
+	 * Act as synchronize_rcu to make sure requests after this point
+	 * see a fully setup device.
 	 */
 	vhost_scsi_flush(vs);
-	kfree(vs->vs_tpg);
 	vs->vs_tpg = vs_tpg;
 	goto out;
 
@@ -1802,6 +1801,7 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 			target_undepend_item(&tpg->se_tpg.tpg_group.cg_item);
 		}
 	}
+free_tpg:
 	kfree(vs_tpg);
 out:
 	mutex_unlock(&vs->dev.mutex);
@@ -1904,6 +1904,7 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 	vhost_scsi_flush(vs);
 	kfree(vs->vs_tpg);
 	vs->vs_tpg = NULL;
+	memset(vs->vs_vhost_wwpn, 0, sizeof(vs->vs_vhost_wwpn));
 	WARN_ON(vs->vs_events_nr);
 	mutex_unlock(&vs->dev.mutex);
 	return 0;
-- 
2.43.0

