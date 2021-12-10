Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AE8C433EF
	for <virtualization@archiver.kernel.org>; Fri, 10 Dec 2021 08:17:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8143A40249;
	Fri, 10 Dec 2021 08:17:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h8dIUP_uJd_B; Fri, 10 Dec 2021 08:17:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 41090401D2;
	Fri, 10 Dec 2021 08:17:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E4A9C001E;
	Fri, 10 Dec 2021 08:17:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACDA9C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 08:17:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A1E5661311
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 08:17:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="SaBVeHyu";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="SCAGchUQ"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4TtH-7YGABgr
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 08:17:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 435746130F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 08:17:55 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BA7kkR3012285; 
 Fri, 10 Dec 2021 08:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=l/5sGb7jZwEHyIrCmTAnkY8mbdQ3OakB8pSpaTF3+qY=;
 b=SaBVeHyuvBq7c0ZlVOC/BFJi2CMotkLPmSX+wGY5XfXwrMjBBzsqRwB9554O/mk9nuhC
 DueON8tQjo496XuqbeBOdVkOsuaIHbspY7EX2nXP7504Az4vhWHmXAetQkwksM0mUl1y
 KQVL2uqWNnAckoZ8Qci8k/qoIQb1XIDZFrahKx+tJMgJXPU/LBqxOoBl3QVjrdGqhJuh
 2SKyajCW4d2g4ZtBzkeP62eMg8/WLh03ippHf5+PM+emNrM0Kz/Fas3Sg/KaXrqjVAuL
 2PJzHHTjpAI5E3B+wxGonhLKbidBbdwg1VJT8sA/4jN5AOO+K64Gl1WLmsXRBUgO9Qhe Yg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ctrj2wpm0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Dec 2021 08:17:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BA8Aph0040108;
 Fri, 10 Dec 2021 08:17:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by userp3020.oracle.com with ESMTP id 3cr1stwm1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Dec 2021 08:17:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=konIUORMyhv5lPBJUFCZZqgJgPQmEX6Bvj9ZZv1aBmI0KgoqXClxVdfJLtzuXg/Bgty3tiH3kzbbl2XQ2ZCoFv+S3OSNxAuwJzdtB5GhQ24YNeFmeRmP7Iuic7ix6RHxxYkCC9gBHHqWkJPX6Ua83LbZBAZD88FHKDhXfVBOkVV5uHKnGqc+0A8q+pXcCtSQKijCSFn6qzYYzK40dJxZmj4wax0CUTOw6hfXCK2Spcu7TueopG2k9Onp6hO65PeKVZo3/iHcCfCp1v/xQQ8NmnSsImlkvnQcbn72qQwoOoh7n/RroHwbq6IuaY/9dxS/N4HPRnpu+NZZBifcxxX9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/5sGb7jZwEHyIrCmTAnkY8mbdQ3OakB8pSpaTF3+qY=;
 b=cTqgsaStP5MHsu2RemzMtGFRypp1VdBumGZYFLIQ2J6Y+dxTlitf8YBc+z37wFgRVbF2pgO88r9DH306VshUQRG/xPj2/iLWlLsMocOQYnvc66SyN+8INxzQYLtTHSAnQ96408alIvPLhG29mAOK6TskTzmEmtW6wKQZevxmBsTEd8lDrCl49FgCNl1qgJ2O/sRFlIz2QWPlAwivJ8r76l5HRfQyceaeaegcIcKq7R8UB9VzAFMEI6ZpT2qDU3nI2A7rYbbkyjbvpzZBotBpllxHv08rTKtbcY+hhMXPCAyOil8CdpJXR3V3oK4kK8DDylXqnYpbwRqBg5IGXfoHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/5sGb7jZwEHyIrCmTAnkY8mbdQ3OakB8pSpaTF3+qY=;
 b=SCAGchUQ7rplePLRPZ+md6mINNa48nxea+HlrrGydq6/EZX4ri7WZTCVg613G4e2GryP1HotDOofb2Y4IX70GsFEVKAuY7WzEiITQZ3nsxhUCg0IN87mmXFguBCGXmSHG/BHBrZRXk8JnFbRkNYkZEUiWUpzOaO/iXfxoNlIfJo=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2839.namprd10.prod.outlook.com (2603:10b6:a03:85::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 08:17:50 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4755.025; Fri, 10 Dec 2021
 08:17:50 +0000
Message-ID: <790448b5-1d64-4d5a-8fc0-09da8a4c7669@oracle.com>
Date: Fri, 10 Dec 2021 00:17:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 7/7] vdpa/mlx5: Restore cur_num_vqs in case of failure
 in change_num_qps()
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-8-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211208201430.73720-8-elic@nvidia.com>
X-ClientProxiedBy: BY3PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:217::26) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.159.153.254] (138.3.200.62) by
 BY3PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:217::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend
 Transport; Fri, 10 Dec 2021 08:17:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bbfbc9c-5198-414e-7fcf-08d9bbb58e44
