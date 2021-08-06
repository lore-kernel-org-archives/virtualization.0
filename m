Return-Path: <SRS0=epgR=M5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5729AC4338F
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 02:38:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2E161186
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 02:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA2E161186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 900FB83BA2;
	Fri,  6 Aug 2021 02:38:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6VAqmV6PdJOS; Fri,  6 Aug 2021 02:38:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3314983B47;
	Fri,  6 Aug 2021 02:38:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECB60C0010;
	Fri,  6 Aug 2021 02:38:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10926C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 02:38:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E0EAF4050C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 02:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="wpwO0+WE";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="P6PdS3dS";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="lm9GlDju"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hQ2C0FFj86yU
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 02:38:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6DD8F404D6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 02:38:35 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1762bApn026555; Fri, 6 Aug 2021 02:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=lxe5Cm1S+VrVoP/j7wgprFlGF9L+RuNFvgHNCf2F8ak=;
 b=wpwO0+WEvpTCBoixBRc+LQmJ1oLquhwSkNIP2tV9qsY+LY8VD42JLmwFq8+jmSTQPqfa
 lwyLRw5UqyaIuC8Hk0grvtUtgXsiBzLJCcZ6TkSwAMaaF1pbxFdv+Bh4gR27jCbB3nuO
 OXXn6+GZrlj/kMgQInFmmgNWzNhc6mb7B+Ucyd7nGfAa6B2oyMSTcnsaFiW+43rhYOJC
 6ua12Xx4fu2f6mFyE3oDfBXjfa1bGYS/l6OKXmTH08dSZoNK9BEY64DsSxCjbqNPQQDE
 7F+RNFszXa3hvugMt3luN/GpqYJhcE+fQ0aBVTfMmM2mzlY8RbWIZI5h41/CDkeN7hTA TQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=lxe5Cm1S+VrVoP/j7wgprFlGF9L+RuNFvgHNCf2F8ak=;
 b=P6PdS3dSXhNmUDYbi06NJtU1h8uYfq9/zuEt2in+Ppx5YKhkplt/kzsqvmDbNGxyKnUu
 tr3qtMKUIm7+Cg1te8Ho7y/gGfpKnWnX9jD0OJqMxKX51oeof0vuwvc7CPzoAqfj9/Xw
 nObE2PxzTCswyf5Qq22i55yX3lMMZEFNseI/idnXNFW4rUWjWB4vW+iwng/etV9YNJul
 H0iSp0R44hG+u0cNtRgu5y+a3T/XS68Zkled4xAdU8nNqCSjDpndGdctE3p+1/nm9y1P
 6zCN6gJnZZOXPJVDekHIVSy7Oc0YCeCVQFCBB3OWzaPM6hbr9eTibvIJhG7d43AXvHku Qg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3a7hxpnj7e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Aug 2021 02:38:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1762ZfOX163593;
 Fri, 6 Aug 2021 02:38:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
 by userp3030.oracle.com with ESMTP id 3a4un4x32e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Aug 2021 02:38:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d45Wsz6J2Qp9srdC51J2vmTF5rw610I1vP/UJp5hPeWgUoCDX6pOFJnWsLhszXFWyIkXtOjfskPcOvtTzgU7qiGo9Di2tHimI22fH87ScRsSn358PRH9mo0wM5Lyo7lZf10PMwKtVR04ypyGmTMZu4cdwTtgFjGYRZJaWk4THR9c5iSLm5Thfd4/PghKpNT0GVl5SEHjZ0xM8cu3o9F1eznRsyg3y0zWsxRGBHZnEx0wu/tIYqfJefQCsJitigjm6bJI+eVVrpvJUhUba+k9yprm+mcJHznAvICi5RJsNBRrJZbRxqzDeHF86nmbbuXG7wVwI2wLpYFHIr8uVU0w1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxe5Cm1S+VrVoP/j7wgprFlGF9L+RuNFvgHNCf2F8ak=;
 b=PL2bFGSwnD9QXLRgCF1HdNhdQVjJE6DUBN0HsYt81jgVYCO1EHqdS8S32hSsiRxkxTw7vpRA4oYmBUqYNk+aN2xLAprJWlF1zeD7z5vRwo0UIxPTj1aBYH3Cu0wU6e5TeugEwH3woa1YWjnyxOCb3NF9CZQnV78Rb4sZUF0h6HABIlvQsx257oFjCzqEze3XQajrFGm4dsf069isuTbsPEcLSW6mh6vFBnsEbZYWHOPOL/9qUP9/jA0vlCMmVhF+yZHnB1KvdR5yYRaA2r97Oa6fu5zXJlcK9FKhrTnLQbWN2qPaBcLG8VNGNk/zO3wiz1lPKLhnt31x7PjrmAi6hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxe5Cm1S+VrVoP/j7wgprFlGF9L+RuNFvgHNCf2F8ak=;
 b=lm9GlDjuuZd8Pa0Zvqnjlcw+EeFydkj1l7wt65kpVbUkqbw9yJeo98EnXPbjAacnONFmwnzZ+CDWpiH/DP13DBJDDgmIdxt3pAQKj/SHGPcuUOr6xKSeQX+7ZGmS97KI6Wnx2RpdizO4hK+zQVTzD+FlUGOVHi7niXnKfpPg93M=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5547.namprd10.prod.outlook.com (2603:10b6:510:da::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Fri, 6 Aug
 2021 02:38:15 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::153e:22d1:d177:d4f1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::153e:22d1:d177:d4f1%8]) with mapi id 15.20.4373.026; Fri, 6 Aug 2021
 02:38:15 +0000
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/15] bvec: add a bvec_virt helper
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tuk3guwk.fsf@ca-mkp.ca.oracle.com>
References: <20210804095634.460779-1-hch@lst.de>
 <20210804095634.460779-2-hch@lst.de>
