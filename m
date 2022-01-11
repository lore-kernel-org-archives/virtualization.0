Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77560C433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 01:00:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBC1B83DF8;
	Tue, 11 Jan 2022 01:00:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IsbuQApFKrww; Tue, 11 Jan 2022 01:00:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3CDF383DF2;
	Tue, 11 Jan 2022 01:00:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05A9AC0030;
	Tue, 11 Jan 2022 01:00:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B44FFC001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 01:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C8B0410A2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 01:00:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="aF+/O3yU";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="dzG7j/HX"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uXQTDEjl8UHT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 01:00:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 24CB3410A0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 01:00:43 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B08XGP026175; 
 Tue, 11 Jan 2022 01:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QxWCQ7Ds0ziPgHnMjoHWu3iWH71La11FgniwfZ412IE=;
 b=aF+/O3yUr5Irdr1JrkcfG3IxGnrjVXtvUJQHLM68NPkyHaYUWOQ0qF3LblIgAtAol8hC
 duhHcUATffCNHk2a9uqqP8CecTtUw1mEPXkc+KGEr46vh11l8zNeVz8PKyvlQjos6NQV
 QYa9DQtLHGF6QmF83zUDOGYfQv/UGjiSHwjAwrsn+NfBvU1jM6Fzwjp4q1hHE4krJY63
 yf3fSMOlEdsBGB0zZbfpWpUp1qa4LwLPjFyOQ+MH2uJ/rMf6BG6EmPI2WPlKkI2/kl9k
 smSEMJBEwCEd2j7SJGKiWBSnltdkaLAojOsfHrDEDQ50WaM41IS9LAWsDZZVgy8YcGR+ xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgjtga2s1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 01:00:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B0paXm038273;
 Tue, 11 Jan 2022 01:00:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
 by userp3020.oracle.com with ESMTP id 3df42ku094-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 01:00:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUYvknXO0yPbjuh1D/K3ZQgw+FnANYKfAvWvh211hFaM8DC8s8PPd5oX/AYT3y/J2AwoOlr2U77Ob6+f1JYNt4OWPblpI0aAb0ZrX5WoL6JpXJXjJalYvKCdgaPKfILPHwZR8OYbnsKUoUSnGSkq13r6t+4p0ZioXkAoe6wJugPa7WARe7l9ovlezTpUPpWb93pnmk4V41PfN8gTs65gouW0dYkr8iKkrcUtgO7NP8VRsB3MnKd/Vg9ru9JtkxlyYXrtm4PAnGX85mZuvcrOjTqAW/WEqqwZY+C4Ipb364zZ90abt8OcFPznYffip0ezhx4o5pKTxsFXHyhmD1t7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxWCQ7Ds0ziPgHnMjoHWu3iWH71La11FgniwfZ412IE=;
 b=WD0JRuTLSlKXDC916o7/PmMVV/GRoO3GUwF7spKOVb15+jLH/hWdPaCa1Xjy/AkiP3aA7lPEBDpFkhfYtrdQXvBzxxf2UlIsHn8NcLuGUOUgutpoorZG3BoRX/dzY/DEOHpd3QE2Bs59omShhpoaUQzFHbf6WhgJynkwdgwdb6eFZa1ZgkG6/agF/nwp++PFvV7bRSDPu4WcrCCFhObtnf6MlisVLVGLZsL5APpJltXaEfo4mZtHRQYOeHoIona/Y7ZsQ/3oqY3iHPfHMgyyDrqRX1Iftm9aZcRkOWk1Jz3lAllLX8kBCvErLCJS9vjJASrYgB7qsEYwa6tNlloKCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxWCQ7Ds0ziPgHnMjoHWu3iWH71La11FgniwfZ412IE=;
 b=dzG7j/HXikwVgL7tzlreJ1veSnT9APesaZRCRKKwDLEbt+c3Ferrd0ZtqNBVsry1mBTekwYuccHzKD82S+lKx9w467Og8MA94wzq7hSzBIxy5n8R/BUa/Had5mDaAfH7RoUMqjFAxbYpWHbTgJNPY/S/KBc6kQH1dyt+Y7rrj0o=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2805.namprd10.prod.outlook.com (2603:10b6:a03:8b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 01:00:39 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 01:00:39 +0000
Message-ID: <94048dc7-defa-2c7b-9350-540e8b9df227@oracle.com>
Date: Mon, 10 Jan 2022 17:00:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v7 07/14] vdpa/mlx5: Support configuring max data virtqueue
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-8-elic@nvidia.com>
 <99150f0c-6814-a0cc-8640-aa8014af6ed0@oracle.com>
 <3205e802-a982-fbe2-511e-f5c28fc19b36@oracle.com>
 <20220109141023.GB70879@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220109141023.GB70879@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: SA9PR13CA0093.namprd13.prod.outlook.com
 (2603:10b6:806:24::8) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c56111a-5c72-44e1-0638-08d9d49dc8ab
