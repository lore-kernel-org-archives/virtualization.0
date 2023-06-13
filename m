Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BF1C88CB5
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4431640993;
	Tue, 13 Jun 2023 01:33:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4431640993
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=OLZxylw7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=q6JE3ncq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dLGtMlFa01hD; Tue, 13 Jun 2023 01:33:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DBABC40990;
	Tue, 13 Jun 2023 01:33:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DBABC40990
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C509BC0091;
	Tue, 13 Jun 2023 01:33:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5C5BC0029
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F7938212C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F7938212C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=OLZxylw7; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=q6JE3ncq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0emRvILso0QH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AAC9782125
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AAC9782125
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:18 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKNjmm016679; Tue, 13 Jun 2023 01:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=U6uc9CuM1TivS7GGT8lzTevqFFqArQU3HrkPWMZBApg=;
 b=OLZxylw74qCs9jW6dDbvtzcDQWGXhd9RYoekqe8h5E88Hr+GhjH0RYyVVrSdHKh10Kca
 93XDKM8XxyyhbhIhICCv2WLSAFS6CtDies56DOByITU3xO91l9KilWup/YMWo7g5Uesu
 oLpmN9/kRbjToiWVXWhmgYp1uc/VC1aRjb/d8fBxtTn7eYOlCy6E1Ixr/CUGREcf0deg
 +76nhhahlLJ7Mz/o0TsgGsrUCnV+oZSSjEf4SAgHOB9vvHn3BFrAVs2S6lM17IRt75Qe
 Zwo/qnoLqEEzH78e5c3Pfu339nTQTtQQ28HRDp1XJKf/vzOms1UnrZWH1XL8JjkLBaXc 3w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fy3c5f0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:17 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35D1CJRD021613; Tue, 13 Jun 2023 01:33:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3hg44-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjXu93FKwT7zWXThAsHcVf0iXeW4GAX/2u7Y6Rb0okOeXwsPYTMiZ0yLdveACZrK7Jy6dXxhNlTJEDEpRH6whZRuM4rcjArcFyJ+I5Hv5jYiuE9a4zOvwKoFvGnNXzALtRfnAmsdIu+mltno0B2llmpGlYSzDg++9/asUaAZc3cbZ/jyANwPzZJ8hxzPD3GElkUtK4OBfrJ6HqBe7yiBYSOfQ3TEh5u0yG0BgoKFBHWq2mcW6QHiE995hagBTjXov55osoqxmosgAcz3ENM+wwWl7JG696IaM+NWhZfkY1lUxS4nV2kNhFP1ETtyRGPhRWmLVE6WCfLMWxgH7txugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6uc9CuM1TivS7GGT8lzTevqFFqArQU3HrkPWMZBApg=;
 b=UmmzS4QV4H7YDUBjw8OcY9hZbqQb0aLeavxonc1HHLAiWsPZrTG/B+4bvR74vWTizUeUIG4Bu10h2/Jt0K3eQtOVcCdt8jqaT4hJ9klRdQAO6Dke2IWCxdSXFC6lWYHZpXmcgvSZXlfN08lYU+gfaey37YP7/4HvpSx+LYc9p8K83/hHw2AX45jJFH7t52RJSWzjBdt6Xm5onQ5V3l+kFl7MOT+/2oy7uthE8VmzIxn8tRGNKgB57DIhj1rEloJHraz0Tz/UTwjKrUUNy0KyN/DC9STF79HR1rRPLCMUTJSJ0KuxgESDTMsOyUDuTjew2vYtui5cZK+PrrzzId1Ekg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6uc9CuM1TivS7GGT8lzTevqFFqArQU3HrkPWMZBApg=;
 b=q6JE3ncqi9GF24sq3wLwHCOkjyFDOl8Mod5vbyLGMZ4O9Ok2Jk96730TtYllTxHACXZChBOkrJc8p4emnUS0a4PRfDg6jHf3gcMDfBzQlXqRC22qFjWHHL2esJZAfO2DkqPpkitTJM0w/cbXlaC30dPptqJd3y/X3RJSzrMFoAU=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 01:32:57 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:32:57 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v8 04/17] vhost, vhost_net: add helper to check if vq has work
