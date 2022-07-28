Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87AEC04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 08:20:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6040160F2C;
	Thu, 28 Jul 2022 08:20:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6040160F2C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=cVru/+7U;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=RYS9SAUw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id emFtXVHDjBsk; Thu, 28 Jul 2022 08:20:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BC50560B50;
	Thu, 28 Jul 2022 08:20:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BC50560B50
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 758B5C0035;
	Thu, 28 Jul 2022 08:20:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9805C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 08:20:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C142560B50
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 08:20:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C142560B50
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zbu1FCBW7CtI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 08:20:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B03A60B38
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1B03A60B38
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 08:20:40 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26S8ItdS004207;
 Thu, 28 Jul 2022 08:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ck56QVdwZE2BEarl6UdYrz71/3MchFCyqpLEL3Gu6M0=;
 b=cVru/+7UkoRybnw6Kkms2j83FfziInGXar5aZVz6ZjSPuUSKLnvrgbkgNQdA+kcLMjyF
 QVi19oDPPXedbH2YAgtObDqYZqEcCcXfJAfHZbHOXjGHj3fFL6BJvFom7CvDM12/nmsP
 0dTpgz/Ris/ULcmQ/u4sFxJznnCmxsJr7HmbmXpOlQCymIV4mCM3FGieaoIuSLI+ngak
 Y+55oTlgkkdUbWxdlpjD13mC288KcyUL23Sr6K6HcgOi1DeB9f/d4LEtEoUYmwcae4+d
 P+p74LMqdDor2I/tpq0BNzBfnRNfALBZ2pRigrp94vQZcjbV6l2rmVetdpHgPAQJeXl5 Hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hsv9x5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jul 2022 08:20:35 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26S8KIbj020567; Thu, 28 Jul 2022 08:20:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh63a8rdu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jul 2022 08:20:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1xLTOqAJ95/CjYmq5IkKKjIvGr0hWzM2KMtroKAyaT5rS2lZBxcs3JUfwC9jbhFaHsrTRkiaGlUYuMaexSAOlk+9QaefvupdMgh6YZ6u2pSvFDRXv0KRaEYNV8sD7Pq40JPwOPH2/V85zKnQsxvWIN4iScow/StIIcbHSdWiipBMBSa1oIxRbFTKY7IJ6HU+TD4LC43y4rNTrv6eyb+6/BbqhX8Y0db0SBtsFAoGuVi4wd8ReB7kKDSvvE5/hmcruQqaNDV6AAGxyOuO8Mgjs4QW256hFi5Y/Ywe73PKncbaZSgAcNW0tGOnz6Hz0F/0YqS0l78TSurPF7D3/gfCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ck56QVdwZE2BEarl6UdYrz71/3MchFCyqpLEL3Gu6M0=;
 b=EH1M3shlpvm25P1sD2GJQyY6iup+84wM9vCUgx6eR1LppWpk/VwZ+zBIC7rZuIcdQ+QTODa/l+/h8Pli1FlaAX7LOb+CTrBWdv3zLW5wFM3o8ewtNGr2ze2Pnk87M2UeUYjudWmOPplQerf78cq9QTdW4TZ5PFL7jQibEiLcpGXgszH3lLb9cZrVdCuf5iM+y80HcuK3zzMweqDA9noVAeAC/znfuQpKx7pHG/Xu5FQxeISK9b7fLeRCstAuC7gWLr68Vp45X8FCXsNQEtjObhhaaKoPe5zIqJNscLaxIOgi9Sad3Ll+c9nSkjv46gFXNazr26LP5SQN/RJGa8UMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ck56QVdwZE2BEarl6UdYrz71/3MchFCyqpLEL3Gu6M0=;
 b=RYS9SAUw9vG2arr/wcsMeb8/eIbU+OFX+DWfOPUbNDtxPd74DkNDYZXXbl443QmYpBfpzMji7jbzmvBxwJ6vOI6/i30Js9z5JA2oV82bBNue5t/c2F6qM9GQxVcQHtWnv1cOPrSExdR1SX4BZIVJcz22RvbJg1IXpTAMQuKD17I=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 08:20:31 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803%4]) with mapi id 15.20.5458.026; Thu, 28 Jul 2022
 08:20:31 +0000
