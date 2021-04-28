Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9375C433B4
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65AF56143D
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65AF56143D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F00C3844D0;
	Wed, 28 Apr 2021 22:37:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xxKYoq92HlDz; Wed, 28 Apr 2021 22:37:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 807AB844BF;
	Wed, 28 Apr 2021 22:37:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 593F3C000D;
	Wed, 28 Apr 2021 22:37:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBFD3C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD78C844C1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KtbKVljxQOQm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB276844BF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:29 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMU816177546;
 Wed, 28 Apr 2021 22:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=VLnKpCNhvmp9vK55eKRk13Bd/4+moORALa/MzVKvxok=;
 b=EQmqPk+tJRXOynJnPCgZLw4HZ4Baeel+Fk29kKsv/PjgYq90wjoj7a9wjlbI7HXbMCZF
 QPoMYue6xp6tXIBB/+mtZuSj/z4CBJ+6tVtZ58vLNA3BjP3naGGpzkmsUwSixIzTDzgQ
 XnisXJ1eht0Z28/W5fpp6P6Wp53vSnhFxJT0Eg0tBOr3xzggX7HVkQGDi3ySnVdpI3Oe
 FB163mmb0UJGZZeIqzqqgNQQHeNIZ7yGXjIgaLvoz/gMwi7RzOZslKrkuZ2cwMXqKrr5
 jt+JfIkYoAq6IadediFYVSsqdt5gNXhUZ0o4kudzEIjp9/NDBFLlRsDeMTCha8UxTEUA ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 385aeq2j3b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMTqP6184210;
 Wed, 28 Apr 2021 22:37:26 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2058.outbound.protection.outlook.com [104.47.36.58])
 by aserp3020.oracle.com with ESMTP id 384b59a4mm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYBMM89RqBAKavApz2eqXeInIkFjHUTunqdukXbIfeVf6mIdeUb0/pJGwpLUzEhJT6wA+kG66kaPXFa/4jrht6eiZeaICq08iQe2D/58HIMPriatMVdM4+5Gbgbel4Wb4aSWAyqE9myDE4uhCkiyX/4lOFDIyoiAajPVoSWvP3G085U9ghdAy84eJ+QkFOO/bq7Ur9Mfixldvc7SGceBnQEr7oEcIWkMnHCm6OCbgWLQ1ayqjoPmq+Q4bDFhby1wXsqgRWrGYs55KQnFkjwm8AYUcZj+fW+OpU9E/uJgEWBUv2DDnwCxQrAmJi5v98QvBXC7kZRLVuWLx8sESAMZ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLnKpCNhvmp9vK55eKRk13Bd/4+moORALa/MzVKvxok=;
 b=g9Bzf+IAQEJlYmAwyz8ZKGZsLhagV+OH9toNk/UDLNlmxIRy0BpEVV7p8y706Ps1qcxcUWJy2BIGeVM9kmtgsCbf+XLaTiHKWQZXM9NcYZEbzoV1l6APbVivCTWAfvOWo4HoyTtwHfD5JFmaSzTngmlvRmCRfF3QoGezT2ZJfZZqo68tvqRLojWFQk7vuBrH0rlbHQJvXMCS0t/9wjd8KcGXvKLiEmDuEUCi8NQkYAG7RGwSJWSdZU7zPr5JmrPgWRY2vv6SwGYJAT4VTizKGy2l7flz+nMSuFFCR+sN4U29iDML+qn6Z9TG/I+SG5xdpA4c75SedUz6i70TLZJDkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLnKpCNhvmp9vK55eKRk13Bd/4+moORALa/MzVKvxok=;
 b=adSI/r+XG8PwKLLXEfJ4PtLkixJkldE9hLaLV8V1JBncVcukme5YtInl3DqGbf7yK/0A1zHPYGppHa8ZcmhCWvAmbfzCc9kgmJM3X/DPNlHI3aeru+1W4dJQqieXHbESaib6bgSXTmfmCgfzXqMkt1MCEjCNQo2PeNVUTa5TBiQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB3702.namprd10.prod.outlook.com (2603:10b6:a03:11a::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 28 Apr
 2021 22:37:25 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 22:37:25 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 00/14] vhost: multiple worker support
