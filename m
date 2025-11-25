Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83B1329C59
	for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764090562; cv=fail; b=DS0Zn3bjKTPdeOxp6+MSqt3gdA/G7G5OTulh/syP4hPPKrbgKz4iflWU8uh+d/jZO0l3vVUXJN0UdRBHiPQtNCXHlbJ9osa4Q4M/4rwoANkHe3+CgcJoMCB4P1FeYbnExZFOpLJGG+b+L9nIq3dwWjd8XssRLoU8YH4QUoyf1RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764090562; c=relaxed/simple;
	bh=wF7/uL+aEPewa73yk+OXWldmEU02n0bmo2Fik+8tnLI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B4EXqnNLCITDFCbYf0MGQ8KLsYonZKvQao3+rR0hSR3pL3v4Nk5DHeLRE+eJv0dkR2g7lBwigEbqK/V/ImxNaJPiJARhWMD0RsLR/odL7e3ZIouMzvdC6P+zGMQ1NXfGr9EucigT+1R/+VKf5ekNJVsl1ui0KiO4hKuu5i4oQGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=0k63vbs0; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=oPTusDfI; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="0k63vbs0";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="oPTusDfI"
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APGadBm4002597;
	Tue, 25 Nov 2025 09:09:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=SAa7nZ2FLZeKh
	vApE5OtTFZ9R5TY4xyC1JtikIMeghM=; b=0k63vbs0ElPJVMu+mHs7YdIrfcnBK
	Ugqy6abx0H9xVqKe+/Xk9k80pXF2S+91yir8fCyv+4YwUOputmUun89cRXeNLnKa
	eufRvwOi8ul1PdUuvjuFjSznQpTQoEP1TFbT9SEZupXrhTMHGZOlCpQAAzwGBHNb
	mRVFSt2CUWWTMaGw7eBl8yO8vi8aAcRCAlVuor0rAZOjmeJEDutlEEceOYqPy5LT
	WUdKw5XKH6yEvS3MRCWuRVpA1ttgj4NPhQo4VQbV3j9zZVFp/05Gw01oNlpKQZY6
	Rg0u3m0ZrLb+VI/YGBDrl8vPmGNgbLXWUaPGlWRVwQE8d3lVGxMNWCPZA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020124.outbound.protection.outlook.com [52.101.193.124])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4amvetagta-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 09:09:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4dWrpZnsQQbLwESubTHfIwhTfyz8HgAbkd8Z566InDffOWJxa+3EFj2oeSRDZ8r9r7Uf+VqSbtCMqqmyi5wcbQBHMdVUF2YfoPG/wqyuBd7tHvjsBm2vPLreRGn+5jHlOX09dRMX9j3dSBqnv/8ZVtlI7JLdp8HHGeCLOmy103MoToWUNW2yKY+SuCXy0DYrasGwyc75FRMjPCbvbGQU3an3r+xAgCXkjUVVeiBhvbdUw12WPF0ExxgCRnUcSlknagYGGMhxygG1dkohK9QBoaR5SWSNXW9KTrCdLp0jwzhMMVuE2IgF42ZDJqOxlTwgZOEdomieI4EbqADH6gwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAa7nZ2FLZeKhvApE5OtTFZ9R5TY4xyC1JtikIMeghM=;
 b=usAEMjiMbyuU0tOES0EMPhUB+S6P7MiX3W16N1rY7CEK5Q9MekTsGaQSZHkpkPK8NTNw/jjlpBa1c3odW8PdJCwR3Ta8iL5YPhvZTY+qs9w2rvc2KV4jfTdH7lZ6W9emvglZm9UG9YFG+ietAx1kSl7MjTfyNs2/YxpqkSX7vri8vbfDolH6c3Su9SHamv2dMfKtohotIjHdirWq6juIDGL/kujk/fxYe34zSK7qZwhobiXyso00v8aQiB1Pj/fB0MuY7x4gif7VnLR0jAD1hC31O7EvoJriyqG9LknsYk+9CbWFtUqhizIUKLSJwGEufAvlm7N5xgCjbZv6sUXF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAa7nZ2FLZeKhvApE5OtTFZ9R5TY4xyC1JtikIMeghM=;
 b=oPTusDfI96IKPYGgOMvzDlnid3vqaeUlF9bKDcrSHs/hJn/PVNrJCDOOKRCC9xTGSU4wGU+F0Hq4W/vlM4Vv5quzzMfRFg3LaUQ/ux6LBJHnwOJmBgDLImLoYJD/jWHd5YYB7TDjJsLrlZdvQ/wKTAxFN4K5106/YFwOmpgSv1iXp15z93NZ5fPqyAxpH+sBXQt9rVKbcVxfm/isdaxFtFC7P9v23WgQyfuuQxZtuLQRJ2yNJFMFiKZ38KAoehyu9tBvrWGO2MkdOeNerBLvqOU46J9rFGDC8pCBena0v6M9dAB0qp0NNI9ZPHsO7QJwiY9Wc4t0cF2sjEG6OCNLLg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by BY5PR02MB7044.namprd02.prod.outlook.com
 (2603:10b6:a03:232::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Tue, 25 Nov
 2025 17:09:03 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 17:09:03 +0000
From: Jon Kohler <jon@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH net-next] virtio-net: avoid unnecessary checksum calculation on guest RX
Date: Tue, 25 Nov 2025 10:51:16 -0700
Message-ID: <20251125175117.995179-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR21CA0006.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::18) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|BY5PR02MB7044:EE_
X-MS-Office365-Filtering-Correlation-Id: a3557da9-9546-4c21-e56b-08de2c4555c7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UOlfi84cjk4wmiz9WP/AimtuL8m81XYvTo5YWiN5r8d4ACmwBKBAB7HxnYUa?=
 =?us-ascii?Q?Uf9YgVudExodP5d7WtDzoff9k5SWTNrknzTaEB0TSWD28ZovzG+UtuaNn0wC?=
 =?us-ascii?Q?VKOb82xvSDcubRoyLDJiJzjqJaOzK9UDjheCojE2oqoPiqZJtMkUdurr2rKV?=
 =?us-ascii?Q?EbtZuykZ4kg8OMzet3FauQgSfP/VTIbcooWVeh+7cd9HZrRLbBd1x3np9fXM?=
 =?us-ascii?Q?JpyW20WHLKzuTGa4j5NFN+890PYKPqkqDXDYnZ4bt8LqDj6TgkOwDI6tmAHu?=
 =?us-ascii?Q?wDlHnr4AWOOBIkKL/u8rBDZo/vKs/jQHizOPWfJ/3zRSEuOnwQMAo4oaGDWM?=
 =?us-ascii?Q?XmcBV5DoRyQgmHFnSwPPcAWcQP5mW9YzuNsxEFYWlCbQwl5tB+b3NT3wD82Z?=
 =?us-ascii?Q?a5bVi+6IvZPWZ9pT1IO30SbF4KrQQwZrMpQUc0ZGBK/Xr4wBA8sa7f6v94XT?=
 =?us-ascii?Q?BRlxBYPj0YKlyLVkmQhxtC7Lfhttmcp6AAwY4m8kO9AGGiCMhspAiyybwV3n?=
 =?us-ascii?Q?qHKo0obsTMbr8L+oZl0aBHaPlmMKLGSiDPPj20iqW/gn+CLWwPreymOfTe5l?=
 =?us-ascii?Q?TWgYqCAFcAsBgqmKRbN3CUZ3MvI4fQXcLi+0MV+KaKBb3P3xhfNpWNNxuBSw?=
 =?us-ascii?Q?I/LySSNij+n9yUFKVG7mjcW3m276jIKrKjDH+s6+EhCpkEB5I8Q2Pe2CPJZp?=
 =?us-ascii?Q?J7AEy7bqQDoVIRsX+kYzH7uAevh+Va+bRk97oMF5HW00cmkM1QKBQvC33Dr0?=
 =?us-ascii?Q?Jj2lnIOCkFWli5I4zVB5hXt46VnH4WGCRwRoCzeu380SFc1hxNREbQbSLcu2?=
 =?us-ascii?Q?a3EjRFZ3imjJOqlE2yes31BQYh454ieqA/0FkJe4at4elga+gitOvyDRo4v7?=
 =?us-ascii?Q?KhQGPWF1ke4LLtfHxPo3dWoUWzSyW7+xeZDoCrqNtjHQbMwW7BM2Qzt164ii?=
 =?us-ascii?Q?p3KkD6LBXNkoFhZvx0LjyqIlDq8JBgsAT4dLM1aB+4aalu42GnU7mg/GI8O1?=
 =?us-ascii?Q?KFgcvhYLoYwHcfzTf44qweQ0IwbQPDUibjT5r/h3WOimCPUYMFW5yf7aR/l2?=
 =?us-ascii?Q?k5FjgQFs8F/uEWpBLw1fAcfi4zfRsYZgdrqwqeh20+F9Pf8eTaBSWDn1ry0I?=
 =?us-ascii?Q?qShVgI9sAVKjLuHaceYY8IX+V93F3jzO/+LdR+roxcz7d/mqysGbkiO9yhkW?=
 =?us-ascii?Q?GFb0HM5uM4khdmUstlk4GJ9yanotvo5Iu5EFApfmmQhlo1aLJKInquZi6X8C?=
 =?us-ascii?Q?piZrqEmXP/jzqiAmKew2Xzjh8Hv6lEkBG+RYkGsgbDd5bq8pm8UBVzxD1nKd?=
 =?us-ascii?Q?38bZRK8VVbqBXutGBc056gNik84DXYjDYgNUY/nXVNuHNB/ctuRonXwDcPX8?=
 =?us-ascii?Q?jKMsvj5n9bgP6vbaXPLTzhZYnHIyO5FfW9XqwMJjrXYbaOrcOgwL1qvuqsY6?=
 =?us-ascii?Q?i/ZRB1kd1lWKsDz+1JE5CaYhkFCO0Qb1be5NDa3nq36AKhuYZh1WZQiY2Nbf?=
 =?us-ascii?Q?77chy5uzrl2zSF26JvH3V8Pp/TXGdbROt9Qc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VpT9ozzgrXIQx/GgRKC60vqRQ97LC8CbNIvWj6BgjbJm2B0dDygQGQBtk3Q7?=
 =?us-ascii?Q?twGgNBK7n2d5p540LXFAIFm5oKmcolpI0jqusp2DY1tDlj6IvtHxA0e+yJmH?=
 =?us-ascii?Q?SrdHvCBN5XlyfJ6WHpmFTYisEZIYFGsHwckMIKL7/Hqs8A1Qc9+F8KaHBrJK?=
 =?us-ascii?Q?PhHFX5IgDsLHNnCxG9Rh1LZW+TGRoBmj8isqPoKfh9IItuF4WUBpxWABUbW5?=
 =?us-ascii?Q?fEFMvv72GWstfaX/OUS5anda/wax8irO/4/vmAsjmBLmTlAHiFbH1I+XunkZ?=
 =?us-ascii?Q?JIv1OrE4XIFDEJv9zetgf5YI0tjDlf42WT3CfRdkjgNlDA2nbcIU5y8U5pL2?=
 =?us-ascii?Q?CjZD0bsaqgsESQtmClidQvqOaDYwzD8ghBsd9f+lnmCmxxETAfzNPP0L3rre?=
 =?us-ascii?Q?ygq/ZqFsdUf+YUmIT3sYFTbI9ym98OSpBAMNks9CxdE/tTwnZWWfkg6+q9f5?=
 =?us-ascii?Q?A43BN3U1BM8Z6ifUlDPatTPba/OAvkPKWnsIXCZX9DbyuJIQqReNjCurUpAr?=
 =?us-ascii?Q?OG+7yagLxMlqt/WfHb96kNNP8tcQVIEs1WfL8TjGc0Hs92j5oupqOO72z4pK?=
 =?us-ascii?Q?yasjDi/LOY0QoivvCKxF46fjBMrKX0REZKaW66BtsktR0zOAaESQRX7k4fld?=
 =?us-ascii?Q?2fCpkfBt+8W0EHh8OXWKZvLW7HGNcypKhzXx6TUdwwVaUUDUhw5i7TKbHrB1?=
 =?us-ascii?Q?Py+FOaOvOJOwjx91ns/UOKsER5Dd8oy8Agc2QzK2yPikLnbgnJMtqrTB90YX?=
 =?us-ascii?Q?O9Sw4V04om/ANF7CWLw2HebIFR/qoNwKCJ9xg1ir2n+n0BNGP44fZ176ntP1?=
 =?us-ascii?Q?aRmnVKbLR864vWLvhrlDtD0ilOx2CcuU9UKlwagixTRoO3XQKXsYEMraU+M6?=
 =?us-ascii?Q?2uLwhcaDcb5DMlIuQGJG1Aa9Z8iKad++KUbyUciR61NtCFe9RvCyYU4dGmSM?=
 =?us-ascii?Q?YqATyOMQ/kwSZK6kDNIKnY+X5ya3pme4YofVQVnBrZrhh6U38aFJAizcLp+n?=
 =?us-ascii?Q?H7XXEs0BSigbhfL7IPOYqhb1QsY5bELIKMIAGR6tGlAhSwr0RTgFUQqQWnSx?=
 =?us-ascii?Q?iUY97j8zhqHuZFPdxIWks9SGJqpsyX1jA2iFKK3pEXtH+ejjgUc0iJaOTbo2?=
 =?us-ascii?Q?uWDvP+aGDe1PfLe2KJ+86oPhKmlNhs4zL42c9YqC105DnK/gDb19eXAVLnEz?=
 =?us-ascii?Q?VTuL5kSPJL034smOV+nM9FdW18vrKO8nf7O6jOA0aTsT0NXSGjqJ0WbIXPZR?=
 =?us-ascii?Q?uOA1Xl7732SeJIqfqUgokaA3hcX1A7uzroUgx9kXtcyckxfWYihkx473kAT+?=
 =?us-ascii?Q?aDpQbRQM16+d/F/Cdrf/PxlP82AN4hHg7miL0Y8oKOt99rLj1swa/kx1Rzbt?=
 =?us-ascii?Q?dRicHX4qQdHKi6dVojllM/tM+HrX70pEveYwW/qu2qGRK7LWVLsqU6UQ3x9w?=
 =?us-ascii?Q?xY9SM41zpdU4RSuH3DTmYGaACmirhxKevNe8iqPOVBy1WULFwosN42Z4SQ7w?=
 =?us-ascii?Q?egFovRo0sLQ2eRQyZDifSfHT1OCt6ohrkVgtkT9RQZcMfYB3keLu7fcWiBvf?=
 =?us-ascii?Q?zaXeLPTV8l9Kc93Mxh5KhvAlQ4X70diHmbboCNkOPJuFWrYa/LjUW3K/Q//l?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3557da9-9546-4c21-e56b-08de2c4555c7
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 17:09:03.7501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQLs9JbO/+Pr+OO8FEETAyVCFqBmt5LwFc9vrmEMCK5tcuIT5j6HWB1q569biLaCO1rZiFicL32wsTZxR5hwsf1PMVU/WmD03My/Btf7uxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7044
X-Authority-Analysis: v=2.4 cv=OamVzxTY c=1 sm=1 tr=0 ts=6925e2b2 cx=c_pps
 a=gCYXggIpC+w3u2dojYR5Vg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=4IWZjywpVbBaUsnlwDMA:9
