Return-Path: <SRS0=0+SM=OG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3290C433FE
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89B16113A
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A89B16113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F38960671;
	Thu, 16 Sep 2021 21:21:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MdeVdqd1BQ-w; Thu, 16 Sep 2021 21:21:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 03FF3608CA;
	Thu, 16 Sep 2021 21:21:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF77AC0027;
	Thu, 16 Sep 2021 21:21:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 776F9C001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5380C400F5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="jXHWW/wo";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="OJe6scvL";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="rEsDXLJ0"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TaUA734RJwi3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 46224406FC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:11 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GKgaQ3012133; 
 Thu, 16 Sep 2021 21:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Sa7B5bnPXtrAVYvyA1UcNIET59s7M6GX/d3W+YihQkM=;
 b=jXHWW/woBYsPJd6vp8GjEh4WjoKY11I2qN2VOKem92e14IcUPtA6Fesp8PQZ04nRSzD7
 v4YMUWF4wzziQr9fhDKiyPFzT2fjRJaqOUoQNwDzSTtda515rCfc5toCj+pkte2IgZX2
 9Vp6q5w6hN54wnAPVjhcDsVBY2QlSOPM7jokbGTs8gsF4CWeplVN2NrVqBbl7GET5ySm
 TTGzexcGQ5oeFOoVOLUui7xHN39MuhiCoWh298PuLcBkxUdyj7Lg4yg9UqGpj/lzDcVM
 42JAiTzwr+n844r4zwGM+gM3rVZU91qovZ+F3TaIFbm98r733yBz+bgMnXhH5th4awBk xQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=Sa7B5bnPXtrAVYvyA1UcNIET59s7M6GX/d3W+YihQkM=;
 b=OJe6scvLe2FiviIEIXGX0GzWvz0Fmt/2ndl5Rhq8wO6O+Pw8NwDTEqLQQHnzMLPSZPqj
 k0I/f/S+f9haELW8yqejsrAciTcoICgGgAIBuF9mH4POP9l5LUBvyVpLvV1CbaBErNtX
 Z4XqmouXo+KNMAfl1fGnb00GNfxGFFAJSymaOr03UvHfkg6DVFDSeY6AsX7UZu3X8Pep
 EV78M+jZYyYqraCAcr5XOAypTgNTeWmwRwxGqfX1jJjlIzqhxO/JHreVwV9UwpT12CdB
 oolrLbj9NSzJvjKESxamCrVz6XHZHSgYOKgCzhtw9UQC10cIO01A/3iPL5K8OLJCpmgq 5g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b3vj13q92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Sep 2021 21:21:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GL5XNr011268;
 Thu, 16 Sep 2021 21:21:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
 by userp3030.oracle.com with ESMTP id 3b0hjyuvpe-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Sep 2021 21:21:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmUkCZUuq8J84DAJHWrClok4blC841Yfa5fxukwpVRk4O8IKTofUJ6FZkke4VHcCyJH51nrbkn+w2gR/0cpQ4sZogbICszyTX+knCTNtRizCBtXgEs24tKm5Nj0XOHZjIaB2b5kUnbs74/uhTykCsA/mBZrGskFBMjC9NgSSogbFyyI7B+JdgIPCyVVTvAI67Gk20UQPlZ3yyUOMT9YvRX0jruqrMlgygq1xSdPnz4U9pWczLo0DnHqH2Jf/BjvmNho4UQ8T/EKCKDn7UVGxsIR0R9CJpdhUBrTaYdkXlez5Q0yGWosZjpJ/IHtV2ofatrPF5THXUMM6xq8un+W3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Sa7B5bnPXtrAVYvyA1UcNIET59s7M6GX/d3W+YihQkM=;
 b=Ht3YZF5wQhleFkDvtmWCPjfXUt3DJwbmM3Z8gPiXx74SVjYGJuGzrSMh0iGDJO5GXszK94l3S9mTLrceAGGlVF7Up12Ljs5mAH6ZIgEWDicZI/hm5EBKFuSt81zGxoPHTcJGSTsPaAgIPM/bTsb+nM+S7siqGlARPRnYnMQzqpHIYJbNZEIoQHusMYL+1v6v/PN+OUKPR8NTkpR/3pdl5dkdsyt5CphkB/JOe1+0CWRF+EszU32R8aWV213LBLA6+6OMO/8fs0gcptSWCwG0QNpUURcgj27Yt3moyNqP98amFmsgWu2t+D+BhTVYBjr80DvkhOWcLob5oczmkc/oLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sa7B5bnPXtrAVYvyA1UcNIET59s7M6GX/d3W+YihQkM=;
 b=rEsDXLJ0mi77EPJJ3F2s9zdVi0Q4LuuhF0zjTEB4D+wpjmIzIfXACG+zXvVmrC+toykFx5Z0t7hODqSjavtDADBZT5TJKgD809ruKJ/Y11fvYb9UsESwqBDlW72pCa1ME65JEJ1pyDOyJh/MvxcOZhWK//oZoUGfW8aMgr7H4G0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB2935.namprd10.prod.outlook.com (2603:10b6:a03:8e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Thu, 16 Sep
 2021 21:21:06 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.014; Thu, 16 Sep 2021
 21:21:06 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] fork: add option to not clone or dup files
