Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7681FC88CB9
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:33:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12EA882153;
	Tue, 13 Jun 2023 01:33:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 12EA882153
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=Pzb2PcFa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=RW6a+3tR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A8O3KU5v_-aG; Tue, 13 Jun 2023 01:33:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 29E3982132;
	Tue, 13 Jun 2023 01:33:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29E3982132
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E739DC0087;
	Tue, 13 Jun 2023 01:33:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE7D2C0029
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9012D60E6D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9012D60E6D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=Pzb2PcFa; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=RW6a+3tR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9dqBx7kYu19q
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BCECE60D9D
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BCECE60D9D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:21 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKNtTM003081; Tue, 13 Jun 2023 01:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=W2dW9tK65GrFEgs/7IoC5fXWRRAYfxsskKScAWGktyw=;
 b=Pzb2PcFalhkLZbY0rkF/UE8qZiHG2BP94xv7bvgEMpP9TMHdHmHhs/dClQNY4+blUj/1
 XtYzwA0HezsozHod2x35tToGy6aZwbzivpanY7lJBexWlUjKNE5wYFGD0jCom3HipX+/
 +f2269/9TBUk+xLMpVb0FJT/V5DjQcBBYsiTIxGZJHCim6sM8oAmYMdf9J7bVwbn8qWK
 oenhhnIx1liTF5MFX777sUt+3shIAxvP4RWWdcP6gBDpagSrDIlUq1yPCBeWJ+Iq48af
 Y1LVO6wbXDdhVlGCAkRalpDl9flCG7fvKTLUQ+kV5+McFIrqtzpi5+P//PSWrh344HOv vQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdm464-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:20 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35D16qft016231; Tue, 13 Jun 2023 01:33:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3hhyq-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqrD9w30F8kh6l8GxYJR/ZcuNbyfNLY39/WPn9nHgI1pK+3t62b0cQsUUNyCvEg6Ml2GD7Hon+46UV+HcsNMpeHNhhqChW9aum1if7ljPDEQyr+dXkz1aNGunDI+VQPBU/nHXFpZwtVmFaXxFJMCF+NxA/fB2RR3RnFduyD3P6XVFGI/BD/L0f9+vXVvl/hvrgu2i3mUAc5K0fjRI4ln7FAkYpgfPvZ9p7NeXEF1CQEpXI8oqvOPMtWXRUudUjzRUvw9OtluPiaj0KDarj5Slt+q7dBeG8qcFFPuQPuvXsJqOqIK+08SMvmYVT6cx0Ajr1b4aoZ//msL+mGo8sJxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2dW9tK65GrFEgs/7IoC5fXWRRAYfxsskKScAWGktyw=;
 b=Q24mNMKqao6i/Nwv3zhCjTEjdZpbRmxobmtHKyR3ttdrENijhKiZ9hWuqV/vx29gzKay2e5iUyPyXy65qPm0GYYwVpbQLW83TzDyt7cK7hRRwUkKnlasJEFMV4jpFo25a5UwNe0LsAWpNEeUCer9lFy7R3h8CKWYfpg+jyHxySFZnMKaIBay6QXii0znopx6WIEs+ghgAFZana0Whuonf1nWhvF3gys5C2NIzf//ArYavOxLQ/Wu+05hHMXupmI064WSyHJK8YRtK+wMf++DDY1WrRTPbVthfImpcRJXucuQDAU+g4cv+qe+PGDSCNiaiBkG+jF9uzGZ1tAor1mD6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2dW9tK65GrFEgs/7IoC5fXWRRAYfxsskKScAWGktyw=;
 b=RW6a+3tR1ZQYiIIgCveMD+vBX3JhYvI45KWStk1Xy+GQGZ3+UkPpGi0NsIxB9CN0bIUHpELNZU0PUaRpqCNU4JUgS03nI/jYP3EzEMw8WOYJ+LPHxTDK4YGz8Mlk1/ndz/wd/umvj6XgBJJAFnqgBjs44m1WMfoNI9LDZMFgr9M=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 01:33:07 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:33:07 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v8 10/17] vhost_scsi: convert to vhost_vq_work_queue
