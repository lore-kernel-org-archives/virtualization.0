Return-Path: <SRS0=D/KU=OT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9A4C433F5
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 11:38:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77BD361409
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 11:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77BD361409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2B74F404E2;
	Wed, 29 Sep 2021 11:38:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id amZOICpbEVzM; Wed, 29 Sep 2021 11:38:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 15A2140012;
	Wed, 29 Sep 2021 11:38:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEDCCC0011;
	Wed, 29 Sep 2021 11:37:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84032C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 11:37:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EF2860684
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 11:37:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Xm95mK1e";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="JZ/SDpUu"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AK0KcZc1hoet
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 11:37:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F96860634
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 11:37:57 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TAkdVS008696; 
 Wed, 29 Sep 2021 11:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=kAW0gtHUOklegCZoWKrlrffwvVZVCw3nCBJZqyvWxoo=;
 b=Xm95mK1e5K6Q1rR8VTrxF8ofv5vISHIAx9/QBb9AQE8n5TMVjwbieePwpxWsHy7vj4bV
 dF6+5uuAuZJcewnhT7Dq89OZwD5PMB9e2KnbDbvgwxTTBBlRIBOkcVaMzDvaFBf4OkHX
 scnPflejuSINBHZwIyODVD2yXFKslOrf4oE2AaVXlDtvkPUgLbmsYA27+KRzVxsB/9AP
 S5M2uGmsfqB1Ut78n3q9ixiA2s/PKi8UO5kGxoY22bfPZHLynHv8AoK2AgjMvsTYczHX
 VyNeXVSCJsbkkywrnQFHUwj0xAbHr73fd90u2cSfLRO5D+acEMwp/Pl05QiNXrBbBY3y HQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bchepj3k1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Sep 2021 11:37:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TBa81e093636;
 Wed, 29 Sep 2021 11:37:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by userp3020.oracle.com with ESMTP id 3bc3ce2bwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Sep 2021 11:37:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzFswEn+bdvUR+KqylRjalvcnxGx7q4qeZMwune5VuBRFuIjObVPy7AN4+AVWGmZskrtCt3msNahWP6LYA+HVejszlCXJrU3aNWSaQ0Bco5V3kdGeezBNbvSLZ94YOJoFkOlyWutPUdHKF8JfDaIdVjhsquoPbypQqY0j5VEL8CFoBI+1Bjuqb+zqQhV3V7agpXkmD2jSvRnLp9fUEtpa1Wejb1E7C1P4rAOAfNb1MNhpihNHhP4fgykoy+aoBDgbepTqUslM7ecIGnsItWoFU0X8pULnF4aReUcfAaMFAEpxRtbUMf3FmSnLwKSQx1N5ZmoUo/V5gNRBEswIFz08g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=kAW0gtHUOklegCZoWKrlrffwvVZVCw3nCBJZqyvWxoo=;
 b=Bk/OcA7ka6vJd5KtvA3Jx4eZoFqXhYxbIv9EHEcCy9z4wRwAf2LL5R7zgBnXOfjPdqQ8gh/BzJRCQw9cIduvmOCZCExpk95Q59aagWYlSkGoanSjVLGoToRvGWe54NJ5BztszIEFnWTCjuWMUNGjDQbbPFVPUlDnPQK8iuxzZeH/dbGoPoNJCpXa65wXY2Kk7H3Vk7dPaJ69VxLt15tnpahiGGg9UEoRtllCLflzMo7dtjr0YDfWd13P8/BvHyv/pnNPEKUG3XhEeTT96RyFXGim97k6pNDwdmLEGPYA9tVTdIiHTmkQsXv/ZFa3m8I0GRzakfl1YDyL/Oeh+kmDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAW0gtHUOklegCZoWKrlrffwvVZVCw3nCBJZqyvWxoo=;
 b=JZ/SDpUuUilP6A5A/+tAQps8hSYq1w2fJyBVeFVZwHHSU3oYp1u/ZqigrPu9XkZYazPPqm0/c4NrWlS/NJhcGhdTJ43SSNZ8kuuIyWqJLXi/6Q0gybyBwupWnITStBNEecDW7BD5VXM1wf+RR0NxgvNfdmXgHbKgnvpLMuzckbQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5412.namprd10.prod.outlook.com
 (2603:10b6:303:13c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 11:37:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 11:37:52 +0000
Date: Wed, 29 Sep 2021 14:37:42 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: sgarzare@redhat.com
Subject: [bug report] vdpa_sim_blk: implement ramdisk behaviour
Message-ID: <20210929113742.GA7928@kili>
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0147.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0147.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Wed, 29 Sep 2021 11:37:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1130606-d302-494a-50ec-08d9833d9293
X-MS-TrafficTypeDiagnostic: CO6PR10MB5412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB54126226B7386B03762E62B68EA99@CO6PR10MB5412.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u6q6uPThHwD8+gsX3n1Asuk0IJGLyR9McMyAyOYgEgDrpkoOsTp1aHwAzV+wVQP4SZ01Y26mxh2gCSstxiFT5udWHNx4I0If7TP/mVKqNIynVKPnu/XfHWN/35ckGIkyaW2DtNzitV+S3XASHnRla8p+cSat1J9Na5pBiLVqYq+7qtF0lK8yr8xSCmZm20ciI5vaOyP3Ncq7MKsNKHR6HspiiGwY4YU0d/LqoYkeTkUduGb9oDS9l5/g2VorJjz39xgsn2GgRpaoLWyl4+Qx30b/3Dc/Kg76hpUgupN9WmJXMTUQkmFjbCLfVUVjEoxK98/WGnELL/clFDAsU13+6u+4dcIbzjy1I/HJ09F+ena8w1Z+VrmBCst2e9uGGc763maVd/tFBk6Z69Y4nL48/QZknPRUPXvcVdmNIahtDlq6YwzEqKHmWaLCO/TKyqSeLws9fgInwgTsJwuj4xw0gidUuyKV/5897HHvd3lII3WBtGieIk1C7WrZuzHB3bGJ8LXC2IpJZjta7wTuiIJjCgwDXUevZNvXKBs9xgk2gkdYqXu6EWk5xWKSL2csHx7zW0pd/LdqzYlTVKf16b9Gqeh2EQg5J8nn2Qju7fIt1I/rzVvLI1G/iWisFn328YkF/rLuHCuDPLlGhwlCu/QK5ooBwZSnWIdikASFwevqyl7o+S3Wn5Kw6n32Ai+qp027wxcwA5cZgfxFkcvH/C96pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6666004)(8936002)(1076003)(33656002)(4326008)(5660300002)(8676002)(956004)(508600001)(9686003)(55016002)(33716001)(186003)(26005)(316002)(83380400001)(38350700002)(9576002)(6496006)(38100700002)(2906002)(66946007)(52116002)(6916009)(44832011)(66556008)(86362001)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KBhAZxxubaayjJd6YIarYh+IUZ/B4+PVr0xu0OCAqsBeBLoCILKVYDyGhTbU?=
 =?us-ascii?Q?un361fanROP5nwMfOVvl/n1o3h/McIK/ErgqjZPd6zptk0fBEQa0M0F6RHNQ?=
 =?us-ascii?Q?JQBheZV5nai8/kEH4/iDKgcFGcvJCAPkzQu9m72/U92bmd6LojAZUIqIBwpD?=
 =?us-ascii?Q?Go+FTVUFLqb56j7gCikXyXyZ4RbgV8YfgXmQvq2HaPHBelAZN/8bSSnwzeDk?=
 =?us-ascii?Q?T3xJEGP7NrPvapy9wyLhTDAbmoR7ZgNBb8h3PvtTRBlrv8SUZAJIU0Z90t8b?=
 =?us-ascii?Q?P46wZIMYQfCJQPA1V2/XEUP7um66+NJnH4dNBOKGQTGh+u0RMNhYV9rAeb4d?=
 =?us-ascii?Q?7q0BmpLnBO27ymtISxOFhspOlfwNtyqLblNSiksXFqdY8yL4E+CfAS8k4T6C?=
 =?us-ascii?Q?uMm+pmgHD+arimdkVPbmvBpE88ZfFafDMCPdZzioHOAhXJX72V3s4oxGWe0Y?=
 =?us-ascii?Q?Ht6KipQv7Yr6PR+35GOw/cXo3wwRg1aPfoc/eb3x5H/0ILc12HJSJZ0K4b1o?=
 =?us-ascii?Q?CgfNyqCuXMIyBncSryHSvJFaZXgIoXGEI+QsK8wM9I5ACGNzI3nTFGAunSaN?=
 =?us-ascii?Q?Z8zUagyH8JbD1Kjjypun/AcZNVJcJOZcDC1VCJ4BEZdwzX0j7Is3qisijEWo?=
 =?us-ascii?Q?vN0ZqtEaR9Nfm7KMHUNg15upY3m4YNl5wVTosswcSKAMns10QA6SOW49YIU8?=
 =?us-ascii?Q?lrdwPwAzqAeZjor0MFsic/vkbiruAkhQ40MrQvOHKqHBwBQ/JTlKSNZhsfw6?=
 =?us-ascii?Q?hvOzJxtMFviHjNgHtYqxcChwmfUgD1GpffpS3UjiJhvvWXqkvO8fIb8hFMtt?=
 =?us-ascii?Q?P5cHrXWPIEK3/0MgTxl/7q81UTKcTDXCBXTHF8qAIlCEx0hJwbk1rjKrlzzn?=
 =?us-ascii?Q?983qkhh1yuoV9OUhAkx30co5rr3wvrlts2JsbPLQFxAeeSA6+7LZBYea72HU?=
 =?us-ascii?Q?v0p4BAOVW0hzs5wrsDjjrFQGNv2dGs8DatIAUy1jbN0ZEwuWzKBVEBT60ER0?=
 =?us-ascii?Q?af73L1/UL4nPwQm6cWlsU7fBENz1GT/nd/7XFTuhaJHTalnpckf9tkMPDzZY?=
 =?us-ascii?Q?AgjGVfQXizyk+0+IGDF89MHBFzIP/YH8ECNO0TILTSBuEtD+axAZ+KZyx7Q3?=
 =?us-ascii?Q?8BY94OFwYCbqLh29MWQETvLUvjFl1aDHgMHF2zhRBWU2cgX4eBG84OhaNcjN?=
 =?us-ascii?Q?u51zRyJM7Sa9E2LFVHkqscB0nr6XNR1I8W3RYI1eOCo3324au/TU1H8VYGrs?=
 =?us-ascii?Q?EPf6w6e25SoNLXDiJvVgrqZrkQNBXRmGb1Do4PROKo6C9cqb0OyrmLzyv6bn?=
 =?us-ascii?Q?s8JClB2JYNo7f3eQh1sw4aMf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1130606-d302-494a-50ec-08d9833d9293
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 11:37:52.6806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pv/OFiGQX75116QAg5DCqg/eEdrCG08v/3u8vES+I/RUkpdjKpriAaPtw1kTJtBrk6yWH5EvFES0f4KTCgsRN7jshPJjkPr1Rm7bPT/h7P0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5412
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10121
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109290071
X-Proofpoint-ORIG-GUID: LmMjibUxS-6HknFlay7I84mrDCE5Oug6
X-Proofpoint-GUID: LmMjibUxS-6HknFlay7I84mrDCE5Oug6
Cc: virtualization@lists.linux-foundation.org
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

