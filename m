Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67410C4167B
	for <virtualization@archiver.kernel.org>; Mon, 30 Oct 2023 17:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F151941828;
	Mon, 30 Oct 2023 17:56:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F151941828
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=znPj6Kl1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=aF6BimXY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b33v6-0P3AZ4; Mon, 30 Oct 2023 17:56:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 25D0A417C6;
	Mon, 30 Oct 2023 17:56:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25D0A417C6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE12CC0071;
	Mon, 30 Oct 2023 17:56:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BF5DC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 17:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D3DD660AFE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 17:56:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D3DD660AFE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=znPj6Kl1; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=aF6BimXY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13FFFxSFWyOg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 17:56:08 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 581E260AFB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 17:56:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 581E260AFB
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39UHOHwd017042; Mon, 30 Oct 2023 17:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=H6/B0ub6FyeKNFXCx/pDDjqJY/isspAriWRvDNlvYfg=;
 b=znPj6Kl1otpRKnxzZknFRGXhJjgLvfq6lw8oIZ+a4z+QA+/oj4x/kV9uisTipkTKVsLw
 mZJB30uB2a2RkVrjbr6dIyaQPqMJ1V0jhc2ECt3x20dX6V7/dAlF4QW0FeqaCA+ThpEJ
 IvQID2ePh8lCn2AY7NN0ITI7F7UKcaPGO9iSsSDwZQf4bo9euab3bOWMQEHlX7leUhQR
 n0yElqNTYTeXepLbw0uISz4t6njBkJIJGJsQkuPRpaXviZuZlGP5MqSJg5zg0gvIaRk9
 iPTDjhsD6PuJAKvqC0Aisp6JWut9HF83MskbGukQ3di6/V4wTr7lCRqcn/FTD9xws5xq hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rqduds2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Oct 2023 17:55:48 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39UHNpiZ001008; Mon, 30 Oct 2023 17:55:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3u0rr4yqp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Oct 2023 17:55:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xwz+Wnv1xvSflArHYts3z1ZufzmEJx/VOdQbF8N8WZt6KrnhI6iSxe2kFL6Cf5EMmv7o/2yXzhNXKNYEaIj4GTwVX+5UHZ9c9bDyoPRDF/v6T2Khu7Wi32eZ0v9bLycW76gmBiDJga6GKbr2oLo8xwKH3+OFb5cd6R5vCKKe+wlusClY/dA4RNbjfsNzNn+C72wb4TjWAPW6BGSaFaXefAfAiZt6QafjETJu2+jaOTGoWpMEQGTjggOYvMK5rGMxcVGpVnmEmlekQsuGrXtNy9Nsgz3n2GXJipFawFTb0ODA7J7KOve6qYdPdddZbprGpft82z21ZK+O96lRKtBbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6/B0ub6FyeKNFXCx/pDDjqJY/isspAriWRvDNlvYfg=;
 b=cuTWrLeld08GuWnEHZ0qukpSVgS/juqcnrzNqIeq9Ys3jAnURfZfUj4oPX7fgxOSCd3mxNY5D2RBvSu3A9LK+q3iII/PfdhjchxUc64seZHBEo8s1wea2zOSXvb7/bZ0KGBK4j+3+PCCKr9RZ5lB1SQXbPLKQPhwjPjHpvVfp8OtG0KQPfSkLYS9fvT8C2yngiiNew6xwN3ql1yW/R+3H0b6KmquaYCW17Cm783o7hjVZCXWR/Z7xaqTXwIwpg+pMMhxzSWuqcftR+KBJZB7XD0OGKyPg6GIgXW5TotdDw1JvyZGBOG8hFDk6MHJ4q/eZbm5q5zGrVZcuttYbX0jLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6/B0ub6FyeKNFXCx/pDDjqJY/isspAriWRvDNlvYfg=;
 b=aF6BimXYwOkyXSc1tnPj0HsgDARQ912bXoVjvdWJRhqpoy7O1pLKJanlUGWYEKGrKtI+x20QNsQmftSjCgLkFRzvoxq1QnAwQxsIt+8zShd3KJYUW7YIHGjcZOVxoLPBFMmUE4mPsVlN4QN2HLxFNO2e9jEqsDLz+HQgajly4sY=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA2PR10MB4764.namprd10.prod.outlook.com (2603:10b6:806:115::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 30 Oct
 2023 17:55:40 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.6933.022; Mon, 30 Oct 2023
 17:55:39 +0000
Message-ID: <6fec5512-66fb-4d94-b225-1351e6d5e8cb@oracle.com>
Date: Mon, 30 Oct 2023 13:55:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] vdpa/mlx5: preserve CVQ vringh index
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <1698350834-415881-1-git-send-email-steven.sistare@oracle.com>
 <CAJaqyWc59oRS86sygnUR-D-wQ-N2TbofsG1hxAmCiGwkb4y42A@mail.gmail.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWc59oRS86sygnUR-D-wQ-N2TbofsG1hxAmCiGwkb4y42A@mail.gmail.com>
