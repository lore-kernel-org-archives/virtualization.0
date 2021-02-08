Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E84FC433DB
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 19:40:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E42864DDD
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 19:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E42864DDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B5209214EC;
	Mon,  8 Feb 2021 19:40:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ptrCmzoWaelt; Mon,  8 Feb 2021 19:40:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 67DDC20468;
	Mon,  8 Feb 2021 19:40:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4556DC0174;
	Mon,  8 Feb 2021 19:40:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34B7FC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 19:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2298C87119
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 19:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mJ6NqNYi0l-c
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 19:40:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2109.outbound.protection.outlook.com [40.107.223.109])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6C9F28708F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 19:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLflB/X575lkqhJWO2A1wOzLB4ssh+Zg4YCYcR4D+X44GLcwSCxWe/vDbpOqDNYN8Gokd7K2dcbru9dO5DydkV/HaYKZ4/7WCDuR+MSfZMDFzNVCtiqC2J8vji/EntyYS1BW6R2JlP9pFJoMV2roHGRRRmkuKQNCpjiD4FrLlgfsvy71QPscBYWb/poEgp7uzYe4q6LNpdHT/kqN6D5ykwt8n9DDT1fcUdEtDRUoYCGFjM8kbQxtbVhJKAxBB0gcJAxr1ojg3JJRSaVeDi+btVLFzUCXy9eKkjPXNJCuHQx8d12aZrZLqrxNWD6O//iTh0JoB3yk01F9mAtk/TPJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xR5I4HzABbKWAAYgjuiM6N3g88DUNSRVGH8J6HuAqWM=;
 b=F6AvFuJynikARGL2wF8PlBIj87im1+7OLhc10ijYIycEeh74o5N+cxsll8Azz6DnuyGIXVbz6/f8swdIkFrC+LdZ4h+MvMkaGS6sL1goNweB3zu41EvpLKK+D6LNM2bQl3NaTBN0QtxS71kbOZECQ2K328IPy+UjY3g5tU4lE25NYMgf/9db57Usj9Vso21oWn1Ob1h0SpZWOZtDZ9ExzEOHJoSo8VTWY4JAxB29XorqV4/ylTxKlwzxifTZSIVFrXqDV/Mv9WOn46J16maQEQCNFrdA/fWTslXDEjVVJETnyxrQReN5nIPHIbHwY00L9UHMzwRll/p2EhnMKjh3pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xR5I4HzABbKWAAYgjuiM6N3g88DUNSRVGH8J6HuAqWM=;
 b=SCYHYrTirQ8ZH9VmCm5vHXGM5KL/S1MQdFF87YdRUKMPXQXvBDfKqa0zpyfoQgxRtFL3TFcplKH/2AcirkvVaqOHc3i1y+5X2lpoOJPRyVHzrOq+YWcy8Em2ZYZhg1YzY7gizMVaihw/dEpRxX5Cm8NxgVr8E7PVnNZJw5UK7po=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1890.namprd21.prod.outlook.com (2603:10b6:303:64::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.5; Mon, 8 Feb
 2021 19:40:34 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3868.006; Mon, 8 Feb 2021
 19:40:34 +0000
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [RFC PATCH 00/18] Microsoft Hypervisor root partition ioctl
 interface
Thread-Topic: [RFC PATCH 00/18] Microsoft Hypervisor root partition ioctl
 interface
Thread-Index: AQHWv52RzpNHORzDhkSH9WyLC+YTBKpPFSuQ
Date: Mon, 8 Feb 2021 19:40:34 +0000
Message-ID: <MWHPR21MB1593320EC0EFAD45DA50E1A9D78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-08T19:40:30Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=66e485dc-965a-4202-9ad4-916a574f3556;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: feffa7f6-7e86-4a59-a9e4-08d8cc696725
x-ms-traffictypediagnostic: MW4PR21MB1890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB18902711C68B17BB5A82FADED78F9@MW4PR21MB1890.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j/NuTxYSRfOscJc1+xOoVmAPYLEd6wm7Bvo6M2NM4x3oCwHZE5jRsJprHprdI4igqC/JxT0aBImxTfhu+a0jBMfWtzilIZmL0mSJfKx54xzEXPm/tc37aKqWIS+uSVd4W+jqZJreA22sO3aDuRMhBEpWl0xIxAAa+1qaK27uN+PXxV8sby+29isOYoPk207hUTGVn9TuaWEvDir2SVNVvZ6yCCNBC+g/S0gQOReyJIlbDiN/rGyRi5A4b7cGYbkK0bjv73rEiiGzR3Lpkwcp+Z5kwPw1lFuwyIDBVQpavydJcdSNqPz027aX+pI+J0y6dME6LmEJU8v4O+HXGWiIKOV6jg3KGzJhk8y17scmIrbvaKeHzrmee9A2I393UltQwcTkPuciRB45ppErvGDW0dyitAKrNV7FRTJhh2f/VV9TzpJPTKYPCsp+mtyFFn6s9EDlcN0pHCeYN9Ep/1GCTg73DPfsYJE0NEdQm8Ijpja5kkChucKqh+xvcYK9ebOH/6OZ6EXz7wWRGncLR8PuzDh4h2GbVPSkNWcpN+WwieWHeOwssWmjyM/3LAkLuPuDdev9iCFqIqefVqBBDgxXkk+8njK9FSuo/834jWYMWbc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(47530400004)(66446008)(8990500004)(966005)(66476007)(64756008)(186003)(83380400001)(8936002)(66556008)(33656002)(478600001)(2906002)(66946007)(52536014)(82960400001)(76116006)(7696005)(5660300002)(316002)(82950400001)(8676002)(107886003)(9686003)(55016002)(6506007)(110136005)(26005)(71200400001)(4326008)(10290500003)(54906003)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ej9rPf/vvnBpA0wqlZbiw9sD3cXKy6rnWoyYPFLJG+912BZKoAVI0WULuIdb?=
 =?us-ascii?Q?H6f4AK57QJLVYGF24VKEW2A/j37BJVhjw2A+gbyeZcZ8bmcZPcqN+cZfJh09?=
 =?us-ascii?Q?6An3D1RlSsXDAOCZtDC3A5tKG6JAZWfLdtYIlB/wLEVEx/mlg3zvVIBjMAhb?=
 =?us-ascii?Q?h/EbcH18Cpg0IZ7ZGwH6jxVoCFiPGzFsLiFg9nSWhNPDeQFlk4mo5Uj5P6gj?=
 =?us-ascii?Q?sgm/pLcmE/I/nwQjQ67IqlorpDO+TvUcNyNKmFFGFfp7s8oQwyJ/5Mn4CQrO?=
 =?us-ascii?Q?tzvKgWh2huzhmXZKj4hb6i9rOe+er7ViY0kn9b9IT6hjKZmLKSzdN4fnwevm?=
 =?us-ascii?Q?mv2WRca8C7HjxRh4hAAk7LEfvULZf/SN4BHVQ5JCDdtYAwaWPc61HOldJ8C5?=
 =?us-ascii?Q?zy0bSjHAVriugv27BVVb8tKXw7F2iqt+lAcvwIRE9bQ75ngo0NJ/OPdglYCA?=
 =?us-ascii?Q?OjKRCaZn7d3+fk5i/OeEu5vrIS6Rkqpes7Y2ecRdnDxQxP87nmf7Qab6sVPC?=
 =?us-ascii?Q?V71h0IVT86Soby7dXRso2aGyk4HfHoIbI5OqIeJeWsQqXxlamuD6Ic9/t0UE?=
 =?us-ascii?Q?VU/g3vL1+yspZokXY1BaLVOJU2o9jUIVECvcROtC8TSNx7bQYx1Hswx4CjDF?=
 =?us-ascii?Q?blYKurhLWyajt0cIoSjx5g8K135QpY66czheW+r8gsFDRz1KMF7Ph2+2Ftnf?=
 =?us-ascii?Q?uD8QdpWoSO7UZRApyx310ctoqix8tb5mCS77UpR0YfUe4VlI6+dLNJWaKBsp?=
 =?us-ascii?Q?HiGHrZoJ8VaY3Vj5fdBqoV5EaH0jbruyQrkbSe3NihKaa2NyRiV7IvsMvZ/F?=
 =?us-ascii?Q?UqCUadqJZZgnOmVdzgha0aNuVXgpSlo3DtHaqGsLRVud6UfPBWJ2ydMdGYXf?=
 =?us-ascii?Q?bEbvSEbR0ye8pYjGQoU90lDrmujqww1WBj2LBRTlPfOSFRLt5JDt+1fkEyiQ?=
 =?us-ascii?Q?tQF9fCRRd5VkuFkOqg930D4+GHv7djXZo/ep01DikxEwq9gin98kk/qWS3u/?=
 =?us-ascii?Q?Dtw/+d8Tkbw+b8tAsj6bl/PUv1QlqvFXmbT2s6/PfmmNjchudBhyqOx7y89S?=
 =?us-ascii?Q?jM/SolJUHOZ0t0EcJhwJG7+wirrcBkL/lrqPG6hayqg282hQLnDRp5e+R7a4?=
 =?us-ascii?Q?4Z+6673IQsaukksSLRI5RoEHeilaX5eg7q7KQB+X9n44tUPU6cszyhO/WSMz?=
 =?us-ascii?Q?YmbBrz9oc6NBReqJpBX4ggYJfu8v+nOZhhKsOhtFFaMAK3vKPGWUV2CSruQe?=
 =?us-ascii?Q?mjQXQo8cvwlQithPVp/b9JAatOVD+Ubq/EnrlQ1uHFVPXiuzXCtolyv3s8od?=
 =?us-ascii?Q?OGXMQrEFLZSx54npZ+rGz+CU?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feffa7f6-7e86-4a59-a9e4-08d8cc696725
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 19:40:34.5959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+wfyTJv9c2XUsQqf89Qfc4LzcQBnEEMT+hl8F/TOB4EnePrNUd2+OWi95StQlKP6I8LHwJcCarkHjHBHmzktgOisu8NB0uVWngs4pwYaHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1890
Cc: "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>
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
From: Michael Kelley via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, November 20, 2020 4:30 PM
> 
> This patch series provides a userspace interface for creating and running guest
> virtual machines while running on the Microsoft Hypervisor [0].
> 
> Since managing guest machines can only be done when Linux is the root partition,
> this series depends on the RFC already posted by Wei Liu:
> https://lore.kernel.org/linux-hyperv/20201105165814.29233-1-wei.liu@kernel.org/T/#t
> 
> The first two patches provide some helpers for converting hypervisor status
> codes to linux error codes, and easily printing hypervisor status codes to dmesg
> for debugging.
> 
> Hyper-V related headers asm-generic/hyperv-tlfs.h and x86/asm/hyperv-tlfs.h are
> split into uapi and non-uapi. The uapi versions contain structures used in both
> the ioctl interface and the kernel.
> 
> The mshv API is introduced in virt/mshv/mshv_main.c. As each interface is
> introduced, documentation is added in Documentation/virt/mshv/api.rst.
> The API is file-desciptor based, like KVM. The entry point is /dev/mshv.
> 
> /dev/mshv ioctls:
> MSHV_REQUEST_VERSION
> MSHV_CREATE_PARTITION
> 
> Partition (vm) ioctls:
> MSHV_MAP_GUEST_MEMORY, MSHV_UNMAP_GUEST_MEMORY
> MSHV_INSTALL_INTERCEPT
> MSHV_ASSERT_INTERRUPT
> MSHV_GET_PARTITION_PROPERTY, MSHV_SET_PARTITION_PROPERTY
> MSHV_CREATE_VP
> 
> Vp (vcpu) ioctls:
> MSHV_GET_VP_REGISTERS, MSHV_SET_VP_REGISTERS
> MSHV_RUN_VP
> MSHV_GET_VP_STATE, MSHV_SET_VP_STATE
> mmap() (register page)
> 
> [0] Hyper-V is more well-known, but it really refers to the whole stack
>     including the hypervisor and other components that run in Windows kernel
>     and userspace.
> 
> Nuno Das Neves (18):
>   x86/hyperv: convert hyperv statuses to linux error codes
>   asm-generic/hyperv: convert hyperv statuses to strings
>   virt/mshv: minimal mshv module (/dev/mshv/)
>   virt/mshv: request version ioctl
>   virt/mshv: create partition ioctl
>   virt/mshv: create, initialize, finalize, delete partition hypercalls
>   virt/mshv: withdraw memory hypercall
>   virt/mshv: map and unmap guest memory
>   virt/mshv: create vcpu ioctl
>   virt/mshv: get and set vcpu registers ioctls
>   virt/mshv: set up synic pages for intercept messages
>   virt/mshv: run vp ioctl and isr
>   virt/mshv: install intercept ioctl
>   virt/mshv: assert interrupt ioctl
>   virt/mshv: get and set vp state ioctls
>   virt/mshv: mmap vp register page
>   virt/mshv: get and set partition property ioctls
>   virt/mshv: Add enlightenment bits to create partition ioctl
> 
>  .../userspace-api/ioctl/ioctl-number.rst      |    2 +
>  Documentation/virt/mshv/api.rst               |  173 ++
>  arch/x86/Kconfig                              |    2 +
>  arch/x86/hyperv/Kconfig                       |   22 +
>  arch/x86/hyperv/Makefile                      |    4 +
>  arch/x86/hyperv/hv_init.c                     |    2 +-
>  arch/x86/hyperv/hv_proc.c                     |   40 +-
>  arch/x86/include/asm/hyperv-tlfs.h            |   44 +-
>  arch/x86/include/asm/mshyperv.h               |    1 +
>  arch/x86/include/uapi/asm/hyperv-tlfs.h       | 1312 +++++++++++
>  arch/x86/kernel/cpu/mshyperv.c                |   16 +
>  include/asm-generic/hyperv-tlfs.h             |  324 ++-
>  include/asm-generic/mshyperv.h                |    3 +
>  include/linux/mshv.h                          |   61 +
>  include/uapi/asm-generic/hyperv-tlfs.h        |  160 ++
>  include/uapi/linux/mshv.h                     |  109 +
>  virt/mshv/mshv_main.c                         | 2054 +++++++++++++++++
>  17 files changed, 4178 insertions(+), 151 deletions(-)
>  create mode 100644 Documentation/virt/mshv/api.rst
>  create mode 100644 arch/x86/hyperv/Kconfig
>  create mode 100644 arch/x86/include/uapi/asm/hyperv-tlfs.h
>  create mode 100644 include/linux/mshv.h
>  create mode 100644 include/uapi/asm-generic/hyperv-tlfs.h
>  create mode 100644 include/uapi/linux/mshv.h
>  create mode 100644 virt/mshv/mshv_main.c
> 
> --
> 2.25.1

I finally made it through reviewing this patch series.  Nice
work -- to you, and to Lillian as the original author of significant
portions!  There's a lot code, but it is well organized for reviewing
and overall is done well.

I have a three general comments:

1) Historically we have very precisely specified the layout of data
structures that are shared with Hyper-V.  Each field has an explicit
width (i.e., u16, u32, u64, etc.) and we have avoided field types that
lack an explicit width (int, enum, bool, etc.).  These patches make
liberal use of enum types in the Hyper-V data structures, and I saw
one occurrence of bool.  While treating enum and bool as 32 bits
works, I have a concern that such specifications aren't consistent
with the original rigor we tried to use.

