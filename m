Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F6832ABC0
	for <virtualization@lists.linux.dev>; Fri,  5 Dec 2025 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764950523; cv=fail; b=UxSne2mCwd1JoDt395c5e0fIcXXtEPRsd8wWL5j/3Ja4IaZtwjkpBXfPmSiQ7lxvZnbwH7jEGZ8dZFrwkWd/Mw+F9KOUnW3FqhKbm/p7mhJ0Beo5IbCGyGdmsK6g5vJvu4oRE/T1gE0s+2UF9fxlvADcc9z4QbHFWzbLlJOeWqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764950523; c=relaxed/simple;
	bh=AwEE2cP0ZxOHRU0KXz5Nu4s33c10MMZ4I9SE8iN1io4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BFbg9MGNIaCtnFKqc3N8LOBVj2Yu0gpDEzetwyZJHghxa2lbBJCIAzmVkJ1QRnGIRWdKo89uoG/9/vLl7GdTzPkWQWbiE0Rj7jloFrkX9tFzsbYMKNrX8mzSz67XHjo352MCgYNwpbrEBv3F8GYqikpLb0g30zHWs2qraJsp6o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=EKdntgns; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="EKdntgns"
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5FwDhR2767505;
	Fri, 5 Dec 2025 17:01:24 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4aubndmuqe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:01:24 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGicGorP0gkCOL9s3JJmyou6jMqiUI+S0Li/anSEilsnbEKPBgD1LFpOPT6v2Rv/kNWyCyZ9BI2W+ThkMMeFT4MPEsX/2BrHkl57B0r0eJ5EHfeBal1umqgcP/VERjYTK3AFS4QOP2BlDLYbbZ2z6H5debzpPSU7O3WZpD2eDQexzhXrPWZh4Y3S3yBRF4e3fZ5oRuowx8QcPKdabQxakLLo80PfiI6Wwb/RBYE8riq+3JsVp6KfB+06WM2zNMugPQTS/Wo2dRvslm/HdkKQVFNMmCub6kIwneZmXx7OSPcr2tvdXZ27HGs5cPplX/1XhIaiaQ030UZSI4tzzzXqLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbGZvKFxZ4VmDAXoVhPXyOMSboo7aKRggVd5N6zhdYU=;
 b=wMdgHiGXnjvTXwQB8S7L0MixX9a8O6y/cQH4lpW4nD55OFymkeWbL6OE2ApPweWHEtZH4Oxrk08huKAr+W8TRMFcPvEMHKpnf29Njbv1LA2bZn12U4CODgfyy4aPaGydl14RDhXkMRB0v8yhI1kOJCOGqzPChZvMA2gSYoIC5EuPryZTWWgJoEtYoiK4gC4RfukAKKmAR4NP1jySPPViJKK8nTH3APOYySe3xHnQyUhts4F5h8ReSczFUVeCC9sRhsYD21vOPZWrgq0gjqXakKL/nAglOy6KOav3KjD6fjtAWIPExsMF9mCGc16XZ5BheAEx+ezbL/9lGR5xXl3Cvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=amd.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbGZvKFxZ4VmDAXoVhPXyOMSboo7aKRggVd5N6zhdYU=;
 b=EKdntgns9HmlynX7Th6pkntDs693ZuRrmCwvL5YPLXUus7r+OTMFu7uDN1ykrM1YT8mKCTVHYqs4pI096PKj7tMZzQywpW1IzbzEtaNYJDR2CWwdYQ/ATtB5n/8S0kKL0A98yjMTqtT3u/p3cDUm85SaBaNOMwT4FI0AlFclbnDVwnfzrnDV4NC3RokOQW8oCLLcwQpgCtdnYBhN3l5YuhOWQpZucGYzDvSzCyptQ0gsmc9FKAaUvC9ajVNM/ZPouzBOe44qZ8NdGWEBX128Na//ZMORZTsEWYX6ABITGLypAOFPt/dUbOaz/zXmayqzRoe5cQJrrxHhG+CpjsslRg==
Received: from DU6P191CA0027.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::27)
 by AS1PR10MB7618.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 16:01:19 +0000
