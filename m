Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26F6C7EE43
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 841E240FCC;
	Tue, 13 Jun 2023 01:33:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 841E240FCC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=pRgefP8a;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=gKUoU8qL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G_IgGNZKmpp8; Tue, 13 Jun 2023 01:33:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6C55741142;
	Tue, 13 Jun 2023 01:33:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C55741142
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EECDEC0090;
	Tue, 13 Jun 2023 01:33:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06486C008D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 99B53402F7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99B53402F7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=pRgefP8a; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=gKUoU8qL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hvxoAywC0y9e
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 961784062C
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 961784062C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:23 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKO4GP029655; Tue, 13 Jun 2023 01:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=cNEUHtNF2jrBYK7Uk1TYCLwlP3Uqnya8GZEmTTCa2Zk=;
 b=pRgefP8aE4qCszybbyVFCGwO1wZ08rZEYWzbQKpTBbAi6sKjiYX5YW2jASV7H4ZKP2Bx
 B6WdYp4BgFBQbK19YTQUm+3mwm6CKek7dgPXzh9Mb2YodhdNqZBMkhqNiSf1w/xzKMu8
 ghO0SkGY+DgJICRQYTMXXXdpo2VngeL682I6obw7kZoEr6TkDKWNNOoHbmHAJX8xGrsC
 Uumk3kQHoQ9p/DIOTgx2VTathuTTLy284JyhNtfCOgPpqdNiign557YMiaizuws6TUcz
 yqRfeUVRt24ApBIB/VBzE8h2znTnXk7voH486XOnuAQ1RK0+A7+jBVPlrEkB6Z7D8j2e Mg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2am5qr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:22 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35D16qfx016231; Tue, 13 Jun 2023 01:33:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3hhyq-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xglr3QzAp2MNkPsWbb8Nt7hb7KMEuzNcQ/6Oxj2cRTfcLOYa96lVoKw9CyKD2bYvIO3mshhz5adVy/3+AEt1gXXsi5iuAmEsDrDsGAsvWAy5xhAckyHXZmZn6dh/RAy1n2w152f2yBGsQCmqym6DDEKMPP7WwDV+AemlU0WJJ6e7uaY3q14MZEGBFq2JKSO2a32cFywLX3r+55gNdyUedftvWYzabBpFlvPJ5aORxJ9sZ96NEIja2JGf/3Ft6L4l05AXyYJqqmyYpLlxJ5ArpZQCcXi3Xg8KDlVJZko0AKH8IPRH1zFq6s9xyrq3di5Vg0cA6uxMhu+2IfAvkeas9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNEUHtNF2jrBYK7Uk1TYCLwlP3Uqnya8GZEmTTCa2Zk=;
 b=mwikrHRjd/3ULbEiPuNQ8Xu9aAGthwXJZ8kLbPmYQk5GOcm5J1xQFc8CtQ0nxVcit2dFQ+HeQeYhr3eAYm5QUWjb6z9UV4GeHLS4rvkaOShYXYWF3E6sP6DcSenQ/VVPCCIl0w66czEkDccy20lBQaFGFFsBzsAv9a0s2UID9nF+FOEbZkNuaOIxhUjsz5nj3+YhW/Ba5MQSOt05USKgq6fUPhT9eUuJAT80kZwkaZ5voAkEkWV3EY57exatJwczbudYCaBcVh2LOAyKt0R3j9wG05vy9Y1eeEUH4kOZ2KF6+aQIk1J/nQhInFxAc79w5BEUxAGiCAAIKaFwU2rdKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNEUHtNF2jrBYK7Uk1TYCLwlP3Uqnya8GZEmTTCa2Zk=;
 b=gKUoU8qLZ3IPSk15MYX9/5Mtxz78GDiZEnFQ876LLiRiCjbe4dhDMIJy27a1yywjROgvak5o8t65Y3FfRipD4TKSUOt7X/aCvSfvrzj+kQcv2FiZPNAQEtnz8j5O7lSnyHUtA850IohjhP3zLraPD5KYoJ8g/IPO5aMFKjvTHYI=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 01:33:17 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:33:17 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v8 15/17] vhost: allow userspace to create workers
