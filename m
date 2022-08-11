Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C328FC25B08
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 00:26:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3BC24154A;
	Thu, 11 Aug 2022 00:26:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F3BC24154A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=aOffqYVF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=EzvfKxF4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WH582sy2OnJ2; Thu, 11 Aug 2022 00:26:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DB37640951;
	Thu, 11 Aug 2022 00:26:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB37640951
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CD4AC0032;
	Thu, 11 Aug 2022 00:26:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5A65C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 00:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9B69360B28
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 00:26:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B69360B28
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=aOffqYVF; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=EzvfKxF4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xrz7xruTfTzP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 00:26:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D47726064D
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D47726064D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 00:26:27 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ANs7pH018168;
 Thu, 11 Aug 2022 00:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=yMn4SobQq1zDVKz05AYeXWBLxXe3blB1Sm+pqWwl008=;
 b=aOffqYVFwQqdxTzk9C3WEThTFm0InCUrq+TUdoUMHp8/6shxCdgGVORUZfl6eKktnFoT
 sEYINoSCu2jIluzgigx5+A0yp0PiNEKGtnZ487mqSOH0JHK/mpr9GRRQ7Yr+xa42/Sx2
 /cEO8expn7pCVoXaB23mVBrXorWEBAUSKBE6HstPcMgohNUopITYCB4PDqI/ldjVJqB2
 zvpLJ6cdlT9PSrDMMMWhi8HRb6+vwsIfr1XDOAwxwc4BIhp3bSDoUuzlHwLtzyKnW1te
 DJg6zJm0YVIMu8oRG2E+zx+EFHCnbezzAAEzLTQUi4yj01L6xAypCfXsCc7lEZWXc+kP Qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwq9kch6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Aug 2022 00:26:17 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27ANVR83037415; Thu, 11 Aug 2022 00:26:17 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3huwqjn23r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Aug 2022 00:26:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSxIt67C6PPR1y7BRBVUvCrPdd1OdAE95w28TaIk6N7EI/UCB6rMVe9zFVODvBX37Lz3A7zDvapnl1ZRhsH9AaYerby/Kk1+xFpwQ8zv8UMmwYkI640NyYkzSvKbvkGnhtHAMmemYveS20rx3khznpDJgLsLvOlVIXJssiKnyTQoOLvZaw8596x2hS6yq9on0H44WS9hr55BHMmz7PlihapSnb4g335m/8Jq+V1VzjS4TbM76LZHp8Kf6Z3/QXUgWKUCGnsLudlTeB2SbVvpLpzP7CXGup20SiEzJ92qWe4gnRM9LvAoOEKpyTymY9KGq4fFF7T5cuyne9qcdb01zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMn4SobQq1zDVKz05AYeXWBLxXe3blB1Sm+pqWwl008=;
 b=b4i2EDpUEbfs1m0KBBDlApUcFToasobFLAE2UfJyGu6jbDh2TDDRHf9aTTbDtSj9l1y4YZAcDRmWpDD6bTzUFq8keYi1mVJIwlIAvRbuEQxPDvjeQEl+Ftlk5LB9Exznp74MPbn3gHYSgmEmMn2W3X/KNeJivZHnv02hR4X47dDBwBgalMUIbC3UlUdSCOjl1nl2TkFLZwhFZr1TmsZ57gfw3P8xG0InObQRj1Ly/yW1TqPEKNyqL/DaCsYJphgyJemZ43bczZ32eoVfAiB50cYx94SR8aZCRbU6OBO9PXmA57WcF7hunhKV8nM93LhBeuZmTsVuNZDpFSLm8x2ckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMn4SobQq1zDVKz05AYeXWBLxXe3blB1Sm+pqWwl008=;
 b=EzvfKxF4XowukRCslqE3xRjy37T9lP/CugOlihWb27bqLTEhDX9UF1qslOonau7/bwMDWbBd+fH202n1s8dFIme66y79lbTKp5XJSDHAUNKYJKySI+K8oWzLJalfb9nO4cjI5EO2Gs7D5GbQuz/Z6RtquNfxnBZq5IM2fOopHvI=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by MWHPR1001MB2367.namprd10.prod.outlook.com (2603:10b6:301:30::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 11 Aug
 2022 00:26:14 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 00:26:13 +0000
Message-ID: <c96bf0cd-3e87-a75c-be92-f42945caf01b@oracle.com>
Date: Wed, 10 Aug 2022 17:26:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809182306-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <62920bd4-1070-a91a-baf8-659009e9f590@oracle.com>
 <20220810021320-mutt-send-email-mst@kernel.org>
 <20220810021427-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220810021427-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SA1PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::15) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fa558d7-d07d-40b7-8e4b-08da7b301920
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2367:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnnzDB58CLb3NdoCKoi8spbHjVds3OSsH4ZoF6U9jfOSE2ui3OKGNJ5RapMZzUA/44FhgYuKGtg3VGzqc9UkAvpe5S92ILYa+ZGB6XSRPhRP8w8wMQtvRQoGKurBHRO2SyshDyIDH8tK6t+mSm+cPVn5MoN1TEBs+z10hDnVghB09dEQxIBzVaemoKZ28zoMElDGZsGYf/v0Ek7yOTMtlymkgMcSODmy3KLlAlG/KVorM9t/kpgnSbhH+JIGZq/fspUPkcAHftMeus+kvK9Bj/XfyvDtzXeeEyR7V2yXWRDC69NpP2X/RcHiWP8EMiIcSD8bwPbmrhBjxvwFVkUMtUZ2HPeBhA2ZKYWGmZ5WotKWk1MaoLx7cG0/g6bB1BBBO4hNv9zAsQ7znwH+U4vE9F/pRv23KHBSc/pEaXIwT6HiYzcJloQ+AtMMIr2QDzGdNJwG3TNHPF6+mDANBmiKWo6cfO2m/VZ1hkeXhk6j4wXqRCTxmvQ200/v+N2th/OGarFzWgO9RM8zEUyRDG8wyzTh5NEGfxhf9xkW454w4w3wiUUViHsXxULFUvl2zTCCXU9ppcz4BaRbCGr8QQrF0boDiGpGYIaTZbzQZcZxahAA7dBuAMnrO78GphGCxow6vdzMnTkmqGkW7ocDcisQ8lc2c8uVCuhJOOthozlulxwWpBXpGRSlHOWapo2ES7hBmCF7PV5GqamERAgOgKek42jm93mI/ly3P4NLrERRVj7K14UcvHi4xmzV0MY6JD2LD3iC4bl2camoogmW8KLiGWClV3CyPLMRTJ+kBH5xJtJfxeH6JOOlFSgra40BU30T1O+fNsu3oj0lOuW3dKtTwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(346002)(136003)(396003)(376002)(39860400002)(41300700001)(83380400001)(53546011)(36916002)(6486002)(6506007)(8676002)(4326008)(66556008)(6666004)(316002)(2616005)(6512007)(66946007)(186003)(66476007)(26005)(54906003)(2906002)(6916009)(38100700002)(36756003)(86362001)(31696002)(8936002)(7416002)(478600001)(31686004)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TS9tOHdQR2F0YWx2RC91QXFxemx1bnl3YzJ4cW5laEpleHhrOUZnQzhOaDBl?=
 =?utf-8?B?VW0vaWloQzJrSm1xZFRVeEJBQno3QzRxcXBva2M0QXVKVmIyQiszZG5RcXlt?=
 =?utf-8?B?bCs1ZVVVckJQT29NT1IzU2FiaWhsUEdNSGlEdUxLemhIMERGS1RuYlFTRk0r?=
 =?utf-8?B?OFVBZThJeUlDc3lNcnVMSVRqaWEzNm5panliKzVPV0ZRU3p1S3lVaWUra2xF?=
 =?utf-8?B?ckhaWkZhWG5Eb0o0Yi8ydEprSFMvVXM3dGljMlVxMldaZUpHVGw4ZVg4aGVN?=
 =?utf-8?B?ckdjOWM3Ukw5VGd4eXoxeW80dCtpYmw4MWU1REVja0orOGhBTHdUU1FzNVpr?=
 =?utf-8?B?MXBUVGxNV1BYZDhtb1o4aHVzNCtMeWV1Sks5L2Z6UmJzQzJ3cy93ZDU2VVlZ?=
 =?utf-8?B?ZkxER0wrMTFFTXlVb1J5dTlNWlY4dFVBMXVTYmxtMW5PaEZBZGZxdzRWUlJ3?=
 =?utf-8?B?dHNId2orYTBEUDI1cnB1NnlJMFVpcTBwZFNxNGpXQlJJeVdFU1V4ZVRZSzVM?=
 =?utf-8?B?dWNHVnlpZW5uUFZmWTZqNTJVR3dOOE9jb0FJVmFBVVlUOWtEaUdLZmtNdWZH?=
 =?utf-8?B?Y3B5SlNLU3UrRmQ4Vk5rQ0Q5djM3bGdEam1kRjU1L09YbnZYL2FXenZ1S0Ix?=
 =?utf-8?B?RmU2VFVKbWlwY3VyNmJ0N2FFQ3VRbkpuZ1VlRzIvQ2h0UXBPcjh2dmtpYU5M?=
 =?utf-8?B?OFJUbUh3NmcyNUVlZHkyZlpDdlpiMzM2ZFRqL0FaSlJwZHpNaXljZmVnZzQz?=
 =?utf-8?B?c1Nsd2pVTHhMWFo1eGQvd3VkQlVvbUlSNWw3TFF1UTYxcHQyTlU4NmFZYzF4?=
 =?utf-8?B?NWVGWjFrcW1tdWNIYTQ2SjBGKzA3YXBDMmVMc0ltUUJoUWRNZ0pxSTZPcWxw?=
 =?utf-8?B?UG5sNnU5aE9mNEI0Tng4alMzcjBIaDZvVFVKOGl0S2FrMWdrS3ROUTY4RVM5?=
 =?utf-8?B?dnZ1UFBjdERQaE5oNmhxQkVBR3JoT1N0SzRJMTI4bWZIT0FQTEIzR2tKbmlR?=
 =?utf-8?B?WjNhak5nUmNoaDhJOEFQZWI2cWdYNDNEZTFQckg2L2tjQ0pjcU5oaUpZUXhy?=
 =?utf-8?B?NHQ1c3NsWEE5N1VpdEJWQ0FkWXU5RzR0Q3dDZjBuQlBFVWtPOHpYczJybUNk?=
 =?utf-8?B?TTIvYmlLNHNpMUNJRHFpekZkZmduQnZOcmc5djAvRWlqcmw1bUoyK0FWN3JN?=
 =?utf-8?B?QVh4NHlpOWtybW95K2UzMk8vK2JMaUtoVkdZSlhhQi9xVkxNQlQwWDhTelVw?=
 =?utf-8?B?UG1wVFdYYm4rQWt2TnBVWUI2bVZkOXJaRHFVNVVvUVkybUVrNnhoNWxUUnNP?=
 =?utf-8?B?UDV4bWxlUE5QOHg0WnRyMWYyWjhnUGhFZ0kxV0pvTWVjWDZYcFUyK082SkFN?=
 =?utf-8?B?eXBwZDYweDBsYzNJU05neU82OFg4VHdmZjg0WTB4REdQVU1JODZWWlJrSDFY?=
 =?utf-8?B?NmZ2cmdxK3JENXVCNEZCNGVvT1VRZWNXRUFTNUJiVDVzQWZXSjJVV2dOZ1Zn?=
 =?utf-8?B?Vk5JdEtFMC8xV2FRekE4VWFsR1ZsTWlFOHNxclNuWVNvSjRBZ1A0SFdpaTRQ?=
 =?utf-8?B?Ymd6RDBENC9tQ1NCV1ZTeU5pWnpvYnVuVGg0QTZQUnl3VTdReStGTjhFRDBi?=
 =?utf-8?B?VnF0L1RuVHdpV0tlazMvUHJ1KzNqTCs2b2ViNmxBdmJwdVlncTZYMnBwMkRR?=
 =?utf-8?B?REg3SGxsSXIrTXZET2lDK2lLbXBwWjdXelRQejREaFJEcWNiZ01Vay9kbm5k?=
 =?utf-8?B?Y2FPamxYQ1VESm1xcUh6dWpjd1MrNzAzcVY4QXJTbndzTlhTNEx2bjBFWity?=
 =?utf-8?B?OERYSGdJZ0hZSWhVRlNMRy9XbnhERUt2d21ZNW5rWG8raTcrRTNSNkhqWUFZ?=
 =?utf-8?B?VWh6NmFyK1J0NExhd1RaTWVDMU15VUZkbG5rY1F5Y21Sc2FMSTJYU1FzOEFv?=
 =?utf-8?B?ajhXWEZBVEhpS2xmd2ltemRkeDByRk9JZ2FOdkFpQWtTZWt4Y1gxTzFmcVZD?=
 =?utf-8?B?V3VJSEdDRUU5blRWOGVBcGJBZzFwNEVHWmNpcktTVkNxdlgxcVphd3pIN2Ra?=
 =?utf-8?B?dzVrWnhCMmYrUytlKzkzMlNiakk4R1E2aFdFM3Z6MFI0eDVpMFhZNEw4UUpo?=
 =?utf-8?Q?YwfnMcLKYeRUPgngbuIi3qihn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa558d7-d07d-40b7-8e4b-08da7b301920
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 00:26:13.8432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKlgr/5NzVRp4zDeNUSpceTd7EttJXmKt0OlHN3TwIfJ3j8OIXEogmjvwXuqv+yfstNv0QTXfip/AxgIzdHLZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2367
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_16,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208110000
X-Proofpoint-ORIG-GUID: DhQVbi-LZEd8QGZNlVXP1n9aCuHBdlI0
X-Proofpoint-GUID: DhQVbi-LZEd8QGZNlVXP1n9aCuHBdlI0
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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

