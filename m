Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCC11F55FA
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737495095; cv=fail; b=KBBr4q/JkhEzGVY/b9DMNrNWJLW4Eg15Aqc1jw98ZtI/7efLLHEWblBwM401fr+QdSGpmtERzBKiQ5D0VtdLNhMMha/ePH4AKL49ZaLzNALuCx+T80/UekEwrDa3tcxkv51OloFbGRCqfgxv2fYFkV0RNYFHm6QLi19LFeeghiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737495095; c=relaxed/simple;
	bh=nF6bRShAFYxuv6gGjc8H9S/INztSUa89jC/N+L+4nHE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=srZnaO65nIfDutEF5VkyNslQ05mM2PPTdxgYooDYzV3oiyvlpj19MsVI8iYptYA832hD9YuqvXEjFAodrvtYeLV4NcnP7F/lp6IF9s/bukBTWqyW0Au6uI6skz2WJEfPbbq94iNFgh1U2YDtfAW1GBxtqa65UXaHQWMPDYTr3Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZupIqIcg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WtCW13Sf; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZupIqIcg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WtCW13Sf"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5196C84F34
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 21:31:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.489
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HCUMm7OD4yjT for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jan 2025 21:31:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D861084F29
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D861084F29
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=ZupIqIcg;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=WtCW13Sf
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D861084F29
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 21:31:31 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LJJo4C018070;
	Tue, 21 Jan 2025 21:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=82x95aY6Wd8kvC4w
	f7TCA4DxqPuEwWPQNor1sCpLNzw=; b=ZupIqIcgZ6a2Ee6hhUyoFei3MWnDva9T
	Ms8pf7auAgP2jQZkfTBu7fC4qrqJ8dT2pQ5IdLoJW+1CSDObLEGESfWse4ExCzv2
	6+Gkaigp0+OHy6IOXHk3aKZEBmq7YvVYqabE63lcPSkC6Q0/YFhiGs8quC3ru0NJ
	gCaKuqOqkld6ZyhMxEOh4keIqun4WB2EWlq4sDCZ01SOyk2u5UhgAMSD82WCXboY
	5Pbh1kq8nvvqv31AzgneTM6XR6l0nziSjYQmxXnTpZUTrqWZ6jUXwX5BcM5o+nKM
	agt0kcW5+Ly2gaCG7A40qGMk51SkSt2VrR8itVvcapNEyakoqHmyCg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qkxmw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 21:31:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50LKRrxa005505;
	Tue, 21 Jan 2025 21:31:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 449194ukkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 21:31:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGiD/SUHCJWKjyYlksRK4SQHFKZy41CHwR38nkZsUwYc3JMn5fjica5ItotETXQqj8i7o74eGrWW4iTj3QTyF8FGea40ItWmRd/x8sgl8JElYPh5J9gX6oWjr4rbkIyOxjzAFSeEvJiISERSBsf4mN3GcmngFg+kDgsDHF1fl21bUtvOAfjKJPqdNtpUWZbxhFRFw7bEOToW+DpiHk30nYznqZLa4IKqEHh2tMhlkMBtI2CUGmM+d3SpeHEDcWG+x5zgt/DJrJAG8I46T+0wHiosYU5iuBNG9OYs1HmD4EnwRzQX6+5WimhEAk/VMMiSki0oGCcg4K596BqxwFpLgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82x95aY6Wd8kvC4wf7TCA4DxqPuEwWPQNor1sCpLNzw=;
 b=p5jfLzFSEOHe0IZHxdK3saHJZQAAfzp6tcPEYSKVpVYi1XfqNu8kNKgbB602yhUKOmwM0tGtOf8T51rRa+QDrZe28ZQ5+tgJyLIub1mbXEs6BuGFtw5nJs267i48vN9IEz9WDobNA24W8aT7WMpyOL/Xq1rws6Ov7V7Ym1ip3Nnf8EZ0CLglXdixH88wtup4YEhYIBlEAD8ebrA1GX3kDB69QcuyP5bMGZkQBHdddixwxURui7nBaMOdPoGJz5Q7GOy0ihqmIiL+1niKXcLrhgw9O9K04fjVATjfBfzJjTgZtDIywUl05bRBHxhLv2OzRpl+DXFEjZdFkwCkyoArNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82x95aY6Wd8kvC4wf7TCA4DxqPuEwWPQNor1sCpLNzw=;
 b=WtCW13SfgPaK7O/YVGFOlRGUvE1A9vrl2JYu4FOTRR6BnkXKGOex/r/6q2yFpfb8h30THlZnh9SFxz0iyUkt7FUXDUEoom2TplOum1LOeXtxpU1vv2UkwHswo5RcL3ttLRI6K5o24CK+Kr0QVJFOXmm3fK20aZl0jAMsyhOOTUM=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH3PR10MB7281.namprd10.prod.outlook.com (2603:10b6:610:12e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 21:31:26 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%3]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 21:31:26 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, pbonzini@redhat.com, wh1sper@zju.edu.cn,
        virtualization@lists.linux-foundation.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 1/1] vhost-scsi: Fix handling of multiple calls to vhost_scsi_set_endpoint
