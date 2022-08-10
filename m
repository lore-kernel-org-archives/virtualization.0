Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFA5C25B07
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 17:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A2FD610FB;
	Wed, 10 Aug 2022 17:06:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A2FD610FB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dJzqniiP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gNxr0RqezyxA; Wed, 10 Aug 2022 17:06:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CF23960B5C;
	Wed, 10 Aug 2022 17:06:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF23960B5C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5C14C0033;
	Wed, 10 Aug 2022 17:06:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC7C6C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 17:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F61D610F7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 17:06:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F61D610F7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dYs5x6sgMpap
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 17:06:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4456460B5C
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4456460B5C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 17:06:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDyB5YACkhyMihd07gssQWMIYBGjhrO6Zye8U+HzUbMKtNhw1I+gujRvK8GlLGTr7LBWmA9dZ87d+SMuEOMMwJsmi1I2jm3e4DGEwfwws4BFiJ7CVFkAJm2h/+MdJot9vQlZxQIwbI9UQb4rfAyFAEzjIGvTGz8FnFX/+S7ZOh/+NYsuA3zPMFs/u3Ih8J6mISay/mhfVbyi28K3gja2ACb6zq8gHoRHSiS/o9mFFoRxTRAoCaUVvoi79oakTD/immbqw23Rh0YGL3q4fG4rjzNHB5eUVCBOrZaKo5AuNcTKl/nIuC5pLYVPS8wmRya5LIIV78LWLV9JqToY5rVrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDfFXvb/mCwSa+wsMgdd1GzYQiWdLilAtwS1rQm1vAg=;
 b=B7Jb3n0+e/SpAfxgbntlXfVVAyLUG9xlJXgP9eZIKg4+zZax5SF83PSDWn9AI4epkPSg7qdW8gXAfgKJoAYGTsIMjJMi9MkSndOBur31l9A3kT4Q4q0+y7YjqfIPSYFJU0JNsJCKwiKexX1YkxRQfBqOIk7w0DPfNIDWzEHiMJBkZMBjgH0lW9DM9I59NxG+Zpnx8bpjIGKa88kEoV5hdoV+lAw3w3FcKK0HGKWp1QrjjgFBym7qCzlyUl5kc8jXDEAGx3/4dsa8ZEaosdbZzF8xXhqUgw16bSEoG+9vND8qAcHIaWzmwq1XnqXFb9Ez8Mtv2pgDhX9d08b3gtdsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDfFXvb/mCwSa+wsMgdd1GzYQiWdLilAtwS1rQm1vAg=;
 b=dJzqniiPN05YeMNPOHNPCMEvCzERs0P3JOhRKhUL8vaC6PciR4tGfs+gtlVGFVeRNR6cCQZBXIqxIyUgof44mcjY7LTnsSy1PV5jSCybn6+ZsmsgtIl0LjVlsW9vHTjwiZTmW0Zb6ljYNrbE+ym+2e5gdJoufJQNBS7bjqYjVdP4Okjs2BIaOT7x6En5Ehk2heINKywcwDmMQuzNooMEmHgELXYIrVdyliUpvmDNe61Z3mY0xNGwW0HmJec0dFvoBfnD65twLEJRfzYDDawlVsbrQeKVyrT4uPZt1mBAAqNW6W+W94NfoT0YmnN6VAgAEw5nqdekuRJ+RpbcxU7sfg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by MN2PR12MB2926.namprd12.prod.outlook.com (2603:10b6:208:10a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 10 Aug
 2022 17:06:33 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::957c:a0c7:9353:411e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::957c:a0c7:9353:411e%5]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 17:06:33 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Thread-Topic: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Thread-Index: AQHYpirEKDhT8iEHv0Wl5fiZieJEBK2g5FqAgAPA+oCAARNOAIAAeEKAgAAKdACAALbdAIAAAJwQgAAHyoCAAACEUIAAKRiAgAAAt5CAAAyxAIAAA53wgAAMv4CAAHJzgIAAAIGAgAAMUoCAACJqgIAAc24wgAACiQCAAAQCwIAACveAgAAAyPA=
Date: Wed, 10 Aug 2022 17:06:33 +0000
Message-ID: <PH0PR12MB54811BD79FAFFAFF38231D38DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220809182306-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <62920bd4-1070-a91a-baf8-659009e9f590@oracle.com>
 <20220810021320-mutt-send-email-mst@kernel.org>
 <20220810021427-mutt-send-email-mst@kernel.org>
 <CACGkMEs3HKU0sPMO=38c471hCNu6a_1TwiYbwg0ZtBiENUBwcA@mail.gmail.com>
 <20220810050219-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819E083F0DEBF30403C380DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220810120440-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548173DD936EF45B07C157D7DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220810125749-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220810125749-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f67ce4a-ac5a-4841-1094-08da7af2ad57