X-Proofpoint-GUID: ZOcdMwU_yppJ4kuWQZphO9rZNS3NtW6j
X-Proofpoint-ORIG-GUID: ZOcdMwU_yppJ4kuWQZphO9rZNS3NtW6j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE0MyBTYWx0ZWRfX7jZ9gKNgMPGJ
 ji8WJwPMCi4zERoW+5RTcew8Vnz+uCdKWyQkNQVq1EOjHq7ke+JIO+QuhOorjEk8Ricc/CSjrde
 rP6GqW2ZcNZh8rA3BZ+Mp1ssTk+w7BTUF+kLYgcm1oj7yVPA9TWXdEv+FbWwYxekZgphgCMXYBy
 ksoE0inDrm5sTCefYir3R0X8E2WrqaugiPLG7k5eDKYDKu2ZNL63YDgCHUJZFuKbFBtR6lKf7nW
 8oJDXYw+wdAQ3PKWdUQ8VD7JQmN0g57ViVYXtuNpfzV7TFLmDx8LzZ6is82FRgG/kkvGInHGYeT
 09TSxlP1QwPAxGxFADU/QGCSR+k2+W+PC38OXQc/TQcXv2hCOo+f3xstL87PS6ldC06Sc74X6/t
 8Yti3ghAlHvMymWmWbA1XcbW3mtOVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Commit a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP
GSO tunneling.") inadvertently altered checksum offload behavior
for guests not using UDP GSO tunneling.

Before, tun_put_user called tun_vnet_hdr_from_skb, which passed
has_data_valid = true to virtio_net_hdr_from_skb.

After, tun_put_user began calling tun_vnet_hdr_tnl_from_skb instead,
which passes has_data_valid = false into both call sites.

This caused virtio hdr flags to not include VIRTIO_NET_HDR_F_DATA_VALID
for SKBs where skb->ip_summed == CHECKSUM_UNNECESSARY. As a result,
guests are forced to recalculate checksums unnecessarily.

Restore the previous behavior by ensuring has_data_valid = true is
passed in the !tnl_gso_type case.

Cc: Paolo Abeni <pabeni@redhat.com>
Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 include/linux/virtio_net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index b673c31569f3..570c6dd1666d 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -394,7 +394,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
 						    SKB_GSO_UDP_TUNNEL_CSUM);
 	if (!tnl_gso_type)
-		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
+		return virtio_net_hdr_from_skb(skb, hdr, little_endian, true,
 					       vlan_hlen);
 
 	/* Tunnel support not negotiated but skb ask for it. */
-- 
2.43.0

