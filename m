Return-Path: <SRS0=mz8r=PR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97257C433F5
	for <virtualization@archiver.kernel.org>; Fri, 29 Oct 2021 12:22:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D81560D43
	for <virtualization@archiver.kernel.org>; Fri, 29 Oct 2021 12:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D81560D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F347D81985;
	Fri, 29 Oct 2021 12:22:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mcufimqd4ILy; Fri, 29 Oct 2021 12:22:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9B31C8196A;
	Fri, 29 Oct 2021 12:22:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FF0AC0019;
	Fri, 29 Oct 2021 12:22:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B40FC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 12:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7897B6064C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 12:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="bZ3UdmX+";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="M6KEYJyR"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2VAOcqqZc2wc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 12:22:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C95A6062A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 12:22:13 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19TADLSW032302; 
 Fri, 29 Oct 2021 12:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=74H8xL+AFXbdcctO+eR2OVdHELwj+SaH8xrr2PwQCVU=;
 b=bZ3UdmX+yfLUQKY/i4a1bcgubcgOey++xVgM2ACQMi+vZvvJKoIQUq9Ce2NYxmmP2aGJ
 AJYaF/KjlhOGz+36FNr3GNoTGv82FqdE41iAKQL7QVFe1dpnotv+fuEoHR+HofPvEyMd
 njDJm8fHBV6rKotx6c3sDEXWdKCTPWNR+AdnAVZLGDHZq7gQCPCu1SkXd22Cbw8BRPqT
 S/JqpJeHnAdLV3PorSJLPz4Y6zcHCqUpt46fKIfQEJlOGyqOq/zfbiVCxNXGrMBrOHeJ
 u/DhR9Bef1QQzi+Ay7OajfeDwMhj6uYUY3iCicHnd5TYjQ1xf9fdWELY96/Noy7jtxiG UA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3byedarr68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Oct 2021 12:21:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19TCFgjE119228;
 Fri, 29 Oct 2021 12:21:51 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
 by aserp3020.oracle.com with ESMTP id 3bx4gfu8tr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Oct 2021 12:21:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+cvEHky0rfxUAp9FfKOCbQvp7lu5wTFzSYudoIGcPZp0LGYkTbHFjPcD1+IPOLvPNoDAOnQIDcmWlI+pnVltX8sAGphbene7rYwpUdNElZH9/uLMHB76ecnyn3L13CFukmLo0Wqfj4DTLtcmXB3T3u2Tv6kWm9HuWoxcCFIi6xx3ybux4dIWiwpByn7+U7Ly7IZhXRClMOfgw2zzfywTywYNnNplBLzzwHx8mWt7RVSXMr3DWrnXnOYva+ivJKI2Vbk66FYGNZSY6W58ugNfwpf9/b8IbxSE8QHGlFRUx1zbwpcs9TbyI0GS12QcMhNGomZdPPYcfmJgY7HHPjQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74H8xL+AFXbdcctO+eR2OVdHELwj+SaH8xrr2PwQCVU=;
 b=MaAfH87KQuNdHECpVUHKUMNs6euCaefaxmKUc8nFMwPIxPO3YYOZ4qg11SDry0HWoj5HB4j61mrWnh4Z0mZZxOoBM1/LhAfvoqnbXxjPUNdWuDeWAhCSxOTi0nSCQLQb1k1qcrjdR5yi5T3UozR07tb1dTjJMFKpZio4fPTDPlsIhXoVWZBnLmzrpr3gYortWmm/wJgXz5Tha/3fNEN6XVhNlb04utbS+++5ZuOYuS1VQkGPTJv1bpSSqMv+hnQ8ATLX5yyQekl7SXrBQybJ924zmUlcsZ0cZaL0FbGT6ZqaJHiAK3BLC6I2tH4TxfOsrVbc3F+e0XDMJsgiiHjDcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74H8xL+AFXbdcctO+eR2OVdHELwj+SaH8xrr2PwQCVU=;
 b=M6KEYJyRuU/KETE7gCcDQKwkvmu7MyOmKTVLWDWc92VDY3ss4HxMwtjOy1x8HkWmg1bKD/Lu5Rud/+cBgHmd/lT0K3k9npe/9OLMWqxQAVdb4UDv0d0kkCTxrZZm3fYIqGp/dfszkDEr1uk4dfGBY5VBluZTjsEgtvFLNzXSXdk=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB4205.namprd10.prod.outlook.com (2603:10b6:208:1d3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 29 Oct
 2021 12:21:49 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::3c49:46aa:83e1:a329]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::3c49:46aa:83e1:a329%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 12:21:49 +0000
