Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA6AC433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 02:08:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DC6660F89;
	Wed, 22 Dec 2021 02:08:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L5g0Gh4gh-l1; Wed, 22 Dec 2021 02:08:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F069960F6F;
	Wed, 22 Dec 2021 02:08:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFCA0C002F;
	Wed, 22 Dec 2021 02:08:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DF70C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:08:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C006415AC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:08:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="QJ+nb5X1";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="OlOXyj++"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0iElTBqZikZk
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:08:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA782410D4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:08:32 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLLE2wj005975; 
 Wed, 22 Dec 2021 02:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xUt3N0xU04zEy5E+hPg1HEOD/4V2FetVgNSqTfJMxPY=;
 b=QJ+nb5X1Y1Ffcz8q4Gg5W5x2/8HxQk8wOHxCGYvJhLxu/0NQBXdbFdkBumf2yVBE6VeH
 IzhSoTNvyNygBtBu3e8kG0vwcAFwhFuNlerfkrcPM9ByG3E097z96mjpRjgTB5NOLDXi
 kAT8pPbjCs/21Uc+hRwHlrcMhv1jks8eEaPlb+V1FRsGbUxXGTubAHvEYD/sR8tbh1qs
 q6rbpjEbEaimhvUP4Gqn+CKlz7wBmZ2PbqNy9afXJPTmpi3FYoojuFEQ4N2iCod+NSMd
 uW0mHzybnyGZ+LqSIygBZABP/VHy2m17cdWY9mjBSjyOK7FwclmSpMJkx/pwjNedVsYX Ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d2qbqvy42-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 02:08:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BM26ruL102055;
 Wed, 22 Dec 2021 02:08:30 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
 by aserp3030.oracle.com with ESMTP id 3d15pe1s9r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 02:08:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsDd4yAetHzDGTahkfUA30Oh34nMF8puGUd9qbGZ3yLA10dZrP8m6ZjHiAqicTFJoMg5hzIoVf/8gTM/gOdeBukUNgOof+IbAcMsPZ+obg93wLHVE2zREXEOcmjaAq+u0T7SBT8xI1To9u5vGFPjZFoYPPX9JHRPPK5pAjaBS6F3z66kgedJTJIqS1b6NjBs/1TRAuyiqFDKMOVvWeoiNKGVpBrqDw6H/2z8UcaWFo7Dru5+eahhw47X4kgmCzWLjYxUktBSjHhxSEcjncgJsPVjsI+pfsrtOFjvqlK6hm26cFn6QS8sQyMNCgLd27Di03kkY+41/8QnG4662oMRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUt3N0xU04zEy5E+hPg1HEOD/4V2FetVgNSqTfJMxPY=;
 b=NQFtMRX4Bl3fTA+ocOrOgRHmjvLx/fwQa/Mk2M2IwB+xpLKroHOSJ1kGjBYpmpz8m+B3CoCGox60qVXNHUyYtzZlkQyM59zToZ6a7vq9TYzzwcfNZg5YLDPJI786s9cdYuiBcwRkGKaBJSQ6371/rL0oiZ4gvHRSla6+JP9y55V0+CFfiLpQbNiJkbiasKMWnToOL2xVRDnn1d+DPMUGDNv1f76X9eWp7UQ+oOYc2e3iiCgwy2zyE2denvkYp0c+fOAeCsywQZd4VLfWOPkAlu3YFFnPGP83qhaIMlm45d/9YFb69arGjTKVS2F4JWDy1/lI4Q3+O7J/cXiABDXUEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUt3N0xU04zEy5E+hPg1HEOD/4V2FetVgNSqTfJMxPY=;
 b=OlOXyj++dHKkldqeA7Q+2/1HrsXwj7QKSPuUMkvIf7tTsnG8kn2DI6fuETwkIS1ZgZOxd+xoGbGrDMzhiuZG4MvhVxBYV2kCm7kCAlgD2ZWUkCJseC7oZhuxfl9KXDdNZqMSK9QhSZio5R2iv7aEY7j7nr6FT13GnuO6O1UMjoI=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB3796.namprd10.prod.outlook.com (2603:10b6:a03:1fe::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.19; Wed, 22 Dec
 2021 02:08:28 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 02:08:28 +0000
Message-ID: <d3b10536-0a6b-21d3-b0c8-a05cda7b9d33@oracle.com>
Date: Tue, 21 Dec 2021 18:08:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 13/13] vdpa: Use BIT_ULL for bit operations
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211221172006.43784-1-elic@nvidia.com>
 <20211221172006.43784-14-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211221172006.43784-14-elic@nvidia.com>
