Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994803242D6
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763718277; cv=fail; b=n65oCRFeWM5Qvl95HzH9z7MzdlouD1xwDw/v8RHqZEu4rgz7wNHq+U0kCRnxgROBHYFgv/Y4K/YMlfSHUaV+yK+obAascMCkRRl7CE6bTziSBn1KMa80CRIM+lPtITDqYFocQNc7QzSWG4EbLgmia4Ol/JAnjGZ8biTvwtw2HSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763718277; c=relaxed/simple;
	bh=9qoXC8gAU0jNZiko92bU8gPrZYGjVn61EJ+CtnEsqMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PqH4YNswyB7MSoRrV8tRdRZhgPCI616gaBXTgzhgmFYYXImANAjD3oLIgsgNA+DNUkoxyHeAOHNqWMFSnMiO1IAX46oJBwWHsUnoORc/H1RxK9wxTpbyoijhEHoMgMd61nkHTL0OD3EbhjhvFRUVPz7NEBDwtQdQkvIMtondvYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=SYgMN3AP; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="SYgMN3AP"
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AL9PHDw3140659;
	Fri, 21 Nov 2025 10:44:18 +0100
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4ahfcq0psj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 10:44:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7lJyqKF6pRBTALlNcCa7vSvVzooBU5IeFc1rvXVZ4MggzX8tc0ShiNcgFRyApNglyRiWWoYGmDCzG2EnxI7bGHuesZAFEyXzij5ufbSQlHYtOsCbORC8cuBo9zugrgpe16/U+ezZ/oE1qVfR7G44pv3v2TI3aLIqu0/vvd00L/BmFL7pcyThdVrJBOAJ2/kmCTutKJ5Ak5UnUsuWgVcykpD+3AOuRHYRhhzMKf8epevF+EADqlg6df5xytAcWbdivpLRfVmSQXllolhE/3C5OgqQxwzt7TFHVDfqBJrs3B+GAJos540KRnlmei5cPu8qR6IRPqhKU+hx5xLt/Xjxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKqTgzvx7a9ps4rAT3RFzl6tdtOFmO8fAeo/zifdS8A=;
 b=eAhje/YiKTTmGip2baXP76oDpUvXEm6fZCoxFtpXij7Seq0//eTmzRYBpyMhwz5BSiFmTZhMBlFghDd0JOoO73FtEhiEBRX63ByA0LbfzbT6zi616CWbONPz4wgQS8NPT+aT7t7fL6eB/wSfLdRe241DYpXzhWOPqrOVBrB9OZ2JCD9SxvvbwlTvLwFZf0kgRVxTD335B7fUiZ46/q2ctNyixVvyw6cpR9z+8yRv1bZyx65c6J6VGDKgR12Q1yDuQfz2sZ7EXfMfNVYZFHwqSgJaXvfwq/jZwvO8Efsi7j1pu9la5uT9eZXqnB6gd/7rId9bmCoAn5VtptWf9lTaYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=amd.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKqTgzvx7a9ps4rAT3RFzl6tdtOFmO8fAeo/zifdS8A=;
 b=SYgMN3APwayDj1/IZOoEl3DlVUSE6u0AXQD/815buLU8Rrv6tHLEHgmWSsN2tQ5SCePnxlkcQSQErDjJd3+SfZ0vwQHHZuRjwB0xJjz1Bawb1xzbq8WA5xLq/LbUf6B355OT3bbdgk1Ca+J33OwLCrRGgsoEayX7zAW0cbFzW0DKA+bKxiQ3Ko6y+4ufFw1GyEmJkCi3/OHRstOhAGUMpGCZ05qqeibfc4/AasyykUlTorlW/Xl8fE1AnILmm0HtHkrhBkYVewCEKI2okN/cKRSwMjSueG44A+AZKPOFYYd48dGc/f2X8Vab6OoPaQDxXTo8vXPn9VJq9V/+h1hxOQ==
Received: from AM0PR04CA0070.eurprd04.prod.outlook.com (2603:10a6:208:1::47)
 by VI1PR10MB3296.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 09:44:13 +0000
