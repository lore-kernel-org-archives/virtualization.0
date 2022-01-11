Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF353C433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 01:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77234409CC;
	Tue, 11 Jan 2022 01:15:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PeZn9hK-dcgz; Tue, 11 Jan 2022 01:15:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F19E74099A;
	Tue, 11 Jan 2022 01:15:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7F4DC002F;
	Tue, 11 Jan 2022 01:15:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEC9BC001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 01:15:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCA5660BCE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 01:15:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="P4/J4JYN";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="WUyMH61g"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m94FsWqQ8MQC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 01:15:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D8F7E605EA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 01:15:03 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B03N6u026231; 
 Tue, 11 Jan 2022 01:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AtAX7U8SUipyNiLSPK8BcpqZa9m0swY5pdoaqYUeJo0=;
 b=P4/J4JYN6+hphHKnhE1VZJ7V+aqkmqhu6vRdoCUQg+1wGr2sCSrUdvjXkwNsiqlXrRpm
 3McCQxDFbC1AP7nnE60Bjy+Qm76CXU/Ezeaxj6qx9x86wNmTtPiADAwaitHzhhOlBYnI
 WqYVeOnQg8TcuRbr0Muvw6w8gdJtVYIeSyp/e45PHSU29ZO7dRPWj3fVeILO/hnwkHC2
 Y1HNxG/adURWEEe7A8oCe1WKZumtqWcqsjF+91opvAWbRLR+2pOj1nRLe3noazMnoF/z
 6EfWWOOOmXU7Gsv7AfQn4JZzLos8+V3EoGnNPxaCdyxyNJ63mzQdhwquHkgWGWpAu/qd 6g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgjtga3fk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 01:15:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B0oQnZ144142;
 Tue, 11 Jan 2022 01:15:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by aserp3030.oracle.com with ESMTP id 3df0ndbk19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 01:15:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwJznpeQr9RxczvfPMWSHo2sJNOyggrqsZK4Fo1ksTRASdsq70x+1A6kfUqbowVu0+lu/2sTpyyAP5DtUm/IcggilaLvXj3w0bDQkcpfW40ivzmblyRNLn3Cjj9hdCjPsHXiqNZLXnLut7cDPzHpG6o1fOLnnNRUCu/P+zb7AW4Tp1RMczxyz/+p2e0TMhI2dARfXyMVJVU0ppr3xOUiHu/kJbnw1MF2cK0hqRus9hyc/ZSuA0trDbqbkDNmzUwfGK1ZAL98YOKKtyzDn4Vw3wOxMB6VGwoUrMF7Gt9ItONONZRcJWCTRnlA5K3A4gY2nV1nHKuDLmhCynLivPCRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtAX7U8SUipyNiLSPK8BcpqZa9m0swY5pdoaqYUeJo0=;
 b=VcyaVRdqyX3OApra0+ItSZebOe1p8UViDAZfvj78yD6Jq49Wcz5T97qLzPrC0DpwSehCDFSislhvrMkmaxKGVKfOvxCpvqItU7YtVwriOvU6OD0ToHYdm5PNeSoVacOpgkqul6b/I+rILzJaW50AXoUH3c5JMZDVr4v+tOifPdl8eVxsgYbHsM1Xa94b176VfkLCThDTwWXtkOsgHBSO1gS65gKRZ3MA6UoZBMa3ZyI3CYMZ/MQ4Ft60SnEzVlWz2X3B0EjZVhX6weyxb/ug/D3/ci4HyGpHyUtrc/DCjjQ3VhSdn9RjMqUQnX7JLNbH2iJLLjTCbIJeEopXfNgnSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtAX7U8SUipyNiLSPK8BcpqZa9m0swY5pdoaqYUeJo0=;
 b=WUyMH61gzXnhsnevSeAGmNY6thpDUgn7Z7U43p1+eOGzJ5NX/FrNmnnCeM++EBghLDsIJeAevkmvA9Opbleot5Rt9GZOxvuZWKVjiRbtuyjBL3mz/aG3if1zPu427wNof4iAxJKHvTxDSiDY+0TWrm6CATFkRNwtAIfDC1xKesg=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3125.namprd10.prod.outlook.com (2603:10b6:a03:14c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 01:14:59 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 01:14:59 +0000
Message-ID: <64298ef3-2177-640c-f69b-d664a520a097@oracle.com>
Date: Mon, 10 Jan 2022 17:14:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v7 03/14] vdpa: Sync calls set/get config/status with
 cf_mutex
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-4-elic@nvidia.com>
 <e6218f34-a7e6-9bc5-8de7-7690dec9aa01@oracle.com>
 <20220109140956.GA70879@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220109140956.GA70879@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: SN6PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:805:106::39) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 999583df-a077-4db3-e574-08d9d49fc972
