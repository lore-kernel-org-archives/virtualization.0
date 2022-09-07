Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7714C54EE9
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 14:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E48760C1E;
	Wed,  7 Sep 2022 14:08:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E48760C1E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oLfjaVOt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HYwXZ78bFA0k; Wed,  7 Sep 2022 14:08:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B85B760BDC;
	Wed,  7 Sep 2022 14:08:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B85B760BDC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90B4EC0033;
	Wed,  7 Sep 2022 14:08:25 +0000 (UTC)
Received: from smtp4.osuosl.org (unknown
 [IPv6:2605:bc80:3010:0:a800:ff:fe79:d16b])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CA60C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 038F440170
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:08:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 038F440170
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=oLfjaVOt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ujXUpKpwHGrR
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:08:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD2714014C
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD2714014C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:08:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6XFdTlQs1l5e9Q2zcK6DAFMk25wuHEmu4sJzz3v8OJPJufxDb4zftNIgYahsg7y0Pu7oRAVVhLKvKzo9XYLqKh8p9J0uq+zbXvQMXRYY1osVoAtzkD9JcBoypXJ9xvjM/UFj+o/7sjH/yhSDm3JX/bbObJS/QAq4pEDKS0HgVap8D1e9o0u876oYnM0+DSoBrVlhyBdQYtM3gPIxbcYyklX+5sw+myf4suqT1pGOzwT46wdm28IixVKq4Fs6oM7KdfMNqCnCOofganRSz19S+LDoUW0MvEL5VzsPBTe3l7oKQixD96Or3Ju6utshf2sR9ABQGaH6GQPPn24iAjvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0NYUwPPE3J+I5XrzhGpRJslgDkz4YIMMpB4woWZXpc=;
 b=PdVc5yVgMI/vYi5sJmSuY45NSqWKjjPzZCcdbD8Fvc1MY1vMQp8hrnhHf7YZce0xkR/za9QHwnQMwikvQLqxT+gtAiK+EYem3d3xE2AMKWc6ILZnnaLjhBNq8FrH+xaY+NucWzsl5Hm9NPI/sJjnVRiOAwO5/D7TrioSVrvTnM6NzkcObCeEUl8AW1GyOLB79HKac4UUA+5Ptzpd404iSh9CHCLxmNr+KeAbtvSCwbYSLaSBk+6IO8T0++c4emNIL7osUZgRUM6djo4giQc8OKibLmE5+xTj6jfX5Q0rRt5gTu9FxDuve21j+YpMMQHnDFhduuKZK89hdAkWQWoy6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0NYUwPPE3J+I5XrzhGpRJslgDkz4YIMMpB4woWZXpc=;
 b=oLfjaVOtGOUshk2Wo9rdUefMTtpfQieFRkfa34s7V+4u3mgUVgyBBSl51WEzC4pVdnIegmOe0FQOMjgmH5Xj9ewURlyvplYDpHjVSU9mpJgQOHUNXS8qLZ/jU50lgCBNp0hMpMmhLikMPjNpmaJh/iqCmlQCfde/gCsc1vtYFU+wyvDNuiR3Ua4dk8T4E7taXmgoglZ7QlPcB1vRgpuFEZI2vi5RlhX4Q3sVvt/cmekw6rIt3sKtLs5/7esyMCsiDyJNtn3KMB0kIE+VyhYTrB37lNlI9HeofZ+hEWGH0x2v2F6UBpAZTp3XoVDQkAwIYEk/QdxGqR2mt+xeSwMASA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 14:08:18 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98%9]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 14:08:18 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>, Gavin Li <gavinl@nvidia.com>
Subject: RE: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Thread-Topic: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Thread-Index: AQHYwpEbqLdY6RByfkyoSMo8wpA6EK3TsrMAgABG8oA=
Date: Wed, 7 Sep 2022 14:08:18 +0000
Message-ID: <PH0PR12MB54812EC7F4711C1EA4CAA119DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220901021038.84751-1-gavinl@nvidia.com>
 <20220901021038.84751-3-gavinl@nvidia.com>
 <20220907012608-mutt-send-email-mst@kernel.org>
 <0355d1e4-a3cf-5b16-8c7f-b39b1ec14ade@nvidia.com>
 <20220907052317-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220907052317-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB4204:EE_
