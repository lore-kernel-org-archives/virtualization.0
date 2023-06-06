Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDCAC7EE24
	for <virtualization@archiver.kernel.org>; Tue,  6 Jun 2023 17:19:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 64E9E40523;
	Tue,  6 Jun 2023 17:19:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 64E9E40523
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=AxYtng41;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=sG44sn93
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KV50Vs1qaweu; Tue,  6 Jun 2023 17:19:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BD4F0400C8;
	Tue,  6 Jun 2023 17:19:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BD4F0400C8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94C43C0037;
	Tue,  6 Jun 2023 17:19:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46215C0029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 17:19:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0BE18400E5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 17:19:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0BE18400E5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hvu-PtIRSTtW
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 17:19:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CFAB8400C8
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CFAB8400C8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 17:19:15 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 356DDvbe022055; Tue, 6 Jun 2023 17:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8LCGG8QNGn6XAKgkmWf5bVJiAfh+XW9p2Sho1wqz8rs=;
 b=AxYtng41i+gxCo25KJOupkQ1WD2DcAwU2kTmHBlO7jf+xsh4Hd7mmvaLic3tBcYdAw3m
 A7RPgO5ByEhQyzpm7A0KX5PTt8GTFjMz2mW7xyRM+hYTDFq1j6b1pj/eZiSd+BZzsUrO
 T9d44EtiUH4qi6+vVx4AjWUGwkgcI1XlbXUJwHyiE1/eBZoN064rGX1SYnoIGirxkWhg
 EfiYr9S5daZS4ZuvfzqEOVqm+/N9mkSpG0qrqFpmIrdoLFKWBIrI8RSrLxNhmy9iF76z
 N9vxucADsZKVzyEC6SXcP1Ij3mqljxlJUw8SNfWm0TJFwWih3dL81x1iqyr11KtolXT4 Hw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx2n5uhd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Jun 2023 17:19:14 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 356GHkT3010503; Tue, 6 Jun 2023 17:19:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r0tqd88ya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Jun 2023 17:19:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCTpS9lTaS8xyg8JUcHiInX+yo75K1oQakMZJ7nRuHau9CXJ0n9RSYtDsPAxiC2+StMc4g/Wj7TQAGEnGMk4zgs7+KKacXFr+yjBEvIZnlrnpESqsv6Zk1If/p5w6Mm7xcO2v2L4jo9JDX3fYUlmv4qIPdzEx3tZ0MfobBr5KcmVzAe27T3f81nGsU+9LKmdsAmKEezl/aKH9kp2nYH1kYlBYO2//d59+C6Gnk8heBO4LL7wzJeIQfjepLRzKz4zix8IQSHZNDBXVfBEKpjb29ZoOKyaTmGKsqhxBZBoU3R8Jh9OfxVZnlQmVkIVVW6WqWLGs2FPwIHkWgxWKTasDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LCGG8QNGn6XAKgkmWf5bVJiAfh+XW9p2Sho1wqz8rs=;
 b=gOennN7xr6AyusVyCBaOKvwzWzJo/s02nwn7ClmZyU7HiLntUlTq17lzOHUpDO2HOB+2YIVb66gLT+V9ylPAv5uP9h78+h1zDG1mc3MwQw77kTEbH0tiQQznQA0oMLjZLfciCwTP/uCaIfQhW7XYFUs/8j47Co3+RGif7FgYYzX8nzPfl9ajcpQF/Y7w9QGmR3Ebxj32yeVHzgvUQmzO0/xgIrNQ+KusttEoHHwoMauAQ6qSfzrpaYitAjJ7xnWjAed+EmZTU2b+B4HYGmGlghQIgIgh05SODam18AxkbkSv3vSQapxvcRInbjwEi0/NzcRcDrEf+6YugCwN/Ti5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LCGG8QNGn6XAKgkmWf5bVJiAfh+XW9p2Sho1wqz8rs=;
 b=sG44sn93+Q4qqZAn2r6XJBf4zUqo8Zd3+GsX2Y/wTY0owQmYsTaPSyNxyT00rNomVS9rl9IDQCrllmVCd09NhVcbP2X24PpyZWFWQn30kSFQ4QvcCalvfK0de0iZz80uq7T+blWUmr9dYMV3pNl7E4pDhQQkD+a6fOq3UVm5Ho4=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY5PR10MB6072.namprd10.prod.outlook.com (2603:10b6:930:38::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 17:19:12 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 17:19:12 +0000
Message-ID: <efd1b26e-0286-e3a8-5343-3ff196788832@oracle.com>
Date: Tue, 6 Jun 2023 12:19:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/1] vhost: Fix crash during early
 vhost_transport_send_pkt calls
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20230605185730.6560-1-michael.christie@oracle.com>
 <yocmdeykp2no67yaopvc3on6hqmwt2gavuhchxfl3appfsapg2@qhcor7x5e7mi>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <yocmdeykp2no67yaopvc3on6hqmwt2gavuhchxfl3appfsapg2@qhcor7x5e7mi>
