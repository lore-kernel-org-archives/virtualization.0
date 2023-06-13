Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4423C7EE43
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:33:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6016040CB9;
	Tue, 13 Jun 2023 01:33:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6016040CB9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=BeSHyGhB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=bMQqhQHw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8qdH1tlcOsce; Tue, 13 Jun 2023 01:33:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5E5E240C99;
	Tue, 13 Jun 2023 01:33:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E5E240C99
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43F6FC0091;
	Tue, 13 Jun 2023 01:33:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AB11C0029
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08C9740334
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08C9740334
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=BeSHyGhB; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=bMQqhQHw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yexCirePklzl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9DBC9402E1
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9DBC9402E1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:20 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKNsxZ002999; Tue, 13 Jun 2023 01:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=shYjIswIyCm/fw2zeudX0S9xFlFC6/scns5x9kEUhRc=;
 b=BeSHyGhBRqiqYgmhG9w+RRtbK9fYNQi4rJmaY8BmfhRM6lAE7SAVQPjH4jeaYkuAcZ7T
 +knX3fcAyn8UxCjasSyCrN5fiOVDS5x3jvCeF6yxj5ShBTGElAmF/80goZIqUwTa77/e
 yeVGEfBNeOy//Sd2p1UAQ2ywEtN7Sb4MsqiwWyzixEtsM82Rlj7iNQ7RQCfRxn8EibNx
 gfRzymp2ewydGjrUjmQpP51TYV0cQ8Oh3HlZey9N+gi+/Pg2V4R1KlXRVa+bQLA7E5YI
 cTUiK7ZEol4yn2RRwDtcL+pHDO0duIwBmYaRFB7BIzQTFkYtcLbHxbxfZkMF/JikQ9ix nQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdm462-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:19 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35D1CJRI021613; Tue, 13 Jun 2023 01:33:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3hg44-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1Vg4hrWwtv5iym+L8sH1UQHDB38/JzDWCENYXvMHLanxTHsxJFHRkJrZ8ywCACi08seKHP2CEDHM4IJvgnJK/MrsSDgT/auiORy0RUnAGo4MoV9gXhSTEI19s+b0p+NWR7+Xumkqc4LIzhe77g2KIPmb/TvqKBpJYM7GPX/mx6BqCFO3Xpov65+AVt7+Jq7n8USuKRaEKzEG3fvIr/PxS6vLZnWFPyNKcZB82CaaYlLT9LmNWLLMBoh4HTtu58f0BxDFP4RqMZyCSm4XAmylla8Ve4xKr2xYLEHlcvUNRC+ZcQnKfi/S6sqNonXtvRfjzn6s989gnzjOy+iCxobDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shYjIswIyCm/fw2zeudX0S9xFlFC6/scns5x9kEUhRc=;
 b=Bg/KiDc4Sts14qoBA3gmYL4WioHt7hTIM6p+rNCssESDMLP0UYfZ6Qgf/sy5l/XpFCm33LUIzZOF1vcuCc9yJiyGn0Y5bgLRE9kF0OV1HlxPqk5juET71qa5+mYBLuTnQxMaaDgOzAm86E47kQeqQVjQSiM4ybphlsMU2fLOX2+ubKLP6F04jR7SnjdBXR9Ga2X4l0E/KXn9yK5GJ0ADd+0GXDUoj0Q8kGLoD3ePGHBJTwVWi2s/d1wa+HFWuXBoKiXOpysksHTtSGdYY7Vq+kk5+gVb9lm0XA31YeV6qxmoHXY8vwQok12NF7KTKPghMwUeYK2DUxUw1xhYLNAS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shYjIswIyCm/fw2zeudX0S9xFlFC6/scns5x9kEUhRc=;
 b=bMQqhQHwNEuZfRSQ4w/2NG4G6XrX8Q8EdF1/BTra8K7f1DBOjTZcNMasQi6veNe+5PTE8K54oRD20B7iRRME/XgqaWbti0eyOhU3FXy4jRUFQf52AgO8Q/lbh4myuVHh0GsPQv50V9oGBtlNy7uV5wQWaHrr6EpX76Gx8z1AjlM=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 01:33:05 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:33:05 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v8 09/17] vhost_scsi: make SCSI cmd completion per vq
