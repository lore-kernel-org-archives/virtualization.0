Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9A8C433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 21:46:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 26BF64016A;
	Tue, 11 Jan 2022 21:46:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IGLub936Dm3L; Tue, 11 Jan 2022 21:46:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4836A4018D;
	Tue, 11 Jan 2022 21:46:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21964C0030;
	Tue, 11 Jan 2022 21:46:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFE04C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 21:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9EBA64161E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 21:46:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="t9pRe2wY";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="reLp/AiO"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2YNfk_X41Lkz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 21:46:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A38ED4161D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 21:46:21 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BJNw7b028126; 
 Tue, 11 Jan 2022 21:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5heCg/ae19Hr/1NIviNwtFyUHYNPe1ae2DSCkJc89H0=;
 b=t9pRe2wY3Dj6OuIliqKXPKf5dJlYNyjnAmDVfNklE3dYT00Ty5t9TfcMxhB0vPNniYpu
 faBcNmCkrlLQjpn9egt1+w8rvgVmP8wxJdr71K/Ow1sm2cvCLHhTTbEcz83J+9mpj2xq
 R/A2fjlNNcWGQ6jser13SWWEDoixB5q8h44DCclthBtNMxg2sh1aUO2nDUOJvNFBaiq7
 ZqvBG5+EUXbMrmVJZkp9ShIAB+BV0MVuqWjCIEy4k3dayhkJXydqaCVjLBfcRTnX2ulS
 4KEYTA5mpJJsvC0XLsVWbJd4/djhoXspAaIgI0E+Cm/+czgbxUBIV6wdkvIpLrCLzTX5 Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgn74ca50-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 21:46:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BLeUAa102779;
 Tue, 11 Jan 2022 21:46:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
 by aserp3030.oracle.com with ESMTP id 3df0nekpm2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 21:46:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcysGbfE5PYn69SmKw2pkvZrFZ7ZUoOeItRExPgGOnrvyD36V225DjayIZfNErqMCdRY/cNgHc+01+TUP7FYQwzHIKBF7m9G3iELl+xLkkFCvR0jdEt2bFyGqHzZJopK1OFnQvDOBUZKgVMbtaMzvjAugLezOvIh96j1QWfMyOJyLop6I4aUu36HtFJ7MnYMvOToq66HuG2tem2/A31n0kqR2qtnjXbhvnsk+xX/yjfRYOtX35n2zwJVBPnxnqyrW0LfuUjWFP7VC98xd4fldlDhpnQMPs+YRQAsaLRAgXD3XpHB/1T02ehZeOYH88KJg8xxXRRxJbNyelew1q3vPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5heCg/ae19Hr/1NIviNwtFyUHYNPe1ae2DSCkJc89H0=;
 b=PVdjoxnhM2Z9JrfxNT+4l5NLBdDm5n5DVPldo4nJ0zhRXLW43GRLBsQMXf/lkHKQ/st6OU6YnNKLJbw5+e1KY2nyGNje9mvVhRBdBHILihKb5wuGbdrAkusp0xoCz1G9CW0AZRrcBFke3+/S2r0Fnr7/E76A3ty67o9hrKf169Ns9rpHYk4JU8UlHoMaoXxlty0BJA9/7y+sjMMfhwX7U1tXoqlzJGC7KUEjae+rLb2CmPZvfyWfgHv9bZgUcJHHDoDgY/Ct2e/WL8OmRiZHqYsfYN3fzVfgYfCrYnNRv2M0n4cNLjkUg/h1DlOy/6UfjSeYh1dj9hdLzR7c0J1TYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5heCg/ae19Hr/1NIviNwtFyUHYNPe1ae2DSCkJc89H0=;
 b=reLp/AiOn7apzDfj4koLt7XF5OgzqrYZyMUffocRzqDh96RJO0Y9XxaIRVN2yRAN2N1hg0cDeI1ZTFWZ+rHxwzXxgu52VxyAYZ5Fms+dxV0MQfMyx+oLG7vCWKuM7wOhCasvebwrA8MyImBd1uFDhWMQinWaRdVVieegav8b36U=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB4672.namprd10.prod.outlook.com (2603:10b6:a03:2af::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 21:46:16 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 21:46:16 +0000
Message-ID: <bbcf2b15-c911-a969-957d-428538fe92bf@oracle.com>
Date: Tue, 11 Jan 2022 13:46:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/4] vdpa: Avoid taking cf_mutex lock on get status
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20220111183400.38418-1-elic@nvidia.com>
 <20220111183400.38418-2-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220111183400.38418-2-elic@nvidia.com>