X-ClientProxiedBy: SN7PR04CA0211.namprd04.prod.outlook.com
 (2603:10b6:806:127::6) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4ef9851-a622-4353-2454-08d9c4eff19c
X-MS-TrafficTypeDiagnostic: BY5PR10MB3796:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB379673C8ED866A860AB1FCE2B17D9@BY5PR10MB3796.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b70pupnjdDXEvoju/+UE04ZFmTDbAdJ7ImZgoQgRXo6XNIageYh+X43Zv2+/OmztnMAR7utvoj2WgkaDcJwOol+Y4bKrfQD83jDARr83hPCC0IXXKIeXnPaXPFOuUPh9iKuxi2yNpvPT0NqLe6V9HFsAD45LhTve47esBy8k6OJGF0o+UyDDrKgI4fnIksYoqLM7cq5ex4w3/SIQlkO3ca0SB9v60UGDemieb6hD07qYOuPdD5hXK6niGRTBO9o8y/WApHrvjjIRE1AoFdNwYUnxRGoHbdQgl4VhSR7/WHCIIz//blfhh1q5N9yGiO9pH2d94U5GNZq7iA65QOM27YGE+zmj0ghwK+UpaUQF2coeZxWLJuKDMVYLlhhpnziNNbVABW7+atDWsH0P9ILK1Lr0JuawbT9QsgggaEQ4touSacAcwxGlq0vgGsx0i/bodj2OpDO26adXiWB8vG9LsgVv9Y4AZ/oMnBHhaIU1FYU3tPIdeXvra2A1Q8qN8wEXGVtFBwU8rscwQd/GFNOmCB+rfUtzUsa/YaRKC6ZEJliFsp/VwUEP40mLSn1LqTb62eZge4RQfq4f/qFVk0hBCLFLNn0Ol4Vu1BPt8YGqAYwO1QMSvMAV77Sy8gPfbsIVTWQdidhAyEBndUji8N6RTk4M5ekElco74NK7EePrQKKBmC/b/mC3MyK1lJi6S+XGLQlC/asdKgNXCTKtKnU1s+IYvBqmbh/bZFDvYoZOBWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(186003)(6666004)(8936002)(36916002)(38100700002)(26005)(86362001)(83380400001)(6486002)(31686004)(5660300002)(8676002)(53546011)(316002)(6506007)(66946007)(2616005)(66476007)(66556008)(2906002)(508600001)(4326008)(31696002)(36756003)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFBCMXBJclZSa3ZlTk1uTjRtZzF4S1M4MjIrNHYzQVI4bTVKTHp1eUZwUllr?=
 =?utf-8?B?Vm00WTRqdnpQVi9qYlFGMVViQzV1czlnbnFtYVlCSGVGUWh5dDN2K003emEv?=
 =?utf-8?B?RnVIZmlSVXYyaUNNQWtMb2JKS1pTQ2JyYmN1amRPMFFGM2swWU52N0dlZFY5?=
 =?utf-8?B?d0NJbm9DNUlzWllybEN0dUM0QWZSTXVYT1ZtK3FQaFdyS3hIWTNVZ1MySy9Z?=
 =?utf-8?B?UVZnSDJnbkVTQVFyVEN1YVNSbUZlbnlJYkdqcGdxZ1JIM1lvOFRFb0h1Rzlo?=
 =?utf-8?B?Vkt5dmwwU1NtM1ZpdzhBNUNJQUI1Rkxoc1JsTnRneTVkZFc3ZFQzbVduZmI3?=
 =?utf-8?B?cEdhRUhqR1MwcVp4N3N2ZzhPVUdHclY0bWxXbjc0dERXTkZoclVLRGNwb0NQ?=
 =?utf-8?B?cC9wcS92UUFPbUFxSitkaklweXNsTXdheDJBMW14S0w3eWllZlR0bVJWTDFK?=
 =?utf-8?B?M05id2lUWkxzRHhpYmVSY0VXSnRaRElyS1BtdWoyUmttb3NCelFXOE9mWnpi?=
 =?utf-8?B?V2FCSVhlMXo3a2lwY3NFUXZzVUthVmc0LytMZDFCSTF3SjJTNGVsMjZrcEhL?=
 =?utf-8?B?dEJIMDgyZ2hwUUFmMkFtTTVPZTE2aVVEQkErTEtnYkQrM2hidkM0eXA5T3lr?=
 =?utf-8?B?RGRwWnpjU3VzZi9WeEJrbEJ4aWZKeWYwbEJhU2g3bXpWZWxnSGplNjVWcmJq?=
 =?utf-8?B?VG8vWS9QZ0FpWFdRVG1ZTlZneWZGODJpTFVKNnVhdm1IeXJXYW5kSlVnREhV?=
 =?utf-8?B?RFVKVkJmTE1QYXZaN0Z1dWhMYlR1OWlJb0lNS3JvVEZoSzVNZ2hLSjJIS3BW?=
 =?utf-8?B?K0gyOWhWbVV4WS9WSEdiQWtGeUs0OEp6Ymx4OXpXSjRXWVEzNGhGRmhvM2h1?=
 =?utf-8?B?Q1ZOazljNUxDNUE2eS9vOVNNSC9vNkVTNnlvSFhudE44VERKdjRSL2c4UU4v?=
 =?utf-8?B?eEtKaUlLVjJmSk11Z3dNZEc4QlNYZmp0bng3SFhYaHBsTVFoVVhQSmU3V1hG?=
 =?utf-8?B?SFp6TDdjbGROck5aSGdyZExGSlBkMHlSamJlZi8xWklFdXpSZFZNWkZMMUlw?=
 =?utf-8?B?WC9YTkJ3WTVGbjlqaHJRZ3pQWW1YaUJGTnY1OEVXKzNzWEpiMmx4SzNpZUVh?=
 =?utf-8?B?bmxXWTZ4ay9nWW9WK045RUJjeVRjK2M2UzNFSCttSDQrWHhBdG1tOFlWSmI1?=
 =?utf-8?B?QnBBSmM0SGhBcE5VMEJub0J1aXcrb0NCQUE0U0plMkpsUEdCVjR6U0RkWHBm?=
 =?utf-8?B?T2hZTVhHWmdjZXlWS1FIbjRQdnBBSDZzemcvRUE0bjFnL2RMdzl1TmNLclhh?=
 =?utf-8?B?a1JOQzM4S0F4cENIYUtwYi82YTVjQmVGb0lKdTVDN29RVjA3Sy92TzIzYmds?=
 =?utf-8?B?UUprRFNjQVRHbGtwZy9mQjlCMGh4NTM5bjh3aWEwZTNURm9GMGc4dGVpUFFP?=
 =?utf-8?B?cVoyWUZvSnJaWHZwWlYrQjVPUnZZTXh2V3RpT2t3c2VVcmY3aTNsbFRFL0Rz?=
 =?utf-8?B?TStzazdTZ3d3ZkJtaXRybDlVKytoUXMwcysyWlkxNytKVS9HMC9MV3d1OXRi?=
 =?utf-8?B?S3dud2IwTUYzaGt1TmRNaG05OEtlNHUrbEFlNEd1NENkdlZqNG85aEZjL2lP?=
 =?utf-8?B?b1NIbEZGd2d2MFd2aFNxTlB4RGF1a3NxbklQMUl3K3ZzUXZ2WnZZUVYzNnB3?=
 =?utf-8?B?bVhEU2F4QTJQMnpNaHBwaEk4cDRiN21FWWgwZ0hHM013OXRINGphU2JQL2J2?=
 =?utf-8?B?WkczVjlUQzZ0RTh2d2xMS2wrVVpGL0JtZ014SXdyT0orY3JoYWc0c0xQTDNp?=
 =?utf-8?B?cWZIOSs5ZStsNFBqZWtNRVhjVC9qTWE0MlBHZ3YzVEIrMVcxaFYzRndiK08y?=
 =?utf-8?B?YkdKY0ttVEs1TVp3RCtCOHlQUzAzWHphZFZybEhQVDlKalRuTlBnT2JkS2R3?=
 =?utf-8?B?VFpQOXptR3l6SlBJME9BRncwc0o0MWU0TFBGWEZLY1hYbC8xNk0zT2ZLNldJ?=
 =?utf-8?B?cTRBNmRXeXhzakRXR2FGTzVkbWZvNzFZRUgyclhma1VYT20vRU94bnNLTHhG?=
 =?utf-8?B?T0FIWk5CWGZMckJxbEE0VjR2ZUJZcVM5L1B0dmYvcTlhZVdMM2NvbW1GMTZV?=
 =?utf-8?B?WE03YUp3MnY3bThLblgvL0YvYUJPL3BDSFdJOWJLakxBWkFtSW5zVlZiM2RV?=
 =?utf-8?Q?1rDbNLsFwvcQ3qVYIlWpC6I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ef9851-a622-4353-2454-08d9c4eff19c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 02:08:28.0968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfGdwGZi6s3IcuoVor/3w3ivcbD4hF9W78RpXL3xpU1HbiL+37I3gq07WBjLbKjcqBoQT3iuCBL2GNUe3fYc+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3796
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10205
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220011
X-Proofpoint-ORIG-GUID: cq5EJYUezQHFg1mIoWhZP_FzXbOKyLl1
X-Proofpoint-GUID: cq5EJYUezQHFg1mIoWhZP_FzXbOKyLl1
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
> All masks in this file are 64 bits. Change BIT to BIT_ULL.
>
> Other occurences use (1 << val) which yields a 32 bit value. Change them
> to use BIT_ULL too.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   drivers/vdpa/vdpa.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 4b649125a038..84ee11393349 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -576,9 +576,9 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>   	return msg->len;
>   }
>   
> -#define VDPA_DEV_NET_ATTRS_MASK ((1 << VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> -				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU) | \
> -				 (1 << VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
> +#define VDPA_DEV_NET_ATTRS_MASK (BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> +				 BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)     | \
> +				 BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
>   
>   static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
>   {
> @@ -597,12 +597,12 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>   	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
>   		macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
>   		memcpy(config.net.mac, macaddr, sizeof(config.net.mac));
> -		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +		config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
>   	}
>   	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]) {
>   		config.net.mtu =
>   			nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
> -		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MTU);
> +		config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU);
>   	}
>   	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]) {
>   		config.net.max_vq_pairs =
> @@ -814,7 +814,7 @@ static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
>   {
>   	u16 val_u16;
>   
> -	if ((features & (1ULL << VIRTIO_NET_F_MQ)) == 0)
> +	if ((features & BIT_ULL(VIRTIO_NET_F_MQ)) == 0)
>   		return 0;
>   
>   	val_u16 = le16_to_cpu(config->max_virtqueue_pairs);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