X-ClientProxiedBy: BYAPR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:74::29) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA2PR10MB4764:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe7463f-e64a-4ef3-93a0-08dbd9716d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjqvbnpQ43n+3phmmrXXxBsS8dlLRK5rPm7ap+LVSwEyqiVtWPBNhaLB4HalLZZ0N2yn4woacYtpTYrEs3n38yHEtvPdzIR2DvF9WkpUKoZMcQ7oruJ1so2oyFJgi4bU5NKgSm6yfetL+G6G+37DNuroLP/yA6mkjhRJcNLjXpm7l6IWemViWfpOcfZywsR+bjQVF3LUl26yfAMO+oJB0H998F+Hoqr8ba/6rG4JVMcvAXrswz7+tJD959LjeoQ+gxVCKRNbGqdUub3nE5Y+yeNlfrq9AYZ3WTsFM9iK7O0sFVC+bLzqcb1iZVFy+lQ+boZBSK53jJGSxXDOx80Dc6OxetgzewHYnJwBLDCV+qOZMAzg5esqk+aADl4epIs6Os6cx/7NiJRMWFnfMZxDs864i6dyoYSrt7RPZh5TiBNerBF9Rb0uPOwjtusVnDrL/DFRVYLGy68n0l554YP6OdZLZKh4tWXEnp6rurlvvXt1nvdX+txQn/Tlm3MKcUXt0/gg/qDEO+6empldPESu67VG+quw6bPKR6y26DQqM5TyZ5u8jE0/Ko7WP4oAs+/jsHLlrXK1IfaoiUHSdV23uLT35yf20aIJXrU0+SWGVTfo8ByeISo94KTyXcCnwSwByUhNzmFxys5diRJOcp6/F6aSS0qMpxKhNKtOe6gbfpfYSpSht+Z8uQGotTAh/xBZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(478600001)(6486002)(8676002)(6666004)(6506007)(966005)(36916002)(83380400001)(53546011)(26005)(2616005)(6512007)(41300700001)(316002)(66556008)(66946007)(66476007)(6916009)(54906003)(31686004)(38100700002)(8936002)(5660300002)(31696002)(2906002)(36756003)(44832011)(4326008)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUFVckNjbnpITldKTTBNSGt3dm53MHlOTC8vQ3lQd1lTK1RyQ3RZVkk5M2ZQ?=
 =?utf-8?B?RCtEUTJQSGIvbVRNYi8xYWNmMmw3NCtYVnB3b0RjWEwzNFNtSE5QdDExUUJ5?=
 =?utf-8?B?Z2lkVkNaems3dFBGL2I0UzlBeG56cEd2UURUQlhiekZMa2Y3S2dYT3hqK1VT?=
 =?utf-8?B?MWF0MnpZZUVFbnFTWFdIYVJ0STBqcnh4VmpRanNVTHBqaG1OK3VTU2YxUlF4?=
 =?utf-8?B?cUxHSXJibkFpenF5NnA4eGlDKzZBQ0NoN2Mzejh2OU5iZU8yZUU4U0t3eTcv?=
 =?utf-8?B?bVVDV0ZwcVc3cXZXdjk3WjY5eHZPdlRmKzlHMXJVcWpRVHllWTlFb0Q1U1BM?=
 =?utf-8?B?VkFTbG1MTnlKRkRCVUFDalQxYWdncFR5UDFDS1hpK0w3NmZMaTgzYnRRWkxN?=
 =?utf-8?B?b0g2U1l2V2RRa204ZzZlZjFxeGx1YVlXYlVxRVo3TWVNVTdBNTBrRVhsdldN?=
 =?utf-8?B?c3hhRzM5Z3hURWFiNGN5c25BalB4SkNlLzBRQW5QRWFyN2l2a2VaRjkwNmJs?=
 =?utf-8?B?azZpelZ4Ry9mQitEaVFEa05RcGJSQ2tJSi9KZU9IU3NwYlBBTEh2WHI2Q1Jo?=
 =?utf-8?B?MzdqY1owRVBnbFR2aFdUVW9qZ3F3aS9ma0h2M1pxb0xuNStaeUhkTFBXZkhB?=
 =?utf-8?B?dlVCWUFrNTFsSHorVmZKT1FDNnhyc2MrUm9sQ2pOdjR2VElZZUlXYlFZZ2Zq?=
 =?utf-8?B?ZXJNQU14T0hGUEVVRmJPOFcxeVFjVnk0Y0VkQjlURkYrOFlEaHZlT0d2RWZq?=
 =?utf-8?B?REhvUXdSdjd2TWMyRjlUSHREemo2MnpWNXhoeEtseXZlaHR5c1JZWkVPNSsw?=
 =?utf-8?B?VUJFTExUQ1lPQnpZTUZrWjN1WGdDM1BQSFpYS1Ntd0EwTzZSZHlrYWN3Uk5p?=
 =?utf-8?B?M2ZlQ2lwdEpZOGdsdndWRjh1UmowajNmc3JYdmZ0dGlnY3dMYVlnRHozVVhM?=
 =?utf-8?B?aW5uMWVnakxOTHhVMDc0N25mVzczK3ptZjN0SkVibDZ6M0JHaDFEOFY2S0JD?=
 =?utf-8?B?bVB6alFJRUczS1REMzA4Q0xLOFd4eGNUZUhiZmUwc0x4RWh0a0lSYXJJUFBM?=
 =?utf-8?B?QUdLZHJTb3RSWnJocnhXK1hZRklPeUEzeEtJVVpTWUZuZitoOTMxRU1QRjNz?=
 =?utf-8?B?VDFRQ20xUVZ3REtWemNOUWc3TU1OM2ZtSXlDOUU2S1dBbXdwMExqOVlkZDh5?=
 =?utf-8?B?aTdwWm55R1hDV0NZWjVuNmlvSkl1ekZPdlRyeTFWalNnWmlQMmJTVlZDb3dx?=
 =?utf-8?B?V242Y2huZzRHcStUUzk3SGIyTHh0MHM4QVNqMlJNdjZOZnhXZERWelMxSUJH?=
 =?utf-8?B?dkQrNzVlVE4zaUhLMGhHZ0hRRHY2b1IxRHRlcURWRUplOENOZUNNSkJiUnpC?=
 =?utf-8?B?ek9iYnZZUytERUJGSFA0NlhDUnliUWp5SGJ4NTIvKzdQY08yQURkeWVOZGRL?=
 =?utf-8?B?emNCd3ZFaHMxR3RjNFJ0aEp4YkpCdW9WOTkxY3g0cy9lVXl1QUdjWHhXNGxR?=
 =?utf-8?B?NmVsanBoak9xMGVLUEtONVc0dThPT3Y4cTdibDBMK2tCNktJeXQzZWxQVCto?=
 =?utf-8?B?RXU3MzN3VjNEY1hvcXhHT0JBSmR1MkExOVM4THRabitqS1A0RE5kQ2NPcW03?=
 =?utf-8?B?S2J3L0VZU0l2UjJXdmVzNUliTkNaVnFSd0huVkx6R3J0UnBiS0RYSytKNENY?=
 =?utf-8?B?dlYrY2FYNjgvanBXc1pLdEhmT3U2L1h5TDliVmJBVUR3bi91eUh4a0xZcFVN?=
 =?utf-8?B?VTZ2OXhCNVdBak9EQ1IyQnZQaFV1UWhjY3FMaDVUSTNRV2lIWmNDM1M3MzRX?=
 =?utf-8?B?RzV0NWQ5aTJSWDhFRzM4NTFDd1JaQkFqS3lwYjlWWGUxQTJib05PZncxbHBM?=
 =?utf-8?B?cU1WWm4rZnpTaFpWUEsrWXhNRmFZMnRRbWJzb0haWEpXNmdod0R0K1BicVVl?=
 =?utf-8?B?OGNqS01KcGM0b1hQL0h6Wk5LZm9SMitidEE0ZUZHY0NPTVFqdk03b2VRUEQ4?=
 =?utf-8?B?ekRBWFlhODVHZHR6NXQ3MmgzV005TlpHZ1pDbXhCeDNXdWpaUXY5ejVDQlp1?=
 =?utf-8?B?eHpEYWI0U1Z3aWJZdGdwRm90d20rTEdHdmNaZGRWQklyRlowMGFTMEUrMVBT?=
 =?utf-8?B?VmowNmpEZi9kcm9hckQ2WHBpSFU5S2I4UWFiYW1BSDBVNnpjamloQ2g1d0FK?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MjlQekZLcTJkdkkreWlkSUo2OU5OZXplNHBSMWpzYXZsWVREVVBnU2E2Uzlj?=
 =?utf-8?B?bTJGZ21VelhCQVJCR1NBcUZiRUpkOHN2eTVSMmFlR29PdnBCOVUvNUNBRGxi?=
 =?utf-8?B?eDQ4N3BsaVkvWWsvL3RRanhFNWZ0L0VvV2lSbXlRa3NIWnRkelUrNTVmQ1Vw?=
 =?utf-8?B?dFJ0ZHF5SW95WW9MaUQ5SUxTeE1IUzRvL0dkdDE4Zk5PRkdwQ2dEbjBpYWpx?=
 =?utf-8?B?N2piQnBxeHhlWmZrRkpaOEpTZFpHWEdpQzZlRmgvUG90UVIxMnhxWVloNkhG?=
 =?utf-8?B?bTRJV3J2WURRWGhoSFUzME4zVHAzUlZ0RG1XU0VqMkdITHp4eVE1cnovUldi?=
 =?utf-8?B?ZlpuMkFxajY5a1BacHo3LzU5WlF5bXVZWEtZQnNiWXlJekxhd0NhK0wwNnFI?=
 =?utf-8?B?THg5N1lRVldIcXd3aHkwUG4xVXhGemlwT3lWb3RCMEQydmJSR1hHbXZhQWxO?=
 =?utf-8?B?b2Q1WUxmUWdTcTZ6NzdYeXlLNVZMVnVweDR2Z2ZiVnV6aUFvdTE2OEdYZkVJ?=
 =?utf-8?B?ZFhkaVczRVp1T3N1eXBZcitDNENhSVcrdnI3eUUrVmNkdlVlejJKVmMyRWI3?=
 =?utf-8?B?Y0QxRWdONnUvZUg2SG1jTmtKZXByTHdXZUN4b1lsei81STUzaS9VNzhXOTl2?=
 =?utf-8?B?RkpqYkNCQXZwTDhxc3l4amQ1NWFxS1ZRUkMwYyszQWMvL09CZlpvWXJyZzh6?=
 =?utf-8?B?VkhFNTlOdzlqMXk4Rit3V2tGY2oyT2xvdG9mb1dmbjdZVm9pcDhzQXgyb0xa?=
 =?utf-8?B?WWs5clBQR0c2bTN4Uk9pZ095eFRNK0pCUUh5NFRJUUI0SjZ6dDN2UllsMjhi?=
 =?utf-8?B?S2wzR2ZVTlovZ3hBZUdjdVkvR3pSd2ZZSFlTaG9tdkdGOThXUWhHclIyUkd6?=
 =?utf-8?B?ZDVBQlJDVGIyaHpicjhaZG92U29ZZVBjQzI1MnVsOUZBR29hdWJ0VVBrQ1pE?=
 =?utf-8?B?MmUxeEFkS2lsVld0Z1JqZDRkNlBRSlZWSWxXWU9sUEtrWVdKcGt4SlIzOGtL?=
 =?utf-8?B?SmoxemlSN0xxbkJkZ1Rha0lLc05YRFViL3dLYllsSWh2T1RlbXJiTUlDZ0gx?=
 =?utf-8?B?ZDRJaDRlNjBmbnpIVWRpQVV3a1p3K2xFRzJ4OGRiQmx6bGFjRVU2bFFrK2ww?=
 =?utf-8?B?RGM5djA1WXM3bm95WnlGQ1pxMkMzSVFrSElLd3JzYnVTQVI5ei9ndXNGRmFp?=
 =?utf-8?B?RnkzRG9jdHdTL1VCQnJvWFVYbGtJTVVyQjhhWTZPbXlOR3plUFZVcXozYmox?=
 =?utf-8?Q?PGFTCjS5NdzgtIc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe7463f-e64a-4ef3-93a0-08dbd9716d88
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 17:55:39.6569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqcme5xHmFNTU4inuydB16l/lNNwq4TTFA2Z3PJ6wjrTElWT3e/2XkYTTFi/x8dQuh8rB7YfZTJJ6J6eA/RFYovSRgIbpWgq+7igpV3nXDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_11,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300141
X-Proofpoint-ORIG-GUID: fkvzldiBVObLpMSSulEbVRBUUdpVHL3F
X-Proofpoint-GUID: fkvzldiBVObLpMSSulEbVRBUUdpVHL3F
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eli Cohen <elic@nvidia.com>
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

