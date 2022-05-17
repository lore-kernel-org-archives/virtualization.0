Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F99C433F5
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 18:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AB1F60E85;
	Tue, 17 May 2022 18:09:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gjjtp1T-gBuI; Tue, 17 May 2022 18:09:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E7FE660A9C;
	Tue, 17 May 2022 18:09:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2A5FC0032;
	Tue, 17 May 2022 18:09:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CB8BC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7375540CCF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="FJQdyzOz";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="s3z9/YMV"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lnbT3k1XdrbJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 81A86400E7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:03 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HHSiAi023116;
 Tue, 17 May 2022 18:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Sgam4+sdcyJMMSPj5dEx56rSUhUZSp8Fm11w+ycRCI0=;
 b=FJQdyzOzmudWTvgrru9qZSNU4mBmgpbcM4ci+zWoOBXz2tZhfuTGQ4+HY6NQspMLzksk
 GNNPkLQahPp1LGLTHTaJBw3BGTyVr/WSyd/L4URhNep+hEY6YpGPTBsmvWnUDsAQ9fLq
 wDJl/KrbLdgYbNgfq6bfiEc1BNE5aKn01Ab559MOEzm5lElqRzRwZsboB0H/XITJkdCV
 QVT0uwbP1nf26JFYGj3/8sn6JZkTVUrjEGS954X2op5PoWe44MHJxbyXuioIAI+S8U5q
 02pxOtSGHQsq8WmxIzDIvy1SSqzVIAUEz9tigD8L9BA+iCPi5Z7Gm0exaspgn+9hFZgj sw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241s73sj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 18:09:01 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24HI69lU023951; Tue, 17 May 2022 18:09:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v8xk2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 18:09:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIVtCPG/KYOEPrRujV9LvwOrf98FzfMwxjTIY8mPvn4qgdmSeTWiATqNicl5cCfv66NtN6ib7fWsuCwhpngM4FbDxa+ToTONOgQpBouQa8YVCmq2GHYN4opHA7HnWKaRDsju4v4d51PDZDSKslUirj4Pjs8UT63ZWeQH1jvxOdLpzQF43RIS1ouF/8nt14SyW84H3XvmPqmiPVu/yglqvH1mF/1eVuhEWRbqGtGL7DO4CV+oGXxSk9RvAm42JkLC1k8UtoLkbqscc6N77Kma+cdSrmzacolbA3pG5f4AgNhAiGl0m2HxZ2GXI5YsgItMlcf3tRJC7mYnhEd1sWiRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sgam4+sdcyJMMSPj5dEx56rSUhUZSp8Fm11w+ycRCI0=;
 b=j9Crtz6TwYPZBKhROtVEfPOVI2tNRqUIoaDWVdZXtTB8rCif34aa4SeeU2TnDv9lAzkYsb3ko+ahgJB+5i3afVciMzqv/8ikd1eOH8SQP0te4PVPAYnGawcmTQXvAryivWCr0G6gDo038o0c2M6NvTyqOTCd63fYtJp8WC4bK4gObi/UUzlA4iPA+Gy60R4n+4mb/ys2GvwBdJ4w6UBhinbSZgQC9GoO3oXXNqMKm5jiDMkpuKsj8o6xkLo9xR5D545Qy9X6AdmMTJjxgtcnegvonriClN9uFCV+OVvtV1Qs/KtwuFVXF1bWI8qq9pgGQfOiKMtYumNsVsyDEixjFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sgam4+sdcyJMMSPj5dEx56rSUhUZSp8Fm11w+ycRCI0=;
 b=s3z9/YMVm/IJ+sAa/vzn7SCPu49hv8G9gAXXBvBsE/qpCRTEuw/kGJ5+uYn39D7HNB7U2DGRVafMsso3zsCSJMwT9jiVz5zk39TJHhiT8TPSFeee3bRhiGse3WClYiUpWVapfJab7O35aYlimgxq0rPkSJGNoY8LhNHphNm3KzM=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB3993.namprd10.prod.outlook.com (2603:10b6:5:1f6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Tue, 17 May 2022 18:08:58 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 18:08:58 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH V3 0/8] vhost flush cleanups
