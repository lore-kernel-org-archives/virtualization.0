Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DE1C7EE2E
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D59AB40972;
	Tue, 13 Jun 2023 01:33:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D59AB40972
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=J3OrAXy8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=ruEifP2J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y1uGonnPwo-G; Tue, 13 Jun 2023 01:33:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3BCD2408EF;
	Tue, 13 Jun 2023 01:33:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BCD2408EF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6662EC008E;
	Tue, 13 Jun 2023 01:33:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EBB0C007A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1907F60D9D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1907F60D9D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=J3OrAXy8; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=ruEifP2J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d_9PBwHBXXLm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D77A60D70
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D77A60D70
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:17 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKNtTL003081; Tue, 13 Jun 2023 01:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ooMEXyzPIpy+NG0Qpbh+a+dBgX81ShVFiwyCkyscAYk=;
 b=J3OrAXy8Z66lJYS+omG6R1cpfBC3BkYuv+DJ+Id+uh8uP5lWO9btlQEqHdw5VqwQfBTf
 NX4TasMTFxYJXUpLF6lZSkjQwbtTHzog6LJyZVQPH6BvSq3VDDbMHVx1AjeK7Z0HJRZt
 Vl5lh0/cHY7iAVeX/SEUyhim9zB0JAOQs32BpGfxeoewLlwC8VmhT69oZtZwG30A/OVx
 KOyjvVKEPmpyjmh4qFp6TiZDGnI6KGzglowDgcfypC/1EF6QeXGEf3wzCgPToSet4K3c
 nTRWtwBT8k4R34bTtYsuMgZqndteHcSouwldqmoXu9jk9u0I9A5OeXRqHqVD9RzZ4HFT Kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdm45x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:16 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35D1CJRB021613; Tue, 13 Jun 2023 01:33:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3hg44-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTYEw9szTinp/CfhfsDol3wDv69Nc8AT+Blc/ZWP/STKvQ9mfQPP+vbykYY45kCW/q8xMVje0nTZSlQ9h8Blo86Do1RoLSBQtdY9oWnxE7kd3eT28uNm97+Lmg4cRpdim+Me6B0u1ME0pfbU6UQhcbJYvOiKwNm7drWpbu56pbhWrWZJaxFslTUPNrKvqF/Q4TI+S20LJiWIhhPxDpk/k1uoEB/0T+fK/S9UCTtLWLLGCi1XO2EfvvNVUW067SjBDdXbB09wQC1mmxhq+gBxPk4JT1nbCELY0gFj5c8nlRsU1rHB+zorFC8FwgjKQBqEYhtxCKGbz1rGF0dVGCHU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooMEXyzPIpy+NG0Qpbh+a+dBgX81ShVFiwyCkyscAYk=;
 b=nRi7E6m2lSS2lgyO0iPNN2zQHz/Jm6MN1clxCEM90GrAtyiBQLY2aysZb0pt4xYd/voRWPA2TQZ9qxStXOup5iASa4IsfN2FcWR5sVUwG4eSYMHXHr8pLIA4CD2hOg4SHsqpuksKTt2aAMT5SJL7YyFGO/SVQQHcdI8v8hEkOAbhq4z3diBv1oRtjDMC6xRXAujVRhBP0zHSQO1p3WkVX3R9bKWC6Xkam/iFZBv6HaaDkXQLejTmSBr4TGSk+XW4o9q8o8ISF0/2+X+bynDLUK0AskNNaJBWj0WCYqYB8u7SvafgaJMfihA1pLxJOqIyLFh9Qrm2BSbbZT2wx54ohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooMEXyzPIpy+NG0Qpbh+a+dBgX81ShVFiwyCkyscAYk=;
 b=ruEifP2JJ060Hars96z/80EW0KucLutuKBmZ88YE+k8hXAF874pOrArjx29jejtY47u20m8t7WLLXROEsiGiYfKPIbgGW7LKqlMfAQH+RLudEXtvBvy0DHdSEV8sU6PLmz9ePZ+mDTAhOrnvf1QrgHI3FE7oSdrgIqbPf+z8DdY=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 01:32:56 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:32:56 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v8 03/17] vhost: add vhost_worker pointer to vhost_virtqueue
