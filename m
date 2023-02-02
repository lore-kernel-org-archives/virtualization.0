Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC95C61DA4
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 22:18:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 659EC408B7;
	Thu,  2 Feb 2023 22:18:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 659EC408B7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=h/8evIfF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=hrJ7sCx1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04UiJqVHGTMc; Thu,  2 Feb 2023 22:18:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D966440192;
	Thu,  2 Feb 2023 22:18:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D966440192
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3983EC0032;
	Thu,  2 Feb 2023 22:18:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F61AC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 22:18:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA431611F0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 22:18:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA431611F0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=h/8evIfF; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=hrJ7sCx1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QgpshmuNEOmh
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 22:18:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F345E60D50
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F345E60D50
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 22:18:33 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 312IDrCh001865; Thu, 2 Feb 2023 22:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GJ/5jByfBlFrFU25cag6JQ5A+sjb3mdpYHEbQQAbcvY=;
 b=h/8evIfF3vnmp0RKmVPDb6NdO1XETC6AlfK66NeJZxDks4t1aCOVeoyVZYHVt1Lvh1/k
 MnanI6rV6pVT2k0AbnOzoD6GO2lBkbdA8vanERK0mBYdl4ZpUoUWYlyF0T9Cxn9SUrR9
 eiX3+th/gatN5oPtULHLmBZJIr6NggO6YpB4UrKjEQZutW+4MHKtQa/1avFNOjm+OotF
 I01/f8WIVrxDysvjeUD9OGWXXzhAaimmIzh6ChbG1sFBPZX9xpX+HBQugBE+THttwNtb
 DplYdkQiMkqo4O6nDPjowABKlNxypqgAVTVGf+uz2KmrJ4hrxrvUa2X7ddbrAuSnZYyc vA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfk64ck5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Feb 2023 22:18:33 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 312L19mw002469; Thu, 2 Feb 2023 22:18:31 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3nct5g9quu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Feb 2023 22:18:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERbykFKdlKVBqns3rfPc2cCkiuY7Qy5Nq5+MmHw0Fzabl6sivJyf/6Oka1e8fKEAplWzEc2R1pRb1UTEgEDJmUmoST4wlO51kKoXFO1vAUcYUTWAKNS+cdRkn8Q0gI+aCz1T5K2yDCw1cskdjdVVfcwmJVZnGNT424aLCqKP1cbgTZPQkdjWwDeCKOn+kHHibjeY2FCVvrplCLEKyCfm/qzY1udJGKIM4lT6byFOr2QSc/HG+FyR8hrxUzVwmMeDXBAxK2sJZdv+Zt25Cx9fp9fjO6Ot8fbJbL5srxrj1rqpTCeNUM6mRJ+ECza5E2hhRXlug/7VmbEfp/z4z2dZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJ/5jByfBlFrFU25cag6JQ5A+sjb3mdpYHEbQQAbcvY=;
 b=BRa3PkuvVry5BpnBDil+11JGmTKZ04MGkXM8F8hCVDX+39Rm/5x6jfhBf/qnJBqu3u+wPcAig/c9NgeyVDubSRbPFVQJXRjq4NhTnsvUxUnxzPNvFZ3DhRJ8Ia1kuxu6opiwy4MsFX1rTVia775NtOpIB36ERliWwAq8/z4Qvn1iv2XuyJMrBd9Clbpf3ht1zltvS/Pz1NFnix9o4F7RxkN/8DsY+4RUtQ4gKI5184o8dzfSGBEXa6cbWcdS3btuY/gy0fk9qVfPXC28LIjF9lNqYw3aL3/185crOli2Nc9SWEXFg4VqBmbEFx10L7QWRFaHb4e0xS2tH9M0WECXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ/5jByfBlFrFU25cag6JQ5A+sjb3mdpYHEbQQAbcvY=;
 b=hrJ7sCx1ynLCAyw7hxesBQOYLtMpDySNs/DfF5xpiRKxA1GRf0bWk/v79MjSLYPG9DN6p1l+bLFvbRUPPlaHg5INJ0jCe0RfRPculpI/BdgALkdZQr7m9g2mq8FG06Uv9XfAhpvH/kTs7U5IeF1xCcRN+hdWdiZcwQBamMUIljo=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH3PR10MB7188.namprd10.prod.outlook.com (2603:10b6:610:121::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 22:18:29 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%6]) with mapi id 15.20.6064.024; Thu, 2 Feb 2023
 22:18:29 +0000
