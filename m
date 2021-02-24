Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA530C433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 11:19:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204AD64E90
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 11:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204AD64E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9964D4EBF5;
	Wed, 24 Feb 2021 11:19:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T1AFKDZG76_S; Wed, 24 Feb 2021 11:19:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id E44194EBE7;
	Wed, 24 Feb 2021 11:19:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2BDAC000B;
	Wed, 24 Feb 2021 11:19:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2B7DC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 11:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9034983089
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 11:19:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r7wt5mvLCzVH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 11:19:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9802183051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 11:19:19 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B603636360003>; Wed, 24 Feb 2021 03:19:18 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Feb
 2021 11:19:17 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Feb
 2021 11:19:02 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS)
 id
 15.0.1497.2 via Frontend Transport; Wed, 24 Feb 2021 11:19:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Clv5DcRBXnIy+JPAZrQGE3UYEv14GA+/UKt3R+JGfSKYdVpirtfDUznBWajvfLV569XATo4UDdC86CnGHcWyRjLRDiAp2Noho2Lh1P3BXlv/YgBKQM+hlIGkvVcXdvb2VHUWUfiR4UKjkq0I9DoNGB0CnwqsvTEJfczvX9jmabTO8bAljbTOSxHiX/GbDfJvhS08PTQt4SRpvgVQb4HOXuiT3mAAvPhJq5vnNQ4EPdGYxcA/WhAf56c90rpQnfpyFNnwabTD3P1RUo8V3FnA9K2V2eIwV5wEZvbLgyNkXSRWAS4XI045sG56ILrxjEbdnubMpugBmR/Jt7VdO0SBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDqbtgCpE5rdJQA5nlhMShbh9SkK5cV/iE14ISXnIHQ=;
 b=GEdbsDQ+NJVeGKEC9wIjRrINR0GYu01IKe5kAf0LE4y3H0+OD89GBmeXELVdWxAl02HQlPmyKQ+m1Mv3YdP/hiIDl51z2zxGbOj7PY3gmDbMNKmD6Fp8gI6p1Li+j5GmQIYNzwU4OkVm5gvOuGQOz0dW+ISfr9LRiavUyNeEPgNWVWFXjCSv0dtzi90G145i9aj7OOP+Nd7yEpNYJScJV3NclfLEvlW39+tfYFkHL/aovHpGD3S0ri9TR2FFyODCdtDi0v4v2UWONR5aY8QYyA8GIP51BGBDYqWolMYS3WyVWzd4mCXvGBsaLuuWHk+K2x5eA9Kh7YqgoTTXaoqjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB3222.namprd12.prod.outlook.com (2603:10b6:a03:12c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 11:18:59 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%3]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 11:18:59 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next 2/9] vdpa: Introduce query of device config
 layout
Thread-Topic: [PATCH linux-next 2/9] vdpa: Introduce query of device config
 layout
Thread-Index: AQHXCnT31njXIAjUUU6IgFe+oKOVAKpm4SmAgABG75A=
Date: Wed, 24 Feb 2021 11:18:59 +0000
Message-ID: <BY5PR12MB4322B6666E1BAA2E80B197B9DC9F9@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-3-parav@nvidia.com>
 <20210224015805-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210224015805-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.166.131.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db7a14e3-258d-44d6-4ca4-08d8d8b5fb90
