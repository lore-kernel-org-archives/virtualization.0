Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA9BC001B0
	for <virtualization@archiver.kernel.org>; Tue, 15 Aug 2023 23:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC7E2414B7;
	Tue, 15 Aug 2023 23:38:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC7E2414B7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=f6fRapbn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=YzekiyYb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VCuSLkIQ3aDS; Tue, 15 Aug 2023 23:38:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0CEEF4047C;
	Tue, 15 Aug 2023 23:38:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0CEEF4047C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D90BFC0071;
	Tue, 15 Aug 2023 23:38:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ABA1C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 23:38:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3CB882115
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 23:38:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C3CB882115
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=f6fRapbn; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=YzekiyYb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id arhV7sCk_024
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 23:38:02 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C863182112
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 23:38:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C863182112
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37FNPao5023312; Tue, 15 Aug 2023 23:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=C+XrX7l/4M8QQGnWROivh1xbbFQphREeZm2DTxMOVE4=;
 b=f6fRapbnSPjYcHzVLiM6Fze/FjttFTRfFutLwypMpNWAwpHC+syNZbo+DLbPQCfysC6C
 dv+AUQmnUhDYHq+lU5JMxvjpsVH2LLqGYGrnGHWNWwNGCKuuF8fgFjOl5FJvY/QQCZxA
 q3ouEXPKc24aGh4uJTslwusCF/2OPw/YfKvwcuj7ffWFx4F6vZbNUn8FF96guYMzczv/
 +IKJLjxOPzAK9WamB92VTBSc15wsdUW6WMoaUBOCrTHAEcuJLXA0Fp5lWiB1wmzqw7/Z
 SXqpd8QDCNFcZlRUwEv2x6YitFi5T/mTPpExz++oCjhih/HX33IT1DAyWCleXwSv2jDB aQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfnu5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Aug 2023 23:38:00 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37FLxmcd003676; Tue, 15 Aug 2023 23:37:59 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sexyjf2fh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Aug 2023 23:37:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMyzIQrQfKvEC1YeGJ4XOGUgnxuofeLL24mAAIhpzaiCL8Q7OquMBLVYw6PKJHtnJCSghP7SjdrFqKzjzU+FvIDD69e6pLD9rQbsQqxe5L2Vz0iVai4V8IHcUgbwB7BBq7CIcqUoszj1iZKZUjN8DbiTHLhfq5Ihms3MxEFXeYZnNwWXwOAqVjh5Tw6MZd61N8xRYO9WUuxnYGUELeLZVC5dkn2e3pVSm3O6Fhi0JO+CQ7DHalKCL+kwRNV0MlU54jgZYMAvJlyoOOQ6EUl/Nufbp2sGW+FRUvqoflR2F+ZhK4KfbvFzJARRcJDr7QBMcDX2S1tlqBdUPFhgDs7QIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+XrX7l/4M8QQGnWROivh1xbbFQphREeZm2DTxMOVE4=;
 b=GjeYHJ+Ah+sDP/S8lfK/z1Ou0RVSCN92RHUaBNXNtdxviZkK7Vp33xHHHn5YEKUu9vuCEUbpOW4rM4zOfzY7666/A3NAj9IKfDuKpiGaU5aRqHkv9DLqu1a0t8QTvCSRhCzJVOx/6Qz4cTT3ISTn3uMej6mqFEz9qs20OSQk82LG3h6NqsWr3mv3jyLPY/TfqxZw69l5uWmhHI1E8MPRSANsOvbjCrJOJ+Td9oKceF0DivjA54XcljqHcsqzZist5dozVp/A2Besub2BsuCOT+kNMwLE3qdOIM6pP5oFEMatS4rdBMp/Vhvd+J0m9/C2sx+3nXE5hpNq+T+39xTmjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+XrX7l/4M8QQGnWROivh1xbbFQphREeZm2DTxMOVE4=;
 b=YzekiyYbQ3iVUWOnjjb0qo8Iy/KDxnJzpsAQy4WqkVt6mQHtAVBrX46v3UKxHaYnCgLYOyRBnaRHuAgdFHXUHg76LbbmrWHs2l0V7a8rNz8bCcZx+eXcaUIEusdu6Qg3ssX+hSP0/Eq/G6LxV9EgQpJ4um2M1AaEx8gE6QyUocE=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SA1PR10MB6413.namprd10.prod.outlook.com (2603:10b6:806:258::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 23:37:57 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 23:37:57 +0000
Message-ID: <80c198d8-a234-0dd2-7435-893dca38ef9e@oracle.com>
Date: Tue, 15 Aug 2023 16:37:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 0/3] vdpa: dedicated descriptor table group
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <1691585683-3948-1-git-send-email-si-wei.liu@oracle.com>
 <CAJaqyWfYrsAagetA2A2XUtdpR8fwKizG8ASvz41HvSDiqkBb0Q@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWfYrsAagetA2A2XUtdpR8fwKizG8ASvz41HvSDiqkBb0Q@mail.gmail.com>
