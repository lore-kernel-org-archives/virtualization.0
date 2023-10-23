Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82202C00A8F
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 22:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0218B4180F;
	Mon, 23 Oct 2023 22:00:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0218B4180F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=TCv52kwt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=X2D+CTt5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9114_PU_fjht; Mon, 23 Oct 2023 22:00:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7958C40168;
	Mon, 23 Oct 2023 22:00:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7958C40168
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39DA6C0039;
	Mon, 23 Oct 2023 22:00:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E451C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 22:00:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05FA58144B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 22:00:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 05FA58144B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=TCv52kwt; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=X2D+CTt5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JPP7l9NFxSln
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 22:00:09 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F51781DA3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 22:00:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F51781DA3
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39NLi5H8020581; Mon, 23 Oct 2023 22:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=UVCebi6LtFk4/FFQhC6ESOTBzDn3wdGAb+r05BzMr5E=;
 b=TCv52kwt4zjawX2nBZfsvnuNbUrnzm64kYhRQPWUTrx8uDAxm7vyukRmBKM7Ud27vuPt
 TRTyExywOEuSv/1c8BRObByXn4NiiSP3tbWPlznhrFPXPL28TYH2jaGr2ZgCdeTJqklQ
 nkbUVocHxvkhaERSt+LUxeXREuMeg3cxiFB/2oq0p2jI/3/Duwuo/zJ9GxZ837IVoyML
 p7mH6AtlklbeeveqgcvRtsTHw4oW8miRkI9eXdvIK7WNneHWvcQWeIenEZ3P42pd7FaX
 3JO8us7E2Dy8umy8HbI0FczZ84/b/F4FeXvg7ZZC5k23gVUNYGZO5TW8jBDGl1aP7lEf jg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv52dv645-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 22:00:07 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39NKx8FQ031095; Mon, 23 Oct 2023 22:00:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tv53b2mr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 22:00:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfWR2G6BkPfV1HuuRB6YoTjqHmspIt7g9KLCUroD6mEKH0BRnDz8JkjsIYCl4kNy9DqMNbNF1KBKgJ7HzThvSFknurHYKh7m1MAgSs7FDCndy6TiWGRju7VlyJzDw7cDUlPDUGx6pOpkANOLTTt3NMvRKgRbp8+W9/SF9xti1PpztB/2AZNEYoBdRQjWzfERVmggrJk9Sv0agJ2Bj2pyEh+CrXSAuZmd4lckTXndonzTQptpsrSH7P1aNWhbiRwnpM2CDoGQxnS5EM6BEkgkXYqGlkNzAlSO7s7/9GhCcwAtr7gQ0bhxPDbk/I7Yr/xuTp1/bUlEE33nc/3TG/ecVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVCebi6LtFk4/FFQhC6ESOTBzDn3wdGAb+r05BzMr5E=;
 b=k6xY5BczTaFMmhWPMpN1575NsBKkeKq21/gCjkilYhZtRdoee1xfjf/W+l8yJ/Max5LbNIjTZQnJr9oRVdHsplkxf7LH9FrJWz1byml/xVnBbu6f3W8MNRso4a2MUTapFCaMKQrHaBGrMSfvt5j7RpuOOQUaDkLlWft3cJYI4dW9ZKnea9XU7ADrJ5NkziYVPUksZXoUQbFN41jJH6lk37cJ2ZBaKPZQRJuOjHHEK+7zwpASaxbaX78XCwlB0+J/SvczR+/kwrkI1ND1VVKzUVVAWL4DULVID6x0wDosKTIARuvyHb+j3Zf3t0jMxS9YJ1TfWZjDI0ZOPjv8SyFB2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVCebi6LtFk4/FFQhC6ESOTBzDn3wdGAb+r05BzMr5E=;
 b=X2D+CTt5W/466YpHa0+rNG5qGLgg1a/a9tf7knMqIgaoAVLZB2JoffaIkr0sbmyROLaBevWQydxOzm7eag3UcSycZB7zZIwHGD2ZT3fAWitZlJdjIqWpMkdsKnuWLoR0hjn/H8R/Vsi1DhN+cwhZSCl//hGOAsrSmORMNddbzD4=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS7PR10MB5376.namprd10.prod.outlook.com (2603:10b6:5:3a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 22:00:04 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 22:00:04 +0000
