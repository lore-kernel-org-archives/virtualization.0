Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CB723BD1B
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785984033; cv=fail; b=BlxJ9tKQgiGdrB8uCPCGjx8encIFlj9RJDfJNO4BrXY/RCBiQvEeVE5alcLAE0VL6jyi2gL4eBCo3SGLnr/P/h/FL40Wv34nmmN20pXJH7luJ5bkVqtyLx0xlbXKyC1+YpaMIn0VTSWoxzPYWfZPiV1vbjCV2YWB6VJn1mizDIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785984033; c=relaxed/simple;
	bh=RCvqWvwWzDId4qfygBZgr56kINf1jUQqpAjAr8ns4Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oWtkfxBewXd4NQJ6aCB41PJ0ltQnTaMSkoR/fykpPppIRb9uPLhvLQdDkjkBnDsEuld5E0mZA9fDWc+igDKbi9Xnb2BhvAzyXnG+lVUSg4jgZ1A81hlx0EUZNx6GaSiKgitSeQRujpQCHV3cgQ9eWqg0cEF0qmRQAXtLwQXj6wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h0oGI3vj; arc=fail smtp.client-ip=52.101.57.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h0oGI3vj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IunktAZA6RRL77sSaVUt/o10ymC0i8fslj70KHfcXFLX21/FffTm44pBwYq7Qz9caElFaAIzNMmpGyfOmh93NV2zbo7GCfVeKrkO+NrYb9NHzSbgsBpvvVHjLXvDdT3+vzZ9rmrO7uIDYAuaYBVGGVvrTuEocv3EbhKLA1LIqKrWe5H+u7ladPUxfpp4Hs8t4yDDGjDdqEozvdL9TdAV+wP7Xsb/6KQyEUh9jZEQCt83dS60UyqZOUCuEW/A288W4D6WwFutwWe8uAz4nF2biKXjV+nRZqBoEcp49Weaj/oiAkfKwAQAiFK3p4DfrxoDAFtMQSaAWBkL3UIUHaGe9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjM0LGuK77s6jckgA+JZX719zRkKO6htz7fUnWykKaU=;
 b=BkQep793wvH1jmQq5CEJXZCw8Yu8yrgieG49KaChP082eyiUqbi+kGTwWkDP5XQpd77phVbLYQE6K1Agetlz4dc3b9qJuiDt7ii89RgBnlJOf5UPzzGjsuGu6CZF7Yq27Sq4ZIYvGEUJCRFwTsKhDuzWjbcXpWUdBwHd/Tbyq9bZY6CPZJs0fFv4O7hfTSGOdO8ZAo5s32UI32Yh8v06qGV87UN/9wKeHBUi30ruWONRQhqYvPKs7rkUPDptfZwsPSErmWLLxX4wbsAKNoFpLjGG7KoQJwhxPa+x0t89/x91h49x3NzpZBB9G7jsZFvo4EaDxi5asDr5afKQgsHFDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjM0LGuK77s6jckgA+JZX719zRkKO6htz7fUnWykKaU=;
 b=h0oGI3vjIb+Ag5tuRtonzsj9gif7RSyM5C/HZIrBqxsv2Gaa5Q3BMD52kAIEe88kiufgj97yJZgaLuOUHB0mzpe+VXR1g8/+rUUVfIujZCIGm8RW6jLHiHSwFkCEQXiThs1RPjg+rjLtQQBmKHQFmlN0hXPzwPUJQ7hZeD9eR+86ilzaOKP3yfjryDSRKKTW9uwa5GgFXU+e8OCRMdnr7vF2xF7XWFoQ/amMG+HSYtC/5d2qzDHBFHWEtcTK2K+vEIoMhho2VlTpr9Kc8+qSqyV4Zg1hREGXkHr0HM2yrzp382N3sd5dMH+iWAgoDZvLJ9DM1twCX4ORsOqzW6LJMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5)
 by SJ0PR12MB7457.namprd12.prod.outlook.com (2603:10b6:a03:48d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 02:40:25 +0000
Received: from CH1PR12MB9573.namprd12.prod.outlook.com
 ([fe80::d88f:a143:5f79:c148]) by CH1PR12MB9573.namprd12.prod.outlook.com
 ([fe80::d88f:a143:5f79:c148%5]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 02:40:25 +0000
Date: Thu, 6 Aug 2026 10:40:22 +0800
From: "Liu, Changcheng" <jerrliu@nvidia.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: pbonzini@redhat.com, virtualization@lists.linux.dev,
	changcheng.liu@aliyun.com
Subject: Re: [PATCH] virtio_blk: add use_irq_affinity module parameter
Message-ID: <anP0FimfttCpDMKW@yokbvdiprd370.nvidia.com>
References: <am2QeS/lS+Cova+I@yokbvdiprd370.nvidia.com>
 <CAJSP0QVSBsg0_pCaxy8Sar3=G+sdj5Z8R5yNmUomGy+C5YrHJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QVSBsg0_pCaxy8Sar3=G+sdj5Z8R5yNmUomGy+C5YrHJQ@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To CH1PR12MB9573.namprd12.prod.outlook.com
 (2603:10b6:610:2ae::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PR12MB9573:EE_|SJ0PR12MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e44e9a0-a0f1-49e3-cb0d-08def364119e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|4143699003|11063799006|56012099006|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RMHgKXqy9G1X6PiD/C/JLFwjbYZWB8btEYyss5RpeqzYgIDogXuntLJnWRIX3G6YoKWZJjpyXGLEI/YNmxkt9RXgsMthI2ZB57hcfJfmilmlbA/+D5aCz7uDzDdJnrvhwY0YttHnN3yJ7JkT3Ic/vYrdUIvbYQtKDbBAwt+rNPXUCBpj5UcymaGC+OK46wSLJ681gCkegkrlzUxy7v5D5O7LbtpUKl60R4T4OglUH6AgroU4MdQFuVMrgyd3QGVkK0Y0XK/mZdoIVlKX15k6bGKBWfhi00TAh3egk3XJAPjbKF/bVr2PqOpUhEJpHsWvFbrLRYDf0h7004+YSkyUzmzdd9a2M63bHOYe/pmmQotIbyJiv6HbuEkpwZ9zMXdQYAVWPKMk9t5n4T8D8zYBHuMOLD0ffz6LABUDkSTIsx+ZjozUvE93ZbqyfGlqVsYXXC5RXlj5uOuyMOAt5pbsJlrUcrhxED/mM5wKadQn0ElG9Ktcwm+PYWPYoslqRImmK7j+of/VTL0LN4OEz3kZ8oIMftYrzQRwG9nmMhs+DPlzv7BKXZ8Z7v3SScLXUxzXMZYJWG8mlzIKnsUY0gZ9k7G5u7A1QkQNZj24PbmTdajFEq8mt4+2ON/wMoxLRnc3pUTG5ggSYoQJJcZvaKp7ef1H0TgfMRUCttScFnCzMHc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PR12MB9573.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(4143699003)(11063799006)(56012099006)(6133799003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0FJazJuNnJndXVVNHRkWFBqTU9Oc2FLV1NhS05jS0NDbCtpK3JoNEhSd0tu?=
 =?utf-8?B?aUdQWVFhQ1Y5dzNTTDRyQUNqY1g0d1lHcW56aW9iczVtY1d1T2NsWkdObzVh?=
 =?utf-8?B?NlowZFYrekY3SGFKRElzM3hlLzhvMi8yUjlxMFEzdFAxWTJONmhhbzZaSU83?=
 =?utf-8?B?TG9RQ0k3YTIrR0NucnRtTDFkRkw3dkY2a1F1OHVKNGFPWE9kZTRuU2NsMkJ5?=
 =?utf-8?B?aHpXdGgyNUgyem91b1l6Y25CRG1Qd1J2di9aUnRGUEJGR3FvWUFQOGpaZzhQ?=
 =?utf-8?B?UkhCVFNvTXlxczhDVEJpYWp6NWZoNXliMzMrVW9aa1o2bXFWdStwYjlOL00y?=
 =?utf-8?B?bmdqUjdlWWh5Q3lEemxaaE9lbGNJUW1GSFRvdW51OEp2VjE1SFhrVndZTWUy?=
 =?utf-8?B?bGJMV1BvcGhYL0Y1Sk9mYkp1QSt6T1dBeFMrVlpJWHJEaEZLTjg0c3Q2NDc4?=
 =?utf-8?B?U3Z5UDYrS2hXSUJqc0I3bWNhaXVWR2VCME5ja1dDVVJjVHViUmJpSkhzRVR2?=
 =?utf-8?B?Ky8wdnJLYTRHa1lUTlFUS3ErUlZWOEtMcUNQeElYNkZsTkpNS3g3U3IrZU0r?=
 =?utf-8?B?OVQ0OGlPRzNlZ2dRSW9aRkpVdm9EVU9wWm1zSHJPcEZKWmtBOFI2dUhBaTU1?=
 =?utf-8?B?dENLOVJpeWVIaHJrS2VpaktNSVFXUVlScm5jZDNpUlRaVnJVRjNERWFUZHFm?=
 =?utf-8?B?dGpxZCtaNnVrZ2lWN2huczFyVmc0aE56SFBpWlhuYmgxcitONms4OUpDckhP?=
 =?utf-8?B?MlpicHhsMDlwOVJ1QjU3a3Q1M2d3emdsR09iY0Z4RFNzQitBVDYrUGIvRFc4?=
 =?utf-8?B?SVE0NDJWdldLZTI4c1hMRXozUTlFY1FwbUZOYVltTUU1c1JvWWRkNzhzUkRX?=
 =?utf-8?B?blFhaGcxeld3TjdVOVdNUWdoT2lhdzlyRXFqV1g4dmRtL2tPcTdhcDFRVFlv?=
 =?utf-8?B?SkZ5Zm9nV1VtN0hrTEpOcjhsYTlyRy9sV0ZRU2VuaHBpMmxOYUhHeWNVWWpw?=
 =?utf-8?B?aHRpWkZxSXpMYWZiZmU0RFgxeG9nckZ5cGI3a081RFRqWHAvcHgySFNIbzNC?=
 =?utf-8?B?Mzg5QUMwaldIZmlBK3ZFbDVjanpjWW40NlZxTmcrM2Q5VTc3anhuNFVTOEtI?=
 =?utf-8?B?cnZTbm12Qk50RDJPRy94dW9GZFl1MWxXbW1uamFlcHVrWDRQcjI1Um10RlZi?=
 =?utf-8?B?OEpEU3BwTytkYzRlWXVvc1J1THJhUmNpQk4vK01hZGpjU01RV28vOGl3dFFv?=
 =?utf-8?B?TVdyYVh0bXFGSlk0NFlTWkpWcndnQW9pa1BNZEFOOGNlMlRxMHJzY3Q3Q0I5?=
 =?utf-8?B?emN5Si9nOUJFbEpIdUxLaTFXWHFUUDAzOWhrSUJCUFVLRDByVWdUQzRzOWtG?=
 =?utf-8?B?WVVSNnFIR1RmNWgySHVHdmxiQ25HRXBxNFBpemMrNG1JVEdoRXNqUUp5RE5m?=
 =?utf-8?B?M01sMDdJcTFsUlJrVGVENnVLa2tCSjBzNzlTdXFubG9yU1JYN3FXUHU3OGVx?=
 =?utf-8?B?N3hUOUlWSzI4ZFQrRlRKaENUQTE0SHgxbVJxUkpTZ252VjVxWkpUUjMrMnlw?=
 =?utf-8?B?bHd4UkdyVlpHd3hlcUU4eXBDODdNMWhWZ1d4VDNQM2tKSWI0WmFTWWlRYklF?=
 =?utf-8?B?bVFNNWptS2MreTJJOW5XYmZUSE15cnVEZXoxT0JWSFcxS1FrY094SDJZYlla?=
 =?utf-8?B?OTJiUkxPd09yOWVEajhOZG04dDRPV0tySjQxaHdUNU9FTjlGSGlKd0gwRUth?=
 =?utf-8?B?YjY1cG9ENUtoOEYwa0NuSzNXV1QycEt4bmVzbFNVVDFHTlVWNk5wN0ZYaWlY?=
 =?utf-8?B?NnEwVWJJQ3dTR2RaMERXdEQ3LytqblJqNDBtVGZmTjV5QmVEMEdtRHh4VDV1?=
 =?utf-8?B?ZXpBa01XZWVvQk40RVZPcWhhWCtBVmZ5bzZIOHJ4S1RxaE5kYy9aTk5WOE5V?=
 =?utf-8?B?TjJ5aXorU3JKQWk5ZnczYjlJc25NakNRN0NNWWRKVG9HTzhJYU5leGFlUkhw?=
 =?utf-8?B?ZTdqbXV6Nk9rMnRkdXdiUk5QWVpJNmdOcmN6NGQwazlSbmZ4Vmh4N2Z3b09I?=
 =?utf-8?B?czdOWkJBakFJOHM1RlpFSUxvRWcxSTdvNFVnM3JpaTMvbDVjL0p1QWFoTVBT?=
 =?utf-8?B?aXh0aTJxNG5MSWZ0S1JHUjdKREcybEJsbGJ2ekVBY2pZeDhlVysvbit4UU9U?=
 =?utf-8?B?UDl0WmJsNGlZdThTSXg1RGFDZjFBZWtLWlVwSE55dm5Edk1vRUIwNkRqelIv?=
 =?utf-8?B?bnd0Y1BURlB3bW8yUWJCOE5mcU16SG1mUlJYOHJHTWQ2OEttMVR2VmdDNmF2?=
 =?utf-8?Q?nKIc6ogbj0yWOgFdNi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e44e9a0-a0f1-49e3-cb0d-08def364119e
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9573.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 02:40:25.1839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzRUBBC5aCopG3rJR7BOFOBWxx1MTdKi3IiqgZC8noGYZJwOAVVecFRL+ZK42suZBljtHwj1BuAAoO2TF2l4EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7457

On Wed, Aug 05, 2026 at 01:45:58PM -0400, Stefan Hajnoczi wrote:
> 
> On Sat, Aug 1, 2026 at 2:21 AM Liu, Changcheng <jerrliu@nvidia.com> wrote:
> >
> > When creating many virtio-blk devices, probe starts failing with
> > -ENOSPC (-28) because the system runs out of interrupt vectors:
> >
> >   virtio_blk virtioNNN: probe with driver virtio_blk failed with error -28
> >
> > By default virtio-blk uses managed IRQ affinity, which reserves an
> > interrupt vector on every CPU for each device (about nr_cpus vectors per
> > device). On a host with many CPUs and many devices this exhausts the
> > vectors long before all devices are probed.
> >
> > Add use_irq_affinity (default true, no behaviour change). Set it to 0 to
> > use unmanaged interrupts, so each device only uses a couple of vectors
> > instead of one per CPU, allowing far more devices to probe.
> >
> > Signed-off-by: Liu, Changcheng <jerrliu@nvidia.com>
> 
> There is already a num_request_queues module parameter for cases where
> the user wishes to reduce the number of virtqueues. Did you benchmark
> that and decide the performance of many queues sharing a single irq
> makes it worth adding another module parameter?
> 
> Stefan

num_request_queues does not address this case because each virtio-blk device
already has only one request virtqueue when the failure occurs, so the queue
count cannot be reduced further.

The issue is reproduced after probing approximately 800 virtio-blk devices on
a 64-core bare-metal host. With managed IRQ affinity, the IRQ-vector reservations
are eventually exhausted and probing additional devices fails with -ENOSPC.
Disabling managed IRQ affinity avoids these per-CPU vector reservations and
allows more devices to be probed successfully.

This patch does not cause multiple virtqueues to share a single IRQ. Passing a
NULL affinity descriptor only disables managed IRQ affinity. Regardless of the
number of virtqueues, virtio-pci still first attempts to allocate a separate
interrupt vector for each interrupt-driven virtqueue. Only if per-VQ vector
allocation fails does the existing virtio-pci fallback share a vector among
the virtqueues, and that fallback is independent of this patch.

The new parameter defaults to enabled, so the existing driver behavior remains
unchanged unless the option is explicitly disabled. The option is intended for
environments with a very large number of devices, particularly for functional
device testing.

- Changcheng

> 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 32bf3ba07a9d..184f1c1f4485 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -41,6 +41,11 @@ static unsigned int poll_queues;
> >  module_param(poll_queues, uint, 0644);
> >  MODULE_PARM_DESC(poll_queues, "The number of dedicated virtqueues for polling I/O");
> >
> > +static bool use_irq_affinity = true;
> > +module_param(use_irq_affinity, bool, 0644);
> > +MODULE_PARM_DESC(use_irq_affinity,
> > +                "Use managed IRQ affinity for virtqueues (default: true)");
> > +
> >  static int major;
> >  static DEFINE_IDA(vd_index_ida);
> >
> > @@ -1016,7 +1021,8 @@ static int init_vq(struct virtio_blk *vblk)
> >         }
> >
> >         /* Discover virtqueues and write information to configuration.  */
> > -       err = virtio_find_vqs(vdev, num_vqs, vqs, vqs_info, &desc);
> > +       err = virtio_find_vqs(vdev, num_vqs, vqs, vqs_info,
> > +                             use_irq_affinity ? &desc : NULL);
> >         if (err)
> >                 goto out;
> >
> > --
> > 2.43.7
> >
> >
