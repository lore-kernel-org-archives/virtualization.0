Return-Path: <SRS0=6TmO=HR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EFAC433E0
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 14:12:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B93966146D
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 14:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93966146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7778685E24;
	Mon, 15 Feb 2021 14:12:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sYyp7BFForJ4; Mon, 15 Feb 2021 14:12:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 565198487B;
	Mon, 15 Feb 2021 14:12:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39505C0174;
	Mon, 15 Feb 2021 14:12:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99D95C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 14:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7E82786AC4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 14:12:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tQufo8jLMYT6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 14:12:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E7374867FC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 14:12:27 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B602a814b0001>; Mon, 15 Feb 2021 06:12:27 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 15 Feb
 2021 14:12:27 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 15 Feb 2021 14:12:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=astdHSpZZbsE3T3wEOxDjZhJK2YeDNOw41n7WHkS4MekDAUhW6/9IaOBoyV7acIyHTaM0zgDiV18Bpb2jtM291KWq3f3YBLIINMW8caolIDW/44HjLML4jQvgBV3ydmH70dkUQ8cgR4AwFybzBlTijt9SDoH5EoEC4pIIJQLedHpshRBYstFnVhw/rqaLjAshlbVb0hTsLMmh47UT+Le/89kHPpQusJhnGQ4s4ME7gieyiQK+3eL2sN96rS5dvRZquheFY1U6aPdksw+iUAz1JuQ8afdGpZ9ngr3ZqZA6SlMawTrmfnzdxS1TflbfYhQlWtMkfvvGialPM9L0biwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PTIeRYlKXpPsxinxSTA6z5hw8UZTUbWHotKxw+bmmw=;
 b=GxgtEzlxk9k83r8eR9yUo1wcTfV0ODXc86vNqMvXTVjfB/YgLm7EmZ0LhVpvN9UJ6o+HRHPsDMuaWw4C0aVFyc4s/bCrzCdqHFxDX/5kdTeBYJGlhqCKN3NMy1CB8ixhjpV/0IkreFiUf0nwwROQhlV5nJRx37DWYFzOfcekysNbBbpBX31dyQ2vUt4DduH7/g/+iwSEnEQf65qhYQeiikpiL2ZX2QPnUvBRcUI/7RAKIrr31fUTrCJ2R7Vm0PSYOicYW6MMkdF9yYDfkVJwTMQ4LuPoXC0pFmOXvdnsMTresi25temQI2c5MWSzZktsaiXFuwKvk+UWe4s8OmnCyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB3368.namprd12.prod.outlook.com (2603:10b6:a03:dc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Mon, 15 Feb
 2021 14:12:25 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%3]) with mapi id 15.20.3846.027; Mon, 15 Feb 2021
 14:12:25 +0000
From: Parav Pandit <parav@nvidia.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: RE: [PATCH] vdpa: Fix memory leak in error unwinding path
Thread-Topic: [PATCH] vdpa: Fix memory leak in error unwinding path
Thread-Index: AQHXAjeW0383bRvZX0K7YVdOCPNku6pZG8UAgAAoqDA=
Date: Mon, 15 Feb 2021 14:12:25 +0000
Message-ID: <BY5PR12MB43220598E44FBA01C7453BE2DC889@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210213183919.248254-1-parav@nvidia.com>
 <20210215114548.m4si5f3rz3diwkgw@steredhat>