Date: Mon, 12 Jun 2023 20:32:34 -0500
Message-Id: <20230613013248.12196-4-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613013248.12196-1-michael.christie@oracle.com>
References: <20230613013248.12196-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR06CA0081.namprd06.prod.outlook.com
 (2603:10b6:5:336::14) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: a4464de7-8712-4342-db8a-08db6bae1d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXM8VQVa8UKzQBbRygdhTi8h52W3D4MhAa6u8oYMIzZY7zOFcSrTiLl0YbpwroMKIgBibNURAww3lLhJ+3yRxLBKCk/LvNtA8JuCktAF/M61IU3DxdWqrJUd73UpvDdyjGOgzEira/Ut48RwS87dKEB5m7bNRifizhlsIjAYCwZpcN921cyWNFh7o/uV4WW1EMpyunpQhdy3T5VpyfcnW69K4fYLo1lM6fQZywJk4i/QyexC54s770eFYE6s2a/EGnrpzbbuUE14oJo5r8p/g4VOMh77JRSeUUr0IcP+bhxNoMdqLwly9owTjLH2VWFzdPR5XD3vf+QKv9vg/Bkaz3YWG8I686/k5yVXYXePznUXkj6GmZOMBeRZPKikSY8fguzGLTqVkdVjHWKp6FX5kakiRdevQBCYGhk7azpo2si+huv3/sJohQQFo6d7eZ/fVS2R6j5yt9Z2n97jO7dc7o4RdUvEPLa7zvoB/K1n/qg2F07uf35hXLWydd4qxl6ESWlgXmi+0GAIy8ltiwJDQMuG5ufgKut2AsIIErLLtRdIKph+v2uASNBsS7PK6gbx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(36756003)(86362001)(66556008)(4326008)(478600001)(66476007)(66946007)(6666004)(316002)(107886003)(6486002)(8936002)(5660300002)(2906002)(8676002)(41300700001)(38100700002)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FefhslrHRcRVUzbG957UIUCoq6hqVcKJ6ukv0B/tbQ5iiyEXikdAjsoMsyP7?=
 =?us-ascii?Q?KqrMhF1VmpcsWT8ri7OrAPDNZbrObNNh4lmZ/t/z1EO9zpu6qxVZMbuyNKbw?=
 =?us-ascii?Q?SlSsVmQnzBAuglNlGrRAX84xH0Ryru9Rh9tPOE+mXx37haJ2zDm3CegLqbp8?=
 =?us-ascii?Q?ZJec7P2FEEmZD1JVPT0KFggp0cM3HUAk6vhbSSU8uSPNJlFZMGiijQnRWC0U?=
 =?us-ascii?Q?YCLAXFgHA71OOWJNpaE0LzODGY7HNVxByL/3u91lX5ENXWcQvyoFN/FVuALM?=
 =?us-ascii?Q?hfhoMpJLR8d/3fCtFf+W0DxGqjUaQifsHZmPLJUOfbMDsSbdyze+ze2UV5nA?=
 =?us-ascii?Q?Qg9y1AFKVfrC9G6wCeB14XFZJfdYsiu6iOM8ffWo0Vs65DRFo15HVUNp2Wnx?=
 =?us-ascii?Q?dvqkYHKyo/IG+XFqGRj6XiJ8qeKiT6+EkUFhudd/7OLhzICuV3u58N15djlC?=
 =?us-ascii?Q?tv1R5l7OxXJaM+iVgaQINZ+Q6qjkbtwtuZ2k51RozQzRuS8geMCH52xUXESP?=
 =?us-ascii?Q?9zLAa/0tWChc8MP27dhS0x9W/0H1BsxX1yrd6CzWUJuNEbB0D4s2INQ0XvBz?=
 =?us-ascii?Q?C4iJGyGPgzlD3JLJ/SmS178WTkY6RU6X7KHCFJkNtbDAdfa4wrBaQFObyMn/?=
 =?us-ascii?Q?mjwm34rubgHcdn3gYcIeBaLkmTecVjJhC+3EiBwfN1Ouabdh9DoNkDkvvxVf?=
 =?us-ascii?Q?+OGZVT65E9lz2pK+0QXpO5Y+fF0YjZP/N2Zif3LDk956Mt3Ni8qyqId99NuW?=
 =?us-ascii?Q?L5iY4J3Cour4I0MSWtbJu3S3Lf2is3x1xefoY6PnvowXAJQuUeSxqHgDgZ3W?=
 =?us-ascii?Q?35y8aTb+Cmx34jldJ+uRalnQuF13OYEQ6JvuZ8ESBKLsVul+kITAIUi/8OhT?=
 =?us-ascii?Q?TMF6xMAucEWjSU9oHQ5xIxyw+SQaX6sIPfKY1YwSPgkH9gdW/6YYrz3g/3bN?=
 =?us-ascii?Q?rEisaDZAaiQlNFMXTU0D9clprZy7sEERoYAAITRD7IULkli2sM2zQAFYrbs2?=
 =?us-ascii?Q?fpp9cd3j5m5OHJDyh29fMLI0bhn65kZflh5K/+RplNCGU9I60S10ee12S/zz?=
 =?us-ascii?Q?qigvp4Y3Ymy+9XuJdSM/HcYPnBm/iN52CnWw7ryjCOrouTB5eSY0vUvVQHgU?=
 =?us-ascii?Q?2iZDAzJXrw98Bsa7OYNOpqhSpjUX/Z3GjhI0YqZuBqVpvlY8Jinuye0yiP4W?=
 =?us-ascii?Q?lIaMZqOKHcOF8nMSfTv+MOf+5YN4892vWUIbhrk5r8/E59/V9kr6vDtLLUCY?=
 =?us-ascii?Q?unuJa6h/3p+mw0+pjoI8M9Bl4bC2MG8jqxyAdezfhWk0XuASmyBsIO+8IuzG?=
 =?us-ascii?Q?lGkUNb4tdJflZvuVVuCIBIIFhcY2anctvFOc68VaVb1eda9RdvcLW5slOQiL?=
 =?us-ascii?Q?QxKca8tnKxVQimxn4EmcjWStdg0HWxfJH06zYAHn8+Q9LZQI7/cOHa/sThYe?=
 =?us-ascii?Q?eqBTax9WN5f0/miZduXIg9BOqfTi5fQF27Zi++pCyIaR+vgR5ADKcUqr/n8+?=
 =?us-ascii?Q?spnwKesImVcwhp3rAsc1yt6k3LsxowdtSikBlpc1G1Mfu5D6OnvSA0hEdlvR?=
 =?us-ascii?Q?VwrfdjCkakqMUkxBJbqCymRKZG7RD7X6p0oZWLwzboEk0lmRgW3sGuNhdO9Y?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gMPP+EtAosqrQ2d+QXK7MsKHYmrEM3U43S0Tp5r7U+oxDlldfWaobdKjxMkqIN4zOOT3sHop/ylBYm/oPuuu5xWc3chw8oFuXfZdEoZfFMbV4mL2MHgwwbPH3qmCKaQZtptS8WhAgVt9Yg49O0jnPNVOulVPOgV5XmMgpWQNUTZX4eiUr6hiTn5xLV30TUGSUhfSGSM1qWo1zTcPVrocmmN7QkXuYwiRy/6QYJ9re+KoRtHPfzdHxaniolmF9rOKrRgZ+WLKdilDh/ivrboMaESD2m5zvpSd9DYNmnUSrvuq8FoblC+5LyT3PxNEP55yY9ykaJD3Pn5dxatkHhHIaKMjScB0pe48q1nchdwOBTjjhnQvHYPDwkrqVVe8kyRfJW9KoDmyrgcRAktlraTH+IRapLQr0ctcazr1t3ctQS8F+P69R+/ouaswEzSe9tpRwAEFmuS+FJVoJV2tQCr6757ZNjx5vDZ0WcMD0GDOM8HbJIfdKjRtPZxZ2c8iqyNpAtEp8/aH0yTdAIfveUpAvF3OkpY1uocTQGJ5byuo1nBsTjpVxszGGmwPUQrtKdOUQKu98Ji2A6dOiHNw0jMsDRCTJEb7x4CzlSs0WfnIWxE9huJ9Sp+vMuNMf0ALYrAxNav0K0KaN6vdmuEGPFCGAspDJdt+Twb6LlSi3niwmswgXKgNxGUv8V7qWqStajV3d+z8A+6+lXi1s1WxtyNf0y+uJWxFqMqxKnzL83GVy+Ph4fD6xud91Uld5HCdXPi9t0CxO23F7hsXFIxXnuCilMPShkQf4bd3SEPcUUZX+4uuGsUiMTfXRk6Ao9MZVgpe
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4464de7-8712-4342-db8a-08db6bae1d40
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:32:56.3355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TNR0JIhFPKDSte8iWtcR1aWO2vUt60fUMG1URP3ht+Q+G+hQY82bdN5Kr3V1h1tgCr2xgzq4OjDQfV4Uq8HSv8UGEE+Pg7gFSQRwwqSSsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130012
X-Proofpoint-ORIG-GUID: 6vsxlwiBykQpQclIJQJxlLIE5HEEgYgC
X-Proofpoint-GUID: 6vsxlwiBykQpQclIJQJxlLIE5HEEgYgC
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