Received: from DB5PEPF00014B99.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::3a) by DU6P191CA0027.outlook.office365.com
 (2603:10a6:10:53f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 16:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B99.mail.protection.outlook.com (10.167.8.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 16:01:18 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 17:01:58 +0100
Received: from [10.48.87.127] (10.48.87.127) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 17:01:17 +0100
Message-ID: <324fdbe2-037a-4daa-84de-8b63dbac8117@foss.st.com>
Date: Fri, 5 Dec 2025 17:01:17 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] rpmsg: virtio_rpmsg_bus: get buffer size from
 config space
To: <tanmay.shah@amd.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
        <andersson@kernel.org>, <mathieu.poirier@linaro.org>, <mst@redhat.com>,
        <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
        <eperezma@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <virtualization@lists.linux.dev>, <xiaoxiang@xiaomi.com>,
        Xiang Xiao
	<xiaoxiang781216@gmail.com>
References: <20251114184640.3020427-1-tanmay.shah@amd.com>
 <20251114184640.3020427-3-tanmay.shah@amd.com>
 <11280877-95f0-4361-9112-23bb17372e91@oss.qualcomm.com>
 <c5395ebf-b0ea-4be8-b0c0-6a51d4c98e09@amd.com>
Content-Language: en-US
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <c5395ebf-b0ea-4be8-b0c0-6a51d4c98e09@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B99:EE_|AS1PR10MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 1410881c-8676-4ecb-984e-08de34178722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVYyNFBlRHJwWFU4M3JoVWxocy92NmJTUUtWcVlXTkFEbExTbFAwbFhhb0xv?=
 =?utf-8?B?azRpTStoU0s0ZTRNempBanJWWmdvQVFvVnlCNkFDRlRuaHBVNndTSWhqaVpo?=
 =?utf-8?B?MnlsUnM2OGxybkEyZzkycVJVZ0VoVThVL3VScHNwNmhXa0c0aFUrb2lVYkJI?=
 =?utf-8?B?SXNzK1Z5bXR5NTltZ0Jrb2pqOVhpVUExWTVjWUFxOWsyQUhJTUZvMU1Ba25X?=
 =?utf-8?B?WC9QcUVpaC85dHY4RTF4eGZqZGNZZ3Q3RDJWZFpad2ZxWjVpdkd2Rjk1NFR3?=
 =?utf-8?B?bFA2TTkwa1RxRjlyU3pHdTd4QTFQMGJxSnBjZkZnbU1YRnFYU0xBUnUrTkhR?=
 =?utf-8?B?b3hsaFNnWjZ2UVNsUThhL0ovd1BBZ1RoenlYVWZId0xiNDJMRi9MUUJmZVhv?=
 =?utf-8?B?a29WMFhlWXVTaGxUaWs3RWRnWEdaRGZ2Zk1sOHQzMnRLMkJXVERQeGdIWmhJ?=
 =?utf-8?B?VnppUUpxVm9KRXk0RzU1ZzZzdTF5RnZyL1oxa0FXTS90a1ZuVHFMdldBakd5?=
 =?utf-8?B?N3Y2SEV3bHdXbnhPVzlWZ2RVNWpCbTg2SnlMdURaZW5zTnpoeVA1d1pPQ3da?=
 =?utf-8?B?eDlDV2RJV1EzMzFNRkxjSkFKY053YnVLL2NQdG41VEF6L1pvK0N4TFhwc0tR?=
 =?utf-8?B?SHpEaS9PSHNMWHVCemRxVlhYNTFuSGdwRlRoOFVsdUpyWkVndi84QytUY2ZL?=
 =?utf-8?B?RFVQVVluTi9lVWQ1Q2xRZGIxeWdrSm1IOHc5MytrVGpFYkhzTlJWUS91azlM?=
 =?utf-8?B?S0tNcEUwVTFzK2UvLzRXOG1XVVVQWHVCRVFXbVY3VHJuYUtWSjNUN1VMZnJL?=
 =?utf-8?B?TUtPTUErblFpMGJIaU1Wd05kaXZXN0xQZEU4ZnA2Q1VydlFmWFhtWkNGNkQv?=
 =?utf-8?B?UlVWek5hMlYwSkkzbUFqc2U2dmovc01KZ3N1eHgrOEpxTjZicFJZTEZ3NFc0?=
 =?utf-8?B?YjV4b2pvbEFxS1VEcjkzVHZPOFQzaFlpWlQ1cGx3ZFd2K2o1azNoaCtpOHQv?=
 =?utf-8?B?T0h2ZjlZYlh5ODY4QlVOUENsbndEQkpmdHdnLzJmWE5sMk5kam0ycm9yR01x?=
 =?utf-8?B?OHlrZFlWd1lzd01nVDBxUWJDeFo3Q2pyMjg4OFVCNzRMdDNpd2JiRXFqRGFQ?=
 =?utf-8?B?M3NQYitCTjF4aHVlYWVCUG1VTGdqVjZ4anlOUFBKSXVuNjRsMzJxVXVEenRl?=
 =?utf-8?B?cFZRUTZhQUNFNmRqeHovckJZZFVxMW9yV09BUzhrWTNsYW44cCtaSTZMOURY?=
 =?utf-8?B?VndHMWxuWVFEWmhDVGpsc3Rjcm9IS1c3RzhaVmMrT3hvNmoxT2tDajA0eGNz?=
 =?utf-8?B?YmQ5dzVzRjg3V2R3N0FNeUZFTCtZMTA5OTZwQzFYeFR0UEFQRjB6TGRxdUEx?=
 =?utf-8?B?bmJhWWtCY0I2M1JXWmxZbkJkQmtpbk5RcTQ5ZDhtZ0lOd3h3MGdXSlFkSHQ1?=
 =?utf-8?B?VUpqMC9lbWdwbno1QmxhNGxrUkkzMUFlSmQ0M280Q1ErcXYvTjVyQWlDUGhC?=
 =?utf-8?B?cEdoNS8wYitlL1l6czFBKzlrenRaV05mRHhRRXdISitpelo2UTdNWHNLWlJT?=
 =?utf-8?B?S09IMzlMQ0ViM2pLYkh3ZE1Wak5YWHl0WXJPNnhnUmx6eW9MRmxNbzE0d3ZB?=
 =?utf-8?B?a0lKY1dKYVlGM0E3SXJtNTU5Ujg2aDRzdTRkMTc3dy95TDlyUEp3Z3hOcHE2?=
 =?utf-8?B?dEx3WFNWN3hRMTl5Q01BRTdXMThwQkdPMis2ZWltdTNZZXpwcXZFYlBISmFV?=
 =?utf-8?B?cFU5cGlJN2wxdHh1QzJwMG10OThiSTRDbko2UHhRY1FvZGQrTFRpT0ovSnRi?=
 =?utf-8?B?Z1FiWUZtVHM4ZHNzWVVzUU9Rck1iajNoTldHR1hZYTg3Y3BRRDZHQ280QVQy?=
 =?utf-8?B?WGZwblJZQ2VoY2F1NTVKbndsYXRleGxmcUhxb3Bwa3FKRHZnZ1J6cU9DRGt3?=
 =?utf-8?B?VytPOENIbTE1Y2JiUGMvdUJQK1g4UXFZQ2p3SmRzajRIY1RBa1dGOHhiZDJJ?=
 =?utf-8?B?NFdVaWxOY0pzZnRJdHY0UlQrSGttVzkrWVNFZlo0dmxFS2VGRzJRK1JLVUFz?=
 =?utf-8?B?dTlsRUpEQVR1QStDUTV5cEh2NEV3QnVhN3JQQ1pvRnZKU2w3MFNlOTdaZCsv?=
 =?utf-8?Q?OGatCTqVnXwwOAz1XjyhJ/Ct9?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 16:01:18.8184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1410881c-8676-4ecb-984e-08de34178722
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B99.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7618
X-Proofpoint-GUID: qeR-lopZh0rWqy5u8MENNBgjXHMQa45Q
X-Proofpoint-ORIG-GUID: qeR-lopZh0rWqy5u8MENNBgjXHMQa45Q
X-Authority-Analysis: v=2.4 cv=FtUIPmrq c=1 sm=1 tr=0 ts=693301d4 cx=c_pps
 p=j2MSVUfDAAAA:8 a=ImtDw27oDxRPo2ELsqiwPw==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FOPVHIcnkjUA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=IeNN-m2dAAAA:8
 a=zd2uoN0lAAAA:8 a=5m4iW_1QmsOvDnVOXZUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=9a3gGlFUS2ax-cngMeOV:22 a=Bho9c0fBagfJEIQBS7DQ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDExNiBTYWx0ZWRfXzy4i+zqds2NE
 rk2WSngtpAz+6Aa0vf9u6wqJZepbfU7z6Y5f5VWOVkjyZCAVoOh5TK9oDrrLSG3BiNZYdU0fouz
 0sFgj+/My9ex5RY1n317XTdJL7glwZH7lYimS04asEAnnzX9Ll5KpF6Bw1thOs3XhohlIdkNOB6
 SdPnVpYG+8eIdT+yYbZla2V+bjUwSjtDLLc/ICAeyu0YhrtSH/pR1K0n64xVFPK82oKx07fV+0N
 pOrFeTNq/mnimOfRN4gFDasqodeslljTYi9ygjTCJQp6+iiPzFTXM6KLoU3Lp7Aodw8X8Tyro4x
 zc1aoVickDUWuGDk/G6F13CIuJ9dFj4RKbGx+XFioa0R4TRtTiSuuc8P0n48/I5KI2o6HKtrGpi
 N9aj8v6A08g6LeK0L0HJn7aoEUBnU4iW2L6lHu4NSzyMsenM4/c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=99 authtc=ignore authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512050116

Hi,

On 12/3/25 19:12, Tanmay Shah wrote:
> Hello,
> 
> Thanks for your reviews. Please find the response below.
> 
> On 11/22/25 6:05 AM, Zhongqiu Han wrote:
>> On 11/15/2025 2:46 AM, Tanmay Shah wrote:
>>> From: Xiang Xiao <xiaoxiang781216@gmail.com>
>>>
>>> 512 bytes isn't always suitable for all case, let firmware
>>> maker decide the best value from resource table.
>>> enable by VIRTIO_RPMSG_F_BUFSZ feature bit.
>>>
>>> Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
>>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>>> ---
>>>   drivers/rpmsg/virtio_rpmsg_bus.c | 68 +++++++++++++++++++++++---------
>>>   include/linux/virtio_rpmsg.h     | 24 +++++++++++
>>>   2 files changed, 74 insertions(+), 18 deletions(-)
>>>   create mode 100644 include/linux/virtio_rpmsg.h
>>>
>>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/ 
>>> virtio_rpmsg_bus.c
>>> index cc26dfcc3e29..03dd5535880a 100644
>>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
>>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
>>> @@ -25,6 +25,7 @@
>>>   #include <linux/sched.h>
>>>   #include <linux/virtio.h>
>>>   #include <linux/virtio_ids.h>
>>> +#include <linux/virtio_rpmsg.h>
>>>   #include <linux/virtio_config.h>
>>>   #include <linux/wait.h>
>>> @@ -39,7 +40,8 @@
>>>    * @sbufs:    kernel address of tx buffers
>>>    * @num_rbufs:    total number of buffers for rx
>>>    * @num_sbufs:    total number of buffers for tx
>>> - * @buf_size:    size of one rx or tx buffer
>>> + * @rbuf_size:    size of one rx buffer
>>> + * @sbuf_size:    size of one tx buffer
>>>    * @last_sbuf:    index of last tx buffer used
>>>    * @bufs_dma:    dma base addr of the buffers
>>>    * @tx_lock:    protects svq, sbufs and sleepers, to allow 
>>> concurrent senders.
>>> @@ -60,7 +62,8 @@ struct virtproc_info {
>>>       void *rbufs, *sbufs;
>>>       unsigned int num_rbufs;
>>>       unsigned int num_sbufs;
>>> -    unsigned int buf_size;
>>> +    unsigned int rbuf_size;
>>> +    unsigned int sbuf_size;
>>>       int last_sbuf;
>>>       dma_addr_t bufs_dma;
>>>       struct mutex tx_lock;
>>> @@ -70,9 +73,6 @@ struct virtproc_info {
>>>       atomic_t sleepers;
>>>   };
>>> -/* The feature bitmap for virtio rpmsg */
>>> -#define VIRTIO_RPMSG_F_NS    0 /* RP supports name service 
>>> notifications */
>>> -
>>>   /**
>>>    * struct rpmsg_hdr - common header for all rpmsg messages
>>>    * @src: source address
>>> @@ -130,7 +130,7 @@ struct virtio_rpmsg_channel {
>>>    * processor.
>>>    */
>>>   #define MAX_RPMSG_NUM_BUFS    (256)
>>> -#define MAX_RPMSG_BUF_SIZE    (512)
>>> +#define DEFAULT_RPMSG_BUF_SIZE    (512)
>>>   /*
>>>    * Local addresses are dynamically allocated on-demand.
>>> @@ -443,7 +443,7 @@ static void *get_a_tx_buf(struct virtproc_info *vrp)
>>>       /* either pick the next unused tx buffer */
>>>       if (vrp->last_sbuf < vrp->num_sbufs)
>>> -        ret = vrp->sbufs + vrp->buf_size * vrp->last_sbuf++;
>>> +        ret = vrp->sbufs + vrp->sbuf_size * vrp->last_sbuf++;
>>>       /* or recycle a used one */
>>>       else
>>>           ret = virtqueue_get_buf(vrp->svq, &len);
>>> @@ -569,7 +569,7 @@ static int rpmsg_send_offchannel_raw(struct 
>>> rpmsg_device *rpdev,
>>>        * messaging), or to improve the buffer allocator, to support
>>>        * variable-length buffer sizes.
>>>        */
>>> -    if (len > vrp->buf_size - sizeof(struct rpmsg_hdr)) {
>>> +    if (len > vrp->sbuf_size - sizeof(struct rpmsg_hdr)) {
>>>           dev_err(dev, "message is too big (%d)\n", len);
>>>           return -EMSGSIZE;
>>>       }
>>> @@ -680,7 +680,7 @@ static ssize_t virtio_rpmsg_get_mtu(struct 
>>> rpmsg_endpoint *ept)
>>>       struct rpmsg_device *rpdev = ept->rpdev;
>>>       struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
>>> -    return vch->vrp->buf_size - sizeof(struct rpmsg_hdr);
>>> +    return vch->vrp->sbuf_size - sizeof(struct rpmsg_hdr);
>>>   }
>>>   static int rpmsg_recv_single(struct virtproc_info *vrp, struct 
>>> device *dev,
>>> @@ -706,7 +706,7 @@ static int rpmsg_recv_single(struct virtproc_info 
>>> *vrp, struct device *dev,
>>>        * We currently use fixed-sized buffers, so trivially sanitize
>>>        * the reported payload length.
>>>        */
>>> -    if (len > vrp->buf_size ||
>>> +    if (len > vrp->rbuf_size ||
>>>           msg_len > (len - sizeof(struct rpmsg_hdr))) {
>>>           dev_warn(dev, "inbound msg too big: (%d, %d)\n", len, 
>>> msg_len);
>>>           return -EINVAL;
>>> @@ -739,7 +739,7 @@ static int rpmsg_recv_single(struct virtproc_info 
>>> *vrp, struct device *dev,
>>>           dev_warn_ratelimited(dev, "msg received with no recipient\n");
>>>       /* publish the real size of the buffer */
>>> -    rpmsg_sg_init(&sg, msg, vrp->buf_size);
>>> +    rpmsg_sg_init(&sg, msg, vrp->rbuf_size);
>>>       /* add the buffer back to the remote processor's virtqueue */
>>>       err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, msg, GFP_KERNEL);
>>> @@ -888,9 +888,39 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>>       else
>>>           vrp->num_sbufs = MAX_RPMSG_NUM_BUFS;
>>> -    vrp->buf_size = MAX_RPMSG_BUF_SIZE;
>>> +    /*
>>> +     * If VIRTIO_RPMSG_F_BUFSZ feature is supported, then configure buf
>>> +     * size from virtio device config space from the resource table.
>>> +     * If the feature is not supported, then assign default buf size.
>>> +     */
>>> +    if (virtio_has_feature(vdev, VIRTIO_RPMSG_F_BUFSZ)) {
>>> +        /* note: virtio_rpmsg_config is defined from remote view */
>>> +        virtio_cread(vdev, struct virtio_rpmsg_config,
>>> +                 txbuf_size, &vrp->rbuf_size);
>>> +        virtio_cread(vdev, struct virtio_rpmsg_config,
>>> +                 rxbuf_size, &vrp->sbuf_size);
>>> +
>>> +        /* The buffers must hold rpmsg header atleast */
>>> +        if (vrp->rbuf_size < sizeof(struct rpmsg_hdr) ||
>>> +            vrp->sbuf_size < sizeof(struct rpmsg_hdr)) {
>>
>>
>> Hello Tanmay,
>>
>> May I know if the omission of = here is to accommodate the ping/pong/ack
>> scenarios? mtu will 0
>>
>>
> 
> Yes. At minimum RPMsg header is needed to ping the correct endpoint. We 
> don't need to have any payload attached to the packet. MTU will be 
> sizeof rpmsg_hdr I think.
> 
>>> +            dev_err(&vdev->dev,
>>> +                "vdev config: rx buf sz = %d, tx buf sz = %d\n",
>>> +                vrp->rbuf_size, vrp->sbuf_size);
>>> +            err = -EINVAL;
>>> +            goto vqs_del;
>>> +        }
>>> +
>>> +        dev_dbg(&vdev->dev,
>>> +            "vdev config: rx buf sz = 0x%x, tx buf sz = 0x%x\n",
>>> +            vrp->rbuf_size, vrp->sbuf_size);
>>> +    } else {
>>> +        vrp->rbuf_size = DEFAULT_RPMSG_BUF_SIZE;
>>> +        vrp->sbuf_size = DEFAULT_RPMSG_BUF_SIZE;
>>> +    }
>>> -    total_buf_space = (vrp->num_rbufs + vrp->num_sbufs) * vrp- 
>>> >buf_size;
>>> +    total_buf_space = (vrp->num_rbufs * vrp->rbuf_size) +
>>> +              (vrp->num_sbufs * vrp->sbuf_size);
>>> +    total_buf_space = ALIGN(total_buf_space, PAGE_SIZE);
>>>       /* allocate coherent memory for the buffers */
>>>       bufs_va = dma_alloc_coherent(vdev->dev.parent,
>>> @@ -908,14 +938,14 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>>       vrp->rbufs = bufs_va;
>>>       /* and second part is dedicated for TX */
>>> -    vrp->sbufs = bufs_va + vrp->num_rbufs * vrp->buf_size;
>>> +    vrp->sbufs = bufs_va + (vrp->num_rbufs * vrp->rbuf_size);
>>>       /* set up the receive buffers */
>>>       for (i = 0; i < vrp->num_rbufs; i++) {
>>>           struct scatterlist sg;
>>> -        void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
>>> +        void *cpu_addr = vrp->rbufs + i * vrp->rbuf_size;
>>> -        rpmsg_sg_init(&sg, cpu_addr, vrp->buf_size);
>>> +        rpmsg_sg_init(&sg, cpu_addr, vrp->rbuf_size);
>>>           err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, cpu_addr,
>>>                         GFP_KERNEL);
>>> @@ -1001,8 +1031,8 @@ static int rpmsg_remove_device(struct device 
>>> *dev, void *data)
>>>   static void rpmsg_remove(struct virtio_device *vdev)
>>>   {
>>>       struct virtproc_info *vrp = vdev->priv;
>>> -    unsigned int num_bufs = vrp->num_rbufs + vrp->num_sbufs;
>>> -    size_t total_buf_space = num_bufs * vrp->buf_size;
>>> +    size_t total_buf_space = (vrp->num_rbufs * vrp->rbuf_size) +
>>> +                 (vrp->num_sbufs * vrp->sbuf_size);
>>>       int ret;
>>>       virtio_reset_device(vdev);
>>> @@ -1015,6 +1045,7 @@ static void rpmsg_remove(struct virtio_device 
>>> *vdev)
>>>       vdev->config->del_vqs(vrp->vdev);
>>> +    total_buf_space = ALIGN(total_buf_space, PAGE_SIZE);
>>>       dma_free_coherent(vdev->dev.parent, total_buf_space,
>>>                 vrp->rbufs, vrp->bufs_dma);
>>> @@ -1028,6 +1059,7 @@ static struct virtio_device_id id_table[] = {
>>>   static unsigned int features[] = {
>>>       VIRTIO_RPMSG_F_NS,
>>> +    VIRTIO_RPMSG_F_BUFSZ,
>>>   };
>>>   static struct virtio_driver virtio_ipc_driver = {
>>> diff --git a/include/linux/virtio_rpmsg.h b/include/linux/virtio_rpmsg.h
>>> new file mode 100644
>>> index 000000000000..6406bc505383
>>> --- /dev/null
>>> +++ b/include/linux/virtio_rpmsg.h
>>> @@ -0,0 +1,24 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>
>>
>> Echo Arnaud's comments. If it is intended for UAPI, please keep it in
>> include/uapi/linux
>>
>>
> 
> It's not intended for UAPI. I need to fix the license. I will check 
> other virtio headers in the same directory and fix the license accordingly.
> 
>>> +/*
>>> + * Copyright (C) Pinecone Inc. 2019
>>> + * Copyright (C) Xiang Xiao <xiaoxiang@pinecone.net>
>>> + */
>>> +
>>> +#ifndef _LINUX_VIRTIO_RPMSG_H
>>> +#define _LINUX_VIRTIO_RPMSG_H
>>> +
>>> +#include <linux/types.h>
>>> +
>>> +/* The feature bitmap for virtio rpmsg */
>>> +#define VIRTIO_RPMSG_F_NS    0 /* RP supports name service 
>>> notifications */
>>> +#define VIRTIO_RPMSG_F_BUFSZ    2 /* RP get buffer size from config 
>>> space */
>>
>> May I know why skip bit 1?
>>
>>
> 
> Thanks, that's a good question. I keept id 2 unmodified from the 
> original series. I don't know why ID 2 was chosen in the original 
> series. I will have to discuss this with the linux remoteproc/rpmsg 
> maintainers and choose the correct ID.
> 
> I don't see any problem choosing ID 1, but for some reason if ID 1 was 
> assigned and deprecated (I don't think that is the case) then only we 
> should use ID 2.


The ID 1 was proposed in an openamp PR [1]. If we
enter VIRTIO_RPMSG_F_BUFSZ first it makes sense to set its ID to 1.

[1]https://github.com/OpenAMP/open-amp/pull/160/commits/d4a13128f94e46180285c05a20da78fdca54f7d7


Regards,
Arnaud

> 
> 
> Arnaud, Mathieu, Bjorn any input here?
> 
>>> +
>>> +struct virtio_rpmsg_config {
>>> +    /* The tx/rx individual buffer size(if VIRTIO_RPMSG_F_BUFSZ) */
>>> +    __u32 txbuf_size;
>>> +    __u32 rxbuf_size;
>>> +    __u32 reserved[14]; /* Reserve for the future use */
>>
>> Should we use __virtio32 instead of __u32 to avoid endianness issues?
>>
>>
> 
> Sure, if that is the standard in other virtio headers I will modify it.
> 
> Thanks,
> Tanmay
> 
>>> +    /* Put the customize config here */
>>> +} __attribute__((packed));
>>> +
>>> +#endif /* _LINUX_VIRTIO_RPMSG_H */
>>
>>
> 