x-ms-traffictypediagnostic: MN2PR12MB2926:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rTfz0zX2qjXr35HjPQW/Z6zYrQSwOjhfWHbuKaKeJ2JsGddR/4D11BtWOzTTNkIO6++SfE/qy2ht0cwpIhq2Eo4vzDtaVv6M2RpetmYkP8Zjh3guC/he92kGfnZV4ZIDGWmto60JRjpviSwxWs2Dhq26WbPR/pqhMPc3duAZ8O7RmkiBByMs2YgSc0ZY7uUeZ2sCDX+e8Q2OcBYsRALJTCbD1qEyb6TVFbdJFKpTYNkGg60amEXSy/h8BnVeLP+f2lPbNbZX3tyyLKupY917NouyBAoY9ChySSZybAaDB1NooOWz2OPhkpXEfirEC2Hsqm6mG3w2p/lV7cGrMWVKybE6dGbrzkjFErHKxfLcHJbk4NXqQYDvX0ugHaJ8okIOcxA9RkFQKOvnR2J+R3dIaZd1704AHahe4I2r3/c7c+VZinS/LNU6x178R7n1zap4lZhjHCKFqY2Y7XV118jA0N+DnQnU9BMW6/0+jCePoZhHXU/cQ0dkdXybiY2MfrOsLoJk0+jRLkPRIe+rbdKr9f8sTAKO041GfyjBFxms/Rq08mH3AyxSPbm5XOmYbdwRXycdhpfGxDLm28Yg2Ss4yr9BJjXVqauio1ljhoGprIgOe/TIkWTDUYCD/6SRz8hcF+gimgTlowyiLj7h6twlbw4JG9ebvyU6iqdd4z7qOh1SDn0XJTTVEZ6GQ2bde4yAozm5xDupLlLMZVT3GdyZp+imXKLLCDaUVHQJ3hzlAuOpRW/PhISDNK6gDNEBmKwsN8R6+wIQfdZW6fHFa6fTDnUkeZwKtcxCUtEP9hObJyt1qlLFZ56wZPgGM3AeD4ip
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(5660300002)(2906002)(7416002)(8936002)(86362001)(55016003)(33656002)(52536014)(38070700005)(9686003)(186003)(7696005)(478600001)(6506007)(122000001)(41300700001)(71200400001)(107886003)(83380400001)(38100700002)(316002)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(6916009)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4rjMT6I2yY0baIwCW7c4begL1LWQH6BafyRtE21ljxzbbJ2ttAS9HOExQwpr?=
 =?us-ascii?Q?Fsc4I+NkZk9LsX/mXl9jUfXMeeoNZTLwSG1YUBjCUG+7gi+s7NCGbvL5SoVa?=
 =?us-ascii?Q?MWHy8ixtkGW7ILifJUD1PvnpKvtV0o3HEsU2+6GyI5FmVS7b2YqUUvtMz1Qx?=
 =?us-ascii?Q?3wrOrL6kGNi9ZuatOpgO/aMgEaS0l7limF45ltfCdVwBvNn1VbZyORbMvf0V?=
 =?us-ascii?Q?h37ghT6d+TS8e5wFaXTzOGbOKBcIvjxiDFNVpSMx8ox+vFgzGIljOFx+oIot?=
 =?us-ascii?Q?15+Rey8Kz7zbOVHRUE0c6QQnlu3MukZFDnc2fasqOeMzUwAPY2kBjSWPgKXy?=
 =?us-ascii?Q?uxjM+k+Lxz1wUHJxdS+W/BdpBtfwOfes2GRFCSk7bpzN3oxT2srGfW1y/heF?=
 =?us-ascii?Q?bfNDXfiNT17J5bCwedSIRedWCfkTNXFg1vf3TKKfouRTUOADtave8BLms38s?=
 =?us-ascii?Q?fjnUbQXbP8ldxq0JxMydVu2VDQAFLumx/hxAWjkmDdbGRrpR4xEh9TRcnD6r?=
 =?us-ascii?Q?bvRr3YcCzX4EuMChqNFtYkwFNqjUtiabr33qnBLmYGFDcR5nAbIoVSX2LncR?=
 =?us-ascii?Q?Iyesp3eeOuXmwZD+vqZU/X6ej20AHe5BPab+kPHvLfn80SIalKEkThNBYUqB?=
 =?us-ascii?Q?+4r7+7RjgmzV+WZaW+GUXIM9WguCDCjFmO616No2EQuyvn10MFBKdOVBZJh/?=
 =?us-ascii?Q?9Cr/wjEti+PUFs8iI4rFJn0/ACmonSjcQqUBJD54dtULhjjQwMvuqWqoffau?=
 =?us-ascii?Q?f92s3tVjDYarjoAYK8eCMda62PwZZJz+MRZ8QDYSxqKV3Ws5z+llXkq+dHEG?=
 =?us-ascii?Q?wMu2nRl9cRDXC2zH+5FtiE7/f7CmHKs1l3Yagzi6Xbm/z6dcKZbn/x7XEoGT?=
 =?us-ascii?Q?ZLF9EkP5fP59qXxkAJkGki32RxAM2tWqEdNUn1pRyUchSxljs8e83saCGGYb?=
 =?us-ascii?Q?y2kRlD9xz70TwniFD9PQsUb9p65X5Fxhz2TZaxVRIho0t0QPK5NqM37AqZnF?=
 =?us-ascii?Q?00n8SZphpvBsO2yj5zKgv/XZA8/TCzwtZOCwQ+pfXlxIRwRQNT565o6Gmefi?=
 =?us-ascii?Q?4yXD+6lE4xM5zzAVabn1QtmTJ2kRC34k9mmn22eNzmMPx55WASTTBaMi6Mf+?=
 =?us-ascii?Q?3Devkmcp3iS5kYoRINuwreblUZnSRrO5uw67wla+zgcO6TM9q/m+fYmHWRus?=
 =?us-ascii?Q?jdRIr5JnwGzeBRFLgSp6Ne4HuIU1lmfys6qDxkM1qonvbJQTziP4kW9T7aFh?=
 =?us-ascii?Q?OFnypA0iXSyeAdIBWJ8D0ifczCbzyBtemnvi4NQTRh1d1ZziJ71/4FzX080X?=
 =?us-ascii?Q?nBpIeyqSOhgCbvavOA46lPWmWy0XwDgtsUaipbXwFV+6zDUbi1akH54Kc+YQ?=
 =?us-ascii?Q?M9QVEd/BqkGwLvbHc0KtAesaSnPtW4MHSxUCkiwRfW9xxHsJyKC/akPjh9Ov?=
 =?us-ascii?Q?qG5DcooiTRkwinR39Q834Bi8xuv2PoIdFpbIp+McmwCoa5KGOzL2Nh77oyVK?=
 =?us-ascii?Q?7g8/QZCS3jwP4+tKFm1fOjiqqc3ZVc4Uw5Ql/LIMZT1Q6QwmYxBF0MeDdZ7e?=
 =?us-ascii?Q?5rxHvxrJEdxkPYa4ubDViPQOyW5gqNy/HOuqSbpVoCETBha96F/59SCzSBcJ?=
 =?us-ascii?Q?OAinyjR1G4NBlCzhQh+ewoY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f67ce4a-ac5a-4841-1094-08da7af2ad57
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 17:06:33.5028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmADpM9shYYQMMjRvq9VepcHe2PpJw8fo3e6pgKiXmdPILcRC5TCiMNvLv/CLQeOLax/I4ZuZ3RzyQzKFXGwuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2926
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, August 10, 2022 12:59 PM
> 
> On Wed, Aug 10, 2022 at 04:22:41PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, August 10, 2022 12:05 PM
> > >
> > > On Wed, Aug 10, 2022 at 04:00:08PM +0000, Parav Pandit wrote:
> > > >
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Wednesday, August 10, 2022 5:03 AM
> > > > > > >
> > > > > > > Should we make this depend on the vq reset ability maybe?
> > > > > >
> > > > > > The advantage of this is to keep TX working. Or we can use
> > > > > > device reset as a fallback if there's no vq reset.
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > Device reset is really annoying in that it loses all the state:
> > > > > rx filters etc etc.
> > > >
> > > > The elegant solution is let driver tell the new mtu to the device.
> > > > One way to do so is by using existing ctrl vq.
> > >
> > > That will need a new feature bit.
> > >
> > Yes. ctrl vq can tell what all configuration does it allow. :) Or you
> > prefer feature bit?
> 
> We did feature bits for this in the past.
> 
Ok. Will try to draft the update for future.

Gavin should repost the patch to address comments unrelated to this future bit anyway.
Right?

> > > > If merged buffer is done, and new mtu is > minimum posting size,
> > > > no need
> > > to undergo vq reset.
> > > > If merged buffer is not done, and buffer posted are smaller than
> > > > new mtu,
> > > undergo vq reset optionally.
> > >
> > > This can be done with or without sending mtu to device.
> > Yes, telling mtu to device helps device to optimize and adhere to the spec
> line " The device MUST NOT pass received packets that exceed mtu" in
> section 5.1.4.1.
> 
> Again, that line refers to \field{mtu} which is the max mtu supported,
> irrespective to anything driver does.
> 
> --
> MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
