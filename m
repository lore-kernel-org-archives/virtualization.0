Return-Path: <SRS0=aA1Z=LQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623E3C2B9F4
	for <virtualization@archiver.kernel.org>; Tue, 22 Jun 2021 14:03:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F112361369
	for <virtualization@archiver.kernel.org>; Tue, 22 Jun 2021 14:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F112361369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AD82B402EA;
	Tue, 22 Jun 2021 14:03:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Za4C8emIbuT; Tue, 22 Jun 2021 14:03:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F0B9341CCF;
	Tue, 22 Jun 2021 14:03:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C026DC0010;
	Tue, 22 Jun 2021 14:03:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21C75C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 14:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1CAEF400C5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 14:03:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kXbeE66vD6Ot
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 14:03:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::619])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C26D40286
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 14:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5sR5/YiKoHPHZejPmiZJzJVziBx49tJdQnAVpEhVJOkz014lpQ5og+ezHDEGzlr3AkLAk4x9unmDiMX63eJWGpE8PVZCmn2S2a3KqGqJBxybfQ3qxERiQEiMhq5sLsfMGBO2h6lLyG9UaaF0OeaRz0eJh+XPXQln/jstYN0SqgAsrj/h2XE9is4RJph26hwMm87q2S/qjKHjbxOGwviUonCqqGS+utxVulm9b2WWt4lZ/LohTRVTKkiyu/pFUR41ofR156dqvacojxuTfAJrENElgK/iYczkYFT+WeEcphbZRfCb55T0ze5fB4B0T6cqKcZBHa3CC6wC4v5Ji4B2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMIk8VvFDOyHexD2/keB7NRmD1xw7CxIqn5Gc52IcQ4=;
 b=fwtEZHJAgu83aJ8iQRiSD0nVdDoxIrx18+AHMPqGfw/DKM+ddtLxTcLp/Er6pn9Ft1v22dgNjjC/5yZRb+6KgsPT4pOVzVd1aVMnIHPnEUxmMa6aKsXKBhIsL5EnoIw4Fy8Y7zdZaYqLrvEuFflegAuLDIAmlypMiBd2qqYct2Mu25jSgR/fyQve2st/6pxbw0yXa9ZjYLOZ2trcemqpNuz55rMpp0cuL/2PeaZ2UL73dgu6kBOsEipl3cvDw22oiTDU/I9iH7cZSg2TYD1uJiY+JZcOVpfVN+sogL8bnfULXejpLDOKepzJtZh5Xy5q60KIbCwIm8YVFINZXQ1oxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMIk8VvFDOyHexD2/keB7NRmD1xw7CxIqn5Gc52IcQ4=;
 b=kaSDh2YI8atZuCUY1xLRnTuscV7l0k/2Sor/YqeRf9t5ZmKKQL0OTedfRHk/gkl2RHySvisq6fTCiStozOwDjT8d8cZ4ReOAPvSS+UES79kYdAkfw45VWrZ4qhPMajWJPF72cJ+NTDWAQ1HWWrK6UsTy3owNZZIyxpLUzb1LrnDv6ZCpT9xCZac0fYpvlbAx9O7xRa1hUauzCGHLxBapU+3L01VLbYN3Xcea6Dd00B7gxhcqjG3yL6JbtwhFoKfGdJoEkzGz2S7jHzb5pXMI+itldUg6D0wr0exF8N6WvUGRRFqGOfBmu57TBUnD0CtpDrCNbqr0Vm0kfIbMIMAVqg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 22 Jun
 2021 14:03:50 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdf9:42eb:ed3b:1cdb]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdf9:42eb:ed3b:1cdb%7]) with mapi id 15.20.4264.018; Tue, 22 Jun 2021
 14:03:50 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Topic: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Index: AQHXYuOJanS3dn7OPkyC8IVj+8AUaqsfqEMAgABt2KA=
