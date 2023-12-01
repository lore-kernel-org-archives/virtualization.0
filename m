Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9375B4401
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 03:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gWPwxpcX"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D1206074C
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 03:48:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D1206074C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gWPwxpcX
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WtUaS0_dwdim
	for <virtualization@lists.linux-foundation.org>;
	Fri,  1 Dec 2023 03:48:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::605])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B9C06605AE
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 03:48:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B9C06605AE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKwEAMcI6NmgO4C/Gob7K/6StXFMXuYm9A6Lgv6eB+5zLymu9/A90ACrxBBx8/QSFG4msrs57tvO3NnRpt0vDjcSDGJtVFO5pD0Q//TRrpBkNRDk3XxZqo0lOjgVfuRx8Hh9kEu4mmTX2u8iuJFlcPWrwOtLG93VqWbukaDsvcGh3kFPB6hkGhC9vYeOAFO5q7spm3Fvz8U+OFwkq/roaNoT5iQviLrGKOWdlryOTAkUtS9Y+SzFdoWs+utyDAdITePfo6R0Kiz/E34vJxGha6N2OSE6zN6u8To1IJ1vn5yG+2NGjxL8QBvBnV/xhMEySliJYrqDYuOtJ6eVfhpOeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQmSBeHix5z0t5+gOg5wAuDQht4Fq/k7XroBOQBvD1E=;
 b=AAOf4WxgjFFigcTHttsfn+yDseCVU/IoZJTfqn5INA9mkBxXBbXQQuNKV4XcKLOCNRoVQdZBMQUXxvwaz4YKhJjllLvy2wr8h3eEVU9foxsaTFxE6HZp7W2qg73lHKlLTOe/4vpT8OmfPeT2I8NC0cnDlC9MpxIQf8FFmxf7eKC8KwoCmU6MfBuINk+mv0Pzo5F986lrwmO4XX+mTlSgj9TOMOpM3dOhsyOmH4DFlEKeBEJH/IK0VEAPyw8xEXctho13ZJpdeuTXJDaThGTj9uA8luaj37gKS9EJFdYElU7kYeEMB83h1X0SKwMNfFezaEkmT5PZOhbSJOD8+8UG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQmSBeHix5z0t5+gOg5wAuDQht4Fq/k7XroBOQBvD1E=;
 b=gWPwxpcXnMy/qLIYWnekXPl4eLpkiwv3uk3cGUApK5jpL9Kpn7qvY+J8lAydSobUc7MzqrsR9yPHF6TmrRZgyStCS066fdQzjNCIC/FamHHJm5oP/eOXV0oSGHkfBdiP7hM9KT4o+PGc556fjF0GOb8F/H7hK3ibqSRTwBcnKAZHW6vUF1qTuOi4gH/sUXBs6N5NaeXGf/hON8FzqbWYphfXW2t0J0qUyrTiGvO7CWmpNcd7+oZ1F25ArSu3tzkeAR/G830P1KgC9uRFPmcMbszoz6MQLNTKi9KTts1FgDPHTF8RpG7DrUqX3KMKglHCjFetc13Jsqoq9TdF6NHE9Q==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 03:48:20 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5615:d69b:3ff7:1f7b]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5615:d69b:3ff7:1f7b%6]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 03:48:20 +0000
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	"Ning, Hongyu" <hongyu.ning@linux.intel.com>
Subject: RE: [PATCH vhost] virtio_ring: fix syncs DMA memory with different
 direction
Thread-Topic: [PATCH vhost] virtio_ring: fix syncs DMA memory with different
 direction
Thread-Index: AQHaJAcm8Ptp6dg2WEmXgZQbHFvLerCTykLQ
Date: Fri, 1 Dec 2023 03:48:19 +0000
Message-ID:
 <PH0PR12MB5481202868797DEA50401820DC81A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20231201033303.25141-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231201033303.25141-1-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH0PR12MB5156:EE_
