Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888DBC77B7F
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 16:25:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16FA6820EC;
	Tue, 16 May 2023 16:25:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 16FA6820EC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=m7/kFZiW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=hx1eedQj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MRt-PC42AjC4; Tue, 16 May 2023 16:25:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 381F781FFE;
	Tue, 16 May 2023 16:25:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 381F781FFE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDFE2C0036;
	Tue, 16 May 2023 16:25:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 550B6C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 16:25:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1ABE060AC9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 16:25:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1ABE060AC9
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=m7/kFZiW; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=hx1eedQj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wq-GHweNndEN
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 16:25:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA4CD60745
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA4CD60745
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 16:25:09 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34GG4HHQ024776; Tue, 16 May 2023 16:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zMiy3wc6+2aah3369sgh6Hof2vKztLSRE5c9HDt6kHU=;
 b=m7/kFZiWNk2XcVLo6T8lCIfx0zh6M2alWeZ3PTK0Rzx+N+mMFfyULAwjYNoBp1DNLnSc
 IiQclr9cUu9Czu78whDwHDMBSPpsQsdM+YK1rENKT2iLrs5cgly7VhZ6uFQLWuaZTTRm
 39usvj0o2/As3NyirOgSoMMibeHmIvg2J6jEAd/Jj2KESwnv76gOfllduRcVSvviEMVw
 JJlpewVZuOsuu3Yxd0RFUxp5FR25b3vC0YCupixoxwYjnLODIfGT9GQRIgHQ0F/3ldb5
 AYhf4LconHxOT7gWlhjqw5+V8RMW+DWBVhCi552+s+6hQw6dHiz4Uy+wnMUHplw0Rxm3 pw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj33uu7k1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 16:24:53 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34GFMs4Y039953; Tue, 16 May 2023 16:24:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj10425hy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 16:24:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShItUuLDfXw1HEJddlkEGkN/QjBP4SEZbm+6QJowO+/3hWA/BBEZ7ZfBFFj3neb8+sIvj9PC0Zn4+C+U3o3wExkRTBfzoNdone9yZYHZ9rOWE0c2f3fAZ/jIEDeeYJ+HXI/A2YudyQ2gAslvLfe/l6ddLg7H2qbOU9TUoyKz/WLVBLedEL1Pg1JBLAF5sVtuZrq+olpUtJUmY+9igiLGUQJBEofw3ACI/JRLgZr73L8HfL7Kol+2Z8QQ1yikOJu85+z8fyec58sRS4qD6oSKdPuR3QM5nHDQmaispq91ze64nqm4QHGVJgk9h9V52PU0pWpctx5NnRqt3/W5bEfMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMiy3wc6+2aah3369sgh6Hof2vKztLSRE5c9HDt6kHU=;
 b=UCFxC68Q5d5kZjfxvC+lCHaMqHRc+fIZ/Dq8JlPEsSzPO0j/sd+uUetCW3vanDNi1gT3N7IOyD8hmHj3YGa5U+Usn615B4hZtq99kxRKw0sWnFCtFHUy8aMWHDuLDz09+FEAA/OrooQM2/NRji23k1qc2p4KJAyCkWBQsYpsqQR0qNEUJ+IgQ/6UjgNC4dKvfBu+Ln0J88hhMFHxknrUz2YtLqKpyYlLYDPxli5Aaxts/AH9Fv4BgF+pXd0V+7EF6SHwZPum8lFjL/28fL4778Yptkq4mu25v9j5eWNJfYDqc5A4/R3at8GerJ7xugPjVowWZtu3ONVGG5i2DRvheg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMiy3wc6+2aah3369sgh6Hof2vKztLSRE5c9HDt6kHU=;
 b=hx1eedQjLsLx0vHf5nVumdm1RgHR3Gp3N5O/ar9jQ7LaRwrQ6ffVCDTLUw/q4iBTcEmAKxpjg/iJ/eBzOmKsAobqSakwl5i8M0yHyP5SHrEnC63ouQjwUPdSdRp6D9flLf2OQGvgI/q/+VJ8JDDtrirpJIbyJucWnxTbMY3jMg0=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SN7PR10MB6641.namprd10.prod.outlook.com (2603:10b6:806:2ac::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Tue, 16 May
 2023 16:24:50 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 16:24:50 +0000
Message-ID: <683d0c30-4aeb-3547-49a9-90ce6eb1a7d0@oracle.com>
Date: Tue, 16 May 2023 11:24:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
 <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
 <20230516-weltmeere-backofen-27f12ae2c9e0@brauner>
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230516-weltmeere-backofen-27f12ae2c9e0@brauner>
X-ClientProxiedBy: DM6PR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:5:80::45) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SN7PR10MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b9e564-7c34-4956-1568-08db562a1281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w9kCo6lbOE+pjQzcFyOgKGl4mY3wD/C2+cdKb/mBMVuYUIqHqauQJ1iGyUBfGhy8PfcpTWOg7A7xCHLizz1QwNIdHeVW3azTuUaiXFZ06UQVqdhzFj/5skQjtmRtR2TWPf8xPexJ+61wmy0ZXcxDeY8Hc0X7Bmdbn1D65Itk7yfwTKMA6iYxj3BYuVGiR/oR9tZu8ZA01LTS3yuuQhsfIFpTeph0CdFX3ktXAInY8MUIbWwyClXiPE2Z2Zuf+4PUt46t5qZX9kGTCb5SLiMULkQUgvcK6Cm2cEbFQyCyClls/XT1wHA+o/3rYM1bO+vp3k73qFcZp+QwKqvdkhBUYYwVnajQKJwVQba1OX1nW5kBuJiRYQMIXIuPNGXTU3nifaWt0jFgrrYWBLZh/MqAlFBDqX7bpvStzovA59a9jlFBPhs1/wasZ7lN1C7oz1ATsA/JybGW2U71HS44KnL+j/jXsVjTbl/eelSoe4c6K0fyMyR+dEt+yb+OWeQ5RRPPgFkzb6K+wH/TNWpQGnDRBAzkmEvi1lsOYkq8Gj7EY3WyZR58YJNhu/r5cdx9T4WIPa16cGhJopRs5XulmBu+qmxEXndY1jFU9IkZt0Ej9+dtmSX9qAEb8TTKRtLj/pJCK5G3pJ5sadecGpeQmnJzJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(38100700002)(36756003)(31696002)(86362001)(5660300002)(7416002)(8936002)(8676002)(2616005)(316002)(6506007)(26005)(53546011)(6512007)(66476007)(66556008)(110136005)(54906003)(66946007)(478600001)(6486002)(31686004)(4326008)(186003)(41300700001)(2906002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzhzdXNCRmNkcUJvZitRc28zVk1FNFNSN1FxTm83OElCY0FJVkN1NEJZK25R?=
 =?utf-8?B?K2o5Y1piVnpiYTZMNEQ1L0w3amlObUxUL29KN1RWbTdwUHBXcmtkZlVkS0Rn?=
 =?utf-8?B?T3p0b1pBUHhqMEZXWWdPZ1RFdXh3a3lYRERwNkFFZEtJOG9lNWZkU0lqRmJ2?=
 =?utf-8?B?dEJkS2lPVzltWVZ6SFlsamJDYyt0RHpWSGN5SjUyMHU1d3IzK1ZYc2RtR0Vq?=
 =?utf-8?B?YlR6YUZNRDBOcEpWOGRvcXhkRERsa2NFWUdiY0xEQXRxdVpxelhMSnV6WmQw?=
 =?utf-8?B?eS9sVnFoUklsWUNKVFN1Z1h6T1RYTTlLT3FoUDlmRmVUQllBcDByMlBFbUdV?=
 =?utf-8?B?NEZGQjBMNlNIazFRclpmK3A3QUFSeUFhelk5K0J5NE9MUzY0Y3p2M2J3eWph?=
 =?utf-8?B?SHBzZ3doR2NCbVJtNHBTcWdudHYvM2F3cHRWVkh5REVRU09GMjlLakVDbzh3?=
 =?utf-8?B?bGE2UlNUZUhqdTJFZ1REZTZJVXpOelBpb1dyaEF2ZnRkc2o1Rm9mZXZlanNF?=
 =?utf-8?B?emFFNldzalNuNk8wTmhFSCtnb0MxdHZ4dXlIQkU3N09vS3lmQmR1RW1KSHdZ?=
 =?utf-8?B?Y2I5aUF4T2ZoTllXOEFhTDY5MG9QSlF5RExIeWY5b2ZCOEdxU1ppMG1heUVr?=
 =?utf-8?B?c3hGWjZGaFo1V0ZTcjM1Zk8wNmMwOXlhUkh1ZjAxMXRjVVF5RmdQUG82bUdk?=
 =?utf-8?B?QXRwVTRkV2xMaHpSd0xRbWJEZkNaaGRLYnFuY2lOT01WQ1RYSmR1YTF0aHNm?=
 =?utf-8?B?Z0QyRklIUGdoK0VXWmNJb3ppVG1aLzRxbzVJdlhGZWw3bWN0dkVQSiszMjBy?=
 =?utf-8?B?N0NSd0I2WmFXRlJkYWdTUUs2VWk4UFBRL1hqeTRDRUVhNGkvVWVJamowN3VP?=
 =?utf-8?B?ck90SUwwcUVnUHJrVHlwMVF5N25kZGIzUkl3Q3JnbVBtTU5ZZ2FTdEpaWk5t?=
 =?utf-8?B?L1lKK2F1ZzcvUStpdGxCcC9KYUw2TG9RdXJoZTdUZkI3UW9HVHJHdWNEQmdK?=
 =?utf-8?B?R3pOQnBZNkJQQWREUDg2NXNsSHFNeEZZTHdpRWl3SmlJL2VFM1I5ejh1NFY5?=
 =?utf-8?B?WTFlMGRvdDZQQWtuV1pBZlFvczQzcUhiWWRIZkVTb29PZ3NlOFQ5QmNBZkJB?=
 =?utf-8?B?N0xXQmVvWmQ5SDVYL1ZEam5HdXBvcStlOW9OZERObzdTb1FURVFqR2VWYjZa?=
 =?utf-8?B?R2VQZzE2aGNrVXJsajJYTEFVaWpSb1Nra0wwVFA1M2dxYWJ2R0kxWjhEdnFS?=
 =?utf-8?B?a3YxbmhMSVZTa1BGNk5EL29Iem9IdFUwWWRwNzZBd0V1d0JPbVQ3bFIwajJq?=
 =?utf-8?B?Ti9SUVhhZ1FvcTJTWGZWMFdXR285TVVoRFBkdEpmaEMxcVlRa0trbCtKcEow?=
 =?utf-8?B?cDBFU0lwTC9YQi9YR01pUEdVeUt6MmsyY2pGdnk5QUFGaGFmdTh3LzhMRjZF?=
 =?utf-8?B?SEtYelVUbGlFcmhqei9STnhJczlqb3dSZ2VKcStyOTZSUkUwV3h5VHJ3bFE2?=
 =?utf-8?B?Q0gxKzFGUFVLRzhra0FvZHkxeW03cU5mV1B0NFdyU2JEYzFjRS96R2IzbEZV?=
 =?utf-8?B?NHNyVWJWYms0MUhjM1FsUlFldWJlK3Nvd0E0STkrU0JibzRocFdSQ0VrOEJz?=
 =?utf-8?B?a3EvSzRUdi81d09EbzU5bWZQRWZRamd6Qko5YjNra2dkcVd4bGFRaUFBWW9i?=
 =?utf-8?B?MmtianF3NWNMc2FSRFlHVFZhTVF0L1krY0JxbmFhU0N5MVQxWmp2UVZaRjRv?=
 =?utf-8?B?ZXlpanFQeGIxeWdVSWJHbUx1MDgzek1YTURkeGFNY0tLWjBHRVVXamFreThk?=
 =?utf-8?B?K0czYXZFd0NkYWM1UHFpOW9obEFJRk9hYUxUUDFDVTE3S0NjRFgwdUtpL3lK?=
 =?utf-8?B?bXRCQWZWVWlKVEJTUVJDd1JCaEVzZGRVMXFIMFhKRlRBT09VOFJid3RxU0RO?=
 =?utf-8?B?NGtPS3dkQ0t6M05pNWlKSEVXQ2xsSnZNRVVjRzFPSk1PM21CSkRETUYrSk83?=
 =?utf-8?B?ZW5raUdjbzBWQjQwdGZVTHR6cTd1NGVXK2VUMXlqSkR1Z3ZHVXV4aE5hcDZy?=
 =?utf-8?B?eW92WmtWZDU5WGFEZXA0UENmcEdtVTV5NEtqbkNDQlFrcWxhcWdqdnFzY3Zw?=
 =?utf-8?B?b0ZTSUh0WENBMHladlhVanNYQ0NLTUtUWlFuUFlPT3hicHhPT2ttVVZpSFFl?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dWxZQm5aY1ZmajlVNHlGZmZZYkRnUVRhSGRkd0p3VUdxZThyTkRDVlZtYjAz?=
 =?utf-8?B?N0Z4QlpkNDdFV21MTXN3citsejNzaW5qZTJRcXhoWGM1bUJLZ2NDOXhHQ2Ez?=
 =?utf-8?B?WnlnSlU3RTVzcDF3d2dLZTcyT1l1MW1STE84MkF0MlBrbVBCekNJTmtVdEp6?=
 =?utf-8?B?SHVNMFloUGNMbFBIdnpMQk9MZWkvM1l1YWtwR1RhNEg3MnQyVnY1SHQrMFkw?=
 =?utf-8?B?ZUhCVkVUc3c2dXdpY05STUhpSTBKVk1DZnd1SlpsaEpUUmtkU2Y4U2lvWlBo?=
 =?utf-8?B?MTJmaHoxQ0ZBbHNBM3JqQjhHZUpqQytHUFJtdHZqU3lOMm5PNlRMaE9mRFNE?=
 =?utf-8?B?Rlk3djVBZTgyelBoSGp3YTI3RVlGOWlLYndybGkxeE81dEFiTWpsQ1F6b09H?=
 =?utf-8?B?Q1YrMzZOak1obGpKbTM3TDNmWnM0dGo3RXYzVWJsd0ZNZDNFZWE3OTlLbS8w?=
 =?utf-8?B?OThjWnJmVFpqMVErQ0ZFdW5zSHZlUmNWZUNxTDREQUxXbldkYW0zQTlONklK?=
 =?utf-8?B?SE5XV0E1ZzRMWUtYVGJhUkZlWGNKdjlORThHNklkUEJlRVhjOFR0MzNYWTg4?=
 =?utf-8?B?bzF0QktJTHQ4MkpDS0lValhjc2ZxMVl1WXFKemdOR3NpL0NGNnRMWEdvTGha?=
 =?utf-8?B?K2FvUVhmU3FTOTdQcXpZektIek5xMFpjVk0wZzZyd0JPY2hwUWtuQXZwcHVh?=
 =?utf-8?B?c1R6elNlQzNybHowY2cyb3RxUTZiSmtndVAyN3JtYUxLRjlrNXRvWnZyS0No?=
 =?utf-8?B?YzFDNzlaSGlBTmhsemlIcVBmbDJ1eDA1dGs2eEVJZXl1cmJGcFlKakk3TDQy?=
 =?utf-8?B?K3ZOM05FazV2N0VBUHpjRXgvNU95ZnAxbjhNV1Q0U0tQb014K1JKQzdDdUdp?=
 =?utf-8?B?UHdZUURLZkptZmx0aHdVa0J0QUJTUFZqajhOem5GcjFKUWJmdW80V2ZIbU1u?=
 =?utf-8?B?cUZwOGV3Ly96eXlTODJUL0JZc0xOZ3NaSG12THcxc1JDK25xdkFQY1o1Mnho?=
 =?utf-8?B?dnlhUGZWMkRMUHVzdnpZbTYwbXpBam1sU2dESmZMYXp3WVlFNXhpYkYvV0Jn?=
 =?utf-8?B?WWZzOFlrbHhCWWxlTG9vellLRkFFaUxieHp1SW9XWVZnMHFYYTByWTdSRGdu?=
 =?utf-8?B?ZFFoSFo1QThXZ2lqNmJZL1A0cUZVMFIxNE9ZVko3OFhrKzg4em9adCs3M1gx?=
 =?utf-8?B?Q2IrU2NONHJSWmdMRE5ITC9xeXpPaHEzaDduK3Rxb25Hd1lnZ3V6V3E3Mnls?=
 =?utf-8?B?OVVqQ1NWTU9XYkxwbklnc0FSWW9YeVlaSVN1QUNLWWZjK0xmUWF2SnBNclFJ?=
 =?utf-8?B?Z3FIRTRGazZkSEQ2elhZVisxWk4wVDEvSEJjaHZCa2k2OWxoVWN0Ujg4ZGJL?=
 =?utf-8?B?K2VKNWhLZFRFdkdxMG1aTmZKcENPK2gzbkd0TDJUdFpaSElVd3crWlNHdCts?=
 =?utf-8?B?L0I0bEpUYzJ1RUhtQWVPbGYxMDR5T0VRdzRuVmQ1M0M1TENuMDlBMnEvNTdV?=
 =?utf-8?B?bDdnMWpjTUxVVXNSKzhKRndaYjNtOXQrMXZNUWVwVzA2d01rWDcvWFN3M2dm?=
 =?utf-8?B?elNrQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b9e564-7c34-4956-1568-08db562a1281
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 16:24:50.5509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLYC1o0KJO/TmeP6V7FT/MUyEE89nFEXhWRgiR93d2nY7L7yD7JbN2uuw1glvDfT/piqFEsXB1Yfh5kmJhVvXVONucNfLkHjq7u4S1BpCBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_08,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=614
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305160139
X-Proofpoint-GUID: 3gRKZsDPWCF0oeKywT_2lB0eZZPhD0dm
X-Proofpoint-ORIG-GUID: 3gRKZsDPWCF0oeKywT_2lB0eZZPhD0dm
Cc: Jens Axboe <axboe@kernel.dk>,
 Linux kernel regressions list <regressions@lists.linux.dev>, mst@redhat.com,
 linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
 Thorsten Leemhuis <linux@leemhuis.info>,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com, nicolas.dichtel@6wind.com
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

T24gNS8xNi8yMyAzOjM5IEFNLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToKPiBPbiBNb24sIE1h
eSAxNSwgMjAyMyBhdCAwNToyMzoxMlBNIC0wNTAwLCBNaWtlIENocmlzdGllIHdyb3RlOgo+PiBP
biA1LzE1LzIzIDEwOjQ0IEFNLCBMaW51cyBUb3J2YWxkcyB3cm90ZToKPj4+IE9uIE1vbiwgTWF5
IDE1LCAyMDIzIGF0IDc6MjPigK9BTSBDaHJpc3RpYW4gQnJhdW5lciA8YnJhdW5lckBrZXJuZWwu
b3JnPiB3cm90ZToKPj4+Pgo+Pj4+IFNvIEkgdGhpbmsgd2Ugd2lsbCBiZSBhYmxlIHRvIGFkZHJl
c3MgKDEpIGFuZCAoMikgYnkgbWFraW5nIHZob3N0IHRhc2tzCj4+Pj4gcHJvcGVyIHRocmVhZHMg
YW5kIGJsb2NraW5nIGV2ZXJ5IHNpZ25hbCBleGNlcHQgZm9yIFNJR0tJTEwgYW5kIFNJR1NUT1AK
Pj4+PiBhbmQgdGhlbiBoYXZpbmcgdmhvc3QgaGFuZGxlIGdldF9zaWduYWwoKSAtIGFzIHlvdSBt
ZW50aW9uZWQgLSB0aGUgc2FtZQo+Pj4+IHdheSBpbyB1cmluZyBhbHJlYWR5IGRvZXMuIFdlIHNo
b3VsZCBhbHNvIHJlbW92ZSB0aGUgaW5nb3JlX3NpZ25hbHMKPj4+PiB0aGluZyBjb21wbGV0ZWx5
IGltaG8uIEkgZG9uJ3QgdGhpbmsgd2UgZXZlciB3YW50IHRvIGRvIHRoaXMgd2l0aCB1c2VyCj4+
Pj4gd29ya2Vycy4KPj4+Cj4+PiBSaWdodC4gVGhhdCdzIHdoYXQgSU9fVVJJTkcgZG9lczoKPj4+
Cj4+PiAgICAgICAgIGlmIChhcmdzLT5pb190aHJlYWQpIHsKPj4+ICAgICAgICAgICAgICAgICAv
Kgo+Pj4gICAgICAgICAgICAgICAgICAqIE1hcmsgdXMgYW4gSU8gd29ya2VyLCBhbmQgYmxvY2sg
YW55IHNpZ25hbCB0aGF0IGlzbid0Cj4+PiAgICAgICAgICAgICAgICAgICogZmF0YWwgb3IgU1RP
UAo+Pj4gICAgICAgICAgICAgICAgICAqLwo+Pj4gICAgICAgICAgICAgICAgIHAtPmZsYWdzIHw9
IFBGX0lPX1dPUktFUjsKPj4+ICAgICAgICAgICAgICAgICBzaWdpbml0c2V0aW52KCZwLT5ibG9j
a2VkLCBzaWdtYXNrKFNJR0tJTEwpfHNpZ21hc2soU0lHU1RPUCkpOwo+Pj4gICAgICAgICB9Cj4+
Pgo+Pj4gYW5kIEkgcmVhbGx5IHRoaW5rIHRoYXQgdmhvc3Qgc2hvdWxkIGJhc2ljYWxseSBkbyBl
eGFjdGx5IHdoYXQgaW9fdXJpbmcgZG9lcy4KPj4+Cj4+PiBOb3QgYmVjYXVzZSBpb191cmluZyBm
dW5kYW1lbnRhbGx5IGdvdCB0aGlzIHJpZ2h0IC0gYnV0IHNpbXBseSBiZWNhdXNlCj4+PiBpb191
cmluZyBoYWQgYWxtb3N0IGFsbCB0aGUgc2FtZSBidWdzIChhbmQgdGhlbiBzb21lKSwgYW5kIHdo
YXQgdGhlCj4+PiBpb191cmluZyB3b3JrZXIgdGhyZWFkcyBlbmRlZCB1cCBkb2luZyB3YXMgdG8g
YmFzaWNhbGx5IHpvb20gaW4gb24KPj4+ICJ0aGlzIHdvcmtzIi4KPj4+Cj4+PiBBbmQgaXQgem9v
bWVkIGluIG9uIGl0IGxhcmdlbHkgYnkganVzdCBnb2luZyBmb3IgIm1ha2UgaXQgbG9vayBhcyBt
dWNoCj4+PiBhcyBwb3NzaWJsZSBhcyBhIHJlYWwgdXNlciB0aHJlYWQiLCBiZWNhdXNlIGV2ZXJ5
IHRpbWUgdGhlIGtlcm5lbAo+Pj4gdGhyZWFkIGRpZCBzb21ldGhpbmcgZGlmZmVyZW50LCBpdCBq
dXN0IGNhdXNlZCBwcm9ibGVtcy4KPj4+Cj4+PiBTbyBJIHRoaW5rIHRoZSBwYXRjaCBzaG91bGQg
anVzdCBsb29rIHNvbWV0aGluZyBsaWtlIHRoZSBhdHRhY2hlZC4KPj4+IE1pa2UsIGNhbiB5b3Ug
dGVzdCB0aGlzIG9uIHdoYXRldmVyIHZob3N0IHRlc3Qtc3VpdGU/Cj4+Cj4+IEkgdHJpZWQgdGhh
dCBhcHByb2FjaCBhbHJlYWR5IGFuZCBpdCBkb2Vzbid0IHdvcmsgYmVjYXVzZSBpb191cmluZyBh
bmQgdmhvc3QKPj4gZGlmZmVyIGluIHRoYXQgdmhvc3QgZHJpdmVycyBpbXBsZW1lbnQgYSBkZXZp
Y2Ugd2hlcmUgZWFjaCBkZXZpY2UgaGFzIGEgdmhvc3RfdGFzawo+PiBhbmQgdGhlIGRyaXZlcnMg
aGF2ZSBhIGZpbGVfb3BlcmF0aW9ucyBmb3IgdGhlIGRldmljZS4gV2hlbiB0aGUgdmhvc3RfdGFz
aydzCj4+IHBhcmVudCBnZXRzIHNpZ25hbCBsaWtlIFNJR0tJTEwsIHRoZW4gaXQgd2lsbCBleGl0
IGFuZCBjYWxsIGludG8gdGhlIHZob3N0Cj4+IGRyaXZlcidzIGZpbGVfb3BlcmF0aW9ucy0+cmVs
ZWFzZSBmdW5jdGlvbi4gQXQgdGhpcyB0aW1lLCB3ZSBuZWVkIHRvIGRvIGNsZWFudXAKPiAKPiBC
dXQgdGhhdCdzIG5vIHJlYXNvbiB3aHkgdGhlIHZob3N0IHdvcmtlciBjb3VsZG4ndCBqdXN0IGJl
IGFsbG93ZWQgdG8KPiBleGl0IG9uIFNJR0tJTEwgY2xlYW5seSBzaW1pbGFyIHRvIGlvX3VyaW5n
LiBUaGF0J3MganVzdCBkZXNjcmliaW5nIHRoZQo+IGN1cnJlbnQgYXJjaGl0ZWN0dXJlIHdoaWNo
IGlzbid0IGEgbmVjZXNzaXR5IGFmYWljdC4gQW5kIHRoZSBoZWxwZXIKPiB0aHJlYWQgY291bGQg
ZS5nLiwgY3Jhc2guCj4gCj4+IGxpa2UgZmx1c2ggdGhlIGRldmljZSB3aGljaCB1c2VzIHRoZSB2
aG9zdF90YXNrLiBUaGVyZSBpcyBhbHNvIHRoZSBjYXNlIHdoZXJlIGlmCj4+IHRoZSB2aG9zdF90
YXNrIGdldHMgYSBTSUdLSUxMLCB3ZSBjYW4ganVzdCBleGl0IGZyb20gdW5kZXIgdGhlIHZob3N0
IGxheWVyLgo+IAo+IEluIGEgd2F5IEkgcmVhbGx5IGRvbid0IGxpa2UgdGhlIHBhdGNoIGJlbG93
LiBCZWNhdXNlIHRoaXMgc2hvdWxkIGJlCj4gc29sdmFibGUgYnkgYWRhcHRpbmcgdmhvc3Qgd29y
a2Vycy4gUmlnaHQgbm93LCB2aG9zdCBpcyBjb21pbmcgZnJvbSBhCj4ga3RocmVhZCBtb2RlbCBh
bmQgd2UgcG9ydGVkIGl0IHRvIGEgdXNlciB3b3JrZXIgbW9kZWwgYW5kIHRoZSB3aG9sZQo+IHBv
aW50IG9mIHRoaXMgZXhjZXJjaXNlIGhhcyBiZWVuIHRoYXQgdGhlIHdvcmtlcnMgYmVoYXZlIG1v
cmUgbGlrZQo+IHJlZ3VsYXIgdXNlcnNwYWNlIHByb2Nlc3Nlcy4gU28gbXkgdGVuZGVuY3kgaXMg
dG8gbm90IG1hc3NhZ2Uga2VybmVsCj4gc2lnbmFsIGhhbmRsaW5nIHRvIG5vdyBhbHNvIGluY2x1
ZGUgYSBzcGVjaWFsIGNhc2UgZm9yIHVzZXIgd29ya2VycyBpbgo+IGFkZGl0aW9uIHRvIGt0aHJl
YWRzLiBUaGF0J3MganVzdCB0aGUgd3Jvbmcgd2F5IGFyb3VuZCBhbmQgdGhlbiB2aG9zdAo+IGNv
dWxkJ3ZlIGp1c3Qgc3R1Y2sgd2l0aCBrdGhyZWFkcyBpbiB0aGUgZmlyc3QgcGxhY2UuCgpJIHdv
dWxkIGhhdmUgcHJlZmVycmVkIHRoYXQgOikgTWF5YmUgbGV0J3MgdGFrZSBhIHN0ZXAgYmFjayBh
bmQgcmV2aXNpdAp0aGF0IGRlY2lzaW9uIHRvIG1ha2Ugc3VyZSBpdCB3YXMgcmlnaHQuIFRoZSB2
aG9zdCBsYXllciB3YW50czoKCjEuIGluaGVyaXQgY2dyb3Vwcy4KMi4gc2hhcmUgbW0uCjMuIG5v
IHNpZ25hbHMKNC4gdG8gbm90IHNob3cgdXAgd2FzIGFuIGV4dHJhIHByb2Nlc3MgbGlrZSBpbiBO
aWNvbGFzJ3MgYnVnLgo1LiBoYXZlIGl0J3Mgd29ya2VyIHRocmVhZHMgY291bnRlZCB1bmRlciBp
dHMgcGFyZW50IG5wcm9jIGxpbWl0LgoKV2UgY2FuIGRvIDEgLSA0IHRvZGF5IHdpdGgga3RocmVh
ZHMuIENhbiB3ZSBkbyAjNSB3aXRoIGt0aHJlYWRzPyBNeSBmaXJzdAphdHRlbXB0IHdoaWNoIHBh
c3NlZCBhcm91bmQgdGhlIGNyZWRzIHRvIHVzZSBmb3Iga3RocmVhZHMgb3IgZXhwb3J0ZWQgYQpo
ZWxwZXIgZm9yIHRoZSBucHJvYyBhY2NvdW50aW5nIHdhcyBub3QgbGlrZWQgYW5kIHdlIGV2ZW50
dWFsbHkgZW5kZWQgdXAKaGVyZS4KCklzIHRoaXMgaHliaXJkIHVzZXIva2VybmVsIHRocmVhZC90
YXNrIHN0aWxsIHRoZSByaWdodCB3YXkgdG8gZ28gb3IgaXMKYmV0dGVyIHRvIHVzZSBrdGhyZWFk
cyBhbmQgYWRkIHNvbWUgd2F5IHRvIGhhbmRsZSAjNT8KCgo+IAo+IFNvIEknbSBmaW5lIHdpdGgg
c2tpcHBpbmcgb3ZlciB0aGUgZnJlZXppbmcgY2FzZSBmb3Igbm93IGJ1dCBTSUdLSUxMCj4gc2hv
dWxkIGJlIGhhbmRsZWQgaW1oby4gT25seSBpbml0IGFuZCBrdGhyZWFkcyBzaG91bGQgZ2V0IHRo
ZSBsdXh1cnkgb2YKPiBpZ25vcmluZyBTSUdLSUxMLgo+IAo+IFNvLCBJJ20gYWZyYWlkIEknbSBh
c2tpbmcgc29tZSB3b3JrIGhlcmUgb2YgeW91IGJ1dCBob3cgZmVhc2libGUgd291bGQgYQo+IG1v
ZGVsIGJlIHdoZXJlIHZob3N0X3dvcmtlcigpIHNpbWlsYXIgdG8gaW9fd3Ffd29ya2VyKCkgZ3Jh
Y2VmdWxseQo+IGhhbmRsZXMgU0lHS0lMTC4gWWVzLCBJIHNlZSB0aGVyZSdzCj4gCj4gbmV0LmM6
ICAgLnJlbGVhc2UgPSB2aG9zdF9uZXRfcmVsZWFzZQo+IHNjc2kuYzogIC5yZWxlYXNlID0gdmhv
c3Rfc2NzaV9yZWxlYXNlCj4gdGVzdC5jOiAgLnJlbGVhc2UgPSB2aG9zdF90ZXN0X3JlbGVhc2UK
PiB2ZHBhLmM6ICAucmVsZWFzZSA9IHZob3N0X3ZkcGFfcmVsZWFzZQo+IHZzb2NrLmM6IC5yZWxl
YXNlID0gdmlydGlvX3RyYW5zcG9ydF9yZWxlYXNlCj4gdnNvY2suYzogLnJlbGVhc2UgPSB2aG9z
dF92c29ja19kZXZfcmVsZWFzZQo+IAo+IGJ1dCB0aGF0IG1lYW5zIHlvdSBoYXZlIGFsbCB0aGUg
YmFzaWMgbG9naWMgaW4gcGxhY2UgYW5kIGFsbCBvZiB0aG9zZQo+IGRyaXZlcnMgYWxzbyBzdXBw
b3J0IHRoZSBWSE9TVF9SRVNFVF9PV05FUiBpb2N0bCB3aGljaCBhbHNvIHN0b3BzIHRoZQo+IHZo
b3N0IHdvcmtlci4gSSdtIGNvbmZpZGVudCB0aGF0IGEgbG9mIHRoaXMgY2FuIGJlIGxldmVyYWdl
ZCB0byBqdXN0Cj4gY2xlYW51cCBvbiBTSUdLSUxMLgoKV2UgY2FuIGRvIHRoaXMsIGJ1dCB0aGUg
aXNzdWUgSSdtIHdvcnJpZWQgYWJvdXQgaXMgdGhhdCByaWdodCBub3cgaWYgdGhlcmUKaXMgcXVl
dWVkL3J1bm5pbmcgSU8gYW5kIHVzZXJzcGFjZSBlc2NhbGF0ZXMgdG8gU0lHS0lMTCwgdGhlbiB0
aGUgdmhvc3QgbGF5ZXIKd2lsbCBzdGlsbCBjb21wbGV0ZSB0aG9zZSBJT3MuIElmIHdlIG5vdyBh
bGxvdyBTSUdLSUxMIG9uIHRoZSB2aG9zdCB0aHJlYWQsCnRoZW4gdGhvc2UgSU9zIG1pZ2h0IGZh
aWwuCgpJZiB3ZSBnZXQgYSBTSUdLSUxMLCBJIGNhbiBtb2RpZnkgdmhvc3Rfd29ya2VyKCkgc28g
dGhhdCBpdCB0ZW1wb3JhcmlseQppZ25vcmVzIHRoZSBzaWduYWwgYW5kIGFsbG93cyBJTy9mbHVz
aGVzL3doYXRldmVyLW9wZXJhdGlvbnMgdG8gY29tcGxldGUKYXQgdGhhdCBsZXZlbC4gSG93ZXZl
ciwgd2UgY291bGQgaGl0IGlzc3VlcyB3aGVyZSB3aGVuIHZob3N0X3dvcmtlcigpCmNhbGxzIGlu
dG8gdGhlIGRyaXZlcnMgbGlzdGVkIGFib3ZlLCBhbmQgdGhvc2UgZHJpdmVycyBjYWxsIGludG8g
d2hhdGV2ZXIKa2VybmVsIGxheWVyIHRoZXkgdXNlLCB0aGF0IG1pZ2h0IGRvCgppZiAoc2lnbmFs
X3BlbmRpbmcoY3VycmVudCkpCglyZXR1cm4gZmFpbHVyZTsKCmFuZCB3ZSBub3cgZmFpbC4KCklm
IHdlIHNheSB0aGF0IHNpbmNlIHdlIGdvdCBhIFNJR0tJTEwsIHRoZW4gZmFpbGluZyBpcyBhY2Nl
cHRhYmxlIGJlaGF2aW9yCm5vdywgSSBjYW4gY29kZSB3aGF0IHlvdSBhcmUgcmVxdWVzdGluZy4K
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
