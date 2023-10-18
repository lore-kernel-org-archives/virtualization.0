Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE723CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 23:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 68F6941998;
	Wed, 18 Oct 2023 23:48:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68F6941998
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=nlISE4v9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=tnpX9ZZi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iK4SVbJauTqR; Wed, 18 Oct 2023 23:48:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E49A840165;
	Wed, 18 Oct 2023 23:48:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E49A840165
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD502C0039;
	Wed, 18 Oct 2023 23:48:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25C67C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 23:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0DA9B6F6EB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 23:48:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0DA9B6F6EB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=nlISE4v9; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=tnpX9ZZi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GwTCg_BZFy4S
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 23:48:17 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA36E6F6DA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 23:48:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA36E6F6DA
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39IIp5eT018065; Wed, 18 Oct 2023 23:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jZ2ztBDuE1nVqB5i58AwsA3rQ18vsZArxDIvTBOu8kk=;
 b=nlISE4v9CPpcsK343IaC5vETg05gdNQBOswh8Sjl4f4iXo+6oMJQEW8+t993/4zaS4MC
 zjngcKElCBJt7s4e/o8TvB61TuGRj0RR9F5QDK7tFA5S0hlgOCpgOyXgBWizh7nHBl8P
 3/qYIR0UpZPKtOT1ST2aqKDQ0/91kDsQmmmaZT6TUBal3gnJ42dG21VvGolBpwgRl845
 AGRZC13aft1MYfpiUQvkmmAq8QiSoUWBvfm/krJMw98+T7G+vWcZP/eX3Cdnqmm0g6ob
 ZJBpN6MDUof1nxeQG51IFVh6CFImfb7DOVZM8+4Hb1Ykc2UJiN3NkYc0RvdqqSLGKaUW hA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqkhu8wxk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 23:48:16 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39ILo3c9040665; Wed, 18 Oct 2023 23:48:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3trfypetkn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 23:48:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbv1sBtKDhkLuXt265Q/S4Z5s4f3GEc+Md0teeAfdKv37MTRZ53fFcplcbhntAbhZpymLjKM09D2hvhXUkuQg5BC/yPaEq0aGHaR9436DNJoBDj8Ob/97csawRRgnOFnikZPQ8H0ZhVKkZRmQbF0Pg7k8xWyGB9OfUyhoa7gsiEcCeHf0BuhIBarrhQBba1aYRdMP4rg/BKAJfyM815kCaqFt01wJ1kCub5bRGZE9yAOxD2ZBY9LFhd6X+YNuJcN6o2InTyFdTxXIi+qvPhuzfWuKdzeQTtOHv6LK/WzQ5mlDwo3BMZrFsIxgrqaxOQuQWtFnaLCxiOdopyhmEznYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZ2ztBDuE1nVqB5i58AwsA3rQ18vsZArxDIvTBOu8kk=;
 b=WH0rU2X4RNx/fdu5tzxgJykdi1CeY8Mbfa5M5+gAwYdOa9eEA/uTpyreoYn1gNUa+zmnZ5MUEAaKYVE2MkMuUWZkxEGR8Rm2D3p67BvDk/Mzaj0LOAjK50WXXIbbA6/tNBuyhVs95aiT9B+nXfEqjTg3Zn5ilZ+JAm1dOxRsKu8Ajm+hSTpWJ2TQDPyWN6DjajaXDEAfaspkNkEVjP9t4vyvXdd/3qOQXweIN6KIin/h075cPGYJCFE9wxqhQf5tkqYxTZgPz63sY2L/ASiH1zxKHMQG6Dfbn/v6TvwGIFdkUMHp5GoqpT7XR4EFuFmgk17fYs4iMChzX/NPZs9HvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ2ztBDuE1nVqB5i58AwsA3rQ18vsZArxDIvTBOu8kk=;
 b=tnpX9ZZiN4qwy8geK/+rBKBj3HMeleA5sWsomuPyfPld9FN9AOgVLwUbg04o7+/bffDWFUCYJLWuwg4ZSHTlWXyeKcuvBPmJbCIR/t6kpopWw/5yPY9REjjKbYSDDEV8E6nf1t9Z+wHLF7f1dOkFDilTYKv2L781hxJu7UzPBsY=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH0PR10MB5321.namprd10.prod.outlook.com (2603:10b6:610:c9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 23:47:54 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 23:47:54 +0000
Message-ID: <171a1147-2099-46da-81f1-fc953e9410e2@oracle.com>
Date: Wed, 18 Oct 2023 16:47:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 PATCH] vdpa_sim: implement .reset_map support
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
References: <1697605893-30313-1-git-send-email-si-wei.liu@oracle.com>
 <becui44lhdptriz4ds7r2b22kazofwo7i44rydacjssnwb7mrq@f6sa74zjhlfp>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <becui44lhdptriz4ds7r2b22kazofwo7i44rydacjssnwb7mrq@f6sa74zjhlfp>