Related, there are several places where the proper layout depends
on the compiler inserting padding (and not inserting padding in the
wrong places) to achieve the needed alignment.  In my view, we
should be explicitly adding the padding.  A couple years back at
Vitaly Kuznetsov's initiative, we added __packed on all the data
structures to instruct the compiler to not add padding, so as to
prevent padding being added at any inappropriate places.

I started by flagging all of these places I saw either of these two
Issues, but I stopped doing so in some of the later patches, figuring
that you could find the issues across the entire series.

2) With all the new hypercalls added with this patch series, and with
Wei Liu's patch series for Linux in the root partition, I've noticed that
we're inconsistent in how the hypercall status is checked.   The
current code works, but is sloppy with types and doesn't always
conform to the letter of the TLFS.  Your new hv_status_to_errno() is
a nice addition, but I think we would be well served by using a 
consistent pattern.  I'm planning to send out a separate email to
the linux-hyperv mailing list with a specific suggestion that we can
all review and comment on.  Once we have agreement, we can do
a cleanup exercise on existing code and on recent patches.

3) I've flagged a few places where the code does not handle configurations
where PAGE_SIZE is other than 4 Kbytes.  While this will never happen
on x86/x64, it could happen on other architectures like ARM64.  Of course,
we may never want to run Linux in the root partition with a page size
other than 4 Kbytes, even on ARM64, so I'm OK with not fixing all these
places.  But I've flagged some places where HV_HYP_PAGE_SIZE would
be more appropriate than PAGE_SIZE (and similar) and I think it makes
sense to fix those now, if just to express that the usage is tied to the
page size used by the Hyper-V interface, and not the guest page size.

I'll also send replies to many of the individual patches with specific
comments embedded.  I have not given "Reviewed-by:" on any of the
patches since they were submitted as RFC, but I can do so for a few
of the patches if that would be helpful.

Michael
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