Date: Mon, 12 Jun 2023 20:32:41 -0500
Message-Id: <20230613013248.12196-11-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613013248.12196-1-michael.christie@oracle.com>
References: <20230613013248.12196-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::18) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 56163019-8a26-42cf-21e5-08db6bae23ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJg7r521LF/ewSHWXo16/qXLxmI2aeBTShlP19mfmdIOPMQO7z6ZFwdpCXhegFkNnx3ueswl2Q+/26YOEjeLp0JlzE3G8ufGudxZ5ODsz/x4iyqgOL54gkrcIQjNihldHp/BEP8lOYWaSFDB35UpDwxIexpofwAz0dnCKSnuiRIX1roB1u+zybbL/z3qTBKrn5WsIcqge3XxuImMw8/VH1NTAvgV9m2XP82cWBm0vC8RTwE4cb9sfizr07dlM43p3qfBvLEaKuwELFSYrt3FikJlIL2O+hx6rctZfZilw4jymlJTGB1l2TjD58A5kawilU04Tt/H+lvfCb+p8sioIVz/ggP4K6A3/ieZUUvEKf+mE026hBznArxQ+q7gfI2cTYCy3oaYSWx9b/CYDTR8NhOwW8Q1hIVyTvx/yy5vw++5VRSak/+keFvUBzN0+E8ebfUItzcaX1tMyPssGVaYBYzK17QURAtYjzVqQaGxjwChN2EJmKckSQkadUGuvwMb+P6n/9SfHgtXS8Q0LONsX5vwBfg1WUkIaCcncRYxTck4uubVmuIdoJ5glnmFsojA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(36756003)(86362001)(66556008)(4326008)(478600001)(66476007)(66946007)(6666004)(316002)(107886003)(6486002)(8936002)(5660300002)(2906002)(8676002)(41300700001)(38100700002)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QPBFVP0ippfGG9acDAbQZCZdH3ZxCkNRR64RVoM9VUIUWmTbk4xAck+U34FG?=
 =?us-ascii?Q?CEYD0rGGqOHHBaTdgGemCb/C3Q92pZFLv1o5g67OhcyguxrzicvehVM+8kxS?=
 =?us-ascii?Q?qKC5PBDdoYy4HC+5FSYuqTa8QTaSCq7IFyn4ckb9jO3xInzDStrWnGnP9q2v?=
 =?us-ascii?Q?7iylmuPbuEsny5+wdER4Vn+aqc2ImZn5B80ZSXZfPUCQsWHahniNmokQwxjS?=
 =?us-ascii?Q?AMyy8deqs5OaYpEFap+27ZBey4N1GphfP1KpYvZi71XsFf2jdeXeLulSGJOr?=
 =?us-ascii?Q?lq9uMHy0d3s8Ps4e2XUo+BuBq7rDrhGgMO9nbS8takz9yhKeDeo6XDwIL2sj?=
 =?us-ascii?Q?YYKdUevkxzV68F3NDOPKlakWepWMhV2FZpfyrkrYDYEsyi7oQE31BKrVaJsu?=
 =?us-ascii?Q?GQpj3vuA9AIHw73qjyuRDokmWxDPW+h0+50tNFAFvfuqdW9T/P8p+TchVBOy?=
 =?us-ascii?Q?j/BaZB9GJD/YikmnNw3de6PBZt7pEAMhozlO16F+GgHwlfckgdCVkKtsIRfR?=
 =?us-ascii?Q?4WkVy3BCWuSf5fDml3bxq5BRNpxJISVn+3QLgm/Ggrdew8TAvD/mlqpIIwaN?=
 =?us-ascii?Q?G/eN50jGe/DpVwSNupFgvLsORtvobvqQ7mBpHBtJktfQbk4yXzJUhbyGAIAA?=
 =?us-ascii?Q?0Jvo5qLQ0rPYwDskEuCd9sTQ5rtbg2XyzbgUt5/y2flT3TgPqeBdTMDnelKO?=
 =?us-ascii?Q?aUCJNYK/mCBvNH+XaptK1gidYRKOUZhgn8TAH/u83o3VKMe2qOz4w84M0dcd?=
 =?us-ascii?Q?lCIosqCtky+MTDlDHcj6I1z0+CwWfOXOtUfaXt3NJrND8oM0sW0Gkm1nTFbE?=
 =?us-ascii?Q?ODbWh4ZhhP57Fybpb/SIu5HlsipSGXRUo3ri2fwMVhEj4Nb+XCmMCcQdQbZX?=
 =?us-ascii?Q?+0fpWDf+Yx1gZRE54vErTnBeXUY+poPFLv3LQuUSXCAhlFNcCfxIVCE5JkKZ?=
 =?us-ascii?Q?jao3ki9dLKv6RKFL2ejTetuEEJ7McYQQUQ1ZGhBhRLz7j1XJ9gcjB5QOnRg5?=
 =?us-ascii?Q?R5NgwVljepjZDpyec2E3ldUw/dlgSMiwMBH09Q60ksfVxJKQ5ZUP/c8Hpgm2?=
 =?us-ascii?Q?0hwtTQOqZon40oniZynvIW96Z6FzsS3mb1FuzQE/GwuUIAUfpUupJN0FEezI?=
 =?us-ascii?Q?8CnAk4Xjvy86KCUyoxwmIjiDFQ5GHVfRzVatPPCvL2vy3ogQpw/8txNwgbM9?=
 =?us-ascii?Q?J+yUXyj9fZNkLp9HXRjYnQxcuZglwjBsF8DRCX+hC0rh+Tg+qkcD9TbliR6E?=
 =?us-ascii?Q?XZ5JCHQpod3TwZptOMuYe49KVlP3c3qDSXP9cWGl4DdxEPRaO9zg+4pSV0bQ?=
 =?us-ascii?Q?pGh0GW44XeMj3RWCl/PwUtWLN6nXPxT4onZy6Hdgdz2dBKAMsqWkWYAXQc+y?=
 =?us-ascii?Q?U6IkthqW4J0jPtJurKElpDlgdyRGcUOA7WWPO7I7NvfDQNDOrz2BGcqmZq0g?=
 =?us-ascii?Q?E6XnEGCwS50JM3Ck326cneT0uNvzTWUp8iJz9xG8O9r4vS7z+99HXZieGB1Y?=
 =?us-ascii?Q?TSkuHlHuHIYWx7xBW7Lh8sG0fvU+4dnt0oLllSZ59NYkYzCCXp+b4sxZ6E+r?=
 =?us-ascii?Q?cwGOQkzE1OttTtNf+SQ/U+ciHOUjwdRCCOZBmCFIDLtQOuY/t7W9rkJ9Bngt?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hgBhtY6LwnmKWHXACbxjtkO6a2FYXkkQ2c2Q71efs0+j0rj1lt7D3NiN3yeT2fjwjZiFYG0/PC3ky6QRUK6sPdKeNxvwnh9lV48Iivgvvt1N/xzAfL2px+z04XmHFJCaslq8Bz4/TTbD4Xrdu62obEalsRAY0BMHRiha8vJCFhVowwo2iGeUTVzsqh5mxAeSTefw02JM1ExFHN2HjkdebMMomDWURg8rSoTudrrbng7RQh+Ulr8jRMAVL53uyu/muGnGChRLsg+83S9kI3+4FcDXD85ScXnafoz9mg3+prfYWeiFmKpMo6lwdaDaRMJ6jvqGuXk2D6QM0Ux1RnuDVss3PXVKg12uqa0/TxtshJ4GwMJ4sSIXANEov51ioDI0/ZxWxhwSmcz9kX1ZCUuhL+R8EBYyLecvbj555SAgIHRKNXwqBUHJ39KmoACIhqYoFcUfIve78gZf5R7YiwkHNxk5r2pV//yvWLsjLVAldwVyaYb/1e5sFMRm6ywFiedyj9KkFBZq2CR1zSx67IPyty+WY6dJzyIUJlXQx5DyHxZ4jRsnb4OeX5nohv5DvuSKhXnRxzg0mUefWhJosNS0mNEKSLmit3d3Qp4KD1FdnK3K645MjeqIk2SVPfm82UyEbZx/DbPjQucSTgjJC6xG0x6O1TMeb9hF4eosnvfwcqx6weEzVfnBq4KTnJDnULLC6R0LzBt8m8H/VowVBF9LMl8IrDhluODSBtDClv7U2MqXEFTdUFFtjht8BoT9RaMyG27i1C8vg4BoXiGw9HJvNFbWE4qi7ilccSs3ai3GUZExNR0AHB2Aayb25JJgycvw
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56163019-8a26-42cf-21e5-08db6bae23ec
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:33:07.5572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNtO/1qMFc6etxewbdvZBdV3Sdy8ADRawQn55iG4DKItpLIulEDJObHRpB+g9eFwJCSX9M3Oza5NNSBw4RV/bjoEat9l6+IN5VdNtImJFFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130012
X-Proofpoint-ORIG-GUID: umg4qXTHCTtlNWgtmU8HE4ANAc6iatoP
X-Proofpoint-GUID: umg4qXTHCTtlNWgtmU8HE4ANAc6iatoP
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