X-ClientProxiedBy: BL0PR02CA0117.namprd02.prod.outlook.com
 (2603:10b6:208:35::22) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH0PR10MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f01ccf-0cfc-4c0a-11dc-08dbd034a527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DqHGu/F18P4QNjZzZHg3YUssHiOAjt7EeJFqNAMdab7h5qWD4FtQCo6QApNSzFwNxtKTFtuLvVLqC/rcknw0VYA5n2AcREtRQhz4vs4Oo6H3tiPX3RgMtuGUkn3fyMwdWFALrA4cbCNq0dbWrxDorrsh2HTRyUhtjmBJUi280BaOAd60HiqettIn5iiZ4yyO94IwKuPeD4qwD9AQk5cuh7laBQErDYD36XMzLC54r7gQnb05PGXUs4rtvIGdTkIAlWzR0CT5djP7yoU0cXT9YEJBxUYgn2KplSutjs6Vnmd+Oq4mj3EIw5pzvyfIbzUg8unETvXdJR9Vda5ueJQ30TENIDM/bKI3c1Gm9r3McUEW4LMKDIM+k1myy1zArjQrStPscrMzydxnjUzq0s5St05n7Ez4ISnXTjM8cTIkXcPUHRyN1jAqrn9Ay9fxDNucgjBok+hQX92kdE/Oots6kBKqCBfHy6y1acn84dLEWA0gNkcNr/1tV8ONcENBNoiLYO0TPuqqcWS7dWo0F5YRaPpuBe0yYgVrazJGfhZ5WzRpln2hGkaic6vIVjHFZcYCcu2vKKmbBh+V6kU0iIIKEbFif0/5iRp5qLjdfrAI4x4tXZqfWRc8yf/nfivvEBJFrQyI5OMPemB0IGIKE2t7CvE1GXeNjo+4VO8xt9YthR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(5660300002)(31686004)(66556008)(316002)(66946007)(6916009)(66476007)(8936002)(478600001)(8676002)(6486002)(966005)(4326008)(38100700002)(83380400001)(31696002)(6512007)(86362001)(2616005)(41300700001)(36756003)(53546011)(6666004)(6506007)(26005)(36916002)(2906002)(142923001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVc4dFdhelZvT2lKblR5L2FtaXlvNkdVeVFZYTdicXBLckNaWGxUTmhVN2Vt?=
 =?utf-8?B?TzhWZjBNSTR3ZldtMjVwRXoyL1Z1dWpnbExvdXc2YXFQZ2tpQU1WY1Q4Q3pT?=
 =?utf-8?B?TGRFL0Iva1pTbVpKZ3JaV1RsVHRTa2lTcUdKUjlsOXdtWER5Lzg1MVVVZHNs?=
 =?utf-8?B?WlZoZ2EzZDEzUE8xeUx6YkQwS29zZ1BrT3l6M0lVYkFzVGFvVHVvMXN2Zkxh?=
 =?utf-8?B?WWpUR3dFU3Y0ZWdReGtYQW9BbWJ4RmxPOUM2dmtab0s2a0w0ejlwdk1Taklj?=
 =?utf-8?B?Wm5hL3dhd2ZMQlBmVFpRa0tWeW1PR0s0amtVenBjb2dLbUhON29BL1B2Qldh?=
 =?utf-8?B?Y3Z1VUZnaE1rY1BvdXc4MC9weXkzWG1mcEZPZzRMODVvb3BrYW9JK0k1Rm95?=
 =?utf-8?B?blYxaTFDQVlocS9vcmowVkJES0ZMUURSUXVoTzFsV0ZkOENMVVQ3L2FBT29H?=
 =?utf-8?B?Ujh2Zk4vOFB3K2NBMkk2QjFKY2tMQUdIZ25PWXJ0NjFnUFZOT2NlcE1qMDNn?=
 =?utf-8?B?TlZuTENkWEtyY1FSSGRBYWI5bDlnZ1JFQXd6L2IrSzBWMFJSTGFqMnRncndt?=
 =?utf-8?B?c3VsN2V4dnV0RkNhdGdJNmJhV1NvMVNVMnUrT3p2bzZ0N3NmSkpWREdud1h5?=
 =?utf-8?B?ZWZ6MExMaHFzM3hjVG9rYWszMHYyZi92L2RzMU1lMktvbFZSZXdjcmhvVFdm?=
 =?utf-8?B?bnFtWEd6cWV1MU52ZnF1N0UvZHlrNStVeER2cVUzWmFyMUFGU2NnSjUyVkJp?=
 =?utf-8?B?S1RsZ2hmMjM1QWJnbVZiVU90bnBTK1RzeXRMSHQ4THNYSVBHbFdWNmFFTUtm?=
 =?utf-8?B?ZlllbktNeUU1Q2FQWDY4ZG9nYWpuMGNBcFRmNG9OOGIxVUJKNnE4MlprMmR0?=
 =?utf-8?B?VHErZzF3UmYyTEJkWDVwN3FNbGFvdU5rZG5KeGZ1RmRWNUZlQ3orKzM5S2k2?=
 =?utf-8?B?N09VWkFIbHM0cFZQS09JTXpXcGU3L2Q0aFhxdDdxeWlyL01sTERnQ2krcyto?=
 =?utf-8?B?Z3hETlhlbXJVNnJvMXJxMzlFWENpV3l3NFE2c3piNnhrRDdVa25ISFJoTUVQ?=
 =?utf-8?B?M01GaXVXRzNiNlFvbFRPeFB5d3Jmb3ZOdXdmVFBRcXdXRWJTSjV4alZpaEpo?=
 =?utf-8?B?eU51OVdBK29iYW1GOHAvTEdXejd6VzlvWUJKbG42VDM0M3B3bjJ3NVZqN2JW?=
 =?utf-8?B?eFh4c2ZhSzVJcWZDb0QvRE43a0MrY1Z1WmxmMVlMV3FkVGEvckl6T1o2eExE?=
 =?utf-8?B?eVBwZUlyalFmaDF1Nkx1SzZtUUM4dmIzbVY2OFhQNWlEQmVyOTBFWjR3UU9a?=
 =?utf-8?B?Y2lWVXBFWXZGdjNHZDZ2amFQNWlnVDdYdDloQys5eUM5LzlKRXZJM3dVa0oy?=
 =?utf-8?B?Yy9ZUlhEQTRNMjdROXluVGJQSDRHQzBVOHU1Ulc0ZG1wOTBHcFNwaXQ4cHZB?=
 =?utf-8?B?cXV1MHBmQTB5TzVVa0UwRkh1ZDRnYjd4WXdPbEVydWV6Nk51MnFrdUNHT1Vy?=
 =?utf-8?B?ZG5uMUt2cmdNV2wyejBQM0lKVUQzSXRSbkdPOHI4N2xEbGhOSXpDSTZHZFo1?=
 =?utf-8?B?cWJBUEpTcUhnMHU2Mng5Z3NKYndQWUhObjJYRzI1cTJXeFlRMllMcDhJc2dB?=
 =?utf-8?B?K2pnVFA2bTJyd2NSVGVEQjRlUUhSVkROV0JpZ2FKT2QrNjhSOHV4MnYzWjk4?=
 =?utf-8?B?dDV5QTBoUDZvc3N1MDIzSXhPbHZObm00RU5vUDdLaWtwSTI1cE5mUThDWjVw?=
 =?utf-8?B?Vzk4a2NiNEhUQ0ZrZHk1WkhpdzFFQk1EaWVxYll2TUt0alY1TXFlQlNBYjZI?=
 =?utf-8?B?UW9sYkJ6cVVJWHUyUzJvT01FZUxpWFpTSkd6Z1oxUDY4cXIrY01RWHFTeHlM?=
 =?utf-8?B?dGd2YTRRVkJYd3hpbGh5UzlGSEhZZFlLR1FGU016a1pjU0ZWcFc5V2Uyclh0?=
 =?utf-8?B?azBLdXJtaGp5eVFxeGhWWXRlMUNzNDBnM2I4aUNQQUswZ0NheUtueHNWMy85?=
 =?utf-8?B?OXFGSllWMVhQWGlPVXRsTWJPbUNvOCtUTytsYi9hb2FEU3VHb0tMMzI1cThI?=
 =?utf-8?B?RjZHT3lndzR6YzBpVDV6cEpNb2VOT0dWNTVNWTd1U2laUldWaXVIRzVWT2Rh?=
 =?utf-8?Q?DsYtELc96Tr3I3JwQ3FqUG9hC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NOFnaL88h7NeDs9NQklBK5O6GMOu7Fqf6pDn/F0U6xpZFqyIa0kVvrqSpFsiS0Efa5tuWQDboDvucz5iNzM+sJb9dw3s7rImImh56UnLYEc0kSVfDf+w+YkoXrSn98gJpMxC/ab57UowGiY35EEHLC6CGKFgFlsJvasLlEsW/m9FgYPFa/7yBi5vJ51plHgSVu48unkX6S8ZUfSVcGmhC/wSMmNLTymJYmtbsGSkpPWdkNyczFCI7E0pzn4FVarrjE8pVkO0lZp0jQpweBymNS7w9MI4pFvANXsHSZSDPJjOMxcofQtGm9Wt2EHIlJ+guCvvhAaiJXHSNRQ/ynuNa/uwJ/J4hHsGGvdeKfX89IHhBZVh8qx7dufbxC7Gu3hoVqEsPUd99Yrnn+TWrzE+z7gYH/6DPROx9X/CGEUHZU9suUjtY4Seuu1XenWzgwv4XuoilrxKI4a1oJ9DL2X8KZ/bVMkIjwI5HC14nEr9KkVgwPhnHgyUADv+32hhF/sOOdYjmIVE57uTtXW3ZeDEQq3Nyff5nsmoGRFCtpd4MAsN8KElmZ8rd5Rpmw2UQz2h7fI4decWMIQbrEgKoZ2kmz7SDjXiz34+slfqLYdR9p4HnqY/x3CBrv9HeTOb8ymlWXIqc5Yq/SzYjZhCLsqcme0wYnM5DPiQpjdUKFmJFe4/mTq1irFKwmPywu1oyRBizWTpTENGsy5VOPtZ4yy1+Ik6ULJVuX5QXWngeIF0UXIy/GuAyl40uZUAORMRyyLwcpGUcPOyEpZOTrP3JzcSalP6np5KckZe/wEQ9Y3u4wiWjj9cTShHkyQ8U+GuesLu5KYS6K2cvy7RrFD585ZVMcBmHBrVr/JJ96nPZoGkfOtUwbDM+k+46BgVNfXWXl9R
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f01ccf-0cfc-4c0a-11dc-08dbd034a527
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 23:47:53.7299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9DjPsK6fpjghp+jZENoTYum2naPwzBrMrTFLdhq6fJ5yzKEI619VGzsevLkc6Gmt8xDoRo0Fdcvbrl4loA7PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180197
X-Proofpoint-GUID: MxiAhUpqLFcoK8qyRC2OyzllKxIvt1If
X-Proofpoint-ORIG-GUID: MxiAhUpqLFcoK8qyRC2OyzllKxIvt1If
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

CgpPbiAxMC8xOC8yMDIzIDE6MDUgQU0sIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBPbiBU
dWUsIE9jdCAxNywgMjAyMyBhdCAxMDoxMTozM1BNIC0wNzAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+
PiBSRkMgb25seS4gTm90IHRlc3RlZCBvbiB2ZHBhLXNpbS1ibGsgd2l0aCB1c2VyIHZpcnR1YWwg
YWRkcmVzcy4KPj4gV29ya3MgZmluZSB3aXRoIHZkcGEtc2ltLW5ldCB3aGljaCB1c2VzIHBoeXNp
Y2FsIGFkZHJlc3MgdG8gbWFwLgo+Pgo+PiBUaGlzIHBhdGNoIGlzIGJhc2VkIG9uIHRvcCBvZiBb
MV0uCj4+Cj4+IFsxXSAKPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdmlydHVhbGl6YXRpb24v
MTY5NjkyODU4MC03NTIwLTEtZ2l0LXNlbmQtZW1haWwtc2ktd2VpLmxpdUBvcmFjbGUuY29tLwo+
Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4+
Cj4+IC0tLQo+PiBSRkMgdjI6Cj4+IMKgLSBpbml0aWFsaXplIGlvdGxiIHRvIHBhc3N0aHJvdWdo
IG1vZGUgaW4gZGV2aWNlIGFkZAo+Cj4gSSB0ZXN0ZWQgdGhpcyB2ZXJzaW9uIGFuZCBJIGRpZG4n
dCBzZWUgYW55IGlzc3VlIDstKQpHcmVhdCwgdGhhbmsgeW91IHNvIG11Y2ggZm9yIHlvdXIgaGVs
cCBvbiB0ZXN0aW5nIG15IHBhdGNoLCBTdGVmYW5vIQpKdXN0IGZvciBteSBvd24gaW50ZXJlc3Qv
Y3VyaW9zaXR5LCBjdXJyZW50bHkgdGhlcmUncyBubyB2aG9zdC12ZHBhIApiYWNrZW5kIGNsaWVu
dCBpbXBsZW1lbnRlZCBmb3IgdmRwYS1zaW0tYmxrIG9yIGFueSB2ZHBhIGJsb2NrIGRldmljZSBp
biAKdXNlcnNwYWNlIGFzIHlldCwgY29ycmVjdD8gU28gdGhlcmUgd2FzIG5vIHRlc3Qgc3BlY2lm
aWMgdG8gdmhvc3QtdmRwYSAKdGhhdCBuZWVkcyB0byBiZSBleGVyY2lzZWQsIHJpZ2h0PwoKVGhh
bmtzLAotU2l3ZWkKCgoKPgo+IFRlc3RlZC1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFy
ZUByZWRoYXQuY29tPgo+Cj4+IC0tLQo+PiBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0u
YyB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tCj4+IDEgZmlsZSBjaGFuZ2Vk
LCAyNiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgCj4+IGIvZHJpdmVycy92ZHBhL3ZkcGFfc2lt
L3ZkcGFfc2ltLmMKPj4gaW5kZXggNzZkNDEwNThhZGQ5Li4yYTBhNjA0MmQ2MWQgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4+ICsrKyBiL2RyaXZlcnMv
dmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4+IEBAIC0xNTEsMTMgKzE1MSw2IEBAIHN0YXRpYyB2
b2lkIHZkcGFzaW1fZG9fcmVzZXQoc3RydWN0IHZkcGFzaW0gCj4+ICp2ZHBhc2ltKQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmdmRwYXNpbS0+aW9tbXVfbG9jayk7Cj4+IMKg
wqDCoMKgfQo+Pgo+PiAtwqDCoMKgIGZvciAoaSA9IDA7IGkgPCB2ZHBhc2ltLT5kZXZfYXR0ci5u
YXM7IGkrKykgewo+PiAtwqDCoMKgwqDCoMKgwqAgdmhvc3RfaW90bGJfcmVzZXQoJnZkcGFzaW0t
PmlvbW11W2ldKTsKPj4gLcKgwqDCoMKgwqDCoMKgIHZob3N0X2lvdGxiX2FkZF9yYW5nZSgmdmRw
YXNpbS0+aW9tbXVbaV0sIDAsIFVMT05HX01BWCwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAwLCBWSE9TVF9NQVBfUlcpOwo+PiAtwqDCoMKgwqDCoMKgwqAg
dmRwYXNpbS0+aW9tbXVfcHRbaV0gPSB0cnVlOwo+PiAtwqDCoMKgIH0KPj4gLQo+PiDCoMKgwqDC
oHZkcGFzaW0tPnJ1bm5pbmcgPSB0cnVlOwo+PiDCoMKgwqDCoHNwaW5fdW5sb2NrKCZ2ZHBhc2lt
LT5pb21tdV9sb2NrKTsKPj4KPj4gQEAgLTI1OSw4ICsyNTIsMTIgQEAgc3RydWN0IHZkcGFzaW0g
KnZkcGFzaW1fY3JlYXRlKHN0cnVjdCAKPj4gdmRwYXNpbV9kZXZfYXR0ciAqZGV2X2F0dHIsCj4+
IMKgwqDCoMKgaWYgKCF2ZHBhc2ltLT5pb21tdV9wdCkKPj4gwqDCoMKgwqDCoMKgwqAgZ290byBl
cnJfaW9tbXU7Cj4+Cj4+IC3CoMKgwqAgZm9yIChpID0gMDsgaSA8IHZkcGFzaW0tPmRldl9hdHRy
Lm5hczsgaSsrKQo+PiArwqDCoMKgIGZvciAoaSA9IDA7IGkgPCB2ZHBhc2ltLT5kZXZfYXR0ci5u
YXM7IGkrKykgewo+PiDCoMKgwqDCoMKgwqDCoCB2aG9zdF9pb3RsYl9pbml0KCZ2ZHBhc2ltLT5p
b21tdVtpXSwgbWF4X2lvdGxiX2VudHJpZXMsIDApOwo+PiArwqDCoMKgwqDCoMKgwqAgdmhvc3Rf
aW90bGJfYWRkX3JhbmdlKCZ2ZHBhc2ltLT5pb21tdVtpXSwgMCwgVUxPTkdfTUFYLCAwLAo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZIT1NUX01BUF9SVyk7
Cj4+ICvCoMKgwqDCoMKgwqDCoCB2ZHBhc2ltLT5pb21tdV9wdFtpXSA9IHRydWU7Cj4+ICvCoMKg
wqAgfQo+Pgo+PiDCoMKgwqDCoGZvciAoaSA9IDA7IGkgPCBkZXZfYXR0ci0+bnZxczsgaSsrKQo+
PiDCoMKgwqDCoMKgwqDCoCB2cmluZ2hfc2V0X2lvdGxiKCZ2ZHBhc2ltLT52cXNbaV0udnJpbmcs
ICZ2ZHBhc2ltLT5pb21tdVswXSwKPj4gQEAgLTYzNyw2ICs2MzQsMjUgQEAgc3RhdGljIGludCB2
ZHBhc2ltX3NldF9tYXAoc3RydWN0IHZkcGFfZGV2aWNlIAo+PiAqdmRwYSwgdW5zaWduZWQgaW50
IGFzaWQsCj4+IMKgwqDCoMKgcmV0dXJuIHJldDsKPj4gfQo+Pgo+PiArc3RhdGljIGludCB2ZHBh
c2ltX3Jlc2V0X21hcChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHVuc2lnbmVkIGludCAKPj4g
YXNpZCkKPj4gK3sKPj4gK8KgwqDCoCBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSA9IHZkcGFfdG9f
c2ltKHZkcGEpOwo+PiArCj4+ICvCoMKgwqAgaWYgKGFzaWQgPj0gdmRwYXNpbS0+ZGV2X2F0dHIu
bmFzKQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+ICsKPj4gK8KgwqDCoCBz
cGluX2xvY2soJnZkcGFzaW0tPmlvbW11X2xvY2spOwo+PiArwqDCoMKgIGlmICh2ZHBhc2ltLT5p
b21tdV9wdFthc2lkXSkKPj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Owo+PiArwqDCoMKgIHZo
b3N0X2lvdGxiX3Jlc2V0KCZ2ZHBhc2ltLT5pb21tdVthc2lkXSk7Cj4+ICvCoMKgwqAgdmhvc3Rf
aW90bGJfYWRkX3JhbmdlKCZ2ZHBhc2ltLT5pb21tdVthc2lkXSwgMCwgVUxPTkdfTUFYLAo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwLCBWSE9TVF9NQVBfUlcpOwo+PiAr
wqDCoMKgIHZkcGFzaW0tPmlvbW11X3B0W2FzaWRdID0gdHJ1ZTsKPj4gK291dDoKPj4gK8KgwqDC
oCBzcGluX3VubG9jaygmdmRwYXNpbS0+aW9tbXVfbG9jayk7Cj4+ICvCoMKgwqAgcmV0dXJuIDA7
Cj4+ICt9Cj4+ICsKPj4gc3RhdGljIGludCB2ZHBhc2ltX2JpbmRfbW0oc3RydWN0IHZkcGFfZGV2
aWNlICp2ZHBhLCBzdHJ1Y3QgbW1fc3RydWN0IAo+PiAqbW0pCj4+IHsKPj4gwqDCoMKgwqBzdHJ1
Y3QgdmRwYXNpbSAqdmRwYXNpbSA9IHZkcGFfdG9fc2ltKHZkcGEpOwo+PiBAQCAtNzU5LDYgKzc3
NSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIAo+PiB2ZHBhc2ltX2Nv
bmZpZ19vcHMgPSB7Cj4+IMKgwqDCoMKgLnNldF9ncm91cF9hc2lkwqDCoMKgwqDCoMKgwqDCoCA9
IHZkcGFzaW1fc2V0X2dyb3VwX2FzaWQsCj4+IMKgwqDCoMKgLmRtYV9tYXDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgPSB2ZHBhc2ltX2RtYV9tYXAsCj4+IMKgwqDCoMKgLmRtYV91bm1h
cMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgID0gdmRwYXNpbV9kbWFfdW5tYXAsCj4+ICvCoMKg
wqAgLnJlc2V0X21hcMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgID0gdmRwYXNpbV9yZXNldF9t
YXAsCj4+IMKgwqDCoMKgLmJpbmRfbW3CoMKgwqDCoMKgwqDCoCA9IHZkcGFzaW1fYmluZF9tbSwK
Pj4gwqDCoMKgwqAudW5iaW5kX21twqDCoMKgwqDCoMKgwqAgPSB2ZHBhc2ltX3VuYmluZF9tbSwK
Pj4gwqDCoMKgwqAuZnJlZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA9IHZk
cGFzaW1fZnJlZSwKPj4gQEAgLTc5Niw2ICs4MTMsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZk
cGFfY29uZmlnX29wcyAKPj4gdmRwYXNpbV9iYXRjaF9jb25maWdfb3BzID0gewo+PiDCoMKgwqDC
oC5nZXRfaW92YV9yYW5nZcKgwqDCoMKgwqDCoMKgwqAgPSB2ZHBhc2ltX2dldF9pb3ZhX3Jhbmdl
LAo+PiDCoMKgwqDCoC5zZXRfZ3JvdXBfYXNpZMKgwqDCoMKgwqDCoMKgwqAgPSB2ZHBhc2ltX3Nl
dF9ncm91cF9hc2lkLAo+PiDCoMKgwqDCoC5zZXRfbWFwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgID0gdmRwYXNpbV9zZXRfbWFwLAo+PiArwqDCoMKgIC5yZXNldF9tYXDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCA9IHZkcGFzaW1fcmVzZXRfbWFwLAo+PiDCoMKgwqDCoC5iaW5kX21t
wqDCoMKgwqDCoMKgwqAgPSB2ZHBhc2ltX2JpbmRfbW0sCj4+IMKgwqDCoMKgLnVuYmluZF9tbcKg
wqDCoMKgwqDCoMKgID0gdmRwYXNpbV91bmJpbmRfbW0sCj4+IMKgwqDCoMKgLmZyZWXCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSB2ZHBhc2ltX2ZyZWUsCj4+IC0tIAo+PiAy
LjM5LjMKPj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