x-ms-traffictypediagnostic: BYAPR12MB3222:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3222E5DF724C11E46532D673DC9F9@BYAPR12MB3222.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jDFR81dNIaCPVe+il7iYMCbtZLdVbJvZUsAwwNXM3cKi2w+OlFFQt5kCEg1D8UWLbkMuu5iZmd3SEpwNxr/h9acRHYc0GbItS85PFTy/qSJyM/5ym/RVsGmLGsjMowYzr2jpRczIj1+br2qpVj7Pr/m1YXJjOOO1XpXqyqvQmbPEhKscDoYwo0v8YewHJXFD6wOAcREW4TFnSiBkXWaSxEQj35yttzF18xkSY0uoxPUTl5YN9HHHyenvri1uGzMO7fs7LqvngcB3fQdeJSi4JL4Qvqv+wbF9zK9UuYVlj3yB0xUIrm90I9MPmXKRXaCwIOjnALVxxBapG5R136s5cGYZOuWz/FdAXaUghzeqRONQe140DzsS89bU4yKh2Y9hNJBcWr8nJfaLv0famvc0koL1Guk8yqNslc+iWbCaFhrc2Ikbwp/pNOeqOmQ0enrZV45VWOCq+MtVI7Onf930HLsEVU489s2Cm+GhO5Z96YaBJmDb6tQUOUmMA9aOFbQzFQ/fHEXzo9LIZdaM4WX9ig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(55016002)(2906002)(9686003)(33656002)(86362001)(8936002)(8676002)(4326008)(316002)(52536014)(6916009)(7696005)(478600001)(5660300002)(6506007)(76116006)(66556008)(186003)(54906003)(66446008)(107886003)(26005)(66476007)(71200400001)(64756008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bYAiMAoPDMMB9HBC5y4ze6rHbqZ5fTvbXuvu3gprVx68bHIAFESovZiff/3F?=
 =?us-ascii?Q?nveLUC82Mro0HsatJ+qxfjZpGFRUNiTw4DkDraX5MxH4haTCY8tHLD+k+sNv?=
 =?us-ascii?Q?UASWuEHdfT9whVKBqyPSdrI+6fB7yQybhtLsDzKWKWUJtGy0hV1QrZ4eFGbA?=
 =?us-ascii?Q?ahONuItLss2UHvvkXWvoTu8f9Nxm79ApYBxJhf0Em95hcsPMhXgS80Kk9Ynh?=
 =?us-ascii?Q?YHF6PDjcZeCK7oJA2QqPy9RcFDh60uFQmrJNtrGw85DfL44TKOigAZ3W9kmh?=
 =?us-ascii?Q?qRqwydBXEiS7Dh3x3fth3W3VgrNkI2neF41r80jth+r3hYZDaSXuiW5M4saL?=
 =?us-ascii?Q?r1vb5Zu7n8dUehOZFRLjG8PrCSAsoKjbpp16hg1Enei7pRLLl458s8NYoQMC?=
 =?us-ascii?Q?Cz1BmrZUCsPA4Wxke3oJOU8srvF6Ql+jHHsPLuVx+K9iHvjzbDaiSppNNTMF?=
 =?us-ascii?Q?PctXTq6uByeodw6NJqz++1kGMi+tefgbwQ5ehaEY6a5rbE6eyIAry4k4QTS8?=
 =?us-ascii?Q?/7LX59h/GcIpvZ+W6fyOcBP/r5fd1UoqyIPV8MEc3uX53Cf1Mypv4kGRTlnm?=
 =?us-ascii?Q?odj6pxezsec0rFIoE4C44LBhTcge+4R+pCvbk6GHs+52qL0WLrM9kAjQDlIx?=
 =?us-ascii?Q?2maRTnS9QdP8XRhAMTsC30Q1EO9+1D1dd47AfgHGNKg13itiCUlSeBPuzwUS?=
 =?us-ascii?Q?gaJ651RORGPBpGQZjjUAKTErfbuD1WVJjqtFmVHkNKawSZvm9Tj55AIUZkMn?=
 =?us-ascii?Q?poXNTpMk+yz9+Xt+SlpVDXCZl2FO581ELHz0PDwrJDvwlDVciHs17rCPz2QP?=
 =?us-ascii?Q?/20Qks8jcLfsbhadJWb8HWa0uEiSU9TwwWpfSGbxNrDpMCcJVBvMpA+qZBpD?=
 =?us-ascii?Q?gsE+XQcyq0+XSzl18xCw0Xj9q7Y2/PnrrpFxOfE8O0FvDc2+0SjMm3t9K7BX?=
 =?us-ascii?Q?zTd+bKtosgu3WMwQbL7ej6ouPd40gJtcmJML+T0eQGoRBHSunC8duJU6tZCm?=
 =?us-ascii?Q?2OR7RtOjibNJew9CwuBWDmE1YjXXurDMK0lPq+fziTv0ic7hoPEjPUkZz5Ex?=
 =?us-ascii?Q?YHxDPs40HwH457JFQFcdoPgvP4sZfDd21M0ez7kEMXXh9AWaVxjDPCDSVELQ?=
 =?us-ascii?Q?8ITJbCJiZLMYaK94GhairbWTsEjBImTnDTcsooWjnCJMgEPGCeu1jGLivCS/?=
 =?us-ascii?Q?GO54dKYqvkUo+toUcdB0DZ+BbNEM6Dvsb7w9iqiAbJ6fn/ZzCnEqrpNJFcab?=
 =?us-ascii?Q?Mb15/Iqke07UHmBZEfJ5ys7yoXNMjjEQctjqiWEVifUNMUNsZZDTCpNQOL9c?=
 =?us-ascii?Q?z6GsDWYrVIfBuDMr8tYb+SS6?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7a14e3-258d-44d6-4ca4-08d8d8b5fb90
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 11:18:59.2659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tj9OPOrF+j5OGhFSzAaSqafeWKJzr2rzpPjNfc3ui6qg78bnMb3sQ/QEX583xIrcdKmOo+lckKZ1OgcilF8svg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3222
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614165559; bh=aDqbtgCpE5rdJQA5nlhMShbh9SkK5cV/iE14ISXnIHQ=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
 x-microsoft-antispam-prvs:x-header:x-ms-oob-tlc-oobclassifiers:
 x-ms-exchange-senderadcheck:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=cmoXWQ3BL4Pd4TzpnwRK3805vI7A5/1QtYYUAm5kZ2ah8ZFpMh5v+K23aSsUqKNzs
 eXeCABu81eAphpJDhYgqzTVXOFw2XegXq6UURVkKL6KImFj0p/vE5jg3Zpch42txTF
 HTEh5nYWdWMgysRpG5NlrZZhKu62FZgFgkvMtz904+ctwLVLSlEEQajKDSRS0vi/Ew
 I8wWgmt1FQwCYdFOl6sx4J6N0RAAo7sYZ564I/Aawg5eSttAF4EGvzUBuSQgh6vhEr
 r8C5feqvz9qT4+D4mwR+vTKZ93GKwJNPKWW88HfSmSLeSpv+M76lwCtdwhELB/1MgF
 PjcKVCn3wTLgQ==
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
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



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, February 24, 2021 12:33 PM
> 
> > +
> > +	features = vdev->config->get_features(vdev);
> > +	if ((features & (1ULL << VIRTIO_NET_F_MQ)) == 0)
> > +		return 0;
> > +
> > +	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
> > +			config->max_virtqueue_pairs))
> > +		return -EMSGSIZE;
> > +	if (nla_put_u8(msg,
> VDPA_ATTR_DEV_NET_CFG_RSS_MAX_KEY_LEN,
> > +		       config->rss_max_key_size))
> 
> Why is it ok to poke at RSS fields without checking the relevant feature bits?
> 
It should be checked.
I relied on _MQ feature bit but yes, even with MQ, RSS can be off.
Will fix to read RSS feature bit.

