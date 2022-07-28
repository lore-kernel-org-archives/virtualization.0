Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DADC19F2B
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 01:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE17041758;
	Thu, 28 Jul 2022 01:41:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AE17041758
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=HLyrabpg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=saXz4WmZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SWLYJLSo7587; Thu, 28 Jul 2022 01:41:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5ACDE4174F;
	Thu, 28 Jul 2022 01:41:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5ACDE4174F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F35CC0035;
	Thu, 28 Jul 2022 01:41:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAE84C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 01:41:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E4DF60EE5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 01:41:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E4DF60EE5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=HLyrabpg; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=saXz4WmZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BiY26dXhNm8S
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 01:41:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB45260E9E
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB45260E9E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 01:41:42 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RNONrn017513;
 Thu, 28 Jul 2022 01:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AgRg191Yf/dNiLpN8psiCRKzs6ZIszTHNBI45fIBodg=;
 b=HLyrabpgzlP4OmsMT7sxR9EcNpLDHvctRnfMnx+N9Nay5OKFKrNbs1PVW0iKfGsYL21o
 jnRobBn7J4tNQj6VtrlsOn4gjMiR+gVg7LlpTwyx41pcVCZUp2n7hkS/SAt9a3CHFrTR
 i7e5w/Jog79BykVWRaCMhwfbNydAPG/Fg1fjFRu5HrXO0wffkKT/MQ7JwFEhQ4yDVcK5
 K6R0We1ibPb4aK0XwMC3P6fIc6fnkPv1HDCzknJJ2AwmLuB7BnWA0E5mO1O7Ho6MyKNI
 iBdkN8mb5BZH1zrWp7VqKK3nP5GZ55mx3SyIx/5I7GLTeXGo7dbbJXZrcpgScxHYCAho GA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg94gk6f0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jul 2022 01:41:35 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26RNTrve006173; Thu, 28 Jul 2022 01:41:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh65dq4g0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jul 2022 01:41:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSAGZZCz647buIVOYCiyOBSgWIR81kaon5HGGML2IF898UR8+xm7aXDpDsTpfgkPOL5jnx/e5aBXiKuL0shpP6vTMNZbfp4ZZVTnHNy+u1xd5r2Izoar3stU4YdhPXKTp0sc3zXkYmIBptSCoe/hV8BqsRrJTVkJrgNrSTkTRHEZuf8Omjk4MCkLmpiCKIPmXjrKvXv934cGa4rRXhMhx9YDBMVaFjra1EzY7aF+swHNQc1XsYH1iYcOCp6cPiDCqiK42TtVtD+oiejEtEucC75eQloqhI1k4x/m6BKU0Qar3+Multvg60qPwhVjZLCoqbql4uPurRnodyjb95spTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgRg191Yf/dNiLpN8psiCRKzs6ZIszTHNBI45fIBodg=;
 b=ElzzTMcPKdyXvSqFYh/7THnsqikdgOYRt8oWeR2M3JQ97wKWSF42xDqZ+CJc+SUXRWaCgs6tn3nAarwz1pXDPJ5c5eUNsEj+XD0xYh+GXpo3HWvbOAKLKG7QyVF9v+akVmm5WzRbqk5i0++gA4K0Ox1EJYAHLxS/BdSV0OEh6X1eC35NT9pApW/mPTkvw82mScHypHxOlWqVjiuHSXGBQEjbo8e0gnk5ucZ3l8T+K8ed80+ynAPeVFBF0j7PSsWMEHMdxsi/+FoUMg4L+/71+RotQpQKxfAxUARPFj3GUTZRxHqzUzJK67CjSfd7VG9VvezAfQswRTgYmwgiCjVkGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgRg191Yf/dNiLpN8psiCRKzs6ZIszTHNBI45fIBodg=;
 b=saXz4WmZh2ZCPBlJiF3sUOeJFjyRUg1nFvppIIf2pxfYoWOnwr3bf2dbEclLNEAcrbV1jy8Prdpq17z8Fr/XUN2mYPcgCjHO/Rh2yFY4cZ7ME2W+SWbkSxqSla0Yk8exz5ZEyEFQ1OTR8En5K5UQ8Lm3YoxFjMSFYetkZnO2LxE=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SA1PR10MB5821.namprd10.prod.outlook.com (2603:10b6:806:232::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 01:41:33 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803%4]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 01:41:32 +0000
