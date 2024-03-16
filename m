Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1699A15B7
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710550046; cv=fail; b=ItD6vqikTEBHvJDtExJfgfMJh1vARXPZPJSK1ZSommPKvV3YRIYO1AYmkY0XufY06Cf6sRmiYd1FC9/mmdz5iuQcq4taHKokHiZPVPxn54IvqLQ3FXh/EK+mU+k+yIBRK9WlnyDDDCZXShnBhsJ+0Llh1UEMiSF+/UFdyNY91do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710550046; c=relaxed/simple;
	bh=30J29AcuhdiVqZQbn9OHXGmt2N5d4F+cOHpObU+0pU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=elVLf9LyVaaUZ99zxOqhq775s0ulHN2xxR2GPWVQhXeLPvWn9HRLEgJke4aa0CZ1pBWATNWNE8LuWyhxRVN/Up6bGMqMK8BiZsf1QNSkGAc/pKSj9qXqldxBUXVRTEyrMmjACVXA0cf7N6I5wWYUdHs7LVw27eL0TgHYJUH8aTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ck7CCSAL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j82GXtQJ; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ck7CCSAL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j82GXtQJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99C9141820
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E9msCfDzmxDN
	for <virtualization@lists.linux-foundation.org>;
	Sat, 16 Mar 2024 00:47:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9F7D141812
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F7D141812
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=ck7CCSAL;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=j82GXtQJ
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9F7D141812
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:22 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FHEgJS004952;
	Sat, 16 Mar 2024 00:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=+Pcq1uY5GaKbC/b4E462OwlH2rj4ifiS/IPl0WaKeis=;
 b=ck7CCSALT+oJ/NxWlLBy+AmcO5R5KAuQ+Ud7bGlZN5UAQ37KkodWA/PyFa6E2PccUlpw
 RF+ZEh3hYIjrgklsPXXNrdoyJdt29Hc4KLNBORGqEkbqzArPWIdeSORHkOtZOJ9csMq1
 WrCs5aG0yU8rLQnY2MHieRFRHQE1RFjPMc2BCqoKAdWVTv2+KYM/PK7h5n8Y5+JSQUYg
 rEfiiY8JxKUOlLxudFlLUdY88UBJddgMZ36PoZYgCH3I25bBeo7GWYoKBYcnAF1KBvVY
 o2fcWOP6v6pJMFdF9oosQ0xtXiuDRyfyvGpN37EXWAXy2efSipp6ifRswQwzYCBlgeXN 5w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wvtjagpn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42FMbJ88033329;
	Sat, 16 Mar 2024 00:47:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wvt97rfmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQLnW6FGxLTiCm312apTAWEJwXdJO0A0q59PuXffg0ZjzUvtQVPSvaYcIfmVRtbYKOBnVvIodsVtMbmsqlnK/fQM4b+zVCDdVJZ20++LbE8jdDFzItlbYPnH/z+/VXXJOneVXqC2yUM21uJZ/EgSVHzz/t3zIQ3YD+Q+46BSISCthZ/hRZHZ4noLjogMVirnVXju6qS7VnkoIDpjOZfVjqkRwjp+oua/5NciUlqLLMML2KOChkzMnVp81nooVWTMsj3JZqDtzTEA1JcqjtTCupTp9WQkzfhBGhVgndrnB8Ugt3+76vxT/UeFbDd6uQmgwH5d9i0o8Rq1VYKaSYXqSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Pcq1uY5GaKbC/b4E462OwlH2rj4ifiS/IPl0WaKeis=;
 b=IfzxKHu30GWT9eHQ4UdJnm0VC+sanpcLlujdtkb7KdSnm2CegOw81VRezHg4FHP4pkM6Mlr0i6LscjO2d3Jvy61nItwPCYuy4L4tT9yaiv0lOhH68gLP0S71sXBP2bjSql0wedY3Y2JXyO5LVdxUg77RkO5RxS67+aJrMvDZicg4RYSlej2JoV0SCk8CZJkPxTlw810+RAZQnjGq2oQgl7POZ30mf88Ao7eb2u2J/JTdTwB6gsUBRc7nTrHEV15v6H2DyXjDGpDATg6mhGlVilJxygVRMB95CguriqX20QhNa/f5UZ9qV0TlZnuF5Tu0EAMu/C696C/YtN3hx+DG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Pcq1uY5GaKbC/b4E462OwlH2rj4ifiS/IPl0WaKeis=;
 b=j82GXtQJUhHT7wC0OZLtj+KWwotFDPht8HB+u1G2xmcFoxVMoFX4OOZVtenE6kEkfIuwIn4JVCKFfUm0PoN+m7Hdo7mxgb9HMxn6mdQW30HXN/p52KkbtlqQnqgv7siP7GVtwkzknc9+ky3ljsKHcVvZyQVYSlw3q6ECv3BKYR8=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH3PR10MB7120.namprd10.prod.outlook.com (2603:10b6:610:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Sat, 16 Mar
 2024 00:47:15 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d%3]) with mapi id 15.20.7362.035; Sat, 16 Mar 2024
 00:47:15 +0000
