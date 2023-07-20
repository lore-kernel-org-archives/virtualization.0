Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA96C0015E
	for <virtualization@archiver.kernel.org>; Thu, 20 Jul 2023 02:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA93C4058D;
	Thu, 20 Jul 2023 02:13:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA93C4058D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=Lrc4pLQK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=iM7BGLWp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wt-DZ8fgqeKF; Thu, 20 Jul 2023 02:13:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E9A17400D2;
	Thu, 20 Jul 2023 02:13:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E9A17400D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF128C0072;
	Thu, 20 Jul 2023 02:13:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEAFBC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 02:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AEB0341B43
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 02:13:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AEB0341B43
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=Lrc4pLQK; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=iM7BGLWp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cY9qvZcgFJu1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 02:13:05 +0000 (UTC)
X-Greylist: delayed 7759 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 20 Jul 2023 02:13:04 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 388664049F
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 388664049F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 02:13:04 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JFOLGD029551; Thu, 20 Jul 2023 00:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Kao42yPwRO82pjByDl/nyiRFwWQxjV8GJVsnt8uj3sg=;
 b=Lrc4pLQKTLknXDLSzghqRkcODkQITwmhL6/K/5DVNUdKbpa32do8TLm++udPQ+f4U9DW
 oglpMwZAoJHGoYRBJUoh1dUlGGQUgEVeodhJwslZVG1OKU1ds2BRHX9gFgKiLUOiIZui
 Hinnv0can+/1zazTYba12e9Jkfvlf0w0hzP2xufkTB01mhH1rLdwxV+VtDlOgTkXm234
 VaPxodweWS500+Da0PaH2g3Fnqqpb+WWBHwUqy5w3F3VxwMNQYNBB5LJD/+pqsIxnShl
 ETO5aTW98/c29c7xk55t5oTqVEE2+X5wc3eygeTDzDJWpovCaOqL9nPX84WXofz2Xfs/ wg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88rqhu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jul 2023 00:03:43 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36JLUWYb000877; Thu, 20 Jul 2023 00:03:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ruhw7qs1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jul 2023 00:03:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3Ckdc67gasyhmnfVdjKPH3Rz68+ajLCou0HBMa0ugBWE8+PKQm8qk5jmFpOvpeov3v9KC2xW2RrfvY4R5bhng7EQ5UBGb+jfIpZwsxpyLnQrPREeOEu2gTXlBvX6jWkLruqAaQKRkd8DvH/NQsV+3NXEMonVp62q0jK4Rcw17YyU6IZI3VFC/zGDL4gflhgBa7PpsOxV92LCtHa/8Xj3Sr5NRjUjp/nX5UoZnrDcVn/m2PRoEM8EmplG9dzfGcvuKP05bhtYmgvZ8RFB5HKR8U2Bix8Bhrm/eq3/znd9DJ0tqbpTxvsvJC75OHMgKlOq4Yb91IsTBb3vJtPIdIdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kao42yPwRO82pjByDl/nyiRFwWQxjV8GJVsnt8uj3sg=;
 b=O7Ybf72Ibh1Yc1WOh3M/ry46+mqG6VShV2jk2xgbULLKb42h4VGuipJPGAjLmy9XoIHbxNl87vEP8qdgLFVdHCeRuKVld4BHE3MCQ2ErBLj0MLnHBWjFF6hPvAN6CAacb2+yk1DuEt7BeLy5asX9q64YT/jfQH5UzwSFc7vioEk/Lx2C1BVN3CoCAaFddZlGXepisqncJ7LMik+JBBcPBxCQrL6eKc+pCrCXV+ucCUfWBzZU+O0kuLdaFRAtPW5S/krguMmwE5yAXaR4hn62Xvg/Lci5SzqmeD2JuW9D+hc+sUlK/9bfaM9k2lVjC+lxSsL+ijX2Vp0hSmsHyP9jjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kao42yPwRO82pjByDl/nyiRFwWQxjV8GJVsnt8uj3sg=;
 b=iM7BGLWpWYE/MSu6bp4gfUAirsvy7dZF6IWPg2PJB+V5UM3j+MjPU1Ia9GbwLwqD2p+K1FIV9xmER79zNcgdV472b8qJ4jTIE1Sm71yRk4KNeaaUuz4AUqfUvhDhCPAXitDW15qo273OoIKEen8VJUVmuuCallbXkjeeWG9tw9s=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS0PR10MB7903.namprd10.prod.outlook.com (2603:10b6:8:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 00:03:40 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::a11b:61fb:cdea:424a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::a11b:61fb:cdea:424a%5]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 00:03:39 +0000
