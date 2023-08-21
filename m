Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D6DEE4996
	for <virtualization@archiver.kernel.org>; Mon, 21 Aug 2023 22:31:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E018460E5E;
	Mon, 21 Aug 2023 22:31:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E018460E5E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=CE7oFlAs;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=hvR6Y4q2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1PbYPmuEUJA4; Mon, 21 Aug 2023 22:31:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 18BA760E2D;
	Mon, 21 Aug 2023 22:31:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 18BA760E2D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6C86C0071;
	Mon, 21 Aug 2023 22:31:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C909BC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 22:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95B6F409DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 22:31:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95B6F409DD
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=CE7oFlAs; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=hvR6Y4q2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SSU36o2EHEZw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 22:31:41 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2FA6F4099D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 22:31:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FA6F4099D
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37LFxu8m013645; Mon, 21 Aug 2023 22:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=S9B0kh/eDF7+Kf73sHumPJ8y/9PoeTD3KdsBgti/ONQ=;
 b=CE7oFlAsxNQPA0dFsMJG4SRQUbNneS/SWWRHnPpLCThmyYcRsYwY993uKjv4dWCccY30
 ozCupgNfzmo88+J25OoyHmoI1fFDRM9o/ZiR0hppNMXmQEXKLAIWCmygBIJfbfO71P3d
 ztao6wI1sT6lADAg97B3ytNASd9vC3n+30w/FJM1jUO8ItJFONwNq7PdsjdYeY64e5R+
 JQ6WvU//yucxmoxJqPvFXyNIzRasjmc0Z+fDYxDNolE9BLJsF21mAv0smJq3GdGOICBF
 DEIgGNl1E9fPp2rMxtku3mM3rzm98zj+L137KYFDQhAbTyye0CaHFXl4TSlHTQAcbN0A 6g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmb1v1ve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Aug 2023 22:31:36 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37LM13r4008022; Mon, 21 Aug 2023 22:31:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sjm642x43-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Aug 2023 22:31:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEpeUepZc6fukHpM4PgPwnW/66NH6lhuXzpfWabY+o90mjVgW5K9z+3NfSXAAXk4Iaag5mIc5ytl1L7ExEQoRafaU5eX5uW+BngaKdEImtDbAP6hP0EApgqMzA58x9BzxmsjvELgSZBSTp7O4eROgEkw+RNCQ0HIPn++6XYvmYj6R8TWkW7PSzGERjbw0X1s/J52f8MhFVyA5SZw2V1LzqlpQXStJ+ly1bXZuZT/42uapkqep4UdBn1aAmTQ9+2i0n/eAsC6C48KqhSNbVuR6dEhku1bxmLasz1qlssSE3/+ueJk+nxP0+FYWioNAUu3ONs1eZFqxX2uKaseXMWdnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9B0kh/eDF7+Kf73sHumPJ8y/9PoeTD3KdsBgti/ONQ=;
 b=DvRwNSDLStYQShh8r/dRVyfDmXKje51QRWVM5pKGfL9eQT8t2UIcfrpdVCpVHyldXWdvT93leam3l+C/IIxdIs7IXFbEi9HRrNnIeUAbSdgSXCM3Zdtkm9R1S6Wu83vQRcWXlOe3HLbuy028ucGtTruMkFsWnOv8zxf/OYcZrly3kBsV6XWpi3EpQS47dNHBOu2J4MhQKpLSK14lBCamlvX8rkSnKnOw88b1ckH33zfhAi+MzOJ7ohE8S6rV2V9M3vvU7u+FbmdKGtmECV4SY/bTo8QsVW15bzTZ6SwP5/Yj/nonaARebFR7I9vjQwizifHmxjBV8Wo1SxC9Al359g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9B0kh/eDF7+Kf73sHumPJ8y/9PoeTD3KdsBgti/ONQ=;
 b=hvR6Y4q2aDlrPq9TF1NQxmrpboSE+hzUUNYu3dppYkZOZHr84K57N9mAZmz/CzqF0qBfoafA7G2ZqXatbbTlEOkOB6eZCSUg2nnrIrYChSCUzHPKagxk1ZbH4iqQsuosCTybPq7dTPosFs4dHhx3qK12spUyVEt5s9cjqhPwB6Y=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SA1PR10MB7738.namprd10.prod.outlook.com (2603:10b6:806:3ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 22:31:33 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 22:31:32 +0000
Message-ID: <e1b5461f-15a5-6647-6473-80b3e8defc48@oracle.com>
Date: Mon, 21 Aug 2023 15:31:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 1/4] vdpa: introduce .reset_map operation callback
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuGeXYo3s6Ytd-Nvp7EXU6td1NY6LrLcVgntprXJwBEhQ@mail.gmail.com>
 <ebc38dc4-ed43-6a1d-5368-ae75269e6b43@oracle.com>
 <CACGkMEscjR_bTVfwaRcQ8qxpiOEJAT35Y1uoj=kBptYkbijDbw@mail.gmail.com>
 <46bd545d-6a90-fb51-3beb-dc942f9609af@oracle.com>
 <CAJaqyWeC=G7fbgvmyCicnuGLYD84G5+b37tVA1KqzrSHO_AGDw@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWeC=G7fbgvmyCicnuGLYD84G5+b37tVA1KqzrSHO_AGDw@mail.gmail.com>
