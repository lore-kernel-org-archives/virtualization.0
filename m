Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A961C77B61
	for <virtualization@archiver.kernel.org>; Fri, 28 Apr 2023 16:35:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA1E942A42;
	Fri, 28 Apr 2023 16:35:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA1E942A42
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=ZqLCtg30;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=ND7dCpGv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KKJL1tN_xnI2; Fri, 28 Apr 2023 16:35:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F3D5740533;
	Fri, 28 Apr 2023 16:35:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3D5740533
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6AA3C0036;
	Fri, 28 Apr 2023 16:35:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC7EBC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:35:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8562D6FEDA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:35:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8562D6FEDA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=ZqLCtg30; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=ND7dCpGv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4yBrwOvhf6RW
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:35:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 814706FED7
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 814706FED7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:35:38 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33SF3oFk020040; Fri, 28 Apr 2023 16:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gvgpHD6nng5jpdcmtxnBU4t67Bx6bu5SE37uEDboKIY=;
 b=ZqLCtg30JQFkC7LymBfLOiVxAn7rejiJoAAf/Dx3mk9beyiwIkhGqFZ+WkBzKQibdRRg
 GfYf1P8IfqkarWkbIAM4zOqvzQsr7/bLHTbAdy2KGzdurNT43fmsItYQEoeNERJN3fyb
 JQfPeq15mcXJKVukQkWeRYNivOaZGSiPcCJKJPLWWp474xw3NT569cThbo4a+aNpYS25
 h0PuyaCyyKg6bnrytE9tvDMdO5T/u9mC5Pz4/tQLmkHopnAh2GLb5XV0zllCw3NBi684
 jbSHQDcl/5+Cy2lPu/hhAS74CCsoP2qXEjlEtGm1M2BQA8mh9dY/9MMW5MZzdJ6FfjdK 1g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q476u6n60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Apr 2023 16:35:37 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 33SFxak7014838; Fri, 28 Apr 2023 16:35:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3q461b6qn9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Apr 2023 16:35:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvn2tOKVSeKm5H75IxKHfku1HfJbXJ29KqJcxXdQCdxcvjHQjTxJ8YZPF5DBPPfwKqos3a2KYmib6Z9MlX2mRRq6yfvaZPaUVGrmOgjPJ7OWbke2olWGnabUyVHkgkwMmKZMf6GZWk66VNA6E71Ou1MKuBQm+2zxjYtJ56T1eO9GgJ4zqZKWv1kvFpxTG2kA0d2XyTiOYOw6/Ckw2ePl1pDyUHGG8QwisI085vn3yMvRWEOFEYam9jl2G8t1U+Ni9VHky8OgNJHvkBVZNqm1eBJDIn2f8kj0QGODjZCAByiAfhcKs0DzOB6Obf1kixvh9SqTDw+R5PCnBQQi3n/cIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvgpHD6nng5jpdcmtxnBU4t67Bx6bu5SE37uEDboKIY=;
 b=J7GWA3sKScrXlYn8ye7qbS7UQKRpIBtxMMo1+G1jK6shjUa/QzO6VaucWhv9YYYvEABBIAhqVFo5M1wljVWPCAd+ybuqeJnWUz+iFmVsQ0WcxOGBjREK1sI0XfkdmnEz919CefL+s5Lhl+jsyCJap9rEc8QptAclsZk4mF7izO+qMBOLu1jJJL6ygVN6Oc4tevPso9jn1qHRqei6ZGRzKH7MiBA9HvIXx3ni8itFWY4UhXhR3LRC+HGSadisj2lk7VR1VAhv5ltMi6QZm2ztjcnwmfTJlujVVZ3lGM9IOm9W/hZT1ajiNyUmrQyttHO8Jfl9PExwZyaPnSQikNMMWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvgpHD6nng5jpdcmtxnBU4t67Bx6bu5SE37uEDboKIY=;
 b=ND7dCpGvgpUILK19ibazZ+ML60YoelhGF64HYkCVBL8qDl3IcyK9+Jo7JN6xqB9ilqUoKM6gRoZUe+dYFL5U7ZWpzk4zwZlorOLiWMbcZaxIaoy32p5duPFHmmU1ichmLk6rpb+073zU/nE96DcC8TTLAVwQoz4Q1TCUSVDhVbA=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM4PR10MB6112.namprd10.prod.outlook.com (2603:10b6:8:b7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22; Fri, 28 Apr 2023 16:35:32 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::264c:5118:2153:91ef]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::264c:5118:2153:91ef%12]) with mapi id 15.20.6340.024; Fri, 28 Apr
 2023 16:35:32 +0000
