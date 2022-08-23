Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FBDC28D13
	for <virtualization@archiver.kernel.org>; Tue, 23 Aug 2022 02:56:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4DD18141E;
	Tue, 23 Aug 2022 02:56:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4DD18141E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y1usqhKI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VsUAPNUUPbDj; Tue, 23 Aug 2022 02:56:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F3B5181418;
	Tue, 23 Aug 2022 02:56:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F3B5181418
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5E5FC0033;
	Tue, 23 Aug 2022 02:56:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16D88C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 02:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB16E8141E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 02:56:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB16E8141E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DqUyeeWmq0eA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 02:56:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 26BBA81418
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 26BBA81418
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 02:56:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VERYAJJKUBIuo+XzWocLFdtZ1BL02z/KmW9LStFoHkSFSK1M281BBWXD/j3dR++Sp1b9eJMSoyeDlBic8QkcJTVtE7AfA58CJZf1vbNpBN54zF6tShVqaLpDjxQDnbbu5pwOysDAvRic/QybTEEiILWLV5oJoRL2CAIpsTpRgSOBSf49f5kG/b93kSbxteOI+LLwTeiM/BUsPqZUEguYrG/QRpmmmv3ygyZQfCHYFKtttNqo/kc8BSIeOm89LvBR4ZMSOdZ8hGnNQ8f2JCzmFQQyFkc/pT+DlzOxYSW9IBSMdZ8tM7UtWnsCZCOF7WvsGikudwKHEt6QBCvUxOf4HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dG/Y8IbAK3QP0iXN4750kKd622D+d6PCLhg9F7M5TA=;
 b=cz7TZdwTZ2nEuon4xgyKngxM2i1qYuq3pyAz0y9gaclnSbnvguJ/Za58umWkRyLczyglZHNDtfsM38vS017zqqbrt5fp5KB+VjzjbcmWAK8KjPxwmt3uPTmu2/3FtsJx1xtBQD3bgoNhiF9F3ZQIQqNCJC3EQqFk2vzaGabP0vVKeRIqYK02GKN1b39KxbmSn/dKiuI4fK80SpCYeJ2bU1Sfv6PsSxsgumFvsPV6PJOZ06x8lvAMomn2rQxVqx0LGbDqMczwl8hY6FqfBZUIRYDCnTaXFLxvA47tlD+hmK/z7l0Ce1KbYnY4p5cvKpQUhWW+3Hr/7+Mks0VzjDVg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dG/Y8IbAK3QP0iXN4750kKd622D+d6PCLhg9F7M5TA=;
 b=Y1usqhKIO+GleHY3b7Cw/lJEAJrlCkwMR7kkKP857XNdHAiSZWZ9/HHWd472aHBN8KyMLYcylE86leW2ljsj3/oku+iLtl2+lRe7ydDdEAVdwVWqk0qSAWCq7reRCl4kP1jFWpKjVfmLcN3/mIzvkFaxKkPJ/FXlN5+oPt74yhEVr8zLooDXIoiJpg3Pdfzof3dZDK5uH5nQ6aqmLpf0HMEpZLufTPwRbMp3CsDfyuNpnlsElpuZRIffsVCmtmRpqvFd6weFhtrePOfBP71oI6mKqlUB7D/YL27NPGBZSQCTbCwDEGA7K7wDFBZj1X5MC/Lj7AbgZpEG2ho0FF55gA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BN8PR12MB3441.namprd12.prod.outlook.com (2603:10b6:408:49::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 02:56:16 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::957c:a0c7:9353:411e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::957c:a0c7:9353:411e%5]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 02:56:16 +0000
To: Gavin Li <gavinl@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "kubakici@wp.pl"
 <kubakici@wp.pl>, "sridhar.samudrala@intel.com"
 <sridhar.samudrala@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>
