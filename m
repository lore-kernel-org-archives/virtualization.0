Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D8433BBA1
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763718044; cv=fail; b=hHm+W7mfU8506swXbxvq/i8Qqy+a5eY7drm6LnAo6bTg5KKT0J/kW0K21xWeoYExM5NDb37pgjxuvoAMHFZEbVptvGxpHaq9HGtfY5CC5+1KmNYiKNkHAbTf2F7CYk+EyIK2iZU62FbiS/vvuf45o8yMv2Klel7WapVE0ha1KpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763718044; c=relaxed/simple;
	bh=AmmDiw1qxoWEYPrKDnBbNyvBKrai6nEJpb3NH/uLsqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xv6GPBAoJFkFscjivO3DV213uIxhA9cT+gFp5mNsUtF2Pjlf2Li2seVybbk3/xm0sj0eMSP794LRCHN4lyzp68o1qoFJJ3tG/N5UnmzvucGEbwHBg4F5CuQGLMgHZazsFb95DeXzX4RCNDQ52cS5jp1W2uELq3T7dJIVtfkNdMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=YBi1N7Of; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="YBi1N7Of"
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AL9cYcN3168045;
	Fri, 21 Nov 2025 10:40:26 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010023.outbound.protection.outlook.com [52.101.69.23])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4ahfcq0p7t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 10:40:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPJmMw3V8Akkw7qqQXwatItTR/WWmzfd2sSdOj5Wq42Z/knb+/2aiiMgri/xxqQprm56oae1IDrZVmnjx7iwaZTK0A1Lv02h6EqFX5bPNksB+3BAQuvQj+ckAwpkm+efbOXD2kADdJQiA6WVwj6bkE9q5pGZQexKXyyu5oal2Gmi+pXU8Lmqu5qEKfg8tzNh4Oz7S9xQsl/z5mUrhKtcST3Q3feleadOxo11mABsq1wSTRXtV6bQZj05/t+nKZYm/bkL/Ia5wH169QIbAoJBKT76vheFtBg6lB/Wmw8uVj2Ibs+SmJjib7Ulz3onbaLPy0Q/MLR9vlwCZnX8t3H4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIIK9uz5TaPjlkA8Oqozp8Vbvh2aqW7Bmn+TgFZIZhs=;
 b=O15dSVGy5XxwV6A9eee/GuK5fAT49ZJTkkIg4QV56a6eU8q4zxwNtYg4XO8fAAVdYaD3v0uxdLw6yKNB6QlXUmAw/B4tQV8pVM5VUPZfLwumPM0scB0l9bKH8LfZ9xxiH3Q/9jD+UH/jJmYpvFlHuG4vZXohMtXMPNUY8ohFMJ5mrfPA9UeFouwIQjv9B++d+n640QLk/5NyP6DD1UZi45fXgB7eQuMV/6CsTzJVaaZZ76eF+hF+lNT//IkbryL796rDmplOUbAHNYdrGLMzSDbKhYyLP6ZTZxJrrABlT8F4q12sbflpqDkMSXc/BKKgQH2G9FUo4xyCuVgRsgCchg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=amd.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIIK9uz5TaPjlkA8Oqozp8Vbvh2aqW7Bmn+TgFZIZhs=;
 b=YBi1N7OfPJ8/KsreEpA8iUxDbw4cqRmRTJb+OPDTYCgbXvEzxzGVT2hwvMqBEqSrbvBDSYg5zK6Ufi9sD0gU0/znrOFHD5JW9qeK/jhCMpPzEDhPVJ6u0oHEBPUXr0ZiVQsJ5XxMYkoVO0QP7VrKktCvO0OBC3jChD2dOOPO+ynimyBO+4ejUOVP1Od+C1xfcZ4QjFUr7usxdDnlwduOjJhazI/R916581syP4mqyrN/9T1dZ/HZp1J+B7FcnHj76azugtTCbwrqQF8oTfIH0YowDeVqkOieoacjfjTlRr6eXMi8AGXAwhfnbxH1u6eIYIVPziY3dG6yYSVL0tJ6tg==