x-ms-office365-filtering-correlation-id: 0723abb2-d19f-4ed0-5417-08dbf2205c07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QmaHvLoYi1ShQANOlk8fUuOUlyHzlrz0XL6OrTNRRv5CwVh236rOkBH3oPYnmzUrLYh997/JpEIC7exS7ZDY+1iHhdnssR+evNQALZtJj+tM51eNcqE+2xihbG4TpBSHFtWivNzGRngQ89oi/PKBKMFmirBspN2ck/nU9+0dqcMWkBNtOxpqr8dIe9V/RPoVazZnwCEoQy8jzD1/D7Amk+8bgDrlIpXdMpEEru12E+6ffGSuyRqIGm730yfE3D9cHSOZfnysWoQW0Fc45vkvXTBvOW5blyUeHMM8KaD3kaQwKVwq7porr/ZFEf4JRFws8nawb//hsuEAnrINNvvYKaXTGxuHGizMc+ggPuvy6U0xc8jSV19pKl7cJLcGlNZPhIdlyQqk3MYm6x5roZMSclw88UPJdp1aZSUtt0V391zGjLyQIWkOBymPJfQQgLB7HopGG3/cJasMSYlMubi0UnlA1gkrmGfvyTE87gdaTI4D9K7DldHxhLSY93Ki4F+NwORs/uClTogT9NW8ramwnQU/49+6x5BWiGyRqPfP680fg92oINMsIDojt0qx2AY0D29WxRt1mBS2j1lttgJJuhExelDR4HTaFob29o0YggV5C5IJnS8k5iFBVpA1v/GDrkhGPsKcenu6jWiGoVqzGg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(230273577357003)(230173577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(7696005)(478600001)(45080400002)(52536014)(66476007)(66556008)(8936002)(64756008)(86362001)(8676002)(66446008)(4326008)(54906003)(966005)(316002)(110136005)(76116006)(66946007)(41300700001)(2906002)(122000001)(5660300002)(33656002)(38100700002)(9686003)(6506007)(71200400001)(83380400001)(38070700009)(26005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tqFQDrYMrFWhIcL+oCq7MFHGEIIzS4Xg3DrXjewcMLfkFhV5n44W0Tq9tGve?=
 =?us-ascii?Q?CKp/Tq1BBHln9Jviqn7VTyJlZItce9we3i8N4Eu0pINqlnE3d7hhIxr34V56?=
 =?us-ascii?Q?pgBDd3VHXG8/NvKGhOka2raYOhv5OKuMhiuOuRtYrOWEyLfyigG7j7FTkhBN?=
 =?us-ascii?Q?C/hrwYuyuUpyVfzGyIRl/OtTS70EQP631YzUWlIlbXzeGScjL9sikmBKbGfH?=
 =?us-ascii?Q?XW+306RukksgJSkzDkkibYJ2rAP5L6rh8tOlXhYZ/UeW93PHJ9u5+otvih3C?=
 =?us-ascii?Q?lGrqK1D2WmLZ2zCzCnLqxmOvj90gTr8z2wKJDWO3FoKpZhzpP+nLbHBhDyNk?=
 =?us-ascii?Q?KbgI4hDOzMPDCJfBsJOqHNJYBJbt6XP/S7ap2R5iQifj9E9WfCUmCEBw1UE8?=
 =?us-ascii?Q?zjzJjDkHNld8v9OHam5wUXoA8wXbGb5LZSuacvUAOniKsolNO4F3IRWbDNnV?=
 =?us-ascii?Q?D2GmiG+ulDW2xHwRdONygxgi6ZFdWdqUuGGgxzBNEaU3pfX0w34/neyhbKEz?=
 =?us-ascii?Q?mF/pZAhgIogg6Pcdt3EOaQb1zmtRGpDd+RrM4XZ3l5JoK5HuFP/D9VP4YPEJ?=
 =?us-ascii?Q?52Djui9coW70PkpelioIwxSMUjtr+6qutlsvVRMWAKSvGo+Z5nkPYzVKprem?=
 =?us-ascii?Q?IVSL8dWA3ZhQez6aecOVW2FcT1+i9VwEcaq+FNWSQNkagwfHylpi+fk3yUqN?=
 =?us-ascii?Q?II8E960hfCZjPBfzB4l0pHe2lPPiF9lHzm68DO5RfTacIcMvdjoTeRJRHBwY?=
 =?us-ascii?Q?QLhcspcnd+3zYxb5FlTQWHvHLdWC+zL7KO+Lmt9pfSvsTNM4Jw7RhxFQQIc5?=
 =?us-ascii?Q?uUr3Ibsp/X9aaHSbcf1RR2g10iuWKXtbo2Xpj/S/k89t6LDl+cY+awAdPjwH?=
 =?us-ascii?Q?K8DuLx3963OIwuHlHIWCbQlRgpnDO1hMTKJ+A43g/TikUNJFXKDuDOk4PaPW?=
 =?us-ascii?Q?98x7A7Pa+mShi837wLfaqp4g11aYu0XJ+HXcDHmaST57au/tn/rZ9YI+nAWY?=
 =?us-ascii?Q?9M73lVMRCDVIby30QvE/EQiKSmiFYy3ujXexyDq7jpDbfsYfqm+FnjT/HuYP?=
 =?us-ascii?Q?SLAfrW7yG0fnFvy9RwAeY3QyajXS+Lo8Z8CNHsthciY90r06+7bvDeLUrIFp?=
 =?us-ascii?Q?h5sHGwXO4P+OySZK5Z2MP7Gry6wtursGY/RggJ5yLp+bj4JgToUYMCPirOl/?=
 =?us-ascii?Q?0RNH53NkpvPghrNe79HO09edrD6NxXhVa+Cn01h/CGNfY0RkigdoKUtndN2Q?=
 =?us-ascii?Q?cJZY83cy9Du8F7QcxiLE4FMYtKwqFDEAQrc7n9bzc8IeeUyf2DnrjD1cLFBh?=
 =?us-ascii?Q?GJI/3MwJnYVATxZX3vkVlrxV8qIKaX/BO/4Q6NIKXRSVRvjoNwQ1XFyE7olp?=
 =?us-ascii?Q?I8Z1I8Vu5zRq5tAGQewo7p4X7r7r9P+93vFCBX6PVKAzMsL27MOlhgkyVZS5?=
 =?us-ascii?Q?ddtWXSYT3dzbMK9m/KCoJuukBYtyBbgcT/XGReimftyja/t+Dfrwgy0PKzYd?=
 =?us-ascii?Q?DSjnv1RjVR+0FGXPZFD9ZRYj2bd9pUYRK6r4K7cadwkgruDuggx9cbRGaqjW?=
 =?us-ascii?Q?B+J6U2SGVxNsRy1mjhQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0723abb2-d19f-4ed0-5417-08dbf2205c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 03:48:19.9882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: caOq/P/rg0wnvVq6+h8tS8zIr9IjZQugYookIfvmhkCs1eGIJ+6ImNQvJamq4uclunTgtvoIhT8lAVN3jJaRdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5156



> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Friday, December 1, 2023 9:03 AM
>
> Now the APIs virtqueue_dma_sync_single_range_for_{cpu,device} ignore the
> parameter 'dir', that is a mistake.
>
> [    6.101666] ------------[ cut here ]------------
> [    6.102079] DMA-API: virtio-pci 0000:00:04.0: device driver syncs DMA
> memory with different direction [device address=3D0x00000000ae010000]
> [size=3D32752 bytes] [mapped with DMA_FROM_DEVICE] [synced with
> DMA_BIDIRECTIONAL]
> [    6.103630] WARNING: CPU: 6 PID: 0 at kernel/dma/debug.c:1125
> check_sync+0x53e/0x6c0
> [    6.107420] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G            E     =
 6.6.0+
> #290
> [    6.108030] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S
> rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    6.108936] RIP: 0010:check_sync+0x53e/0x6c0
> [    6.109289] Code: 24 10 e8 f5 d9 74 00 4c 8b 4c 24 10 4c 8b 44 24 18 4=
8 8b
> 4c 24 20 48 89 c6 41 56 4c 89 ea 48 c7 c7 b0 f1 50 82 e8 32 fc f3 ff <0f>=
 0b 48
> c7 c7 48 4b 4a 82 e8 74 d9 fc ff 8b 73 4c 48 8d 7b 50 31
> [    6.110750] RSP: 0018:ffffc90000180cd8 EFLAGS: 00010092
> [    6.111178] RAX: 00000000000000ce RBX: ffff888100aa5900 RCX:
> 0000000000000000
> [    6.111744] RDX: 0000000000000104 RSI: ffffffff824c3208 RDI:
> 00000000ffffffff
> [    6.112316] RBP: ffffc90000180d40 R08: 0000000000000000 R09:
> 00000000fffeffff
> [    6.112893] R10: ffffc90000180b98 R11: ffffffff82f63308 R12: ffffffff8=
3d5af00
> [    6.113460] R13: ffff888100998200 R14: ffffffff824a4b5f R15:
> 0000000000000286
> [    6.114027] FS:  0000000000000000(0000) GS:ffff88842fd80000(0000)
> knlGS:0000000000000000
> [    6.114665] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    6.115128] CR2: 00007f10f1e03030 CR3: 0000000108272004 CR4:
> 0000000000770ee0
> [    6.115701] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [    6.116272] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [    6.116842] PKRU: 55555554
> [    6.117069] Call Trace:
> [    6.117275]  <IRQ>
> [    6.117452]  ? __warn+0x84/0x140
> [    6.117727]  ? check_sync+0x53e/0x6c0
> [    6.118034]  ? __report_bug+0xea/0x100
> [    6.118353]  ? check_sync+0x53e/0x6c0
> [    6.118653]  ? report_bug+0x41/0xc0
> [    6.118944]  ? handle_bug+0x3c/0x70
> [    6.119237]  ? exc_invalid_op+0x18/0x70
> [    6.119551]  ? asm_exc_invalid_op+0x1a/0x20
> [    6.119900]  ? check_sync+0x53e/0x6c0
> [    6.120199]  ? check_sync+0x53e/0x6c0
> [    6.120499]  debug_dma_sync_single_for_cpu+0x5c/0x70
> [    6.120906]  ? dma_sync_single_for_cpu+0xb7/0x100
> [    6.121291]  virtnet_rq_unmap+0x158/0x170 [virtio_net]
> [    6.121716]  virtnet_receive+0x196/0x220 [virtio_net]
> [    6.122135]  virtnet_poll+0x48/0x1b0 [virtio_net]
> [    6.122524]  __napi_poll+0x29/0x1b0
> [    6.123083]  net_rx_action+0x282/0x360
> [    6.123612]  __do_softirq+0xf3/0x2fb
> [    6.124138]  __irq_exit_rcu+0x8e/0xf0
> [    6.124663]  common_interrupt+0xbc/0xe0
> [    6.125202]  </IRQ>
>
> We need to enable CONFIG_DMA_API_DEBUG and work with need sync
> mode(such as swiotlb) to reproduce this warn.
>
> Fixes: 8bd2f71054bd ("virtio_ring: introduce dma sync api for virtqueue")
> Reported-by: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
> Closes:
> https://lore.k/
> ernel.org%2Fall%2Ff37cb55a-6fc8-4e21-8789-
> 46d468325eea%40linux.intel.com%2F&data=3D05%7C01%7Cparav%40nvidia.co
> m%7C97b0fd5c2bb445e452ce08dbf21e45dd%7C43083d15727340c1b7db39e
> fd9ccc17a%7C0%7C0%7C638369984097407804%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> 0%3D%7C3000%7C%7C%7C&sdata=3DJGLTh%2B0zAW9bAI7tNEEOUlBVvDgM15
> vmAKGtkELCB%2BI%3D&reserved=3D0
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c =
index
> 51d8f3299c10..49299b1f9ec7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3219,8 +3219,7 @@ void
> virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq,
>       if (!vq->use_dma_api)
>               return;
>
> -     dma_sync_single_range_for_cpu(dev, addr, offset, size,
> -                                   DMA_BIDIRECTIONAL);
> +     dma_sync_single_range_for_cpu(dev, addr, offset, size, dir);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_cpu);
>
> @@ -3246,8 +3245,7 @@ void
> virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
>       if (!vq->use_dma_api)
>               return;
>
> -     dma_sync_single_range_for_device(dev, addr, offset, size,
> -                                      DMA_BIDIRECTIONAL);
> +     dma_sync_single_range_for_device(dev, addr, offset, size, dir);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_device);
>
> --
> 2.32.0.3.g01195cf9f
>
Reviewed-by: Parav Pandit <parav@nvidia.com>