x-ms-office365-filtering-correlation-id: c5d87e58-3286-4ad8-abb5-08da90da6a64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q743QZIG2hXUChwKkxE1VGahiQO1r9OuoyVHiA1igRxCx/IJqiDBnmXMsaLOIqeordvKAWvYrfx2vBs8vTemOue7qml30rfNx/5sEvaUzy5b7xwIybtL3NRONj1A8B997nWwYBSpCstSAORniZeJcTMQRF1QFP+t6wpuFS6n6qhVy6MV8kF/8VURM80QFxyiJa5adwmqdeRKSLbNURJP+Dzl7nk4ouTBSU9PErdL/+eJfPeDaUPhfPz/Di8QpvgjOQ3u3fnlZIl3qcpctFmQd7tCncIaOm0eXKubw61ifWDtUYIt1xuihqSXV347hzgGOfk6RTc+6dBjoBixC7j1XRBY/498s7WjHQiST4czJgnVCGWL4k9pOMxos7aH7oJZeYRu2ig0e7GoCbwwiSsiakLT37p+7oXMb+RyuSVAOpvs8VSiVbWOTEEgJH4uwrbcWzzIjenyRUTl9Y2/9poAcjfJq3YqBAUVFWYbxv61D/9E9NcT2gSJ8EP7FCCefmLnPB08WnFbva3xnFQa3cRM3cHsn5C66X078mNsE7dyVpS/cVeN01HIScVw4AGD4J9ACp6/5ZgXoOVWV3cghsV3Iu4BCeATjzQziI5KWCYppmdm5Zk9DcMGIui4K+WAOL8QU6phBeeN9JnT1bpuQn2ZOL10I467OngBDpVwcOXA0nQaKoU9sFznEbrqhFLp6FrfWnPIhv3MbO/wPP3pg+yk6LsJGO3rT+xyeLQsLwioMKf15A9woHlCVCrdK2f4atyd4jDjImsPD6ct8bh5uTcrAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(83380400001)(76116006)(38070700005)(316002)(54906003)(122000001)(38100700002)(55016003)(66946007)(4326008)(8676002)(110136005)(2906002)(66556008)(64756008)(66446008)(6636002)(66476007)(53546011)(52536014)(9686003)(7416002)(186003)(26005)(8936002)(5660300002)(71200400001)(478600001)(41300700001)(7696005)(6506007)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7MZgQLKj8uJ2qhIbF94cnPN4dTFxF57JocW+Jwu5AozOoEAOT8IFxEAxPD?=
 =?iso-8859-1?Q?ZmxWSZjy5oP6d9YgjjqSERAsXfqWOaLOg+zOOhnTqWXdWluqfOzoblDzk4?=
 =?iso-8859-1?Q?X8p7gA5JHj9Ik6fbJPkpM5ftzhtErL9k12JCWNnKza1iIRns4myvAjyX3v?=
 =?iso-8859-1?Q?fQi1o3X5p8t2fM6oWqnm8TXuVLGaXhfjiPXd9/ulXe2VogeD4roJfbdit1?=
 =?iso-8859-1?Q?5JqRON90j4cu7rL0J8G3qbLD5qdxmBii8HyM2/TuLn8lmZM1yok6lw4sW9?=
 =?iso-8859-1?Q?jCedqHK/GyYKJZxI5+UeN+QOmnFlElzacA3YlbjRO/3KBNzowt3xzy6FP1?=
 =?iso-8859-1?Q?XFUuVWGdu0JpWMLdGtamxTnejlTvtMv853yBDYLmWd66aOcG87scPlO1W0?=
 =?iso-8859-1?Q?VcRjikOCF7jhbjyBZXcNvYrHqpXg03w02Ye8jATBvD9RdC/erGhN39azWU?=
 =?iso-8859-1?Q?xnIhfk4f5DXtwUd0FpDYP/vHvvdiCShw2WhpqrrSrWm5OrtGfkAlIwL0g8?=
 =?iso-8859-1?Q?ltA1UIb++PHc9LPYth6RAEumIAGnJIE9FCdu8UTyyH9vm5xKo8SmeU7Jfd?=
 =?iso-8859-1?Q?TSXLMFsUkAUPMPLlCXmBkNTH14RimRe+MoCdp+q3RMIp+5FBp6xnVWEOR/?=
 =?iso-8859-1?Q?i7A+Izic8t8Gcaxeup6kDHe/2AFCJLJHArHb1olv7EstO7DNOvzhOeSgX8?=
 =?iso-8859-1?Q?AyGVL0dSpXkDlHSqivD07ehebuJxL7GxwyzASZPQmOgIM/j5/Qf5+Gz9ZO?=
 =?iso-8859-1?Q?DPIvQjBD/7QCf6Ze/a+46C9BCCqXzgowLpLxv6pVWmlfThYMi9al0HcO36?=
 =?iso-8859-1?Q?CljWJjATTxIP4KHUGsGRcCaj6adQgtQX25JQlXSoF0A3pYoHA4HE55O/Z1?=
 =?iso-8859-1?Q?pJehCqnjv95m5gim0451WPqtP7VLEKNtxdNhKr12kWtBXGUgjmnJgA68Yc?=
 =?iso-8859-1?Q?o6tpLDrG0FTLxWcMwKSIILi0WE2jmcTVnK2kXs+E6TDKGaAvqPBx95QTeU?=
 =?iso-8859-1?Q?rBMn6Lx6ZWB9jDQWHwWW6DEP57a8sXOSwFKhSYof3nP9SEaptyij93Cwjv?=
 =?iso-8859-1?Q?0a9TSk0D27VD4P+AgrE+1XXAipQ1N/V61RTSZ6P4b+fHXjF38OJmWT0iXp?=
 =?iso-8859-1?Q?9v5RzU8/DUSr4cnwGmO14e9owc48XZB+o4dm85azZVFPj3K8TwGnw5Zdww?=
 =?iso-8859-1?Q?JjFJMnszCdqN8fFl2JF/yBwVTwTDhG9Cm5GQUuW8PfOPV4FQcjqvuSQEyi?=
 =?iso-8859-1?Q?N6ScC8WAhZJeyiQRnXMC6j3kypUKhEULnXHx5SZX3GRETCGW1dkUavdEr0?=
 =?iso-8859-1?Q?LRdBnTg6jbcWDKjNuoLROhq/pvtElClYlSmFW5lFV+CCPfSmyAZalmYcmV?=
 =?iso-8859-1?Q?PdqSM5s5I1tKxLEgkCqoTTAsWFeBaYbM8h0260x9HhyLYTql3/d5ZJ8fKR?=
 =?iso-8859-1?Q?O0OtyGLWppd4LN9vu4uW+dOG1u13btqynwhOfaJ3oVO2725kiLEPLednwB?=
 =?iso-8859-1?Q?bWXGZXTw76kDwQxSuiWKYygtqid2/ryn7Z9pZqsg/N+Qf+a3uy5xaz3tuu?=
 =?iso-8859-1?Q?kDlhhOWP8JuPBKkOw1V/VHR0s+gkuKEq5i6QuN4Kf0nmDfvhVnAgLNZqZy?=
 =?iso-8859-1?Q?j/tw1nAs8jUKQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d87e58-3286-4ad8-abb5-08da90da6a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 14:08:18.8443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l+WxR6S5nVmr+eoS3Wb6L3PZdoMeRQgGStLRZ/COmbm2Xmwafdo4jQGpbeokhMle3ZNAe8XRmjTCP3QHWkIj8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, September 7, 2022 5:27 AM
