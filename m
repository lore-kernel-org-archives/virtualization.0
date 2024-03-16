Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3358B2F56
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710550050; cv=fail; b=TtP3RZZGzCFyB9jlsNXK2UOdAuiXXQ8UDKq6BEQdsXb7QkWCbqoLfYB/IGkg6AjX6XO99H5ZmxrTmoYSCLvww3bxzYwFTr1S1D0tnzbZHsBY92bjGdDZhFyQR0iHHJprLtFSz+/vITRZNCKi015bLLSOKgB0MN6RClss/FGz7pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710550050; c=relaxed/simple;
	bh=kIoXXYZti082jYJ9s36E1+MkD7go0JPKk8IoTA2gNSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=igmd33Pn8jw/pi6V+g24Hc/wHyCtnKNphz2fp7t01Nca2Avn0HSuaKfJIjpfEKg5lQK+8ioA7SenY5H47MkGWC7bSoryNbIWBTq0gvpCjEfEM19IhayvPwb7ao4BPJfFRMoakBX/TtxFsy0VlEku4khIX4hwWeIjnQ7PA5b4nVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KE2+J3ZW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xHrQ6l6M; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KE2+J3ZW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xHrQ6l6M"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 726BC4036E
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.798
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ic86e_oIWOTz
	for <virtualization@lists.linux-foundation.org>;
	Sat, 16 Mar 2024 00:47:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5107640191
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5107640191
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=KE2+J3ZW;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=xHrQ6l6M
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5107640191
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:23 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FH8x0r014193;
	Sat, 16 Mar 2024 00:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=LoGTz6dfI+T0GlJ994h/1mZCvr/IxYA9MC+4hKChMLE=;
 b=KE2+J3ZWUV48x3w/YLKSa0Sd5VWlIZzPROAKd/L6rIWCM8JFC/prcBBashc8aas9oycs
 diu9lWorJUHkRDECMmMYvi5b3gpPjdGBM+e+xWTnNzCiF3DJ1EJtEUkO0TsL7VcONGHn
 cv9/V8i5h+bLFAfK73bwBheBe4pceYamjLvaDmZfz/gSuWXFmWpPcSONMGeVU+k66rc6
 +BIyI7DvvqlXXAcdMHYS1uoX11m6weXswXPNC4uwdT34qFLrA3j/IUol0R1BSuMR8+h3
 K1Fnhok5WTggtX+gYj2N3A/DUqcRCFipVsVWRz0gX6naD/tPVr7Tbeq12HJ7JQ8HcU9M rg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wvswbgt9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42FMbJ89033329;
	Sat, 16 Mar 2024 00:47:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wvt97rfmg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6X75HE3jFpEOCRwuoddN7zPR65Vv20EvPDh761+4VsHCiKgy6tKYhKrsG10MH3nGGlK1JQtPjoNu5an3zDD8re63OK4YmRt64IH9wAcj5R4slOPlECw8RHMS0iVb5DnwxE9qWWvyY4KzTin63IrXL0ayy0PfmwFLEGO2kzBJMHk1fkK7H+5ywW3bU5jXYd+cb4e2n7DqZpZaoaXPLBxRWv7tCDutQpk02TaHwZdEZkehT72vEMfe6CjC52KBFkBhqQypzpWzNQCPqkhPYrW4CVOt43SEyZk0eQ+yLJIyQigrkVNdRlDZl06eUTmnDTnwuGCuuvOq3G0y0J4mpmwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoGTz6dfI+T0GlJ994h/1mZCvr/IxYA9MC+4hKChMLE=;
 b=aJwisXdrOy62yVTWbJ949OzIvrZGkNvnGmi1pRdj9d3gtRCVia/47/yHS3qlLZZE+jYu/k8VKXhxWxJ091gknQUe4KZ4frWA9wbVqcP82Ay+gKEmPnUynoQcG7bcMakRPCqvzUVbGfXlgcOaMc5NEml2ArZiQF6hdxjaix0rw/WxcZjN/suCuOGQm2o0uI2+tsINBTPNSEQDoMyRxlro0bs4C5y/LXksgjqpxeUes6Z2++hi76fguSFHAK+nVL90S2OKtFsSuYlXnu+dpLhTmSvRn28W8F+yN9u+KB6Rd8QtRiyK8bXchO/YW+CTplki1LBag7OVqyClBt1zQ0rgzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoGTz6dfI+T0GlJ994h/1mZCvr/IxYA9MC+4hKChMLE=;
 b=xHrQ6l6MT5rLQ/OG45RBdO/bae6kjUtRJ49N5RtQDWri2c6QEf2yqZBsHb5ZgtJ4Lz0gUIlQYScynhXGQioz/L3gLlYnFnQPtSnqrpNxFVPJeSsQAvg6YG8mHIBGfsZFLuE3Tv52V3aqOZkxK5HZCEE2p60E+MJS1wrxOY2mpk4=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH3PR10MB7120.namprd10.prod.outlook.com (2603:10b6:610:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Sat, 16 Mar
 2024 00:47:17 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d%3]) with mapi id 15.20.7362.035; Sat, 16 Mar 2024
 00:47:17 +0000