Message-ID: <2dfff5f3-3100-4a63-6da3-3e3d21ffb364@oracle.com>
Date: Thu, 28 Jul 2022 01:20:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: spec clarification (was Re: [PATCH V3 4/6] vDPA: !FEATURES_OK should
 not block querying device config space)
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-5-lingshan.zhu@intel.com>
 <PH0PR12MB548190DE76CC64E56DA2DF13DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <00889067-50ac-d2cd-675f-748f171e5c83@oracle.com>
 <63242254-ba84-6810-dad8-34f900b97f2f@intel.com>
 <8002554a-a77c-7b25-8f99-8d68248a741d@oracle.com>
 <c8bd5396-84f2-e782-79d7-f493aca95781@redhat.com>
 <f3fd203d-a3ad-4c36-ddbc-01f061f4f99e@oracle.com>
 <CACGkMEtvVOtqAgY4Yzt_4=t8yfGJho4d9C=X8MQhW0ZKw1sDNA@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEtvVOtqAgY4Yzt_4=t8yfGJho4d9C=X8MQhW0ZKw1sDNA@mail.gmail.com>
X-ClientProxiedBy: SA1PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::10) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6393ce6a-afc3-40df-7f3f-08da70720964
X-MS-TrafficTypeDiagnostic: BLAPR10MB5156:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QYJ6e0Ef4VroRgC348pLm/Ss5lFfI7/+IYUUYzyITJplP/R+pP2n95/akYCWO0t9XvqFs4NlfPoV0dSRUZKV5Ib3VfRvi3hbgTRTgH9yjvpeGP15x0rtGhw70Waw+gEXuzZ/k1Cl9fOjpUfv3V1rZG0sbGAMw+H3BetK+/zvgfpdvI1iR5pWbp5VTBPW4bs8HShCCEGVIujxcOkM13UAu62x618QotNEWlEaHmmd5MUNVXDSisxtk4OhgiLHaeqgzfoSnCmZ8FOwq7lTLMOt6A25nEnzkrCOekoUpiWQmAZCawgAMKWpmjfJ4Mx/D8E8MrWklczP98zGMNSW5Hw/iiER6/78wbuaaqU7a+jI2J+VDjNxyj650UxG4ilTd+5imQBe0yHWvzoEcFtPO7jJMfiRGYR6yn1Np6xTrAb3+Q/tYce/VbWOGJH76QOOiyHfCLeN/rdyx4PJmrJeFMxEu6UJtwutywuqcKDupwvTsMFbl5j3BxMvb/05cvvIrwY4rJwW6NsXZ7YjKdvzv1us303K8pOCnWBwCgvMDQw6yB0NQyaY9lAYv9S/URT/483lWL7GslBRAQ0sQEOzglsL93Tik+eW18r4PPcDx1WfjmFH0gd5p2FluQy+HP7c2JubZ7lXlsssHalUevMPyA7oRVqYzwqgFz0Gn3axPMlhHU8jeF+OAx/18w5knTWF5WApooMbu3ixqmqVLAe/zICrQQMqYxQsajNwgzEsKMJL4DpyTf8WZ8oajc9kj0n0iuaqkJZ1/mwlWTRk79QlTpR7Oo67dat5RGjXrh908D0tCSDAYPxu/Ds9aBc0e20emQkefL5NqYR7lcxqmCyd3/FQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(396003)(136003)(346002)(376002)(39860400002)(366004)(41300700001)(2616005)(2906002)(86362001)(6666004)(186003)(33964004)(31696002)(26005)(6512007)(36916002)(38100700002)(6506007)(53546011)(83380400001)(66476007)(31686004)(478600001)(4326008)(8676002)(66946007)(8936002)(6486002)(54906003)(316002)(110136005)(66556008)(7416002)(5660300002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3NCVmgvU3l5RFAyNm9iVWVHZnFSWnlNenRESWt5RUNkcUJneTlmK3B6RDJk?=
 =?utf-8?B?clhtUTl5aVJ4WTZILzgzWDBOcmFzRjNuUDZyT2VkNFNTTFQzQVBMUUxXd09x?=
 =?utf-8?B?MWcvSGhoTTVBSEZXdkZEK1ZJVW9yZmd3K0tSU05YOVZEYlRyMmlSOFV3OGt0?=
 =?utf-8?B?VlhsR0hHdGI5dXluQXFjM0x2VzNRc2VpRE9SWklTMTA4WVBGVXZ1R3JIMmk2?=
 =?utf-8?B?K1VpcG5hWEx5a09mQTVQVit2MXhVNkwxTGlrTEZqM0lYdkJTL1gzRmdlVUl6?=
 =?utf-8?B?ejhPMmNXYVRIT21yeDVLMWF2Smo2NkxxQ3VkTXAyd0VtU2pxNWFacEoyWTEx?=
 =?utf-8?B?MnY1OWVsU0FwTjFIbGt3Zll5bkU2QVZmUmJhMUhYSjB0S3hqaE1EYUx1SmRW?=
 =?utf-8?B?Um40VnczNEgwRGJUVVVKc1dQTWdnYXJFN2YxQWZyNGZjdnNXL0l5VXc5QWd6?=
 =?utf-8?B?VU9WTit0enFmVmRIczdhL1QrOUNTOGpWTEQzb3RWMnFIT3h2UWFrcHFBYThN?=
 =?utf-8?B?N0t6MldLOXhrMFVsZ20wYXgrZjl3MENaakpSeHRtTVpMVjR0Z3FxaTNUeTll?=
 =?utf-8?B?KzZWVGdVY1BLSnJwMzNkcHpWcTJxYm5wU2I4ZmZkaTdUTE82M2Z3YkhUejlP?=
 =?utf-8?B?ZUNWdTZHRVRUb1ZOOXpETlFMWWFSUTlzMWpYNUVIZmU2TlN2RGVreTdaTEtN?=
 =?utf-8?B?eiswTGYxak5sTDJDNEJxUHNCb2JUWmtYMVNKRzVXeDZGQ0JGTGdmdXNXQ0Jn?=
 =?utf-8?B?dmR3elRWVjhYd0hDb0NDSmpMdVRwc1I5Rnd0VGhyRkhRb3R4MTRzQThBdXZp?=
 =?utf-8?B?VnAweWV0R1ptQzR2UVFiWWVOb2lqZDYxRm5McmtLTnIrTE5kZk4ybmpHbmFE?=
 =?utf-8?B?eGl0ZTBjYzNMK243MFVFWVlMUzdnVmJGS1R2bVN2QUFxV1VhOGg1NHZkcVBy?=
 =?utf-8?B?OC81SmdTd1VOblBWNjlUOVNFU1BXaFppOUhuQnRWbVRNV2JOYVUyOEVDNk1M?=
 =?utf-8?B?dlpjdHVjNVYxYmRVTXprQjVKTjB1Rmk0cHFFblNmeE9NY1c1SERKTnJqeC92?=
 =?utf-8?B?M25zRnNOYTdxVUIyR1lVNDRWVWhJVDRhai9BUndUUkxpWWhCMXN2NExHMURI?=
 =?utf-8?B?RTI0YkgwdCtjU29rTU9zaDR1MGZ6c3YyS01McFBSeEd6LzhpUTY3bnl0eElp?=
 =?utf-8?B?TkZrZEQweVVzWTdZa0x1eXl6dXM1d044bGRvLy9idlpnMDIzR2JXcEgrNFo2?=
 =?utf-8?B?bnIrMzVSMmdKTlhiZ3ZzdWdRcVdMZngrOFVJaERKODBNOVBTbmZhT0xORmhK?=
 =?utf-8?B?UU9mK0tCWmNtdHlTRFFWNUkxa2E4eUppcytvVU82RzRsb1U0aWF0M3UrQjB6?=
 =?utf-8?B?UWRYRGk2RGNPQllKei9ibGpjODN3L1lFTng4bGY3Z09QbXVkaGVpOWpGTnBQ?=
 =?utf-8?B?Z0NZbk5JZlI4REZJdGpjN0IwSjEyZm8zRzYxK0ttcFNUWENvVm1vRjZiVFNH?=
 =?utf-8?B?MG9QQUhTNTZkUTRlOC9MYmlmWWdpOHhLMUhhcjNLdWhUYTRiVHd3bHl6dFBT?=
 =?utf-8?B?ZFBud0o5QjYwQldYWC91K2l0SkFLTEFoL0FuaVh2THFYaUdQL1l2YmdramY0?=
 =?utf-8?B?ZWVJT2ZyNmVhTllIT2lkakhvWWhJS0NTTFQ1QlhtT0c3akRkL05EcTh0emln?=
 =?utf-8?B?YTQ5ZGI2REZTeW1mWjcwZ3BUZGpQK0owOGpMSURnS29Bc1dpbmNNQWFtaFY5?=
 =?utf-8?B?aUtLMWR2ZFFXcHBqaE9aemk0Y1g4OFdiaVgreEpVaXdvc3dpM09XRFFkSnM5?=
 =?utf-8?B?WDVDQlR1eTJtMDZzNkRRWTVLUDlaSlI0QlNDWHNOYjJId0x6REIxQ2xkNFNz?=
 =?utf-8?B?dmlvN0JGY3pLNFhFKzBCM0VZL0xWRVFlbFQyd2l2YUVJVXFlQkFSaEx2RC9N?=
 =?utf-8?B?RklKL1gyOXFpVWFtS002dXk5TEE5VTZPOUx0YmxoQjNJN1dEQytRbllDZVNq?=
 =?utf-8?B?TzdONjJBUnJCQmdRU0RqMVBvY3dpSlRvd1ZyMDIzWko5NWxDYS9ZaU9aVFFo?=
 =?utf-8?B?cFJpRVJ3YUE0dVBVM1pWYlBwTUllTWN3bW1SWFZpakY4RkNqSGlyeWRrTHVo?=
 =?utf-8?B?Rlp6SjV1SUM2N2VCOUt1U1hyQy9JOGVNVXdKNWY3UWRjWTh6NEhiN1UxejA1?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6393ce6a-afc3-40df-7f3f-08da70720964
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 08:20:31.3916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMIAfH2UDdhv8GA92wsLVcomi8GC9I5G5K8LZoNovVwzl2jae8lsifJMpk8o3HuzqYD/GC1SHMhiaMurbxb8YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_01,2022-07-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280034
X-Proofpoint-ORIG-GUID: U5lCgzduF0BqCxugABnHGn8WiQOauJ3d
X-Proofpoint-GUID: U5lCgzduF0BqCxugABnHGn8WiQOauJ3d
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 virtio-comment@lists.oasis-open.org,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, virtio@lists.oasis-open.org,
 Eli Cohen <elic@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============7722777312296396865=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============7722777312296396865==
Content-Type: multipart/alternative;
 boundary="------------WDzLQcrmCNlMb0eWacTVI30R"
Content-Language: en-US

--------------WDzLQcrmCNlMb0eWacTVI30R
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

Could you please comment on the different wording between "exist" and 
"valid" in spec? Having seen quite a few relevant discussions regarding 
MTU validation and VERSION_1 negotiation on s390, I was in the 
impression this is not the first time people getting confused because of 
ambiguity of random wording without detailed example helping to clarify 
around the context, or due lack of clear definition set ahead. I like 
your idea to keep things consistent (conditional depending on feature 
presence), however, without proper interpretation of how spec is 
supposed to work, we are on a slippery slope towards inconsistency.

On 7/28/2022 12:36 AM, Jason Wang wrote:
>> And looking at:
>>
>> "The mac address field always exists (though is only valid if
>> VIRTIO_NET_F_MAC is set), and status only exists if VIRTIO_NET_F_STATUS
>> is set."
>>
>> It appears to me there's a border line set between "exist" and "valid".
>> If I understand the spec wording correctly, a spec-conforming device
>> implementation may or may not offer valid status value in the config
>> space when VIRTIO_NET_F_STATUS is offered, but before the feature is
>> negotiated.
> That's not what I read, maybe Michael can clarify this.
>

