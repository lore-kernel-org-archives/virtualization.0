Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6E5C43334
	for <virtualization@archiver.kernel.org>; Wed, 15 Jun 2022 00:47:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AFFC60AF6;
	Wed, 15 Jun 2022 00:47:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pZNCwipBMLvw; Wed, 15 Jun 2022 00:47:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD4F960ABE;
	Wed, 15 Jun 2022 00:47:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75E97C0039;
	Wed, 15 Jun 2022 00:47:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1450C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 00:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB5F083388
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 00:47:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="qc8P4AkL";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="eC79csK4"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x1wXREJHJSQC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 00:47:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B860283385
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 00:47:03 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25F0T8EO002771
 for <virtualization@lists.linux-foundation.org>; Wed, 15 Jun 2022 00:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : from :
 subject : message-id : date : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=tyPc9z9AP0cwSTZmeV083G/xu5FqLGsFR/e3N1JHJdM=;
 b=qc8P4AkLrAmUW/VS9EXSv6InZVv62wjYmbR/3HB0dIMt7cJC+lpiyHmCOweq/sXAmvl+
 47N8YO1Gxct4RFXjGZwISUd/wmKL2IZId4u1Ag1OeVLtqaphte7QgcyF+VOaKO2RWpcu
 LzanyY18YGghy4hY9MWviCCprAPXfAmdZmUdcYSfJBMYSuvUjeh8q4UEeDKOvcI2qPrF
 +Ms9olJsxcKPlvJrmUXsGLb+RJxWL7vw90Gl2jjNobTH6rlh4d3xfh30rcdt4X4r+fMx
 9KujaGjL5tbEKtnr+Rl263YaDlOt+jTUv+p0PyhieJjDH1bWtSHLWFHTIZ2y6NSJePS7 gA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjns7876-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 00:47:02 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 25F0UVVa018784
 for <virtualization@lists.linux-foundation.org>; Wed, 15 Jun 2022 00:47:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3gprbr7c4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 00:47:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGP0m3dU6AI0qTt77qN5Mqvt8W6Zj0jIDvAlvXZ6WT9uI4cjYJU82JwOUUL7puR3Dp54ryssRiHC7D51o7/jPEDU9xAwnhCCRuSH6JD9/3cI6rxIph4aJHqGCVJ8MT7h1/2YSumtv96OfJQkszlolEhJMg7tSKMVMu8vnYDa4We/affsQN+xfjy6ALtHaDQ7vwQFfJAlxGsVTCuJ/LGSK8ZDH/pXL+iWT2yQD08gLm+/61tpUk+H440zaJSHWpGtQS9SKmjiKt2cssl8isq4pDF5qQ7+pCOJ3oCJSey9Wj9I9Fb33bVAVxfqa3y+dt6b364n4XLNJ5Io0J0sno3I3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyPc9z9AP0cwSTZmeV083G/xu5FqLGsFR/e3N1JHJdM=;
 b=JfOqoQzQuMeq0xVP37gegEMfN2ROa/FbNnWZXlXd3SpsAWr/R/wG0u3f/+0Hs8it3tVt99bty2+PBjbd5ETe24Ofo4A3PXf0Vn/ZNoHzAzf0OI6Zl7z2WH+5dKh+90lYhuXEjYefNJKRbAfnNe2cllMEVZHzBKmCSDVLPg26EgLOUMOvniRA4c5RhxjAl963yPMQnviU9+g4I5fjgR72Usi7bPBK8oSx8YA/CzcC1ik8Fa43SBqhQ8pe/sbSzIbRd2EYkQMAhDV4FsslTqRo719nHmP9l7KN77L6MBkDc6rt0mBQK8ar2avV9HAb2jLKcjkkNWOwXjZWy05pOC6D6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyPc9z9AP0cwSTZmeV083G/xu5FqLGsFR/e3N1JHJdM=;
 b=eC79csK4HiTooQaKt6HqDDF5GMyyq+sFce0N/ycagFmiQJVnfv8j3eS7jdBP0UqqU8a/UQIzRNNJCVBBerBZdyf353K5fagK6IwqaxIUMYTd5B3rJNCQXRtWBp8QBJiCz6eO2i7BfWJa7V8HW968eL5nMbhWOMdj7CRjrktD2Y0=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by CY4PR1001MB2309.namprd10.prod.outlook.com (2603:10b6:910:3f::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 15 Jun
 2022 00:46:58 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::60b7:5604:cc5d:54bd]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::60b7:5604:cc5d:54bd%5]) with mapi id 15.20.5332.020; Wed, 15 Jun 2022
 00:46:58 +0000
