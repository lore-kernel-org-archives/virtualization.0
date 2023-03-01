Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C26C64EC4
	for <virtualization@archiver.kernel.org>; Wed,  1 Mar 2023 01:30:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C6F5B402D7;
	Wed,  1 Mar 2023 01:30:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C6F5B402D7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=cYPhXumh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=GP3xJliN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xBm72JK_USIn; Wed,  1 Mar 2023 01:30:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 17A76400D8;
	Wed,  1 Mar 2023 01:30:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 17A76400D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2294C0033;
	Wed,  1 Mar 2023 01:30:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B64BC002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 01:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0188481589
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 01:30:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0188481589
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=cYPhXumh; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=GP3xJliN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 32jcRSKidh5B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 01:30:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2136181585
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2136181585
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 01:30:36 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 31SNDiDF025010; Wed, 1 Mar 2023 01:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=PjDmXWi396pJA86FUQ/C5XqrwjJ47WbDG99PSEoZcvk=;
 b=cYPhXumh5iQUBGmVLz0ugT8anXA6w/9Ah+cNOFWrYqaXH1Fs2SCY7ukzp/Z90qjCjiyr
 i0r+Yt0B8crQaNkb1wWWziMsZtG4tnZAuKaH0GBBECakB8aFRGO85S2SS2RMIpHcMZZG
 vGcpnJtYD+Woe8xW/ysrif+0eYCzhIGPhI63pkkImda2duxH0ckfVd3z5PFWfA/r/pVH
 FiKkd+xnBZIpsZy5bWve2Ws6UhD7Hez8nJn5BxCbkTJ1lC7Al5qQK5EgyfIwuvG7KS6v
 YL2WuR+S9Be4jbmus9s6Od+bgRiWKpmzPODxNbYajvjXUz/bz5WYypeW+aQniW1JEWki GA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72fs9n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Mar 2023 01:30:23 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 3210uBwM032926; Wed, 1 Mar 2023 01:30:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ny8s7pwme-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Mar 2023 01:30:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgP1SrZg4LzAkttrjHl5zP1NJIYIhLgLP6etMU/ekAvx35NaPfJ0sZgVUIikW0L3LTqUtigQK0U+JZXw5U2kCvWcBQhZjHZgtGXHLYsCXnVmVigGBxjiZ8TwDz2knbLpfXfhowAUfZZ6I4GxsHjza8DoDP60H4v//eTT9xutt87KKAMTomo99hVrNvjAMMtF8htJ5lbQok8O1A/yZGZR9EkMcCpZ+PNcGIw00ViWFtmIp4TCyPyvb1ZdNs8linDD4gSH1F1FHzfywaPbKDGOZxJD10d2m56i0GLzG7YUmgU+0JbXXlXvqwHrG+vF94jS5XpQpMHY91NnF6q6PvQPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjDmXWi396pJA86FUQ/C5XqrwjJ47WbDG99PSEoZcvk=;
 b=a4ZTp8Tc2z9UILj/WCjsTcfd34LAefUzDHZMEua5/78HQiKF9Z7S+UmutGwFbeZAOSyWG8beVJgWUx2tkH72w4E/xZgJjPQFFEdU9xE1swEbij388FLP2xLCbS9vmsBcU/jYmZEZj7Q6ib7oZ8UPxiO925N8bPO6sonO2eMSeBcFOmUrHkOCu1ovOsqXTcX8zhlzRK+xssrOXFRo/ccWROxtqogJMVO5jV739GlczeNCiFIppVCvPJD2t8sPQGcgLIj2UbBkSVqEAtPsJOBSSvGm/fyZphDQ6EHPuOzDvQ0ndwPn5IUAqrYlCmeOlF6kkYUsDDlRzWZz4GQuoZ0xjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjDmXWi396pJA86FUQ/C5XqrwjJ47WbDG99PSEoZcvk=;
 b=GP3xJliNx4WkMMbV7Atk0NGxRaUyvXB3qBbXg1jLbba1DjzY3bzFrRibyGWDH/HqOYKz3+c5qS5c92ULSpH5vg4V2qdqlFjOWzwHhmHSc75rCBo/MDFPtdLbstddkGHgMa6zH44SXIUBbQbEvidFDipIDq0VsaT9UEInoBou2DQ=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CO1PR10MB4435.namprd10.prod.outlook.com (2603:10b6:303:6c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.7; Wed, 1 Mar
 2023 01:30:20 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3%9]) with mapi id 15.20.6156.016; Wed, 1 Mar 2023
 01:30:20 +0000
