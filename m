Return-Path: <SRS0=0+SM=OG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119E7C433F5
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6BE60FC0
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA6BE60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9125883F41;
	Thu, 16 Sep 2021 21:21:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rP67OA8BN24l; Thu, 16 Sep 2021 21:21:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 30E0483F20;
	Thu, 16 Sep 2021 21:21:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3E45C0021;
	Thu, 16 Sep 2021 21:21:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E0EDC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50461406FE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Z3KOGc+b";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="CP+uSeD0";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="z3UN1B9F"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZBDqWcllQ_Nv
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C074840490
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:09 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GK0IWO009079; 
 Thu, 16 Sep 2021 21:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=fa4XamKFhDBigC5x33aJYAwIT8MyC+C1rH8EcMHY1pM=;
 b=Z3KOGc+b+p0S6Ft3PyQRTSSivmCKh2lABZyF6MiU5Zc+YF4wPsMQ3LB0VdWic1AlSTI/
 b8mMOhKihHSBigUzeiveYXXDPH21vg2uJs9sZ4laYbwGrytww7kYP+CY0sOJriSZwVuz
 ggbgQmnSsItIQDYQN0URHjbMx1j6pvnsYSlLUbTv9ICwAP/F/tTf8agOyBUu4wyKzznh
 47ijbNgZ3yLpu3jvSaL1V9hCW1t86bd/zug8oHIfwdmK7I4IX9gkH0KklYZq8mohg9tW
 uzJzORi1NTFI+r5UpzRtBp9nNd61nt53313r7FF/VGbH09bVOHMtSlPL/EMtkJpVqMEs qg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=fa4XamKFhDBigC5x33aJYAwIT8MyC+C1rH8EcMHY1pM=;
 b=CP+uSeD0IKCkS204haEI85UDRLXZlLMyHJYQy+S5g423iCkVOoJNzWRs4xI0DgKhtGh0
 uUnm+s3bov3BLPQl7CqORnPePkJYUL4L3KUDVIwBINbTahWJbUGHhhbWSG2ThYPFQpIy
 FKWFqMpksMLLwe7OmP+hDbMPgH9chYUuGR8sTNO3xD5aPsa93gU3E9x6TVRO6JpJbGqM
 YilXhNAIE4jShYKyTmSRDrLWHUqYFUqfuo7nVUOmvl245LQDhsblh0416fKTuUX/MrMn
 4/y00+IsncJuG43VwqyCec8YbxN3CCH0/90DmcZOp5KQuBfxBiiZBAEK7Fk5DV3CWolp 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b3s74m7wy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Sep 2021 21:21:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GL5XNq011268;
 Thu, 16 Sep 2021 21:21:07 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
 by userp3030.oracle.com with ESMTP id 3b0hjyuvpe-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Sep 2021 21:21:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WU3yBPI48kI/b7IjIOn99CXAd57DkkOUEzMOaHxqTh94CnJ7Q8rP1pQrFn9UfVFX/AWP1M7qemnXo0hrH9QrIIkartnXnNYpZvCCbEpweXM4LKOQfqe05ivL4wvJDSU1KP43Ct/mmS8l+6oCRu7ljImd0mWe64HG6t7+Cm7fPLKEvy0lOSlyOerLClC6Oyf5zHGaT1Pm+RP8YGRnFnEF6EL2DozjO+Kzhaq66/URwGiAOmt5FF1gLI42bE4pTiLTauCF/gbuB/FItcRO8TIyR8sGdrWogwgOaXz64uPjs4YPVYYvRIFcBNrZO7UXCpi+8upN27yhi8TMPjrpnTNA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=fa4XamKFhDBigC5x33aJYAwIT8MyC+C1rH8EcMHY1pM=;
 b=DkSzFQiC6Wt8DQvrJS0fU+3r0KosuIkQA5Yiw4PJTzzWyfdVGn78shuljxMASJ8XXhaAdpPyyzz/UHVC+j/I0v3VXd9YWkOA0OYuJ5YvthpZ8Vcqr/2HyhT0V/w0Z0NndJScqDaX8YSBaUtuty3luodkHnNemRewhliSSKr9u2AhieWUC1tQTCxM30yP0pir4fXO17PaO9BXweeaICoKvpnmpEa89RVre6t3+PSs4bK80Iwdi7+CLp8LFT6TmNdaJnYq4jc/rtiyr1Dr87RBBPSJ4S2yDKRyARNoH/tc2sS7PaPGo1pNKuIK0qoLTtAPpZd7pfjpcFRcYfpTkEJ6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fa4XamKFhDBigC5x33aJYAwIT8MyC+C1rH8EcMHY1pM=;
 b=z3UN1B9F9PusU4TjR+6bLTUujkVB4MNTVuow7zRaM/PRtp6AOhByHzcl7CwucjfDiR5CNq0veykddYixmTAj4+L2aEqhsm9sCTJX5+ArKywTonIN+8RHHlr9hVOMsMhBI7iS0vLoPXuGvO5WxyZouldOcHZhZNp7f77TrT8VNKU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB2935.namprd10.prod.outlook.com (2603:10b6:a03:8e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Thu, 16 Sep
 2021 21:21:03 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.014; Thu, 16 Sep 2021
 21:21:03 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] signal: Export ignore_signals