> =

> On Wed, Sep 07, 2022 at 04:08:54PM +0800, Gavin Li wrote:
> >
> > On 9/7/2022 1:31 PM, Michael S. Tsirkin wrote:
> > > External email: Use caution opening links or attachments
> > >
> > >
> > > On Thu, Sep 01, 2022 at 05:10:38AM +0300, Gavin Li wrote:
> > > > Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for
> > > > big packets even when GUEST_* offloads are not present on the
> device.
> > > > However, if guest GSO is not supported, it would be sufficient to
> > > > allocate segments to cover just up the MTU size and no further.
> > > > Allocating the maximum amount of segments results in a large waste
> > > > of buffer space in the queue, which limits the number of packets
> > > > that can be buffered and can result in reduced performance.
> =

> actually how does this waste space? Is this because your device does not
> have INDIRECT?
VQ is 256 entries deep.
Driver posted total of 256 descriptors.
Each descriptor points to a page of 4K.
These descriptors are chained as 4K * 16.
So total packets that can be serviced are 256/16 =3D 16.
So effective queue depth =3D 16.

So, when GSO is off, for 9K mtu, packet buffer needed =3D 3 pages. (12k).
So, 13 descriptors (=3D 13 x 4K =3D52K) per packet buffer is wasted.

After this improvement, these 13 descriptors are available, increasing the =
effective queue depth =3D 256/3 =3D 85.