From: Mike Christie <michael.christie@oracle.com>
To: oleg@redhat.com, ebiederm@xmission.com,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 4/9] vhost: Remove vhost_vq_flush
Date: Fri, 15 Mar 2024 19:47:02 -0500
Message-Id: <20240316004707.45557-5-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316004707.45557-1-michael.christie@oracle.com>
References: <20240316004707.45557-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:8:2f::21) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH3PR10MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: b103e683-53a5-4d98-8a9a-08dc4552a031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cHiQrJ9kRN8uhBaCeV8TBiCB/NJauKX5fwh+xeVDkXBLCq4ew2eUbRcAkpMS+b4r8IoRKHYT2YW9ApePs1qSMCBrn26hF8K4WQdoS+EJ/RLZdVjH2WiSJCaQgJQWZCclXB5ors321Jw2WZ5EDr8FiQpXcmsImL7v6UJKE3i6xO/9ucbvMJzIHXQoNsvUNR/As3lUKQms9Q5X0dnpgBvAd+vDra7wuISCKMc0P7t/Uyoxz6XjavVR02yN02SjajdF6PXOTyU+K5pP5CnhNrJwKrRK+yRaP53npq453W81NkL7GPnSjDlEBx+VaCGAU1lVMhO6gpVKHPuTDGd8wcZKzLeh4kymT+3/EXdNSgiA0HrfLghEk1l2THp7sINpa0f6/Fr25/B5TqkOX35nu03jRLfStdIkAJkXl6T8ZDZTVrkBEaWWFN3/z2oYoi1wihMZ30qzoFlCGWCDa1tWL+kbLhJaXMzG9vQuRFrgnmKOTAdY7nPPBzvU5ARXUO+KfOhVZbEQQpQ6SCuVz2Qeink6Z/cHBgfXQWPasp7JzS/vghxGql8JFvybGYioObGQlzmZSEqdHDBjDMQvN3XXukRvLtaf8ZMjakFPSKqmYMveVoYEHe0UruY6xYg0jMY5bokBZ3O17wmHUS8d7o+k+P66fc47fY2EBJIGPoh5MiE2Z0M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zs4g0CTqlPkgqVUEWwmUB87lWFx5Be75qio4o83W/bdVHYO/NS0G1o49Tzui?=
 =?us-ascii?Q?EKw7mo2rVdFphMdpzPLH0o6a2UlHxnGM8i7yHyqJ5mDVfa8/8ZH1kDnI8JgZ?=
 =?us-ascii?Q?eDOKXfUGehDP1hODjzE3Lpk53n5Rum8OW3JFyOBgyjzqRboq8/UVrys7G/II?=
 =?us-ascii?Q?+SPEtObJkSZBuLhYACde4UlhUVkeTmYWba34nT2ldIrw6Uno4exv/43BV6vg?=
 =?us-ascii?Q?mV82IMtiok/XRmzGl9zse3sAaAP7F64DQFACYv+rwd/eBkwNcMz4PCGJGzFQ?=
 =?us-ascii?Q?LKnvdcMNnjy9NKv/xRRRam8crw4X+5st02cBPeH476LK0uUM2RH4Nje90h68?=
 =?us-ascii?Q?1JtJfO6e8wuT1GyxUsTNJbzpI6UufzibZFEIjAyHXhYv+IqEbjvWOlT21qOI?=
 =?us-ascii?Q?jjcTCoJIPU/Z02MlxX0DU6+iF0OZryigdRxz8Pd8/d8mVyo+JuZDYGewZFbI?=
 =?us-ascii?Q?8osvibC7rOYzESYWJTrNLdzEjN/ci2BOb2kn7FPbm5Y5mpLF13St+33dYuaU?=
 =?us-ascii?Q?oct4k2um3Bywi1jTpleCz5iGi/8Fo21W0K/u3g/aEKFrmT6/iTr+462BmZIB?=
 =?us-ascii?Q?C8/NLnmuwkzoLUPCzgy7caZVdPVbNiOt1c9D0gSwuqd16NQDEw7EPyzDynGN?=
 =?us-ascii?Q?mFlWxSfovkXszHRGocEaxAVk1wEzV0hyBo3gvPJIlMZRNkVqNG4vyTzg2LSD?=
 =?us-ascii?Q?yyOzQ2Bq9WE+p16C6HEyDDLo4EpxfQstaHf0YxjfSiZ4ASzTDqXjElRpe65p?=
 =?us-ascii?Q?S+hZ4pFssAy5qXE9YSChf+nByIK2CRlZLuS8g1avFwcGdMb1B4LuyiLxwtu9?=
 =?us-ascii?Q?GfWKxGiiQ0dx8aVNK7ayv1RZFZ3A43kSWxuwi0Chz6heOQn1Mvye4s9Mzof8?=
 =?us-ascii?Q?DAFqoFHiFo2PrfoIqMBPT0Qpk7pdbTwenvBmFabCVFeCQuXlhKiX9xJE5RK+?=
 =?us-ascii?Q?OYYLUiDDdfgA1aSbgIe1cmBOfkn/cFpfk4L0KQGXAgLe3acyo0K9q52yW/9P?=
 =?us-ascii?Q?CraIdPImE7+/oXCik12gO5KaUladEEieynj4c+sXA0zY/d110J6vxmGlOGpv?=
 =?us-ascii?Q?WZNRVY4w23nbqnMw2VnLl6d5HNlD/lCEAMZEU36EXuOzmS66Ta0I2oe038gF?=
 =?us-ascii?Q?pupukTFgxIIGeh5fbto5LPaHH28+gkWZUEdFeKxnrA1iQ3ruMGTPaIInerGH?=
 =?us-ascii?Q?GogeGubkr5ChHaYdmsfWm4ZQDY8gls26PQGdx5gG5OOYPoXYscwcC+GhhU9H?=
 =?us-ascii?Q?fzL4eN0+ntjVRKyIeRHBIPFhSDoy5KkqWbeZTa1fQq21SmFF3IY+VqgrLBSv?=
 =?us-ascii?Q?rBlmJyDI7YWEHG8f/xF6jBOrZpT6BkRtAMnq6om/GkOAfZ8vYYvj6IuNBD1n?=
 =?us-ascii?Q?QNveEz6QbL5BT7rViJ39aPlm4oV8u5p+gKbhOjfRfHU9gyDzyoLPaUuIVXKV?=
 =?us-ascii?Q?1nokmF7uy2AzyPbWYJBK+EeFCM76/yrufX1JIEtCOn4h9IvOsFc8OPbDaA79?=
 =?us-ascii?Q?iSLTBtQ07sWBr/GFKWJfP5ZEAXcIvPLzYFh2ImQKzuAfl1hiq/oH54nF7gJJ?=
 =?us-ascii?Q?gXnVtKNF/jtn2OkSP8YXGj9hbNVKNTBbutV+2bsP3LWSufGkqBaTy3ftyZQW?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oVHRGZlnHZMG6GONq8guGCPGqEL3Xw+RyKsIKunuHdF21pf9IQXnwBGJGcQEvLvG0ibOrh7Hx+zTHdBTVfez2OHkS2/+8DacOivWALw0Sw+YCm2KqJBDwyTRUP+uFIUr5c8yYpTd94qSNKag79SkwWxYoNcWHJLv7cQS3LWaMyuSkqXrwGHb4Vj7vgk2xLIHLsPq4YnSdd6IQv2uqMBybWtK+WSh4ve3NAd1DRhW0xEgbc4trHaEJ9VjRH0aWn380FKJ6ajwEhjEREFFm+PbsnUzIbT44FfhlxG6JGgWaCLJp8KopcoZ7BtDvfxGKPwPgvHnKytGJVOGjCam7IS0tY8D8Y6BvPP5m1bU4vMqD/DwTz6N+mnbqVVvWGvfdpu6sKqNv9Ui6EwnA3OUTKpp0f4G+lwxY6VYnmBwOjCQdeNa2IGmsOvXmHfs2YUPI+n4zOu0SHQesvWW+wsNFFzYHmRqXvmH7KUbqV5Nn/6Fr5bKSjW+duQuhmTy1gG9z3IaesVOZnf8+Z33J0W12v/rkSLWPrp4aeBON9H5D81HmtUr8lXfQl63gkH7EY53BbzXye0GhBrjIG3mpyvSuKOevNIzGMv+miN3GobmCjEWvf8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b103e683-53a5-4d98-8a9a-08dc4552a031
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2024 00:47:15.7872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFMYkUUlVRC3NKTFl8uyK25avxqsOuCvC93NqusGoEUhwE2xEx2g5lBBeQ9IOsBUu8Y9DHo2ljqo11DBE3JbJ19W8kJJxvLXOtU4CDax89s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_08,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403160003
X-Proofpoint-ORIG-GUID: bZjVsfZdppRwW3hSaYTedvzVztak9rtR
X-Proofpoint-GUID: bZjVsfZdppRwW3hSaYTedvzVztak9rtR