Received: from DU2PR04CA0025.eurprd04.prod.outlook.com (2603:10a6:10:3b::30)
 by VI0PR10MB8383.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:231::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 09:40:22 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::5) by DU2PR04CA0025.outlook.office365.com
 (2603:10a6:10:3b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.12 via Frontend Transport; Fri,
 21 Nov 2025 09:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 09:40:21 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 10:40:41 +0100
Received: from [10.48.87.127] (10.48.87.127) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 10:40:15 +0100
Message-ID: <d1f07248-194b-429c-aceb-9d586aad934b@foss.st.com>
Date: Fri, 21 Nov 2025 10:40:15 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] rpmsg: virtio_rpmsg_bus: allow the different
 vring size for send/recv
To: Tanmay Shah <tanmay.shah@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <mst@redhat.com>, <jasowang@redhat.com>,
        <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <virtualization@lists.linux.dev>, <xiaoxiang@xiaomi.com>,
        Xiang Xiao
	<xiaoxiang781216@gmail.com>
References: <20251114184640.3020427-1-tanmay.shah@amd.com>
 <20251114184640.3020427-2-tanmay.shah@amd.com>
Content-Language: en-US
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <20251114184640.3020427-2-tanmay.shah@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B622:EE_|VI0PR10MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c8062f-6658-47c9-6aa9-08de28e1fd83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnlPemtZbERDR1ZpNU11UGk3cDlQM3I5RVZRczczNXA5M1F1cWdtUnZtNjhQ?=
 =?utf-8?B?Y0g4YmViMCttY2g5Ymc2OE1ha3JHS0NSSnJSZTh4Uk9aL2NaV3QzaHM5dGtR?=
 =?utf-8?B?TnpkUVRCK2NnNnBJU1g3NERuSTRQcGgrOC91Ui9hMlpDMHJVUEF4a0hOQVRH?=
 =?utf-8?B?SXBYM1FSTURtUzFUdTJuR1Nwd3RHa1llaFVBYkZ1dzlML2VlOTE3eml3M0lE?=
 =?utf-8?B?UGgrYnp6TXBmSUZUcVNsK3ZHTXFZRmQ5QlhsUDlWckdGSThzRHliQWRWTVE3?=
 =?utf-8?B?RHVNQlRDVjBhWDlpM040V1ZQWWhGR0tEOWk5c0kwK245SmNrM3NVZktZaGNw?=
 =?utf-8?B?OVd6cCt2MGs4RGl3RndqNFZPbnc1bGZlSDR0R1d1YkpualJ0d1hzOWVFUEtl?=
 =?utf-8?B?WWlIRUk4L3FvckdySzVjUjJNcTlIRTVUakNIYTVUd0VYNzQ5VGVXcHlZckNn?=
 =?utf-8?B?WkFXc0ZpTGZWaUZxTVpOb1lzdUhXSUozcGNNRFRDSjByYS8yMUlleHNBL0or?=
 =?utf-8?B?SjQvVUwwUElndDEyUEtINStRb0tETVlGTE5vNmFtUUxKb21NWXUwYnJuaHJr?=
 =?utf-8?B?SnNBc2JSaTB0alE3QU5RRFhrbE4vL2paMG83YlNqMjlwbjNad2JpeTVvYTMw?=
 =?utf-8?B?Y1IwNzY4aTJIejc2WERDcngvTklCMERlS2pHSVI3Vm9vN0tRUU1ocE5vYXhZ?=
 =?utf-8?B?UkNIZHpjME9oR3hUVnZaM3gzSG5abFJ1cnhwTDh2QVZxMVJtNEtYUHNhOHFs?=
 =?utf-8?B?VTh0dllJNGM4eHRqVUxVdDdIbitVZCtja0lPMU16ZGgzS29pQ3BONk9pZ054?=
 =?utf-8?B?TWVDWUphVUxZMGdZcmc5UCtFcUI2RTlMV2pyUUhUV2xuZ2tNUmdSNVhLa1lj?=
 =?utf-8?B?d2N2dG9PSlpyRVBJeVg3QzFUWmdlOENYSHBBVHFnQVBMYWVQOG9iYm5NT3ZX?=
 =?utf-8?B?K21EZkVSZDhqQ1N3Ty83NWVmVXJlb2Q5cXE0dXh2ejd4VUJrdVB2WlkyVzBV?=
 =?utf-8?B?NlE1ZHdLdG82dW1rN3ZEYklKZ0l2Lzg1UHlxMDRQdVZLMVVZNFF4aFhzV3hV?=
 =?utf-8?B?ay90aGV0OGcrY2lsMGVpZlY1UkErMHFBK0lONGVBQy9ZZWp2d1k0bkVmVENT?=
 =?utf-8?B?UUZtaVplZVIyYnFoS3FKODV0cDRoNm9nTG01WWVJZ3dLTXlOOUdMSmg3SnJ2?=
 =?utf-8?B?bEMwWmhhcDlIZTFoNXB3ZG1xWE53TTFvaktQeGN1SUhpbnVSMHl3SjRPRDJV?=
 =?utf-8?B?NENoclRJUGY4cCthRGtid21KNjhHcHM1MXlPUTg3QThEUXJHNUFEUXV4QmY1?=
 =?utf-8?B?ZnpseWFpUmlRdDlyV0NEY3EyZ2VtRUlqcGlKVXArVGMxcktvdWczYXRiRzRD?=
 =?utf-8?B?eTBkVmEwRTRCOHM0cTRmVzR4V3BMY2QyYlkyZDduZ1N5NytsMlhWWENMNjh2?=
 =?utf-8?B?RmxvUm82dDJjSmJma0VQWWUydTI5MWpqSDgyU1RFTzU2aC9SYmFTZWVCL2Vq?=
 =?utf-8?B?d1V3WDFXNUVWSVVDbk9mZ2Z4OUI2bDl4UVNudEJXVEVhdHFJYk5aZHRKdmZp?=
 =?utf-8?B?cnhSdy9zaDJJWG85YzhHTkh4NUNZekNMbDgyekxKR3c3OXpybUNVVTEreW04?=
 =?utf-8?B?TzZYdHZtUGp5UGVla0VEeGs2R29ITHJva3B4ZklUdTM3QytXa2UxVnBFVk91?=
 =?utf-8?B?OGlMQmlBaC8rVGpwd09uU2RZTkUxai82dkRGL2FnZTRNT3FDTzhhY2g2Q0ZI?=
 =?utf-8?B?T0ozc0Mxd2RJYU8rNHRKWDZnMnlhRTk3TDFrbE1tU0M4UHFyTGhHUW5OYk93?=
 =?utf-8?B?UHo2ZTEyNjU3azVrTENFZXREcGc1TlIxVjZad3kxeGlMSlFBb2liQmo1Qytk?=
 =?utf-8?B?SEwrK1RiYVpTYkRTelJvOGRMQzFoUFdsd3cyYU9rNW11dFkyY2d2TndWMzUx?=
 =?utf-8?B?K1FPNHBQclpZanNtRkI5Q1pVNGJFN3NHbG1IK1RqRlBDb3Y4ZTdxenFvNW41?=
 =?utf-8?B?bkhPbVR5MTJrYzlLQ1YxNGg4a3o0S3VYeko2VXE1Ynd6UXhNcTZwTzgxc05U?=
 =?utf-8?B?aTJPMlo4VmFmNmNwYTNGZEJOWSt0eHVSYlk0OWJTckcyL2dJaXpDcVgrenBh?=
 =?utf-8?Q?0XeU=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 09:40:21.8115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c8062f-6658-47c9-6aa9-08de28e1fd83
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8383
X-Authority-Analysis: v=2.4 cv=DNSCIiNb c=1 sm=1 tr=0 ts=69203389 cx=c_pps
 a=6NdYoJeYuQcqbj5+k3r0qw==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FOPVHIcnkjUA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=IeNN-m2dAAAA:8 a=zd2uoN0lAAAA:8
 a=MYnERga7t4ZiccbvLZMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mgT4paIk3ETtovw8Kpc4xkxTAihiSpee