X-ClientProxiedBy: CH2PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:610:4f::27) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY5PR10MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 767bd083-999a-4b7f-9a1b-08db66b22544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fr4tBVm7nD6eFqtMq34dq7mYQTw5fJEIAyKZdUbZXelMf7jiaPMe/U9ZF0hZPqUCO5VGTumNzpZs0htskbh08vxbJitCAeHIOs4OWdKwxnnopM27DwnZfTZ3ro5lPyBm80jTYee9K6lEx2fT/bU97JFZo2p2cZyqAsXP98nTy/GMWxikDvD4eg9NjUfUme3RfXYEUjImc9HKPsAlUZ0vUQSQHRGz2tRz/CX1ffgs5hwG8u9jFuVcVX0yJp11KFn7FES5F3gjj26ePBgzydU4RpfLCkZVUP7fyeEuIxNnO6YgjkfaAw9k247+wbiew9D5/TAqCxsC5+MW9ZR7+9AF+rAQSvUSn9VNUSlvBuU6SaR2bXIeacZllDu5GxsUcn99Ft9scbk2SmZRFGXCSSdJbYRnf/0CoY+D5fKVCGOb5qSu6t3l6yz22XLNnzeYut9hrpQkIX6/CrojkivL9u8zdvCJoccn2O+Jcd54fIGlLzhZtfwbYnHH51jm0VTqzN5TB93JNTXxibcefsQhnSbA6L1OenfHwaAUdyvNbnlq+lt0+Wn+EsQhNTBFkgCMn75ej0SJsoy9XsISt463XzDdZPWj74UeaZBXi6ZPwYh7hRCsur3B4knhUluCFQChf+6r5AKhOgzjhGNGVWr6/quF4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(66556008)(66476007)(66946007)(8676002)(31686004)(8936002)(4326008)(6916009)(5660300002)(316002)(86362001)(31696002)(41300700001)(38100700002)(478600001)(2906002)(6486002)(26005)(53546011)(6512007)(6506007)(186003)(36756003)(83380400001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGdKaVNkQ0tDN2hDNnU2SkN2b3pEZVVMcW4vbWJpRWF3b1kzYktHallkMm05?=
 =?utf-8?B?YXROcFk5KzJpM2cwY041eUlOYkFlcXhWb2d2WTVHbXI2SlZLbmVrdDhmcU04?=
 =?utf-8?B?Qk4xQUczN2JXdytHL2NSaDZ5eGUwc2VjSnZTZkdBWkFRYnVFQ0lRNFFIZlRl?=
 =?utf-8?B?VWFhUWkrVlhMVTR6V05RdGpnQlpxbkFsNS9mZ0xTUGxTR3FCZDVaWE5ldVpC?=
 =?utf-8?B?VDIzQUQwQ3lYbnBQR01GUHk2QW8xai9aeXQrSUVZdEQ2eldUV3pOSGtSVXcy?=
 =?utf-8?B?cFUxZnJCVGdrZjZBeTU3Zk92VTV2MitIY2lOdFNKVFBuWVlFV1dKRUNFTDl5?=
 =?utf-8?B?dUpSd0ZuQlBGbkIxQ3VwczhBMExPM0grRzk5T012YWg3ZktNQ2pSNERUS1JJ?=
 =?utf-8?B?RkZSUFlSMS9sL1VwSC9oVWFwSG1LbUxoZzQvRzFPUnhEVkNBMUZCMzhoUEQ2?=
 =?utf-8?B?M211bzFQQlcvR05RYitDRWtzT2dySHRJRXpMeHE1QTlzS1JoenhQSzJXVFJI?=
 =?utf-8?B?V2RVb01JZkE2SU9INWFGd2RIdmR4VCtPMlpRYUY3YlZtSkJDMkVmTW9QaHdw?=
 =?utf-8?B?dTdUa3FhSlFLdEZaME1ydE1rWFQxYUlUNlBDelVRSzFJMkR4V2lyRTI3TGxh?=
 =?utf-8?B?eS9oYWw5b1NhUkZnOUtQQjRQRG9OSDdXVHF6RHJ5SnJaR2RqL2NzYjVIc2Ix?=
 =?utf-8?B?T2tkR1VoMzBSZkdSazVUQkd0TUZyQTRiNjVjT3dDNVFHZDhWUExrMjlFcDNn?=
 =?utf-8?B?Nk02VWRTYWRzREZaMzE4dW96SkNTNnRmaXFlV0d4T05FMGNrQVRVREErVEFZ?=
 =?utf-8?B?SndDYTI0WE9sRDVXR2U1RmpFcDhhQlMza3g5RnZ2eXYzajdHUkgxY2ZvVWwx?=
 =?utf-8?B?Mnp6UWlHS082Nit5bTJqSlZKbUZpU2NUcmZ3OXBBUTNDYzBhMDJEMTM2eUlV?=
 =?utf-8?B?bFkyVFRpUzJ4TzdCZnVNUHhVOFllUEFWTTUzbERQU1pCbWxrYXU0VXJtaEdB?=
 =?utf-8?B?ZjVtOWF3b0JFSmRUN1pFSGVwZldLLy9zZGNVRm1xNGZMa2FVamY4aWgxWTZP?=
 =?utf-8?B?Y013b0lZY3h4THNrRDIvV2drbUh5bjliNGV1T051ZVpkRk9XMktCS20zUmpx?=
 =?utf-8?B?dno0NURXUkkyMkxmcWhpblQwVzRIUG9Jdk82SzRqY2dzWGZxaXo1TlI3L1cz?=
 =?utf-8?B?OXE0eXdKM0NPMXlmekp0QzFYYjFTcjVUUkYzVnhlNktjSjFBdUNRMG5LNjBH?=
 =?utf-8?B?QjYwTFRzQ01aRUVWNnNaTU9jNFhQMXVWeXhKL25mc2YrZDVtWHJ2T3hsaHhz?=
 =?utf-8?B?MkFMZFkvck84NmNuWmg1cEUxVjRmdlkwTURRdGVZWjkrdTBOUWVmQTNUanZK?=
 =?utf-8?B?QmtkQXRCaUlyN3hjd1NPOUlQcFFIN1BDQzczTW9PWFFWNHpvZTJZU1FrcGFR?=
 =?utf-8?B?NjhITEQ3THc2a05HVWM3b3pabXFZdS9CM2pFbGxZTHhjWkJ1UU9nbFJOTjJn?=
 =?utf-8?B?amV5NE11Q1FUZDRraEI5SU9kMXhITnhyOUswY1RSYzVuVjRCRW5nSWZ1YmFl?=
 =?utf-8?B?MmdWRGovWjRDcksrUUQ3c0gzOTB4ZEdSbW5KK1lCUEdGZG5Nd3FNRGpnQ3BP?=
 =?utf-8?B?L05VdlJ0eFp2ZTdSTVVleE02RjFJVzh6ckttT21iRHlzTmdpaXRVZURxK0xE?=
 =?utf-8?B?RC9WZHRteFVHTFFlYjhUNzB3QkZ1emZVUi9HSklZT0ZjNXdhOFZ4Q0gzbVRz?=
 =?utf-8?B?V0l4a1NKeHk1bjlSd1FVZ3QzWldMam9DQ21aTU1VcEtVTHlINzZSbDNLK0Ux?=
 =?utf-8?B?bFZYNlViNzFSSU53Z005UXROOG1XSWlHU0o2ZnYvRXZBQ1RRNEhMZDA4UEpE?=
 =?utf-8?B?YUhmQkhrQXN3aGdMeUg0YWJLajlUakRjWEJubGpmSHNYNUFMZjh5NG1GQTJW?=
 =?utf-8?B?Rm9TYmhzdmVDc0dHZCtOd2phU1g5V2xoeGxORERRa0NONi9WbWk3dHZ2MXlG?=
 =?utf-8?B?VGRVRWtyRXM4bTh1N21IamYzSGN1VENPS3ZlNXowNG9aa1BtTE82R3hDMm9t?=
 =?utf-8?B?blFTSzJFc2Vvck5VREJqSFJYbUl4UzlwcDRNb2owd3I4QjVaNDNGZTFVS3FS?=
 =?utf-8?B?LzQ1NU9jeWx4WXFnNGZIc044UWdrN1lla2ZiWXVIdnZOVFJvVVlpeXp5YmJj?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tUvHbPO8zi5WEJlwLrdGihjr8tse9XDcYxdvfSf5TlYEWz7yDcPC+aa1AK8s4o/bcd+kuEK1j3/jx83wKyltP3SynYodD9v0M//r91DT9WAC6uz+ZqazUvBBozLsH6ZR5dfx+yBzTyQJrNtZ7BLhMf53Cfk7WBE6l+C4RU9fR59rSl38mfz7pQqe2YML77p8uJQ8We0aBhSXOyKTxcjBwQXjH8meKClDUvWNHz2XV7TZsKdaqLF0yKyX6HB7eqXmsLecNo1oWgabuV403i+ug1kh3JP0k/FtFFZ8y0gM66k2ev7frFUsMoXDIk2xuxjSZ4VoPCg7kSurQXEg6/eb7lBjUILl1glnzMENoN/Rm6AITSUv8mHmeLKKbsfebPptC3k8Zw6aBewp1KjvceHOq5Erb7t9YRfSGDEtkhHUWXTrWKpQEFkereHpw+h1bKClgXWdXCcjOXB5zADyfb9SApF9uDNXCVMtQGenjH9Cv3ysNeMOyLQYDvfuSf8N7hbMuw4HebBrJpMkENyfjXWDcNhXjhIv5wRVOT7Z3fLjxwgKr1DwdLacdD/pXgVxvKwgXFfAAtyjl8Q0oWer9ExnKF/muVGbn3U7oLZcFzqPKk1MVf3qiuJKRGrl7NmHQujxd7GNW6RGJbF4WytyhZeYL7gR/hTKFyp1MmY1FZs43yLMyrHcaADSm1AU0c3bgLvtF9nrjBoGvYAZnPJ0We+fIEZSGA/1QZ+/6BUEYi5NprPC4pkitnhbrAOPzqaLd8BuCblMgTVgBGt4v7FDCT2ZUoA7WIeK8fjjmo5djzZDrqTDOhfjsT9FZXNBi932sziM
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767bd083-999a-4b7f-9a1b-08db66b22544
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 17:19:12.0019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHs5eZK8/p7siVIy7kfzaudrt/rBLqzcia9zprArNQqYKYELzgFsbkE6Qn2apFctZOF1txryIEr4W2EU84ecBK6vuLuUVbFuWto3AMU6688=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_12,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=983 spamscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306060149
X-Proofpoint-GUID: MGbnVEJFK_hKrosVlcXDWNHsr3r-DL8x
X-Proofpoint-ORIG-GUID: MGbnVEJFK_hKrosVlcXDWNHsr3r-DL8x
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 mst@redhat.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gNi82LzIzIDQ6NDkgQU0sIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBPbiBNb24sIEp1
biAwNSwgMjAyMyBhdCAwMTo1NzozMFBNIC0wNTAwLCBNaWtlIENocmlzdGllIHdyb3RlOgo+PiBJ
ZiB1c2Vyc3BhY2UgZG9lcyBWSE9TVF9WU09DS19TRVRfR1VFU1RfQ0lEIGJlZm9yZSBWSE9TVF9T
RVRfT1dORVIgd2UKPj4gY2FuIHJhY2Ugd2hlcmU6Cj4+IDEuIHRocmVhZDAgY2FsbHMgdmhvc3Rf
dHJhbnNwb3J0X3NlbmRfcGt0IC0+IHZob3N0X3dvcmtfcXVldWUKPj4gMi4gdGhyZWFkMSBkb2Vz
IFZIT1NUX1NFVF9PV05FUiB3aGljaCBjYWxscyB2aG9zdF93b3JrZXJfY3JlYXRlLgo+PiAzLiB2
aG9zdF93b3JrZXJfY3JlYXRlIHdpbGwgc2V0IHRoZSBkZXYtPndvcmtlciBwb2ludGVyIGJlZm9y
ZSBzZXR0aW5nCj4+IHRoZSB3b3JrZXItPnZ0c2sgcG9pbnRlci4KPj4gNC4gdGhyZWFkMCdzIHZo
b3N0X3dvcmtfcXVldWUgd2lsbCBzZWUgdGhlIGRldi0+d29ya2VyIHBvaW50ZXIgaXMKPj4gc2V0
IGFuZCB0cnkgdG8gY2FsbCB2aG9zdF90YXNrX3dha2UgdXNpbmcgbm90IHlldCBzZXQgd29ya2Vy
LT52dHNrCj4+IHBvaW50ZXIuCj4+IDUuIFdlIHRoZW4gY3Jhc2ggc2luY2UgdnRzayBpcyBOVUxM
Lgo+Pgo+PiBCZWZvcmUgY29tbWl0IDZlODkwYzVkNTAyMSAoInZob3N0OiB1c2Ugdmhvc3RfdGFz
a3MgZm9yIHdvcmtlcgo+PiB0aHJlYWRzIiksIHdlIG9ubHkgaGFkIHRoZSB3b3JrZXIgcG9pbnRl
ciBzbyB3ZSBjb3VsZCBqdXN0IGNoZWNrIGl0IHRvCj4+IHNlZSBpZiBWSE9TVF9TRVRfT1dORVIg
aGFzIGJlZW4gZG9uZS4gQWZ0ZXIgdGhhdCBjb21taXQgd2UgaGF2ZSB0aGUKPj4gdmhvc3Rfd29y
a2VyIGFuZCB2aG9zdF90YXNrIHBvaW50ZXJzLCBzbyB3ZSBjYW4gbm93IGhpdCB0aGUgYnVnIGFi
b3ZlLgo+Pgo+PiBUaGlzIHBhdGNoIGVtYmVkcyB0aGUgdmhvc3Rfd29ya2VyIGluIHRoZSB2aG9z
dF9kZXYsIHNvIHdlIGNhbiBqdXN0Cj4+IGNoZWNrIHRoZSB3b3JrZXIudnRzayBwb2ludGVyIHRv
IGNoZWNrIGlmIFZIT1NUX1NFVF9PV05FUiBoYXMgYmVlbiBkb25lCj4+IGxpa2UgYmVmb3JlLgo+
Pgo+PiBGaXhlczogNmU4OTBjNWQ1MDIxICgidmhvc3Q6IHVzZSB2aG9zdF90YXNrcyBmb3Igd29y
a2VyIHRocmVhZHMiKQo+IAo+IFdlIHNob3VsZCBhZGQ6Cj4gCj4gUmVwb3J0ZWQtYnk6IHN5emJv
dCtkMGQ0NDJjMjJmYThkYjQ1ZmYwZUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCgoKT2suIFdp
bGwgZG8uCgoKPj4gLcKgwqDCoCB9Cj4+ICvCoMKgwqAgdnRzayA9IHZob3N0X3Rhc2tfY3JlYXRl
KHZob3N0X3dvcmtlciwgJmRldi0+d29ya2VyLCBuYW1lKTsKPj4gK8KgwqDCoCBpZiAoIXZ0c2sp
Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT01FTTsKPj4KPj4gLcKgwqDCoCB3b3JrZXIt
PnZ0c2sgPSB2dHNrOwo+PiArwqDCoMKgIGRldi0+d29ya2VyLmtjb3ZfaGFuZGxlID0ga2Nvdl9j
b21tb25faGFuZGxlKCk7Cj4+ICvCoMKgwqAgZGV2LT53b3JrZXIudnRzayA9IHZ0c2s7Cj4gCj4g
dmhvc3Rfd29ya19xdWV1ZSgpIGlzIGNhbGxlZCBieSB2aG9zdF90cmFuc3BvcnRfc2VuZF9wa3Qo
KSB3aXRob3V0Cj4gaG9sZGluZyB2aG9zdF9kZXYubXV0ZXggKGxpa2Ugdmhvc3RfcG9sbF9xdWV1
ZSgpIGluIHNldmVyYWwgcGxhY2VzKS4KPiAKPiBJZiB2aG9zdF93b3JrX3F1ZXVlKCkgZmluZHMg
ZGV2LT53b3JrZXIudnRzayBub3QgTlVMTCwgaG93IGNhbiB3ZQo+IGJlIHN1cmUgdGhhdCBmb3Ig
ZXhhbXBsZSBgd29ya19saXN0YCBoYXMgYmVlbiBpbml0aWFsaXplZD8KPiAKPiBNYXliZSBJJ20g
b3ZlcnRoaW5raW5nIHNpbmNlIHdlIGRpZG4ndCBoYXZlIHRoaXMgcHJvYmxlbSBiZWZvcmUgb3Ig
dGhlCj4gcmFjZSBpcyByZWFsbHkgc2hvcnQgdGhhdCBpdCBuZXZlciBoYXBwZW5lZC4KClllYWgs
IEkgZHJvcHBlZCB0aGUgUkVBRC9XUklURV9PTkNFIHVzZSBiZWNhdXNlIEkgZGlkbid0IHRoaW5r
IHdlIG5lZWRlZAppdCBmb3IgdGhlIHZob3N0X3Zzb2NrX3N0YXJ0IGNhc2UsIGFuZCBmb3IgdGhl
IGNhc2UgeW91IG1lbnRpb25lZCBhYm92ZSwgSQp3b25kZXJlZCB0aGUgc2FtZSB0aGluZyBhcyB5
b3UgYnV0IHdhcyBub3Qgc3VyZSBzbyBJIGFkZGVkIHRoZSBzYW1lCmJlaGF2aW9yIGFzIGJlZm9y
ZS4gV2hlbiBJIHJlYWQgbWVtb3J5LWJhcnJpZXJzLnR4dCwgaXQgc291bmRzIGxpa2Ugd2UndmUK
YmVlbiBnZXR0aW5nIGx1Y2t5LgogCkknbGwgYWRkIGJhY2sgdGhlIFJFQUQvV1JJVEVfT05DRSBm
b3IgdnRzayBhY2Nlc3Mgc2luY2UgdGhhdCdzIHdoYXQgd2UgYXJlCmtleWluZyBvZmYgYXMgc2ln
bmFsaW5nIHRoYXQgdGhlIHdvcmtlciBpcyByZWFkeSB0byBiZSB1c2VkLiBJIGRpZG4ndCBzZWUK
YW55IHR5cGUgb2YgcGVyZiBoaXQgd2hlbiB1c2luZyBpdCwgYW5kIGZyb20gdGhlIG1lbW9yeS1i
YXJyaWVycy50eHQgZG9jCml0IHNvdW5kcyBsaWtlIHRoYXQncyB3aGF0IHdlIHNob3VsZCBiZSBk
b2luZy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
