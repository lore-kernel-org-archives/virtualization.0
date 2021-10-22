Return-Path: <SRS0=+kt1=PK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00563C433F5
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 15:07:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8819A6112F
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 15:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8819A6112F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D9B1837D3;
	Fri, 22 Oct 2021 15:07:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7O_xJ2tf4Nqf; Fri, 22 Oct 2021 15:07:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B1C12837B9;
	Fri, 22 Oct 2021 15:07:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 711C4C0020;
	Fri, 22 Oct 2021 15:07:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40EA2C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 15:07:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27D26403FF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 15:07:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6E37uThFMpme
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 15:07:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D5AFE403FA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 15:07:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJmFge53x99EkwzSA7VI824KpRW4LVTHjqjpkkzygvL57kyB8lgGN7e5XquIMOrLiiSvaR94XkCtg070EwAv50kFsSzG59K0I8My5jCRDTFdyTHxetcUVYZnmDGWbm6Ytw0B3SsKalwPqGxo7bSWApbiWPQCAucFiO4KLbE9CbP+aiA/Ch7dDWRjKMjetWTq79dd+xXQ3vcYiaQckoUC/g5r6OPi5YZdOIhbDhnjQiMVlQr0zuUSXu4otkutCWJejuPWrpgMexH8Is0nkSIB9b4fpFEc4lUJLE9O5bvEoVUlTvp/E1PSLfajSk5Icjv9SOzurj/g7Y3ckIU5HUVLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esBzImAHrfjfARyjWdk+aDT7ykKJ+qMQXuVS7/h7vOQ=;
 b=k7GKzzOojGW5EMhdwc7Cy7nr7g3dwmdj3D1SKyV7MJqQDupsT4KrTniBg/y/v5J7q0GNQTY3PrjJnmXJdyj89AY9sSaVITQUDmzZbotmxlWM/LAKpPC0nkM9tVVEjSFZIkrbyvd8RlN+BatJyQaG9qpb4bOdFc81Kv5Qnb4uTOAQHEv4HD/ydT9cryXoA7r0SmX9ediApuxIxClXs4k7996jBEIzavy10I+jCjcR00Xcr7186XVI5IuAZf4OP82pNQrXW6C+MD5NrnoLvZID6HpiOeOp1HylY1jHw3PPXAq726m8enMPHgtTaygoeBGU2CS5QWzyg0jzuOXrhaa1jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esBzImAHrfjfARyjWdk+aDT7ykKJ+qMQXuVS7/h7vOQ=;
 b=AeTistr3Ubbv5E+mxFz9dkSixzh5lJxA2XoAsfgqsKQbFECQZsf+VbG+Juex29u46brQ/dZDjGGMP86hZStoG6xuRae4mAPWPkzgeNYs6fRuR59q1JlM32bsMmX38+6keGAJSicMh5/p7r+Pk403DZeUbNig4LkgdokwLF9xbOUpUWmEGDH5cnDD1Bt1BsCujDTmAjIUmOG12R9oDAmnNeH9YIvPBkU4Aqug6zGSzClg19b4qObqD9oiyWbHBXJvmONlifSQYqDvgAn90KIsG/ij9tEkMO20OuezKwZwjD0iNdBbiifzegLfkggMmoamgFJlhOLSsM6akTi8ouzrUw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 15:07:32 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 15:07:32 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next v4 0/8] vdpa: enable user to set mac, mtu
