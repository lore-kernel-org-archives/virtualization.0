Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C6CC0015E
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 23:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 458FE60DCB;
	Mon, 26 Jun 2023 23:23:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 458FE60DCB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=1ulf4fuI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=zK/oobEc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VLUc6MkAyiY1; Mon, 26 Jun 2023 23:23:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3B32B60625;
	Mon, 26 Jun 2023 23:23:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B32B60625
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1009EC0037;
	Mon, 26 Jun 2023 23:23:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2133C0091
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9CD2E409D6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9CD2E409D6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=1ulf4fuI; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=zK/oobEc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZqAfnLHHB11Q
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 02BDD40990
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02BDD40990
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:34 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QMi6e6023163; Mon, 26 Jun 2023 23:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=pG/JvZdnjFdkEkD1zZXwN8weL78B5d03QixykEXxnvA=;
 b=1ulf4fuIYh7vDfw5T+IqLGxFbPUi1aFs9BXMPPI35CVzoQau/DIvMXD1asB2zHSdht54
 KL+04Guj/3VvhWBTWDybvd5sXtT21N/lBElwnjUHurj268IACXljLOkneQM1sc1GVwW+
 04/fKPlmmeYfo5AxWqPErzj5XupVOF9irmXX6gtkR2wWsFc2KVzRWGDhGI7xOB+mIyyW
 XKq48jxIFyaw8Xiv5t4W6AjkB7QOpO7eJyBpWa/IbcB7OMFujzh7dgaQCxoxmUlaezLB
 9iHltAsNQNloMA59CGxSyRRub9ckmTHAWMo9qrfmbL2j+5esATLQt/jRoKmflaR8Cair YA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq933ufe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:33 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QMRJZ6026359; Mon, 26 Jun 2023 23:23:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpxa88fr-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bR+F1gpj7SWtyNvNEHUp0bcrQXPn5tjXt8mnueIfoaEoCJUXqGxmQyKQEIaFR5Xv/SEQ5ZLSNyQVwSEkioSiEhaMG/wTMgCZv3+oBhIe/TD+h29xBzrRV7P253sEblq9lxlvs712+EtYMUf5dXS0vBu6SEf6ZED5CKIGbe0oARyOBf6EHdGdBFMrPUwy0uJRFp6swVl5Sjyd+nuuTqwY96J48bWUn4be7e4jhAg5mOQo0vT7iYz+gMyERDPH8ECrJUWd1z20/oxah6XbI0x7ku6wXvzpsbHDbtUljAT2CgveP4bu5EB2kIOQAhOGM2qzYM70HXVvRbdYqQcgdvinsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pG/JvZdnjFdkEkD1zZXwN8weL78B5d03QixykEXxnvA=;
 b=CA3SEA5fjz7oj3n/Bngpj2JYE5iDaUhH+rxFY+KkYvHFq9/WNSzxn7xfvz7U2VGxZq6xOkIonigwwtBJWhLmvGUO8VfKW4JBoW/iQOQf2hthJq9t5Lxv49sM/jHKN+DjrrZKuSAjCc8YeS4R+ixdTSlE5g5wnKJQvtFhnXq2i2WijzR4dDrYjePc2M8gp3j7nuYoY3aa58w2iWYLSEIoztKbVM18YdxhpmJ4MlEc/eJ6x+z0TiOuPIfBXoehbe2MAeKeCeHtO5FnlQjTmdWmd208/yoipaZl93SXsaUKkjEM5wEQcs3wxNQ9tnxOc/WdFsHQbk76FR19Y7m1TTamGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG/JvZdnjFdkEkD1zZXwN8weL78B5d03QixykEXxnvA=;
 b=zK/oobEcmTZzftnMZJnjarJYFPQXXarcdieRUcg5uNnC9GIZ6QLgryx+/RkKiLLmDq28Wi7/SkLAFaO8qSlka6hMbA+zgpUt4J27xjmMc/mg/X18HMHz6TiMEvms1RYFS2bcLEInBNktowYQ2TZFoAJ8lvtXgRXjx9dHIipM6VE=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 23:23:32 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 23:23:32 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 14/17] vhost: replace single worker pointer with xarray
