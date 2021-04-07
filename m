Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69ACC433B4
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 03:53:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EB5610E5
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 03:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EB5610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 44EE6405AB;
	Wed,  7 Apr 2021 03:53:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o4CkmdHBp4-F; Wed,  7 Apr 2021 03:53:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B217B405A0;
	Wed,  7 Apr 2021 03:53:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76E61C000B;
	Wed,  7 Apr 2021 03:53:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA46EC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 03:53:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D1BE060BD4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 03:53:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lMraPrNrnZvK
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 03:53:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38BDD60BC7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 03:53:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAl2RBUdiSOMKJI21OndHZfTE3U1GeP+zDQrTAmUt+y4qTi/gQHyBLJh4By0g4Bs9U33Sl65su9+xVpUkkj5X/8+TWBk0teOLYUATtzxYttHrqbXEPkbv2J9uQLWTYS4JLePmCR/VoIPGdA7XbDpB0r8tt7CvqKUaJ5oNras7SpYF9P42lvsvPL1Pv6eYTEiy8irJoGdfwJtTxdTUfdQnyk83UBI0cGo2Gg65gs/HqdRFyJD73Xbvovt88IHFHgiFtCYbcletsJWJn1qQlUk/pu2yfccTZSGfuOzY/2QrZ5lwq8uT+xshHs+OBBTSIjh0I764sMHyltvJg1b61PcTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/7D3BgJWmugoIZ7NQKpyjv9AERwiAeKrG4/PBV3LIw=;
 b=fblCMnOjVZmxUa8Q8psYUE6jA/CvGCOL8kerjaGUx+PytH9tH8aYpKcA/xmGrLWEARe9FFwHwCFuy6BfcQPch9ucYDHcg4F/zSM7My0/MLiH8KfydJN33i5cjk9qoxs5Gv9Ob5vmI9nxY4Cb6EIfdnvaldKZZk7ksIUrUfHtfhpZlv4yecGLmJoC3qtlL0ZbZNupxMlcI1E03AjF10ROBpfHaaTEBiGNi1uyVPavMwblsIJdvkgj3+JQ7HJSFYM608y5wT2yAd1rM3WveCmrXrT/8cMlA821SVpacyNWnfYwsPPFJT3TfHbteWLZ6zLG9JGGvECkN3MHx0i6E66JKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/7D3BgJWmugoIZ7NQKpyjv9AERwiAeKrG4/PBV3LIw=;
 b=AeHiJ1vaODGLtPdfbmDrmAT5xBiRVqht0W9YkRCq1U1DsfbGq1ZuaYHrbOYEJhkkFrV9n0KvqOzFRzAe+qIpyg9DI14psxKFPwbsGnXdx8bW4wsn6AxImrAbbTSSmUJNMzqsOZJr4X/XIlwqAFtylJU6225oA5oi4nWwLsGRE7PozbfnTUjvsOm6cTDUMINok7KyYgmHvuFPjUGZdrC6KaK/spndCxtrXt74YsRmqhr7iCTWK05pHnrrNRgSQ7ig00dGwwadfYbA62b6b6ko7O5fIMccojR/Tshd7mL+7lBNEV5MIt1l6Iq6bSMG+wkCsDRWMmTWANhr1Vc0PA7jiA==
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB3761.namprd12.prod.outlook.com (2603:10b6:a03:1af::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 7 Apr
 2021 03:52:58 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::7cec:a7fa:db2e:3073]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::7cec:a7fa:db2e:3073%9]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 03:52:58 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v2 03/14] vdpa: Introduce and use vdpa device
 get,set config, features helpers
Thread-Topic: [PATCH linux-next v2 03/14] vdpa: Introduce and use vdpa device
 get,set config, features helpers
Thread-Index: AQHXKwcKcTMrA9TYFU25JjlqUCZWlaqoYyyAgAAIvCA=
Date: Wed, 7 Apr 2021 03:52:58 +0000
Message-ID: <BY5PR12MB4322012F91AA0DC4392364CBDC759@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210406170457.98481-1-parav@nvidia.com>
 <20210406170457.98481-4-parav@nvidia.com>
 <e2f4f024-f506-c2d0-3aef-a11ce2c5778f@redhat.com>