Message-ID: <c4576404-46ef-2991-8b68-2b0775da56cf@oracle.com>
Date: Thu, 2 Feb 2023 14:18:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 6/7] vdpa/mlx5: conditionally show MTU and STATUS in
 config space
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 parav@nvidia.com
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-7-git-send-email-si-wei.liu@oracle.com>
 <bad92641-e10e-cb06-179d-2f4bc11c721d@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <bad92641-e10e-cb06-179d-2f4bc11c721d@nvidia.com>
X-ClientProxiedBy: BY5PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::34) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH3PR10MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2ba19a-c01b-4a06-5d54-08db056b6959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uoNK4UeYNb281yPo3zYDsOqAOtnu8jvoP1jb1YFz7tpJTDY0JB0/wtiKoTMxlV4zDQGdeX68dAHz4KSdPmcaoQ74Ak/srOSE5Vj7qkpI2se5jFs7i/nN0jW61TvmedYNXns0GQ/wpDs+DRYYIjN2zCPsIOWy1f2NDsrh5H3gA5Ss5Zatr3K8E/F3PY8npRyf4ljQodNpGaHAXgFGDh+xZo8Lad5KJTDriyKQpG+8WX3qPxl1az50mktDRp3laBXiXdFDOEdkuIzq4PAQ6aoaS0XPiQPSJGNqEEIvgW6EMBKEaYwkQH74fA6fs7/gFMfgJm4OZOOLVsWr0/8XX6XtSnV7C6uvi8ne+6imvBpCCUnwYtcOl60GdqvV6+h2MZtlHcQV4jcHDqamMgXAs/1f1OIAeQZ0TXAJXNydcBTcZf/b6Mgo14VNSNReDg+jh+wMTfv4PDD2f11xaA8hA9Greeag6ff15adVt6OpAOiU0FhNlqNswKbq5PoK2IUdiVNycWsuChYT+zG3vnfOevs7UVa27JW7+Z+2SoulFTZzpziUmPnkOIuXn815vuWrWOsjoqpkcWnZGeo/glBCuFZ7xPvakmkjqjBKuIYL4WsutQ+CXXmNaI8G+mL00wG1AbiKJkPZlD8qp0JAa3J3NhPSPDImEWEIlSSKWPmqNmmx2XT29ioY2b/wDsbhwxYdF55h18Bz7uKQef8hin7MwrEnmbiCEqsR6MzF1XJmEF0LaG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199018)(2616005)(36916002)(6666004)(316002)(4326008)(41300700001)(8936002)(66946007)(66476007)(8676002)(186003)(86362001)(6512007)(6486002)(83380400001)(478600001)(66556008)(53546011)(6506007)(26005)(31696002)(36756003)(2906002)(5660300002)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTdpTlZnUUQ5MklhTnpZNDVwd3ErQTZPOFBQM1BXYVZkRFdSU0FkU2pJaHp4?=
 =?utf-8?B?MEdoVFV1blBvL2Nma01kTFNodHVXUTF5d2I4UHEzZWlWUUJjeVYydTBjUmtK?=
 =?utf-8?B?NktUZFpxNWxDQmFEdmpDZkIzUDU3Nmx2T2RJbGpTVUpUTm5naXhIaG9XK0dE?=
 =?utf-8?B?d0pzZ1BsT1cvTTVRVVJVZFhsNFVoLzFyUHJrOWpUREJibENKaG5oWnZsT0hI?=
 =?utf-8?B?aFlzWTlnWWdGSTBQVEZ3MWZFMEdaV044RDNQRkprZ0ExNkdQb25nc1NVSENP?=
 =?utf-8?B?VmN4VlVDbHZTN3BzRTI2cFEyM0x3ZW0rTXpzQXJxUkVCU3orRjlteFBuMi9r?=
 =?utf-8?B?RzVLUXFrakJZWlRFRldvR0ZOOGhlZUFPRDJjbGJ0M09iMHdGQ2w1RU00Ry9n?=
 =?utf-8?B?TDVVRVBJc20yUUdkT2FTamM3MU90aG9uYm4wd1Z3eGVJUUJ1THlETkJ2Y2dC?=
 =?utf-8?B?WWE1c0NiNnZ1ZmVDT281TjRJNGxMS3ZKUU56bnppdVhRN2RCR0k5em8zYm9M?=
 =?utf-8?B?ekVQVVpNRVNKejhLYnlGdjluSWhya041RXVLNUo5ejBBRWJvUWE5TlZwRXJ0?=
 =?utf-8?B?c3ZFSWVrekQ4QlZycWZlNHFMNVNUMWdhSGpaRDhEeHAvVVFUVTRkSEdxUmtz?=
 =?utf-8?B?dW51U3hHaWQvZkJFSzFiNE9KMnZUQUNnWjNOSzJOMXlmL1VvL2RwZXdxOVdt?=
 =?utf-8?B?VDc0VTA1eUNGQ29iaG41Z3ErVHlwZ1FmRkdNZHREcnM4dXFyOFFCbm9yVWpD?=
 =?utf-8?B?ZjdHTmc0V2ljSXZBWjJPZGg1ckVhOVN4NDc3L1VIbG5iVVM3V3Vma2oyM2U1?=
 =?utf-8?B?UkswRGVZVklRVnl4V2dDdjNRclYzRGdIQjVZQ2hsY3Q4MmNrTktLY0N3TklW?=
 =?utf-8?B?TXpQZlVTT1lpZUduUGpicjBmZDdZNU1CdU14SVJsbHV2NnJKMWNqVTREaEN4?=
 =?utf-8?B?VDI0dUliRUVDeGlBTFFWcG9zaURpTlhlbEFZdVFpOXZFSU9mREFZd09tc0RU?=
 =?utf-8?B?S0E2bVE5cElCYWJUTUJNdlVUeGhYenNKYkJld3lEY2FXQi82YUE5OHNmbHlO?=
 =?utf-8?B?SmMzdGNxYXBmVmxHNnk3d2creDk4c0E5WjBRd2laaGZIQ3IzY3A3VGNCM09B?=
 =?utf-8?B?a2ZqSzQ5MlBzdzc2dDBzTHJXaDF1NE1WYWdEUTRQMVFPclpCYmFpTXRHZDlJ?=
 =?utf-8?B?VXltaGVIRFlFTEtwRTJyWEM4b0xXTDNSK3dDbm9vQ09DbGJxUzlhdDBncURw?=
 =?utf-8?B?VUdIMUVxQWJsVXNWaFhjbWJHVU14ZnhRSlI1bEZISzMraWxJMlFqRXlCUHhi?=
 =?utf-8?B?Vzh4ZzdMcHUxcWUrN2IxZU1hWCtNUlNjdFJVZDJQRUtiTnNEdTVlbW9UaFRw?=
 =?utf-8?B?cGF4VTE0azNDbVBGOEExclpoY25zMzhyOWN3Rk1HRWY1ZlZ2SHlFV0taS1Rx?=
 =?utf-8?B?WFRKVmNnOEdFUWJUYytEcnFkSUhtWnFJekpjZ0NwSjcreFIxVmhOT3l1eUlN?=
 =?utf-8?B?aTByelFMeWx6VlRtVGlTNi9SNk1TTzdJSTJ0QnplVStjSmJLaFhUMDgySjFn?=
 =?utf-8?B?YklKQTBNN0JJamh1L1h6ckpzeHBNS0xTQTluaCtJbGNUMmhzTEpzc1Q3SEtk?=
 =?utf-8?B?UDlWcUQ2U3NXS2Y0ZVpQNUswZXlpVkZ5VFpBTUNmaDJDVm9SSmlVbUlXLzZ2?=
 =?utf-8?B?YngwVWkrbTJhajh4TXZ2K2hpQnpxRHZ5bHFReHlUQzdtMlNRYk5rMHE2bzIx?=
 =?utf-8?B?OUUxYTNSd04ybHVoWjl0aXBIUVJGQnhzVWE3YTBrdDhyUkpJcGN5NEdDbEV0?=
 =?utf-8?B?Mm05K3RFV0NyalBjbng0YjF6cFFFaWtEY1RzZlY5dDBNSGpwS1ZaTDROZmlq?=
 =?utf-8?B?SHhxSmNzRmdsT1IwanN5VnloSEhldWhydWluZXZUbUg5UlQvRDFKSlo5U0Vn?=
 =?utf-8?B?aVlOblA3YjZDdG81NnorS3dMWTNSMVFaM3pwb3lsVk9OSnRIQkNsOXN2eW9T?=
 =?utf-8?B?RS9OdW9ubGFFeG5LdWFrRWd1K1daYmJ2cTJ3T1VjeGdGeGdtM1F1NzZtTERZ?=
 =?utf-8?B?T0JCdWlPL3ZGYk9reTc2WTVDUGtLZ05weTJSaDVMRzltMVhLSnJMV2FyNEND?=
 =?utf-8?Q?cd5OFg1DUDb2tKlil69bTootT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oThNqxWzWOoSzA+UmMQMD6PaCgidX0BX6V1tou1aeYPBhGyOWfWqLoMF4Xlz0zvbjftRavP7U91prSmQ7rKPU5NOCg/PC2MSA7BYLFFETo7yKmeT1dA+RDcuk7lTHvVdHHW0aS10Ht2BuD2ogom0HHEvKWqRaN4HgkpLRVEWhuYw0us2nm4WKdIghnRyPAgqEUXzOheg14iu/E8du3ggoCIokr+AtxR6R2cY0TWwbNJCdSP4HeKe7vcLa8KhCNmwdAI0fkZjJxVuaQHI3uPhKQlmXh9p7ZrNrui/Yx8fwZKeImik0JQUwxUiBzkLiJ7aIhMurOczHFIhgHaRvzUuVTvZB+K/zAua8OsWvcxKlYZ8uRzChP09tziPrf7cKGEEgTtdbUhUvl5z0TPXJVqZcz1JpnOK6JtuevCwPmxkRO3afxUhs13zuVoIoP/LasowTU2XguuDspwICj1PoOPt6iLggfudqM44dXE9wNfaRtY/19eUyzSC9Xwvf1gyVtl0Nd0VBOUfOqUL8E/iKRDeu4XkTuJJ+Ns1bpDNdDlFS4g7jxKx27KNvHZAX9J0W2DNOneeX+5brNnoHFu+Az344JB3peZ+BSb1igrLg5qZD/sMl/UBHNoS83CKy7+e+//uJ/aNA6wZo0rCLaEL+dZbKywlJGWQDPMfjJ+Sor5OrnJLXIO1CHUHu4jKLNB6LBpLdtJv1kOT0uJ3RXLhn1+jbM5VsxDXR38oJzbCRftmE5AKqM9yhTYOuc4PEvJCEN6bd1/QafcY3Qs3wHFecbaQ+GouU+OR3HSa+niFZrIIv/ds7LOkqOqghY+jiUeOfDQARRFeEr+RGA+k1wIBdWp48Lx4SkoEilhwdYrjookuY22lwdQM26THAYy13pi0mRtpJZPHZaFjhGjJ0B4JNSs65w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2ba19a-c01b-4a06-5d54-08db056b6959
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 22:18:29.1566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/lPqIdOxqiP/+RLh1hUzTaPyix3NMr7RYLY0nMdT8yNDj0naDLnLwlTOv6n7X5rv/N+aw463ShWJyRxZuEkrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302020198
X-Proofpoint-ORIG-GUID: jdJ3a2NZMDDvs9gAM6Z-2NMDjwiVrQm2
X-Proofpoint-GUID: jdJ3a2NZMDDvs9gAM6Z-2NMDjwiVrQm2
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CgpPbiAyLzIvMjAyMyA1OjMxIEFNLCBFbGkgQ29oZW4gd3JvdGU6Cj4KPiBPbiAwMS8wMi8yMDIz
IDE6MjIsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+IFRoZSBzcGVjIHNheXM6Cj4+IMKgwqDCoMKgIG10
dSBvbmx5IGV4aXN0cyBpZiBWSVJUSU9fTkVUX0ZfTVRVIGlzIHNldAo+PiDCoMKgwqDCoCBzdGF0
dXMgb25seSBleGlzdHMgaWYgVklSVElPX05FVF9GX1NUQVRVUyBpcyBzZXQKPj4KPj4gV2Ugc2hv
dWxkIG9ubHkgc2hvdyBNVFUgYW5kIFNUQVRVUyBjb25kaXRpb25hbGx5IGRlcGVuZGluZyBvbgo+
PiB0aGUgZmVhdHVyZSBiaXRzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13
ZWkubGl1QG9yYWNsZS5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMgfCAyMiArKysrKysrKysrKysrKy0tLS0tLS0tCj4+IMKgIDEgZmlsZSBjaGFuZ2Vk
LCAxNCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIAo+PiBiL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYwo+PiBpbmRleCAzYTZkYmJjNi4uM2Q0OWVhZSAxMDA2NDQKPj4gLS0tIGEv
ZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuYwo+PiBAQCAtMzAwOSw2ICszMDA5LDggQEAgc3RhdGljIGludCBl
dmVudF9oYW5kbGVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAKPj4gKm5iLCB1bnNpZ25lZCBsb25n
IGV2ZW50LCB2b2lkICpwCj4+IMKgwqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV93cV9lbnQgKndx
ZW50Owo+PiDCoCDCoMKgwqDCoMKgIGlmIChldmVudCA9PSBNTFg1X0VWRU5UX1RZUEVfUE9SVF9D
SEFOR0UpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmICghKG5kZXYtPm12ZGV2LmFjdHVhbF9mZWF0
dXJlcyAmIAo+PiBCSVRfVUxMKFZJUlRJT19ORVRfRl9TVEFUVVMpKSkKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIE5PVElGWV9ET05FOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc3dp
dGNoIChlcWUtPnN1Yl90eXBlKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIE1MWDVfUE9S
VF9DSEFOR0VfU1VCVFlQRV9ET1dOOgo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBNTFg1X1BP
UlRfQ0hBTkdFX1NVQlRZUEVfQUNUSVZFOgo+PiBAQCAtMzExOCwxNiArMzEyMCwyMCBAQCBzdGF0
aWMgaW50IG1seDVfdmRwYV9kZXZfYWRkKHN0cnVjdCAKPj4gdmRwYV9tZ210X2RldiAqdl9tZGV2
LCBjb25zdCBjaGFyICpuYW1lLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVy
cl9hbGxvYzsKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgIC3CoMKgwqAgZXJyID0gcXVlcnlfbXR1KG1k
ZXYsICZtdHUpOwo+PiAtwqDCoMKgIGlmIChlcnIpCj4+IC3CoMKgwqDCoMKgwqDCoCBnb3RvIGVy
cl9hbGxvYzsKPj4gK8KgwqDCoCBpZiAoZGV2aWNlX2ZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9f
TkVUX0ZfTVRVKSkgewo+PiArwqDCoMKgwqDCoMKgwqAgZXJyID0gcXVlcnlfbXR1KG1kZXYsICZt
dHUpOwo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGVycikKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZ290byBlcnJfYWxsb2M7Cj4gZGV2aWNlX2ZlYXR1cmVzIGlzIG5vdCBkZWZpbmVkIGFzIGEg
bG9jYWwgdmFyaWFibGUuIEl0IGlzIGRlZmluZWQgaW4gCj4gdGhlIG5leHQgcGF0Y2guCkdvb2Qg
Y2F0Y2ghIFdpbGwgcmV2aXNlIGFuZCBwb3N0IGEgdjMuCgpUaGFua3MhCi1TaXdlaQoKPj4gwqAg
LcKgwqDCoCBuZGV2LT5jb25maWcubXR1ID0gY3B1X3RvX21seDV2ZHBhMTYobXZkZXYsIG10dSk7
Cj4+ICvCoMKgwqDCoMKgwqDCoCBuZGV2LT5jb25maWcubXR1ID0gY3B1X3RvX21seDV2ZHBhMTYo
bXZkZXYsIG10dSk7Cj4+ICvCoMKgwqAgfQo+PiDCoCAtwqDCoMKgIGlmIChnZXRfbGlua19zdGF0
ZShtdmRldikpCj4+IC3CoMKgwqDCoMKgwqDCoCBuZGV2LT5jb25maWcuc3RhdHVzIHw9IGNwdV90
b19tbHg1dmRwYTE2KG12ZGV2LCAKPj4gVklSVElPX05FVF9TX0xJTktfVVApOwo+PiAtwqDCoMKg
IGVsc2UKPj4gLcKgwqDCoMKgwqDCoMKgIG5kZXYtPmNvbmZpZy5zdGF0dXMgJj0gY3B1X3RvX21s
eDV2ZHBhMTYobXZkZXYsIAo+PiB+VklSVElPX05FVF9TX0xJTktfVVApOwo+PiArwqDCoMKgIGlm
IChkZXZpY2VfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19ORVRfRl9TVEFUVVMpKSB7Cj4+ICvC
oMKgwqDCoMKgwqDCoCBpZiAoZ2V0X2xpbmtfc3RhdGUobXZkZXYpKQo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBuZGV2LT5jb25maWcuc3RhdHVzIHw9IGNwdV90b19tbHg1dmRwYTE2KG12ZGV2
LCAKPj4gVklSVElPX05FVF9TX0xJTktfVVApOwo+PiArwqDCoMKgwqDCoMKgwqAgZWxzZQo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZGV2LT5jb25maWcuc3RhdHVzICY9IGNwdV90b19tbHg1
dmRwYTE2KG12ZGV2LCAKPj4gflZJUlRJT19ORVRfU19MSU5LX1VQKTsKPj4gK8KgwqDCoCB9Cj4+
IMKgIMKgwqDCoMKgwqAgaWYgKGFkZF9jb25maWctPm1hc2sgJiAoMSA8PCBWRFBBX0FUVFJfREVW
X05FVF9DRkdfTUFDQUREUikpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIG1lbWNweShuZGV2LT5j
b25maWcubWFjLCBhZGRfY29uZmlnLT5uZXQubWFjLCBFVEhfQUxFTik7CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