Message-ID: <1aefa1dd-9099-9676-8aad-98299dd64b74@oracle.com>
Date: Fri, 29 Oct 2021 08:21:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v3 0/2] x86/xen: simplify irq pvops
Content-Language: en-US
To: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
References: <20211028072748.29862-1-jgross@suse.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20211028072748.29862-1-jgross@suse.com>
X-ClientProxiedBy: SN7PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:806:127::10) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
Received: from [10.74.111.7] (138.3.200.7) by
 SN7PR04CA0215.namprd04.prod.outlook.com (2603:10b6:806:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 12:21:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f97efe90-b6c1-46fa-807e-08d99ad6ae6a
X-MS-TrafficTypeDiagnostic: MN2PR10MB4205:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4205D7FA2E10517783457C728A879@MN2PR10MB4205.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AV3GszoDBnoLW7bokq9FppGYHHzHDmrcx5x6XmHRp3TgJBjghY317leaK0n4FIjVdH0jva5rmTzT0VZzysMcm10c3PLHHIpUNl8zDzLSjYScvFHoEqBW+NkXVSbFYfgrXtqhgZkcBG6w24zFY9HMmvzvK84W2GJlWJ8lZLnyYn2d/LyJDS1C4I/KQwnXB1USieaQbRNtyqfiXm9QYKrGMM4bblUZbX8u7DJEDBjCcQNYDyC7u/xa9ED6lDJ4Ka25GxX3L4rl9LVQYUgWk4Ez2pyJzVWRy/shalf72sBCnXcKE+QRlM/MXYRcnMAx82x7hW7OkuAGq4nOagcrNNY4h8BG2Ei5D+aKT2IZCmy4GU2wZAlqdjDeKqs1OUTOzj/ffqMMKyfoT7ecAvp7w6+NDsjFVWqGrFepM0RFIvMIDaV++qrSMeBhr4FtAVqJsqPGZnTgVCD5ThwQLUI8xADrAsqjeQcgvCfmwW9FvHKg9wnketus+blI47//cDJ8y98brNhtwuQcWq+goDsDVlxZQNsZ3q7mPQxOVT+GrTrRAp1S014x1fSxCzSD8SQSPoVhGqUEnYxXyE/lBFxp45H1aFU+6Ym5cW9k7eig8AhIdLNL7pFpNsnzaQTSAc7CqqKWjR+KH017abuyoUP/6B9Z+p9T0HSEacMkUODXZc8hRoUvcpQ+KAzAP34EZ03Jd/f2dy7MAsrPI4vk1eTFfFt0F9ZaetWtXGEjEUMrqHpUFKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5009.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(508600001)(316002)(44832011)(38100700002)(66476007)(54906003)(66946007)(5660300002)(8936002)(36756003)(66556008)(6666004)(31696002)(6486002)(186003)(4326008)(16576012)(8676002)(86362001)(31686004)(26005)(83380400001)(2616005)(4744005)(2906002)(53546011)(7416002)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THk4L05EM0E4L0d5d1RPdFMzalJHVmhRamVTbkt2T1hQN2gxRC9mWjZ3V1hu?=
 =?utf-8?B?YXlUSjMzbVhvQTl1c3Ztd0RyU1ZGSW12a2FIZUxVdExTK21tUlZNamIxaDZ0?=
 =?utf-8?B?bERmWURjeXFDU2liTW5LODdyc3c5MEVZaEdIVFk2bm1jVklVa3EvaVZLYlRy?=
 =?utf-8?B?TVE1ZmdZRWdLb2Y0ZE1WTDZHZDhOS3N2VkhnT3A0MzZMMnRKOUNOUENtM3NX?=
 =?utf-8?B?ZmlUUjBkU00yUXJaNGYrL0VzUzQ4eTVRL1NVWDVjRUlCU1QvY3MwbjlRNkZC?=
 =?utf-8?B?c0FMZnlKQ2JjbWVwZjRPR3puN2JUUkxjWDJNWUpWKy9sUTh2WjNmZGJPd29H?=
 =?utf-8?B?bGVRcGcvRU5CdHFhaVRMQzZicWJKK3RTSE93ZU52dkVhd3lGV04wc3RjaEJ2?=
 =?utf-8?B?Z0hveDNRZWszWWh2ZjhIVFl5UnNwK01DMVNkZUJ2SFpyRkJ3clFja2pPRXRk?=
 =?utf-8?B?OHNqUXpHYUNGcGc3V1JDRTJobUw4V1JvTlVkT3lSRGpaWm4rV1M1NUNvUnNR?=
 =?utf-8?B?TDhIVXZSVXI0bVk1K0tDZ2NrUjBTRDFlT2gyNktrNVFQaFN6czZjREZsZ25M?=
 =?utf-8?B?WmpsR3U5dkd0QUo1UmhueWNZcW1kaTdEQmtjU3dZVi9iZE00YVhYNHIrMklD?=
 =?utf-8?B?VWd6aUsxUDhjYjc0ZGpXMUpLMFdLeVNRRTRBcVEwVzVlN2RKSjN6b0k4RHZx?=
 =?utf-8?B?bEx3K1RIY2V2RW8zeWgxQmovN3dyUUpRalZtUlVwajBSZmwrVWNCMkV5a25a?=
 =?utf-8?B?VDg4Z1AzeU03bEpkTlluV1ppejI1YVUvMGNudHhiQmUrNGRwUDc5SlRqUmFh?=
 =?utf-8?B?a3lYTDlYZmFWQUk3cnVUU2dsaTJBakNRU2xZTmUzWloyYjJTdmZ5eXBpcldy?=
 =?utf-8?B?YlNNdTFSQWNQZVNHUXZmZ1BEcEZjR2JwUTRsenVGak5jNk9zb2JhSWxXTWVU?=
 =?utf-8?B?QjRUV3c5dW1wZXU3RTBLNzhkNURVaHdqU01sc0c4TjdJUDI3cU9FUlpmWWNp?=
 =?utf-8?B?YkRMa25leHpEbEF3TW9xc0lidXVPdHRCendpUC81cnR2cWVvaVY2enc2RTFN?=
 =?utf-8?B?dVR6U0QwWHU2VTUwYi95UWEwclBlb0lyQWV5L29NYUo3Um9ZU1NBWWlnamtV?=
 =?utf-8?B?eUN6RTFiZDMzSUhzdnlYem9ESE13YmpBdU5iNHZrdHJkVDd3ZHlFZDBmSnRo?=
 =?utf-8?B?QyswVDJWYW9CZjhIbEZwN2FPeUNFRWdkZVJGY0FzZGFlTGFldG50dnBuUkxs?=
 =?utf-8?B?VGxKQ3JsSnE1bDNjTEZBZHFvKzJxbGpuTnlhOUYwTmhHV0IzYUw3b2t6TzVS?=
 =?utf-8?B?LzNlS2lEOFJ6VjkvNUFRU215dk5ZUXltZHp6eUg5WnkrSndnb2d4aVNxRk5l?=
 =?utf-8?B?aGpWZ00zZG1XWjhPbHh6ME5PYXRoQmQvNytpZjZhZVVkNXlmYVN2RXAzc0Y3?=
 =?utf-8?B?dFV2N0V1TFdRbWJLUFUvMDNzTmV5TGptemJ5dFdXZisreFhRTWFtdVpyK0d4?=
 =?utf-8?B?RjAyS2NaNWRNdklOU3pOcTlSNUFaQkZHVnQ5c0hIQ0NiejMwM3VJZUhqMEZh?=
 =?utf-8?B?czBxa1JqNkliWHV2RjFEOFRXVDdPbzk4VTV5Y29BLzU2SFk2OFFTMU52OXhx?=
 =?utf-8?B?ZCtZSnRQelpLNnVNMnFHK2ViSFFSNkhPWEQxekxZcDhBOWdLT2g1dmFBdDhn?=
 =?utf-8?B?d0ovUjJGV0N4Y1AwdGVkM2w0RDg5ZVkycjFmcE5VZGNkNCtoYW5tZ05LQlBI?=
 =?utf-8?Q?7QbI3FUDmVmK/kwyfBvdq760tkldgUz5U5k9WO7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97efe90-b6c1-46fa-807e-08d99ad6ae6a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 12:21:49.1152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdrFf6+/RJBkHI2HOiL+t7Nc24Ra6jfGxQc6AfVj6pRzPMvyDUkSTlNL6DsuZOlmklxzGb6MKfH8ldE5gJx7K5wkOKlsB7VK4PS/aVF2HWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4205
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10151
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290073
X-Proofpoint-ORIG-GUID: onGq9ew2kjs84MKtF47f0GKEXOP4bVfR
X-Proofpoint-GUID: onGq9ew2kjs84MKtF47f0GKEXOP4bVfR
Cc: Stefano Stabellini <sstabellini@kernel.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
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


On 10/28/21 3:27 AM, Juergen Gross wrote:
> The pvops function for Xen PV guests handling the interrupt flag are
> much more complex than needed.
>
> With the supported Xen hypervisor versions they can be simplified a
> lot, especially by removing the need for disabling preemption.
>
> Juergen Gross (2):
>    x86/xen: remove xen_have_vcpu_info_placement flag
>    x86/xen: switch initial pvops IRQ functions to dummy ones
>
>   arch/x86/include/asm/paravirt_types.h |   2 +
>   arch/x86/kernel/paravirt.c            |  13 ++-
>   arch/x86/xen/enlighten.c              | 116 ++++++--------------------
>   arch/x86/xen/enlighten_hvm.c          |   6 +-
>   arch/x86/xen/enlighten_pv.c           |  28 ++-----
>   arch/x86/xen/irq.c                    |  61 +-------------
>   arch/x86/xen/smp.c                    |  24 ------
>   arch/x86/xen/xen-ops.h                |   4 +-
>   8 files changed, 53 insertions(+), 201 deletions(-)
>

Applied to for-linus-5.16


-boris

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