X-ClientProxiedBy: DS7PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::21) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SA1PR10MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb81dbc-0658-4d55-98a7-08dba2965edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ATMEdA5ZT5MYvgKNoSrMNSDTaEBMLS/J8rcpGt73gPpHkwDoDchnUxXmqx8FNRwiZOXGqr8cmKc0kckEUJDHQLPFFS8JPmLP4b5D6higY6M1aat0ag1s9nrrzCyw4U3+PoGvUOI0cvKZdpgL30Ok7yXOyqL8213N5GhxEWUQXNQVbtCOOQUfXg7n2LmCy0yzLc7K+wWSZ+SzQuIR9x0aXln5CbmmkgGW68888XvNPSlNQ5qNG46qUdeq11A3rlsDKBj2p6iDGJpp2qTf2kd63gX+wleoqVxifNHeAJM+Dt7Z4mX/naPjSTQGRo2nKp/myQfZEyBm8JvLYWU+pUYQT/s08c8fP0llsZ5S+rJelBqaFJ3+q0K5oX4DnFpirIytf95klNhYR60xxh7p+RonCQX6w+SPUC+/b/tOTTUwrrxm8fNy1oAlA7T4LK4mGdMTCPgh7NrrRMrRtAMdDOQcUCHCyeVMSQQ1aR61iKHYHwoMTGWQ0zIHdiocEaMlY33UiJrOjt2kTFSBW3rUtyX38T02Ih8OcNCh0YfRl9tbT270Kz9jbjXOdNQCpx4LvrX3D2W6ZrEF6Q+Zs4KhZzX1ZoqQF1IaYnOH7ZKbSq7deuBZKvc+YO66FlAvnDPKKI499nxettdPI/DpG9wWz7wB4xD6Nv4SjkVaFEV/KmXZegxfIbPS1XQxIlMw+DkhALSb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(86362001)(5660300002)(66556008)(2616005)(41300700001)(66476007)(2906002)(66946007)(316002)(6916009)(31686004)(8676002)(478600001)(8936002)(4326008)(31696002)(6666004)(6486002)(36916002)(53546011)(38100700002)(6506007)(6512007)(26005)(36756003)(142923001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWM1OHNUaHBEUnpsMk9Hb0ZPY0Jla0dRdW9xVUpDeUpvaDlJdmVQWnpHUW1r?=
 =?utf-8?B?QjM5TFppSnR4TVMwdlRISFhESnRicWQ3RDZVL0ZZejFMOTExQ0FqL3FNQStZ?=
 =?utf-8?B?Y0dIYjZXNEd1SWFOL3JtUXRFenVOVFJjekRYbTNNeXRJTUFqNG1HNjRoMDR5?=
 =?utf-8?B?aDFoNVM0aVVQNVhRUWdZR01VY3Q1VXFPWDdlTmMzMmlqbktOOTlTWFJLNkZk?=
 =?utf-8?B?OFBDc2xtN0szTW5VQmpvK3lFbytmY0VjQUUzbXhjUVpyMGpjd2FiaVFtSldY?=
 =?utf-8?B?bFFFL2krY2syZUkrZWhOazFoZHBHOE9jV2JXbGlQQm1RODhqZkY2YXpvUG9p?=
 =?utf-8?B?R3FCWVJQU0dOMzhkd3lOMEdzbVhJMUo4MXM2SXBPZ29tTnBKUGpwUVRzVS9J?=
 =?utf-8?B?cVFEQUs0U3N4dnU2NmlVcGwrWXgzK0xZcVJEOCtJbU1oNDYrUXdBdmFuRnk3?=
 =?utf-8?B?OVI3MVNybCsrWUJRWDFGUDZJRnk1eU5heW1XT1dmU1pleUZBZXNGdzVVd1Ba?=
 =?utf-8?B?SEdKMFdNaGI5VnJOdlJ1Y2RKOWxDYnlNTnlyUXZYdXhHOHB5cWo2K1JML0NW?=
 =?utf-8?B?YWJ6QlcwaHFuNFArSk5scHdyeE5HMGxxc3JycFNFYStJVUd5OU1KenJWLzZU?=
 =?utf-8?B?ZzFIdVJDeTJhNzRRUi9zdUNVSnljTHJPd1ZZbWhITkM4K3ExL3pra2xkV3c5?=
 =?utf-8?B?cU9CRHlXNUw4ZE9Vb2tqVzN0OFRQditFZTBURkppSldqR1Y5UmtIcGhPU2w3?=
 =?utf-8?B?R2t0SGt5VmRLM2RGUVZCN1ZVQVFleHVIU09EUlgzWXcvUFdRL0lrZWs5MTRj?=
 =?utf-8?B?c2RobTVvMWJ3Yk1Bd0E0cGdFK3BCYXdLK3M3elVQREZRd2ZCd0RSa2FoeUVa?=
 =?utf-8?B?dk9FTFZnYnI1QjZmSU80aDIxb1RRckdtZnBlYTdpdHdZQlZkOTJsTjYxQkoz?=
 =?utf-8?B?VEpqbzV2MWxDZHFHKzhaSkNwZjU5cWRYc0E2WTJTSjdWMkhpb3lzTzExaTZQ?=
 =?utf-8?B?NXFNRWRoMWFYcERucWFhK2VmNThyRmhKSDYrWG5tbHB6OFQ2dk51MUhEMWpH?=
 =?utf-8?B?Uk5FY1BBcHkwcnRGSnlWWC9QZDNjQnpkbjZSbFAvN1FPaXQ4MSs1UlJzMnJu?=
 =?utf-8?B?dzRNR3NJaVFXUGZZY2NWT1B0RmlieElEWWdTTXpEMGFyZGFjaGt3N0x0ZFhL?=
 =?utf-8?B?QVFFOGZrWEdBM0RwVUNyN1kwZis3T21ScnZEemdLN0crY0poUVQyZWZTc2NG?=
 =?utf-8?B?NTNhcjhvNnIrcVE2bEsrYkRvaVluSnhRT3JQYmxFVTYxaFFWTTYydTVYUHdZ?=
 =?utf-8?B?TWlmTG8vNGNEVzdnRVpZMW03UDIrd21HZ1NtZWdOakdJZWtkbjFtWE9mUGhh?=
 =?utf-8?B?M1ZJY1djdHV2UkEwOTFvK2VOS2VadWpJUXZrbzdBaFpXTDFWYUhqNm01enZP?=
 =?utf-8?B?T2VRaU16UFRmUS8yY2V0ODh1UUN6b3hDV1YvSG1WVnlLaTl1SHlyMk5kWW1j?=
 =?utf-8?B?QVRZWXNyb2JsWEgzenpER293Sm1oMUIzVmZObWsvaG93c2Z5ams1bHdTS3JV?=
 =?utf-8?B?T0pYUDdEdDByOS93bGk1ZlZydE9tZVc2cUcvTTRVZ3ZTQVNkWWFvR0U3Z1NP?=
 =?utf-8?B?cHY2WlcrVE1DNWpIMU05STMwSXNISVJodjZzQjV5aFVSd1ZCYUtKY0ZpUTQy?=
 =?utf-8?B?OGsyQTlXZnc4T28vTnE3R3drNnYrV2FZdEtSMndhSGkyUHQvU09Fc3N0aGt6?=
 =?utf-8?B?bFd2Q05WV28vNi8zNHh1MmlyRmRRL2k2elhzZmJlbGh1cjRnc0hmSnlkR2tY?=
 =?utf-8?B?SFBtdHg5UWQ1RmFrc01pWTJHMjkzVXBCcno5amVWbld3WS85YkhkRzRiTUNM?=
 =?utf-8?B?eVNmWjUzdDd1QUZSc0MxTldZSkI3eS9jVVF2VldXaXRwb2dJT0ovaXA1ZVRN?=
 =?utf-8?B?TVIxNE5mR2N1bTFyeStuSzdjRUFPb3ZKOGJ4cTE3RDZQVFYzVHgrTitMNUVk?=
 =?utf-8?B?UWtsRHNJZi96MTRHTkU2UFpwOWpSSVk5Qndsc1hJYUg0bjE5Nnp4NkdlQnRq?=
 =?utf-8?B?Z1M3SjB4UmQrTFZqTDFwNGh3QnArckE5QTJISjI0aHBrbERBV2JjU3J4RkFz?=
 =?utf-8?Q?gTAkS/r8Satst25WGP0gutn/O?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?V20rdmNFYW1aVGdFSFBFYzkrYmd4NHdkVUFZbWVUelBJVGV1NEoxSGdVME92?=
 =?utf-8?B?REFTeGVXY1lMYVdXVXRVWDNzVUVaOHZCVmVQQk1HeThIcjR0dStreDBRNGpJ?=
 =?utf-8?B?eURIYXhORXQycnhrV3BDYmhoNGw0MENVbkxjMlFFN0ZRZ1JDYlRkMmxSQjNK?=
 =?utf-8?B?c2tpNzRFeG5OdGc2SWVaUjVkWEpyL29TMlYzNVU2Q1JwVVBZUWJQbithWFdU?=
 =?utf-8?B?ZDgzWWNqMlRselV1dVh2N2RVWkpHY2IzeU5ITnphWGdPWXh0NytSWGYrZVNv?=
 =?utf-8?B?Y3hpQU43M1k5aHBhRXZDaUp5d0wwVVpVR3BZVjdOdnBIWFlpd3R1STZacnpE?=
 =?utf-8?B?VmF4Ylc1em81VzJsVDF0c1QxNXhXZXlmeTFVUjd6MmI2TUJDc2htQU9KdTBF?=
 =?utf-8?B?bVBraG9wakJuQm01R3A2WGZrakZvM1dUR2NGdUxJTHcyejZlN2lLY2g4YnRS?=
 =?utf-8?B?NzJ6VkNVUi9FdGdOMFM0LzdzTjZBSDRQaHJCZDlxNExtanRTUzhpTE1FdlRX?=
 =?utf-8?B?OWg0dUlVNjJBVkdWNzVEWmlTZU8vRlczK2h4NDdtZmJrRWFCVzd4dWNQc29Q?=
 =?utf-8?B?SHBrNXRyT21CVkpZa2tGa1NXOFdFeElJb0VpV1FCb3ZoOVVaSFdZRkNVd2lk?=
 =?utf-8?B?SFpVakMvY3E5QXhSM3o3TUlhUHZ2VEpBVTRyc21iTWQvNU9vTmZacm02MmVx?=
 =?utf-8?B?SE1abEo2RW05MzBRNElPSklaRTdZaEI0Z2dHZjl3bnVzdE5kcWFxT0NsRldu?=
 =?utf-8?B?R21yb3lwanZwWHFYc3dZdWRTaVNjWTdOZlJ1L3laTStIcklVTVc4YWV2YTFU?=
 =?utf-8?B?NndnNEFQaFBncTZIQ2FwSDNURDJWWmlWMWhzVFFCeEN6Q1BWQS8vRVJ1Uysz?=
 =?utf-8?B?L1hKc1ZKdXJsV1h2VUNLVjNFVW5wd2p6bGthaWFxbHpuYmd2WjhZMU0rdG5J?=
 =?utf-8?B?Y3VWSlN3SC84MHFsdnMrMlRrTzFpODJGaGVydU1QSTNPSWNhdUk4UXFjdC9U?=
 =?utf-8?B?dVhzUzJFUS9ZWXQvZHlwRDJmbS9BTnRTWTVlNGdYbFJkekVZZmpUdlYwYWtm?=
 =?utf-8?B?MEkzcndkS1J0ZVdnNVJUMWptVW5nTGZRTjhET1NsdnRsNHFHbk9tS0xzekxa?=
 =?utf-8?B?eVpUYWJxY282TCsxd0lZU1RjNWc4SnA1eCtFN0RpWDNiTmU2SzFFZGp5NVNB?=
 =?utf-8?B?V29wZ3YydTE0dmlhUWhzeXFzYkc2Y1kxV29uODZDOGZ1bGtJUWVNTURDeUIr?=
 =?utf-8?Q?3JxaS9xckB6KoGg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb81dbc-0658-4d55-98a7-08dba2965edc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 22:31:32.5974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nC+wh9vhrHeLCExerr6memAQLKQt67Qr/zr/lwr3CD1Q8CjXOrW49T4F/KGNLCvUTTlon0ySp4MKCe5Wu+gmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7738
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210207
X-Proofpoint-ORIG-GUID: ii03pm1Db_OElBnWqDcAsiVyaKeWnUIv
X-Proofpoint-GUID: ii03pm1Db_OElBnWqDcAsiVyaKeWnUIv
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, gal@nvidia.com
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

CgpPbiA4LzE3LzIwMjMgODoyOCBBTSwgRXVnZW5pbyBQZXJleiBNYXJ0aW4gd3JvdGU6Cj4gT24g
VGh1LCBBdWcgMTcsIDIwMjMgYXQgMjowNeKAr0FNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3Jh
Y2xlLmNvbT4gd3JvdGU6Cj4+Cj4+Cj4+IE9uIDgvMTUvMjAyMyA2OjU1IFBNLCBKYXNvbiBXYW5n
IHdyb3RlOgo+Pj4gT24gV2VkLCBBdWcgMTYsIDIwMjMgYXQgMzo0OeKAr0FNIFNpLVdlaSBMaXUg
PHNpLXdlaS5saXVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4+Pj4KPj4+PiBPbiA4LzE0LzIwMjMgNzoy
MSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4gT24gVHVlLCBBdWcgMTUsIDIwMjMgYXQgOTo0
NuKAr0FNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4+Pj4+PiAt
LS0KPj4+Pj4+ICAgICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCB8IDcgKysrKysrKwo+Pj4+Pj4gICAg
IDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKPj4+Pj4+Cj4+Pj4+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4+Pj4gaW5k
ZXggZGIxYjBlYS4uM2EzODc4ZCAxMDA2NDQKPj4+Pj4+IC0tLSBhL2luY2x1ZGUvbGludXgvdmRw
YS5oCj4+Pj4+PiArKysgYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4+Pj4gQEAgLTMxNCw2ICsz
MTQsMTIgQEAgc3RydWN0IHZkcGFfbWFwX2ZpbGUgewo+Pj4+Pj4gICAgICAqICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBAaW92YTogaW92YSB0byBiZSB1bm1hcHBlZAo+Pj4+Pj4gICAgICAq
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAc2l6ZTogc2l6ZSBvZiB0aGUgYXJlYQo+Pj4+
Pj4gICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSZXR1cm5zIGludGVnZXI6IHN1
Y2Nlc3MgKDApIG9yIGVycm9yICg8IDApCj4+Pj4+PiArICogQHJlc2V0X21hcDogICAgICAgICAg
ICAgICAgIFJlc2V0IGRldmljZSBtZW1vcnkgbWFwcGluZyAob3B0aW9uYWwpCj4+Pj4+PiArICog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5lZWRlZCBmb3IgZGV2aWNlIHRoYXQgdXNpbmcg
ZGV2aWNlCj4+Pj4+PiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNwZWNpZmljIERN
QSB0cmFuc2xhdGlvbiAob24tY2hpcCBJT01NVSkKPj4+Pj4gVGhpcyBleHBvc2VzIHRoZSBkZXZp
Y2UgaW50ZXJuYWwgdG8gdGhlIHVwcGVyIGxheWVyIHdoaWNoIGlzIG5vdCBvcHRpbWFsLgo+Pj4+
IE5vdCBzdXJlIHdoYXQgZG9lcyBpdCBtZWFuIGJ5ICJkZXZpY2UgaW50ZXJuYWwiLCBidXQgdGhp
cyBvcCBjYWxsYmFjawo+Pj4+IGp1c3QgZm9sbG93cyBleGlzdGluZyBjb252ZW50aW9uIHRvIGRl
c2NyaWJlIHdoYXQgdmRwYSBwYXJlbnQgdGhpcyBBUEkKPj4+PiB0YXJnZXRzLgo+Pj4gSSBtZWFu
dCB0aGUgYnVzIHRyaWVzIHRvIGhpZGUgdGhlIGRpZmZlcmVuY2VzIGFtb25nIHZlbmRvcnMuIFNv
IGl0Cj4+PiBuZWVkcyB0byBoaWRlIG9uLWNoaXAgSU9NTVUgc3R1ZmYgdG8gdGhlIHVwcGVyIGxh
eWVyLgo+Pj4KPj4+IFdlIGNhbiBleHBvc2UgdHdvIGRpbWVuc2lvbmFsIElPIG1hcHBpbmdzIG1v
ZGVscyBidXQgaXQgbG9va3MgbGlrZQo+Pj4gb3ZlciBlbmdpbmVlcmluZyBmb3IgdGhpcyBpc3N1
ZS4gTW9yZSBiZWxvdy4KPj4+Cj4+Pj4gICAgICogQHNldF9tYXA6ICAgICAgICAgICAgICAgICAg
ICBTZXQgZGV2aWNlIG1lbW9yeSBtYXBwaW5nIChvcHRpb25hbCkKPj4+PiAgICAgKiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIE5lZWRlZCBmb3IgZGV2aWNlIHRoYXQgdXNpbmcgZGV2aWNl
Cj4+Pj4gICAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzcGVjaWZpYyBETUEgdHJh
bnNsYXRpb24gKG9uLWNoaXAgSU9NTVUpCj4+Pj4gOgo+Pj4+IDoKPj4+PiAgICAgKiBAZG1hX21h
cDogICAgICAgICAgICAgICAgICAgIE1hcCBhbiBhcmVhIG9mIFBBIHRvIElPVkEgKG9wdGlvbmFs
KQo+Pj4+ICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTmVlZGVkIGZvciBkZXZp
Y2UgdGhhdCB1c2luZyBkZXZpY2UKPj4+PiAgICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHNwZWNpZmljIERNQSB0cmFuc2xhdGlvbiAob24tY2hpcCBJT01NVSkKPj4+PiAgICAgKiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFuZCBwcmVmZXJyaW5nIGluY3JlbWVudGFsIG1h
cC4KPj4+PiA6Cj4+Pj4gOgo+Pj4+ICAgICAqIEBkbWFfdW5tYXA6ICAgICAgICAgICAgICAgICAg
VW5tYXAgYW4gYXJlYSBvZiBJT1ZBIChvcHRpb25hbCBidXQKPj4+PiAgICAgKiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG11c3QgYmUgaW1wbGVtZW50ZWQgd2l0aCBkbWFfbWFwKQo+Pj4+
ICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTmVlZGVkIGZvciBkZXZpY2UgdGhh
dCB1c2luZyBkZXZpY2UKPj4+PiAgICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNw
ZWNpZmljIERNQSB0cmFuc2xhdGlvbiAob24tY2hpcCBJT01NVSkKPj4+PiAgICAgKiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGFuZCBwcmVmZXJyaW5nIGluY3JlbWVudGFsIHVubWFwLgo+
Pj4+Cj4+Pj4KPj4+Pj4gQnR3LCB3aGF0J3MgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGlzIGFu
ZCBhIHNpbXBsZQo+Pj4+Pgo+Pj4+PiBzZXRfbWFwKE5VTEwpPwo+Pj4+IEkgZG9uJ3QgdGhpbmsg
cGFyZW50IGRyaXZlcnMgc3VwcG9ydCB0aGlzIHRvZGF5IC0gdGhleSBjYW4gYWNjZXB0Cj4+Pj4g
bm9uLU5VTEwgaW90bGIgY29udGFpbmluZyBlbXB0eSBtYXAgZW50cnksIGJ1dCBub3QgYSBOVUxM
IGlvdGxiLiBUaGUKPj4+PiBiZWhhdmlvciBpcyB1bmRlZmluZWQgb3IgaXQgZXZlbiBjYXVzZXMg
cGFuaWMgd2hlbiBhIE5VTEwgaW90bGIgaXMKPj4+PiBwYXNzZWQgaW4uCj4+PiBXZSBjYW4gZG8g
dGhpcyBzaW1wbGUgY2hhbmdlIGlmIGl0IGNhbiB3b3JrLgo+PiBJZiB3ZSBnbyB3aXRoIHNldHRp
bmcgdXAgMToxIERNQSBtYXBwaW5nIGF0IHZpcnRpby12ZHBhIC5wcm9iZSgpIGFuZAo+PiB0ZWFy
aW5nIGl0IGRvd24gYXQgLnJlbGVhc2UoKSwgcGVyaGFwcyBzZXRfbWFwKE5VTEwpIGlzIG5vdCBz
dWZmaWNpZW50Lgo+Pj4+ICAgIEZ1cnRoZXIgdGhpcyBkb2Vzbid0IHdvcmsgd2l0aCAuZG1hX21h
cCBwYXJlbnQgZHJpdmVycy4KPj4+IFByb2JhYmx5LCBidXQgSSdkIHJlbW92ZSBkbWFfbWFwIGFz
IGl0IGRvZXNuJ3QgaGF2ZSBhbnkgcmVhbCB1c2Vycwo+Pj4gZXhjZXB0IGZvciB0aGUgc2ltdWxh
dG9yLgo+PiBPSywgYXQgYSBwb2ludCB0aGVyZSB3YXMgc3VnZ2VzdGlvbiB0byBnZXQgdGhpcyBp
bmNyZW1lbnRhbCBBUEkgZXh0ZW5kZWQKPj4gdG8gc3VwcG9ydCBiYXRjaGluZyB0byBiZSBpbiBw
YXIgd2l0aCBvciBldmVuIHJlcGxhY2UgLnNldF9tYXAsIG5vdCBzdXJlCj4+IGlmIGl0J3MgdG9v
IHNvb24gdG8gY29uY2x1ZGUuIEJ1dCBJJ20gb2theSB3aXRoIHRoZSByZW1vdmFsIGlmIG5lZWQg
YmUuCj4gWWVzLCBJIHRoaW5rIHRoZSByaWdodCBtb3ZlIGluIHRoZSBsb25nIHJ1biBpcyB0byBk
ZWxlZ2F0ZSB0aGUKPiBiYXRjaGluZyB0byB0aGUgcGFyZW50IGRyaXZlci4gVGhpcyBhbGxvd3Mg
ZHJpdmVycyBsaWtlIG1seCB0byBhZGQKPiBtZW1vcnkgKGxpa2UgaG90cGx1Z2dlZCBtZW1vcnkp
IHdpdGhvdXQgdGhlIG5lZWQgb2YgdGVhcmluZyBkb3duIGFsbAo+IHRoZSBvbGQgbWFwcy4KTm9k
cy4KCj4KPiBIYXZpbmcgc2FpZCB0aGF0LCBtYXliZSB3ZSBjYW4gd29yayBvbiB0b3AgaWYgd2Ug
bmVlZCB0byByZW1vdmUKPiAuZG1hX21hcCBmb3Igbm93LgpJIGd1ZXNzIGZvciB0aGF0IHNha2Ug
SSB3b3VsZCBrZWVwIC5kbWFfbWFwIHVubGVzcyB0aGVyZSdzIHN0cm9uZyAKb2JqZWN0aW9uIGFn
YWluc3QgaXQuCgpUaGFua3MsCi1TaXdlaQoKPgo+Pj4+IFRoZSByZWFzb24gd2h5IGEgbmV3IG9w
IGlzIG5lZWRlZCBvciBiZXR0ZXIgaXMgYmVjYXVzZSBpdCBhbGxvd3MKPj4+PiB1c2Vyc3BhY2Ug
dG8gdGVsbCBhcGFydCBkaWZmZXJlbnQgcmVzZXQgYmVoYXZpb3IgZnJvbSB0aGUgb2xkZXIga2Vy
bmVsCj4+Pj4gKHZpYSB0aGUgRl9JT1RMQl9QRVJTSVNUIGZlYXR1cmUgYml0IGluIHBhdGNoIDQp
LCB3aGlsZSB0aGlzIGJlaGF2aW9yCj4+Pj4gY291bGQgdmFyeSBiZXR3ZWVuIHBhcmVudCBkcml2
ZXJzLgo+Pj4gSSdtIG9rIHdpdGggYSBuZXcgZmVhdHVyZSBmbGFnLCBidXQgd2UgbmVlZCB0byBm
aXJzdCBzZWVrIGEgd2F5IHRvCj4+PiByZXVzZSB0aGUgZXhpc3RpbmcgQVBJLgo+PiBBIGZlYXR1
cmUgZmxhZyBpcyBuZWVkZWQgYW55d2F5LiBJJ20gZmluZSB3aXRoIHJldXNpbmcgYnV0IGd1ZXNz
IEknZAo+PiB3YW50IHRvIGNvbnZlcmdlIG9uIHRoZSBkaXJlY3Rpb24gZmlyc3QuCj4+Cj4+IFRo
YW5rcywKPj4gLVNpd2VpCj4+PiBUaGFua3MKPj4+Cj4+Pj4gUmVnYXJkcywKPj4+PiAtU2l3ZWkK
Pj4+Pgo+Pj4+PiBUaGFua3MKPj4+Pj4KPj4+Pj4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgQHZkZXY6IHZkcGEgZGV2aWNlCj4+Pj4+PiArICogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEBhc2lkOiBhZGRyZXNzIHNwYWNlIGlkZW50aWZpZXIKPj4+Pj4+ICsgKiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgUmV0dXJucyBpbnRlZ2VyOiBzdWNjZXNzICgwKSBvciBlcnJv
ciAoPCAwKQo+Pj4+Pj4gICAgICAqIEBnZXRfdnFfZG1hX2RldjogICAgICAgICAgICBHZXQgdGhl
IGRtYSBkZXZpY2UgZm9yIGEgc3BlY2lmaWMKPj4+Pj4+ICAgICAgKiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdmlydHF1ZXVlIChvcHRpb25hbCkKPj4+Pj4+ICAgICAgKiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQHZkZXY6IHZkcGEgZGV2aWNlCj4+Pj4+PiBAQCAtMzkwLDYgKzM5
Niw3IEBAIHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgewo+Pj4+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICB1NjQgaW92YSwgdTY0IHNpemUsIHU2NCBwYSwgdTMyIHBlcm0sIHZvaWQgKm9wYXF1
ZSk7Cj4+Pj4+PiAgICAgICAgICAgIGludCAoKmRtYV91bm1hcCkoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCwKPj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1NjQgaW92YSwgdTY0IHNpemUpOwo+Pj4+Pj4gKyAgICAgICBpbnQgKCpyZXNldF9tYXAp
KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50IGFzaWQpOwo+Pj4+Pj4gICAg
ICAgICAgICBpbnQgKCpzZXRfZ3JvdXBfYXNpZCkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1
bnNpZ25lZCBpbnQgZ3JvdXAsCj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1bnNpZ25lZCBpbnQgYXNpZCk7Cj4+Pj4+PiAgICAgICAgICAgIHN0cnVjdCBkZXZpY2UgKigq
Z2V0X3ZxX2RtYV9kZXYpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCk7Cj4+Pj4+
PiAtLQo+Pj4+Pj4gMS44LjMuMQo+Pj4+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