Hello Stefano Garzarella,

The patch 7d189f617f83: "vdpa_sim_blk: implement ramdisk behaviour"
from Mar 15, 2021, leads to the following
Smatch static checker warning:

	drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:179 vdpasim_blk_handle_req()
	warn: unsigned subtraction: 'to_push - pushed' use '!='

drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
    61 static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
    62                                    struct vdpasim_virtqueue *vq)
    63 {
    64         size_t pushed = 0, to_pull, to_push;
    65         struct virtio_blk_outhdr hdr;
    66         ssize_t bytes;
    67         loff_t offset;
    68         u64 sector;
    69         u8 status;
    70         u32 type;
    71         int ret;
    72 
    73         ret = vringh_getdesc_iotlb(&vq->vring, &vq->out_iov, &vq->in_iov,
    74                                    &vq->head, GFP_ATOMIC);
    75         if (ret != 1)
    76                 return false;
    77 
    78         if (vq->out_iov.used < 1 || vq->in_iov.used < 1) {
    79                 dev_err(&vdpasim->vdpa.dev, "missing headers - out_iov: %u in_iov %u\n",
    80                         vq->out_iov.used, vq->in_iov.used);
    81                 return false;
    82         }
    83 
    84         if (vq->in_iov.iov[vq->in_iov.used - 1].iov_len < 1) {
    85                 dev_err(&vdpasim->vdpa.dev, "request in header too short\n");
    86                 return false;
    87         }
    88 
    89         /* The last byte is the status and we checked if the last iov has
    90          * enough room for it.
    91          */
    92         to_push = vringh_kiov_length(&vq->in_iov) - 1;

Are you positive that vringh_kiov_length() cannot be zero?  I looked at
the range_check() and there is no check for "if (*len == 0)".

    93 
    94         to_pull = vringh_kiov_length(&vq->out_iov);
    95 
    96         bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov, &hdr,
    97                                       sizeof(hdr));
    98         if (bytes != sizeof(hdr)) {
    99                 dev_err(&vdpasim->vdpa.dev, "request out header too short\n");
    100                 return false;
    101         }
    102 
    103         to_pull -= bytes;

