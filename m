Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E31C00A8F
	for <virtualization@archiver.kernel.org>; Tue, 24 Oct 2023 17:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88F714EFB3;
	Tue, 24 Oct 2023 17:27:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88F714EFB3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=i75/UWfs;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=PLFyPd9v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L6lyjsNcLhp8; Tue, 24 Oct 2023 17:27:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 96AFB4EF90;
	Tue, 24 Oct 2023 17:27:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 96AFB4EF90
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AD05C0071;
	Tue, 24 Oct 2023 17:27:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCD2CC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 17:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B12966FC43
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 17:27:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B12966FC43
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=i75/UWfs; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=PLFyPd9v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g3E9ePwJb5G2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 17:27:33 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 646AF6FC52
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 17:27:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 646AF6FC52
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OHR96h008011; Tue, 24 Oct 2023 17:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vQ10P3zIuZisLoaveRHNnGUDtux4PE3YWfataqyyFBo=;
 b=i75/UWfsjlOh0vJXh4uKwbSbyqg/lbbhmBAq0WlOiL8o0dpcjy/loWEu7x2jxuBo5L5E
 OtZSRsF5S51RHkMGgjNsD3Yhunryt0YFWUgvxcAtaZPZ6wqR8xMAhkpXbD+GkcYNzm7S
 aYeowi8/JVwk/rdHMRivKLjclhbeiFI1x/lt5iJvPtIYVWU5ZVXjf8JXH7r3p9tb+Hhc
 M60srZKnKahUj9yB7bAsAhp4+OOpiWe8QuUqhLMTsMf3t2dZIhxFm6XBadi92jaU30O/
 rm8SQ4b1PU3SF+MwikYNQ5cb//mJFE36X347lHT/Q8ys0tzVIMC4VFWVogS8YJeiwHAl cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5jbe1pp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 17:27:32 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39OH0ST5014155; Tue, 24 Oct 2023 17:27:31 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tvbfjtwsd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 17:27:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vaeemo1+iTXDM6iYi+a+xJjTLcm8Zu6MbL77t7iL/A7wQrupYcvz5t4mGY5hZg4ng6vrYM4jp+xDPWRq+BZqlbn6RK0iZajpFUManZ9cnhImSA2NuvLB2n7tDEqt1/tflMG4LvmOVQllHyQ2jvR/Njwl3s00dnBYrpAlbeYxw31xWDoPjTldgcGdC9ZwK5cKhxyN4ErSeFmWq58KYaDNVKQSgAmRO31B0vCzWsH+CKGyTPXTlH/74Bx8khRqhOWJOrfseNdQjz6uJ3jzxCNYaRJrhQmmwrRwJS/fUsBDFDWJy1yruDE7nsY4j60SKIWuuocxhRI8G25+bQFC3lfOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQ10P3zIuZisLoaveRHNnGUDtux4PE3YWfataqyyFBo=;
 b=bMShoVsgMDtHaAuNV0/UqMOBtuVDdGDZ4NlfpjZ1HM08/5y7nGfmuBNzyIZWRASN86xa0PMX4P0meux4pV2OYD0F6U+B/Qfk/yRABYKHQNGx824HhuM2wFYyHIRMWQbxtO1jVMTvHlnWo23AnedYfrzlyF+By2bagexgYyFY2eCIZ6Mjl9IBfF/JnomUAKCpSxa/Qpb1N91+b2UitgxsWQCocPwLSFRMK7GuxXBwJVPwUkSLzZRc9w9aYch0nKNdvJBiYsHtSn3L6RCi50HqZoA9zFlaZBsWZNvIhxMHPrs4jPNscrliRW+PxJodipLSy+DqbpKR62FqWRtRZeMlng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQ10P3zIuZisLoaveRHNnGUDtux4PE3YWfataqyyFBo=;
 b=PLFyPd9v3xyoxrk8k3et9JYxweQy5QNa6Dvg7h7ofcipn5D0mQTFPbXNa7wFnmkNZ/xxzed/0UuDnuPWcuF6TCF3Gz/0ihzz8j9+Uuqrcv0YDA+vX06tc4gd4qC7F3iiUr6bw5E2CDAsN/ufenF8sbszv6evI32EUbn7XfN3I+c=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH0PR10MB4600.namprd10.prod.outlook.com (2603:10b6:510:36::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 17:27:29 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 17:27:29 +0000
Message-ID: <b5dadd3d-8806-4d72-90c4-ee1ba6446c3a@oracle.com>
Date: Tue, 24 Oct 2023 10:27:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] vdpa: decouple reset of iotlb mapping from device
 reset