X-Proofpoint-ORIG-GUID: mgT4paIk3ETtovw8Kpc4xkxTAihiSpee
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3MyBTYWx0ZWRfXw6qI49lGBEQS
 pQIVZlBMrhPDTApMNg7/764bHQ/a3kH230cHxERmAUZcaY3IjAwotP6Hr1AMHwwAB1FP0fGtz8g
 K+NK8UeWeKzqTSB6F37abvxKo8GFfUYbPb5nORAysl4h1fZv7SfrrJHCwimQdfxIekxo15Mt41i
 4F5qEKAZwi5NchbXFiFkySAPJrO+BcAkxRuUG2frwoEy0xE9CgtQ/GA8tgiBa7jcWaqRfXKifOh
 HfwflDHjzAAsCMWAw18b/nPIsjS4jrs/nizAHrWZq6ZasRUhFqMJ3QnVwlmfabkmIRR6LjgSMPa
 M1kuqmlsZehFivxHU7ZInSKmVRdsnQhKoPjIm9fAq4gOPySju9RMzJgpM4UgampbukoXFYwTaWm
 Uhhz3BWS3JgLMBlymeg1KepZ+zkpsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210073

Hi Tanmay,

On 11/14/25 19:46, Tanmay Shah wrote:
> From: Xiang Xiao <xiaoxiang781216@gmail.com>
> 
> it's useful if the communication throughput is different from each side
> 
> Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>