Message-ID: <e546e6c0-37bd-ee3e-76e5-def63a33f432@oracle.com>
Date: Wed, 27 Jul 2022 18:41:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Content-Language: en-US
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <c7c8f49c-484f-f5b3-39e6-0d17f396cca7@intel.com>
 <PH0PR12MB5481E65037E0B4F6F583193BDC899@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1246d2f1-2822-0edb-cd57-efc4015f05a2@intel.com>
 <PH0PR12MB54815985C202E81122459DFFDC949@PH0PR12MB5481.namprd12.prod.outlook.com>
 <19681358-fc81-be5b-c20b-7394a549f0be@intel.com>
 <PH0PR12MB54818158D4F7F9F556022857DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e98fc062-021b-848b-5cf4-15bd63a11c5c@intel.com>
 <PH0PR12MB54815AD7D0674FEB1D63EB61DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220727015626-mutt-send-email-mst@kernel.org>
 <66291287-fcb3-be8d-2c1b-dd44533ed8b3@oracle.com>
 <20220727050102-mutt-send-email-mst@kernel.org>
 <6d5b03ee-5362-8534-5881-a34c9ea626f0@oracle.com>
 <939bc589-b3ad-d317-8b1d-6da58e4670c0@intel.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <939bc589-b3ad-d317-8b1d-6da58e4670c0@intel.com>