Subject: RE: [PATCH v2 0/2] Improve virtio performance for 9k mtu
Thread-Topic: [PATCH v2 0/2] Improve virtio performance for 9k mtu
Thread-Index: AQHYs9rkB7Ofq0SFo0K4rOAu/HKXaa27zyAQ
Date: Tue, 23 Aug 2022 02:56:15 +0000
Message-ID: <PH0PR12MB548134ABC8B055298834050EDC709@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220819144904.3332-1-gavinl@nvidia.com>
In-Reply-To: <20220819144904.3332-1-gavinl@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dad677a1-aeb5-4a2f-26cc-08da84b30bdf
x-ms-traffictypediagnostic: BN8PR12MB3441:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fed57qTJzm7PNygmB2scQNAbAkcpqMh8SMwcaPX5vjywKML814AwQA5Vnfb97dNPsn2OQqBNd57BaG0NyOpL2KCL0/imolysyUejExx3iVY65QH5qf85F00cZa4i580zk3kwlEN+eOdBZcAm+awPOk1K9QrQH/TBMG9PEjWExcQ2qu54wU8+aSwjFwgE75r0QZ/WEpjy23mAojujPuh4H54kUlEipoWSSQbTv3O2nbbDpa9IBTKlAbzbHl3d9X08x61j4uvyNSezSKdhqlFgCF2AKrWOSZx4lkIzMhYDT+JNsL2phe7RYVwTfr9FHSqbZNk1wyjXyUwHWVokGH5tNCs4zILs6P3MOjEkmgrqLNL8IZMupteUPVfTrp94ArpoUtcIID3Ga/q398Hkl1yLcVUPCgCV3lfWJ8Z5GMYEGQY8UOhST5eunlNi8lB5NKO+yWfho/Fw6tyMydTIzr8+L2ZWTOlGxjOCAzHpcLJvJEIwzwB/o/dqU04gZGbnhx1qi8/UtrutQrE4C475y8or7DVHUvOCg2epLNa5ATWzXcqv4NgMX2ivLie6Uoy2/x4OQImtGeVERC0rLaoj4V9zeuDD81RFGA+SZEiKG0u2UdhPz5ahhp7RGE5ObQQAqEedfRqEDbpQIXQ3wtOQdJs8h3XcIM5isKuarYcFV+DEe1oKf8PphPmx/gehP/3maS0aoZ3FH0II0i79owVDEyN8s0a18UiPBsCOs+PEEyjk/Kl0VjyXhPb8hZSyIVKwWx9/yB5Y4aCNn0lV+/act+93Uuh98wJ4Hd5VLj8Y5sG63JM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(54906003)(52536014)(86362001)(316002)(7416002)(8936002)(107886003)(4744005)(186003)(26005)(71200400001)(110136005)(2906002)(33656002)(6506007)(7696005)(9686003)(4326008)(76116006)(66946007)(921005)(8676002)(66476007)(66446008)(66556008)(122000001)(64756008)(478600001)(55016003)(38100700002)(38070700005)(83380400001)(5660300002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rm+VD+Z6S/1sUk+F7+eckHz7vhg2BWutxaz/AqvPrhR/HwJPavRsi6vIGxwC?=
 =?us-ascii?Q?lhieGjsoduItzapLWvXuS9DJZWpz0SiWd5s4LKOCk2mxngcUYTohh22zdGRD?=
 =?us-ascii?Q?gRgKmNXV6K6NqFvHGVwPE7P9Mr+BMRi0pIcqhoLxmH+VvvV6QWqUtyC9g3Jb?=
 =?us-ascii?Q?uiHD5dTkd/9nwU300X06Spp18wPsIVQRu6XLBBgZTbLCRqGoVjBwolHae5o0?=
 =?us-ascii?Q?LFSKYRctCa3Ih5I9webxh868StW0EGdpBmSZCrYp7JNCbRXtiV2wxjgUjdVZ?=
 =?us-ascii?Q?Yk1XCW0qvR9vO+MYVkETK+1EnFF9Lv3AUtqJSNDgoXw7xZhl2eGE9RRfX4U9?=
 =?us-ascii?Q?AgbuevkEc6d41hb2IsNqa3hrJRjTBP7FIGXHP4BOn5clRrYgB5ny9GtNq2K+?=
 =?us-ascii?Q?KKOrv/KHFvTvukSakw+zScHGzEat/1YeV9Pkhj7F3EHAUJAA1bHI4BbbA5vw?=
 =?us-ascii?Q?ZIhVm5Sjura5HnmG0ucZzGhmmkbkwqVREYtTH4eR3Uo6/nKfXf3P3v/nprQn?=
 =?us-ascii?Q?C/4HMdAkPp4BwJEEVrmecTaJYdge+VnmqFz1bU7Sgqj8BK6oXDlDrRvh0rMn?=
 =?us-ascii?Q?ZVDywsa/7F7We0zDf1q4IwAKtXczb4GrhbrBjgWAkvHXdtu+JXGX1QpLOrUZ?=
 =?us-ascii?Q?8O+5ud2VFFPUbwNI06y+omSNrwpCkVYxfHcOvv5LT01QRZRJ55esOmkzswQy?=
 =?us-ascii?Q?JSQ9d1u59iK/rqic5RMLghWeqAiFKzyBeWEXvV36GWhOyrw1Zg7LQ/CWCNdS?=
 =?us-ascii?Q?4k5M4x+RLnrWq6Cx3IlgBxc7/oMffGHOY3xgPxZ1EZG1VYWRIWTNGXHDFP9k?=
 =?us-ascii?Q?jh+glQFAOEL8TL6YNlZSa+rpN4sP3Rardbl1db+ltSj+PzSB0KQFwtFfRNFR?=
 =?us-ascii?Q?Zt4xDViBVc54125LLOSXy0IjHDw8TSlxmtgOcsCWRxJ0yT990SjJBy/cCaaa?=
 =?us-ascii?Q?1EseUACEViHrPLCUkp/D7qrV9ONEeOiHuLMWVyvg5zCc+/ZnDFVJCIRv+3R8?=
 =?us-ascii?Q?c+/p385nBG/g5p5LhDikD+eB9cAOnZm+RXR6RdEqGlimBr19qj1ucZgKPVxN?=
 =?us-ascii?Q?xYlBXsv/tFDgUwplNWQyvEd3+qZ9L0vOOybV4h4mD0FmJ1Hnp9UdjO9hvj9s?=
 =?us-ascii?Q?zb1SfVJgRWCg/F/+iBa+2AtWYb3wSNCKrA1rmPnqrKz+IFDl3mLIvpCt4tnG?=
 =?us-ascii?Q?EdOIBePLaifs5hlqtEsklQbwYVY6ReUWplDKpyaHRuAqwJqpsl+aCNuQv3EK?=
 =?us-ascii?Q?VVrM1LbqkY4x3PjNStOI4T/gh34Of7L72vTa66YcYC46u2RwE4iXIJ4euYr1?=
 =?us-ascii?Q?ecK0pZ953rAJgjBNwFWjUCOPwky9pp8KT7OMKuxQH+UesKMf9wmKMK0UxNJl?=
 =?us-ascii?Q?1B6wvBTSdD4fDvxjasFuSgU6cEFfnXgXnkg7x7TLzqj4kCiYPk6xucVAWfnh?=
 =?us-ascii?Q?WF4ffjlMUvQwVoQW6sJ8u2VHXp8XcCa0AS+6D7XDlkP7e7OaV4sIz4r9EbTy?=
 =?us-ascii?Q?fHBmqC2fiwH3agoQnboI/7dZi0lv8UO4W7TyOKBtOu/fZ3uf4sikePf3UdGD?=
 =?us-ascii?Q?YitRQBLl7Aq31m2TDg8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad677a1-aeb5-4a2f-26cc-08da84b30bdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 02:56:15.9129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QPu5HTzzXnruhyQ6/qKOac8XKmvT/cWriVG3YB93MG6dZRKQnAXzE2dyi/5A514Sq9sD6VrIiaN/gs42ufe1cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3441
Cc: Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>
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


> From: Gavin Li <gavinl@nvidia.com>
> Sent: Friday, August 19, 2022 10:49 AM
> 
> This small series contains two patches that improves virtio netdevice
> performance for 9K mtu when GRO/ guest TSO is disabled.
> 
> Gavin Li (2):
>   virtio-net: introduce and use helper function for guest gso support
>     checks
>   virtio-net: use mtu size as buffer length for big packets
> 
>  drivers/net/virtio_net.c | 52 +++++++++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 16 deletions(-)

This driver change is in drivers/net.
Patches must include, netdev@vger.kernel.org to this series.
I do not know if they are merged through MST tree or netdev tree.

You might want to wait for a day or two, and if you don't receive comments, you should resend V2 by including netdev@vger.kernel.org.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
