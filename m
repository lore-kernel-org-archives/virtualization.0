Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CFFC636D4
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 22:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85B6160DFA;
	Tue, 31 Jan 2023 22:58:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85B6160DFA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=PvMWTx/Z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=GfP3Voau
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mC5yNfnC_hv4; Tue, 31 Jan 2023 22:58:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5231460DE5;
	Tue, 31 Jan 2023 22:58:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5231460DE5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C979C0032;
	Tue, 31 Jan 2023 22:58:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26CD5C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 22:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E0AD340524
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 22:58:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E0AD340524
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=PvMWTx/Z; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=GfP3Voau
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QwZaPEIVOl4y
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 22:58:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BEA81404FE
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BEA81404FE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 22:58:37 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 30VIhvhd013725; Tue, 31 Jan 2023 22:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Z5Yml8pBO/4eNWfIeYBssFI6hrhIBjwid65P0cqXlZs=;
 b=PvMWTx/Z25iL6s3aeXGrYPO7f7VxjropB6v9XMc3rKG+eObn5WOPrFyDn6lp9FNvaw9u
 iuTO20tP22xEWaUbP+FPdIIFMW8oqtgtA2krUa1OE311FfOLPUnoWVAbWGLvpeZN8Gb+
 vT5r4a0xUCyhs8S+EvGv27XaLDjnBX8SzmJEvhRCXN1PH7IRhEUeuP0hOfyBdYV3h7Ez
 BtuLBRga43UemUjb8OA2HA1w8dIq/x91RMxvHv4W7oqeHvLLutk3p7H+XpZU1W0xqlpT
 YLMYzZKAmLrJMnuBZr5vp6xEIXU/VurSrjdh1dDIKejC9xL7BFnrvk0F3M1HmH9Nduxy nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvn9xy5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Jan 2023 22:58:36 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 30VLE83i003590; Tue, 31 Jan 2023 22:58:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3nct5dr79g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Jan 2023 22:58:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnZXdg+o2WUE7Tyw01X4iezZVi7E9U39U02m/+q3akELKC7cz9+VcCdBpoR0Oi2730MeIlTZ05y71n3IIUA98RMms6QHQRJ5JduIE+duNC47v0XwXFGIprG4ooQ94VXtIlxMxiqEzxkNA+ZSVrrbT7JYZEAKEeO/YdBe1IzqMC6haYrnFEmdqOQ/iyR04REJub5fTsWuNNZlTD1UQP57A4QJfYj/H9OSvdFUm3oNDMLAANVfIVinUROljQscE/Ab6qywv4MxOmJeEE45ND2J7l83Um9tSg73dPzfa0kXJ0xHpSe90o018HYg4cOGBEDbFR9xMoxgkDiFRVV3GMkjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5Yml8pBO/4eNWfIeYBssFI6hrhIBjwid65P0cqXlZs=;
 b=kQ7/bvVFqZHHYmMaVt4zy5H93C1lRwikg7P4prX2ZkZucJxp3nQnomLkyJEIaWEiH3uxq8hfZIBf7R5OYy+65iN5V+6QBxakJTR5ki4IYqZZ+KMMw5YbA0qbLfKkLS2yjwd/VrA0AzOP+450dvlSpwpiuWZS0UgeHEbxfHjaPebvBToNp9E+tGUdwafr0zNa+bdIOFd9ZRt5hXDP/eQ9SSmRdU6tbLTUWQP+VddkIOIziaYjIwlGnZpPAXWAKiN4jIJPTdx2rTVDYb82nSeSZaYfN8UgNQW9SLi7eOkHkYUfgTFdCsXzl8QJikFouKEC3HtWDrHqHAFL6MfaN4Hqaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5Yml8pBO/4eNWfIeYBssFI6hrhIBjwid65P0cqXlZs=;
 b=GfP3Voaus/N3rzGNG+vRLTrZP4nMgkjfv10JqRRTjoPFCOIQOenkxhojfxrDkTTVlnlhFn/IZ9ls0KlQRXiXCwAtV+gUOyBPvHHhltmj/lCKUfQ/E7iX3VIFk/aeKga93541tyzytwqDDPCMffjXfbmQ3BLLlkEHxt9CBgYvj18=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by IA1PR10MB6784.namprd10.prod.outlook.com (2603:10b6:208:428::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.20; Tue, 31 Jan
 2023 22:58:33 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%7]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 22:58:33 +0000
Message-ID: <b228665e-223e-11d5-cf05-ff24a656c0e3@oracle.com>
Date: Tue, 31 Jan 2023 14:58:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/6] vdpa/mlx5: support device features provisioning
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 parav@nvidia.com
References: <1675110643-28143-1-git-send-email-si-wei.liu@oracle.com>
 <1675110643-28143-7-git-send-email-si-wei.liu@oracle.com>
 <0b1f2898-e49d-9cb5-2913-382c9a04170f@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <0b1f2898-e49d-9cb5-2913-382c9a04170f@nvidia.com>
