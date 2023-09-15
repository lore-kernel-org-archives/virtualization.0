Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9B0EE3F01
	for <virtualization@archiver.kernel.org>; Fri, 15 Sep 2023 05:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E233783B67;
	Fri, 15 Sep 2023 05:38:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E233783B67
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=CmjkYcJ7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=xxAmWGSk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZXVBlHyMdrk3; Fri, 15 Sep 2023 05:38:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2276583B5A;
	Fri, 15 Sep 2023 05:38:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2276583B5A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E703DC0071;
	Fri, 15 Sep 2023 05:38:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0E38C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 05:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 842B3612D8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 05:38:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 842B3612D8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=CmjkYcJ7; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=xxAmWGSk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QOxiQTU9QirH
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 05:38:42 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F39EC612D4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 05:38:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F39EC612D4
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38EKxYfV029176; Fri, 15 Sep 2023 05:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ITQvj/Zuan8J1FOOcUBsRWC5tJSttqrj5Wsp8mG5p0Q=;
 b=CmjkYcJ7eMtxlAiPtPJGo1833MgHV4qcLkfXzk8B6Dwf6HiKdj4zh1mcSB9rsKyrSafi
 TfmaJqiDbvIzoI6mHke5ZqSMGpRLGnqOQZaYmtAjd1scGMh8tzPG5JsOJB+lup1DbJX1
 pQjEmXBy6qvhxKcql5hQNrVx143rE91ZAr8soEdHv/1gc0NqYOqsVYaZ4NOtNVYTha1z
 qkd3Eox0MpDaBjSxHhzZndsOAowqOpLF7AUEZ+HAaYHgUQ7qGJmXJAOFeokiGa10dRrc
 7TTCRtlYbQts33Vp4ioHE3/pUte56Ka9VFOlg2/pFQ5HDIkZ8OsnNY6znR2UcUZD/KHI 3g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7rf3x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Sep 2023 05:38:29 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38F3H9mw030288; Fri, 15 Sep 2023 05:38:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0wkjxd6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Sep 2023 05:38:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHn1iTlkuOxijaEyxiXrBb7n9i5yjm+34oKi0tj+gUxTlSCWC85oREK36y9OUWKNeGCAwva4kt4mwNzednKE8R2wIUIbCfXCN2PIvxi+uMv3zjy2FpJcQtFrbsMJGGR0ECHZ0Bd5eT9cRYRU6yjK1uVZIclyWBu+0yrpVFOFz7FF6cPzGh5+Bz4OPM8SqVAck1btPagBAVG5QryITPlqig9ItrHsm+KMIMBv4WEpzdJojOPeN+DP562+0mjFQp/YlLSXX4oWTSCrJt9Y5YKfaobiWS46JlNjFanOyV4NQiAcHHcmEKBiV9kSzDN/Pn7F5XqnHu82YLNLAGKI8IxxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITQvj/Zuan8J1FOOcUBsRWC5tJSttqrj5Wsp8mG5p0Q=;
 b=OQRAYc9bK5c7MQu3GzLGTpIZtNIkTrbp5hSuRziWqLzg997/M9ch8qZZVoVX7WI7Z9Z0kVCbv8i74pnPAWw2n2rCXOhfTZiUMVV2+oJCJYX+bvVgIRY2cFh2dx4QHYVhI0flpUyXL+N/91P0UcMNM2DiVteIeJAgpNwS1X8lMoOYz9yp7fyudKD2Q6iS09SbHalbG5mkl79PKBBxkJlti5EIeOCdhCkxbD9iPegvtv84m4t+y2VwSrFkatkeawyDPIoCHkiJMHWOydBUsni4ld/u7YWUo2I0CCRNGjUTZ/WLnNtnH0iGcw28gVf0EMdRfcY1IO/5Pf1RUX+Skv5mUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITQvj/Zuan8J1FOOcUBsRWC5tJSttqrj5Wsp8mG5p0Q=;
 b=xxAmWGSkHkaF8Htyl1ZperCGX05Y9MJiBgfatk3kRBo9bNSmH60Lv4J7LN+YKmihlrnniMfO0Xv43G4ZbcPvthVsW6AvJpeBkMrZOMGqvNZlevgnwXa2g63qkqWQRzkS4q9ywY+gDSu1sX6bNDzlWi/o/sOu8TUVXWzViFJz5AU=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SN7PR10MB7076.namprd10.prod.outlook.com (2603:10b6:806:329::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 05:38:10 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 05:38:10 +0000
Message-ID: <00673fc0-7afa-a546-9dcd-08c0c4228acb@oracle.com>
Date: Thu, 14 Sep 2023 22:38:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RFC v2 1/4] vdpa: introduce .reset_map operation callback
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <1694266319-32287-1-git-send-email-si-wei.liu@oracle.com>
 <1694266319-32287-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEsACZcKQr9BGB0FzqJQbpfu9QTsh3hTxLaJ72on+3pK7w@mail.gmail.com>
 <c73cf75a-00bd-a0d9-90cf-7ad3ab76977c@oracle.com>
 <CACGkMEvP7jLHtGavU8PGmfL7k1nE39jP8zBfQY4jnAcpDZSV0g@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvP7jLHtGavU8PGmfL7k1nE39jP8zBfQY4jnAcpDZSV0g@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::20) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SN7PR10MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: e64fe543-d025-4751-d3c9-08dbb5adf27f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8AqWvAFmrzcN8obVSigxeSnognKxbTgWWE7Ua0OP6A9tqKQgFTWQX0Zdfb7MrT/+dm6PN5EJmUAX9AVReoXM+b54iR/TyrkAZUzBZgC5JAPiYmGzEtsv93N6IkGT+X6SZOWFv/tGobkXV5ZqIL3JYppQfDDwpRn67HzJ8yA4CNWY4fu/17JEayp4tQDyVbtYAM+56zEYyMD/otsRyowXApPOtl3H9U9MulHHz9zuGeI8rFfzs6YGKQKQAOjCthUDGfqYDB2Bp29PvU0mjjByyYV0fl1iJySsv0/thZd52kxTeVrPxAtawk03dQ/n4x4/F9lZ96Eh4dPCZDavrSl/agehdVGWm/PpyMFlttn+hGLmPrA/ag5ZCytBdnKO5TX7B7FrHzH+Ajpxlsr1rODwqiP5/OHGiQo7ZfWTGw0NbYRPYTpvsXbUKen4VL9vTKhGqQImX/gFKOoCBGERzcm8cKgBL1lW1v15OQPvR8256oSPmgjQzz2C4YWdQDsbywr2SWkONkbyRRoPnKH0UUEqygQNJhAF5ydLSzWnAx1E+Vpxf4aGFGF4KeZw+/q3R7Ixv+lUG9yUo9bf3zj32hL3glOVWrqXEiiUnvndEE6DRjTSkPvijMR4wV1ddqWrAb+uUTJEQ3QyGSfrjWpv+RDnQot0IJUAQU9r5B/xWflSMlY5+L8hxlBhTY+lBR1KQMNw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(1800799009)(451199024)(186009)(478600001)(38100700002)(31686004)(83380400001)(2616005)(6486002)(6506007)(26005)(8936002)(6512007)(66899024)(36916002)(53546011)(6666004)(2906002)(86362001)(31696002)(8676002)(5660300002)(4326008)(66556008)(6916009)(66946007)(66476007)(41300700001)(316002)(36756003)(142923001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWdpeWxtMXNpaWlTNndXU2RRZ0NoWVhYWHBTQ3ZwNllmUWthV0Q2MWZrZGZ1?=
 =?utf-8?B?WkJsZ05DYzg3TGhqc1dVQ250VU5kVXUwMTRDeGVKcVp1dXQxSFlWRE91UVpr?=
 =?utf-8?B?NG5NdDhyb01pMnJWOU15M2w0VVZUdGYxNUV5WXlLVWppeVpvd05vVkYyVkd6?=
 =?utf-8?B?QW1qUjE4T2hKRjV0RkoyUitXRzBwR3hFOVhhb1dXN1dXdkZ6NUxhS0YydGF6?=
 =?utf-8?B?N01lcHVNbktkc0IwWHV1Qm11eHV5RW9YcnpkcUEzOU5sU0N4bUtTcDZXdEF5?=
 =?utf-8?B?ZGNQVGE3bjFVdVdrb091RmRqZjk1SzBDYjlPYTlzWWo1bThWK3M3eEdQZWNh?=
 =?utf-8?B?RllyK1VpWUFKNU5LNURpbTU0MkkxZkNnQkVNbzUyR3RlRzNCSTQxbk1DRm1U?=
 =?utf-8?B?QXErbEVraUx5SGg0bk4xUU45KzFpR29PTUhRQzFtUVI3NlMraVc4TlJsTEEy?=
 =?utf-8?B?OFlIVmtSNVdRMEhuWlNraC9mREJKQ3dGaDRLMkQxZWhpWm9NeG1PWUZzblA4?=
 =?utf-8?B?bytwbk9JUTBWZWk4dDYzdllkejZ6eFdSYjRjZ1QzVnl6dU4vTXFLZUZSZ0M5?=
 =?utf-8?B?V0t0bThyY20zdXllNEpBdXBDckk0ek9LMVNiSmIrMUluT3NJTlV6Y0Vlb1hx?=
 =?utf-8?B?WkcxY2tvZllxNjZ3VXZjWTJicFJTMVNka3Zsa080ZVRWOEE1NG9yc0UrY0I5?=
 =?utf-8?B?VXlrY0MxSUEwc2FVWGZMSFFURUxuSXpaY0tJbG9sMW9YdnVkRkoxd3g2WGxx?=
 =?utf-8?B?SURhcCttSlN4bmdwTFVqWGlPNzhsMUNadGNDaCtNUnVWek1POW4vQlJ6WnBT?=
 =?utf-8?B?VEZRVGlEZzlCYmJSdVEvdUNlbjZ5b0dmbFBoRUp0QXJJcVVKV3JJS29LcVRK?=
 =?utf-8?B?TlNjSTdMUHJUZzF3emRVc0d6alJESWdtR0l5WVI1dUwzSTRISXFWMnFETHU2?=
 =?utf-8?B?TXJTK042Q0pETEtPbFMrUkprQS94SmVUalpCdTlta3AvSFpkMHJibVlTUStI?=
 =?utf-8?B?TVdHYlZ6b0NNNmZ2NG1tOCthdElRWGVUbVlLSm93dGlRaXZtaVlpSVk3TndY?=
 =?utf-8?B?NUhhUHl2Qzd3a2QwOEZWdDI2anh3VFp1aEFPZjRtdEVJTkl4aUZaekdPTlRE?=
 =?utf-8?B?Y3AxcWF6ejlEVHhuMnM5OWVLSlVwdkVIT3JLeDFVOU9mR0F1NzBrdDhVN2RB?=
 =?utf-8?B?aDRaU1FTelMvWjRRbnJlaFIyVDJaWnVtSmlLZDRhZGRNcDVvY0FiNTFuanZW?=
 =?utf-8?B?djk5Y2tacVZqY0VtRGpLSkUzd3BsU2xXOFV4aGZNdVJyM1dDWlJQMGhJZFN4?=
 =?utf-8?B?OVhReWZBNzZZZUY2b0FHWlZ6ZFRoZndOcEUvajZaQURtam8vYnZZNmhpRXlz?=
 =?utf-8?B?cG1GN21JWVIrV2p4RnU3TXRaVDhUdFFLZWwxUDRZWlFXV00vTlhQRS9OTTYz?=
 =?utf-8?B?b1c2aFpTcEpjL25lVDduaGk2K1pPRDRudUo3aUE5MWl6V01YaVowYk9WaWRS?=
 =?utf-8?B?dDVBdGJPYitiQXA2SVU2Z2ZDRi9xcGI5UFhDZWNiZFNzSG5nektBajFPZ3Zq?=
 =?utf-8?B?d1JzYWg5b2JsVzFQc2c4cEJwaENxeDJBS1BsT0hjWm5oQUh2R3lDV2YzQlE1?=
 =?utf-8?B?WFl0WUdXOUFYWmdoZDk3Mi95bHV3UG1iaUtnaGpJZWpObDBJL2xaQlI4a29s?=
 =?utf-8?B?SXBHc08xM2RFR2wrTXdSdlFBTnljZVZ6cGtlWWw0QUVtMWJxVHFYR1JLVFdj?=
 =?utf-8?B?QlU4NExlZ1JzemxjUUw2ZkFBS3Q5VUwxRkZ0QnE1SmpFYXI5L0w2SURoNUxu?=
 =?utf-8?B?eWlJUDZ6RkcwSUEweHkxQXd1eW1qNlJrUTBGQ1daeklKT2pkaEZHY2UzbFZE?=
 =?utf-8?B?YUJvLzZoUGVOQ1NuV1M1Zjc1eDZwdFRPb2NEbVRXYVRtNGF5dDh1dHhZdDZs?=
 =?utf-8?B?Q0FkOEQzbi80Zis4NXZhbkRUeXlQaUFoY1JUNlNXUWxJUm4xTENxem52K2dz?=
 =?utf-8?B?aGdUc0ZEZnZObU9EalpEc3VhMm9XT2tJS0dFK0tuQjV5UGFvMXdMc3NBaTdG?=
 =?utf-8?B?REZGU3BJUUt4ZFFDeEFpSWFIKzAyVFlRcUJHQlZpOTYydStHbThwSGxoYndR?=
 =?utf-8?Q?BKQfNOBT/pc1xVTyN9/6n8789?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: d16ynKCQ43B5xcEwfGeRY0DG5wa2hdP9EwteTJeOQJF2yKn/V1jcsc57keiUcZkTppzv4lVEJvIW+b7BY6QpZJrn3fdVn1Q95af7j0cMWDjO2QW1tAj/0SrzsLInzzM5gmM6+fprq+G1nIKLqbh9PBWcwGrN49wscVuzzipZhKUQxii2SBzTBD0bQuG74K7MDyw49H4dGZt3AWQivdPS+zbsYGu+mzua2MD8ykuZwApxMtLGYbqL+iiMxeLn8+TmeD1AgiLqKrnWLJj8slzMbyTZaqynTHqhRVkTci9W6OF7IBXTJLycO4etCXHZnbzuGp12LsXNSsprMf2XVvZ566KIfUCOpYPDhasozP3fQLgohKDs7vBmJI1Z4oGuBKICtH3i4D0wYFzNsz7AdrZeoYqfSiSZrtUnUjwpyqfiwJFPTBh6Tajfr79IfDRV5QEe6VxHevDSGlClgETYoORSWuz7biSsH/eWdMwzkGwn/TWmnnU3GJ0divdMnTQuOVu+M5dT/+ywGsLGChy5K20DzzwrdJOfHmTCZNZ/wZSH4NPu7TBs5CnuTmfhuUXQFItlZxa0SfiiTz8F18WC1ub01srbHuWblEPv7fhn9+hbJ09javTVMMyIKMFdkcEW9gHZ4b0Ygap6F0pyfziXR67sJpUJlBy7TdPdN3SSYSLsvI5pOro5ukrGXMLuObkxMBoXgyjPPSkfDLP5ah+xXHtRSTzVCQd/32CwofUYFgNdkL2WDw/Kwp4k80LFdACA2xuWcx8lIwZeZ+kj9AIemvfQGz/RT6yURA1vLAx+uiCRjUbuRumw2E2t2ahXPMtXFYPg1YcXsjuWqdwGwGWmXcWGiW6pDP/s7HqEJrG/Pwmliv0NqQzDtbZoG7u4kQcji9SLQisAc6Fm9WSFRHJVyz2Svg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64fe543-d025-4751-d3c9-08dbb5adf27f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 05:38:10.7140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXmlJHfwl3Gw6f7xWf0bPA9wpNXcaps/+olqcWpB3qAWHq8cGJneMF+0PJGH1W2bYm1HUcBInHkF3UE9AMGN8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_05,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150050
X-Proofpoint-ORIG-GUID: z0LRMa39aRdK66kUOlU_z-1gIpFPkAvv
X-Proofpoint-GUID: z0LRMa39aRdK66kUOlU_z-1gIpFPkAvv
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 xuanzhuo@linux.alibaba.com, mst@redhat.com
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

CgpPbiA5LzExLzIwMjMgMTE6MjMgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4gT24gVHVlLCBTZXAg
MTIsIDIwMjMgYXQgNzozMeKAr0FNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4g
d3JvdGU6Cj4+IEhpIEphc29uLAo+Pgo+PiBPbiA5LzEwLzIwMjMgODo0MiBQTSwgSmFzb24gV2Fu
ZyB3cm90ZToKPj4+IEhpIFNpLVdlaToKPj4+Cj4+PiBPbiBTYXQsIFNlcCA5LCAyMDIzIGF0IDk6
MzTigK9QTSBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+IHdyb3RlOgo+Pj4+IE9u
LWNoaXAgSU9NTVUgcGFyZW50IGRyaXZlciBjb3VsZCB1c2UgaXQgdG8gcmVzdG9yZSBtZW1vcnkg
bWFwcGluZwo+Pj4+IHRvIHRoZSBpbml0aWFsIHN0YXRlLgo+Pj4gQXMgZGlzY3Vzc2VkIGJlZm9y
ZS4gT24tY2hpcCBJT01NVSBpcyB0aGUgaGFyZHdhcmUgZGV0YWlscyB0aGF0IG5lZWQKPj4+IHRv
IGJlIGhpZGRlbiBieSB0aGUgdkRQQSBidXMuCj4+IEkgZ3Vlc3MgdG9kYXkgdGhpcyBpcyBleHBv
c2VkIHRvIHRoZSBidXMgZHJpdmVyIGxheWVyIGFscmVhZHksIGZvciBlLmcuCj4+IHZob3N0X3Zk
cGFfbWFwKCkgY2FuIGNhbGwgaW50byB0aGUgIC5kbWFfbWFwLCBvciAuc2V0X21hcCwgb3IKPj4g
aW9tbXVfbWFwKCkgZmxhdm9ycyBkZXBlbmRpbmcgb24gdGhlIHNwZWNpZmljIGhhcmR3YXJlIElP
TU1VCj4+IGltcGxlbWVudGF0aW9uIHVuZGVybmVhdGg/IFNwZWNpZmljYWxseSwgInN0cnVjdCBp
b21tdV9kb21haW4gKmRvbWFpbiIKPj4gaXMgbm93IHBhcnQgb2YgInN0cnVjdCB2aG9zdF92ZHBh
IiBhdCBhbiBpbmRpdmlkdWFsIGJ1cyBkcml2ZXIKPj4gKHZob3N0LXZkcGEpLCByYXRoZXIgdGhh
biBiZWluZyB3cmFwcGVkIGFyb3VuZCB1bmRlciB0aGUgdmRwYSBjb3JlCj4+ICJzdHJ1Y3QgdmRw
YV9kZXZpY2UiIGFzIHZkcGEgZGV2aWNlIGxldmVsIG9iamVjdC4gRG8gd2Uga25vdyBmb3Igd2hh
dAo+PiByZWFzb24gdGhlIGhhcmR3YXJlIGRldGFpbHMgY291bGQgYmUgZXhwb3NlZCB0byBidXMg
Y2FsbGVycyBsaWtlCj4+IHZob3N0X3ZkcGFfbWFwIGFuZCB2aG9zdF92ZHBhX2dlbmVyYWxfdW5t
YXAsIHdoaWxlIGl0J3MgcHJvaGliaXRlZCBmb3IKPj4gb3RoZXIgc2ltaWxhciBjYXNlcyBvbiB0
aGUgb3RoZXIgaGFuZD8gT3IgaXMgdGhlcmUgYSBib3VuZGFyeSBpbiBiZXR3ZWVuCj4+IEkgd2Fz
IG5vdCBhd2FyZSBvZj8KPiBMZXQgbWUgdHJ5IHRvIGV4cGxhaW46Cj4KPiBzZXRfbWFwKCksIGRt
YV9tYXAoKSwgZG1hX3VubWFwKCkgaXMgdXNlZCBmb3IgcGFyZW50IHNwZWNpZmljCj4gbWFwcGlu
Z3MuIEl0IG1lYW5zIHRoZSBwYXJlbnRzIHdhbnQgdG8gZG8gdmVuZG9yIHNwZWNpZmljIHNldHVw
IGZvcgo+IHRoZSBtYXBwaW5nLiBUaGUgYWJzdHJhY3Rpb24gb2YgdHJhbnNsYXRpb24gaXMgc3Rp
bGwgb25lIGRpbWVuc2lvbgo+ICh0aG91Z2h0IHRoZSBhY3R1YWwgaW1wbGVtZW50YXRpb24gaW4g
dGhlIHBhcmVudCBjb3VsZCBiZSB0d28KPiBkaW1lbnNpb25zKS4gIFNvIGl0J3Mgbm90IG5lY2Vz
c2FyaWx5IHRoZSBvbi1jaGlwIHN0dWZmIChzZWUgdGhlCj4gZXhhbXBsZSBvZiB0aGUgVkRVU0Up
Lgo+Cj4gVGhhdCBtZWFucyB3ZSBuZXZlciBleHBvc2UgdHdvIGRpbWVuc2lvbiBtYXBwaW5ncyBs
aWtlIChvbi1jaGlwKQo+IGJleW9uZCB0aGUgYnVzLiBTbyBpdCdzIG5vdCBvbmUgZGltZW5zaW9u
IHZzIHR3byBkaW1lbnNpb25zIGJ1dCB0aGUKPiBwbGF0Zm9ybSBzcGVjaWZpYyBtYXBwaW5ncyB2
cyB2ZW5kb3Igc3BlY2lmaWMgbWFwcGluZ3MuCk9LLCBJIHRoaW5rIEkgc2F3IG9uLWNoaXAgd2Fz
IHVzZWQgaW50ZXJjaGFuZ2VhYmx5IGZvciB2ZW5kb3Igc3BlY2lmaWMgCm1lYW5zIG9mIG1hcHBp
bmcgZXZlbiBmb3IgVkRVU0UuIFdoaWxlIEkgdGhpbmsgd2UgYm90aCBhZ3JlZWQgaXQncyB0b28g
CmNvbXBsZXggdG8gZXhwb3NlIHRoZSBkZXRhaWxzIG9mIHR3by1kaW1lbnNpb25zIGFuZCB3ZSBz
aG91bGQgdHJ5IHRvIAphdm9pZCB0aGF0IChJIHRob3VnaHQgb24tY2hpcCBkb2Vzbid0IGltcGx5
IHR3by1kaW1lbnNpb24gYnV0IGp1c3QgdGhlIAp2ZW5kb3Igc3BlY2lmaWMgcGFydCkuIFRoYXQn
cyB0aGUgcmVhc29uIHdoeSBJIGhpZGUgdGhpcyBzcGVjaWFsIGRldGFpbCAKdW5kZXIgYSBzaW1w
bGUgLnJlc2V0X21hcCBpbnRlcmZhY2Ugc3VjaCB0aGF0IHdlIGNvdWxkIGVhc2lseSBkZWNvdXBs
ZSAKbWFwcGluZyBmcm9tIHZpcnRpbyBsaWZlIGN5Y2xlIChkZXZpY2UgcmVzZXQpLgoKPgo+PiBJ
IHRoaW5rIGEgbW9yZSBmdW5kYW1lbnRhbCBxdWVzdGlvbiBJIGRvbid0IHF1aXRlIHVuZGVyc3Rh
bmQsIGlzIGFkZGluZwo+PiBhbiBleHRyYSBBUEkgdG8gb24tY2hpcCBJT01NVSBpdHNlbGYgYW4g
aXNzdWUsIG9yIGp1c3QgdGhhdCB5b3UgZG9uJ3QKPj4gbGlrZSB0aGUgd2F5IGhvdyB0aGUgSU9N
TVUgbW9kZWwgZ2V0cyBleHBvc2VkIHZpYSB0aGlzIHNwZWNpZmljIEFQSSBvZgo+PiAucmVzZXRf
bWFwPwo+IGV4dHJhIEFQSSB0byBvbi1jaGlwIElPTU1VLCBzaW5jZSB0aGUgb24tY2hpcCBsb2dp
Y3Mgc2hvdWxkIGJlIGhpZGRlbgo+IGJ5IHRoZSBidXMgdW5sZXNzIHdlIHdhbnQgdG8gaW50cm9k
dWNlIHRoZSB0d28gZGltZW5zaW9ucyBhYnN0cmFjdGlvbgo+ICh3aGljaCBzZWVtcyB0byBiZSBh
biBvdmVya2lsbCkuClRoYW5rcyBmb3IgY2xhcmlmaWNhdGlvbnMgb2YgeW91ciBjb25jZXJuLiBJ
IHdpbGwgcmVwaHJhc2Ugb24tY2hpcCB0byAKInZlbmRvciBzcGVjaWZpYyIgYW5kIHRyeSB0byBh
dm9pZCBtZW50aW9uaW5nIHRoZSB0d28tZGltZW5zaW9uIGFzcGVjdCAKb2YgdGhlIEFQSS4KPgo+
PiBGb3IgdGhlIHBsYXRmb3JtIElPTU1VIGNhc2UsIGludGVybmFsbHkgdGhlcmUgZXhpc3RzCj4+
IGRpc3RpbmN0aW9uIGJldHdlZW4gdGhlIDE6MSBpZGVudGlmeSAocGFzc3Rocm91Z2gpIG1vZGUg
YW5kIERNQSBwYWdlCj4+IG1hcHBpbmcgbW9kZSwgYW5kIHRoaXMgZGlzdGluY3Rpb24gaXMgc29t
ZWhvdyBnZXR0aW5nIGV4cG9zZWQgYW5kCj4+IHByb3BhZ2F0ZWQgdGhyb3VnaCB0aGUgSU9NTVUg
QVBJIC0gZm9yIGUuZy4gaW9tbXVfZG9tYWluX2FsbG9jKCkgYW5kCj4+IGlvbW11X2F0dGFjaF9k
ZXZpY2UoKSBhcmUgYmVpbmcgY2FsbGVkIGV4cGxpY2l0bHkgZnJvbQo+PiB2aG9zdF92ZHBhX2Fs
bG9jX2RvbWFpbigpIGJ5IHZob3N0LXZkcGEgKGFuZCB0aGUgb3Bwb3NpdGUgZnJvbSB3aXRoaW4K
Pj4gdmhvc3RfdmRwYV9mcmVlX2RvbWFpbiksIHdoaWxlIGZvciB2aXJ0aW8tdmRwYSBpdCBkb2Vz
bid0IGNhbGwgYW55IElPTU1VCj4+IEFQSSBhdCBhbGwgb24gdGhlIG90aGVyIGhhbmQKPiBJdCdz
IHRoZSB3YXkgdGhlIGtlcm5lbCBtYW5hZ2VzIERNQSBtYXBwaW5ncy4gRm9yIGEgdXNlcnNwYWNl
IGRyaXZlcgo+IHZpYSB2aG9zdC12RFBBLCBpdCBuZWVkcyB0byBjYWxsIElPTU1VIEFQSXMuIEFu
ZCBmb3IgYSBrZXJuZWwgZHJpdmVyCj4gdmlhIHZpcnRpby12RFBBLCBETUEgQVBJIGlzIHVzZWQg
KHZpYSB0aGUgZG1hX2RldiBleHBvc2VkIHRocm91Z2gKPiB2aXJ0aW9fdmRwYSkuIERNQSBBUEkg
bWF5IGRlY2lkZSB0byBjYWxsIElPTU1VIEFQSSBpZiBJT01NVSBpcyBlbmFibGVkCj4gYnV0IG5v
dCBpbiBwYXNzdGhyb3VnaCBtb2RlLgpSaWdodCwgSSB0aGluayB3aGF0IEkgbWVhbnQgaXMsIGRp
c3RpbmN0aW9uIG9mIG1hcHBpbmcgcmVxdWlyZW1lbnQgCmV4aXN0cyBiZXR3ZWVuIHR3byBidXMg
ZHJpdmVycywgdmhvc3QtdmRwYSBhbmQgdmlydGlvLXZkcGEuIEl0J3MgCmltcG9zc2libGUgdG8g
aGlkZSBldmVyeSBkZXRhaWxzIChpZGVudGl0eSwgc3dpb3RsYiwgZG1hcikgdW5kZXIgdGhlIApj
b3ZlciBvZiBETUEgQVBJIHNpbXBseSB1c2luZyB0aGUgSU9NTVUgQVBJIGFic3RyYWN0aW9uLiBT
YW1lIGFwcGxpZXMgdG8gCmhvdyBvbmUgZGltZW5zaW9uIG9yaWVudGVkIHZlbmRvciBzcGVjaWZp
YyBBUEkgKCAuZG1hX21hcC8uc2V0X21hcCBJIAptZWFuKSBjYW4ndCBjb3ZlciBhbGwgY2FzZXMg
b2YgcG90ZW50aWFsbHkgbXVsdGktZGltZW5zaW9uYWwgbWFwcGluZyAKcmVxdWlyZW1lbnRzIGZy
b20gdmlydGlvLXZkcGEgKHdoaWNoIGlzIHVzaW5nIGEgZmVhdHVyZSByaWNoIERNQSBBUEkgCmlu
c3RlYWQgb2Ygc2ltcGxlIGFuZCBsb3dlciBsZXZlbCBwYWdlIG1hcHBpbmcgYmFzZWQgSU9NTVUg
QVBJKS4gSSBub3cgCmdldCB0aGF0IHlvdSBtYXkgd2FudCB0byB1bmRlcnN0YW5kIHdoeSAucmVz
ZXRfbWFwIGlzIHJlcXVpcmVkIGFuZCB3aGljaCAKcGFydCBvZiB0aGUgdXNlcnNwYWNlIGZ1bmN0
aW9uYWxpdHkgd29uJ3Qgd29yayB3aXRob3V0IGl0LCBvbiB0aGUgb3RoZXIgCmhhbmQuCj4KPj4g
LSB3aGljaCBpcyB0byBpbmhlcml0IHdoYXQgZGVmYXVsdCBJT01NVQo+PiBkb21haW4gaGFzLgo+
IFllcywgYnV0IGl0J3Mgbm90IGEgMToxIChpZGVudGlmeSkgbWFwcGluZywgaXQgcmVhbGx5IGRl
cGVuZHMgb24gdGhlCj4gY29uZmlndXJhdGlvbi4gKEFuZCB0aGVyZSBjb3VsZCBldmVuIGJlIGEg
c3dpb3RsYiBsYXllciBpbiB0aGUKPiBtaWRkbGUpLgpZZXMsIHNvIEkgc2FpZCBpbmhlcml0IHRo
ZSBjb25maWd1cmF0aW9uIG9mIHRoZSBkZWZhdWx0IGRvbWFpbiwgd2hpY2ggCmNvdWxkIHZhcnkg
dmVyc3VzIG9uZS1kaW1lbnNpb24uCj4KPj4gSWRlYWxseSBmb3Igb24tY2hpcCBJT01NVSB3ZSBj
YW4gYW5kIHNob3VsZCBkbyBwcmV0dHkgbXVjaAo+PiB0aGUgc2FtZSwgYnV0IEkgZG9uJ3QgdGhp
bmsgdGhlcmUncyBhIGNsZWFuIHdheSB3aXRob3V0IGludHJvZHVjaW5nIGFueQo+PiBkcml2ZXIg
QVBJIHRvIG1ha2Ugdmhvc3QtdmRwYSBjYXNlIGRpc3Rpbmd1aXNoIGZyb20gdGhlIHZpcnRpby12
ZHBhCj4+IGNhc2UuIEknbSBhZnJhaWQgdG8gc2F5IHRoYXQgaXQgd2FzIGp1c3QgYSBoYWNrIHRv
IGhpZGUgdGhlIG5lY2Vzc2FyeQo+PiBkaXN0aW5jdGlvbiBuZWVkZWQgYnkgdmRwYSBidXMgdXNl
cnMgZm9yIGUuZy4gaW4gdGhlIGRlZXAgb2YKPj4gdmRwYV9yZXNldCgpLCBpZiBub3QgaW50cm9k
dWNpbmcgYW55IG5ldyBkcml2ZXIgQVBJIGlzIHRoZSBnb2FsIGhlcmUuLi4KPiBTbyByZXN0X21h
cCgpIGlzIGZpbmUgaWYgaXQgaXMgbm90IGRlZmluZWQganVzdCBmb3Igb24tY2hpcC4gRm9yCj4g
ZXhhbXBsZSwgZG9lcyBWRFVTRSBuZWVkIHRvIGltcGxlbWVudCBpdCBvciBub3Q/CklmICJvbi1j
aGlwIiBvZiB3aGF0IHlvdSBzYWlkIG1lYW5zICJ0d28tZGltZW5zaW9uIiBvciAiaWRlbnRpdHkg
Cm1hcHBpbmciIGluIHRoZSBjb250ZXh0IEkgd291bGQgc2F5IGl0J3MgZGVmaW5pdGVseSBub3Qg
dGhlIGludGVudC4gCkluc3RlYWQsIGl0J3MgdGhlIGJlc3QgSSBjYW4gdGhpbmsgb2Ygd2hhdCBp
cyBhYmxlIHRvIG5vdCBleHBvc2UgdGhhdCAKcGFydCBvZiB0aGUgc3BlY2lmaWNzLgoKVkRVU0Ug
Y2FuIGltcGxlbWVudCBpdCBpZiBpdCBoYXMgc2ltaWxhciByZXF1aXJlbWVudCBvZiByZXNldHRp
bmcgCm1hcHBpbmcgdG8gdGhlIGRlZmF1bHQgc3RhdGUgZm9yIGJ1cyBkcml2ZXIgdXNlcnMgbGlr
ZSB2aG9zdC12ZHBhLiBUaGlzIAppcyBsZWZ0IHVwIHRvIHRoZSBWRFVTRSBvd25lciB0byBkZWNp
ZGUsIHRob3VnaCBmcm9tIHdoYXQgSSBjb2xsZWN0IHNvIApmYXIgaXQgZG9lc24ndCBzZWVtIGhh
dmUgdG8gZG8gc28gZm9yIHRoZSBtb21lbnQsIGFzIGl0J3MgZXhwbGljaXRseSAKdXNpbmcgRE1B
IG9wcyB0byBpbXBsZW1lbnQgc3dpb3RsYiBsaWtlIGJvdW5jaW5nIG1lY2hhbmlzbSB3aGljaCB3
b3JrcyAKbW9yZSBjbG9zZWx5IHRvIHRoZSBETUEgQVBJLiBBbmQgaXRzIHZob3N0LXZkcGEgdXNh
Z2Ugc2VlbXMgbm90IHBhZ2UgCnBpbm5pbmcgYmFzZWQgYnV0IHRocm91Z2ggc2hhcmVkIG1lbW9y
eT8gTG9zaW5nIHRoZSBwZXJmb3JtYW5jZSByZWFzb24gCnRvIGRlY291cGxlIG1hcHBpbmcuCj4K
Pj4+IEV4cG9zaW5nIHRoaXMgd2lsbCBjb21wbGljYXRlIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBi
dXMgZHJpdmVycy4KPj4gQXMgc2FpZCBhYm92ZSwgdGhpcyBkaXN0aW5jdGlvbiBpcyBuZWVkZWQg
YnkgYnVzIGRyaXZlcnMsIGFuZCBpdCdzCj4+IGFscmVhZHkgZG9uZSBieSBwbGF0Zm9ybSBJT01N
VSB2aWEgSU9NTVUgQVBJLiBJIGNhbiBkcm9wIHRoZSAucmVzZXRfbWFwCj4+IEFQSSB3aGlsZSBh
ZGQgYW5vdGhlciBzZXQgb2Ygc2ltaWxhciBkcml2ZXIgQVBJIHRvIG1pbWljCj4+IGlvbW11X2Rv
bWFpbl9hbGxvYy9pb21tdV9kb21haW5fZnJlZSwgYnV0IGRvaW5nIHRoaXMgd2lsbCBjb21wbGlj
YXRlIHRoZQo+PiBwYXJlbnQgZHJpdmVyJ3MgaW1wbGVtZW50YXRpb24gb24gdGhlIG90aGVyIGhh
bmQuCj4gSSdtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCB0aGUgaXNzdWUuIEJ1dCBzb21ldGhpbmcg
bGlrZSBQRAo+IGFsbG9jYXRpb24vZnJlZSBpbiBSRE1BPwpOZXZlciBtaW5kLCB0aGlzIHdvdWxk
IGp1c3QgZXhwb3NlIG1vcmUgaW1wbGVtZW50YXRpb24gZGV0YWlscyBvbiB0aGUgCnR3by1kaW1l
bnNpb24gKG9yIG1heWJlIG11bHRpLWRpbWVuc2lvbmFsKSBtYXBwaW5nIG1vZGVsIGFuZCBhbHNv
IAppbnRyb2R1Y2VzIG1vcmUgY29tcGxleGl0eS4gQ2VydGFpbmx5IG5vdCBzb21ldGhpbmcgSSdk
IGFkdm9jYXRlIGZvci4KPj4gV2hpbGUgLnJlc2V0X21hcCBpcwo+PiB3aGF0IEkgY2FuIHRoaW5r
IG9mIHRvIGJlIHRoZSBzaW1wbGVzdCBmb3IgcGFyZW50LCBJIGNhbiBkbyB0aGUgb3RoZXIKPj4g
d2F5IGlmIHlvdSdyZSBmaW5lIHdpdGggaXQuIExldCBtZSBrbm93IGhvdyBpdCBzb3VuZHMuCj4g
SSB0aGluayB3aGF0IEkgc3RpbGwgZG9uJ3QgdW5kZXJzdGFuZCBpczogaG93IGlzIHJlc2V0X21h
cCgpIHJlbGF0ZWQKPiB0byBwZXJzaXN0ZW50IElPVExCPyBJIGd1ZXNzIGl0J3MgYSBtdXN0IGJ1
dCBJIHN0aWxsIGRpZG4ndCBmaWd1cmUgb3V0Cj4gd2h5LgpIb3BlIG15IGZvbGxvdy11cCByZXNw
b25zZSB0byBwYXRjaCAyIGFuZCA0IGdvdCBpdCBjbGFyaWZpZWQ/IElmIG5vdCBsZXQgCm1lIGtu
b3cgd2hpY2ggcGFydCBJIG1heSBiZSBtaXNzaW5nLgoKVGhhbmtzLAotU2l3ZWkKCj4KPiBUaGFu
a3MKPgo+PiBUaGFua3MsCj4+IC1TaXdlaQo+Pgo+Pj4gVGhhbmtzCj4+Pgo+Pj4+IFNpZ25lZC1v
ZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KPj4+PiAtLS0KPj4+PiAg
ICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCB8IDcgKysrKysrKwo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKykKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Zk
cGEuaCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+Pj4gaW5kZXggMTdhNGVmYS4uZGFlY2Y1NSAx
MDA2NDQKPj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4+ICsrKyBiL2luY2x1ZGUv
bGludXgvdmRwYS5oCj4+Pj4gQEAgLTMyNCw2ICszMjQsMTIgQEAgc3RydWN0IHZkcGFfbWFwX2Zp
bGUgewo+Pj4+ICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAaW92YTogaW92YSB0
byBiZSB1bm1hcHBlZAo+Pj4+ICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAc2l6
ZTogc2l6ZSBvZiB0aGUgYXJlYQo+Pj4+ICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBSZXR1cm5zIGludGVnZXI6IHN1Y2Nlc3MgKDApIG9yIGVycm9yICg8IDApCj4+Pj4gKyAqIEBy
ZXNldF9tYXA6ICAgICAgICAgICAgICAgICBSZXNldCBkZXZpY2UgbWVtb3J5IG1hcHBpbmcgKG9w
dGlvbmFsKQo+Pj4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTmVlZGVkIGZvciBk
ZXZpY2UgdGhhdCB1c2luZyBkZXZpY2UKPj4+PiArICogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHNwZWNpZmljIERNQSB0cmFuc2xhdGlvbiAob24tY2hpcCBJT01NVSkKPj4+PiArICogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRldmljZQo+Pj4+ICsgKiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgQGFzaWQ6IGFkZHJlc3Mgc3BhY2UgaWRlbnRpZmllcgo+
Pj4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUmV0dXJucyBpbnRlZ2VyOiBzdWNj
ZXNzICgwKSBvciBlcnJvciAoPCAwKQo+Pj4+ICAgICAqIEBnZXRfdnFfZG1hX2RldjogICAgICAg
ICAgICBHZXQgdGhlIGRtYSBkZXZpY2UgZm9yIGEgc3BlY2lmaWMKPj4+PiAgICAgKiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdmlydHF1ZXVlIChvcHRpb25hbCkKPj4+PiAgICAgKiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgQHZkZXY6IHZkcGEgZGV2aWNlCj4+Pj4gQEAgLTQwMSw2
ICs0MDcsNyBAQCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIHsKPj4+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgdTY0IGlvdmEsIHU2NCBzaXplLCB1NjQgcGEsIHUzMiBwZXJtLCB2b2lkICpvcGFx
dWUpOwo+Pj4+ICAgICAgICAgICBpbnQgKCpkbWFfdW5tYXApKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRldiwgdW5zaWduZWQgaW50IGFzaWQsCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
dTY0IGlvdmEsIHU2NCBzaXplKTsKPj4+PiArICAgICAgIGludCAoKnJlc2V0X21hcCkoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCk7Cj4+Pj4gICAgICAgICAgIGlu
dCAoKnNldF9ncm91cF9hc2lkKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGlu
dCBncm91cCwKPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGlu
dCBhc2lkKTsKPj4+PiAgICAgICAgICAgc3RydWN0IGRldmljZSAqKCpnZXRfdnFfZG1hX2Rldiko
c3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4KTsKPj4+PiAtLQo+Pj4+IDEuOC4zLjEK
Pj4+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