X-MS-TrafficTypeDiagnostic: BYAPR10MB3125:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3125A445DCB90CA7F8F77A44B1519@BYAPR10MB3125.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2YaRFKKe12GIA+S6gQujc1pWuRro4SmODkSnVXd2MbX2l5PvUno6Z7uAUodFy6jIZF6FePXYBYujKw8A0qdOqIzOy36T40Je7peg+5ywxPjVerZjrNZXQ4ifn6I83Z7SixO2gyEaa9XFNkFjW1xr0DJjHEj3WwSPGAKZjuzF99MD/vt+1V2mM7BoS7DGpRGakC3zeEGxFhcpXVae4h9YnKsGdHmgvLcvzTZutA8/1nvaAzpzm5p93XJmxmfFs868GgLzLUFTzRVwH4nlaYTWywONL3RHHuEcr+Lg1XXXSghSd67loiwZAFcg54dBCbhnhD/l1aYr+s7GrIk1L3VSCae5nAxNZGUxqWzrO71na5ZnqZ2azdC8fj+3AXmOiIMjjbdcPYyOrvulUS39ba6PqRAoFq7AY+fuGWZgfW4I/+Psii+Z9k6WCGX4+Dj3GJUV7sBtWB8BqtP71q2yYri3pxyvgaZOG9ifv3scztUHQW4MLigBk1pANJPyH5utshTp/L3I2lgEqEfVtJLjtuNHM39BBntPiyrt83CQxUSiN17b6I3mgUKfG9wHbEx/3/LJbm3BRMVdi7PNOFpDTePRZkSzrJys9H1jhNy253Hek01693zL0KpLGzSPWhQUfSEt9tfVwvOi/YFk/dxHw4BFKav+17bzDQfwvRSyqJ741SWs8lrUHIYq54YxoNv2LSKQtlMqixv5cL5+DydCcEyZzBr1gu987B4PrlLijLzc4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(31686004)(53546011)(316002)(5660300002)(86362001)(6666004)(6486002)(6512007)(6916009)(2906002)(26005)(186003)(8676002)(6506007)(36916002)(508600001)(66476007)(66556008)(2616005)(83380400001)(4326008)(36756003)(31696002)(38100700002)(66946007)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWVjUkk5UzJ2WU1XM25TNlF3Y2ZIOTFub0JaaloyMTNiVmNPSGJoSWVlU2Yv?=
 =?utf-8?B?Y3V0a1Rnd0NKS1RsOUFad28xeHNQOUJQcWFYd0NnZy9jSVJpVkR2NndOQVNG?=
 =?utf-8?B?SXd0YUV1bWdlRjkvc1VqOHZvS3cwSEdSU3FiVUJEY2lDamVVRGpJNzZmWDlV?=
 =?utf-8?B?UnhiQXBENG1vbnJ5ZHp3dU1HMUNqcXFuTFkzeGpnR0haeWdTVlNMTng5TGJw?=
 =?utf-8?B?Sk5CQUNZQUZqeVhoRlV3cDNzdkZsTjBmdWgrUVpiMVBONFdmdEtVMkpReGEz?=
 =?utf-8?B?TlNBOFYyU1plSEVpM1YzTEV4VHBUVko2bEUvSnJNRnp6bkI2U0RYdDlMUlVF?=
 =?utf-8?B?c2FCaFFmd1FWTEVtcVk1UmVsSVZmOFMzMFlXd0tnNUJYakoreDVmekUrUjVC?=
 =?utf-8?B?Y0xsMi94akRiNkVXbUhVMGFIekl5UCtOMDQvMEZvS0h4ZlByNHkwY2Nld1pN?=
 =?utf-8?B?eVhPN0ROaGVnS2ZNVnlZWSs1U3RFbWlRU1A2SFFrVU1UY1F4dEVsaGY5dGVC?=
 =?utf-8?B?QXFyWXZtSlJyUXhpK1N6NS8zWXNsYUp4L3dxK3Y2NnBHN25ZSGt5N01janRk?=
 =?utf-8?B?SFhWVW15elRRdGhSQloxVFNjMmNQNWt1OUN5b1NlL04reUVqZkRWVzRaN3JJ?=
 =?utf-8?B?bmdzZmVqVnlqS0FNRk93WEx1SUMzWWZ5Q0MrRE1ZWkdQMTh0MGZkNlE5bXBS?=
 =?utf-8?B?QTNFTFRDNjRlRXVCcWEyeGR0ci8wV0dhdmVvQ3dKYWhvTFdYZXAxQVc4dzFJ?=
 =?utf-8?B?Rk42c0hXSU1BTjExT0NZYUhPOFpEaks2OVZOd2xmVVNWRFUySkttRktkcXYy?=
 =?utf-8?B?eXRsWm9QMHhnZnN6RGowZUxONU1adGNTd0ZQbWdtSzdPa2NuaE9tS0tUbzdW?=
 =?utf-8?B?RThvVk5SajJReSthT3dBQStZN2N3UXR0WjM2ZVdVMXZXWFdMOHNZYzB5Q3VD?=
 =?utf-8?B?QmQ3WVlaSFR0U1dtWWlubmF4ZDk1VDN6T3dEUXRyKzFQVFUrdzh4UHVyVmlp?=
 =?utf-8?B?N25uODcwWElBbVY5eXRkZmh1NnJETXV1QW8xMjVYM0lWRDN3U0xkVHI5ZTkv?=
 =?utf-8?B?SlJubGlvTVkyZDluVkFDRVMxTXgxSytqMGxqM2pnOW9nWENTYVBpam5TRllR?=
 =?utf-8?B?Q3hqY21BeU9uT29jZ3BkMktpd0M5STQwS3N1SW5kWko3RDdVTzdPNmJ5SnRI?=
 =?utf-8?B?YXg2V1FmM1pVb0xCRU1wd2FRL1lraCtvVUI4NTNMMmRpTFVzbThKeVRUMENx?=
 =?utf-8?B?OWZwK25lN3hsdW1xTmxjRXloNUxMVSt1MmVkeG5xd0lKZWtDOVV3VC95MTdv?=
 =?utf-8?B?NXpNUWg0VGJKYmc1QlFXUmFxaUprZUdTeGdnM2ZYbVZ0cHU5YzVnRnVMVGRF?=
 =?utf-8?B?T0lnVW1wNkRTNnZPSGM4K1FrL1BPd1hkb0YwR25paGtTeUpqZlpxL09FRGxn?=
 =?utf-8?B?Uk9rRGNXcHdRaFZ4R3RmU1U0QXJ1eVNJT1Yva2lQSXNWWXc4N1kyNk9kdmVs?=
 =?utf-8?B?d3NzbVB3UVRtVlpENHhjcitBZ1l3ejlaM01xSldoZ3g2d21WMDZVTnVPN212?=
 =?utf-8?B?UzJ4Um9iWVFJeW1lZko0cHZ2SzN2bE1Wb0RiWXZXTlBmZkYzQUIwSGNMNnB4?=
 =?utf-8?B?UGxjbUpWVC83Q3k0VDFlazJPZ3UyTW4vczZjdG5uSlBLc0RzU3k2WDJpZVpG?=
 =?utf-8?B?UkVUU0RLald6T1MzMnRWU2t3Nmx2SmxLNDE1SWxPNDlDOEowM1lZVjVtWG1B?=
 =?utf-8?B?VUZLL0FtZnl6eGk2MlN2Z3g3cjlQU2l6dXhIcEJDSzFMSndOM0JMdlJ2Qjc4?=
 =?utf-8?B?TSsrTnJ0M0p1aG56eVhlUXFhSVVWQWlKQnBjVGY5VkZBWWJWbmZMSEowcFlH?=
 =?utf-8?B?ODVtYU8yRmpzS0RYMVplQ1lrcHh2bkt5ZXpuNDJjbXBoT2FLWUFZS1dRS2lH?=
 =?utf-8?B?R1NnSlNHa3g5WjNuSU0xRngzeUV0bGJ6bHBtN0RwYkJZa0tPZXlJSFJFclRQ?=
 =?utf-8?B?ajFpNmlzSVdGU0Y1S08yZXlVSHFEVE5rWDQwY1FCVThEY3cwcTRKMmJETzhT?=
 =?utf-8?B?bGg3ZG1kc2FSS3hoQ2NHWkI2TmxoU0FZclhZUXJnNDQ0MzhkMXNxZkd1UjB2?=
 =?utf-8?B?WUUyZlRiUFFRVmltMmJXQktSK2hGUXd2OHBFWjRMTHkrRVgzMURVTmFjK2ta?=
 =?utf-8?Q?5WItrx2T7UH29LTRkDmYW+A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 999583df-a077-4db3-e574-08d9d49fc972
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 01:14:59.5837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0a9tA+CaYEIYLDhxQvWXAMA4DCYu7q4wyF368W0A6GycSiKrJ9oYhcoXcUSp7s8rmbcF6h3KbaX3GKVIHo5xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3125
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110001
X-Proofpoint-GUID: ax-ZSXrAnlehcenvawmTCEFS5-R3C2yk
X-Proofpoint-ORIG-GUID: ax-ZSXrAnlehcenvawmTCEFS5-R3C2yk
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