Date: Mon, 26 Jun 2023 18:23:04 -0500
Message-Id: <20230626232307.97930-15-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626232307.97930-1-michael.christie@oracle.com>
References: <20230626232307.97930-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::29) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dac161a-1e06-44e8-87ee-08db769c5b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FKL5OrycRwk5oEL6FJ3jjWeDEMDpnIfxpPsFQ24HiOAwcS24m+67R0+Pt8DOLfB4b49Ukn5YrLn8687E2K1m1UbH26uAwWen90iN+WiMHinAm1dGHhQwKQZ7igi0JOoU/hYlRSG+G5LP4WbY9vCClvQKx7nCTakXHWBoRWiWSkZK3k5V9p6jwzpiVRKyWf8uRxkt60e1O/hjxQltJBytLGQyRASfumxWVH+3wdIP0EMFTBMY6pxBkZ9Zkz1+r2SLophMH19N9xW8L6gYfFqt4vhnuGbOJHyGMTG0+RwGRHIFx94ng6kolxJ5I7Pa7A4rg+iuYL5niVynSFphWDjUTRZ6B5BQF6++uOwqICUUvbxsyF7u4IWMTFQgi3JA34uWIkDf79TvpvoUuM/RbPW+6KrOcL+WnXskzA+M3y8rzKRltnW3/wdWhY7G6paTmKMIcVzgnqPoU1TB35tgoKVrg5cYzaMW2iWyAiaN8c7A9K4T6UM+CsMd+APbwAekSmUwqM8gtTaUVPGQiYi7lEHhhwSAqMf50mriXdc6SeW1010L0oiDy3Fijkv2gL7mO7VwTWLyQ/DKZcK0fos+qMmQldN3yDBdrpp1gbRcvZRR/4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(2616005)(107886003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OTFAJSVo1ySxTfQYsUc4uRJCPvTlGeUKswSjQ1og28Sf5Rok5kMBY2UzC13e?=
 =?us-ascii?Q?v56svsE+Vek6v9bo/REkYrJd1D+mMALv/gDG1HT2t9f6waBokbGw1lkFo5xz?=
 =?us-ascii?Q?/I4KxNRRsO8Orgyg6q+K2wcBpeo8hZ9nIEtTRkV19cb5SVGSD3U5UKPfuuk3?=
 =?us-ascii?Q?oKh0+D49fJeerJar3o8jqaEguSRXVWWFfJmeYwi9pqvjUf+GItQg2b5yr28i?=
 =?us-ascii?Q?T7XdpbnBHEp151ZE0RRog78X0gI9LNQ36ou0o2EZXxjQg36RGbDE4nsw+eEz?=
 =?us-ascii?Q?iFvPLXnmRJ4oR9QO/W35W37vwqqNex/pVu0AFlLMl9jhOcUY/znn3nGWfgh4?=
 =?us-ascii?Q?8snpkaMEsPrR3sfsTjX8zUl2Htv7Fn+d6mej/AEtKhYRePckmgCrrbKTL5VP?=
 =?us-ascii?Q?+0YOU/RCUlqAZkbsAu7NedRRNHWONI+RekYYp+WdjOmARVoJJ4py5ujcQV4z?=
 =?us-ascii?Q?BBaT6zA+1ME8b2Bf/Tzt/R6uKAxzveH1svmfbdTsB2RiOxb1k5uQow67UeUi?=
 =?us-ascii?Q?W+GfILeLX3i67ZvYf1MiKK5NKv1dcVJistSkjuwhRg4XlIJh5UdGpoDqz1U9?=
 =?us-ascii?Q?36ICJK/t8qBR29cr50EOOkgd1savUKp+idZh9jer9svAM9GdDWcnhU38k9Ce?=
 =?us-ascii?Q?ns5V64pprXsYVAro3PxffraHvD2aEKrsbVXGGyGjLOcRgecr0QFagdZANfbQ?=
 =?us-ascii?Q?eQdOABnSyuLITu9kaCncShksh7QOSzbILvOUJDSmTEucTIkEyYlo6DDFtlB8?=
 =?us-ascii?Q?uu7HtZPoOyBUAMnm9DWTMlg63SiPikcX5UH8qx9p8UZZe/HHJJbATzpNl3+k?=
 =?us-ascii?Q?DXit+5w5vGLOP/bzfa/owC7wlGklNWL0beiEyHr8rL8m2GTSBOztzx3rv8mY?=
 =?us-ascii?Q?aPRvReOUSQgX8Wv8ytN58/ySPHVflKyviWYv2lYVP+R8C2BCMuP/hU76GDGI?=
 =?us-ascii?Q?o9RA14WfPRGqL4ITMB4Qv8hrLFkHuCG2F4PD6pXesJ39BX8oWP3lP7Kjo65b?=
 =?us-ascii?Q?2ZC5sdF3f1ZVfUJ8q3CoXf//8nJ4hz+QQroibrL60tr8WsVeVxSyfLlXq9fs?=
 =?us-ascii?Q?YHse9RhLuOJhgCmSZm8ouZAOd5LrkUHDNx3aHguwrx4ZR0RYqcgRwgiuYqcP?=
 =?us-ascii?Q?3LuUHjiEfU/3q2Ktu1MmHLzS+1Tk35KVkpullxrk2Zhw5xO1kdJR/LEb5Fxv?=
 =?us-ascii?Q?2Zek0siWaKhAOZJJcx9c3WCwIqLbGGUO4KnQwGLME7a18rEpPg1zhsNCUFz/?=
 =?us-ascii?Q?i7YcyI1C5WJ8ObDyZC4XWx9t2wVnkD+Zo5w/0J/M+0lmj/E/ehkixJmD9zL9?=
 =?us-ascii?Q?H8e3ix3nnlde2fNRFtm3cMktEtM9WZT0vXTahNJH8HxZGavtM2pHdzVH66Z9?=
 =?us-ascii?Q?kTpZY2hDh+A/ZWsiXhH+4xnguIzkLQlqutrawlsxogzy0dtYkt/OaII3/OZ9?=
 =?us-ascii?Q?b0rK+jhp67ylijQfvGeUg1KkcPSh5xCuTvgn6dd7+dkeQmFO77UZNcDORSXU?=
 =?us-ascii?Q?CPMiv7diQVIGlceoEwRjIhIV7Iobb0scL9NHNrB85xuYDf+37lECogxQV7AA?=
 =?us-ascii?Q?FWzCkYIrAVr6YqyEL93x7O+Ol/OYIzXicGl4unY8dQLzIpQLEfhN+4853Q80?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lZXKS5O27Zva/frDgFrvPhuT7SQIO5TCUlmnILN/pOIqguNxV78xWFrcjMh6Gm3ABwrozPCeC0auJB4VWOj0SczHxfphmP5kgqFVImnIlYKQR+Fm9Qj0xFdKk0Gb/YO5UT1jHczEIFflkwGrD4Gbkzu/PHj/7KeIaNtY3QgFsUEhBrGfzYtW/OP0IFuD54yuLKO9ewNr+Zcj2wUiVnov7AOcwevLsC5kQai5v1wtK4sh3LJaBtafgPfNJISmkF2+JROJoW1xoIOysUklhFfGjkEjiP8VTdiUyHiIdZ/vu8JvHAWjDMTjvwC6vnnWkgH+hXpWn8ipsF+dvHsV7BLtX9cNAgm32T2vMWHOLFqkDf7p6L82LN5SsFYaIpIsa2zkn0k2bPUqVnLns6aIsNDF+E/8Da8lTQiBn46x3aqzBmNfghR/jK0KbEH5qY9Ij/c6S/rRIBXsJOor8dk/ZiBPIseW9f/3Dt83WkoRp8T6BeiVkIok58T3OhuAXHvkMlQ/sTOf3dP16pesHMcDLFTiFsoIiW19R7N+FqnBIpU2+hUAYbU1LW8zp0Ue2ALTqrq+dN0h9La0bf9jJsaNU5PJfr2KE2tpcYRFZBsLj7UuUdOtVLTnh0fqKYSAfuo2fms2wzWzujPPOqz03BCK8avfvUtlNJwyvpc4tNFotkO69LzTadhamKMpTsi73+AdRaGuJXu+dYUW5+3egrDNlIofBCIFrq67EobjHdS/HxxG8VQ7QpgqoWRwHTN5d4g5N5XDE6S11Hj4w16A0QIYMzmgb+xLy44OpgT8AZiYmHmYOcO0b7bG8AE7GKztNqEM/zxI
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dac161a-1e06-44e8-87ee-08db769c5b28
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 23:23:32.0451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FixrwYQW2YQAzFwXUHefduNVlIWj4YEix2cdNNUDoSZNJiHRF1ki2h8flAwPKTqgvc7HHUuSch8WbbTk15EnwVOrFQzMVyKSKA2J48MEQlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260218
X-Proofpoint-ORIG-GUID: H8_ZAI8inDLHjobQ6p_V7-ryrOo75xXQ
X-Proofpoint-GUID: H8_ZAI8inDLHjobQ6p_V7-ryrOo75xXQ
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

The next patch allows userspace to create multiple workers per device,
so this patch replaces the vhost_worker pointer with an xarray so we
can store mupltiple workers and look them up.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 64 ++++++++++++++++++++++++++++++++-----------
 drivers/vhost/vhost.h |  3 +-
 2 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 12203d3893c5..ffbaf7d32e2c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -280,7 +280,11 @@ EXPORT_SYMBOL_GPL(vhost_vq_flush);
 
 void vhost_dev_flush(struct vhost_dev *dev)
 {
-	vhost_worker_flush(dev->worker);
+	struct vhost_worker *worker;
+	unsigned long i;
+
+	xa_for_each(&dev->worker_xa, i, worker)
+		vhost_worker_flush(worker);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_flush);
 
@@ -482,7 +486,6 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->umem = NULL;
 	dev->iotlb = NULL;
 	dev->mm = NULL;
-	dev->worker = NULL;
 	dev->iov_limit = iov_limit;
 	dev->weight = weight;
 	dev->byte_weight = byte_weight;
@@ -492,7 +495,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
 	spin_lock_init(&dev->iotlb_lock);
-
+	xa_init_flags(&dev->worker_xa, XA_FLAGS_ALLOC);
 
 	for (i = 0; i < dev->nvqs; ++i) {
 		vq = dev->vqs[i];
@@ -554,15 +557,35 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
-static void vhost_worker_free(struct vhost_dev *dev)
+static void vhost_worker_destroy(struct vhost_dev *dev,
+				 struct vhost_worker *worker)
+{
+	if (!worker)
+		return;
+
+	WARN_ON(!llist_empty(&worker->work_list));
+	xa_erase(&dev->worker_xa, worker->id);
+	vhost_task_stop(worker->vtsk);
+	kfree(worker);
+}
+
+static void vhost_workers_free(struct vhost_dev *dev)
 {
-	if (!dev->worker)
+	struct vhost_worker *worker;
+	unsigned long i;
+
+	if (!dev->use_worker)
 		return;
 
-	WARN_ON(!llist_empty(&dev->worker->work_list));
-	vhost_task_stop(dev->worker->vtsk);
-	kfree(dev->worker);
-	dev->worker = NULL;
+	for (i = 0; i < dev->nvqs; i++)
+		dev->vqs[i]->worker = NULL;
+	/*
+	 * Free the default worker we created and cleanup workers userspace
+	 * created but couldn't clean up (it forgot or crashed).
+	 */
+	xa_for_each(&dev->worker_xa, i, worker)
+		vhost_worker_destroy(dev, worker);
+	xa_destroy(&dev->worker_xa);
 }
 
 static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
@@ -570,6 +593,8 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	struct vhost_worker *worker;
 	struct vhost_task *vtsk;
 	char name[TASK_COMM_LEN];
+	int ret;
+	u32 id;
 
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
 	if (!worker)
@@ -584,16 +609,18 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	init_llist_head(&worker->work_list);
 	worker->kcov_handle = kcov_common_handle();
 	worker->vtsk = vtsk;
-	/*
-	 * vsock can already try to queue so make sure llist and vtsk are both
-	 * set before vhost_work_queue sees dev->worker is set.
-	 */
-	smp_wmb();
-	dev->worker = worker;
 
 	vhost_task_start(vtsk);
+
+	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
+	if (ret < 0)
+		goto stop_worker;
+	worker->id = id;
+
 	return worker;
 
+stop_worker:
+	vhost_task_stop(vtsk);
 free_worker:
 	kfree(worker);
 	return NULL;
@@ -650,6 +677,11 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 			err = -ENOMEM;
 			goto err_worker;
 		}
+		/*
+		 * vsock can already try to queue so make sure the worker
+		 * is setup before vhost_vq_work_queue sees vq->worker is set.
+		 */
+		smp_wmb();
 
 		for (i = 0; i < dev->nvqs; i++)
 			dev->vqs[i]->worker = worker;
@@ -751,7 +783,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	dev->iotlb = NULL;
 	vhost_clear_msg(dev);
 	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
-	vhost_worker_free(dev);
+	vhost_workers_free(dev);
 	vhost_detach_mm(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 83f78b6f563b..44c3017766b2 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -30,6 +30,7 @@ struct vhost_worker {
 	struct vhost_task	*vtsk;
 	struct llist_head	work_list;
 	u64			kcov_handle;
+	u32			id;
 };
 
 /* Poll a file (eventfd or socket) */
@@ -159,7 +160,6 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct vhost_worker *worker;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
@@ -169,6 +169,7 @@ struct vhost_dev {
 	int iov_limit;
 	int weight;
 	int byte_weight;
+	struct xarray worker_xa;
 	bool use_worker;
 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 			   struct vhost_iotlb_msg *msg);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