Date: Mon, 12 Jun 2023 20:32:46 -0500
Message-Id: <20230613013248.12196-16-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613013248.12196-1-michael.christie@oracle.com>
References: <20230613013248.12196-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:5:333::8) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3616f6-e9d3-4940-cea1-08db6bae29a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kNlR1sQWHo9ZRvOnNemBsux7btT5+eVq9QX7NUSvEtxVrrxuQHU43Pe8CcfKzGn9+Y5o2Et9x98CTxbcrgaHhKnUicoZev2iRECUlqxl6xSILe0oe33afPW+uUkLY7n+M4Q2ZrLrWScP+w+84JaNYr8m8lcceWfCiIw0m8UGuQxKcJZDEOOl8k1xTgUi74UdlATqYyod5DeeFIvxvgQe3K3Tn9IByvDwsSPbqTIT5pYUW7ftLGN0B+SCZR3pKHL7S7lJgl7q3QywleSWWKHV362MComtYcRanLqqFL0lamVhSBcdN43KAQfuNgV2A8F/lKKONuwqExrCAGL3Gd0SF7rlGhPSE59SK5170t9oVCwL3FQKfAlBvkdtOECEyUSoRWompx31GH2Hi7UJ1HszMLEhEqNeGRQWcEUNK4Cb7By1lFKZhYXNRTWk/S9q/pfdHbyt+OJxC7pdwo0LQwYFcU4F08ga0okGNKInLE8Vj7VtVHAZJZGBG+1nAxtrC+/0miV9YKtzXaIz8L13wTG4EZEbLjCRwMZ5vLr2O8Hp3V1gPXEI0jbxKZ9IlGE1DzXV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(36756003)(86362001)(66556008)(4326008)(478600001)(66476007)(66946007)(6666004)(316002)(107886003)(6486002)(8936002)(5660300002)(2906002)(8676002)(41300700001)(38100700002)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u9bIJd7IV5pmrfbXxuoitBuZVqMAFIjQt+nAvSWIzre0zmnIXwXxnIMXujup?=
 =?us-ascii?Q?CrSXX0RIggnd++qy+4mzPGuOQ0HIpgsNNBvdCqHfYNqKqhvr5a0LDR0MjB2i?=
 =?us-ascii?Q?zD9nf//ixK9KepkGY7zvcf78zTzpMrfyFMGimSDsWtpDjZgpMK5vGd+XZQLG?=
 =?us-ascii?Q?OObrQYI/U3EawH1k49paaKyQRlXG++06QMtEpdzVEcP8z3qkvv4QYPhk5LU5?=
 =?us-ascii?Q?ptOPbBRR96B6FL1Y3fktTFZfgXfq2ZjhX+GHp2T07uGc6r4wZNweUByFdXUM?=
 =?us-ascii?Q?VeMls5F6+eNsjIpbn+1PdaG5x7V9lIrVl0IxMCKdSJTFB2icd7OveI+ys/BF?=
 =?us-ascii?Q?se3o9apKHSuXWlId8O9GJAU5tEdA/Hf6d8EDWz+e32sguw1U8kk0Dv8/TxNp?=
 =?us-ascii?Q?lcxqJcMaubA8sG9twAeK14Dpr9f00vKtFb903hBFaHxn2lV3Ij3VKtmkMrdl?=
 =?us-ascii?Q?ze7YmDl9IQbxhT3f+9TpFctvJbqxfeT3AaSaPKWYcFQfI3uIFFexv7lP6M6/?=
 =?us-ascii?Q?69pjh40b4DlInFdtnaNPhWkBCnEmeobVPCBr1OrUFbdCAJ6XxVblo9F2/P9e?=
 =?us-ascii?Q?ydIjL0kc6wNnChqoZNu/HtNg140JSZ2bXyE3oI7hTXWJVqoXbLJLzh6CiTQ1?=
 =?us-ascii?Q?C9MOAAkrdjmEMkDEBlhLsUX1ZZrgZmqkghkAJpdE9ngiBVRydwikBalOKcAp?=
 =?us-ascii?Q?HTw2VBsXKzIEEFoqMMVe13oAYu9rz02+EsYBSCWZHu2jkhYbF8oQnqJBfrXT?=
 =?us-ascii?Q?F1wWCtRh/ZrUP4ivV/7yVuFW9o5S/GcH73Wx0oOiKw2/u/9Jw3K7xdXYexpq?=
 =?us-ascii?Q?EiNAHGgjuWMtPXgeDY+PuqBZj8ph+y0ggYy5lG2ZJXXMcvusIZbQxE924PSF?=
 =?us-ascii?Q?nAw2WEg5MiMJVi3kpjQEhMoQm9RSJTnjuXQwPX0Rxdo3aY/P/88cGd8ogiYz?=
 =?us-ascii?Q?j3ApVbYbVOP3c5JKVKL/8aVl2xII5NizhRqm0dMINgDBlj0Nsa5bkiAFAFtO?=
 =?us-ascii?Q?HjjtcYnz4DSN84FjtM/ybQlXeefCd5LAJiA7czJY3XOWAmtuwXcn391ty3yh?=
 =?us-ascii?Q?dXNbdoyOXODP57XOXB2/tX/ZxQ7dQFC4NTK4RsEt+fkWFz2URiJqwa1WLV55?=
 =?us-ascii?Q?x1tfQ+r8kSOYji2wxup1e9afWZ9t2x7HMwJJHe1ehlWEA6EoVZN1+fSGaIhE?=
 =?us-ascii?Q?UzkYQL0QFGhlJ1STs+EBpJbc475nCF/ZZG4iXfANFs1O2QQUCXrK+a/DNOmE?=
 =?us-ascii?Q?3GyW3YpZGZanT6xRDMPAJScrHVDgx9IH9xyAfKQ855JKKoUi/QzkLX5ej0QB?=
 =?us-ascii?Q?6Anl6tEJwcnMM4pH3R/rRJs5tqeLawYcZdeJWy0VLvxNuuKpgje8rjM+FKPs?=
 =?us-ascii?Q?bktHf2l1D0YIxcNnz06p91X6GrH6Rd9B72hlGPnjg2AWpmQCnohHokyp9OBZ?=
 =?us-ascii?Q?6o5ZQQatdRj2k4pg79p0HTgStrDLgcCbqy12JBvQjxFQ91VUzbkfU9OK5BQO?=
 =?us-ascii?Q?iX3HLZce2/ZFI8W/lHLpq1vo+Oj7qlu2grfX8Xvd5kZemhP67uIoh3yprEMn?=
 =?us-ascii?Q?EvjJClP0p+OKpy+/A5N5mT8wZVBCXLx9SMFwHS1OOgPzjJNZTQW9G6SlDR7x?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NzirkSHDzCgfnbqKlhrHiFaabYTRFGRJ2XppEYM6/ojZScivnNaXy9HcovJ7Sn1R5O3vCVBHYCPu2QrMRFFYON8BmUXznmZxXijG4L1s76weWVsOsTA1IpGXZwCpknprc++H7nP0CiNza7LoGtY2CZd+SQM1nMkHvd9h+5WLLKMYVaEipaBzRGBJqQ6Wyrlpz7Wf1rfjArjrJpkszdAxzfDypymLm8ouyR3j+nh3u4xvJ7Ktdzq9QpZEWiYnLS2l0a4iJU83jv19Q0kTSohT5YaZqFwiyYn3jDH6M5fxtuESUXcY/Ew5O/I0uaTk35PXyzz7C25GrgOObqQGtT+em0PZe1lGF7A5T8t5x9SlYT2xBwAA3dkDg7wg+DHCtiLH71o6FQCuxQJEKsHEHsJBtsOMPLIFVy9ZyX2BPLKLysVzVwBw/7NZxGLQf0d+hbnMh7dwRgKIanzFAi6hZSk23KCL4OL75WihTHAdJbTYx1FXDW9ribyqGusuddYSVttJNGrqqeY2C4w3P+eax7U8dM0/MrshRuPb+Yre22wxWnSBX6NGE4X99a9sCbF4xmWnk+Pe0VhW/vjbN714zmP9mVSBMxvkkcdKV3VoNoehJ9i2yi+a2NAZiSn8OwlrQkKRkiK8mYRqP8pMyOMP/i94JPFv1AXX+gEKKRY7Vi4Qa5XV2zt0Ocx7kqb09rB/RpgcV8Ext/YBK89jyTYY/x6hUStdSgN/PCKWz4Rvgp0jJUnS6Zrhx5Y1RrbLI2kvzfN964pVgjA0WW2PhrcYXGY0pg0e2Ec3WuOtrQpzJylP5xM6snNiOx73mFALZ93uAiws
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3616f6-e9d3-4940-cea1-08db6bae29a1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:33:17.1316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVGzyxoZCTcpHL5/QpNU+CDj4SVDXjOQYJrtY4ClEntdGy+iduca3X0ace+kRt3eXNTvLrK1kSsvluNeU3nvmHR3+ktYyrkABo1C9MUSZ9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130012
X-Proofpoint-ORIG-GUID: TQH4Rv7P8QMp1V6v6_i7jEGAWz7rP4J0
X-Proofpoint-GUID: TQH4Rv7P8QMp1V6v6_i7jEGAWz7rP4J0
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