Content-Language: en-US
To: Lei Yang <leiyang@redhat.com>
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvkSFcHXC0HFw-NoDtDNnaucJbpfPO0Yho2r1QP8F6zSw@mail.gmail.com>
 <4d03661b-4289-46e7-8760-32a186783b73@oracle.com>
 <CAPpAL=za9VKy2csCPKOKHEKe3qGDQ=89n_08G_MWd7XMiNpUvQ@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAPpAL=za9VKy2csCPKOKHEKe3qGDQ=89n_08G_MWd7XMiNpUvQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::16) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH0PR10MB4600:EE_
X-MS-Office365-Filtering-Correlation-Id: c7bc4028-6bdd-44cd-8e74-08dbd4b67f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dRTzHhegye2klZzW74hh8jBU2fDgkyjUkZ2N3nhq8V55v8jWlcPEAR3VpGuXCkJsd3D1xIqBdbQhVXYKTTCdCb8HAD50xTPx7uOjooJGVAFhDzDQkS3kzQ9cVAh0SF4PNcbjlPKrW7GkC5CU9r7z/0+CCHzYt0GLSBu4SVh0PuS1d3gQgbgjjjQSBdhpB6xOCSTV6ATYnsKa3hTg3n12D78IJA/M5hy4HQinF0FoBB9ZJeS/IrgQ5Hzv8HtmKffxz5Vtgb1vj3Yv2GJ96fW6F0qYdIatm5my8Hl8yy5NVptWxke8CBYbU09UjaiV9Rw97dVaJKNYFD+U1Ifv56FAYfRQcifQImw9GLI/ofiFg8DSLWDUxPZViDlT0ab28Bpgg7pgWYSJpc9ryOBFr00P3VN+DeMPbFP53gjNbZAsJkKUKAbOF2Q075/a2MxRyrzMEj4aM8oqVbqLv0wAIFxn53GiiWptgWdDs5xqKD9jgQokmN+/4KmQVczmjid9h6NJ9OX+4fOvdTgfM+kmrB2dLGz5gLfOeuJIPZFlDcqyrPSKoZ1Wx88wYkV9z6atfInxYfwSew32LqY3F5PEqXgE7a1ZmnrtRNHDYTNZwKrWqWGqYa+3guoDe3Jf1u0W0ZJEum5PFfTb4Mmw4ujZnCJ8qPKrW2a8ceOHuQl7ywe46yk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(26005)(6512007)(2616005)(2906002)(316002)(66556008)(41300700001)(66476007)(4326008)(5660300002)(6916009)(8936002)(8676002)(36916002)(53546011)(6666004)(6506007)(6486002)(66946007)(478600001)(966005)(86362001)(38100700002)(31696002)(36756003)(31686004)(66899024)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzE3TFNSNVlCQlBnUWxXcGRMdGZoOVRGMU9RZHA5VkdGR0lSRlZlZUs4T2Z4?=
 =?utf-8?B?U093OVpzTWVJWnFVN1JkYVRyL0gvWTVCcVlVL0VXVnJTTzZlWjRNZVdEWnNw?=
 =?utf-8?B?bE1aTzdsNjI5dS9WNFVVekNLWXhra3FGUjM5UFA3VjhSSW9EVk5Gb2ZTdGI3?=
 =?utf-8?B?Y1VLMmczNEpQWnJnZW5iNnJCaWhXT3pSbkwvVUhCMHdXTWV0c3NRWFFQNUZO?=
 =?utf-8?B?b05sNUdidnJ4dStVeUN0L0ZKN0VJWFVSWnl1NG5HZmRFYnhxdG9kNVl6SnF4?=
 =?utf-8?B?YUEzSEIxbzZ2YjY2cGZkYnJldkJScktMbVNueU5pdVNnMkJ2Rm5LTEtJc0xl?=
 =?utf-8?B?OG9GZCttTS9MK3hTNWRtcmVTMkl3VHQ1VGR1endUNlZhS0hRd3FoenV5Kzly?=
 =?utf-8?B?U0t0Z0hGU0lKUndaYzl2b2JMVEZiVXJCNHExVUQvSkowdUFkZWgzUjBDbFd6?=
 =?utf-8?B?bFhLUmJBekZUZUlLR3FxMWZvdjBlRHhCU1V0L1hVbTdsY0ZiWG9FaHlmSG5K?=
 =?utf-8?B?Slh0UGdlazA4RDBsVk95aHIwV1BqNHNpZVdMWmViMSt6UEFtQUc1TytqVElk?=
 =?utf-8?B?WkxEYnVNdW1sb0J6LzdJWHJQUzRja21LdXZRVW1jSE90dXRTUjlqUFNBOExq?=
 =?utf-8?B?VWY1ckJRczdxb2hVUEU0WFhUNyt5NEIwK21NOUlTak01SFBWa1oxcm5aRFJB?=
 =?utf-8?B?WmlxOHZxaE5ackNmTHhZaHNIV2J4YnFHQTdhTDFWbDhoU2RiSFZzaGNjUWM5?=
 =?utf-8?B?Z3gxN0JBa0JaVU12UmthcmRRTUhwdm9ySkRtZURvbGtSZThHMldDTEROQ1Vi?=
 =?utf-8?B?OGNFN3F4c0dsTGxLSDRSR0xqQzdrMzg1UXNxVlM1OWh3c1l5M0owN0VpVzgx?=
 =?utf-8?B?U2t4MnBOaUhqZUVNMlhSRGduQjJlUHNreFYvamt0eVpPZFRoT3kyNTJkaDNE?=
 =?utf-8?B?aEcrWDRjWi9XczA1NWNRcloxeFlEUGJLcjNnNDM5M0w5ZW1aY1ppUlFPdUJz?=
 =?utf-8?B?VG1pOWZOdXhGdXhWazVIS3RJUllxK0xCTkVpVWdaWWhkbzZuWXpCUElZMTc3?=
 =?utf-8?B?WE5Zd0RwcVVNNHdVc0tYNFc3SC9lWERQNDBXa0pDOTFOS2Z3TzBtd2g5UW1y?=
 =?utf-8?B?L2p6endGMEc0YjNjaHQyd3grR1ZzVGRTeXd3MFBKUC9EMWxaRG91NmlvM0da?=
 =?utf-8?B?VVBrQXBXeXZDUTdCV01NQjk5SjAxbDV6RjBRUlE0WFRPcGYwRjdxV3dGUUZP?=
 =?utf-8?B?NVFNcDI0RWhOUDdXV1Boa1Z3ZmVyTEFZWEppck5jN2UxTkJzZjg2bGNDLytT?=
 =?utf-8?B?bmp0RlBCazBZc09Ca3RNVm5sSnA0YlllOFh6WmVwRWIrTzJGVmhyZUFjdXpT?=
 =?utf-8?B?UVgyRlRKanNhN0ErWEFoOGdhdmJjT2VWY0dWNmJHejUyR1ZmU1JUcm5jbDhU?=
 =?utf-8?B?S1lybGVWLzlqOW5uVnYxMkZsQnZLWVJ2SmpsKzZyanRZTUkwaFJURGFMKzM3?=
 =?utf-8?B?WW5GbzBNQVhnSWJwSjRWakVrTnVFb2lManB6ellNK0MzVW1zTlQxWUhMUDkw?=
 =?utf-8?B?TmRZQ09ObW9XS01aM0tnK3BJS1RjLzlTSmVxZWs2M1UvTnVTalk1bk9qV2hE?=
 =?utf-8?B?ZW9XV0xiSmIrOVpzMXlqTVB0YmFKcnpkTnpGUVB0Vk4rNE5ZdG5LemdEUml5?=
 =?utf-8?B?UndIKzl4THZCZ1ZmSENEZCthWU9qY0x5emVFUHFZZk1kaWx3NE5DSWEvUWFU?=
 =?utf-8?B?UWk4alVGWVdQV0dxckRUYUdldll4TlNWSlJUY1plVHdhTlJ3OXE5SFg3bHVH?=
 =?utf-8?B?UDhmOVhueTZZU0dCYzBQK1cxelIyS2JZazYvZCtaOGtqRzZVWGlqUThYL0Vl?=
 =?utf-8?B?aUp0NGRPSkhJWmF1Y255dzFJZmlpNjBvMkZZVUZ5MGVNVzNLY3g3ZGVXV3Zt?=
 =?utf-8?B?aDhIaHZpSng4TXFGQ0VvM09TNEc3aG9yS3lsbDBtZGRqTWFkS09RSkdxTzZO?=
 =?utf-8?B?b1ZIdHJ2dXhjQmg4MDZUbWJiTmRxY21zWVViaGFPQnFob2hqdDZhZ3lnMnRq?=
 =?utf-8?B?T2U5RUlmSHlYaFpXSkxlQ2tjL3R1TEYrR3RrTFRCcFNFS2RYdkdyTDJJV0wv?=
 =?utf-8?Q?zJ9YBVBUOS+uv3uLzITUZrg2H?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mN5xipHj1RVOQjckVmcXAIsyRX+2WEYIqw6TYVueIecfP4vhmQ+5FWsCq5HCDRbPzAlwrlJLbglnLmb7RDqReWVtF1Mx5VJrROxZrM9ndlVtN+UMyxDPTP7sFbjDVMCKyxtSsrO4NHjfd3pIbNJpb7VuFredW3xvmUBajKcUhpzd5UvXRD46DmW49ZTZc1uhEDlSWjscWFmQSf8U04DvJQse9Z3uuEHopIOp/S6fku7W1Uqn4eiYhGG8zjpgk6HpJXONMfww9KVosreXvVJZPELF8wbeX+r+h5bRys5YIaspJrUfO+LB+XHSO+y0qgl1v4po1NtupczSh/2XO/L5r7WEVRDu7thNRSc8kThGHP7fJ8SeZ+S4PwI/7rzgjGrJgCuMIwY+YayR0I1tBvyDfbkIq6PnBxOU6WOnNWqLeYADpFCPaIprg0ix+1OjC29tp2fOLrupJxp0wgpdkBDBP1cG8CvDeIjqD6z/Td5r+I1gmOIXJOnOZrmTMNpyA7AbaSHL7t1I2mWjj1sJEREdgJwEehb3vUXyxVRNlxMZTzC4X0fsoxFFH4zN7EJ8Jh2pLJCsBBXn0a+mIuCb92+6wUVn63q8hZjiuvDl2nFad/9wiDrfxDS32ZkRUErWLBd47tpH1cyZpUQrgUIL1edYI26Uekf15tRPWcDOo5/QkqotDGheG1zYE4KaBfnTzI+lkMlH84QYOI+F1U8JNiWcBwHB8UtfWrDTG3QvTJQku9PlJe2m4UxxugW4CZddPL9sducfvPw8J9uxWH0cGGmFmoeNJ7WOoDEJjUhMHMRmRdoL9Rkw9LCi59qUxCr1Hv0M6YEXhJ/tLUNqD4Ra+F8PPhwDzNfRqr4QNXAiZI0QYjoIOfzYy8H6ZFYDNNJy3DG89PXYwe7XFqKqKRcplUGSBA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bc4028-6bdd-44cd-8e74-08dbd4b67f2a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 17:27:28.8135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+eWVP2Upvg1MhfaIhmYP81fqASvcNSkH3Pkgc/BtBEOdLEfgfycUo+yHHw39iko1uDw2/Mxa51QbKFJkJJXHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_17,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240149