To: virtualization <virtualization@lists.linux-foundation.org>
From: Dongli Zhang <dongli.zhang@oracle.com>
Subject: Question on vhost vq->signalled_used and vq->signalled_used_valid
Message-ID: <e44f52db-cdee-58fd-0c6f-a003ee816e31@oracle.com>
Date: Tue, 14 Jun 2022 17:46:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Content-Language: en-US
X-ClientProxiedBy: SA9PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:806:28::29) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb5abae7-a3ab-4fe3-4ee4-08da4e688d9c
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2309:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB230900F3B62835E664681B04F0AD9@CY4PR1001MB2309.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLiEviqRPqTzd1k3dOBy6K1fwomsoUuppev5FUhYfUXcSgr5Cqbj27G/64QDd4uog9aH5jML+9EYtJq8Xrom3+jXad2hwMUl6VEUV6khMxsZrxsLG4Fm1RK6mcQlUSqZtEgdkXTuMHRguNQHcXuBgJS9yWk4zdOk9Ihsu00b6yKNNMZA4RCnrwwYFnJIHtMgfhKqabAseQ89uDiTLpxjI3rCkpnDm5+yKDTsPd41QZ6FbwYdVAiCVEQz0hAfsSgEkednUZoTvqF/DY+x7xSorvwI/tXkwt3fQas2OP++HKpxO2lXx/FWtiw0I4crOAfN6FGhU8QS1g/C69K9eid50RFTVhAfoubsRLxRI0e7xy1NNJWvGm+jjAWOJXY52Ke6zKj6qDTpK8M2n6aabsfhM3SXa1YaSvKOqAu+2bAWUBhQ1yUsT6W4Wj0k+hTKybvsVQfNmMnE8tsFOT5lX6OZgdJB/CRKt3obo4KNUpJlxKwLkkGqdpfZadyQVqERgwKchb+zKBW54oEBAb+EgaOYyPdSSkWZJloggik26A7KNuXOKlChHk1xh6f1I6zEsbJ6BNL/OeEVpUcPwyYYApdIFDRvFkHFolnzPl8k8iDajY2Bw079NOVJ8aSu4Ub5wQ8Yr7dZ/iJDBX4Av2N5Jzl4L3fX4LzaSjmerzRmaHvsZgPVWcusVfFW3z0H5fTTbaaSPhusjuI9fCG+4DM960CKs49dsPpa1Ij3BR+dTWYcNh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2663.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(2906002)(6666004)(44832011)(5660300002)(107886003)(6486002)(8936002)(66556008)(66476007)(508600001)(83380400001)(66946007)(38100700002)(4326008)(186003)(8676002)(31686004)(6506007)(36756003)(86362001)(6916009)(2616005)(6512007)(316002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzIyYkRaQlZ3aXV6dDBZMDBZaTVPZDY2VjREaFpXMG1YOE5yZjhFZWd3WEdO?=
 =?utf-8?B?TXhzQUoyMnhINHhSa1MrakJ4cmFKNW1XNlBLdnMrU1hEdDJaVFg2ZWZhQVRE?=
 =?utf-8?B?NGpHYnVTa1Zad3BFYzlBcFoxYTczS05DWVBCZHZsVm9ud2FwQVQvVFJhQkZ3?=
 =?utf-8?B?bElDM1NlN3k2eFRaZ0doTFpjczc4andpYWVmZkVSUE0vWXV4WmhzNjJXRzA4?=
 =?utf-8?B?azFQczBwZlRJaXRQWUZBbVdXLzFneXhDVEViVmVYMnM3Z0x3YVVpUi9nT2RI?=
 =?utf-8?B?bmxKSUdMcW9td0hHSEh6UGE1VytJaXVzSlNCRE5JNHQvZWt0Yms4czRHMDN6?=
 =?utf-8?B?dk01OElJcEtpalBqWnpxWTJSdmZtb1JiN082L3ZualRFenJ3bmh4cXA3WFNB?=
 =?utf-8?B?RHhZZ3F0RFhoL2dNVHFYRU1OU0k3VkZEMGZPR0dWS2hVdXdiak1aQjI5Y0NO?=
 =?utf-8?B?OEViZ2YyTVhOSW55dDdLNTl0aFI2WkkyMnk3emd1OCtaakNaR2tNS0lGd1k1?=
 =?utf-8?B?c1JoYUpmUm9hanozSWNXRDY1SzJITnBNRTI3WTRZQ0VMNWgwbjJCNUdvTWNq?=
 =?utf-8?B?Z1NzOFUyVktDRHo0L1lpM1liMXpqQUVyVEcrQUVnN3d3THVmaXp1Vm4zWG9I?=
 =?utf-8?B?eHc1SWRvNkwySjhRd3NWNVlUNm90WDhtZDJKZWRUZis3bEdESEJXQzcwQ201?=
 =?utf-8?B?SVdRUmlEbU4zTVZibWd1bnR2aGhiTWdPeGpSVEh6VHZ3YlJ2L3pnM3FueTE0?=
 =?utf-8?B?MVYrMFBxWll2M3NCb3dxN2x2cDBHang0ZFdJRkRSeGEycHMwNnFFUmlHclQr?=
 =?utf-8?B?T1ZlbjhrdzFHeDFENFVoTzZoWlFMRmRHWG0vTzlzUXdDVlE1MXNZc1Jwc3NT?=
 =?utf-8?B?d2NJT2tZNmxQRnl0YUtlVkFYY0Y5RTBpWUlacUxrNXcvRjF0ZGcxeFVtRHdX?=
 =?utf-8?B?TEN4dlJPMVNnTkZ0R1doZ0VHcVZodHVKYXlhSE8wcjBHQVdEQkN1U0thSEFh?=
 =?utf-8?B?Z0J4c0djTTNiRmljbHl6d08xNGJDR0ZtejRtMEZhb1IveitQaVBocUlBYVNM?=
 =?utf-8?B?a05WNjlvVXluMGE0TC9ibVpFQWNsRDhudnlSTUwrZnM2dm9ObkxENVZvNDhX?=
 =?utf-8?B?RC9NSDJLYzd4T2RKY0EyRFJMelVqaDFNcUd4MjF1R2F4V2JaekJYUjY4eXVX?=
 =?utf-8?B?UkhvWXVuY1RsOE4vWjNZNE9PeEZ4Q2VScEdZdFI1MVdDOWNScnV0eTFaWHZF?=
 =?utf-8?B?MU5Ba0dsc05HcWkrVk9BTWNWVUpwZ1RhZ1RaZ25nZTBJb2RzNGFzSEJlZ3FF?=
 =?utf-8?B?WWZyelhLbTlOTUpaVys2VVVjbmh2dDYxTlNWLzRmalZJNUlSR3VzV3VtSG90?=
 =?utf-8?B?RGxBODNEb0F2YzhHM2UzZTdJOXhkTlY2bHZkV0R0VjRPclBjNnAwQmsraU81?=
 =?utf-8?B?ZjdTUWVjc3lJd0hJQmg4K2J6ZzVmckduM0F1S0dDbWVSRjlKcnl1THlLTmVM?=
 =?utf-8?B?anQzbjZtenlmRGg0RGZhTjNqQ0ZEL3hmMnZRaC9od3VlUis2T1NEdlFBZ1o3?=
 =?utf-8?B?Yk9qVnZhaW5nMmlNZzIyMzVVZ2hEZ0xaR1RTZHJpVDlMR3E0MXArMGhyNlNI?=
 =?utf-8?B?TFJvOS9NZVRLK0NVWmFxNVJJaGYzZmpwMEtqVmN4UHliUWsrNnF2TmdkUzVX?=
 =?utf-8?B?Qnh6QVpCYWl2ckNaK2pHYmtKajMyZ1BzNTErNVZpOUhaMDZnN1VqNGQxdHRR?=
 =?utf-8?B?YktaeHUwb0FUOTZyOWU4eFh0K25kL09tV2VWb2JwWUUrL1ZPQndnSU55WXA2?=
 =?utf-8?B?WjM4SUI0OUluL1NYWlA5VjY2b0dYOE9yeU5ldlpGK0sxWldTcWhzampTcG0v?=
 =?utf-8?B?ditBK01DNUtPd3RCOWdCSkR2V1V4VnBzWi9wU2FRYkUyOUtJZlR1TFJnRUJE?=
 =?utf-8?B?OHFuanJFOEVEaUxXNzRZVGtLM0tCNDZVeC9aK2o1UmhGTTUrZUtjYUdKdXZs?=
 =?utf-8?B?L3Q2VWlGd2NFN0NYOU03NThoS1YvVU9paTYzWkYrQlhZbjhVZWZMTW84YXo0?=
 =?utf-8?B?RWhmMHhTcG56T25sWXRvYUk5L296SklEU0QzbFNNUHhlUDZUOWJPWUd6emp2?=
 =?utf-8?B?MGcwMjhBdVFJN2xiMDdxNmNVRmNxNVJvMHp5RHJEM3doWi9GdWVrZE9CT3Fx?=
 =?utf-8?B?WnNVbVVSWTQ0RlpIS0llK0FtZ2JsbkFpeUFFT1E2Y05TeVhoWWpEN255blow?=
 =?utf-8?B?M3JRRmR0R1JHVFJmUkk0K3U1L0ZkakpkOXFSN3lPRGUxMWdHMGJaNEJZdytp?=
 =?utf-8?B?dXlxMm1WUkM0RVpuTXF5NkNXZGlTQ0x3YzB4djI3ZDE1elFMWkJpL2pLbXlK?=
 =?utf-8?Q?jAMQ2aUwTc3JIG5z7bJil2XM11ZRgZiAYc/7K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5abae7-a3ab-4fe3-4ee4-08da4e688d9c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 00:46:58.7930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABC1zKumBWlBgnFHNhb11fjIpK0K5CerjtkS2ahLYIn7c+O52QAsxxhHNcHugA+Yn1nYWKS+0XjOXK5asX2wEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2309
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517, 18.0.874
 definitions=2022-06-14_10:2022-06-13,
 2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=743 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206150000
X-Proofpoint-GUID: Hn1tJVl-pj36QYVI8_opUn3Dnj1NW0Mv
X-Proofpoint-ORIG-GUID: Hn1tJVl-pj36QYVI8_opUn3Dnj1NW0Mv
Cc: Joe Jin <joe.jin@oracle.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hello,

May I have a question on vq->signalled_used and vq->signalled_used_valid?

According to comments at line 2395, "If the driver never bothers to signal in a
very long while, used index might wrap around. If that happens, invalidate
signalled_used index we stored."

(BTW, I see QEMU-7.0 uses int16_t at something like line 2399 and I am thinking
about why)

2372 static int __vhost_add_used_n(struct vhost_virtqueue *vq,
2373                             struct vring_used_elem *heads,
2374                             unsigned count)
2375 {
2376         vring_used_elem_t __user *used;
2377         u16 old, new;
2378         int start;
2379
2380         start = vq->last_used_idx & (vq->num - 1);
2381         used = vq->used->ring + start;
2382         if (vhost_put_used(vq, heads, start, count)) {
2383                 vq_err(vq, "Failed to write used");
2384                 return -EFAULT;
2385         }
2386         if (unlikely(vq->log_used)) {
2387                 /* Make sure data is seen before log. */
2388                 smp_wmb();
2389                 /* Log used ring entry write. */
2390                 log_used(vq, ((void __user *)used - (void __user *)vq->used),
2391                          count * sizeof *used);
2392         }
2393         old = vq->last_used_idx;
2394         new = (vq->last_used_idx += count);
2395         /* If the driver never bothers to signal in a very long while,
2396          * used index might wrap around. If that happens, invalidate
2397          * signalled_used index we stored. TODO: make sure driver
2398          * signals at least once in 2^16 and remove this. */
2399         if (unlikely((u16)(new - vq->signalled_used) < (u16)(new - old)))
2400                 vq->signalled_used_valid = false;
2401         return 0;
2402 }

However, although the vhost signals the frontend virtio *conditionally*, the
vq->signalled_used is always updated at the end of vhost_notify() at line 2465,
no matter whether line 2475 returns true/false.

I did some tests but never see line 2399 returns true.

2441 static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
2442 {
2443         __u16 old, new;
2444         __virtio16 event;
2445         bool v;
2446         /* Flush out used index updates. This is paired
2447          * with the barrier that the Guest executes when enabling
2448          * interrupts. */
2449         smp_mb();
2450
2451         if (vhost_has_feature(vq, VIRTIO_F_NOTIFY_ON_EMPTY) &&
2452             unlikely(vq->avail_idx == vq->last_avail_idx))
2453                 return true;
2454
2455         if (!vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX)) {
2456                 __virtio16 flags;
2457                 if (vhost_get_avail_flags(vq, &flags)) {
2458                         vq_err(vq, "Failed to get flags");
2459                         return true;
2460                 }
2461                 return !(flags & cpu_to_vhost16(vq,
VRING_AVAIL_F_NO_INTERRUPT));
2462         }
2463         old = vq->signalled_used;
2464         v = vq->signalled_used_valid;
2465         new = vq->signalled_used = vq->last_used_idx;
2466         vq->signalled_used_valid = true;
2467
2468         if (unlikely(!v))
2469                 return true;
2470
2471         if (vhost_get_used_event(vq, &event)) {
2472                 vq_err(vq, "Failed to get used event idx");
2473                 return true;
2474         }
2475         return vring_need_event(vhost16_to_cpu(vq, event), new, old);
2476 }


Therefore, would you mind helping me understand what does "If the driver never
bothers to signal in a very long while" indicate?

How the vhost driver "never bothers to signal in a very long while" as
vq->signalled_used is always updated?

About the naming, why not use "vq->added_used" because the value is always
updated after something is added to the vring buffer?

Perhaps this is a silly question. Sorry that currently I am stuck on it :)

Thank you very much!

Dongli Zhang
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