Message-ID: <bf2164a9-1dfd-14d9-be2a-8bb7620a0619@oracle.com>
Date: Wed, 19 Jul 2023 17:03:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does not
 support it
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
 <20230704114159-mutt-send-email-mst@kernel.org>
 <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
 <CAJaqyWd0QC6x9WHBT0x9beZyC8ZrF2y=d9HvmT0+05RtGc8_og@mail.gmail.com>
 <eff34828-545b-956b-f400-89b585706fe4@amd.com>
 <20230706020603-mutt-send-email-mst@kernel.org>
 <1fdf73cb-f23e-0c34-f95f-f1bac74332da@oracle.com>
 <20230719182112-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230719182112-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SA1PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::18) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS0PR10MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: 2755c219-f30c-43e7-b671-08db88b4c5c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r4PnK8M9lEPYzWPoAXKo8DE0JBFUBHdtkQrbS+7QxZWkJz3UKHD8qxyavEhsdNn/0yn7RnqteOycojnWv+5I1mh6bgqtU41KahHxZx5QQdb2cIlYliHdpSlic454GQKAky2T1pATqK8IHJ9H+KM1vQl3VimKG7MAOqcV3s7MEsNWhBYdyLmYAYGw+/THuIHJzIfnQ00wjUHKjRLF5gwQP7UdveC0zBgiCHu2LqOUpkI1skhDyb0CQteTjiyjAjfTGdRQ8qq2oZSIGLeDbX8tSfEW4pYc6LDYcAOAjP0VEFMQqjkm0ZP20o6RpmAs4cBDT41kk22AKrp0DjQVXhgx5JWy72/Qhp6QAQ92Fe5IFCzuUdSMmPLETUa6tcBn6VlkSODIgrp8Uf0VgLYkGDoflB00d3D/b5Q0M4a+JeZgpkgdA1HpOdFk5KRiz2LDpLmoSPFBxK9m6cJemwbF3/KUQIh3w5YicLcwTX1S1c7VTRTIwLExT69AWAEmO2MvEZ1lUvmjG6hAMrdrnz+/Kf22iLzq7YT4i1CYF6sdOQscIa+tsK8p0SWMfrT3BoNDxK1ikwqWmbjYDokIYNByVZFbtUA39q/Htu/LNaCh+zoWD86XfXLv6BubKF/pUi3dUIvpt1FdnKI4bWYNmS8Dd0JNvNPghvJFa+Lzi8KRn9YXKCdxlYXyYJ1zjNLg9pAQCyPK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(54906003)(478600001)(6506007)(53546011)(26005)(186003)(966005)(6486002)(6666004)(6512007)(66899021)(83380400001)(2616005)(36916002)(66574015)(86362001)(5660300002)(38100700002)(8936002)(8676002)(84970400001)(41300700001)(316002)(6916009)(4326008)(2906002)(31686004)(31696002)(36756003)(66556008)(66476007)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDRxK3R6djlFOXNrYkp2TW8wOVFZdFc2ZFRDSHR0SVZSa3ZNUGNWam1TTmg0?=
 =?utf-8?B?N0ZacUhudGduNHlDeWZ0WlJ1SXc4UTg4eHMwcWVoUlR6L2ZFSFpXKzkvRlFG?=
 =?utf-8?B?NlVqbFlLYU05SnNGTUNHR25QSEp0Z2RIb2ZTREJMUGZZa21CVG5VY2lJcDBu?=
 =?utf-8?B?MlVuTnJFejVFSjFKYUM5YytRTjh5NEwrellVSVIzQVhRSXgzRHhTMzdQU2NT?=
 =?utf-8?B?SWxiOEpYWVlEUzJWMlB4TVRYS3F4TGh5SnQxQ21lRWNidTl6SE9Cb2ZKdnRC?=
 =?utf-8?B?cGg0amJuRUhhUGZsaEFwckpRbkd1b0M3cXdKeC9CMy9oY2FNejhtNWNqL1Qr?=
 =?utf-8?B?cml5aXZlTlJQc0ROa1lYb0NMTXVsUFFrYlBiSEhoeXhCeUxKMER1YTIwTHZD?=
 =?utf-8?B?c0M2Snc5a3F4Q2hlOEV6TjVKMFRPbW9hWEMvQTAxaU85VkRseEE1L0o0b2R2?=
 =?utf-8?B?TGJZdm4yNWlxSDhaYlZPbml0bHMzS3Arbi80aFJ5ZFRsZnlHZjZLUmJVRW9C?=
 =?utf-8?B?T3lQaXJqR0dKT2xWMGNnRGtJMy85bWQ5emJCR1dBSDdhVGx5MmplQXhQT1Jr?=
 =?utf-8?B?ZkxKNGF1VC85MVdSTjVWMFdOWjNSUDNuNHJ6VVNMNU9vT0dWWk0yeG12czhK?=
 =?utf-8?B?Q1V3ZnRkTG05cnBMNEpGejJtY2U1SUN5a0tjOGFEeUsxczh2VU5vek00WVdZ?=
 =?utf-8?B?SjI4WkFvenFFNlJpSkRiS2ZramVPaTJmRkhMS2RVNGJDamt2STNKRHl2UzRK?=
 =?utf-8?B?VzFpL3FnS1UxaFFnN056UUlFTE1ieTNqc1M4aWR6b2JCbEJIYzBPY05KMHA2?=
 =?utf-8?B?Um9jSnRJdVI0bDFpWU9EbGpiNkdWd2VJbHp1VzEvY05yWFRBSkpidjhqTlNE?=
 =?utf-8?B?OGdicWo3RytwMGVPUWR0WG1CUHd2L1lxVzgvTlZXTWNLSzk3dHRBQnJmd0Zu?=
 =?utf-8?B?NW5qby9vMDEvRUNSZmtpR2ZrYllHRkRxWW5LNzI4cVR1Z0JJNlR3SHd4L1VE?=
 =?utf-8?B?c2tLMSthWG04Y3lTLzNmYWR1TXpleEwvejRZRFpaRk1XeUFXRTl1VUI4bkwx?=
 =?utf-8?B?TVVaZXpNS0pZZGRraFdHK2V6SHNLY0NTS25MT3MyaXVyN3FGT2NOWlZaUVBW?=
 =?utf-8?B?cnRZTXo1UVpldHBMaUtmbnFVOEU3N3V3QnBzR1dLcmY0Q3gxSFJnb2FackJ4?=
 =?utf-8?B?U3lDVk16MGNuR2o0aDJoVnY5UFp3WDRqTFRPYUYzeThRWXI5aE14TUlsNXkw?=
 =?utf-8?B?cGlFSkdkWmJxRGJuUEdaRUpRblllVy8xVmEveS9KcTYzUkNrdlgxUURMN1ph?=
 =?utf-8?B?MWRlYmN5LzczUnlMVlRoSU1kYWF2WWpJeCsvcDR0ZE5RckgwNzFkK3dyaXdM?=
 =?utf-8?B?VUhyKzM1Q2ZNMnFvWFUzY3R6R1RYRjVibzl5QnJNU0RhYXorZUNEYVVCd3FP?=
 =?utf-8?B?OFJpLzhKRkVIQjVCTVNZQ0lTZ2VYTjFRaUlYZEpRLzFrVHl6anF5NE55MGs0?=
 =?utf-8?B?ditxMS9wZFhsNVFieEpvVTVyOUVUU2VjUXVpU3lMdkt2SThiRkdvY21TS1lV?=
 =?utf-8?B?dFpVM216TFZuZGthaDBxaThXTGoveVFvZ1I0WEJUZXpCVWxkWU5BZnZJZmVo?=
 =?utf-8?B?M2xjU3ZiVTFPUkxrcmhzcSt2emxBSVluejZjeExMQ0tYaUxqcEcyRUZyVXl2?=
 =?utf-8?B?dWx1MGo2cTNlWmswTFVNdkpmUWc1UUp5dFZGOERsclZHd2p5NmZ2ajJjVmow?=
 =?utf-8?B?NkFjRzVSUUpacHIvZUROSkg5bGlVaHRlNHB6OVA4aDNaeHVMNlprWngvaFJZ?=
 =?utf-8?B?NEdzNXdUeWhXNDBVcVl1M0x6WktaeXB2SG1KNGRtd1lUVFBwN2pPZmNCcE5D?=
 =?utf-8?B?TzAxSVZCR2wwSjZvQWV5Y3JWNVpyanlCU0dEY25GNTJKR0pncjJ6SHkzbkdM?=
 =?utf-8?B?M2toZDhwd1A4aW1Nb2laQzVLNUoxdXdWUnVPVFhxeFQ1ekEzL0g4S1czOXBy?=
 =?utf-8?B?eFNsaGJadG5manptTGtzeEJmY3diSWE4VHFLY2h0QUVVTVprY0NJQzltL2ZE?=
 =?utf-8?B?R2MyY04wNnNwZXNhQ01ISnNPUUVqQ1FDWjFrbnlMUTgyN3JvdDVkMmNBSXpn?=
 =?utf-8?Q?6gj0bchScWImon/dPxY4jiD05?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: U8l4XZEf6ThL46iKAQig9Y2nRmby0SbncHZsP/hWgozYS4HomqH5caPQkUE1AqXBH97TLNc8WCkb83ZT3C0Lp53CbA8uM5Da8YYnIWBPGhA6jzxzFWc72xksLRMF5rHHaykxuEvwtu38dF0jWALl6eZeVGyy/7x1vlAjX29ZUQ5GXckQ1R3/SSlsfAek3eE2L4+gU7+8evgqwq4rYMZHPJZ8QB1PfVIs7niTV3Naju4U5UiDnpuFyJwclKKaiHaZKxpi1+Ee14XnwJfDnqVmk494InEMMpl1wjpRYYw1XGkHOALj5Vvk/9aOTb9KgbbXNKCjMxAvCf+BIJI8W9fQa+2AbmMmq9yvmtUU0fWNzuxZLKa+njyhAPWClo4neZW/gm+y4ocqo7XyZ+DRPuRvw/YOSX9K0IN4lfKQVhVuqtGpUZUqJZoXvZF7ZuuP3CjuDc/P+IzQQI5TglMVDZUphdQZhSHYqK4PxkTdxRLYihWxkc8i+UApYvkvRcOyBpOiXg9Bdf3ez3d3XYI3wo6B49h7eQSNRcVcu6V95ldG0b9iqdE3/9rPP0NTb09MiyFyJIS+OzdVOFAoMfxI3hTidrbpo/UJZvXzG6aOwqOnaqNBTtQMwuCkkAuzf8/St4twJDkLGtyy5ux2vTJVo9+rnFuQvYEEymiEtI2jWTF1EYYrafgOMeY+8qNyT797rfaIw1+zX9SOc/ajsFFCKiipYhwQG9jFN3ovNoYIOyiSBlxStO7IYz4yMI2MN0yli7hj5uGuqPseq+lGu0krLkqSqhYFOpp9VRTZDXWZN0VySvrEFAX68zSRwkZItVrkYb1MZbyTn2ZQLAjvMZmj47yljzVGxT7JqeAq+6ewSJgQOC/sORZfK9C4VpYOp4zTJtn2
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2755c219-f30c-43e7-b671-08db88b4c5c1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 00:03:39.8149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aH/B6UP2J9mxuZTcICLgwIpWMkoEa1eaS65A88IFglQUnWRo/wLewLoYsXx75WEhbt23/5zzAiqM7i2mDVPuTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7903
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190217
X-Proofpoint-GUID: x0BhONA9AJ8V3S-Tzy2PzdwsRFkzrVCU
X-Proofpoint-ORIG-GUID: x0BhONA9AJ8V3S-Tzy2PzdwsRFkzrVCU
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio Perez Martin <eperezma@redhat.com>
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