X-ClientProxiedBy: BN0PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:408:e8::12) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|IA1PR10MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: b88cdaed-783c-4ab9-ccd1-08db03deada4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7YboQWGm8U+tZzCbun9greToz5pNq3WOn/zDAVvFpkl+iARk+Q37k8o7R3cbbKvOrdpC06wQuFfIquCtRJ6V733ESP2ig64pHaGUiNagNOTFenYOdOOFBP4E493av4Xf4GhvebBCJJZwy5ycrpnFSZ1xYtJWHAZnQ0TjR2rriWT7+Rfk4P29HOOlRlLdEhryH1/Q0UZhQb5ICkZc71t0zugmish4QWZ+bCQP1aEcnuRr3EwAkJDxS+bTg8CszRVTsYueZ7JrRbkapIlH9cQZGbHfcqkB8s8YRF61Wf4u5CNyol7FLTjpwb3MyQsxkmeMCRbSsvOEair+N7AdbcumE+qfNwEBHH4emTT7ZtDUjkNlq+cf8qANQiW6nT6zCzRuF0JHLyDPUnob6LjAJN/1vxYeFdsYUrE9VW//8axXgxdF7VIk+CNSWGAs+yxpzCcasHyf8QLHxiSTq0kQAayBwaIsfFeH9l1PA/aWzL+6ulnuxHgbNYJy9+5OtR70a1Qo7Y2EzL7rHviFlGkCjaMxs74DeSMGLi4AaP30Z1RhzgpAFcxJjIRXV+Avy87BwMEnkOgQ8WnoXmzl80QzgLPGM82QutHsH779M7EzJZNweup8xEaaIGkV5q+eOd/1UicQGZ00pXL9WLQiAwURLtCjFGPdiRO7KGSNBkqGAN73npbJmik9mcHQFXa/icLcI9uYjYuBGRX8D9SdXjcaMgL6etnG8Y01hLKF6f9U7CfXvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199018)(31686004)(38100700002)(8936002)(5660300002)(41300700001)(2616005)(8676002)(66556008)(36916002)(66476007)(478600001)(4326008)(36756003)(316002)(2906002)(6486002)(26005)(186003)(86362001)(6512007)(6666004)(31696002)(53546011)(83380400001)(66946007)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnJlanFrTkRaZ1BoS1RVNVFvZjFjVjU0U21aTWlsODFpWERMNUtLckRaUFpO?=
 =?utf-8?B?MjYwRGcvVnRiT3RuMmpUZzdoUklKOHlIbko2aEFKUWNzaUtFUXUwQmZ5WUsr?=
 =?utf-8?B?N3Y0b0ltazVxdlhxOWozNjQrK2hFc3dpVTB0b1Q1WHhrenkxNUtJRGFpMk11?=
 =?utf-8?B?K0lnQVhzOS9HT1ZocjFVWVdOK1RUWmNhM2VFWHBIek9BSWtpcFJVdGRyUmM0?=
 =?utf-8?B?Nm1ja3V0cCtOSEdVZmlqakkzSDhXOHdxTi9yYXc3Z1lmRnRTUU1LaFZTWFRm?=
 =?utf-8?B?VmNBSndqai9EZ1RwMW5SK3Q2aVVlNDRXYzFKenUyaDh5Yi8zRmRXQkJCRXlG?=
 =?utf-8?B?RlNLUURqVFhoK3hkOGx5dWZzVis4cTZ3SWZ2aHhGZ0ZQSGVZWlZiRm5tV1Z3?=
 =?utf-8?B?ZXBBd29zZHErcU9GcGV4RmI0TVJRLzJHN1BCM1lVMEwyRGxoRkRWRyt4RklM?=
 =?utf-8?B?bzBLY3U5WWhkYXNoM0tzVHcyaGlCa1dyQU4vTVo3YlpNUXV6ZkdtVXcxeUx0?=
 =?utf-8?B?ejBaUTR4TnVpR3RRMW1rajB2d2dvYm5nTDlFUEU0ajZGSE5sL2pOcmU3UHM4?=
 =?utf-8?B?NDA2VmRMVktUKzZ6dFZDbnJpQmwxYUs5RzU1UFF1Ly91YWxhZ3F4cTN0Njc1?=
 =?utf-8?B?RFhZS2MzU3FubmRYVDh4ZTFnMFFVRS9rdDFuZ21sVGpNOU5VWnFDNlFZa1h5?=
 =?utf-8?B?VTRGazhXUXFvMXpkcWZBSm5VVXR5bHpvbEJSQmtobm9jTUowOVZWS3B3REhY?=
 =?utf-8?B?NU5KYjJLYWE5OHpmbVBCc2RLYlVGRUxJWmZSYmZCT2ZhUnEzOWgwZjZMQm5S?=
 =?utf-8?B?TVdZTEJVcitmODlKT1NVOUNUcTN2MEZPSnUyZHRxeHRIS3NwNnc2ODhxeFBW?=
 =?utf-8?B?b3NZLzdRUkh6U1dFbHdoRUM2cFExbmIvQ3YwMHVFUXpxUmZseGhSZmdmdGVE?=
 =?utf-8?B?bFVzczdTbHJOaW9FN1dHdkkrbTdMOTFkSmsrblZjOHlEMFh6cnRPWnQwYU9P?=
 =?utf-8?B?R2VQUG83VWk2Z1hjMWtzU3ZLL2FtNDhjRzlrM0ExbSs1SEQ1RHdLUjRUWmV4?=
 =?utf-8?B?RWFNczRUU0NxZDNaUUtBbWVyWWV5MHFkcDRDSERQSnJCOGpROUM2SHBmNmFD?=
 =?utf-8?B?alQybFZpOFRQN3FiZ3loblYrM1B5YTNPdE1sTmFZQWxEUGdOSGEzaWZwZ2dE?=
 =?utf-8?B?dGhXc1duRjRWajdYUHNzVTd6Y0s0TFRJY3FWM3NONS9KZGEyZzUvVnN1QW5I?=
 =?utf-8?B?SHZ4M1EvTUJibHpDS1BTTjZXUkFUczRNTnlXTXljWU5HNzJUZDNPd09VdURD?=
 =?utf-8?B?MzRaQXFBQ043RVJpKzNqVHRENHFRQmNCV3BvTEk4Q0JQbUQ5SEpOMWtWR25w?=
 =?utf-8?B?YlJwVWtlVytpeUttTW9BNmV3NW1VanFYc0lCNXpjVGhIVndXYU82TFI0NnBQ?=
 =?utf-8?B?VWlYSzRaQmZhMTB2ZjNTL0ZERlZ2UGRMaERvc3VORExHREZMR09iNHh1eW90?=
 =?utf-8?B?ZEVnUGRDa1dlOEMwU1JYelNzUjZHakJ6aEp4cmtXL0tZdVZCNnZNb2hYcWZk?=
 =?utf-8?B?UFQxNi9iS0JLSDQrcm1nVytOMkpYVFk5QjZ6NGIvQndMS0lGR1hWTUtCZ3VP?=
 =?utf-8?B?R0krWHhXaEx4czhUL1BXQnhlTDJXSnA5emhMZkFNalNYeTg2MGtiSVpTcDF3?=
 =?utf-8?B?aE92RzgvUFpOeVh2VzROemhTdFpPQVRNNHpmeFMyOUdnd2VVOE05RjRHYXZa?=
 =?utf-8?B?UFNtV2NkS0J5cm5ia2RJdUREdEU3aDh6ZTU5eTVHWmRVK3k5OTB3dkVRQmhj?=
 =?utf-8?B?Q1J3UExWMHNRdG1landXT2MyMmloOVZpem9qZlM2aERQQ29yTkEra0U3YWcy?=
 =?utf-8?B?QXBDR0ZFbGx1enFYZWpBVHY4c1NocVNlbTBTQkZvSGw2QWdHekpFS2JKS0tV?=
 =?utf-8?B?a24veHlDbUEzU21za3Y3czZQWVVMaDdncUtRdXVpSzlLdnRjbHFJTU03VWZl?=
 =?utf-8?B?N2hWM0RhL3VDWC96YkdUWXArQjFIYnpTQ1gyQkh4M25MeGU4MTFWVlRzTEJs?=
 =?utf-8?B?TTNNM1c5WnJOclJYV0xwbXZ0N2hDZWJLak93ZmlqaENUUGFoMEZPSzl5SHNo?=
 =?utf-8?Q?wASGnzwvNhDt2zwxGEpg0gTWq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F960bDIIxxUv5M1z9bqSHwxLYU9CCIgacpA50pACsXp4J/f9nsKbf/LFIpPp9ur+EJ2EqnFWpb1QitmjkMfcn0ZX0bWi3XDYvuNVMeiVrD3l0YOi7PSrL8Sc6jLQLWhLQu1c5+bgXfFpa+LIgyoJE9JG1wFGGRHymJIkdlQROCLs+SVcwwFmwJENfP2bUbBgHJ8cNUfFlBXY0EEvmGPwOrN5zTRtW7F0GTPmGZoZ1PiEMji89wYMSLvwRMJEtm89Oo6FW2eu6Va2r0D3J5368FVKa8dshBqlJOaEHQenOtqGsGHHaKrsEZDp2ix5hdBwzerEdb/MaWCCvbThpVUnCzxafQWoNCxrRqFAnSe3jTa/iXtQQlaUfivPIpqr6yiLJej7pDng7p3s8b6eFJpHlbn/rsCk3+gS1iR5Nw+Cl87i+w3UfhHkLYUTvaqI94TDQz4gd0YJJqeT2eM5wf3E+Cqmfj4zbWPsbOrnED5T7pU629sxr1IH75Vn2Zc84BAMznTBsGYd7DTiXwPNIpV0hgbtDWo8zkGn9QqWSlVCNiO1uERcZmI51p4bkqZRRUA8AoZ8i6/hYtjXcuLEi909VLYHJeo3h2KdfSyTT9xY4bgxi5iJtromKoK81TahjbtuJ0/qUjzMXEtrlBPylJYoY0gy8BI4P2in9CR3kggHq88VZDn4VrCAJCewtyskE9C4cROJAmxqrV2zSxaqfU2QbyLh1lvAX6XnMBQ5JLB/NEg8TOM81PzJYlxTS2SsYkky/eluT5p9PEJGowjmEwTPVi+hjqGgU6kE6EWK99KSO0hbY5D0E4/lQUTgn+SJgOcT038uvHKvaokiN8CV3kb9CwRXLASHKkXjCJHc76pzQSE7CK17ybVd0jQeHvMhXFfQIt26IB/KISEpHOizk4tQbA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88cdaed-783c-4ab9-ccd1-08db03deada4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 22:58:33.5813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybve0LoNyxZpF0WqOQ8YgPKhpauOg8MrhKpwOQdIFg9AErfsSYayqVczCc1NZicRAXYvNrfMk04TOrIrkjzb2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310198
