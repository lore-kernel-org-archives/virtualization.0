Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C2AC433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Jun 2022 20:42:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74B1E81D5A;
	Mon, 13 Jun 2022 20:42:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P0UBdz00C-m0; Mon, 13 Jun 2022 20:42:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1159B81AD7;
	Mon, 13 Jun 2022 20:42:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5F31C0032;
	Mon, 13 Jun 2022 20:42:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03C73C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 20:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ECDF360BAB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 20:42:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z3EW5Hikla6B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 20:42:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::606])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 101F060A94
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 20:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGzE0cbDK/bPjVTC2wZ2KgcEUbNL/xJ7BwUJ8xdb2pxBoMfVgW6oIZTYyloMaQmjoH+4MRURBzItuTBUVAFaXQMTyhArj9rM72XJUHTDStLvJhTuOqHxdZ19whuWxf8xKw3XlF/wUG6+w/BB/4PbKn4qkJO2keQkitQjKalzCwV/teQ9j/Uqz2OFksYI9M5Y4IxH5Uyr8YXKmzYieb5Ivv5oU54LVtQqeDPY7jWyVepSlBIrx2M+3CHApCDmYZAFFAF5nX5YYwWioRH45Roh95Rajh3XzFVCLC1iLKDGk5m0YbNY7oc0njmMPjSS0BlZsdwp5rq1WqTJabmaRNZsdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6ycQKfnPUqKXrUk4UI1Fqby2/D21P51+U4eeXEjEAI=;
 b=BsXH7Eiuvr41+v6whyX+ZogmGvK3vmNaPlbZbVRLjwMxEbrW16vWbtTQ9/HKeC/N5bBANp3Py+d49gdYooy0ZLivW1fHVJs0+NdzXfbjBiBPy9NFZjCFsYJvg+sM7snUZpH7xvGn06D0PC5rbcahhYTi3WEtaDtvPbCmmwWi271lT6fU5wZnMd9cqf7gDwRXhXc8KE86UZndvUxihXGC2DRek1+IdGYQFp6WWTjEixJlSx8D2gmbl8k/TAZljNhhW53dFWwXn8AjVqjq0EAPl8fMCy5AAJH/KSY4zGJoF4+NeDzIleFhELOZy6Nyt86P92y/IX/F6Vazh2EdgMgOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6ycQKfnPUqKXrUk4UI1Fqby2/D21P51+U4eeXEjEAI=;
 b=FgUvofgp0U2ebV8pDMTWQtGlz9RpW147062oiPNlyGQhXK99bAE5QvrFnSxHBU5PzYqY5pUueAA02PX81IpElVFAJzgwL8AX2bLlJI2ate//YIElymeStiF3Ww56/34V7M4tY+2W9yXLnTOb++XYevmQjBl/+KMZYBh4zsHBKAwCg2UdOx9lP/s0CBy5sYYYFKKVDntiKynRp7QV9MWLybkBC8DaRebABiynlMdqNPSboMpjEFZrFcJm7ojsOx7qhFWWHi+/TrztLq3elOsNj7Z+Xxz2BAVWPGYlOTW96P5pKDQP3deTeDfmD10eJ6ICi7md/lvn6MqRRyv4okrCRQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 20:42:23 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::8c53:1666:6a81:943e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::8c53:1666:6a81:943e%3]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 20:42:23 +0000
To: Zhu Lingshan <lingshan.zhu@intel.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH V2 3/6] vDPA: allow userspace to query features of a vDPA
 device
Thread-Topic: [PATCH V2 3/6] vDPA: allow userspace to query features of a vDPA
 device
Thread-Index: AQHYfw/QFftqwiWMMkaiRAN4I7mCTa1NzPiQ
Date: Mon, 13 Jun 2022 20:42:23 +0000
Message-ID: <PH0PR12MB548173EB919A97FF82E5E62BDCAB9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220613101652.195216-1-lingshan.zhu@intel.com>
 <20220613101652.195216-4-lingshan.zhu@intel.com>
