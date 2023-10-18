Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C646CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 05:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D77CC41E30;
	Wed, 18 Oct 2023 05:21:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D77CC41E30
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=b/7sJpQm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=yuVd8k5R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t8P4oq6APowO; Wed, 18 Oct 2023 05:21:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 18E5E41E2A;
	Wed, 18 Oct 2023 05:21:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 18E5E41E2A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC8A1C0039;
	Wed, 18 Oct 2023 05:21:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A85BCC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 05:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7433B40116
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 05:21:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7433B40116
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=b/7sJpQm; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=yuVd8k5R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZCRDUpemIR2J
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 05:21:46 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E198D400C8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 05:21:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E198D400C8
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39HJwjAP002796; Wed, 18 Oct 2023 05:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4oJ75vNFGhzpn5taVX2ymMozA8PGzFYVQtde/VbuFcE=;
 b=b/7sJpQmtQYDDKsV1GiQtHFVf2Szv3G9BvmT4/v+ro1Zqe5fLk1BSogfmzxaQexwFVS0
 Aoh1BdCm6FPUzk7y4N92ZDCnQwpsVjH5Gj02f3CLprQ+2runpi6sfq7NsrOGOJ/qRSCI
 tMZuPA5adzhjZH99YFOxZMzS5s32l/DrDMV6IrmbfoWA92Oz1NTxR5tCxHvH8u3K0iGr
 mPRpptaCgm+DSaGLxHkld0NkrXVPAa9+gb+UbwzKDH+Cc6/XAnQsPHd+oe/MH+jFsxf3
 Aq8XYkymYkGtq2oVeRELiyHPOcQnjqCZfjDBBAljDU9aRl/Zu6A5w6YCZct27alfRmKU 7g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1cesj2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 05:21:44 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39I4wwNd009668; Wed, 18 Oct 2023 05:21:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3trg0nrg8w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 05:21:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gamCIqz3TYdV5Uvt2qjghjYdFZErIubV8If9523ESncefv4whUM1rzfp4BN7Yu4MjYOss0A73bzTJPkz2/XfnTKQfx6sTWm5kxfrQiOk+C9NsfEGgDCFdYOozyseRPlZqL+HVnUUDz7gIl3Mp1JbkZJZzVsV+rOG9yPA6WPT36GqZZhMzmbdiHiDpQECIXC3/OTQdWYsrBQO4iQSXbj0CU7fPy8ka5x6aVUAfpzfpvg0Jt7OePT7CmW/2kJt6myuN+uzrKaxdU89IaxaSq9mFJaqkvXarZChjZnitqsoE8bo3+hFh9LuUwmcZDerDjrJlMC1PQLRWSIojWS8Inwn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oJ75vNFGhzpn5taVX2ymMozA8PGzFYVQtde/VbuFcE=;
 b=EGTrYX5Fmn/oLxHSqb2S3Wx4blQYfD6W3351eU9dq8fDmL/hCimX0hV90avEpJGHkPy6Fzcb4vs7k8d9edTGTay/MSjqun94dk+ptiHJeV2k1pMI9wb8HgVhYsdnKO8W1An4wiBYOWnOQ22id+8Xf56e4mEfbxYnjep/w8AIm1AfkbqCH8zwAl2OavMgxyTjO4bZKs77DZPvr2gRRoviCUpAMgTgcqQmf0aAoqk2jJnVL52Cq4F1Yi3y429KhxMT3nompZ43QoAJcRbHphhVFieuYXw5uBjOEbpe9JLtvl/ovVvVM/1fJnIB2EicoAg+716UXABVwRjfBk3qdxiJOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oJ75vNFGhzpn5taVX2ymMozA8PGzFYVQtde/VbuFcE=;
 b=yuVd8k5RqhdMK2wvSBiRjdxC4GHiTdsQAIdEgIirC86CrJoOq5zV6AMq59qdv++/VvrmKlM8XQUdZj/gAlEBKA7E0X3P2nz6HZzZVHqxdNW2ImxMB7B+qLfa8zkZ4u2PalyLUa7pR8R7WrHlzOaSeUGTz2GNdne1rtt1w8LvXsE=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH3PR10MB7161.namprd10.prod.outlook.com (2603:10b6:610:12b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 05:21:41 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 05:21:40 +0000
Message-ID: <7b86e89a-9eac-4711-840d-c677cc892cba@oracle.com>
Date: Tue, 17 Oct 2023 22:21:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] vdpa_sim: implement .reset_map support
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
References: <1697185420-27213-1-git-send-email-si-wei.liu@oracle.com>
 <4o4yuuezigilikolv2paxb7icrsm3gdnj5aeoe47uotzju7xve@s5vqaafrppdv>
 <2222edd1-4eb1-4b06-87ef-df2d4f591931@oracle.com>
 <kuiqvqcspmx2fo6sylivhzopxnsxlqxahicgbp3lrltewz2puj@bka6ceakl6x3>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <kuiqvqcspmx2fo6sylivhzopxnsxlqxahicgbp3lrltewz2puj@bka6ceakl6x3>