Date: Thu, 16 Sep 2021 16:20:46 -0500
Message-Id: <20210916212051.6918-4-michael.christie@oracle.com>
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
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 21:21:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ece1d2c9-27fb-49b9-102b-08d97957e42b
X-MS-TrafficTypeDiagnostic: BYAPR10MB2935:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2935CB2EFA8BDFF2B8AE6970F1DC9@BYAPR10MB2935.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JqT4NxM/AfKKNlV5nzzRaIViwQic3s7AeTAUx3xJzVemg/C4eUhGbAboqRIpEP8ufPhCHOSniXz62blVT9C/xSOxfNO5ty83+mtBOQ/Kz9y7IVsPXBs9GmbmjBB6VeXRCGmVlpvYnAnXaAQQyhJq9SAOO2WxNnOBg4QNgVA3J+UQWXv6IaVyZpVxKLgrHB6CgjsJtf4SqEk4a4yd91EIy6FF3a8p2eymlw09K5ySLzPADOT2Nm0fQ7uLHR2oPYO+jvkBUeI8qLvmXJTlB+7Y4a6sC+PmtU2pqj4vymmvyQ1+5+MzuYvl8+ppX2ptUvhwvrjIBMy91Rp2B+Z+MkrUjtXMRdNdTBcIGKVodEYd4JSXoBOL8p5seZOVQ7y4nmekc7Sh10VY2Yn5B2lywxqXNLsURR3D4A9mxUs4LMXd694noMtlCWmPU87Ioho4qBQIDWS6Y+Xy0zLpRCsQp2uGoEj7d0vHz1qGqBQN6bBBHM0MviKvLAVVUbIFP51Slt+9eyRZSdP6sfJvvt3+S2YwVuL1+RX83Pv7FEkYFqjXRUKY92mjbLyoBtOLOVXesVboZLgLmfidhK2vCBwUwhkEPliNRkrnVi2uojGWY0O4o9sQFRX+XXfTvPKfmzxRDv+MxTxqlI9eeWEs5fCQlIFoZcdOLmkJBvdcKWqnInPNZeQYUvXRKThPqJIe67h3xzoEVeI5AhT4Bf6Vg99yoM2ThQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(86362001)(36756003)(26005)(107886003)(508600001)(8676002)(8936002)(66556008)(83380400001)(66946007)(5660300002)(6506007)(66476007)(4326008)(6486002)(2906002)(38100700002)(38350700002)(1076003)(52116002)(2616005)(6512007)(956004)(6666004)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9yqXJLj9aL2ToiGlJs7EgJM9XmZV/wmBS6vFtNOwb4KloorrsO2DPIWWmph9?=
 =?us-ascii?Q?/IGyRTrLgAyO1Sj/zIzmROHSI/vkDwP9gcFz0aOaTYoRXYsmsL6KgDLGgliF?=
 =?us-ascii?Q?Wm269MR4k3Ld3ziGmd0B+E2EBsM6U0qPnI/D/zDkmFlUe6/3BpVgRiWvaMrN?=
 =?us-ascii?Q?9ZvMrpNQW99fodfAA5GAw9HKTLdO31iAaAq6EZWR8lUq4py3LjhMtCfMAyx7?=
 =?us-ascii?Q?u2SbqE5O5uTpjGnXL4xq8OSRKUNtncYXxyG+dJQWQDx6TiHSxHLSxzAFSWkd?=
 =?us-ascii?Q?oaSA5PxsWSo8IFaqYUvsQF+DTUmh212FMhiAxTAtEjb0XtOeF+jUlXpqxVWW?=
 =?us-ascii?Q?2EcuUJyOLpg/+iTD/m84QqOAPIMr85qsga6+mauXJO0eECBZTsk7gMGWfdf1?=
 =?us-ascii?Q?BA4T6N9PzMWejVPUgN8R12y1oC8IUbiDbLm7VQkGKwkpsQW7vN/0SZUoiLAL?=
 =?us-ascii?Q?jHBZ33ClDNphDNi/pHgl7mDGVF3nXkUhCpghXlenK5fRDcIlXgbCb9ROy0+8?=
 =?us-ascii?Q?Ct+xnemAHa34lJztJv1VelxXjVBmMW5ArQOknHUCZQPStvcIIO/zjAdeIa78?=
 =?us-ascii?Q?1NVi/c8C4T045vmlf7W3uD+p0M54+HfyXf82wZXQD6Z12nl+88l+eFRn3vz3?=
 =?us-ascii?Q?JcjTxk800RTXlYnzWN7EM7NGLY9EUB9Oyib/xl9m4Sa4MPFEyhTe7I30PsEt?=
 =?us-ascii?Q?Dgvnw1yMK9gU5leNT4cj6SRfGKj6/f9PQHd8VPz/FhIa1G0S2kwhfigvEqR+?=
 =?us-ascii?Q?HRQ+3F/4wcWNLPbxqdpTVh6+c3xndxG6I8+jvREfXJgKfg6jV1n3kvajFe2X?=
 =?us-ascii?Q?XT06/aTASvH0NAglbGAGWJD0YfwlK2vfUgYe+lm5DNfn7X8MHwnS2owqVjkl?=
 =?us-ascii?Q?aLf7OnrBsv7yFxGYRdUtmOd2fAyjH14gQ8Mx87Nvn4bUL0XqPRebWr5X3y1Y?=
 =?us-ascii?Q?RAPMwC5N2zqiKg/b//FIx58xtru/MoSezoq2zgjN9LWUejoXHLH4WV7awJFk?=
 =?us-ascii?Q?7PidC6UOI9K1zqJw4CCwYtDVSYUolrj8ik/0BIGuKJSl6XSVRWDTRiVyLXPc?=
 =?us-ascii?Q?4TH86wdEtrw9kWDpnXDVzcJNZYBDaEtwN3sxTu7MD28qFG9v+str+NJ1XmuT?=
 =?us-ascii?Q?8IjUoxG+x1SQTXFQcpt2eAJr82Vd0nBuXGfx5fvrVjAsbOgIuWTd2ZLx99Vd?=
 =?us-ascii?Q?ado1iXAy3Xj2Gst5Q2SA+kuhqFHsAHLlbZhJj+2QvczjSjfSGg8NNoLEZ1Kk?=
 =?us-ascii?Q?LpqSPSOiQiLB6Ai5u19CW8aCIaRtSxtqKWi5c6JCvH1ppw8xk9D2NbUFzaP5?=
 =?us-ascii?Q?mI2l7CAkhwlZzezeHFPc4i8O?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece1d2c9-27fb-49b9-102b-08d97957e42b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 21:21:04.8867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlBxfrSeqhWyXwc/oA5UF1FvQOVZzdYQkK1Ob+mppTt9+56QRXgnhVln8Qi6aBcNi9dxITsblp8lSgM8e5P6Ci8ejMhKch0ZYTej+g1VcRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2935
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160122
X-Proofpoint-ORIG-GUID: yKkJOJtFfxS4tGmaR2e-SFvk4tmAD-99
X-Proofpoint-GUID: yKkJOJtFfxS4tGmaR2e-SFvk4tmAD-99
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