In-Reply-To: <20220613101652.195216-4-lingshan.zhu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7724c7f-7f71-447d-35a1-08da4d7d3834
x-ms-traffictypediagnostic: BL1PR12MB5141:EE_
x-microsoft-antispam-prvs: <BL1PR12MB51417D25B10051409D18E36BDCAB9@BL1PR12MB5141.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VijiWycHU3cgiKs1RJhu11+CyyOqPsuQ6eAw4/XWoufkAc9SL83EwZSZh9ToxELnvHx650mMH4iVnWONRTWMbEZ5MsQq08IAA1WAjFB9uIBT7+EF8M2SgkRWIKbjdqhElosf1TGpNYHxsGYIj62T7L+uibLzMqK8JmyJ+6nWQM5wbYcVtLmzTjnfe17T1cWYURklolmwr4zUqbhVKCdbWx2r0mSdIqdx+FTndyv6su78HSFgHUSeaxXWh6i1gZT9t4NZB6HysFIbfAQF0llJadP8/fxFzX5po11ZLjiIi7XOd8jf8oHnVY8g+YETDffp7cL1zUuu0i2pmVmzA1XhI+k1VuURpqbXcOshJnDhlVo6+el/wzI4UFUUhK6CGVEPL6usQNQ2EY7/5d7OnESc9+J+e3lp505ObyG8c1IveMhPQK8snXWjhoyN9UlfbA1OLmkXMH4VtBDkeORqPV8GsNCGQisrp/x6lbs5IomngpmAyL+WlmiDvwq17HvaKUZ8T0etXTgt7fMTiz210RdxyMrse8GqCz4cTTI9I9TeYp4Z2XkfZ+fOeRLGQXAdBsW5Sb8VoiQaqjBaG8SR1uoMWlrZdfS1Y6qftvAO3w52qF7QDM84aUZobxhZKVVNc7qI8MriUlota60NmkNckhJh2j3Zd2ld4APNE4tRWFC5epVige0hofvCZ2b9UP5VRXwuMow/p7dM/qxwsjuNy7kvCQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(66946007)(66476007)(4326008)(66556008)(8676002)(64756008)(66446008)(76116006)(508600001)(33656002)(38100700002)(52536014)(2906002)(71200400001)(38070700005)(8936002)(86362001)(55236004)(7696005)(26005)(6506007)(5660300002)(9686003)(110136005)(54906003)(55016003)(316002)(186003)(83380400001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fYoYTia26F95MVkcdtiMF2q6+QDguO4Yzuqh09pKj0GysSFNbzIfPgZHlW6S?=
 =?us-ascii?Q?/pgtf3zNMcuYqHy87NfPLWWx+QAUlYgqZ+uBKM70shCZfFeDmnIx4k6ftoCY?=
 =?us-ascii?Q?fWhykvSrGkIRnfBNs2uLS4/XvA3tY6Hl7xdCQCP5jAIiAcGiA7P8KczTSwJZ?=
 =?us-ascii?Q?hJQhi2ZDNZHUHpgCb19w7BF+srYxox1D9mZc7cWxNDfX0fSBpsDvLckZnHzf?=
 =?us-ascii?Q?xoBS2pc41Bz2Gt99veLgPhvKli41rtQOi1CGG5Ua1JuO1LpI6LrB8dUAmCoT?=
 =?us-ascii?Q?s+8gvKmbDeEUmj6e4qfgzNxBzMMn2iKvnf9a54/Lf5XF8BFOwZO4kHv89Hq/?=
 =?us-ascii?Q?2z7x5x7hLAkZXbwDPBBu6WQSsSpb5IA4erraF1cKafN9dGLGbURg/0RvEe50?=
 =?us-ascii?Q?1ck0InKwms9UniQMY/N46GKCs51IJZq1CCAPO9MqFjTl5aJgJfRf7wsLYPjM?=
 =?us-ascii?Q?0LoQzMPqjB0qF8JWnVGsfyWHlypilqqNpUzoUasnf+wbY252w2c7NO/LW+TM?=
 =?us-ascii?Q?fvHmeOFa9aJ8K6AAY1gpKoP7BxGk2DYJX1CE4sTbiyIAf5hilVoqkbHfPRkE?=
 =?us-ascii?Q?d2uMtHNfE6NVrV+zwzNSZTDsqkKD3U1lSbZqLMV1P7OdcjzkZoQUtUIKBTXK?=
 =?us-ascii?Q?cjbVxstjF5J0EB1uBg7IgJjyovI6HU+UmRqDvEo1AsPKIC/a/ChqbrfnP5LX?=
 =?us-ascii?Q?KoQHumq/IMaqekWPGyQm86xP8eaoJ+NiQgnR5A9a8TvDK615Xsnb0UR3bMvr?=
 =?us-ascii?Q?ORiwsCR+u7Ia8V3ZMwq8kY7Iz6yj/vbmea6NicvNYdtSsQWBF6QyNwENhJtq?=
 =?us-ascii?Q?kl5TnxGU/Rn311KNVXEYx/i999kGz0KBgUfK4A3ihT4n4N3ZU27truoN2Kuk?=
 =?us-ascii?Q?OQhwpgRgr0+FNaj9Jbz3zZxmhz9pLIjXQ0aypKmaXNxqd9wywkn5QddBtSDY?=
 =?us-ascii?Q?hoXQXrI6NFDE3IReP4Cmz4nQpKAuhGvZjtD6zI1hjcs8hZm/MfQjA+g9PeOo?=
 =?us-ascii?Q?rQjhKdnNY466uI0EBmGRX+QFi0JW5Te8CX176dkOpVvaV4J6RuDaiwbx5BV0?=
 =?us-ascii?Q?BRT4wc8eavP9LEbU/OL9lwOpfn4Ey31odum8b5zZ+Zo44oz5Hps1Xrsh95q4?=
 =?us-ascii?Q?sRGks9Ftun3qyO/JmvAgg4bCiS9ek7Imq9UWTXqotpr2PgnlD3svoma5E0PV?=
 =?us-ascii?Q?NWFeDxiUQ1rBVpsTTTpxDvsOpVgW4Y71LhQXUmFQR0BW2RJJ0bMI6UxwEFjw?=
 =?us-ascii?Q?lid/t3PjofMmLOzLZmXwgB0sp+VHvX/lwVnpEYTc0UYItKnLPIQX+A3UdkHf?=
 =?us-ascii?Q?Nr8ntttfzbHQ8urSDu9fcIfa9gyDthiUl4IOCaHq0WSrAY68l1LBSBgWYp/y?=
 =?us-ascii?Q?Mcx/hakTNrTXSu/EjL2SBmsAK+bXXzgN2xjNJVXtwQ1F7qb+B7Z2GyeViPF/?=
 =?us-ascii?Q?0WMlESMfDacb1O0wq+OX7m4LgIQF5NfFBWPjj0gDxwCerKrcbg0fUh6CoeL1?=
 =?us-ascii?Q?qqiwyR+YBu42fL8xucXNErTV8nmtDWm0jOgsprn6U9A+DpmvpE4KoGK1yWfQ?=
 =?us-ascii?Q?RbtueBMNNKDAM2qYVgvufD4MrbZrNnLm7A8VtR04+7PCwEYMhOzvLGaLTcH0?=
 =?us-ascii?Q?FAmsYNCgKL5oBqrIyGI5Ahr5VdrdbrUlJSmtM8eO2sh1J39Azbl8+PhbQe0R?=
 =?us-ascii?Q?xRuhccW91Zeh864T6hHHbUs9tYmkJAZm4W3eOikPqMXuHoIkXDHo3e6xmSnt?=
 =?us-ascii?Q?vrOiwfKqhg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7724c7f-7f71-447d-35a1-08da4d7d3834
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 20:42:23.4918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yMT4AWi/ldd37erj98XMgP0Wyugohdi3zAnVohA35n4e1lIrVuHGBDHanNgdB0jaouxxZxoRjamGdCmeAgpi5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: Zhu Lingshan <lingshan.zhu@intel.com>
> Sent: Monday, June 13, 2022 6:17 AM
> device
> 
> This commit adds a new vDPA netlink attribution
> VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES. Userspace can query
> features of vDPA devices through this new attr.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/vdpa.c       | 13 +++++++++----
>  include/uapi/linux/vdpa.h |  1 +
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> ebf2f363fbe7..9b0e39b2f022 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -815,7 +815,7 @@ static int vdpa_dev_net_mq_config_fill(struct
> vdpa_device *vdev,  static int vdpa_dev_net_config_fill(struct vdpa_device
> *vdev, struct sk_buff *msg)  {
>  	struct virtio_net_config config = {};
> -	u64 features;
> +	u64 features_device, features_driver;
>  	u16 val_u16;
> 
>  	vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config)); @@ -
> 832,12 +832,17 @@ static int vdpa_dev_net_config_fill(struct vdpa_device
> *vdev, struct sk_buff *ms
>  	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
>  		return -EMSGSIZE;
> 
> -	features = vdev->config->get_driver_features(vdev);
> -	if (nla_put_u64_64bit(msg,
> VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
> +	features_driver = vdev->config->get_driver_features(vdev);
> +	if (nla_put_u64_64bit(msg,
> VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
> +			      VDPA_ATTR_PAD))
> +		return -EMSGSIZE;
> +
> +	features_device = vdev->config->get_device_features(vdev);
> +	if (nla_put_u64_64bit(msg,
> VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,
> +features_device,
>  			      VDPA_ATTR_PAD))
>  		return -EMSGSIZE;
> 
> -	return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> +	return vdpa_dev_net_mq_config_fill(vdev, msg, features_driver,
> +&config);
>  }
> 
>  static int
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h index
> 25c55cab3d7c..39f1c3d7c112 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -47,6 +47,7 @@ enum vdpa_attr {
>  	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>  	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
>  	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */

I see now what was done incorrectly with commit cd2629f6df1ca.

Above was done with wrong name prefix that missed MGMTDEV_. :(
Please don't add VDPA_ prefix due to one mistake.
Please reuse this VDPA_ATTR_DEV_SUPPORTED_FEATURES for device attribute as well.

> +	VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,	/* u64 */
> 

>  	VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
>  	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
> --
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