In-Reply-To: <20210215114548.m4si5f3rz3diwkgw@steredhat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.167.131.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 977c72a2-b788-4b79-3306-08d8d1bbb85d
x-ms-traffictypediagnostic: BYAPR12MB3368:
x-microsoft-antispam-prvs: <BYAPR12MB33680645BEA320869B0EE602DC889@BYAPR12MB3368.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jw8Q/aAnOvxMxCn4baOilz29hQZh+xS3hK6W+tlScEkahvNssyv6Kd7avd8Asj8bSY7zzdknezkMGtXk+jYzzDTKSC0cVVBMy2tceqaCEL8OD/QW7DAmNfu0TRAYuQrc87cF1fvOQHH6To4QOFpamZWp7M3/SBvMjL6XiCSK+vmfwfXwH/Pn+8KDYooUIAzWzEsuE7Tjk6okf0itq/y1Sctkk2nakBZwnTrqtptl1DkJ/3+aOCPVXQS/Xfx2uEGqnwG1nTWim1kMRXADuqTbE7HqR2CLkwNlEpN7XJBw7jdBqusyjGBnTRfrU/Emx3HKDJiZ5H+1WlVsmF6eSuCqdQ5CJ4/M8zD8Rlf04Fgqz2UN31F+VZI3FQP0R28KXN2VbMT12gYEdCWYhwrTqBI8zP6HixXxoH+1+/L37VSv3ka1/Wux/9O6To1ZQF40HRHdEq0ezXyHawD6kTnAFX2l0Lt/wd7FrFa6SLC2a3O6b8ZpfnpfMWq0FOCLgDOCItcKT+TMsDa/mp6xLB2lRB/ceA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(86362001)(8676002)(8936002)(6916009)(33656002)(2906002)(52536014)(71200400001)(5660300002)(6506007)(64756008)(66476007)(83380400001)(478600001)(4326008)(316002)(9686003)(66946007)(76116006)(66446008)(66556008)(54906003)(7696005)(26005)(55016002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4sBho72247QwSCbPGfpinaiRy4hCZ3qBk+usN1qlhCqgEvHOD6IprzyYoJ2V?=
 =?us-ascii?Q?2q8/BFAmIdq7rlinjq6OiGlQwQHs2MpOUCzzuTrL95Dwxk+6fSkldG1AbOQI?=
 =?us-ascii?Q?MB1RoOGvUE2+W3L63zGx9aC9W5ouhJ6saOjqgn7bHqQn9e6nN+0fUpq5OgL7?=
 =?us-ascii?Q?CsueZ4TqzuUEhR99uwHZMD4xWOnm3tuspkJnsWaX0HjVDlnp4l5GxhucaJYm?=
 =?us-ascii?Q?RC/SSp+OQ05ZZa+1CWlnvk6kv1xgaQTPX4uEwuLouQiFr3STx+PAPKPk/MiQ?=
 =?us-ascii?Q?Mmi8xhemCmCc5VILm7gQL9zu30lFNEosXPXXadn7mrp9z43fIUK+apNo5sJa?=
 =?us-ascii?Q?T+x1tlWhF+4jeOGeQwovUwSjVgMWzWlpf8NS2pNyMuBjYmJ4cZYAqNGXTBUv?=
 =?us-ascii?Q?YeAeE4Vsd3LPtjYj57r7xM63B9feN2epQ6U3EmZ7XAP4wLcP/50wiotYbpLr?=
 =?us-ascii?Q?Bued6TX9cbCalBFRsa4K3eWFC3YCnW3D5Xt4Xsi1kAYx1fOcrDugOgg1q2un?=
 =?us-ascii?Q?WJeLd2DsbG3EoNfR/eLSspgY8ojnWBgL1c1EEB2xvF4sACO3HRaPjUWuRW4M?=
 =?us-ascii?Q?xa9AaDr8+i/7hox8I16tv73J909A9nG3Op/G2hnZb6TODA7IM0CyK8LueopC?=
 =?us-ascii?Q?KnELGqSzOMNySRKbcVAWdJTmaBaQRZE8f1+dbmjIKVJVJGHA1hi4ZSs/txBp?=
 =?us-ascii?Q?CfvOFF3UXgRiQcG67IQXJelOLytMUWiKCKNmtylocy+hoQGOa7mvjjRgq9Ne?=
 =?us-ascii?Q?4OMoGprd5eb2uOCyxBmHQukyFNR1CRluD20em6EGFFDoMh+m6I8I/KoK+0nf?=
 =?us-ascii?Q?bISeKPYBCYP8iziTz/eGVxDsDgDPi8kiBF3+8iL4b5EXBr/27A8iuXmBpgfR?=
 =?us-ascii?Q?JC6kJEcUJqezCDS1FRhCzNHNgBMjK20zwKgkxb9BnsmVnTZBzm2FiyxAnBuh?=
 =?us-ascii?Q?t4VaSVWzAH7TxvdLHu8aK/f4MiWAA07yJxWXOleCLfsNDmhfiyEDVnhXMkRy?=
 =?us-ascii?Q?sjtl0rb5d6uSxtlQV8pO3BbeJIjqLp/uGoeQf/XlCkWAJPTZW8d1M8vrBwQ8?=
 =?us-ascii?Q?unWpDYEJlooU6FCYEtVuXo7e6XUnbgysQK91CyK/0u5HC3ZHOe7yqCDGu3Iq?=
 =?us-ascii?Q?lTOh+dWCzoATcOqSVfki4lxQoJNH1oXcpH+k0zX3q4PJqaZYtKBtXiQEAE2j?=
 =?us-ascii?Q?x9LpwlcMeQr6ZMlhO2h6Rbojb8Get+jN/1zPif7KJpiNgOQjnNO3tAPwXYtP?=
 =?us-ascii?Q?fWjLzLzf214wMsegPKcm0Gq2tqYFeaNe4MGleRCWv0wimGFSqAmCyH+HAwo1?=
 =?us-ascii?Q?LscToeGfp/KiQZJ5xZsaFcSZ?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977c72a2-b788-4b79-3306-08d8d1bbb85d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 14:12:25.4433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXHFC3lpxaiS+DH2FDUOtXOhP/Cvwqq0A25scM4afUQmcfrsK2u48PTL4SKfw2CfkE0KEE1ZRhmN7m86otfYzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3368
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1613398347; bh=5PTIeRYlKXpPsxinxSTA6z5hw8UZTUbWHotKxw+bmmw=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:x-header:
 x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
 x-ms-exchange-transport-forked:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=q9G3hmFiiNU5KbBLUqGiAGADJMl42Zqu6TsQSof/cyzfq3cmyB6bEUADfaEIqTio/
 efvdrOJpFSBJAiuw84CfNxgTwa/ns+YUT++S4pUrqrGOCms0zRVjRX4BKUu+G/pCve
 2EyXQfLg1AomVXCCAmu/ZVAbppOgCISQO25hF8bVIIb3BBd9U/H4sQo02FHoTve2ao
 RURN/USeiRw9MeW/hMCPThNpjrh5U54NRV9KNV3X6cPJPN0+nJZQrGt3abodoE7jmO
 NBdtSPSYnZ3jcMRx4VxWnMZRYWGkCbuUXjLsCt813sbwmNxt3eJxJVcDknm1sexePy
 SnE1IUayvHHfg==
Cc: "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: Stefano Garzarella <sgarzare@redhat.com>
> Sent: Monday, February 15, 2021 5:16 PM
> 
> On Sat, Feb 13, 2021 at 08:39:19PM +0200, Parav Pandit wrote:
> >When device get command fails to find the device or mdev, it skips to
> >free the skb during error unwinding path.
> >Fix it by freeing in error unwind path.
> >
> >Fixes: a12a2f694ce8 ("vdpa: Enable user to query vdpa device info")
> >Signed-off-by: Parav Pandit <parav@nvidia.com>
> >---
> > drivers/vdpa/vdpa.c | 8 +++++---
> > 1 file changed, 5 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> >3d997b389345..e3f1bfdf8d6f 100644
> >--- a/drivers/vdpa/vdpa.c
> >+++ b/drivers/vdpa/vdpa.c
> >@@ -540,20 +540,22 @@ static int vdpa_nl_cmd_dev_get_doit(struct
> sk_buff *skb, struct genl_info *info)
> > 	if (!dev) {
> > 		mutex_unlock(&vdpa_dev_mutex);
> > 		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> >-		return -ENODEV;
> >+		err = -ENODEV;
> >+		goto err;
> > 	}
> > 	vdev = container_of(dev, struct vdpa_device, dev);
> > 	if (!vdev->mdev) {
> > 		mutex_unlock(&vdpa_dev_mutex);
> > 		put_device(dev);
> >-		return -EINVAL;
> >+		err = -EINVAL;
> >+		goto err;
> > 	}
> > 	err = vdpa_dev_fill(vdev, msg, info->snd_portid, info->snd_seq, 0,
> info->extack);
> > 	if (!err)
> > 		err = genlmsg_reply(msg, info);
> > 	put_device(dev);
> > 	mutex_unlock(&vdpa_dev_mutex);
> >-
> >+err:
> 
> If we put this label before mutex_unlock(), we can remove that call in the
> error paths.
> 
> Maybe we can also add another label before put_device() and jump to it in
> the "if (!vdev->mdev)" case.
> 
Yep, I will send v2.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