X-ClientProxiedBy: SA1PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::26) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SA1PR10MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 6712eb7c-3dc2-473a-cf9c-08db9de8a770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8x8KwLZPIDNNvwrXiRYpK15in3kdygRi/CboZo6oSRJTMortqBMlsF15T4wqGN8uCL4IA1Amz/VJpjX3hidQu7NAdqKNXxZ2gwMlVMlNnsuDN+8U3JAwK+jS6NbRoXmswwkMWrMM/okzNdr6LzJ3/Rnfs7JurSblMXVb4wznbhStt1FmFC/8jAlyWAcbTaaax0lXWB/F2sqPrOv8k6l2ot/B7Jn+ufWnN7R/JVKmMVR7nT7CLSI+xrskNnD8a2SwjhMbixqCMBcUY7MaNEi1gRbY3dQHbYhuCnpwfEzbWdLNSJQVNSys4dsnOOyX9YxKCel4VOl3yTkjm7V16qfrnBf5Ak8IrsekYvQK6l7rCaTukh/mq7OnQmAwblvVDgcm0XqATpL7iyJBgpVCY9Q5VXG1d2kuEfdgXaS1IW9j8/XzJlOs1IbmBBQj9QyBPZWRpIqFwjRl2UDDvys1LElvYmKbLKuNWdiqyo8RN6lKOFvGEXEKEM62tMpShuBUhFw+wxjRRIO+AeJKG8rck0252Q8itrWqOpkirZQrCIM5fva7Qvf1Y3MESlYWYoWa6L/Dk8ATi8cIFdfX8tWb1+MXRw1Juv5Xmwmrd6sVnGMouqGTPEU3F4VAOeN2rFhEC7VgoNcEV01NESLyvCMYgOKvCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199024)(186009)(1800799009)(86362001)(4326008)(41300700001)(6916009)(2906002)(31686004)(316002)(478600001)(5660300002)(2616005)(38100700002)(83380400001)(66556008)(53546011)(26005)(36916002)(66574015)(8936002)(6506007)(6666004)(6512007)(8676002)(6486002)(36756003)(66946007)(31696002)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDBWSUw2TVFPbnIyZ0JaandyTis0d0xmQVZTelBTblVIaForN1ExY1BSa1RZ?=
 =?utf-8?B?VGZKWkVqK0NJemhUMk0rajRobVpqeHFpcVI0OXdOWVBVdXFlMHdPNHc0QXFL?=
 =?utf-8?B?WitMU1pZYjFrTm1lTERUb2Joak1iYlk1V0VnTCtlTnVDZVh0aGlLbHorUS9r?=
 =?utf-8?B?SFZlRm5ZbzNiNGlmU3BZT3BQNEpOQ210Nk9tdVFxQ2psa3dFbWVLZ1p4SEh0?=
 =?utf-8?B?KzZzUVZJd2ZrMU1vUy9TVXFiOTEvYTFrUExwenhiRVpwMTg3YUhTQWlmMnJn?=
 =?utf-8?B?MDY5ditKY0srMTZod2syUWwzS0RqVGtneUtDQUFoU2w1SGVURkFSbEdjbDJu?=
 =?utf-8?B?N1FjdkhGNXFrK1hsQ1gxR3R2TGxFa0ZORHFyM2FDVks3N1hmUk9jYkFvVHlB?=
 =?utf-8?B?dkRxSm1jTDMwZ3NSZ3dlMW5wb1M0SFZxcDFKYThBZnpxV3pqdERXUFdGdXAy?=
 =?utf-8?B?NWtzRkhDcHNzdGNSekt6T3ZRK0pVMEs4Yk1MSGpQZ3c3R3lpclF4YlZhY3RP?=
 =?utf-8?B?b2EwRjJxZTNwSkE1N0ptZ1lCekdON3l6VWRHcmYwcHp3WFdhOEhJamM1b2ZV?=
 =?utf-8?B?U3lJSzVNUUVKWXNMR21Xc0dtSmRjYXFtNDhsdFNWNll2NkFoemFPTjBtYkhE?=
 =?utf-8?B?YWQwMk5zL3JoM0xVVlRZalJmc2NmS0RvQXo5UUgyNTVuaUpFTFJURldid3Zu?=
 =?utf-8?B?WFYrNUlCUXFBTm9vTkxxMzBuc1U1bWEvbmxtYlZCeTVKR2NJUVNDS3Z6VXo2?=
 =?utf-8?B?b1RYdWVLZkc3K3I4cDNZUEhGanRDZUZiUjFEd3luZzJyalNPMnI3WW81cnhK?=
 =?utf-8?B?ZnNydkhLZ0t0VXdXNE45SmJldEZ2MUhqVStFL1lPb204WER6cGJPMXVLM0NU?=
 =?utf-8?B?REx6cWE4cmlCUFM1VHliVGJIV1ZPV0dkb21YL0VSRFg4V0xqTUxxc3QvZExl?=
 =?utf-8?B?ZWwrUWhRaGRBQVdqb1BHQWV4SEQ1VG5nQlE2bkZTcUZGM3lBTERjTzBzcjAx?=
 =?utf-8?B?QXptYSsrS1hSdFJzZDFucEpGVHU2dXdEZTArNjZ2SU1vTnV6TTh5Q1lzWml1?=
 =?utf-8?B?cTNUT1R2TURkTXJWc1hRa1dtdExkYUNUOU5vOTRoRDRzcUtnUmRKTkNpYjYz?=
 =?utf-8?B?TzV5K3ZseFdYN2djY25qSmZWUnVyVElraFFqRHc5Wi9icHFQRVdaQVNOMEFP?=
 =?utf-8?B?bkdNZndmWElaM0kyVVVLSkxVVHFDblk5VklyMTA2UjE2Q0FkQ1g3d1h2cWwz?=
 =?utf-8?B?djd2OE90RHBUODRIOVUyTVN1MGpNZ1ZHZTZ4cU4xeVN5TElNM2QyZEVXenB1?=
 =?utf-8?B?RzU5QVl5UDRlUDhJZ0g4SUdLY3RuNHJhMmJQaWlHcXBXWDlub2k2c1BEZUxS?=
 =?utf-8?B?dHN6RlZ3MkxDMjlrNTdOTUhNUElwL0NKdkpESjFsTlhlczBjeGdYUDVTUDZC?=
 =?utf-8?B?dDROTjZFZUh1eHR1d0VhcFVVc0pORDlQTk9JNXRseFQ5WnNsTHUxZGJCQlFJ?=
 =?utf-8?B?ZVFSN0dDbGwxWU5uOGtIRXVSd2orTDdhV2lEOXI2SEMzYVJoV1VyMnBqekRv?=
 =?utf-8?B?Q1VBckNmUElmU2JrWmF3MlBPb1lTcElSbkNxdTlFRXp1OVJWU3d6VnM0TklR?=
 =?utf-8?B?TmJyNWp2M1RuS0VDT2YvQUJCSnZaOC9jckZZNEJxMEV3YUN5elA4cGhMcWRj?=
 =?utf-8?B?SUVrUGY3YnA4S1RvNHpnR0laR3JpZEhOQ0lHeWVqbGRkM0ZhUEtBTnpScURs?=
 =?utf-8?B?NXQwY2c1dFEvbTZPYmJvcEw4M1NxZ3gxTFNnUG5hcTEwQlVucjBtN0Nnd3FQ?=
 =?utf-8?B?TVpwK25nYTBSbGhwNDBVdjRFTGtJaEg2WDh1RE9Bc3JLaVp1ODdVWDZ5Z21F?=
 =?utf-8?B?NWZwdkFmYUZJSUlCVS9DbGlGcDF5eGNLQkQzOEdUWWV0Qjh1NjZieGlUMFpW?=
 =?utf-8?B?S1JJcUtsU3hNbW5LTHJPRzd1YWIyRkkweHZ3TFdrWFc2alFhM3RVR3RHY21o?=
 =?utf-8?B?WFo5eHNLYis3NTE5aHFVRUFQTE9lWFNGZFQ1ai9MS1pwNzBUL3A4clA0RGsw?=
 =?utf-8?B?OG1pS1VhbnlPdlRPVy9TM21nMldvSjhYd0UwNWRScVdvQVNQcWVuZUtpUStG?=
 =?utf-8?Q?ZRBhnCWTJZy5LDp8PEBS086wC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6tmaAXrUEKJHsaLP/GVeiPG1x2OPeIjttlF2U4bELoM2rjc+d07FpB2EdypnjXSvF3cN2AnO3qH2vjqWL0xKzDfdVKzDlOYO7W4snIJLcJ9uEMc69ZHWxVpe4YABk0z4LGZbISU09pxsglyjbaSPwc3EPbNSI7CpSabl6BDqF+2FR23/f8y7aR5oQrckg2mA6TjcVut7D4jvapdfOshjnSeO3CT+zOlKikXQZk6qqsYfKyarQuskp/89y2YdUSddNvpB2pml4JpXc70axeskJ5rZQOrav/NOgtnDORhcXUcNNQ+24IvjGM9WZQO5BcgtjJzqSCYOVjDUrhiXuC7sDWEWSE6R6LRY0ydNff6gwwPugwk7KqNgN56ftEAgFuQ5rVfB6oY74WRqACZJ7zMkLbW6mo4YfOPS4disi6Jg6i1bsQd4lbz0sksx9ujZp/aNXqns78ngHX3dMxaloYfnchVNq1Y+tyn51ZOJya/xUWrjXqP1Lw20ptUb4IwzSbg1ESjyXQXOqUBuKdezvropZE+2L1KONefcFmbLUhMuJG8vbVZCuSd2fnhT63M0Z4a/zaVAHpJEqsbuuC7/610xD5dPodOf3iAjp+1Jz1YHcVYuiwi02LlUt+1/m/DdMZqjvKLRjraAq39sZ3cIyhUpSgqkMqE1UYRI79hqe5PQ8Ap3cxZbFY0ArDR/bKGruQ1Z/KxvcVNsmzioAVv5EuS8g3FC5atc1wfv8MS6KgDI5aHypRUencjsDC7bQ3wI9JVe6pz62S9JYynivyIBPHPNMurQZ1Kiqe9rKWhD2qrK0yJ3NE57LVY4NUk8qmVa5f5557EXbsWEIwzcG4rUAlhWKdqxwnbP6UNwi54t5gAvxrA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6712eb7c-3dc2-473a-cf9c-08db9de8a770
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 23:37:57.2170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWuew/MniOr29XPes3dOPq3wVk9aBRVyDl4eHSxOXXjCyu95+lBV3hhqhONEg7VwK+umRtLCTWBBXJ2qebdsUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6413
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_19,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 mlxlogscore=594 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150213
X-Proofpoint-ORIG-GUID: TCei3xVmC0AwQEIkuHRrIpKegdotYzwG
X-Proofpoint-GUID: TCei3xVmC0AwQEIkuHRrIpKegdotYzwG
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, elic@nvidia.com
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

