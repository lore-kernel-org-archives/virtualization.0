Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2F6C433F5
	for <virtualization@archiver.kernel.org>; Sun, 15 May 2022 20:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D634D81A3E;
	Sun, 15 May 2022 20:29:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7pfOv5HrIa6G; Sun, 15 May 2022 20:29:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 629E481BC2;
	Sun, 15 May 2022 20:29:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBB41C007F;
	Sun, 15 May 2022 20:29:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15F8CC007A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C3BD541603
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="A+2A5F6a";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="zyOZEvoB"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0GfqhSmbxHoR
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 19827408E3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:33 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24FE3lQo020883;
 Sun, 15 May 2022 20:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=4ni17t/JxL/iPGZHR1zne8ezlAdALJhBZfW/Nkx/o7w=;
 b=A+2A5F6a8LZ88vAKgtWtMWIrY2xsnzzhLDc2tr8OcQ5LCB/Lzvht4ZbHweRkAV7Bq37k
 eguY5ZB3lVJ2RWZVRQv0hK+YTnDaorVQVRBw4pRwfeX/tWmlbZEqbJ2tEqJQ3xKN+8Bo
 KU2TdwLbvbU6ar5JRVeDjmF2wleoyZ9a+lGs/OrduE66VOJCw2M8u+425GAePHZa5cbr
 V3TACOn2d7JCurVB8B8f0hCy2v4ZER2l081Qc0UFBmsperq1uNNyo4cgGiOkdGw1wMY6
 M8XFYVQbqjmpaKbqSahRZwc7Tycw8FKyfkfscrFZlv5ulyk1B3HJ8cb6QU94w026p/hg qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310hv2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 May 2022 20:29:33 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24FKOthA000789; Sun, 15 May 2022 20:29:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v17vqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 May 2022 20:29:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzi6BfEzSzkNys8Xh11/7JB8Qrps+4yMQ+HIDkZSnfjMheWCYZfwdRFp1Bdzfadx3n/CCh3dm+eRxq5Nqil82XcbUuYmoPw/FXUv69YRvjvoP9nyTI7FtfdA2CGgBylqLZZCaTy5zDGDV2zoNK+a8eN2JjtFavxqt0tNtNMFbp12YJ4aS4BwnfGeoWeIc8Jex+Ar9zdQlI1oavthbRxWYg5bGs3aZUTLFK9MQJM7LTcGWwKlCtbQ5GonEI1RU1hE5n0ZMXsmODJhb6THkK5il2wQEV9/mtKBMWduAQlyXHD2PU072GzbP8NNeKczmaqSbbrPOa6rEKuLsZqOWnrHaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ni17t/JxL/iPGZHR1zne8ezlAdALJhBZfW/Nkx/o7w=;
 b=AbNcM7n2Y/rk7P2u6CByID9v9LPR2E27vzgz/HogOIER+/xOo9A/uwW9AGiu5ZWpm0HQddO6/ct0oDpEBQ3DohYtOiZCj4hpnY5ZOlC/lgn3YSgPetOcpPp4T3nbtTWt7cXgZR0u3tA84bQv74Lch4ObhXzPWUmZNKAy0QkJfeqpTYIHDBKswiYLTTCKufdC8Ces/OVVaALXMrcfHkyyCbnIqEudlxeT9QPPqcC7GPHmQFN2EOdMozsWuD/qP4vRi176VscNd7WN+S+xQ3BKNsxhiFYW//WyovEA9Q5Vzt1Gojjsdx8XMK+1Zaj0o2ciCLKluhJ8FgzQEERNJ4xqvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ni17t/JxL/iPGZHR1zne8ezlAdALJhBZfW/Nkx/o7w=;
 b=zyOZEvoBHdajTWhgPWXo/0T067MMMpjzkmaROrsemrCjYhjXDOBA03mCg0XFG6V1d1Gyu6HxgWKmYFcwizbzEjX7PUUtGedmIb9uxCgZBeS+PhpyXLBfTWp4+FJVFnONFreKdEP4PVhVhVUjtWW7chdu8ygj3aWpQHks5jaGwuk=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BN7PR10MB2707.namprd10.prod.outlook.com (2603:10b6:406:c9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Sun, 15 May 2022 20:29:30 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Sun, 15 May 2022
 20:29:30 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH V2 0/8] vhost flush cleanups