The same "bytes" is used for both to_pull and to_push.  In this
assignment it would only be used for the default case which prints an
error message.

    104 
    105         type = vdpasim32_to_cpu(vdpasim, hdr.type);
    106         sector = vdpasim64_to_cpu(vdpasim, hdr.sector);
    107         offset = sector << SECTOR_SHIFT;
    108         status = VIRTIO_BLK_S_OK;
    109 
    110         switch (type) {
    111         case VIRTIO_BLK_T_IN:
    112                 if (!vdpasim_blk_check_range(sector, to_push)) {
    113                         dev_err(&vdpasim->vdpa.dev,
    114                                 "reading over the capacity - offset: 0x%llx len: 0x%zx\n",
    115                                 offset, to_push);
    116                         status = VIRTIO_BLK_S_IOERR;
    117                         break;
    118                 }
    119 
    120                 bytes = vringh_iov_push_iotlb(&vq->vring, &vq->in_iov,
    121                                               vdpasim->buffer + offset,
    122                                               to_push);
    123                 if (bytes < 0) {
    124                         dev_err(&vdpasim->vdpa.dev,
    125                                 "vringh_iov_push_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
    126                                 bytes, offset, to_push);
    127                         status = VIRTIO_BLK_S_IOERR;
    128                         break;
    129                 }
    130 
    131                 pushed += bytes;
    132                 break;
    133 
    134         case VIRTIO_BLK_T_OUT:
    135                 if (!vdpasim_blk_check_range(sector, to_pull)) {
    136                         dev_err(&vdpasim->vdpa.dev,
    137                                 "writing over the capacity - offset: 0x%llx len: 0x%zx\n",
    138                                 offset, to_pull);
    139                         status = VIRTIO_BLK_S_IOERR;
    140                         break;
    141                 }
    142 
    143                 bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov,
    144                                               vdpasim->buffer + offset,
    145                                               to_pull);