Date: Thu, 05 Aug 2021 22:38:11 -0400
In-Reply-To: <20210804095634.460779-2-hch@lst.de> (Christoph Hellwig's message
 of "Wed, 4 Aug 2021 11:56:20 +0200")
X-ClientProxiedBy: SA9P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::30) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by
 SA9P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 02:38:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37bc1a19-ab81-480a-98f8-08d958833dd1
X-MS-TrafficTypeDiagnostic: PH0PR10MB5547:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB554779D0BA37A158A6A51D278EF39@PH0PR10MB5547.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEip2dgbKdqZ4Asg58kgknokPP0VL7s2MhAl/RcCcR3taRwndoxL7E712HIVgx9LdTrlNqQ0diDJszAe4rBXJk0aVwB4arw0ONCn5cC8IUL9sSK3UMCgZLnKV7lpO89eSju6eWWfvlJQEqK1lub3+ocK+KhN7n1FeZLZEUr/Jcml06d2lfKNyRuYie2qXchAtGxkZhaM3Oi14SiJEFPvo4x7wzO9tSPy2JWJ4buZKJzVDWs6k/UtiK4ZbNorEjE4noZAOk1OMRLJ+zfjo5YDXN3poq5pvQxuatHatDIDUCjIuU/B8F8712qa5z4b/W1TCyX8HP6DitEZqK4xOVUJPlbPduP4hcCTaQLOYSrt1f896Rj5NeitTldF/8Vf0KpemAdcgbbJc+zuiUHMkDpuVNPH0p1jqnVCy700lBRvG/zenHMOo8Y/ib7OAH18tWE+uzrMnDed1DQBDeOGAzCG6YtX5QQnCW6W2OLjQUjC+hagRWtuXZRIP2MCQf4IVU/O3a8AL6Eir5IPQ2n6tFbukGHagq3zIcXBS6AB9VAqCR3I9QG9gPILlANRxk6n72qdZlWr9fSHZ4u1CzIRT8N/5MfBcmQLhLXu9PfqFcxjgd4zqPPCkm9/ksZ9hBvEBaL4Fi9mamrnqQMjFrgduQP02LqQp0myyr5mWsUAHmHnJAk0ta8XMlLNoatxGvdoGcFhCZ1Zj3PBZrCUAwyyfV3Eeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4759.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(376002)(39860400002)(396003)(136003)(346002)(186003)(55016002)(8936002)(2906002)(8676002)(7696005)(52116002)(36916002)(38350700002)(38100700002)(6916009)(478600001)(956004)(54906003)(66946007)(66556008)(5660300002)(6666004)(558084003)(316002)(26005)(7416002)(4326008)(66476007)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HwqZ6hDDLzRzX+a0nli8YIlaVQoXWqp5xHzf2aqWrJ3KUDo/c3Z+0fVLgg7q?=
 =?us-ascii?Q?7vHOTmdJPFqcfAu2fpD5jg51HVvw9a2CQOE4HPRPrzJqt9wFVr2Q7AfOON03?=
 =?us-ascii?Q?YjK8VkpbCU3nrWFAxYqJMeeczHdsl95+tbc6lUjSfzJLsrRgqJ6S79QciLgN?=
 =?us-ascii?Q?OKmg6/3qGpwmh3po3B3GPmKHSZkdTri7jadDwiOIZW8W2AKxx5bT1PbVJg9T?=
 =?us-ascii?Q?CRXExyff6w4rG4/Q8s3aDOCD3yPqZZ/pHPwSA5BENGHOcAPCR8AaLtwVKZOM?=
 =?us-ascii?Q?0HieGiehG3YEC8QboF86m+C6W3zMCK4zw7tUnsWAZVD6COzDyDQ8GPMU2rmu?=
 =?us-ascii?Q?+4dCsq6TY85PRALRHUy0G4pq3f0+6+KK+Gf8AgbYBLGj2jedtz3yTrJ17V4K?=
 =?us-ascii?Q?+xIyoun+VMyc8DU2RN7AE68VhGJIXo6a1Mc/qCCrKBYKNX37EO4kIziP11TJ?=
 =?us-ascii?Q?K7YosFfZMrIrMeEgRsW6AH1+vVoAd71uZ4GLxjT15quVWtU+Dy8zXjlmlf5E?=
 =?us-ascii?Q?+UUs6BwDodJIUdHzgLnxhwZAzfuQLc7VlmxVHz560DEgHMMsl18ES9YbmEHm?=
 =?us-ascii?Q?uMBPFez7qUHTpb8vVktdVE8eIEMDD7fJoVamg6W7nZYu2WnD0nTKEgskawiP?=
 =?us-ascii?Q?44VtjlUdvSRJxI0xkALX3mcwT7VNqoU9jH+sVI53gCNABV9G35ncG5JRGHYk?=
 =?us-ascii?Q?LePs+GQjGe3Y0EgbXR74UEP+YbwvRr8qDg6luS7kmAhCWX9wTK+q0O9JFl8P?=
 =?us-ascii?Q?g/bG5T6HvWy3Aw5YfS7R5bv2SgZkH75vYPxPJGEDxE/7QQeL9RkLuU+IZZKu?=
 =?us-ascii?Q?Z3eGJcTwzmcg/ESN7zKy92HK7TMl2ywgAHPgo5QPEz0Xo9LAAxqlr8I8Kj/O?=
 =?us-ascii?Q?EAZ1Y75kVbZKBSzurNCd1+dAsguu3XljvDtv5fsX0pEIMG0TRidcagMxozhr?=
 =?us-ascii?Q?3LunAsi5D8FM90Zmi/v/WG0sY+vtR1d0ytcFSRUXW2JzgWjhdoFlMVi7Njak?=
 =?us-ascii?Q?jEt5/8Dh1kcTdKsnklc5hjUx+kVQVLPNw7DayUcGCrHsH9CGGiCYBrZcAJeS?=
 =?us-ascii?Q?3yMTOPfEI4+yStNsR0FzMDKggjC9DbLWxPpF8JF4kk25L6J9c/g5Hnu3PPCh?=
 =?us-ascii?Q?P66okeQP5QxJJAam1nuti5Gi8YgGf/w+uj9BU2/2tLhzpAdTwe76fr/Bav5T?=
 =?us-ascii?Q?OLRaUkPqAigRs0g93Hyc1laafVT+gxEOTSamnJIYBBe7Uqs8sO0ImoK9GqYA?=
 =?us-ascii?Q?2UWltULOiOy71dumNVEd29A/nPXVs55U7EVadKMVwxx0V70I8iV2AK5cVE5r?=
 =?us-ascii?Q?8mcQOfVqXytTFulDz3EDUjnj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bc1a19-ab81-480a-98f8-08d958833dd1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 02:38:15.1817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOpJtuq92ls4/s19y3U0YyIwZnm7Sz8XctOTqylByalLubpc2b21MWjny/0ph5WA1NsDPw4JOHzXCamm5VUf2qTmj7M7hjw9NY8Excl2LRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5547
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10067
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060013
X-Proofpoint-GUID: wK_tIywM9icsTQkrrZ80TX8d8LC0f_PT
X-Proofpoint-ORIG-GUID: wK_tIywM9icsTQkrrZ80TX8d8LC0f_PT
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 Song Liu <song@kernel.org>, dm-devel@redhat.com,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Ilya Dryomov <idryomov@gmail.com>, linux-um@lists.infradead.org,
 Coly Li <colyli@suse.de>, linux-raid@vger.kernel.org,
 linux-bcache@vger.kernel.org, Stefan Haberland <sth@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Geoff Levand <geoff@infradead.org>, Phillip Lougher <phillip@squashfs.org.uk>
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


Christoph,

> Add a helper to get the virtual address for a bvec.  This avoids that
> all callers need to know about the page + offset representation.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