And Jason and I find below normatives are conflict with each other.
>> "The device MUST allow reading of any device-specific configuration 
>> field before FEATURES_OK is set by the driver. This includes fields 
>> which are conditional on feature bits, as long as those feature bits 
>> are offered by the device." 
> ...
>> And also there are special cases where the read of specific
>> configuration space field MUST be deferred to until FEATURES_OK is set:
>>
>> "If the VIRTIO_BLK_F_CONFIG_WCE feature is negotiated, the cache mode
>> can be read or set through the writeback field. 0 corresponds to a
>> writethrough cache, 1 to a writeback cache11. The cache mode after reset
>> can be either writeback or writethrough. The actual mode can be
>> determined by reading writeback after feature negotiation."
>> "The driver MUST NOT read writeback before setting the FEATURES_OK
>> device status bit."
> This seems to conflict with the normatives I quoted above, and I don't
> get why we need this.
>

Thanks,
-Siwei
--------------WDzLQcrmCNlMb0eWacTVI30R
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Michael,<br>
    <br>
    Could you please comment on the different wording between &quot;exist&quot;
    and &quot;valid&quot; in spec? Having seen quite a few relevant discussions
    regarding MTU validation and VERSION_1 negotiation on s390, I was in
    the impression this is not the first time people getting confused
    because of ambiguity of random wording without detailed example
    helping to clarify around the context, or due lack of clear
    definition set ahead. I like your idea to keep things consistent
    (conditional depending on feature presence), however, without proper
    interpretation of how spec is supposed to work, we are on a slippery
    slope towards inconsistency.<br>
    <br>
    <div class="moz-cite-prefix">On 7/28/2022 12:36 AM, Jason Wang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CACGkMEtvVOtqAgY4Yzt_4=t8yfGJho4d9C=X8MQhW0ZKw1sDNA@mail.gmail.com">
      <blockquote type="cite" style="color: #007cff;">
        <pre class="moz-quote-pre" wrap="">And looking at:

&quot;The mac address field always exists (though is only valid if
VIRTIO_NET_F_MAC is set), and status only exists if VIRTIO_NET_F_STATUS
is set.&quot;

It appears to me there's a border line set between &quot;exist&quot; and &quot;valid&quot;.
If I understand the spec wording correctly, a spec-conforming device
implementation may or may not offer valid status value in the config
space when VIRTIO_NET_F_STATUS is offered, but before the feature is
negotiated.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">That's not what I read, maybe Michael can clarify this.

</pre>
    </blockquote>
    <br>
    And Jason and I find below normatives are conflict with each other.<br>
    <blockquote type="cite">
      <pre class="moz-quote-pre" wrap=""><blockquote type="cite">
&quot;The device MUST allow reading of any device-specific configuration 
field before FEATURES_OK is set by the driver. This includes fields 
which are conditional on feature bits, as long as those feature bits are 
offered by the device.&quot;


</blockquote>...
</pre>
      <blockquote type="cite" style="color: #007cff;">
        <pre class="moz-quote-pre" wrap="">And also there are special cases where the read of specific
configuration space field MUST be deferred to until FEATURES_OK is set:

&quot;If the VIRTIO_BLK_F_CONFIG_WCE feature is negotiated, the cache mode
can be read or set through the writeback field. 0 corresponds to a
writethrough cache, 1 to a writeback cache11. The cache mode after reset
can be either writeback or writethrough. The actual mode can be
determined by reading writeback after feature negotiation.&quot;
&quot;The driver MUST NOT read writeback before setting the FEATURES_OK
device status bit.&quot;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">This seems to conflict with the normatives I quoted above, and I don't
get why we need this.

</pre>
    </blockquote>
    <br>
    Thanks,<br>
    -Siwei<br>
  </body>
</html>

--------------WDzLQcrmCNlMb0eWacTVI30R--

--===============7722777312296396865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7722777312296396865==--