For vhost-scsi with 3 vqs or more and a workload that tries to use
them in parallel like:

fio --filename=/dev/sdb  --direct=1 --rw=randrw --bs=4k \
--ioengine=libaio --iodepth=128  --numjobs=3

the single vhost worker thread will become a bottlneck and we are stuck
at around 500K IOPs no matter how many jobs, virtqueues, and CPUs are
used.

To better utilize virtqueues and available CPUs, this patch allows
userspace to create workers and bind them to vqs. You can have N workers
per dev and also share N workers with M vqs on that dev.

This patch adds the interface related code and the next patch will hook
vhost-scsi into it. The patches do not try to hook net and vsock into
the interface because:

1. multiple workers don't seem to help vsock. The problem is that with
only 2 virtqueues we never fully use the existing worker when doing
bidirectional tests. This seems to match vhost-scsi where we don't see
the worker as a bottleneck until 3 virtqueues are used.

2. net already has a way to use multiple workers.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c            | 141 ++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h            |   3 +
 include/uapi/linux/vhost.h       |  33 ++++++++
 include/uapi/linux/vhost_types.h |  16 ++++
 4 files changed, 192 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f07f92a67e59..a4f97b56f1b4 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -623,6 +623,76 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	return NULL;
 }
 
+/* Caller must have device mutex */
+static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
+				     struct vhost_worker *worker)
+{
+	if (vq->worker)
+		vq->worker->attachment_cnt--;
+	worker->attachment_cnt++;
+	vq->worker = worker;
+}
+
+ /* Caller must have device and virtqueue mutex */
+static int vhost_vq_attach_worker(struct vhost_virtqueue *vq,
+				  struct vhost_vring_worker *info)
+{
+	unsigned long index = info->worker_id;
+	struct vhost_dev *dev = vq->dev;
+	struct vhost_worker *worker;
+
+	if (!dev->use_worker)
+		return -EINVAL;
+
+	/*
+	 * We only allow userspace to set a virtqueue's worker if it's not
+	 * active and polling is not enabled. We also assume drivers
+	 * supporting this will not be internally queueing works directly or
+	 * via calls like vhost_dev_flush at this time.
+	 */
+	if (vhost_vq_get_backend(vq) || vq->kick)
+		return -EBUSY;
+
+	worker = xa_find(&dev->worker_xa, &index, UINT_MAX, XA_PRESENT);
+	if (!worker || worker->id != info->worker_id)
+		return -ENODEV;
+
+	__vhost_vq_attach_worker(vq, worker);
+	return 0;
+}
+
+/* Caller must have device mutex */
+static int vhost_new_worker(struct vhost_dev *dev,
+			    struct vhost_worker_state *info)
+{
+	struct vhost_worker *worker;
+
+	worker = vhost_worker_create(dev);
+	if (!worker)
+		return -ENOMEM;
+
+	info->worker_id = worker->id;
+	return 0;
+}
+
+/* Caller must have device mutex */
+static int vhost_free_worker(struct vhost_dev *dev,
+			     struct vhost_worker_state *info)
+{
+	unsigned long index = info->worker_id;
+	struct vhost_worker *worker;
+
+	worker = xa_find(&dev->worker_xa, &index, UINT_MAX, XA_PRESENT);
+	if (!worker || worker->id != info->worker_id)
+		return -ENODEV;
+
+	if (worker->attachment_cnt)
+		return -EBUSY;
+
+	vhost_worker_destroy(dev, worker);
+	return 0;
+}
+
 static int vhost_get_vq_from_user(struct vhost_dev *dev, void __user *argp,
 				  struct vhost_virtqueue **vq, u32 *id)
 {
@@ -644,6 +714,75 @@ static int vhost_get_vq_from_user(struct vhost_dev *dev, void __user *argp,
 	return 0;
 }
 
+/* Caller must have device mutex */
+long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
+			void __user *argp)
+{
+	struct vhost_vring_worker ring_worker;
+	struct vhost_worker_state state;
+	struct vhost_virtqueue *vq;
+	long ret;
+	u32 idx;
+
+	if (!dev->use_worker)
+		return -EINVAL;
+
+	if (!vhost_dev_has_owner(dev))
+		return -EINVAL;
+
+	switch (ioctl) {
+	/* dev worker ioctls */
+	case VHOST_NEW_WORKER:
+		ret = vhost_new_worker(dev, &state);
+		if (!ret && copy_to_user(argp, &state, sizeof(state)))
+			ret = -EFAULT;
+		return ret;
+	case VHOST_FREE_WORKER:
+		if (copy_from_user(&state, argp, sizeof(state)))
+			return -EFAULT;
+		return vhost_free_worker(dev, &state);
+	/* vring worker ioctls */
+	case VHOST_ATTACH_VRING_WORKER:
+	case VHOST_GET_VRING_WORKER:
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	ret = vhost_get_vq_from_user(dev, argp, &vq, &idx);
+	if (ret)
+		return ret;
+
+	mutex_lock(&vq->mutex);
+	switch (ioctl) {
+	case VHOST_ATTACH_VRING_WORKER:
+		if (copy_from_user(&ring_worker, argp, sizeof(ring_worker))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = vhost_vq_attach_worker(vq, &ring_worker);
+		if (!ret && copy_to_user(argp, &ring_worker,
+					 sizeof(ring_worker)))
+			ret = -EFAULT;
+		break;
+	case VHOST_GET_VRING_WORKER:
+		ring_worker.index = idx;
+		ring_worker.worker_id = vq->worker->id;
+
+		if (copy_to_user(argp, &ring_worker, sizeof(ring_worker)))
+			ret = -EFAULT;
+		break;
+	default:
+		ret = -ENOIOCTLCMD;
+		break;
+	}
+
+	mutex_unlock(&vq->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vhost_worker_ioctl);
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
@@ -681,7 +820,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 		smp_wmb();
 
 		for (i = 0; i < dev->nvqs; i++)
-			dev->vqs[i]->worker = worker;
+			__vhost_vq_attach_worker(dev->vqs[i], worker);
 	}
 
 	return 0;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 31937e98c01b..4920ca63b8de 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -31,6 +31,7 @@ struct vhost_worker {
 	struct llist_head	work_list;
 	u64			kcov_handle;
 	u32			id;
+	int			attachment_cnt;
 };
 
 /* Poll a file (eventfd or socket) */
@@ -190,6 +191,8 @@ void vhost_dev_cleanup(struct vhost_dev *);
 void vhost_dev_stop(struct vhost_dev *);
 long vhost_dev_ioctl(struct vhost_dev *, unsigned int ioctl, void __user *argp);
 long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp);
+long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
+			void __user *argp);
 bool vhost_vq_access_ok(struct vhost_virtqueue *vq);
 bool vhost_log_access_ok(struct vhost_dev *);
 void vhost_clear_msg(struct vhost_dev *dev);
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 92e1b700b51c..155710585979 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -45,6 +45,25 @@
 #define VHOST_SET_LOG_BASE _IOW(VHOST_VIRTIO, 0x04, __u64)
 /* Specify an eventfd file descriptor to signal on log write. */
 #define VHOST_SET_LOG_FD _IOW(VHOST_VIRTIO, 0x07, int)