In-Reply-To: <e2f4f024-f506-c2d0-3aef-a11ce2c5778f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [136.185.184.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b939729-4dcd-4ffe-3515-08d8f978a225
x-ms-traffictypediagnostic: BY5PR12MB3761:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3761DB75F18C27460EF418D2DC759@BY5PR12MB3761.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 168BP53QQBbUkzxiMPLL6XO/MdXQG5jOXHwuFRYsh/iIF8K0+THanKdCsKBROG35ykcfUPNoqZf3bbgbr0TXDvGB1RyWHcgD4CotqG6pNd61x0Y/CPlVTBNX1AsBAS8aa09Mfa6VmsS19uI7kcTVQRUmBWsGUTtjFwIvAqd3xwFm1ulvLslDeccqt15lsmdK9M+fbrzhSTS3CtPmJSxyJ/cgT+GD05685mca/HJrfQNzWYbtllFNQURey5qJ7YF83ZFJ4HDtmSFxUBtkTg7jVaAn9geOcdy0sVPuxguNMqrlEK9E2ScFDhmllXW+xTcET0hVUp1hglUnhb8NEBfo7nUbZ3YOelYqkOHvBP6RjydGw7Xh6EdUQNHSndTwpXDoIMMZY6dRoiYnVZn4w0lwoIhJysthImMxCJ5jVzuLk3eldO5DPbK6uj8CiHC8SWTfbjYVi2DUxldMdzERRxqTKwYuZOMmLl/NEJm6IxDZKX1NVbUMqGiFW7BMldkmpiOipHBKa39nCcapw6ubbMI4aEiYXuAdRdHmwrWAGAOiFMECKLMfW6N7x2vpmLnZDOmhrsep1meBw1TfmmRp0yhiLXDEui59RVz77PFPVu/5Y7n07R9MKUBz8CHkklS5agGySrLHaxu8O77KbGjsKtxKkvtXoowelwSrwaZz9QPLwPU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(64756008)(66556008)(66446008)(8936002)(66946007)(66476007)(76116006)(71200400001)(38100700001)(54906003)(110136005)(52536014)(83380400001)(33656002)(4326008)(6506007)(86362001)(9686003)(26005)(186003)(55016002)(498600001)(107886003)(5660300002)(2906002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QjCzVbE64+9VM7RMsmo+olwKzu64W90rSm61wlM3AsDSdczmvM0FA/CCaVmk?=
 =?us-ascii?Q?zJNbJ5HKLP5au6cz0yLfL1wT9ExtUpjy5EHKgiV5oqgW9m7vHieiXW5vHEaw?=
 =?us-ascii?Q?98Mk38f0lBKgOCX9bT9s8IAyZfwo4aNeymUOJ+xFKogTOE4rvWVFuon0arqY?=
 =?us-ascii?Q?7v/jWsS6YMp8oupBTMjPGX0rL/yIKgx6f6xKTwoM0YuHVVv+soZyHHZRzVSj?=
 =?us-ascii?Q?1S3TjwnY3J4kXm83QZnRugHOKD01WoszN4U6lR+7E8feRuP8FhCvfSlPcVsJ?=
 =?us-ascii?Q?iYfw8rBZUqEsftrk/7K6Hslj9DmfmQakHfaMT4SWJ2F3Ud61HGbbH8NUiy37?=
 =?us-ascii?Q?f3MPnKS5iFiGtd9beByceWjj+JMUXFvI5zZcAxTYQgo5cKvxqgo+nN0k3x9m?=
 =?us-ascii?Q?13JFXwHf0ODrlQ/uBrGS480ZH13/Sss0LyKLGL36hUdKYv+IcXyKfMYa+72x?=
 =?us-ascii?Q?wu6ZqptT+luHf0tEEpbH6BLs0Og3pPdUm7AFt/iqLtIXrHUe3xd50a5KTle0?=
 =?us-ascii?Q?qWYvDC2lIxYIPv4xD0hvvlboihTrFoDSjLbv0fcWVEu82Sq1h7G3RT7oMuB2?=
 =?us-ascii?Q?qCJViBRpsV2wzhPpUIcPhpSwoDeXY40XRRt2khIvzEBPK0CWplIrr572JI3F?=
 =?us-ascii?Q?clBhkzjTEsH95jJs/BcIg4Po4ONJA0I7w2ShM8j98iy4iFP6jvBbrqd8/wvw?=
 =?us-ascii?Q?avET8njwXC8WSphw2mEw7dymEWVy959xUKuL/uHVXr0kaC3ViRtlRdcTjlrr?=
 =?us-ascii?Q?AF2q01L6QDxDwZb5sZ2rH1ajtE5gCRGU5w5HFWGeXfs1ydvGRqx7+tJuxqS7?=
 =?us-ascii?Q?XIXMyT/ow7Spn0lIAsS7TZ5rsW2wue2qw8Qn3Y9VoY/PnD+8PMC/jnYexud3?=
 =?us-ascii?Q?ctuI3VSzCHzsogvQ/lSJpTbcmJgc/rrWQWuScInSqbDvoGiFu58tcgVOl0Rc?=
 =?us-ascii?Q?GomP0Wo/MPb3t9HpobsMXWUGTzj4NenX3haXSN78AEUUtABvS+HUVNr4NLVc?=
 =?us-ascii?Q?p8EexUJ6PlQuorl8AXWrRcSo173UgvVAU29b6E9rs3qzxaZdz2lnNShaw8eg?=
 =?us-ascii?Q?wOJw3t144L3Vcb0y8gFaT3+83CD5hX+0e4K05gaAoafNTx+r/OmerhuCzGBu?=
 =?us-ascii?Q?4xf3JYdm3z/SBGY0JAdQqYHRUamtmTRxEGYLklT90udw4HGuE/HMOdFn84nz?=
 =?us-ascii?Q?72vSURIMFhrHixVxX1tKaIkDpQcxCLV/J1kJ2HZJK0JwtC3uupvRC1ANvZk8?=
 =?us-ascii?Q?dGE/QD3UM90nIyl3SRJCfLlbm3TTP8/fENDqmackNTGIuSzPuWDoA10mZdCC?=
 =?us-ascii?Q?n1No2f0YNEZsvXrGovoMDjA0?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b939729-4dcd-4ffe-3515-08d8f978a225
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 03:52:58.3270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srdy71X2USdcSHZVQ+HAPRkXQsUKY20U6KR2QsOg1xBdTvxtX8PVuzb6F+GE4r3i6GyD/rwy6nxP4MCtF8/gpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3761
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
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



> From: Jason Wang <jasowang@redhat.com>
> Sent: Wednesday, April 7, 2021 8:48 AM
[..]
> > +/**
> > + * vdpa_set_features - Set vDPA device features
> > + * @vdev: vdpa device whose features to set
> > + * @features: features of the vdpa device to enable/disable
> > + *
> > + * Return: Returns 0 on success or error code.
> > + */
> > +int vdpa_set_features(struct vdpa_device *vdev, u64 features) {
> > +	const struct vdpa_config_ops *ops = vdev->config;
> > +
> > +	vdev->features_valid = true;
> > +	return ops->set_features(vdev, features); }
> > +EXPORT_SYMBOL_GPL(vdpa_set_features);
> > +
> 
> 
> Let's add a doc for this function?
Kdoc comment is added above the function in this patch.

> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> 
> 
> We probably need to convert drivers/virtio/vdpa.c as well.
Yes, will do.

> 
> 
> > @@ -236,7 +236,6 @@ static long vhost_vdpa_set_config(struct
> vhost_vdpa *v,
> >   				  struct vhost_vdpa_config __user *c)
> >   {
> >   	struct vdpa_device *vdpa = v->vdpa;
> > -	const struct vdpa_config_ops *ops = vdpa->config;
> >   	struct vhost_vdpa_config config;
> >   	unsigned long size = offsetof(struct vhost_vdpa_config, buf);
> >   	u8 *buf;
> > @@ -250,7 +249,7 @@ static long vhost_vdpa_set_config(struct
> vhost_vdpa *v,
> >   	if (IS_ERR(buf))
> >   		return PTR_ERR(buf);
> >
> > -	ops->set_config(vdpa, config.off, buf, config.len);
> > +	vdpa_set_config(vdpa, config.off, buf, config.len);
> >
> >   	kvfree(buf);
> >   	return 0;
> > @@ -259,10 +258,9 @@ static long vhost_vdpa_set_config(struct
> vhost_vdpa *v,
> >   static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user
> *featurep)
> >   {
> >   	struct vdpa_device *vdpa = v->vdpa;
> > -	const struct vdpa_config_ops *ops = vdpa->config;
> >   	u64 features;
> >
> > -	features = ops->get_features(vdpa);
> > +	features = vdpa_get_features(vdpa);
> >
> >   	if (copy_to_user(featurep, &features, sizeof(features)))
> >   		return -EFAULT;
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h index
> > 37b65ca940cf..62e68ccc4c96 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -320,28 +320,12 @@ static inline void vdpa_reset(struct vdpa_device
> *vdev)
> >           ops->set_status(vdev, 0);
> >   }
> >
> > -static inline int vdpa_set_features(struct vdpa_device *vdev, u64
> > features) -{
> > -        const struct vdpa_config_ops *ops = vdev->config;
> > -
> > -	vdev->features_valid = true;
> > -        return ops->set_features(vdev, features);
> > -}
> > -
> > -
> > -static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned
> offset,
> > -				   void *buf, unsigned int len)
> > -{
> > -        const struct vdpa_config_ops *ops = vdev->config;
> > -
> > -	/*
> > -	 * Config accesses aren't supposed to trigger before features are set.
> > -	 * If it does happen we assume a legacy guest.
> > -	 */
> > -	if (!vdev->features_valid)
> > -		vdpa_set_features(vdev, 0);
> > -	ops->get_config(vdev, offset, buf, len);
> > -}
> > +u64 vdpa_get_features(struct vdpa_device *vdev); int
> > +vdpa_set_features(struct vdpa_device *vdev, u64 features); void
> > +vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
> > +		     void *buf, unsigned int len);
> > +void vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
> > +		     void *buf, unsigned int length);
> 
> 
> I think it's better to use a separate patch for this moving.
> 
Ok. will have prepatch to this one for movement.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
