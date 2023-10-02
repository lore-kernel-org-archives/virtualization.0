Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DC0E7849A
	for <virtualization@archiver.kernel.org>; Mon,  2 Oct 2023 11:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3374B41779;
	Mon,  2 Oct 2023 11:23:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3374B41779
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=plX/VvDt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tgGaGnm-_V7y; Mon,  2 Oct 2023 11:23:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7053540148;
	Mon,  2 Oct 2023 11:23:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7053540148
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C569C0071;
	Mon,  2 Oct 2023 11:23:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E0B9C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 11:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E6B2E82F76
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 11:23:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E6B2E82F76
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=plX/VvDt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3mW8Ln20xxoz
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 11:23:37 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::60c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E298682F4A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 11:23:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E298682F4A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQOICVcddo56iysYnwbBuHyveai/qJZZOlTdtG310YeMi07H9jPZ57OefOiA5gkRpj5lV2tHTPF2i5H597gfQPeQhAoGHngmFiVL3xted2t8rm87f+I3/QV4sO/1CbRSoFOKxq6YvVepKKx6Y25xIkPGNBgnPKKQHOMQONGNyvviHs1hUs8I0haeAMrKAKBWeTNP8eyUYYHKiAHnYcCEfWkXiV/Er9FWa+jNall3lLw2vItmo+/hqrMArV82azcyh+cGasQJmSWUeMkMBEVyKm3JyaUZvC20SewiwhKiQpYFW0TR4vO1S0VZSqEZwhRkDb9t6cZ0nFq0ByOzJ5uhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqNFaWfyqri5ai6ECUgki0hYoJZHc0LuDiwUqaWXwlc=;
 b=XbqTIThFUn1AeylcMvWlbjwAF6I1vwqsMWfnCH0w01kIo1hI9rVvONthELM+7X552tvDE7f7g5vD9fKy+H5jZJvhKAPR0GkECkWG5nbLG4h65ee4UdsWz5QkrgxVa2gouz3/jacjZv06isTYDz/nIzL8IBESu3EhKNc8y17dktItxhczdFk3tz83TD2PGG7UHh10n+9dIJ8wM/ML6MM8qok6YDyyTusn8NPrB0CCCaCD0TzjBPTnLdojaReWLR1v2onISaF1u3hdih7a2HpjxqMLx0aqlMfhpFybOei49vIzzUVTzSuCUg6zIS0le1IH8b1zWJAhe48Gt/j9BZhfdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqNFaWfyqri5ai6ECUgki0hYoJZHc0LuDiwUqaWXwlc=;
 b=plX/VvDtaocgzWZaOXmI8xnnb0YwX6uyQp/3o/B8Tcu8rNQoEu8Zxbm149ut15QeEJSEWyI8cSn5ZDFjfHijYgLwgDOpBPNHhJ73qELi7H+0tFG9vpzqxyO/3cT/bWWxsWfDtgJfQL5dFw6aIInkW7L9a+DCJUl3BikKt7yJXQhuGVkChnXF6TrPvzExbrZo0tu+m4S/5vRy6tQqKQ67+YVTv006NWiSEawuMXJ1w7A2JDiSvFRjrXMs+TNI9RyeAg2uDrb2Ri7iedrx2t61sPAgRCKvDkhHFA8e5BncU0BoRlFMK98pzbk0n+U68MohGJoKdDij+9Wn/a30fYBhcw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 2 Oct
 2023 11:23:34 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199%7]) with mapi id 15.20.6838.029; Mon, 2 Oct 2023
 11:23:34 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: RE: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Thread-Topic: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Thread-Index: AQHZ7IkPl5ENqOgMC0yEzkOHANq/CLAnAKqAgA9qw0A=