Date: Tue, 21 Jan 2025 15:31:25 -0600
Message-ID: <20250121213125.140333-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:610:5b::19) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH3PR10MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a35c3f5-f042-4c1e-0d63-08dd3a62f617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aV95lT2jyuNYin/IgFb1Xcdnj/NxQpc/HBMadYH1PCcbUb4aJSE8YWgLl833?=
 =?us-ascii?Q?rVRawE+7hNx651U1EHfl26+w+YsJVM7jd6Qh5aZ7h22Upc/HMAaEroWdVoVe?=
 =?us-ascii?Q?X1KeZ8Opow/24rmq+R2xkHxv74RY+MAwWYIcGq/fRRsd+XL6iZ0nbCPjmTX+?=
 =?us-ascii?Q?hAmJC4mb1yw2lAFJU8cllTZ0WAw2Ix58CD/Ho3mExT2rJOIUSZYVv7kIAnmv?=
 =?us-ascii?Q?a2ans/vKG7RZPKeCMV7GKyfZ/8v3csmEnoZfcQhuLZ1qg5puQRnjHQCoc+4q?=
 =?us-ascii?Q?bQAKQwHxEcjSrn1ePPWIvtSVtkM1VXIdR/Ge2eAaozzS8OHWbVAT5pU9pCQ1?=
 =?us-ascii?Q?CFNQmgkBOZyVFPCoEpkDwtsYc6F8t2ykbV3f2vvoYX5WuhDNAT2ur5KiTAC/?=
 =?us-ascii?Q?I8LpBbesgTqX2Mst1stkeRrDPG1wRs24ChiJMoiGEKymez31oH11xoHNus1d?=
 =?us-ascii?Q?3IGommL2JeCsBOTrHc/MIxpyQwVLVW6OIxK8HCD9rRXBoxRCcqW1UMlvl2zo?=
 =?us-ascii?Q?PBxf0I6IGFgD5NSSEDuOGBEc5YAS1tGkPTAPYH2ajNrkaDtoCuEAAbqZDhzR?=
 =?us-ascii?Q?w+YhsqXDa6fQ27B0YT8LOXqdoAfftT2EmB+gCRfEqNWGEj/zTXkIr3SpYgaS?=
 =?us-ascii?Q?yNfS5CC0iUOqjpBYqMJJoPICeXAIpJFyZXLok//ku8zvHq2UjIfAUDuhY+xz?=
 =?us-ascii?Q?VSqFndUkwarFXUrbrJLxQL44G8/zlH8oLJTTOngSE1LSWkOxqxEziF7jSBlS?=
 =?us-ascii?Q?MbLejMW20AinFdPSkh/7oO0HvFxTIbGB9delecV6OWphL7XBwbPo7+0bqc1e?=
 =?us-ascii?Q?DE2kJjCBdNpQSDcOARnBE00WluU0oNsZ3feuxPFfmDtyYCKZckMNHM2r5uxL?=
 =?us-ascii?Q?fIwjp+bTtS7MqUXYNrbBMRsCp/zTrVAQRIbEAa+0tuv6RRK5AcK1C3LZzTVG?=
 =?us-ascii?Q?gFqQMOfsZAon5s0pQypshzIFCHl/V6G8DdT0rBz6yfo/iLx08l3bAMwMoZNf?=
 =?us-ascii?Q?eZmrCyBzOLqWI9KkZFHHNkGb6BOhtfAbUi7T7bSImv6DR20WUHT9BrzOz1Ud?=
 =?us-ascii?Q?/Bn+5JycPblfYnpOEdyz71YVSqjR1lJj3pOKMTVLLrqruHkfL/rJN6oouRqV?=
 =?us-ascii?Q?4zqLl8pJw1lgHmRQ+OPs2BX5wkNnz1vx/WpPwuCcbIfgmMLXOWXY6kookK1s?=
 =?us-ascii?Q?3HdDLxolYly8LDfMj64kYA6rVN0P1MnzlNnQ+Y5mf2N5c+Ydkp2uaTFSr/Um?=
 =?us-ascii?Q?zIEw3DR0+hRT99vZVtZDq74A4LW19p5mPoHZAzWk/rM68cPzYxPPhxOUmuGx?=
 =?us-ascii?Q?zcJ0n2TNGeutQO87Jppvnx+qeCQLDMpQwN7e8Yfq8KcWyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?icYqazO+v5ZRWFMw5/28HGqHP/q2jp7f3q4pw77ttohlmKus42iFMJ5L4CoK?=
 =?us-ascii?Q?RPiOxUpM2QA0VuaQm0xCf3gKQOrPTLqqINcaTWU8bQHXeCX02vhh7P0uuLc+?=
 =?us-ascii?Q?OpBzSSTQlDk4msF28Ym5FISfVBAJmrWPbTnCnembV78tlUvzwQveQzP+58Lw?=
 =?us-ascii?Q?MZGpHRZ+ZTD6dUy7r6Ub6MKFHyjqym60HWZo9MP5RJW6U8TZ78DLOtEiScyV?=
 =?us-ascii?Q?BQcwUbFhO+WnecpHlsPV2ub+sTCRRMXpH8bPG57c7JwpC8dGvAohhlGW048u?=
 =?us-ascii?Q?cEyzQ4e4ZkRWwXMo2Fl8rC0Do/sgPEpWamuW8CYeZv/P2uelvyeeb8LVI4ZK?=
 =?us-ascii?Q?krjhC+xXIt3BtkuCB1RAbUqxH3WFpgsjnD+2EkwO6ALJhmcNs2pUvD1BiWI+?=
 =?us-ascii?Q?RNyYgZyOOJmU13WyFwj9WQUj8BPc2xiQqeo7HZBYajEveQUJcfE7xEgDaWnp?=
 =?us-ascii?Q?1HavRs9sTr7auSwA+BUyNroqSsW9uz0jr6bpkn+0m9WRfUwDRvIy+H78j6wu?=
 =?us-ascii?Q?REsIR0cG9MCVzWKJSLRGqidcMBuEBW4PWPnYZbSz6brI7I/9FUnofqqF7jp8?=
 =?us-ascii?Q?vDWl4abFEH66sqr7KXWHnXv7RL14E9ZY6PVCRtZkPh9w+yP0s8whKX8XwBu4?=
 =?us-ascii?Q?eJFW9VtlqSt5+NQdS//9kPAamLuIXmju7N9BIgdA6j+1366rqzLtKBZvQuVQ?=
 =?us-ascii?Q?n6VfZMmZDAxyXDjdHs/P8X7GY1o9ORkbl4sOjVBTVfh0eLr8Oecfwe96nuC3?=
 =?us-ascii?Q?H3024viiK+yjDvVpFeQ/z6GiiNeqwwCp75bjQgKTumnlFN6fqzFbB9YkIyhA?=
 =?us-ascii?Q?NLbHWbb55xQE/A7gVhXIZpXJKFPqfFJPBuDjbRupww5a0E9wvWLJfsz/WL6h?=
 =?us-ascii?Q?2uVBoevmPFgFUC13GxebCDGOJEWbeB95lePT+5NJaM7W2Rx3ZCWFCtLJOdmg?=
 =?us-ascii?Q?KD545dTj5nLqcct1RplS6M34FFbJ0mFhx2ntWh8DeEurK/LsMxvwZaAiPcts?=
 =?us-ascii?Q?b1z1XDHQK1sX0eN89yvjAZsuzxVc7hTNrr/OW7L4gMfqMq5PW0a5MCmgfxYY?=
 =?us-ascii?Q?Mm1/aIRvhwBUKj4ePInS64kUdP18e+wa4jlNkGp4NIDNfBhtf5Sny/OJlONi?=
 =?us-ascii?Q?FRCgJwv0TChh9HahubmFcmLCZsXV/wrW/YsnTPGEIA8jiXPqoPUlMtjeyV/a?=
 =?us-ascii?Q?II11pqagh2VxMkANp5H++2RKOVMlFEEt66Gc4KprMtYDdWamLfO409l5c1fL?=
 =?us-ascii?Q?csv7Nfzhr6z93Q7k+Uhyr8QovtXpAfyc5OCVkIPjkOk+m86Z8bCGoQtPExzm?=
 =?us-ascii?Q?Ds7olTc3ABhwT4Pr/5Ge2J7zrWM8NzlPEs180HgEzn75KS5ERQbzDG7tW+wd?=
 =?us-ascii?Q?hIBWj1PRqZskwOqxCc+m4CyX+2QhRJU8YeI0nefHodS3qA6BWEYLZpuEbBUJ?=
 =?us-ascii?Q?uvPMJXXOdYbp51OjTfZ428U4mfleRgHmesqcEveYyusDa6m2RtmnusX71pni?=
 =?us-ascii?Q?OZaoixU98HA3dwOMgSxRR7juObJDMLQG+SBOK9ilNQSbXxYlcPfC5550pQWQ?=
 =?us-ascii?Q?GFZZA+D4ZbO1Zh9z0TDYLTClt8bXMg+OmjYfT4del0Q44s0HQ2LPaT9mpI40?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U88u0hqi5eMWzbbksPaA7rrn5jb3YMGW08AMtSZYZpBPeutM1nVPjglyWc5Qkj5fVV50p/iLrTnNwSv4zdIM+/02EJ7hOOB+k5KMrIWm5C5X0yMMKbNeX7Qbmu18S4F9QtIVMoJJ/5Yqr4OhAQ96TfHuWEGtpGp5XcQP2jhY5Y7olFAmtC67mtaXAliBXfyhaLv+YH/01YLpL3lHjAPyxQdN/RGLELUxxXT6DmufU/aeX95c/2MOW+0JGBUMJC2zxuOduQBbSnpXPy+YpsOOxx0V+Wa0lebQSYJNXknexa1wMyhOMKE6kzBq2OOmxmGWdCCKp1lL0TFg/rb/G56VMscixBQyXzgWVz2Job9QecRpmoo4p4jMVXsh5WXCKmJmc9Sp/7Tm+/wlgRbswi2kNw9h1lRNTwBFpgP1DQLa/d+X+1bm52CYx0acfqAEKFW3GXV3owUhR+a7mG6PpI7zNXee0J3Shwmlb+YVfom0tpbKVZErD7wImL4YtN95y0VlcFm1l7v9miWwLRkjjMXmnnvMvHVrmiK6qvXkns1Ev5/wSViOyYxGSsEPLwF41yJRy92+JjVg8IIqSmS0gC3uerhdm4tSu9I9khFzeqAL+V4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a35c3f5-f042-4c1e-0d63-08dd3a62f617
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 21:31:26.7710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0H0Mo1d1Z06RLU0P1VynT3ageyZpj7jDenCICAulQbLofaUDSXhya2lNFLTe1W3VrsJnL2tgTOG9NZS8k75qyiF9BwEdKZyvSqs08FelcYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_08,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=947 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501210171
X-Proofpoint-ORIG-GUID: qhMg0ox55qJxKqPEvz0e8HXTULqS2sxF
X-Proofpoint-GUID: qhMg0ox55qJxKqPEvz0e8HXTULqS2sxF

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
---
 drivers/vhost/scsi.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a4cbdc607fa..6bb64f3be7db 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1828,14 +1828,19 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
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
@@ -1851,12 +1856,6 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
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
@@ -1903,7 +1902,8 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 		}
 		ret = 0;
 	} else {
-		ret = -EEXIST;
+		ret = -ENODEV;
+		goto free_tpg;
 	}
 
 	/*
@@ -1931,6 +1931,7 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 			target_undepend_item(&tpg->se_tpg.tpg_group.cg_item);
 		}
 	}
+free_tpg:
 	kfree(vs_tpg);
 out:
 	mutex_unlock(&vs->dev.mutex);
@@ -2033,6 +2034,7 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 	vhost_scsi_flush(vs);
 	kfree(vs->vs_tpg);
 	vs->vs_tpg = NULL;
+	memset(vs->vs_vhost_wwpn, 0, sizeof(vs->vs_vhost_wwpn));
 	WARN_ON(vs->vs_events_nr);
 	mutex_unlock(&vs->dev.mutex);
 	return 0;
-- 
2.43.0