X-Proofpoint-GUID: 9Di5sQ36XF9x51L9nloO7Afhsl4_FTYf
X-Proofpoint-ORIG-GUID: 9Di5sQ36XF9x51L9nloO7Afhsl4_FTYf
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CgpPbiAxLzMxLzIwMjMgNDo1NiBBTSwgRWxpIENvaGVuIHdyb3RlOgo+Cj4gT24gMzAvMDEvMjAy
MyAyMjozMCwgU2ktV2VpIExpdSB3cm90ZToKPj4gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIGZlYXR1
cmVzIHByb3Zpc2lvbmluZyBmb3IgbWx4NV92ZHBhLgo+Pgo+PiAxKSBWYWxpZGF0ZSB0aGUgcHJv
dmlzaW9uZWQgZmVhdHVyZXMgYXJlIGEgc3Vic2V0IG9mIHRoZSBwYXJlbnQKPj4gwqDCoMKgIGZl
YXR1cmVzLgo+PiAyKSBDbGVhcmluZyBmZWF0dXJlcyB0aGF0IGFyZSBub3Qgd2FudGVkIGJ5IHVz
ZXJzcGFjZS4KPj4gMykgU2V0IGNvbmZpZyBzcGFjZSBmaWVsZCBvbmx5IHdoZW4gdGhlIGNvcnJl
c3BvbmRpbmcgZmVhdHVyZSBpcwo+PiDCoMKgwqAgcHJvdmlzaW9uZWQuCj4+Cj4+IEZvciBleGFt
cGxlOgo+Pgo+PiDCoMKgwqAgIyB2ZHBhIG1nbXRkZXYgc2hvdwo+PiDCoMKgwqAgcGNpLzAwMDA6
NDE6MDQuMjoKPj4gwqDCoMKgwqDCoCBzdXBwb3J0ZWRfY2xhc3NlcyBuZXQKPj4gwqDCoMKgwqDC
oCBtYXhfc3VwcG9ydGVkX3ZxcyA2NQo+PiDCoMKgwqDCoMKgIGRldl9mZWF0dXJlcyBDU1VNIEdV
RVNUX0NTVU0gTVRVIE1BQyBIT1NUX1RTTzQgSE9TVF9UU082IFNUQVRVUyAKPj4gQ1RSTF9WUSBD
VFJMX1ZMQU4gTVEgQ1RSTF9NQUNfQUREUiBWRVJTSU9OXzEgQUNDRVNTX1BMQVRGT1JNCj4+Cj4+
IDEpIFByb3Zpc2lvbiB2RFBBIGRldmljZSB3aXRoIGFsbCBmZWF0dXJlcyBkZXJpdmVkIGZyb20g
dGhlIHBhcmVudAo+Pgo+PiDCoMKgwqAgIyB2ZHBhIGRldiBhZGQgbmFtZSB2ZHBhMSBtZ210ZGV2
IHBjaS8wMDAwOjQxOjA0LjIKPj4gwqDCoMKgICMgdmRwYSBkZXYgY29uZmlnIHNob3cKPj4gwqDC
oMKgIHZkcGExOiBtYWMgZTQ6MTE6YzY6ZDM6NDU6ZjAgbGluayB1cCBsaW5rX2Fubm91bmNlIGZh
bHNlIAo+PiBtYXhfdnFfcGFpcnMgMSBtdHUgMTUwMAo+PiDCoMKgwqDCoMKgIG5lZ290aWF0ZWRf
ZmVhdHVyZXMgQ1NVTSBHVUVTVF9DU1VNIE1UVSBIT1NUX1RTTzQgSE9TVF9UU082IAo+PiBTVEFU
VVMgQ1RSTF9WUSBDVFJMX1ZMQU4gTVEgQ1RSTF9NQUNfQUREUiBWRVJTSU9OXzEgQUNDRVNTX1BM
QVRGT1JNCj4+Cj4+IDIpIFByb3Zpc2lvbiB2RFBBIGRldmljZSB3aXRoIGEgc3Vic2V0IG9mIHBh
cmVudCBmZWF0dXJlcwo+Pgo+PiDCoMKgwqAgIyB2ZHBhIGRldiBhZGQgbmFtZSB2ZHBhMSBtZ210
ZGV2IHBjaS8wMDAwOjQxOjA0LjIgCj4+IGRldmljZV9mZWF0dXJlcyAweDMwMDAyMDAwMAo+PiDC
oMKgwqAgIyB2ZHBhIGRldiBjb25maWcgc2hvdwo+PiDCoMKgwqAgdmRwYTE6Cj4+IMKgwqDCoMKg
wqAgbmVnb3RpYXRlZF9mZWF0dXJlcyBDVFJMX1ZRIFZFUlNJT05fMSBBQ0NFU1NfUExBVEZPUk0K
Pj4KPj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+
PiAtLS0KPj4gwqAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgNzIgCj4+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdl
ZCwgNTggaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgCj4+IGIvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jCj4+IGluZGV4IDNhNmRiYmM2Li41ZDZkZmQyIDEwMDY0NAo+PiAtLS0g
YS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4gKysrIGIvZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jCj4+IEBAIC0yMTgzLDYgKzIxODMsNyBAQCBzdGF0aWMgdTY0
IGdldF9zdXBwb3J0ZWRfZmVhdHVyZXMoc3RydWN0IAo+PiBtbHg1X2NvcmVfZGV2ICptZGV2KQo+
PiDCoMKgwqDCoMKgIG1seF92ZHBhX2ZlYXR1cmVzIHw9IEJJVF9VTEwoVklSVElPX05FVF9GX1NU
QVRVUyk7Cj4+IMKgwqDCoMKgwqAgbWx4X3ZkcGFfZmVhdHVyZXMgfD0gQklUX1VMTChWSVJUSU9f
TkVUX0ZfTVRVKTsKPj4gwqDCoMKgwqDCoCBtbHhfdmRwYV9mZWF0dXJlcyB8PSBCSVRfVUxMKFZJ
UlRJT19ORVRfRl9DVFJMX1ZMQU4pOwo+PiArwqDCoMKgIG1seF92ZHBhX2ZlYXR1cmVzIHw9IEJJ
VF9VTEwoVklSVElPX05FVF9GX01BQyk7Cj4+IMKgIMKgwqDCoMKgwqAgcmV0dXJuIG1seF92ZHBh
X2ZlYXR1cmVzOwo+PiDCoCB9Cj4+IEBAIC0zMDA5LDYgKzMwMTAsOCBAQCBzdGF0aWMgaW50IGV2
ZW50X2hhbmRsZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrIAo+PiAqbmIsIHVuc2lnbmVkIGxvbmcg
ZXZlbnQsIHZvaWQgKnAKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgbWx4NV92ZHBhX3dxX2VudCAqd3Fl
bnQ7Cj4+IMKgIMKgwqDCoMKgwqAgaWYgKGV2ZW50ID09IE1MWDVfRVZFTlRfVFlQRV9QT1JUX0NI
QU5HRSkgewo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCEobmRldi0+bXZkZXYuYWN0dWFsX2ZlYXR1
cmVzICYgCj4+IEJJVF9VTEwoVklSVElPX05FVF9GX1NUQVRVUykpKQo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gTk9USUZZX0RPTkU7Cj4gRG9lcyBub3QgYmVsb25nIGluIHRoaXMg
cGF0Y2gKWWVwLCBJIGNhbiBzcGxpdCB0aGUgcGF0Y2guIFRob3VnaCBmZWF0dXJlIHByb3Zpc2lv
bmluZyBvbiBtbHg1X3ZkcGEgaGFzIAp0byBkZXBlbmQgb24gdGhhdCBwYXRjaC4KCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBzd2l0Y2ggKGVxZS0+c3ViX3R5cGUpIHsKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGNhc2UgTUxYNV9QT1JUX0NIQU5HRV9TVUJUWVBFX0RPV046Cj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBjYXNlIE1MWDVfUE9SVF9DSEFOR0VfU1VCVFlQRV9BQ1RJVkU6Cj4+IEBAIC0zMDYwLDYg
KzMwNjMsNyBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9kZXZfYWRkKHN0cnVjdCAKPj4gdmRwYV9t
Z210X2RldiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+PiDCoMKgwqDCoMKgIHN0cnVjdCBt
bHg1X3ZkcGFfZGV2ICptdmRldjsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgbWx4NV92ZHBhX25ldCAq
bmRldjsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgbWx4NV9jb3JlX2RldiAqbWRldjsKPj4gK8KgwqDC
oCB1NjQgZGV2aWNlX2ZlYXR1cmVzOwo+PiDCoMKgwqDCoMKgIHUzMiBtYXhfdnFzOwo+PiDCoMKg
wqDCoMKgIHUxNiBtdHU7Cj4+IMKgwqDCoMKgwqAgaW50IGVycjsKPj4gQEAgLTMwNjgsNiArMzA3
MiwyNSBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9kZXZfYWRkKHN0cnVjdCAKPj4gdmRwYV9tZ210
X2RldiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIC1FTk9TUEM7Cj4+IMKgIMKgwqDCoMKgwqAgbWRldiA9IG1ndGRldi0+bWFkZXYtPm1kZXY7
Cj4+ICvCoMKgwqAgZGV2aWNlX2ZlYXR1cmVzID0gbWd0ZGV2LT5tZ3RkZXYuc3VwcG9ydGVkX2Zl
YXR1cmVzOwo+PiArwqDCoMKgIGlmIChhZGRfY29uZmlnLT5tYXNrICYgQklUX1VMTChWRFBBX0FU
VFJfREVWX0ZFQVRVUkVTKSkgewo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGFkZF9jb25maWctPmRl
dmljZV9mZWF0dXJlcyAmIH5kZXZpY2VfZmVhdHVyZXMpIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZGV2X3dhcm4obWRldi0+ZGV2aWNlLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgIlRoZSBwcm92aXNpb25lZCBmZWF0dXJlcyAweCVsbHggYXJlIG5vdCBzdXBwb3J0
ZWQgCj4+IGJ5IHRoaXMgZGV2aWNlIHdpdGggZmVhdHVyZXMgMHglbGx4XG4iLAo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRkX2NvbmZpZy0+ZGV2aWNlX2ZlYXR1cmVzLCBk
ZXZpY2VfZmVhdHVyZXMpOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZB
TDsKPj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4gK8KgwqDCoMKgwqDCoMKgIGRldmljZV9mZWF0dXJl
cyAmPSBhZGRfY29uZmlnLT5kZXZpY2VfZmVhdHVyZXM7Cj4+ICvCoMKgwqAgfQo+PiArwqDCoMKg
IGlmIChhZGRfY29uZmlnLT5tYXNrICYgQklUX1VMTChWRFBBX0FUVFJfREVWX0ZFQVRVUkVTKSAm
Jgo+IFRoaXMgbG9va3MgcmVkdW5kYW50LgpUaGlzIHdpbGwgYmUgaGFuZHkgdG8gcmV3cml0ZSB0
aGUgY29uZGl0aW9uYWwgd2hlbiBsZWdhY3kgZGV2aWNlIChub24gClZFUlNJT05fMSkgaXMgZ29p
bmcgdG8gYmUgcHJvdmlzaW9uZWQgd2hpY2ggbWF5IHN1cHBvcnQgaW4gZnV0dXJlLi4gQnV0IApJ
IGNhbiByZW1vdmUgdGhlIGNoZWNrIGZvciBub3cuCgo+PiArwqDCoMKgwqDCoMKgwqAgIShkZXZp
Y2VfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19GX1ZFUlNJT05fMSkgJiYKPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoCBkZXZpY2VfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19GX0FDQ0VTU19QTEFU
Rk9STSkpKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBkZXZfd2FybihtZGV2LT5kZXZpY2UsCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIk11c3QgcHJvdmlzaW9uIG1pbmltdW0gZmVhdHVyZXMg
MHglbGx4IGZvciB0aGlzIGRldmljZSIsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQklU
X1VMTChWSVJUSU9fRl9WRVJTSU9OXzEpIHwgCj4+IEJJVF9VTEwoVklSVElPX0ZfQUNDRVNTX1BM
QVRGT1JNKSk7Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVPUE5PVFNVUFA7Cj4+ICvCoMKg
wqAgfQo+PiArCj4+IMKgwqDCoMKgwqAgaWYgKCEoTUxYNV9DQVBfREVWX1ZEUEFfRU1VTEFUSU9O
KG1kZXYsIHZpcnRpb19xdWV1ZV90eXBlKSAmCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBNTFg1X1ZJ
UlRJT19FTVVMQVRJT05fQ0FQX1ZJUlRJT19RVUVVRV9UWVBFX1NQTElUKSkgewo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgZGV2X3dhcm4obWRldi0+ZGV2aWNlLCAibWlzc2luZyBzdXBwb3J0IGZvciBz
cGxpdCAKPj4gdmlydHF1ZXVlc1xuIik7Cj4+IEBAIC0zMDk2LDcgKzMxMTksNiBAQCBzdGF0aWMg
aW50IG1seDVfdmRwYV9kZXZfYWRkKHN0cnVjdCAKPj4gdmRwYV9tZ210X2RldiAqdl9tZGV2LCBj
b25zdCBjaGFyICpuYW1lLAo+PiDCoMKgwqDCoMKgIGlmIChJU19FUlIobmRldikpCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gUFRSX0VSUihuZGV2KTsKPj4gwqAgLcKgwqDCoCBuZGV2LT5t
dmRldi5tbHhfZmVhdHVyZXMgPSBtZ3RkZXYtPm1ndGRldi5zdXBwb3J0ZWRfZmVhdHVyZXM7Cj4+
IMKgwqDCoMKgwqAgbmRldi0+bXZkZXYubWF4X3ZxcyA9IG1heF92cXM7Cj4+IMKgwqDCoMKgwqAg
bXZkZXYgPSAmbmRldi0+bXZkZXY7Cj4+IMKgwqDCoMKgwqAgbXZkZXYtPm1kZXYgPSBtZGV2Owo+
PiBAQCAtMzExOCwyMCArMzE0MCwyNiBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9kZXZfYWRkKHN0
cnVjdCAKPj4gdmRwYV9tZ210X2RldiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9hbGxvYzsKPj4gwqDCoMKgwqDCoCB9Cj4+
IMKgIC3CoMKgwqAgZXJyID0gcXVlcnlfbXR1KG1kZXYsICZtdHUpOwo+PiAtwqDCoMKgIGlmIChl
cnIpCj4+IC3CoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9hbGxvYzsKPj4gK8KgwqDCoCBpZiAoZGV2
aWNlX2ZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fTkVUX0ZfTVRVKSkgewo+PiArwqDCoMKgwqDC
oMKgwqAgZXJyID0gcXVlcnlfbXR1KG1kZXYsICZtdHUpOwo+PiArwqDCoMKgwqDCoMKgwqAgaWYg
KGVycikKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfYWxsb2M7Cj4+IMKgIC3C
oMKgwqAgbmRldi0+Y29uZmlnLm10dSA9IGNwdV90b19tbHg1dmRwYTE2KG12ZGV2LCBtdHUpOwo+
PiArwqDCoMKgwqDCoMKgwqAgbmRldi0+Y29uZmlnLm10dSA9IGNwdV90b19tbHg1dmRwYTE2KG12
ZGV2LCBtdHUpOwo+PiArwqDCoMKgIH0KPj4gwqAgLcKgwqDCoCBpZiAoZ2V0X2xpbmtfc3RhdGUo
bXZkZXYpKQo+PiAtwqDCoMKgwqDCoMKgwqAgbmRldi0+Y29uZmlnLnN0YXR1cyB8PSBjcHVfdG9f
bWx4NXZkcGExNihtdmRldiwgCj4+IFZJUlRJT19ORVRfU19MSU5LX1VQKTsKPj4gLcKgwqDCoCBl
bHNlCj4+IC3CoMKgwqDCoMKgwqDCoCBuZGV2LT5jb25maWcuc3RhdHVzICY9IGNwdV90b19tbHg1
dmRwYTE2KG12ZGV2LCAKPj4gflZJUlRJT19ORVRfU19MSU5LX1VQKTsKPj4gK8KgwqDCoCBpZiAo
ZGV2aWNlX2ZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fTkVUX0ZfU1RBVFVTKSkgewo+PiArwqDC
oMKgwqDCoMKgwqAgaWYgKGdldF9saW5rX3N0YXRlKG12ZGV2KSkKPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbmRldi0+Y29uZmlnLnN0YXR1cyB8PSBjcHVfdG9fbWx4NXZkcGExNihtdmRldiwg
Cj4+IFZJUlRJT19ORVRfU19MSU5LX1VQKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGVsc2UKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbmRldi0+Y29uZmlnLnN0YXR1cyAmPSBjcHVfdG9fbWx4NXZk
cGExNihtdmRldiwgCj4+IH5WSVJUSU9fTkVUX1NfTElOS19VUCk7Cj4+ICvCoMKgwqAgfQo+IERv
ZXNuJ3QgYmVsb25nIGluIHRoaXMgcGF0Y2gKV2lsbCBzcGxpdCBwYXRjaC4KCi1TaXdlaQo+PiDC
oCDCoMKgwqDCoMKgIGlmIChhZGRfY29uZmlnLT5tYXNrICYgKDEgPDwgVkRQQV9BVFRSX0RFVl9O
RVRfQ0ZHX01BQ0FERFIpKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBtZW1jcHkobmRldi0+Y29u
ZmlnLm1hYywgYWRkX2NvbmZpZy0+bmV0Lm1hYywgRVRIX0FMRU4pOwo+PiAtwqDCoMKgIH0gZWxz
ZSB7Cj4+ICvCoMKgwqAgLyogTm8gYm90aGVyIHNldHRpbmcgbWFjIGFkZHJlc3MgaW4gY29uZmln
IGlmIG5vdCBnb2luZyB0byAKPj4gcHJvdmlzaW9uIF9GX01BQyAqLwo+PiArwqDCoMKgIH0gZWxz
ZSBpZiAoKGFkZF9jb25maWctPm1hc2sgJiBCSVRfVUxMKFZEUEFfQVRUUl9ERVZfRkVBVFVSRVMp
KSAKPj4gPT0gMCB8fAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2aWNlX2ZlYXR1cmVzICYg
QklUX1VMTChWSVJUSU9fTkVUX0ZfTUFDKSkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyID0g
bWx4NV9xdWVyeV9uaWNfdnBvcnRfbWFjX2FkZHJlc3MobWRldiwgMCwgMCwgCj4+IGNvbmZpZy0+
bWFjKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChlcnIpCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGdvdG8gZXJyX2FsbG9jOwo+PiBAQCAtMzE0MiwxMSArMzE3MCwyNiBAQCBzdGF0
aWMgaW50IG1seDVfdmRwYV9kZXZfYWRkKHN0cnVjdCAKPj4gdmRwYV9tZ210X2RldiAqdl9tZGV2
LCBjb25zdCBjaGFyICpuYW1lLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyID0gbWx4NV9tcGZz
X2FkZF9tYWMocGZtZGV2LCBjb25maWctPm1hYyk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
ZXJyKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9hbGxvYzsKPj4gLQo+
PiAtwqDCoMKgwqDCoMKgwqAgbmRldi0+bXZkZXYubWx4X2ZlYXR1cmVzIHw9IEJJVF9VTEwoVklS
VElPX05FVF9GX01BQyk7Cj4+ICvCoMKgwqAgfSBlbHNlIGlmICgoYWRkX2NvbmZpZy0+bWFzayAm
IEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9GRUFUVVJFUykpIAo+PiA9PSAwKSB7Cj4+ICvCoMKgwqDC
oMKgwqDCoCAvKgo+PiArwqDCoMKgwqDCoMKgwqDCoCAqIFdlIHVzZWQgdG8gY2xlYXIgX0ZfTUFD
IGZlYXR1cmUgYml0IGlmIHNlZWluZwo+PiArwqDCoMKgwqDCoMKgwqDCoCAqIHplcm8gbWFjIGFk
ZHJlc3Mgd2hlbiBkZXZpY2UgZmVhdHVyZXMgYXJlIG5vdAo+PiArwqDCoMKgwqDCoMKgwqDCoCAq
IHNwZWNpZmljYWxseSBwcm92aXNpb25lZC4gS2VlcCB0aGUgYmVoYXZpb3VyCj4+ICvCoMKgwqDC
oMKgwqDCoMKgICogc28gb2xkIHNjcmlwdHMgZG8gbm90IGJyZWFrLgo+PiArwqDCoMKgwqDCoMKg
wqDCoCAqLwo+PiArwqDCoMKgwqDCoMKgwqAgZGV2aWNlX2ZlYXR1cmVzICY9IH5CSVRfVUxMKFZJ
UlRJT19ORVRfRl9NQUMpOwo+PiArwqDCoMKgIH0gZWxzZSBpZiAoZGV2aWNlX2ZlYXR1cmVzICYg
QklUX1VMTChWSVJUSU9fTkVUX0ZfTUFDKSkgewo+PiArwqDCoMKgwqDCoMKgwqAgLyogRG9uJ3Qg
cHJvdmlzaW9uIHplcm8gbWFjIGFkZHJlc3MgZm9yIF9GX01BQyAqLwo+PiArwqDCoMKgwqDCoMKg
wqAgbWx4NV92ZHBhX3dhcm4oJm5kZXYtPm12ZGV2LAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICJObyBtYWMgYWRkcmVzcyBwcm92aXNpb25lZD9cbiIpOwo+PiArwqDC
oMKgwqDCoMKgwqAgZXJyID0gLUVJTlZBTDsKPj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8gZXJyX2Fs
bG9jOwo+PiDCoMKgwqDCoMKgIH0KPj4gwqAgLcKgwqDCoCBjb25maWctPm1heF92aXJ0cXVldWVf
cGFpcnMgPSBjcHVfdG9fbWx4NXZkcGExNihtdmRldiwgbWF4X3ZxcyAKPj4gLyAyKTsKPj4gK8Kg
wqDCoCBpZiAoZGV2aWNlX2ZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fTkVUX0ZfTVEpKQo+PiAr
wqDCoMKgwqDCoMKgwqAgY29uZmlnLT5tYXhfdmlydHF1ZXVlX3BhaXJzID0gY3B1X3RvX21seDV2
ZHBhMTYobXZkZXYsIAo+PiBtYXhfdnFzIC8gMik7Cj4+ICsKPj4gK8KgwqDCoCBuZGV2LT5tdmRl
di5tbHhfZmVhdHVyZXMgPSBkZXZpY2VfZmVhdHVyZXM7Cj4+IMKgwqDCoMKgwqAgbXZkZXYtPnZk
ZXYuZG1hX2RldiA9ICZtZGV2LT5wZGV2LT5kZXY7Cj4+IMKgwqDCoMKgwqAgZXJyID0gbWx4NV92
ZHBhX2FsbG9jX3Jlc291cmNlcygmbmRldi0+bXZkZXYpOwo+PiDCoMKgwqDCoMKgIGlmIChlcnIp
Cj4+IEBAIC0zMjQzLDcgKzMyODYsOCBAQCBzdGF0aWMgaW50IG1seDV2X3Byb2JlKHN0cnVjdCBh
dXhpbGlhcnlfZGV2aWNlIAo+PiAqYWRldiwKPj4gwqDCoMKgwqDCoCBtZ3RkZXYtPm1ndGRldi5p
ZF90YWJsZSA9IGlkX3RhYmxlOwo+PiDCoMKgwqDCoMKgIG1ndGRldi0+bWd0ZGV2LmNvbmZpZ19h
dHRyX21hc2sgPSAKPj4gQklUX1VMTChWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFDQUREUikgfAo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJJVF9VTEwo
VkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVApIHwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCSVRfVUxMKFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NVFUp
Owo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJJVF9VTEwo
VkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01UVSkgfAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9GRUFUVVJFUyk7Cj4+IMKg
wqDCoMKgwqAgbWd0ZGV2LT5tZ3RkZXYubWF4X3N1cHBvcnRlZF92cXMgPQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgTUxYNV9DQVBfREVWX1ZEUEFfRU1VTEFUSU9OKG1kZXYsIG1heF9udW1fdmlydGlv
X3F1ZXVlcykgKyAxOwo+PiDCoMKgwqDCoMKgIG1ndGRldi0+bWd0ZGV2LnN1cHBvcnRlZF9mZWF0
dXJlcyA9IGdldF9zdXBwb3J0ZWRfZmVhdHVyZXMobWRldik7CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