From: Mike Christie <michael.christie@oracle.com>
To: oleg@redhat.com, ebiederm@xmission.com,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 5/9] vhost_scsi: Handle vhost_vq_work_queue failures for TMFs
Date: Fri, 15 Mar 2024 19:47:03 -0500
Message-Id: <20240316004707.45557-6-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316004707.45557-1-michael.christie@oracle.com>
References: <20240316004707.45557-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::7) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH3PR10MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: e197951c-1f84-4d23-63da-08dc4552a0f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KQzQUKJZT67iveWOL68j9OJr+P0l6nZY6QTgdfn8wtYzfjFNZtPPUl6tWZ1m6UhQQi9HqofEXoL7G8v+jFUpOzB6KYaPBTXDQDC9uYZjaSFOKxPYYEBweccuoTSuJfAncGNWzOSFbq9ELEfnQLOKgnG2lu9JCHKjvhHUvGfoowYr0zCKRNJ7NRHDYViS0/pNtOXFD4Et055jz6WkY+DvU7emI015upRYtPAjRDIeQG0Yu0NsdbYhhHIpeYXaK3KGOGz4l8KSfCcAjKdVzwQUr7o2KO8TE8RNPfFuJArk9mv9hXRMXwcHAizpGRaHCGRvXYriXBJhnZWJjbyWrOqMFLHdpblxmjY58FL03XZFX8tzB4QaGBwnb+/tn/78m7iGdkYEOgqA9HFE3ReuAByIMCW0cCldnE/zBbyGkaRSCGhRIeqO7hC1qJ0eg5W6uoKU/N/Y3/kg50bJc7+vxLyTxd0a+xYydPxnfBBXpv1E8wuE846qxGynuvZQgQc8gUFfWkDBP803g3x14tyRX26XmzZpmKEK/ZSEegEwDm8gee6JsJQ4spuB8ocY46t6Iylx7tK45t7ynpKJ+6cj9pTxgCzeNDp/+1ELVsfOY1nARf3Ns2WcNStiSrldzSZq4ep4vKWr/S0ovKKTEFlq62ANVS7LYrMyZVEBfJjJVTQGlhs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DH3Ky5d36/bs/sgz0ewFgiGT6xrnHtO87WqhUJpQfcTq4zouNgUAfO9BD6FL?=
 =?us-ascii?Q?MgCe41NV4fo/ig6oXMeOWZ3RZOjvBGNDm7+SXfw336ZtZwp6ReA+wh/njbIA?=
 =?us-ascii?Q?Xj61bmVPMJfymhidWyGlAGsk6YDAJriPsWFmDCRfeZMxvo7HHKgF1Y+EXW/H?=
 =?us-ascii?Q?QtQpc+/16K8MhH3w5Tez0dOujTg0x4EPRN7WC4Lw8xCMeMTH8h6ElGMwhr8g?=
 =?us-ascii?Q?HBmtnmOffxYJJQ77OD140egP/Oo57pIR8E3/0t2yCAx2RvjOg0KHlpqm3xl8?=
 =?us-ascii?Q?9vUmW5C9B61Ydb27OdHUujaC73hu1NMYAIr9ILx9ihqc8blnlKVI64LPmdQD?=
 =?us-ascii?Q?N1xGZ7qSlshoqn0FITeW0S1LtQX0m+DiSBAys/f7gBegrwK09e15QMPTsGaY?=
 =?us-ascii?Q?b/6SdTTzZ8WuNQypC8K0YezvQ4sGHX1ywecbUSTW7FCyaoxRurgJLzS9CT99?=
 =?us-ascii?Q?0n/2gAwAvc889tjbATsFw3YRXRcoB7yBXdJmYmO+714nmC2kuMa3zYESF9JA?=
 =?us-ascii?Q?M4DJLyXEissUNNnqHgBlMuIwyFocVtfoKNx5uCgN3TlidA6Pys3UteHs3ZT0?=
 =?us-ascii?Q?ans7W2np+fu/Z4qbT3ZdIZ3vjTdoOECM7RXLSwhaMhYZKMJQWvmMy2ryHXCz?=
 =?us-ascii?Q?NS84gbJJ53uEspKyRpfNvERm4UlBw7bzgsay22RNwwSzIt7IQAp/ZDlQ7w3o?=
 =?us-ascii?Q?627HuJKO0m/HdzL00+IfrXFVjbfhWSppLtLnH5DoJg+MnNA81UwagRhsm2WJ?=
 =?us-ascii?Q?4q7JXFmjXcRMtYSD9FGthsOKZqMTezUsYPHmTv3cuXZjjj3w6TKUl2yoxjVF?=
 =?us-ascii?Q?L9KIeL9is27FkMnlE6SKUuvyRzLUQVZ+jWb8dsc5BUrXKQmXnlsazE8X/j0u?=
 =?us-ascii?Q?XJLbGrWjtnjaVEdtijiAoO5J3rshuGfHTh1oRv+XbGvJZ4dKGraIhQTDRCa5?=
 =?us-ascii?Q?nXdrFreUBOLJFS35d3FOfyHrK6/QjAfjU8tUBsJ1yvdp0EuMxU3PQP9dQUbF?=
 =?us-ascii?Q?EYi8E+GZYTfmUyTbA6NHuFtzK0Qnnn7t/1cu1baLqcy/4ewDcpHxnAHvLcw2?=
 =?us-ascii?Q?0xxAkr6nENXbZkdtxGCh/dbP/giGF/vNNTChvkeMFMfqpbcJTppi8xl3y1na?=
 =?us-ascii?Q?zo6zT1As3rxNzeXiOECMyAF9P6BXONp7AKJNX3kuTo1hfIYFC5loUcJE0/hd?=
 =?us-ascii?Q?HgOWJKQdmQ/Q6yL7bzUiIl7ZleuGdhK/X68UAxw+u9HwNSVKWFHAL/VsYLje?=
 =?us-ascii?Q?udgGudmAZXaVnpa+fip+x0FWNNp4c01CH8nBtewGNVVkA9yJnj/VHzQsnyz6?=
 =?us-ascii?Q?Og4ODO4+QP87yY8MSmWv5tPWg6vSBR99wawBd9J6XkjRs0NlERdSFxXtnFRg?=
 =?us-ascii?Q?BKkA3hLLscBtmUpfPSeovVRK7E9fJ6cCis3N5lkQfk5bTN71sla3FzDSizBB?=
 =?us-ascii?Q?HPgRsKb3lSVrYPxqn6KeTMVSodjpOGZL/l3HVV++xMX3zPqQinwglFmDEsSX?=
 =?us-ascii?Q?8UTtteCqWTfKVa9at2eqxshFKBDo1XtDIbhr7venTgzF9ohFlPd6NtnDi7IN?=
 =?us-ascii?Q?gRYk44Kf5/cRAzTygwS7DJ2jduJYiVkWTS96rntP+uaT3ZRMfDaFpiRhbWMn?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	waAtaIt5XRGcQUPBclHDlVeZfuJnQUAJ8VEM5/MhgsEsu1Ro5F8zkhwnK6pUUyD7BTpSPZNOvdjOy0gyFXyQrRguIqq1nxd3WgSw75WE7LQVl++y+gTQ1g8LANtJtTbZgfFwn2jjCtNte5f7qzned9rXYTwzYrCivyZ5tCdhGuAbHSCsEExNx3W2XAI7amSUfgDtct7WpmypxGyiAnmqG22dotDvkuIeRzWVSXI+HmzXRveUVZIsRKXP4jpK7jrU70F2JlmaA3vQqOJRISH26cdjNmg4+JHzJXYTClNGwgZiJZwc8vJLIBmtRX51Vadzm9p+/x665bcTweXIqN6/RtmIoNObiJYirnQNiNwwuqwDYGBo2UCZSRPcibdV0btNECMcgMGKhjPM/eWbXtV4+8xwybo0p934vp3d1Tpaf6EFfksgM6W+XXOhEZRHQRRA+NTPYHj2gNbA7YrUbWBqcpFoMiayia75JmmsU15LlzG4X20WmUhzWBINqaPazbIB4lUlGN9jrNsLozoZCKr96SDQ7Tz/i4WK/i+agFycEzDcJo4uHowQgOPrdQuMADL90aKOdlxLGLjxS+e9X3e7toG806x1arDdnYSqTJI27t4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e197951c-1f84-4d23-63da-08dc4552a0f8
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2024 00:47:17.0905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoM9WJOywpTUOvAdwKnR2PiZ4Ld3OWfM42jkXFJ4BXGFS0FRZ/4/wQGtQMM5acnKk9UlcZlgiPQt5zZCAy0K1UWaux+0Ndi0RzFDIwMrgQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_08,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403160003
X-Proofpoint-GUID: _n38tyORdd-iaoFbLyF8Xz_B8iWitw7w
X-Proofpoint-ORIG-GUID: _n38tyORdd-iaoFbLyF8Xz_B8iWitw7w

vhost_vq_work_queue will never fail when queueing the TMF's response
handling because a guest can only send us TMFs when the device is fully
setup so there is always a worker at that time. In the next patches we
will modify the worker code so it handles SIGKILL by exiting before
outstanding commands/TMFs have sent their responses. In that case
vhost_vq_work_queue can fail when we try to send a response.

This has us just free the TMF's resources since at this time the guest
won't be able to get a response even if we could send it.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 04e0d3f1bd77..006ffacf1c56 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1309,7 +1309,8 @@ static void vhost_scsi_tmf_flush_work(struct work_struct *work)
 	 * send our response.
 	 */
 	vhost_dev_flush(vq->dev);
-	vhost_vq_work_queue(vq, &tmf->vwork);
+	if (!vhost_vq_work_queue(vq, &tmf->vwork))
+		vhost_scsi_release_tmf_res(tmf);
 }
 
 static void
-- 
2.34.1

