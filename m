Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F713C43334
	for <virtualization@archiver.kernel.org>; Fri,  8 Jul 2022 03:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E07C742463;
	Fri,  8 Jul 2022 03:05:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E07C742463
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2021-07-09 header.b=qpzycQnf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=jdwVl167
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8fAv173mNGKR; Fri,  8 Jul 2022 03:05:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5C7B442482;
	Fri,  8 Jul 2022 03:05:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C7B442482
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 230F6C0082;
	Fri,  8 Jul 2022 03:05:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EF6FC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 18974612EE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:05:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 18974612EE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2021-07-09 header.b=qpzycQnf; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=jdwVl167
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fYYaHsaWeWJ9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:05:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E86C660A69
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E86C660A69
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:05:37 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2681Z1Fd020284;
 Fri, 8 Jul 2022 03:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=+E/eYYL1ixrLNUiEA4ZWuQOwGtW54qq/V04NFkAv+Ho=;
 b=qpzycQnf/sB9ASbKFhGEfNcjfxQAwqQdgNMtfIxdilw46wpvr1+HyyjFocbQyBFzCz7X
 /fQCI0ORLVm2qWQe9ykXsxKY7xS2pf8495C49lK2K8pjn+ad24YiyQsCvy/ox6a6hH/C
 l4oTqGiHz+D2sxoJZupiCMjB78gZ/gWyxJEDiXQP57N+9MtMv0UuxxLS22Z8bNS2NFCX
 THRaQnSAbWa5Oquu9jhTZ/f5xzZoKXdXDdEX6B7PEQFaAdcb17nc34GikjlKMxxccdDc
 uvY98FGzgwKYCbPH/eNnJV57aLDhZwabwd3ueC95hvKyjJH7UdMN6/XLF9vwmNjTiJfM DQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4uby6w4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Jul 2022 03:05:36 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 26831Kkr032205; Fri, 8 Jul 2022 03:05:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3h4ud6cc45-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Jul 2022 03:05:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBGR2wZHATvB9n1+hx/H9FfziewWpjWeiTZSl3M4miy/hbdtse3jYLAaCleGHWocbJ5pv8cnE8PzEkpH//DkwhzTlwMd2n0COqNUgwFHEYMpOWEb0J9tb6+vRqdnW2gQZfCQarYxzu3rgNzHooTQQ9qL4FfutJnTskzeCK2VlocnQiV+pxS0hoVNIYkPxHNqYTyRc3z5IKDZlKP6/DcHqlTTmNGVM844hu8+ElDceuVUqVgUT/r6dNRLcztM8GIATKXWtqMciatVoE5wIZeiaHOCWT6QU+yPkbEGwjdcqBRME2jN1+RLCY0Stv2AN/wpjz75LgBYXPLY+idbQlpw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+E/eYYL1ixrLNUiEA4ZWuQOwGtW54qq/V04NFkAv+Ho=;
 b=QyjXm/Ps2qpb/qfNrUhXPqpv24wrghnsws6/IEUmoFcYqAz38vEyRxSpSgjCdHtYsb4QHsYmSwI6mIb9F6/ZRqv5md1qb/iUqazKVwm/gdKWn1o7eXa2ObinrstVEGQ6I2BzNtVQQGDFWEvdRpFF3545wOcbUhDYTypwnkdgV1hOPI6zCwrQRl0xcZplEhojwgbITFTONDec4umkiSNdpq/n553Mnl/5kqvFN96e0lEBIue5Ve4RxNRIrt/lfBQVOuB/E5bwH57BgIl4FqF2c4dMmiy3lednGwmK5LpWEaCBJl/CCcvODkAsR2kEGLVroL8WCcWLBxOswU7L00m7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E/eYYL1ixrLNUiEA4ZWuQOwGtW54qq/V04NFkAv+Ho=;
 b=jdwVl167ppLV23XBseaYFSnYI5bsIJCd21nffngbYm3ZKndX+Nm6HVDAlJlHo+/GdbTOgqqpahd8qYsrN3c9XQ6C659GDtB6GQlMejv2/OQ1tw/aCdKU7t0012E7CVe5Rv64NSKxwX99tWnDo4rHdj2KLmIvz0MTBezu/BvIxJA=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SA2PR10MB4731.namprd10.prod.outlook.com (2603:10b6:806:11e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Fri, 8 Jul 2022 03:05:34 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5395.020; Fri, 8 Jul 2022
 03:05:34 +0000
From: Mike Christie <michael.christie@oracle.com>
To: virtualization@lists.linux-foundation.org, jasowang@redhat.com,
 pbonzini@redhat.com, mst@redhat.com, stefanha@redhat.com
Subject: [PATCH 2/2] vhost scsi: Allow user to control num virtqueues
Date: Thu,  7 Jul 2022 22:05:25 -0500
Message-Id: <20220708030525.5065-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708030525.5065-1-michael.christie@oracle.com>
References: <20220708030525.5065-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:5:134::33) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a45605e5-bc2c-426f-95f6-08da608eb988
X-MS-TrafficTypeDiagnostic: SA2PR10MB4731:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 326wU6UkrWkVKLJvPP+laR9c9inpbY3lRlUOyUuyFgtm4FGZrrqwLrAxVJaQn20w3BEvfAR4GVCm+4drDR3XvovLf/dSbupY7wl/qFChr/7RZbjwMUzMq7xDHu4fZn+uqI/ZWHakLzAgOEU0Xw6rca2ShSGleZ99IDIyxqPn/oSSyJtm7HMqQqSJx/e6MsG6pREFknu60L14dRl0Qlu4SZihgXS7rtI8WtojqPI5CzgRcHy0M/qtHq9q+2R6HIkJo6cyeTdE/57gDjeMacujTbrWB2TI77QvMVkjwnIIMhxuDtedeNkcbF+aa+Gh+U07ZSEMk/wJN117nDm2+QOG//o2Qr1Wc/sLp2VxLJH1ATOFYwwDSSuJmm7+9ycRue7IPQF7IhHjNTeoCGhaiGA7PIAAjkY+HIk17gD3N9vglO20BVv1gyNHGh14T5oVFLK18S20DxrwWov9VF/1VqEsnIPuem6+SoNgHRrbiWSQq1+aC+UTqgZPXdc3aZbreZy1KI/jtwk+6P+8FaVfj0aW963qZAh2VLXLN+jiWtRD0RjHLPbDoCu6iwYuY1kedutMnvTfZ1DitZYOj1WeXq47wFvI15tXkmEfFEeYLcOe2N5gvojUbK1jsRzzd9lAN6oTsCu4W8cKayr76WTMK/LfHFQtzDkDBs5MhvlvRirKZFhqFZyDMwydaSCm7St0D/Qvlji4AcFfO62fy8oOsTeBCGmhoEZs07G3itH1ffpD2LNKe7S/+m0DrwUEy2iXDS8JTa/gmL98O1rym2TUTIX8LxfBMvFU+TtTAR24uggiEBBz0svBi1THlBXfM+1jF6df
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(39860400002)(346002)(136003)(396003)(366004)(376002)(38350700002)(2616005)(38100700002)(83380400001)(186003)(107886003)(1076003)(8936002)(5660300002)(66476007)(4326008)(8676002)(66556008)(41300700001)(478600001)(6666004)(2906002)(26005)(6512007)(6506007)(52116002)(6486002)(36756003)(316002)(86362001)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZtG34bl9WXPUOlFGwUz2rPdOVnCaGq45P5HhesVJ9ZPAXYna2vuVEpmfXDa3?=
 =?us-ascii?Q?vDEc7BJc/4eraZ1ZVUeP8Z4jiiVuQy4wMkDdduwXLSyCkLMwqiTYOivIBfIc?=
 =?us-ascii?Q?VifXty4ROZU5Oel+a8NOPLs8s13R5KFykmRP5KpIjY3APc84oRqkoB6+mqy0?=
 =?us-ascii?Q?NldOqbomANcWfijHFeKNln2LdWTEUKt9hmfB6GTIsBqxBNbah31j6zoEJ6dF?=
 =?us-ascii?Q?5iy30/ZeE5U1OZ1crzUrdryuvxNvnMcFkIavWSGL6HlIYQtno7bXMfSRVwJr?=
 =?us-ascii?Q?d2Da4A8KYYWzz5DoV1CY1ntxQ3dz8rEGJuEN/z4jHBnozFy3lmm0shQPfVmR?=
 =?us-ascii?Q?13jDz6911LA/TikplHjX+rYIt3Kt2iR1qI/vUqgCcaSlfznXiui/W3viZqTO?=
 =?us-ascii?Q?yks8oCErLhD5DiWM/X+erI66VYjeZg4aNSa+NEgGdLpD+YgRqB/yy+KgasWE?=
 =?us-ascii?Q?17750t+1TDZ0c7cpY/zLjSmEc30CCJ2sH9f5M4NXEwABV5DDYnJOWCcxtplT?=
 =?us-ascii?Q?PEblk9yx9tvrlRxWNmSLms8L2BfOaVbAlok/djGLU+xjDRSWIfmRR4+lGq8p?=
 =?us-ascii?Q?DTndUf3P6PEN+IVcKm5cWYUT+up9/w5NDMUr3jfAV2TGPvVjsWn3OplCy/Jx?=
 =?us-ascii?Q?Wn6m9wNlQT6dYJ+c2+zouW1RTWYSG7zquYOHifPW8/I0lEQRX6H9ozympMJq?=
 =?us-ascii?Q?4Xwd3D+/J5STJ1BxqRWuc/o2ZJL1P0ry07Qb8DQuI6f/e+spiGBXbGocWHF8?=
 =?us-ascii?Q?+DBUsgHw6HMIwYvAeqD3xsXzF1DJkB8gS1DGyxyKkwtqGFgwnDn1tkDA5pjL?=
 =?us-ascii?Q?IdtOPRhvNU8lwWjwOSpylrJ/8SnVpMlfcxNlw5OdUxqbwoMkYoDYsuH8xwTm?=
 =?us-ascii?Q?zqWqC+4dL3Nces75EjsrmVoFBI2ljB0z34D7YVRJQaDXgk2P+eG7X0nv9vUq?=
 =?us-ascii?Q?OnSbEoRxWL2y95lGN63+nArdyn7uhqRmumYQQrtVrOkgvL5hUNqYzvhs9d+C?=
 =?us-ascii?Q?ixXNpKjRpI/9tgZyyuhGy95n6moqv/CbgV7lSXVMG8U6978p+V97RwFFBC4y?=
 =?us-ascii?Q?aNFkRmNAyUG6X/k5QKou3Rc2CUWsXiAwr0r6qupWFgPbxpDcYF6edzWlJTMK?=
 =?us-ascii?Q?LoKSWjzLmdHQ7gJ9D4VHXiDS2qI8oUUG6xIV/UY1Fqpc7K2SQQk2NS+rR7Po?=
 =?us-ascii?Q?sBPZGq1JVzMLXwetLb9uATlXqMwEhSHjXOD0de7l025WA3t4IuZZJUAv+sH0?=
 =?us-ascii?Q?Ey1yfbv3rR9+erVcaX9g30VJATaRZSLxqdDokxeB8goX8qXcEVijjfUxL9GJ?=
 =?us-ascii?Q?UrCcihGUz7NcpWoCeKgbYSgMLYvHbWf6T5gwyqrtO1fuRPl/U86FkyNEhP9q?=
 =?us-ascii?Q?f362l4a7RacKZBTVPsivHaMq2Q5n6linnNo8x96hFzGPJ8DSZNXqrQzsGkd4?=
 =?us-ascii?Q?jVRRxSFNi5mJypzsiP6ULEiZnJI7SAypqRhj5TdFrvDogtFhJaiViT7HPiL7?=
 =?us-ascii?Q?GBMaZa9t+RXwyZB1wTCNUPGJuXw91srUBGrtXMzgjGm2IRb9R/clNTvxuM4H?=
 =?us-ascii?Q?1oaCQB+rybOnqR9l0WQtHfZ3rSddLRwVtbetCOMGYQd8vzpF02LTSm8eo9tZ?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45605e5-bc2c-426f-95f6-08da608eb988
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 03:05:34.2111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4t1dgnUpxyBX7OBiplzG8xONPEoORIhZi/J5WdI/P18rTzSIgnPEGoA8XUJqrP/BWb/M72dKSL72jpOXqjkqKxyZZpNb1NHhU6F3FrIyQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4731
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517, 18.0.883
 definitions=2022-07-08_02:2022-06-28,
 2022-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207080010