CgpPbiA3LzE5LzIwMjMgMzoyNiBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIFdl
ZCwgSnVsIDE5LCAyMDIzIGF0IDAzOjIwOjAzUE0gLTA3MDAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+
Cj4+IE9uIDcvNS8yMDIzIDExOjA3IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+PiBP
biBXZWQsIEp1bCAwNSwgMjAyMyBhdCAwNTowNzoxMVBNIC0wNzAwLCBTaGFubm9uIE5lbHNvbiB3
cm90ZToKPj4+PiBPbiA3LzUvMjMgMTE6MjcgQU0sIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3Rl
Ogo+Pj4+PiBPbiBXZWQsIEp1bCA1LCAyMDIzIGF0IDk6NTDigK9BTSBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+IE9uIFR1ZSwgSnVsIDQsIDIwMjMgYXQgMTE6
NDXigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+
PiBPbiBUdWUsIEp1bCAwNCwgMjAyMyBhdCAwMTozNjoxMVBNICswMjAwLCBFdWdlbmlvIFBlcmV6
IE1hcnRpbiB3cm90ZToKPj4+Pj4+Pj4gT24gVHVlLCBKdWwgNCwgMjAyMyBhdCAxMjozOOKAr1BN
IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pj4+Pj4gT24g
VHVlLCBKdWwgMDQsIDIwMjMgYXQgMTI6MjU6MzJQTSArMDIwMCwgRXVnZW5pbyBQZXJleiBNYXJ0
aW4gd3JvdGU6Cj4+Pj4+Pj4+Pj4gT24gTW9uLCBKdWwgMywgMjAyMyBhdCA0OjUy4oCvUE0gTWlj
aGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4+Pj4+Pj4+IE9uIE1v
biwgSnVsIDAzLCAyMDIzIGF0IDA0OjIyOjE4UE0gKzAyMDAsIEV1Z2VuaW8gUMOpcmV6IHdyb3Rl
Ogo+Pj4+Pj4+Pj4+Pj4gV2l0aCB0aGUgY3VycmVudCBjb2RlIGl0IGlzIGFjY2VwdGVkIGFzIGxv
bmcgYXMgdXNlcmxhbmQgc2VuZCBpdC4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBBbHRob3Vn
aCB1c2VybGFuZCBzaG91bGQgbm90IHNldCBhIGZlYXR1cmUgZmxhZyB0aGF0IGhhcyBub3QgYmVl
bgo+Pj4+Pj4+Pj4+Pj4gb2ZmZXJlZCB0byBpdCB3aXRoIFZIT1NUX0dFVF9CQUNLRU5EX0ZFQVRV
UkVTLCB0aGUgY3VycmVudCBjb2RlIHdpbGwgbm90Cj4+Pj4+Pj4+Pj4+PiBjb21wbGFpbiBmb3Ig
aXQuCj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4gU2luY2UgdGhlcmUgaXMgbm8gc3BlY2lmaWMg
cmVhc29uIGZvciBhbnkgcGFyZW50IHRvIHJlamVjdCB0aGF0IGJhY2tlbmQKPj4+Pj4+Pj4+Pj4+
IGZlYXR1cmUgYml0IHdoZW4gaXQgaGFzIGJlZW4gcHJvcG9zZWQsIGxldCdzIGNvbnRyb2wgaXQg
YXQgdmRwYSBmcm9udGVuZAo+Pj4+Pj4+Pj4+Pj4gbGV2ZWwuIEZ1dHVyZSBwYXRjaGVzIG1heSBt
b3ZlIHRoaXMgY29udHJvbCB0byB0aGUgcGFyZW50IGRyaXZlci4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+PiBGaXhlczogOTY3ODAwZDJkNTJlICgidmRwYTogYWNjZXB0IFZIT1NUX0JBQ0tFTkRf
Rl9FTkFCTEVfQUZURVJfRFJJVkVSX09LIGJhY2tlbmQgZmVhdHVyZSIpCj4+Pj4+Pj4+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPj4+Pj4+
Pj4+Pj4gUGxlYXNlIGRvIHNlbmQgdjMuIEFuZCBhZ2FpbiwgSSBkb24ndCB3YW50IHRvIHNlbmQg
ImFmdGVyIGRyaXZlciBvayIgaGFjawo+Pj4+Pj4+Pj4+PiB1cHN0cmVhbSBhdCBhbGwsIEkgbWVy
Z2VkIGl0IGluIG5leHQganVzdCB0byBnaXZlIGl0IHNvbWUgdGVzdGluZy4KPj4+Pj4+Pj4+Pj4g
V2Ugd2FudCBSSU5HX0FDQ0VTU19BRlRFUl9LSUNLIG9yIHNvbWUgc3VjaC4KPj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+PiBDdXJyZW50IGRldmljZXMgZG8gbm90IHN1cHBvcnQgdGhhdCBzZW1hbnRpYy4K
Pj4+Pj4+Pj4+IFdoaWNoIGRldmljZXMgc3BlY2lmaWNhbGx5IGFjY2VzcyB0aGUgcmluZyBhZnRl
ciBEUklWRVJfT0sgYnV0IGJlZm9yZQo+Pj4+Pj4+Pj4gYSBraWNrPwo+Pj4+IFRoZSBQRFMgdmRw
YSBkZXZpY2UgY2FuIGRlYWwgd2l0aCBhIGNhbGwgdG8gLnNldF92cV9yZWFkeSBhZnRlciBEUklW
RVJfT0sgaXMKPj4+PiBzZXQuICBBbmQgSSdtIHRvbGQgdGhhdCBvdXIgVlEgYWN0aXZpdHkgc2hv
dWxkIHN0YXJ0IHdpdGhvdXQgYSBraWNrLgo+Pj4+Cj4+Pj4gT3VyIHZkcGEgZGV2aWNlIEZXIGRv
ZXNuJ3QgY3VycmVudGx5IGhhdmUgc3VwcG9ydCBmb3IgVklSVElPX0ZfUklOR19SRVNFVCwKPj4+
PiBidXQgSSBiZWxpZXZlIGl0IGNvdWxkIGJlIGFkZGVkIHdpdGhvdXQgdG9vIG11Y2ggdHJvdWJs
ZS4KPj4+Pgo+Pj4+IHNsbgo+Pj4+Cj4+PiBPSyBpdCBzZWVtcyBjbGVhciBhdCBsZWFzdCBpbiB0
aGUgY3VycmVudCB2ZXJzaW9uIHBkcyBuZWVkcwo+Pj4gVkhPU1RfQkFDS0VORF9GX0VOQUJMRV9B
RlRFUl9EUklWRVJfT0suCj4+PiBIb3dldmVyIGNhbiB3ZSBhbHNvIGNvZGUgdXAgdGhlIFJJTkdf
UkVTRVQgcGF0aCBhcyB0aGUgZGVmYXVsdD8KPj4gV2hhdCdzIHRoZSByYXRpb25hbGUgb2YgbWFr
aW5nIFJJTkdfUkVTRVQgcGF0aCB0aGUgZGVmYXVsdD8gTm90ZWQgdGhpcyBpcyBvbgo+PiBhIHBl
cmZvcm1hbmNlIGNyaXRpY2FsIHBhdGggKGZvciBsaXZlIG1pZ3JhdGlvbiBkb3dudGltZSksIGRp
ZCB3ZSBldmVyIGdldAo+PiBjb25zZW5zdXMgZnJvbSBldmVyeSBvciBtb3N0IGhhcmR3YXJlIHZl
bmRvcnMgdGhhdCBSSU5HX1JFU0VUIGhhcyBsb3dlciBjb3N0Cj4+IGluIHRlcm1zIG9mIGxhdGVu
Y3kgb3ZlcmFsbCB0aGFuIEVOQUJMRV9BRlRFUl9EUklWRVJfT0s/IEkgdGhpbmsgKFJJTkcpUkVT
RVQKPj4gaW4gZ2VuZXJhbCBmYWxscyBvbiB0aGUgc2xvdyBwYXRoIGZvciBoYXJkd2FyZSwgd2hp
bGUgSSBhc3N1bWUgZWl0aGVyCj4+IFJJTkdfUkVTRVQgb3IgRU5BQkxFX0FGVEVSX0RSSVZFUl9P
SyBkb2Vzbid0IG1hdHRlcnMgbXVjaCBvbiBzb2Z0d2FyZSBiYWNrZWQKPj4gdmRwYSBlLmcuIHZw
X3ZkcGEuIE1heWJlIHNob3VsZCBtYWtlIEVOQUJMRV9BRlRFUl9EUklWRVJfT0sgYXMgdGhlIGRl
ZmF1bHQ/Cj4+Cj4+IC1TaXdlaQo+IENvbWluZyBmcm9tIHRoZSBzcGVjIFJJTkdfUkVTRVQgaGFz
IGNsZWFyZXIgc2VtYW50aWNzLgpTcGVjIGRvZXNuJ3QgaGF2ZSBjbGVhcmVyIHNlbWFudGljcyBv
biB2ZHBhIHNwZWNpZmljcyAtIHN1Y2ggYXMgaG93IGRvZXMgClJJTkdfUkVTRVQgaW50ZXJvcGVy
YXRlIHdpdGggQVNJRD8KPiBBcyBsb25nIGFzIHdlIHN1cHBvcnQgaXQgaXQgaXMgbm90IGNyaXRp
Y2FsIHdoaWNoIG9uZQo+IGlzIHRoZSBkZWZhdWx0IHRob3VnaC4KVGhlIHBvaW50IGlzIHZkcGEg
dmVuZG9yIGRyaXZlcnMgbWF5IGltcGxlbWVudCBSSU5HX1JFU0VUIGZvciBhIApkaWZmZXJlbnQg
cHVycG9zZSB0aGFuIGxpdmUgbWlncmF0aW9uLiBJbiBjYXNlIHRoZXkgc3VwcG9ydCBib3RoIEkg
ZG9uJ3QgCnNlZSBhIHJlYXNvbiB3aHkgaXQgaGFzIHRvIGZhbGxiYWNrIHRvIGEgc2xvd2VyIHBh
dGggZ2l2ZW4gdGhlcmUncyBhIApmYXN0ZXIgcGF0aC4gTWF5IHdlIHNob3VsZCBsZWF2ZSB0aGlz
IHRvIHZlbmRvciBkcml2ZXIgdG8gZGVjaWRlLCBidXQgSSAKYW0gbm90IHN1cmUuCgotU2l3ZWkK
Cj4KPgo+Pj4gVGhlbiBkb3duIHRoZSByb2FkIHZlbmRvcnMgY2FuIGNob29zZSB3aGF0IHRvIGRv
Lgo+Pj4KPj4+Cj4+Pgo+Pj4KPj4+Cj4+Pj4+Pj4+IFByZXZpb3VzIHZlcnNpb25zIG9mIHRoZSBR
RU1VIExNIHNlcmllcyBkaWQgYSBzcHVyaW91cyBraWNrIHRvIHN0YXJ0Cj4+Pj4+Pj4+IHRyYWZm
aWMgYXQgdGhlIExNIGRlc3RpbmF0aW9uIFsxXS4gV2hlbiBpdCB3YXMgcHJvcG9zZWQsIHRoYXQg
c3B1cmlvdXMKPj4+Pj4+Pj4ga2ljayB3YXMgcmVtb3ZlZCBmcm9tIHRoZSBzZXJpZXMgYmVjYXVz
ZSB0byBjaGVjayBmb3IgZGVzY3JpcHRvcnMKPj4+Pj4+Pj4gYWZ0ZXIgZHJpdmVyX29rLCBldmVu
IHdpdGhvdXQgYSBraWNrLCB3YXMgY29uc2lkZXJlZCB3b3JrIG9mIHRoZQo+Pj4+Pj4+PiBwYXJl
bnQgZHJpdmVyLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBJJ20gb2sgdG8gZ28gYmFjayB0byB0aGlzIHNw
dXJpb3VzIGtpY2ssIGJ1dCBJJ20gbm90IHN1cmUgaWYgdGhlIGh3Cj4+Pj4+Pj4+IHdpbGwgcmVh
ZCB0aGUgcmluZyBiZWZvcmUgdGhlIGtpY2sgYWN0dWFsbHkuIEkgY2FuIGFzay4KPj4+Pj4+Pj4K
Pj4+Pj4+Pj4gVGhhbmtzIQo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBbMV0gaHR0cHM6Ly9saXN0cy5ub25n
bnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMjMtMDEvbXNnMDI3NzUuaHRtbAo+Pj4+
Pj4+IExldCdzIGZpbmQgb3V0LiBXZSBuZWVkIHRvIGNoZWNrIGZvciBFTkFCTEVfQUZURVJfRFJJ
VkVSX09LIHRvbywgbm8/Cj4+Pj4+PiBNeSB1bmRlcnN0YW5kaW5nIGlzIFsxXSBhc3N1bWluZyBB
Q0NFU1NfQUZURVJfS0lDSy4gVGhpcyBzZWVtcwo+Pj4+Pj4gc3ViLW9wdGltYWwgdGhhbiBhc3N1
bWluZyBFTkFCTEVfQUZURVJfRFJJVkVSX09LLgo+Pj4+Pj4KPj4+Pj4+IEJ1dCB0aGlzIHJlbWlu
ZHMgbWUgb25lIHRoaW5nLCBhcyB0aGUgdGhyZWFkIGlzIGdvaW5nIHRvbyBsb25nLCBJCj4+Pj4+
PiB3b25kZXIgaWYgd2Ugc2ltcGx5IGFzc3VtZSBFTkFCTEVfQUZURVJfRFJJVkVSX09LIGlmIFJJ
TkdfUkVTRVQgaXMKPj4+Pj4+IHN1cHBvcnRlZD8KPj4+Pj4+Cj4+Pj4+IFRoZSBwcm9ibGVtIHdp
dGggdGhhdCBpcyB0aGF0IHRoZSBkZXZpY2UgbmVlZHMgdG8gc3VwcG9ydCBhbGwKPj4+Pj4gUklO
R19SRVNFVCwgbGlrZSB0byBiZSBhYmxlIHRvIGNoYW5nZSB2cSBhZGRyZXNzIGV0YyBhZnRlciBE
UklWRVJfT0suCj4+Pj4+IE5vdCBhbGwgSFcgc3VwcG9ydCBpdC4KPj4+Pj4KPj4+Pj4gV2UganVz
dCBuZWVkIHRoZSBzdWJzZXQgb2YgaGF2aW5nIHRoZSBkYXRhcGxhbmUgZnJlZXplZCB1bnRpbCBh
bGwgQ1ZRCj4+Pj4+IGNvbW1hbmRzIGhhdmUgYmVlbiBjb25zdW1lZC4gSSdtIHN1cmUgY3VycmVu
dCB2RFBBIGNvZGUgYWxyZWFkeQo+Pj4+PiBzdXBwb3J0cyBpdCBpbiBzb21lIGRldmljZXMsIGxp
a2UgTUxYIGFuZCBQU0QuCj4+Pj4+Cj4+Pj4+IFRoYW5rcyEKPj4+Pj4KPj4+Pj4+IFRoYW5rcwo+
Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+Pj4+IE15IHBsYW4gd2FzIHRvIGNvbnZlcnQKPj4+Pj4+Pj4+
PiBpdCBpbiB2cF92ZHBhIGlmIG5lZWRlZCwgYW5kIHJldXNlIHRoZSBjdXJyZW50IHZkcGEgb3Bz
LiBTb3JyeSBpZiBJCj4+Pj4+Pj4+Pj4gd2FzIG5vdCBleHBsaWNpdCBlbm91Z2guCj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+PiBUaGUgb25seSBzb2x1dGlvbiBJIGNhbiBzZWUgdG8gdGhhdCBpcyB0byB0
cmFwICYgZW11bGF0ZSBpbiB0aGUgdmRwYQo+Pj4+Pj4+Pj4+IChwYXJlbnQ/KSBkcml2ZXIsIGFz
IHRhbGtlZCBpbiB2aXJ0aW8tY29tbWVudC4gQnV0IHRoYXQgY29tcGxpY2F0ZXMKPj4+Pj4+Pj4+
PiB0aGUgYXJjaGl0ZWN0dXJlOgo+Pj4+Pj4+Pj4+ICogT2ZmZXIgVkhPU1RfQkFDS0VORF9GX1JJ
TkdfQUNDRVNTX0FGVEVSX0tJQ0sKPj4+Pj4+Pj4+PiAqIFN0b3JlIHZxIGVuYWJsZSBzdGF0ZSBz
ZXBhcmF0ZWx5LCBhdAo+Pj4+Pj4+Pj4+IHZkcGEtPmNvbmZpZy0+c2V0X3ZxX3JlYWR5KHRydWUp
LCBidXQgbm90IHRyYW5zbWl0IHRoYXQgZW5hYmxlIHRvIGh3Cj4+Pj4+Pj4+Pj4gKiBTdG9yZSB0
aGUgZG9vcmJlbGwgc3RhdGUgc2VwYXJhdGVseSwgYnV0IGRvIG5vdCBjb25maWd1cmUgaXQgdG8g
dGhlCj4+Pj4+Pj4+Pj4gZGV2aWNlIGRpcmVjdGx5Lgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gQnV0
IGhvdyB0byByZWNvdmVyIGlmIHRoZSBkZXZpY2UgY2Fubm90IGNvbmZpZ3VyZSB0aGVtIGF0IGtp
Y2sgdGltZSwKPj4+Pj4+Pj4+PiBmb3IgZXhhbXBsZT8KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IE1h
eWJlIHdlIGNhbiBqdXN0IGZhaWwgaWYgdGhlIHBhcmVudCBkcml2ZXIgZG9lcyBub3Qgc3VwcG9y
dCBlbmFibGluZwo+Pj4+Pj4+Pj4+IHRoZSB2cSBhZnRlciBEUklWRVJfT0s/IFRoYXQgd2F5IG5v
IG5ldyBmZWF0dXJlIGZsYWcgaXMgbmVlZGVkLgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gVGhhbmtz
IQo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiAtLS0KPj4+Pj4+Pj4+Pj4+IFNlbnQgd2l0aCBGaXhl
czogdGFnIHBvaW50aW5nIHRvIGdpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9tc3QKPj4+Pj4+Pj4+Pj4+IGNvbW1pdC4gUGxlYXNlIGxldCBtZSBrbm93IGlmIEkgc2hvdWxk
IHNlbmQgYSB2MyBvZiBbMV0gaW5zdGVhZC4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBbMV0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDYwOTEyMTI0NC1tdXR0LXNlbmQtZW1h
aWwtbXN0QGtlcm5lbC5vcmcvVC8KPj4+Pj4+Pj4+Pj4+IC0tLQo+Pj4+Pj4+Pj4+Pj4gICAgIGRy
aXZlcnMvdmhvc3QvdmRwYS5jIHwgNyArKysrKy0tCj4+Pj4+Pj4+Pj4+PiAgICAgMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0
L3ZkcGEuYwo+Pj4+Pj4+Pj4+Pj4gaW5kZXggZTFhYmYyOWZlZDViLi5hN2U1NTQzNTIzNTEgMTAw
NjQ0Cj4+Pj4+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+Pj4+Pj4+Pj4g
KysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+Pj4+Pj4+Pj4+IEBAIC02ODEsMTggKzY4MSwy
MSBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lvY3RsKHN0cnVjdCBmaWxlICpm
aWxlcCwKPj4+Pj4+Pj4+Pj4+ICAgICB7Cj4+Pj4+Pj4+Pj4+PiAgICAgICAgICBzdHJ1Y3Qgdmhv
c3RfdmRwYSAqdiA9IGZpbGVwLT5wcml2YXRlX2RhdGE7Cj4+Pj4+Pj4+Pj4+PiAgICAgICAgICBz
dHJ1Y3Qgdmhvc3RfZGV2ICpkID0gJnYtPnZkZXY7Cj4+Pj4+Pj4+Pj4+PiArICAgICBjb25zdCBz
dHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2LT52ZHBhLT5jb25maWc7Cj4+Pj4+Pj4+Pj4+
PiAgICAgICAgICB2b2lkIF9fdXNlciAqYXJncCA9ICh2b2lkIF9fdXNlciAqKWFyZzsKPj4+Pj4+
Pj4+Pj4+ICAgICAgICAgIHU2NCBfX3VzZXIgKmZlYXR1cmVwID0gYXJncDsKPj4+Pj4+Pj4+Pj4+
IC0gICAgIHU2NCBmZWF0dXJlczsKPj4+Pj4+Pj4+Pj4+ICsgICAgIHU2NCBmZWF0dXJlcywgcGFy
ZW50X2ZlYXR1cmVzID0gMDsKPj4+Pj4+Pj4+Pj4+ICAgICAgICAgIGxvbmcgciA9IDA7Cj4+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgaWYgKGNtZCA9PSBWSE9TVF9TRVRfQkFDS0VO
RF9GRUFUVVJFUykgewo+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgICBpZiAoY29weV9mcm9t
X3VzZXIoJmZlYXR1cmVzLCBmZWF0dXJlcCwgc2l6ZW9mKGZlYXR1cmVzKSkpCj4+Pj4+Pj4+Pj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FRkFVTFQ7Cj4+Pj4+Pj4+Pj4+PiAr
ICAgICAgICAgICAgIGlmIChvcHMtPmdldF9iYWNrZW5kX2ZlYXR1cmVzKQo+Pj4+Pj4+Pj4+Pj4g
KyAgICAgICAgICAgICAgICAgICAgIHBhcmVudF9mZWF0dXJlcyA9IG9wcy0+Z2V0X2JhY2tlbmRf
ZmVhdHVyZXModi0+dmRwYSk7Cj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgIGlmIChmZWF0
dXJlcyAmIH4oVkhPU1RfVkRQQV9CQUNLRU5EX0ZFQVRVUkVTIHwKPj4+Pj4+Pj4+Pj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9TVVNQ
RU5EKSB8Cj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQklU
X1VMTChWSE9TVF9CQUNLRU5EX0ZfUkVTVU1FKSB8Cj4+Pj4+Pj4+Pj4+PiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfRU5BQkxFX0FGVEVSX0RS
SVZFUl9PSykpKQo+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBh
cmVudF9mZWF0dXJlcykpCj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIC1FT1BOT1RTVVBQOwo+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgICBpZiAoKGZlYXR1
cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfU1VTUEVORCkpICYmCj4+Pj4+Pj4+Pj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgIXZob3N0X3ZkcGFfY2FuX3N1c3BlbmQodikpCj4+Pj4+Pj4+
Pj4+PiAtLQo+Pj4+Pj4+Pj4+Pj4gMi4zOS4zCj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+Pj4gVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0Cj4+
PiBWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+Pj4gaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