Message-ID: <b7bc4a59-af42-bc4e-0bc8-05b5e6885750@oracle.com>
Date: Fri, 28 Apr 2023 11:35:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: [PATCH v7 00/14] vhost: multiple worker support
To: virtualization@lists.linux-foundation.org, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
References: <20230428163131.92777-1-michael.christie@oracle.com>
Content-Language: en-US
From: michael.christie@oracle.com
In-Reply-To: <20230428163131.92777-1-michael.christie@oracle.com>
X-ClientProxiedBy: SN6PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:805:de::49) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|DM4PR10MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: cad8b376-b24e-4cb4-de17-08db4806955c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V5oKYivTuTJxbyftLtFVSq0t5CSnwP/V5YoW5hIeJ5RLRtrQVNcfGbGj3YwunyRjJHtclC2k2crwm2ywWkT9JiEVfMFYOo+C08F5ZAVGuACMJu9be82ZIwAJycBrhHzL93cBm3tyq+E4aRhDYu1PBaGPxk2px4acJNB1zhKNww20hJjBiKtxy4+3G/crxeL2/jZH11sz3+UpA9sWGhgemlyzljrkjTJO17KephUfGvEfqz5YHoRbggw32Ds6BjMvRiB58JwGxnmFuWHx9Bhg+ZMSmK7rPA9ksocRA/45GR0HFwcRF+CMFifd0oDD6T/vMFWfOikVm1wd1WZCyPQr79Awe5Y8BSBnUfDGWvn2Lep3c7qK4y5XvhLXi3m96odhM8eS2zgwrDK6DgwGZ6ApRWHGkSJp77/1gmV84Mbkg2TsrIZPue5VVJzkM38OEgq0omdFtVLC3hHxMc/DBpX1HwnEhyTYboeTODqGr5dCsYAUn7XsKz14mrDnydPcF4OEv62SuX8WHsvbXN9FCBVX8wXxQmE3LW8378JhXCdCEfVoHaKhNaQkYUb0/cyydLdi33KenfBB29ZEZIdR6oeC1M2zBYDOszrJMhP6re4KpUhNA/Npiuzroc7XDLjVHtj5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199021)(186003)(9686003)(26005)(6512007)(6506007)(2616005)(83380400001)(31686004)(66476007)(66946007)(66556008)(316002)(41300700001)(38100700002)(5660300002)(2906002)(31696002)(86362001)(478600001)(8936002)(6666004)(8676002)(6486002)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aS9wZ1JPcXpCWlJUVk50MVg1UXllWGV2YkxBdzUwRVJFMDNRbHk3c3Q1YUtl?=
 =?utf-8?B?TW1DN0kyUmp2cEVlZTFmdFZ2ZDlQTlo2RXVkblNyejJsVkR3bXFGNm5LS2dh?=
 =?utf-8?B?V3JueTdxYWtGNmtyNGlKdVNudTNZSkZwVVVNZFRpcmNUeW51SDRHYUZDaTc4?=
 =?utf-8?B?eFk5Q00zYXRjbFlkQzMrbWdHQi8ycEJiTlhic21SUXcyMDRIaEZvK21aVExJ?=
 =?utf-8?B?SmVGL3R0bXVYcWVhc2VkLzRRS2pBT3ZSbGFGRzB4bDNDYWZRcS9OYVN3NzAv?=
 =?utf-8?B?b3NjaVZZRGh5RUFvR045dnBUWTZHNEFCeGJJd1VWRzhlK2dMVEx0ODFncHR3?=
 =?utf-8?B?SXdYNzlyaWV4RTdYR3d1V0ZoR2V3WFFxMUh4RzdrcnRoa21rNndvTllBWDJK?=
 =?utf-8?B?MmZqSjZnMGEwM3JzRDVZOGtFSDhhd245Y0k0eTNpMmQyeURzUTV2Z1VZRDNl?=
 =?utf-8?B?MGU5NlgzWEFpWGRlZi9KQ3d2SStmek9oNHRpVitqR3JBeVp5ZUgvdUMrT01R?=
 =?utf-8?B?SjRraTllMTBOMjFSKzVsTTZZV3BFZzRQY3FrSUVneVIvSTBGbjFwSVYxOHc1?=
 =?utf-8?B?cytSbmF4VG15WndBVm9HYkYwU1c1aGtvZWQ3cE4xYVkzYUU2T2RkUHNPZHpj?=
 =?utf-8?B?L0RKRW5Gc21ZQlM3VDRNcXd6ZlJDVlRPVXVUV3ZtYkZuanU0Y0RFNVE4M3pO?=
 =?utf-8?B?V3lISTVMUkRaVGE3TURXcmgySVNUWnljcEVoeWdKajFibTJoeFRQY3VMdlhN?=
 =?utf-8?B?c09CQXNhVnF6TG5XQ1lXWExBUkI0aHF0NEpza1pEa2IvVGszVzJRLzltY3ZM?=
 =?utf-8?B?UU84aFFVT0c3QytNakY4MnNOYzZjVEVoZ2JEcmdTRnU1b3pkbnAxSlhMTmti?=
 =?utf-8?B?Rld1VjVIRmhjbXNZdlN3QXVCN1ZhK3h2RWEyZi9YQWlBYVB3Y1dZbHhJTkw3?=
 =?utf-8?B?OWNWejQ2b2QweTVTdHJDVi9kMVg2dDJkVnlSVHRzWDBhMGxKN1o3R1JaUDJx?=
 =?utf-8?B?T1RlSDU0OU9kWS9nblNoS2ZwMTZwMEVhN0w4RFRJNFhRZFFaQjZUS2kwU0U4?=
 =?utf-8?B?bzVKUmFsRTZqbXJHV2xHZGQ3RUczcU1nOUNyNFN4RnRiK3RJUFlhMlIvTEVR?=
 =?utf-8?B?Yms4WTFHY1lnZDkyQnlkaTkrUXE2UkpQbzN0Q2daazJ3SWNkNUVMMnFVYVkv?=
 =?utf-8?B?TzBrNDJkMXpIMFRUcUY2UTlLMVdXNVpFd3prd0FwN2h6NnZmZ1RST2ZCNzJo?=
 =?utf-8?B?SnRlcnR1ZjEveVFvSS9iY1A1WDZsa3laU1lhWjJMcTd1M1p3QnNIeTlvWkFY?=
 =?utf-8?B?eGVnOERMY0Q4TDd3U2JydGpDeGN5bGdxbEQxWHRaUmR4WlRic2wrZXp5VUhn?=
 =?utf-8?B?Rkt6LzNUT0dYclNwOGRWd1hMcXRlVm9td3NSa2dHWjZyUnNOS1RNSHl4S3VC?=
 =?utf-8?B?d202dFhIVG1KUmsxWm9weWw1VHN2ZXc4dXk0MkZ1TVV1ZUs1bGQxeFRRV2xj?=
 =?utf-8?B?VUFCZmtEOGZobUNqM05FbEhlMCtVcElHVitvYXBzWWZXVU9mVUtFUUx4MHUv?=
 =?utf-8?B?QkdVVGVVQWdMVnVyZXhhRGpUVXNUeVppem5KRVNqSUtjcjFoM3llbDVoZDdw?=
 =?utf-8?B?K3pZUzE5R0xuczBYZDExZXIyeGFielFvVzQ1VWlWdlpHTmw5aW1WZXpGSUFC?=
 =?utf-8?B?ME5GREs4ZHpGWnQwSkFSc1RHdXJoeDEyV0RXSmlIQkw1emt4WXFCSGtSRUZK?=
 =?utf-8?B?dVQrR2pNUlZXRUU0NnlDbDN0ZlZQOVJxVDZNOWRJbzZMeThGYlhJTloxbjBM?=
 =?utf-8?B?OGlNdG9mazhHZWw2THIxTTZ0MDkyc0lvRGpuQWZnZFE2eDdIU1V0aGNpYi9n?=
 =?utf-8?B?TllVV04rZk94a0xGQW45aFppMG5NQldNMmtkdGxQQ1crRlZyVG9MMmZSQjc3?=
 =?utf-8?B?czNPSnpEVDNkZk9Qb0xVYXBBYnhTTmhqZ3cwejJhNHpCeDh3cU41UEplNjhD?=
 =?utf-8?B?Vk5MODBveG5idWNnd2RMWlA5NlRvaWhFUGF2WnZwaVhEbXVkckdJaXhWR0xH?=
 =?utf-8?B?SFBGTzRCNmcvWnRVaEJOOFlaOVJObEJNaG4vNmdYd3BJbVE2dFQ2YVhDRWlG?=
 =?utf-8?B?RjFKeGZkWGFRS2tTdnoyMGFVOEJIRVdWUm03U084YStldjBBSDVIMzg1OEp3?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZVsaNJh1V532r0JAjCVZR5jSbbougCDm+wha7tnBhbGskt3+ayitaz44YEVp2pY9VTJvduf3+UmXtYN00y/YKQx190YSaR/+sG6tQtQmpawHpjwhHMBKTZQuB78Cjs1mWB1TeCg8i+Ltz++4Fv6+3ID+ZIYyWejfJrTqz8j2pGA9t7zLn3fZdP+rLQ7UbNKQOc/XEM2udh90EEtuDBLYJ4KyMLcHtSPYagE9wCmseMjSZCPlV4t+GLl2giwHts5RmFUGcrfC/d5vzTaPoH6LaK9y2eK6MiptqGTjOx8pFWGFNA6rNyvlBUQfgGnFecCmKnKjvvgbK3vXCsLw/JlysD/65iT3g9E2WKD4hQyPMvc9QYSdDknL57I1jlzhObfRd3hh72RtmLA2+tSS0PkvSPYk3ISMvfidxwejZ3cFfQfTwONGC6Y73Oj0vcfd6/7kOpr8uv9zOy8cu4mt7ukHYbD0pCwZHwnTsWdFQp6opVoFpC87dof7s1j+9tRZXstxEZeGm8SRmj5ngeQ8Q3z6d8dDHv+NmkBEUV8hQgiBeC+XMJfpJVcP+MLLYqiCLegNMGdNXjR06Q6ij1vc93PltCeaW+ltvEtCAFaFxhnz/cV1zF/ZXzoleeXcEQHdSDWsA0BWlv6DzxU0BWYhvtfaGlSxFRrZEhXxCbJ8Y3xTedZ1FJa2ZNZElPfa2cYn/Xzpww23YHMIpbxVIhbUvpfnNqWfsq/gSKe/I08znFJW55jR5oYc/a1qYCVArxXyvlhNs9XsBYz4/qRHaUuIDumTypCKisGl7dNCsSXowXWtDDnbNGvh8N9Xb59CDVYrhjG5
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad8b376-b24e-4cb4-de17-08db4806955c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 16:35:31.9079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oT1xHdJbPsSb/f4Mvf/5J59OS+OdE/ULAgjJZ8xjYMMTosQWFYv+mk3GA8CuiQJvOLhq/TdWR5rZzHqLwpjsq1udiGZBSzjDogE2x6+4z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6112
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=799
 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280133
