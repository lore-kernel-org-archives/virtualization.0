Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAAEC7EE43
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3190682158;
	Tue, 13 Jun 2023 01:42:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3190682158
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=hbDswR5b;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=ySitcYXe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4SJgJOmD4uSZ; Tue, 13 Jun 2023 01:42:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A0CBB82197;
	Tue, 13 Jun 2023 01:42:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A0CBB82197
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74262C007A;
	Tue, 13 Jun 2023 01:42:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60D73C0029
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:42:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B02C382152
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:42:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B02C382152
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tI32GYqSHCck
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:42:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E42782155
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E42782155
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:42:10 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKNxB8029014; Tue, 13 Jun 2023 01:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=pW00FVbl/y5qx+H96C8+Nmje7d1SQ2ueap+6YXwsrSM=;
 b=hbDswR5bvyF8bIhGm1axlU1gCWSDfQXiBrNF8yS/SBVKrgUifm7KB4QkqWD+bkJziK0n
 Rk24SrIRiEgU/mDEbynWD0HT26eL6ZoIHbAV8QvisAVD9tgx33/+fBNrhfpzFcQYpjh4
 PtSgE61JqQazCdfeCvGAKBUMjNGggt2PaLEgJDwZt4WoGV3aVzcNDtVyy2f56jN2jYti
 I7YZg5tMDcJPnQRWL4AQFFpjR2xoOAwcV0iRqv2VI6lntyYzl4p6UpTr/NxRB5ZmcKqD
 uhkITCYsKear9xnnQ71wEZLMOKmpExQP19E9mc/gpyStJEV+d9dtlT3coCZE/g2fRyBe sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3bm8ch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:42:09 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35D06fsS021667; Tue, 13 Jun 2023 01:42:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3hnnc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:42:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjKKAA0527lT7wnuCCcg9N1mm5n9VinuX7bYXhb+vYJEXDnJckDHMYt7WCQmC10VSRv/kM0dkHWtp+sJ6nUF/wAGDAAMFXXhaQk/jEJWVKlfjwJjrj8hzVC++5Ii0WOAttEM/bncelEJniXOIK86HSQty4fqs5LuU3yt0awVQ7TpAfy1cITdPi2cSjsiNPfat5+HfOSRLMyfzAMaCZ1yPZ/Ro4qdQ5RUOtKCOXF1ZPCaWg+m0P3hDbXDzfxnTZEgrNC43wd4iXmHBFQhpEEyXiPYoLvUkwmCH+os3vNTedEj1f0S84hrNhfaAkxtOe0CCRxZrMnv/aqh0z67MHoB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW00FVbl/y5qx+H96C8+Nmje7d1SQ2ueap+6YXwsrSM=;
 b=YEUcm0ltRhveWXHoFq9McYzfq42weL1VJw+kKeHzgA+c9ecDbgtJzSoHr89heyfZL6g5NaWCS1p663Bej0LdEX1uRovLIHoLZtuvrEp39kBjVhGDHsb5wuQNGwkOGKPARcDki+MlApFdHXS5cXFkWpDDmj/nH1HWsTzMO3MqFe2nlscsashWYHB6TpfffZAIXAWsbC2WQQDLTb9BT5QBykbhPEIn5hg1pDZ/NehlJnYvormD/M+GVmiVyglIpo1aqxPK6fBbQ9UzmMGX+tUMbgpLiVkNqC7GC3x+R/o2T2UtXk+lUhrd1IhKrU33XMd/7V02C4Uqbx0WRANJ2/1g3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW00FVbl/y5qx+H96C8+Nmje7d1SQ2ueap+6YXwsrSM=;
 b=ySitcYXeWaxRFf5HbBuGaqS/D15FrMfskrhWPhbIL8elU2wh/NRzZPDmnN2+icbeon3QWRgI/TGIzl9c6oUVeaVfeU8cpZyh5UcSqist2jWLZK9I6wHSWfvNyU8qYRPrCfxTNuRFuP01FDf6tr8xjRnJLCCz4fDtafkJexhY+pI=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SJ2PR10MB7040.namprd10.prod.outlook.com (2603:10b6:a03:4c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Tue, 13 Jun
 2023 01:42:07 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:42:07 +0000
Message-ID: <3191c739-7505-f3a4-cde0-203b4fca4a42@oracle.com>
Date: Mon, 12 Jun 2023 20:42:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 17/17] vhost: Allow worker switching while work is
 queueing
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
References: <20230613013248.12196-1-michael.christie@oracle.com>
 <20230613013248.12196-18-michael.christie@oracle.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230613013248.12196-18-michael.christie@oracle.com>