Date: Tue, 22 Jun 2021 14:03:50 +0000
Message-ID: <PH0PR12MB5481AE651E0E9BFA6A1839EEDC099@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210616191155.102303-3-parav@nvidia.com>
 <aa7899c0-4b6b-dee3-a175-91e0394bc999@redhat.com>
In-Reply-To: <aa7899c0-4b6b-dee3-a175-91e0394bc999@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [223.184.81.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87ccee15-25fd-4702-f890-08d935868fd2
x-ms-traffictypediagnostic: PH0PR12MB5404:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5404E36E539ECD39595ED0A2DC099@PH0PR12MB5404.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VgTzj0kG+VtNlWAm2QrmZmKdhUkgMfcvSGXZo0FfotGPZZ/oFwzw7sr29J4XTA5H6ZI8F3UgO0uj7SZYvK9qS79xHA6rVtvX5o7iPX7YkEedBY21ypZN8CTOtVsztk2jryentBQLY4STUCzFT6jsCczZFqL2jY/PYU8v9EkiW9DLQ3oVcEwj3lkUPO2VjJGu9a36giE6qHIthAoBlYA7YC7c5GhmCQT3MR6yo/7TaxsYc97wlblN9a6dyODSuYtbQBKf7W8Lg8ueQrrFDV2xvPlXK+7O2bdiPGij+0lmsTEv3LmUn1ybN6OIOT2UCrDHOZfn8Fe/ta/iQBLqCgOoxS63jVQxGQIeDVKpQwGq+t+Y6IYVNwbiLgAQLqZ9fTYy5bPY89dSomgZuBHDjOb5nFkyTmzRTuNnVQqsLkIGcPN6wM7s9fMlukFTSp0DqZ3T8bE5LO2sCMg3SwarSEXpZb8EMOYmpg9RJe/qr6830w5Xz5f1iXEd5iQz/ODmUH32VidYSvxV7Twb3RK8Re9eVi2R0xr4NzGifR74DHHNRoNYhLLS+42l7cyDVNkeRXurVsO/fN3Txpq2S6d/UGnt7Y+p0I30kU3dA265zAdQKBLHjPs08x10d3H73qgoTBhF0VA12SXMqywtZkJR+23Y5w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(9686003)(4326008)(5660300002)(7696005)(110136005)(107886003)(71200400001)(54906003)(316002)(52536014)(478600001)(55016002)(38100700002)(30864003)(122000001)(186003)(26005)(76116006)(2906002)(6506007)(33656002)(8676002)(86362001)(66446008)(64756008)(66556008)(66476007)(66946007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HloVVthVo3vmYfrbZQnnnp+elNS7ab/KdRn97Zz2SktX1VI6f41yXa9wj9D8?=
 =?us-ascii?Q?7WJV28BE64v0pJz6WRVzT5JACd5WaSedWpRTXfI5ZzeK/RH+epriUAwMahbV?=
 =?us-ascii?Q?/ll3p496ILYdK/sRAESZ5RMwgO7lViYmYqy+dpAtgzD6U/9MeajVRczqws6k?=
 =?us-ascii?Q?QUWRZsItk8qEDGWPrKFAjaMfU5zGZ9WftzNSFa1nn3JcBHqkER7eV4CRcTYw?=
 =?us-ascii?Q?zpybUzoAl2sVxSty/niHDsofIx8Jv2mFqi/EBUkLGeuCg7XR94XnlHYyabyp?=
 =?us-ascii?Q?mGryJl6sEWCbedYDLbCHWshVJkddLbHvT3ko5RDqQwA2TkzMrC0KARQdd6hs?=
 =?us-ascii?Q?RQmLDC0qva3NYofbXni6g5kTrl9V9Z45rVd+HwIIdgh/TWRcXa6cnqZm6oY4?=
 =?us-ascii?Q?Gbd/NejpJZj0233hUXKiv2+0qb//w4nbsv6kRkG0RGVId3H1sdrvrd+fd47X?=
 =?us-ascii?Q?f6N0gyGaNzKVkTzrOa0pTNOYqRztyxekX5l9d2NDXeyu/xNiT5mZck1j915B?=
 =?us-ascii?Q?nGoaUteAfZD6ioloclvhD3jO8yJvYf2UrujdbYjVl4my6HDA34koUGyt/bDu?=
 =?us-ascii?Q?xRoExa551lnTi/g/+dheqzCD6D1VC61MxzGx4KEbYyt/9K112Ly0STCDJKW2?=
 =?us-ascii?Q?vldMOgmFOIF7lgQpkzKnhn0DKuXXRULiPLNV/Ku7cr82AsERbgZgSLN3wUqB?=
 =?us-ascii?Q?UPqIfqFbfuEBhgvU5gNwBZHk4SPjblKrS7B8qdUvCrZYFVMw3TPpjePbEVse?=
 =?us-ascii?Q?iBqB7jILxyyrpxfrmnwNnLUBqGjD2DxEETL87hm+FmFu0Xy6AmLs1jf6Xkbe?=
 =?us-ascii?Q?UUvKLoyPjjpXT3T9INFTE+Zf6CGrMHQINobiCIMPr9+q2ClsPCqf8rITU5lw?=
 =?us-ascii?Q?F5cNzSsZTsflsHtq4/vVs2bDnwPS0VzesFmOEgFe4abqWr+K1mRhJRkfZ6oo?=
 =?us-ascii?Q?hGbRUAe+Y53ezv7j/xLrHBOynOvjRpvQNvymxE+3Bhicsu/LNgWK5zYJXVg+?=
 =?us-ascii?Q?9O9V11zGvCxcUOWS3wJHFCa7eqo36FfsMWR3b+JhD+STnPutN2P48U8OjGJX?=
 =?us-ascii?Q?C7WnUyI1HsUzL6pfhbzGP/tltSs2hW+xnDkVb7V2cB7R+a+VHdaVhmnwCpbB?=
 =?us-ascii?Q?jLvALvITME4jZrm6Jq/vHOyJdBVIC3kpJ4SGJhxIQwLUPmyb23fyopyawHcx?=
 =?us-ascii?Q?gFvtBzlLdmGmuusLPCQqsdXTQEXgUW88pj2f0JV8DUhMY7iMTAMECT18DwfD?=
 =?us-ascii?Q?wTCaA4cepGUSIxCOCLbcQnJPzy1ppYFKO3rRpUTPkHuWzdOS97RLq/83QGf4?=
 =?us-ascii?Q?QRtNDLWzFrD9XJ/mIsGW1tEN?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ccee15-25fd-4702-f890-08d935868fd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 14:03:50.1775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OThac0fjluhva0dOoSmYFjHPhL3fWCUgTfhagIBm3dGwXJm6lRoNbgKvvRjboHVeB1XY5gdC09DeX2kkicD2yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5404
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
> Sent: Tuesday, June 22, 2021 12:50 PM
> 

[..]
> >   {
> >   	const struct vdpa_config_ops *ops = vdev->config;
> >
> > +	mutex_lock(&vdev->cf_mutex);
> >   	/*
> >   	 * Config accesses aren't supposed to trigger before features are set.
> >   	 * If it does happen we assume a legacy guest.
> > @@ -303,6 +308,7 @@ void vdpa_get_config(struct vdpa_device *vdev,
> unsigned int offset,
> >   	if (!vdev->features_valid)
> >   		vdpa_set_features(vdev, 0);
> >   	ops->get_config(vdev, offset, buf, len);
> > +	mutex_unlock(&vdev->cf_mutex);
> >   }
> >   EXPORT_SYMBOL_GPL(vdpa_get_config);
> >
> > @@ -316,7 +322,9 @@ EXPORT_SYMBOL_GPL(vdpa_get_config);
> >   void vdpa_set_config(struct vdpa_device *vdev, unsigned int offset,
> >   		     void *buf, unsigned int length)
> >   {
> > +	mutex_lock(&vdev->cf_mutex);
> >   	vdev->config->set_config(vdev, offset, buf, length);
> > +	mutex_unlock(&vdev->cf_mutex);
> 
> 
> I think it's better to use a separate patch to implement the synchronization in
> set_get()/get_config()
> 
Ok. I will split.

> 
> >   }
> >   EXPORT_SYMBOL_GPL(vdpa_set_config);
> >
> > @@ -643,6 +651,204 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct
> sk_buff *msg, struct netlink_callba
> >   	return msg->len;
> >   }
> >
> > +static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
> > +				       struct sk_buff *msg, u64 features,
> > +				       const struct virtio_net_config *config)
> > +{
> > +	u16 val_u16;
> > +
> > +	if ((features & (1ULL << VIRTIO_NET_F_MQ)) == 0)
> > +		return 0;
> > +
> > +	val_u16 = le16_to_cpu(config->max_virtqueue_pairs);
> > +	return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
> val_u16);
> > +}
> > +
> > +static int vdpa_dev_net_rss_config_fill(struct vdpa_device *vdev,
> > +					struct sk_buff *msg, u64 features,
> > +					const struct virtio_net_config
> *config)
> > +{
> > +	u16 val_u16;
> > +	u16 val_u32;
> > +
> > +	if ((features & (1ULL << VIRTIO_NET_F_RSS)) == 0)
> > +		return 0;
> > +
> > +	if (nla_put_u8(msg,
> VDPA_ATTR_DEV_NET_CFG_RSS_MAX_KEY_LEN,
> > +		       config->rss_max_key_size))
> > +		return -EMSGSIZE;
> > +
> > +	val_u16 = le16_to_cpu(config->rss_max_key_size);
> > +	if (nla_put_u16(msg,
> VDPA_ATTR_DEV_NET_CFG_RSS_MAX_IT_LEN, val_u16))
> > +		return -EMSGSIZE;
> > +
> > +	val_u32 = le32_to_cpu(config->supported_hash_types);
> > +	if (nla_put_u32(msg, VDPA_ATTR_DEV_NET_CFG_RSS_HASH_TYPES,
> val_u32))
> > +		return -EMSGSIZE;
> > +	return 0;
> > +}
> > +
> > +static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct
> sk_buff *msg)
> > +{
> > +	struct virtio_net_config config = {};
> > +	u64 features;
> > +	u32 val_u32;
> > +	u16 val_u16;
> > +	int err;
> > +
> > +	vdpa_get_config(vdev, 0, &config, sizeof(config));
> > +
> > +	if (nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
> sizeof(config.mac),
> > +		    config.mac))
> > +		return -EMSGSIZE;
> > +
> > +	val_u16 = le16_to_cpu(config.status);
> > +	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
> > +		return -EMSGSIZE;
> 
> 
> Note that status field only exist when VIRITO_NET_F_STATUS is
> negotiated. And if not, we need assume the link is up.
> 
Ok. will change.

> 
> > +
> > +	val_u16 = le16_to_cpu(config.mtu);
> > +	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
> > +		return -EMSGSIZE;
> > +
> > +	val_u32 = le32_to_cpu(config.speed);
> > +	if (nla_put_u32(msg, VDPA_ATTR_DEV_NET_CFG_SPEED, val_u32))
> > +		return -EMSGSIZE;
> > +
> > +	if (nla_put_u8(msg, VDPA_ATTR_DEV_NET_CFG_DUPLEX,
> config.duplex))
> > +		return -EMSGSIZE;
> 
> 
> The above two only exists when VIRTIO_NET_F_SPEED_DUPLEX is
> negotiated.
> 
I think I missed fixing this. You or Michael mentioned this in v2.
Will fix.

> 
> > +
> > +	features = vdev->config->get_features(vdev);
> > +
> > +	err = vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> > +	if (err)
> > +		return err;
> > +	return vdpa_dev_net_rss_config_fill(vdev, msg, features, &config);
> > +}
> > +
> > +static int
> > +vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32
> portid, u32 seq,
> > +		     int flags, struct netlink_ext_ack *extack)
> > +{
> > +	u32 device_id;
> > +	void *hdr;
> > +	int err;
> > +
> > +	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> > +			  VDPA_CMD_DEV_CONFIG_GET);
> > +	if (!hdr)
> > +		return -EMSGSIZE;
> > +
> > +	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev-
> >dev))) {
> > +		err = -EMSGSIZE;
> > +		goto msg_err;
> > +	}
> > +
> > +	device_id = vdev->config->get_device_id(vdev);
> > +	if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
> > +		err = -EMSGSIZE;
> > +		goto msg_err;
> > +	}
> > +
> > +	switch (device_id) {
> > +	case VIRTIO_ID_NET:
> > +		err = vdpa_dev_net_config_fill(vdev, msg);
> > +		break;
> > +	default:
> > +		err = -EOPNOTSUPP;
> > +		break;
> > +	}
> > +	if (err)
> > +		goto msg_err;
> > +
> > +	genlmsg_end(msg, hdr);
> > +	return 0;
> > +
> > +msg_err:
> > +	genlmsg_cancel(msg, hdr);
> > +	return err;
> > +}
> > +
> > +static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct
> genl_info *info)
> > +{
> > +	struct vdpa_device *vdev;
> > +	struct sk_buff *msg;
> > +	const char *devname;
> > +	struct device *dev;
> > +	int err;
> > +
> > +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
> > +		return -EINVAL;
> > +	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> > +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > +	if (!msg)
> > +		return -ENOMEM;
> > +
> > +	mutex_lock(&vdpa_dev_mutex);
> > +	dev = bus_find_device(&vdpa_bus, NULL, devname,
> vdpa_name_match);
> > +	if (!dev) {
> > +		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> > +		err = -ENODEV;
> > +		goto dev_err;
> > +	}
> > +	vdev = container_of(dev, struct vdpa_device, dev);
> > +	if (!vdev->mdev) {
> > +		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa
> device");
> > +		err = -EINVAL;
> > +		goto mdev_err;
> > +	}
> > +	err = vdpa_dev_config_fill(vdev, msg, info->snd_portid, info-
> >snd_seq,
> > +				   0, info->extack);
> > +	if (!err)
> > +		err = genlmsg_reply(msg, info);
> > +
> > +mdev_err:
> > +	put_device(dev);
> > +dev_err:
> > +	mutex_unlock(&vdpa_dev_mutex);
> > +	if (err)
> > +		nlmsg_free(msg);
> > +	return err;
> > +}
> > +
> > +static int vdpa_dev_config_dump(struct device *dev, void *data)
> > +{
> > +	struct vdpa_device *vdev = container_of(dev, struct vdpa_device,
> dev);
> > +	struct vdpa_dev_dump_info *info = data;
> > +	int err;
> > +
> > +	if (!vdev->mdev)
> > +		return 0;
> > +	if (info->idx < info->start_idx) {
> > +		info->idx++;
> > +		return 0;
> > +	}
> > +	err = vdpa_dev_config_fill(vdev, info->msg, NETLINK_CB(info->cb-
> >skb).portid,
> > +				   info->cb->nlh->nlmsg_seq, NLM_F_MULTI,
> > +				   info->cb->extack);
> > +	if (err)
> > +		return err;
> > +
> > +	info->idx++;
> > +	return 0;
> > +}
> > +
> > +static int
> > +vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct
> netlink_callback *cb)
> > +{
> > +	struct vdpa_dev_dump_info info;
> > +
> > +	info.msg = msg;
> > +	info.cb = cb;
> > +	info.start_idx = cb->args[0];
> > +	info.idx = 0;
> > +
> > +	mutex_lock(&vdpa_dev_mutex);
> > +	bus_for_each_dev(&vdpa_bus, NULL, &info,
> vdpa_dev_config_dump);
> > +	mutex_unlock(&vdpa_dev_mutex);
> > +	cb->args[0] = info.idx;
> > +	return msg->len;
> > +}
> > +
> >   static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
> >   	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING
> },
> >   	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
> > @@ -674,6 +880,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
> >   		.doit = vdpa_nl_cmd_dev_get_doit,
> >   		.dumpit = vdpa_nl_cmd_dev_get_dumpit,
> >   	},
> > +	{
> > +		.cmd = VDPA_CMD_DEV_CONFIG_GET,
> > +		.validate = GENL_DONT_VALIDATE_STRICT |
> GENL_DONT_VALIDATE_DUMP,
> > +		.doit = vdpa_nl_cmd_dev_config_get_doit,
> > +		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
> > +	},
> >   };
> >
> >   static struct genl_family vdpa_nl_family __ro_after_init = {
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index 993d99519452..bf104f9f461a 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -42,6 +42,7 @@ struct vdpa_mgmt_dev;
> >    * @dev: underlying device
> >    * @dma_dev: the actual device that is performing DMA
> >    * @config: the configuration ops for this device.
> > + * @cf_mutex: Protects get and set access to features and configuration
> layout.
> >    * @index: device index
> >    * @features_valid: were features initialized? for legacy guests
> >    * @nvqs: maximum number of supported virtqueues
> > @@ -52,6 +53,7 @@ struct vdpa_device {
> >   	struct device dev;
> >   	struct device *dma_dev;
> >   	const struct vdpa_config_ops *config;
> > +	struct mutex cf_mutex; /* Protects get/set config and features */
> >   	unsigned int index;
> >   	bool features_valid;
> >   	int nvqs;
> > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > index 66a41e4ec163..5c31ecc3b956 100644
> > --- a/include/uapi/linux/vdpa.h
> > +++ b/include/uapi/linux/vdpa.h
> > @@ -17,6 +17,7 @@ enum vdpa_command {
> >   	VDPA_CMD_DEV_NEW,
> >   	VDPA_CMD_DEV_DEL,
> >   	VDPA_CMD_DEV_GET,		/* can dump */
> > +	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
> >   };
> >
> >   enum vdpa_attr {
> > @@ -33,6 +34,16 @@ enum vdpa_attr {
> >   	VDPA_ATTR_DEV_MAX_VQS,			/* u32 */
> >   	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
> >
> > +	VDPA_ATTR_DEV_NET_CFG_MACADDR,		/* binary */
> > +	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */
> > +	VDPA_ATTR_DEV_NET_CFG_MAX_VQP,		/* u16 */
> > +	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
> > +	VDPA_ATTR_DEV_NET_CFG_SPEED,		/* u16 */
> > +	VDPA_ATTR_DEV_NET_CFG_DUPLEX,		/* u16 */
> > +	VDPA_ATTR_DEV_NET_CFG_RSS_MAX_KEY_LEN,	/* u8 */
> > +	VDPA_ATTR_DEV_NET_CFG_RSS_MAX_IT_LEN,	/* u16 */
> > +	VDPA_ATTR_DEV_NET_CFG_RSS_HASH_TYPES,	/* u32 */
> 
> 
> Is it better to use a separate enum for net specific attributes?
> 
Yes, because they are only net specific.
I guess it is related to your below question.

> Another question (sorry if it has been asked before). Can we simply
> return the config (binary) to the userspace, then usespace can use the
> existing uAPI like virtio_net_config plus the feature to explain the config?
> 
We did discuss in v2.
Usually returning the whole blob and parsing is not desired via netlink.
Returning individual fields give the full flexibility to return only the valid fields.
Otherwise we need to implement another bitmask too to tell which fields from the struct are valid and share with user space.
Returning individual fields is the widely used approach.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