X-ClientProxiedBy: SA9PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:806:22::10) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 932da5ac-c899-4bbf-097f-08da703a4cf0
X-MS-TrafficTypeDiagnostic: SA1PR10MB5821:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4nOh5J+V113lLpA5qg+UEmcr/eQYLkjhLbuJpLz6w6g04jBDNN1hi0J0mrJzOV/1TDD6LPizOgM+cH+nCmPYg50FeI8AMHXdJOJ2E7r1oOihCOibxSIsjZLUj7L88kgR06ZRBAdAEbmjd8fN72TMHKT/vE8Db4PrKR/8JY4fLfCv11CYJLHoyhKf38FchjqYGT9OBltWz1rRUMvIOJ5S4b/yETJr0OoRqeK4iw4ujtvneVQzCtzFzyOwOGNwJI5Iqk3Jk7uP+dzf3wRyQEGixqv1aFvuUXYFdq6mRWmOJtSRn4v9XOfpUHhKSTz+6CylQbnrO4gAXDyYP8M/Vg1XK0D5kI+kev/bKemTOoZIZQelVYpzO/6JolivdEqERIIy9cduRhwtrkQYTRXcNQlBoj8wQ9GGDAEog4c8+ZSI/7IuEfZ5b9wSIclrU9QLF33LJzxWVc05HCS8upPOzqjwg5O2ojqglt3N0nfyolW2KYv8/I7Dy7SLrf89QOvB5NJKqeQbbHNJnhMWxUKRn+VzGVKrtyRkkMwIlVnK37mp7udIvigvkW+DEFVcx8iaJCZu5q1TP7cxQeDGHkBziUH08LXKlc1rE0fNkDu7nUb48196rG7KLUhcWit7J21UQ6s31U3e1vCnmg7yPUvAUiRQiaUp0kIxNM5xum3mtBOwN3G7FnSpf50fKWqxQH8Vjhgi3h9SmUqaYOI5QsvkVX3aRM0puvyJWrx/wlqQtbd/yI1aXYd2duqxbP+rwzIW4YehNCUdnHynDfWlhqtKer9qKN4/PKdEvibKftYwgg/IfrlRlWQceg8HyXoyIq/0GNQQBWfOuyBXB23+oi3MEdqmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(396003)(346002)(136003)(39860400002)(376002)(54906003)(5660300002)(31686004)(8936002)(66946007)(8676002)(66476007)(66556008)(86362001)(31696002)(110136005)(316002)(6666004)(6512007)(26005)(36756003)(2906002)(2616005)(53546011)(478600001)(41300700001)(6486002)(83380400001)(38100700002)(4326008)(6506007)(36916002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUdsK1luYWs5SWtVVjNEZndZRFdBTnpEMzhuRFFVUW0xOW1KSFU3L0M0UVlM?=
 =?utf-8?B?T2h0UXNjbmtCRExzaDVueHpWLytsN3BJTTZ6MG5TWlNsS1JrVlRXOFVraGlG?=
 =?utf-8?B?K3BkWnRPSy92TWVwR1N4cjdKT0x5SkNKU20xdUMrbnNwUms4MlFHcUo0Q2p2?=
 =?utf-8?B?UnFMV290dk0zSVlOYXJVQ1dYTWsrY3JERUN5VlJFUlI4UGhQdklqYmF6K3Az?=
 =?utf-8?B?MnJxS3ZHRHVXWW0rZEpqcFc2TytpQ0FhTVU5WHBLcW9iMFZiNW5hMU9IT1pL?=
 =?utf-8?B?TVhrYUtSR0ZieWRLdk05WmpsRlU3c3duR0tTOCtTSW1oeVFpMTJwYUF1NVRx?=
 =?utf-8?B?d0gvdUc4cFB1OTdBTCtSRzNxbXRhMHdZQ05wQzVYVDUzRThCQWlucTRabTU2?=
 =?utf-8?B?cnQrRWk1NGd6WWgyQ05Cc3VJWmM4OUNhZ29tYkl5MjRHS3pmMzUxK2t6Wmtr?=
 =?utf-8?B?d0N3UHAxbXZSTjdqZXF5SHdTNFpMVUx6amYxUU92YnRaaFZxZHd2OER5MnJ0?=
 =?utf-8?B?cm5JZWNOa0pVNGYyaE81V3l5Z1plZm9jdHdkVnEvV2phaWNLMXdZS1JsczVG?=
 =?utf-8?B?eDlHODQ1eWI5Y0gzTDMxOFEvcnJKczdhcDQreVF0NHFyZWVSWGQ2dVo4Zkd6?=
 =?utf-8?B?K2FwQlgyZmhCZFFwSWdhQ0kwU0I5dlluS01kMkd4cU5OTm9EVmd3RWp1bkxB?=
 =?utf-8?B?Uk1mb2pGQUJiN3Vhd0pXRXNhR1lFdWwwclBEaFRNU3Q2aUtJc1RYZERPbEpR?=
 =?utf-8?B?WmdVb3RCdDNsWFJpUjYrdHhhNlJrbkxzcTJmSUNKQVBaTVI4ZkpiUk8yQmo2?=
 =?utf-8?B?RGs2eHV5THhyakJabUFpNHpHQVU1RG12bk9ZMkxGOEJ4ZTVtOEJJTldzOFc4?=
 =?utf-8?B?blNWbWhGQWpPdHJMRTN4MnZYRU5NRE0vUVZhQkhsMW5QbDJKNEFPRGJVUnVs?=
 =?utf-8?B?L3lLVGQzT1BTakhZTTAzWDBFVTh3TDFpNmMzOURWVkxDekhZRzQrWjF5Z1Jp?=
 =?utf-8?B?bHB3OTRmakYrcW80N3QzTVhkMHdnRXJLSjFwLzBsTko2SENaY3E1c2lwT0ZW?=
 =?utf-8?B?S29Tb09vZXNDcm10amFFK3FEZERiNGxzYmZML2Y0ZGFnWENWUEQwTUJJeStU?=
 =?utf-8?B?TUlEYS91RTBSZFdjS1VTM3lFK1R1YXVhbE5wRWdyTlpHTC9jVlhWZWxTUVFT?=
 =?utf-8?B?S0o4VklGWVlBSTh3aUpjWXUrczVDZzV2bmhhUFlSYVJGblZETWJwMDAvZk04?=
 =?utf-8?B?VU5rbVRaL3pDQ3dKbXNNdnNnZktseXFQaW9zT2FhdFErNy9iaHZIWGhhdmpj?=
 =?utf-8?B?aER4dlg4ZEU4Y3REQ1N1ZWthS0JHWjlzVUJlSzZWSEZMS2RJUS9WOUx4S3VV?=
 =?utf-8?B?b3YwR2o4TUlCZmZMb1l2UjA3M092UVM3ZWl3TWIzWHJCY2NUMGlYWGN3bVY3?=
 =?utf-8?B?RS83Q1U0TWFuNzlVQ3ljb1hxL1hHQnlTdzlxSythSXV6b2prNGRNSGpSTE5R?=
 =?utf-8?B?eWhlc0phMzk0ay9JYldveWM4emVtSGYyMjNqOXpzK0NMWExQeE8xTHFOVXV6?=
 =?utf-8?B?bUZnOFloWVFBalJsY2gwWnBDQkdjRXpvcUVmUGlzSFNWMW53dWNhQW9POW5z?=
 =?utf-8?B?U21jby9NTmJ6N2dHbjlPY011MGhnZ05FSFZmVUw2eXpjYVMxT2w1OEowcnIz?=
 =?utf-8?B?dHlFTUNaRnRKZEpOaFVQcW15UXdFT0hCWkQyajRFTFA3K295bURrR3NYUkNF?=
 =?utf-8?B?SW8rZ2hwQ241Z0tZNGlWV29xSUFNdXlOa3praGtZME5lOXAzZzlXWjdqLzFE?=
 =?utf-8?B?SSs0OXdWU0xDeE5FeUh4V2l1ZGpxK1hZRHM2MXFIL3ptVU5reFBEUEVmMVRW?=
 =?utf-8?B?RFVaMnFqTmkzWm1WekxUb2UySi9waVZ4RUJPd3FCMWZMQXpMdjFCUVJIRVd4?=
 =?utf-8?B?REtvNi9hWXdadTdXekpraDdRemJITW5sckhrdFNBb3Iwc3QwcUdIUmRnK3g3?=
 =?utf-8?B?Y3hoRThnZytBTjB1TG04UWJOMnV0N2dGUDYrOHowVVlITHFveTlmS29iWXpv?=
 =?utf-8?B?bGF4TGhUbXg5dHZXQkwxOTV5Y3Q1Zy93ZThqbzB1bzhkbnBlVExmMGwvZE5w?=
 =?utf-8?Q?yxrsYAHxrRqOYRMP5S7WbKeMs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932da5ac-c899-4bbf-097f-08da703a4cf0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 01:41:32.8966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCCTLI5RLYJpa34Fo8RnAfcYfTXg5zKtW5Yd0HNn3zq5Dh1OPzFtZPMW9XfLcXdLbAInWbLZSi7j+KaJqdrhRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_08,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207280004
X-Proofpoint-GUID: qu2sUZfrEV4pM-gsZkqCNis4WY5XExBF
X-Proofpoint-ORIG-GUID: qu2sUZfrEV4pM-gsZkqCNis4WY5XExBF
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

CgpPbiA3LzI3LzIwMjIgNDo1NCBBTSwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPgo+Cj4gT24gNy8y
Ny8yMDIyIDY6MDkgUE0sIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDcvMjcvMjAyMiAy
OjAxIEFNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+PiBPbiBXZWQsIEp1bCAyNywgMjAy
MiBhdCAxMjo1MDozM0FNIC0wNzAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+Pj4+Cj4+Pj4gT24gNy8y
Ni8yMDIyIDExOjAxIFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4+IE9uIFdlZCwg
SnVsIDI3LCAyMDIyIGF0IDAzOjQ3OjM1QU0gKzAwMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToKPj4+
Pj4+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+Pj4+Pj4+
IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjYsIDIwMjIgMTA6NTMgUE0KPj4+Pj4+Pgo+Pj4+Pj4+IE9u
IDcvMjcvMjAyMiAxMDoxNyBBTSwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+Pj4+Pj4+Pj4gRnJvbTog
Wmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPj4+Pj4+Pj4+IFNlbnQ6IFR1
ZXNkYXksIEp1bHkgMjYsIDIwMjIgMTA6MTUgUE0KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBPbiA3LzI2
LzIwMjIgMTE6NTYgUE0sIFBhcmF2IFBhbmRpdCB3cm90ZToKPj4+Pj4+Pj4+Pj4gRnJvbTogWmh1
LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPj4+Pj4+Pj4+Pj4gU2VudDogVHVl
c2RheSwgSnVseSAxMiwgMjAyMiAxMTo0NiBQTQo+Pj4+Pj4+Pj4+Pj4gV2hlbiB0aGUgdXNlciBz
cGFjZSB3aGljaCBpbnZva2VzIG5ldGxpbmsgY29tbWFuZHMsIGRldGVjdHMgCj4+Pj4+Pj4+Pj4+
PiB0aGF0Cj4+Pj4+Pj4+PiBfTVEKPj4+Pj4+Pj4+Pj4gaXMgbm90IHN1cHBvcnRlZCwgaGVuY2Ug
aXQgdGFrZXMgbWF4X3F1ZXVlX3BhaXIgPSAxIGJ5IGl0c2VsZi4KPj4+Pj4+Pj4+Pj4gSSB0aGlu
ayB0aGUga2VybmVsIG1vZHVsZSBoYXZlIGFsbCBuZWNlc3NhcnkgaW5mb3JtYXRpb24gYW5kIAo+
Pj4+Pj4+Pj4+PiBpdCBpcwo+Pj4+Pj4+Pj4+PiB0aGUgb25seSBvbmUgd2hpY2ggaGF2ZSBwcmVj
aXNlIGluZm9ybWF0aW9uIG9mIGEgZGV2aWNlLCBzbyBpdAo+Pj4+Pj4+Pj4+PiBzaG91bGQgYW5z
d2VyIHByZWNpc2VseSB0aGFuIGxldCB0aGUgdXNlciBzcGFjZSBndWVzcy4gVGhlIAo+Pj4+Pj4+
Pj4+PiBrZXJuZWwKPj4+Pj4+Pj4+Pj4gbW9kdWxlIHNob3VsZCBiZSByZWxpYWJsZSB0aGFuIHN0
YXkgc2lsZW50LCBsZWF2ZSB0aGUgCj4+Pj4+Pj4+Pj4+IHF1ZXN0aW9uIHRvCj4+Pj4+Pj4+Pj4+
IHRoZSB1c2VyIHNwYWNlCj4+Pj4+Pj4+PiB0b29sLgo+Pj4+Pj4+Pj4+IEtlcm5lbCBpcyByZWxp
YWJsZS4gSXQgZG9lc27igJl0IGV4cG9zZSBhIGNvbmZpZyBzcGFjZSBmaWVsZCBpZiAKPj4+Pj4+
Pj4+PiB0aGUKPj4+Pj4+Pj4+PiBmaWVsZCBkb2VzbuKAmXQKPj4+Pj4+Pj4+IGV4aXN0IHJlZ2Fy
ZGxlc3Mgb2YgZmllbGQgc2hvdWxkIGhhdmUgZGVmYXVsdCBvciBubyBkZWZhdWx0Lgo+Pj4+Pj4+
Pj4gc28gd2hlbiB5b3Uga25vdyBpdCBpcyBvbmUgcXVldWUgcGFpciwgeW91IHNob3VsZCBhbnN3
ZXIgb25lLCAKPj4+Pj4+Pj4+IG5vdCB0cnkKPj4+Pj4+Pj4+IHRvIGd1ZXNzLgo+Pj4+Pj4+Pj4+
IFVzZXIgc3BhY2Ugc2hvdWxkIG5vdCBndWVzcyBlaXRoZXIuIFVzZXIgc3BhY2UgZ2V0cyB0byBz
ZWUgaWYgCj4+Pj4+Pj4+Pj4gX01RCj4+Pj4+Pj4+PiBwcmVzZW50L25vdCBwcmVzZW50LiBJZiBf
TVEgcHJlc2VudCB0aGFuIGdldCByZWxpYWJsZSBkYXRhIAo+Pj4+Pj4+Pj4gZnJvbSBrZXJuZWwu
Cj4+Pj4+Pj4+Pj4gSWYgX01RIG5vdCBwcmVzZW50LCBpdCBtZWFucyB0aGlzIGRldmljZSBoYXMg
b25lIFZRIHBhaXIuCj4+Pj4+Pj4+PiBpdCBpcyBzdGlsbCBhIGd1ZXNzLCByaWdodD8gQW5kIGFs
bCB1c2VyIHNwYWNlIHRvb2xzIAo+Pj4+Pj4+Pj4gaW1wbGVtZW50ZWQgdGhpcwo+Pj4+Pj4+Pj4g
ZmVhdHVyZSBuZWVkIHRvIGd1ZXNzCj4+Pj4+Pj4+IE5vLiBpdCBpcyBub3QgYSBndWVzcy4KPj4+
Pj4+Pj4gSXQgaXMgZXhwbGljaXRseSBjaGVja2luZyB0aGUgX01RIGZlYXR1cmUgYW5kIGRlcml2
aW5nIHRoZSB2YWx1ZS4KPj4+Pj4+Pj4gVGhlIGNvZGUgeW91IHByb3Bvc2VkIHdpbGwgYmUgcHJl
c2VudCBpbiB0aGUgdXNlciBzcGFjZS4KPj4+Pj4+Pj4gSXQgd2lsbCBiZSB1bmlmb3JtIGZvciBf
TVEgYW5kIDEwIG90aGVyIGZlYXR1cmVzIHRoYXQgYXJlIAo+Pj4+Pj4+PiBwcmVzZW50IG5vdyBh
bmQKPj4+Pj4+PiBpbiB0aGUgZnV0dXJlLgo+Pj4+Pj4+IE1RIGFuZCBvdGhlciBmZWF0dXJlcyBs
aWtlIFJTUyBhcmUgZGlmZmVyZW50LiBJZiB0aGVyZSBpcyBubyAKPj4+Pj4+PiBfUlNTX1hYLCB0
aGVyZQo+Pj4+Pj4+IGFyZSBubyBhdHRyaWJ1dGVzIGxpa2UgbWF4X3Jzc19rZXlfc2l6ZSwgYW5k
IHRoZXJlIGlzIG5vdCBhIAo+Pj4+Pj4+IGRlZmF1bHQgdmFsdWUuCj4+Pj4+Pj4gQnV0IGZvciBN
USwgd2Uga25vdyBpdCBoYXMgdG8gYmUgMSB3aWh0b3V0IF9NUS4KPj4+Pj4+ICJ3ZSIgPSB1c2Vy
IHNwYWNlLgo+Pj4+Pj4gVG8ga2VlcCB0aGUgY29uc2lzdGVuY3kgYW1vbmcgYWxsIHRoZSBjb25m
aWcgc3BhY2UgZmllbGRzLgo+Pj4+PiBBY3R1YWxseSBJIGxvb2tlZCBhbmQgdGhlIGNvZGUgc29t
ZSBtb3JlIGFuZCBJJ20gcHV6emxlZDoKPj4+Pj4KPj4+Pj4KPj4+Pj4gwqDCoMKgwqBzdHJ1Y3Qg
dmlydGlvX25ldF9jb25maWcgY29uZmlnID0ge307Cj4+Pj4+IMKgwqDCoMKgdTY0IGZlYXR1cmVz
Owo+Pj4+PiDCoMKgwqDCoHUxNiB2YWxfdTE2Owo+Pj4+Pgo+Pj4+PiDCoMKgwqDCoHZkcGFfZ2V0
X2NvbmZpZ191bmxvY2tlZCh2ZGV2LCAwLCAmY29uZmlnLCBzaXplb2YoY29uZmlnKSk7Cj4+Pj4+
Cj4+Pj4+IMKgwqDCoMKgaWYgKG5sYV9wdXQobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFD
QUREUiwgCj4+Pj4+IHNpemVvZihjb25maWcubWFjKSwKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjb25maWcubWFjKSkKPj4+Pj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTVNHU0laRTsK
Pj4+Pj4KPj4+Pj4KPj4+Pj4gTWFjIHJldHVybmVkIGV2ZW4gd2l0aG91dCBWSVJUSU9fTkVUX0Zf
TUFDCj4+Pj4+Cj4+Pj4+Cj4+Pj4+IMKgwqDCoMKgdmFsX3UxNiA9IGxlMTZfdG9fY3B1KGNvbmZp
Zy5zdGF0dXMpOwo+Pj4+PiDCoMKgwqDCoGlmIChubGFfcHV0X3UxNihtc2csIFZEUEFfQVRUUl9E
RVZfTkVUX1NUQVRVUywgdmFsX3UxNikpCj4+Pj4+IMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU1T
R1NJWkU7Cj4+Pj4+Cj4+Pj4+Cj4+Pj4+IHN0YXR1cyByZXR1cm5lZCBldmVuIHdpdGhvdXQgVklS
VElPX05FVF9GX1NUQVRVUwo+Pj4+Pgo+Pj4+PiDCoMKgwqDCoHZhbF91MTYgPSBsZTE2X3RvX2Nw
dShjb25maWcubXR1KTsKPj4+Pj4gwqDCoMKgwqBpZiAobmxhX3B1dF91MTYobXNnLCBWRFBBX0FU
VFJfREVWX05FVF9DRkdfTVRVLCB2YWxfdTE2KSkKPj4+Pj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IC1FTVNHU0laRTsKPj4+Pj4KPj4+Pj4KPj4+Pj4gTVRVIHJldHVybmVkIGV2ZW4gd2l0aG91dCBW
SVJUSU9fTkVUX0ZfTVRVCj4+Pj4+Cj4+Pj4+Cj4+Pj4+IFdoYXQncyBnb2luZyBvbiBoZXJlPwo+
Pj4+Pgo+Pj4+Pgo+Pj4+IEkgZ3Vlc3MgdGhpcyBpcyBzcGVjIHRoaW5nIChoaXN0b3JpY2FsIGRl
YnQpLCBJIHZhZ3VlbHkgcmVjYWxsIAo+Pj4+IHRoZXNlIGZpZWxkcwo+Pj4+IGFyZSBhbHdheXMg
cHJlc2VudCBpbiBjb25maWcgc3BhY2UgcmVnYXJkbGVzcyB0aGUgZXhpc3RlbmNlIG9mIAo+Pj4+
IGNvcnJlc3BvbmRpbmcKPj4+PiBmZWF0dXJlIGJpdC4KPj4+Pgo+Pj4+IC1TaXdlaQo+Pj4gTm9w
ZToKPj4+Cj4+PiAyLjUuMcKgIERyaXZlciBSZXF1aXJlbWVudHM6IERldmljZSBDb25maWd1cmF0
aW9uIFNwYWNlCj4+Pgo+Pj4gLi4uCj4+Pgo+Pj4gRm9yIG9wdGlvbmFsIGNvbmZpZ3VyYXRpb24g
c3BhY2UgZmllbGRzLCB0aGUgZHJpdmVyIE1VU1QgY2hlY2sgdGhhdCAKPj4+IHRoZSBjb3JyZXNw
b25kaW5nIGZlYXR1cmUgaXMgb2ZmZXJlZAo+Pj4gYmVmb3JlIGFjY2Vzc2luZyB0aGF0IHBhcnQg
b2YgdGhlIGNvbmZpZ3VyYXRpb24gc3BhY2UuCj4+IFdlbGwsIHRoaXMgaXMgZHJpdmVyIHNpZGUg
b2YgcmVxdWlyZW1lbnQuIEFzIHRoaXMgaW50ZXJmYWNlIGlzIGZvciAKPj4gaG9zdCBhZG1pbiB0
b29sIHRvIHF1ZXJ5IG9yIGNvbmZpZ3VyZSB2ZHBhIGRldmljZSwgd2UgZG9uJ3QgaGF2ZSB0byAK
Pj4gd2FpdCB1bnRpbCBmZWF0dXJlIG5lZ290aWF0aW9uIGlzIGRvbmUgb24gZ3Vlc3QgZHJpdmVy
IHRvIGV4dHJhY3QgCj4+IHZkcGEgYXR0cmlidXRlcy9wYXJhbWV0ZXJzLCBzYXkgaWYgd2Ugd2Fu
dCB0byByZXBsaWNhdGUgYW5vdGhlciB2ZHBhIAo+PiBkZXZpY2Ugd2l0aCB0aGUgc2FtZSBjb25m
aWcgb24gbWlncmF0aW9uIGRlc3RpbmF0aW9uLiBJIHRoaW5rIHdoYXQgCj4+IG1heSBuZWVkIHRv
IGJlIGZpeCBpcyB0byBtb3ZlIG9mZiBmcm9tIHVzaW5nIAo+PiAudmRwYV9nZXRfY29uZmlnX3Vu
bG9ja2VkKCkgd2hpY2ggZGVwZW5kcyBvbiBmZWF0dXJlIG5lZ290aWF0aW9uLiAKPj4gQW5kL29y
IGV4cG9zZSBjb25maWcgc3BhY2UgcmVnaXN0ZXIgdmFsdWVzIHRocm91Z2ggYW5vdGhlciBzZXQg
b2YgCj4+IGF0dHJpYnV0ZXMuCj4gWWVzLCB3ZSBkb24ndCBoYXZlIHRvIHdhaXQgZm9yIEZFQVRV
UkVTX09LLiBJbiBhbm90aGVyIHBhdGNoIGluIHRoaXMgCj4gc2VyaWVzLCBJIGhhdmUgYWRkZWQg
YSBuZXcgbmV0bGluayBhdHRyIHRvIHJlcG9ydCB0aGUgZGV2aWNlIGZlYXR1cmVzLCAKPiBhbmQg
cmVtb3ZlZCB0aGUgYmxvY2tlci4gU28gdGhlIExNIG9yY2hlc3RyYXRpb24gU1cgY2FuIHF1ZXJ5
IHRoZSAKPiBkZXZpY2UgZmVhdHVyZXMgb2YgdGhlIGRldmljZXMgYXQgdGhlIGRlc3RpbmF0aW9u
IGNsdXN0ZXIsIGFuZCBwaWNrIGEgCj4gcHJvcGVyIG9uZSwgZXZlbiBtYXNrIG91dCBzb21lIGZl
YXR1cmVzIHRvIG1lZXQgdGhlIExNIHJlcXVpcmVtZW50cy4KRm9yIHRoYXQgZW5kLCB5b3UnZCBu
ZWVkIHRvIG1vdmUgb2ZmIGZyb20gdXNpbmcgCnZkcGFfZ2V0X2NvbmZpZ191bmxvY2tlZCgpIHdo
aWNoIGRlcGVuZHMgb24gZmVhdHVyZSBuZWdvdGlhdGlvbi4gU2luY2UgCnRoaXMgd291bGQgc2xp
Z2h0bHkgY2hhbmdlIHRoZSBvcmlnaW5hbCBzZW1hbnRpY3Mgb2YgZWFjaCBmaWVsZCB0aGF0IAoi
dmRwYSBkZXYgY29uZmlnIiBzaG93cywgaXQgcHJvYmFibHkgbmVlZCBhbm90aGVyIG5ldGxpbmsg
Y29tbWFuZCBhbmQgCm5ldyB1QVBJLgoKLVNpd2VpCgoKPgo+IFRoYW5rcywKPiBaaHUgTGluZ3No
YW4KPj4gLVNpd2VpCj4+Cj4+Cj4+Cj4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