Message-ID: <32496de6-e1f7-a37b-3c82-5d294a9dd339@oracle.com>
Date: Tue, 28 Feb 2023 17:30:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 07/15] vdpa: add vhost_vdpa_suspend
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230224155438.112797-1-eperezma@redhat.com>
 <20230224155438.112797-8-eperezma@redhat.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230224155438.112797-8-eperezma@redhat.com>
X-ClientProxiedBy: BYAPR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:74::21) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CO1PR10MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d5f4a0-217c-4fcb-6e99-08db19f48547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gv4LYyWOqcyWNeCslWF5zAufYocmA0eUTTf3DaxYNTsIEBHpQxLsrtGBGfPgqdmTUAPLAK26WTRbSJrFqNDRj7kL73PWXovX0irf1TMvaojGiaOic9A0jFTnl1mbav1nE9arJlCT6FkelN3t+3JC9NVILB09LwhMgpUbhPdHReBSWBEWtAtLl86lXON1Oo1lAAEts882SblDIdxAJD8mOQ0vfAyNp86dr9uONDcpztvlf42nDIaRw0MP2bMkeoeYP5FM9Pz5f83emPRTCg3hv5kDHeIsVru5Z45kbgBBDbKptR4a9FfL10YIEGCxaeNWcN4y77h5qnVICBsU0LiSfnbMoMXr7Xv/+xcwiPvf5Qo56cRWHmPTcCcO+bvHZW/xhcf732o4THN+H+utx/Gf+Gtb8PZ9tR4BsnW0lcowa8rTmfOO29og6XeJHDjXuwa1G81Hs/2XcHt8KBabSoMGLDrA1T2wOYq+/d4rTx4WosOZR2QIkB61johqZb8lRy3FAdkpp6ZSXWHNgOtsXfR91tnBFRoo8b65HjuUCXUtKVVlLGIDWrweTHkxIMFRMuUzawpD1s+rcA/JEdXjSIVr3H3ThDmnzfz1Y5jBUCIr9WXKojpdNvW9cAy7+3bXFEV1y0BzJ+QKmZRKKyyy7XJ3HpN+1dthLCINIuUZ1X7G887kvxP/J6bvseOw8zypCrksG5+wepF6VrIndNXOSnCBQavjFac3ocQsG/SCgeuburQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199018)(66899018)(66946007)(66556008)(66476007)(41300700001)(8676002)(31686004)(4326008)(316002)(54906003)(8936002)(83380400001)(36756003)(66574015)(2906002)(36916002)(5660300002)(478600001)(7416002)(6512007)(26005)(186003)(31696002)(86362001)(6486002)(53546011)(6506007)(38100700002)(6666004)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blRGYndVTXlCa1BhOGdUR3Y1emQ3N0toZUdLUnZZYmtWa2pVVUtxdENWVUhp?=
 =?utf-8?B?dFB4SlZOdTBDdlo4VlZEYlhadEFSL0duSS9IVEhEcTZMWmc4cUwwSUNPTEo0?=
 =?utf-8?B?UnlMY2luaUFNYVAvK3Q2V1daYkxaTWJFRC9Ub2JQdUsyWWNVMWJSSGFvaFNB?=
 =?utf-8?B?RnYrSHNlTHpaejlTbi9VVXFDcXg1dEtxN0N5a1orb2RHaUdsYzRzYmFlT0xh?=
 =?utf-8?B?cGt1blh2VzNZZXpvTGFWcUZicFNIaWtHN0FMclZRazZkS3NDTktQaFQwbnJR?=
 =?utf-8?B?NWFWWG12U0ZzVGZENU12WitFTTlEdEhhWkphZy8wc1NlZ3ZGQWtpSnFzdytX?=
 =?utf-8?B?aE9JR2NyQmo0dy9nOFQ3ckx3NlVzUzRmTVRST3VtN2RDU3NTRnhIME9MaFFx?=
 =?utf-8?B?TFNVWVNzYVJGdXVVc00xamNPNDZlTXhFQitzNlg1UXB5RVFkeXhJQjZScVVs?=
 =?utf-8?B?dUJGWGxOSktZKzZYN0JQQjhBQ3JRSnIwUUNOTVR0LytzRjRCTXV6T3dMa2Ix?=
 =?utf-8?B?Z3ZWYUZWYm0xTklnQ1dmd2FNVGVrc0JJQllpa3ZTTjNpZkdKeFVGRFd0YVpF?=
 =?utf-8?B?QnV2dEVSVUZxeEJxSDVXTVFMNzJmU1dNQ3FpbFROSGxKNTRDeUExUk5XUVQx?=
 =?utf-8?B?MmM0ckVSWDNuOVdzRWxoZ2NQS3NQUytiZkZLTWpOQ0pXVldnSXFLMHp6UmNH?=
 =?utf-8?B?dDJzV0JiUjRYelNyR1pnNHNtdit6Z1NTbkt4RnFaV0d4eGdHaFFLZlVyTWRF?=
 =?utf-8?B?S29rcEgvRVRLRXhMVHdVM1pHTFNJTitoWGJoT204UWR6TVNSUjRrdmluU3Qv?=
 =?utf-8?B?MU45UEN3WWJienJIZU5OVTlLelcwMnZnZU9UUEx4bE5aaEJCNGZDSHIvR1ZO?=
 =?utf-8?B?bXRGYzJob2pRUmtTS2ZHdlk4UFR0N0xiemJ1YWRLWGc0WjJnYXhBNlhBbGJr?=
 =?utf-8?B?WjFscmJuRkh3czQ0V1lQM1hWUXpBQ0gvTXZCcGY1WVFXUThscEJYdmxHNnVJ?=
 =?utf-8?B?d1ZrcnU1WC9rcEVTRjdnazZLM08vdTlxOG5DV1VReEVGNVlBZ2xGdXdFZzhI?=
 =?utf-8?B?RC9jU2EyUkNNWE1BNmNBRVNJUk1ZSVJQbVpvVHJHcU1JSjAvWXVQZWMvV0FN?=
 =?utf-8?B?aFFBZFNSY09tZDJYU1gwS2lqbFBlbmlXTDFSTFQrZUI3ZGhHa2VTZWc5cklJ?=
 =?utf-8?B?NEZxNUNQVlh2ZW5HT1d2dWVLVC8rclI4YUl0N0pIbURPVzYxV0RHYlZLVnQz?=
 =?utf-8?B?ZWpXM1VkQnhQR3cxNWgxcnFFUnJDMzJ2NlpCZWx0Zk9TWW9YOXR4bWtJaFBU?=
 =?utf-8?B?dzFvOXFJamk5djNDZjVkeno5alM1Y1JKUitydWIxalc0OWVhKzNtbXFNVVAv?=
 =?utf-8?B?ejlYU0NFcVNIeDlhYXlCWjlzUkZGU0JIbzU3Vkl0L3hjY09tYXV0VzBpUDVn?=
 =?utf-8?B?L3BubVBuTTlXR0VNdWlpODB0RTZnSklIbFFkS2hRTXlTbU5iY1JrM1ZBRVRz?=
 =?utf-8?B?aFVRZ2hLMmlJNEJjL2V2RlFYY1Q2TlIvdWRMVStFYWtla25tKzJOUmxaMWNu?=
 =?utf-8?B?UVl5WGluYVVTYXNobHFWVDNFUWpYWkRjc3I5NHpCcTZSdklUZkpQTnBQS3gw?=
 =?utf-8?B?K0lVQ2xBZElkaU9JdlB6WTVmNkk5RWlQT1hwTmQzYWZJbHJQNnJOMXhma3BZ?=
 =?utf-8?B?MWN2VVZCNjlUTnFTZ2lhWXIxRzRybG0rNm5OcGQrS3NnL2F4bTNDSXNOWS9M?=
 =?utf-8?B?WGdzN094aWZadmk0ZUhFTmw4dFl5ZnV3WDNtZTE2TThWTDQxR1JMelFzVUZo?=
 =?utf-8?B?TFhSelFCNXd2VEdsaklVODkyYzFjVWs5ZXp1TitCSXVudUNKbUtxVlNUclB5?=
 =?utf-8?B?UmRiZ1VGcHk5QXNHdHM5STE3bHJBZUo5WWdNQS9GekI5UTFvekEvKytLL2Fr?=
 =?utf-8?B?NXYwb3puZk0xUEgzYjRlUkVHcFd4R1dRLytIS21nZzRzbWR3RjdvWC9xZ1lE?=
 =?utf-8?B?RzFGdE1IUk5kRUtTRmVhZVFIV2FucklzVVRHRzJwaWIyTzV4bG9XZURPZUhu?=
 =?utf-8?B?WS9yLzVkYjZNcVhaQkV6MDNXYUhPdnN0eFROWjBISEpFelJLTDh2VlJNTlVl?=
 =?utf-8?Q?NIoQjdA73odbWe+/izv5NcwB6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U0RKTFk2SHZXWWYrem5KVXVRdTA3QlVPZVdIK25aYjlaVGR1UDFIYXliM1Qv?=
 =?utf-8?B?SWZMamIxY1JzNGlEMnJlSS84S1VhQTVkV2s0RURoS3RwU2d6dE80K3VnTWVk?=
 =?utf-8?B?QTdwVDhSZE52aEFoQUNVUHdHbnMzbjBJN2VqVUxvR3ZQYnMxUjdFak4yNS9y?=
 =?utf-8?B?blRWS1dFUVMxRS9OWGFIQTcxY1pGVE9yYy9VbWhyZGNkZ05CcVN4Wi81ZTVj?=
 =?utf-8?B?VldOTUVFZ3l0ZDBzbW9lMWpRWmdZNXhRa01RNUlUYW5wUTZsbDhlaHlrTVcx?=
 =?utf-8?B?clordFIva3hDL1o4Z0VacG1UdS9FdkIxOUlBdHIxampQV2RwcDZlcjZENnl4?=
 =?utf-8?B?NU03SDVKdWVkWHhHcFA5Ukgyd2ZuY0tjd0drTTlCaXVTaWh5ZUZFd2QzZ21n?=
 =?utf-8?B?azczMGVpQVFHem1qTUsyWTBBdmNIKzhJSU9tNE9rQXhGUWdxam0vcGhhZkg1?=
 =?utf-8?B?WkQvQ2crZUhWK29ac0ZZdzZQK0Fqak9oS01PNjZZaGRNaXR2a3REclgzR0dK?=
 =?utf-8?B?N2xvc3JwL2hXNlowTVRsTkVmeG9JazI4WHVqeXBTaEs5ai9CZDdqY0l3S28z?=
 =?utf-8?B?VFBsNFE5UUUxbWVqcUdWa1RickswcS9ZUDRlYi9QYWc2VVZ2bzRmalBnZFQv?=
 =?utf-8?B?UGh0WFA0TnVLK200a1I0dUdWN2ZhOVBzWkg2SzdOeDZ6U0w3Sk1wTXVkbUV6?=
 =?utf-8?B?ditFci91RkgvM2NqelhnSWxseWpVcUxlNE9hR013dmFvOEZGWExNNmpXQXF6?=
 =?utf-8?B?ZVFmQ0F1Sy9ZbEVaZkswSk5DRi9rbGE5OHd3aVJ3RU5aOVlvbWZlSXVxNGZw?=
 =?utf-8?B?bGl5M0NOcjJqZ3p0NTgyODBjb0tidjEzSW1NNWN0M0pWWWpRQXF3Nzlyd2RM?=
 =?utf-8?B?V2V2SUhhWm1kS2VYQTV4S1RpZXZRQmQ2NVNJK2xYZk95aDRiSWgwb2dYbThs?=
 =?utf-8?B?SnlGdm5TSHcwMXE5Q3JXeSs4NDBYdDNtcHgxQ1lnY1kyNnVzSVBPYStDeVFh?=
 =?utf-8?B?NjhVWFpUcjlMRFlSUk9GMG93Y1R3MWpqcGxHbVhUMTVCc0FLSU4zVVBDc0xh?=
 =?utf-8?B?RW9DcUZybHkxeE0ySVRnbXRkYWpmMmo5OXQ1UStLRUFHalZ0RFVOa3Q5V25F?=
 =?utf-8?B?T3pqTHdGam1haVVkMmpxejlUc3dDTy95bFRpUUdMd05lNUZ3ZUNnMXV6bFdI?=
 =?utf-8?B?Y05zVUkzZzVqdDFBdGhWWWVrczlxMm9iZU5zZzVkRmxnNVhQeFd4bmREMS9R?=
 =?utf-8?B?bHFORjh6ZHFmeTBrSGdRRnJ0N3JRU3lVaDBDQ05mNzVrOHNJRC9sZlAyUnpr?=
 =?utf-8?B?S1BEM2xnR1VEaUpCRkIybDlxN2pVWDVwVk5Hd0NScHVsS01LMXpaU2RDTk03?=
 =?utf-8?Q?X64kpGot3f6d2/3pKe1GJiznwyuZlRak=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d5f4a0-217c-4fcb-6e99-08db19f48547
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 01:30:20.4477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ByGkkbIPj+xELhCKckwUHzBYcQ0j8za1/oFJW6sik1xnVkblJbt1cf3ORdJXYY2RopJCwqPg3hXSPJaPWzlXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4435
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_19,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010010
X-Proofpoint-ORIG-GUID: B8TCOHY52Xa8kJAQtSKCsgzmpMfZEDa5
X-Proofpoint-GUID: B8TCOHY52Xa8kJAQtSKCsgzmpMfZEDa5
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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