Thanks you for reopening of this series!
> ---
>   drivers/rpmsg/virtio_rpmsg_bus.c | 47 ++++++++++++++++----------------
>   1 file changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 484890b4a6a7..cc26dfcc3e29 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -37,8 +37,9 @@
>    * @svq:	tx virtqueue
>    * @rbufs:	kernel address of rx buffers
>    * @sbufs:	kernel address of tx buffers
> - * @num_bufs:	total number of buffers for rx and tx
> - * @buf_size:   size of one rx or tx buffer
> + * @num_rbufs:	total number of buffers for rx
> + * @num_sbufs:	total number of buffers for tx

Nitpicking... I wonder if rx, tx term would be more generic
In such case s/num_rxbufs/n_rx_buf/ s/num_sbufs/num_txbufs/

Regards
Arnaud

> + * @buf_size:	size of one rx or tx buffer
>    * @last_sbuf:	index of last tx buffer used
>    * @bufs_dma:	dma base addr of the buffers
>    * @tx_lock:	protects svq, sbufs and sleepers, to allow concurrent senders.
> @@ -57,7 +58,8 @@ struct virtproc_info {
>   	struct virtio_device *vdev;
>   	struct virtqueue *rvq, *svq;
>   	void *rbufs, *sbufs;
> -	unsigned int num_bufs;
> +	unsigned int num_rbufs;
> +	unsigned int num_sbufs;
>   	unsigned int buf_size;
>   	int last_sbuf;
>   	dma_addr_t bufs_dma;
> @@ -112,7 +114,7 @@ struct virtio_rpmsg_channel {
>   /*
>    * We're allocating buffers of 512 bytes each for communications. The
>    * number of buffers will be computed from the number of buffers supported
> - * by the vring, upto a maximum of 512 buffers (256 in each direction).
> + * by the vring, up to a maximum of 256 in each direction.
>    *
>    * Each buffer will have 16 bytes for the msg header and 496 bytes for
>    * the payload.
> @@ -127,7 +129,7 @@ struct virtio_rpmsg_channel {
>    * can change this without changing anything in the firmware of the remote
>    * processor.
>    */
> -#define MAX_RPMSG_NUM_BUFS	(512)
> +#define MAX_RPMSG_NUM_BUFS	(256)
>   #define MAX_RPMSG_BUF_SIZE	(512)
>   
>   /*
> @@ -439,11 +441,8 @@ static void *get_a_tx_buf(struct virtproc_info *vrp)
>   	/* support multiple concurrent senders */
>   	mutex_lock(&vrp->tx_lock);
>   
> -	/*
> -	 * either pick the next unused tx buffer
> -	 * (half of our buffers are used for sending messages)
> -	 */
> -	if (vrp->last_sbuf < vrp->num_bufs / 2)
> +	/* either pick the next unused tx buffer */
> +	if (vrp->last_sbuf < vrp->num_sbufs)
>   		ret = vrp->sbufs + vrp->buf_size * vrp->last_sbuf++;
>   	/* or recycle a used one */
>   	else
> @@ -878,19 +877,20 @@ static int rpmsg_probe(struct virtio_device *vdev)
>   	vrp->rvq = vqs[0];
>   	vrp->svq = vqs[1];
>   
> -	/* we expect symmetric tx/rx vrings */
> -	WARN_ON(virtqueue_get_vring_size(vrp->rvq) !=
> -		virtqueue_get_vring_size(vrp->svq));
> -
>   	/* we need less buffers if vrings are small */
> -	if (virtqueue_get_vring_size(vrp->rvq) < MAX_RPMSG_NUM_BUFS / 2)
> -		vrp->num_bufs = virtqueue_get_vring_size(vrp->rvq) * 2;
> +	if (virtqueue_get_vring_size(vrp->rvq) < MAX_RPMSG_NUM_BUFS)
> +		vrp->num_rbufs = virtqueue_get_vring_size(vrp->rvq);
> +	else
> +		vrp->num_rbufs = MAX_RPMSG_NUM_BUFS;
> +
> +	if (virtqueue_get_vring_size(vrp->svq) < MAX_RPMSG_NUM_BUFS)
> +		vrp->num_sbufs = virtqueue_get_vring_size(vrp->svq);
>   	else
> -		vrp->num_bufs = MAX_RPMSG_NUM_BUFS;
> +		vrp->num_sbufs = MAX_RPMSG_NUM_BUFS;
>   
>   	vrp->buf_size = MAX_RPMSG_BUF_SIZE;
>   
> -	total_buf_space = vrp->num_bufs * vrp->buf_size;
> +	total_buf_space = (vrp->num_rbufs + vrp->num_sbufs) * vrp->buf_size;
>   
>   	/* allocate coherent memory for the buffers */
>   	bufs_va = dma_alloc_coherent(vdev->dev.parent,
> @@ -904,14 +904,14 @@ static int rpmsg_probe(struct virtio_device *vdev)
>   	dev_dbg(&vdev->dev, "buffers: va %p, dma %pad\n",
>   		bufs_va, &vrp->bufs_dma);
>   
> -	/* half of the buffers is dedicated for RX */
> +	/* first part of the buffers is dedicated for RX */
>   	vrp->rbufs = bufs_va;
>   
> -	/* and half is dedicated for TX */
> -	vrp->sbufs = bufs_va + total_buf_space / 2;
> +	/* and second part is dedicated for TX */
> +	vrp->sbufs = bufs_va + vrp->num_rbufs * vrp->buf_size;
>   
>   	/* set up the receive buffers */
> -	for (i = 0; i < vrp->num_bufs / 2; i++) {
> +	for (i = 0; i < vrp->num_rbufs; i++) {
>   		struct scatterlist sg;
>   		void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
>   
> @@ -1001,7 +1001,8 @@ static int rpmsg_remove_device(struct device *dev, void *data)
>   static void rpmsg_remove(struct virtio_device *vdev)
>   {
>   	struct virtproc_info *vrp = vdev->priv;
> -	size_t total_buf_space = vrp->num_bufs * vrp->buf_size;
> +	unsigned int num_bufs = vrp->num_rbufs + vrp->num_sbufs;
> +	size_t total_buf_space = num_bufs * vrp->buf_size;
>   	int ret;
>   
>   	virtio_reset_device(vdev);

