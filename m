Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF490C433F5
	for <virtualization@archiver.kernel.org>; Sat,  8 Jan 2022 01:38:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84D6E60AB7;
	Sat,  8 Jan 2022 01:38:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UxVtA7HZmfrc; Sat,  8 Jan 2022 01:38:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C7D6B60908;
	Sat,  8 Jan 2022 01:38:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9ACFBC0030;
	Sat,  8 Jan 2022 01:38:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89CE7C001E
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Jan 2022 01:38:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D10F60AA4
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Jan 2022 01:38:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YFHNSDT2CZAt
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Jan 2022 01:38:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D23260908
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Jan 2022 01:38:43 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2081StmQ007295; 
 Sat, 8 Jan 2022 01:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E2sbUgbAp3JbZbs28jpLjDmqdiOZjoYQnVjPEsqSCSs=;
 b=YSrMQ/6ydlkgR0KyeTSKfy9JNzwmZkF9WtlHSrRja0/550VMt6j9LHGiReaSx7chA7MX
 2hkonTl8nfoZH992l/EmfAcQ6lOAubiH8O9ngaIDZeuru5yWJq4uAF6q7H7hpCtDMbyT
 7dOQj/kanUzF4yLrPDADhtt5Hi8xu5o/dH/z3Rf7nlUuEH0B1CECk5eB521e8bWv3GwN
 U4mStlBM8xmbEouT+rnvBVFLW52JiY2yjhqe8/jZucG4vsVdv8KWgDCYuBRlqAtsHSEU
 tFWQiif2PqiISdqviU6/Ja217z1XcjSOY1S7mwziT90KQuvS6itPt81vTHwaR5aaL/0B 7Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3de4v8kb2a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 08 Jan 2022 01:38:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2081VUbJ113221;
 Sat, 8 Jan 2022 01:38:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
 by userp3020.oracle.com with ESMTP id 3de4vpmnj2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 08 Jan 2022 01:38:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFAM+XuA8CeQ+gy7laah/eM00wI6Xn/njCrKLEpWx88CIeI74DEmSi88mmQYMwimfao2EOwLE3AB8gJtvM8Ge8eFDuHoUKRcxqX/6UWdWQWtSZT/qBmMXf92EW4bfatsUq4Mq2M+IAHVx4CJQXt21GS8UYk+hUtQEnV3lR9KsvHGWkxA5OVZfMSUgF7VAK/o0GbPHcP+sKqouPGjae4Jj3sqf3DPdXSQ8tfDz/YcBGXioZDeo1V/AkXau6RS3tShdbRdOz0ENRVDHYiqmxtOzdeu3YClx2qAqFeyEVymGzaXNgNA4ZBDx36QkVtiUgxQBgRzH78Z+iIS1yOGgznbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2sbUgbAp3JbZbs28jpLjDmqdiOZjoYQnVjPEsqSCSs=;
 b=nLzQfnZxsB3uPklbdc/VbDPlvGXXlSn24HZ93J90zQZvGXlifaSnAWgEAI9QEqVi/Pl2532j0T/ybPK6lNcXaNtx5WDs4F+50pdBVh9J3M6IWXeD+0VqMf0xokPCIFRDca/kppH2muEi6xIMdUqzxV944QxYEAdrhOLGqhTUUZmogLVf1IYRx5s5hknH9FtU+7p9dB/Nrzl04BGvSS32tg8IoZmhclnLQklKUxlU5apymZtdHQMCtI6iCh3JnyuuXW5FTtsKBfasTwPutFqAzchNWSmoHlfXxuvTMCCu2wNJR61wUjY9lZ1uLqJlV7iJNxNLNCKCfW6/7oMguvDpUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2sbUgbAp3JbZbs28jpLjDmqdiOZjoYQnVjPEsqSCSs=;
 b=jNVLwmir/Oz/OpjvDwf/Oz9cyBI1IpufgHpNYaWL19/1XYOm7nQdE6wwfbGkRIdmE/DIcBO2/jntDXDR9O9aLohB/zOQf+q858uxXVIAK+jpm1We4vzOy0q3wyKet2Z/3/0vyujp4tjyzDId6fN7Ycx2MlTlD721c5RlkhY5c9Y=
Received: from BN8PR10MB3283.namprd10.prod.outlook.com (2603:10b6:408:d1::28)
 by BN6PR1001MB2145.namprd10.prod.outlook.com (2603:10b6:405:2d::38)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Sat, 8 Jan
 2022 01:38:34 +0000
Received: from BN8PR10MB3283.namprd10.prod.outlook.com
 ([fe80::317a:27e2:c007:7eb]) by BN8PR10MB3283.namprd10.prod.outlook.com
 ([fe80::317a:27e2:c007:7eb%6]) with mapi id 15.20.4867.011; Sat, 8 Jan 2022
 01:38:33 +0000