vhost_vq_flush is no longer used so remove it.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 12 ------------
 drivers/vhost/vhost.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 045f666b4f12..cd79075da294 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -263,18 +263,6 @@ bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work)
 }
 EXPORT_SYMBOL_GPL(vhost_vq_work_queue);
 
-void vhost_vq_flush(struct vhost_virtqueue *vq)
-{
-	struct vhost_flush_struct flush;
-
-	init_completion(&flush.wait_event);
-	vhost_work_init(&flush.work, vhost_flush_work);
-
-	if (vhost_vq_work_queue(vq, &flush.work))
-		wait_for_completion(&flush.wait_event);
-}
-EXPORT_SYMBOL_GPL(vhost_vq_flush);
-
 /**
  * vhost_worker_flush - flush a worker
  * @worker: worker to flush
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 9e942fcda5c3..91ade037f08e 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -205,7 +205,6 @@ int vhost_get_vq_desc(struct vhost_virtqueue *,
 		      struct vhost_log *log, unsigned int *log_num);
 void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
 
-void vhost_vq_flush(struct vhost_virtqueue *vq);
 bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work);
 bool vhost_vq_has_work(struct vhost_virtqueue *vq);
 bool vhost_vq_is_setup(struct vhost_virtqueue *vq);
-- 
2.34.1

