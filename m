Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081B0CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 04:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44A7182167;
	Wed, 18 Oct 2023 04:36:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44A7182167
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=01mfIupP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=yCgI+cRw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QKqnSnOqjbR4; Wed, 18 Oct 2023 04:36:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B64C38224D;
	Wed, 18 Oct 2023 04:36:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B64C38224D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7441CC0071;
	Wed, 18 Oct 2023 04:36:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C555C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 04:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6973D401C9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 04:36:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6973D401C9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=01mfIupP; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=yCgI+cRw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mQKTRVBJ6x_F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 04:36:01 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C94E40146
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 04:36:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7C94E40146
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39HJxMVW018261; Wed, 18 Oct 2023 04:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=38mRKxm//vCEsPRWfftvMJC+dlz7U8aHLUM8UTVCWMs=;
 b=01mfIupPFTR8kE6zvifyqliDFf0j9p+Z9gu8sEdmrHULH11CjNRvHeZdxNWTVZBpOj6F
 pwZldFsRVgDpM3TBIQSZe5PZvmIWI58GjzravX3glZpG36megkW2BWweOvONgshc10K0
 MeaLfSZCW/BEcB9bUTUQEI8YfZr50vzUMkjhsZOPVIZS0oSCjLjrhcS+Q6zargcU013h
 7kVqiJC5/1ecZHlhI4jeDedtyl1Ofnsgw8U4DXSrvLuAGalopWfCM6ruewhtPq58Ih55
 AkmeurpsW08OeGkU9p7qHgKkTi/6/fTA7ZB5PNKinLzy2DwcALXPCEjbCMGwcWNsf9HI pA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28pq94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 04:35:57 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39I1xMQ9015234; Wed, 18 Oct 2023 04:35:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3trg1fy2qu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 04:35:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+lc/DEKtV2062MA5ShxYc6NrijMWHbLVPD3wnDK3NyEyYxT6x4shBYV42qdDjpV5nFmCL9mQrlJnZv9h+f5Mg0reu2IQBBERrsc+6saSxZH2fqXM6dQIKvw0HNClRP5c3GNc9Ipao6QrngF2FTZIJ6eh+PRJSrOBTdojobpeKk/QQttEStGSbScoisVFM+U0GjXQqHxg4dCY7nDIkaZ7Cp5CvfmduTE2IelKbKLnAurGwd75hNl8MqG6gjYtSvnaXqfJBRCHehWC3LBdVbpd2v8IUlt/gxKhk3hK4A2LMctyoa7sfERriaYK7zZZVWGYyUApNzeZLN6YGovsOcByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38mRKxm//vCEsPRWfftvMJC+dlz7U8aHLUM8UTVCWMs=;
 b=D1/+1YsyepAEJE4LUAleqtxxF0bN8GgkvBLUyXcRHgF0V3QAetbvpY+xsWBSBK4OeQVa2GxoQDu/ridm2ZOIawexSy/BAABmICV5d5BCSrADy0ZqrqdwPt931QKC1ga76tf6+WxDgWUDAQfvaFtw3kkkCWMdkSV1O7j0Nbi5eU1CQbnwwtS54TCTuCxU37KQ977dBH7EpUUJO3IwZzNJfXBPpdYy7pXwf0Y7FLHcUTVcnyIQaRfVXH50o/H3et4WOmmBtsQc4ObzVXDIDwzDYjHKwi/dL6tAZw3PG5D5Mb4pOtvEGCVrvoNUi8xFrVZiPyiiH7jG7NHPes0wQmfS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38mRKxm//vCEsPRWfftvMJC+dlz7U8aHLUM8UTVCWMs=;
 b=yCgI+cRwqaGtc+0bwbElZu05l7alod7fI3CcZCTUaiSDJw3Lvunr+7zkXQvGHXm5+tQXbFolLaa4cKUAWfI6CsEdyOp/N6om1mqiNS00uJQV7jTGSzRn/EXJw5cMBvabNEqTwKZo1oNWDIV+7Ej38fi7yFBeFUFuFdZz3KTmmAQ=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS0PR10MB7269.namprd10.prod.outlook.com (2603:10b6:8:f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 04:35:52 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 04:35:51 +0000
Message-ID: <c9c819b9-4a63-4bb4-a977-881f6e653ed8@oracle.com>
Date: Tue, 17 Oct 2023 21:35:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
 <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
 <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com>
 <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
X-ClientProxiedBy: DM6PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:5:334::12) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS0PR10MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: acc00937-2802-40c0-a350-08dbcf93b50f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tq1PUbIIpXf9oDmpXfO9pZdslelINI//0scnr5+jjIMkjI/u3msDcjXruVxe4Y+dvUvliVES18F40vi8dzuDeX5xRaPcQcQuW8rIRm2zRJrtrB0TmNCkC3sstgbYAOnuFOZ5Xuz2FYbpOigIdrBu4BD4zUECh0BmN4eQrKM6JNgfpNRLF63qU+agM9tlXLBYTRLTj/zO0A22jkpx7eDO2W4dWdHyuvzIW8qdgleGJ35VoWksW3ogBDUyFvScJ2K7TW6M25KHM+JvUujJyYxeN9oBEnb+uikmgI9RBPBHGFXW5IJyQxPJN1Qsyfoqn4HskXVM7eWus2b+YtRdZpvzV4eL884uQMAN8XBVR7SkvtPIvSHY61SzYmpoeJSPXiYn8/kdRb+idSsqZspfsqt3r6B1Y6ib09iTrT+R5Blj8S+xRX9cXoBtUq/uqdCt1pVH9R9CqyprjLwCXqnkPnrVwwyJopSeGQxHYMOSPtJM7Ks3gaF2KTiumk7YlMKj/zqToCOy9wFZNeShbZQnOrWi5znCxveIoyDaNdplr3rfHJPTMWj3jCvOPXY32nyb3iM5StvL/6UAP28jVW0gdhUFG2EdeDZaTGoz/4BLyWo/J8TPp8O1FufWhoauu0NxdoMPqpx+cCzy3IRE+4y7ZgYqDgGEgsrRl1VlnGyGP0BeWG++V9Qa9fYmd824Ue/qMdErMwBKhWk4KJNJW5OGeC9ELA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(966005)(478600001)(6486002)(66476007)(66556008)(66899024)(316002)(6916009)(66946007)(83380400001)(26005)(2616005)(31696002)(86362001)(36756003)(38100700002)(6506007)(36916002)(31686004)(53546011)(6666004)(6512007)(2906002)(41300700001)(8676002)(5660300002)(8936002)(4326008)(142923001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEVnTHl5WHFjOTZlUmg5R2pjMWxONkdiK0hLUEdnVXdkZWpFZkN1c3lQMVVU?=
 =?utf-8?B?blRQRHFaUmU2Y2tBNTk0dFU0aFkxZ0VoWDE1K2pYSWtYYy9jZjZVWjhsUkZt?=
 =?utf-8?B?cXgxMloyR2I2RGZidnJXRTFnczVhSnVJQzA4WEhlL0RBdjVKY3MreUJ0YXFy?=
 =?utf-8?B?ak96SWZKcGtYT2U4aXg0SkZad0ZJSlJqdlFFaU5RaGFmbWd3VXByeU9OUTFi?=
 =?utf-8?B?V1lrRUpPdGlUREdHVU1HWW81WlBPaVdQS0tuVGJtcEovVnkrQm1pQVUwSlVl?=
 =?utf-8?B?eThaVFZFNHhZaTdwWjBJZUI1clJmWjEvVEwvSTBCRzZ1aXZjajl3MzlMT0Jl?=
 =?utf-8?B?cnZoZ085cXozeSt5S2NzV1VPblhUOGliSGF2bDNybFNaWE10eVB6ckZ2Z2tu?=
 =?utf-8?B?VVZhbmoyeGM2c2FrWERrcFJabUpzYk1pK0oxQnlLOEVRZkFpRWhNSGtaVnhi?=
 =?utf-8?B?SjBxUnFESzFoZC90cVJjSUFRbkFZeE43QjVvQmFSYlcydkpGRTVYNG95NG9U?=
 =?utf-8?B?clEzbGFiaEc1MVlCVzZaeHA3M2pvZGVNeUU1ajF0R3RlSHBVK1Y4dUFTWUhH?=
 =?utf-8?B?WGxPSU1yWmVVUkN0QmRwVWNhdWdmSWg3ZTBzVGc2Z2MzWHhuYmsxczFUVG84?=
 =?utf-8?B?Mnc0OEh3REkwSjZsZHU4YzBZUWo1YWJNZ0QrbXMxeG9vdmZJRzh6ZTJ1YzdX?=
 =?utf-8?B?dW9mSStEMWFibTB5c0haTmQ4SyswVWtCeWZidGFmdmtwVU9JS2lNQmdMZVU5?=
 =?utf-8?B?dlJoYWNSUENwUkpNTTc0OFdkS29OOHNwaGgrWHpWcEUrdjRrNG5ySjN1bFVU?=
 =?utf-8?B?WVoxVVc4cGpoRHgwLzdiRk0yaEFyZFkvdWpqcjdyL3JIVDBpN1IrTEJSRy8r?=
 =?utf-8?B?bHIzaHR1ck9XT2hjYm9zS0hmQ0t5c2NvWnJzbDY2VzlxMzZWbzJpRTUvbUY1?=
 =?utf-8?B?bHZPbFo4R3lUdFV1TG1RY013eFRRQnBaNGRPR1d3ZHVzSnpHNm9JdGFWTmdh?=
 =?utf-8?B?OHp6Q3BEZmNpZ0lBS0tQZytDWWZoVFcxTE1YeVN2cFhkeHJFUm01cXdtcmVp?=
 =?utf-8?B?bEFSRGVYZCtsRUVhRDJ0MzNwNUZBQTJ2UXNmd2x2NUliZjgxdnp2SmFoZ1NL?=
 =?utf-8?B?cXdLUUlsZnpYNjNRN2IvOWwzcnZmQWJ0TGFjRFh3WGt5aHR6UFRqWGx2cllT?=
 =?utf-8?B?TUZRbnlCSWE1YzUzUGZPNmxQUmEzZng0WXlCQXN1YUtlUXZNQ01IaEhYU256?=
 =?utf-8?B?clJBQ2FwS2VBbllDWmVYU3cvRTVXZ25vQ3Y0VWZOV0hOL09SMVpxM3dYQnVC?=
 =?utf-8?B?bWpTRFlmZmc4WW5rRkJldFZhdUp1RnFlbkc1N2Z6M3BMUXZBMTByTS9YU3dy?=
 =?utf-8?B?ajUyMmRwY0YzMU0wM3duWWdDbmZQZnRodHV4UzNIbFRUVHVFNUhSV2YrZXh2?=
 =?utf-8?B?Z09ZcFBNUTVIVFBKSGZEc243R2tEbGpVd3JvVHprMnhxVlBSdHBUZUJ1RWpu?=
 =?utf-8?B?ajhNMll0Wm1rdDNabGJxZ0x0WDZNREpiVytrcXBjMitBWFdBek1yVVJJV2Jz?=
 =?utf-8?B?TXZONkRUMTlYdHNibjBqNXQ5akcxSWRtcUtIcWV6UUlUNEJxV3NXSFhFUWtN?=
 =?utf-8?B?UnFaanpuS3BvUGd3cVJSTVZiQVk1ZjVsb1N0LzJ6ZHFRRys0UDgwelFLVjBB?=
 =?utf-8?B?ZVVha0FCZGhpak5vNG96a2J1SUR4S2JQaEYwUGFVTkRVSnA1eW03NzA4dGVG?=
 =?utf-8?B?eXVucXdIMW05Q0pHOWErenNUdjBFVjFVZHFNL3FvbEI5emc3WFkyaEkweXhy?=
 =?utf-8?B?SUtHelQyTGIybS8rakYvSEpUM0xjdTFXc3l3dzI2Y1dhTGxKeXVNQkZPOStZ?=
 =?utf-8?B?OTZLcVlvTTNUUXIxdHVVWVlDWG5DaHJza3R4ZjI4SU01aE1yQVVjYUdyeGgw?=
 =?utf-8?B?TFBNZlZ5VThGRkZWbVNvRnQyaDFRYWI4aGxaUmpBai9lMGhJRG8xYjN5TUZx?=
 =?utf-8?B?Y21GU3BuQjZJdmVIVEh3QURnaEpPZFdpVTFOVGd0b3ZlYzVrNnFLRlpCK1Fx?=
 =?utf-8?B?Sk9GdkhWeDBZZ2ZUMW1CWUNhVEZObVhYQU90YkF5WVRwYUpqY29LVHNQYmlC?=
 =?utf-8?Q?aecuHm6AfJKeECThiLD2K/brL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N1NMU2dONXJtMWdrRllSZWt5Q2NIU2xtV3hWc3MyMWx5Q0pkMG1EREcyTlJV?=
 =?utf-8?B?Z2lRWHJCQ3JEamtEeDRMMndBS2U4NjBPckJyK1YxaUdENmNmZjBHQXcrbjA2?=
 =?utf-8?B?TWVEL05VNWx2ZTBCcks1WkUxcks4TlZyN0NFZ29pQWM5bjBYK3JkdklKMUo2?=
 =?utf-8?B?bENDOXFteDdvZFZ1M0dKdXk5UFZDS1AwSjFWeEZQdWRlV0V0QXExWnJtc1pu?=
 =?utf-8?B?YjU1WWhEeHRDeFRYUi9DL3I4bDRtVTRBTUlBZEVwdzNDcENLNGhzV29qckdL?=
 =?utf-8?B?UGRzS0pMVERNUUk3RzU4WXd3UlM0dlhXWlFwTnpXV0dmUzQrU1ZnWW5nWkhu?=
 =?utf-8?B?cFdHbnZscXFwQnJVQkQ5TUNiTjFuWWdibTVTOHpYS25DTGdZaFdGelJEVU56?=
 =?utf-8?B?aTZkc0dCdnNUQW5hb3M3TTJuYnE3dkIzOFlHa0x1WDdwaFBTa3hRa3RyV3A4?=
 =?utf-8?B?d204OVI1cThkQkJyY3luQm9KSGNiSGxrTXN0Y1NQNm9kNVR1RE5WNlAwUTNN?=
 =?utf-8?B?Sm9ZaEtKQ0VPbGgvZFRqOWNrRkhqSVM0YXRFWWxZSmIxb3Rxdy9Ld3lkVzhO?=
 =?utf-8?B?VHgzKzMrN1lSN1RpMENUdi9wWVR6Rk9DMjFUVGZyR1IvbHFpYWxkWmkzYXpV?=
 =?utf-8?B?WldiQmZEbE94TWJqcWJHZEcvRUhyQndGcVFlSGZZWVZjTkd3Y1VFbUZYZWNn?=
 =?utf-8?B?b2d2dFRiZWNKUUp1dThNZzAyK0gyWGYzejZzN0krWkViS25lZFZsenRRVEJR?=
 =?utf-8?B?c3dlOTVuaWVPRlNrMTBCUFdqZXByU1NHZjhwaFRDMnFVakNJdHRVMkNuVjFo?=
 =?utf-8?B?RXRxdTVzclcwdzlMb1hZdTF4RFUyYVNwdWhCTXJMUzV2SXNnV1VWdG9EUXlE?=
 =?utf-8?B?a3RNMWdZaVVmUDkvMDViMTVqQVZmdkRZUXNKT214dlo5SDQ2T1RVc2VsYStl?=
 =?utf-8?B?YU5KV3loVFRpSUwxZHpRWjA0SHZMNkVCOUZjelR0S29mK0hxd3ljTENlYVlX?=
 =?utf-8?B?QUplTjdGSFpocTJncEo0SmIzSm5JczMxNWRJcFZLVURVbGxYUjlHN2pwazlU?=
 =?utf-8?B?M1I2T1cxaDNlWUZBb0s3N2kxWjVOLzZNcXZTVkRZNEcrb0VrbmxPWFNFazJL?=
 =?utf-8?B?bDB1S05ZcFJuUHBTa3dsSDJKOS9OdFNyMmRWeE5KQ3FXOSt1dWpHWlZCNE9w?=
 =?utf-8?B?VzFrRSt3RFBRTk11TmZHb1psNTlHT1JZSUo3WE1UL0luaTNGcTRPQXNZL2ZS?=
 =?utf-8?Q?4aZiRJ8sNzYbEXl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc00937-2802-40c0-a350-08dbcf93b50f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 04:35:50.9539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AANXxWT7Ib+iZcBf2vdXr6JPOUBWeKh/n9RFvxVMteZuNk4oxLtzpFMbk05D+Tsw4J23qlZGxw6BsHaNcw0Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7269
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_01,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180038
X-Proofpoint-ORIG-GUID: l3jWM3rlCtvQ-pm2Mhzq4fIm8vhAS6f0
X-Proofpoint-GUID: l3jWM3rlCtvQ-pm2Mhzq4fIm8vhAS6f0
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
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