Thread-Topic: [PATCH linux-next v4 0/8] vdpa: enable user to set mac, mtu
Thread-Index: AQHXxpmvqggo5IfRl0a+twGjkaCaeave1XCAgABIAUA=
Date: Fri, 22 Oct 2021 15:07:32 +0000
Message-ID: <PH0PR12MB5481D9037F79F3118AACDB3FDC809@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211022064007-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211022064007-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf23eed6-e49d-4bdc-290e-08d9956dac6f
x-ms-traffictypediagnostic: PH0PR12MB5403:
x-microsoft-antispam-prvs: <PH0PR12MB540306766FE65FEB0164FFEDDC809@PH0PR12MB5403.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bQfM8cL6HNWb/lLlV1Sb+lkJr9/oF6BSL3dt3eTqbaO3Ly7yu96ypOT0WtkhpEtyLVg3wi1R3xldabEVzpE9d3F0EqtHwUX/zC8YtuOb1s2V477oqVYIOIMPhe86QMgMWmZmkrVhYZRIenHLs1cM84zRFqTbLTKbt6aY1K9PIVfmKxnZUUsKK/HHlg8yMfI9PSVMQvjqU43TLOVQITrc6cizpjs1jCi/mi0TkazswahTZIXGrQKkz6TXVzwnVtzGyXP1qDSQeXLXJdV6noYrIMU+XgObeMECr6P4suZQzCy3pxb8lLpMoBCd53hhOuffzbkP6F6H0BolYqQauimXsoS9wc4ddGbiI2T3TWa2BVy3AwzBxDM4olf7pRhJvJXsgxsqulaBB+spJUJ9/Np/yUSx1F/2NDM4dqPSZzO6l6T706Xx1euFSDDDuRMNbB/5ZuGRtNt4aI3P8rk5/rrKKaLa3IuLGnlzBpCbdUUfTPEIHfkomGWfVVlbLn/EovD+YOHP/b7oJFzsom3F0s3iX9Znm265QtfbIBWJoNeIybQMP9tbUcbIhqWR6wAX3eHBCluIJ1pw7IocdfGyXoaXamEmr7tIhc0d5wO+gCTsG2o1NEGz0djYLlIPEmtBjMSBEITrXRXeqbUxZceNJF70lPm+thUUoxw7UHsoaK25QBhqbErwjBpluRqbvHQzExRxVLANyLhIjA5NoUc7LsMyXw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(6916009)(8936002)(83380400001)(7696005)(122000001)(38100700002)(71200400001)(5660300002)(45080400002)(508600001)(54906003)(38070700005)(8676002)(107886003)(186003)(316002)(6506007)(9686003)(66556008)(66446008)(66476007)(64756008)(66946007)(76116006)(4326008)(2906002)(55016002)(26005)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WwIPyX/zlyYZ0z5vaVoYBX8wTfNJZfOiV7ZdSerXo1qMHhIxixYE+VlBhPNH?=
 =?us-ascii?Q?XEsFhMyiFux44YXn4QWWUD0a2jx/9ecOWMDE3nVz3NwxNUJYm1hPuQJirP53?=
 =?us-ascii?Q?ZQ/LywHLXZUvxTQAvpgJ7IruQEpI9MnGX4Vwy0WOknz0VWBLpdrAd95iEvbJ?=
 =?us-ascii?Q?s/vDf2DO58mZzY/CG2VWLlTL5KyCFq3XUFPk0EBrlxL0uzFsS3rLwV7a9gfc?=
 =?us-ascii?Q?6pb3ZU2p4ZnCP/hqhzZVwlBL2weGPEBo7uIcyiYyCJXYGOhLobGlzHSA5UWS?=
 =?us-ascii?Q?KPOR0ISRWe0aDOqI5gXFh4tWGpHHzi59AYmE65XN8SVkE0sTNEwnNdLQpLd3?=
 =?us-ascii?Q?u1wrgNRAWi5EiHD/m1C4vflC7P14MhJBfu+gjU424bEtJDHzIfdoWGloV4zJ?=
 =?us-ascii?Q?WWk+eKMSqQAkZMqXuP4gDnf30HbURhHZPIYwCrElGu2X0geEIdjBA5pKg09g?=
 =?us-ascii?Q?cFzL6M3omS1w/lFnamVctciyZVnL5lwkndAs/oB7g3nLi7UnbayCKj2AHYpI?=
 =?us-ascii?Q?vl6uuQLde4LnGVgUnX19Z53H2N+5nxO5SQq7AA7sdFYjPOqM3lSCKk2vA/gJ?=
 =?us-ascii?Q?z9VSTQ9eeme3xvid/c0ZvsuopLEcHrX1WBEzGmmACeLKRo114VI8kqvO2EhW?=
 =?us-ascii?Q?2wJl71RrdD3Lk6edHNQOeQrgEeKF5cTz7dbzNZyj5XIedRczE02OC+A8K/Z5?=
 =?us-ascii?Q?gDjvlpevxgxCchMvstE0L1gWZXNU16TGDpliKg62acfA+ERR4ZN4KvxtjxaC?=
 =?us-ascii?Q?JpYgahS5hNqxVD01XQT55IteMTUsTdezxipvRUkGul/NL9Gw6/HNAa7SVjbF?=
 =?us-ascii?Q?9DrJ2FDewZ1EZT1Q5OPjGLDWp6140PLXl5LY1YvF5fZpsyTOURBCuyBGyLr/?=
 =?us-ascii?Q?/StQ/0IuP07SzFx/Wu20Iei7n4/gs7sMhmwC+ONm1T5Sclc/Z15b3kTuSCsx?=
 =?us-ascii?Q?F2R0HaIhRhRasjEaO4QsfmSC69ZPWXO8ulu8AUw6LrmzWiOJWztifhAau2QD?=
 =?us-ascii?Q?rCLdQKved+sOFFnhXlgmcgeKGwoQg0x9/Hn2Zyv8KKj8oTC2e+EASc5FQwOu?=
 =?us-ascii?Q?sjCVeuPnEX+vD5xIHI6ZJ3/kOj0DxQFdyy6niem+TPAm/OZZuSESvfV+Wd1M?=
 =?us-ascii?Q?tTJZzDfk3nTxle/aaOCs1kCp9Tal4gjkBt2REHdXElXCqmhDrAb2wM76y7QN?=
 =?us-ascii?Q?C+axLt7inauq65KujfqTNBYL439FV7PEcO8EZbAVwWRZLxstgHDKCHrOACVe?=
 =?us-ascii?Q?Oxb/XS6ZjVGShKj2vLMMkpmxrBmG+dTmq0O8aho7wkRFPFJ3WdqkO0SLixgQ?=
 =?us-ascii?Q?zPWE+KDkmVV9Mo4MnRJ0RM126MI3/Z0PJZ5hG4IQ9va40qxBzp6NjzaEWfsW?=
 =?us-ascii?Q?drOJnw+WdGwVX6cO27IUFEd51FOKFSVWLDr+elP6FC181OupxeOBNg2MrlUX?=
 =?us-ascii?Q?l6ufttb3lq8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf23eed6-e49d-4bdc-290e-08d9956dac6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 15:07:32.5809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: parav@nvidia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Michael,

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, October 22, 2021 4:11 PM
> 
> On Thu, Oct 21, 2021 at 07:35:01PM +0300, Parav Pandit wrote:
> > Currently user cannot view the vdpa device config space. Also user
> > cannot set the mac address and mtu of the vdpa device.
> > This patchset enables users to set the mac address and mtu of the vdpa
> > device once the device is created.
> > If a vendor driver supports such configuration user can set it
> > otherwise user gets unsupported error.
> >
> > vdpa mac address and mtu are device configuration layout fields.
> > To keep interface generic enough for multiple types of vdpa devices,
> > mac address and mtu setting is implemented as configuration layout fields.
> 
> 
> So I got lots of "sha1 is lacking or useless" warnings with this.
> I did my best to merge but please check out the result in linux-next.
>
I was able to test vdpasim_net on one system with rebase code with these patches.
On 2nd system I started verifying mlx5 vdpa.
System has mlx5 vdpa and virtio blk devices.
After rebase, I hit the below crash at system boot time on virtio blk device.

