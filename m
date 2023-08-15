Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC270C001DF
	for <virtualization@archiver.kernel.org>; Tue, 15 Aug 2023 23:10:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57396820FC;
	Tue, 15 Aug 2023 23:10:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57396820FC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=iEADdVlC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=wPWrcEeB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ErD94dKzKiLm; Tue, 15 Aug 2023 23:10:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CB3B5820F4;
	Tue, 15 Aug 2023 23:10:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB3B5820F4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EEADC0071;
	Tue, 15 Aug 2023 23:10:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BEB5C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 23:10:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 53D2641B31
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 23:10:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53D2641B31
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=iEADdVlC; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=wPWrcEeB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dGY_a8ll6RET
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 23:10:06 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1B3CF41B37
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 23:10:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1B3CF41B37
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37FMlwU0001011; Tue, 15 Aug 2023 23:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8/23uyOJjF3ya8vBOv9xhvR16W44aB4YO0qRLq2aZik=;
 b=iEADdVlCSR5vu1DtRrW8LAs0qgBI1fnkoMKi1RRGHGJ0c1Dqs3zT+8G3jcOTWf3Y/Bgu
 WJ3L3elf082HYHYSoL8cv9L/RYjhrlE8X+GKpbwC827sJNpmnObUPX+sg1cL6TYEZWra
 LGijbnZhaVUnQ0DDTCBbr5NTJDP0efleUXcyWnKfWNakx1W49hsltX9nhcBvBBBjb2Ps
 3/6BNd5bvdP/1HGXOukcF68dcpRPx0EKdnh2qwbP5xsBr92nFMElFyIumd+CjBQ3CrB8
 F2+qYPashov2WvSpkH5tmw3/3F9XgXiOcxstUjv/lte3D+z+tArH026jxpNLSLvuXKfU sQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfntbf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Aug 2023 23:10:00 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37FLl6Fx003700; Tue, 15 Aug 2023 23:10:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sexyjed4r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Aug 2023 23:10:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=er75XkAuGjJiRDz2+00GldU6ihILqI3iYNdoTL33UtUQOwzoVWvCPssgAdwInG5mmgFCknlQOT6jOOsCfw9P3hdIkstCMcbT/MBBqGDdOecdStUqTqCleEYIbSvFcwMIYErBiBEIUpyCCBFw5XmP46quCFcGj8MsUknZStXb9a2xdKBWK6//Dn2sDub55NCs/+M7bm+fFukDJcbjxOezIM6ublhO0dbMiQL88GnEKRWTAV3/UlcPNckrGPpax0Gu7ow9Zn/ACsTm/6Fj7M2tF4Apu603CMzNfO3LGNERvEo8H2xsq+x2phrsFg5FX1xs30rtod/mDblYvJ+MTopDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/23uyOJjF3ya8vBOv9xhvR16W44aB4YO0qRLq2aZik=;
 b=B6Uu2gRKMlaTn7v0MdyP2+qWn+QCZYD4oWoOSSqTBRYlA2Urb3ZwnVO1IB2ivI90BeXZMf2ffZyDYTgOQK6n02owf8PSHHJ3+nfKM3NFQeWlZXJjxjkHQ1O3tiDFp/QUOf37BoJW6LWiDdBs6iaICkI1Bi8XvJmww0fZdPXNhFb3ov/L379o/p/cVgIJITIl5JRJC86Ah0qrQKHuKrnSxHlN+6F+uYfnk9v4bVPrmLSvSGzaVEtBwWJCHeMGF0leZnfuh0SpT3E3EelU+8WwtYTSuQ32V82YbHMW1fLPQFVEE1tnkZEwaoKSn+6QHspm3Tu66kq4W18juDVy0CY4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/23uyOJjF3ya8vBOv9xhvR16W44aB4YO0qRLq2aZik=;
 b=wPWrcEeBksM8ipQjPx/5Um1yz/yoQXccibrBSyUVmdJPP3xaLQW8riVpWJb2VFEo8ZcsfH/bK/vVHDwJk+ObFS5vFIWZDhDUN8CQCFkMXpDQBu4CdG16pyv+0TgODPXaDE9ilLPfAczixKS6QgJo3e2ARORWpdOH0/bQt45RrdE=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH7PR10MB6602.namprd10.prod.outlook.com (2603:10b6:510:206::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 23:09:58 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 23:09:58 +0000
Message-ID: <19466c8d-7e61-c95d-4ecc-130bd9920483@oracle.com>
Date: Tue, 15 Aug 2023 16:09:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 3/4] vhost-vdpa: should restore 1:1 dma mapping before
 detaching driver
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-4-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvrg0qA6=E-5WJL79XAdO3SpSr=rumsyYMW4a-7tZkD8Q@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvrg0qA6=E-5WJL79XAdO3SpSr=rumsyYMW4a-7tZkD8Q@mail.gmail.com>
X-ClientProxiedBy: BY5PR17CA0064.namprd17.prod.outlook.com
 (2603:10b6:a03:167::41) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH7PR10MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 5addcbaa-014a-49f7-64f1-08db9de4be79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0YdqtRz5yEfYqPByhzU8okSAX8FB7rexS3wr7rCIyGG2IsZ712wo7NW8IsDVdvZmeNE0kfMcHzwf8O7Kau50S41yCvy1KEzClkRzoU4RRmZuYW8AUEw8xW4puVhdMINdwKIfU/BjCPMfSwTSZqyX1jj9WHN3FH6tvrR68Wl+qKE+kW8b2GDPAZZnqI+88Fwi871jrMcVfir583IOaxkm9TQJnnKtfzBNr8xsXsGyKwWO2wO8Q6mNU0XQxYiRk7Lv8y4Kp64whpI+5yqE4XiwNXduk80JlEMuTLiVjuAxu3O9KG4RGd2ypy4HVrciv1LCGNVhXeMiUIuLqD1tzTpi72V5iouDOqRIbN3qed5QmEAyc+9mXn4rRJJLpSSYtn4Itc5TAUwQBjrA6dtRKn0wFprKBS4Iwp00FkrBXjW9sD1xsqvyFxLON5VQr3mHsF3r7b1AV2FMGdfPG9NP8kd/BACuyrrGiju78+Xdkcom7d5Ez/QtawbWwuBtTGwdxaPN6OejYvO95YSXvV5BJYiksWR58R/ILImfb4jxh9TRCh5axATrHsivTnZdHYbLK5jXybFoMlu3uIVvi1pezVxxIS6d/PHmuox0gM+X451eYJRm+8r6O/bb5UudJXz6VBdAcP+R+vDBowVYgMf6Y9N1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199024)(186009)(1800799009)(478600001)(86362001)(6486002)(2616005)(36756003)(31686004)(31696002)(6506007)(66476007)(5660300002)(66556008)(66946007)(316002)(41300700001)(6916009)(53546011)(26005)(6666004)(38100700002)(36916002)(83380400001)(4326008)(2906002)(8936002)(8676002)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWUxa2k1dFVNd0U4YU0yZmJwdzZOT3VtNndGYm11cTRwcnhaL1BsU09yNGYw?=
 =?utf-8?B?aVNzR0pQb3VsdEF3eXN5WWsyMFM3T2gwdjg0dVNuVk9vTllldU5CS1ZDUUxL?=
 =?utf-8?B?N1lYZUdGRStyRFdYb24wQkNwLzJCY1dVVm1lM1NmOGVlYlNRdXV5dTNWWkZU?=
 =?utf-8?B?R2dKbkxLWGpCSFIrSStqdmZsMTN2VlBuMDk4dU4wVkFxczExWTFFdERSOGs5?=
 =?utf-8?B?c2M3S25UWk9rKzR4OXhFNzNnNEc3NGNyNDI0OUsyNy9iTXd2N3ZKNVhGMm9E?=
 =?utf-8?B?YUwwZDBqaUNkdjJ6VEwrN2tKamR2dXJocDdscHNMcjkwSlp6OWV3ZkIxd1Z1?=
 =?utf-8?B?S0xkUVhjeU1obmlmVzI5bjhTalZvVmlwVVFTMEdaeTBMOVhRL0pIVTdQYW5U?=
 =?utf-8?B?NWI0cTloYThyOVBpcml3STk4d1pjVGNWenNKK1g0WTVnMzJUbXJZYWJSSW04?=
 =?utf-8?B?WC9Uc3JkQXRLQ3hwMnRDZzVRSXBvVCtnN2lNOGlyWWhSNmhsc0tFd014NHM1?=
 =?utf-8?B?ZzRLM0c3YXNobVVqVjNOd25PaWU0VHhYSCtYemF6WEp0cXBqZ1VnTi9pNnF6?=
 =?utf-8?B?T0wwczM3b1ZtdGFDS0lwajdHamdCR2hHeUo0TFBJRWFCWXNGQytlV1gxaW5K?=
 =?utf-8?B?bE9tbjZ4Q1c4cTE0Ky9xeTFwTDZrYjQyT1ZmUGlqbC9WYXpteUV3cm5uUEg0?=
 =?utf-8?B?bGk4ai9SemJIU2x2TlMvTU1NNmQyV2ZsaU45OVJxMHNaT3pWZm5RT3lYaTZp?=
 =?utf-8?B?Qmt0dWRxY0t1ZFJuNjZCN1hab0c3L3E5QnV1NUh6RHpCTzBGV2FrUFlrT1cz?=
 =?utf-8?B?dGVBTHYxaGFWY0Vvd1MydlQ3SFBJUWZCMytIR3Bsc1FLYjBqMVRseVIzenZW?=
 =?utf-8?B?eXRBejFqR1NKcFJncmQxZnE5WkpRS2Y4bjF0Q2REWHVIRC9pdjhxaWRFZzBR?=
 =?utf-8?B?UWEwNWdlRUEwSzdvdnZ6dWlDQzNQVXdUaHZFWDgxTHF3MUpwZmZ1a1BRTWVG?=
 =?utf-8?B?Y1RJbmRHWHQxWUc5N3ZWSjZZanRBd1lBSzRGMU9RZlhuNWVOeXVia1NRVDRs?=
 =?utf-8?B?M015dWJQcTlVdEx4eHkyZDBSK3pQbXR6TUN5blk1UEJCUWV2ZHVBNnNaejR4?=
 =?utf-8?B?RG94a0V0Q3BrVFdNdmxkQ0IwN1dxTjlQNy9DaFJnaGU1b3hUcWs3N3o5UWRE?=
 =?utf-8?B?eXFadFZ0WGZrS1hQUHc0dkk2Ty9Ca3FqeHU4NlpzR1AvNzFUUGd0QnRLU3Bu?=
 =?utf-8?B?eCsvLzdIWEkzLytabWVEamFRU040WTgrMnYxS3ZyWStYcUQrOGxidy9VYUFX?=
 =?utf-8?B?a3AxbVFOVFNPc3QrSmtZeDhOaHZTYXJ1M282T08xRWpUQXFLZFVZckF2UFQ5?=
 =?utf-8?B?MXVxcjB3T3ZQWGFGL29FNk9naDdvdExsVGdQdDMwZ1l0RXp4TXUvQlJXSGdH?=
 =?utf-8?B?WDZWdm42alp2ZlFpdkRLa0F3VU1zZ0plVEZxR2dJbjE4U0t5SWpOUGllQy8w?=
 =?utf-8?B?RW9FeERwMmZNQUNFWXFVMUpGdkVNNEp0TXg3YXZ2U29xSGRMVkJQNldYVHBi?=
 =?utf-8?B?K3MxZis5OGJaT3lXZ3B2bkI0b0s3cCs4ci9NN1hrNDFTTzJ3WCtTRXdJbHZR?=
 =?utf-8?B?dC81dW02OVdKdEhWODY5OFlVeXVzS2wzN1lkelhWV2lZUkFubFBYT0N2aWpK?=
 =?utf-8?B?a0M0N1VjeTlRSi9sb2E1Vlp0TS9OSHFwcXNXOUJjS05Ia2ZKRXI5Ymw4Vm0r?=
 =?utf-8?B?NkpoREdXQlNEUmFGbEcvQ256elhTSDZkVXZxOVNleWhkN2ZlTEhXMnRGdTd4?=
 =?utf-8?B?UmtJRS8rbE9kSlF6UGMzQ2UxZTM5YjYzTjdiMVNUUUtkd25SRExROXJTT2Jo?=
 =?utf-8?B?TEM3N3hSQ01xejRsaGMraU5ud1dQSEZMQksxK3NGL2hBeWRtejl5Wm5DYUps?=
 =?utf-8?B?MGNsTVM2LzR5NHY5ckpoc2Rpd0FuMmQyUFNHK2VyWm9TdnZ6eHBpeHc1Yng1?=
 =?utf-8?B?R05BZktDcG5wNmlsaXpQMHRqNXhReEdoRG5tdFZKTElhR0x5SXQxbVBXRzZq?=
 =?utf-8?B?V01XZVJRbU9sQzZDcUwxbnI5R2Q0RHRpTjgzN1BoWWs3bHJpSkpKL1V3K0xi?=
 =?utf-8?Q?1Wjz4w/j5LGwDEcjxBNFXevJN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NDgvVGhRQmpuMXBtZXVpeVF1Z0RJZTVURGhxZ1p2VWNXWEdBc1UwMGFIYXZZ?=
 =?utf-8?B?emFudlBsZjkxZ3BremtXVm9YQXY1dmNlTWFaSjFFOGYvanhXS0pTcXQ5aHkv?=
 =?utf-8?B?QWlJcWIrRzJpd2l2NGdMaVM1cFk2WlNHVHlVSFpxQnBscnZxZ3dNa2piZG5k?=
 =?utf-8?B?WmQvd1NFbHR6TG9HcmN4VjV5V2lPMEFxNFBDMGJxR3owM3ExVmx5SEtjcVBR?=
 =?utf-8?B?dy8wcXZHUnZKK2VZSGlsZG9DNzBzZ0NibW5LMHlYWkJOZ09nbWFqa2NJRVl0?=
 =?utf-8?B?NTFqRGtGcFVWVnRYZ1RnK25qRXU1SThtLzdlckJqZkJCZHcxeWtxam11ckN1?=
 =?utf-8?B?aHJiU3oyZ0FqZGhkeGRZSkVTTE1HenNlQWthYVZrQ1MwajRpcitkb1VPeG11?=
 =?utf-8?B?c3Z5RGpPQTZWNFRWZldrODVZOExveU5tbzZYVVFVUVlZZjZ1UnM4Sk9JaFpP?=
 =?utf-8?B?YnhRRlJKL0xRODZEY1R3WXpzaTBBUGRnY3dXU2I1YlE1MTMybFR4b0hvS0Zi?=
 =?utf-8?B?R1RjbVdMUFdkR0RNTCtOVVFpcXZqaXhOdnp4ZnQ1VWJRUkRja0lyUmY3OEY1?=
 =?utf-8?B?MVVQMGo3eDJFTW9TUno4T1JqZUZwYlh2RUszQzVWdzhCU1dXZGZXZWJpMmxz?=
 =?utf-8?B?cmJTdmM3UXd3TFNoMXZoZFlVOEhsdzFkb0RHd3c3dXNlODlkUVRUeWFFckxT?=
 =?utf-8?B?Y2x5Y2crRU8zaHY4ekVNY3EzYzJDUXJpV3JVdW1YS3FlK3RHZ25QV0NwdW1F?=
 =?utf-8?B?alpHRVpBREU0RGEyTE5QeVZBSmpIMVBBdHJvQW1IRjlHRC9KeUpCOFpmRGpa?=
 =?utf-8?B?RFNFdUs2cVhYeFZucmlRUDJETTd1N2VhQmJGRktCY0ZZb096SG9BUHVqcC9F?=
 =?utf-8?B?cHM3SGRpRWJNVjFqSmg1MURhTXFPeGx3YnRZckszQkRIcm1vNEFIdVJHTVZl?=
 =?utf-8?B?Z3hsSE9kTGVCcUpRcUE3SDd6eXRtR0Q0TVlqR0NoTnlETnd5cnhnN2JJUlFI?=
 =?utf-8?B?OEtLdDNuMFFCUjJ2YnlWSzhBN05lRExrWUFDRG9Ba2hoNVp2TjVOTWx1bmJm?=
 =?utf-8?B?eWhQVll4Z2J0TTgwYTQ4NjBmQXFYbERmTkdMaUV0Q1poM1BQV0dINnU0TkQz?=
 =?utf-8?B?MEhlUEQ3YldGci9NVTNCKzQ4UXZPaHlURU5wSnRxT3lQQUxIRWpJVldmeXpE?=
 =?utf-8?B?N0dYVTErcDRwRVBPUko2UXhiOGtDVnJmblFxREZMV3FwTXdIbnJPTUcrNGhV?=
 =?utf-8?Q?IAUA3pU+EWU5yDa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5addcbaa-014a-49f7-64f1-08db9de4be79
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 23:09:57.8484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRDTRvxydGve7Ydgla6i5hdNvY1d8kEp6UiZHk7xKj0WkbTrF4POshF1sHNW4YMVlZJQ1PIV9tN28QUG8N1HPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_19,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150209
X-Proofpoint-ORIG-GUID: CmfDYp40ojgSZ20FRJeyYRBpGkDGCYD-
X-Proofpoint-GUID: CmfDYp40ojgSZ20FRJeyYRBpGkDGCYD-
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, gal@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiA4LzE0LzIwMjMgNzozMiBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBUdWUsIEF1ZyAx
NSwgMjAyMyBhdCA5OjQ14oCvQU0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPiB3
cm90ZToKPj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29t
Pgo+PiAtLS0KPj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDE3ICsrKysrKysrKysrKysrKysr
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4gaW5kZXggYjQz
ZTg2OC4uNjJiMGEwMSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4gKysr
IGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4gQEAgLTEzMSw2ICsxMzEsMTUgQEAgc3RhdGljIHN0
cnVjdCB2aG9zdF92ZHBhX2FzICp2aG9zdF92ZHBhX2ZpbmRfYWxsb2NfYXMoc3RydWN0IHZob3N0
X3ZkcGEgKnYsCj4+ICAgICAgICAgIHJldHVybiB2aG9zdF92ZHBhX2FsbG9jX2FzKHYsIGFzaWQp
Owo+PiAgIH0KPj4KPj4gK3N0YXRpYyB2b2lkIHZob3N0X3ZkcGFfcmVzZXRfbWFwKHN0cnVjdCB2
aG9zdF92ZHBhICp2LCB1MzIgYXNpZCkKPj4gK3sKPj4gKyAgICAgICBzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkcGEgPSB2LT52ZHBhOwo+PiArICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19v
cHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKPj4gKwo+PiArICAgICAgIGlmIChvcHMtPnJlc2V0X21h
cCkKPj4gKyAgICAgICAgICAgICAgIG9wcy0+cmVzZXRfbWFwKHZkcGEsIGFzaWQpOwo+PiArfQo+
PiArCj4+ICAgc3RhdGljIGludCB2aG9zdF92ZHBhX3JlbW92ZV9hcyhzdHJ1Y3Qgdmhvc3RfdmRw
YSAqdiwgdTMyIGFzaWQpCj4+ICAgewo+PiAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdmRwYV9hcyAq
YXMgPSBhc2lkX3RvX2FzKHYsIGFzaWQpOwo+PiBAQCAtMTQwLDYgKzE0OSwxNCBAQCBzdGF0aWMg
aW50IHZob3N0X3ZkcGFfcmVtb3ZlX2FzKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1MzIgYXNpZCkK
Pj4KPj4gICAgICAgICAgaGxpc3RfZGVsKCZhcy0+aGFzaF9saW5rKTsKPj4gICAgICAgICAgdmhv
c3RfdmRwYV9pb3RsYl91bm1hcCh2LCAmYXMtPmlvdGxiLCAwVUxMLCAwVUxMIC0gMSwgYXNpZCk7
Cj4+ICsgICAgICAgLyoKPj4gKyAgICAgICAgKiBEZXZpY2VzIHdpdGggb24tY2hpcCBJT01NVSBu
ZWVkIHRvIHJlc3RvcmUgaW90bGIKPj4gKyAgICAgICAgKiB0byAxOjEgaWRlbnRpdHkgbWFwcGlu
ZyBiZWZvcmUgdmhvc3QtdmRwYSBpcyBnb2luZwo+PiArICAgICAgICAqIHRvIGJlIHJlbW92ZWQg
YW5kIGRldGFjaGVkIGZyb20gdGhlIGRldmljZS4gR2l2ZQo+PiArICAgICAgICAqIHRoZW0gYSBj
aGFuY2UgdG8gZG8gc28sIGFzIHRoaXMgY2Fubm90IGJlIGRvbmUKPj4gKyAgICAgICAgKiBlZmZp
Y2llbnRseSB2aWEgdGhlIHdob2xlLXJhbmdlIHVubWFwIGNhbGwgYWJvdmUuCj4+ICsgICAgICAg
ICovCj4gU2FtZSBxdWVzdGlvbiBhcyBiZWZvcmUsIGlmIDE6MSBpcyByZXN0b3JlZCBhbmQgdGhl
IHVzZXJzcGFjZSBkb2Vzbid0Cj4gZG8gYW55IElPVExCIHVwZGF0aW5nLiBJdCBsb29rcyBsaWtl
IGEgc2VjdXJpdHkgaXNzdWU/IChBc3N1bWluZyBJT1ZBCj4gaXMgUEEpClRoaXMgaXMgYWxyZWFk
eSBmbGF3ZWQgaW5kZXBlbmRlbnQgb2YgdGhpcyBzZXJpZXMuIEl0IHdhcyBpbnRyb2R1Y2VkIApm
cm9tIHRoZSB0d28gY29tbWl0cyBJIHJlZmVyZW5jZWQgZWFybGllciBpbiB0aGUgb3RoZXIgdGhy
ZWFkLiBUb2RheSAKdXNlcnNwYWNlIGlzIGFscmVhZHkgYWJsZSB0byBkbyBzbyB3aXRoIGRldmlj
ZSByZXNldCBhbmQgZG9uJ3QgZG8gYW55IApJT1RMQiB1cGRhdGUuIFRoaXMgc2VyaWVzIGRvbid0
IGdldCBpdCB3b3JzZSBub3IgbWFrZSBpdCBiZXR0ZXIuCgpGV0lXIGFzIHNhaWQgZWFybGllciwg
dG8gYWRkcmVzcyB0aGlzIHNlY3VyaXR5IGlzc3VlIHByb3Blcmx5IHdlIApwcm9iYWJseSBzaG91
bGQgc2V0IHVwIDE6MSBETUEgbWFwcGluZyBpbiB2aXJ0aW9fdmRwYV9wcm9iZSgpIG9uIGRlbWFu
ZCwgCmFuZCB0ZWFycyBpdCBkb3duIGF0IHZpcnRpb192ZHBhX3JlbGVhc2VfZGV2KCkuIFF1ZXN0
aW9uIGlzLCB3YXMgCnZpcnRpby12ZHBhIHRoZSBvbmx5IHZkcGEgYnVzIHVzZXIgdGhhdCBuZWVk
cyAxOjEgRE1BIG1hcHBpbmcsIG9yIGl0J3MgCnRoZSBvdGhlciB3YXkgYXJvdW5kIHRoYXQgdmhv
c3QtdmRwYSBpcyB0aGUgb25seSBleGNlcHRpb24gYW1vbmcgYWxsIAp2ZHBhIGJ1cyBkcml2ZXJz
IHRoYXQgZG9uJ3Qgd2FudCB0byBzdGFydCB3aXRoIDE6MSBieSBkZWZhdWx0LiBUaGlzIAp3b3Vs
ZCBoZWxwIHBhcmVudCB2ZHBhIGltcGxlbWVudGF0aW9uIGZvciB3aGF0IGtpbmQgb2YgbWFwcGlu
ZyBpdCBzaG91bGQgCnN0YXJ0IHdpdGggdXBvbiBjcmVhdGlvbi4KClJlZ2FyZHMsCi1TaXdlaQoK
Cgo+Cj4gVGhhbmtzCj4KPj4gKyAgICAgICB2aG9zdF92ZHBhX3Jlc2V0X21hcCh2LCBhc2lkKTsK
Pj4gICAgICAgICAga2ZyZWUoYXMpOwo+Pgo+PiAgICAgICAgICByZXR1cm4gMDsKPj4gLS0KPj4g
MS44LjMuMQo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
