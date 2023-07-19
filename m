Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BDDC001B0
	for <virtualization@archiver.kernel.org>; Wed, 19 Jul 2023 22:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92AD040125;
	Wed, 19 Jul 2023 22:54:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 92AD040125
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=fvypz8Sw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=IBIg9LPM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GaATOSZ0tDgA; Wed, 19 Jul 2023 22:54:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E69EB400E7;
	Wed, 19 Jul 2023 22:54:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E69EB400E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1921C0072;
	Wed, 19 Jul 2023 22:54:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C807C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 22:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 200C140125
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 22:54:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 200C140125
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wz3-iYgbnOSk
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 22:54:32 +0000 (UTC)
X-Greylist: delayed 2059 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 19 Jul 2023 22:54:32 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5DE1F400E7
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5DE1F400E7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 22:54:32 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JFOp4M008954; Wed, 19 Jul 2023 22:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=LxB92oFlEnOstlUb2jCTCTIQ1W2TfTyUxTXyxU5tR6M=;
 b=fvypz8SwUZ6Z6irydXRuEBTnX9NHborn5HUs4sQL+CIVo8yMN7S+FN1RX3EwHNMD70rC
 WhnqWlwLzxRnRiv51pPK+J2DU0zQAtq1ot+hfVmtWF7q7zbDnjIWXzxJYND5cMaq9nHM
 KCXOifxmxM4ltavO3LNwi6ELmW4ElfwDaorG6iKd2dKDKM2lNePiSNJ6INB23CYn+N9V
 Tw1PC7EQ/nUa9/0HWzpabHZJyqSyqQTrriLr2gdqcC+wWXlweTxde1KM5J65vnXvoxi3
 hzJ/bqPDmijbPINf/UOMtRiiuPmoKRGsm5quJo+F3+qY5Hk8JWnWaliLYtileHdKGbhi Aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run780hw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 22:20:10 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36JLmxPu023888; Wed, 19 Jul 2023 22:20:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ruhw7v1wv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 22:20:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8SuHAZ9FgZ1ut6/EShB3pk86CYJW1k0sWzbJ0S3IqF3X+GciOqlWTagLA7Zvwo4xJUD3Jo3ylcUtPaW70RmJAK2drSKBp6yyA2qxV1dKwIk7lMMpxLtieFl/57G/127vWm6wTpHsznueaE7GZeZrnO/XRKu592AY7Z8akjZDfS/IYtVqnvF4KYyVjhHZxDBYpNM1o2H6pbp37tgZMBtTP9X8PvbEAM78tK1U2e/gipD71eQrbCCLJfxXy2TN1DDFUw3AdZHOUZksLBBGw3iGxs4WCoDAj/hfYgdewPwTkJh+Mf9ZAjZh8eIq9EWnwjAxzx8NAm8g/mdDnR9iYxpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxB92oFlEnOstlUb2jCTCTIQ1W2TfTyUxTXyxU5tR6M=;
 b=YEMd5NJUTo6+n0m4QYgqjBf3Ueo0x8NY1upLgsJh58kVjwyatZlFARYB3qtbaBrpTf78O7VcdCwy2qr4XWGQIhbgoe2hB2VjUsA/zd066ttH248+l93AkIGu2amLBLfiTplT8xXiQaQVpOchPI/1gDh11Bdh/Y2K26QVY2vIRcgwk8l/Xq2VLoB6eMO5N/gZXHAyyXNA0qsFATnDfaQqsA8uoGzcLQBnIVIrlArvUQ6cKG6FApu7XByX/8F3LUnissqoFjciP8dUKB4Vj6VrFLJYjUpaclJKhzgvCAe1kJQDcECeQX3+5zSryyDX9n8esSjqNnnUJVosNuaDIcqzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxB92oFlEnOstlUb2jCTCTIQ1W2TfTyUxTXyxU5tR6M=;
 b=IBIg9LPMRS2DTwmSa8KpFoyHr9XO1yY1SQxyoHiJ8p5m/RxdJ5KT1FiubvfXa6NsTyR1Y27R8qTKsk36PWq6MAlbkSdWZad1DI4wKW/4jJl1D2F2lONF1o/o3300a0injjjFRIJ1CWkaInf+EC1AdVLc7AbjPUyu9IVwx8nho4w=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 22:20:06 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::a11b:61fb:cdea:424a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::a11b:61fb:cdea:424a%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 22:20:06 +0000