Each vhost device gets a thread that is used to perform IO and management
operations. Instead of a thread that is accessing a device, the thread is
part of the device, so when it calls kernel_copy_process we can't dup or
clone the parent's (Qemu thread that does the VHOST_SET_OWNER ioctl)
files/FDS because it would do an extra increment on ourself.

Later, when we do:

Qemu process exits:
	do_exit -> exit_files -> put_files_struct -> close_files

we would leak the device's resources because of that extra refcount
on the fd or file_struct.

This patch adds a no_files option so these worker threads can prevent
taking an extra refcount on themselves.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 include/linux/sched/task.h |  3 ++-
 kernel/fork.c              | 14 +++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index c55f1eb69d41..d0b0872f56cc 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -32,6 +32,7 @@ struct kernel_clone_args {
 	size_t set_tid_size;
 	int cgroup;
 	int io_thread;
+	int no_files;
 	struct cgroup *cgrp;
 	struct css_set *cset;
 };
@@ -86,7 +87,7 @@ extern pid_t kernel_clone(struct kernel_clone_args *kargs);
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *kernel_copy_process(int (*fn)(void *), void *arg, int node,
 					unsigned long clone_flags,
-					int io_thread);
+					int io_thread, int no_files);
 struct task_struct *fork_idle(int);
 struct mm_struct *copy_init_mm(void);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