+/* By default, a device gets one vhost_worker that its virtqueues share. This
+ * command allows the owner of the device to create an additional vhost_worker
+ * for the device. It can later be bound to 1 or more of its virtqueues using
+ * the VHOST_ATTACH_VRING_WORKER command.
+ *
+ * This must be called after VHOST_SET_OWNER and the caller must be the owner
+ * of the device. The new thread will inherit caller's cgroups and namespaces,
+ * and will share the caller's memory space. The new thread will also be
+ * counted against the caller's RLIMIT_NPROC value.
+ *
+ * The worker's ID used in other commands will be returned in
+ * vhost_worker_state.
+ */
+#define VHOST_NEW_WORKER _IOR(VHOST_VIRTIO, 0x8, struct vhost_worker_state)
+/* Free a worker created with VHOST_NEW_WORKER if it's not attached to any
+ * virtqueue. If userspace is not able to call this for workers its created,
+ * the kernel will free all the device's workers when the device is closed.
+ */
+#define VHOST_FREE_WORKER _IOW(VHOST_VIRTIO, 0x9, struct vhost_worker_state)
 
 /* Ring setup. */
 /* Set number of descriptors in ring. This parameter can not
@@ -70,6 +89,20 @@
 #define VHOST_VRING_BIG_ENDIAN 1
 #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
 #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
+/* Attach a vhost_worker created with VHOST_NEW_WORKER to one of the device's
+ * virtqueues. This must be done before VHOST_SET_VRING_KICK and the driver
+ * specific ioctl to activate the virtqueue (VHOST_SCSI_SET_ENDPOINT,
+ * VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING) has been run.
+ *
+ * This will replace the virtqueue's existing worker. If the replaced worker
+ * is no longer attached to any virtqueues, it can be freed with
+ * VHOST_FREE_WORKER.
+ */
+#define VHOST_ATTACH_VRING_WORKER _IOWR(VHOST_VIRTIO, 0x15,		\
+					struct vhost_vring_worker)
+/* Return the vring worker's ID */
+#define VHOST_GET_VRING_WORKER _IOWR(VHOST_VIRTIO, 0x16,		\
+				     struct vhost_vring_worker)
 
 /* The following ioctls use eventfd file descriptors to signal and poll
  * for events. */
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index c5690a8992d8..d3aad12ad1fa 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -47,6 +47,22 @@ struct vhost_vring_addr {
 	__u64 log_guest_addr;
 };
 
+struct vhost_worker_state {
+	/*
+	 * For VHOST_NEW_WORKER the kernel will return the new vhost_worker id.
+	 * For VHOST_FREE_WORKER this must be set to the id of the vhost_worker
+	 * to free.
+	 */
+	unsigned int worker_id;
+};
+
+struct vhost_vring_worker {
+	/* vring index */
+	unsigned int index;
+	/* The id of the vhost_worker returned from VHOST_NEW_WORKER */
+	unsigned int worker_id;
+};
+
 /* no alignment requirement */
 struct vhost_iotlb_msg {
 	__u64 iova;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
