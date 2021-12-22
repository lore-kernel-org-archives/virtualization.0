Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033DEC433F5
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 02:05:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95966415D5;
	Wed, 22 Dec 2021 02:05:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jYrFBCPJIslD; Wed, 22 Dec 2021 02:05:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 31703415A4;
	Wed, 22 Dec 2021 02:05:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15C62C002F;
	Wed, 22 Dec 2021 02:05:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2855AC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:05:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 156BC415D4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:05:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7_rfq7NZG3Zm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:05:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 09150415A4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:05:46 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLLE8EE009686; 
 Wed, 22 Dec 2021 02:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PFPVS0cYSCUlttcTuClE5LqtPiaKPaSohP053L/M4Qg=;
 b=QWEd4deyu8Qk5VPYWI6MbLAAsaLqcHNCzcSb5CIbkOiq+m/aD8S8zxjO9ywiUAkA72gn
 aW07tRmjmrmGlBLZUs9c45wZqPxNtvnsnrmASrUwDjXSBwQlWjbiQ93eWgF+WFbnW4XN
 fA1sPkgJdJmwiH6Nlabe3+n5T5yS/5+v2WM0lLT5cw2aWrdyYo5Qcfu6Bq/Yj1DpLE82
 dmNqZZ38o72j78XW+PV1eoEJEcJCSWaLz898FRpYvvkvxyezohH9WkdQhnrfuaBtDq4q
 QGZuhWToeOy9OiHniabX0uO1emq4W13SgDSdaN7vubykcIeeFr7nV5mo0meak+/NZ6lR gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d2qk2cvhr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 02:05:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BM1utW7075843;
 Wed, 22 Dec 2021 02:05:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by aserp3030.oracle.com with ESMTP id 3d15pe1q04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 02:05:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNSDkNEqojUNRZ1pM4nNAHX11MeU9xXe87VhVNJR6kRWwgKipfjrPXj2TimtequNotNkOorubkhFbYLBvTJtGLWCKf5RMgMp3M84J6KeGw1GnPcwGAoFFvb2If9T5fyyh5QZd1BHMboO+LzoptMs8lbnvlyYo9wT1px2Q2YgQulSboc+5I6CaBkUtQnQaNu46V5VTd7i1TV09Rtxtl3SXC1gl+jD65hhQiONMpeeLdQKscxm3oyeqYtckjW9auGNMK5GYwbwnmsWuwRxrDcDiNk9uiq1mmObAmHjkIfPl5gLcxUVxUzSGaxTJPgtpHETucVM/70pQfNjnBYtOzCIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFPVS0cYSCUlttcTuClE5LqtPiaKPaSohP053L/M4Qg=;
 b=X/V8MP8ieLEMQDBzBNjZj+K1UbOrZ82Zi75xQ27X9sy8cask1lJNhsja+O4TNn3ybLVQPteM0Ns1R5YIxVMoODtZuQGPqtA+0UQS2kcYC+1NOFnNj3JN15LGwy7D6Col/XsJTRBTzg+ovNJDoML0ZuoilwE1aYsuY/v6x3YeCYt1fqAH7JyF7b1hL/YabEG7KI1Id06LlxKp1Q3sn2SDZxb0P2AZ4MJz8ibVgsZcSfQM8ws4RTwcrqz7wQBLfCGXP/Q35Uw1byz+iq+ZorB2Atm3hb8YgvO/XYhED+BljMMgtI7fzW6zoXs9XTLM4KCLLGcz7mPUSn3hL2j1tYwYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFPVS0cYSCUlttcTuClE5LqtPiaKPaSohP053L/M4Qg=;
 b=ktH/ae3Cb1kDxFqDodwbHzdn9O33XJJFVo3kS8qXcr9td5itKzol3yQgMf1R4ML9KI/eDPHFGrAVYFr/32I0Ha+WNN8u+iQanZzSF3PLTUGxOtw0JWAkJzMuvQj2xMpKlNNPda8FdmSwznW0zFNlKTExclLjO875qhWTwlxi6QA=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB4308.namprd10.prod.outlook.com (2603:10b6:a03:203::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 02:05:43 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 02:05:43 +0000
Message-ID: <09539b97-22dc-6c67-1b51-35699a4bf85d@oracle.com>
Date: Tue, 21 Dec 2021 18:05:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 07/13] vdpa/mlx5: Support configuring max data
 virtqueue pairs
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211221172006.43784-1-elic@nvidia.com>
 <20211221172006.43784-8-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211221172006.43784-8-elic@nvidia.com>
X-ClientProxiedBy: SN6PR01CA0006.prod.exchangelabs.com (2603:10b6:805:b6::19)
 To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ca8b046-e2b1-41bc-df72-08d9c4ef8f38