Date: Mon, 12 Jun 2023 20:32:40 -0500
Message-Id: <20230613013248.12196-10-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613013248.12196-1-michael.christie@oracle.com>
References: <20230613013248.12196-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::30) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: d211c4b7-899a-4178-b09e-08db6bae22bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iwJxpdKE+YTmDw+tujroc3HDwJ7m/NnPcUiOPXP+wZzr8BqWn5FzJHI+6egTYil23zQOXjsVc5QEXpBmLHrYLbZHwgFGvZmYAGbrJiciCF/phMiw2CK4CdmkkiNthWVDaqnH7Zs5ZHA1zTr/WwWAfcf9fM9L20ewLTq6CDjV4gn8XoX5DvVE1+3eLwFZHIOdDoDbwrvhM+mx0aoTCNM5A0Z23NR25xnA9E5cwRa+6OdbruzDTWpGtq4MILHsjjXDWoF39QfCFgo2iM8G5s1PJ+Q6uWuE9lCqJwhwPx7coBxoBx2zujesgobB+uHwhl/OD4km4pZ3XEbdhtMupImcoIz6HKDqJO8Rsdp+NHyc9olDeR5u4Nn6VodwtGCHFpuvgr6q3bzfmJ7pzfg0PScpYwLuRTgedsRKz4i+Bh4LcieMomUrpCEnyeWjHrWQruDWQDsQeGQ0IWhioRXAr+9uyJ/xzh2isiwrUvhUtJXI1Mshw+aqpYq2pI0/rRoRTUd40VOPTRnLrcghHesIebKCcMVbe0qYmOcqPkGTF3uJ5ftkC370bAQPLu5EKK5guzsz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(36756003)(86362001)(66556008)(4326008)(478600001)(66476007)(66946007)(6666004)(316002)(107886003)(6486002)(8936002)(5660300002)(2906002)(8676002)(41300700001)(38100700002)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y5bXq0U2PuZ+HAepeIKORr647FXj1qetU9p5N9LD+VZqjevuRn8T1U8vPBOm?=
 =?us-ascii?Q?AKKBmhhJuuKT8NJtywq84/Z+EyAhg9oCXlwoJesVZJwwt6O1Km/ap5iYynk2?=
 =?us-ascii?Q?kozIw6Hu3H3UC7KIrgFQVuIGZtgjByQVEf3SfEIG79A1t0TUO1uNPVv2Q7AR?=
 =?us-ascii?Q?TzMPBUW3Uu9ashwl7Fuon9MsLu44Y7SBdhZAha+8Dh+zjax25TCq6Sm5Mji0?=
 =?us-ascii?Q?mWcmKFAEpmYQmBxHln7I5JTWtTymHuLnOaIUPdzF1UD/mOnv1zPP9fXobT5a?=
 =?us-ascii?Q?QxSwi8cRoI2SnYwyxYIfnO1rkfbAwx2qzH+/fpwyYh1gmoW0u8NL9hb/fAZN?=
 =?us-ascii?Q?XgyZpEGJEDbiDZj9L4jZdb/E/0DWt6AKJc8hMVjZYliIc3HxRb/wrTuzN5XF?=
 =?us-ascii?Q?Q3hed+RyqQ2ja2dlVMR5MeJUc89rvXZE0H208Yunsenq8cYHRIzLstCXtfzc?=
 =?us-ascii?Q?njdHGnSovsBkt7AEUR6ZY/3FlXXgCtLjyc9N8FZz2SVMNFyT0iJTO2jZ0E31?=
 =?us-ascii?Q?cukA7LBF4LbZf8+yKBOdHXVVAyRsG0pGLEr2PnOyt0rTUS5S0iLEhPS3EtG+?=
 =?us-ascii?Q?llwJuPUsVzr86Jh0BavYsZ9pgX+uuAiwb7PZt5MX9iGbrgTQb3HAIXW0GPVz?=
 =?us-ascii?Q?9Pq2mBEU+XrPFUeOevy5G1JCqVqQQiWp4Mk1r/YxOt6XSUPUyBQZP6IQ5DG0?=
 =?us-ascii?Q?zMcLSOa95ipMMGOtVBPIM1mFjOA3KfV1zDX80xKwQIAnx/rsTg1StSH7zus7?=
 =?us-ascii?Q?VX0KbBgjEK+Ficw1GMS9U2byW11Co4LjlFcANUq4vbuv+23yrgb1i5xjCF2k?=
 =?us-ascii?Q?gxCZx9PAqcpmiKYqiSN+d4sc4DIAmsq/20CU20rzoRyheWFoCvrXYvqIzWJO?=
 =?us-ascii?Q?ZgvYYTITguDe6Of0bPzJXS4bxq6LgGNPnnBku6E/5KwUzIb4fPUSqgoKbT7F?=
 =?us-ascii?Q?zn28TmCzqNiPWIclFvdTWMgf8VotEWBxvq77bTPA2jY8vQ/XqrUXxYzybvRV?=
 =?us-ascii?Q?Krw3m3wm7+jhqr/2g6ieas3WERsSdd24wBKHsFC5HlVHlH0JfWOPiYyosyET?=
 =?us-ascii?Q?TQ+LJHtaCeLq8Wuz/HDNsojE2a4ApwTb5V57TJpUE5wdMyERU+9nXPw4lW6s?=
 =?us-ascii?Q?cy2O0QZoAXNT2J5Kpw2ygGF9hFIcF7aHQqYMxAYL1biECqAZyhwWBM5jX6Y1?=
 =?us-ascii?Q?TbLhiIWOYhvzEihrokUZGcso+a4KTmeWVqx0i2VKo0B40Xd2lO7p5DYqCRg5?=
 =?us-ascii?Q?1UoGsYpY4A6+HeaYhEyW4+u1qMUQAKbyfOUoNqixWHV1BPjYZIm1yttfqTP+?=
 =?us-ascii?Q?RQPapjYCqxpI/6j1jdpu+64R3YrQ5DzZBfrOqMOEuX914hStmmA0Zy+LOrXf?=
 =?us-ascii?Q?CTOSPSelHWELJrl9ldgoIGZta+NYRGz4tr+wY+x9PSnwnE9Mkg9azGtrLA+8?=
 =?us-ascii?Q?Gtm6s7a5IytDkuZgGOnUC6g9VxEndeu7Kz+B5D1e0uEqm63r0lHXLu4RwEat?=
 =?us-ascii?Q?QoLWLPqzNFHP8DlqztF6mtnEo1GGqM1YMJS7MdNnmwqiTyDWfUYAlGmsNxQ3?=
 =?us-ascii?Q?VHFzmkmbKeM4fmWfeTfy/rlvPfNfWtDNAXuPwIRsppKGIHKPKC/5D7m6gUrf?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iygqhKdNPnFRLGk1UOwkr69t6mrxNWZCiWfmAKxwqba3D6z3+h093uQNCRBQCBd3hVbxIeqQLx1/pAMBSp/Z7aP9EKw8xtD/W9UVCvazU/3QcMzvrPi3nHLykUFdwaKVhcpK8NaTF/HvkJAMxJnjCyUb+KlKttR+p2abJtYZGl+cR3a8kG+gQ4ePS0ljULK7Ark1V8DfbUZbOAd5c9Uk4W5s7S38IuCzMCJOhYEHqamrbsLCMdDfEaGR40HqvakAZJchihJOLnqJjNHoJmJ/gBbgssNnyj4xMgi8p4jHRUxcmpandQvSUWOl4cWzOkB6Cdwe5bNof3crJFwig4EKKdA4GJa1mXwcrlTDReSNf+4bbHQucqicApO0d3l9eV9b4VFLeANPGFmU+nomSew0VL3TL/6v5uKnWJrIcg0jsrNZrb6H4odSq8fnIlwcQfEKfALell9+frvMOFqPHGgm4sRoTmJIL5V3TLElLTQ8GJ8oCSa+GV/n6doJfqZQ7mJ83bHsPIf5EUTZQ5Cp8qPGcg5yMAYRUbuLiU7C45J+kKw9j0Nv4N+3Vz8SaKvYAVPx5toEpev/YdzUk2WLBML99Je9HsIYmOSHWmTUgQ5NaR1X0g/XtA5pwPeq+FyMJ+5aEOVjYcXYa8hPCN1F9T5Fhqkmj/yCY3kHMHHAgMZLKvc1G2mo+FvhLJ5QwWIAaVCHiFkUvqdRdzTWcXyqluw/GOCj1rKVcPtzSP3w1M6DkC9lWDkspdzoNTsNhk8g24w1/6qR8JptVWN46hAD4jszuEZaHEQ3d7wxaJ0Fql0/FrjWGNgzWLlZ0KaLA+7vNBF1
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d211c4b7-899a-4178-b09e-08db6bae22bf
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:33:05.5710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWJ33Yl7iHlX7MJC9sp17tJF/JbtnzIYQApggv59/7G4heroIcnuhMjdgaQ7mBZ147yx58ogFeS/UIzltRvLCVSxQi4c31JNkfILfVIqZWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130012
X-Proofpoint-ORIG-GUID: ZeOVsK-GYA-ZiZH7ID_h8LkUt2PrYduG
X-Proofpoint-GUID: ZeOVsK-GYA-ZiZH7ID_h8LkUt2PrYduG
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

