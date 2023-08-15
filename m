Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FE1C0015E
	for <virtualization@archiver.kernel.org>; Tue, 15 Aug 2023 23:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 660D841B3F;
	Tue, 15 Aug 2023 23:11:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 660D841B3F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=CDCjC/Ye;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=b1CGtt+f
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YaKsNktRb0YX; Tue, 15 Aug 2023 23:11:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 35F2D41B39;
	Tue, 15 Aug 2023 23:11:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 35F2D41B39
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0413CC0071;
	Tue, 15 Aug 2023 23:11:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A91AC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 23:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D7CC841B3C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 23:11:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D7CC841B3C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sGnWnsG4OIVh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 23:11:45 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5262941B39
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 23:11:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5262941B39
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37FMicYu026072; Tue, 15 Aug 2023 23:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4Fra4gkoA0C8r0Lb2apyB8VmhoDbuXOADOp6yZU3BAc=;
 b=CDCjC/YemKPmqY/JWqSLt4922LqxTxL5rsu08LC6AD+QPmpOUUvTLR1FIgPzTqhH3xJl
 Z7oQZq0cqgtgxNCZ+3+sxBZ0AfN/V0DiCFAquhzUV2/PI/vew8ffz5pRtR0bojvBnWww
 vFBQmm1EIbHfQw6T08v0/u5pP3ovJB/0JAL7CtCwHSPL8FnHFtfD8B3hx8nHtc6XFLry
 QcwyjGbGjRalvMKFZiYafpL8D5oJ/JXYZNR4voYlf9DV+IZvukQnq2yPUY6fYsG/Jojo
 50L/2N7sGT+Y3LJZTVcu7SBP85eWp7fTVZNw/Dx2ChFcUXyVKGmjYWbggJ1CRQb35vb9 ZA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w5wty0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Aug 2023 23:11:42 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37FLcQoB039550; Tue, 15 Aug 2023 23:11:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sey70ngee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Aug 2023 23:11:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJSMXBlq9FyxuifeKf+qMMafaGVj62+XPLSpjW/4W5Tw/DzEVVzQU3hd0XpngPO0yU0VfXcNwUKsLTHrwLuhUW0Y2gYW1eEB1CMrlKhLEEMkUO/uWWL7CggrSrJpzB/dNzzPWOkqW2WPPBXrRbnc3mCbHSyHvF5INLUH7l4K9qFIkOlR4vcx+EaNFhmDuudr0l2Vi5TFwRaZmuY/j9RMrUJHzWYtrO+C0OuTHGb2VUvCyP3V4j+Gw4gXCLGpRTt1UaZ5E+w6wM/S1ngNqWQx6J5MyBqARDhYe0YKO1x1ZnF0e87k6KU+B1gyhH31smBaF/DiegZpoKs1GxldbSighw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Fra4gkoA0C8r0Lb2apyB8VmhoDbuXOADOp6yZU3BAc=;
 b=RUPOlkIGyuKKzSpT3gAadWDkw168ciYTbnxBgv26co0cMHy4RDbmGPO5rDoYFMoA/ujGIPMphA0Khh9DBNsensoSxXla/mUIcxbqilK8brX6V0OJ9cmALlNu5i9Cfy0Y4ODuM97LgtvliyyqpTVqUlHy715/pniiAUkc3dfm7pIxwJ8iCV0DvI792FwZpTawXfKDFIMPOd6UkQHHWNVjJslf2Tf/z9E5nz5vNNU60Es0nOnQqlfx4z2MHx5lZ5d0XKatQz4w1FFwu+URN+vYBI5SxV3G7qpzvdyxbk6YLEjAr5GKVynAeBU28Rg4Kn1hv7ZQhYocQlaILc8QVHEkWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Fra4gkoA0C8r0Lb2apyB8VmhoDbuXOADOp6yZU3BAc=;
 b=b1CGtt+ffjvWoPVfTyJGB/T2tBkbCr16bPrub4rsHNTaG2X8vt1Kgc375oeBeYmYljzxlUuct77TMqJ7qhUu0aUgVLnNtNMQ59RDzhHyEPrEZZzvhkRrnnRGDpX05IlGfUsolUt4p+5ncDo1Sf3Ym4hYTKklVT7FmifKltK69Bg=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH2PR10MB4120.namprd10.prod.outlook.com (2603:10b6:610:7d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 23:11:39 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 23:11:39 +0000
Message-ID: <5f9d33ec-145c-7c41-989a-1d80af3ea19d@oracle.com>
Date: Tue, 15 Aug 2023 16:11:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 2/4] vdpa/mlx5: implement .reset_map driver op
Content-Language: en-US
To: Dragos Tatulea <dtatulea@nvidia.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-3-git-send-email-si-wei.liu@oracle.com>
 <ec351090ef971976f5149ca1a32563b1fb1bb857.camel@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ec351090ef971976f5149ca1a32563b1fb1bb857.camel@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::14) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH2PR10MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: c36d13b5-3b66-4ed0-ebbe-08db9de4fadb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PcJC4+hW26sVps1H0J5ZrTaSrESmK1puqw01kg8Eku1EHs4teVuPyGLLOAJuoSOsYwAqGb2i0ckcsq+C+lSRVbqmRdM9K/Bybv8gYgSHW1qzLU6TK7SQ9NufDl0Q3Oflui8iKe6RYnA4wtPscx47vF5eyQzaKXLvrM0Dl3zv3JkwLULTWrhiWHtz8t00qoAvrCBblNY3gv/IKFG+jev6aUHJzx/3dsxVWOKhDFTc2VmPD5VUi+Xlx3MIy7WzTcobdRP3GljzpbVe0mCkaVAxPQrtyGwplwMbTCzp+bVz275YSDFwksmCf4IvOyuNZG0e+Yll74rnKT6SKffCfkm1gTe0w/bb8Lw9wjUuJbWtMoGhZ4zR/AL+I16argyyyf6NU7ynar1l5FG6lWyaSGKltoRW8kCsWJyjd9ccgEBTzeX29HYq9EdAFJBuOGSsqrpajRuldmRkfe3GlDGKy7M+KLJELDhbUmo/Wvkm+45bYoqp47sut7Jkqep9H4YKSXoOVGBvq4mu+pBVT66OZEeHTeQC0pt+MGKPqyGf/u81ef0S8qGIVYaqUtxwyAu7kfbRo28b2BGqB0ytB8lyXsAVkyN49S8CH4RQWoog3TYg7Ej+5j5ZCEiOrIZRqrUAs9KXifd0FTC67uD+QGfp5aWszeGbkF54MyKDkx1Y2JWBOZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199024)(186009)(1800799009)(5660300002)(4326008)(66946007)(83380400001)(36756003)(110136005)(6512007)(478600001)(36916002)(6486002)(38100700002)(8936002)(53546011)(31686004)(2616005)(316002)(26005)(6506007)(966005)(86362001)(31696002)(66556008)(2906002)(66476007)(6666004)(54906003)(41300700001)(8676002)(142923001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0lXSjd2Rmo5MzhRd2FPbTBia0o3TkJqaUNsd3FkbzNkYlYraWlSU2lMSVhI?=
 =?utf-8?B?V2d3SHNtVVhKVHFQUFBOdW1ROHA3dW8xN1lIR2g5aHp0VERiZlBRZkVYci8v?=
 =?utf-8?B?WjdYdVMzZHNxdDZraStEbzBqV3pnWkNTUjhac3Zhako5QXNQeG0xK3JtaWJH?=
 =?utf-8?B?MXVlSFVFQm9qWkoyWTVWcUc4eXYvVkVSOGFUUFMrZ3NaSW5XWWVtUHA0WGJ2?=
 =?utf-8?B?RHlYQUV2MUtieU5aKy9nWkU5dlQvdGhMUlRxaEhyNmdQeWhvN0dyakxScmpp?=
 =?utf-8?B?UEtORzdaWEZKajdKNHJ4WCtFbFJQRG13MFU5N0hxa2Roa2Jna1JvVDErWE0x?=
 =?utf-8?B?NnltYnF0U1dGRVZxSnRRSW96TzJsWWpqcjRUT0NDaDNnVk5ZbXpidkdmODNI?=
 =?utf-8?B?elF2R0FHVjFPN1VFYlQzZ2x6QTRadm1uVU4vUWJsdG0wRStSemJ4eERXcGVD?=
 =?utf-8?B?WWpDOVdtM2ZWYTR5Vm5waGZreHppeHlDOTkzVm0xSVhHK2V2N3NjelorSVZN?=
 =?utf-8?B?N05zYkM0MWwvR3d6M3lIaWVoYkxqeTRDTFVOVGphWTJVMERoWUtaVVJmQVQ3?=
 =?utf-8?B?ZjFiMmJpbkFHTldHSTRSaEJhOWZLMUFHQXdkV0tQbHVsMHNibHRBc0NOSGxv?=
 =?utf-8?B?WGVleXpUcXZVaTIzQ21kTTE1cDY3aklvVHM4dzBwVHQxMWw4U0VGblRROWx0?=
 =?utf-8?B?a1ZJUU5jb2FnQ2dPNm9oWlVNSkdwYS9aVHdha2Y5bUtqaDFabWwxbXBuRG5z?=
 =?utf-8?B?YTJmR1JhVlFvSFd0UnJ0cGtnV21sZjBBRWR2NDlmQ0Zlc1hWR3NLNWlGN3FY?=
 =?utf-8?B?akt5WWxnaWNic0lCSmd6c1h0dU03c0tGRkh6VlQxWGRUZzlXK1RlcjBDUW9n?=
 =?utf-8?B?WkpkUHRYaDA2Z3ZzVGV6SEpYcSsxZ2U1bjJLdi9rYWt5azhUY0tpeTkxNlpT?=
 =?utf-8?B?Ti9qK3lJeHBKSVdhL1IvSEcvdlJkbW1DbElycDRjYklkTUtEVG5kN2ZPL1hn?=
 =?utf-8?B?N2dtblc2T1UvN3JvL2ZvSXpUMTBUTU5mcllNcTd3WW1zL1JlenU4VlY2R09o?=
 =?utf-8?B?TzNsazhtb1lydVdTMnpvV284OVRDU3E2ZUtBTG0xUlFRV2phOXArNnF3RnR6?=
 =?utf-8?B?dVZCdGRhKzBWY0pnZjZVdDRlOVhOOHR2VFFwbWRrK0NDeVFGcG5SWjhNMlFy?=
 =?utf-8?B?NUJmaGpEVERsZ0VBM1didGZvdGRNbTdodHdrK3lHRVQ3anpPbWh3UDh3ajVE?=
 =?utf-8?B?TThFU0RiUkVDTTBib3NDKzlNSnRZTVJiR1ZMUDFWSlFJNGFPUzV6dlJvWEFa?=
 =?utf-8?B?YmE4aDhZNXpVTjRlakxWcXhJc1o0bDBvRTFYZU1uTWNQVitMcXdHS3VaTE1Y?=
 =?utf-8?B?R3lQZG9xMC9Tc1duVlRWNFNxV2cvZXRFTDNVWHV3RzFHQlp6UWZVb0ZXd0NM?=
 =?utf-8?B?d1dBTVVuNS9Od1hyY3V2TVFnZmpTb3hIN2htWTdOVk9YenR5UXpxcGdyMmpu?=
 =?utf-8?B?UGtVWXFCMjU4NTNoMDlYV2RVbko5WGNOQ1JzWWdFaWhZYVlZM3JiZHgxYStT?=
 =?utf-8?B?c3VCVmNTR1pDYml5bmVKREpmbFlZaFkxVWRva3RaSTYrSVFKUWtuLzBiN2hi?=
 =?utf-8?B?QXZ6L0tmM1JoVEpZdVRoWmxvLzBoOWJuOGlrKzVxTWFmVEQ2aUhYYXZvVDFH?=
 =?utf-8?B?ZG93Sjl1bzUzR2c3MzRqcXArenRIZjNXV1FpN0t1WXpONm83UXBNTFMxcDVa?=
 =?utf-8?B?WDdKa2lpeVh0Z0l2clE2WTZjM2hnWi9iN3A4cDhTN3phNVRmQS94ZVpSNTBi?=
 =?utf-8?B?WDFENFNNZmt4RXJ4a1ZMYkduNy9aWUlITTJXQnJENGdxSktzMGdrcUx6VkZS?=
 =?utf-8?B?REp6cU1takNKMHI3ejY4dHkzaHRmTis1NzdSdVlLWXg1YjAyZ251NEwvTFRU?=
 =?utf-8?B?dHovdW5WZ0g2QnBTTXYyeGtsZ2llZHpETDJENjRGTUVkYk1Qcm9RcjFFSFE4?=
 =?utf-8?B?MmNXcXFadjJBRzdWUitjbVJUN0RzR1NzTW5GMnBRS0JSUlFHLzdDaUVwWGkx?=
 =?utf-8?B?MmE2ZmZrd3VFeUxTK3FValNIY2dEUnVhYVhRVTNHenFjT2dGL1pVTm81aTQ1?=
 =?utf-8?Q?QPI04Y1M+1F0QMh49Mm4i9M3h?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RWdTU1BIQUI3KzJINGFPdzJpcGpWUDZjamNmWGh4U3ZRSmlCMzQ5VTM1ZXYr?=
 =?utf-8?B?NkQyZHN2bGVxbVJUVkdBaFBsSTZMcXE4NjNmeWtvY1luZE1EOUJaaGNyS01J?=
 =?utf-8?B?bWhXY2hOMk9DRjcrQUdEeTZTTVVKMmxxYUtib0YzL0VOZlJNaUc3NVdlTkF1?=
 =?utf-8?B?bGlQN2Q3dUdZSXVFQVY0OUxzR3hTRS81SDhsRm1ZMHlGQjA1WXBRMndLNFM1?=
 =?utf-8?B?RnV0NVh0Y1F4RUZmSmNxMTdHRFg0VWd4NU5VUS81V2FVV1RaVEhBSXNHazdr?=
 =?utf-8?B?RStocnFqMWJnYlc4Mm0wZHFXblhVN2VyeGErMlhLVENXSHdMSmFCWVpwT2pW?=
 =?utf-8?B?cm9QTWdXNnF6VlpJTGpXS0pDdHJ5NDdHSEEvNWdmT2M0M1NZNEhrenBYS2Y3?=
 =?utf-8?B?eXlWUHFMdW9NMlZSNG51K0kvVi9xc1VkWXF1d3JIdXM5WkJxaDFBWlBZMWpI?=
 =?utf-8?B?bHdUVkZkTVltSmgxRnNUL0Q0bzU4WjNVOVpVTWl3NkNueTJ4YjcxNkZzQ1V6?=
 =?utf-8?B?WmhkZjBLcTBXeEJiU2tqcE5xcGhCaWJBRE1GU3pObmxpazJkbEZmbUEwUXN2?=
 =?utf-8?B?RWJVWmw0VDhJSWYwazU3RUZGRklkZFExc05oQS9nalFuTXhmUjM0eEhacnpS?=
 =?utf-8?B?SnlWRk82UmFWWUpGVnlyc2UzNFZHaWhjaktuNk1CUkFoWW1rRXBtVFQ0cUdQ?=
 =?utf-8?B?TSs3dWJBTkQraVpsdkFHV1BvbEhHcWhQZURwZitjZG54bHdUK3hGMXRJRTA3?=
 =?utf-8?B?VWJBN0psNGNvRVB5bkkvaWU0d0I2N1FlQXoxY21Zd25OdlJJZ0p0OVlTOTZY?=
 =?utf-8?B?a2hMb2pTR3A5QUxGSmJxRXdvZjZHV1J5WnBndUhrZTk0QkVaWGlrVDd3QVFu?=
 =?utf-8?B?eVd4WXgyWUUrOGFqUWl5WkJJMDVyTEpUZjRXT25LekkyVmVhRDdlQWVDYklk?=
 =?utf-8?B?Q2ZqL1NPRGlnZEFsNUV3dnk3cDFDay9HeHl6dHBrTmhLWkZVNVNvTTlWdWd1?=
 =?utf-8?B?eXYrd0lHYzQzcmk1WFh0VjlaRk93VlEzdWU5aytPSmNXUTY3bGNLYUU4djFR?=
 =?utf-8?B?OUlLL2dFYXBWbUlNYUZwQXBER0s5cFRpZnpjYXlRVk9TSDBCTGVSOURSUlVh?=
 =?utf-8?B?VEdoWTI3ZVprbDNjV1l3VkZ3eVQ0aHorNy9yRGNlMm1kTWJmM0pBczFINFcv?=
 =?utf-8?B?bGY5eXNQUS9YWEV0djZONUtZUmJuaXF4R3FvNzdZZUgzOFFFOHh4VEx0c1RI?=
 =?utf-8?Q?VYXYHZYXj6V+YkI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36d13b5-3b66-4ed0-ebbe-08db9de4fadb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 23:11:39.1455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEl3E0T7rXVriQ1K67e/bwnDWWtTbEUlVYmGeee6i0HM/O2HvM9rGqH7LWtuXPmeFUffCkgriM/CGYZQ+2qAfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_19,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150209
X-Proofpoint-ORIG-GUID: 8zkOgU5OBfM8jBMj79KwZYPdx95-YxFL
X-Proofpoint-GUID: 8zkOgU5OBfM8jBMj79KwZYPdx95-YxFL
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "mst@redhat.com" <mst@redhat.com>, Gal Pressman <gal@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>
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

CgpPbiA4LzE1LzIwMjMgMToyNiBBTSwgRHJhZ29zIFRhdHVsZWEgd3JvdGU6Cj4gT24gTW9uLCAy
MDIzLTA4LTE0IGF0IDE4OjQzIC0wNzAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+PiBUaGlzIHBhdGNo
IGlzIGJhc2VkIG9uIHRvcCBvZiB0aGUgInZkcGEvbWx4NTogRml4ZXMKPj4gZm9yIEFTSUQgaGFu
ZGxpbmciIHNlcmllcyBbMV0uCj4+Cj4+IFsxXSB2ZHBhL21seDU6IEZpeGVzIGZvciBBU0lEIGhh
bmRsaW5nCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxpemF0aW9uLzIwMjMwODAy
MTcxMjMxLjExMDAxLTEtZHRhdHVsZWFAbnZpZGlhLmNvbS8KPj4KPj4gU2lnbmVkLW9mZi1ieTog
U2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+PiAtLS0KPj4gIMKgZHJpdmVycy92
ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCB8wqAgMSArCj4+ICDCoGRyaXZlcnMvdmRwYS9tbHg1
L2NvcmUvbXIuY8KgwqDCoMKgwqDCoMKgIHwgNzIgKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLQo+PiAtCj4+ICDCoGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuY8Kg
IHwgMTggKysrKysrKy0tLQo+PiAgwqAzIGZpbGVzIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKyks
IDM3IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvY29y
ZS9tbHg1X3ZkcGEuaAo+PiBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPj4g
aW5kZXggYjUzNDIwZS4uNWM5YTI1YSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUv
Y29yZS9tbHg1X3ZkcGEuaAo+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRw
YS5oCj4+IEBAIC0xMjMsNiArMTIzLDcgQEAgaW50IG1seDVfdmRwYV9jcmVhdGVfbXIoc3RydWN0
IG1seDVfdmRwYV9kZXYgKm12ZGV2LAo+PiBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAo+PiAg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQg
aW50IGFzaWQpOwo+PiAgwqB2b2lkIG1seDVfdmRwYV9kZXN0cm95X21yKHN0cnVjdCBtbHg1X3Zk
cGFfZGV2ICptdmRldik7Cj4+ICDCoHZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXJfYXNpZChzdHJ1
Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludAo+PiBhc2lkKTsKPj4gK2ludCBt
bHg1X3ZkcGFfcmVzZXRfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCB1bnNpZ25lZCBp
bnQgYXNpZCk7Cj4+ICAgCj4+ICDCoCNkZWZpbmUgbWx4NV92ZHBhX3dhcm4oX19kZXYsIGZvcm1h
dCwKPj4gLi4uKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgXAo+PiAgwqDCoMKgwqDCoMKgwqDCoGRldl93YXJuKChfX2RldiktPm1kZXYtPmRl
dmljZSwgIiVzOiVkOihwaWQgJWQpIHdhcm5pbmc6ICIgZm9ybWF0LAo+PiBfX2Z1bmNfXywgX19M
SU5FX18swqDCoMKgwqAgXAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9t
ci5jIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCj4+IGluZGV4IDVhMTk3MWZjLi5jOGQ2
NGZjIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKPj4gKysrIGIv
ZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCj4+IEBAIC00ODksMjEgKzQ4OSwxNSBAQCBzdGF0
aWMgdm9pZCBkZXN0cm95X3VzZXJfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAo+PiBz
dHJ1Y3QgbWx4NV92ZHBhX21yICptcgo+PiAgwqDCoMKgwqDCoMKgwqDCoH0KPj4gIMKgfQo+PiAg
IAo+PiAtc3RhdGljIHZvaWQgX21seDVfdmRwYV9kZXN0cm95X2N2cV9tcihzdHJ1Y3QgbWx4NV92
ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkCj4+IGludCBhc2lkKQo+PiArc3RhdGljIHZvaWQgX21s
eDVfdmRwYV9kZXN0cm95X2N2cV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpCj4+ICDC
oHsKPj4gLcKgwqDCoMKgwqDCoMKgaWYgKG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9DVlFf
R1JPVVBdICE9IGFzaWQpCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm47
Cj4+IC0KPj4gIMKgwqDCoMKgwqDCoMKgwqBwcnVuZV9pb3RsYihtdmRldik7Cj4+ICDCoH0KPj4g
ICAKPj4gLXN0YXRpYyB2b2lkIF9tbHg1X3ZkcGFfZGVzdHJveV9kdnFfbXIoc3RydWN0IG1seDVf
dmRwYV9kZXYgKm12ZGV2LCB1bnNpZ25lZAo+PiBpbnQgYXNpZCkKPj4gK3N0YXRpYyB2b2lkIF9t
bHg1X3ZkcGFfZGVzdHJveV9kdnFfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2KQo+PiAg
wqB7Cj4+ICDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IG1seDVfdmRwYV9tciAqbXIgPSAmbXZkZXYt
Pm1yOwo+PiAgIAo+PiAtwqDCoMKgwqDCoMKgwqBpZiAobXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9W
RFBBX0RBVEFWUV9HUk9VUF0gIT0gYXNpZCkKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybjsKPj4gLQo+PiAgwqDCoMKgwqDCoMKgwqDCoGlmICghbXItPmluaXRpYWxpemVk
KQo+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm47Cj4+ICAgCj4+IEBA
IC01MjEsOCArNTE1LDEwIEBAIHZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXJfYXNpZChzdHJ1Y3Qg
bWx4NV92ZHBhX2Rldgo+PiAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lkKQo+PiAgIAo+PiAgwqDC
oMKgwqDCoMKgwqDCoG11dGV4X2xvY2soJm1yLT5ta2V5X210eCk7Cj4+ICAgCj4+IC3CoMKgwqDC
oMKgwqDCoF9tbHg1X3ZkcGFfZGVzdHJveV9kdnFfbXIobXZkZXYsIGFzaWQpOwo+PiAtwqDCoMKg
wqDCoMKgwqBfbWx4NV92ZHBhX2Rlc3Ryb3lfY3ZxX21yKG12ZGV2LCBhc2lkKTsKPj4gK8KgwqDC
oMKgwqDCoMKgaWYgKG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9EQVRBVlFfR1JPVVBdID09
IGFzaWQpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfbWx4NV92ZHBhX2Rlc3Ry
b3lfZHZxX21yKG12ZGV2KTsKPj4gK8KgwqDCoMKgwqDCoMKgaWYgKG12ZGV2LT5ncm91cDJhc2lk
W01MWDVfVkRQQV9DVlFfR1JPVVBdID09IGFzaWQpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBfbWx4NV92ZHBhX2Rlc3Ryb3lfY3ZxX21yKG12ZGV2KTsKPj4gICAKPj4gIMKgwqDC
oMKgwqDCoMKgwqBtdXRleF91bmxvY2soJm1yLT5ta2V5X210eCk7Cj4+ICDCoH0KPj4gQEAgLTUz
NCwyNSArNTMwLDE3IEBAIHZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoc3RydWN0IG1seDVfdmRw
YV9kZXYgKm12ZGV2KQo+PiAgwqB9Cj4+ICAgCj4+ICDCoHN0YXRpYyBpbnQgX21seDVfdmRwYV9j
cmVhdGVfY3ZxX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKPj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQg
YXNpZCkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIpCj4+ICDCoHsK
Pj4gLcKgwqDCoMKgwqDCoMKgaWYgKG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9DVlFfR1JP
VVBdICE9IGFzaWQpCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsK
Pj4gLQo+PiAgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBkdXBfaW90bGIobXZkZXYsIGlvdGxiKTsK
Pj4gIMKgfQo+PiAgIAo+PiAgwqBzdGF0aWMgaW50IF9tbHg1X3ZkcGFfY3JlYXRlX2R2cV9tcihz
dHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgdmhvc3Rf
aW90bGIgKmlvdGxiLAo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IGFzaWQpCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiKQo+PiAgwqB7Cj4+ICDCoMKgwqDCoMKg
wqDCoMKgc3RydWN0IG1seDVfdmRwYV9tciAqbXIgPSAmbXZkZXYtPm1yOwo+PiAgwqDCoMKgwqDC
oMKgwqDCoGludCBlcnI7Cj4+ICAgCj4+IC3CoMKgwqDCoMKgwqDCoGlmIChtdmRldi0+Z3JvdXAy
YXNpZFtNTFg1X1ZEUEFfREFUQVZRX0dST1VQXSAhPSBhc2lkKQo+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4+IC0KPj4gIMKgwqDCoMKgwqDCoMKgwqBpZiAobXIt
PmluaXRpYWxpemVkKQo+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
MDsKPj4gICAKPj4gQEAgLTU3NCwyMCArNTYyLDE4IEBAIHN0YXRpYyBpbnQgX21seDVfdmRwYV9j
cmVhdGVfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYKPj4gKm12ZGV2LAo+PiAgwqB7Cj4+ICDCoMKg
wqDCoMKgwqDCoMKgaW50IGVycjsKPj4gICAKPj4gLcKgwqDCoMKgwqDCoMKgZXJyID0gX21seDVf
dmRwYV9jcmVhdGVfZHZxX21yKG12ZGV2LCBpb3RsYiwgYXNpZCk7Cj4+IC3CoMKgwqDCoMKgwqDC
oGlmIChlcnIpCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gZXJyOwo+
PiAtCj4+IC3CoMKgwqDCoMKgwqDCoGVyciA9IF9tbHg1X3ZkcGFfY3JlYXRlX2N2cV9tcihtdmRl
diwgaW90bGIsIGFzaWQpOwo+PiAtwqDCoMKgwqDCoMKgwqBpZiAoZXJyKQo+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXRfZXJyOwo+PiArwqDCoMKgwqDCoMKgwqBpZiAo
bXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0RBVEFWUV9HUk9VUF0gPT0gYXNpZCkgewo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyID0gX21seDVfdmRwYV9jcmVhdGVfZHZx
X21yKG12ZGV2LCBpb3RsYiwgYXNpZCk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBpZiAoZXJyKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiBlcnI7Cj4+ICvCoMKgwqDCoMKgwqDCoH0KPj4gK8KgwqDCoMKgwqDCoMKgaWYg
KG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9DVlFfR1JPVVBdID09IGFzaWQpIHsKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVyciA9IF9tbHg1X3ZkcGFfY3JlYXRlX2N2cV9t
cihtdmRldiwgaW90bGIpOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGVy
cikKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gZXJyOwo+IEkgdGhpbmsgeW91IHN0aWxsIG5lZWQgdGhlIGdvdG8gaGVyZSwgd2hlbiBDVlEg
YW5kIERWUSBmYWxsIGluIHNhbWUgYXNpZCBhbmQKPiB0aGVyZSdzIGEgQ1ZRIG1yIGNyZWF0aW9u
IGVycm9yLCB5b3UgYXJlIGxlZnQgc3R1Y2sgd2l0aCB0aGUgRFZRIG1yLgpZZXMsIHlvdSBhcmUg
cmlnaHQsIEkgd2lsbCBmaXggdGhpcyBpbiB2Mi4gVGhhbmsgeW91IGZvciBzcG90dGluZyB0aGlz
IQoKLVNpd2VpCgo+Cj4+ICvCoMKgwqDCoMKgwqDCoH0KPj4gICAKPj4gIMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gMDsKPj4gLQo+PiAtb3V0X2VycjoKPj4gLcKgwqDCoMKgwqDCoMKgX21seDVfdmRw
YV9kZXN0cm95X2R2cV9tcihtdmRldiwgYXNpZCk7Cj4+IC0KPj4gLcKgwqDCoMKgwqDCoMKgcmV0
dXJuIGVycjsKPj4gIMKgfQo+PiAgIAo+PiAgwqBpbnQgbWx4NV92ZHBhX2NyZWF0ZV9tcihzdHJ1
Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCB2aG9zdF9pb3RsYgo+PiAqaW90bGIsCj4+
IEBAIC02MDEsNiArNTg3LDI4IEBAIGludCBtbHg1X3ZkcGFfY3JlYXRlX21yKHN0cnVjdCBtbHg1
X3ZkcGFfZGV2ICptdmRldiwKPj4gc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwKPj4gIMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gZXJyOwo+PiAgwqB9Cj4+ICAgCj4+ICtpbnQgbWx4NV92ZHBhX3Jl
c2V0X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdW5zaWduZWQgaW50IGFzaWQpCj4+
ICt7Cj4+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBtbHg1X3ZkcGFfbXIgKm1yID0gJm12ZGV2LT5t
cjsKPj4gK8KgwqDCoMKgwqDCoMKgaW50IGVyciA9IDA7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKg
aWYgKGFzaWQgIT0gMCkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAw
Owo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoG11dGV4X2xvY2soJm1yLT5ta2V5X210eCk7Cj4+ICvC
oMKgwqDCoMKgwqDCoGlmICghbXItPnVzZXJfbXIpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBnb3RvIG91dDsKPj4gK8KgwqDCoMKgwqDCoMKgX21seDVfdmRwYV9kZXN0cm95X2R2
cV9tcihtdmRldik7Cj4+ICvCoMKgwqDCoMKgwqDCoGlmIChNTFg1X0NBUF9HRU4obXZkZXYtPm1k
ZXYsIHVtZW1fdWlkXzApKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlcnIg
PSBfbWx4NV92ZHBhX2NyZWF0ZV9kdnFfbXIobXZkZXYsIE5VTEwsIDApOwo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGVycikKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtbHg1X3ZkcGFfd2FybihtdmRldiwgImNyZWF0ZSBETUEg
TVIgZmFpbGVkXG4iKTsKPj4gK8KgwqDCoMKgwqDCoMKgfQo+PiArb3V0Ogo+PiArwqDCoMKgwqDC
oMKgwqBtdXRleF91bmxvY2soJm1yLT5ta2V5X210eCk7Cj4+ICvCoMKgwqDCoMKgwqDCoHJldHVy
biBlcnI7Cj4+ICt9Cj4+ICsKPj4gIMKgaW50IG1seDVfdmRwYV9oYW5kbGVfc2V0X21hcChzdHJ1
Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCB2aG9zdF9pb3RsYgo+PiAqaW90bGIsCj4+
ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBib29sICpjaGFuZ2VfbWFwLCB1bnNpZ25lZCBpbnQgYXNpZCkKPj4gIMKgewo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+IGIvZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jCj4+IGluZGV4IDYxYzEwYmEuLjM5OWE2OTAgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+PiArKysgYi9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4gQEAgLTI4MTYsNyArMjgxNiw2IEBAIHN0YXRp
YyBpbnQgbWx4NV92ZHBhX3Jlc2V0KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPj4gIMKgwqDC
oMKgwqDCoMKgwqB1bnJlZ2lzdGVyX2xpbmtfbm90aWZpZXIobmRldik7Cj4+ICDCoMKgwqDCoMKg
wqDCoMKgdGVhcmRvd25fZHJpdmVyKG5kZXYpOwo+PiAgwqDCoMKgwqDCoMKgwqDCoGNsZWFyX3Zx
c19yZWFkeShuZGV2KTsKPj4gLcKgwqDCoMKgwqDCoMKgbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoJm5k
ZXYtPm12ZGV2KTsKPj4gIMKgwqDCoMKgwqDCoMKgwqBuZGV2LT5tdmRldi5zdGF0dXMgPSAwOwo+
PiAgwqDCoMKgwqDCoMKgwqDCoG5kZXYtPm12ZGV2LnN1c3BlbmRlZCA9IGZhbHNlOwo+PiAgwqDC
oMKgwqDCoMKgwqDCoG5kZXYtPmN1cl9udW1fdnFzID0gMDsKPj4gQEAgLTI4MjcsMTAgKzI4MjYs
NiBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9yZXNldChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYp
Cj4+ICDCoMKgwqDCoMKgwqDCoMKgaW5pdF9ncm91cF90b19hc2lkX21hcChtdmRldik7Cj4+ICDC
oMKgwqDCoMKgwqDCoMKgKyttdmRldi0+Z2VuZXJhdGlvbjsKPj4gICAKPj4gLcKgwqDCoMKgwqDC
oMKgaWYgKE1MWDVfQ0FQX0dFTihtdmRldi0+bWRldiwgdW1lbV91aWRfMCkpIHsKPj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChtbHg1X3ZkcGFfY3JlYXRlX21yKG12ZGV2LCBO
VUxMLCAwKSkKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBtbHg1X3ZkcGFfd2FybihtdmRldiwgImNyZWF0ZSBNUiBmYWlsZWRcbiIpOwo+PiAtwqDCoMKg
wqDCoMKgwqB9Cj4+ICDCoMKgwqDCoMKgwqDCoMKgdXBfd3JpdGUoJm5kZXYtPnJlc2xvY2spOwo+
PiAgIAo+PiAgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+PiBAQCAtMjg5NSw2ICsyODkwLDE4
IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX3NldF9tYXAoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2
LAo+PiB1bnNpZ25lZCBpbnQgYXNpZCwKPj4gIMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gZXJyOwo+
PiAgwqB9Cj4+ICAgCj4+ICtzdGF0aWMgaW50IG1seDVfdmRwYV9yZXNldF9tYXAoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCkKPj4gK3sKPj4gK8KgwqDCoMKgwqDC
oMKgc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7Cj4+ICvCoMKg
wqDCoMKgwqDCoHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYo
bXZkZXYpOwo+PiArwqDCoMKgwqDCoMKgwqBpbnQgZXJyOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDC
oGRvd25fd3JpdGUoJm5kZXYtPnJlc2xvY2spOwo+PiArwqDCoMKgwqDCoMKgwqBlcnIgPSBtbHg1
X3ZkcGFfcmVzZXRfbXIobXZkZXYsIGFzaWQpOwo+PiArwqDCoMKgwqDCoMKgwqB1cF93cml0ZSgm
bmRldi0+cmVzbG9jayk7Cj4+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBlcnI7Cj4+ICt9Cj4+ICsK
Pj4gIMKgc3RhdGljIHN0cnVjdCBkZXZpY2UgKm1seDVfZ2V0X3ZxX2RtYV9kZXYoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4KQo+PiAgwqB7Cj4+ICDCoMKgwqDCoMKgwqDCoMKgc3Ry
dWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7Cj4+IEBAIC0zMTU0LDYg
KzMxNjEsNyBAQCBzdGF0aWMgaW50IG1seDVfc2V0X2dyb3VwX2FzaWQoc3RydWN0IHZkcGFfZGV2
aWNlICp2ZGV2LAo+PiB1MzIgZ3JvdXAsCj4+ICDCoMKgwqDCoMKgwqDCoMKgLnNldF9jb25maWcg
PSBtbHg1X3ZkcGFfc2V0X2NvbmZpZywKPj4gIMKgwqDCoMKgwqDCoMKgwqAuZ2V0X2dlbmVyYXRp
b24gPSBtbHg1X3ZkcGFfZ2V0X2dlbmVyYXRpb24sCj4+ICDCoMKgwqDCoMKgwqDCoMKgLnNldF9t
YXAgPSBtbHg1X3ZkcGFfc2V0X21hcCwKPj4gK8KgwqDCoMKgwqDCoMKgLnJlc2V0X21hcCA9IG1s
eDVfdmRwYV9yZXNldF9tYXAsCj4+ICDCoMKgwqDCoMKgwqDCoMKgLnNldF9ncm91cF9hc2lkID0g
bWx4NV9zZXRfZ3JvdXBfYXNpZCwKPj4gIMKgwqDCoMKgwqDCoMKgwqAuZ2V0X3ZxX2RtYV9kZXYg
PSBtbHg1X2dldF92cV9kbWFfZGV2LAo+PiAgwqDCoMKgwqDCoMKgwqDCoC5mcmVlID0gbWx4NV92
ZHBhX2ZyZWUsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