X-MS-TrafficTypeDiagnostic: BYAPR10MB2805:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB28053372AACD70D980C397A5B1519@BYAPR10MB2805.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0gVU2RrCs2r9XCJZwUR2QVnLETHLpVbO7l5S43JJmMYDzaXZINe2dZWAOddWN0+YmpAi/VhZ2Ufu98PaI9eh7b7D3LyZGdZTS7oFRgswvMpfTpfN7o/16pnMBnAOs3n15VEJN2WdAXMEovyUbTFWUpTmz/uHttVZyNB7JOol8yZp1M5BCP6pDdmpepzQjsdb5ClhQFRKgY5H+43tNenJohitenSBVndlFnvIiCEP0YRh8wiW7UlWBl13PkwGh9Q6eoQEmI8g0A4wlEIfQFGHOd/O6mKuugQvEekBXMggs+/vO1HA7GBQ94PxQdMM5IIuyBd3Acd0HRJxvMnOZfsA7V2jv3csjq0NMKPW2dnXwZQq+hGQcacWV0f7j0cOyG0so5LQMb54XIuaYKxebkzHN62TbaeAKl1fzqk6srNuyBsVJkQQ41IVIDzUoQx/q5C3PnXJXVsDxHfBS6BJwoA3t8Jo75DyBMaVrZK/H4DaevrnNYd2zpQ/VXX6e6ulRtGd2LX0lnEyKoTN9wDwBMgF6mioWiqN0jlak7SpcfAEawlbysM+kkUNmFprGpuHaE0dS1rjcFNlsnOJjL52RyD0hcDtw+Fjne3l4zGASnSADs+qBfzd4D7lA1T0UcFqoKZCstHtskbqrItq4SO+wtxYZ6WE/FaBy0EnlIp4/lDpaEOF0iyoo5LGiZP4cb+cSuiDu8zY+pgQ4Cn1pOAEY7vUekgHzGHFxU6eaxKG80j59g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66946007)(6916009)(36756003)(6506007)(86362001)(8936002)(26005)(508600001)(5660300002)(66556008)(53546011)(2616005)(66476007)(6512007)(36916002)(6666004)(31696002)(31686004)(2906002)(83380400001)(8676002)(6486002)(316002)(38100700002)(4326008)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1Q1VXJzU2d4MndtSVJvRFVhdENMa2lKSTFjaTNBUEVMSEFoeDBncE4zRWts?=
 =?utf-8?B?dUg4TlpzZGl4S1htTmhxL2ZHclBzNlpkS3oyTTZQZ2ExZzJTeW1HaVhDdHVJ?=
 =?utf-8?B?Zk8xRzlodWMrUHRuSzBBTEVGM1NFU3FEU0xQVkpRNCtxRFVodUgyaEtacUp1?=
 =?utf-8?B?Tkd3eUJSb1N4SHJ6NkNzS0pyc1Z0eWVDM0c5WEVaWnluSjZpZ2luY25oUEM0?=
 =?utf-8?B?T09saFZNUjB4WUNrODVMa2crY3FmTkpMUE5Qb2V4MG5Bc1lsckU4RElmUlNE?=
 =?utf-8?B?SGgrcnZTMlRoUStrUUJCWjZtcWp4dTMrdldMQnhYM2tYOGFBbG83c1docVVz?=
 =?utf-8?B?YWQ2TEZhUVZTb3I0ZVBMK2kwNHA0Q0g1YzdWMmV2R3NWeElVQVFCbXQ3RUo4?=
 =?utf-8?B?ZmdsWG1ZaGtQQmg4dkJ0TnhyT0YxNE9TRW5XMlA5dTk3aXVTVEF6c1ZFaTBt?=
 =?utf-8?B?M3M3RHZyRnEzdk1ESWk5bDdSc1NiUm4xNHFRWXRyOVZ4bHA4eWQwL1RIY1Zz?=
 =?utf-8?B?QkN0bW5ENTFraUVOL2ZhUXNsQ1Z2dXhiQko3RTZEdUFqek4rbVpqRExJMmxh?=
 =?utf-8?B?Y1g5eGNHUnlzYkxYRFQra2U4bEY2YW5jY1Z3aWtRcVF5NTdLTmFiQitqVWhj?=
 =?utf-8?B?a1V1eTVoTEViNDRkMUlLMmNRTitTQm1zMTBGMlN1cXZydThTYzFaOWVDbHA0?=
 =?utf-8?B?SFhTbXVHb0NEQlpHNTNGSStiYzVFWFAvVjQ4NEtYdjRuUG5MczhXb2ZjY3k1?=
 =?utf-8?B?K0hPNmloK1hrMWF1UzJLZndtYzVtRTRjeDBVbmhOWHFJZnREdmh0TjFPUjlv?=
 =?utf-8?B?Y1F6WlcrbTIrT1hUT1lJdVp1UFJiWjRDM1Q4NjNubEt0eUIyWklPREc1dmJE?=
 =?utf-8?B?M0ZBNEMyTjl0R0ZtSE5GWnc2dDI3alBVME5YMitWTDVPOU9MN01KcWhYL3BI?=
 =?utf-8?B?RVhzYjI3SW55MHdHS2loSDFrUGUzV3AvUG5jdEg0NG9YbG5lN21rQ1BGdDBs?=
 =?utf-8?B?UWNwVGVFN3NEZ0YzWUd6cUJkZ0Mvc2VHaWdTSVFLVUczcmlaV3Q5dVZHMnZp?=
 =?utf-8?B?UVJGY0lDWDUxc3Q1WnVCZnJMVG9yTjFxbENHcnNwKzl1WEc4UFJ6MVZwdkcw?=
 =?utf-8?B?QU9QSEZ0TzZISm1Jdkh4Z2J0eVo0NHB3RFNFMnhtS3F4ek52aEhUVjhFYVEz?=
 =?utf-8?B?M0xRQW1iT3RWU2ZUd0c4WXZhQjlzNW9ONTY1cnZjd1BiWUpuZUE4bUNUR0N6?=
 =?utf-8?B?Q3NtWC9tZCtFcGlkYTFLSHY2R3hwNE9PNzA3Rk03TytYdDZrYW1uMmpJWVNw?=
 =?utf-8?B?ZlVqbW1naEs2dU9GTHdiY1RhVUJFbXVnL1QvRUcrTmFnQTVyZ1UyV0hRVmVW?=
 =?utf-8?B?V2RDMWZpVWkrdzRtL0dycExpY3YvWkovVUFGYWZBSlFLL3pSMDJ1Qi9JbWtj?=
 =?utf-8?B?bFViaVdsWEJPN0U4d09XcXJvUEZPTjlrQTdPUU4wWHVVZEVyS2tTVC9zWHFP?=
 =?utf-8?B?Mit3TTY2L3BGcVVwRm9UVkJIOVV5aDdPYU5lTVcyd0Npb21BOUFwdkFCLy8w?=
 =?utf-8?B?QTh3WnhINFF3OTRER3ZQWlYwUGlTcGZHZTRVb3BHZzlnZURkVW4rZkVMbFkw?=
 =?utf-8?B?ajF0dm0wc25qZDJzSDhvUWtBUE1Db0lRUTVYNHFKSXBnZCtOZjlaYjdHTlFU?=
 =?utf-8?B?QzBZQlVuUS9ONUdyT1FwWWZ4QkhiOUJ6aXQySHNVbGtoYWlPUXl4aDkycWNt?=
 =?utf-8?B?SEpUT09sdmtHem1ROFdUdS9ISG0zckd3QUlNRVFrbXlnc1hzZVFQd2hjZm5u?=
 =?utf-8?B?TUd6cmdldUVFWll6Qk4zVUNJeXBSbUQ1MEtXemt4b2dWTlFueU8wQTc1R1lC?=
 =?utf-8?B?cTZUcWliN05oai9DTVBnSVRYQUNMaThTTzQwWCtOdFJYdU5MeVByN3VJb1hm?=
 =?utf-8?B?R3Y0MDFJWEpnQnRUQ05CQkUwR3o4cHhmcFk2SVF3MGQ3QmhjVU9oWGVXTG9n?=
 =?utf-8?B?L0w3MEhnVnZzMzVDSFByS0ZsVkxyUFV3ck1OUjlacDUvZDNDMmdQbDNhblIx?=
 =?utf-8?B?c1IzSlNWTDdUK1BCT0pDWXVsbW5rLzNBWmJIeEFYdEpuSFFxSXFDTTR5azE0?=
 =?utf-8?B?OGJDR245S1l1MUNOU3AxV1VsTi9NOVlMZTR3RnRQeUJPWDJ1L2VQb1RKWjNC?=
 =?utf-8?Q?p6vxZ0TxhtALEHvKkCQYPwQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c56111a-5c72-44e1-0638-08d9d49dc8ab
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 01:00:39.3584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwgAu1zO9kKTQIk1QklNMDTIxGo0PNf6tcdGgNzEIbZiRndAUHRTBvKuEkoKPse+MICnqzvFDO6+mqxGtEdApg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2805
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110001
X-Proofpoint-GUID: 7cGlFA0zxYoeOH-bvsLHy1R1Wdx3BQ4A
X-Proofpoint-ORIG-GUID: 7cGlFA0zxYoeOH-bvsLHy1R1Wdx3BQ4A
Cc: lvivier@redhat.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