X-MS-TrafficTypeDiagnostic: BYAPR10MB2839:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2839B1F05B04C9E39267BE64B1719@BYAPR10MB2839.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8YywQ6qYP4HpKS2kKm5jg6EwWORPYKdxhpGwner34A0ze5yxvas80XidtOrzXz0GGBXCzbdYcSwUWjRxmCUX9u7HeHkJixPKgBd3+ZFX+QvNd/mFm+GLx3b3opAziZw/tTDjW03H0GPDqe5g8PZgaRu4XxGR6E/vv4Yya+/3VcHlnajsPQ10oJI1hPh4Oc2R5zF46tHpmOjnFmsbEp9oLsDeqQKAJtppXhCulLRMw4rDVDQ504gRZTUYRqTpr1WVeoVif6P+xO5O51EmqNUtrXMwa7lhvJcCg4eQlk2/KyH0QsEMSogmUnMyad/N23QEmizrLy9MGOeLqBc3vBTs+hiITlPemuS927Wgf/Vw43RQ+tO6oTeF3r4l0mjNVaMimcu/ladhH3DoyJDUtWiDa/khBLC+0pjIwejFIoXLN4XCEQbXVdSAprKh/x3wpaOdJR3w80FDIOiSlp/fCePTvT2bnzV5e308qsXHqzC2A0t+9jtld4sxbRj/MEfGcqqzY0VhHYdK7iop9hyrE88su3x+aEBCbomEJgAKQ4HyhJbXMMx8SSVwodDccl971e0BSgFB8uUp5sHqz5Ya5FbYLWn45RAXHK0Cn1Xj/Rcdfy9cyO8W4qtiyewlHaatOk7qhTNCfi3xjQrlK/+w+cC5Qik1pNnEBmaS1pqJu7Uj32DDb3hl1YIft8iI8BeLgoK8uQl7drL61GfYtB3Qy8eB429CiI5dqHAKNY81j8wMtbg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(956004)(4326008)(6666004)(66556008)(2616005)(36756003)(8936002)(38100700002)(66476007)(2906002)(31696002)(31686004)(508600001)(5660300002)(16576012)(26005)(6486002)(86362001)(66946007)(53546011)(4744005)(186003)(83380400001)(316002)(8676002)(36916002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGc4QU5Qd2RwR3pCS3BuQzVFVXpmNlpJclc3V0h4NENWc0M3U2pWU1RFc2FM?=
 =?utf-8?B?dGgwMW1ORlNYaklzeUgxVU5DNWtnZnlGcWpZbjhUMDhIaFhYZkFPR0FWYlU4?=
 =?utf-8?B?NEIzdXI0MlRQRWJSeWxDbXNxazlOZW5tWkN0Rll2RndmZ2ZXZ2ZpRkJ3VGFD?=
 =?utf-8?B?ZlZPbGNKTHhkMDVVNGM1UkpOVHNIdnV3UHJXVG5uWXRlQzBqWEVIaGlVOGdm?=
 =?utf-8?B?amgrL0ZqUHNKbzBNTkVOeHhBL0dXelA3MFFSV0JyRFJlOUxQRmVselJpR25M?=
 =?utf-8?B?STRKN2hvQSsxbjByb3pGN1EwTE8zNmdHeEkxSGhnU1BvK3ZKRCtRWmtSYktx?=
 =?utf-8?B?Z1Z0ZVRWNkdhNDh5K0F1VEtocDgza3BFb09VTjJZdU5IYjN4VkxMTUhqOWMw?=
 =?utf-8?B?ejVCVUMxQVNWNjF4ZkR0ZUpMaTB4QjhzZTg4Zkh1d2xHYkpvdUxrc2pYTkl1?=
 =?utf-8?B?MWFrTEg1b1FTSkZ6RkRLYitTRzRlVmFHcUVrQ0VVN2p0cGpGVklBMElZWGEz?=
 =?utf-8?B?dWNvNDdUZUtPSS9ZU3FqbGVVV3ZEdXQrdFVTME5wSytPa2gwVVB4SlFINUtN?=
 =?utf-8?B?dUV1OGJwdXVwM1hwZTZWZjlWWmVQUUZQUWRabGUzY3FPdk11dVN3UkRUR1Rp?=
 =?utf-8?B?dm8vN1hBaGFWS0JyZS93dlAyTDlTK3VCNi83OUxMOXgvZG9sbldoaG96bmtj?=
 =?utf-8?B?dWtNUGhTNkFYeWZvWWlWbmxXZXY0b0xGTkpCZVNBbkpwb3pndGo5RWN6UWU3?=
 =?utf-8?B?VHh4cWVYN2JUY0dtTVB1cjZEODlud0ExNnhHTjFWZ21rb25sS3h5M0dicXhw?=
 =?utf-8?B?ekY2STEyNHo2c0J5ZE1qV29ITXF2MVU1OGM3bTdMeHJIVlQrd0hYTHBBT1E3?=
 =?utf-8?B?N3ArcWpPZVA0dHdranQxSUFxczFUS01xS1daNUxGWWhtT3ZrSFhuRFVKRnhi?=
 =?utf-8?B?bGZ1eDBKM2hYK3NXbDRGRUUrMHZiWkRGaXpBaUFwam1oQ2o2ZDZnaEdqMUVY?=
 =?utf-8?B?c1JOcEN4LzZ3bFk5NGZ0ZWdETHdsaWZHeERYMkgyWVFSZC9XUHJVa3haWXFx?=
 =?utf-8?B?SG52U2RmclliSCtoRXdpNU9LMERFL3RKVUl1TzF0MFJnbUV1WDdkR2VIVlhQ?=
 =?utf-8?B?cGh3S0JFY0hjZ3FibjJnb0NTUHgyOCtNUXhsandwRHZZZEdXaDNVNzV3RlAy?=
 =?utf-8?B?dE81akxZUmwxRENTWFFrS09DcVhFQWpvMERrNlhPaTc4cjQzVmZQLzRGQUtu?=
 =?utf-8?B?QjF2OXNzZ3IrTEw3WEU4d09MWm5xMDFRb29zRVNFQmoxRnM5NnFrcHN1L2Yv?=
 =?utf-8?B?b3dVWEZqL2pFK3pQT3k1MlczV2VOTzVMTWY3ZXdLeU01RHpFZHBqVHl1QnFL?=
 =?utf-8?B?RmFLcXN1VWtkdUlJa1lxWnpNSHg2ODZXTm5mZW5vdUpySVBiV1prNzllK09o?=
 =?utf-8?B?K3hDdElxQzVlRkx2U1BreURpQ01UYytNa2pOVXBlbTdYcXNmYXJxQURYZkRn?=
 =?utf-8?B?U08xQzAvN3dVSDhWMWNINkJUbEdjaGtPREQxMVRUTGlEWHltYlVzVUJoRWF0?=
 =?utf-8?B?TmM5RXpZYUlTVWJKdjFLRW9jYS9nMEc0TkZSYzdNbUxBNWZDMUFjQkxTcGtG?=
 =?utf-8?B?Y2ZyMjE2U3pFTWsyTTlSaExYREVFWXNIQ1FMb3JCUm11U0hyODJia09MWHNO?=
 =?utf-8?B?SFd6Yk5iOGlISXh3b0t6R1RNMTBtdWV5QTJkQzRRbmNaRXlkc0lLeXpmTktK?=
 =?utf-8?B?ZHN0SjNmVVl6WlpPRlpoQ0cvYUJmck8vRHhPOFV5QUNGYWwrZGNyRWNqaWpw?=
 =?utf-8?B?cldJdkQ1a1pZbVhBd1ZVY3FBTjF5VDhUejNpN2pHOU03a1FsQXQ0RXhZUUt6?=
 =?utf-8?B?TW9pUW1XampNSnpFUCtHYmlwbEZBdXNGTnFGak9YRFo2QWZZS0tPYy9NaXV0?=
 =?utf-8?B?V0pWRWpFeFU3QkxBOEl0bFJ5SHBCK1NLTXpVODBjU3BxNXpwQkJCZGtHdnFF?=
 =?utf-8?B?bWF0TDQ4eTdTdkM3QmJieFVDdkVxM2duNEE1KzFiOUU4VFFGbFZpTk8zYnZS?=
 =?utf-8?B?T2lHcG1LWHY3YzBaV3FJZW9LbFNHdlUrUE8zeTZxR2ZTNFlEWWQxNlA4ajda?=
 =?utf-8?B?RStsK2ZHSjZyemt5WWFZazV5ajZTRlNkZzVCcmx1TzJ0TXZ0NmRzZVBobDNS?=
 =?utf-8?Q?bu2TpBAd/ROpFnFqjpGjA4A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbfbc9c-5198-414e-7fcf-08d9bbb58e44
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 08:17:50.1526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6ZTQzBInz8F+knQ7WLjyOE9mTpkrO2OgAcDBSgNgCPeKgAH9t15EfREd9zSQ/8ofG3xa1XUVPTpBLzcWMNyZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2839
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10193
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112100046
X-Proofpoint-ORIG-GUID: aqWTrq_8aodJ9cx8S6Px3V-_SrhAgtkY
X-Proofpoint-GUID: aqWTrq_8aodJ9cx8S6Px3V-_SrhAgtkY
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



On 12/8/2021 12:14 PM, Eli Cohen wrote:
> Restore ndev->cur_num_vqs to the original value in case change_num_qps()
> fails.
>
> Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 4f0b8bba8b58..2d37240e8bfc 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1539,6 +1539,8 @@ static int change_num_qps(struct mlx5_vdpa_dev *mvdev, int newqps)
>   	for (--i; i >= cur_qps; --i)
Should the condition be i >= cur_qps*2 instead?

>   		teardown_vq(ndev, &ndev->vqs[i]);
>   
> +	ndev->cur_num_vqs = 2 * cur_qps;
> +
>   	return err;
>   }
>   

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