This patch separates the scsi cmd completion code paths so we can complete
cmds based on their vq instead of having all cmds complete on the same
worker/CPU. This will be useful with the next patches that allow us to
create mulitple worker threads and bind them to different vqs, and we can
have completions running on different threads/CPUs.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/vhost/scsi.c | 56 ++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index bb10fa4bb4f6..a77c53bb035a 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -167,6 +167,7 @@ MODULE_PARM_DESC(max_io_vqs, "Set the max number of IO virtqueues a vhost scsi d
 
 struct vhost_scsi_virtqueue {
 	struct vhost_virtqueue vq;
+	struct vhost_scsi *vs;
 	/*
 	 * Reference counting for inflight reqs, used for flush operation. At
 	 * each time, one reference tracks new commands submitted, while we
@@ -181,6 +182,9 @@ struct vhost_scsi_virtqueue {
 	struct vhost_scsi_cmd *scsi_cmds;
 	struct sbitmap scsi_tags;
 	int max_cmds;
+
+	struct vhost_work completion_work;
+	struct llist_head completion_list;
 };
 
 struct vhost_scsi {
@@ -190,12 +194,8 @@ struct vhost_scsi {
 
 	struct vhost_dev dev;
 	struct vhost_scsi_virtqueue *vqs;
-	unsigned long *compl_bitmap;
 	struct vhost_scsi_inflight **old_inflight;
 
-	struct vhost_work vs_completion_work; /* cmd completion work item */
-	struct llist_head vs_completion_list; /* cmd completion queue */
-
 	struct vhost_work vs_event_work; /* evt injection work item */
 	struct llist_head vs_event_list; /* evt injection queue */
 
@@ -358,10 +358,11 @@ static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
 	} else {
 		struct vhost_scsi_cmd *cmd = container_of(se_cmd,
 					struct vhost_scsi_cmd, tvc_se_cmd);
-		struct vhost_scsi *vs = cmd->tvc_vhost;
+		struct vhost_scsi_virtqueue *svq =  container_of(cmd->tvc_vq,
+					struct vhost_scsi_virtqueue, vq);
 
-		llist_add(&cmd->tvc_completion_list, &vs->vs_completion_list);
-		vhost_work_queue(&vs->dev, &vs->vs_completion_work);
+		llist_add(&cmd->tvc_completion_list, &svq->completion_list);
+		vhost_vq_work_queue(&svq->vq, &svq->completion_work);
 	}
 }
 