X-MS-TrafficTypeDiagnostic: BY5PR10MB4308:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB43081387FD1385AB23B6B1B3B17D9@BY5PR10MB4308.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L5YWZpTUzrHqRxc49elRL2hMAbokCN7H7Xz/cV8vitk5XZ6waPdaU2SNwvGaumxlkVd8Hbv3efTpX8+DbPzQiRpCBAwyKJ9QMT66T60YBT4kfmbHW5h+cn23xdR3uHbg0viDsbDEutEi8BxsCJIT6HEopWk4WiKEdf626QYyb2bR8q/RhdFslEXZrbUO8ybdosZAI5zi9TI0NCyGm37/2MHkSeQZxYIamWZgUAVPljBpRi7bUg3Np2oUjXaeDX/LQaKeizJEFbjkTmZYLDeKCrWD2yeQs+/l42HmrZT5HdeOvM79wDzE6IUpBtgvYYlSZG9dLXfwgeOQropkfmsjLkA/OGvDGAJ4e+dLe6j2L/zewKPaVuwkUBfU3rjqr3hXudM1F0IfZBrrGXhCEJJRb8T6mOGqljSw4oxBJG++2TEL330WQaoJC9lQ2l7oQJsvS7hRewVP+N4TZ2BgNn9sD972vsSdPJ0/rzk2ShXOzbkfF7A6rDHNj7yHT3hpVzH4AbYw/1/FC38FvqdEC+bOgOJgtGcY2kupqn92WWQVlXMedzp8oCzjNqgb+uUcaxO4eZ5MXQ5TmVjRt04SBbn8ezC7X1cBddbo/fezdAOHb45AEXfBRTbqff+dczVeKElOp//LQDrsueh5Me7+hZH7FiYjKbwph9xpD0pFJFrScyvyyIDYJ5XLtijdJAdKwhB+/YtQgEj0zMOhOOz+qVV8f7apZ9mIlxQTKnDNBSOjQYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6666004)(6506007)(38100700002)(66946007)(53546011)(2616005)(31696002)(66556008)(508600001)(4326008)(26005)(6512007)(66476007)(5660300002)(31686004)(83380400001)(36916002)(6486002)(36756003)(316002)(8936002)(86362001)(186003)(2906002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEdUZEN5V2lvT2xHa21oWTNFRDlLaktOaFVjRmU0WFdlUW5pVmZCUTllS2ZK?=
 =?utf-8?B?Rk1KRitHOTA0L0x2NkQ1WVpXSEFidGZPMWpzOXh0WXlZb3VpY0V4NkZzUlZw?=
 =?utf-8?B?c2hPaWp5TzM1MTFPeFlGWlJoTWdkNE1CRDBidmYyMnB4M1NQWHBvNmcxTFRq?=
 =?utf-8?B?UlF3Vzd3RlBYSkY2OURubUZEekxHZU1FazNDYzd3Y0xMdlNQN0src3pHMXhY?=
 =?utf-8?B?V3FxZUtHd2JncExYeDdieFJ5VW54UnViNE9MKzJ5Z1VVeVlzTytIdDB6SWhO?=
 =?utf-8?B?c1JDQlpleCtuQzF3eFpSWjhadzBIMWdqZE5JaC85OFl2ZmV5M0tJUkJwcEFn?=
 =?utf-8?B?Z0ZtK2JsUnZXYWJzZTNtalgzSEFjYkU0d2ZsdWl3T2dsSTYwbE1XQ2FaTXln?=
 =?utf-8?B?Q2NyUXRDK0V0M2lGaFRKTThSeFZVMVdwNUdKNUR4MFpOTnFPc1BlWmdBSkJ1?=
 =?utf-8?B?ckdxQnJDWkxJdlVQODBqd2FYMmsva3dqT3U2TjlQOGlKeFhEMUJEZnp1ajh0?=
 =?utf-8?B?Q1NuVk90MXFWTnV5QUlQMm94bExIa3A2NU44V01VSXp1ZEUwc3lNMW9LRnNC?=
 =?utf-8?B?eWdQREhuaW01MFlZczhCazQ1MzVIWFZ5RjMrNkFkR0Z0NkRtUEcyVU1ZclpU?=
 =?utf-8?B?QldlSWdVZHRqdXZxTXlTUEo2WkplZ1l5VldTd3lJbjFqeDZWWmhMdTEwZk1v?=
 =?utf-8?B?RzJlZlRUN01VTkNsZXpNNWlIWVNERVVFaVRmckc1ZjRoQXBPYTFEc0IvNm1H?=
 =?utf-8?B?ODBwWWljMnZURUVpNSs4Y213bHU1ZTM1NlI5dnpJYmZ3RTJJOUFLNnA4bHVG?=
 =?utf-8?B?clQ1eXpvWGZjUitPcXhhTE4vN2NHWjhXbDFUK3VXT1JNb0x2OFRGTE5PbDhV?=
 =?utf-8?B?WU0xWmJZVHd3dU1vMGdKc1NCa1VteGxHNEVDYXN5ZDlaT0dFcnhlcm1CWU9x?=
 =?utf-8?B?bmpKN3ZJalZSaUtxSnB2WVk5bUdyS0tGbGpTY3A0S3o3ek5KQmJhc3Q0K2JU?=
 =?utf-8?B?dHJOdmlWZUxMM0hxN0dFQWlhakNGL0IvMXdGRzFGZGhvSnIydXJld1ViQ2sy?=
 =?utf-8?B?YU1YRjFoWTh3K2tQWDNyRzREay91T2lGeWQ1TWdHdDBWZ2FSTFB3Y0x2Mkxs?=
 =?utf-8?B?M3NKSjlWSE92akpBVittbXdOS3JrNjVmUEhLM2QzYUk3dE5zcUJpVVJ6T2NW?=
 =?utf-8?B?WUN2dGxBdjB0cUZBanNuV1dUdUhQNEJGWDl0WWtXRkd2SHM5TE5pUXpleDZJ?=
 =?utf-8?B?anRTM3dnY1NnV1R2eHZZc01nUzdJbXFzaTU5MEo4eDlMRGNxMWRBMUI2UGpn?=
 =?utf-8?B?dzliZGdMRDZ6NUtzMkdWUFMvZGVXT0lYNU5oOExYVDNWaDBRNEQ3aVNOQzB6?=
 =?utf-8?B?dW8xVG1id2FkblFGanVQYWk0Wk5iVWl1Q1ZuRDF6RnlqN3R6Mkg3TjVRR1JQ?=
 =?utf-8?B?NDhnbkM2a0pRYTFmVzROay9NaWJ6OFFrMmpNbUNkMFd3NXkrMkR0TWdLTlNm?=
 =?utf-8?B?WktlZGR4OWhwdWlHcFF6dG05bUFZRDBha2plR25RY0ZteExTSU95dDdHUVdK?=
 =?utf-8?B?M0NtR0VLVVZJeXFnZ1pOMzFHK1NDWnEwcGtXZ2drcEtIYm81WENmaEVmbUVQ?=
 =?utf-8?B?SVdOSzYvcVMzWHg3a1ZlVUx2MVBJYnRRUm4wbjRZdk1iYVlpZzd2RmM1a1hk?=
 =?utf-8?B?b05qZGd1OEpVYzBtOUJadjRHazhuUEt5MmVzMGY2VHJLakNjODhCN09OdnlX?=
 =?utf-8?B?RXp2WWlDZUlUaUJMWkdmSW9KSjVFRHlsRkU3dytDMkdQblllWVYzeUozYU4x?=
 =?utf-8?B?NFNhdkRSNnVTTE8yMms1eGE5NTBCcVB4ZkVtNXpRVm94Umh4ZXFRWEFpeW1W?=
 =?utf-8?B?TnB4UkxWYzZXUVZ0TTloQUU5U01nYXdaTlRWVndGZGdjTmpibnY2MklORWg4?=
 =?utf-8?B?YU50NnY5akZxeXlMVHVNd2RHVUU5alpwL1Z5TmpYemcwazU2RUpCNXBKY0VN?=
 =?utf-8?B?SWJyVE0xd3hZamRqZGNyQnVqaVpMRlhuQ0pQWHFTenlNc3lXc1NVVWlOV1lD?=
 =?utf-8?B?MHV6UXVEbGNyYk9GenRmYWE4WVdiQW5xQ1p3akY0T2QzcHFqYm9nV2F6YzdN?=
 =?utf-8?B?eHpRUVhIbHIraXF0aEltM1AyYUJDZVhsS1RlUHJjMjd3MXJUQ09aTTRqQzI2?=
 =?utf-8?Q?q0567n2nUZQlQm74zsxujSs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca8b046-e2b1-41bc-df72-08d9c4ef8f38
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 02:05:43.0295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4ncDFg7so+vkT0cY5gsaxP4tYSh4Tbpz6N3Brp3jUMTUHKc/+gc/LHXNf17SE2y/7eEv6COkfOYugCs/VYgYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4308
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10205
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220010
X-Proofpoint-GUID: _NDxL2OYcd4sWrmQyRCVmEnbQS97eONF
X-Proofpoint-ORIG-GUID: _NDxL2OYcd4sWrmQyRCVmEnbQS97eONF
Cc: lvivier@redhat.com, eperezma@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 12/21/2021 9:20 AM, Eli Cohen wrote:
> Check whether the max number of data virtqueue pairs was provided when a
> adding a new device and verify the new value does not exceed device
> capabilities.
>
> In addition, change the arrays holding virtqueue and callback contexts
> to be dynamically allocated.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 43 +++++++++++++++++++++----------
>   1 file changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 4a2149f70f1e..848eabbb1831 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -131,11 +131,6 @@ struct mlx5_vdpa_virtqueue {
>   	struct mlx5_vq_restore_info ri;
>   };
>   
> -/* We will remove this limitation once mlx5_vdpa_alloc_resources()
> - * provides for driver space allocation
> - */
> -#define MLX5_MAX_SUPPORTED_VQS 16
> -
>   static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>   {
>   	if (unlikely(idx > mvdev->max_idx))
> @@ -148,8 +143,8 @@ struct mlx5_vdpa_net {
>   	struct mlx5_vdpa_dev mvdev;
>   	struct mlx5_vdpa_net_resources res;
>   	struct virtio_net_config config;
> -	struct mlx5_vdpa_virtqueue vqs[MLX5_MAX_SUPPORTED_VQS];
> -	struct vdpa_callback event_cbs[MLX5_MAX_SUPPORTED_VQS + 1];
> +	struct mlx5_vdpa_virtqueue *vqs;
> +	struct vdpa_callback *event_cbs;
>   
>   	/* Serialize vq resources creation and destruction. This is required
>   	 * since memory map might change and we need to destroy and create
> @@ -1218,7 +1213,7 @@ static void suspend_vqs(struct mlx5_vdpa_net *ndev)
>   {
>   	int i;
>   
> -	for (i = 0; i < MLX5_MAX_SUPPORTED_VQS; i++)
> +	for (i = 0; i < ndev->mvdev.max_vqs; i++)
>   		suspend_vq(ndev, &ndev->vqs[i]);
>   }
>   
> @@ -1245,7 +1240,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>   	int i, j;
>   	int err;
>   
> -	max_rqt = min_t(int, MLX5_MAX_SUPPORTED_VQS / 2,
> +	max_rqt = min_t(int, roundup_pow_of_two(ndev->mvdev.max_vqs  / 2),
>   			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
>   	if (max_rqt < 1)
>   		return -EOPNOTSUPP;
> @@ -2220,7 +2215,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>   	clear_vqs_ready(ndev);
>   	mlx5_vdpa_destroy_mr(&ndev->mvdev);
>   	ndev->mvdev.status = 0;
> -	memset(ndev->event_cbs, 0, sizeof(ndev->event_cbs));
> +	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
>   	ndev->mvdev.actual_features = 0;
>   	++mvdev->generation;
>   	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
> @@ -2293,6 +2288,8 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>   	}
>   	mlx5_vdpa_free_resources(&ndev->mvdev);
>   	mutex_destroy(&ndev->reslock);
> +	kfree(ndev->event_cbs);
> +	kfree(ndev->vqs);
>   }
>   
>   static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
> @@ -2538,15 +2535,33 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   		return -EOPNOTSUPP;
>   	}
>   
> -	/* we save one virtqueue for control virtqueue should we require it */
>   	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
> -	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
> +	if (max_vqs < 2) {
> +		dev_warn(mdev->device,
> +			 "%d virtqueues are supported. At least 2 are required\n",
> +			 max_vqs);
> +		return -EAGAIN;
> +	}
> +
> +	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> +		if (add_config->net.max_vq_pairs > max_vqs / 2)
> +			return -EINVAL;
> +		max_vqs = min_t(u32, max_vqs, 2 * add_config->net.max_vq_pairs);
> +	} else {
> +		max_vqs = 2;
> +	}
>   
>   	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
>   				 name, false);
>   	if (IS_ERR(ndev))
>   		return PTR_ERR(ndev);
>   
> +	ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
> +	ndev->event_cbs = kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs), GFP_KERNEL);
> +	if (!ndev->vqs || !ndev->event_cbs) {
> +		err = -ENOMEM;
> +		goto err_alloc;
> +	}
>   	ndev->mvdev.max_vqs = max_vqs;
>   	mvdev = &ndev->mvdev;
>   	mvdev->mdev = mdev;
> @@ -2627,6 +2642,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   		mlx5_mpfs_del_mac(pfmdev, config->mac);
>   err_mtu:
>   	mutex_destroy(&ndev->reslock);
> +err_alloc:
>   	put_device(&mvdev->vdev.dev);
>   	return err;
>   }
> @@ -2669,7 +2685,8 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>   	mgtdev->mgtdev.ops = &mdev_ops;
>   	mgtdev->mgtdev.device = mdev->device;
>   	mgtdev->mgtdev.id_table = id_table;
> -	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
> +					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
>   	mgtdev->madev = madev;
>   
>   	err = vdpa_mgmtdev_register(&mgtdev->mgtdev);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