CgpPbiAxLzkvMjAyMiA2OjEwIEFNLCBFbGkgQ29oZW4gd3JvdGU6Cj4gT24gVGh1LCBKYW4gMDYs
IDIwMjIgYXQgMDU6NTA6MjRQTSAtMDgwMCwgU2ktV2VpIExpdSB3cm90ZToKPj4KPj4gT24gMS82
LzIwMjIgNToyNyBQTSwgU2ktV2VpIExpdSB3cm90ZToKPj4+Cj4+PiBPbiAxLzUvMjAyMiAzOjQ2
IEFNLCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4gQ2hlY2sgd2hldGhlciB0aGUgbWF4IG51bWJlciBv
ZiBkYXRhIHZpcnRxdWV1ZSBwYWlycyB3YXMgcHJvdmlkZWQgd2hlbiBhCj4+Pj4gYWRkaW5nIGEg
bmV3IGRldmljZSBhbmQgdmVyaWZ5IHRoZSBuZXcgdmFsdWUgZG9lcyBub3QgZXhjZWVkIGRldmlj
ZQo+Pj4+IGNhcGFiaWxpdGllcy4KPj4+Pgo+Pj4+IEluIGFkZGl0aW9uLCBjaGFuZ2UgdGhlIGFy
cmF5cyBob2xkaW5nIHZpcnRxdWV1ZSBhbmQgY2FsbGJhY2sgY29udGV4dHMKPj4+PiB0byBiZSBk
eW5hbWljYWxseSBhbGxvY2F0ZWQuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4g
PGVsaWNAbnZpZGlhLmNvbT4KPj4+PiAtLS0KPj4+PiB2NiAtPiB2NzoKPj4+PiAxLiBFdmFsdWF0
ZSBSUVQgdGFibGUgc2l6ZSBiYXNlZCBvbiBjb25maWcubWF4X3ZpcnRxdWV1ZV9wYWlycy4KPj4+
Pgo+Pj4+ICDCoCBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCA1MSArKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tCj4+Pj4gIMKgIDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNl
cnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+PiBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYwo+Pj4+IGluZGV4IDRhMjE0OWY3MGYxZS4uZDQ3MjA0NDRiZjc4IDEwMDY0NAo+
Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+ICsrKyBiL2Ry
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+IEBAIC0xMzEsMTEgKzEzMSw2IEBA
IHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlIHsKPj4+PiAgwqDCoMKgwqDCoCBzdHJ1Y3QgbWx4
NV92cV9yZXN0b3JlX2luZm8gcmk7Cj4+Pj4gIMKgIH07Cj4+Pj4gIMKgIC0vKiBXZSB3aWxsIHJl
bW92ZSB0aGlzIGxpbWl0YXRpb24gb25jZSBtbHg1X3ZkcGFfYWxsb2NfcmVzb3VyY2VzKCkKPj4+
PiAtICogcHJvdmlkZXMgZm9yIGRyaXZlciBzcGFjZSBhbGxvY2F0aW9uCj4+Pj4gLSAqLwo+Pj4+
IC0jZGVmaW5lIE1MWDVfTUFYX1NVUFBPUlRFRF9WUVMgMTYKPj4+PiAtCj4+Pj4gIMKgIHN0YXRp
YyBib29sIGlzX2luZGV4X3ZhbGlkKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdTE2IGlk
eCkKPj4+PiAgwqAgewo+Pj4+ICDCoMKgwqDCoMKgIGlmICh1bmxpa2VseShpZHggPiBtdmRldi0+
bWF4X2lkeCkpCj4+Pj4gQEAgLTE0OCw4ICsxNDMsOCBAQCBzdHJ1Y3QgbWx4NV92ZHBhX25ldCB7
Cj4+Pj4gIMKgwqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9kZXYgbXZkZXY7Cj4+Pj4gIMKgwqDC
oMKgwqAgc3RydWN0IG1seDVfdmRwYV9uZXRfcmVzb3VyY2VzIHJlczsKPj4+PiAgwqDCoMKgwqDC
oCBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcgY29uZmlnOwo+Pj4+IC3CoMKgwqAgc3RydWN0IG1s
eDVfdmRwYV92aXJ0cXVldWUgdnFzW01MWDVfTUFYX1NVUFBPUlRFRF9WUVNdOwo+Pj4+IC3CoMKg
wqAgc3RydWN0IHZkcGFfY2FsbGJhY2sgZXZlbnRfY2JzW01MWDVfTUFYX1NVUFBPUlRFRF9WUVMg
KyAxXTsKPj4+PiArwqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICp2cXM7Cj4+Pj4g
K8KgwqDCoCBzdHJ1Y3QgdmRwYV9jYWxsYmFjayAqZXZlbnRfY2JzOwo+Pj4+ICDCoCDCoMKgwqDC
oMKgIC8qIFNlcmlhbGl6ZSB2cSByZXNvdXJjZXMgY3JlYXRpb24gYW5kIGRlc3RydWN0aW9uLiBU
aGlzIGlzCj4+Pj4gcmVxdWlyZWQKPj4+PiAgwqDCoMKgwqDCoMKgICogc2luY2UgbWVtb3J5IG1h
cCBtaWdodCBjaGFuZ2UgYW5kIHdlIG5lZWQgdG8gZGVzdHJveSBhbmQgY3JlYXRlCj4+Pj4gQEAg
LTEyMTgsNyArMTIxMyw3IEBAIHN0YXRpYyB2b2lkIHN1c3BlbmRfdnFzKHN0cnVjdCBtbHg1X3Zk
cGFfbmV0Cj4+Pj4gKm5kZXYpCj4+Pj4gIMKgIHsKPj4+PiAgwqDCoMKgwqDCoCBpbnQgaTsKPj4+
PiAgwqAgLcKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgTUxYNV9NQVhfU1VQUE9SVEVEX1ZRUzsgaSsr
KQo+Pj4+ICvCoMKgwqAgZm9yIChpID0gMDsgaSA8IG5kZXYtPm12ZGV2Lm1heF92cXM7IGkrKykK
Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIHN1c3BlbmRfdnEobmRldiwgJm5kZXYtPnZxc1tpXSk7
Cj4+Pj4gIMKgIH0KPj4+PiAgwqAgQEAgLTEyNDQsOCArMTIzOSwxNCBAQCBzdGF0aWMgaW50IGNy
ZWF0ZV9ycXQoc3RydWN0IG1seDVfdmRwYV9uZXQKPj4+PiAqbmRldikKPj4+PiAgwqDCoMKgwqDC
oCB2b2lkICppbjsKPj4+PiAgwqDCoMKgwqDCoCBpbnQgaSwgajsKPj4+PiAgwqDCoMKgwqDCoCBp
bnQgZXJyOwo+Pj4+ICvCoMKgwqAgaW50IG51bTsKPj4+PiAgwqAgLcKgwqDCoCBtYXhfcnF0ID0g
bWluX3QoaW50LCBNTFg1X01BWF9TVVBQT1JURURfVlFTIC8gMiwKPj4+PiArwqDCoMKgIGlmICgh
KG5kZXYtPm12ZGV2LmFjdHVhbF9mZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX05FVF9GX01RKSkp
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIG51bSA9IDE7Cj4+Pj4gK8KgwqDCoCBlbHNlCj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIG51bSA9IGxlMTZfdG9fY3B1KG5kZXYtPmNvbmZpZy5tYXhfdmlydHF1ZXVl
X3BhaXJzKTsKPj4+PiArCj4+Pj4gK8KgwqDCoCBtYXhfcnF0ID0gbWluX3QoaW50LCByb3VuZHVw
X3Bvd19vZl90d28obnVtKSwKPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMSA8PCBN
TFg1X0NBUF9HRU4obmRldi0+bXZkZXYubWRldiwgbG9nX21heF9ycXRfc2l6ZSkpOwo+Pj4+ICDC
oMKgwqDCoMKgIGlmIChtYXhfcnF0IDwgMSkKPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biAtRU9QTk9UU1VQUDsKPj4+PiBAQCAtMTI2Miw3ICsxMjYzLDcgQEAgc3RhdGljIGludCBjcmVh
dGVfcnF0KHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+Pj4+ICDCoMKgwqDCoMKgIE1MWDVf
U0VUKHJxdGMsIHJxdGMsIHJxdF9tYXhfc2l6ZSwgbWF4X3JxdCk7Cj4+Pj4gIMKgwqDCoMKgwqAg
bGlzdCA9IE1MWDVfQUREUl9PRihycXRjLCBycXRjLCBycV9udW1bMF0pOwo+Pj4+ICDCoMKgwqDC
oMKgIGZvciAoaSA9IDAsIGogPSAwOyBpIDwgbWF4X3JxdDsgaSsrLCBqICs9IDIpCj4+Pj4gLcKg
wqDCoMKgwqDCoMKgIGxpc3RbaV0gPSBjcHVfdG9fYmUzMihuZGV2LT52cXNbaiAlCj4+Pj4gbmRl
di0+bXZkZXYubWF4X3Zxc10udmlydHFfaWQpOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBsaXN0W2ld
ID0gY3B1X3RvX2JlMzIobmRldi0+dnFzW2ogJSAoMiAqIG51bSldLnZpcnRxX2lkKTsKPj4+IEdv
b2QgY2F0Y2guIExHVE0uCj4+Pgo+Pj4gUmV2aWV3ZWQtYnk6IFNpLVdlaSBMaXU8c2ktd2VpLmxp
dUBvcmFjbGUuY29tPgo+Pj4KPj4gQXBvbG9naWVzIHRvIHJlcGx5IHRvIG15c2VsZi4gSXQgbG9v
a3MgdG8gbWUgd2UgbmVlZCB0byBzZXQgY3VyX251bV92cXMgdG8KPj4gdGhlIG5lZ290aWF0ZWQg
bnVtIG9mIHF1ZXVlcy4gT3RoZXJ3aXNlIGFueSBzaXRlIHJlZmVyZW5jaW5nIGN1cl9udW1fdnFz
Cj4+IHdvbid0IHdvcmsgcHJvcGVybHkuCj4gWW91IGNhbid0IHJlYWxseSB1c2UgY3VyX251bV92
cXMuIENvbnNpZGVyIHRoaXMgc2NlbmFyaW86Cj4gY3JlYXRlIHZkcGEgZGV2aWNlIHdpdGggbWF4
IFZRcyA9IDE2IChSUVQgc2l6ZSBjcmVhdGVkIHdpdGggOCBlbnRyaWVzKQo+IGJvb3QgVk0KPiBl
dGh0b29sIG1vZGlmeSBudW0gUVBzIHRvIDIuIGN1cl9udW1fdnFzIG5vdyBlcXVhbHMgMi4KPiBy
ZWJvb3QgVk0uCk9uY2UgVk0gaXMgcmVib290ZWQsIHRoZSBjdXJfbnVtX3ZxcyBoYXMgdG8gcmVz
ZXQgdG8gMCBpbiB0aGUgcmVzZXQoKSBvcC4KPiBjcmVhdGUgUlFUIHdpdGggMSBlbnRyeSBvbmx5
LgpIZXJlIGN1cl9udW1fdnFzIHdpbGwgYmUgbG9hZGVkIHdpdGggdGhlIG5ld2x5IG5lZ290aWF0
ZWQgdmFsdWUgCihtYXhfcnF0KSBhZ2Fpbi4KCj4gZXRodG9vbCBtb2RpZnkgbnVtIFFQcyB0byA0
LiBtb2RpZnkgUlFUIHdpbGwgZmFpbCBzaW5jZSBpdCB3YXMgY3JlYXRlZAo+IHdpdGggbWF4IFFQ
cyBlcXVhbHMgMS4KSXQgd29uJ3QgZmFpbCBhcyB0aGUgY3VyX251bV92cXMgd2lsbCBiZSBjb25z
aXN0ZW50IHdpdGggdGhlIG51bWJlciBvZiAKcXVldWVzIG5ld2x5IG5lZ290aWF0ZWQgKGkuZSB0
aGUgbWF4X3JxdCBpbiBjcmVhdGVfcnF0KSBmb3IgbW9kaWZ5LgoKPgo+IEkgdGhpbmsgaXQgaXMg
b2sgdG8gY3JlYXRlIHRoZSBSUVQgYWx3YXlzIHdpdGggdGhlIHZhbHVlIGNvbmZpZ3VyZWQgd2hl
bgo+IHRoZSBkZXZpY2Ugd2FzIGNyZWF0ZWQuClRoZSBwcm9ibGVtIG9mIG5vdCBzZXR0aW5nIGN1
cl9udW1fdnFzIGluIGNyZWF0ZV9ycXQgKGFuZCByZXNldHRpbmcgaXQgCmluIG1seDVfdmRwYV9y
ZXNldCkgaXMgdGhhdCwgb25jZSB0aGUgVk0gaXMgcmVib290ZWQgb3IgdGhlIGRldmljZSBpcyAK
cmVzZXQsIHRoZSB2YWx1ZSBkb2Vzbid0IGdvIHdpdGggdGhlIGFjdHVhbCBudW1iZXIgb2YgcnF0
IGVudHJpZXMgaGVuY2UgCndvdWxkIGJyZWFrIHZhcmlvdXMgYXNzdW1wdGlvbnMgaW4gY2hhbmdl
X251bV9xcHMoKSBvciBtb2RpZnlfcnF0KCkuIEZvciAKaW5zdGFuY2VzLAoKY3JlYXRlIHZkcGEg
ZGV2aWNlIHdpdGggbWF4IGRhdGEgVlFzID0gMTYKYm9vdCBWTQpmZWF0dXJlc19vayBzZXQgd2l0
aCBNUSBuZWdvdGlhdGVkClJRVCBjcmVhdGVkIHdpdGggOCBlbnRyaWVzIGluIGNyZWF0ZV9ycXQK
ZXRodG9vbCBtb2RpZnkgbnVtIFFQcyB0byAyLiBjdXJfbnVtX3ZxcyBub3cgZXF1YWxzIDIuCnJl
Ym9vdCBWTQpmZWF0dXJlc19vayBzZXQgd2l0aCBNUSBuZWdvdGlhdGVkClJRVCBjcmVhdGVkIHdp
dGggOCBlbnRyaWVzIGluIGNyZWF0ZV9ycXQKZXRodG9vbCBtb2RpZnkgbnVtIFFQcyB0byA2Lgpj
dXJfbnVtX3ZxcyB3YXMgMiB3aGlsZSB0aGUgYWN0dWFsIFJRVCBzaXplIGlzIDggKD0gMTYgLyAy
KQpjaGFuZ2VfbnVtX3FwcyB3b3VsZCBmYWlsIGFzIHRoZSB3cm9uZyBpbmNyZW1lbnQgYnJhbmNo
IChyYXRoZXIgdGhhbiB0aGUgZGVjcmVtZW50KSB3YXMgdGFrZW4KCmFuZCB0aGlzIGNhc2UgdG9v
LCB3aGljaCBjYWxscyBvdXQgdGhlIG5lZWQgdG8gdmFsaWRhdGUgdGhlIHByZXNlbmNlIG9mIApW
SVJUSU9fTkVUX0ZfTVEgaW4gaGFuZGxlX2N0cmxfbXEoKQoKY3JlYXRlIHZkcGEgZGV2aWNlIHdp
dGggbWF4IGRhdGEgVlFzID0gMTYgKFJRVCBzaXplIGNyZWF0ZWQgd2l0aCA4IGVudHJpZXMpCmJv
b3QgVk0KZmVhdHVyZXNfb2sgc2V0IHdpdGggTVEgbmVnb3RpYXRlZApSUVQgY3JlYXRlZCB3aXRo
IDggZW50cmllcyBpbiBjcmVhdGVfcnF0CmV0aHRvb2wgbW9kaWZ5IG51bSBRUHMgdG8gMi4gY3Vy
X251bV92cXMgbm93IGVxdWFscyAyLgpyZWJvb3QgVk0KZmVhdHVyZXNfb2sgc2V0IHdpdGggbm8g
TVEgbmVnb3RpYXRlZApSUVQgY3JlYXRlZCB3aXRoIDggZW50cmllcyBpbiBjcmVhdGVfcnF0CmV0
aHRvb2wgbW9kaWZ5IG51bSBRUHMgdG8gNi4gc3VwcG9zZSBndWVzdCBydW5zIGEgY3VzdG9tIGtl
cm5lbCB3aXRob3V0IGNoZWNraW5nIHRoZSAjY2hhbm5lbHMgdG8gY29uZmlndXJlCmNoYW5nZV9u
dW1fcXBzIGNhbiBzdWNjZWVkIGFuZCBubyBob3N0IHNpZGUgY2hlY2sgcHJvaGliaXRpbmcgYSBz
aW5nbGUgcXVldWUgZ3Vlc3QgdG8gc2V0IG11bHRpLXF1ZXVlCgpUaGFua3MsCi1TaXdlaQo+Cj4+
IEZ1cnRoZXIsIHdlIG5lZWQgdG8gdmFsaWRhdGUgVklSVElPX05FVF9GX01RIGlzIHByZXNlbnQK
Pj4gaW4gaGFuZGxlX2N0cmxfbXEoKSBiZWZvcmUgY2hhbmdpbmcgdGhlIG51bWJlciBvZiBxdWV1
ZSBwYWlycy4KPj4KPj4gU28ganVzdCBkaXNyZWdhcmQgbXkgcHJldmlvdXMgUi1iIGZvciB0aGlz
IHBhdGNoLgo+Pgo+PiBUaGFua3MsCj4+IC1TaXdlaQo+Pgo+Pgo+Pj4+ICDCoCDCoMKgwqDCoMKg
IE1MWDVfU0VUKHJxdGMsIHJxdGMsIHJxdF9hY3R1YWxfc2l6ZSwgbWF4X3JxdCk7Cj4+Pj4gIMKg
wqDCoMKgwqAgZXJyID0gbWx4NV92ZHBhX2NyZWF0ZV9ycXQoJm5kZXYtPm12ZGV2LCBpbiwgaW5s
ZW4sCj4+Pj4gJm5kZXYtPnJlcy5ycXRuKTsKPj4+PiBAQCAtMjIyMCw3ICsyMjIxLDcgQEAgc3Rh
dGljIGludCBtbHg1X3ZkcGFfcmVzZXQoc3RydWN0IHZkcGFfZGV2aWNlCj4+Pj4gKnZkZXYpCj4+
Pj4gIMKgwqDCoMKgwqAgY2xlYXJfdnFzX3JlYWR5KG5kZXYpOwo+Pj4+ICDCoMKgwqDCoMKgIG1s
eDVfdmRwYV9kZXN0cm95X21yKCZuZGV2LT5tdmRldik7Cj4+Pj4gIMKgwqDCoMKgwqAgbmRldi0+
bXZkZXYuc3RhdHVzID0gMDsKPj4+PiAtwqDCoMKgIG1lbXNldChuZGV2LT5ldmVudF9jYnMsIDAs
IHNpemVvZihuZGV2LT5ldmVudF9jYnMpKTsKPj4+PiArwqDCoMKgIG1lbXNldChuZGV2LT5ldmVu
dF9jYnMsIDAsIHNpemVvZigqbmRldi0+ZXZlbnRfY2JzKSAqCj4+Pj4gKG12ZGV2LT5tYXhfdnFz
ICsgMSkpOwo+Pj4+ICDCoMKgwqDCoMKgIG5kZXYtPm12ZGV2LmFjdHVhbF9mZWF0dXJlcyA9IDA7
Cj4+Pj4gIMKgwqDCoMKgwqAgKyttdmRldi0+Z2VuZXJhdGlvbjsKPj4+PiAgwqDCoMKgwqDCoCBp
ZiAoTUxYNV9DQVBfR0VOKG12ZGV2LT5tZGV2LCB1bWVtX3VpZF8wKSkgewo+Pj4+IEBAIC0yMjkz
LDYgKzIyOTQsOCBAQCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfZnJlZShzdHJ1Y3QgdmRwYV9kZXZp
Y2UKPj4+PiAqdmRldikKPj4+PiAgwqDCoMKgwqDCoCB9Cj4+Pj4gIMKgwqDCoMKgwqAgbWx4NV92
ZHBhX2ZyZWVfcmVzb3VyY2VzKCZuZGV2LT5tdmRldik7Cj4+Pj4gIMKgwqDCoMKgwqAgbXV0ZXhf
ZGVzdHJveSgmbmRldi0+cmVzbG9jayk7Cj4+Pj4gK8KgwqDCoCBrZnJlZShuZGV2LT5ldmVudF9j
YnMpOwo+Pj4+ICvCoMKgwqAga2ZyZWUobmRldi0+dnFzKTsKPj4+PiAgwqAgfQo+Pj4+ICDCoCDC
oCBzdGF0aWMgc3RydWN0IHZkcGFfbm90aWZpY2F0aW9uX2FyZWEKPj4+PiBtbHg1X2dldF92cV9u
b3RpZmljYXRpb24oc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4KQo+Pj4+IEBAIC0y
NTM4LDE1ICsyNTQxLDMzIEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2Rldl9hZGQoc3RydWN0Cj4+
Pj4gdmRwYV9tZ210X2RldiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+Pj4+ICDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+Pj4+ICDCoMKgwqDCoMKgIH0KPj4+PiAg
wqAgLcKgwqDCoCAvKiB3ZSBzYXZlIG9uZSB2aXJ0cXVldWUgZm9yIGNvbnRyb2wgdmlydHF1ZXVl
IHNob3VsZCB3ZQo+Pj4+IHJlcXVpcmUgaXQgKi8KPj4+PiAgwqDCoMKgwqDCoCBtYXhfdnFzID0g
TUxYNV9DQVBfREVWX1ZEUEFfRU1VTEFUSU9OKG1kZXYsCj4+Pj4gbWF4X251bV92aXJ0aW9fcXVl
dWVzKTsKPj4+PiAtwqDCoMKgIG1heF92cXMgPSBtaW5fdCh1MzIsIG1heF92cXMsIE1MWDVfTUFY
X1NVUFBPUlRFRF9WUVMpOwo+Pj4+ICvCoMKgwqAgaWYgKG1heF92cXMgPCAyKSB7Cj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIGRldl93YXJuKG1kZXYtPmRldmljZSwKPj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICIlZCB2aXJ0cXVldWVzIGFyZSBzdXBwb3J0ZWQuIEF0IGxlYXN0IDIgYXJlIHJl
cXVpcmVkXG4iLAo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWF4X3Zxcyk7Cj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRUFHQUlOOwo+Pj4+ICvCoMKgwqAgfQo+Pj4+ICsKPj4+
PiArwqDCoMKgIGlmIChhZGRfY29uZmlnLT5tYXNrICYgQklUX1VMTChWRFBBX0FUVFJfREVWX05F
VF9DRkdfTUFYX1ZRUCkpIHsKPj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGFkZF9jb25maWctPm5l
dC5tYXhfdnFfcGFpcnMgPiBtYXhfdnFzIC8gMikKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gLUVJTlZBTDsKPj4+PiArwqDCoMKgwqDCoMKgwqAgbWF4X3ZxcyA9IG1pbl90KHUz
MiwgbWF4X3ZxcywgMiAqCj4+Pj4gYWRkX2NvbmZpZy0+bmV0Lm1heF92cV9wYWlycyk7Cj4+Pj4g
K8KgwqDCoCB9IGVsc2Ugewo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBtYXhfdnFzID0gMjsKPj4+PiAr
wqDCoMKgIH0KPj4+PiAgwqAgwqDCoMKgwqDCoCBuZGV2ID0gdmRwYV9hbGxvY19kZXZpY2Uoc3Ry
dWN0IG1seDVfdmRwYV9uZXQsIG12ZGV2LnZkZXYsCj4+Pj4gbWRldi0+ZGV2aWNlLCAmbWx4NV92
ZHBhX29wcywKPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5hbWUs
IGZhbHNlKTsKPj4+PiAgwqDCoMKgwqDCoCBpZiAoSVNfRVJSKG5kZXYpKQo+Pj4+ICDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIFBUUl9FUlIobmRldik7Cj4+Pj4gIMKgICvCoMKgwqAgbmRldi0+
dnFzID0ga2NhbGxvYyhtYXhfdnFzLCBzaXplb2YoKm5kZXYtPnZxcyksIEdGUF9LRVJORUwpOwo+
Pj4+ICvCoMKgwqAgbmRldi0+ZXZlbnRfY2JzID0ga2NhbGxvYyhtYXhfdnFzICsgMSwKPj4+PiBz
aXplb2YoKm5kZXYtPmV2ZW50X2NicyksIEdGUF9LRVJORUwpOwo+Pj4+ICvCoMKgwqAgaWYgKCFu
ZGV2LT52cXMgfHwgIW5kZXYtPmV2ZW50X2Nicykgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBlcnIg
PSAtRU5PTUVNOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9hbGxvYzsKPj4+PiArwqDC
oMKgIH0KPj4+PiAgwqDCoMKgwqDCoCBuZGV2LT5tdmRldi5tYXhfdnFzID0gbWF4X3ZxczsKPj4+
PiAgwqDCoMKgwqDCoCBtdmRldiA9ICZuZGV2LT5tdmRldjsKPj4+PiAgwqDCoMKgwqDCoCBtdmRl
di0+bWRldiA9IG1kZXY7Cj4+Pj4gQEAgLTI2MjcsNiArMjY0OCw3IEBAIHN0YXRpYyBpbnQgbWx4
NV92ZHBhX2Rldl9hZGQoc3RydWN0Cj4+Pj4gdmRwYV9tZ210X2RldiAqdl9tZGV2LCBjb25zdCBj
aGFyICpuYW1lLAo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgbWx4NV9tcGZzX2RlbF9tYWMocGZt
ZGV2LCBjb25maWctPm1hYyk7Cj4+Pj4gIMKgIGVycl9tdHU6Cj4+Pj4gIMKgwqDCoMKgwqAgbXV0
ZXhfZGVzdHJveSgmbmRldi0+cmVzbG9jayk7Cj4+Pj4gK2Vycl9hbGxvYzoKPj4+PiAgwqDCoMKg
wqDCoCBwdXRfZGV2aWNlKCZtdmRldi0+dmRldi5kZXYpOwo+Pj4+ICDCoMKgwqDCoMKgIHJldHVy
biBlcnI7Cj4+Pj4gIMKgIH0KPj4+PiBAQCAtMjY2OSw3ICsyNjkxLDggQEAgc3RhdGljIGludCBt
bHg1dl9wcm9iZShzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZQo+Pj4+ICphZGV2LAo+Pj4+ICDCoMKg
wqDCoMKgIG1ndGRldi0+bWd0ZGV2Lm9wcyA9ICZtZGV2X29wczsKPj4+PiAgwqDCoMKgwqDCoCBt
Z3RkZXYtPm1ndGRldi5kZXZpY2UgPSBtZGV2LT5kZXZpY2U7Cj4+Pj4gIMKgwqDCoMKgwqAgbWd0
ZGV2LT5tZ3RkZXYuaWRfdGFibGUgPSBpZF90YWJsZTsKPj4+PiAtwqDCoMKgIG1ndGRldi0+bWd0
ZGV2LmNvbmZpZ19hdHRyX21hc2sgPQo+Pj4+IEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRfQ0ZH
X01BQ0FERFIpOwo+Pj4+ICvCoMKgwqAgbWd0ZGV2LT5tZ3RkZXYuY29uZmlnX2F0dHJfbWFzayA9
Cj4+Pj4gQklUX1VMTChWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFDQUREUikgfAo+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQklUX1VMTChWRFBBX0FUVFJf
REVWX05FVF9DRkdfTUFYX1ZRUCk7Cj4+Pj4gIMKgwqDCoMKgwqAgbWd0ZGV2LT5tYWRldiA9IG1h
ZGV2Owo+Pj4+ICDCoCDCoMKgwqDCoMKgIGVyciA9IHZkcGFfbWdtdGRldl9yZWdpc3RlcigmbWd0
ZGV2LT5tZ3RkZXYpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
