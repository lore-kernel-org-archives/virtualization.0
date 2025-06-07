Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599161EA7EC
	for <virtualization@lists.linux-foundation.org>; Sat,  7 Jun 2025 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749321239; cv=fail; b=G4sjxie/5vyFiHNOowWNtDdh2i5ULRNFRBl8s4TO0H1HWyouyBTw8QGota32yVk9QzSt8YafcbDZzTViZLmkwuJ7FrohFHnZ8vGYMdPfyNzBhkBk9wkIx5NQlNDIt2Ee46VRYxEPDBTGK6lf/sQhVf2ks+KcIsOeDhwb0jZ6NYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749321239; c=relaxed/simple;
	bh=6d3noVjYIuX+CtKhVXubkHw9pmpPBVklXEkrfYGrmm8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mQ6wFbVpOAZcdcuTVHyeyoUcs746YRIsO46Zxs+yFB1c4l4XsfUe3KXhacmWZpadDyQnjPQ2nNbLdQy8Fj3j3PvtrqdS3OnSGj1sKlj4TRrETiAlzJE4EitUzv74Y48Hv3jQKKKcJopp1dBtTV31RwMdIyc9speph43oAA1Fjis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kMmGJaTc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=omBv9Jri; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kMmGJaTc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="omBv9Jri"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB5B1813A6
	for <virtualization@lists.linux-foundation.org>; Sat,  7 Jun 2025 18:33:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.489
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I8VvWQ2ODJw9 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 Jun 2025 18:33:57 +0000 (UTC)
X-Greylist: delayed 4534 seconds by postgrey-1.37 at util1.osuosl.org; Sat, 07 Jun 2025 18:33:57 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 19DA081384
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 19DA081384
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=kMmGJaTc;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=omBv9Jri
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 19DA081384
	for <virtualization@lists.linux-foundation.org>; Sat,  7 Jun 2025 18:33:56 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 557GLeXT018468;
	Sat, 7 Jun 2025 17:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=R8AKU5yYK5ZBbmtE
	0exPuaPtx2qwYPD9xYI3a7YNfzM=; b=kMmGJaTcvJVWq8fwDYTYeo9oJdBQ3F7x
	EsH5kuqqe2SuWqdv5IUuyWIcfslqs3pSOs9AU7WZdCYHGbV8nNIZVKe85IKdl44o
	Hc1cNlljBylJkP2dJN4/5rck+ScGys/A99DWDUh57tZd5Dsbr8Dxq0cMAsUAvRsf
	QFASr9hWbnA6vHfqaGm7ehPEHLZMX86CPjs/ZB4oUChWxcaZxq2bDqv5e74pM7GT
	nT/DUeIsLqg38q/CY26V5VtuhLKvooVleY34xknGEN+FLIC8uy1HXLPA8QYGIXXb
	kJjmIC9jnzCIyL730xGSoIhQFJQk/aTTBCs7+Hs2QqrDKG4FIyu17w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c148d7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Jun 2025 17:18:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 557C5AqM007498;
	Sat, 7 Jun 2025 17:18:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv5vhyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Jun 2025 17:18:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijXH5jN9TIIk/uFFZyzbC9r7hVBVFmUKZbYsKQwpmDpeO8qkvWTlquPae3EWJliAFn1TvB1IbSYBS49+j3+1KGF5CUiNMBm99umMmDrgSlFQctEHQKoON8RHHnZgQTHF7Jmww+DFgF8TH3vZtwhvJrRJAAMUUdxA4GDEwXvFiAHkL8GgGpVAz4WmE+ct/AA9LfJ7UqL6G+/02XWlXgHE2UejK8l6i//cuwrPeBCf9I5GBmUqMSVv8EdldDlUOAtiuKb5LxiwtNZhXX/vMZXQ3jsIFrpjSW/F5EnwXMcuHsD3ztD9wZCxPgyljWKDe3r4AIpbyWCbvtvl/HWNoKr30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8AKU5yYK5ZBbmtE0exPuaPtx2qwYPD9xYI3a7YNfzM=;
 b=JWJTzkhs6P+q/IiK4wvEY68xcNP1lc9XovG3jGKAeOgmipbALW8qx476fTuz4iCBnPV1g7qBsQxP85szuz6vu0s1FmXyQlwxw5ZFbCPQw23SOgwSxf9l32paGotJBcEw/3thEtL9oJypo6swJcIPDAvEXn2lP1FaWagndN+7uYLlH4kXGOCcniLBDeTahHLed7Kw/chWX4XTVXSm1NFzenjPOFcwSe2cMgASLWQOszomH5f2x3uqAuZHB+ofmPfkU6YFDdfBaUBxWgtjKJLrFA29uoXvs+lUN746D5/4gm55icOdRIf7kIsEyXNWBlsapvn6Df5e7g1RnAeqwX9YHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8AKU5yYK5ZBbmtE0exPuaPtx2qwYPD9xYI3a7YNfzM=;
 b=omBv9JriLJnFYV1fIQm3xCat60byMAi70QFbeLPFpxO5TS/YgCWt85IpqeiySHV3j/Cd9uFg+ePATlmYc+qHmBXSTV2JGNbFsxsyE+Fc0QuZFIqvLoKHF8et1XjmCBSJQ4F8kyEmTWNSRKX4pR7sZNp1X/6h+tHCYSHR5U6CLOc=