Date: Tue, 17 May 2022 13:08:42 -0500
Message-Id: <20220517180850.198915-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: DM6PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:5:60::36) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 909025fe-6e8f-408b-61a3-08da3830505f
X-MS-TrafficTypeDiagnostic: DM6PR10MB3993:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB39939E13990C0EDDC35C0498F1CE9@DM6PR10MB3993.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oO9daH7ZAdgN/vZ5fRbHxW9EiB8rElSpnnxtKs7h8aIRqYZTWb9s2S3EWU33J+AEMLKN1Cz3aDV+zpGtcuRclOax0OrTgXxTESlAbB8pRUuUjwSfO7RDy5owf8vFDDq2yhUAZOsMD0KVNgfCO49qY+aBrgksZcvkDfQGKhS7AgS8YieoPX3HdX3fR6x6MepGD9BKpZuL0nG3TcyGz5XXnMjoA9gbeY75Hgiz8uJpBo5G10lBGsr4X8jz7jaTXbpJPtGtmu6Y9xyvAyiPsm7OwSRT/N/oCb3O/8uECjeOeb3hvVAa2+7xI/p/DfAFUIXcWxT2OgYTQ0RTifF4L51//2XH449/FACoAAKuNXegy2mRYEof9jmjcQStetf8vdE7hAM6FYx/zjPs7wNOrz9YoptNNY+MZO/RK6HclTI0CjM1rK8e+AfvkXHRj0AMlzqnIUHmevKR3byRqY61oECxnByejjzUnZQ85eFs224XP2t/U8HiabHEE4/AXH1ImLW6nex7CR8SB5FtKl2A1kcmX2ubdh5+J08NFvtJ5FM8zFdKjoP+AiZWx4jMCdTEOYaPdXk67IrBsA3wgujgo0/M6uDWV2S8DbIajzwLvDqcpt17ot5HIYhDRsRQ4fUGYk8qxlMYc1KqMhFMQVWEQ47xSSVFjL4LJ5Vf17oFwhEcNJDCQTLQyDU7GHZl6WhrIWMQOdnjDX6+KTBZ1Ga488W76g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(1076003)(2616005)(6486002)(8936002)(508600001)(36756003)(38350700002)(6512007)(2906002)(8676002)(6506007)(5660300002)(26005)(186003)(66946007)(66556008)(52116002)(316002)(66476007)(4744005)(38100700002)(86362001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rX17sipwDLYySpxv0bsbNDQEC8IDKejgZTIdkPwEJloh33xhzeYPd9Qg63JY?=
 =?us-ascii?Q?KRW5LPRp1MWjmduzvvFZptP3T86pbEV9ozhQ0h6lkY/NEbPryTcGP+mR8Gfu?=
 =?us-ascii?Q?QmTJ6KMy+2c2a03ZkVhIV+Chij2SCLMR2xvRsI/0sU7NYPdpIyPVyaWP+iWC?=
 =?us-ascii?Q?QQp0m8J+RJoDjt07D8meiVJlhTTyP4+gPgktVPOKIR4I5pMdB10vMZc2Xole?=
 =?us-ascii?Q?YBIlCKXbBMeAPNrr2nm4DkGav0ndDgQ6xi0ZBiNN5UuYiMHrvu2DOZy5hbxg?=
 =?us-ascii?Q?V/GOX3DAMbe1AlM/3o4VNfuwWmc5ywMMiH4zOz9NdD8YY6TgpztDVhdgUrcE?=
 =?us-ascii?Q?9lGlvIc/XoonqlrXbhN0yodXDLbtlOaLJgkpPg9c3kOgnGf+UmXP3QjBh7Sg?=
 =?us-ascii?Q?PoqGoa9hszqGHE24shvFj0aOYlR5UBOpwcgz5N1aRUiWrXd0Dq9c0O994bIO?=
 =?us-ascii?Q?VODlDnWhu5JR47kVx2i+N8/1Ka+K8VUg3Ia2FC0fhrub2tnukiykHMC4WDlE?=
 =?us-ascii?Q?ziWOmuwIwSHrtQzmBE/UQuyCNJLckAAKb609w2/2RUBdr0ATWMT7C2bpE2xT?=
 =?us-ascii?Q?DbbQQeRZHxy/s/28Q/lDs1nhtYpUKvKy73bQeRjdxIjVLpx4iNArJb3pFb96?=
 =?us-ascii?Q?6pXex/7gGsu4J8cmzz6MP7g6CyT5Qe6l14zOwyxZgwQ+je+CTa4/eQQH+4vu?=
 =?us-ascii?Q?zQ9+FikH6N1xnvsKB3h0XLym8OaLy8q1eZCcF3aGf8B/pkFeOPQnQNXZTwqq?=
 =?us-ascii?Q?hRqdAvMaz/vOKIbFAbOeRbunxTqY3NQjY6tHjHvCpmg/KxxOxHD43yqHCXVh?=
 =?us-ascii?Q?CxgKr9LKdk7oqLpQhQKeJLwf6Z7nJrnyI9W6P98GPILdDOohqwsYsU3hxX7t?=
 =?us-ascii?Q?Beldf/x43rKvAXpIKc8/JqlnlIoNmZXbVaHe18mnEX5MC494G0dD0r8IJDZl?=
 =?us-ascii?Q?LJLpxglq78nQxf6izJiBHXz6/7rFBRb/vYkOd3oYiv4nWieUmDuLKHs0SYlm?=
 =?us-ascii?Q?m5SjClndkXJy4FkIo0BNLR8b3apXoCHWjtiNS/SGtpkMTpmQk9ZiO4xP6fy2?=
 =?us-ascii?Q?i4Kc0trUbOlxr91s26rf2BUXtT9hnvcxi1rT8pGn4rpP63u6NJ0Pf42oxDo2?=
 =?us-ascii?Q?SDu7+qSGWU05JJ9zbt681fdLmM9Ja65ULXBrfx1dZNxGqBVgb6s7jMcbeZk8?=
 =?us-ascii?Q?g0W1cm94tiLtf4lrIkCq8SblU37Zy0W7xMlW3ltEgtUbWokKZmqrpQc6w17n?=
 =?us-ascii?Q?MUUwM3rJh781LAVrd8BanZyV/x5IjAysYLAcvj35IdFTjgl3vac16ujfbcYJ?=
 =?us-ascii?Q?QE6c3snUk+uZHOa3wLImBG2khqSAUYz1DQpM2nyc0rk4uMQx5gpZKuipw17C?=
 =?us-ascii?Q?N4MxlOT1kCcPwudBdDUE8eYqglT+yZIUHLLj+XULI5z1PQHqBlJq+T5vPpp0?=
 =?us-ascii?Q?4i82GRSAxB3Txa3cVWbFQjQTvIDBkOo1b6sOB7as/WCeRfdHXe3m8BtmuuGj?=
 =?us-ascii?Q?Qo2fw8HLQHZXFgvfOvCzN2B8CHwS9rzf53sg+o26WphX8ssk7KqgWsURT2Pp?=
 =?us-ascii?Q?wjmMa3w0xxMuhItGehsdYYjGjV4nF2T1OuuexEgg91bMTgBTy9UKaBfbmdnJ?=
 =?us-ascii?Q?Brq7UTV9vnFqoYI3J1m5O55bIsgXEeTU3w88slv2vEYFD4uluTpedR6lP4Ih?=
 =?us-ascii?Q?v2jiE3dhkv5rynYVn8C/isZ2O/q/KFwqgj4TWYrPiX5FuKUMmqXmLGg0puST?=
 =?us-ascii?Q?9G5W7RzI3SLjvLEkHW/2Js2yZ4E95DM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909025fe-6e8f-408b-61a3-08da3830505f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 18:08:58.5454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sySu0dIqDhQ1HysA59XuC+04PE+PN5FItoRYR7Tb3hMbf8KmXdE85st3+YMl8cuzZBqT+5fcbJCehyDz3MTfYQZXGaoMZ1FlABG3VHMhrog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3993
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-17_03:2022-05-17,
 2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=819 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170107
X-Proofpoint-GUID: CsIKEDfVt_e9sVJJEfwRjUkL-8dDv9Kj
X-Proofpoint-ORIG-GUID: CsIKEDfVt_e9sVJJEfwRjUkL-8dDv9Kj
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

The following patches made over linus's/mst's tree are Andrey Ryabinin's
flush cleanups and some from me. They reduce the number of flush calls
and remove some bogus ones where we don't even have a worker running
anymore or they were based on outdated or incorrect assumptions.

V3:
- Fix test.c flush use.

V2:
- Added patch to rename vhost_work_dev_flush to just vhost_dev_flush
to handle review comment from Jason about the naming not being so
great.



_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