This patchset allows userspace to map vqs to different workers. This
patch adds a worker pointer to the vq so in later patches in this set
we can queue/flush specific vqs and their workers.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 21 ++++++++++++++-------
 drivers/vhost/vhost.h |  1 +
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index dfd96cf6a152..c78c15af97d3 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -479,6 +479,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 		vq->log = NULL;
 		vq->indirect = NULL;
 		vq->heads = NULL;
+		vq->worker = NULL;
 		vq->dev = dev;
 		mutex_init(&vq->mutex);
 		vhost_vq_reset(dev, vq);
@@ -545,7 +546,7 @@ static void vhost_worker_free(struct vhost_dev *dev)
 	dev->worker = NULL;
 }
 
-static int vhost_worker_create(struct vhost_dev *dev)
+static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
 	struct vhost_task *vtsk;
@@ -553,7 +554,7 @@ static int vhost_worker_create(struct vhost_dev *dev)
 
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
 	if (!worker)
-		return -ENOMEM;
+		return NULL;
 
 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
 
@@ -572,17 +573,18 @@ static int vhost_worker_create(struct vhost_dev *dev)
 	dev->worker = worker;
 
 	vhost_task_start(vtsk);
-	return 0;
+	return worker;
 
 free_worker:
 	kfree(worker);
-	return -ENOMEM;
+	return NULL;
 }
 
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
-	int err;
+	struct vhost_worker *worker;
+	int err, i;
 
 	/* Is there an owner already? */
 	if (vhost_dev_has_owner(dev)) {
@@ -603,9 +605,14 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 		 * below since we don't have to worry about vsock queueing
 		 * while we free the worker.
 		 */
-		err = vhost_worker_create(dev);
-		if (err)
+		worker = vhost_worker_create(dev);
+		if (!worker) {
+			err = -ENOMEM;
 			goto err_worker;
+		}
+
+		for (i = 0; i < dev->nvqs; i++)
+			dev->vqs[i]->worker = worker;
 	}
 
 	return 0;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index cb872cc4157a..206617edb2a9 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -74,6 +74,7 @@ struct vhost_vring_call {
 /* The virtqueue structure describes a queue attached to a device. */
 struct vhost_virtqueue {
 	struct vhost_dev *dev;
+	struct vhost_worker *worker;
 
 	/* The actual ring of buffers. */
 	struct mutex mutex;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