Convert from vhost_work_queue to vhost_vq_work_queue so we can
remove vhost_work_queue.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index a77c53bb035a..1668009bd489 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -353,8 +353,9 @@ static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
 	if (se_cmd->se_cmd_flags & SCF_SCSI_TMR_CDB) {
 		struct vhost_scsi_tmf *tmf = container_of(se_cmd,
 					struct vhost_scsi_tmf, se_cmd);
+		struct vhost_virtqueue *vq = &tmf->svq->vq;
 
-		vhost_work_queue(&tmf->vhost->dev, &tmf->vwork);
+		vhost_vq_work_queue(vq, &tmf->vwork);
 	} else {
 		struct vhost_scsi_cmd *cmd = container_of(se_cmd,
 					struct vhost_scsi_cmd, tvc_se_cmd);
@@ -1332,11 +1333,9 @@ static void vhost_scsi_ctl_handle_kick(struct vhost_work *work)
 }
 
 static void
-vhost_scsi_send_evt(struct vhost_scsi *vs,
-		   struct vhost_scsi_tpg *tpg,
-		   struct se_lun *lun,
-		   u32 event,
-		   u32 reason)
+vhost_scsi_send_evt(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
+		    struct vhost_scsi_tpg *tpg, struct se_lun *lun,
+		    u32 event, u32 reason)
 {
 	struct vhost_scsi_evt *evt;
 
@@ -1358,7 +1357,7 @@ vhost_scsi_send_evt(struct vhost_scsi *vs,
 	}
 
 	llist_add(&evt->list, &vs->vs_event_list);
-	vhost_work_queue(&vs->dev, &vs->vs_event_work);
+	vhost_vq_work_queue(vq, &vs->vs_event_work);
 }
 
 static void vhost_scsi_evt_handle_kick(struct vhost_work *work)
@@ -1372,7 +1371,8 @@ static void vhost_scsi_evt_handle_kick(struct vhost_work *work)
 		goto out;
 
 	if (vs->vs_events_missed)
-		vhost_scsi_send_evt(vs, NULL, NULL, VIRTIO_SCSI_T_NO_EVENT, 0);
+		vhost_scsi_send_evt(vs, vq, NULL, NULL, VIRTIO_SCSI_T_NO_EVENT,
+				    0);
 out:
 	mutex_unlock(&vq->mutex);
 }
@@ -1991,7 +1991,7 @@ vhost_scsi_do_plug(struct vhost_scsi_tpg *tpg,
 		goto unlock;
 
 	if (vhost_has_feature(vq, VIRTIO_SCSI_F_HOTPLUG))
-		vhost_scsi_send_evt(vs, tpg, lun,
+		vhost_scsi_send_evt(vs, vq, tpg, lun,
 				   VIRTIO_SCSI_T_TRANSPORT_RESET, reason);
 unlock:
 	mutex_unlock(&vq->mutex);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