X-ClientProxiedBy: CH0PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:610:e7::24) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SJ2PR10MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eea0b42-e0e9-4906-7e8c-08db6baf6584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPsww0jiXbHXmCq7wrXoZrDsQinUkFUHlwYrJlCEeJnZotccqPqIKk/QqoHkxAkkEfy+cDgcTd0YLe/dNb/13aRaeMkx5+SMcoUgf/PZyiljW/WWT9NdfCRkAuH9lQFyve+KNtbyzakVmnkRdv6K4LZW/uBY751P0k9O78QTmNcP/mVL0GwbVAFBDowqlTvsQRwoRGUfTvI2LAqncwytYPnIg8ycySLgnkIBIjAvF0yW0orK8hMq9wuqDskUw1vrx3+cP+XtnZDb26ubUqm6wIKJvLLgyQj5yUrk8C92mNL8mssEwS7haueY/Vqv+SraV5s4xL9reedNsmbp/lHDrKNpiDHopjm6xESMTiEjPpde+YarPB13Jmw4qwjaVHcZ/mV6xUmjjd0E4nxzm+gezkHpki8RYGsOfIEishH83gONKzYkgmQLxSg7X3oDlKO/MplpxXAUfYYm6RuCn9DRGFSTuMu06kd3xaDXKAa/HvIVbrKGzwRlnlVT5kZQy6ce5oSI6wgjUnd4UhXb/ifOuzNx/RCuxzHQZQBbpK0iv5uz9yYhDMgx/hOzM6VFoOnDlhjYRlapj5n/yfi9YPEdny3/PIOWiZRWFbiFEIpNJVYbJeVevWaTUoQl5XgIqbJYqgiAAw+S8lwiO5KGMjZtQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199021)(66556008)(66476007)(66946007)(36756003)(8676002)(5660300002)(478600001)(31686004)(8936002)(316002)(6486002)(41300700001)(38100700002)(83380400001)(53546011)(26005)(6506007)(186003)(86362001)(31696002)(6512007)(2616005)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWE0akRJT2w5YVM5VkFiTGFUVGo1a2IrYXp2c3ZXZXN4a3R5RWI4SHR5MmJU?=
 =?utf-8?B?U3k5YlhTSms3NVIrY0ZvcEtpL2RqNVZrMFVWQk84cXZkUXZTQW9LM3IzVHFH?=
 =?utf-8?B?NUdIcVNtSHgzdExkT2wxZ0hYb0NTQjdQUis4d0wvMFBkSTVnQTRmR1hLRGVy?=
 =?utf-8?B?VGhVY2drTHZUVmZzQ3dHYkJhV1o0STNWQithRG82ekZCUXBRazluenFDSTE0?=
 =?utf-8?B?L0lDNHhRa0l3ekZnSmRncHdSWk1kNitWSkgzNFA5aUV2U2FtY0JwNG05cVFp?=
 =?utf-8?B?UFlwcEY0ZXVHYWZVNTZMRW5QV1NyWUlic2FZVlVlaGIwbmJWNUdUWkduRm9I?=
 =?utf-8?B?RVptOTNRMGhDY201Znl6cmdreDU0cS8vLzloMVY0VXFlckZibW9zVkZYUDVZ?=
 =?utf-8?B?UXR0VWlNdkMxVDZwRmRmdFh2NkJaVlVkcmxQNXlFYzVkRFdRQTVCa0lnZ3E3?=
 =?utf-8?B?TllZZHdMTC85Rm9OcnRsTytHZkFkdXlYd05STk4wUkZwZVNBdEpqVXRYSWk1?=
 =?utf-8?B?L3plVWpJYnNnQ2xmTWdvVGk3OTVuQ2M0dnhJZGJHOGhBaVJGL1VoaWRJTGlC?=
 =?utf-8?B?ZTBObzNtc3RydVhxMzFjMm1yWE02WFVlWmZwaEVnRHB3QTFjMm4zc1RFdUVN?=
 =?utf-8?B?UFhETTRVNU9TVmFvdnI5eUNBMmc3MFhaQ0xkOHJTK1NpcTVHVkhTVW5NYU1R?=
 =?utf-8?B?eExabDlqWEZKbElYdDdweWtjeTludmxrR3FtS1ZTT283a0xhd3VtZjhRNnJN?=
 =?utf-8?B?eUFwbkFST0NuQks3ZHVsZVgxQ2V5RDA2RWVlUXVuYWVQcUx0cUNWUTJBMElw?=
 =?utf-8?B?NTF5dWtDM1BtWGJBSTZzN2hEQ1psWGR1aFJnak4xQlNYUDBTYmpDSUNEamt1?=
 =?utf-8?B?TEZMcHFLMWdwMTkvMmNibDNDVm1XaGI4L2FXWDNwR0FxZ2tCem9DcHNJdkNn?=
 =?utf-8?B?dURqUzFiSnowbkJ4TEkzUWpHWnI0U3p4VndYYWRJQ2Nyc1daYXRyOFVGNUFz?=
 =?utf-8?B?R3p5cU82c2xrOWE0MXcxenlLTXBPS0NNdGQrT09rM2R6Qk1oUGtkeXVoZXBY?=
 =?utf-8?B?Q3kxdjVPNEMwOXFtNjNFLzh3ZUo0TW52WG84SGZVb3BxN3pJcVdBeDRLbWFS?=
 =?utf-8?B?aVlWcnJaRmhiTHB4ZFF6MXRXNVUzSWhGR2hpTmxKUWJNb0xkNXVtSC8zeDVz?=
 =?utf-8?B?SHE2bHNvZjB3VjRjVkRlTGZFSUZwRXFwU051WTlFNzNTSUlRM2ZMUmFQZEFM?=
 =?utf-8?B?aWNCM2ViNXh0VUJOSmVFajBTU2RibEpHTUdVYms0ZnJCaHpTNzZ1ZEFyVFhv?=
 =?utf-8?B?NXZzOWkxVUFBRjBXck5LczNwWTYzSmwyZ2J3dS8xR09tWVI5NE55TUUrdzBh?=
 =?utf-8?B?TFFiTVdJeC9QKzUxWWRZRkVkcVZ0b2N2eVZndkw4WHh3SmV5QjhRSnpOVlZn?=
 =?utf-8?B?Y21abkowZzhtT0ZrWnpXb1pRdXJMWGlMeHIzRjFpZEpKRi9nMDlCcTJGWkdD?=
 =?utf-8?B?NzFLcjY2b2VsZWdta0dncmxrbW1LWHA1cm1GWVYrcGx5QXFYRGpVcEJqQW94?=
 =?utf-8?B?eDc5MVorNlR4TkhnMFlRNE9DdytVdEQ3YkxYVEpXd3BzVTBqREY3TTV6ZGMz?=
 =?utf-8?B?cXdYdTdQTWtEMGZrdDNwUmM1RmN0bHdHY3VoSFdDWDE0bDg3ZnBZSHdXak4x?=
 =?utf-8?B?dGNLV3JVVER0RXprWHBiOTZDdVM5RDc4MWdXU0JuOWNTanVCVFJUdHNWNVht?=
 =?utf-8?B?STFEODYzSlV0ZUFQWUh3RUNVQ0pXTGJEM0VOb3VGYVl4aEJoQnl4VEl0d09P?=
 =?utf-8?B?eE8rTlRZZ1hVT3BpMk0vcXR5TGoxU2U0OGtibG8velRpTStXWkdiTm1GSWU2?=
 =?utf-8?B?QWdvMnlqWnR1M1J3L1ZCSHNmSHNEVFZKMmF3cmFiZTRteHRjd3VlbEtyTExp?=
 =?utf-8?B?cWUzdHluQVM1K2M5UGR6QkZjNm1JeGNFOXBxWTdtV0FTU0FSdXlTeFc0Skdz?=
 =?utf-8?B?WWxnRDN0RXFPQmEvUWFkMEV3RUYrTUFuaG1qeHRRdjlrWU9rWjJHUGF3eGo0?=
 =?utf-8?B?Tm1tQno3UkdRYXZrRC84VjEwQUhhRUFvb1ZBN3lWZzZYUHhUYlgxWlprWk12?=
 =?utf-8?B?alRxbzJhYkQ4T05LZHFzUkZsY3lKdW1lTGNKTDJtLzREVnQzVkVPLzg5UU1w?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SpK7F2PiyIwE6lvWZlHVC/O0tsLnEoAVthSnhEv21gBZaTWZ0V9gv6+2fuQhqhUXndewYleRea7GheSQM86cH+fKw2bAzyXJ+kYnAwozuE9vtckaQyG3eeO/vRPGjXduvK2LtyRbSf3JB5sea06GpQT+KcAKjkBfbWTihkaRS6Uf39iZHJYTBeVprkVdyjwv4QOoTaPJNzc8GCsVm0u5zs4gazlBcnrGYFO7gutwa43R7Jqo9uzMg8EPSlf16GDws3Ok3ojrlIGW+fpm5WFfhyYcEfjkZ9n6o3VSGwnTSiszkmpuOxKPa16v5Rl+zF7F8yxqOz5yH2TsbTr588UTr2InEjSdnLLJCteDkJpW25I2Z1WWULKFXfEFjMWglEZbtV0xNy7tEo4v+IgyIwvP1pLwoEdNh7LxkHvRLxsE3WyO5peGlg7WAyvnWiUUZ9w+EIieR/dM3Ymom71KD1I842htYPxBcmlB8Esfd5bpSe+m9YBUVwg3UH1THhR/6Qpsi3Fct9C+GI07W3uwv5NicqkYLpJN7+wRmcseTozVKpJkuyDCoVJ07h+2xyFAvsRx6g4/s/Q7W2217ahVHqHp3HJjtHSis2NQ/3uyTnSyAp3CiXHKwpLU0R9Yo4y2rVjh9SIKR6Evswvrb7f6e0M7QbSJgy19MeYxWhIBH1Y8liSFwrVnYnb1cs7V9d8frxFDmnQhMztJWuJnryXWgcSS9iOWJ+N3vcYfO83tKFmYOOXnTqfO6YcSpmCxcAYscvEKkATOmtY57zapEXp6ihoGj/KS3r98l/Doit0eY+O6s8mFVuk0CzQXuX/vDKiFWQdt
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eea0b42-e0e9-4906-7e8c-08db6baf6584
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:42:07.1057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoi6cN78WtjrpW1oL6iqfAheT466+YBElaCiy8QOh3AXc6wf8iF7fHEntBCc9OJWmSdlWrzzH1DzoNDg36RO2YeGcKUeDL+NcH0mL0kGJ4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=644 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130013
X-Proofpoint-ORIG-GUID: qAHvr35x4uhO84sfOF_kdEe2n_8A_5mJ
X-Proofpoint-GUID: qAHvr35x4uhO84sfOF_kdEe2n_8A_5mJ
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 6/12/23 8:32 PM, Mike Christie wrote:
> This patch drops the requirement that we can only switch workers if work
> has not been queued by using RCU for the vq based queueing paths and a
> mutex for the device wide flush.
> 
> We can also use this to support SIGKILL properly in the future where we
> should exit almost immediately after getting that signal. With this
> patch, when get_signal returns true, we can set the vq->worker to NULL
> and do a synchronize_rcu to prevent new work from being queued to the
> vhost_task that has been killed.
> 

Hey Jason and Stefano, just an update on why we now have this extra
patch.

Jason, in one of the last reviews you were asking about supporting
switching workers when works are queueing and I had said it's probably
not worth it, because it adds come complexity that might not be used.

Stefano, it sounded like you preferred RCU to handle when we are
adding the initial worker while vsock is possibly queueing works.

It turns out the signal/fork developers added some hacks to their code
for the vhost_task patches to support SIGKILL but I think they want us to
eventually remove them. To do that, we need a way to handle where the
vhost_worker/vhost_task exits while work is being queued. To do this we
need the same as the above (instead of a new worker it would be NULL
though).

So to handle all these requests, I ended up adding this last patch.
I wasn't sure if you wanted it to go in at the same time as the
initial multiple worker patches since it changes the behavior the
interface can support or separate when I fix up the SIGKILL code.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