Message-ID: <0b0c6fd0-934c-8234-85da-6f99b5a3fe4d@oracle.com>
Date: Fri, 7 Jan 2022 17:38:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v7 07/14] vdpa/mlx5: Support configuring max data virtqueue
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
 mst@redhat.com, virtualization@lists.linux-foundation.org
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-8-elic@nvidia.com>
 <99150f0c-6814-a0cc-8640-aa8014af6ed0@oracle.com>
 <3205e802-a982-fbe2-511e-f5c28fc19b36@oracle.com>
 <d6b55b8a-c119-6316-3b85-27b097390cfe@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <d6b55b8a-c119-6316-3b85-27b097390cfe@redhat.com>
X-ClientProxiedBy: SJ0PR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:332::17) To BN8PR10MB3283.namprd10.prod.outlook.com
 (2603:10b6:408:d1::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3357b1a5-d456-478f-d65e-08d9d2479515
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2145:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB2145B2A4215BFFA2A0B33FCFB14E9@BN6PR1001MB2145.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6zA60ffHEbaEI1jJBMVuQ65DM3crhkcSP5kxUZNYdFEly0hUvIdDKjTupCSamFwfZ1uqLDWI7s4IpUDLe2hACdlA7+J6o4Umbz6ncXT1WgOaOw325umdRj8XnexJFJBFAUlxbW38J2WUc6jL95hpO2vio8q7wAgLkd/arsCKNO0FEDokxC0gAOGuVlDWMALIXu31BcTle/DK/6FFY+bG30/hNyzzb9JI159ocyDVnJ9LqCX33p+d4UGNIUui2WDLE5axn2PyOHLYU3E/A08MLo7E43zfNQwHgMiQzqEYerIMvtpM739MUak0S4B+es52vNO1zk+S6q1gaPd6ihDtrQQekEpbhBrCfACxq64SaNuu36EmoXrR8513yAqH76G930gCnTZMkartTkQK8M1Z27/PvHV392SaYAvCYWW2o7s2jJiJGf+kj6AY9QsbJ1g39zSdjqVpP8pqE4JTJDueAY+dvZ1sGxr6tJpl2j7x+YHFlMpooqOubuvfE0zi3YN+9zJPDPaXJKomTyk1xwuBe8EnWCKVuqcdQFIy+6ZoLx8rBI+Tt8ukz+QgcioOVNQZPRA5nOECW+jftAZyAAdc1iCwLfDX/6KaPkngGEyaceQpklQH/V5em4nWwRFyEwEH9DOVXdyPjX8+SQa65+iL0Pz9ygsJdsz7iwB/trU9JrJCRnYbgM6kQ/uNb68AbTXzMcGfE9Yi+O+ZfqxCe9xRaZTxCsIw1x4qxGFW8A7rx02VJhfbAzStNLhfFLFYsGr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR10MB3283.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(31696002)(66946007)(53546011)(6512007)(38100700002)(86362001)(8936002)(508600001)(186003)(110136005)(8676002)(2906002)(66556008)(6506007)(26005)(66476007)(83380400001)(36916002)(316002)(6666004)(5660300002)(6486002)(36756003)(31686004)(2616005)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzNOMktHRWpBNEovOGtXL3pvUVBuWmJIZGUxaDdGd3dDeGltTUlvNElGQSt6?=
 =?utf-8?B?N0VyMGdNbHM5RUpETDVGWkJUeHJqUytheDE2d2V6S3pHK1JTWXV2RTV0cXpS?=
 =?utf-8?B?S0hPelo1dE1HWHNNM3Z4YWh1VHNHVjNuelZSdi9MSkVwMnZ0U0tJeW1TclhP?=
 =?utf-8?B?S2pvNXE1TStTbWtUQUNMMUFmY2NzTWdBNTNlbzdhOWRFS01INy83Qndad0Mz?=
 =?utf-8?B?VVVXRTVPOExwbFdjL0RuVkVQVDlQeUlwREpWODU3WENsSmNpZnZlYndCU3VR?=
 =?utf-8?B?ZGtneVBMTDR4NXpPdG9CejRyQWkvYmxwNDVMV1Nxc0dTaHc5NUJEQkZrVStO?=
 =?utf-8?B?NzdvWGEyUkluenByR1lKWXJFcjJ2d2ZsL2w2NFp3T2pnK3RZOTd4cFFyVFcr?=
 =?utf-8?B?OUU2b1JJbGExc29FWWM4WDlPa1ptd1RabFpCSmxhRHJpSFRMR1pPMlJaR2h3?=
 =?utf-8?B?Ulo0QnArRHhIV3dkT3MvczVMOHUxSXc4eHJGK1Z3L3pQeFVNK2IzYStFbnhv?=
 =?utf-8?B?NEN0MlBQUmcveWUwVmxvZzR2MGVick5OeSt4ZzFWL0FRaGhaTUhGbVlLOUdB?=
 =?utf-8?B?ZU1Qb0tlY2I2alJSb293bzVxN1BIT1VUQUNSekI5NCtUVDNjcHJmQjk3dzdE?=
 =?utf-8?B?MCtWZzF4MmhjdWdJbVlyamNUbGJnQ1BHa0s5TkphRGs3S3ZtanJ4MmdCSW5Z?=
 =?utf-8?B?a3l4ODlEU0daeElOclp6c0dsQ285eDFDN3lKUDUzemlpdkp6M1FCLzBJcXJs?=
 =?utf-8?B?a0dFd2hoYTVFZk1xczQ0UkpLVnVHcSt6QmJwVFM4b1JBUmUzTTIrTURXZGhV?=
 =?utf-8?B?UUd5RHU0SEQzSFVPZFhYRGhmdVJ6eE1LUFpRdnEyOWtGWEZFUU5qc29iOStL?=
 =?utf-8?B?YlIvTmdPOGYwWkpUQmdnbGdkc3FiRGlpcXRvMGdla2wyU1NIVnZ4R3U4ZjNL?=
 =?utf-8?B?MUlpYVp3M2FERjk2TXhCS09CdWpYZU9vd1dCak55cHU4SWs4VmxTMHhhQWhR?=
 =?utf-8?B?RzJjbHN3c29GbldmS0x6WkEvMVFNSTNJOEhORkNibUpYR0dWUDhQT1I1aURM?=
 =?utf-8?B?TlpVS2UzMzBUaGJKb1l5eXM5VkUrR2ZlanpHNWlSUjNOZ2lsSU1wT2w4emFC?=
 =?utf-8?B?bXphSFlMZytWRTFWZFIzemh4YURNVURJREl4eDJkTngyUGwvZXhkT2VuSDd5?=
 =?utf-8?B?c1JLd1djbTJxbUhsWFlkOEpCS1VSbGpjNnUzWDZFTU1Zdm81NGtDVjQ3SkZQ?=
 =?utf-8?B?ZDJIcGhvVHFrS3piRmx4cVlNNWtHTHRmcEJrWUc4Q3BzOFowWHNUcHVwK2Rp?=
 =?utf-8?B?dk56TGNxMi9CSWp1NndnK2V0TEY5Q09XTGcvdm92cmkxdlFhTkRTSDB5YjV6?=
 =?utf-8?B?OVMzZ0ZoVUpKTzNRQjg2ZmpxbERQdGtTb1BXZDFWaGthNWxYVkhYb0VSSHo2?=
 =?utf-8?B?aXU0QWJQYm01eEZFK2lOQmQ4TEFkRkQ1MUFqYnhmUGdQOElYYWVUeVJudTFP?=
 =?utf-8?B?TjJXTktMakhTUWl6Mnd6Nlh4RDVoV2dmRy9TNHBGSGUxbWxUalV3ejNRS2NB?=
 =?utf-8?B?UDlJcS85d2dmdHJwWUFzVi9hWlhRV0IzMlFES1ZEVDNZdjIzb0tVeWVjT0dI?=
 =?utf-8?B?dXV1dlZKSUpoQkNHSXl2NEthS2p1UUEzaWc3YWZZdnRrYXVzd29pNk9SZG5H?=
 =?utf-8?B?eDBaWE9hY2xGOFduQWt0TGZFbzl1R2NZMTR0Q0NmZkZxN01GZVhJL3hWTW1H?=
 =?utf-8?B?YzExeVYrUHUxNnNzc1UwZUdlN0JBUGRtUkpXemZJSXduN0YwQW1QQ3dRazVo?=
 =?utf-8?B?S2VQdFNDejF1SktaQ1lQVStTTDNpbWRadXJUOGVKM3Y3S2NYUEs5My9nKzF2?=
 =?utf-8?B?ZSswSm5tRDMwMTNGL2pnNDBpMDNsbFhmWmlJM2R0UXplTUdCWWtWZnBaRjF5?=
 =?utf-8?B?Y29Pd1kvREkwZTFQUTk3M2sxSTg4RGIvYnQ4ZGVmUW9aajVsNXhjaUpiYjF5?=
 =?utf-8?B?Z1ZMVy8vM2VEb0VITGl3TWoyTmFEU2hRYVVVb1BLMTIzaHF5emRYRng4ZVRU?=
 =?utf-8?B?Qml4djdHK2xzWmx2V1hyWjFJWjZtZUxiRUY0eEVOZVNjSjY2UjhhSXRQWW9G?=
 =?utf-8?B?dFhKRVdWQSsrK1p3TnRPRWNzKzY0TS82N09aQ1N1RzdKS2RMMHhtWFBGTnQr?=
 =?utf-8?Q?BSPl6SJXkpq7vamnduGIvws=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3357b1a5-d456-478f-d65e-08d9d2479515
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3283.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2022 01:38:33.8507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDgxzSyrZPOhyxGwwy+xqau39d377V9J+JjAbsljPhIb+g30gv4Bm/CykC3jKStqhidFndExeeiRX80WKvfgog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2145
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10220
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201080006
X-Proofpoint-ORIG-GUID: 6CfvZWucIWU1GHGWTdewLra4hJ-8ctCA
X-Proofpoint-GUID: 6CfvZWucIWU1GHGWTdewLra4hJ-8ctCA
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAxLzYvMjAyMiA5OjQzIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4g5ZyoIDIwMjIvMS83
IOS4iuWNiDk6NTAsIFNpLVdlaSBMaXUg5YaZ6YGTOgo+Pgo+Pgo+PiBPbiAxLzYvMjAyMiA1OjI3
IFBNLCBTaS1XZWkgTGl1IHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiAxLzUvMjAyMiAzOjQ2IEFNLCBF
bGkgQ29oZW4gd3JvdGU6Cj4+Pj4gQ2hlY2sgd2hldGhlciB0aGUgbWF4IG51bWJlciBvZiBkYXRh
IHZpcnRxdWV1ZSBwYWlycyB3YXMgcHJvdmlkZWQgCj4+Pj4gd2hlbiBhCj4+Pj4gYWRkaW5nIGEg
bmV3IGRldmljZSBhbmQgdmVyaWZ5IHRoZSBuZXcgdmFsdWUgZG9lcyBub3QgZXhjZWVkIGRldmlj
ZQo+Pj4+IGNhcGFiaWxpdGllcy4KPj4+Pgo+Pj4+IEluIGFkZGl0aW9uLCBjaGFuZ2UgdGhlIGFy
cmF5cyBob2xkaW5nIHZpcnRxdWV1ZSBhbmQgY2FsbGJhY2sgY29udGV4dHMKPj4+PiB0byBiZSBk
eW5hbWljYWxseSBhbGxvY2F0ZWQuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4g
PGVsaWNAbnZpZGlhLmNvbT4KPj4+PiAtLS0KPj4+PiB2NiAtPiB2NzoKPj4+PiAxLiBFdmFsdWF0
ZSBSUVQgdGFibGUgc2l6ZSBiYXNlZCBvbiBjb25maWcubWF4X3ZpcnRxdWV1ZV9wYWlycy4KPj4+
Pgo+Pj4+IMKgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDUxIAo+Pj4+ICsr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0KPj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMzcg
aW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIAo+Pj4+IGIvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jCj4+Pj4gaW5kZXggNGEyMTQ5ZjcwZjFlLi5kNDcyMDQ0NGJmNzggMTAw
NjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4gKysr
IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4gQEAgLTEzMSwxMSArMTMx
LDYgQEAgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUgewo+Pj4+IMKgwqDCoMKgwqAgc3RydWN0
IG1seDVfdnFfcmVzdG9yZV9pbmZvIHJpOwo+Pj4+IMKgIH07Cj4+Pj4gwqAgLS8qIFdlIHdpbGwg
cmVtb3ZlIHRoaXMgbGltaXRhdGlvbiBvbmNlIG1seDVfdmRwYV9hbGxvY19yZXNvdXJjZXMoKQo+
Pj4+IC0gKiBwcm92aWRlcyBmb3IgZHJpdmVyIHNwYWNlIGFsbG9jYXRpb24KPj4+PiAtICovCj4+
Pj4gLSNkZWZpbmUgTUxYNV9NQVhfU1VQUE9SVEVEX1ZRUyAxNgo+Pj4+IC0KPj4+PiDCoCBzdGF0
aWMgYm9vbCBpc19pbmRleF92YWxpZChzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHUxNiBp
ZHgpCj4+Pj4gwqAgewo+Pj4+IMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5KGlkeCA+IG12ZGV2LT5t
YXhfaWR4KSkKPj4+PiBAQCAtMTQ4LDggKzE0Myw4IEBAIHN0cnVjdCBtbHg1X3ZkcGFfbmV0IHsK
Pj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfZGV2IG12ZGV2Owo+Pj4+IMKgwqDCoMKg
wqAgc3RydWN0IG1seDVfdmRwYV9uZXRfcmVzb3VyY2VzIHJlczsKPj4+PiDCoMKgwqDCoMKgIHN0
cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyBjb25maWc7Cj4+Pj4gLcKgwqDCoCBzdHJ1Y3QgbWx4NV92
ZHBhX3ZpcnRxdWV1ZSB2cXNbTUxYNV9NQVhfU1VQUE9SVEVEX1ZRU107Cj4+Pj4gLcKgwqDCoCBz
dHJ1Y3QgdmRwYV9jYWxsYmFjayBldmVudF9jYnNbTUxYNV9NQVhfU1VQUE9SVEVEX1ZRUyArIDFd
Owo+Pj4+ICvCoMKgwqAgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUgKnZxczsKPj4+PiArwqDC
oMKgIHN0cnVjdCB2ZHBhX2NhbGxiYWNrICpldmVudF9jYnM7Cj4+Pj4gwqAgwqDCoMKgwqDCoCAv
KiBTZXJpYWxpemUgdnEgcmVzb3VyY2VzIGNyZWF0aW9uIGFuZCBkZXN0cnVjdGlvbi4gVGhpcyBp
cyAKPj4+PiByZXF1aXJlZAo+Pj4+IMKgwqDCoMKgwqDCoCAqIHNpbmNlIG1lbW9yeSBtYXAgbWln
aHQgY2hhbmdlIGFuZCB3ZSBuZWVkIHRvIGRlc3Ryb3kgYW5kIAo+Pj4+IGNyZWF0ZQo+Pj4+IEBA
IC0xMjE4LDcgKzEyMTMsNyBAQCBzdGF0aWMgdm9pZCBzdXNwZW5kX3ZxcyhzdHJ1Y3QgbWx4NV92
ZHBhX25ldCAKPj4+PiAqbmRldikKPj4+PiDCoCB7Cj4+Pj4gwqDCoMKgwqDCoCBpbnQgaTsKPj4+
PiDCoCAtwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBNTFg1X01BWF9TVVBQT1JURURfVlFTOyBpKysp
Cj4+Pj4gK8KgwqDCoCBmb3IgKGkgPSAwOyBpIDwgbmRldi0+bXZkZXYubWF4X3ZxczsgaSsrKQo+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzdXNwZW5kX3ZxKG5kZXYsICZuZGV2LT52cXNbaV0pOwo+
Pj4+IMKgIH0KPj4+PiDCoCBAQCAtMTI0NCw4ICsxMjM5LDE0IEBAIHN0YXRpYyBpbnQgY3JlYXRl
X3JxdChzdHJ1Y3QgbWx4NV92ZHBhX25ldCAKPj4+PiAqbmRldikKPj4+PiDCoMKgwqDCoMKgIHZv
aWQgKmluOwo+Pj4+IMKgwqDCoMKgwqAgaW50IGksIGo7Cj4+Pj4gwqDCoMKgwqDCoCBpbnQgZXJy
Owo+Pj4+ICvCoMKgwqAgaW50IG51bTsKPj4+PiDCoCAtwqDCoMKgIG1heF9ycXQgPSBtaW5fdChp
bnQsIE1MWDVfTUFYX1NVUFBPUlRFRF9WUVMgLyAyLAo+Pj4+ICvCoMKgwqAgaWYgKCEobmRldi0+
bXZkZXYuYWN0dWFsX2ZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fTkVUX0ZfTVEpKSkKPj4+PiAr
wqDCoMKgwqDCoMKgwqAgbnVtID0gMTsKPj4+PiArwqDCoMKgIGVsc2UKPj4+PiArwqDCoMKgwqDC
oMKgwqAgbnVtID0gbGUxNl90b19jcHUobmRldi0+Y29uZmlnLm1heF92aXJ0cXVldWVfcGFpcnMp
Owo+Pj4+ICsKPj4+PiArwqDCoMKgIG1heF9ycXQgPSBtaW5fdChpbnQsIHJvdW5kdXBfcG93X29m
X3R3byhudW0pLAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDEgPDwgTUxYNV9DQVBf
R0VOKG5kZXYtPm12ZGV2Lm1kZXYsIGxvZ19tYXhfcnF0X3NpemUpKTsKPj4+PiDCoMKgwqDCoMKg
IGlmIChtYXhfcnF0IDwgMSkKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FT1BOT1RT
VVBQOwo+Pj4+IEBAIC0xMjYyLDcgKzEyNjMsNyBAQCBzdGF0aWMgaW50IGNyZWF0ZV9ycXQoc3Ry
dWN0IG1seDVfdmRwYV9uZXQgCj4+Pj4gKm5kZXYpCj4+Pj4gwqDCoMKgwqDCoCBNTFg1X1NFVChy
cXRjLCBycXRjLCBycXRfbWF4X3NpemUsIG1heF9ycXQpOwo+Pj4+IMKgwqDCoMKgwqAgbGlzdCA9
IE1MWDVfQUREUl9PRihycXRjLCBycXRjLCBycV9udW1bMF0pOwo+Pj4+IMKgwqDCoMKgwqAgZm9y
IChpID0gMCwgaiA9IDA7IGkgPCBtYXhfcnF0OyBpKyssIGogKz0gMikKPj4+PiAtwqDCoMKgwqDC
oMKgwqAgbGlzdFtpXSA9IGNwdV90b19iZTMyKG5kZXYtPnZxc1tqICUgCj4+Pj4gbmRldi0+bXZk
ZXYubWF4X3Zxc10udmlydHFfaWQpOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBsaXN0W2ldID0gY3B1
X3RvX2JlMzIobmRldi0+dnFzW2ogJSAoMiAqIG51bSldLnZpcnRxX2lkKTsKPj4+IEdvb2QgY2F0
Y2guIExHVE0uCj4+Pgo+Pj4gUmV2aWV3ZWQtYnk6IFNpLVdlaSBMaXU8c2ktd2VpLmxpdUBvcmFj
bGUuY29tPgo+Pj4KPj4gQXBvbG9naWVzIHRvIHJlcGx5IHRvIG15c2VsZi4gSXQgbG9va3MgdG8g
bWUgd2UgbmVlZCB0byBzZXQgCj4+IGN1cl9udW1fdnFzIHRvIHRoZSBuZWdvdGlhdGVkIG51bSBv
ZiBxdWV1ZXMuIE90aGVyd2lzZSBhbnkgc2l0ZSAKPj4gcmVmZXJlbmNpbmcgY3VyX251bV92cXMg
d29uJ3Qgd29yayBwcm9wZXJseS4gRnVydGhlciwgd2UgbmVlZCB0byAKPj4gdmFsaWRhdGUgVklS
VElPX05FVF9GX01RIGlzIHByZXNlbnQgaW4gaGFuZGxlX2N0cmxfbXEoKSBiZWZvcmUgCj4+IGNo
YW5naW5nIHRoZSBudW1iZXIgb2YgcXVldWUgcGFpcnMuCj4KPgo+IFN1Y2ggdmFsaWRhdGlvbiBp
cyBub3QgbWFuZGF0ZWQgaW4gdGhlIHNwZWMuIEFuZCBpZiB3ZSB3YW50IHRvIGRvIAo+IHRoYXQs
IGl0IG5lZWRzIHRvIGJlIGRvbmUgaW4gYSBzZXBhcmF0ZSBwYXRjaC4KQWdyZWVkLiBUaGUgdXNl
cnNwYWNlIChxZW11KSBoYXMgc2ltaWxhciB2YWxpZGF0aW9uIGZvciBzb2Z0d2FyZSAKdmlydGlv
LW5ldCBhbHRob3VnaCB0aGUgc3BlYyBkb2Vzbid0IG1hbmRhdGUuCgotU2l3ZWkKCj4KPiBUaGFu
a3MKPgo+Cj4+Cj4+IFNvIGp1c3QgZGlzcmVnYXJkIG15IHByZXZpb3VzIFItYiBmb3IgdGhpcyBw
YXRjaC4KPj4KPj4gVGhhbmtzLAo+PiAtU2l3ZWkKPj4KPj4KPj4+Cj4+Pj4gwqAgwqDCoMKgwqDC
oCBNTFg1X1NFVChycXRjLCBycXRjLCBycXRfYWN0dWFsX3NpemUsIG1heF9ycXQpOwo+Pj4+IMKg
wqDCoMKgwqAgZXJyID0gbWx4NV92ZHBhX2NyZWF0ZV9ycXQoJm5kZXYtPm12ZGV2LCBpbiwgaW5s
ZW4sIAo+Pj4+ICZuZGV2LT5yZXMucnF0bik7Cj4+Pj4gQEAgLTIyMjAsNyArMjIyMSw3IEBAIHN0
YXRpYyBpbnQgbWx4NV92ZHBhX3Jlc2V0KHN0cnVjdCB2ZHBhX2RldmljZSAKPj4+PiAqdmRldikK
Pj4+PiDCoMKgwqDCoMKgIGNsZWFyX3Zxc19yZWFkeShuZGV2KTsKPj4+PiDCoMKgwqDCoMKgIG1s
eDVfdmRwYV9kZXN0cm95X21yKCZuZGV2LT5tdmRldik7Cj4+Pj4gwqDCoMKgwqDCoCBuZGV2LT5t
dmRldi5zdGF0dXMgPSAwOwo+Pj4+IC3CoMKgwqAgbWVtc2V0KG5kZXYtPmV2ZW50X2NicywgMCwg
c2l6ZW9mKG5kZXYtPmV2ZW50X2NicykpOwo+Pj4+ICvCoMKgwqAgbWVtc2V0KG5kZXYtPmV2ZW50
X2NicywgMCwgc2l6ZW9mKCpuZGV2LT5ldmVudF9jYnMpICogCj4+Pj4gKG12ZGV2LT5tYXhfdnFz
ICsgMSkpOwo+Pj4+IMKgwqDCoMKgwqAgbmRldi0+bXZkZXYuYWN0dWFsX2ZlYXR1cmVzID0gMDsK
Pj4+PiDCoMKgwqDCoMKgICsrbXZkZXYtPmdlbmVyYXRpb247Cj4+Pj4gwqDCoMKgwqDCoCBpZiAo
TUxYNV9DQVBfR0VOKG12ZGV2LT5tZGV2LCB1bWVtX3VpZF8wKSkgewo+Pj4+IEBAIC0yMjkzLDYg
KzIyOTQsOCBAQCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfZnJlZShzdHJ1Y3QgdmRwYV9kZXZpY2Ug
Cj4+Pj4gKnZkZXYpCj4+Pj4gwqDCoMKgwqDCoCB9Cj4+Pj4gwqDCoMKgwqDCoCBtbHg1X3ZkcGFf
ZnJlZV9yZXNvdXJjZXMoJm5kZXYtPm12ZGV2KTsKPj4+PiDCoMKgwqDCoMKgIG11dGV4X2Rlc3Ry
b3koJm5kZXYtPnJlc2xvY2spOwo+Pj4+ICvCoMKgwqAga2ZyZWUobmRldi0+ZXZlbnRfY2JzKTsK
Pj4+PiArwqDCoMKgIGtmcmVlKG5kZXYtPnZxcyk7Cj4+Pj4gwqAgfQo+Pj4+IMKgIMKgIHN0YXRp
YyBzdHJ1Y3QgdmRwYV9ub3RpZmljYXRpb25fYXJlYSAKPj4+PiBtbHg1X2dldF92cV9ub3RpZmlj
YXRpb24oc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4KQo+Pj4+IEBAIC0yNTM4LDE1
ICsyNTQxLDMzIEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2Rldl9hZGQoc3RydWN0IAo+Pj4+IHZk
cGFfbWdtdF9kZXYgKnZfbWRldiwgY29uc3QgY2hhciAqbmFtZSwKPj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+Pj4+IMKgwqDCoMKgwqAgfQo+Pj4+IMKgIC3CoMKg
wqAgLyogd2Ugc2F2ZSBvbmUgdmlydHF1ZXVlIGZvciBjb250cm9sIHZpcnRxdWV1ZSBzaG91bGQg
d2UgCj4+Pj4gcmVxdWlyZSBpdCAqLwo+Pj4+IMKgwqDCoMKgwqAgbWF4X3ZxcyA9IE1MWDVfQ0FQ
X0RFVl9WRFBBX0VNVUxBVElPTihtZGV2LCAKPj4+PiBtYXhfbnVtX3ZpcnRpb19xdWV1ZXMpOwo+
Pj4+IC3CoMKgwqAgbWF4X3ZxcyA9IG1pbl90KHUzMiwgbWF4X3ZxcywgTUxYNV9NQVhfU1VQUE9S
VEVEX1ZRUyk7Cj4+Pj4gK8KgwqDCoCBpZiAobWF4X3ZxcyA8IDIpIHsKPj4+PiArwqDCoMKgwqDC
oMKgwqAgZGV2X3dhcm4obWRldi0+ZGV2aWNlLAo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgIiVkIHZpcnRxdWV1ZXMgYXJlIHN1cHBvcnRlZC4gQXQgbGVhc3QgMiBhcmUgCj4+Pj4gcmVx
dWlyZWRcbiIsCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXhfdnFzKTsKPj4+PiAr
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FQUdBSU47Cj4+Pj4gK8KgwqDCoCB9Cj4+Pj4gKwo+Pj4+
ICvCoMKgwqAgaWYgKGFkZF9jb25maWctPm1hc2sgJiBCSVRfVUxMKFZEUEFfQVRUUl9ERVZfTkVU
X0NGR19NQVhfVlFQKSkgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoYWRkX2NvbmZpZy0+bmV0
Lm1heF92cV9wYWlycyA+IG1heF92cXMgLyAyKQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiAtRUlOVkFMOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBtYXhfdnFzID0gbWluX3QodTMy
LCBtYXhfdnFzLCAyICogCj4+Pj4gYWRkX2NvbmZpZy0+bmV0Lm1heF92cV9wYWlycyk7Cj4+Pj4g
K8KgwqDCoCB9IGVsc2Ugewo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBtYXhfdnFzID0gMjsKPj4+PiAr
wqDCoMKgIH0KPj4+PiDCoCDCoMKgwqDCoMKgIG5kZXYgPSB2ZHBhX2FsbG9jX2RldmljZShzdHJ1
Y3QgbWx4NV92ZHBhX25ldCwgbXZkZXYudmRldiwgCj4+Pj4gbWRldi0+ZGV2aWNlLCAmbWx4NV92
ZHBhX29wcywKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmFtZSwg
ZmFsc2UpOwo+Pj4+IMKgwqDCoMKgwqAgaWYgKElTX0VSUihuZGV2KSkKPj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIFBUUl9FUlIobmRldik7Cj4+Pj4gwqAgK8KgwqDCoCBuZGV2LT52cXMg
PSBrY2FsbG9jKG1heF92cXMsIHNpemVvZigqbmRldi0+dnFzKSwgR0ZQX0tFUk5FTCk7Cj4+Pj4g
K8KgwqDCoCBuZGV2LT5ldmVudF9jYnMgPSBrY2FsbG9jKG1heF92cXMgKyAxLCAKPj4+PiBzaXpl
b2YoKm5kZXYtPmV2ZW50X2NicyksIEdGUF9LRVJORUwpOwo+Pj4+ICvCoMKgwqAgaWYgKCFuZGV2
LT52cXMgfHwgIW5kZXYtPmV2ZW50X2Nicykgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBlcnIgPSAt
RU5PTUVNOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9hbGxvYzsKPj4+PiArwqDCoMKg
IH0KPj4+PiDCoMKgwqDCoMKgIG5kZXYtPm12ZGV2Lm1heF92cXMgPSBtYXhfdnFzOwo+Pj4+IMKg
wqDCoMKgwqAgbXZkZXYgPSAmbmRldi0+bXZkZXY7Cj4+Pj4gwqDCoMKgwqDCoCBtdmRldi0+bWRl
diA9IG1kZXY7Cj4+Pj4gQEAgLTI2MjcsNiArMjY0OCw3IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBh
X2Rldl9hZGQoc3RydWN0IAo+Pj4+IHZkcGFfbWdtdF9kZXYgKnZfbWRldiwgY29uc3QgY2hhciAq
bmFtZSwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbWx4NV9tcGZzX2RlbF9tYWMocGZtZGV2LCBj
b25maWctPm1hYyk7Cj4+Pj4gwqAgZXJyX210dToKPj4+PiDCoMKgwqDCoMKgIG11dGV4X2Rlc3Ry
b3koJm5kZXYtPnJlc2xvY2spOwo+Pj4+ICtlcnJfYWxsb2M6Cj4+Pj4gwqDCoMKgwqDCoCBwdXRf
ZGV2aWNlKCZtdmRldi0+dmRldi5kZXYpOwo+Pj4+IMKgwqDCoMKgwqAgcmV0dXJuIGVycjsKPj4+
PiDCoCB9Cj4+Pj4gQEAgLTI2NjksNyArMjY5MSw4IEBAIHN0YXRpYyBpbnQgbWx4NXZfcHJvYmUo
c3RydWN0IAo+Pj4+IGF1eGlsaWFyeV9kZXZpY2UgKmFkZXYsCj4+Pj4gwqDCoMKgwqDCoCBtZ3Rk
ZXYtPm1ndGRldi5vcHMgPSAmbWRldl9vcHM7Cj4+Pj4gwqDCoMKgwqDCoCBtZ3RkZXYtPm1ndGRl
di5kZXZpY2UgPSBtZGV2LT5kZXZpY2U7Cj4+Pj4gwqDCoMKgwqDCoCBtZ3RkZXYtPm1ndGRldi5p
ZF90YWJsZSA9IGlkX3RhYmxlOwo+Pj4+IC3CoMKgwqAgbWd0ZGV2LT5tZ3RkZXYuY29uZmlnX2F0
dHJfbWFzayA9IAo+Pj4+IEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFIpOwo+
Pj4+ICvCoMKgwqAgbWd0ZGV2LT5tZ3RkZXYuY29uZmlnX2F0dHJfbWFzayA9IAo+Pj4+IEJJVF9V
TEwoVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFIpIHwKPj4+PiArIEJJVF9VTEwoVkRQQV9B
VFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVApOwo+Pj4+IMKgwqDCoMKgwqAgbWd0ZGV2LT5tYWRldiA9
IG1hZGV2Owo+Pj4+IMKgIMKgwqDCoMKgwqAgZXJyID0gdmRwYV9tZ210ZGV2X3JlZ2lzdGVyKCZt
Z3RkZXYtPm1ndGRldik7Cj4+Pgo+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
