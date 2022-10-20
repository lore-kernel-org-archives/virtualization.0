Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA4DC4332F
	for <virtualization@archiver.kernel.org>; Thu, 20 Oct 2022 17:20:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC255405D8;
	Thu, 20 Oct 2022 17:20:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC255405D8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=Uy9yZCNy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=q8Ru6zjC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I9XX-QdREfmq; Thu, 20 Oct 2022 17:20:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 057954012B;
	Thu, 20 Oct 2022 17:20:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 057954012B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD415C0033;
	Thu, 20 Oct 2022 17:20:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00E0AC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 17:20:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C00EC8434A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 17:20:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C00EC8434A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=Uy9yZCNy; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=q8Ru6zjC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n4yYaD0OijWH
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 17:20:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2AC408405E
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2AC408405E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 17:20:10 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KGwubu020010;
 Thu, 20 Oct 2022 17:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=/x3StfwZMIvEIHaO04n2q1rAtEe15UA3sySrnOVV/Jk=;
 b=Uy9yZCNytAOVifwqlAf9bBue2aW0gLgSaLCUGJPJ2JmD8CyYCy89zRQBjyD/PletCvHY
 QIMS8iOY8SVOxvzq//QQIOQvQYq1fAVnrm1NG1V71qH1sSjduh2uHjz423c6U0lZtKjL
 kktGzOkN+yhQZuTho65/WwpOc1SODQZ6dEvrkn3EeXEoPswEulw+kR39Fx3y3avBjl61
 C8Y717uEM/YpDyszHbUL4mAkjeCgRbqQtzpzxxK7FbiHz2gGeVPHGPC+5V71jX3P+KCL
 UEBeNdkq4h6qGNjl+fZU+eth3qd7sV05Aj3ZwdZ3WSvrWB3JZY98OKGcs95j5/GUMY0f 0g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3p04a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Oct 2022 17:20:07 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 29KFNvhA007128; Thu, 20 Oct 2022 17:20:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3k8hrd16ek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Oct 2022 17:19:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dquQnsXuCwQ8nEiK2kV/Sh3gqDmQP6JSDbXWid+fWLsZL/tG7sjphGU8GQ0RtaOlFdnxB81Qjl9KLDwPakQXratIeOLBrP0daXWfOiOMjsYpUrrrhDJ2PT3WmIkXksiuBY1AeQv+4Raw+XuIbli7E+er30nlFq2VKqPxI4n0ZzJ8HCgv8plQ1OXp8AlEDJEnTTD3lJGG0ST1gDEc+8ir2LOBbNRhhfa8NamnUY89oh2jTf7P0ApnvT/wsdnuQThRyJxdOmVV/qjgnPl8S4NwH3NvTem/7EkX3LUZET9emEStlKX6C8yPzbJ4Sr9cNZz2e1J8iG6UiyQ5Ow86jREReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/x3StfwZMIvEIHaO04n2q1rAtEe15UA3sySrnOVV/Jk=;
 b=aYjVlsrkdPcXCUuGDFHKxS1fRHisIHxCzLx1BkcGHJeEdsG6kCuNpYvz1jeXKx7pPcBwvYod2thencTN3ZYIthnmBKd2vQG8QOwTtwBlnvHuyn3GgS557mf6ut8GEVjcOyVgYqkN/QVz3qCv/scyXiEZ63W1rfVR5V6E/Gq6CvhrfDeZUnvWGoE6j0rXtBvhnAdKXsQylgfGyGSYo4jS4OjLeQRQcllQTQNPiht5InlDaZW8uxVzl4s30gIOKWd3BN0N9JrnvLuYZdO57DD4vRpOe4UiDG7E7t9yy59tF0VQD2ov46YRdoIyaenHCVvQWq29gRYR5l8nutg+G5qttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x3StfwZMIvEIHaO04n2q1rAtEe15UA3sySrnOVV/Jk=;
 b=q8Ru6zjCmQ9NtDzVJCHiQTL2IYmtBS4fe69o4lx/iwaOT95EdBpyDPosNT9Eg2fstWZNjtVGzv1lEs899bImNF5WIWw9WXciQvjWFpTOd5hquk3EKiDpyQDr0WNLGE40eao3Ki367EnWP63SD8BO+Nv+tGu2bojJKnX6/CHIQOk=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by IA1PR10MB5921.namprd10.prod.outlook.com (2603:10b6:208:3d7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 17:19:40 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%5]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 17:19:39 +0000