Message-ID: <4d03661b-4289-46e7-8760-32a186783b73@oracle.com>
Date: Mon, 23 Oct 2023 15:00:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] vdpa: decouple reset of iotlb mapping from device
 reset
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvkSFcHXC0HFw-NoDtDNnaucJbpfPO0Yho2r1QP8F6zSw@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvkSFcHXC0HFw-NoDtDNnaucJbpfPO0Yho2r1QP8F6zSw@mail.gmail.com>
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS7PR10MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c68c0f5-a0e0-4531-480a-08dbd41369af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pdmrj5VVWCIn9CvzayL5b41ZaysMhKRQNs1f+ew9teXAJ7pwMFZdjoi1PhT+2wN/JTfDtM1prTN+meq4o9kOrG3Htu3iLk6evkhOUg4Ybz+2BNmbhrIKnb9o8qwBHlGO+pCYg/AnTD30ZFVc0ECMjYwbOouG7/WOz4GLKvWmm9lOBi4/eMbeMtM2uzs4jgXZLPN2XV0aOVBNtUiY6+UUkNEXeD2D5VH3jkzB2D1AoXvddQEyH/lLX9OS9h4nnhnuhdE1eBStZoXGCRK46rNupscRrFp38Yu4oUwDAF/vnSEHlrj5BkT/H9mw32Luf5J5SyKsWcnoQPCxvuz1xk/529vW9x2AW9R6VuLYDIl6MZ+wG4qLOMOQmh9JfvVgJDdd0K31w8FNTGEvj68EwhhNrgrZT8hl+rmLbWraLFkGVGH2AvhZWdrYBv+4AgdWoWbuehFYxzmyeGJInh2AIV/kdqme3tZFxvaV2+Uu5hfgIMjiZuLVp5OVKHUYVfCGPgjg7hd/neyZ1uKdHUS9R0ym4mQv8B3GOliXFNxySh4O3cVW/WDgWuMNyUPu+XswctEcrgujC5zmWnQXimqFDUCwmJrWgphll3MSi6lmsOHO3cfBN51nhXm/RIyku9Zut1RcQMsBlR416lCFbScOvB0RVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(31686004)(66899024)(6666004)(2906002)(4326008)(41300700001)(8676002)(26005)(6506007)(38100700002)(5660300002)(36916002)(6512007)(53546011)(83380400001)(2616005)(6486002)(8936002)(66556008)(31696002)(36756003)(6916009)(316002)(86362001)(66946007)(966005)(66476007)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVczdk5Uazh3ZVZZcE5GcE5jKzFrUG5OYmsycElBaUVSbnBmUFRCMXBLRitS?=
 =?utf-8?B?cmlWTFJIaklIOTBxa2xZNitGOXlNd0xRTWtHM2FnSjYzRzJxZjRPeEhhU0Rn?=
 =?utf-8?B?RW5qZkhCRGhRNi9Ca3RmNXZMM1JjTVRyUFFiMXZrTnM3MU9scFhTSEZ3Sjcz?=
 =?utf-8?B?M2MrSWdJd0owM3ZDeUZidkptMStySjZGM05jd2FrT3lqSWRZcG5ES1hqSEg5?=
 =?utf-8?B?K2dyQXJQVnh3ZW1PcHNsK0RBdThITHRMZ1prcThtbkU0d1VzZndRM011blI4?=
 =?utf-8?B?LzI4MnhUYXpzSXdLcndMM1NoOFNiblI3RkFtRzRkcm0rdjF5aEk2QzAwYnYr?=
 =?utf-8?B?MVFhNTRPSnFQelMvbXNKYVlFL252M0lETGFSQTR6ak9pU0QvTlJ1U3pZYjJs?=
 =?utf-8?B?akVEUlpiT2xwOGRlM0pNMXExVVl6VEhBTWhhL3FoTFRXa24rMlhYZUJocTda?=
 =?utf-8?B?NnNHY0NIMk0vU3ROcFhZTkEwdTBVRTFLNFdGbDJZV3BHSTNnNjdzNGRGaFJ5?=
 =?utf-8?B?Ulh0S2oyU040UklGSjNjbXhJMDhvWHF1Z1c5aWlwbVo0UC9rbW9lSGdqdkpw?=
 =?utf-8?B?NmxGNW8zTG82aW1ZQkgvMDFyMkllalBjWEZ4UG1oeWcwLzhVSGhMY2NKM1pC?=
 =?utf-8?B?SktWcHdsQlBJS1ViWnc2RWcwdTNRdWtieXZlbXBJVmZZa0puVnd2T2RaeXNh?=
 =?utf-8?B?cHlLOWlBdlFMamE3MHlvZEFHbFo2QWxFSW5sQTJmbGlFOGFyc1RTY0V1VFp2?=
 =?utf-8?B?a3czbDlFMnF3QTVLSzJ1QnNkMnBleU5lSUd4SitjWEkrTXNObDRSL1diQUJD?=
 =?utf-8?B?T0F4c0IwR3VMVEozNmZZYU93dyt1RnVtdEYrSmtYMnNnL2NndHRSMklDNk45?=
 =?utf-8?B?bHMxeE1nb216bXhNYkVJNUVra0FOZW1QVE5xTzI3cU5FOEFWR0M1S2R2NWpB?=
 =?utf-8?B?YUpjUDhCNndUelh6QWxrOFA0K3ozZU04enhCMk5nWHRKdXZyVkVURkZhT0pt?=
 =?utf-8?B?akNqKzBkUEZvKzBUMVhTQ1Uwb1QxVFlLRmwvYVFWeXp1RkRLS3JGWnB0WVBw?=
 =?utf-8?B?QTVsTGJwWVVvaDNGZG5CSGNmZmtlYks4QWQ5UmZRR1ppbGNlQTBDT1F3MGdM?=
 =?utf-8?B?SXkzWmJSRjJ0ZlllVGM1TFpLN3R0bnA4MG8rTlQ5aTE0blh1SzZ3dFNsVDk5?=
 =?utf-8?B?RFVrclJNWTk5SG96K284Wm1YZ0o0eWVsS1FTb203K2JHYXVXVUFQcC8zdGxz?=
 =?utf-8?B?QnJ3OUw5eE9qc2p3d0RGbnJMVmlYbjlYeW9UZmJ2R3dXTmI5OGdQeldNVlRN?=
 =?utf-8?B?VmFPbFh6NmxFMkRuQS8rUTZFZ0F4NStIUHlqT01FYTd5clpLVjk3eEJUOWYw?=
 =?utf-8?B?dm9NRmpoTVZOS0ZDUmFRY1pkUURuSTJ2Uys1cmVLclpLTXlKc1d0QkswSmxC?=
 =?utf-8?B?TmYvRFRmckh0OEhnZWI0dXZNYXVTNDRYQVlnaVIzQVZFenZPTHJOaEpwSFht?=
 =?utf-8?B?dS85RnhmeVRIR29YUERWdG5pdFlBQmdKQzJlRGZDWWh1UW9pWUFRYld1bm1a?=
 =?utf-8?B?SWJnS3UrM2pNZFdmOG9IV3BiaUtoODlSMzA4NVhxK1Njdk1nalNJK25MQ1NI?=
 =?utf-8?B?TG5OLzhIeVhBOVgyc0xCMmpBOXBPTHhyZkh3OHl5MERDcklXTHo0VXR3QU5S?=
 =?utf-8?B?WkhjNzdXOWFwQ2MxekNUQlRJellkNDMzWW5DSTUwYjhKVFNQeko2SWhseGI1?=
 =?utf-8?B?ODh6ZU9JcmRuYmw3OVVIK0JIak54Y0l2aE9YMUhDblJBdVVPaUJXbEZ4TWJq?=
 =?utf-8?B?aVdDekRnWnRtaXdwc3FPSkVlTW9JY1dhM25jaEhJZkNlK2pIQVRJT2JuM1ZS?=
 =?utf-8?B?NVQyTkRsT0tJczZIWW1QdnhQVWxNY1h4eldMMDFEUC9lR0d2dzdaQmwvWWFQ?=
 =?utf-8?B?YTdrM0FZanU2NGd2V2J6SmkvZURIRU43SHQwY1NsZUttVnNmZWZqR09zdUhm?=
 =?utf-8?B?dXRoMzhNOG1uQklhdzRBRUNJcmJHMXJ6WnM5YUhTd0huaE5rbHNTL2plbHB6?=
 =?utf-8?B?WEpQLytVbjd6QWx3Ti9ta1pIZG1UOE9nS0RUckdEVEtVOURodGU5V2hpanVL?=
 =?utf-8?Q?Letp942AYmSheWyQzQGDVSIZ1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: As0NQJOBqZCR4dfGzexzEDXI362vxobFpTA6FjO6owDvcwv7lQLcUgK78Zj0zVXz3uKzcOTkwUR5BQDABwdqem6vGduGDUmT9QkAoREHTk48i8lNeS9p6E+QCOI3US+0VVtin6+pwm9KdE03SuK7MydOdj8mdDPmZER7DqjnBTbwxiT0x8rWVz5XhK+/A4BJc+Y4tFuipDv2uVWyWWbzikh4kHF7SiWGjL9gUavaG4KhXnUwjyDFEg3qImqjg2Od3XHtkb+BOfPFTpcHbdBoVkh0yRuQ0Tuod9kw8yIHYQ2iAJ5ViWJbRtQDxkv3oIy1WrB3chtqPp7ubGe8m99UE1aOWLTHTvH2m95j2LkM/ts1BubdGgJDeJ2bSpWfmB3pzFfHi/AMahMVkaNOOi8t9ofs/gpsf4O8ZYs9wtdiNhfIEb1Akfdza2oxgKAPQZT+7x0911AMFDFd844ti0WDUqywNW2oVhodeZoN98i8jDc4HiZsnpd3vfVV+kATfjEuH+DnD62EtjXwBuA2Nm7MJavhlPqG6Wwuu27GcUn4TSoinqZ0R7VTBfvUVVA0LD8ifJBR7eGNakT2V9qfzUK3SvCbJEFV/TEgtpceMmYbmE27HSLzkxsL/4FUW1TSHOXnOvcoGWR3wp1JG1OJx5DkIjOjIrGGMb/QQ3T2eil0OcCfRyJ/bZsASsnJsLtWI0MYqTMxR1Cy6DSq42oM6D69JidjWim2P5Kh/mhKw7H81VrmEqxLHcK9MtBdslSsIvzbe+HDmq6op6BkvdaY2Y1cT8jmGZBR+IeBw/CHuEKJe8QDg/P5CnhNDpw4BkR6wGuhgiQH6iLyDnGRkYcKHGjdAu+W+XIIqe7HhY9LzlCQp84n9Q5UeBU8en9TmmSWkg5TDz1eTbO1Qx2rUwbENZluhA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c68c0f5-a0e0-4531-480a-08dbd41369af
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 22:00:04.7687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pkf4J04d0tNqBbqhr7hWFs3+wQABawEvi0EdNcYyPNBhrBCfnt82rwppWN0ysz/90LbhqC0+3u/D38kQjynw0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_21,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230193
X-Proofpoint-ORIG-GUID: J7KMr18Ux7JNJBxV8FJhVnmrKtIfTn9_
X-Proofpoint-GUID: J7KMr18Ux7JNJBxV8FJhVnmrKtIfTn9_
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