Date: Mon, 12 Jun 2023 20:32:35 -0500
Message-Id: <20230613013248.12196-5-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613013248.12196-1-michael.christie@oracle.com>
References: <20230613013248.12196-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR06CA0092.namprd06.prod.outlook.com
 (2603:10b6:5:336::25) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: d93fb1c2-8e16-4a52-26f6-08db6bae1e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4smlwqqnszZUwNXzw1MB65MIZI992LIXgFRmunK9v3boaIvqfgHEaHVDbLBQnPnqkhQn0CWhBTwb+f79GcBCS5KCwMYcMok+NLANURZcagwVAQLL+7kjT6Zgc85ErzI+ZfbVKUh7VZqhZZbCWhvcwkDpwNVclZPSgXcwej0oWyq4PCX87Ink8DoPks7foobALE8CGGjqooxAHb3U30prONts2i6/l2990LUw7IWpQhIcPgWxFxn4e6b41TxsJYir2RBNQD9KjBSmM5LPMwDFkMHC07aDomk0jfHr1+Mmi5qiIpB2/3nq7KXCjDaR32T2vw52KejkV5CehKqBxGlfOzoxA/ppB4v4cAkwMaeyXgYHFNAcaHGp+V2xRLdyHWo7vGv/HpX2UEOyTg9EAhQdWITFtPrm5EASCVqqHKcPSrfCa65mrI+yXBejWKaJiCOGoDTCOk/v88a68szXdqROnkfKixvX2CGGcIMFH6DZz30nTKhg8i51LQf0by3cRi3UpAUKZ4VAhkQXq9ATrnCYXnyQaydG+YzmJagMcCPD7diVIFehPXJhEegEDk/rnno
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(36756003)(86362001)(66556008)(4326008)(478600001)(66476007)(66946007)(6666004)(316002)(107886003)(6486002)(8936002)(5660300002)(2906002)(8676002)(41300700001)(38100700002)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wTmV8ShlLDTNQxsJ+CpbwMstFcXWNsg4rJJm1LDwnjyxlLgCyV7NY8oTLKcw?=
 =?us-ascii?Q?0/iDIU8pX4ZCI3scczAp+pgB2+GLfZwNee4ede42gzY0fffQVXsWD8iuFtjI?=
 =?us-ascii?Q?ANvhWrnOBsdhioCkgcgqIBjtAuQ+KTWUio2T9JLK4XHnSWfxwS6d9c11aFTu?=
 =?us-ascii?Q?MzAhl34phnn3chI15LZgMajh6LiazuT8jir/3VYVM94oSu9r/x5WQbioM4Qz?=
 =?us-ascii?Q?3O3vJ6r9hmB88aBCLlKr23JNt9AChEnPr15glOfZYXIeo09FQLZ9f2uKl7go?=
 =?us-ascii?Q?TsAyOoiPqu6ZfANTvNNMXojo+ox3Hc/Y/0NgrmmtHnEtdj7OcGti2jTQPwUC?=
 =?us-ascii?Q?AHi7pRpThMkYb7ZMEgbeFCkUOMCi5tf5IJqUU5B76q5V+GzPN6UDiCDKV2sS?=
 =?us-ascii?Q?oq7v5frPe0hNxIGZ85rMpO/eIf0ViKi5VMiuM0Fn/qc8WbENad5smDn90eOb?=
 =?us-ascii?Q?6UNzJTOal6ySFWVdv6FQr9ZzbqVcGuqXQFMvGCpPq7OD0sGmRyLQILEZWbqy?=
 =?us-ascii?Q?v/xAtI95x7h6I+5ULHmCi1G4xtmj2IIH7zNDBU81X097YyqYanXsZI+ZnpNB?=
 =?us-ascii?Q?rZCjnIDTFsgG5nZUtrWU/TWhA0KKDkI6t8nWawf/EvN1bSh+20/51ZhJb7LS?=
 =?us-ascii?Q?r1ph+a1pbxvgd/iKrERUADuEzAMF0YX3P7wPmRogwYeCgpa9xsPcGjnC1T9m?=
 =?us-ascii?Q?aeZWtM0jCaKSQ3Cb6/yJHnFopNzK08nC5vRmN710Hn8M95OtGFr2NEZ/TOTu?=
 =?us-ascii?Q?3xhdpudHSgVn1zUGnFNA07Ra5TUjwc7FZ9lHhRjbNmcfSZ0nwLt1XP0IwBrE?=
 =?us-ascii?Q?lxZadhdtoPSDuoPY04x7eKjPbes4BgnRw8YUkOhSdoUYsMYeyRr+WKa5troG?=
 =?us-ascii?Q?1NTfSATGAi87WPskrI4OBEWR0NerfVvBEhaAKMnd8R06fRj0g2LwiX4vcsdJ?=
 =?us-ascii?Q?xuE4rQt3bJtoi7fA9qv8E9e6E5qkXkN4oeIoYAAGxKH4rzrPXxiZO6/GROag?=
 =?us-ascii?Q?M2XZ6ugn5Th2sdjJe9/vhD6TomIFY6/Wyizrd/BVvNpCAp2WsjYcwqb5NxUY?=
 =?us-ascii?Q?4cTzmEiPPzfAjD3/rlsmBSoeXOFNeLWBP9a9f37/yQkp6NtkFSVtAY3lTGN2?=
 =?us-ascii?Q?bik9/fvl/7JrfhEuN+6dtNgMEfV0p1J11e2bfYXUQbamF2V199GUyfY3za9L?=
 =?us-ascii?Q?7DVZKi73MM4sIsR1KzZu6Vz5XLBWPPFyoBGk7bKNjUIEn9wACtnpTe6OOZh5?=
 =?us-ascii?Q?/J3QksGQD1cGl3746ZKA33oYZA6mdVfQ3JpuYBmlRIdo2V/3c7g30C/hSK6T?=
 =?us-ascii?Q?tudkKZtV7BcZ56k37b0vF6ZP45+uyfvnbm9IZoDwUrTsL83KFyRPZhDGMz6+?=
 =?us-ascii?Q?4Xa79ESAut0B3kqChm+KDqU0L9qSZxFB148l6akGT9nnhhbKxdCupWlEsUs/?=
 =?us-ascii?Q?RyZiR9ZNdtSwp5kFhN8od9FzTQx1FvSNET6rN2bbvS77ecWU1H4T3jJgiNYp?=
 =?us-ascii?Q?oVFaVAN1yWwczySeWNzOH+H3DMQo+Kzell4d2io17gdjdnyw9ncYcYDeSwGn?=
 =?us-ascii?Q?yqS+r5gjy/zTRgr6e9+SzBsQGen5vBWim+1HUs+a6BzulaeHoJUv2YpFSiYY?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: byzY6u+6cq081vqI0t1ZU6DXgoD0wDMG0WtUHCofDAiQYXXADmJS5VOYmf8f7Ia9sRcBq+07PCuR/famm6iBQAkg3sHcPiODBBn/CXSN/iHoxawUX9pHZAMPbfwCDItBXfvd2vAIwjf8tpr78TIPqeotQVxDUDU/3quZHAykOCjADxjhW2ErL8ME0OadyI2zvJbXSVxC3A6aHLhfp1nEOKMGPgocgVQ+o+rnSqilZlDu8jVmStgFKi9aMGNhKdNhUdN6zXfqwWjWYLFFR+AoJi1QKv0mrPFCvzZ3+lkOyBR2Er7UqCnfmhPjfHymcr9uamBptEOQE9SZ0YKPbhnh/DE14PNy44G3sbJlsP86DOsvx6V3CAszaNsgp1CA+YPpqgWxk1s5AifaLdKhwSmEKWOpmoL9XvhWCOOgZy6QIFNZHpjmbdSmGA0Zl1SWujJb9XtiC2TlXP2dUaYY7vkuNgTeRizDSU2vpYOKoIQqG9IMU74M7seAPLOsGgmJm7/a2YQ526GF4BClsGF4atgmgXWiXiT2oRteY/GHesan75TwhUC+F3V3eAaAqtuYPj3ZBPMqIPhnd7ANhJECrEqWcZmv5Tgkkesx2s3cwjOQ+KBLzSd3jq3Fs3WrY3C7WLriWcDghMIlpiLgFCOV6LL21uVhdvcItOn/qp5k72GoNZ/X+Pw5tr/1e5R9tQpupWMaRXLkjcZwx/s9okBznqdLaYNbidvnOhrb9+8vs7RzmpY8I4Et9xBM3IGXEnTBTttNJRn04z7n8mZJuwxv7NdnBYCo8WPtaLc7lAOQrpiXSbNtPcE2rhvxibZalLujt6kt
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93fb1c2-8e16-4a52-26f6-08db6bae1e09
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:32:57.7111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 957LpE3rryVH1nmuZVl8G0QLgdDduMfdozBrjnQmfDK4r8OkYeU7OzA3EDeZoYk3Jrwfep7q9sXVquQyOJMo8fCqch3CfFgnfh1yEgRlvzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130012
X-Proofpoint-GUID: 1cXn1mLyL3AYupEFq_ZP-t73f4Ypqvtr
X-Proofpoint-ORIG-GUID: 1cXn1mLyL3AYupEFq_ZP-t73f4Ypqvtr
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