Date: Thu, 16 Sep 2021 16:20:45 -0500
Message-Id: <20210916212051.6918-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916212051.6918-1-michael.christie@oracle.com>
References: <20210916212051.6918-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:3:12b::13) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR04CA0027.namprd04.prod.outlook.com (2603:10b6:3:12b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 21:21:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20f82e8e-935d-45b7-4bc7-08d97957e37c
X-MS-TrafficTypeDiagnostic: BYAPR10MB2935:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2935FC76F5CEA7BAC5628818F1DC9@BYAPR10MB2935.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nbb4bB1OZsFMwR/qoh+KaYEtCrIXzHkHpsTzsiEEUUurzfM7lCjLbZD4BsFc8Uy+TLWt2DTfPlVPcB6ukqP0DSJ6VWniDAmkwuN3Xy+gDEX75bzoJCrj4m1pVNFGTMi6XhfcTu2gNkKUrB7IDqUbqjNMxQGjGPwRSwL5drBOKfjA/v1zVBXEdn5hZNr6gqSIyTSEbkMGNmQD6IR0VHgrbujMgSkxmggej8CMCbpVLhp3WnQvBQdxinixmBrt9jkQPLRdef48SGjxaJJgVoB2dpYRvuZcP4k/o3zvWqBVP4uPR+fhrs7fpWJub81mpYfWUav7ArsVu7WTR0tjX3wi8RH/gfOcjrUfpXMts8dLyTuuMrhEl6xUwwEIwxUOXg43r2sLe9FJTRxF8gMFHRR2DZcmxX0gfMKLNZcAQ/9ooMQ8QpYiT8mi7Ara+bWfekUu9RSBnCxytgKqpwfZK2FzuNZ3aIlVpAQk+UviFIUt5vZLyJ0TTx/m/mQNDRHGnhc0VjHi9d8ROw1OWF/zrTpxTLb2plc5BamWwrZkRNxwonZnUSXf36sMnPZm0oQDZsyaYkwSQoDu4GSmK9sUMh2jvSDgDo7nFsLToiF9aBNl8ZCC89h9dzDOXLfxb6g56ZUQjxz0UNCUJmC68ti1h8rsFzc+17EYFj9j5ms5mce4ej1gih0cNThSxKeQEOnP7aoHrtMvrOx4qWqJpb0Z3WWOpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(86362001)(36756003)(26005)(107886003)(508600001)(8676002)(8936002)(66556008)(66946007)(5660300002)(6506007)(66476007)(4326008)(6486002)(2906002)(38100700002)(4744005)(38350700002)(1076003)(52116002)(2616005)(6512007)(956004)(6666004)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wm8YyOy9zUxaAqJfO1MvB2EVM1hvnVKOJAs3jus339x24aHHPIdh8i2hgjdp?=
 =?us-ascii?Q?o4weIWWu9aKSsIcwNjHoyppQhmqFcrKRwStCX/DXRN4FnOzXsCOVLQDxef+m?=
 =?us-ascii?Q?h6FgpmPR6YVIdsjjLJD3hJJREmH56d5ell/zoeiNwlmG/3IxqTMzlf+z7+e6?=
 =?us-ascii?Q?eLMRwBye5b1EXgiRx3uARMzQMFPqQUAZqLZQX3A5Eu4EpyQopbDoDCf96ynY?=
 =?us-ascii?Q?oxQUgOkEMEYs+i507ng5HXHtQJu5g+g50oTOXfNq/A/4YXgqMIcx10/Ngm74?=
 =?us-ascii?Q?8sh7Smy0GU40OwGQK57HZeG5JOlGOBrVsucEekoqj7XKlj0YL3peR6DC7Sos?=
 =?us-ascii?Q?aQI8p68S9YbpEl6hvQZzpkI57tx27MVg8PfWXRAlWXtvxyUK7T1cp+tAztpQ?=
 =?us-ascii?Q?ufAf8lAWOqcAa583MwHn6F2w4JmFjvtH4glxVblkLdNMn3dWmzv4m92b8qO2?=
 =?us-ascii?Q?ROfvEbtr6XTOLRCXrxdtXHO9EEyNTsMo4BnFKX5xVzk/0oNd6Lm5CgOhmyU3?=
 =?us-ascii?Q?PVzvsGarPMkPm+lVcEHEXaSs89IL9n5+ZqsUG0grCSKxeNdQz3KTIsIUoi2d?=
 =?us-ascii?Q?/tIADiyrOapm9py2WAsUjsM89xig7Kvd7iV5zywItr5Y0Hnxnn73+yaB5920?=
 =?us-ascii?Q?qj7H2+LFF4cv0OtyEmqo8gxPlfOhRZTXwrrhrxFEjOPrs806XWWOw2fWRUkA?=
 =?us-ascii?Q?JKZB19vEZU5lzqLBjhwKSyEOSD10VXRA7waWWrvBdDiCWaCvTFRTbKKr5AeG?=
 =?us-ascii?Q?mSctIeP1sDq99emyo3NIHoaVF1N5tW/FWspMOq9oCIerX5NvUJw59eIT3NX0?=
 =?us-ascii?Q?kHXporYKpCef83wAzdqX/DgolOJ8hCFSWcyWp/sVIs4/U+QEesA4IbQslWyP?=
 =?us-ascii?Q?zoTFDa3MiWIIkuvTzd9m3b9zsO7YZeliuqLZxJZPASZpGkFVHszkubKTyTVq?=
 =?us-ascii?Q?QRLAAUcgawbmPjOVwHI7Hgy0G1iWbItDXhRpABY7yvjlvlCgobaSYTFFSvtv?=
 =?us-ascii?Q?2JY5PQizoyOGQ/ti2M1QsdV65qParNmiuspTb/Klv69AQ5HIZYa4aUqYXv0f?=
 =?us-ascii?Q?Obk0fPBH2HzihbGHQhgGChIdKCaqgo29PryHpBano7ZEY6gIe5at6cSBHp6g?=
 =?us-ascii?Q?7L9ATgTtO6PAcBhbMGCHCLWdDQf1qZ53FDlLwcj+xLXJtKYgxKoPZvBatTpM?=
 =?us-ascii?Q?qWjQm9gbe9l4QpNjFbfB4mfZnNQniKoTXH6Wm8vxrgMkpD7SK299zbS/3bmN?=
 =?us-ascii?Q?zxNGCzmwttlL6WaSzxxz2msfdIQgQv79lmKK6OdVKhONPqY1r5T5SCdJTkfJ?=
 =?us-ascii?Q?oUrl9otxovMSUG/+jocl6jvh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f82e8e-935d-45b7-4bc7-08d97957e37c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 21:21:03.7654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+3linx83aCXiEDkjzMRw8XlD2wPiuesyaTDu733n/IVqEJKW0HKfSbaeUTK8R9OfSPgsizcwX/dA7zikj8TPK+b3c792fFoly+hPUQv78g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2935
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160122
X-Proofpoint-ORIG-GUID: 8bAZpY8_uf6UCa3lo8are1Utjfa0mlbK
X-Proofpoint-GUID: 8bAZpY8_uf6UCa3lo8are1Utjfa0mlbK
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

The kthread API creates threads that ignore all signals by default so
modules like vhost that will move from that API to kernel_copy_process
will not be expecting them. This patch exports ignore_signals so those
modules can keep their existing behavior.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 kernel/signal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 952741f6d0f9..8fb79200c18b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -534,6 +534,10 @@ void flush_itimer_signals(void)
 }
 #endif
 
+/**
+ * ignore_signals - setup task to ignore all signals
+ * @t: task to setup
+ */
 void ignore_signals(struct task_struct *t)
 {
 	int i;
@@ -543,6 +547,7 @@ void ignore_signals(struct task_struct *t)
 
 	flush_signals(t);
 }
+EXPORT_SYMBOL_GPL(ignore_signals);
 
 /*
  * Flush all handlers for a task.
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