Message-ID: <4fc4c99e-083e-e72f-64dd-b64c35b93516@oracle.com>
Date: Thu, 20 Oct 2022 10:19:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 1/4] vdpa: save vdpa_dev_set_config in struct
 vdpa_device
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
 <1666137032-28192-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEv_fKZa9qN+ytnViCdvcR4Cbr8KyT71UnWzWjrtsFMyBg@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEv_fKZa9qN+ytnViCdvcR4Cbr8KyT71UnWzWjrtsFMyBg@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0119.namprd05.prod.outlook.com
 (2603:10b6:a03:334::34) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|IA1PR10MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 259a3261-8a15-43ad-6b5f-08dab2bf4530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lvEFAZtonMSWUEgrpnZ+kTBZws4BBu9F2mXt+b/o8FFf2lZtQR3OsqxoFLeJwWD4WDfU62Kk5dreou9mnFniusQOtslX6QloUkYCouHaX8871bBrvUwdEgF8P6Z/L4yYjsU3rFGaHJo7xJzb+UpXndH3s7J5iJChl/BgbxOySdVOjWwXX/VjiYL11ti57dvBD+Hc2qdZfdoCUpE6yKf7JneWFvu1jTycm5JOz+53uMT0OR2QFt7EKrfL+xcxiL9DG9X1GVt7Rh+3YK1LUtADJlmT8ai3jcVUZcX33OMLnht7526DBtELyv6cpeBz2Xr9hJEnQZa9L0jjzvQEXRNjqebB1T13GtcSVrhpMsyOpOTGuP5Ujb3WbkRRVDOmqKbC6y/neGubFm2WYe3dlSBfk3sXzQpaDPpGysS5UcmZHB2359v5MwX1nih0PF7BxGS1+yN3j4EpktOPuA9EjdaUf38JYNiERS8B/2O92Xf7AFmW2v7VbXi1HfDTkJeyQfJTg8wi89qd+heMbssLpvGH9Jz9X+u+6ORNQXxi+AQ2RaEnOJx5Vz3sOEZ+A9v+mBrGgbc9gooJAzIiZ4liOwHc50wLLflj/2QvEhNTMhMm1AJuQxvHzUqtFeJfLm6oI0ujlk7RGSWTt3EN/uHsVeglJlo4CeMTf7rmSVOmwzJyk1rtbMKTgNlCZN7eMVEmog78Cx6ozxbW+eTPcY9WT/VLCnCGrZtmg5NaQDfTgDyfH34fGOxtRUStMl26MkdQGa20ayKOyEVP48IB+3/kcpRGtxvuXwkV6E9IQJygSZmHSHw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199015)(36756003)(31696002)(86362001)(31686004)(38100700002)(2906002)(5660300002)(26005)(6512007)(6666004)(2616005)(186003)(53546011)(83380400001)(36916002)(6506007)(33964004)(8936002)(478600001)(6486002)(6916009)(8676002)(316002)(66556008)(4326008)(66946007)(66476007)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1BpTGg0YTNKcWx0SUZzSURHY0hSa2lzQzcyd1VYRm5MTW1vNkN4VDREUzgr?=
 =?utf-8?B?b2hGbjdlaWJzZXJCcGxKOWI5TG91VG1iVThVODdWNHpDa0RoMDN5Uy9pNjc5?=
 =?utf-8?B?WHJRLzlvdHhMVG5zQmFmQXZsT1VsVCszUXMxbmhWRzBiV1lxUE8xeDNPbDdT?=
 =?utf-8?B?YzUyRlVWL0t1VUwwVnlYZFFYVlhrWFpMN3h4SFc3b09iL0d6L08wd0dCVlll?=
 =?utf-8?B?Mm9SRHQ4dENHb043S201YklZU0ZJVGlQZWZScEVuQzlDa21McTA4MXdqN1ZP?=
 =?utf-8?B?T1J1UTJQV2Y2elFCbm5DWVFoTGpFdm9NaVYvaUpTeWpGRFBtbFgzV2dkRUIv?=
 =?utf-8?B?RTgxcldPNkczbjRmR2VwWi9wRTFMSVo3eDlnZm90ZHFsTlBJOVlkODZTaVRq?=
 =?utf-8?B?NUx4V29mdy8vVnZ3OWpLU0pJWnVGL1dmYXo1bGlTSUtBd28vK2UydmJ2eWQr?=
 =?utf-8?B?cGtqMmkvc2JnekV6UDRuZzFIUWR2bXg0eldhelJvb1hGTlhHd1dQZ2N4bzNv?=
 =?utf-8?B?NGpKeVk2eS82eFVqM0hDM1RhWVJpMHZFRTc4NnhmRGlpVXMwcHJzODMrZ0l0?=
 =?utf-8?B?NkQzd1RjS29ZaHpnVExYWXBXL3JqWnpGREhVcnVtNklBdCtmLzVma08zK3Yr?=
 =?utf-8?B?Q0E4TFdKWWhtaHF6R0F4UWJEcXhoL0k3eWJuQUFyK2FCNVhOenkvUTZLMW41?=
 =?utf-8?B?Yk12RHZOdXFBc24xSVVEYkpZUFMwbXRmK0hQZURNMWJTVUlacUhEM3NyTkVy?=
 =?utf-8?B?V0xRVitWbGdVbGt6czc4cnpSaXdFc2M3SWFkbjEvSWpsd2RqUjZQWHplM081?=
 =?utf-8?B?SFNuNmtaSkFyWElxanNzby8ramlZZnB1QWNGais3S2owcmQxczAxMWJDUUtn?=
 =?utf-8?B?d2hScnBqNHNwclVJcHh6alVMTHlqR3ZjWmZybUNEeWJBNGI5Ujd5b1hBODVj?=
 =?utf-8?B?bCtHT2hzR0lzVkQwQm5lYVczTlRFVWR6cVVIRU9DWE9Lb1BCdW1jL2xQWTlO?=
 =?utf-8?B?V3lRTE41U2FWZ040cWdsZ0h2NlV6Rmd5ZzE0cG90aU1MdFE3UURHdTh2Vnho?=
 =?utf-8?B?UUlQZVhwVVo0bWFZbHQ4ZFN0VkZzcEN6RGZkcnJoZEp4MURvYmd4R3hXdk5m?=
 =?utf-8?B?L1pMdGp2ZDBIOTZQNnF0QmxTWlhBMmpud0IxT2hqY3N0NnRzdy9yYmhpM1BX?=
 =?utf-8?B?b1lHTUpoU3NmbHhrQlJtNlpXcFNGb1Zib1NzQUFEem50VFByV1Y4UkpOYnRo?=
 =?utf-8?B?K3oyTnlCLzVRMndsZmdRbStMa0tTMXY2RCs4NXVjN2JwajZBVDdxV2tYcklT?=
 =?utf-8?B?V1Mzd0F0ZVlvR1FNSXhRd0srN25SUUZxRk5ZVTd2TDYrTE5ST1ZnYXQvU3BJ?=
 =?utf-8?B?OTFwdXpYWmdSMStKT3hVZUErZUhsa0piRVdrTDVXTU5GNHk1Y0tVMDlhMFk0?=
 =?utf-8?B?bmNZRnNWMXZIWFVzUHNhdEd3WUF3TU9EQVdEUkNqMzFqWjVoTFVCczBlbXNY?=
 =?utf-8?B?S0xpZFY2TGZVMUxGbXRRUkNKV2xtOFdIYUExdU9wREpmc1FFaHFpUzY0QS91?=
 =?utf-8?B?VGtDcVY2OTRzZ2xEQ3laVXF0WEtZVGtNZlRpSmNETXI4UlBFRGJ4WTVocEMr?=
 =?utf-8?B?aDI2R3A2K0NmQm1DcXFRa0NnRnpmUnYyR2w5K0doY0pvbXNBMlhBTnJNZVpD?=
 =?utf-8?B?bE95Q1RiQzZVSVVEWXJFdWJrQVJrMy9zNjVTWThsZDFSN1BEU0dORExCcG9O?=
 =?utf-8?B?SFNBazV4dTFPdEFCUjl2VGRXekpFSkd2L0owMnRkRm1ITnVCUWdHQ05PYzlk?=
 =?utf-8?B?TGxETmwxYld1aXVDd2tOTVZhY0RLWEhCeElYOE82UnJ0K1I0TTBVbHc1R014?=
 =?utf-8?B?eDFndk5weGtxcjVPRWhlM2ZmaW05WkhEa1U4R1lQL3d2OFRzMXluYkw5dzkx?=
 =?utf-8?B?bmc4WjE5Z1pXcXJ6bTRJMlBEbmszS2dUTjl2R2R1UU9OdUtZTjBGMnpsanhl?=
 =?utf-8?B?dDlOcGdsb1lIdmN5VXI4aHp4V0dMdlBnWk9IMWVGbmdRSUQyRUNoL1NkN3di?=
 =?utf-8?B?TVVyUTlWYjZaM2NXWTFSKzBCd0V1VjBZa2d0QmVGNUlJNWtnYnErMXdVQU5T?=
 =?utf-8?Q?ZMqT9WYDoBx8xseKxcg1FVes2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259a3261-8a15-43ad-6b5f-08dab2bf4530
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 17:19:39.7988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Im5J1NHfuEFEBIrQ7TNXkp0d4iJbMABTWKWysUkVb0tqcqbtLQoubjJ3AmVj9bjhON3t6KWhP9fbJfOO4KWZbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_08,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210200103
X-Proofpoint-ORIG-GUID: uPKWXADQ384DXxvsw_K1HX79KaAuOSHt
X-Proofpoint-GUID: uPKWXADQ384DXxvsw_K1HX79KaAuOSHt
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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
Content-Type: multipart/mixed; boundary="===============7814416230304833771=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============7814416230304833771==
Content-Type: multipart/alternative;
 boundary="------------zGSZqRKBPAAkXzFdCEKJR0TH"