Here "bytes" is to_pull again.

    146                 if (bytes < 0) {
    147                         dev_err(&vdpasim->vdpa.dev,
    148                                 "vringh_iov_pull_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
    149                                 bytes, offset, to_pull);
    150                         status = VIRTIO_BLK_S_IOERR;
    151                         break;
    152                 }
    153                 break;
    154 
    155         case VIRTIO_BLK_T_GET_ID:
    156                 bytes = vringh_iov_push_iotlb(&vq->vring, &vq->in_iov,
    157                                               vdpasim_blk_id,
    158                                               VIRTIO_BLK_ID_BYTES);

Do we know that to_push is larger than VIRTIO_BLK_ID_BYTES?

    159                 if (bytes < 0) {
    160                         dev_err(&vdpasim->vdpa.dev,
    161                                 "vringh_iov_push_iotlb() error: %zd\n", bytes);
    162                         status = VIRTIO_BLK_S_IOERR;
    163                         break;
    164                 }
    165 
    166                 pushed += bytes;
    167                 break;
    168 
    169         default:
    170                 dev_warn(&vdpasim->vdpa.dev,
    171                          "Unsupported request type %d\n", type);
    172                 status = VIRTIO_BLK_S_IOERR;
    173                 break;
    174         }
    175 
    176         /* If some operations fail, we need to skip the remaining bytes
    177          * to put the status in the last byte
    178          */
--> 179         if (to_push - pushed > 0)

What I'm doing here is I'm looking for places where there are signedness
bugs such that "pushed > to_push" and the subtraction results in a high
positive value instead of a negative value.

I think there are potential issues here.  It's definitely not clear
without reading a lot of context whether this code is safe.

    180                 vringh_kiov_advance(&vq->in_iov, to_push - pushed);
    181 
    182         /* Last byte is the status */
    183         bytes = vringh_iov_push_iotlb(&vq->vring, &vq->in_iov, &status, 1);
    184         if (bytes != 1)
    185                 return false;
    186 
    187         pushed += bytes;
    188 
    189         /* Make sure data is wrote before advancing index */
    190         smp_wmb();
    191 
    192         vringh_complete_iotlb(&vq->vring, vq->head, pushed);
    193 
    194         return true;
    195 }

regards,
dan carpenter
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