CgpPbiAxMC8xNi8yMDIzIDc6MzUgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4gT24gVHVlLCBPY3Qg
MTcsIDIwMjMgYXQgNDozMOKAr0FNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4g
d3JvdGU6Cj4+Cj4+Cj4+IE9uIDEwLzE2LzIwMjMgNDoyOCBBTSwgRXVnZW5pbyBQZXJleiBNYXJ0
aW4gd3JvdGU6Cj4+PiBPbiBNb24sIE9jdCAxNiwgMjAyMyBhdCA4OjMz4oCvQU0gSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4gT24gRnJpLCBPY3QgMTMsIDIwMjMg
YXQgMzozNuKAr1BNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4+
Pj4+Cj4+Pj4+IE9uIDEwLzEyLzIwMjMgODowMSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+
IE9uIFR1ZSwgT2N0IDEwLCAyMDIzIGF0IDU6MDXigK9QTSBTaS1XZWkgTGl1IDxzaS13ZWkubGl1
QG9yYWNsZS5jb20+IHdyb3RlOgo+Pj4+Pj4+IERldmljZXMgd2l0aCBvbi1jaGlwIElPTU1VIG9y
IHZlbmRvciBzcGVjaWZpYyBJT1RMQiBpbXBsZW1lbnRhdGlvbgo+Pj4+Pj4+IG1heSBuZWVkIHRv
IHJlc3RvcmUgaW90bGIgbWFwcGluZyB0byB0aGUgaW5pdGlhbCBvciBkZWZhdWx0IHN0YXRlCj4+
Pj4+Pj4gdXNpbmcgdGhlIC5yZXNldF9tYXAgb3AsIGFzIGl0J3MgZGVzaXJhYmxlIGZvciBzb21l
IHBhcmVudCBkZXZpY2VzCj4+Pj4+Pj4gdG8gc29sZWx5IG1hbmlwdWxhdGUgbWFwcGluZ3MgYnkg
aXRzIG93biwgaW5kZXBlbmRlbnQgb2YgdmlydGlvIGRldmljZQo+Pj4+Pj4+IHN0YXRlLiBGb3Ig
aW5zdGFuY2UsIGRldmljZSByZXNldCBkb2VzIG5vdCBjYXVzZSBtYXBwaW5nIGdvIGF3YXkgb24K
Pj4+Pj4+PiBzdWNoIElPVExCIG1vZGVsIGluIG5lZWQgb2YgcGVyc2lzdGVudCBtYXBwaW5nLiBC
ZWZvcmUgdmhvc3QtdmRwYQo+Pj4+Pj4+IGlzIGdvaW5nIGF3YXksIGdpdmUgdGhlbSBhIGNoYW5j
ZSB0byByZXNldCBpb3RsYiBiYWNrIHRvIHRoZSBpbml0aWFsCj4+Pj4+Pj4gc3RhdGUgaW4gdmhv
c3RfdmRwYV9jbGVhbnVwKCkuCj4+Pj4+Pj4KPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkg
TGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4gICAgIGRyaXZl
cnMvdmhvc3QvdmRwYS5jIHwgMTYgKysrKysrKysrKysrKysrKwo+Pj4+Pj4+ICAgICAxIGZpbGUg
Y2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQo+Pj4+Pj4+Cj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+Pj4+PiBpbmRleCA4
NTE1MzVmLi5hM2Y4MTYwIDEwMDY0NAo+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5j
Cj4+Pj4+Pj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+Pj4+PiBAQCAtMTMxLDYgKzEz
MSwxNSBAQCBzdGF0aWMgc3RydWN0IHZob3N0X3ZkcGFfYXMgKnZob3N0X3ZkcGFfZmluZF9hbGxv
Y19hcyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4+Pj4+PiAgICAgICAgICAgIHJldHVybiB2aG9z
dF92ZHBhX2FsbG9jX2FzKHYsIGFzaWQpOwo+Pj4+Pj4+ICAgICB9Cj4+Pj4+Pj4KPj4+Pj4+PiAr
c3RhdGljIHZvaWQgdmhvc3RfdmRwYV9yZXNldF9tYXAoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHUz
MiBhc2lkKQo+Pj4+Pj4+ICt7Cj4+Pj4+Pj4gKyAgICAgICBzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
cGEgPSB2LT52ZHBhOwo+Pj4+Pj4+ICsgICAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29w
cyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+Pj4+Pj4+ICsKPj4+Pj4+PiArICAgICAgIGlmIChvcHMt
PnJlc2V0X21hcCkKPj4+Pj4+PiArICAgICAgICAgICAgICAgb3BzLT5yZXNldF9tYXAodmRwYSwg
YXNpZCk7Cj4+Pj4+Pj4gK30KPj4+Pj4+PiArCj4+Pj4+Pj4gICAgIHN0YXRpYyBpbnQgdmhvc3Rf
dmRwYV9yZW1vdmVfYXMoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHUzMiBhc2lkKQo+Pj4+Pj4+ICAg
ICB7Cj4+Pj4+Pj4gICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdmRwYV9hcyAqYXMgPSBhc2lkX3Rv
X2FzKHYsIGFzaWQpOwo+Pj4+Pj4+IEBAIC0xNDAsNiArMTQ5LDEzIEBAIHN0YXRpYyBpbnQgdmhv
c3RfdmRwYV9yZW1vdmVfYXMoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHUzMiBhc2lkKQo+Pj4+Pj4+
Cj4+Pj4+Pj4gICAgICAgICAgICBobGlzdF9kZWwoJmFzLT5oYXNoX2xpbmspOwo+Pj4+Pj4+ICAg
ICAgICAgICAgdmhvc3RfdmRwYV9pb3RsYl91bm1hcCh2LCAmYXMtPmlvdGxiLCAwVUxMLCAwVUxM
IC0gMSwgYXNpZCk7Cj4+Pj4+Pj4gKyAgICAgICAvKgo+Pj4+Pj4+ICsgICAgICAgICogRGV2aWNl
cyB3aXRoIHZlbmRvciBzcGVjaWZpYyBJT01NVSBtYXkgbmVlZCB0byByZXN0b3JlCj4+Pj4+Pj4g
KyAgICAgICAgKiBpb3RsYiB0byB0aGUgaW5pdGlhbCBvciBkZWZhdWx0IHN0YXRlIHdoaWNoIGlz
IG5vdCBkb25lCj4+Pj4+Pj4gKyAgICAgICAgKiB0aHJvdWdoIGRldmljZSByZXNldCwgYXMgdGhl
IElPVExCIG1hcHBpbmcgbWFuaXB1bGF0aW9uCj4+Pj4+Pj4gKyAgICAgICAgKiBjb3VsZCBiZSBk
ZWNvdXBsZWQgZnJvbSB0aGUgdmlydGlvIGRldmljZSBsaWZlIGN5Y2xlLgo+Pj4+Pj4+ICsgICAg
ICAgICovCj4+Pj4+PiBTaG91bGQgd2UgZG8gdGhpcyBhY2NvcmRpbmcgdG8gd2hldGhlciBJT1RM
Ql9QUkVTSVNUIGlzIHNldD8KPj4+Pj4gV2VsbCwgaW4gdGhlb3J5IHRoaXMgc2VlbXMgbGlrZSBz
byBidXQgaXQncyB1bm5lY2Vzc2FyeSBjb2RlIGNoYW5nZQo+Pj4+PiBhY3R1YWxseSwgYXMgdGhh
dCBpcyB0aGUgd2F5IGhvdyB2RFBBIHBhcmVudCBiZWhpbmQgcGxhdGZvcm0gSU9NTVUgd29ya3MK
Pj4+Pj4gdG9kYXksIGFuZCB1c2Vyc3BhY2UgZG9lc24ndCBicmVhayBhcyBvZiB0b2RheS4gOikK
Pj4+PiBXZWxsLCB0aGlzIGlzIG9uZSBxdWVzdGlvbiBJJ3ZlIGV2ZXIgYXNrZWQgYmVmb3JlLiBZ
b3UgaGF2ZSBleHBsYWluZWQKPj4+PiB0aGF0IG9uZSBvZiB0aGUgcmVhc29uIHRoYXQgd2UgZG9u
J3QgYnJlYWsgdXNlcnNwYWNlIGlzIHRoYXQgdGhleSBtYXkKPj4+PiBjb3VwbGUgSU9UTEIgcmVz
ZXQgd2l0aCB2RFBBIHJlc2V0IGFzIHdlbGwuIE9uZSBleGFtcGxlIGlzIHRoZSBRZW11Lgo+Pj4+
Cj4+Pj4+IEFzIGV4cGxhaW5lZCBpbiBwcmV2aW91cyB0aHJlYWRzIFsxXVsyXSwgd2hlbiBJT1RM
Ql9QRVJTSVNUIGlzIG5vdCBzZXQKPj4+Pj4gaXQgZG9lc24ndCBuZWNlc3NhcmlseSBtZWFuIHRo
ZSBpb3RsYiB3aWxsIGRlZmluaXRlbHkgYmUgZGVzdHJveWVkCj4+Pj4+IGFjcm9zcyByZXNldCAo
dGhpbmsgYWJvdXQgdGhlIHBsYXRmb3JtIElPTU1VIGNhc2UpLCBzbyB1c2Vyc3BhY2UgdG9kYXkK
Pj4+Pj4gaXMgYWxyZWFkeSB0b2xlcmF0aW5nIGVub3VnaCB3aXRoIGVpdGhlciBnb29kIG9yIGJh
ZCBJT01NVS4KPiBJJ20gY29uZnVzZWQsIGhvdyB0byBkZWZpbmUgdG9sZXJhdGluZyBoZXJlPwoK
VG9sZXJhdGluZyBkZWZpbmVkIGFzIFFFTVUgaGFzIHRvIHByb2FjdGl2ZWx5IHVubWFwIGJlZm9y
ZSByZXNldCBqdXN0IHRvIAp3b3JrYXJvdW5kIHRoZSBkcml2ZXIgYnVnIChvbi1jaGlwIG1hcHMg
b3V0IG9mIHN5bmMpLCB1bmNvbmRpdGlvbmFsbHkgCmZvciBwbGF0Zm9ybSBvciBvbi1jaGlwLiBX
aGlsZSB3ZSBhbGwga25vdyBpdCBkb2Vzbid0IGhhdmUgdG8gZG8gc28gZm9yIApwbGF0Zm9ybSBJ
T01NVSwgdGhvdWdoIHVzZXJzcGFjZSBoYXMgbm8gbWVhbnMgdG8gZGlzdGluZ3Vpc2guIFRoYXQg
c2FpZCwgCnVzZXJzcGFjZSBpcyBzYWNyaWZpY2luZyByZXNldCB0aW1lIHBlcmZvcm1hbmNlIG9u
IHBsYXRmb3JtIElPTU1VIHNldHVwIApqdXN0IGZvciB3b3JraW5nIGFyb3VuZCBidWdneSBpbXBs
ZW1lbnRhdGlvbiBpbiB0aGUgb3RoZXIgc2V0dXAuCgo+IEZvciBleGFtcGxlLCBpZiBpdCBoYXMg
dG9sZXJhbmNlLCB3aHkgYm90aGVyPwpJJ20gbm90IHN1cmUgSSBnZXQgdGhlIHF1ZXN0aW9uLiBC
dXQgSSB0aGluayB1c2Vyc3BhY2UgaXMgY29tcHJvbWlzaW5nIApiZWNhdXNlIG9mIGJ1Z2d5IGlt
cGxlbWVudGF0aW9uIGluIGEgZmV3IGRyaXZlcnMgZG9lc24ndCBtZWFuIHdlIHNob3VsZCAKdW5p
Zm9ybWx5IGVuZm9yY2Ugc3VjaCBiZWhhdmlvciBmb3IgYWxsIHNldF9tYXAvZG1hX21hcCBpbXBs
ZW1lbnRhdGlvbnMuCgo+Cj4+Pj4gVGhpcyBjb2RlIG9mCj4+Pj4+IG5vdCBjaGVja2luZyBJT1RM
Ql9QRVJTSVNUIGJlaW5nIHNldCBpcyBpbnRlbnRpb25hbCwgdGhlcmUncyBubyBwb2ludCB0bwo+
Pj4+PiBlbXVsYXRlIGJhZCBJT01NVSBiZWhhdmlvciBldmVuIGZvciBvbGRlciB1c2Vyc3BhY2Ug
KHdpdGggaW1wcm9wZXIKPj4+Pj4gZW11bGF0aW9uIHRvIGJlIGRvbmUgaXQgd291bGQgcmVzdWx0
IGluIGV2ZW4gd29yc2UgcGVyZm9ybWFuY2UpLgo+IEkgY2FuIGVhc2lseSBpbWFnaW5lIGEgY2Fz
ZToKPgo+IFRoZSBvbGQgUWVtdSB0aGF0IHdvcmtzIG9ubHkgd2l0aCBhIHNldHVwIGxpa2UgbWx4
NV92ZHBhLgpOb3RlZCwgc2VlbXMgdG8gbWUgdGhlcmUncyBubyBzdWNoIGNhc2Ugb2YgYSB1c2Vy
c3BhY2UgaW1wbGVtZW50YXRpb24gCnRoYXQgb25seSB3b3JrcyB3aXRoIG1seDVfdmRwYSBvciBp
dHMgZnJpZW5kcywgYnV0IGRvZXNuJ3Qgd29yayB3aXRoIHRoZSAKb3RoZXJzIGUuZy4gcGxhdGZv
cm0gSU9NTVUsIG9yIHdlbGwgYmVoYXZpbmcgb24tY2hpcCBJT01NVSAKaW1wbGVtZW50YXRpb25z
LiBUaGUgVW5tYXArcmVtYXAgdHJpY2sgYXJvdW5kIHZkcGEgcmVzZXQgd29ya3MgdG90YWxseSAK
ZmluZSBmb3LCoHBsYXRmb3JtIElPTU1VLCBleGNlcHQgd2l0aCBzdWItb3B0aW1hbCBwZXJmb3Jt
YW5jZS4gT3RoZXIgdGhhbiAKdGhpcyB0cmljaywgSSBjYW5ub3QgZWFzaWx5IHRoaW5rIG9mIG90
aGVyIG1lYW5zIG9yIGlvdGxiIG1lc3NhZ2UgCnNlcXVlbmNlIGZvciB1c2Vyc3BhY2UgdG8gcmVj
b3ZlciB0aGUgYm9ndXMgc3RhdGUgYW5kIG1ha2UgaW90bGIgYmFjayB0byAKd29yayBhZ2FpbiBh
ZnRlciByZXNldC4gQXJlIHdlIHRhbGtpbmcgYWJvdXQgaHlwbm9zaXMgdGhhdCBoYXMgbm8gcmVh
bCAKYmFzaXMgdG8gZXhpc3QgaW4gdGhlIHJlYWwgd29ybGQ/Cgo+ICAgSWYgd2UgZG8KPiB0aGlz
IHdpdGhvdXQgYSBuZWdvdGlhdGlvbiwgSU9UTEIgd2lsbCBub3QgYmUgY2xlYXIgYnV0IHRoZSBR
ZW11IHdpbGwKPiB0cnkgdG8gcmUtcHJvZ3JhbSB0aGUgSU9UTEIgYWZ0ZXIgcmVzZXQuIFdoaWNo
IHdpbGwgYnJlYWs/Cj4KPiAxKSBzdGljayB0aGUgZXhhY3Qgb2xkIGJlaGF2aW91ciB3aXRoIGp1
c3Qgb25lIGxpbmUgb2YgY2hlY2sKSXQncyBub3QganVzdCBvbmUgbGluZSBvZiBjaGVjayBoZXJl
LCB0aGUgb2xkIGJlaGF2aW9yIGVtdWxhdGlvbiBoYXMgdG8gCmJlIGRvbmUgYXMgRXVnZW5pbyBp
bGx1c3RyYXRlZCBpbiB0aGUgb3RoZXIgZW1haWwuIEluIGFkZGl0aW9uLCB0aGUgCmVtdWxhdGlv
biBoYXMgdG8gbGltaXQgdG8gdGhvc2UgYnVnZ3kgZHJpdmVycyBhcyBJIGRvbid0IGZlZWwgdGhp
cyAKZW11bGF0aW9uIHNob3VsZCBhcHBseSB1bmlmb3JtbHkgdG8gYWxsIGZ1dHVyZSBzZXRfbWFw
L2RtYV9tYXAgCmltcGxlbWVudGF0aW9ucy4KPiAyKSBhdWRpdCBhbGwgdGhlIHBvc3NpYmxlIGNh
c2VzIHRvIGF2b2lkIGEgb25lIGxpbmUgb2YgY29kZQo+Cj4gMSkgc2VlbXMgbXVjaCBlYXNpZXIg
dGhhbiAyKQpZb3Ugc2VlIGl0J3MgbW9yZSB0aGFuIGp1c3Qgb25lIGxpbmUgb2YgY29kZSwgYW5k
IEknbSB1bmNlcnRhaW4gaWYgdGhlIAphZGRpdGlvbmFsIGNvbXBsZXhpdHkgaXMgd2FycmFudGVk
IG9yIG5lY2Vzc2FyeSwgcGFydGljdWxhcmx5IGlmIGFkZGVkIAp0aGlzIHBpZWNlIG9mIGNvbXBh
dGliaWxpdHkgY29kZSB3aWxsIGxpbmdlciBmb3IgcXVpdGUgYSBsb25nIHRpbWUuIApJbnN0ZWFk
IG9mIGFkZGluZyBoeXBvdGhldGljYWwgY29kZSBjaGFuZ2UgZm9yIG5vIHNwZWNpZmljIGdvb2Qg
cmVhc29uIAphbmQgbm8gcmVhbCB1c2UgY2FzZSwgSSdkIGxpa2UgdG8gYWRkIHRoZSBjb2RlIHdo
ZW4gd2UgZmluZCBvdXQgYSAKc3BlY2lmaWMgdXNlIGNhc2UgdGhhdCBtYXkgZ2V0IGltcGFjdGVk
IG9yIGFscmVhZHkgYmVpbmcgYWZmZWN0ZWQsIHRoZW4gCndlIHdpbGwgaGF2ZSBnb29kIHVuZGVy
c3RhbmRpbmcgaG93IHRvIGNvZGUgdXAgdGhlIGZpeCBhbmQgZW11bGF0ZSAKcHJvcGVybHkgZm9y
IGNvbXBhdGliaWxpdHksIHdoaWxlIG5vdCBhZmZlY3Rpbmcgb3RoZXIgZ29vZCBpbXBsZW1lbnRh
dGlvbnMuCgpUaGFua3MsCi1TaXdlL2kvCgo+Cj4+Pj4gRm9yIHR3byByZWFzb25zOgo+Pj4+Cj4+
Pj4gMSkgYmFja2VuZCBmZWF0dXJlcyBuZWVkIGFja2VkIGJ5IHVzZXJzcGFjZSB0aGlzIGlzIGJ5
IGRlc2lnbgo+Pj4+IDIpIGtlZXAgdGhlIG9kZCBiZWhhdmlvdXIgc2VlbXMgdG8gYmUgbW9yZSBz
YWZlIGFzIHdlIGNhbid0IGF1ZGl0Cj4+Pj4gZXZlcnkgdXNlcnNwYWNlIHByb2dyYW0KPj4+Pgo+
Pj4gVGhlIG9sZCBiZWhhdmlvciAod2l0aG91dCBmbGFnIGFjaykgY2Fubm90IGJlIHRydXN0ZWQg
YWxyZWFkeSwgYXM6Cj4gUG9zc2libHkgYnV0IHRoZSBwb2ludCBpcyB0byB1bmJyZWFrIHVzZXJz
cGFjZSBubyBtYXR0ZXIgaG93IHdlaXJkIHRoZQo+IGJlaGF2aW91ciB3ZSd2ZSBldmVyIGhhZC4K
Pgo+Pj4gKiBEZXZpY2VzIHVzaW5nIHBsYXRmb3JtIElPTU1VIChpbiBvdGhlciB3b3Jkcywgbm90
IGltcGxlbWVudGluZwo+Pj4gbmVpdGhlciAuc2V0X21hcCBub3IgLmRtYV9tYXApIGRvZXMgbm90
IHVubWFwIG1lbW9yeSBhdCB2aXJ0aW8gcmVzZXQuCj4+PiAqIERldmljZXMgdGhhdCBpbXBsZW1l
bnQgLnNldF9tYXAgb3IgLmRtYV9tYXAgKHZkcGFfc2ltLCBtbHg1KSBkbwo+Pj4gcmVzZXQgSU9U
TEIsIGJ1dCBpbiB0aGVpciBwYXJlbnQgb3BzICh2ZHBhc2ltX2RvX3Jlc2V0LCBwcnVuZV9pb3Rs
Ygo+Pj4gY2FsbGVkIGZyb20gbWx4NV92ZHBhX3Jlc2V0KS4gV2l0aCB2ZHBhX3NpbSBwYXRjaCBy
ZW1vdmluZyB0aGUgcmVzZXQsCj4+PiBub3cgYWxsIGJhY2tlbmRzIHdvcmsgdGhlIHNhbWUgYXMg
ZmFyIGFzIEkga25vdy4sIHdoaWNoIHdhcyAoYW5kIGlzKQo+Pj4gdGhlIHdheSBkZXZpY2VzIHVz
aW5nIHRoZSBwbGF0Zm9ybSBJT01NVSB3b3Jrcy4KPj4+Cj4+PiBUaGUgZGlmZmVyZW5jZSBpbiBi
ZWhhdmlvciBkaWQgbm90IG1hdHRlciBhcyBRRU1VIHVubWFwcyBhbGwgdGhlCj4+PiBtZW1vcnkg
dW5yZWdpc3RlcmluZyB0aGUgbWVtb3J5IGxpc3RlbmVyIGF0IHZob3N0X3ZkcGFfZGV2X3N0YXJ0
KC4uLiwKPj4+IHN0YXJ0ZWQgPSBmYWxzZSksCj4+IEV4YWN0bHkuIEl0J3Mgbm90IGp1c3QgUUVN
VSwgYnV0IGFueSAob2xkZXIpIHVzZXJzcGFjZSBtYW5pcHVsYXRlcwo+PiBtYXBwaW5ncyB0aHJv
dWdoIHRoZSB2aG9zdC12ZHBhIGlvdGxiIGludGVyZmFjZSBoYXMgdG8gdW5tYXAgYWxsCj4+IG1h
cHBpbmdzIHRvIHdvcmthcm91bmQgdGhlIHZkcGEgcGFyZW50IGRyaXZlciBidWcuCj4gSnVzdCB0
byBjbGFyaWZ5LCBmcm9tIHVzZXJzcGFjZSwgaXQncyB0aGUgKG9kZCkgYmVoYXZpb3VyIG9mIHRo
ZSBjdXJyZW50IHVBUEkuCj4KPj4gSWYgdGhleSBkb24ndCBkbwo+PiBleHBsaWNpdCB1bm1hcCwg
aXQgd291bGQgY2F1c2Ugc3RhdGUgaW5jb25zaXN0ZW5jeSBiZXR3ZWVuIHZob3N0LXZkcGEKPj4g
YW5kIHBhcmVudCBkcml2ZXIsIHRoZW4gb2xkIG1hcHBpbmdzIGNhbid0IGJlIHJlc3RvcmVkLCBh
bmQgbmV3IG1hcHBpbmcKPj4gY2FuIGJlIGFkZGVkIHRvIGlvdGxiIGFmdGVyIHZEUEEgcmVzZXQu
IFRoZXJlJ3Mgbm8gcG9pbnQgdG8gcHJlc2VydmUKPj4gdGhpcyBicm9rZW4gYW5kIGluY29uc2lz
dGVudCBiZWhhdmlvciBiZXR3ZWVuIHZob3N0LXZkcGEgYW5kIHBhcmVudAo+PiBkcml2ZXIsIGFz
IHVzZXJzcGFjZSBkb2Vzbid0IGNhcmUgYXQgYWxsIQo+IEl0J3MgYSB1c2Vyc3BhY2Ugbm90aWNl
IGNoYW5nZSBzbyB3ZSBjYW4ndCBmaXggaXQgc2lsZW50bHk6Cj4KPiBodHRwczovL2xrbWwub3Jn
L2xrbWwvMjAxMi8xMi8yMy83NQo+Cj4gQW5vdGhlciBleGFtcGxlIHdoaWNoIGlzIHJlbGF0ZWQg
dG8gdmhvc3QtdkRQQToKPgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDIzMDky
NzE0MDU0NC4yMDUwODgtMS1lcmljLmF1Z2VyQHJlZGhhdC5jb20vVC8KPgo+IFRoYW5rcwo+Cj4+
PiBidXQgdGhlIGJhY2tlbmQgYWNrbm93bGVkZ2luZyB0aGlzIGZlYXR1cmUgZmxhZwo+Pj4gYWxs
b3dzIFFFTVUgdG8gbWFrZSBzdXJlIGl0IGlzIHNhZmUgdG8gc2tpcCB0aGlzIHVubWFwICYgbWFw
IGluIHRoZQo+Pj4gY2FzZSBvZiB2aG9zdCBzdG9wICYgc3RhcnQgY3ljbGUuCj4+Pgo+Pj4gSW4g
dGhhdCBzZW5zZSwgdGhpcyBmZWF0dXJlIGZsYWcgaXMgYWN0dWFsbHkgYSBzaWduYWwgZm9yIHVz
ZXJzcGFjZSB0bwo+Pj4ga25vdyB0aGF0IHRoZSBidWcgaGFzIGJlZW4gc29sdmVkLgo+PiBSaWdo
dCwgSSBjb3VsZG4ndCBzYXkgaXQgYmV0dGVyIHRoYW4geW91IGRvLCB0aGFua3MhIFRoZSBmZWF0
dXJlIGZsYWcgaXMKPj4gbW9yZSBvZiBhbiB1bnVzdWFsIG1lYW5zIHRvIGluZGljYXRpbmcga2Vy
bmVsIGJ1ZyBoYXZpbmcgYmVlbiBmaXhlZCwKPj4gcmF0aGVyIHRoYW4gaW50cm9kdWNlIGEgbmV3
IGZlYXR1cmUgb3IgbmV3IGtlcm5lbCBiZWhhdmlvciBlbmRpbmcgdXAgaW4KPj4gY2hhbmdlIG9m
IHVzZXJzcGFjZSdzIGV4cGVjdGF0aW9uLgo+Pgo+Pj4gTm90IG9mZmVyaW5nIGl0IGluZGljYXRl
cyB0aGF0Cj4+PiB1c2Vyc3BhY2UgY2Fubm90IHRydXN0IHRoZSBrZXJuZWwgd2lsbCByZXRhaW4g
dGhlIG1hcHMuCj4+Pgo+Pj4gU2ktV2VpIG9yIERyYWdvcywgcGxlYXNlIGNvcnJlY3QgbWUgaWYg
SSd2ZSBtaXNzZWQgc29tZXRoaW5nLiBGZWVsCj4+PiBmcmVlIHRvIHVzZSB0aGUgdGV4dCBpbiBj
YXNlIHlvdSBmaW5kIG1vcmUgY2xlYXIgaW4gZG9jIG9yIHBhdGNoIGxvZy4KPj4gU3VyZSwgd2ls
bCBkbywgdGhhbmsgeW91ISBXaWxsIHBvc3QgdjIgYWRkaW5nIHRoZXNlIHRvIHRoZSBsb2cuCj4+
Cj4+IFRoYW5rcywKPj4gLVNpd2VpCj4+Cj4+Cj4+Cj4+PiBUaGFua3MhCj4+Pgo+Pj4+IFRoYW5r
cwo+Pj4+Cj4+Pj4+IEkgdGhpbmsKPj4+Pj4gdGhlIHB1cnBvc2Ugb2YgdGhlIElPVExCX1BFUlNJ
U1QgZmxhZyBpcyBqdXN0IHRvIGdpdmUgdXNlcnNwYWNlIDEwMCUKPj4+Pj4gY2VydGFpbnR5IG9m
IHBlcnNpc3RlbnQgaW90bGIgbWFwcGluZyBub3QgZ2V0dGluZyBsb3N0IGFjcm9zcyB2ZHBhIHJl
c2V0Lgo+Pj4+Pgo+Pj4+PiBUaGFua3MsCj4+Pj4+IC1TaXdlaQo+Pj4+Pgo+Pj4+PiBbMV0KPj4+
Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdmlydHVhbGl6YXRpb24vOWYxMThmYzktNGY2Zi1k
ZDY3LWEyOTEtYmU3ODE1MmU0N2ZkQG9yYWNsZS5jb20vCj4+Pj4+IFsyXQo+Pj4+PiBodHRwczov
L2xvcmUua2VybmVsLm9yZy92aXJ0dWFsaXphdGlvbi8zMzY0YWRmZC0xZWI3LThiY2UtNDFmOS1i
ZmU1NDczZjFmMmVAb3JhY2xlLmNvbS8KPj4+Pj4+ICAgICBPdGhlcndpc2UKPj4+Pj4+IHdlIG1h
eSBicmVhayBvbGQgdXNlcnNwYWNlLgo+Pj4+Pj4KPj4+Pj4+IFRoYW5rcwo+Pj4+Pj4KPj4+Pj4+
PiArICAgICAgIHZob3N0X3ZkcGFfcmVzZXRfbWFwKHYsIGFzaWQpOwo+Pj4+Pj4+ICAgICAgICAg
ICAga2ZyZWUoYXMpOwo+Pj4+Pj4+Cj4+Pj4+Pj4gICAgICAgICAgICByZXR1cm4gMDsKPj4+Pj4+
PiAtLQo+Pj4+Pj4+IDEuOC4zLjEKPj4+Pj4+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