> > +		return -EMSGSIZE;
> 
> Did you check this with sparse?
> max_virtqueue_pairs is __virtio16.
I will check and go through the types.

> 
> > +
> > +	rss_field = le16_to_cpu(config->rss_max_key_size);
> > +	if (nla_put_u16(msg,
> VDPA_ATTR_DEV_NET_CFG_RSS_MAX_IT_LEN, rss_field))
> > +		return -EMSGSIZE;
> > +
> > +	hash_types = le32_to_cpu(config->supported_hash_types);
> 
> unused variable
Will remove.

> 
> > +	if (nla_put_u32(msg, VDPA_ATTR_DEV_NET_CFG_RSS_HASH_TYPES,
> > +			config->supported_hash_types))
> > +		return -EMSGSIZE;
> > +	return 0;
> > +}
> > +
> > +static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct
> > +sk_buff *msg) {
> > +	struct virtio_net_config config = {};
> > +
> > +	vdev->config->get_config(vdev, 0, &config, sizeof(config));
> > +	if (nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
> sizeof(config.mac), config.mac))
> > +		return -EMSGSIZE;
> > +	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, config.status))
> > +		return -EMSGSIZE;
> > +	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU,
> config.mtu))
> > +		return -EMSGSIZE;
> > +	if (nla_put_u32(msg, VDPA_ATTR_DEV_NET_CFG_SPEED,
> config.speed))
> > +		return -EMSGSIZE;
> 
> looks like a bunch of endian-ness/sparse errors to me, and a bunch of fields
> checked without checking the feature bits.
Yes, few are missed out.
Fixing them in v2.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