X-Proofpoint-GUID: S7suHrwdZekZRsg8cNb3huv-a2hWhDYy
X-Proofpoint-ORIG-GUID: S7suHrwdZekZRsg8cNb3huv-a2hWhDYy
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The following patches were built over Linux's tree. They allow us to
support multiple vhost workers tasks per device. The design is a modified
version of Stefan's original idea where userspace has the kernel create a
worker and we pass back the pid. In this version instead of passing the
pid between user/kernel space we use a worker_id which is just an integer
managed by the vhost driver and we allow userspace to create and free
workers and then attach them to virtqueues at setup time.

All review comments from the past reviews should be handled. If I didn't
reply to a review comment, I agreed with the comment and should have
handled it in this posting. Let me know if I missed one.

Results:
--------

fio jobs        1       2       4       8       12      16
----------------------------------------------------------
1 worker        160k   488k     -       -       -       -
worker per vq   160k   310k    620k    1300k   1836k   2326k


Notes:
0. This used a simple fio command:

fio --filename=/dev/sdb  --direct=1 --rw=randrw --bs=4k \
--ioengine=libaio --iodepth=128  --numjobs=$JOBS_ABOVE

and I used a VM with 16 vCPUs and 16 virtqueues.

1. The patches were tested with LIO's emulate_pr=0 which drops the
LIO PR lock use. This was a bottleneck at around 12 vqs/jobs.