CgpPbiA4LzkvMjAyMiAxMToxNSBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIFdl
ZCwgQXVnIDEwLCAyMDIyIGF0IDAyOjE0OjA3QU0gLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3
cm90ZToKPj4gT24gVHVlLCBBdWcgMDksIDIwMjIgYXQgMDQ6MjQ6MjNQTSAtMDcwMCwgU2ktV2Vp
IExpdSB3cm90ZToKPj4+Cj4+PiBPbiA4LzkvMjAyMiAzOjQ5IFBNLCBQYXJhdiBQYW5kaXQgd3Jv
dGU6Cj4+Pj4+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4+Pj4+
IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA5LCAyMDIyIDY6MjYgUE0KPj4+Pj4gVG86IFBhcmF2IFBh
bmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4KPj4+Pj4gQ2M6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT47IEphc29uIFdhbmcKPj4+Pj4gPGphc293YW5nQHJlZGhhdC5jb20+OyBHYXZp
biBMaSA8Z2F2aW5sQG52aWRpYS5jb20+OyBIZW1taW5nZXIsCj4+Pj4+IFN0ZXBoZW4gPHN0ZXBo
ZW5AbmV0d29ya3BsdW1iZXIub3JnPjsgZGF2ZW0KPj4+Pj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+
OyB2aXJ0dWFsaXphdGlvbiA8dmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtCj4+Pj4+IGZvdW5k
YXRpb24ub3JnPjsgVmlydGlvLURldiA8dmlydGlvLWRldkBsaXN0cy5vYXNpcy1vcGVuLm9yZz47
Cj4+Pj4+IGplc3NlLmJyYW5kZWJ1cmdAaW50ZWwuY29tOyBhbGV4YW5kZXIuaC5kdXlja0BpbnRl
bC5jb207Cj4+Pj4+IGt1YmFraWNpQHdwLnBsOyBzcmlkaGFyLnNhbXVkcmFsYUBpbnRlbC5jb207
IGxvc2V3ZWlnaEBnbWFpbC5jb207IEdhdmkKPj4+Pj4gVGVpdHogPGdhdmlAbnZpZGlhLmNvbT4K
Pj4+Pj4gU3ViamVjdDogUmU6IFt2aXJ0aW8tZGV2XSBbUEFUQ0hdIHZpcnRpby1uZXQ6IHVzZSBt
dHUgc2l6ZSBhcyBidWZmZXIgbGVuZ3RoIGZvcgo+Pj4+PiBiaWcgcGFja2V0cwo+Pj4+Pgo+Pj4+
PiBPbiBUdWUsIEF1ZyAwOSwgMjAyMiBhdCAwOTo0OTowM1BNICswMDAwLCBQYXJhdiBQYW5kaXQg
d3JvdGU6Cj4+Pj4+Pj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4K
Pj4+Pj4+PiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgOSwgMjAyMiA1OjM4IFBNCj4+Pj4+PiBbLi5d
Cj4+Pj4+Pj4+PiBJIHRoaW5rIHZpcnRpby1uZXQgZHJpdmVyIGRvZXNuJ3QgZGlmZmVyZW50aWF0
ZSBNVFUgYW5kIE1SVSwgaW4KPj4+Pj4+Pj4+IHdoaWNoIGNhc2UgdGhlIHJlY2VpdmUgYnVmZmVy
IHdpbGwgYmUgcmVkdWNlZCB0byBmaXQgdGhlIDE1MDBCCj4+Pj4+Pj4+PiBwYXlsb2FkIHNpemUg
d2hlbiBtdHUgaXMgbG93ZXJlZCBkb3duIHRvIDE1MDAgZnJvbSA5MDAwLgo+Pj4+Pj4+PiBIb3c/
IERyaXZlciByZWR1Y2VkIHRoZSBtWHUgdG8gMTUwMCwgc2F5IGl0IGlzIGltcHJvdmVkIHRvIHBv
c3QKPj4+Pj4+Pj4gYnVmZmVycyBvZgo+Pj4+Pj4+IDE1MDAgYnl0ZXMuCj4+Pj4+Pj4+IERldmlj
ZSBkb2Vzbid0IGtub3cgYWJvdXQgaXQgYmVjYXVzZSBtdHUgaW4gY29uZmlnIHNwYWNlIGlzIFJP
IGZpZWxkLgo+Pj4+Pj4+PiBEZXZpY2Uga2VlcCBkcm9wcGluZyA5SyBwYWNrZXRzIGJlY2F1c2Ug
YnVmZmVycyBwb3N0ZWQgYXJlIDE1MDAKPj4+Pj4gYnl0ZXMuCj4+Pj4+Pj4+IFRoaXMgaXMgYmVj
YXVzZSBkZXZpY2UgZm9sbG93cyB0aGUgc3BlYyAiIFRoZSBkZXZpY2UgTVVTVCBOT1QgcGFzcwo+
Pj4+Pj4+IHJlY2VpdmVkIHBhY2tldHMgdGhhdCBleGNlZWQgbXR1Ii4KPj4+Pj4+Pgo+Pj4+Pj4+
Cj4+Pj4+Pj4gVGhlICJtdHUiIGhlcmUgaXMgdGhlIGRldmljZSBjb25maWcgZmllbGQsIHdoaWNo
IGlzCj4+Pj4+Pj4KPj4+Pj4+PiAgICAgICAgICAgLyogRGVmYXVsdCBtYXhpbXVtIHRyYW5zbWl0
IHVuaXQgYWR2aWNlICovCj4+Pj4+Pj4KPj4+Pj4+IEl0IGlzIHRoZSBmaWVsZCBmcm9tIHN0cnVj
dCB2aXJ0aW9fbmV0X2NvbmZpZy5tdHUuIHJpZ2h0Pwo+Pj4+Pj4gVGhpcyBpcyBSTyBmaWVsZCBm
b3IgZHJpdmVyLgo+Pj4+Pj4KPj4+Pj4+PiB0aGVyZSBpcyBubyBndWFyYW50ZWUgZGV2aWNlIHdp
bGwgbm90IGdldCBhIGJpZ2dlciBwYWNrZXQuCj4+Pj4+PiBSaWdodC4gVGhhdCBpcyB3aGF0IEkg
YWxzbyBoaW50ZWQuCj4+Pj4+PiBIZW5jZSwgYWxsb2NhdGluZyBidWZmZXJzIHdvcnRoIHVwdG8g
bXR1IGlzIHNhZmVyLgo+Pj4+PiB5ZXMKPj4+Pj4KPj4+Pj4+IFdoZW4gdXNlciBvdmVycmlkZXMg
aXQsIGRyaXZlciBjYW4gYmUgZnVydGhlciBvcHRpbWl6ZWQgdG8gaG9ub3Igc3VjaCBuZXcKPj4+
Pj4gdmFsdWUgb24gcnggYnVmZmVyIHBvc3RpbmcuCj4+Pj4+Cj4+Pj4+IG5vLCBub3Qgd2l0aG91
dCBhIGZlYXR1cmUgYml0IHByb21pc2luZyBkZXZpY2Ugd29uJ3QgZ2V0IHdlZGdlZC4KPj4+Pj4K
Pj4+PiBJIG1lYW4gdG8gc2F5IGFzX2l0X3N0YW5kcyB0b2RheSwgZHJpdmVyIGNhbiBkZWNpZGUg
dG8gcG9zdCBzbWFsbGVyIGJ1ZmZlcnMgd2l0aCBsYXJnZXIgbXR1Lgo+Pj4+IFdoeSBkZXZpY2Ug
c2hvdWxkIGJlIGFmZmVjdGVkIHdpdGggaXQ/Cj4+Pj4gKCBJIGFtIG5vdCBwcm9wb3Npbmcgc3Vj
aCB3ZWlyZCBjb25maWd1cmF0aW9uIGJ1dCBhc2tpbmcgZm9yIHNha2Ugb2YgY29ycmVjdG5lc3Mp
Lgo+Pj4gSSBhbSBhbHNvIGNvbmZ1c2VkIGhvdyB0aGUgZGV2aWNlIGNhbiBiZSB3ZWRnZWQgaW4g
dGhpcyBjYXNlLgo+PiBZZWEgc29ycnkuIEkgbWlzdW5kZXJzdG9vZCB0aGUgY29kZS4gSXQgY2Fu
J3QgYmUuCj4gSGVyZSdzIGEgcHJvYmxlbSBhcyBJIHNlZSBpdC4gTGV0J3Mgc2F5IHdlIHJlZHVj
ZSBtdHUuCj4gU21hbGwgYnVmZmVycyBhcmUgYWRkZWQuIE5vdyB3ZSBpbmNyZWFzZSBtdHUuCj4g
RGV2aWNlIHdpbGwgZHJvcCBhbGwgcGFja2V0cyB1bnRpbCBzbWFsbCBidWZmZXJzIGFyZSBjb25z
dW1lZC4KPgo+IFNob3VsZCB3ZSBtYWtlIHRoaXMgZGVwZW5kIG9uIHRoZSB2cSByZXNldCBhYmls
aXR5IG1heWJlPwpUbyBiZSBob25lc3QgSSBhbSBub3Qgc3VyZSBpZiB3b3J0aCBpdCwgdmVyeSBm
ZXcgdXNlciBjaGFuZ2VzIE1UVSBvbiB0aGUgCmZseSB3aXRoIHRyYWZmaWMgb25nb2luZywgZm9y
IHRoZSBtb3N0IGNhc2VzIEkndmUgc2VlbiB1c2VycyBqdXN0IGNoYW5nZSAKaXQgb25seSBvbmNl
IGluIGRlcGxveW1lbnQgdGltZS4gRXZlbiBpZiB0aGV5IGNoYW5nZSBpdCBvbiB0aGUgZmx5IHRo
ZXkgCm1heSBuZWVkIHRvIGJlIGF3YXJlIG9mIHRoZSBjb25zZXF1ZW5jZSBhbmQgaW1wbGljYXRp
b24gb2YgbG9zcyBvZiAKcGFja2V0cy4gSW4gcmVhbCBkZXZpY2VzLCBtdHUgY2hhbmdlIGNvdWxk
IGVuZCB1cCB3aXRoIGxpbmsgc3RhdHVzIApjaGFuZ2UgYW5kIGluIHRoYXQgY2FzZSB0aGVyZSdz
IHVzdWFsbHkgbm8gZ3VhcmFudGVlIGFycml2ZWTCoCBwYWNrZXQgCndpbGwgYmUga2VwdCBkdXJp
bmcgdGhlIHdpbmRvdy4KCldoaWxlIEkgY291bGQgdW5kZXJzdGFuZCB0aGlzIHdvdWxkIHNsaWdo
dGx5IGludHJvZHVjZSByZWdyZXNzaW9uIG9uIApmdW5jdGlvbmFsaXR5LCBhcyB0aGUgd29yc3Qg
Y2FzZSBmb3IgcGFja2V0IGxvc3MgaWYgZGV2aWNlIGRyb3BwaW5nIApwYWNrZXRzLCBpdCB3b3Vs
ZCBiZSBhbGwgc21hbGxlciBidWZmZXJzIG9mIHRoZSBmdWxsIHF1ZXVlIHNpemUuIEZvciAKY29y
cmVjdG5lc3MgYW5kIGVsZWdhbmNlIEkgZG9uJ3QgbWluZCBpbnRyb2R1Y2luZyBzcGVjaWZpYyBm
ZWF0dXJlIHRoYXQgCmNoYW5nZXMgTVRVLCBvciBldmVuIHJlbHlpbmcgb24gdnFfcmVzZXQgaXMg
ZmluZS4gZGV2aWNlX3Jlc2V0IHdvdWxkIGJlIAp0b28gb3ZlcndoZWxtZWQgZm9yIHRoaXMgc3Bl
Y2lhbCB1c2UgY2FzZSBJTUhPLgoKLVNpd2VpCgo+Cj4+IC0tIAo+PiBNU1QKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