Date: Mon, 2 Oct 2023 11:23:34 +0000
Message-ID: <PH0PR12MB54816D19D34358B37CD689C1DCC5A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230922114539-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230922114539-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB5830:EE_
x-ms-office365-filtering-correlation-id: 038c973b-30ea-4953-8f58-08dbc33a03db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jz0RYn4DtVMdqED5RqxyiNtRr1r24fGLTnSv/eg92/GVW8TbJ2EbivYwaVgvsYpTMj3F1EyyY5s/8oMhbXNFAs0YGsB2mMAbnsGTvlKokUGIFeZLtQR+UungbAY1hExKGJcvJVXrqftuzvtmzcj0iEluJ9jNY4aTgumH09yje1rBhDdttBnT31i63FLNg2PYypBsGy53rAP+t0AHtHroDLxBp6W5O8OoTHYG6sl4xQn4lSNeEmAWswxKJC9aqtDcGnNhwSRAqgRh5I+VTfuVB/VnuLsZT6syV86NchFha5888k8/KLfGfk58qvW/E7SFI4PPVfe69mw4gQWVnd/H+SLH8JCaZfq9TGSl812NEkRQspxupPld175ziQSv+apvBn4mv8jmAGDIpDfQqs7yGhqhrIKJH8T0puO38lpsZw1DzBT6g4b6/sh/FhF09CXb5sqweP7/XTAllbCiL+dUrNnqccsv1tgoDF8Ezifh/ZjdJN9vtVjaXy272bOOXv6KNkjYvLQKGGQmu5N1OeReDm/0w1bMt2NAdMWsQy7cpnRcFWEXiaaZ4HCXMCn9/JQtd15iqjbvlgDMpFdvaG6ExhOo7t2FAAgz24J3FR6HIrPfBVtHoz3dB9ThlDno8Nob
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(7696005)(71200400001)(55016003)(6506007)(122000001)(26005)(9686003)(107886003)(86362001)(110136005)(52536014)(38100700002)(316002)(38070700005)(33656002)(83380400001)(66556008)(6636002)(54906003)(41300700001)(66476007)(66946007)(8936002)(4326008)(478600001)(66446008)(76116006)(4744005)(64756008)(8676002)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c67gs7XKDaqOcSnctAAD2fWvyygJRHpmLaFBBlPaAonWMAYItBcNtc64O1e8?=
 =?us-ascii?Q?mHy0QHuxuTGfjKutv1lyUuhjuvvuoHuqn3ooPn5s/p1lWEesV9L0HbGz0xQG?=
 =?us-ascii?Q?G2l45Xbz3D5O8ASa1hsyvkEaQMBg7enQtPb/1H1hB5TujI4JHrHtvN9aYeP4?=
 =?us-ascii?Q?iPkyyjo4p/HOV+L6zUE3xgpv/qFmPVnUODeipHv2yXmODY85lxikdJijHDZz?=
 =?us-ascii?Q?SI1pOzrnyJdIDl9C7Eqn42c9O0VAW7icbjgBfo+pyBb6Mc18VGq7P7EsNws0?=
 =?us-ascii?Q?KeBSPlAx6rL2VOtwIz28VbGZAfKIb6y7SN0TmNZyHzOVc8EBXe1kCbQcMdNI?=
 =?us-ascii?Q?YaALf6BImes1XA9o9vHiyu0+aNgZZnEHBQAsVfCsVD2ARKyHE1VqmG/d2PCb?=
 =?us-ascii?Q?9WRMFaHYf8Yp/+jyEklRJU9hVmuLG9lLRrnCgjNRIe65aGWwkZGDDOPysUX5?=
 =?us-ascii?Q?W11sjEnCYDPl59sJ66LR1E750cPfpYL1aWVsNoeIFmXC1PVikVp64MDfjQ5i?=
 =?us-ascii?Q?5glgV9DDNvl4JIVlgCm/bkXUCAQ/wMsuweRkTA/bx+3mLjigWSyd0j0MIlyh?=
 =?us-ascii?Q?wom9D2jX0zHw6yIcvRYCuNWlbXNLIN3TSGRktmIpdPBTwG11yPH/UrvqC2l3?=
 =?us-ascii?Q?xi2Zieexy8WBvm5eITkjsKvkwuSTEZVxw22CSz8pIYgcBQaY3TMbWaxBUoFV?=
 =?us-ascii?Q?QZdSnua10wDoeYVCSxCIhY4d8cW5HylVW4hxsZ3g+TlPTkfbaJxYjYVDhSZM?=
 =?us-ascii?Q?HfK2ycdDnyIX4OMvJeeo7PAL5UXgkD03evxDuo7yqxKxbUvRAETqv4FGb/Sp?=
 =?us-ascii?Q?yRu+gh//BYDnhX1i2f5Kr9u0AvoH7w7cgKGrukdVVjToP17W+mzJXIxG5kmf?=
 =?us-ascii?Q?vaxdq5IktBouuocY+ZCuzdfJ9yMR7o5RttxfxSlgeV0ultejVKLjj0iR1+Ym?=
 =?us-ascii?Q?V/1S3s/veC2oq2DpjUqfBck8VQL47wEpS4VYax94er/0//0iKkVhKAhpdc7J?=
 =?us-ascii?Q?djP3iU7ggxCgYfHbp6vS2PIDNmqTTNCqBu3Su3QVj9TeqCO6InLN6+S1IUPJ?=
 =?us-ascii?Q?LSOq9aeHnAWWFwcQHoyuOOhz0cKSvTgUXofdFeQlfLfcV3bvTJRMtGJwz753?=
 =?us-ascii?Q?TtXC9rX/EUtxkJ2TnPjYMy8ib7ZpMX0SucSPCaQBfYH4YPy79QXnFPrUKFfw?=
 =?us-ascii?Q?JjlIeWY4BtgKLBrLSVuH4U9XfQr9Z0e6am7LORi77+bGjst2f3/X8EhXND7c?=
 =?us-ascii?Q?PtUITcwVCWKN40BxpIFxSLS/LV8Jx/FJCXJyizHbhxlZ+UxgFIEdF2yR3H4T?=
 =?us-ascii?Q?A1h5BIAqTG6S2Nn63lYtkenJAmf5h2oX/ORzSa7tITNuiDt2ltWUXq2SNZaZ?=
 =?us-ascii?Q?baEGiyqJL75PawOujKPbFrOM0Lv3D5FKAnuZDWvoAO9qXc4kTxn9MAZ5bV8B?=
 =?us-ascii?Q?LKezyIhaLeZHtUtOL6mQ4WdWvrqvpZbz1dIIb0w3E4Wa4672OIr0xvCGJhnX?=
 =?us-ascii?Q?VJrmeRunl4DBdWuQCnFg3p20i1cA6XxkYAU484PX7UPHqryKdCcp9jgpz2Ah?=
 =?us-ascii?Q?ZknK/KUmj6tc6AylScc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038c973b-30ea-4953-8f58-08dbc33a03db
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 11:23:34.3129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jm2Hr7VqK3+7RFghsqk8c0j/eyixo2b45gIPJoo03U/1ZJHEEL1Iumzeq+upORg/dN5XRltSXrv0nnsuqRGK5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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
> Sent: Friday, September 22, 2023 9:23 PM

> > +static int virtiovf_pci_probe(struct pci_dev *pdev,
> > +			      const struct pci_device_id *id) {
> > +	const struct vfio_device_ops *ops = &virtiovf_acc_vfio_pci_ops;
> > +	struct virtiovf_pci_core_device *virtvdev;
> > +	int ret;
> > +
> > +	if (pdev->is_virtfn && virtiovf_support_legacy_access(pdev) &&
> > +	    !virtiovf_bar0_exists(pdev) && pdev->msix_cap)
> 
> I see this is the reason you set MSIX to true. But I think it's a misunderstanding -
> that true means MSIX is enabled by guest, not that it exists.

Msix check here just looks a sanity check to make sure that guest can enable msix.
The msix enable check should be in the read()/write() calls to decide which AQ command to choose from, 
i.e. to access common config or device config as written in the virtio spec. 

Yishai please fix the read() write() calls to dynamically consider the offset of 24/20 based on the msix enabled state.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