@@ -509,17 +510,17 @@ static void vhost_scsi_evt_work(struct vhost_work *work)
  */
 static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 {
-	struct vhost_scsi *vs = container_of(work, struct vhost_scsi,
-					vs_completion_work);
+	struct vhost_scsi_virtqueue *svq = container_of(work,
+				struct vhost_scsi_virtqueue, completion_work);
 	struct virtio_scsi_cmd_resp v_rsp;
 	struct vhost_scsi_cmd *cmd, *t;
 	struct llist_node *llnode;
 	struct se_cmd *se_cmd;
 	struct iov_iter iov_iter;
-	int ret, vq;
+	bool signal = false;
+	int ret;
 
-	bitmap_zero(vs->compl_bitmap, vs->dev.nvqs);
-	llnode = llist_del_all(&vs->vs_completion_list);
+	llnode = llist_del_all(&svq->completion_list);
 	llist_for_each_entry_safe(cmd, t, llnode, tvc_completion_list) {
 		se_cmd = &cmd->tvc_se_cmd;
 
@@ -539,21 +540,17 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 			      cmd->tvc_in_iovs, sizeof(v_rsp));
 		ret = copy_to_iter(&v_rsp, sizeof(v_rsp), &iov_iter);
 		if (likely(ret == sizeof(v_rsp))) {
-			struct vhost_scsi_virtqueue *q;
+			signal = true;
+
 			vhost_add_used(cmd->tvc_vq, cmd->tvc_vq_desc, 0);
-			q = container_of(cmd->tvc_vq, struct vhost_scsi_virtqueue, vq);
-			vq = q - vs->vqs;
-			__set_bit(vq, vs->compl_bitmap);
 		} else
 			pr_err("Faulted on virtio_scsi_cmd_resp\n");
 
 		vhost_scsi_release_cmd_res(se_cmd);
 	}
 
