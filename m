Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F97C433FE
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 22:29:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E61B94288A;
	Thu,  9 Dec 2021 22:29:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WgYKFrpvSx3b; Thu,  9 Dec 2021 22:29:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B705E4287C;
	Thu,  9 Dec 2021 22:29:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D038C002F;
	Thu,  9 Dec 2021 22:29:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1F93C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 22:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CFBFA6F98E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 22:29:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="AHkUiOMH";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="QYgz71B/"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F6D97DmLa_Tn
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 22:29:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 502FF6F990
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 22:29:26 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9K3pte012285; 
 Thu, 9 Dec 2021 22:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Wg77k36bXcG5Mks07vC4N+d6410+v87rmiglIQBgqEM=;
 b=AHkUiOMHIqJB7xWjynqnKxH7exxZHIOitN7jJfPjG5xvTAXeo5ygu2S7zbUTUWGX3dcW
 bGiVpaw7v7xGFcD7j//XXRWAgiv8U9Jgb/BE9sTPJuRku99+XoftL1IMTmagj1GXZJzw
 L9b8r0KxyZrrlL4SFGAvfxziinZ9yA7RyFX83Q1HznO6RVK/8Y6cPIjDRHG/HND+duqH
 Qv6errG5+2lRbU3M7oOh70Ys8ziUaLNBsnHt3cQ2k9pl27NSltEbSbKmLb9ilE+hDkjr
 vNkUg/hGLCIgnCA+AF0vPvOAs9zmvK64vMKYeHOYJswQ8wX0ctuRsmy33yZkduSsiVHM Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ctrj2vx8f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Dec 2021 22:29:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B9MBVr7114604;
 Thu, 9 Dec 2021 22:29:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
 by aserp3030.oracle.com with ESMTP id 3csc4wurtw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Dec 2021 22:29:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpsBBS/llaG2AhL1wIfjqy33bu7D9VJTYfblajdiUZc5c9WqsDQ7CQ2BDidJM9u80RHGK6Rl0KID69nO4qX4anbU3V4nmpBTx+3ccPPinVzbu45K+99SqM1U5lh8z0qvdtlmD2bjGPoJfT6kEHrCt9eeuZziBIqm6XWDrfBDoTulKBvpTsE9YUdZ72rTKEZ6lRFJuOUSSULXx7vikseYQqlTBBzX76JPY0VHn49Lq0OdKRdOcUoZcSaZK386xGG8oGz3UKhmMEGJKRxy8pV0RbW7pI4H87AtGDqSv46SCUytqQYzVS3fijvdUVI5D1WkbVClq+7WDhoCRjWU9O2GNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wg77k36bXcG5Mks07vC4N+d6410+v87rmiglIQBgqEM=;
 b=Soq5pViyEC/PWLq+FuLDlO8Zt2UF5CTkU4UJ8UiVbbhH1L/LxsO8398M5TMk1EvLtMO8Q9Tnv3LiZPyq8PIkJORRK9LShpygFi2jw0Hk1tGvZsZPmQkAfdPnCdItTaH1v2twYM6RrCG4V2wKJQv6zNpfKfxyqWNyaDBsQgkR+NMDBqi41GiC600WUf3dX8hvKRUVhdax4MKTrRpzs5kp0DrrLCFCjnuoiD5NWimXRl3PFOMyKXfyDJvrjXY2n+ag/7apvIzJW4e+eNv2XZwbli5RKAga+d6NoRhh1taJgLOI7H2RkJjJDN9XL9ZzUKQGNQ4WRd2kyGb+RDN14ciAkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg77k36bXcG5Mks07vC4N+d6410+v87rmiglIQBgqEM=;
 b=QYgz71B/ApCdB3xppnHeBor49Kk1OTxsTCmaDCWnfLqw4bKGltj5OOY01gcr8zTnyK011NXGXQ4fypGIIa406nScCoBaBHYcwyZAXGBYwijTXvoM/8kF5HIDAyuIcBCjpcR2lOzb7L+ibB+IV0l9s5V9KlBbd3HSV7d2kPEgV6Y=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB4589.namprd10.prod.outlook.com (2603:10b6:a03:2d0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 22:29:21 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4755.025; Thu, 9 Dec 2021
 22:29:21 +0000
Message-ID: <9522131f-f3c1-1fdf-c63f-bcff00917fac@oracle.com>
Date: Thu, 9 Dec 2021 14:29:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 1/7] vdpa: Provide interface to read driver features
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-2-elic@nvidia.com>
 <ff8cdad8-cfbd-1d7a-545f-acda1e51a360@oracle.com>
 <20211209064702.GA108239@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211209064702.GA108239@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: BY3PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:a03:255::19) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.159.153.254] (138.3.200.62) by
 BY3PR10CA0014.namprd10.prod.outlook.com (2603:10b6:a03:255::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Thu, 9 Dec 2021 22:29:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bf58d0d-c163-465b-6bcc-08d9bb6358b2
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4589:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB45893D9DB779B5B7C5518641B1709@SJ0PR10MB4589.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4NyH2SfRov5dnuLsPf5UEXaXeKNlR7j+ldqEXeAbr7UdntFjLgtjxNaINsCAGzwEZCBp/zmW1KlIqXPamL+WBzvL6bmLrl6P4m18zVnoAcTdVBdBSVXOPBmDqyd3gR22KM1W+XVtJEhbTmRtNcu8XCKUbnprAE1sMbiEXJDfBBSyRC/n7fYhsopW5FLmNPVbeFnXyheW4t1GvbgjVL2NIyUEDgaMy8afn3XH7aC+qFP8Cdx/ByUABIpskiv69cE6v3Snb+b2pypxNdaMXWDa0bfu7JZoV97AjZ4XSu1MZCYjXcs10BCLklJMVj0CeGe4cPoiv+di/TvtvfqEoOSA35xFSIlPHfUodPGjYi0rF7NqNT5j5iR+jZYPGdGP06eHwP7j0OWbVm38a1em08w9fvv8HiuVRBBG5zzMcRRXFadTEAT8ieC7EQpJyAlKju6SHPQKlb1JoEJLI6oZfVtmbnhml+6F57bgGoBxHu7BkqsPtqaw7QVneUMOWqnj5gkWntjcK2472XYS54IVdX7OZSYHkSaRt4UbmKoRqQnOLAQP6G2pwInPS6fXY3YSyqdSqTWwklBSJq/EHDKZ8WMJErKb8eg8NscoN5CLDCHRSoEomcf7Az/iUAcvcarTKSuIlcqGs9c3IywPPw3E++bcL6mrTSoI6AVm2DXV8aczN3Udf+yJ0BQs5NAkQ5XTw9b2lSq9l2Yo0UVsY3ibvj+qVOg6jlSkY2gIbCYs+vcwt48=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(26005)(16576012)(6916009)(86362001)(31696002)(316002)(31686004)(186003)(36756003)(53546011)(2906002)(4326008)(83380400001)(5660300002)(38100700002)(508600001)(30864003)(6486002)(66476007)(956004)(66556008)(8676002)(66946007)(2616005)(8936002)(36916002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkZnL1BhRGlNK3prY1FySGdFcG9ZZVZYR29VZjhIMHJHN1FLK0diR1pTUjMz?=
 =?utf-8?B?R2hDUUlpYk40Kzk4UEFFV3VxdXJVcXF3T1QzVEdVa2tRZEhlN0ZtcDRNMzhU?=
 =?utf-8?B?RGk0UTdCdmZyQTV6VXBkM2Z6RVNIVGFFVXlNbmJHenZYMC9aeVhoSHo5SHc5?=
 =?utf-8?B?WTIxN3BNd2FCVDI3ckR0Z2hjSTNUbnBjSjcrcHpaSDdQNjh3ZjFLTzRoMjY0?=
 =?utf-8?B?ZlRocHg0SjlDL2J4b09SakpKWklMYlE4UUdrNzJhaU9EdElSbHdWZHBVeDlh?=
 =?utf-8?B?eGhZZWpySXlCM2lmWXdvRTNNWEd3WC9MU0NXK3Z5V2Q1b2xQMkl1OW9sK0M0?=
 =?utf-8?B?YlQ5R211c01NTjFPMjY2QVVEOGxlbVRvTklOZTdrVjVTT3kxa0F3Y05ML1Rq?=
 =?utf-8?B?WWNCSEExdUs4L1NLTkNLUnhuMWdmUGRucGV1VUVFQURkeFhwNVFFOUUvUjJQ?=
 =?utf-8?B?cXZmVGVjUVh5emUwUzlTQk5XYkw3VGt1UUx4dlhoM1ZyUTVkc005bllySmo1?=
 =?utf-8?B?ZExEVmtNbVJxVHdnelFvRldXMWdBZ3p4UG41cDgvQ01jZUl2bXl1am5vVmR0?=
 =?utf-8?B?QnpXNlB2MjJ4ZUs1OE5zYzVoSSs0RlFzSHRvQlh1SFo3NE5sK0x4WnZyL0tr?=
 =?utf-8?B?WEFrTzkyNmVodWQ5T2hwQ0hPQmRmdmoxTjNOWjUwVkFMRHBva0lwMytXMEJx?=
 =?utf-8?B?NW00aHJVSUtucjBqci93ek5GNlFhZnRZTUFvU0c3a2VselhSOFpTcmdObUE5?=
 =?utf-8?B?ZVVmK1dQb1E1UFBCdFZ2QWtHTk5LUjFheU1TZmV2NlVObktPazJsWGNFb3JZ?=
 =?utf-8?B?SUcrNGJ4MEI0UlEzcmpKSnNEeXoya2poRHFoMVpWbzE5L05HdzFWaHRwa1I2?=
 =?utf-8?B?VU5wTHZOU3dRQ3N5eFc0VjBvVnN0Tk9RSWpXUW56SUZOTEVkaVZEVVBwaDdT?=
 =?utf-8?B?VVBMaTFzNTgzSWxsNW5mS3h5bVBhT0x4WlIydVpnV1hqbXMzb3N2QTNnaG9o?=
 =?utf-8?B?WUd5TkIrNkEycDJSVEt4c2FCTkFCb1ljT1NHZ0Q2RzJ1SjZ5Y0hNcStidVU5?=
 =?utf-8?B?aHFrSmxkemJZZnlhR1pTN0VocXRKTkhSbWdOdVVyckdOMGU1U0VkdjNXVDI4?=
 =?utf-8?B?L2Q3SVA4RmxraFUvYXIyRS9JU01ERVpZUVovaTZJWUhBWHBiMkZjMmdoOS84?=
 =?utf-8?B?MHgxcG85Z0xHQ2huL04rL1RjSEVJczZ5TXF2eitrMWJiOG52bk1adkMrdDBi?=
 =?utf-8?B?WjJjM3hCenBpT2d2aCtlcnJiY1Fkd2drbkg4Zkg2VnNKRTF0UWFieGlMRndv?=
 =?utf-8?B?aFJDM21mTVBhL3dOWC9BV1h5TlhpYTBpTXpnUytvc21LOTdoc2I5UklTK0Rj?=
 =?utf-8?B?RXdlMmxVKzgzY1E0VXJGL3NMNGdEaHpiN2VQdVI4QzAyQ3dIWVBCaWlVbHQ5?=
 =?utf-8?B?M1FvYWNLSnN4bC94K2pJZktWQnI4OWVIUHpJSWVWRGpLV1dsVWY0c2V0cFlx?=
 =?utf-8?B?amhXdmxPUzI2cDhXTzAwSzVrd2NZZFZDL2xwVUtFVUN6NEtuRGZFYktZOTl3?=
 =?utf-8?B?blZFLzlYbWdjQ05zZGtaZVZuVXdtbWEzTVBmeWNhbWdmMmNoT011ZWE4NDNZ?=
 =?utf-8?B?bFBqYk5OZHpNMzJrbW1KdE1ZTlpQbzVWVTI2TDJBUkhsdFN0eXM5UHJkUGZO?=
 =?utf-8?B?b0swYTZJRHN4ZWZJdnNHMzdqV0NpaldrYVhhUEdldDJ1OHY3UVJnM0VzMEpa?=
 =?utf-8?B?SU83NEIzNGVhekdyZ2szTWdkKzRpRHh4QzZvYS9PbEU3R04yQyt4T0gzYTEw?=
 =?utf-8?B?R094RDJGeitVNTJWTzAyQXJwdHZJcnlUOFBtRFljQ0J5RGl5UUpMOENQM20y?=
 =?utf-8?B?bkJsczJZWGRKdk1qcXpQVGZUZlVFZmpsK0V0SmFiYWdnSFAzcDJBMEtIUkhj?=
 =?utf-8?B?aFhsellMc0RhdnlBMWt0TjZYaEg1d0RIMWtMQ2FzQmFKVDJLSlVIbjFFNWJ5?=
 =?utf-8?B?SU5MakhqWWQwbmJIM1d3TnEwMkpka0ZabEVEMXhrbmFQTjhYbFpDTDlrN3RU?=
 =?utf-8?B?NDRmcUY3TEpxeVJ4c0dyMFZZWVoxbVkwOVNGOTRlWE1GbXFkZzVBbGJOdFZY?=
 =?utf-8?B?aC85azEzZXFBL1RqcXh2UGh4YTRLUFdVVkRBWHdYM01ia3FNQzVmR3NxMWtT?=
 =?utf-8?Q?axnIMEOddhgU3ASjDt6YIJc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf58d0d-c163-465b-6bcc-08d9bb6358b2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 22:29:21.5130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axr3PNGG+PiluVUl1CN0ZyBinsTXufO1jQEe/STfBQ4VgZY59U9ma8lcEKSPkiMJA+w8NHUux4ylXbAIDNFdkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4589
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10193
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112090114
X-Proofpoint-ORIG-GUID: IIBqmeUyEQGrLV8_t17PppRotiDhrr9P
X-Proofpoint-GUID: IIBqmeUyEQGrLV8_t17PppRotiDhrr9P
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 12/8/2021 10:47 PM, Eli Cohen wrote:
> On Wed, Dec 08, 2021 at 03:57:21PM -0800, Si-Wei Liu wrote:
>>
>> On 12/8/2021 12:14 PM, Eli Cohen wrote:
>>> Provide an interface to read the negotiated features. This is needed
>>> when building the netlink message in vdpa_dev_net_config_fill().
>>>
>>> Also fix the implementation of vdpa_dev_net_config_fill() to use the
>>> negotiated features instead of the device features.
>> Are we sure the use of device feature is a bug rather than expected
>> behavior?
> I think so since in vdpa_dev_net_config_fill() we're returning the
> current configuration so you you don't want to mislead the user with
> wrong information.
You seem to imply vdpa_dev_net_config_fill() should return the 
current/running driver config rather than the initial setting of the 
device side before feature negotiation kicks in. This seems to work for 
the running link status which is propagated to the configuration space, 
but how do you infer the other untrackable running config the driver is 
operating, such as mtu, the effective value of which is not written back 
to config space or propagated back to vdpa backend?

>
>> How do users determine the configured number of queue pairs at any
>> point in case of a non-multiqueue supporting guest/driver or that the device
>> is being reset (where actual_features == 0)?
> I would think if you read during reset (which is really a short period
> of time), you get what there is at the moment.
I would stress out the case if guest not supporting multi-queue. For e.g 
guest firmware might only support single queue without control queue, 
which is not considered to be transient. Since the validity of the value 
connects to feature negotiation, how does the host admin user infer 
feature negotiation is complete? What is the administrative value if 
they have to keep track of the change without knowing the effective 
negotiation status?

Thanks,
-Siwei
>
>> Maybe we should differentiate
>> the static device config against driver/device running state here. I thought
>> the change to vdpa_dev_net_config_fill() in this patch would break vdpa tool
>> user's expectation that the value of max_vqp config is a fixed value since
>> the vdpa creation time.
> That was not intended to be fixed AFAIU.
>
>> Perhaps worth adding another attribute to represent the running state
>> (cur_max_qps) based on the negotiated features.
>>
> You can get that information by running e.g. ethtool -l ens1.
>
>> -Siwei
>>
>>> To make APIs clearer, make the following name changes to struct
>>> vdpa_config_ops so they better describe their operations:
>>>
>>> get_features -> get_device_features
>>> set_features -> set_driver_features
>>>
>>> Finally, add get_driver_features to return the negotiated features and
>>> add implementation to all the upstream drivers.
>>>
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>>    drivers/vdpa/alibaba/eni_vdpa.c    | 16 ++++++++++++----
>>>    drivers/vdpa/ifcvf/ifcvf_main.c    | 16 ++++++++++++----
>>>    drivers/vdpa/mlx5/net/mlx5_vnet.c  | 16 ++++++++++++----
>>>    drivers/vdpa/vdpa.c                |  2 +-
>>>    drivers/vdpa/vdpa_sim/vdpa_sim.c   | 21 +++++++++++++++------
>>>    drivers/vdpa/vdpa_user/vduse_dev.c | 16 ++++++++++++----
>>>    drivers/vdpa/virtio_pci/vp_vdpa.c  | 16 ++++++++++++----
>>>    drivers/vhost/vdpa.c               |  2 +-
>>>    drivers/virtio/virtio_vdpa.c       |  2 +-
>>>    include/linux/vdpa.h               | 14 +++++++++-----
>>>    10 files changed, 87 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
>>> index 3f788794571a..ac0975660f4d 100644
>>> --- a/drivers/vdpa/alibaba/eni_vdpa.c
>>> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
>>> @@ -58,7 +58,7 @@ static struct virtio_pci_legacy_device *vdpa_to_ldev(struct vdpa_device *vdpa)
>>>    	return &eni_vdpa->ldev;
>>>    }
>>> -static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
>>> +static u64 eni_vdpa_get_device_features(struct vdpa_device *vdpa)
>>>    {
>>>    	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
>>>    	u64 features = vp_legacy_get_features(ldev);
>>> @@ -69,7 +69,7 @@ static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
>>>    	return features;
>>>    }
>>> -static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
>>> +static int eni_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
>>>    {
>>>    	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
>>> @@ -84,6 +84,13 @@ static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
>>>    	return 0;
>>>    }
>>> +static u64 eni_vdpa_get_driver_features(struct vdpa_device *vdpa)
>>> +{
>>> +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
>>> +
>>> +	return vp_legacy_get_driver_features(ldev);
>>> +}
>>> +
>>>    static u8 eni_vdpa_get_status(struct vdpa_device *vdpa)
>>>    {
>>>    	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
>>> @@ -401,8 +408,9 @@ static void eni_vdpa_set_config_cb(struct vdpa_device *vdpa,
>>>    }
>>>    static const struct vdpa_config_ops eni_vdpa_ops = {
>>> -	.get_features	= eni_vdpa_get_features,
>>> -	.set_features	= eni_vdpa_set_features,
>>> +	.get_device_features = eni_vdpa_get_device_features,
>>> +	.set_driver_features = eni_vdpa_set_driver_features,
>>> +	.get_driver_features = eni_vdpa_get_driver_features,
>>>    	.get_status	= eni_vdpa_get_status,
>>>    	.set_status	= eni_vdpa_set_status,
>>>    	.reset		= eni_vdpa_reset,
>>> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>>> index 6dc75ca70b37..6a6a0a462392 100644
>>> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
>>> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>>> @@ -169,7 +169,7 @@ static struct ifcvf_hw *vdpa_to_vf(struct vdpa_device *vdpa_dev)
>>>    	return &adapter->vf;
>>>    }
>>> -static u64 ifcvf_vdpa_get_features(struct vdpa_device *vdpa_dev)
>>> +static u64 ifcvf_vdpa_get_device_features(struct vdpa_device *vdpa_dev)
>>>    {
>>>    	struct ifcvf_adapter *adapter = vdpa_to_adapter(vdpa_dev);
>>>    	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>>> @@ -187,7 +187,7 @@ static u64 ifcvf_vdpa_get_features(struct vdpa_device *vdpa_dev)
>>>    	return features;
>>>    }
>>> -static int ifcvf_vdpa_set_features(struct vdpa_device *vdpa_dev, u64 features)
>>> +static int ifcvf_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 features)
>>>    {
>>>    	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>>>    	int ret;
>>> @@ -201,6 +201,13 @@ static int ifcvf_vdpa_set_features(struct vdpa_device *vdpa_dev, u64 features)
>>>    	return 0;
>>>    }
>>> +static u64 ifcvf_vdpa_get_driver_features(struct vdpa_device *vdpa_dev)
>>> +{
>>> +	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>>> +
>>> +	return vf->req_features;
>>> +}
>>> +
>>>    static u8 ifcvf_vdpa_get_status(struct vdpa_device *vdpa_dev)
>>>    {
>>>    	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>>> @@ -443,8 +450,9 @@ static struct vdpa_notification_area ifcvf_get_vq_notification(struct vdpa_devic
>>>     * implemented set_map()/dma_map()/dma_unmap()
>>>     */
>>>    static const struct vdpa_config_ops ifc_vdpa_ops = {
>>> -	.get_features	= ifcvf_vdpa_get_features,
>>> -	.set_features	= ifcvf_vdpa_set_features,
>>> +	.get_device_features = ifcvf_vdpa_get_device_features,
>>> +	.set_driver_features = ifcvf_vdpa_set_driver_features,
>>> +	.get_driver_features = ifcvf_vdpa_get_driver_features,
>>>    	.get_status	= ifcvf_vdpa_get_status,
>>>    	.set_status	= ifcvf_vdpa_set_status,
>>>    	.reset		= ifcvf_vdpa_reset,
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index 63813fbb5f62..ce2e13135dd8 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -1880,7 +1880,7 @@ static u64 mlx_to_vritio_features(u16 dev_features)
>>>    	return result;
>>>    }
>>> -static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
>>> +static u64 mlx5_vdpa_get_device_features(struct vdpa_device *vdev)
>>>    {
>>>    	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>>    	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>> @@ -1972,7 +1972,7 @@ static void update_cvq_info(struct mlx5_vdpa_dev *mvdev)
>>>    	}
>>>    }
>>> -static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
>>> +static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
>>>    {
>>>    	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>>    	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>> @@ -2339,6 +2339,13 @@ static int mlx5_get_vq_irq(struct vdpa_device *vdv, u16 idx)
>>>    	return -EOPNOTSUPP;
>>>    }
>>> +static u64 mlx5_vdpa_get_driver_features(struct vdpa_device *vdev)
>>> +{
>>> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>> +
>>> +	return mvdev->actual_features;
>>> +}
>>> +
>>>    static const struct vdpa_config_ops mlx5_vdpa_ops = {
>>>    	.set_vq_address = mlx5_vdpa_set_vq_address,
>>>    	.set_vq_num = mlx5_vdpa_set_vq_num,
>>> @@ -2351,8 +2358,9 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
>>>    	.get_vq_notification = mlx5_get_vq_notification,
>>>    	.get_vq_irq = mlx5_get_vq_irq,
>>>    	.get_vq_align = mlx5_vdpa_get_vq_align,
>>> -	.get_features = mlx5_vdpa_get_features,
>>> -	.set_features = mlx5_vdpa_set_features,
>>> +	.get_device_features = mlx5_vdpa_get_device_features,
>>> +	.set_driver_features = mlx5_vdpa_set_driver_features,
>>> +	.get_driver_features = mlx5_vdpa_get_driver_features,
>>>    	.set_config_cb = mlx5_vdpa_set_config_cb,
>>>    	.get_vq_num_max = mlx5_vdpa_get_vq_num_max,
>>>    	.get_device_id = mlx5_vdpa_get_device_id,
>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>> index 7332a74a4b00..c37d384c0f33 100644
>>> --- a/drivers/vdpa/vdpa.c
>>> +++ b/drivers/vdpa/vdpa.c
>>> @@ -733,7 +733,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>>>    	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
>>>    		return -EMSGSIZE;
>>> -	features = vdev->config->get_features(vdev);
>>> +	features = vdev->config->get_driver_features(vdev);
>>>    	return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
>>>    }
>>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> index 41b0cd17fcba..ddbe142af09a 100644
>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> @@ -399,14 +399,14 @@ static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
>>>    	return VDPASIM_QUEUE_ALIGN;
>>>    }
>>> -static u64 vdpasim_get_features(struct vdpa_device *vdpa)
>>> +static u64 vdpasim_get_device_features(struct vdpa_device *vdpa)
>>>    {
>>>    	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>>    	return vdpasim->dev_attr.supported_features;
>>>    }
>>> -static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
>>> +static int vdpasim_set_driver_features(struct vdpa_device *vdpa, u64 features)
>>>    {
>>>    	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>> @@ -419,6 +419,13 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
>>>    	return 0;
>>>    }
>>> +static u64 vdpasim_get_driver_features(struct vdpa_device *vdpa)
>>> +{
>>> +	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>> +
>>> +	return vdpasim->features;
>>> +}
>>> +
>>>    static void vdpasim_set_config_cb(struct vdpa_device *vdpa,
>>>    				  struct vdpa_callback *cb)
>>>    {
>>> @@ -613,8 +620,9 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
>>>    	.set_vq_state           = vdpasim_set_vq_state,
>>>    	.get_vq_state           = vdpasim_get_vq_state,
>>>    	.get_vq_align           = vdpasim_get_vq_align,
>>> -	.get_features           = vdpasim_get_features,
>>> -	.set_features           = vdpasim_set_features,
>>> +	.get_device_features    = vdpasim_get_device_features,
>>> +	.set_driver_features    = vdpasim_set_driver_features,
>>> +	.get_driver_features    = vdpasim_get_driver_features,
>>>    	.set_config_cb          = vdpasim_set_config_cb,
>>>    	.get_vq_num_max         = vdpasim_get_vq_num_max,
>>>    	.get_device_id          = vdpasim_get_device_id,
>>> @@ -642,8 +650,9 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
>>>    	.set_vq_state           = vdpasim_set_vq_state,
>>>    	.get_vq_state           = vdpasim_get_vq_state,
>>>    	.get_vq_align           = vdpasim_get_vq_align,
>>> -	.get_features           = vdpasim_get_features,
>>> -	.set_features           = vdpasim_set_features,
>>> +	.get_device_features    = vdpasim_get_device_features,
>>> +	.set_driver_features    = vdpasim_set_driver_features,
>>> +	.get_driver_features    = vdpasim_get_driver_features,
>>>    	.set_config_cb          = vdpasim_set_config_cb,
>>>    	.get_vq_num_max         = vdpasim_get_vq_num_max,
>>>    	.get_device_id          = vdpasim_get_device_id,
>>> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
>>> index c9204c62f339..1e65af6ab9ae 100644
>>> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
>>> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>>> @@ -573,14 +573,14 @@ static u32 vduse_vdpa_get_vq_align(struct vdpa_device *vdpa)
>>>    	return dev->vq_align;
>>>    }
>>> -static u64 vduse_vdpa_get_features(struct vdpa_device *vdpa)
>>> +static u64 vduse_vdpa_get_device_features(struct vdpa_device *vdpa)
>>>    {
>>>    	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
>>>    	return dev->device_features;
>>>    }
>>> -static int vduse_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
>>> +static int vduse_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
>>>    {
>>>    	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
>>> @@ -588,6 +588,13 @@ static int vduse_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
>>>    	return 0;
>>>    }
>>> +static u64 vduse_vdpa_get_driver_features(struct vdpa_device *vdpa)
>>> +{
>>> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
>>> +
>>> +	return dev->driver_features;
>>> +}
>>> +
>>>    static void vduse_vdpa_set_config_cb(struct vdpa_device *vdpa,
>>>    				  struct vdpa_callback *cb)
>>>    {
>>> @@ -720,8 +727,9 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
>>>    	.set_vq_state		= vduse_vdpa_set_vq_state,
>>>    	.get_vq_state		= vduse_vdpa_get_vq_state,
>>>    	.get_vq_align		= vduse_vdpa_get_vq_align,
>>> -	.get_features		= vduse_vdpa_get_features,
>>> -	.set_features		= vduse_vdpa_set_features,
>>> +	.get_device_features	= vduse_vdpa_get_device_features,
>>> +	.set_driver_features	= vduse_vdpa_set_driver_features,
>>> +	.get_driver_features	= vduse_vdpa_get_driver_features,
>>>    	.set_config_cb		= vduse_vdpa_set_config_cb,
>>>    	.get_vq_num_max		= vduse_vdpa_get_vq_num_max,
>>>    	.get_device_id		= vduse_vdpa_get_device_id,
>>> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
>>> index e3ff7875e123..97285bc05e47 100644
>>> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>>> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>>> @@ -53,14 +53,14 @@ static struct virtio_pci_modern_device *vdpa_to_mdev(struct vdpa_device *vdpa)
>>>    	return &vp_vdpa->mdev;
>>>    }
>>> -static u64 vp_vdpa_get_features(struct vdpa_device *vdpa)
>>> +static u64 vp_vdpa_get_device_features(struct vdpa_device *vdpa)
>>>    {
>>>    	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>>>    	return vp_modern_get_features(mdev);
>>>    }
>>> -static int vp_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
>>> +static int vp_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
>>>    {
>>>    	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>>> @@ -69,6 +69,13 @@ static int vp_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
>>>    	return 0;
>>>    }
>>> +static u64 vp_vdpa_get_driver_features(struct vdpa_device *vdpa)
>>> +{
>>> +	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>>> +
>>> +	return vp_modern_get_features(mdev);
>>> +}
>>> +
>>>    static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
>>>    {
>>>    	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>>> @@ -415,8 +422,9 @@ vp_vdpa_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
>>>    }
>>>    static const struct vdpa_config_ops vp_vdpa_ops = {
>>> -	.get_features	= vp_vdpa_get_features,
>>> -	.set_features	= vp_vdpa_set_features,
>>> +	.get_device_features = vp_vdpa_get_device_features,
>>> +	.set_driver_features = vp_vdpa_set_driver_features,
>>> +	.get_driver_features = vp_vdpa_get_driver_features,
>>>    	.get_status	= vp_vdpa_get_status,
>>>    	.set_status	= vp_vdpa_set_status,
>>>    	.reset		= vp_vdpa_reset,
>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>> index 29cced1cd277..6d087a4fb581 100644
>>> --- a/drivers/vhost/vdpa.c
>>> +++ b/drivers/vhost/vdpa.c
>>> @@ -262,7 +262,7 @@ static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
>>>    	const struct vdpa_config_ops *ops = vdpa->config;
>>>    	u64 features;
>>> -	features = ops->get_features(vdpa);
>>> +	features = ops->get_device_features(vdpa);
>>>    	if (copy_to_user(featurep, &features, sizeof(features)))
>>>    		return -EFAULT;
>>> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
>>> index f85f860bc10b..a84b04ba3195 100644
>>> --- a/drivers/virtio/virtio_vdpa.c
>>> +++ b/drivers/virtio/virtio_vdpa.c
>>> @@ -308,7 +308,7 @@ static u64 virtio_vdpa_get_features(struct virtio_device *vdev)
>>>    	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>>>    	const struct vdpa_config_ops *ops = vdpa->config;
>>> -	return ops->get_features(vdpa);
>>> +	return ops->get_device_features(vdpa);
>>>    }
>>>    static int virtio_vdpa_finalize_features(struct virtio_device *vdev)
>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>> index c3011ccda430..db24317d61b6 100644
>>> --- a/include/linux/vdpa.h
>>> +++ b/include/linux/vdpa.h
>>> @@ -169,14 +169,17 @@ struct vdpa_map_file {
>>>     *				for the device
>>>     *				@vdev: vdpa device
>>>     *				Returns virtqueue algin requirement
>>> - * @get_features:		Get virtio features supported by the device
>>> + * @get_device_features:	Get virtio features supported by the device
>>>     *				@vdev: vdpa device
>>>     *				Returns the virtio features support by the
>>>     *				device
>>> - * @set_features:		Set virtio features supported by the driver
>>> + * @set_driver_features:	Set virtio features supported by the driver
>>>     *				@vdev: vdpa device
>>>     *				@features: feature support by the driver
>>>     *				Returns integer: success (0) or error (< 0)
>>> + * @get_driver_features:	Get virtio features in action
>>> + *				@vdev: vdpa device
>>> + *				Returns the virtio features accepted
>>>     * @set_config_cb:		Set the config interrupt callback
>>>     *				@vdev: vdpa device
>>>     *				@cb: virtio-vdev interrupt callback structure
>>> @@ -276,8 +279,9 @@ struct vdpa_config_ops {
>>>    	/* Device ops */
>>>    	u32 (*get_vq_align)(struct vdpa_device *vdev);
>>> -	u64 (*get_features)(struct vdpa_device *vdev);
>>> -	int (*set_features)(struct vdpa_device *vdev, u64 features);
>>> +	u64 (*get_device_features)(struct vdpa_device *vdev);
>>> +	int (*set_driver_features)(struct vdpa_device *vdev, u64 features);
>>> +	u64 (*get_driver_features)(struct vdpa_device *vdev);
>>>    	void (*set_config_cb)(struct vdpa_device *vdev,
>>>    			      struct vdpa_callback *cb);
>>>    	u16 (*get_vq_num_max)(struct vdpa_device *vdev);
>>> @@ -395,7 +399,7 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
>>>    	const struct vdpa_config_ops *ops = vdev->config;
>>>    	vdev->features_valid = true;
>>> -	return ops->set_features(vdev, features);
>>> +	return ops->set_driver_features(vdev, features);
>>>    }
>>>    void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