T24gMTAvMzAvMjAyMyAxMToxMiBBTSwgRXVnZW5pbyBQZXJleiBNYXJ0aW4gd3JvdGU6Cj4gT24g
VGh1LCBPY3QgMjYsIDIwMjMgYXQgMTA6MDnigK9QTSBTdGV2ZSBTaXN0YXJlCj4gPHN0ZXZlbi5z
aXN0YXJlQG9yYWNsZS5jb20+IHdyb3RlOgo+Pgo+PiBtbHg1X3ZkcGEgZG9lcyBub3QgcHJlc2Vy
dmUgdXNlcmxhbmQncyB2aWV3IG9mIHZyaW5nIGJhc2UgZm9yIHRoZSBjb250cm9sCj4+IHF1ZXVl
IGluIHRoZSBmb2xsb3dpbmcgc2VxdWVuY2U6Cj4+Cj4+IGlvY3RsIFZIT1NUX1NFVF9WUklOR19C
QVNFCj4+IGlvY3RsIFZIT1NUX1ZEUEFfU0VUX1NUQVRVUyBWSVJUSU9fQ09ORklHX1NfRFJJVkVS
X09LCj4+ICAgbWx4NV92ZHBhX3NldF9zdGF0dXMoKQo+PiAgICAgc2V0dXBfY3ZxX3ZyaW5nKCkK
Pj4gICAgICAgdnJpbmdoX2luaXRfaW90bGIoKQo+PiAgICAgICAgIHZyaW5naF9pbml0X2tlcm4o
KQo+PiAgICAgICAgICAgdnJoLT5sYXN0X2F2YWlsX2lkeCA9IDA7Cj4+IGlvY3RsIFZIT1NUX0dF
VF9WUklOR19CQVNFCj4+Cj4+IFRvIGZpeCwgcmVzdG9yZSB0aGUgdmFsdWUgb2YgY3ZxLT52cmlu
Zy5sYXN0X2F2YWlsX2lkeCBhZnRlciBjYWxsaW5nCj4+IHZyaW5naF9pbml0X2lvdGxiLgo+Pgo+
PiBTaWduZWQtb2ZmLWJ5OiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29t
Pgo+PiAtLS0KPj4gIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8ICA3ICsrKysr
Ky0KPj4gIGRyaXZlcnMvdmhvc3QvdnJpbmdoLmMgICAgICAgICAgICB8IDMwICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKwo+PiAgaW5jbHVkZS9saW51eC92cmluZ2guaCAgICAgICAgICAg
IHwgIDIgKysKPj4gIDMgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+IGluZGV4IDk0NjQ4OGI4OTg5
Zi4uZjY0NzU4MTQzMTE1IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMKPj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+IEBA
IC0yNzk1LDEzICsyNzk1LDE4IEBAIHN0YXRpYyBpbnQgc2V0dXBfY3ZxX3ZyaW5nKHN0cnVjdCBt
bHg1X3ZkcGFfZGV2ICptdmRldikKPj4gICAgICAgICBzdHJ1Y3QgbWx4NV9jb250cm9sX3ZxICpj
dnEgPSAmbXZkZXYtPmN2cTsKPj4gICAgICAgICBpbnQgZXJyID0gMDsKPj4KPj4gLSAgICAgICBp
ZiAobXZkZXYtPmFjdHVhbF9mZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX05FVF9GX0NUUkxfVlEp
KQo+PiArICAgICAgIGlmIChtdmRldi0+YWN0dWFsX2ZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9f
TkVUX0ZfQ1RSTF9WUSkpIHsKPj4gKyAgICAgICAgICAgICAgIHUxNiBsYXN0X2F2YWlsX2lkeCA9
IGN2cS0+dnJpbmcubGFzdF9hdmFpbF9pZHg7Cj4+ICsKPj4gICAgICAgICAgICAgICAgIGVyciA9
IHZyaW5naF9pbml0X2lvdGxiKCZjdnEtPnZyaW5nLCBtdmRldi0+YWN0dWFsX2ZlYXR1cmVzLAo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUxYNV9DVlFfTUFYX0VO
VCwgZmFsc2UsCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoc3Ry
dWN0IHZyaW5nX2Rlc2MgKikodWludHB0cl90KWN2cS0+ZGVzY19hZGRyLAo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHN0cnVjdCB2cmluZ19hdmFpbCAqKSh1aW50
cHRyX3QpY3ZxLT5kcml2ZXJfYWRkciwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIChzdHJ1Y3QgdnJpbmdfdXNlZCAqKSh1aW50cHRyX3QpY3ZxLT5kZXZpY2VfYWRk
cik7Cj4+Cj4+ICsgICAgICAgICAgICAgICBpZiAoIWVycikKPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgdnJpbmdoX3NldF9iYXNlX2lvdGxiKCZjdnEtPnZyaW5nLCBsYXN0X2F2YWlsX2lkeCk7
Cj4+ICsgICAgICAgfQo+PiAgICAgICAgIHJldHVybiBlcnI7Cj4+ICB9Cj4+Cj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jIGIvZHJpdmVycy92aG9zdC92cmluZ2guYwo+PiBp
bmRleCA3YjhmZDk3N2Y3MWMuLjc5OTc2MmM4MzAwNyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92
aG9zdC92cmluZ2guYwo+PiArKysgYi9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4+IEBAIC01OTUs
NiArNTk1LDI0IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBfX3ZyaW5naF9ub3RpZnlfZGlzYWJsZShz
dHJ1Y3QgdnJpbmdoICp2cmgsCj4+ICAgICAgICAgfQo+PiAgfQo+Pgo+PiArc3RhdGljIGlubGlu
ZSBpbnQgX192cmluZ2hfc2V0X2Jhc2Uoc3RydWN0IHZyaW5naCAqdnJoLCB1MTYgaWR4LAo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50ICgqcHV0dTE2KShjb25zdCBzdHJ1Y3QgdnJp
bmdoICp2cmgsCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX192aXJ0aW8xNiAq
cCwgdTE2IHZhbCkpCj4+ICt7Cj4+ICsgICAgaW50IHJldDsKPj4gKwo+PiArICAgIHJldCA9IHB1
dHUxNih2cmgsICZ2cmgtPnZyaW5nLmF2YWlsLT5pZHgsIGlkeCk7Cj4+ICsgICAgaWYgKHJldCkK
Pj4gKyAgICAgICAgcmV0dXJuIHJldDsKPj4gKwo+PiArICAgIHJldCA9IHB1dHUxNih2cmgsICZ2
cmgtPnZyaW5nLnVzZWQtPmlkeCwgaWR4KTsKPj4gKyAgICBpZiAocmV0KQo+PiArICAgICAgICBy
ZXR1cm4gcmV0Owo+PiArCj4gCj4gSSBkb24ndCB0aGluayBWTU0gc2hvdWxkIGJlIGFibGUgdG8g
bW9kaWZ5IHRoZSBndWVzdCdzIHZyaW5nIG1lbW9yeS4KPiBGb3IgdnJpbmdoIGl0IHNob3VsZCBi
ZSBlbm91Z2ggd2l0aCB0aGUgbmV4dCBsaW5lLCBubyBuZWVkIGZvcgo+IHByZXZpb3VzLgo+IAo+
IElmIEknbSBub3Qgd3JvbmcgdGhpcyB3YXMgc29sdmVkIGluIHRoZSBzaW11bGF0b3IgYnkgWzFd
IGFuZCBbMl0uIEFtIEkKPiBtaXNzaW5nIHNvbWV0aGluZz8KPiAKPiBUaGFua3MhCj4gCj4gWzFd
IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIzLzEvMTgvMTA0NQo+IFsyXSBodHRwczovL3d3dy5z
cGluaWNzLm5ldC9saXN0cy9rZXJuZWwvbXNnNDcwNTcyNC5odG1sCj4gCj4+ICsgICAgdnJoLT5s
YXN0X2F2YWlsX2lkeCA9IHZyaC0+bGFzdF91c2VkX2lkeCA9IGlkeDsKPj4gKyAgICByZXR1cm4g
MDsKPj4gK30KPj4gKwoKT0ssIHRoYXQgbWFrZXMgc2Vuc2UuICBJIGp1c3QgdmVyaWZpZWQgdGhh
dCB0aGUgaWR4IEkgcGFzcyB0byB2cmluZ2hfc2V0X2Jhc2VfaW90bGIgCmRvZXMgaW5kZWVkIG1h
dGNoIHZyaC0+dnJpbmcuYXZhaWwtPmlkeCBhbmQgdnJoLT52cmluZy51c2VkLT5pZHguICAKCldp
dGggbm8gbmVlZCB0byBwdXR1MTYsIHRoZSBmaXggY291bGQgYmUgY29uZmluZWQgdG8gYSBmZXcg
bGluZXMgaW4gdGhlIG1seDUgZHJpdmVyOgoKc2V0dXBfY3ZxX3ZyaW5nKHN0cnVjdCBtbHg1X3Zk
cGFfZGV2ICptdmRldikgewogICAgaWR4ID0gY3ZxLT52cmluZy5sYXN0X2F2YWlsX2lkeDsKICAg
IHZyaW5naF9pbml0X2lvdGxiKCZjdnEtPnZyaW5nLCAuLi4pOwogICAgY3ZxLT52cmluZy5sYXN0
X2F2YWlsX2lkeCA9ICBjdnEtPnZyaW5nLmxhc3RfdXNlZF9pZHggPSBpZHg7Cn0KCkhvd2V2ZXIs
IEkgd29uZGVyIGlmIHJlLXN5bmNpbmcgd2l0aCB0aGUgZ3Vlc3QgdmFsdWVzIHdvdWxkIGJlIGEg
bW9yZSByb2J1c3QgZml4OgoKc2V0dXBfY3ZxX3ZyaW5nKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICpt
dmRldikgewogICAgdnJpbmdoX2luaXRfaW90bGIoJmN2cS0+dnJpbmcsIC4uLik7CiAgICB2cmlu
Z2hfc3luY19pb3RsYigmY3ZxLT52cmluZyk7Cn0KCnZyaW5naF9zeW5jX2lvdGxiKHN0cnVjdCB2
cmluZ2ggKnZyaCkgewogICAgZ2V0dTE2X2lvdGxiKHZyaCwgJnZyaC0+bGFzdF9hdmFpbF9pZHgs
ICZ2cmgtPnZyaW5nLmF2YWlsLT5pZHgpOwogICAgZ2V0dTE2X2lvdGxiKHZyaCwgJnZyaC0+bGFz
dF91c2VkX2lkeCwgJnZyaC0+dnJpbmcudXNlZC0+aWR4KTsKfQoKLSBTdGV2ZQoKPj4gIC8qIFVz
ZXJzcGFjZSBhY2Nlc3MgaGVscGVyczogaW4gdGhpcyBjYXNlLCBhZGRyZXNzZXMgYXJlIHJlYWxs
eSB1c2Vyc3BhY2UuICovCj4+ICBzdGF0aWMgaW5saW5lIGludCBnZXR1MTZfdXNlcihjb25zdCBz
dHJ1Y3QgdnJpbmdoICp2cmgsIHUxNiAqdmFsLCBjb25zdCBfX3ZpcnRpbzE2ICpwKQo+PiAgewo+
PiBAQCAtMTQ1Niw2ICsxNDc0LDE4IEBAIHZvaWQgdnJpbmdoX3NldF9pb3RsYihzdHJ1Y3QgdnJp
bmdoICp2cmgsIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCj4+ICB9Cj4+ICBFWFBPUlRfU1lN
Qk9MKHZyaW5naF9zZXRfaW90bGIpOwo+Pgo+PiArLyoqCj4+ICsgKiB2cmluZ2hfc2V0X2Jhc2Vf
aW90bGIgLSBzZXQgYXZhaWxfaWR4IGFuZCB1c2VkX2lkeAo+PiArICogQHZyaDogdGhlIHZyaW5n
Cj4+ICsgKiBAaWR4OiB0aGUgdmFsdWUgdG8gc2V0Cj4+ICsgKi8KPj4gK2ludCB2cmluZ2hfc2V0
X2Jhc2VfaW90bGIoc3RydWN0IHZyaW5naCAqdnJoLCB1MTYgaWR4KQo+PiArewo+PiArICAgIHJl
dHVybiBfX3ZyaW5naF9zZXRfYmFzZSh2cmgsIGlkeCwgcHV0dTE2X2lvdGxiKTsKPj4gK30KPj4g
K0VYUE9SVF9TWU1CT0wodnJpbmdoX3NldF9iYXNlX2lvdGxiKTsKPj4gKwo+PiArCj4+ICAvKioK
Pj4gICAqIHZyaW5naF9nZXRkZXNjX2lvdGxiIC0gZ2V0IG5leHQgYXZhaWxhYmxlIGRlc2NyaXB0
b3IgZnJvbSByaW5nIHdpdGgKPj4gICAqIElPVExCLgo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC92cmluZ2guaCBiL2luY2x1ZGUvbGludXgvdnJpbmdoLmgKPj4gaW5kZXggYzNhODExN2Rh
YmU4Li5lOWI4YWY0ZTZhNWUgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvdnJpbmdoLmgK
Pj4gKysrIGIvaW5jbHVkZS9saW51eC92cmluZ2guaAo+PiBAQCAtMzA2LDYgKzMwNiw4IEBAIGlu
dCB2cmluZ2hfaW5pdF9pb3RsYl92YShzdHJ1Y3QgdnJpbmdoICp2cmgsIHU2NCBmZWF0dXJlcywK
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2cmluZ19hdmFpbCAqYXZhaWwsCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdnJpbmdfdXNlZCAqdXNlZCk7Cj4+Cj4+
ICtpbnQgdnJpbmdoX3NldF9iYXNlX2lvdGxiKHN0cnVjdCB2cmluZ2ggKnZyaCwgdTE2IGlkeCk7
Cj4+ICsKPj4gIGludCB2cmluZ2hfZ2V0ZGVzY19pb3RsYihzdHJ1Y3QgdnJpbmdoICp2cmgsCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdnJpbmdoX2tpb3YgKnJpb3YsCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdnJpbmdoX2tpb3YgKndpb3YsCj4+IC0tCj4+
IDIuMzkuMwo+Pgo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