[..]
> > > >
> > > > MTU(Bytes)/Bandwidth (Gbit/s)
> > > >               Before   After
> > > >    1500        22.5     22.4
> > > >    9000        12.8     25.9
> =

> =

> is this buffer space?
Above performance numbers are showing improvement in bandwidth. In Gbps/sec.

> just the overhead of allocating/freeing the buffers?
> of using INDIRECT?
The effective queue depth is so small, device cannot receive all the packet=
s at given bw-delay product.

> > >
> > > Which configurations were tested?
> > I tested it with DPDK vDPA + qemu vhost. Do you mean the feature set
> > of the VM?
> =

The configuration of interest is mtu, not the backend.
Which is different mtu as shown in above perf numbers.

> > > Did you test devices without VIRTIO_NET_F_MTU ?
> > No.=A0 It will need code changes.
No. It doesn't need any code changes. This is misleading/vague.

This patch doesn't have any relation to a device which doesn't offer VIRTIO=
_NET_F_MTU.
Just the code restructuring is touching this area, that may require some ex=
isting tests.
I assume virtio tree will have some automation tests for such a device?

> > > >
> > > > @@ -3853,12 +3866,10 @@ static int virtnet_probe(struct
> > > > virtio_device *vdev)
> > > >
> > > >                dev->mtu =3D mtu;
> > > >                dev->max_mtu =3D mtu;
> > > > -
> > > > -             /* TODO: size buffers correctly in this case. */
> > > > -             if (dev->mtu > ETH_DATA_LEN)
> > > > -                     vi->big_packets =3D true;
> > > >        }
> > > >
> > > > +     virtnet_set_big_packets_fields(vi, mtu);
> > > > +
> > > If VIRTIO_NET_F_MTU is off, then mtu is uninitialized.
> > > You should move it to within if () above to fix.
> > mtu was initialized to 0 at the beginning of probe if VIRTIO_NET_F_MTU
> > is off.
> >
> > In this case,=A0 big_packets_num_skbfrags will be set according to gues=
t gso.
> >
> > If guest gso is supported, it will be set to MAX_SKB_FRAGS else
> > zero---- do you
> >
> > think this is a bug to be fixed?
> =

> =

> yes I think with no mtu this should behave as it did historically.
> =

Michael is right.
It should behave as today. There is no new bug introduced by this patch.
dev->mtu and dev->max_mtu is set only when VIRTIO_NET_F_MTU is offered with=
/without this patch.

Please have mtu related fix/change in different patch.

> > >
> > > >        if (vi->any_header_sg)
> > > >                dev->needed_headroom =3D vi->hdr_len;
> > > >
> > > > --
> > > > 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