CgpPbiA4LzkvMjAyMyA3OjQ5IEFNLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3cm90ZToKPiBPbiBX
ZWQsIEF1ZyA5LCAyMDIzIGF0IDI6NTbigK9QTSBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNs
ZS5jb20+IHdyb3RlOgo+PiBGb2xsb3dpbmcgcGF0Y2hzZXQgaW50cm9kdWNlcyBkZWRpY2F0ZWQg
Z3JvdXAgZm9yIGRlc2NyaXB0b3IgdGFibGUgdG8KPj4gcmVkdWNlIGxpdmUgbWlncmF0aW9uIGRv
d250aW1lIHdoZW4gcGFzc3Rocm91Z2ggVlEgaXMgYmVpbmcgc3dpdGNoZWQKPj4gdG8gc2hhZG93
IFZRLiBBcyB0aGlzIFJGQyBzZXQgaXMgdG8gc2VlayBlYXJseSBmZWVkYmFjayBvbiB0aGUgdUFQ
SQo+PiBhbmQgZHJpdmVyIEFQSSBwYXJ0LCBmb3Igbm93IHRoZXJlJ3Mgbm8gYXNzb2NpYXRlZCBk
cml2ZXIgcGF0Y2ggY29uc3VtaW5nCj4+IHRoZSBBUEkuIEFzIHNvb24gYXMgdGhlIHN1cHBvcnQg
aXMgaW4gcGxhY2Ugb24gYm90aCBoYXJkd2FyZSBkZXZpY2UgYW5kCj4+IGRyaXZlciwgcGVyZm9y
bWFuY2UgZGF0YSB3aWxsIGJlIHNob3cgdXNpbmcgcmVhbCBoYXJkd2FyZSBkZXZpY2UuIFRoZQo+
PiB0YXJnZXQgZ29hbCBvZiB0aGlzIHNlcmllcyBpcyB0byByZWR1Y2UgdGhlIFNWUSBzd2l0Y2hp
bmcgb3ZlcmhlYWQKPj4gdG8gbGVzcyB0aGFuIDMwMG1zIG9uIGEgfjEwMEdCIGd1ZXN0IHdpdGgg
MiBub24tbXEgdmhvc3QtdmRwYSBkZXZpY2VzLgo+Pgo+IEkgd291bGQgZXhwYW5kIHRoZSBjb3Zl
ciBsZXR0ZXIgd2l0aCBzb21ldGhpbmcgaW4gdGhlIGxpbmUgb2Y6Cj4gVGhlIHJlZHVjdGlvbiBp
biB0aGUgZG93bnRpbWUgaXMgdGhhbmtzIHRvIGF2b2lkaW5nIHRoZSBmdWxsIHJlbWFwIGluCj4g
dGhlIHN3aXRjaGluZy4KU3VyZSwgd2lsbCBhZGQgaW4gdGhlIG5leHQuCgo+Cj4+IFRoZSBwbGFu
IG9mIHRoZSBpbnRlbmRlZCBkcml2ZXIgaW1wbGVtZW50YXRpb24gaXMgdG8gdXNlIGEgZGVkaWNh
dGVkCj4+IGdyb3VwIChzcGVjaWZpY2FsbHksIDIgaW4gYmVsb3cgdGFibGUpIHRvIGhvc3QgZGVz
Y3JpcHRvciB0YWJsZSBmb3IKPj4gYWxsIGRhdGEgdnFzLCBkaWZmZXJlbnQgZnJvbSB3aGVyZSBi
dWZmZXIgYWRkcmVzc2VzIGFyZSBjb250YWluZWQgKGluCj4+IGdyb3VwIDAgYXMgYmVsb3cpLiBj
dnEgZG9lcyBub3QgaGF2ZSB0byBhbGxvY2F0ZSBkZWRpY2F0ZWQgZ3JvdXAgZm9yCj4+IGRlc2Ny
aXB0b3IgdGFibGUsIHNvIGl0cyBidWZmZXJzIGFuZCBkZXNjcmlwdG9yIHRhYmxlIHdvdWxkIGFs
d2F5cwo+PiBiZWxvbmcgdG8gYSBzYW1lIGdyb3VwICgxKS4KPj4KPj4KPj4gICAgICAgICAgICAg
ICAgfCAgZGF0YSB2cSB8IGN0cmwgdnEKPj4gPT09PT09PT09PT09PT0rPT09PT09PT09PSs9PT09
PT09PT09PQo+PiB2cV9ncm91cCAgICAgIHwgICAgMCAgICAgfCAgICAxCj4+IHZxX2Rlc2NfZ3Jv
dXAgfCAgICAyICAgICB8ICAgIDEKPj4KPj4KPiBBY2tlZC1ieTogRXVnZW5pbyBQw6lyZXogPGVw
ZXJlem1hQHJlZGhhdC5jb20+ClRoYW5rcyEKCi1TaXdlaQoKPgo+Cj4+IC0tLQo+Pgo+PiBTaS1X
ZWkgTGl1ICgzKToKPj4gICAgdmRwYTogaW50cm9kdWNlIGRlZGljYXRlZCBkZXNjcmlwdG9yIGdy
b3VwIGZvciB2aXJ0cXVldWUKPj4gICAgdmhvc3QtdmRwYTogaW50cm9kdWNlIGRlc2NyaXB0b3Ig
Z3JvdXAgYmFja2VuZCBmZWF0dXJlCj4+ICAgIHZob3N0LXZkcGE6IHVBUEkgdG8gZ2V0IGRlZGlj
YXRlZCBkZXNjcmlwdG9yIGdyb3VwIGlkCj4+Cj4+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgICAg
ICAgICAgICAgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4gICBpbmNsdWRlL2xp
bnV4L3ZkcGEuaCAgICAgICAgICAgICB8IDExICsrKysrKysrKysrCj4+ICAgaW5jbHVkZS91YXBp
L2xpbnV4L3Zob3N0LmggICAgICAgfCAgOCArKysrKysrKwo+PiAgIGluY2x1ZGUvdWFwaS9saW51
eC92aG9zdF90eXBlcy5oIHwgIDUgKysrKysKPj4gICA0IGZpbGVzIGNoYW5nZWQsIDUxIGluc2Vy
dGlvbnMoKykKPj4KPj4gLS0KPj4gMS44LjMuMQo+PgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