CgpPbiAyLzI0LzIwMjMgNzo1NCBBTSwgRXVnZW5pbyBQw6lyZXogd3JvdGU6Cj4gVGhlIGZ1bmN0
aW9uIHZob3N0LmM6dmhvc3RfZGV2X3N0b3AgZmV0Y2hlcyB0aGUgdnJpbmcgYmFzZSBzbyB0aGUg
dnEKPiBzdGF0ZSBjYW4gYmUgbWlncmF0ZWQgdG8gb3RoZXIgZGV2aWNlcy4gIEhvd2V2ZXIsIHRo
aXMgaXMgdW5yZWxpYWJsZSBpbgo+IHZkcGEsIHNpbmNlIHdlIGRpZG4ndCBzaWduYWwgdGhlIGRl
dmljZSB0byBzdXNwZW5kIHRoZSBxdWV1ZXMsIG1ha2luZwo+IHRoZSB2YWx1ZSBmZXRjaGVkIHVz
ZWxlc3MuCj4KPiBTdXNwZW5kIHRoZSBkZXZpY2UgaWYgcG9zc2libGUgYmVmb3JlIGZldGNoaW5n
IGZpcnN0IGFuZCBzdWJzZXF1ZW50Cj4gdnJpbmcgYmFzZXMuCj4KPiBNb3Jlb3ZlciwgdmRwYSB0
b3RhbGx5IHJlc2V0IGFuZCB3aXBlcyB0aGUgZGV2aWNlIGF0IHRoZSBsYXN0IGRldmljZQo+IGJl
Zm9yZSBmZXRjaCBpdHMgdnJpbmdzIGJhc2UsIG1ha2luZyB0aGF0IG9wZXJhdGlvbiB1c2VsZXNz
IGluIHRoZSBsYXN0Cj4gZGV2aWNlLiBUaGlzIHdpbGwgYmUgZml4ZWQgaW4gbGF0ZXIgcGF0Y2hl
cyBvZiB0aGlzIHNlcmllcy4KPgo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVy
ZXptYUByZWRoYXQuY29tPgo+IC0tLQo+IHY0Ogo+ICogTG9vayBmb3IgX0ZfU1VTUEVORCBhdCB2
aG9zdF9kZXYtPmJhY2tlbmRfY2FwLCBub3QgYmFja2VuZF9mZWF0dXJlcwo+ICogRmFsbCBiYWNr
IG9uIHJlc2V0ICYgZmV0Y2ggdXNlZCBpZHggZnJvbSBndWVzdCdzIG1lbW9yeQo+IC0tLQo+ICAg
aHcvdmlydGlvL3Zob3N0LXZkcGEuYyB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrKysKPiAg
IGh3L3ZpcnRpby90cmFjZS1ldmVudHMgfCAgMSArCj4gICAyIGZpbGVzIGNoYW5nZWQsIDI2IGlu
c2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jIGIvaHcv
dmlydGlvL3Zob3N0LXZkcGEuYwo+IGluZGV4IDIyODY3Nzg5NWEuLmY1NDI5NjBhNjQgMTAwNjQ0
Cj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC12
ZHBhLmMKPiBAQCAtNzEyLDYgKzcxMiw3IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9yZXNldF9k
ZXZpY2Uoc3RydWN0IHZob3N0X2RldiAqZGV2KQo+ICAgCj4gICAgICAgcmV0ID0gdmhvc3RfdmRw
YV9jYWxsKGRldiwgVkhPU1RfVkRQQV9TRVRfU1RBVFVTLCAmc3RhdHVzKTsKPiAgICAgICB0cmFj
ZV92aG9zdF92ZHBhX3Jlc2V0X2RldmljZShkZXYsIHN0YXR1cyk7Cj4gKyAgICB2LT5zdXNwZW5k
ZWQgPSBmYWxzZTsKPiAgICAgICByZXR1cm4gcmV0Owo+ICAgfQo+ICAgCj4gQEAgLTExMDksNiAr
MTExMCwyOSBAQCBzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX3N2cXNfc3RvcChzdHJ1Y3Qgdmhvc3Rf
ZGV2ICpkZXYpCj4gICAgICAgfQo+ICAgfQo+ICAgCj4gK3N0YXRpYyB2b2lkIHZob3N0X3ZkcGFf
c3VzcGVuZChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gK3sKPiArICAgIHN0cnVjdCB2aG9zdF92
ZHBhICp2ID0gZGV2LT5vcGFxdWU7Cj4gKyAgICBpbnQgcjsKPiArCj4gKyAgICBpZiAoIXZob3N0
X3ZkcGFfZmlyc3RfZGV2KGRldikpIHsKPiArICAgICAgICByZXR1cm47Cj4gKyAgICB9Cj4gKwo+
ICsgICAgaWYgKCEoZGV2LT5iYWNrZW5kX2NhcCAmIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1NV
U1BFTkQpKSkgewpQb2xhcml0eSByZXZlcnNlZC4gVGhpcyBlbmRzIHVwIGRldmljZSBnZXR0aW5n
IHJlc2V0IGFsd2F5cyBldmVuIGlmIHRoZSAKYmFja2VuZCBvZmZlcnMgX0ZfU1VTUEVORC4KCi1T
aXdlaQoKPiArICAgICAgICB0cmFjZV92aG9zdF92ZHBhX3N1c3BlbmQoZGV2KTsKPiArICAgICAg
ICByID0gaW9jdGwodi0+ZGV2aWNlX2ZkLCBWSE9TVF9WRFBBX1NVU1BFTkQpOwo+ICsgICAgICAg
IGlmICh1bmxpa2VseShyKSkgewo+ICsgICAgICAgICAgICBlcnJvcl9yZXBvcnQoIkNhbm5vdCBz
dXNwZW5kOiAlcyglZCkiLCBnX3N0cmVycm9yKGVycm5vKSwgZXJybm8pOwo+ICsgICAgICAgIH0g
ZWxzZSB7Cj4gKyAgICAgICAgICAgIHYtPnN1c3BlbmRlZCA9IHRydWU7Cj4gKyAgICAgICAgICAg
IHJldHVybjsKPiArICAgICAgICB9Cj4gKyAgICB9Cj4gKwo+ICsgICAgdmhvc3RfdmRwYV9yZXNl
dF9kZXZpY2UoZGV2KTsKPiArfQo+ICsKPiAgIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9kZXZfc3Rh
cnQoc3RydWN0IHZob3N0X2RldiAqZGV2LCBib29sIHN0YXJ0ZWQpCj4gICB7Cj4gICAgICAgc3Ry
dWN0IHZob3N0X3ZkcGEgKnYgPSBkZXYtPm9wYXF1ZTsKPiBAQCAtMTEyMyw2ICsxMTQ3LDcgQEAg
c3RhdGljIGludCB2aG9zdF92ZHBhX2Rldl9zdGFydChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIGJv
b2wgc3RhcnRlZCkKPiAgICAgICAgICAgfQo+ICAgICAgICAgICB2aG9zdF92ZHBhX3NldF92cmlu
Z19yZWFkeShkZXYpOwo+ICAgICAgIH0gZWxzZSB7Cj4gKyAgICAgICAgdmhvc3RfdmRwYV9zdXNw
ZW5kKGRldik7Cj4gICAgICAgICAgIHZob3N0X3ZkcGFfc3Zxc19zdG9wKGRldik7Cj4gICAgICAg
ICAgIHZob3N0X3ZkcGFfaG9zdF9ub3RpZmllcnNfdW5pbml0KGRldiwgZGV2LT5udnFzKTsKPiAg
ICAgICB9Cj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby90cmFjZS1ldmVudHMgYi9ody92aXJ0aW8v
dHJhY2UtZXZlbnRzCj4gaW5kZXggYTg3YzVmMzlhMi4uOGY4ZDA1Y2Y5YiAxMDA2NDQKPiAtLS0g
YS9ody92aXJ0aW8vdHJhY2UtZXZlbnRzCj4gKysrIGIvaHcvdmlydGlvL3RyYWNlLWV2ZW50cwo+
IEBAIC01MCw2ICs1MCw3IEBAIHZob3N0X3ZkcGFfc2V0X3ZyaW5nX3JlYWR5KHZvaWQgKmRldikg
ImRldjogJXAiCj4gICB2aG9zdF92ZHBhX2R1bXBfY29uZmlnKHZvaWQgKmRldiwgY29uc3QgY2hh
ciAqbGluZSkgImRldjogJXAgJXMiCj4gICB2aG9zdF92ZHBhX3NldF9jb25maWcodm9pZCAqZGV2
LCB1aW50MzJfdCBvZmZzZXQsIHVpbnQzMl90IHNpemUsIHVpbnQzMl90IGZsYWdzKSAiZGV2OiAl
cCBvZmZzZXQ6ICUiUFJJdTMyIiBzaXplOiAlIlBSSXUzMiIgZmxhZ3M6IDB4JSJQUkl4MzIKPiAg
IHZob3N0X3ZkcGFfZ2V0X2NvbmZpZyh2b2lkICpkZXYsIHZvaWQgKmNvbmZpZywgdWludDMyX3Qg
Y29uZmlnX2xlbikgImRldjogJXAgY29uZmlnOiAlcCBjb25maWdfbGVuOiAlIlBSSXUzMgo+ICt2
aG9zdF92ZHBhX3N1c3BlbmQodm9pZCAqZGV2KSAiZGV2OiAlcCIKPiAgIHZob3N0X3ZkcGFfZGV2
X3N0YXJ0KHZvaWQgKmRldiwgYm9vbCBzdGFydGVkKSAiZGV2OiAlcCBzdGFydGVkOiAlZCIKPiAg
IHZob3N0X3ZkcGFfc2V0X2xvZ19iYXNlKHZvaWQgKmRldiwgdWludDY0X3QgYmFzZSwgdW5zaWdu
ZWQgbG9uZyBsb25nIHNpemUsIGludCByZWZjbnQsIGludCBmZCwgdm9pZCAqbG9nKSAiZGV2OiAl
cCBiYXNlOiAweCUiUFJJeDY0IiBzaXplOiAlbGx1IHJlZmNudDogJWQgZmQ6ICVkIGxvZzogJXAi
Cj4gICB2aG9zdF92ZHBhX3NldF92cmluZ19hZGRyKHZvaWQgKmRldiwgdW5zaWduZWQgaW50IGlu
ZGV4LCB1bnNpZ25lZCBpbnQgZmxhZ3MsIHVpbnQ2NF90IGRlc2NfdXNlcl9hZGRyLCB1aW50NjRf
dCB1c2VkX3VzZXJfYWRkciwgdWludDY0X3QgYXZhaWxfdXNlcl9hZGRyLCB1aW50NjRfdCBsb2df
Z3Vlc3RfYWRkcikgImRldjogJXAgaW5kZXg6ICV1IGZsYWdzOiAweCV4IGRlc2NfdXNlcl9hZGRy
OiAweCUiUFJJeDY0IiB1c2VkX3VzZXJfYWRkcjogMHglIlBSSXg2NCIgYXZhaWxfdXNlcl9hZGRy
OiAweCUiUFJJeDY0IiBsb2dfZ3Vlc3RfYWRkcjogMHglIlBSSXg2NAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