I have some internal issues in accessing crashed system, unable to proceed to verify it.
However, the crash doesn't seems to occur due to this patches, as its happening on virtio blk dev (non vdpa based blk dev).

[    1.238098] virtio_blk virtio0: [vda] 73400320 512-byte logical blocks (37.6 GB/35.0 GiB)
 [    1.240177] BUG: unable to handle page fault for address: 00000000fffedbeb
 [    1.240973] #PF: supervisor write access in kernel mode
 [    1.241590] #PF: error_code(0x0002) - not-present page
 [    1.242202] PGD 0 P4D 0 
 [    1.242559] Oops: 0002 [#1] SMP NOPTI
 [    1.243023] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc6-vdpa-mac+ #7
 [    1.243559] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 [    1.243559] RIP: 0010:virtqueue_add_sgs+0x9e2/0xe50
 [    1.243559] Code: 0e 41 89 4d 40 49 8b 4d 78 48 89 1c 11 48 8b 5c 24 08 49 8b 4d 78 48 89 5c 11 08 49 8b 95 b0 00 00 00 48 85 d2 74 06 8b 1c 24 <89> 1c 82 41 8b 45 50 0f b7 5c 24 10 49 8b 55 60 83 e8 01 66 41 23
 [    1.243559] RSP: 0000:ffff88810092b5a8 EFLAGS: 00010006
 [    1.243559] RAX: 0000000000000000 RBX: 0000000000001001 RCX: ffff888104f91000
 [    1.243559] RDX: 00000000fffedbeb RSI: 0000000000000000 RDI: 0000000000000004
 [    1.243559] RBP: 0000000000000003 R08: 0000000000000004 R09: ffffffff8289920c
 [    1.243559] R10: 0000000000000003 R11: 0000000000000001 R12: 0000000000000030
 [    1.243559] R13: ffff88810547ef00 R14: 0000000000000001 R15: 0000000000000000
 [    1.243559] FS:  0000000000000000(0000) GS:ffff88846fa00000(0000) knlGS:0000000000000000
 [    1.243559] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [    1.243559] CR2: 00000000fffedbeb CR3: 0000000002612001 CR4: 0000000000370eb0
 [    1.243559] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 [    1.243559] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 [    1.243559] Call Trace:
 [    1.243559]  virtio_queue_rq+0x1e4/0x5f0
 [    1.243559]  __blk_mq_try_issue_directly+0x138/0x1e0
 [    1.243559]  blk_mq_try_issue_directly+0x47/0xa0
 [    1.243559]  blk_mq_submit_bio+0x5af/0x890
 [    1.243559]  __submit_bio+0x2af/0x2e0
 [    1.243559]  ? create_page_buffers+0x55/0x70
 [    1.243559]  submit_bio_noacct+0x26c/0x2d0
 [    1.243559]  submit_bh_wbc.isra.0+0x122/0x150
 [    1.243559]  block_read_full_page+0x2f7/0x3f0
 [    1.243559]  ? blkdev_direct_IO+0x4b0/0x4b0
 [    1.243559]  ? lru_cache_add+0xcf/0x150
 [    1.243559]  do_read_cache_page+0x4f2/0x6a0
 [    1.243559]  ? lockdep_hardirqs_on_prepare+0xe4/0x190
 [    1.243559]  read_part_sector+0x39/0xd0
 [    1.243559]  read_lba+0xca/0x140
 [    1.243559]  efi_partition+0xe6/0x770
 [    1.243559]  ? snprintf+0x49/0x60
 [    1.243559]  ? is_gpt_valid.part.0+0x420/0x420
 [    1.243559]  bdev_disk_changed+0x21c/0x4a0
 [    1.243559]  blkdev_get_whole+0x76/0x90
 [    1.243559]  blkdev_get_by_dev+0xd4/0x2c0
 [    1.243559]  device_add_disk+0x351/0x390
 [    1.243559]  virtblk_probe+0x804/0xa40
 [    1.243559]  ? ncpus_cmp_func+0x10/0x10
 [    1.243559]  virtio_dev_probe+0x155/0x250
 [    1.243559]  really_probe+0xdb/0x3b0
 [    1.243559]  __driver_probe_device+0x8c/0x180
 [    1.243559]  driver_probe_device+0x1e/0xa0
 [    1.243559]  __driver_attach+0xaa/0x160
 [    1.243559]  ? __device_attach_driver+0x110/0x110
 [    1.243559]  ? __device_attach_driver+0x110/0x110
 [    1.243559]  bus_for_each_dev+0x7a/0xc0
 [    1.243559]  bus_add_driver+0x198/0x200
 [    1.243559]  driver_register+0x6c/0xc0
 [    1.243559]  ? loop_init+0x149/0x149
 [    1.243559]  init+0x52/0x7d
 [    1.243559]  do_one_initcall+0x63/0x300
 [    1.243559]  ? rcu_read_lock_sched_held+0x5d/0x90
 [    1.243559]  kernel_init_freeable+0x26a/0x2b2
 [    1.243559]  ? rest_init+0x2e0/0x2e0
 [    1.243559]  kernel_init+0x17/0x130
 [    1.243559]  ? rest_init+0x2e0/0x2e0
 [    1.243559]  ret_from_fork+0x1f/0x30
 [    1.243559] Modules linked in:
 [    1.243559] CR2: 00000000fffedbeb
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