Message-ID: <1fdf73cb-f23e-0c34-f95f-f1bac74332da@oracle.com>
Date: Wed, 19 Jul 2023 15:20:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does not
 support it
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Shannon Nelson <shannon.nelson@amd.com>
References: <20230703142218.362549-1-eperezma@redhat.com>
 <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
 <20230704114159-mutt-send-email-mst@kernel.org>
 <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
 <CAJaqyWd0QC6x9WHBT0x9beZyC8ZrF2y=d9HvmT0+05RtGc8_og@mail.gmail.com>
 <eff34828-545b-956b-f400-89b585706fe4@amd.com>
 <20230706020603-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230706020603-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SA9PR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:806:6e::19) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CO1PR10MB4722:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d425658-0544-44e1-ba90-08db88a64e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nP+33mMYMaxmqFo+WsxvRwmbGQj/Gasq/4z8zNP+7mINQl5PW9YVazM5ikN5+Q/+EdJIzz4dUAg4xQjHSvbfPeZBYmNxQ1OBfw5CLpLhIJTikwexuMRbP+8CIqyGMYG+ZfBGz4LOBqwa465DbgQxZ2qoO1lqKpSkez7gY/IkgBBp88I5MGCz7/BOTNmoh0dcRKBVnfNMh8sWcHXZ7xVc+Lh2+jw9sRly92Tz8cNMfXgbVuV2CHyUpFS/pUTL12GmZ91kJOeLTJ2Y1jrKSmJFKVU5P7Wuai5dQZyYLxQM/SFERB7Y4j9iePRNJJzX93D9b+sFzMUnwWqtrdEpz90LvMr8jKbHz2oB3jcHJN22j4Ia+SrAYmWy4DIKfxcnGSXfPQlMufwltQp5oso682Awxrwz8TxRqLHTgc/LFHXszhh9Lt4KNXR1jJwkG/ZpCbYysRPZuf23HYOs4bbXtBL3OSKWdhY6kAC1uU5Nn6eFSX8VVAPv/qEk0Yjrzlzh5fZ5fbxS/Iy2T+fdXnSgxXVWrLjlXm6XDlWMQGVwGSrnW/OhiliRFGMvHxTzyD9W+GriemDKLjtO8UC8OQ8B3BFECQzV3G1DhH4vG23auTkrHtRKxSwTkjeQNEFg986IrXRVYSlsPFqkzZRTexolO3TB/LR6HN9abKCGboJwJDGsYov4JOPJBDsSDfyb7XHZH6v0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199021)(53546011)(36756003)(478600001)(110136005)(66899021)(6666004)(6512007)(6486002)(966005)(36916002)(186003)(26005)(6506007)(86362001)(31696002)(41300700001)(66946007)(4326008)(316002)(66556008)(66476007)(31686004)(8936002)(8676002)(38100700002)(5660300002)(2616005)(66574015)(2906002)(84970400001)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTF6by9uOFBYMHdneW10cE1ZVTh5eUVnVjI3TTc1bG9CVUZuajNHZndLa29t?=
 =?utf-8?B?UGZRSnJrMnhZbmxKaHR3cjJKTzNPTmsyZjFuVkxUWEt1ajVGRlRVOWpmeVZi?=
 =?utf-8?B?eFBUR2ZnRk5SWjJvQTVYRlduNWlnN2FuTFVOQTAvUDVCRXpPbFNaaGxwcDA3?=
 =?utf-8?B?VEd1NnN0eEZJR1dqeERoNkQ2UlNVTGl0MjVVSlR3YzUzNEhYcjVrU2NPVjlS?=
 =?utf-8?B?a3BwZGlrREEzak0weEtmd2JRbm01a2hDbHFMNlI2aThBcTNzdGpUNjNJOGpI?=
 =?utf-8?B?YmRtUnFDdy8vcWJjSmJ1dGhQV0JkcE1kQ0JkWC8wVWVKZzU3TENVelBiTDNW?=
 =?utf-8?B?L25rc2NuZXFhaEkyZmRJdnlLTFZUL3BiREpwUy9ocVF0MDBObVNoZUp2ZVR4?=
 =?utf-8?B?bUs3d3pSV01vemphVUx6VTVaMWpKK3hBU3JLSjZyTkpUVkFmZ25OZXArNitI?=
 =?utf-8?B?QTBXTVQxcWhqV2Jjczk3T1BzRzdQY3o2aXZzbGx0Qk9NZFFwVzQxaEZIT3dk?=
 =?utf-8?B?eDYrMnR5TTdkOHphWm83cG9pNUVmQlBNSDM4SG8xV3F4dmpJUHN2SVZzNHhL?=
 =?utf-8?B?N0IwM3d5NkxNWC96ZVJJTjlzUnNaNnFCTE9odHV3WTlCaEhkR1JVdkN4alUw?=
 =?utf-8?B?TC8wOFk0Vm1ZWVdSdkF1NkNPYnZFc1RoWGNRUVhLRDFDalU3dlFHalB4OCt5?=
 =?utf-8?B?WGVTTm1lRzJvVHgvRVFRbXhvdWJpV3BzT2htNXhGeStLL29LZnlFRkx6YlBD?=
 =?utf-8?B?eUZ6S0V4NXpYTXo1ODZmd1dSSEE4K2dsSHUzaVhyTmRLb1RDZHRZemxJMW9p?=
 =?utf-8?B?UWdFdVpZTkM3SUVOZjRkbzlVL3cyamdhTU5uU2pvRFlNa2xpQ0pIWGJXRFRS?=
 =?utf-8?B?MFNHVFNtbjZQcktpWkx4clhTZWk5NmhYRGdlSmpHWCthbjE1VzQ2TXpsLzRF?=
 =?utf-8?B?WElNUWxkVHc5SFN3bnNRTk5zRXlyS09uNXEzdXV4NFBuZ0Z4cC9PZnRrdmc5?=
 =?utf-8?B?aHdJeSttZWNvMHpMYXoxQ1Z0U2FlZG1Tc2MzOXJkZ0lINmlBWEx6TkgrNEZn?=
 =?utf-8?B?SnRtZS9oL3NGWDRPWG5JcHArS2R4Vy9udy9tb2ZDNm5BazBwZnFMTjdGTHlZ?=
 =?utf-8?B?VDZtTGRQTEJnd2I2YkdSVHN1RVBsVEhMZGUwelU0M3htRHdHTE5waHJVYUN6?=
 =?utf-8?B?QjJiRktIL0hzTE8xMlA4V29UWHRpdmQ2QjFvcndQZyswdFlYRjArRU5YNE5R?=
 =?utf-8?B?dC9pY2VuSVhUNzh6OThpRDJNQ0VBaWZnRXg4ZFQ3QlR6KzRzU2hBWXZ4M2tJ?=
 =?utf-8?B?ZnNoeThmNVBPUnFjUkJvSFZKT0ljL0hQR0FyVTFCRW80K2k2cSt6YkRrQUl6?=
 =?utf-8?B?R1M5ZFJSWWVZZHpVdFF1RDhaVXg3WGI5SHZ3bURyaFA3MTVzdjdPQVArcWtQ?=
 =?utf-8?B?dFVxcXE3QUNRZ0dYRkhod3NZWjhJbWsvdG1WMi9kMGg4UVdkL2l3NWliMzI2?=
 =?utf-8?B?K0tqUzZkOFF4WHhiVCtVM2x6QTl0L3BTMnRJZDNxeFNIaWM5cGoxbmZuYlBz?=
 =?utf-8?B?Mklwa1o2cmZzd2NTdmtQV2YxNldkTkRaN09PYXcxTGkzRDh5OHQrY1Q3SmhW?=
 =?utf-8?B?NGtPOVBYZzZ2MFlXUUNTZXFwWEQvWThWV25YNDdEeHI4Q0xvaGpaNDBKNnY1?=
 =?utf-8?B?REJ5UFNwVEZGbExRRzlyNkRBOC9TWUxFOTlHcTByWXpBZlVORVdBcmhYbE5a?=
 =?utf-8?B?SGtqMzhEdXRuVmgzTnZJZTZVeHUva09TWFB1SnVxcWNtWHppWFJva1U1dTd1?=
 =?utf-8?B?U2RKcm03T3hmclRWOGE2RVBpcnpzeVQ2dkx4dEpobnJ0RXdoT3cwSndIWjRy?=
 =?utf-8?B?NHZDYzlxTXBDT2dQMTU0cW5QaTF6NDQvUXNTQVZpVEZQbThtUFhBbEg3VU5l?=
 =?utf-8?B?SGJqcGlHRHphUjFKU3JuRzJjVUdLa3I2aFgxRlczNzBKUDVDVWtKMmJOZksx?=
 =?utf-8?B?ZzBBSTlEYnFUQkhuWXhkeUw0MXhJVzFYdjZRdDIyQnZ3bzk3ajd1UEFYaG5r?=
 =?utf-8?B?ODk1eWQ5ZnhqLzBtOGVha2R2Snd0UkVoMXk4RWYzWXNvZ1gySjJrUVkvK1FD?=
 =?utf-8?Q?JgmozVpzrN6R2cFjXkjnbhki+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: V/d1MyE72PcyFYyvWYe5PzGQ3ixiNsFe/dCpKjbzXOojzBpJpet3rird4DiR36X5BWhWPSXq9WiPBEEw1bL8J1l+q2OAskdw2D9F5enC66ugFNmCNMA8XcZHkCu30NzOMbeKn7zlibbFPz5WQT3z4UbgRklTIQC2pg6GVhQ3YYA2OpY4CeXSXVimKETYqzarIjaCKpN4DJiMBTiTBmdN2jibhkTJ6I3M1NizhPAB0mFNBPNSIxfKfE3AcECfMLSo29c/Svo+W/WpFUIR2sbk7wuXTiFFdGhA7u333Mhve6HOICaM3rdQnE0x0IMG5kTUoRQ1FscTq6nxLaEfq8Zl8V8VlFoDZ7WSUeWUpO0RhA7wIlJslF+zpre6DZFWrzT1bisrZJMmN9Utan0kIwVxeBPRtBSd0uERic8RPsTuZTTMzlp9FZXZaiANsKcejrsp7dEb2RBaSWytPFiFE7jX3N3ebc2MjEh+pVQJUnYvERiDWC83bn418Pq580D072fPm/mA2pMDqS4/mDGMHkrpk1ljL68qUohpQgi7cpO58GUaHEjJRoh2DAXBYA+pwEKWLj+4WEM6zVMGz4LT8NnGUojACbQGLCbmogwZ7NthIrq6RIPEN8bBozKajIvPPzuPw4W4HS3gwnV0hNx3xMt7/SNdQrXNdMfEn+xVh6VN2zxKnRLaFDir2pMV9UjMWVf3Fr7+15HBLu91tbQ+8nfW+8m0tOAn3Lqw++JYxsBPLbrFzpr3z6BLweSRjko4oQckO9ZUKy4XtOgz3P6eRSqnBoazvt9GH5Ncmeu8ra1WcsFtFFUAvhgs+nG9tRWd2o83F8t3VnD2xmWI7YorXoNIdrTMEsmhv1G3L0pS0pVZnue1UDh4GvcHn4DR1HNNa086
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d425658-0544-44e1-ba90-08db88a64e8c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 22:20:06.8827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mSGvvdMfSRzd6BSFxnybB2pDTV5RAQczAClxFAzlogkq7evo5XH3BnH+l5aQ70OP/VAHgXgdbUSntUe+zGRAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4722
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190201
X-Proofpoint-GUID: TXPq1pf1swUxewoNCWLAnV5US7xgdc-g
X-Proofpoint-ORIG-GUID: TXPq1pf1swUxewoNCWLAnV5US7xgdc-g
Cc: netdev@vger.kernel.org, Eugenio Perez Martin <eperezma@redhat.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CgpPbiA3LzUvMjAyMyAxMTowNyBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIFdl
ZCwgSnVsIDA1LCAyMDIzIGF0IDA1OjA3OjExUE0gLTA3MDAsIFNoYW5ub24gTmVsc29uIHdyb3Rl
Ogo+PiBPbiA3LzUvMjMgMTE6MjcgQU0sIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+Pj4g
T24gV2VkLCBKdWwgNSwgMjAyMyBhdCA5OjUw4oCvQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4+Pj4gT24gVHVlLCBKdWwgNCwgMjAyMyBhdCAxMTo0NeKAr1BNIE1p
Y2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+PiBPbiBUdWUsIEp1
bCAwNCwgMjAyMyBhdCAwMTozNjoxMVBNICswMjAwLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3cm90
ZToKPj4+Pj4+IE9uIFR1ZSwgSnVsIDQsIDIwMjMgYXQgMTI6MzjigK9QTSBNaWNoYWVsIFMuIFRz
aXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+PiBPbiBUdWUsIEp1bCAwNCwgMjAy
MyBhdCAxMjoyNTozMlBNICswMjAwLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3cm90ZToKPj4+Pj4+
Pj4gT24gTW9uLCBKdWwgMywgMjAyMyBhdCA0OjUy4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxt
c3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4+Pj4+PiBPbiBNb24sIEp1bCAwMywgMjAyMyBhdCAw
NDoyMjoxOFBNICswMjAwLCBFdWdlbmlvIFDDqXJleiB3cm90ZToKPj4+Pj4+Pj4+PiBXaXRoIHRo
ZSBjdXJyZW50IGNvZGUgaXQgaXMgYWNjZXB0ZWQgYXMgbG9uZyBhcyB1c2VybGFuZCBzZW5kIGl0
Lgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gQWx0aG91Z2ggdXNlcmxhbmQgc2hvdWxkIG5vdCBzZXQg
YSBmZWF0dXJlIGZsYWcgdGhhdCBoYXMgbm90IGJlZW4KPj4+Pj4+Pj4+PiBvZmZlcmVkIHRvIGl0
IHdpdGggVkhPU1RfR0VUX0JBQ0tFTkRfRkVBVFVSRVMsIHRoZSBjdXJyZW50IGNvZGUgd2lsbCBu
b3QKPj4+Pj4+Pj4+PiBjb21wbGFpbiBmb3IgaXQuCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBTaW5j
ZSB0aGVyZSBpcyBubyBzcGVjaWZpYyByZWFzb24gZm9yIGFueSBwYXJlbnQgdG8gcmVqZWN0IHRo
YXQgYmFja2VuZAo+Pj4+Pj4+Pj4+IGZlYXR1cmUgYml0IHdoZW4gaXQgaGFzIGJlZW4gcHJvcG9z
ZWQsIGxldCdzIGNvbnRyb2wgaXQgYXQgdmRwYSBmcm9udGVuZAo+Pj4+Pj4+Pj4+IGxldmVsLiBG
dXR1cmUgcGF0Y2hlcyBtYXkgbW92ZSB0aGlzIGNvbnRyb2wgdG8gdGhlIHBhcmVudCBkcml2ZXIu
Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBGaXhlczogOTY3ODAwZDJkNTJlICgidmRwYTogYWNjZXB0
IFZIT1NUX0JBQ0tFTkRfRl9FTkFCTEVfQUZURVJfRFJJVkVSX09LIGJhY2tlbmQgZmVhdHVyZSIp
Cj4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhh
dC5jb20+Cj4+Pj4+Pj4+PiBQbGVhc2UgZG8gc2VuZCB2My4gQW5kIGFnYWluLCBJIGRvbid0IHdh
bnQgdG8gc2VuZCAiYWZ0ZXIgZHJpdmVyIG9rIiBoYWNrCj4+Pj4+Pj4+PiB1cHN0cmVhbSBhdCBh
bGwsIEkgbWVyZ2VkIGl0IGluIG5leHQganVzdCB0byBnaXZlIGl0IHNvbWUgdGVzdGluZy4KPj4+
Pj4+Pj4+IFdlIHdhbnQgUklOR19BQ0NFU1NfQUZURVJfS0lDSyBvciBzb21lIHN1Y2guCj4+Pj4+
Pj4+Pgo+Pj4+Pj4+PiBDdXJyZW50IGRldmljZXMgZG8gbm90IHN1cHBvcnQgdGhhdCBzZW1hbnRp
Yy4KPj4+Pj4+PiBXaGljaCBkZXZpY2VzIHNwZWNpZmljYWxseSBhY2Nlc3MgdGhlIHJpbmcgYWZ0
ZXIgRFJJVkVSX09LIGJ1dCBiZWZvcmUKPj4+Pj4+PiBhIGtpY2s/Cj4+IFRoZSBQRFMgdmRwYSBk
ZXZpY2UgY2FuIGRlYWwgd2l0aCBhIGNhbGwgdG8gLnNldF92cV9yZWFkeSBhZnRlciBEUklWRVJf
T0sgaXMKPj4gc2V0LiAgQW5kIEknbSB0b2xkIHRoYXQgb3VyIFZRIGFjdGl2aXR5IHNob3VsZCBz
dGFydCB3aXRob3V0IGEga2ljay4KPj4KPj4gT3VyIHZkcGEgZGV2aWNlIEZXIGRvZXNuJ3QgY3Vy
cmVudGx5IGhhdmUgc3VwcG9ydCBmb3IgVklSVElPX0ZfUklOR19SRVNFVCwKPj4gYnV0IEkgYmVs
aWV2ZSBpdCBjb3VsZCBiZSBhZGRlZCB3aXRob3V0IHRvbyBtdWNoIHRyb3VibGUuCj4+Cj4+IHNs
bgo+Pgo+IE9LIGl0IHNlZW1zIGNsZWFyIGF0IGxlYXN0IGluIHRoZSBjdXJyZW50IHZlcnNpb24g
cGRzIG5lZWRzCj4gVkhPU1RfQkFDS0VORF9GX0VOQUJMRV9BRlRFUl9EUklWRVJfT0suCj4gSG93
ZXZlciBjYW4gd2UgYWxzbyBjb2RlIHVwIHRoZSBSSU5HX1JFU0VUIHBhdGggYXMgdGhlIGRlZmF1
bHQ/CldoYXQncyB0aGUgcmF0aW9uYWxlIG9mIG1ha2luZyBSSU5HX1JFU0VUIHBhdGggdGhlIGRl
ZmF1bHQ/IE5vdGVkIHRoaXMgCmlzIG9uIGEgcGVyZm9ybWFuY2UgY3JpdGljYWwgcGF0aCAoZm9y
IGxpdmUgbWlncmF0aW9uIGRvd250aW1lKSwgZGlkIHdlIApldmVyIGdldCBjb25zZW5zdXMgZnJv
bSBldmVyeSBvciBtb3N0IGhhcmR3YXJlIHZlbmRvcnMgdGhhdCBSSU5HX1JFU0VUIApoYXMgbG93
ZXIgY29zdCBpbiB0ZXJtcyBvZiBsYXRlbmN5IG92ZXJhbGwgdGhhbiBFTkFCTEVfQUZURVJfRFJJ
VkVSX09LPyAKSSB0aGluayAoUklORylSRVNFVCBpbiBnZW5lcmFsIGZhbGxzIG9uIHRoZSBzbG93
IHBhdGggZm9yIGhhcmR3YXJlLCAKd2hpbGUgSSBhc3N1bWUgZWl0aGVyIFJJTkdfUkVTRVQgb3Ig
RU5BQkxFX0FGVEVSX0RSSVZFUl9PSyBkb2Vzbid0IAptYXR0ZXJzIG11Y2ggb24gc29mdHdhcmUg
YmFja2VkIHZkcGEgZS5nLiB2cF92ZHBhLiBNYXliZSBzaG91bGQgbWFrZSAKRU5BQkxFX0FGVEVS
X0RSSVZFUl9PSyBhcyB0aGUgZGVmYXVsdD8KCi1TaXdlaQoKPiBUaGVuIGRvd24gdGhlIHJvYWQg
dmVuZG9ycyBjYW4gY2hvb3NlIHdoYXQgdG8gZG8uCj4KPgo+Cj4KPgo+Pj4+Pj4gUHJldmlvdXMg
dmVyc2lvbnMgb2YgdGhlIFFFTVUgTE0gc2VyaWVzIGRpZCBhIHNwdXJpb3VzIGtpY2sgdG8gc3Rh
cnQKPj4+Pj4+IHRyYWZmaWMgYXQgdGhlIExNIGRlc3RpbmF0aW9uIFsxXS4gV2hlbiBpdCB3YXMg
cHJvcG9zZWQsIHRoYXQgc3B1cmlvdXMKPj4+Pj4+IGtpY2sgd2FzIHJlbW92ZWQgZnJvbSB0aGUg
c2VyaWVzIGJlY2F1c2UgdG8gY2hlY2sgZm9yIGRlc2NyaXB0b3JzCj4+Pj4+PiBhZnRlciBkcml2
ZXJfb2ssIGV2ZW4gd2l0aG91dCBhIGtpY2ssIHdhcyBjb25zaWRlcmVkIHdvcmsgb2YgdGhlCj4+
Pj4+PiBwYXJlbnQgZHJpdmVyLgo+Pj4+Pj4KPj4+Pj4+IEknbSBvayB0byBnbyBiYWNrIHRvIHRo
aXMgc3B1cmlvdXMga2ljaywgYnV0IEknbSBub3Qgc3VyZSBpZiB0aGUgaHcKPj4+Pj4+IHdpbGwg
cmVhZCB0aGUgcmluZyBiZWZvcmUgdGhlIGtpY2sgYWN0dWFsbHkuIEkgY2FuIGFzay4KPj4+Pj4+
Cj4+Pj4+PiBUaGFua3MhCj4+Pj4+Pgo+Pj4+Pj4gWzFdIGh0dHBzOi8vbGlzdHMubm9uZ251Lm9y
Zy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDIzLTAxL21zZzAyNzc1Lmh0bWwKPj4+Pj4gTGV0
J3MgZmluZCBvdXQuIFdlIG5lZWQgdG8gY2hlY2sgZm9yIEVOQUJMRV9BRlRFUl9EUklWRVJfT0sg
dG9vLCBubz8KPj4+PiBNeSB1bmRlcnN0YW5kaW5nIGlzIFsxXSBhc3N1bWluZyBBQ0NFU1NfQUZU
RVJfS0lDSy4gVGhpcyBzZWVtcwo+Pj4+IHN1Yi1vcHRpbWFsIHRoYW4gYXNzdW1pbmcgRU5BQkxF
X0FGVEVSX0RSSVZFUl9PSy4KPj4+Pgo+Pj4+IEJ1dCB0aGlzIHJlbWluZHMgbWUgb25lIHRoaW5n
LCBhcyB0aGUgdGhyZWFkIGlzIGdvaW5nIHRvbyBsb25nLCBJCj4+Pj4gd29uZGVyIGlmIHdlIHNp
bXBseSBhc3N1bWUgRU5BQkxFX0FGVEVSX0RSSVZFUl9PSyBpZiBSSU5HX1JFU0VUIGlzCj4+Pj4g
c3VwcG9ydGVkPwo+Pj4+Cj4+PiBUaGUgcHJvYmxlbSB3aXRoIHRoYXQgaXMgdGhhdCB0aGUgZGV2
aWNlIG5lZWRzIHRvIHN1cHBvcnQgYWxsCj4+PiBSSU5HX1JFU0VULCBsaWtlIHRvIGJlIGFibGUg
dG8gY2hhbmdlIHZxIGFkZHJlc3MgZXRjIGFmdGVyIERSSVZFUl9PSy4KPj4+IE5vdCBhbGwgSFcg
c3VwcG9ydCBpdC4KPj4+Cj4+PiBXZSBqdXN0IG5lZWQgdGhlIHN1YnNldCBvZiBoYXZpbmcgdGhl
IGRhdGFwbGFuZSBmcmVlemVkIHVudGlsIGFsbCBDVlEKPj4+IGNvbW1hbmRzIGhhdmUgYmVlbiBj
b25zdW1lZC4gSSdtIHN1cmUgY3VycmVudCB2RFBBIGNvZGUgYWxyZWFkeQo+Pj4gc3VwcG9ydHMg
aXQgaW4gc29tZSBkZXZpY2VzLCBsaWtlIE1MWCBhbmQgUFNELgo+Pj4KPj4+IFRoYW5rcyEKPj4+
Cj4+Pj4gVGhhbmtzCj4+Pj4KPj4+Pj4KPj4+Pj4KPj4+Pj4+Pj4gTXkgcGxhbiB3YXMgdG8gY29u
dmVydAo+Pj4+Pj4+PiBpdCBpbiB2cF92ZHBhIGlmIG5lZWRlZCwgYW5kIHJldXNlIHRoZSBjdXJy
ZW50IHZkcGEgb3BzLiBTb3JyeSBpZiBJCj4+Pj4+Pj4+IHdhcyBub3QgZXhwbGljaXQgZW5vdWdo
Lgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBUaGUgb25seSBzb2x1dGlvbiBJIGNhbiBzZWUgdG8gdGhhdCBp
cyB0byB0cmFwICYgZW11bGF0ZSBpbiB0aGUgdmRwYQo+Pj4+Pj4+PiAocGFyZW50PykgZHJpdmVy
LCBhcyB0YWxrZWQgaW4gdmlydGlvLWNvbW1lbnQuIEJ1dCB0aGF0IGNvbXBsaWNhdGVzCj4+Pj4+
Pj4+IHRoZSBhcmNoaXRlY3R1cmU6Cj4+Pj4+Pj4+ICogT2ZmZXIgVkhPU1RfQkFDS0VORF9GX1JJ
TkdfQUNDRVNTX0FGVEVSX0tJQ0sKPj4+Pj4+Pj4gKiBTdG9yZSB2cSBlbmFibGUgc3RhdGUgc2Vw
YXJhdGVseSwgYXQKPj4+Pj4+Pj4gdmRwYS0+Y29uZmlnLT5zZXRfdnFfcmVhZHkodHJ1ZSksIGJ1
dCBub3QgdHJhbnNtaXQgdGhhdCBlbmFibGUgdG8gaHcKPj4+Pj4+Pj4gKiBTdG9yZSB0aGUgZG9v
cmJlbGwgc3RhdGUgc2VwYXJhdGVseSwgYnV0IGRvIG5vdCBjb25maWd1cmUgaXQgdG8gdGhlCj4+
Pj4+Pj4+IGRldmljZSBkaXJlY3RseS4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gQnV0IGhvdyB0byByZWNv
dmVyIGlmIHRoZSBkZXZpY2UgY2Fubm90IGNvbmZpZ3VyZSB0aGVtIGF0IGtpY2sgdGltZSwKPj4+
Pj4+Pj4gZm9yIGV4YW1wbGU/Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IE1heWJlIHdlIGNhbiBqdXN0IGZh
aWwgaWYgdGhlIHBhcmVudCBkcml2ZXIgZG9lcyBub3Qgc3VwcG9ydCBlbmFibGluZwo+Pj4+Pj4+
PiB0aGUgdnEgYWZ0ZXIgRFJJVkVSX09LPyBUaGF0IHdheSBubyBuZXcgZmVhdHVyZSBmbGFnIGlz
IG5lZWRlZC4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gVGhhbmtzIQo+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IC0t
LQo+Pj4+Pj4+Pj4+IFNlbnQgd2l0aCBGaXhlczogdGFnIHBvaW50aW5nIHRvIGdpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tc3QKPj4+Pj4+Pj4+PiBjb21taXQuIFBsZWFz
ZSBsZXQgbWUga25vdyBpZiBJIHNob3VsZCBzZW5kIGEgdjMgb2YgWzFdIGluc3RlYWQuCj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDYw
OTEyMTI0NC1tdXR0LXNlbmQtZW1haWwtbXN0QGtlcm5lbC5vcmcvVC8KPj4+Pj4+Pj4+PiAtLS0K
Pj4+Pj4+Pj4+PiAgICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDcgKysrKystLQo+Pj4+Pj4+Pj4+
ICAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2
ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+Pj4+Pj4+IGluZGV4IGUxYWJmMjlmZWQ1Yi4uYTdlNTU0MzUy
MzUxIDEwMDY0NAo+Pj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+Pj4+Pj4+
Pj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+Pj4+Pj4+PiBAQCAtNjgxLDE4ICs2ODEs
MjEgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV91bmxvY2tlZF9pb2N0bChzdHJ1Y3QgZmlsZSAq
ZmlsZXAsCj4+Pj4+Pj4+Pj4gICAgewo+Pj4+Pj4+Pj4+ICAgICAgICAgc3RydWN0IHZob3N0X3Zk
cGEgKnYgPSBmaWxlcC0+cHJpdmF0ZV9kYXRhOwo+Pj4+Pj4+Pj4+ICAgICAgICAgc3RydWN0IHZo
b3N0X2RldiAqZCA9ICZ2LT52ZGV2Owo+Pj4+Pj4+Pj4+ICsgICAgIGNvbnN0IHN0cnVjdCB2ZHBh
X2NvbmZpZ19vcHMgKm9wcyA9IHYtPnZkcGEtPmNvbmZpZzsKPj4+Pj4+Pj4+PiAgICAgICAgIHZv
aWQgX191c2VyICphcmdwID0gKHZvaWQgX191c2VyICopYXJnOwo+Pj4+Pj4+Pj4+ICAgICAgICAg
dTY0IF9fdXNlciAqZmVhdHVyZXAgPSBhcmdwOwo+Pj4+Pj4+Pj4+IC0gICAgIHU2NCBmZWF0dXJl
czsKPj4+Pj4+Pj4+PiArICAgICB1NjQgZmVhdHVyZXMsIHBhcmVudF9mZWF0dXJlcyA9IDA7Cj4+
Pj4+Pj4+Pj4gICAgICAgICBsb25nIHIgPSAwOwo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gICAgICAg
ICBpZiAoY21kID09IFZIT1NUX1NFVF9CQUNLRU5EX0ZFQVRVUkVTKSB7Cj4+Pj4+Pj4+Pj4gICAg
ICAgICAgICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcigmZmVhdHVyZXMsIGZlYXR1cmVwLCBzaXpl
b2YoZmVhdHVyZXMpKSkKPj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
LUVGQVVMVDsKPj4+Pj4+Pj4+PiArICAgICAgICAgICAgIGlmIChvcHMtPmdldF9iYWNrZW5kX2Zl
YXR1cmVzKQo+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBwYXJlbnRfZmVhdHVyZXMg
PSBvcHMtPmdldF9iYWNrZW5kX2ZlYXR1cmVzKHYtPnZkcGEpOwo+Pj4+Pj4+Pj4+ICAgICAgICAg
ICAgICAgICBpZiAoZmVhdHVyZXMgJiB+KFZIT1NUX1ZEUEFfQkFDS0VORF9GRUFUVVJFUyB8Cj4+
Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQklUX1VMTChWSE9TVF9C
QUNLRU5EX0ZfU1VTUEVORCkgfAo+Pj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1JFU1VNRSkgfAo+Pj4+Pj4+Pj4+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9FTkFCTEVf
QUZURVJfRFJJVkVSX09LKSkpCj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHBhcmVudF9mZWF0dXJlcykpCj4+Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIC1FT1BOT1RTVVBQOwo+Pj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICBpZiAoKGZlYXR1
cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfU1VTUEVORCkpICYmCj4+Pj4+Pj4+Pj4gICAg
ICAgICAgICAgICAgICAgICAgIXZob3N0X3ZkcGFfY2FuX3N1c3BlbmQodikpCj4+Pj4+Pj4+Pj4g
LS0KPj4+Pj4+Pj4+PiAyLjM5LjMKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwo+IFZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdAo+IFZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