X-Proofpoint-GUID: Z0IMQNs5FYbqC8j_1X19yuN1j2PeGBn1
X-Proofpoint-ORIG-GUID: Z0IMQNs5FYbqC8j_1X19yuN1j2PeGBn1
Cc: mst@redhat.com, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

VGhhbmtzIGEgbG90IGZvciB0ZXN0aW5nISBQbGVhc2UgYmUgYXdhcmUgdGhhdCB0aGVyZSdzIGEg
Zm9sbG93LXVwIGZpeCAKZm9yIGEgcG90ZW50aWFsIG9vcHMgaW4gdGhpcyB2NCBzZXJpZXM6Cgpo
dHRwczovL2xvcmUua2VybmVsLm9yZy92aXJ0dWFsaXphdGlvbi8xNjk4MTAyODYzLTIxMTIyLTEt
Z2l0LXNlbmQtZW1haWwtc2ktd2VpLmxpdUBvcmFjbGUuY29tLwoKV291bGQgYmUgbmljZSB0byBo
YXZlIGl0IGFwcGxpZWQgZm9yIGFueSB0ZXN0cy4KClRoYW5rcywKLVNpd2VpCgpPbiAxMC8yMy8y
MDIzIDExOjUxIFBNLCBMZWkgWWFuZyB3cm90ZToKPiBRRSB0ZXN0ZWQgdGhpcyBzZXJpZXMgdjQg
d2l0aCByZWdyZXNzaW9uIHRlc3Rpbmcgb24gcmVhbCBuaWMsIHRoZXJlIGlzCj4gbm8gbmV3IHJl
Z3Jlc3Npb24gYnVnLgo+Cj4gVGVzdGVkLWJ5OiBMZWkgWWFuZyA8bGVpeWFuZ0ByZWRoYXQuY29t
Pgo+Cj4gT24gVHVlLCBPY3QgMjQsIDIwMjMgYXQgNjowMuKAr0FNIFNpLVdlaSBMaXUgPHNpLXdl
aS5saXVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4+Cj4+Cj4+IE9uIDEwLzIyLzIwMjMgODo1MSBQTSwg
SmFzb24gV2FuZyB3cm90ZToKPj4+IEhpIFNpLVdlaToKPj4+Cj4+PiBPbiBTYXQsIE9jdCAyMSwg
MjAyMyBhdCA1OjI44oCvUE0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPiB3cm90
ZToKPj4+PiBJbiBvcmRlciB0byByZWR1Y2UgbmVlZGxlc3NseSBoaWdoIHNldHVwIGFuZCB0ZWFy
ZG93biBjb3N0Cj4+Pj4gb2YgaW90bGIgbWFwcGluZyBkdXJpbmcgbGl2ZSBtaWdyYXRpb24sIGl0
J3MgY3J1Y2lhbCB0bwo+Pj4+IGRlY291cGxlIHRoZSB2aG9zdC12ZHBhIGlvdGxiIGFic3RyYWN0
aW9uIGZyb20gdGhlIHZpcnRpbwo+Pj4+IGRldmljZSBsaWZlIGN5Y2xlLCBpLmUuIGlvdGxiIG1h
cHBpbmdzIHNob3VsZCBiZSBsZWZ0Cj4+Pj4gaW50YWN0IGFjcm9zcyB2aXJ0aW8gZGV2aWNlIHJl
c2V0IFsxXS4gRm9yIGl0IHRvIHdvcmssIHRoZQo+Pj4+IG9uLWNoaXAgSU9NTVUgcGFyZW50IGRl
dmljZSBjb3VsZCBpbXBsZW1lbnQgYSBzZXBhcmF0ZQo+Pj4+IC5yZXNldF9tYXAoKSBvcGVyYXRp
b24gY2FsbGJhY2sgdG8gcmVzdG9yZSAxOjEgRE1BIG1hcHBpbmcKPj4+PiB3aXRob3V0IGhhdmlu
ZyB0byByZXNvcnQgdG8gdGhlIC5yZXNldCgpIGNhbGxiYWNrLCB0aGUKPj4+PiBsYXR0ZXIgb2Yg
d2hpY2ggaXMgbWFpbmx5IHVzZWQgdG8gcmVzZXQgdmlydGlvIGRldmljZSBzdGF0ZS4KPj4+PiBU
aGlzIG5ldyAucmVzZXRfbWFwKCkgY2FsbGJhY2sgd2lsbCBiZSBpbnZva2VkIG9ubHkgYmVmb3Jl
Cj4+Pj4gdGhlIHZob3N0LXZkcGEgZHJpdmVyIGlzIHRvIGJlIHJlbW92ZWQgYW5kIGRldGFjaGVk
IGZyb20KPj4+PiB0aGUgdmRwYSBidXMsIHN1Y2ggdGhhdCBvdGhlciB2ZHBhIGJ1cyBkcml2ZXJz
LCBlLmcuCj4+Pj4gdmlydGlvLXZkcGEsIGNhbiBzdGFydCB3aXRoIDE6MSBETUEgbWFwcGluZyB3
aGVuIHRoZXkKPj4+PiBhcmUgYXR0YWNoZWQuIEZvciB0aGUgY29udGV4dCwgdGhvc2Ugb24tY2hp
cCBJT01NVSBwYXJlbnQKPj4+PiBkZXZpY2VzLCBjcmVhdGUgdGhlIDE6MSBETUEgbWFwcGluZyBh
dCB2ZHBhIGRldmljZSBjcmVhdGlvbiwKPj4+PiBhbmQgdGhleSB3b3VsZCBpbXBsaWNpdGx5IGRl
c3Ryb3kgdGhlIDE6MSBtYXBwaW5nIHdoZW4KPj4+PiB0aGUgZmlyc3QgLnNldF9tYXAgb3IgLmRt
YV9tYXAgY2FsbGJhY2sgaXMgaW52b2tlZC4KPj4+Pgo+Pj4+IFRoaXMgcGF0Y2hzZXQgaXMgcmVi
YXNlZCBvbiB0b3Agb2YgdGhlIGxhdGVzdCB2aG9zdCB0cmVlLgo+Pj4+Cj4+Pj4gWzFdIFJlZHVj
aW5nIHZkcGEgbWlncmF0aW9uIGRvd250aW1lIGJlY2F1c2Ugb2YgbWVtb3J5IHBpbiAvIG1hcHMK
Pj4+PiBodHRwczovL3d3dy5tYWlsLWFyY2hpdmUuY29tL3FlbXUtZGV2ZWxAbm9uZ251Lm9yZy9t
c2c5NTM3NTUuaHRtbAo+Pj4+Cj4+Pj4gLS0tCj4+Pj4gdjQ6Cj4+Pj4gLSBSZXdvcmsgY29tcGF0
aWJpbGl0eSB1c2luZyBuZXcgLmNvbXBhdF9yZXNldCBkcml2ZXIgb3AKPj4+IEkgc3RpbGwgdGhp
bmsgaGF2aW5nIGEgc2V0X2JhY2tlbmRfZmVhdHVyZSgpCj4+IFRoaXMgd2lsbCBvdmVybG9hZCBi
YWNrZW5kIGZlYXR1cmVzIHdpdGggdGhlIHJvbGUgb2YgY2Fycnlpbmcgb3Zlcgo+PiBjb21wYXRp
YmlsaXR5IHF1aXJrcywgd2hpY2ggSSB0cmllZCB0byBhdm9pZCBmcm9tLiBXaGlsZSBJIHRoaW5r
IHRoZQo+PiAuY29tcGF0X3Jlc2V0IGZyb20gdGhlIHY0IGNvZGUganVzdCB3b3JrcyB3aXRoIHRo
ZSBiYWNrZW5kIGZlYXR1cmVzCj4+IGFja25vd2xlZGdlbWVudCAoYW5kIG1heWJlIG90aGVycyBh
cyB3ZWxsKSB0byBkZXRlcm1pbmUsIGJ1dCBub3QKPj4gZGlyZWN0bHkgdGllIGl0IHRvIGJhY2tl
bmQgZmVhdHVyZXMgaXRzZWxmLiBUaGVzZSB0d28gaGF2ZSBkaWZmZXJlbnQKPj4gaW1wbGljYXRp
b25zIGluIHRlcm1zIG9mIHJlcXVpcmVtZW50LCBzY29wZSBhbmQgbWFpbnRhaW5pbmcvZGVwcmVj
YXRpb24sCj4+IGJldHRlciB0byBjb3BlIHdpdGggY29tcGF0IHF1aXJrcyBpbiBleHBsaWNpdCBh
bmQgZHJpdmVyIHZpc2libGUgd2F5Lgo+Pgo+Pj4gICAgb3IgcmVzZXRfbWFwKGNsZWFuPXRydWUp
IG1pZ2h0IGJlIGJldHRlci4KPj4gQW4gZXhwbGljaXQgb3AgbWlnaHQgYmUgbWFyZ2luYWxseSBi
ZXR0ZXIgaW4gZHJpdmVyIHdyaXRlcidzIHBvaW50IG9mCj4+IHZpZXcuIENvbXBsaWFudCBkcml2
ZXIgZG9lc24ndCBoYXZlIHRvIGJvdGhlciBhc3NlcnRpbmcgY2xlYW5fbWFwIG5ldmVyCj4+IGJl
IHRydWUgc28gdGhlaXIgY29kZSB3b3VsZCBuZXZlciBib3RoZXIgZGVhbGluZyB3aXRoIHRoaXMg
Y2FzZSwgYXMKPj4gZXhwbGFpbmVkIGluIHRoZSBjb21taXQgbG9nIGZvciBwYXRjaCA1ICJ2aG9z
dC12ZHBhOiBjbGVhbiBpb3RsYiBtYXAKPj4gZHVyaW5nIHJlc2V0IGZvciBvbGRlciB1c2Vyc3Bh
Y2UiOgo+Pgo+PiAiCj4+ICAgICAgIFRoZSBzZXBhcmF0aW9uIG9mIC5jb21wYXRfcmVzZXQgZnJv
bSB0aGUgcmVndWxhciAucmVzZXQgYWxsb3dzCj4+ICAgICAgIHZob3N0LXZkcGEgYWJsZSB0byBr
bm93IHdoaWNoIGRyaXZlciBoYWQgYnJva2VuIGJlaGF2aW9yIGJlZm9yZSwgc28gaXQKPj4gICAg
ICAgY2FuIGFwcGx5IHRoZSBjb3JyZXNwb25kaW5nIGNvbXBhdGliaWxpdHkgcXVpcmsgdG8gdGhl
IGluZGl2aWR1YWwKPj4gZHJpdmVyCj4+ICAgICAgIHdoZW5ldmVyIG5lZWRlZC4gIENvbXBhcmVk
IHRvIG92ZXJsb2FkaW5nIHRoZSBleGlzdGluZyAucmVzZXQgd2l0aAo+PiAgICAgICBmbGFncywg
LmNvbXBhdF9yZXNldCB3b24ndCBjYXVzZSBhbnkgZXh0cmEgYnVyZGVuIHRvIHRoZSBpbXBsZW1l
bnRhdGlvbgo+PiAgICAgICBvZiBldmVyeSBjb21wbGlhbnQgZHJpdmVyLgo+PiAiCj4+Cj4+PiAg
ICBBcyBpdCB0cmllcyBoYXJkIHRvIG5vdCBpbnRyb2R1Y2UgbmV3IHN0dWZmIG9uIHRoZSBidXMu
Cj4+IEhvbmVzdGx5IEkgZG9uJ3Qgc2VlIHN1YnN0YW50aWFsIGRpZmZlcmVuY2UgYmV0d2VlbiB0
aGVzZSBvdGhlciB0aGFuIHRoZQo+PiBjb2xvci4gVGhlcmUncyBubyBzaW5nbGUgYmVzdCBzb2x1
dGlvbiB0aGF0IHN0YW5kcyBvdXQgYW1vbmcgdGhlIDMuIEFuZAo+PiBJIGFzc3VtZSB5b3UgYWxy
ZWFkeSBub3RpY2VkIGl0IGZyb20gYWxsIHRoZSBhYm92ZSAzIGFwcHJvYWNoZXMgd2lsbAo+PiBo
YXZlIHRvIGdvIHdpdGggYmFja2VuZCBmZWF0dXJlcyBuZWdvdGlhdGlvbiwgdGhhdCB0aGUgMXN0
IHZkcGEgcmVzZXQKPj4gYmVmb3JlIGJhY2tlbmQgZmVhdHVyZSBuZWdvdGlhdGlvbiB3aWxsIHVz
ZSB0aGUgY29tcGxpYW50IHZlcnNpb24gb2YKPj4gLnJlc2V0IHRoYXQgZG9lc24ndCBjbGVhbiB1
cCB0aGUgbWFwLiBXaGlsZSBJIGRvbid0IHRoaW5rIHRoaXMgbnVhbmNlCj4+IG1hdHRlcnMgbXVj
aCB0byBleGlzdGluZyBvbGRlciB1c2Vyc3BhY2UgYXBwcywgYXMgdGhlIG1hcHMgc2hvdWxkCj4+
IGFscmVhZHkgZ2V0IGNsZWFuZWQgYnkgcHJldmlvdXMgcHJvY2VzcyBpbiB2aG9zdF92ZHBhX2Ns
ZWFudXAoKSwgYnV0IGlmCj4+IGJ1Zy1mb3ItYnVnIGJlaGF2aW9yYWwgY29tcGF0aWJpbGl0eSBp
cyB3aGF0IHlvdSB3YW50LCBtb2R1bGUgcGFyYW1ldGVyCj4+IHdpbGwgYmUgdGhlIHNpbmdsZSBi
ZXN0IGFuc3dlci4KPj4KPj4gUmVnYXJkcywKPj4gLVNpd2VpCj4+Cj4+PiBCdXQgd2UgY2FuIGxp
c3RlbiB0byBvdGhlcnMgZm9yIHN1cmUuCj4+Pgo+Pj4gVGhhbmtzCj4+PgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