Received: from IA0PR10MB7255.namprd10.prod.outlook.com (2603:10b6:208:40c::10)
 by CY8PR10MB7340.namprd10.prod.outlook.com (2603:10b6:930:7f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Sat, 7 Jun
 2025 17:18:18 +0000
Received: from IA0PR10MB7255.namprd10.prod.outlook.com
 ([fe80::a82c:ceec:cd7f:8c64]) by IA0PR10MB7255.namprd10.prod.outlook.com
 ([fe80::a82c:ceec:cd7f:8c64%4]) with mapi id 15.20.8813.021; Sat, 7 Jun 2025
 17:18:18 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH] vhost-scsi: Fix log flooding with target does not exist errors
Date: Sat,  7 Jun 2025 12:18:15 -0500
Message-ID: <20250607171815.111030-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::22) To IA0PR10MB7255.namprd10.prod.outlook.com
 (2603:10b6:208:40c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7255:EE_|CY8PR10MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f66c37-4f75-4606-50dc-08dda5e74b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ISJRkua/P9QZ3YtyrAXHacXsEV2IqgvUlo/PbN235hx+UerQyxj2EWdB/4w2?=
 =?us-ascii?Q?DwsbC+iMdXQehd4JEu+3myL0ulPZFgNzjRBVWs4IM+ZQ2Vl6z1/6e8S04vVW?=
 =?us-ascii?Q?K027QQC4kKuI6UzHXIv2EAcXia3DWFmym4w5kOxaANcnOti4URZGye0Pvrn6?=
 =?us-ascii?Q?e4mt3a5c2Ib5NLzMKV7KRh126IL7jhAMrk1wE2yYOm+USZvd28xb1Zaq8Hmh?=
 =?us-ascii?Q?/qVz8MTuAWMOgTxae12CM8Am/g6OcYsn/K4gkcXwCBWLsHrhqXj1kayV01PZ?=
 =?us-ascii?Q?X/zyOS5hVwwZtI7UvBFUq3edkhaaVAZOcob3twMdkC5XGK7YKTcc8msvQwyx?=
 =?us-ascii?Q?NozyDxWM8ckXvgtqWahDhQxUZNMgj3gkbv9vZgkS7d0+RXjbYcz+puiUWyLw?=
 =?us-ascii?Q?5PAAmS7E0M9/aFdiov+X4R9aUcURnBpNlArYnSgW+f1zdYGz9BKWl92rVNEs?=
 =?us-ascii?Q?7/G7NNmr2oDhMa0z5JZB7gw19hNr4suS0ZdWZP8ij81E1YbiEWliG500hyj9?=
 =?us-ascii?Q?h7g89DoDA49EtN8oilT39E3SnhoYuiBAJ+ZbgV9dgnCwaV92kWhqgLLuNMKG?=
 =?us-ascii?Q?jNNr47RmDbmMJkjHp8D/tN1aB++S7NxqmVvQ6OXKVt8T8BDWTRMFiT1s+Sh/?=
 =?us-ascii?Q?/9G0vwJx9+aco3jP7E1lxofE/uxZkqy21sb1YsBdPMnbCR18CEF6jHAItVUg?=
 =?us-ascii?Q?1xG681+4FyA76tzvH5Gv9dRR8UscuTg/7N87+Ne3FR4KStxmzsoRr5CKv/nM?=
 =?us-ascii?Q?v2rkPIynzMQvjVSKyrwyBDtbfVW80+dksXxt2VvekRuMQR2/iXMyyg3KI13u?=
 =?us-ascii?Q?J0axzJgY0eGYgdRIfF7h4fWKy8wTPUDX5OV+6Mlt/sS3QVWzXY2KdLKFRRAX?=
 =?us-ascii?Q?KH7EQ/PUBYqHCpPG2vV0raNjyEg4FVhdCQyqGwHedWpGHMptMZqdQ3YAS2eX?=
 =?us-ascii?Q?/jc0A4dm0+55iwnTpo/ea0ahSUB5rbaBfusd80dPf3DpIb3wHmHcX5K7ZHBE?=
 =?us-ascii?Q?06YGg0YO50XTvTO5073p/tT4wGugakYOv2R6kPlWn7J+E3PYmCCeX+mLHn/+?=
 =?us-ascii?Q?vcFoFTx5xEEvvTGp6gD6nJt9f9Wt51McI9MD7FRPzqG+AYsIreav0AtXKbWO?=
 =?us-ascii?Q?2itfDb9GvGF3e2KoQwiCGrtHFvFsAqkeMqLBI1n33BzhAMWBFxJJqTodMA9X?=
 =?us-ascii?Q?dBGiAl8/5gZc4jOr6E8byDjhEpzsym4zURgueUPkrYq9OHwOlpGgbY1L86VD?=
 =?us-ascii?Q?QGtAYgbSAS2/CJbkFUxJgT0z/kf2nEteS7KAJ+4Hkb9GNeJa2Et6dHF0hESs?=
 =?us-ascii?Q?ImbJTUtRvAJ/xofca9esSRFkD4EhlDqDjPHqlQL76Y8zd50knqQd2k4ocmG5?=
 =?us-ascii?Q?RyPl7Z27kQQOu3ZWk6WQbB3AYkzIx7lNIajhDmuk+xXrIlCl5lJ5foRdkIOG?=
 =?us-ascii?Q?ZkcBVphr0+s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7255.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x5vqP+YGempeQs+Y/W4/tY8xDevrheoLFlBsj6CsLL6VksF96oS0uo5iSBCU?=
 =?us-ascii?Q?V0z4pd6YmG9FQLwG+0SPQQPvUdAYevZJGr+TZodxSoOGfzrD+GNH78ogkc2T?=
 =?us-ascii?Q?Lv8rm5et4BNhTr3yCP9IrGhM/OFWMJVwFpMxrMLBm+F7CtdqES4qQo/66s5x?=
 =?us-ascii?Q?AceIA5N2XGot2DEH0YsGYFkez75HJlm6kTaugXVuHkLu/eg6+4lFq8TpRqbR?=
 =?us-ascii?Q?dLw6qFjZBx2GlFFwwmk0836Oow6379PJRvyE0wlbFLJEOIdjfqXZIWl2G/m+?=
 =?us-ascii?Q?0Uk6Bv5eJhre9RBr37rIOtoLOwfMEccUggM2sC+eWOzvaBuDQQWOVLPkWSHH?=
 =?us-ascii?Q?kpK+PQhf1EIaDoTiztuOgmvr4uOWdT/ZrzFTpEUYPjhl1T6YAP+WczB9oQw7?=
 =?us-ascii?Q?D4hOYyDFkTCIYimp8wRtuGUMCygk7w9+Gr+4JgdimWrINkpfQz9EtgfGuwvI?=
 =?us-ascii?Q?1rqAplRWxqWctPTsMOAybJ1ijiTt+gVFq+0hhOTKk5F9uzA2mJE33v9dkmYd?=
 =?us-ascii?Q?hdIgCzgjOtVE7U3CYffDUXJ9S6LCFO8JURDyQFbOV8W3sTPu42Kl1DVxbcG0?=
 =?us-ascii?Q?hsHR2tDrOI3Kwha3rXmFNlJZZlTu15pJlX8Oow4Gc854UfnJ5xlrCjpCi9i2?=
 =?us-ascii?Q?+JpyXGOpicmMhYR228UaWXZdlYGV7H4YF6BBmnQZQLW+Bljo46u0d7PoVSV2?=
 =?us-ascii?Q?V09YI0CqSNe6aFjRIb4bcj0vkNHX2MJA6QfPok3oVlOKetz82G4dR4D/+6dZ?=
 =?us-ascii?Q?K9NeBTCepuhhSpX89rv9pau2lbBt83CaCChvPhmIp1p0oxk4bt4ZrkO8zPjC?=
 =?us-ascii?Q?KtVw0su8Gh37F/3t+AKBto45jm1Yp2PpyCj9KOXGmTg3o4oic/KjgJrDcS49?=
 =?us-ascii?Q?iR2KqXfyZ9UVNkoMKw/5BjKLprw2kOqN5R+VxGdEYDmMcDfdMzmHIEW30Nre?=
 =?us-ascii?Q?gPiZOfm1Bck3IWPoNb7XB8dojF5LlWe4QHpBAp+Bp1C4Yqi4uAxNFaSv3u73?=
 =?us-ascii?Q?Kyf+uOMEozHjNOXZq9sA3B9oIAVsRSN/XKZL7pl2n3TovVIQ7vErvjTRiv+V?=
 =?us-ascii?Q?U2vwYwiupRAuHyKwHkP/7EnWm1ILL46lYx+Wbm0qMqo8mezUSVtAYZY75mce?=
 =?us-ascii?Q?+3PtKPA32SwOFcJc+eXsnru71hkqpiclG1GemGSxNwnpveJFkj3jMf0iojiK?=
 =?us-ascii?Q?qcx24/YwdF4wlZjfMDyOTlGMLcCMqCiXhY9Z7zdIdBZq/7DWkvxUpTBCyP3C?=
 =?us-ascii?Q?rQl+4XR6q6qHoUG+2dt4Nr5nPHmlKqYlwyNrepdGS7DhrVn0GgklSBCOOEqp?=
 =?us-ascii?Q?A2Iiwr5xqidn6yKIm32SWhhFe4FGeBVrY2rx3X0T8YIMC+9JSIr1/nYNMLU7?=
 =?us-ascii?Q?xuehlzACOv97GsDW8ZfWAnjem8DkeSulMLzP21a0Ca4Aj4Jd41fpDbhBa3y4?=
 =?us-ascii?Q?UlPEv6z+G2LBJBsDj8l0UD8I2aTRoqgTirCdHw7yPTl8sUpadHsQAWQmz8le?=
 =?us-ascii?Q?Rt0UsnTfd4/owVH8NxZWPWXHm+0WB9DhVKX2p0s/KOZUtBYQbDaPp/5AaY5x?=
 =?us-ascii?Q?IYPYwcVjZe2WAnUG0OwitHOaSNEwyWIwP+ZS2QEmUSNn1VggxbC7gShcW1kq?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TQTdozNsrUT6f9h7RuOgFidGULSN+0Iyz5KVpIXzOyipWD4XW+HGi/NQ+aWS9i70LnhxoA+EeWp8tIlHkALM4nCixMAFntdmBvONvGaXvFT/CNppf6ItzLvRM/joMSRaAFAY/jqxBvj8TOwxRqcCtzYP3NAiyH/Mz/exh9Q4qWSBfZU0y2ptDgbk9i67r8fd+K7EAi8IuN+tbJrjX3sFovV1uglxz/Fba1snslTfdtzfLcgmp4FMWSAGXYYwcgnmtNSvvU9O+LICUfa7T1pgRXt0MkR3hy+LZtRShpqG4fVXyQMhcYhKSQ9s5GxRuH3GSyx9mjlEyD1Smo8LjdCFkuwqBva2D1YLrBPsyGxjodJ8jhFP0OPmfU0NoRcG+eFmpRu7rz9lKbEDigz+snq0BAkLG5YmgcO9T3E6bVQFOBNGWoeHsFloyOR28kRoDDolrfFp1k4JHtowipx4bGrtyKvvRkCHdqJvK8EfNjli7whqJRKH8n93JVSNkGy/w6ieuIav2DG2oL+Ul6MxB1EnPD8XWxz7F15zf2GvS7Ibt5zG+dIC7/mLjUA1bmtTckLR683+6QIKHDE7EcuQKxIsy4rIrNcK1JQOp19UcoCyE5U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f66c37-4f75-4606-50dc-08dda5e74b61
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7255.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 17:18:18.5050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJJCS1Wv2+NlcPlGnro4u2w8B75RGAEfeXbFuw+/XayQn+9wj0Xu4wwBYV7HkoCv0BVzZsEHO+ZemP21COEkHZgN1pPTWHeq7gk2ylk1XBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7340
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_07,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506070124
X-Proofpoint-GUID: N3zbiVy_-7nK4sZUVBtf5xlbp-IUEbUL
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=6844745e cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=9WkPz5kH9LUvRFbCTNgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDEyNSBTYWx0ZWRfXxIJALOc2PoVx Kt0q70Hp0hijgVfQlRt3s/+XlPMsJmgHVY70UQ9VzX+M3B0bn6ScltF3GHbEzAd6HCEamKF7NcY VjvVn94ea1UYrdYlm+9lJtuDndZQNXsFiTFGYjTRpnSqKqOi22IPcJEGwwxBA4l8A4ntanUCKIC
 O0jEzM//GWSautcFOZSStjR/A8D/+Dz2Tzh35FohxCEPXgNz0/2IRwefafIby0yaoSpyMY2vgtC JHYoNSpOz0UzWcp1s3khfr5eibpi3CMUG4oYbeXBAtmOzf4qPiQ1vReFQKhRwgjKtFhYG27KuE+ 0VEf38vH+0Oe20fECrReorVASUYOG2iLZJ738hOTxI1Lnd7hIxsJUeokbP3qoR+sqRv0tyRqiiT
 FJDRiDpsFr0eEd8ipbSwJ6RfD0E3t3UC/9uHfXEuStz2pMxYhAqvbNxUiQYQWbuLfIlVcdZG
X-Proofpoint-ORIG-GUID: N3zbiVy_-7nK4sZUVBtf5xlbp-IUEbUL

As part of the normal initiator side scanning the guest's scsi layer
will loop over all possible targets and send an inquiry. Since the
max number of targets for virtio-scsi is 256, this results in 255
error messages about targets not existing. When there's more than 1
vhost-scsi device, then you get N * 255 log messages.

It looks like the log message was added by accident in:

commit 09d7583294aa ("vhost/scsi: Use common handling code in request
queue handler")

The patch was just making some coce common but added the vq_err call
and I'm guessing the patch author forgot to enable the vq_err call
(vq_err is implemented by pr_debug which defaults to off). So this
patch removes the call since it's expected to hit this path during
device discovery.

Fixes: 09d7583294aa ("vhost/scsi: Use common handling code in request queue handler")
Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index c12a0d4e6386..c9f418a4571a 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1226,10 +1226,8 @@ vhost_scsi_get_req(struct vhost_virtqueue *vq, struct vhost_scsi_ctx *vc,
 			/* validated at handler entry */
 			vs_tpg = vhost_vq_get_backend(vq);
 			tpg = READ_ONCE(vs_tpg[*vc->target]);
-			if (unlikely(!tpg)) {
-				vq_err(vq, "Target 0x%x does not exist\n", *vc->target);
+			if (unlikely(!tpg))
 				goto out;
-			}
 		}
 
 		if (tpgp)
-- 
2.43.0