-	vq = -1;
-	while ((vq = find_next_bit(vs->compl_bitmap, vs->dev.nvqs, vq + 1))
-		< vs->dev.nvqs)
-		vhost_signal(&vs->dev, &vs->vqs[vq].vq);
+	if (signal)
+		vhost_signal(&svq->vs->dev, &svq->vq);
 }
 
 static struct vhost_scsi_cmd *
@@ -1770,6 +1767,7 @@ static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
 
 static int vhost_scsi_open(struct inode *inode, struct file *f)
 {
+	struct vhost_scsi_virtqueue *svq;
 	struct vhost_scsi *vs;
 	struct vhost_virtqueue **vqs;
 	int r = -ENOMEM, i, nvqs = vhost_scsi_max_io_vqs;
@@ -1788,10 +1786,6 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 	}
 	nvqs += VHOST_SCSI_VQ_IO;
 
-	vs->compl_bitmap = bitmap_alloc(nvqs, GFP_KERNEL);
-	if (!vs->compl_bitmap)
-		goto err_compl_bitmap;
-
 	vs->old_inflight = kmalloc_array(nvqs, sizeof(*vs->old_inflight),
 					 GFP_KERNEL | __GFP_ZERO);
 	if (!vs->old_inflight)
@@ -1806,7 +1800,6 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 	if (!vqs)
 		goto err_local_vqs;
 
-	vhost_work_init(&vs->vs_completion_work, vhost_scsi_complete_cmd_work);
 	vhost_work_init(&vs->vs_event_work, vhost_scsi_evt_work);
 
 	vs->vs_events_nr = 0;
@@ -1817,8 +1810,14 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 	vs->vqs[VHOST_SCSI_VQ_CTL].vq.handle_kick = vhost_scsi_ctl_handle_kick;
 	vs->vqs[VHOST_SCSI_VQ_EVT].vq.handle_kick = vhost_scsi_evt_handle_kick;
 	for (i = VHOST_SCSI_VQ_IO; i < nvqs; i++) {
-		vqs[i] = &vs->vqs[i].vq;
-		vs->vqs[i].vq.handle_kick = vhost_scsi_handle_kick;
+		svq = &vs->vqs[i];
+
+		vqs[i] = &svq->vq;
+		svq->vs = vs;
+		init_llist_head(&svq->completion_list);
+		vhost_work_init(&svq->completion_work,
+				vhost_scsi_complete_cmd_work);
+		svq->vq.handle_kick = vhost_scsi_handle_kick;
 	}
 	vhost_dev_init(&vs->dev, vqs, nvqs, UIO_MAXIOV,
 		       VHOST_SCSI_WEIGHT, 0, true, NULL);
@@ -1833,8 +1832,6 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 err_vqs:
 	kfree(vs->old_inflight);
 err_inflight:
-	bitmap_free(vs->compl_bitmap);
-err_compl_bitmap:
 	kvfree(vs);
 err_vs:
 	return r;
@@ -1854,7 +1851,6 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
 	kfree(vs->dev.vqs);
 	kfree(vs->vqs);
 	kfree(vs->old_inflight);
-	bitmap_free(vs->compl_bitmap);
 	kvfree(vs);
 	return 0;
 }
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