2. Because we have a hard limit of 1024 cmds, if the num jobs * iodepth
was greater than 1024, I would decrease iodepth. So 12 jobs used 85 cmds,
and 16 used 64.

3. The perf issue above at 2 jobs is because when we only have 1 worker
we execute more cmds per vhost_work due to all vqs funneling to one worker.
I have 2 patches that fix this. One is just submit from the worker thread
instead of kikcing off to a workqueue like how the vhost block patches do.
I'll post this after the worker support is merged. I'm also working on
patches to add back batching during lio completion and do polling on the
submission side.

We will still want the threading patches, because if we batch at the fio
level plus use the vhost theading patches, we can see a big boost like
below. So hopefully doing it at the kernel will allow apps to just work
without having to be smart like fio.

fio using io_uring and batching with the iodepth_batch* settings:

fio jobs        1       2       4       8       12      16
-------------------------------------------------------------
1 worker        494k    520k    -       -       -       -
worker per vq   496k    878k    1542k   2436k   2304k   2590k

V7:
- Add more comments about assumptions.
- Drop refcounting and just use an attachment_cnt variable, so there
is no confusion about when a worker is freed.
- Do a opt-in model, because vsiock has an issue where it can queue works
before it's running and it doesn't even need multiple workers, so there 
is no point in chaning the driver or core code.
- Add back get worker ioctl.
- Broke up last patches to make it easier to read.

V6:
- Rebase against vhost_task patchset.
- Used xa instead of idr.
V5:
- Rebase against user_worker patchset.
- Rebase against flush patchset.
- Redo vhost-scsi tmf flush handling so it doesn't access vq->worker.
V4:
- fix vhost-sock VSOCK_VQ_RX use.
- name functions called directly by ioctl cmd's to match the ioctl cmd.
- break up VHOST_SET_VRING_WORKER into a new, free and attach cmd.
- document worker lifetime, and cgroup, namespace, mm, rlimit
inheritance, make it clear we currently only support sharing within the
device.
- add support to attach workers while IO is running.
- instead of passing a pid_t of the kernel thread, pass a int allocated
by the vhost layer with an idr.

V3:
- fully convert vhost code to use vq based APIs instead of leaving it
half per dev and half per vq.
- rebase against kernel worker API.
- Drop delayed worker creation. We always create the default worker at
VHOST_SET_OWNER time. Userspace can create and bind workers after that.

V2:
- change loop that we take a refcount to the worker in
- replaced pid == -1 with define.
- fixed tabbing/spacing coding style issue
- use hash instead of list to lookup workers.
- I dropped the patch that added an ioctl cmd to get a vq's worker's
pid. I saw we might do a generic netlink interface instead.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