On 1/9/2022 6:09 AM, Eli Cohen wrote:
> On Thu, Jan 06, 2022 at 04:33:49PM -0800, Si-Wei Liu wrote:
>>
>> On 1/5/2022 3:46 AM, Eli Cohen wrote:
>>> Add wrappers to get/set status and protect these operations with
>>> cf_mutex to serialize these operations with respect to get/set config
>>> operations.
>>>
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>>    drivers/vdpa/vdpa.c          | 19 +++++++++++++++++++
>>>    drivers/vhost/vdpa.c         |  7 +++----
>>>    drivers/virtio/virtio_vdpa.c |  3 +--
>>>    include/linux/vdpa.h         |  3 +++
>>>    4 files changed, 26 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>> index 42d71d60d5dc..5134c83c4a22 100644
>>> --- a/drivers/vdpa/vdpa.c
>>> +++ b/drivers/vdpa/vdpa.c
>>> @@ -21,6 +21,25 @@ static LIST_HEAD(mdev_head);
>>>    static DEFINE_MUTEX(vdpa_dev_mutex);
>>>    static DEFINE_IDA(vdpa_index_ida);
>>> +u8 vdpa_get_status(struct vdpa_device *vdev)
>>> +{
>>> +	u8 status;
>>> +
>>> +	mutex_lock(&vdev->cf_mutex);
>>> +	status = vdev->config->get_status(vdev);
>>> +	mutex_unlock(&vdev->cf_mutex);
>>> +	return status;
>>> +}
>>> +EXPORT_SYMBOL(vdpa_get_status);
>>> +
>>> +void vdpa_set_status(struct vdpa_device *vdev, u8 status)
>>> +{
>>> +	mutex_lock(&vdev->cf_mutex);
>>> +	vdev->config->set_status(vdev, status);
>>> +	mutex_unlock(&vdev->cf_mutex);
>>> +}
>>> +EXPORT_SYMBOL(vdpa_set_status);
>>> +
>>>    static struct genl_family vdpa_nl_family;
>>>    static int vdpa_dev_probe(struct device *d)
>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>> index ebaa373e9b82..d9d499465e2e 100644
>>> --- a/drivers/vhost/vdpa.c
>>> +++ b/drivers/vhost/vdpa.c
>>> @@ -142,10 +142,9 @@ static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
>>>    static long vhost_vdpa_get_status(struct vhost_vdpa *v, u8 __user *statusp)
>>>    {
>>>    	struct vdpa_device *vdpa = v->vdpa;
>>> -	const struct vdpa_config_ops *ops = vdpa->config;
>>>    	u8 status;
>>> -	status = ops->get_status(vdpa);
>>> +	status = vdpa_get_status(vdpa);
>> Not sure why we need to take cf_mutex here. Appears to me only setters
>> (set_status and reset) need to take the lock in this function.
>>
> What if the implenentation of get_status() at the upstream driver
> requires some setup. Taking cf_mutex seems like a good thing to do.
This doesn't like vdpa_get_config() which doesn't need that kind of 
setup at all currently (though whether the legacy detection in 
vdpa_get_config is useful or not remains to be a pending question). Even 
if there's a need in future, we may add it once we get there, right?

It looks to me it's quite unlikely the cf_mutex is needed even in 
future, since the command line tool would never want to intervene 
internal virtio status via set_status() from the the netlink thread, 
while the guest driver is running and in control. It's doubtful this 
just serves no real purpose for foreseeable future, but just add 
unwarranted overhead unnecessarily.

Regards,
-Siwei



>
>>>    	if (copy_to_user(statusp, &status, sizeof(status)))
>>>    		return -EFAULT;
>>> @@ -164,7 +163,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>>>    	if (copy_from_user(&status, statusp, sizeof(status)))
>>>    		return -EFAULT;
>>> -	status_old = ops->get_status(vdpa);
>>> +	status_old = vdpa_get_status(vdpa);
>> Ditto.
>>
>>>    	/*
>>>    	 * Userspace shouldn't remove status bits unless reset the
>>> @@ -182,7 +181,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>>>    		if (ret)
>>>    			return ret;
>>>    	} else
>>> -		ops->set_status(vdpa, status);
>>> +		vdpa_set_status(vdpa, status);
>> The reset() call in the if branch above needs to take the cf_mutex, the same
>> way as that for set_status(). The reset() is effectively set_status(vdpa,
>> 0).
>>
> Right, I missed that. Will send a fix.
>
>> Thanks,
>> -Siwei
>>
>>>    	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) && !(status_old & VIRTIO_CONFIG_S_DRIVER_OK))
>>>    		for (i = 0; i < nvqs; i++)
>>> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
>>> index a84b04ba3195..76504559bc25 100644
>>> --- a/drivers/virtio/virtio_vdpa.c
>>> +++ b/drivers/virtio/virtio_vdpa.c
>>> @@ -91,9 +91,8 @@ static u8 virtio_vdpa_get_status(struct virtio_device *vdev)
>>>    static void virtio_vdpa_set_status(struct virtio_device *vdev, u8 status)
>>>    {
>>>    	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>>> -	const struct vdpa_config_ops *ops = vdpa->config;
>>> -	return ops->set_status(vdpa, status);
>>> +	return vdpa_set_status(vdpa, status);
>>>    }
>>>    static void virtio_vdpa_reset(struct virtio_device *vdev)
>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>> index 9cc4291a79b3..ae047fae2603 100644
>>> --- a/include/linux/vdpa.h
>>> +++ b/include/linux/vdpa.h
>>> @@ -408,6 +408,9 @@ void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>>>    		     void *buf, unsigned int len);
>>>    void vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
>>>    		     const void *buf, unsigned int length);
>>> +u8 vdpa_get_status(struct vdpa_device *vdev);
>>> +void vdpa_set_status(struct vdpa_device *vdev, u8 status);
>>> +
>>>    /**
>>>     * struct vdpa_mgmtdev_ops - vdpa device ops
>>>     * @dev_add: Add a vdpa device using alloc and register

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