CgpPbiAxMC8yMi8yMDIzIDg6NTEgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4gSGkgU2ktV2VpOgo+
Cj4gT24gU2F0LCBPY3QgMjEsIDIwMjMgYXQgNToyOOKAr1BNIFNpLVdlaSBMaXUgPHNpLXdlaS5s
aXVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4+IEluIG9yZGVyIHRvIHJlZHVjZSBuZWVkbGVzc2x5IGhp
Z2ggc2V0dXAgYW5kIHRlYXJkb3duIGNvc3QKPj4gb2YgaW90bGIgbWFwcGluZyBkdXJpbmcgbGl2
ZSBtaWdyYXRpb24sIGl0J3MgY3J1Y2lhbCB0bwo+PiBkZWNvdXBsZSB0aGUgdmhvc3QtdmRwYSBp
b3RsYiBhYnN0cmFjdGlvbiBmcm9tIHRoZSB2aXJ0aW8KPj4gZGV2aWNlIGxpZmUgY3ljbGUsIGku
ZS4gaW90bGIgbWFwcGluZ3Mgc2hvdWxkIGJlIGxlZnQKPj4gaW50YWN0IGFjcm9zcyB2aXJ0aW8g
ZGV2aWNlIHJlc2V0IFsxXS4gRm9yIGl0IHRvIHdvcmssIHRoZQo+PiBvbi1jaGlwIElPTU1VIHBh
cmVudCBkZXZpY2UgY291bGQgaW1wbGVtZW50IGEgc2VwYXJhdGUKPj4gLnJlc2V0X21hcCgpIG9w
ZXJhdGlvbiBjYWxsYmFjayB0byByZXN0b3JlIDE6MSBETUEgbWFwcGluZwo+PiB3aXRob3V0IGhh
dmluZyB0byByZXNvcnQgdG8gdGhlIC5yZXNldCgpIGNhbGxiYWNrLCB0aGUKPj4gbGF0dGVyIG9m
IHdoaWNoIGlzIG1haW5seSB1c2VkIHRvIHJlc2V0IHZpcnRpbyBkZXZpY2Ugc3RhdGUuCj4+IFRo
aXMgbmV3IC5yZXNldF9tYXAoKSBjYWxsYmFjayB3aWxsIGJlIGludm9rZWQgb25seSBiZWZvcmUK
Pj4gdGhlIHZob3N0LXZkcGEgZHJpdmVyIGlzIHRvIGJlIHJlbW92ZWQgYW5kIGRldGFjaGVkIGZy
b20KPj4gdGhlIHZkcGEgYnVzLCBzdWNoIHRoYXQgb3RoZXIgdmRwYSBidXMgZHJpdmVycywgZS5n
Lgo+PiB2aXJ0aW8tdmRwYSwgY2FuIHN0YXJ0IHdpdGggMToxIERNQSBtYXBwaW5nIHdoZW4gdGhl
eQo+PiBhcmUgYXR0YWNoZWQuIEZvciB0aGUgY29udGV4dCwgdGhvc2Ugb24tY2hpcCBJT01NVSBw
YXJlbnQKPj4gZGV2aWNlcywgY3JlYXRlIHRoZSAxOjEgRE1BIG1hcHBpbmcgYXQgdmRwYSBkZXZp
Y2UgY3JlYXRpb24sCj4+IGFuZCB0aGV5IHdvdWxkIGltcGxpY2l0bHkgZGVzdHJveSB0aGUgMTox
IG1hcHBpbmcgd2hlbgo+PiB0aGUgZmlyc3QgLnNldF9tYXAgb3IgLmRtYV9tYXAgY2FsbGJhY2sg
aXMgaW52b2tlZC4KPj4KPj4gVGhpcyBwYXRjaHNldCBpcyByZWJhc2VkIG9uIHRvcCBvZiB0aGUg
bGF0ZXN0IHZob3N0IHRyZWUuCj4+Cj4+IFsxXSBSZWR1Y2luZyB2ZHBhIG1pZ3JhdGlvbiBkb3du
dGltZSBiZWNhdXNlIG9mIG1lbW9yeSBwaW4gLyBtYXBzCj4+IGh0dHBzOi8vd3d3Lm1haWwtYXJj
aGl2ZS5jb20vcWVtdS1kZXZlbEBub25nbnUub3JnL21zZzk1Mzc1NS5odG1sCj4+Cj4+IC0tLQo+
PiB2NDoKPj4gLSBSZXdvcmsgY29tcGF0aWJpbGl0eSB1c2luZyBuZXcgLmNvbXBhdF9yZXNldCBk
cml2ZXIgb3AKPiBJIHN0aWxsIHRoaW5rIGhhdmluZyBhIHNldF9iYWNrZW5kX2ZlYXR1cmUoKQpU
aGlzIHdpbGwgb3ZlcmxvYWQgYmFja2VuZCBmZWF0dXJlcyB3aXRoIHRoZSByb2xlIG9mIGNhcnJ5
aW5nIG92ZXIgCmNvbXBhdGliaWxpdHkgcXVpcmtzLCB3aGljaCBJIHRyaWVkIHRvIGF2b2lkIGZy
b20uIFdoaWxlIEkgdGhpbmsgdGhlIAouY29tcGF0X3Jlc2V0IGZyb20gdGhlIHY0IGNvZGUganVz
dCB3b3JrcyB3aXRoIHRoZSBiYWNrZW5kIGZlYXR1cmVzIAphY2tub3dsZWRnZW1lbnQgKGFuZCBt
YXliZSBvdGhlcnMgYXMgd2VsbCkgdG8gZGV0ZXJtaW5lLCBidXQgbm90IApkaXJlY3RseSB0aWUg
aXQgdG8gYmFja2VuZCBmZWF0dXJlcyBpdHNlbGYuIFRoZXNlIHR3byBoYXZlIGRpZmZlcmVudCAK
aW1wbGljYXRpb25zIGluIHRlcm1zIG9mIHJlcXVpcmVtZW50LCBzY29wZSBhbmQgbWFpbnRhaW5p
bmcvZGVwcmVjYXRpb24sIApiZXR0ZXIgdG8gY29wZSB3aXRoIGNvbXBhdCBxdWlya3MgaW4gZXhw
bGljaXQgYW5kIGRyaXZlciB2aXNpYmxlIHdheS4KCj4gICBvciByZXNldF9tYXAoY2xlYW49dHJ1
ZSkgbWlnaHQgYmUgYmV0dGVyLgpBbiBleHBsaWNpdCBvcCBtaWdodCBiZSBtYXJnaW5hbGx5IGJl
dHRlciBpbiBkcml2ZXIgd3JpdGVyJ3MgcG9pbnQgb2YgCnZpZXcuIENvbXBsaWFudCBkcml2ZXIg
ZG9lc24ndCBoYXZlIHRvIGJvdGhlciBhc3NlcnRpbmcgY2xlYW5fbWFwIG5ldmVyIApiZSB0cnVl
IHNvIHRoZWlyIGNvZGUgd291bGQgbmV2ZXIgYm90aGVyIGRlYWxpbmcgd2l0aCB0aGlzIGNhc2Us
IGFzIApleHBsYWluZWQgaW4gdGhlIGNvbW1pdCBsb2cgZm9yIHBhdGNoIDUgInZob3N0LXZkcGE6
IGNsZWFuIGlvdGxiIG1hcCAKZHVyaW5nIHJlc2V0IGZvciBvbGRlciB1c2Vyc3BhY2UiOgoKIgog
wqDCoMKgIFRoZSBzZXBhcmF0aW9uIG9mIC5jb21wYXRfcmVzZXQgZnJvbSB0aGUgcmVndWxhciAu
cmVzZXQgYWxsb3dzCiDCoMKgwqAgdmhvc3QtdmRwYSBhYmxlIHRvIGtub3cgd2hpY2ggZHJpdmVy
IGhhZCBicm9rZW4gYmVoYXZpb3IgYmVmb3JlLCBzbyBpdAogwqDCoMKgIGNhbiBhcHBseSB0aGUg
Y29ycmVzcG9uZGluZyBjb21wYXRpYmlsaXR5IHF1aXJrIHRvIHRoZSBpbmRpdmlkdWFsIApkcml2
ZXIKIMKgwqDCoCB3aGVuZXZlciBuZWVkZWQuwqAgQ29tcGFyZWQgdG8gb3ZlcmxvYWRpbmcgdGhl
IGV4aXN0aW5nIC5yZXNldCB3aXRoCiDCoMKgwqAgZmxhZ3MsIC5jb21wYXRfcmVzZXQgd29uJ3Qg
Y2F1c2UgYW55IGV4dHJhIGJ1cmRlbiB0byB0aGUgaW1wbGVtZW50YXRpb24KIMKgwqDCoCBvZiBl
dmVyeSBjb21wbGlhbnQgZHJpdmVyLgoiCgo+ICAgQXMgaXQgdHJpZXMgaGFyZCB0byBub3QgaW50
cm9kdWNlIG5ldyBzdHVmZiBvbiB0aGUgYnVzLgpIb25lc3RseSBJIGRvbid0IHNlZSBzdWJzdGFu
dGlhbCBkaWZmZXJlbmNlIGJldHdlZW4gdGhlc2Ugb3RoZXIgdGhhbiB0aGUgCmNvbG9yLiBUaGVy
ZSdzIG5vIHNpbmdsZSBiZXN0IHNvbHV0aW9uIHRoYXQgc3RhbmRzIG91dCBhbW9uZyB0aGUgMy4g
QW5kIApJIGFzc3VtZSB5b3UgYWxyZWFkeSBub3RpY2VkIGl0IGZyb20gYWxsIHRoZSBhYm92ZSAz
IGFwcHJvYWNoZXMgd2lsbCAKaGF2ZSB0byBnbyB3aXRoIGJhY2tlbmQgZmVhdHVyZXMgbmVnb3Rp
YXRpb24sIHRoYXQgdGhlIDFzdCB2ZHBhIHJlc2V0IApiZWZvcmUgYmFja2VuZCBmZWF0dXJlIG5l
Z290aWF0aW9uIHdpbGwgdXNlIHRoZSBjb21wbGlhbnQgdmVyc2lvbiBvZiAKLnJlc2V0IHRoYXQg
ZG9lc24ndCBjbGVhbiB1cCB0aGUgbWFwLiBXaGlsZSBJIGRvbid0IHRoaW5rIHRoaXMgbnVhbmNl
IAptYXR0ZXJzIG11Y2ggdG8gZXhpc3Rpbmcgb2xkZXIgdXNlcnNwYWNlIGFwcHMsIGFzIHRoZSBt
YXBzIHNob3VsZCAKYWxyZWFkeSBnZXQgY2xlYW5lZCBieSBwcmV2aW91cyBwcm9jZXNzIGluIHZo
b3N0X3ZkcGFfY2xlYW51cCgpLCBidXQgaWYgCmJ1Zy1mb3ItYnVnIGJlaGF2aW9yYWwgY29tcGF0
aWJpbGl0eSBpcyB3aGF0IHlvdSB3YW50LCBtb2R1bGUgcGFyYW1ldGVyIAp3aWxsIGJlIHRoZSBz
aW5nbGUgYmVzdCBhbnN3ZXIuCgpSZWdhcmRzLAotU2l3ZWkKCj4gQnV0IHdlIGNhbiBsaXN0ZW4g
dG8gb3RoZXJzIGZvciBzdXJlLgo+Cj4gVGhhbmtzCj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