X-Proofpoint-ORIG-GUID: LnQLzj8B_g5HWsVYzRigWkocrwdYQe2r
X-Proofpoint-GUID: LnQLzj8B_g5HWsVYzRigWkocrwdYQe2r
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

We are currently hard coded to always create 128 IO virtqueues, so this
adds a modparam to control it. For large systems where we are ok with
using memory for virtqueues it allows us to add up to 1024. This limit
was just selected becuase that's qemu's limit.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 85 +++++++++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 24 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 8d6b4eef554d..d9861ab2c300 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -159,9 +159,13 @@ enum {
 };
 
 #define VHOST_SCSI_MAX_TARGET	256
-#define VHOST_SCSI_MAX_VQ	128 + VHOST_SCSI_VQ_IO
+#define VHOST_SCSI_MAX_IO_VQ	1024
 #define VHOST_SCSI_MAX_EVENT	128
 
+static unsigned vhost_scsi_max_io_vqs = 128;
+module_param_named(max_io_vqs, vhost_scsi_max_io_vqs, uint, 0644);
+MODULE_PARM_DESC(max_io_vqs, "Set the max number of IO virtqueues a vhost scsi device can support. The default is 128. The max is 1024.");
+
 struct vhost_scsi_virtqueue {
 	struct vhost_virtqueue vq;
 	/*
@@ -186,7 +190,9 @@ struct vhost_scsi {
 	char vs_vhost_wwpn[TRANSPORT_IQN_LEN];
 
 	struct vhost_dev dev;
-	struct vhost_scsi_virtqueue vqs[VHOST_SCSI_MAX_VQ];
+	struct vhost_scsi_virtqueue *vqs;
+	unsigned long *compl_bitmap;
+	struct vhost_scsi_inflight **old_inflight;
 
 	struct vhost_work vs_completion_work; /* cmd completion work item */
 	struct llist_head vs_completion_list; /* cmd completion queue */
@@ -245,7 +251,7 @@ static void vhost_scsi_init_inflight(struct vhost_scsi *vs,
 	struct vhost_virtqueue *vq;
 	int idx, i;
 
-	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
+	for (i = 0; i < vs->dev.nvqs;  i++) {
 		vq = &vs->vqs[i].vq;
 
 		mutex_lock(&vq->mutex);
@@ -533,7 +539,6 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 {
 	struct vhost_scsi *vs = container_of(work, struct vhost_scsi,
 					vs_completion_work);
-	DECLARE_BITMAP(signal, VHOST_SCSI_MAX_VQ);
 	struct virtio_scsi_cmd_resp v_rsp;
 	struct vhost_scsi_cmd *cmd, *t;
 	struct llist_node *llnode;
@@ -541,7 +546,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 	struct iov_iter iov_iter;
 	int ret, vq;
 
-	bitmap_zero(signal, VHOST_SCSI_MAX_VQ);
+	bitmap_zero(vs->compl_bitmap, vs->dev.nvqs);
 	llnode = llist_del_all(&vs->vs_completion_list);
 	llist_for_each_entry_safe(cmd, t, llnode, tvc_completion_list) {
 		se_cmd = &cmd->tvc_se_cmd;
@@ -566,7 +571,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 			vhost_add_used(cmd->tvc_vq, cmd->tvc_vq_desc, 0);
 			q = container_of(cmd->tvc_vq, struct vhost_scsi_virtqueue, vq);
 			vq = q - vs->vqs;
-			__set_bit(vq, signal);
+			__set_bit(vq, vs->compl_bitmap);
 		} else
 			pr_err("Faulted on virtio_scsi_cmd_resp\n");
 
@@ -574,8 +579,8 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 	}
 
 	vq = -1;
-	while ((vq = find_next_bit(signal, VHOST_SCSI_MAX_VQ, vq + 1))
-		< VHOST_SCSI_MAX_VQ)
+	while ((vq = find_next_bit(vs->compl_bitmap, vs->dev.nvqs, vq + 1))
+		< vs->dev.nvqs)
 		vhost_signal(&vs->dev, &vs->vqs[vq].vq);
 }
 
@@ -1421,26 +1426,25 @@ static void vhost_scsi_handle_kick(struct vhost_work *work)
 /* Callers must hold dev mutex */
 static void vhost_scsi_flush(struct vhost_scsi *vs)
 {
-	struct vhost_scsi_inflight *old_inflight[VHOST_SCSI_MAX_VQ];
 	int i;
 
 	/* Init new inflight and remember the old inflight */
-	vhost_scsi_init_inflight(vs, old_inflight);
+	vhost_scsi_init_inflight(vs, vs->old_inflight);
 
 	/*
 	 * The inflight->kref was initialized to 1. We decrement it here to
 	 * indicate the start of the flush operation so that it will reach 0
 	 * when all the reqs are finished.
 	 */
-	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
-		kref_put(&old_inflight[i]->kref, vhost_scsi_done_inflight);
+	for (i = 0; i < vs->dev.nvqs; i++)
+		kref_put(&vs->old_inflight[i]->kref, vhost_scsi_done_inflight);
 
 	/* Flush both the vhost poll and vhost work */
 	vhost_dev_flush(&vs->dev);
 
 	/* Wait for all reqs issued before the flush to be finished */
-	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
-		wait_for_completion(&old_inflight[i]->comp);
+	for (i = 0; i < vs->dev.nvqs; i++)
+		wait_for_completion(&vs->old_inflight[i]->comp);
 }
 
 static void vhost_scsi_destroy_vq_cmds(struct vhost_virtqueue *vq)
@@ -1603,7 +1607,7 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 		memcpy(vs->vs_vhost_wwpn, t->vhost_wwpn,
 		       sizeof(vs->vs_vhost_wwpn));
 
-		for (i = VHOST_SCSI_VQ_IO; i < VHOST_SCSI_MAX_VQ; i++) {
+		for (i = VHOST_SCSI_VQ_IO; i < vs->dev.nvqs; i++) {
 			vq = &vs->vqs[i].vq;
 			if (!vhost_vq_is_setup(vq))
 				continue;
@@ -1613,7 +1617,7 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 				goto destroy_vq_cmds;
 		}
 
-		for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
+		for (i = 0; i < vs->dev.nvqs; i++) {
 			vq = &vs->vqs[i].vq;
 			mutex_lock(&vq->mutex);
 			vhost_vq_set_backend(vq, vs_tpg);
@@ -1715,7 +1719,7 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 		target_undepend_item(&se_tpg->tpg_group.cg_item);
 	}
 	if (match) {
-		for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
+		for (i = 0; i < vs->dev.nvqs; i++) {
 			vq = &vs->vqs[i].vq;
 			mutex_lock(&vq->mutex);
 			vhost_vq_set_backend(vq, NULL);
@@ -1724,7 +1728,7 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 		/* Make sure cmds are not running before tearing them down. */
 		vhost_scsi_flush(vs);
 
-		for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
+		for (i = 0; i < vs->dev.nvqs; i++) {
 			vq = &vs->vqs[i].vq;
 			vhost_scsi_destroy_vq_cmds(vq);
 		}
@@ -1764,7 +1768,7 @@ static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
 		return -EFAULT;
 	}
 
-	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
+	for (i = 0; i < vs->dev.nvqs; i++) {
 		vq = &vs->vqs[i].vq;
 		mutex_lock(&vq->mutex);
 		vq->acked_features = features;
@@ -1778,16 +1782,40 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 {
 	struct vhost_scsi *vs;
 	struct vhost_virtqueue **vqs;
-	int r = -ENOMEM, i;
+	int r = -ENOMEM, i, nvqs = vhost_scsi_max_io_vqs;
 
 	vs = kvzalloc(sizeof(*vs), GFP_KERNEL);
 	if (!vs)
 		goto err_vs;
 
-	vqs = kmalloc_array(VHOST_SCSI_MAX_VQ, sizeof(*vqs), GFP_KERNEL);
-	if (!vqs)
+	if (nvqs > VHOST_SCSI_MAX_IO_VQ) {
+		pr_err("Invalid max_io_vqs of %d. Using %d.\n", nvqs,
+		       VHOST_SCSI_MAX_IO_VQ);
+		nvqs = VHOST_SCSI_MAX_IO_VQ;
+	} else if (nvqs == 0) {
+		pr_err("Invalid max_io_vqs of %d. Using 1.\n", nvqs);
+		nvqs = 1;
+	}
+	nvqs += VHOST_SCSI_VQ_IO;
+
+	vs->compl_bitmap = bitmap_alloc(nvqs, GFP_KERNEL);
+	if (!vs->compl_bitmap)
+		goto err_compl_bitmap;
+
+	vs->old_inflight = kmalloc_array(nvqs, sizeof(*vs->old_inflight),
+					 GFP_KERNEL | __GFP_ZERO);
+	if (!vs->old_inflight)
+		goto err_inflight;
+
+	vs->vqs = kmalloc_array(nvqs, sizeof(*vs->vqs),
+				GFP_KERNEL | __GFP_ZERO);
+	if (!vs->vqs)
 		goto err_vqs;
 
+	vqs = kmalloc_array(nvqs, sizeof(*vqs), GFP_KERNEL);
+	if (!vqs)
+		goto err_local_vqs;
+
 	vhost_work_init(&vs->vs_completion_work, vhost_scsi_complete_cmd_work);
 	vhost_work_init(&vs->vs_event_work, vhost_scsi_evt_work);
 
@@ -1798,11 +1826,11 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 	vqs[VHOST_SCSI_VQ_EVT] = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
 	vs->vqs[VHOST_SCSI_VQ_CTL].vq.handle_kick = vhost_scsi_ctl_handle_kick;
 	vs->vqs[VHOST_SCSI_VQ_EVT].vq.handle_kick = vhost_scsi_evt_handle_kick;
-	for (i = VHOST_SCSI_VQ_IO; i < VHOST_SCSI_MAX_VQ; i++) {
+	for (i = VHOST_SCSI_VQ_IO; i < nvqs; i++) {
 		vqs[i] = &vs->vqs[i].vq;
 		vs->vqs[i].vq.handle_kick = vhost_scsi_handle_kick;
 	}
-	vhost_dev_init(&vs->dev, vqs, VHOST_SCSI_MAX_VQ, UIO_MAXIOV,
+	vhost_dev_init(&vs->dev, vqs, nvqs, UIO_MAXIOV,
 		       VHOST_SCSI_WEIGHT, 0, true, NULL);
 
 	vhost_scsi_init_inflight(vs, NULL);
@@ -1810,7 +1838,13 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 	f->private_data = vs;
 	return 0;
 
+err_local_vqs:
+	kfree(vs->vqs);
 err_vqs:
+	kfree(vs->old_inflight);
+err_inflight:
+	bitmap_free(vs->compl_bitmap);
+err_compl_bitmap:
 	kvfree(vs);
 err_vs:
 	return r;
@@ -1828,6 +1862,9 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
 	vhost_dev_stop(&vs->dev);
 	vhost_dev_cleanup(&vs->dev);
 	kfree(vs->dev.vqs);
+	kfree(vs->vqs);
+	kfree(vs->old_inflight);
+	bitmap_free(vs->compl_bitmap);
 	kvfree(vs);
 	return 0;
 }
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