Content-Language: en-US

--------------zGSZqRKBPAAkXzFdCEKJR0TH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/19/2022 9:38 PM, Jason Wang wrote:
> On Wed, Oct 19, 2022 at 8:56 AM Si-Wei Liu<si-wei.liu@oracle.com>  wrote:
>> In order to allow live migration orchestration software to export the
>> initial set of vdpa attributes with which the device was created, it
>> will be useful if the vdpa tool can report the config on demand with
>> simple query. This will ease the orchestration software implementation
>> so that it doesn't have to keep track of vdpa config change, or have
>> to persist vdpa attributes across failure and recovery, in fear of
>> being killed due to accidental software error.
>>
>> This commit attempts to make struct vdpa_device contain the struct
>> vdpa_dev_set_config, where all config attributes upon vdpa creation
>> are carried over. Which will be used in subsequent commits.
>>
>> Signed-off-by: Si-Wei Liu<si-wei.liu@oracle.com>
>> ---
>>   include/linux/vdpa.h | 23 +++++++++++++----------
>>   1 file changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> index 6d0f5e4..f1838f5 100644
>> --- a/include/linux/vdpa.h
>> +++ b/include/linux/vdpa.h
>> @@ -58,6 +58,16 @@ struct vdpa_vq_state {
>>          };
>>   };
>>
>> +struct vdpa_dev_set_config {
>> +       u64 device_features;
>> +       struct {
>> +               u8 mac[ETH_ALEN];
>> +               u16 mtu;
>> +               u16 max_vq_pairs;
>> +       } net;
> Not for this patch but I think there should be a union container for
> this structure to make it usable for other types of devices.
Yes, once another type of device comes around for adding device specific 
config option, then the union container can be added naturally.

>
>> +       u64 mask;
>> +};
>> +
>>   struct vdpa_mgmt_dev;
>>
>>   /**
>> @@ -77,6 +87,8 @@ struct vdpa_vq_state {
>>    * @nvqs: maximum number of supported virtqueues
>>    * @mdev: management device pointer; caller must setup when registering device as part
>>    *       of dev_add() mgmtdev ops callback before invoking _vdpa_register_device().
>> + * @vdev_cfg: initial device config on vdpa creation; useful when instantiate with
>> + *            the exact same config is needed.
> Not a native speaker, but I guess it should be better named as "init_cfg"?
OK I will rename.

-Siwei
>
> Thanks
>
>>    */
>>   struct vdpa_device {
>>          struct device dev;
>> @@ -91,6 +103,7 @@ struct vdpa_device {
>>          struct vdpa_mgmt_dev *mdev;
>>          unsigned int ngroups;
>>          unsigned int nas;
>> +       struct vdpa_dev_set_config vdev_cfg;
>>   };
>>
>>   /**
>> @@ -103,16 +116,6 @@ struct vdpa_iova_range {
>>          u64 last;
>>   };
>>
>> -struct vdpa_dev_set_config {
>> -       u64 device_features;
>> -       struct {
>> -               u8 mac[ETH_ALEN];
>> -               u16 mtu;
>> -               u16 max_vq_pairs;
>> -       } net;
>> -       u64 mask;
>> -};
>> -
>>   /**
>>    * Corresponding file area for device memory mapping
>>    * @file: vma->vm_file for the mapping
>> --
>> 1.8.3.1
>>

--------------zGSZqRKBPAAkXzFdCEKJR0TH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 10/19/2022 9:38 PM, Jason Wang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CACGkMEv_fKZa9qN+ytnViCdvcR4Cbr8KyT71UnWzWjrtsFMyBg@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Wed, Oct 19, 2022 at 8:56 AM Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
In order to allow live migration orchestration software to export the
initial set of vdpa attributes with which the device was created, it
will be useful if the vdpa tool can report the config on demand with
simple query. This will ease the orchestration software implementation
so that it doesn't have to keep track of vdpa config change, or have
to persist vdpa attributes across failure and recovery, in fear of
being killed due to accidental software error.

This commit attempts to make struct vdpa_device contain the struct
vdpa_dev_set_config, where all config attributes upon vdpa creation
are carried over. Which will be used in subsequent commits.

Signed-off-by: Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a>
---
 include/linux/vdpa.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 6d0f5e4..f1838f5 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -58,6 +58,16 @@ struct vdpa_vq_state {
        };
 };

+struct vdpa_dev_set_config {
+       u64 device_features;
+       struct {
+               u8 mac[ETH_ALEN];
+               u16 mtu;
+               u16 max_vq_pairs;
+       } net;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Not for this patch but I think there should be a union container for
this structure to make it usable for other types of devices.</pre>
    </blockquote>
    Yes, once another type of device comes around for adding device
    specific config option, then the union container can be added
    naturally. <br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEv_fKZa9qN+ytnViCdvcR4Cbr8KyT71UnWzWjrtsFMyBg@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+       u64 mask;
+};
+
 struct vdpa_mgmt_dev;

 /**
@@ -77,6 +87,8 @@ struct vdpa_vq_state {
  * @nvqs: maximum number of supported virtqueues
  * @mdev: management device pointer; caller must setup when registering device as part
  *       of dev_add() mgmtdev ops callback before invoking _vdpa_register_device().
+ * @vdev_cfg: initial device config on vdpa creation; useful when instantiate with
+ *            the exact same config is needed.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Not a native speaker, but I guess it should be better named as &quot;init_cfg&quot;?</pre>
    </blockquote>
    OK I will rename.<br>
    <br>
    -Siwei<br>
    <blockquote type="cite" cite="mid:CACGkMEv_fKZa9qN+ytnViCdvcR4Cbr8KyT71UnWzWjrtsFMyBg@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

Thanks

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">  */
 struct vdpa_device {
        struct device dev;
@@ -91,6 +103,7 @@ struct vdpa_device {
        struct vdpa_mgmt_dev *mdev;
        unsigned int ngroups;
        unsigned int nas;
+       struct vdpa_dev_set_config vdev_cfg;
 };

 /**
@@ -103,16 +116,6 @@ struct vdpa_iova_range {
        u64 last;
 };

-struct vdpa_dev_set_config {
-       u64 device_features;
-       struct {
-               u8 mac[ETH_ALEN];
-               u16 mtu;
-               u16 max_vq_pairs;
-       } net;
-       u64 mask;
-};
-
 /**
  * Corresponding file area for device memory mapping
  * @file: vma-&gt;vm_file for the mapping
--
1.8.3.1

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------zGSZqRKBPAAkXzFdCEKJR0TH--

--===============7814416230304833771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7814416230304833771==--