X-ClientProxiedBy: BL1PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::21) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH3PR10MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 9056179c-fb92-4f82-c887-08dbcf9a1b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFyZLg99qJcS0Y9L9Inyy41g/uVv3U2l+i7ZF6e2LTtj3JMmK5xQR/Tnrf25MI2yfUw2O0Bem3yfwT+VwXQQ8HQTXGKQyeKciA8Q2Azhk/n2YuSr9V7f7aSdyhnLiya0jg1yMOu5N88VoJec0A7ec/sJ49t5D/UNoPlOQTh0YJW6Qh+mm9CrnpHCx6A3SwJpInt0LFJtzLnRcBLyrzrX1VsqURkoUxSwLYmbv/ormlYBab22sIlx4XEBuTzHRTZFmE2hBcppX2xRZqEVrJ+iVKIg4veS907v5NouXQjVQ4kG3hUBhn2h1kZOgdwZG84EiIR4ryZxiBJIGYiITcxy62iSGFz3VvMkr3UKmYi5sxJp/vh2bfjKqVtG8CRUei3f2LHxTequaFkpZLghj6ijqYuU2AWZgygnAelBxdVaXXuD53kyDkOpMsUI4IxKGDp9DQagDkqzyHLp13uOD7W5ozMPnuho2lexb9rgD0V5evY0VpRom8Lic1duF27mUjknh1H580MiZ2FZyp5e/h3jcZUKs64J47AtcvI9a0p8CW3lRHi0/0XSdrKJpUbe5im6j6H4icwWk4RVRrVp4+YAYaFQa/jTzHWYO9DIJyy3Ud+MVG6knbcGEQhLZsxUk1kyXnSSf9jwz0p253OQgg07S8jpEKvoRY+DKqTcR0AY8yU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(316002)(6486002)(966005)(66556008)(66476007)(6916009)(66946007)(38100700002)(26005)(83380400001)(31696002)(86362001)(36756003)(478600001)(53546011)(36916002)(2616005)(6512007)(6506007)(31686004)(2906002)(6666004)(41300700001)(5660300002)(8936002)(4326008)(8676002)(142923001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2xmN0VUcmdFbmZwWHFTY0kwQWZhRXJrcG5KWU5yaFVpNmYwRDZrUFZOQWIw?=
 =?utf-8?B?Yk5nYk13QXlWUU1uRkUyNVRRWmVWeXlBTzJhaUxvUGdhTnpFcEZhSnh5cWJR?=
 =?utf-8?B?QmJsM25nb2ZXUFh0dllCNjBLQW1JQkxjM3Arek1ZRUZua2lYTGwxVDR2R3E2?=
 =?utf-8?B?S3psUjJXN3hBakk4bXZ3eEluZWtuVklqcHFFdjRjT0RoMFNXcGl4UjhiSTh3?=
 =?utf-8?B?alJTd2NlbHFKSE5PN3E0VTVqSkVhR2FPTEhsdTF0aHd3cHRFTWpTZDZ6U3Zl?=
 =?utf-8?B?ZmNaRDVOY2ZrN09tUmQ1Q1pLZStXZUJGem1FbVBUUWxwbjMwcVJUYStKY0Rx?=
 =?utf-8?B?M0o2WGZvaEEwMDVkRWZJYzhQUjNoeUl0ZjhGWG1YVVB5emNxeUYyWkNRREZi?=
 =?utf-8?B?by9jeCtjaW1iMEFqWm9EUWdYbmJ1dStIeWZyREtNMk5ySWQwN0NiZ0RDVGNT?=
 =?utf-8?B?akVobHlkQndrN2pPVTRYanNFOHoyeXZnRWhjOHRqTDY3Mm5keWw2TWxnditS?=
 =?utf-8?B?OVNXTktldnZORHQ3Yi81elN5eUl0em1OaUp3cXY2UnVxbmNoMVJ3emRtdkE4?=
 =?utf-8?B?WGRKR3gxWFkwWDEwM0V1cTJxYXovUm1rY1VoQ3poWkhkalFaVGZMSjd3dTFV?=
 =?utf-8?B?VE43VGNodWU0elVWUUdaRWRucmZPdXBvcmxjaVFja3hLZHhGNFZNeUlhTVZn?=
 =?utf-8?B?UXVRWVN6ZjE4ZHA5UDExdHF0aUhjbUFhd1kxdG9sNndDbTFWUXE4cGpEYSt1?=
 =?utf-8?B?MktiUVgvbElnRHZ6dTVLRkR4WW5jN20reGNKTFM0N1NuWkNtdkNaSmNLWTBS?=
 =?utf-8?B?S2tPQmViNWhPSVg1bTVRNjhuY1FIKzhwUytieDU5TEJ6R3BGR0NPQnN3VWk0?=
 =?utf-8?B?MWphYTRDaVc0MlhrQ1F0QUgxV1pxM2hnNmVaNkY2d0VwUmRTL2lQVEpmeXFp?=
 =?utf-8?B?UUtaZWdiWVhQVzJ6dWkxS1d3QkRvTSt5RkN1ZWdrQjl3bWZRT3FlQ2VHZ09N?=
 =?utf-8?B?YVA3RnNINWpWbWd1REhEdGFVRURUNFNjVUZpOVVRbi9IR21QK2pOdFpMRmE0?=
 =?utf-8?B?NHpFdEZSVGlIRVdLeHpqOXNJM1U2aDZWK3NwTUhWRTJWVDVBNmdxZlJ1eHZm?=
 =?utf-8?B?RTFQOUg2NHNKZUx5TCtMSEZsSUw4NXVyWjNmWGZLTWI4ZE9BalFDRUlRZGNa?=
 =?utf-8?B?c0FFUmttSEhaMFY2MkJoTEFqQjdFVitCZzJpZ2VNbXBjQUlvVFg3eUlRcXk0?=
 =?utf-8?B?dFg1eUN0VmZRWG81T1JEK3p4MTZQaVBJOXBQbnNaUmdlQmJhTXBNc3BuVGl5?=
 =?utf-8?B?Y1ZrQnV4SEQ0d0ZwZzFTMEFZK2dBN0toWS9RcWN0WlNodFdnL0RCQVdoc083?=
 =?utf-8?B?UnhNYUZQd1Z1eXlUa0NvejZDdmlvaTdvOU1XNHkzYnRtbzZNZVdUcHFIODZL?=
 =?utf-8?B?RWVxVW0rNHpqSzhwcHJROEtWUnJxZVpISGpIUGtwUForY24ra09QelhUbFFo?=
 =?utf-8?B?VzBnRVI1eEREdVFxY1FoZjh2SHFBbXdtbWxGY1poUVlRMklKL21zb2pLQ3Iy?=
 =?utf-8?B?K1pGUmxtNjdhT21nZTk2RnIzSkFHN25nNlFhK0p5LzJaTjRBRk95dk5GM2Ux?=
 =?utf-8?B?ZG1PTFpRTTU0eGRHYWJpWEJTMnAwTWNBUjh6QkM2SDJUZ3E3OE5BTktySU85?=
 =?utf-8?B?aFZzTTdWWTdVV0R4V1RkMWZyUkRLZWNXMVFLcndMV3I1RUgvcG1xSjJSZG5C?=
 =?utf-8?B?OXBBdUZwWXUxR0UyRkQ3d1o3TVVHVk82M3hVaUZJL2F2OVFFTjdNc2ZMWjFw?=
 =?utf-8?B?aEZDT1YrL0hXUkpQM3FoS3BkN0oydWgvODJSMmRFZms0cmFKQXhZNzk2dVNO?=
 =?utf-8?B?ZXVPQkkzVHU3QUE2SWVBd1NpQU1HQTh0S3BMZ011K1htcFJaSkd0UWpZU0h3?=
 =?utf-8?B?Sm4xamVTcXFacGxXcU9wTUdnN1V1MFhoV2E2VHpCTEtQK2FuSnNBMnJ3RS9k?=
 =?utf-8?B?d0hBUkdWRWJoa3BndFp6SDVNY3VJVi91a2Fha0hLanJrYVhKa3VWSTBaeXZO?=
 =?utf-8?B?SzJSSkVHVEU3bWRZS2dYTDZVMitEdTRKUG1iaFc0d2M0L2pyYXpaQmczVXlB?=
 =?utf-8?Q?0aQSeZGyd1Qnzz00WaphDXbLC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7DlQBHPChiw1YR4bReo1v1KGMh7bLrZ766NeM8jTFIhoNCwx4O599nVNuWTCWu9JTrccE9FewYx9xjgOhj8mr8JiX6WkKkAhaz8pYXMnqTofSjuvmaNkmh/qtaC12Epz0g09nBadORzBWJh476/DW5LusrkwxIBJgSsldSleNONrC/ZEuXgcB6i/36JcvgTUaCoJkCI1xvGz7BXGZCEcfvEnxjwzWAJfxmliTPLyARkpV1NHFTYKvIcmSURYqVAa4RvVMj1I5QmAubhsD0sBpakdLdH4uNI/h8nCyCwIVx1ZDy8hKvWDkJQrg+41N00zGrSFg168gsERzLpR4VHFH1RtDDY1aaqD8+30a23iPfpMVvXFYgB+mMpkHJIqLfrAFfo9nEZqZSQFRE/lWP/yIng8B5qSARBxrA7E1GQUXj8wf5u9e1nvLfIIo4rxOuvFpwNP9iR05NJYBJoPf9TJcxa0n8pIBBRv5Ymc5iNvSPzC54NCcMJTxfsQH1nr3Mic/BjNuPldKa3hjVS1MiePovvpQDXqILUGkZO2TzNXH3wrlJVgnpG6n7OgNyY/olMRba9VkpJ95AZ68+EcjWGYBYnxKOKZi2kS52JC/gLof5VGOQ5pS5BGP4N7VcBasUMJgQX2uJB37zSzKpIw2g7hib30/Aomq6Xq/XwBL9mSpzVydUgE/G57iNX49qO36M9K4vC98rTcaitR1wo14dibiRe2fLO8yljddgHGnEtSgVFCfdUAe+wCcIkAuZKZI+HSP70m+1jLG5aY2abD7W6Jl4YC7Qv6kTCtXfzkU0kqygb9MV1DEkZS16emewa7mAJEQi7r9CxowBWdhlfvA5gaLwn2swKu7053KHI2H7bOuXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9056179c-fb92-4f82-c887-08dbcf9a1b43
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 05:21:39.4167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoPh0KUApzHUWNU3/tPAw0LiF4vhDa6xTriMTVUAd3dlBCk+3vbdgC3jm3LlA/EdzRKey7q3c0pQ/cPJ6ivEdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180045
X-Proofpoint-ORIG-GUID: y3YemqkcoXtSqr7WaYQZQA82JJvHO7z9
X-Proofpoint-GUID: y3YemqkcoXtSqr7WaYQZQA82JJvHO7z9
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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

SGkgU3RlZmFubywKCk9uIDEwLzE3LzIwMjMgNjo0NCBBTSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdy
b3RlOgo+IE9uIEZyaSwgT2N0IDEzLCAyMDIzIGF0IDEwOjI5OjI2QU0gLTA3MDAsIFNpLVdlaSBM
aXUgd3JvdGU6Cj4+IEhpIFN0ZWZhbm8sCj4+Cj4+IE9uIDEwLzEzLzIwMjMgMjoyMiBBTSwgU3Rl
ZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+Pj4gSGkgU2ktV2VpLAo+Pj4KPj4+IE9uIEZyaSwgT2N0
IDEzLCAyMDIzIGF0IDAxOjIzOjQwQU0gLTA3MDAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4gUkZD
IG9ubHkuIE5vdCB0ZXN0ZWQgb24gdmRwYS1zaW0tYmxrIHdpdGggdXNlciB2aXJ0dWFsIGFkZHJl
c3MuCj4+Pgo+Pj4gSSBjYW4gdGVzdCBpdCwgYnV0IHdoYXQgSSBzaG91bGQgc3RyZXNzPwo+PiBH
cmVhdCwgdGhhbmsgeW91ISBBcyB5b3Ugc2VlLCBteSBwYXRjaCBtb3ZlZCB2aG9zdF9pb3RsYl9y
ZXNldCBvdXQgb2YgCj4+IHZkcGFzaW1fcmVzZXQgZm9yIHRoZSBzYWtlIG9mIGRlY291cGxpbmcg
bWFwcGluZyBmcm9tIHZkcGEgZGV2aWNlIAo+PiByZXNldC4gRm9yIGhhcmR3YXJlIGRldmljZXMg
dGhpcyBkZWNvdXBsaW5nIG1ha2VzIHNlbnNlIGFzIHBsYXRmb3JtIAo+PiBJT01NVSBhbHJlYWR5
IGRpZCBpdC4gQnV0IEknbSBub3Qgc3VyZSBpZiB0aGVyZSdzIHNvbWV0aGluZyBpbiB0aGUgCj4+
IHNvZnR3YXJlIGRldmljZSAoZXNwLiB3aXRoIHZkcGEtYmxrIGFuZCB0aGUgdXNlcnNwYWNlIGxp
YnJhcnkgc3RhY2spIAo+PiB0aGF0IG1heSBoYXZlIHRvIHJlbHkgb24gdGhlIGN1cnJlbnQgLnJl
c2V0IGJlaGF2aW9yIHRoYXQgY2xlYXJzIHRoZSAKPj4gdmhvc3RfaW90bGIuIFNvIHBlcmhhcHMg
eW91IGNhbiB0cnkgdG8gZXhlcmNpc2UgZXZlcnkgcG9zc2libGUgY2FzZSAKPj4gaW52b2x2aW5n
IGJsayBkZXZpY2UgcmVzZXQsIGFuZCBzZWUgaWYgYW55dGhpbmcgKHJlbGF0ZWQgdG8gbWFwcGlu
ZykgCj4+IGJyZWFrcz8KPgo+IEkganVzdCB0cmllZCB0aGVzZSBzdGVwcyB3aXRob3V0IHVzaW5n
IGEgVk0gYW5kIHRoZSBob3N0IGtlcm5lbCBoYW5ncwo+IGFmdGVyIGFkZGluZyB0aGUgZGV2aWNl
Ogo+Cj4gW3Jvb3RAZjM4LXZtLWJ1aWxkIH5dIyBtb2Rwcm9iZSB2aXJ0aW8tdmRwYQo+IFtyb290
QGYzOC12bS1idWlsZCB+XSMgbW9kcHJvYmUgdmRwYS1zaW0tYmxrCj4gW3Jvb3RAZjM4LXZtLWJ1
aWxkIH5dIyB2ZHBhIGRldiBhZGQgbWdtdGRldiB2ZHBhc2ltX2JsayBuYW1lIGJsazAKPiBbwqDC
oCAzNS4yODQ1NzVdW8KgIFQ1NjNdIHZpcnRpb19ibGsgdmlydGlvNjogMS8wLzAgZGVmYXVsdC9y
ZWFkL3BvbGwgcXVldWVzCj4gW8KgwqAgMzUuMjg2MzcyXVvCoCBUNTYzXSB2aXJ0aW9fYmxrIHZp
cnRpbzY6IFt2ZGJdIDI2MjE0NCA1MTItYnl0ZSAKPiBsb2dpY2FsIGJsb2NrcyAoMTM0IE1CLzEy
OCBNaUIpCj4gW8KgwqAgMzUuMjk1MjcxXVvCoCBUNTY0XSB2cmluZ2g6Cj4KPiBSZXZlcnRpbmcg
dGhpcyBwYXRjaCAoc28gYnVpbGRpbmcgInZkcGEvbWx4NTogaW1wbGVtZW50IC5yZXNldF9tYXAg
Cj4gZHJpdmVyIG9wIikgd29ya2VkIGhlcmUuCkknbSBzb3JyeSwgdGhlIHByZXZpb3VzIFJGQyBw
YXRjaCB3YXMgaW5jb21wbGV0ZSAtIHBsZWFzZSBzZWUgdGhlIHYyIEkgCmp1c3QgcG9zdGVkLiBU
ZXN0ZWQgYm90aCB1c2VfdmEgYW5kICF1c2VfdmEgb24gdmRwYS1zaW0tYmxrLCBhbmQgcmF3IApk
aXNrIGNvcHkgdG8gdGhlIHZkcGEgYmxvY2sgc2ltdWxhdG9yIHVzaW5nIGRkIHNlZW1zIGZpbmUu
IEp1c3QgbGV0IG1lIAprbm93IGhvdyBpdCBnb2VzIG9uIHlvdXIgc2lkZSB0aGlzIHRpbWUuCgpU
aGFua3MsCi1TaXdlaQoKPgo+Pgo+Pj4KPj4+PiBXb3JrcyBmaW5lIHdpdGggdmRwYS1zaW0tbmV0
IHdoaWNoIHVzZXMgcGh5c2ljYWwgYWRkcmVzcyB0byBtYXAuCj4+Pgo+Pj4gQ2FuIHlvdSBzaGFy
ZSB5b3VyIHRlc3RzPyBzbyBJJ2xsIHRyeSB0byBkbyB0aGUgc2FtZSB3aXRoIGJsay4KPj4gQmFz
aWNhbGx5IGV2ZXJ5dGhpbmcgaW52b2x2aW5nIHZpcnRpbyBkZXZpY2UgcmVzZXQgaW4gdGhlIGd1
ZXN0LCAKPj4gZS5nLsKgIHJlYm9vdCB0aGUgVk0sIHJlbW92ZS91bmJpbmQgdGhlbiByZXByb2Jl
L2JpbmQgdGhlIHZpcnRpby1uZXQgCj4+IG1vZHVsZS9kcml2ZXIsIHRoZW4gc2VlIGlmIGRldmlj
ZSBJL08gKHdoaWNoIG5lZWRzIG1hcHBpbmcgcHJvcGVybHkpIAo+PiBpcyBzdGlsbCBmbG93aW5n
IGFzIGV4cGVjdGVkLiBBbmQgdGhlbiBldmVyeXRoaW5nIGVsc2UgdGhhdCBjb3VsZCAKPj4gdHJp
Z2dlciBRRU1VJ3Mgdmhvc3RfZGV2X3N0YXJ0L3N0b3AgcGF0aHMgZW5kaW5nIHVwIGFzIHBhc3Np
dmUgCj4+IHZob3MtdmRwYSBiYWNrZW5kIHJlc2V0LCBmb3IgZS5nLiBsaW5rIHN0YXR1cyBjaGFu
Z2UsIAo+PiBzdXNwZW5kL2hpYmVybmF0ZSwgU1ZRIHN3aXRjaCBhbmQgbGl2ZSBtaWdyYXRpb24u
IEkgYW0gbm90IHN1cmUgaWYgCj4+IHZkcGEtYmxrIHN1cHBvcnRzIGxpdmUgbWlncmF0aW9uIHRo
cm91Z2ggU1ZRIG9yIG5vdCwgaWYgbm90IHlvdSBkb24ndCAKPj4gbmVlZCB0byB3b3JyeSBhYm91
dC4KPj4KPj4+Cj4+Pj4KPj4+PiBUaGlzIHBhdGNoIGlzIGJhc2VkIG9uIHRvcCBvZiBbMV0uCj4+
Pj4KPj4+PiBbMV0gCj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdmlydHVhbGl6YXRpb24v
MTY5NjkyODU4MC03NTIwLTEtZ2l0LXNlbmQtZW1haWwtc2ktd2VpLmxpdUBvcmFjbGUuY29tLwo+
Pj4KPj4+IFRoZSBzZXJpZXMgZG9lcyBub3QgYXBwbHkgd2VsbCBvbiBtYXN0ZXIgb3Igdmhvc3Qg
dHJlZS4KPj4+IFdoZXJlIHNob3VsZCBJIGFwcGx5IGl0Pwo+PiBTZW50IHRoZSBsaW5rIHRocm91
Z2ggYW5vdGhlciBlbWFpbCBvZmZsaW5lLgo+Cj4gUmVjZWl2ZWQgdGhhbmtzIQo+Cj4gU3RlZmFu
bwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