diff --git a/kernel/fork.c b/kernel/fork.c
index cec7b6011beb..a0468e30b27e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1532,7 +1532,8 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
+		      int no_files)
 {
 	struct files_struct *oldf, *newf;
 	int error = 0;
@@ -1544,6 +1545,11 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 	if (!oldf)
 		goto out;
 
+	if (no_files) {
+		tsk->files = NULL;
+		goto out;
+	}
+
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
 		goto out;
@@ -2179,7 +2185,7 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = copy_semundo(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_security;
-	retval = copy_files(clone_flags, p);
+	retval = copy_files(clone_flags, p, args->no_files);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p);
@@ -2539,6 +2545,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
  * @node: numa node to allocate task from
  * @clone_flags: CLONE flags
  * @io_thread: 1 if this will be a PF_IO_WORKER else 0.
+ * @no_files: Do not duplicate or copy the parent's open files.
  *
  * This returns a created task, or an error pointer. The returned task is
  * inactive, and the caller must fire it up through wake_up_new_task(p). If
@@ -2546,7 +2553,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
  */
 struct task_struct *kernel_copy_process(int (*fn)(void *), void *arg, int node,
 					unsigned long clone_flags,
-					int io_thread)
+					int io_thread, int no_files)
 {
 	struct kernel_clone_args args = {
 		.flags		= ((lower_32_bits(clone_flags) | CLONE_VM |
@@ -2555,6 +2562,7 @@ struct task_struct *kernel_copy_process(int (*fn)(void *), void *arg, int node,
 		.stack		= (unsigned long)fn,
 		.stack_size	= (unsigned long)arg,
 		.io_thread	= io_thread,
+		.no_files	= no_files,
 	};
 
 	return copy_process(NULL, 0, node, &args);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