X-ClientProxiedBy: SN7PR04CA0075.namprd04.prod.outlook.com
 (2603:10b6:806:121::20) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d03bfe4a-e82c-4a3c-aab9-08d9d54bcb92
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4672:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46728DE910D1B8059DD4E04CB1519@SJ0PR10MB4672.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jONpBY3I/hxvxwV96uw3N7tbkGvgJxITa2eGDLXsqC0m/owu0UPGwc5a/u0toG5TmsHcnqGE2/mQJ1w8lVMUc+7zGQ4CDizm6IwlM5/IWj7PAEizqgUxDMS2DqrcF1ZD9YrGJUlCZymo4bTeEDPX9yaRqzWLaQKuAVc5/MVed/8yU1Pe/pgBTC4dILeH/7ioEhImqIj0IGNfn2ha+XxItjZaKo++oOJNRyWtaItdDN6tRawqJYedcpE1BtOH2Z0TPg4yW0DcKnE1G8Cy2HuyKZ1ry+/TxAmQNbEmuc432mVhd5b2L3w8tWMtzvaDaYr5jQYm1h1zRTfASP2eEWrzSyQCtWScHj71W/X0V2IFHREYIzQYyOMLSpUZ4cAPRXpdkdnku0gKMUso6XR+/rhIh9brumNhjk6sXZ2z3jBIrVnZ7c9UNUFy+YWCendXCXbNsFFDz8tUxP2hGe8Us90xfn8GHMJzxzUdZafarBhRaVctjso6ItTgXlTngcab9YlXdBUF4n+oMOCeLlFCGkSOCITf9IMVtZmPDpEbhlchzUaoT+teUpUMztkhFKhPni4ZP2uWIbWfBNSoK4Y9D4IqSjRYIgLPqpitmpJgjet7aKRa3sSt5EMKNRC/67AD8zvOvBjj4lCVOagKi21G1Ql6zk+pCT9uBqVrmllNDS1wFFZsUuvXKiiX3OoiSbcCgXUXVGQYQTNk66cVhz/iXWbGEDb9dJ2pOBQr1/t4FABjfO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(86362001)(6666004)(186003)(26005)(2616005)(66556008)(66476007)(66946007)(508600001)(2906002)(38100700002)(6506007)(53546011)(36756003)(6512007)(36916002)(83380400001)(316002)(31696002)(31686004)(5660300002)(4326008)(8936002)(6486002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3RQTnFSLzg4TjBGb04zYkVEV1pNTjlvdWNTOW9FSDMxYkdNT1NwOUVZKzF3?=
 =?utf-8?B?R3BmOG9vSlcyNjMxeXZpWUtiTVdOOHhVWnJ2RWhpS2x6aXZsZmk1WnFsMER4?=
 =?utf-8?B?Qmt6Wld4d240RE5QdFFKWmlPZm9VeDR4VEtxeG9KTEM5Q0VSLzBlcjRwU3Jx?=
 =?utf-8?B?SVBKZEZGRFd0QVhtNDhuT0VwR1JhNGY4TmVzVWh0TjRDWVFxOUIwaVVONWJp?=
 =?utf-8?B?dys0N1hZOFhhYWtOc2Vueml0NE1Nd1IvMTJDaXhoNU9URFBrRzcxdHNBbWw1?=
 =?utf-8?B?T0dXU2dUR3pibkNkdjVLdU9yK3R0YzQwYU5ndE9obVU5MHlyZ2FuaDhNOUt4?=
 =?utf-8?B?eXU2WVhSaHRidHQ4TWIxdFFFSmxQalRGVFVrM3B5WU5PWXh4eVMvRE1JV3dx?=
 =?utf-8?B?Y2hWZzV2ZU54a2EwWk9vWUNpWVhDUFVXbzlYaGNUbjk3MkpvbEJDVWhvaHRR?=
 =?utf-8?B?anl1T0tha1h5OXIwOW1NbGhudUxQeG8wdDJIc05lKzlsQVpJWWpBdGF0Q2s4?=
 =?utf-8?B?bEV4ck5KY2dyL2JzdnRORG5HbDNpSEZaN1BhVHhWcEp5ekNvOCtVOTVNYnRD?=
 =?utf-8?B?eFJ4OEQwcDhDcmd5U2JEbzVsSjBNTExEOWlaS0M2NWhzU3FQY2dOUmUxWFcv?=
 =?utf-8?B?RlBpODlpMkJ1dno4UzJLRFQwRjIxamZkN01ZMTBEclVYclc3S25LbVAyQ3cx?=
 =?utf-8?B?WVZnNFBkLzBQNFI0NkRyMmxlYy81enJJRXVNWXV0OTUzZ0xlMDBuSTNleDRC?=
 =?utf-8?B?WkZ3bHNiQ1hMS3NBRWpVMjF3eENjaXpUcXd1SzNvZ2djU1k5NkNqK3V4RkZL?=
 =?utf-8?B?MjRWbUVCaWVlekR4SXloMmlpamgzOTR0bVd2aytWa1dJZmpFaVYvcWZzUkZK?=
 =?utf-8?B?Y3RvWVovck9RMEs3Y2ZhcmpGV1hYTFdka2d5d2swZnpPS2dtSmVRemlhRUJs?=
 =?utf-8?B?dUdrQ3FoeFVQb2d4MkV6WmFWenBVdWxxSktNZkdaVjAzYnhUQmRaWndCK2Rk?=
 =?utf-8?B?cklNMkZCekRjRkhBb0EwLyt4T2FiOEh6bUdhTVZTUiticmt1Z1M3YlM0cTdR?=
 =?utf-8?B?Z3A1WEJoSVNmaW5Fb29RWTFXaXVFYWYrb2E0ZzhYUiswNkhDZ0JvV2I5NFRI?=
 =?utf-8?B?KzBTOHJTTFkraVpJSDROQ0k4K2lDOGxDWlVwRXo5RDhLT0ZlVUZyWDZ3Ylla?=
 =?utf-8?B?a0dIeWJFRlNCUHQ3aXlhSnNWSlFQRTI5WWpqNEo1L0pBdU9LcGpTeVZJdnZJ?=
 =?utf-8?B?MDFJaWIwZmJGcmhlL0UzMGw4YjJvWmtPdTZrTGZ4M2Q5ZlhmTjkwZE43UW84?=
 =?utf-8?B?R21pZXJwa3hVenJaQ2c5d3oxbTkyWCs0aGc2RUV0V095UTc2RTFPNmMvWHo4?=
 =?utf-8?B?MTJmb1k5dkJxdFE2T0xUYTZaeHF4eXV1Q3Nja25GcjU5Mit6TGZHUitiQXZW?=
 =?utf-8?B?YmtxR0NGek0zTGoxa2xqWmZQbW5UUTUveGl3cktOaTVoR1Azc0QxQzBpMFdD?=
 =?utf-8?B?K3kyUldHWVQ0bDM5MjdOWWxMRVR4bnVWb09yTk1oQXA5MWttZjlhU3NCRmMy?=
 =?utf-8?B?MytjWFJlRDllMkxqMm40aWlMbjZVUXBJNGVtWjVWRVJOS1NsSWNJQ2RGaUl2?=
 =?utf-8?B?anpQTDdObnhoR20yTEMvMk9mTVJJS29MWjlxQzUyNmtyVkZvbHBRcklnNmZj?=
 =?utf-8?B?dnJOUFdUelI3NCtsZ1dGSU5jMTROWFF1cDgrUm93RXRXbURoem1CaENxa2Fo?=
 =?utf-8?B?N29YdkplNHJHQVpwZ05BS0hFYVp6MGxtVlhJakUweXhSU08wdysxNE9mZUdx?=
 =?utf-8?B?Uk1JN0FjYVJTVVhlRDRkdHgvMy85T0szSEFxc2M1VjY4VWl0WE1BZExGeXpz?=
 =?utf-8?B?QktJTG5DbFptaHBMVnV6eWhrdk53VDF4WXhuQlVrS3NpWHRoRFUrVGxoU3Vl?=
 =?utf-8?B?dGJETU10RnpQK1VMSDQwR2diWTlsaHpHMTVVL1g0KzJkS2gvNUx6REkvRUww?=
 =?utf-8?B?OXFJMStOaUx0OHRtVUZBcDFodFVkaEZoVThvVHgycitCc3NkUTBNUFBlOE1G?=
 =?utf-8?B?WFd2cGRYOTFkMDgwRm1SUmNLQksrREZNYmIzejJmSmM3ZnlLT0poMkFLNFFs?=
 =?utf-8?B?WU5JMWo2YzJuK0l1ellRSExLMC9tWTNBdHlnTE9kWGRjVmJxb25ZdzZDSGNx?=
 =?utf-8?Q?9m6mJN5/IKhhBQF8IYz9OWs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03bfe4a-e82c-4a3c-aab9-08d9d54bcb92
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 21:46:16.6629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFLYV+4qs5VDofpWlpVagpgp6P0Lb/SevUzZeQRbasJQa7quzVGycfV+29q3Qo2646IPf8g/wY4rwG22LKZmBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4672
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110112
X-Proofpoint-ORIG-GUID: LM5b-GeHmyV_WTBzq7SN6-tydEihOXEJ
X-Proofpoint-GUID: LM5b-GeHmyV_WTBzq7SN6-tydEihOXEJ
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



On 1/11/2022 10:33 AM, Eli Cohen wrote:
> Avoid the wrapper holding cf_mutex since it is not protecting anything.
> To avoid confusion and unnecessary overhead incurred by it, remove.
>
> Fixes: f489f27bc0ab ("vdpa: Sync calls set/get config/status with cf_mutex")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>
> ---
>   drivers/vdpa/vdpa.c  | 11 -----------
>   drivers/vhost/vdpa.c |  5 +++--
>   include/linux/vdpa.h |  1 -
>   3 files changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 4380367d00b5..9846c9de4bfa 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -21,17 +21,6 @@ static LIST_HEAD(mdev_head);
>   static DEFINE_MUTEX(vdpa_dev_mutex);
>   static DEFINE_IDA(vdpa_index_ida);
>   
> -u8 vdpa_get_status(struct vdpa_device *vdev)
> -{
> -	u8 status;
> -
> -	mutex_lock(&vdev->cf_mutex);
> -	status = vdev->config->get_status(vdev);
> -	mutex_unlock(&vdev->cf_mutex);
> -	return status;
> -}
> -EXPORT_SYMBOL(vdpa_get_status);
> -
>   void vdpa_set_status(struct vdpa_device *vdev, u8 status)
>   {
>   	mutex_lock(&vdev->cf_mutex);
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 6e7edaf2472b..0ed6cbadb52d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -142,9 +142,10 @@ static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
>   static long vhost_vdpa_get_status(struct vhost_vdpa *v, u8 __user *statusp)
>   {
>   	struct vdpa_device *vdpa = v->vdpa;
> +	const struct vdpa_config_ops *ops = vdpa->config;
>   	u8 status;
>   
> -	status = vdpa_get_status(vdpa);
> +	status = ops->get_status(vdpa);
>   
>   	if (copy_to_user(statusp, &status, sizeof(status)))
>   		return -EFAULT;
> @@ -163,7 +164,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>   	if (copy_from_user(&status, statusp, sizeof(status)))
>   		return -EFAULT;
>   
> -	status_old = vdpa_get_status(vdpa);
> +	status_old = ops->get_status(vdpa);
>   
>   	/*
>   	 * Userspace shouldn't remove status bits unless reset the
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index a6047fd6cf12..2de442ececae 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -421,7 +421,6 @@ void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>   		     void *buf, unsigned int len);
>   void vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
>   		     const void *buf, unsigned int length);
> -u8 vdpa_get_status(struct vdpa_device *vdev);
>   void vdpa_set_status(struct vdpa_device *vdev, u8 status);
>   
>   /**

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