Date: Wed, 28 Apr 2021 17:36:59 -0500
Message-Id: <20210428223714.110486-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [73.88.28.6]
X-ClientProxiedBy: DM5PR1101CA0019.namprd11.prod.outlook.com
 (2603:10b6:4:4c::29) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR1101CA0019.namprd11.prod.outlook.com (2603:10b6:4:4c::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Wed, 28 Apr 2021 22:37:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13da0d6b-aa51-40df-e7d5-08d90a9631f8
X-MS-TrafficTypeDiagnostic: BYAPR10MB3702:
X-Microsoft-Antispam-PRVS: <BYAPR10MB37020A6FC51EC68CE1D3BA1CF1409@BYAPR10MB3702.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDGpnCFyekRxXX/rAEcjx7vVL0XhP2F/SJ/n6+0eDN0NhdH0gajUK2p4/cYxrrqTT5uKX4XCybEIL5/HXs++8eBIQxvAkI8Zfg1eKM/WeyXGWBV1lx+949mg2L+NdvdPDopXcesVej3Fkh8U+NmHdDuRTkVVbrAV5XeWxdmoRkz2M3YW8657T7mnyFoVKlUIuBG7vcQqSagc7rN0s1quBD4rTq+wjUDZ0ZY9DN+fex9wDcJbToWTMVNciY2JLMLz9jCYvouchCinrsH44sDDsctOWqjbPHJmnX+hHeQp0fQimLEHl7KLI56dUDrRkIKgujB/gNP7+RSaUMSQwzaeQ7CJs0BRILyLK78QmE6+nLBBLs2VBVf8tbsY7A1eWkXmfhhOmaVrglhUv3mkZpHv2367bVRQBcaDxnqaGKwlZdgEk9HykKFSGaoxqnhJ2/DK2wa1isR80MiVeyTrfaJK+eDDTbvwDLaeijvdDWDQUNVAO2QlhLet7nD931TW1qbbMcq607IKkuGSI8Gfi4MsLEnaYXmp2XV120JS4oLtPltKZOQpxnvfmHnIAOiweO1XqHGEv2qni/rvU1GdWIjVaPTS62Eqy2qxupZVuO6kiEBoeNT5oK/4oxc5WZoSpqEUfgW4DY61aWBloserOX7XsITk2xYmzkF1L8zTgPXc/Zxb9bSvUWdiNBIveE7r5Ee6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(396003)(366004)(376002)(39860400002)(346002)(6512007)(6666004)(26005)(66556008)(956004)(316002)(38100700002)(38350700002)(8676002)(478600001)(2616005)(6506007)(186003)(16526019)(5660300002)(8936002)(6486002)(66476007)(1076003)(86362001)(52116002)(66946007)(36756003)(2906002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wss1uqQd5ZY3OhBMBhU09pEms34ZzMKCYOeqSCyGQwgoR/dMAQde9/iJk+GO?=
 =?us-ascii?Q?oSSvB60HUB4QMG+ipbS/q7V4rbQgNx6H4JmhW6S8digXqKuGK9JbfMEy8tgA?=
 =?us-ascii?Q?hIQet8ldC1bm8QTivR30+6XQMAtmSl5GUrPIXIAn09q+SKFkUK9i9/HNWrNj?=
 =?us-ascii?Q?8ZujaISfnJslatR4jDnR25yCEDSZMKBrVmWvn7i6N9P6wPorJTFIlI8NrL1g?=
 =?us-ascii?Q?w6bHHMg4naUyTkS9ijKeu7NLKbQcbBIF4pEJf8JSQ18d5MB9mu+tMb8eU7dr?=
 =?us-ascii?Q?30DH7HCAtJulKVzScLDTEeqamxQ/YR4gKFUOMUaRxgilfwQo8/PriWMebAX0?=
 =?us-ascii?Q?Lw6xEc6bl7H0ib1TYSRah4670OgUJr4VNuIbCGGiFr+K4ntXaLKGcbc5eO1H?=
 =?us-ascii?Q?9/tfzWFjB4/zPzUiMCb6vw4E3aWD73F4L373PGBhg+slCHBvW5vpk38C/a9H?=
 =?us-ascii?Q?AZusR/V8EzvhD9CNrRLMxPnQIVa6SrEc13lbhbHRIcSwIbpMOBB3cyolKS80?=
 =?us-ascii?Q?D4b0Eb1x60VG2lY7LGJF6WJ0QNYIOUgX+lxAN0SylUksQ6Eps3VlP92vsAL+?=
 =?us-ascii?Q?+QFNnL2CSc9lLUdtG9a/yjh6gOKp1NuHTZT7aYiVxoKFY/eMjg8bP2YGnuzd?=
 =?us-ascii?Q?/Oz9dNBmA1rYi2iHPfzlHosca45zQVHRQrXmytPA6pSMHCdz8k0nk3mK3i2C?=
 =?us-ascii?Q?sPTinCO9ZW70tesFwQSdy4WPC+mjzWDU+Ag2yNCppAx45S/0T698/gnUT2Mr?=
 =?us-ascii?Q?RJfuEOJ0ylupqhhWNRO7//0SSvNKGDgIPdjN71BhujgYt7f0jN0KZ3izM5fn?=
 =?us-ascii?Q?6BA3S8wwJ01Aq9++QF2ZEUgOqjXIB+/ezaxmhUxf1dEMgtve9lCQVZP2dy5m?=
 =?us-ascii?Q?WOJOV4yDpEX4V1qtbchK5Pq5zFx47VK6jpcJQugp94p4LVLiQzyhXA1PNHkr?=
 =?us-ascii?Q?2At8g9MFTWVOHWNgHrhhJHq8iOdIGCsIe/0rhYWLUSBvjGLco75zoS/ZvmEg?=
 =?us-ascii?Q?GdHBbChCBDeh8r7D0rLhPccasgErs5OiCXCGmRtPJnKKPMiop/BhMQNJpLoN?=
 =?us-ascii?Q?DzRcNDpbkLYYt80iyb716HFnO7dlAtcyzW4/3y9/s67n5TFDEL9RtlBv356D?=
 =?us-ascii?Q?Sr269CWwsL9MBdVqbxmiCpfppJ5NgJ565iVjMaakeHzhUrVbL5lJGnI40IBu?=
 =?us-ascii?Q?6hOhjRrW9jOQ2veuNo6gNCzcklZOhklefAHByjcaHyHgg9IdyyEpVHb3qTfd?=
 =?us-ascii?Q?xFWEqAND3QVu6I1RXlFLqkDQQD4gKYnpfLduhul28Ti6xRKAkjaLpK0Esabt?=
 =?us-ascii?Q?nNOqs6uFwQCS+cse47XUk/l9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13da0d6b-aa51-40df-e7d5-08d90a9631f8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 22:37:25.0563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSrO6NZy9CsTH74ncwGZK11BdW6BLAMXzCfNFKXzD9l0pEzFmwpywnm90QHY4Sfffdndy7bZ/opcV6LooU4ig+4y9/uz91Lku6MOWcjsMoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3702
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
X-Proofpoint-ORIG-GUID: k2wnCWQuCfwiAEZOWJYpkZINeNqTohYU
X-Proofpoint-GUID: k2wnCWQuCfwiAEZOWJYpkZINeNqTohYU
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280144
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

The following patches apply over mst's vhost branch and were tested
againt that branch and also mkp's 5.13 branch which has some vhost-scsi
changes.

These patches allow us to support multiple vhost workers per device. I
ended up just doing Stefan's original idea where userspace has the
kernel create a worker and we pass back the pid. This has the benefit
over the workqueue and userspace thread approach where we only have
one'ish code path in the kernel.

The kernel patches here allow us to then do N workers device and also
share workers across devices.

I included a patch for qemu so you can get an idea of how it works.

TODO:
-----
- polling
- Allow sharing workers across devices. Kernel support is added and I
hacked up userspace to test, but I'm still working on a sane way to
manage it in userspace.
- Bind to specific CPUs. Commands like "virsh emulatorpin" work with
these patches and allow us to set the group of vhost threads to different
CPUs. But we can also set a specific vq's worker to run on a CPU.
- I'm handling old kernel by just checking for EPERM. Does this require
a feature?

Results:
--------
When running with the null_blk driver and vhost-scsi I can get 1.2
million IOPs by just running a simple

fio --filename=/dev/sda --direct=1 --rw=randrw --bs=4k --ioengine=libaio
--iodepth=128  --numjobs=8 --time_based --group_reporting --name=iops
--runtime=60 --eta-newline=1

The VM has 8 vCPUs and sda has 8 virtqueues and we can do a total of
1024 cmds per devices. To get 1.2 million IOPs I did have to tune and
ran the virsh emulatorpin command so the vhost threads were running
on different CPUs than the VM. If the vhost threads share CPUs then I
get around 800K.

For a more real device that are also CPU hogs like iscsi, I can still
get 1 million IOPs using 1 dm-multipath device over 8 iscsi paths
(natively it gets 1.1 million IOPs).



_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