In the next patches each vq might have different workers so one could
have work but others do not. For net, we only want to check specific vqs,
so this adds a helper to check if a vq has work pending and converts
vhost-net to use it.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c   | 2 +-
 drivers/vhost/vhost.c | 6 +++---
 drivers/vhost/vhost.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index ae2273196b0c..98bb957eb3b9 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -546,7 +546,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
 	endtime = busy_clock() + busyloop_timeout;
 
 	while (vhost_can_busy_poll(endtime)) {
-		if (vhost_has_work(&net->dev)) {
+		if (vhost_vq_has_work(vq)) {
 			*busyloop_intr = true;
 			break;
 		}
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c78c15af97d3..a832ca692eb1 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -266,11 +266,11 @@ bool vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 EXPORT_SYMBOL_GPL(vhost_work_queue);
 
 /* A lockless hint for busy polling code to exit the loop */
-bool vhost_has_work(struct vhost_dev *dev)
+bool vhost_vq_has_work(struct vhost_virtqueue *vq)
 {
-	return !llist_empty(&dev->worker->work_list);
+	return !llist_empty(&vq->worker->work_list);
 }
-EXPORT_SYMBOL_GPL(vhost_has_work);
+EXPORT_SYMBOL_GPL(vhost_vq_has_work);
 
 void vhost_poll_queue(struct vhost_poll *poll)
 {
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 206617edb2a9..37c183b37c42 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -45,7 +45,6 @@ struct vhost_poll {
 
 void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
 bool vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
-bool vhost_has_work(struct vhost_dev *dev);
 
 void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
 		     __poll_t mask, struct vhost_dev *dev);
@@ -199,6 +198,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *,
 		      struct vhost_log *log, unsigned int *log_num);
 void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
 
+bool vhost_vq_has_work(struct vhost_virtqueue *vq);
 bool vhost_vq_is_setup(struct vhost_virtqueue *vq);
 int vhost_vq_init_access(struct vhost_virtqueue *);
 int vhost_add_used(struct vhost_virtqueue *, unsigned int head, int len);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