Date: Sun, 15 May 2022 15:29:14 -0500
Message-Id: <20220515202922.174066-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: DS7PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:8:57::22) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51f250de-36c4-4937-310b-08da36b19d07
X-MS-TrafficTypeDiagnostic: BN7PR10MB2707:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB270727B9542AAE4A8D79F926F1CC9@BN7PR10MB2707.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xCKi023TDOkQBmsPnhI2dd0Jipqztb7N2G2hdZ0sGOo+4JoyZ4Pd/M3YLTdIjZL7+PbYzr2Enj0wOAYAyfWfPk2tcoP6sPAMvnclwX+FMN5/+DBgrBNWsW8Y9hFjv5rP2AedkpcZbuPn9CPwjcNzWGFRlVXKce6eos9+je5DuO/Dt/tDbXTuoZTg+qmrMY4/CUETtg6UBc5WxbivKs6socmC3cDTYgiyyyMAmdeQNdxRiUBeMi6QMZ7dsFgt4dLwdXigXMx6y0e0Qm3W0gaqQHNCij5CQQq++9jEjYrbu2RZ4oYXtsBOYafMLx40kYoo9zfrSOiA3agYw4L6lalkPYTCK8dwp5RMVTaz9N0Zi46/4cjRd5DeIBbOYOLian868RqOjsjyroRvRRFkEssEAl11pth/9qCRH10lz3vRWJFhXvvevhMZNyxOuN5rLjdDThJk+iF+unedMElALU24jLQ3WQongJF0oRqyuBI8WI1h6njeHyBUZBrAdZnBMFbN0YyR98zX7dcKHWQORUaHsO1n6hEVPLXGI1i8y3mHv93a50ayTCKt/pMlrxOhFaKtYS9m58Q5PPBzWH8m8TW1PlVoQH0vwvNIoX2uguv6JOpcP7HMoKjkrf2klSpX9RrqqXYHksbAHiuN+FARnVgRsIFtc+6nZ057iRTcgR6yN8DyGG243PqLfyvzz4mDeP7CVb7IjenBbmjT2ylYbLZi1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(1076003)(8676002)(38350700002)(8936002)(36756003)(316002)(4744005)(26005)(6512007)(2616005)(186003)(5660300002)(45080400002)(6506007)(6486002)(2906002)(38100700002)(86362001)(6666004)(66946007)(66476007)(52116002)(66556008)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J+sbX/Ay83k1PP9Mh9QiPrOBzb9n//+xzpx7a4DCG2365EuVZseTEBiVxWvo?=
 =?us-ascii?Q?iNE3lOVh7ZQKZOEQpc8N4Gw05sF7QuJLUOrk62HJNn//jtWCJxNa/Li+mLqO?=
 =?us-ascii?Q?6LDRlOVqFyMz4JD9ahxiuoIs1KYvrnhO1pQq1IAVQbcrc56pvcF63SDQ6E8F?=
 =?us-ascii?Q?+U3jEHe5K1MakVeuTn5OXWqCcadfNqD1lelIbFFwli35D2qgMyHFhpjNwnJo?=
 =?us-ascii?Q?jr2vYP8sBUl8QlguKMhvOvdBUn6nDrOnkzelaJOukJ8Lt62bYrze5fRhVR0U?=
 =?us-ascii?Q?TQBSAxnPbOJlvhMNEa+JBLKw6sOsSL9LkAwRt95zBTcC45HtL66n1IQTq9FJ?=
 =?us-ascii?Q?F9mGhy6FgrSY+qPO/Ncox6HWLHYvWJc1ffjEIjO86t9/Ad7tVtyZ3Qjha1Dh?=
 =?us-ascii?Q?A57x0cZzUK3rDRloubN15BWzvVLJzb5y8WzlCffAHwMRb5mPZU5FmzzwtftE?=
 =?us-ascii?Q?FuYaFg5ZVW/RaiA4zGu1x/4AL7vJGbyZn5kBL31JsMFvsGrxSbJu3HWCF0JV?=
 =?us-ascii?Q?1gmkqaPGDbINKomp80qR3GuozeAt3tXozYP/otylK4HehselzwWe5ncVUU26?=
 =?us-ascii?Q?gzUpNcAGpZ/oGD0sgdtqyU9SGETzbeloEIIxI3vP0M8cwDcDqNaZRK+pMKxw?=
 =?us-ascii?Q?kxWQUUvoj53+7lczZFcVicMOVLnJWS5rJ8iKYVgwOg5/usUQIF7nL2feuqa+?=
 =?us-ascii?Q?nY/YlFcCp3Imi8AHcX6D5WOzEy0iTLQKMZDshp3bZJP3prMVVOhqnwOo4grX?=
 =?us-ascii?Q?MFTM2GgZmNugOlXCuC90EerJldiOFszuyB7lK7E2eYi9dYTCr496lpSofbeL?=
 =?us-ascii?Q?fgqUkK7hN2q1QISHxJChJ9nTamOOO++hpdf+C09R+4D6LyUyjHFN7zXpMXVp?=
 =?us-ascii?Q?kkxY+5NSz7MNst9JezBJ6RqmWWi6AAtBCJg29ZdlUhTlHhOl+9I6JVTKa7XA?=
 =?us-ascii?Q?Jb6ELIpzck2Oj8jiKmDpPduOgAS04y05K5yDsrPoihESsnhfg9Pumh9UBNpS?=
 =?us-ascii?Q?jYJgMDOOG1/Nmgp6K854ve3aXhFWAttCtK14ghyYUNoHTSTKVeWGmEuoZ2Km?=
 =?us-ascii?Q?APRBkFkgLn0soKR5DrSuMJqBzP7WiCzjoutA/N182SoZOb57CvC1YT2tg/nJ?=
 =?us-ascii?Q?aZeu2T/sj/Asb4EBM1Vz1gFTjeMTWsU5F32xD7zP8pxOCEL+7Nwae7UEhx2P?=
 =?us-ascii?Q?/pxSR0x5KfCyCKx9hmNsUo726dM9PMnM2ibhrpTk5+no+zXY230/1AK6Bg9L?=
 =?us-ascii?Q?eqnxz/IMbZ8U6zePdakPyoU4aptGon08K3cB5f9W+BFidT+T1yFZwhjUdL3z?=
 =?us-ascii?Q?vMjAsHNSF8bO/WpRexPCLqtODxaBvvAUZCT0eL1NMpTzO12uGDYdu7sEcH3g?=
 =?us-ascii?Q?ICk+wvpgcOuJxA+Lwih93BVIWyjTX6wTAoOqmaYryj30OrtMSjBTsNYwgw6B?=
 =?us-ascii?Q?aGoOUK+VLafKxnD8IRSCJd2H8i025fGXsN8lZZJE9XxnrY9OEGrJXlymXMzc?=
 =?us-ascii?Q?8pMQB9C2132yaN74wzFEoYPL1NPYm8R7LFFd9k5yEg0Fwgxkp8G3ZuoEO8yn?=
 =?us-ascii?Q?UN/gtcEebByP5ijNT1+kLFEcathK7QeQmuL9Wi6NuhfRue3jUG890MYUrFBn?=
 =?us-ascii?Q?bhfpJ6ONavtxUH5mWNx/WxwRTeHH95sOaUTE0ro+59KHJsW7rpVXIfWWmbhR?=
 =?us-ascii?Q?D3riyk+a3y0yd2o03QO3mIBSoCLPuGP6L7jRaUNfesjpU0VLWfCMou3p7Nio?=
 =?us-ascii?Q?4L4Z3ErluluXy02gkoU9RS2sxZSPpP8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f250de-36c4-4937-310b-08da36b19d07
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2022 20:29:29.9670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SKK3OR2p3dxQrDTOgQWmulmv0/H4dpoT3CLyXIFIKtFFEXU8cMvszD/lKDUtyYCR5cvTyV9boX2R3A5TjOpP6Akj0Mju3jTBwHrLFblSRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2707
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-15_11:2022-05-13,
 2022-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0
 suspectscore=0 mlxlogscore=801 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205150120
X-Proofpoint-ORIG-GUID: FbDGmJd7mvsn2aKbKggmB2mqEqfd9BU5
X-Proofpoint-GUID: FbDGmJd7mvsn2aKbKggmB2mqEqfd9BU5
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

The following patches are Andrey Ryabinin's flush cleanups and some
from me. They reduce the number of flush calls and remove some bogus
ones where we don't even have a worker running anymore or they were
based on outdated or incorrect assumptions.

Jason, for the patches you gave me an explicit acked/reviewed tag I
added it. For the replies where I answered your review questions and
you only replied with an affirimative reply I did not add a tag,
because I was not not 100% sure what you wanted to do.

These patches will be used in the vhost threading patches which I think
will make progress again now that I have Christian's email figured out
:) (he had moved to microsoft but I've been using the ubuntu address).
I think the patches are ok cleanups in general so I thought they could
get merged separately if people agree.

V2:
- Added patch to rename vhost_work_dev_flush to just vhost_dev_flush
to handle review comment from Jason about the naming not being so
great.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