Received: from AM2PEPF0001C710.eurprd05.prod.outlook.com
 (2603:10a6:208:1:cafe::c9) by AM0PR04CA0070.outlook.office365.com
 (2603:10a6:208:1::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Fri,
 21 Nov 2025 09:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM2PEPF0001C710.mail.protection.outlook.com (10.167.16.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 09:44:13 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 10:44:38 +0100
Received: from [10.48.87.127] (10.48.87.127) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 10:44:12 +0100
Message-ID: <0a2b9fe6-d8b2-42d6-b6b3-9a94a82c6738@foss.st.com>
Date: Fri, 21 Nov 2025 10:44:12 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] rpmsg: virtio_rpmsg_bus: get buffer size from
 config space
To: Tanmay Shah <tanmay.shah@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <mst@redhat.com>, <jasowang@redhat.com>,
        <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <virtualization@lists.linux.dev>, <xiaoxiang@xiaomi.com>,
        Xiang Xiao
	<xiaoxiang781216@gmail.com>
References: <20251114184640.3020427-1-tanmay.shah@amd.com>
 <20251114184640.3020427-3-tanmay.shah@amd.com>
Content-Language: en-US
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <20251114184640.3020427-3-tanmay.shah@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C710:EE_|VI1PR10MB3296:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e43389-18bb-4b5c-8128-08de28e2876f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mng1RTlkck9pa0lUWThaellPd0ZjRzNMSXpHdUQ3YzBxT0huenRYRk1kZFFs?=
 =?utf-8?B?OUh6WDNLMkhqMW0xQXkxdEczUGZTYTFDcHJNNW56dWE5STlJei93dEJ4aEky?=
 =?utf-8?B?OU1yM0J2U2haSVJlVnVCK241K3lWd2pTNUZTTXd3TXY0eE53aHA4QnJ6K2dT?=
 =?utf-8?B?cGlUTmY3TzJlaFM2a0hUd25rKy9NQmhiOElmNDFUeEYrSGRqVFFRWUxNcVlx?=
 =?utf-8?B?QjA4N1NZNjdjOGN1bjhoMkRkV0UxUldYbU0zanN1SloyVW9SQ0pKT2M0U3pF?=
 =?utf-8?B?ZG5ydmUxM0daSWJuNWpyY3BOZlBiV05DOE9mRkRGaDFIOEdENkFSaU5NcHBu?=
 =?utf-8?B?eHZuTFg3dDVWdHBEcE1oNEtBTmI2RVJTanhrOFRwTXp1bUdWUDQzUGRpbk9q?=
 =?utf-8?B?QXd2cUMza0x5VE13MkJWck9BWnZrSE9ycjYxTFArenZveUU1MUlHWkVnSUhn?=
 =?utf-8?B?aU10cE1wRzAzblA5YmkwOG5aWlFDYllLbzlpcnB3cXM5dVNFc0hHaEtuSlov?=
 =?utf-8?B?b3hseXNualU1aTJ1M3VBME0xdHJ4am0yZVFvNEpVMG1HQWxuYVp4U2o0ODJV?=
 =?utf-8?B?TWVjSUhoK3lpb0lGWHE1dmtGSkZ2d1JkTXZwSGJSZmVjRzVvWitUa3Y5NHZy?=
 =?utf-8?B?azJSN3dacEZ3Mjh2ZTdQaFVYaHNWdmhhWmZiNzZMUDcvMGhESmsyMXB4eWtT?=
 =?utf-8?B?Uytub3M5OUpGMG5LdGtkREdsWDZ1aVpSNHlCSTNDVm5mbUFlQ1V5MUcyd2Mz?=
 =?utf-8?B?SWNJNTY0R1VKYTVyNnBTWnBrZmZYRnBuM29HR2tFdlBvN2xWRjYrR3Znb0tU?=
 =?utf-8?B?YUtOZFlTdzdQTzBYM1BERlF0bzNVbXNDNTdQSVp4aEVrbkhEVlVTNjg4V0o1?=
 =?utf-8?B?STJsTmhITldlR294c1l2MWhqY1hXN0ZXRzZHZTlyTVNQZFRRTkpqOUxLZXdN?=
 =?utf-8?B?bDFWWWFUZnZpcGZaYXdwY3lpVmdVOUtTVzh4K1VhMlBQVHFENUdYOCtnWUhz?=
 =?utf-8?B?cThOZVAzZVAxT1cwazBELzRhUy9QL3loRFErOTdmTERTeXFJVVkrbGhQeFUr?=
 =?utf-8?B?ZmtJeFNoRnFhbnRYcy80R09wenlqOW9ueURlelhya0xmRVFVcGhVZDhhZDVq?=
 =?utf-8?B?NkFvSzNtcEhLQlNjdUFoajloVTZxeFAzbmZGbHpWbjVzNTl0M3MrY3QxRVZC?=
 =?utf-8?B?bGxBcGEyQmRmR3A4V09MbzhJUGYxcE5UVzhNcnFEWENzT0VVaDZiT3BTdlhM?=
 =?utf-8?B?Y0hVMGVNQlVmRkN3MjNQc2ZpcXZKQTV1Snd0T1Jlem13aFZEb29HTmNJZ21G?=
 =?utf-8?B?eitYWE1pTXJCNmVkcXl1eXdMZSs5aUJLTjhqWWlsbThyQnFYRk9kdThQQzh0?=
 =?utf-8?B?eHNOa285cDhqaG8xOUlhRDByS2NzRGNuK1NvOUhjWXQrNVViUVdLOVlwbUJ3?=
 =?utf-8?B?djdXV1RkelN5YmdQTUxlZGxUYWlFdHl6UncyNEdOdEZaeGM4OHF3Tk50Wm1E?=
 =?utf-8?B?TTZIZzNzZG1Oa1hDSjZzdDBGR3cvZW02ZlI2UVl5VW5YTjliSG16NWhHT3RH?=
 =?utf-8?B?dEJ0Q3dPdFU1NHczMVNZd1R0NndRczg4WGxBNWVMUEpjQVhSV3ZHbUtkSDli?=
 =?utf-8?B?L0t5Q0pvdWRLMWxHdm5mb3RMeDZIc2dpanRTQzVtSWhZVVZnTjk2WDF1b2Y3?=
 =?utf-8?B?d1d6Q09wZkFLb2c1WVB5clkxQmZuNUxramlpcVViL2NydzlTYUtmUFlUVlVv?=
 =?utf-8?B?cVRxYW5tQlJEN3FYWXBrQ3pmbWpPQThWdWNOc1dwTG5pZDZTSlBXbWxTRzU5?=
 =?utf-8?B?U2xWbHFZdGJTK1FWcExEMURtVUZqTXJJb0xOcEJjTGR2dEZkdkdqakViM0RJ?=
 =?utf-8?B?cGFxdS8yZFhodnJHTHNtWU1RTnlOK1lndEdrWFV1NDBtVWE1Yk5ObE5pQWxE?=
 =?utf-8?B?Z3FSRXRTT3U4YVJGK1BJZ1NTbUVFZ0E5NWUzaXNrY1MwaGxsd3F0akxBZXlO?=
 =?utf-8?B?elpqRUg5K210dWx5QmtSaHNnNjkrMjZTYVl3dWJHaUltcGFuc1FJbE16eFdO?=
 =?utf-8?B?WjQydlBFc3hDYnRxaHZ3NnRMZEhqSStXQktNTVlzWlIzb3ZYS3I5YUpTeU04?=
 =?utf-8?Q?7c6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 09:44:13.2305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e43389-18bb-4b5c-8128-08de28e2876f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3296
X-Authority-Analysis: v=2.4 cv=DNSCIiNb c=1 sm=1 tr=0 ts=69203472 cx=c_pps
 a=lTC8IeES+PzMwLEJ9HO3BQ==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FOPVHIcnkjUA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=IeNN-m2dAAAA:8 a=zd2uoN0lAAAA:8
 a=j2MSVUfDAAAA:8 a=oGp5VSZPowymOWLuIFMA:9 a=QEXdDO2ut3YA:10
 a=9a3gGlFUS2ax-cngMeOV:22
X-Proofpoint-GUID: 3pJ72A7S460aWc_9x3g-MkcWGNwucJy-
X-Proofpoint-ORIG-GUID: 3pJ72A7S460aWc_9x3g-MkcWGNwucJy-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3MyBTYWx0ZWRfXyzMkpG9BEO7V
 PpBIGunX1PeeNMCkN3MaAZi1ZundzZ7kthN9SGCHRYHPRDqIRcb1lKhNpjL/1N3ThOiGoppONpP
 SZ6kso0nOVGYhjQh7YT0GNE8AgcrAVgT6mJR+KMwJQp5mTVrOhS07D8bwMxrl6ezQW0YIUV2vXK
 4Z92yrkS6S/KLvcYYyk2fMGrGKORezAVbLhTcSV4mHPExNslXYi3WFjX0Yss6m9wc07Td/BiCT7
 wt2edZhJkfzPYrgjsFhdOdZvw40LxrElwRLHq1HYRXV4A6ZVNIM6cRjndwU+hfbqoba7GVHqUzh
 ONtwlYlvjohqFCWyYAPK4AyApxizpYSLhYsv/dGh2pjNwMzNRVAnzmPLekGiHirTHspxb4tCy2j
 Ss6DDkuJj55w3ebK4cMwPLKp10597Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210073



On 11/14/25 19:46, Tanmay Shah wrote:
> From: Xiang Xiao <xiaoxiang781216@gmail.com>
> 
> 512 bytes isn't always suitable for all case, let firmware
> maker decide the best value from resource table.
> enable by VIRTIO_RPMSG_F_BUFSZ feature bit.
> 
> Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>   drivers/rpmsg/virtio_rpmsg_bus.c | 68 +++++++++++++++++++++++---------
>   include/linux/virtio_rpmsg.h     | 24 +++++++++++
>   2 files changed, 74 insertions(+), 18 deletions(-)
>   create mode 100644 include/linux/virtio_rpmsg.h
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index cc26dfcc3e29..03dd5535880a 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -25,6 +25,7 @@
>   #include <linux/sched.h>
>   #include <linux/virtio.h>
>   #include <linux/virtio_ids.h>
> +#include <linux/virtio_rpmsg.h>
>   #include <linux/virtio_config.h>
>   #include <linux/wait.h>
>   
> @@ -39,7 +40,8 @@
>    * @sbufs:	kernel address of tx buffers
>    * @num_rbufs:	total number of buffers for rx
>    * @num_sbufs:	total number of buffers for tx
> - * @buf_size:	size of one rx or tx buffer
> + * @rbuf_size:	size of one rx buffer
> + * @sbuf_size:	size of one tx buffer
>    * @last_sbuf:	index of last tx buffer used
>    * @bufs_dma:	dma base addr of the buffers
>    * @tx_lock:	protects svq, sbufs and sleepers, to allow concurrent senders.
> @@ -60,7 +62,8 @@ struct virtproc_info {
>   	void *rbufs, *sbufs;
>   	unsigned int num_rbufs;
>   	unsigned int num_sbufs;
> -	unsigned int buf_size;
> +	unsigned int rbuf_size;
> +	unsigned int sbuf_size;
>   	int last_sbuf;
>   	dma_addr_t bufs_dma;
>   	struct mutex tx_lock;
> @@ -70,9 +73,6 @@ struct virtproc_info {
>   	atomic_t sleepers;
>   };
>   
> -/* The feature bitmap for virtio rpmsg */
> -#define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
> -
>   /**
>    * struct rpmsg_hdr - common header for all rpmsg messages
>    * @src: source address
> @@ -130,7 +130,7 @@ struct virtio_rpmsg_channel {
>    * processor.
>    */
>   #define MAX_RPMSG_NUM_BUFS	(256)
> -#define MAX_RPMSG_BUF_SIZE	(512)
> +#define DEFAULT_RPMSG_BUF_SIZE	(512)
>   
>   /*
>    * Local addresses are dynamically allocated on-demand.
> @@ -443,7 +443,7 @@ static void *get_a_tx_buf(struct virtproc_info *vrp)
>   
>   	/* either pick the next unused tx buffer */
>   	if (vrp->last_sbuf < vrp->num_sbufs)
> -		ret = vrp->sbufs + vrp->buf_size * vrp->last_sbuf++;
> +		ret = vrp->sbufs + vrp->sbuf_size * vrp->last_sbuf++;
>   	/* or recycle a used one */
>   	else
>   		ret = virtqueue_get_buf(vrp->svq, &len);
> @@ -569,7 +569,7 @@ static int rpmsg_send_offchannel_raw(struct rpmsg_device *rpdev,
>   	 * messaging), or to improve the buffer allocator, to support
>   	 * variable-length buffer sizes.
>   	 */
> -	if (len > vrp->buf_size - sizeof(struct rpmsg_hdr)) {
> +	if (len > vrp->sbuf_size - sizeof(struct rpmsg_hdr)) {
>   		dev_err(dev, "message is too big (%d)\n", len);
>   		return -EMSGSIZE;
>   	}
> @@ -680,7 +680,7 @@ static ssize_t virtio_rpmsg_get_mtu(struct rpmsg_endpoint *ept)
>   	struct rpmsg_device *rpdev = ept->rpdev;
>   	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
>   
> -	return vch->vrp->buf_size - sizeof(struct rpmsg_hdr);
> +	return vch->vrp->sbuf_size - sizeof(struct rpmsg_hdr);
>   }
>   
>   static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
> @@ -706,7 +706,7 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
>   	 * We currently use fixed-sized buffers, so trivially sanitize
>   	 * the reported payload length.
>   	 */
> -	if (len > vrp->buf_size ||
> +	if (len > vrp->rbuf_size ||
>   	    msg_len > (len - sizeof(struct rpmsg_hdr))) {
>   		dev_warn(dev, "inbound msg too big: (%d, %d)\n", len, msg_len);
>   		return -EINVAL;
> @@ -739,7 +739,7 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
>   		dev_warn_ratelimited(dev, "msg received with no recipient\n");
>   
>   	/* publish the real size of the buffer */
> -	rpmsg_sg_init(&sg, msg, vrp->buf_size);
> +	rpmsg_sg_init(&sg, msg, vrp->rbuf_size);
>   
>   	/* add the buffer back to the remote processor's virtqueue */
>   	err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, msg, GFP_KERNEL);
> @@ -888,9 +888,39 @@ static int rpmsg_probe(struct virtio_device *vdev)
>   	else
>   		vrp->num_sbufs = MAX_RPMSG_NUM_BUFS;
>   
> -	vrp->buf_size = MAX_RPMSG_BUF_SIZE;
> +	/*
> +	 * If VIRTIO_RPMSG_F_BUFSZ feature is supported, then configure buf
> +	 * size from virtio device config space from the resource table.
> +	 * If the feature is not supported, then assign default buf size.
> +	 */
> +	if (virtio_has_feature(vdev, VIRTIO_RPMSG_F_BUFSZ)) {
> +		/* note: virtio_rpmsg_config is defined from remote view */
> +		virtio_cread(vdev, struct virtio_rpmsg_config,
> +			     txbuf_size, &vrp->rbuf_size);
> +		virtio_cread(vdev, struct virtio_rpmsg_config,
> +			     rxbuf_size, &vrp->sbuf_size);
> +
> +		/* The buffers must hold rpmsg header atleast */

typo:  /* The buffers must hold at least the rpmsg header */
> +		if (vrp->rbuf_size < sizeof(struct rpmsg_hdr) ||
> +		    vrp->sbuf_size < sizeof(struct rpmsg_hdr)) {
> +			dev_err(&vdev->dev,
> +				"vdev config: rx buf sz = %d, tx buf sz = %d\n",

message could be more explicit: s/"vdev config:/"bad vdev config:/

> +				vrp->rbuf_size, vrp->sbuf_size);
> +			err = -EINVAL;
> +			goto vqs_del;
> +		}
> +
> +		dev_dbg(&vdev->dev,
> +			"vdev config: rx buf sz = 0x%x, tx buf sz = 0x%x\n",
> +			vrp->rbuf_size, vrp->sbuf_size);
> +	} else {
> +		vrp->rbuf_size = DEFAULT_RPMSG_BUF_SIZE;
> +		vrp->sbuf_size = DEFAULT_RPMSG_BUF_SIZE;
> +	}
>   
> -	total_buf_space = (vrp->num_rbufs + vrp->num_sbufs) * vrp->buf_size;
> +	total_buf_space = (vrp->num_rbufs * vrp->rbuf_size) +
> +			  (vrp->num_sbufs * vrp->sbuf_size);
> +	total_buf_space = ALIGN(total_buf_space, PAGE_SIZE);

Needed? The allocator does not manage the page alignment?

>   
>   	/* allocate coherent memory for the buffers */
>   	bufs_va = dma_alloc_coherent(vdev->dev.parent,
> @@ -908,14 +938,14 @@ static int rpmsg_probe(struct virtio_device *vdev)
>   	vrp->rbufs = bufs_va;
>   
>   	/* and second part is dedicated for TX */
> -	vrp->sbufs = bufs_va + vrp->num_rbufs * vrp->buf_size;
> +	vrp->sbufs = bufs_va + (vrp->num_rbufs * vrp->rbuf_size);
>   
>   	/* set up the receive buffers */
>   	for (i = 0; i < vrp->num_rbufs; i++) {
>   		struct scatterlist sg;
> -		void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
> +		void *cpu_addr = vrp->rbufs + i * vrp->rbuf_size;
>   
> -		rpmsg_sg_init(&sg, cpu_addr, vrp->buf_size);
> +		rpmsg_sg_init(&sg, cpu_addr, vrp->rbuf_size);
>   
>   		err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, cpu_addr,
>   					  GFP_KERNEL);
> @@ -1001,8 +1031,8 @@ static int rpmsg_remove_device(struct device *dev, void *data)
>   static void rpmsg_remove(struct virtio_device *vdev)
>   {
>   	struct virtproc_info *vrp = vdev->priv;
> -	unsigned int num_bufs = vrp->num_rbufs + vrp->num_sbufs;
> -	size_t total_buf_space = num_bufs * vrp->buf_size;
> +	size_t total_buf_space = (vrp->num_rbufs * vrp->rbuf_size) +
> +				 (vrp->num_sbufs * vrp->sbuf_size);
>   	int ret;
>   
>   	virtio_reset_device(vdev);
> @@ -1015,6 +1045,7 @@ static void rpmsg_remove(struct virtio_device *vdev)
>   
>   	vdev->config->del_vqs(vrp->vdev);
>   
> +	total_buf_space = ALIGN(total_buf_space, PAGE_SIZE);
>   	dma_free_coherent(vdev->dev.parent, total_buf_space,
>   			  vrp->rbufs, vrp->bufs_dma);
>   
> @@ -1028,6 +1059,7 @@ static struct virtio_device_id id_table[] = {
>   
>   static unsigned int features[] = {
>   	VIRTIO_RPMSG_F_NS,
> +	VIRTIO_RPMSG_F_BUFSZ,
>   };
>   
>   static struct virtio_driver virtio_ipc_driver = {
> diff --git a/include/linux/virtio_rpmsg.h b/include/linux/virtio_rpmsg.h
> new file mode 100644
> index 000000000000..6406bc505383
> --- /dev/null
> +++ b/include/linux/virtio_rpmsg.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */

This licensing seems reserved for the UAPIs

> +/*
> + * Copyright (C) Pinecone Inc. 2019
> + * Copyright (C) Xiang Xiao <xiaoxiang@pinecone.net>
> + */
> +
> +#ifndef _LINUX_VIRTIO_RPMSG_H
> +#define _LINUX_VIRTIO_RPMSG_H
> +
> +#include <linux/types.h>
> +
> +/* The feature bitmap for virtio rpmsg */
> +#define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
> +#define VIRTIO_RPMSG_F_BUFSZ	2 /* RP get buffer size from config space */
> +
> +struct virtio_rpmsg_config {
> +	/* The tx/rx individual buffer size(if VIRTIO_RPMSG_F_BUFSZ) */
> +	__u32 txbuf_size;
> +	__u32 rxbuf_size;
> +	__u32 reserved[14]; /* Reserve for the future use */
> +	/* Put the customize config here */
> +} __attribute__((packed));

I am still convinced that adding a version field would help with future
improvements, even though a feature bit field can be used to handle new
configurations. Indeed, how can we address the need for more space
beyond the 14 reserved words?
Thanks,
Arnaud

> +
> +#endif /* _LINUX_VIRTIO_RPMSG_H */

