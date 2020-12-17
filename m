Return-Path: <SRS0=dJY/=FV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D86C4361B
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 16:39:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 735612389E
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 16:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735612389E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 203642E2A9;
	Thu, 17 Dec 2020 16:39:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xM0rPqhoO3Gi; Thu, 17 Dec 2020 16:39:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E77322E287;
	Thu, 17 Dec 2020 16:39:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D223EC0893;
	Thu, 17 Dec 2020 16:39:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78BAFC013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6AF2B2E2A9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:39:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9ndp72O47M65
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:39:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by silver.osuosl.org (Postfix) with ESMTPS id 1755D2E287
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:39:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9ih1N+X8O3lnILwyVbCow4kSdf5ye6CHpT3JYo9A+3wWIBu7xzTyk5iqganykTb7h7l9b8Rn9j18C/yVxbpmeR4F5hii4tuBnln6wq3j8msBB5xICCwzjWCZxefm7mj9eU2VFVvUDwR2o+Dx2kMr+yGba7zCYSSbO8l9wDMPe9ihf7SgReL/Z739I8vRyglrSOlZS4nWRtErTt03XJ+uCQFi2IKVYyZTkZTX1BvVhrSfyxr+CHzkW9/vjPrr5vZ1bs8XBhyoBPcj/XwdYfn7W1FxVDmte4lYtMrwUo4LpYepsHjrEczh+ALCFPbFBDyDpRMkDbi3+SudIR0l0dfnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXK/6XIWrKedgwPHkOGU0VcaSwK9Pg2O9s+PYqfQ+Vc=;
 b=a27GS1NgSdeffEmXq2Eql14toDZdCZ6McHlnBpIAf6Yxcq6uFAaw5F+riT9kGritlwOmy/x1gSciNJAZrjknkvjdht2TKQvh3mRQlduIalFe73qAt+dsjzVQVJKh9l6RU+2Zx0HfpAKyB4o9anQiMg/QjZ9eCx/o0aMv/LbruyjrZTPAkdSo9weiXqo+70us1YH5lijMP5s+CNWJznLOvk9ij4b3rBJ7OSTL2JsEjMS3mE/DQQcwiDYiECzXne/X0hybcvAYXRMmyv8Hd8wcAVOrT47vfxuKhffySyE3fJEozWMGEx7520aLwTLrGuray9ECsZWE/us7GETSqsgTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXK/6XIWrKedgwPHkOGU0VcaSwK9Pg2O9s+PYqfQ+Vc=;
 b=boI59GGUMZDGlAffM4hvj2QEr3/cvSFZpv4g8fjF3oic9Qo4vUnRB0NWk+jWHjnH+vkqLbXXpJN0xWI8Gcc8OocMpPY5WirVHAnq8zDy+o1A9WR6cPAQxGpmqOOM0oUhNGBqukukIiALM/fhso/TPoihr6Een+pZi4yoRz8xbT8=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3949.namprd12.prod.outlook.com (2603:10b6:208:167::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Thu, 17 Dec
 2020 16:39:01 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3654.025; Thu, 17 Dec 2020
 16:39:01 +0000
Subject: Re: [bisected] Re: drm, qxl: post 5.11 merge warning+explosion
To: Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>
References: <5979380e28f4ba8023e88f96d3a9291381a8457e.camel@gmx.de>
 <a1b925758cbc5517d4ff6df3cf2a9b6614fd5535.camel@gmx.de>
 <1f88b926bedcad0d6e35c7f5b63bbb038c8c6c09.camel@gmx.de>
 <6f99d3ca-a7ff-69e9-8ca1-9d016a8d3f48@amd.com>
 <23bc1073395db9ccf55ecca45198375f4d5d6250.camel@gmx.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7cb43d5b-4e6a-defc-1ab6-5f713ad5a963@amd.com>
Date: Thu, 17 Dec 2020 17:38:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <23bc1073395db9ccf55ecca45198375f4d5d6250.camel@gmx.de>
Content-Type: multipart/mixed; boundary="------------3712E5C2A23F470317C58012"
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR02CA0024.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::37) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0024.eurprd02.prod.outlook.com (2603:10a6:208:3e::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Thu, 17 Dec 2020 16:39:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: df8316d9-86ce-46af-50f2-08d8a2aa4281
X-MS-TrafficTypeDiagnostic: MN2PR12MB3949:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3949D9200EC9F7A00F60165483C40@MN2PR12MB3949.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFgSKO+1uf+/fBMKM/JU7XkdQajGYUYc6st47DZ2brWdJnTDl+9Gy7ztn5myX0U+ikotACJ6I0Mt4gVFY1BcmC5Ssy7mH0IOFmgX2ViN0qUyU7Pliqw/lgvoZt9GlTfOpYbSl2awwZUsBAEcxrLEEJfvV3GgoHaRHHHj4TqvnTF5UU40OJnwcLA1a4RUmOg6OmS6uv2ker3bMevrjdRkD4S/KEb9b4Cvj+PMjqqz0hM2n6nhI0C+NmjQSXrAtLRI0T6ePaooJxqSWL1w401Dvgz49yrorv2Zh7IDuFJFOfJxyieeBfiVEpf2MY0hKeXAQ1PfmtJ5ZBdkDJ+jcqIeAOkhKkbVEjZKwqOQ1j16Zko0u68YVcTG4sFLkAiSwX9LFATTLiCDK/xrwhKbFpqAUb58BMZVFoJk5HZrsbYd2Tk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(8676002)(6666004)(186003)(4326008)(31686004)(5660300002)(66556008)(66616009)(6486002)(478600001)(66946007)(83380400001)(66476007)(316002)(86362001)(36756003)(8936002)(54906003)(16526019)(2906002)(235185007)(66574015)(4001150100001)(2616005)(45080400002)(110136005)(52116002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-15?Q?jH3DbpusZuv3CLsOjV3rjLn/J5JLO85GLDBpm62YBs4zvOHF280KSOrjF?=
 =?iso-8859-15?Q?GcU+q6UytxQk3a1WDZ9nzu48GhisTYvO1xABvP3A1/obwm3c5iot8RWMN?=
 =?iso-8859-15?Q?iFT1KuwCzNfnacWQ4ia/7DJJVPknrc4bRKyf/7PzFkEyUF2eDQV2c9hJ3?=
 =?iso-8859-15?Q?8IBPWCS5PEmRj0qSF42kz7qdVKrArEArevXXunWpyUzfUMIyPfagdrmbH?=
 =?iso-8859-15?Q?tdjUuYWz7EcAF2c7htw9AfZRCo5WvvLsBDJYGRjDsYLh77dm2hIEX4xTl?=
 =?iso-8859-15?Q?SlCn2dVCScfWZoIcG6LYJvjPV/C/xSSA8ii40VUjRzAY8t/2a/UfoKUnM?=
 =?iso-8859-15?Q?Ea10DgcTpf0GptlAdLpnQAryl64WE5ez1DzRAbGq6JTrIFw4aCeEEMslc?=
 =?iso-8859-15?Q?kGyhXG1wEhtyHr7RCJNvTffBz8HsIArjqgdeK9FRAhDm5Ni2uZbjAj2ha?=
 =?iso-8859-15?Q?LNEpns+lhoFrl2FGqe1nJhGn7I5boBD/7E2DxbIqjunzpspXPP6mjQzgL?=
 =?iso-8859-15?Q?+atcOSBMjWDKVSwFKUFr4in8vc5CjzSuk2SYdFMgMmI1LTzCNe9Pf45OL?=
 =?iso-8859-15?Q?BCoZKA6FWmnkZINkysQEpHq7+Uykrwrq90NcgpR/iFELJHxTJaAAvcv/0?=
 =?iso-8859-15?Q?otb5hofI0qFL+ZLERPqyzDicvb/mqM7z/k3KVKdQZccUQZL3Lv87d1ZKO?=
 =?iso-8859-15?Q?ab/xUSe9yPRFDFLeJkK45U/qMquGvGRifxMTX9osPDtgbQ8iI5FntLJzC?=
 =?iso-8859-15?Q?p4BtQ4R5F+C8MfkVOK9cDO/Ne5dVIHrl5S96wbKc3PRoW2XWsBU0WX/+D?=
 =?iso-8859-15?Q?7wY6DJE+/PE+7l8S+wGE4iVWeT4FW88+r5U/3lCatgyxUyc1CIeqencCR?=
 =?iso-8859-15?Q?z7LD/TGgRwlUZclOOS6KNgeEVTA9WaS4zREgP5w4YpqubA109CPzMbvOD?=
 =?iso-8859-15?Q?PsdDaYu7mIae8b0JUj2k5yDyEzo4ch5RToOblp7Ww23MX/3PR61PIn2Vi?=
 =?iso-8859-15?Q?tUFqfugKqs+OmpPZ5l/e8Y3woYjHyjjAQXiNsrdM50Zrwbt7GSShMwOsN?=
 =?iso-8859-15?Q?Qkd/RgMpjzaU+Iv1+eXT0CHjBnotQ4uubjAA/IUS2bxVeXlLobwiaPQxs?=
 =?iso-8859-15?Q?KCS0M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 16:39:01.6106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: df8316d9-86ce-46af-50f2-08d8a2aa4281
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgZG8NIbhgJ8GCHiRMskEJtj5nyappTw00ogEojKbPvmznwKS984tV0UZxJuIXYY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3949
Cc: Dave Airlie <airlied@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--------------3712E5C2A23F470317C58012
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.12.20 um 17:26 schrieb Mike Galbraith:
> On Thu, 2020-12-17 at 17:24 +0100, Christian König wrote:
>> Hi Mike,
>>
>> what exactly is the warning from qxl you are seeing?
> [    1.815561] WARNING: CPU: 7 PID: 355 at drivers/gpu/drm/ttm/ttm_pool.c:365 ttm_pool_alloc+0x41b/0x540 [ttm]

Yeah, that is an expected result.

Looks like qxl does something quite odd here, it allocates an 
dma_address array but doesn't have a device to fill them.

On the other hand I don't see qxl using the allocated dma_addresses. 
Dave do you have an idea why qxl is doing that?

Mike can you test the attached patch?

Thanks in advance,
Christian.

> [    1.815561] Modules linked in: ext4(E) crc16(E) mbcache(E) jbd2(E) ata_generic(E) ata_piix(E) virtio_console(E) virtio_rng(E) virtio_blk(E) qxl(E) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) ahci(E) fb_sys_fops(E) cec(E) libahci(E) uhci_hcd(E) ehci_pci(E) rc_core(E) ehci_hcd(E) crc32c_intel(E) serio_raw(E) virtio_pci(E) virtio_ring(E) 8139cp(E) virtio(E) libata(E) drm(E) usbcore(E) mii(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) autofs4(E)
> [    1.815589] CPU: 7 PID: 355 Comm: kworker/7:2 Tainted: G            E     5.10.0.g489e9fe-master #26
> [    1.815590] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> [    1.815614] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [    1.815621] RIP: 0010:ttm_pool_alloc+0x41b/0x540 [ttm]
> [    1.815623] Code: fc ff ff 89 ea 48 8d 04 d5 00 00 00 00 48 29 d0 48 8d 3c c5 00 1c 40 a0 e9 d7 fc ff ff 85 c0 0f 89 2f fc ff ff e9 28 fc ff ff <0f> 0b e9 35 fc ff ff 89 e9 49 8b 7d 00 b8 00 10 00 00 48 d3 e0 45
> [    1.815623] RSP: 0018:ffff888105d3b818 EFLAGS: 00010246
> [    1.815625] RAX: 0000000000000000 RBX: ffff888106978800 RCX: 0000000000000000
> [    1.815626] RDX: ffff888105d3bc68 RSI: 0000000000000001 RDI: ffff888106238820
> [    1.815626] RBP: ffff888106238758 R08: ffffc90000296000 R09: 800000000000016b
> [    1.815627] R10: 0000000000000001 R11: ffffc90000296000 R12: 0000000000000000
> [    1.815628] R13: ffff888106238820 R14: 0000000000000000 R15: ffff888106978800
> [    1.815628] FS:  0000000000000000(0000) GS:ffff888237dc0000(0000) knlGS:0000000000000000
> [    1.815632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.815633] CR2: 00007eff52a0d5b8 CR3: 0000000002010003 CR4: 00000000001706e0
> [    1.815633] Call Trace:
> [    1.815644]  ttm_tt_populate+0xb1/0xc0 [ttm]
> [    1.815647]  ttm_bo_move_memcpy+0x4a5/0x500 [ttm]
> [    1.815652]  qxl_bo_move+0x230/0x2f0 [qxl]
> [    1.815655]  ttm_bo_handle_move_mem+0x79/0x140 [ttm]
> [    1.815657]  ttm_bo_evict+0x124/0x250 [ttm]
> [    1.815693]  ? drm_mm_insert_node_in_range+0x55c/0x580 [drm]
> [    1.815696]  ttm_mem_evict_first+0x110/0x3d0 [ttm]
> [    1.815698]  ttm_bo_mem_space+0x261/0x270 [ttm]
> [    1.815702]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
> [    1.815705]  ttm_bo_validate+0x117/0x150 [ttm]
> [    1.815756]  ttm_bo_init_reserved+0x2c8/0x3c0 [ttm]
> [    1.815772]  qxl_bo_create+0x134/0x1d0 [qxl]
> [    1.815775]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
> [    1.815791]  qxl_alloc_bo_reserved+0x2c/0x90 [qxl]
> [    1.815794]  qxl_image_alloc_objects+0xa3/0x120 [qxl]
> [    1.815797]  qxl_draw_dirty_fb+0x155/0x450 [qxl]
> [    1.815815]  ? _cond_resched+0x15/0x40
> [    1.815819]  ? ww_mutex_lock_interruptible+0x12/0x60
> [    1.815822]  qxl_framebuffer_surface_dirty+0x14f/0x1a0 [qxl]
> [    1.815841]  drm_fb_helper_dirty_work+0x11d/0x180 [drm_kms_helper]
> [    1.815853]  process_one_work+0x1f5/0x3c0
> [    1.815866]  ? process_one_work+0x3c0/0x3c0
> [    1.815867]  worker_thread+0x2d/0x3d0
> [    1.815868]  ? process_one_work+0x3c0/0x3c0
> [    1.815872]  kthread+0x117/0x130
> [    1.815876]  ? kthread_park+0x90/0x90
> [    1.815880]  ret_from_fork+0x1f/0x30
> [    1.815886] ---[ end trace 51e464c1e89a1728 ]---
> [    1.815894] BUG: kernel NULL pointer dereference, address: 0000000000000230
> [    1.815895] #PF: supervisor read access in kernel mode
> [    1.815895] #PF: error_code(0x0000) - not-present page
> [    1.815896] PGD 0 P4D 0
> [    1.815898] Oops: 0000 [#1] SMP NOPTI
> [    1.815900] CPU: 7 PID: 355 Comm: kworker/7:2 Tainted: G        W   E     5.10.0.g489e9fe-master #26
> [    1.815901] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> [    1.815916] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [    1.815921] RIP: 0010:dma_map_page_attrs+0xf/0x1c0
> [    1.815922] Code: 1f 17 5b 01 48 85 c0 75 e3 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 41 55 41 54 55 53 48 83 ec 08 <48> 8b 87 30 02 00 00 48 85 c0 48 0f 44 05 e7 16 5b 01 41 83 f8 02
> [    1.815923] RSP: 0018:ffff888105d3b7e8 EFLAGS: 00010296
> [    1.815924] RAX: 0000000000001000 RBX: 0000000000000001 RCX: 0000000000001000
> [    1.815924] RDX: 0000000000000000 RSI: ffffea0004171e40 RDI: 0000000000000000
> [    1.815925] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [    1.815925] R10: ffffea0004171e40 R11: ffffc90000296000 R12: 0000000000000001
> [    1.815926] R13: ffff888106238820 R14: ffff888105d07100 R15: ffff888106978800
> [    1.815926] FS:  0000000000000000(0000) GS:ffff888237dc0000(0000) knlGS:0000000000000000
> [    1.815928] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.815929] CR2: 0000000000000230 CR3: 0000000002010003 CR4: 00000000001706e0
> [    1.815929] Call Trace:
> [    1.815937]  ttm_pool_alloc+0x448/0x540 [ttm]
> [    1.815940]  ttm_tt_populate+0xb1/0xc0 [ttm]
> [    1.815942]  ttm_bo_move_memcpy+0x4a5/0x500 [ttm]
> [    1.815945]  qxl_bo_move+0x230/0x2f0 [qxl]
> [    1.815947]  ttm_bo_handle_move_mem+0x79/0x140 [ttm]
> [    1.815949]  ttm_bo_evict+0x124/0x250 [ttm]
> [    1.815982]  ? drm_mm_insert_node_in_range+0x55c/0x580 [drm]
> [    1.815984]  ttm_mem_evict_first+0x110/0x3d0 [ttm]
> [    1.815988]  ttm_bo_mem_space+0x261/0x270 [ttm]
> [    1.890133]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
> [    1.890138]  ttm_bo_validate+0x117/0x150 [ttm]
> [    1.891740]  ttm_bo_init_reserved+0x2c8/0x3c0 [ttm]
> [    1.891744]  qxl_bo_create+0x134/0x1d0 [qxl]
> [    1.893398]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
> [    1.893400]  qxl_alloc_bo_reserved+0x2c/0x90 [qxl]
> [    1.893402]  qxl_image_alloc_objects+0xa3/0x120 [qxl]
> [    1.893405]  qxl_draw_dirty_fb+0x155/0x450 [qxl]
> [    1.896515]  ? _cond_resched+0x15/0x40
> [    1.896517]  ? ww_mutex_lock_interruptible+0x12/0x60
> [    1.896520]  qxl_framebuffer_surface_dirty+0x14f/0x1a0 [qxl]
> [    1.896533]  drm_fb_helper_dirty_work+0x11d/0x180 [drm_kms_helper]
> [    1.896537]  process_one_work+0x1f5/0x3c0
> [    1.900535]  ? process_one_work+0x3c0/0x3c0
> [    1.900536]  worker_thread+0x2d/0x3d0
> [    1.900538]  ? process_one_work+0x3c0/0x3c0
> [    1.902704]  kthread+0x117/0x130
> [    1.902706]  ? kthread_park+0x90/0x90
> [    1.902709]  ret_from_fork+0x1f/0x30
> [    1.902711] Modules linked in: ext4(E) crc16(E) mbcache(E) jbd2(E) ata_generic(E) ata_piix(E) virtio_console(E) virtio_rng(E) virtio_blk(E) qxl(E) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) ahci(E) fb_sys_fops(E) cec(E) libahci(E) uhci_hcd(E) ehci_pci(E) rc_core(E) ehci_hcd(E) crc32c_intel(E) serio_raw(E) virtio_pci(E) virtio_ring(E) 8139cp(E) virtio(E) libata(E) drm(E) usbcore(E) mii(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) autofs4(E)
> [    1.904797] Dumping ftrace buffer:
> [    1.911038]    (ftrace buffer empty)
> [    1.911041] CR2: 0000000000000230
>
>
>


--------------3712E5C2A23F470317C58012
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-qxl-don-t-allocate-a-dma_address-array.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="0001-drm-qxl-don-t-allocate-a-dma_address-array.patch"

From 083cb816505261e4d9d5c71716295650f8334521 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Thu, 17 Dec 2020 17:36:57 +0100
Subject: [PATCH] drm/qxl: don't allocate a dma_address array
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

That seems to be unused.

Signed-off-by: Christian KÃ¶nig <christian.koenig@amd.com>
---
 drivers/gpu/drm/qxl/qxl_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index d8ecfb8b3193..66640f4947bd 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -116,7 +116,7 @@ static struct ttm_tt *qxl_ttm_tt_create(struct ttm_buffer_object *bo,
 	ttm = kzalloc(sizeof(struct ttm_tt), GFP_KERNEL);
 	if (ttm == NULL)
 		return NULL;
-	if (ttm_dma_tt_init(ttm, bo, page_flags, ttm_cached)) {
+	if (ttm_tt_init(ttm, bo, page_flags, ttm_cached)) {
 		kfree(ttm);
 		return NULL;
 	}
-- 
2.25.1


--------------3712E5C2A23F470317C58012
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--------------3712E5C2A23F470317C58012--
