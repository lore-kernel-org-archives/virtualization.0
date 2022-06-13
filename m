Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C89C433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Jun 2022 20:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1288681D98;
	Mon, 13 Jun 2022 20:37:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A12heWlqf9fW; Mon, 13 Jun 2022 20:37:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A761E81495;
	Mon, 13 Jun 2022 20:37:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 742E6C0032;
	Mon, 13 Jun 2022 20:37:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3D11C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 20:37:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E11A260E48
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 20:37:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mje0yv0cuAqV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 20:37:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::61f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F8C160E44
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 20:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0N/IQusy44yMQ05XDPjWvUCTk1QHTJuBiZ4kGLVA6r2kriv79MXL6k0de7sbC+I8c+QlHZeC2uM6OkeMaRJf/DvmgRTuf9HHtUYQfEKVwvcedfJ2MpTIEXPlXf0i2BIiQUiI6FTZNz5YbjjD3MYbnuTd6S/a2UX3itxzU9A9p1WmA03Ys+Q+PLk9LLy3rPXBffI/NLJFZCWsxFs4Myz+U2H2jviF0Uf7FE9abFPcsPJnIvzFRrdckLzsrdHIZjGB18fDuUjP5d2BxKV4TKx+K4hfR1nekFsEsu1vRibyDymLKnRchMorXDNU36GNtmjNcDgzi17e+LUw8ocV0dPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wq28kR4FJBgkI5uFUfrtuxLU+CyLvAz9mKgWscch12A=;
 b=Kai37SkG8AXxz7A7fcCKvstFFLOjJJyTsMB/O7JVJTIHStm+TJVKB0+wfTY0U7bkyRswRFZjdCj272HLFCQKB2mECyeFfkpDUceinecHTxyDomOB4yRd1GhvXFq5ge6vmsbC7MzDd38dRlbNntueZS34osbdFFYINdL0MPPTrbtu/KJFAqwVXeBWWwYNasc0Zs+iMPqdJ9ouDaIuaewGxIKYlEM0IWdM74GZaP22aqSjy9AMnUd2veK6gOTG1yJuT10dn62sKWwSM3nqvmWDvxA7iI5xObTjaJT7dI9m69RCw4HdviYrpAsC6J6B0zLvmdUCbK4U1kITsfg4f3BEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wq28kR4FJBgkI5uFUfrtuxLU+CyLvAz9mKgWscch12A=;
 b=j7r8/aZsMDUuf4jFqsBk/4C3eZGMvLQm687V3YCpDaYqaHJ+Yjna6PFcQyB+nI1uXgiPL3izGrl9/8jRbU/7yqOjfCFffjiZR+tedWsL5iUpt0NXXAdJIXM/+ducJb/aPkNiUb537TZdXrDtS5VZiEH8G0g4vaSss2aeEuXIrXACg+D59bkVUqqcRzjyxoQgR5JWEVHKehReNUSgjYd+6RoskyNsrsyMQ7x+078yjIIJhnhgU9P1XtIiLYLBQosOEu9SE/qXJA9krx9OqP4aMvLcGiVgz3J1j9UkQ0Ro78cUU30LhygSgJ2nU5AaHYKgtV/9+fspKekxKm6M1ltUNA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Mon, 13 Jun
 2022 20:37:36 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::8c53:1666:6a81:943e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::8c53:1666:6a81:943e%3]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 20:37:35 +0000
To: Zhu Lingshan <lingshan.zhu@intel.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH V2 3/6] vDPA: allow userspace to query features of a vDPA
 device
Thread-Topic: [PATCH V2 3/6] vDPA: allow userspace to query features of a vDPA
 device
Thread-Index: AQHYfw/QFftqwiWMMkaiRAN4I7mCTa1NzJHQ
Date: Mon, 13 Jun 2022 20:37:35 +0000
Message-ID: <PH0PR12MB54817EB6FD580B3C5FF58129DCAB9@PH0PR12MB5481.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 96fcad33-afbc-4b6d-e4ba-08da4d7c8ca1
x-ms-traffictypediagnostic: DM6PR12MB4436:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4436395356B3A65A6976288FDCAB9@DM6PR12MB4436.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nEE8c9Mkm8XV2xdRBGO6sGROgeT1tkNtENdqrVmVfckwrbccaZcU9xS7CX6r1CB6ik7nZTrTFyr2+EZ1IuKDU1aDgR79poFFUa21AMA2hYEQcHFeXG+ug2qxk4Glwvav0BQh7yFgTiOp37vuekUoZZV+MsW9pDsflRtvaihI9J59vxyYJHueXxn0xstK6r2duDrEUmK7Sgsvya8fwC39KCo094qhJOXGwDQ70vT763VMVeC+FDSP/ZOaSmNk9UcGBgvp1tVnKA5tccnsBd7OEDgyR8DlFLNv/gpQLUZplbPV6XtjeuL/nxZZovGtrEbBjwk+YFif42Df5HvNYx8qbakMmLQU7u4dxXjJbFiGIKIhIxfuw4Q4ULJ+x7X/P6iT1OtSpLQAvv5xm75WgRdDss/ysNEc/ZjPy0t+YdBAyD5cECgfbhPOV2StPaNKlyvPJvg9xy3dfNUG5FnNEzw72f4awQXyy/dvuA6tibu3eI5swkfXxU4z6lawdJKy+hj8ey9gY2osJ/aNQiYW7OtmhpNk3lRoYBh5IIaYPHKR3u5Gsifh9puppzP4Xwl6NBMmL/+HLbN/XQpmhGanAeRY0PVdTls9gIfThRrNh/8tMC0HpYSSqNizXZgOHD+ykCaOTcpppB9HM0EsJ3WhW8W//5ZxmpGnF6zkzoECJqkCAnJi1vKnJqSnjZMxVU+xcVdWlGhkyOy3KtY78io5xS9VVw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(33656002)(6506007)(26005)(2906002)(7696005)(55236004)(316002)(38100700002)(186003)(83380400001)(9686003)(52536014)(86362001)(55016003)(8936002)(64756008)(4326008)(8676002)(76116006)(66476007)(66556008)(66946007)(66446008)(122000001)(110136005)(54906003)(71200400001)(508600001)(38070700005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2besB7lt8NDVTRj1SCWA31s9tLHIOOhFz8u8haRfEfBFxH6WpNmOXGTt2KwY?=
 =?us-ascii?Q?IAa6QSaiahdPVdkwpKzb0zjEKRN80fLKpk5l9XOtuRSPCbX098jbEvj0q7uA?=
 =?us-ascii?Q?vIWbYRrBYFzl1hG3zvkyBsMYTd2nH986SOHAHEqldJyxzMYaHRyOdVi7NjKT?=
 =?us-ascii?Q?2CId/bK5plf1xPPuyQE2S9fVdZmqyGJ3YQlu2av2bDZsZ6teOiaueXJJfJVe?=
 =?us-ascii?Q?/og6fgC7Cx9+9ZOyNjjrTE5WQru0IbGaDHEkaTOdbqORchZ6reMLYYOwENHn?=
 =?us-ascii?Q?VlePH83v6MR5tbSu4w0FwGops5eesi9NN066U87eTElG3aDpyT6bKFpM/goy?=
 =?us-ascii?Q?iyu1XPLF+OEdp/MpThbUMWTxq/lbLhd3Pp1rlR7HX0C9O9Hecf4OL8hokLA3?=
 =?us-ascii?Q?uZ9BZkNDHko0QU39FGS3S44mmb4r+iBo5lcku2PGPfHktfmmbyppMzGgzXJF?=
 =?us-ascii?Q?aojRAGMSK8Ns8br7SXWqe3GwHL91tw/wQDPDnccW7rSqPQO2CJIKW6abtQKo?=
 =?us-ascii?Q?mnMCZp3rNO02B616KgQnLQaM6S8ZnC7AvqY//8JNEBVF00FP7SCZooJfi4fO?=
 =?us-ascii?Q?0iy91SnzH1IgACOXa+i3eZ83emsz4TcbdX52fH/n7tfphol5mC897Jo/R7hX?=
 =?us-ascii?Q?OVxLk+rdMYLujuDlLN6jLFhF9qQA31taTAcEtxlXjgWreMIC8ignWlmAGVsW?=
 =?us-ascii?Q?k66qu+F+Ns1RFo4BTJCVyJTmrSCi3z8WFfAd4hOfkCH/v9eRqQu3ejlfrThK?=
 =?us-ascii?Q?kgS+4STuG2QDU/5VKKKOPUuB9MUuqNfIpltvUQlPpKm2AvjVzh2UsnzlS+BM?=
 =?us-ascii?Q?5ykZ1oT3qpOWUJRqIww1d7z5LJR49hSr2w8pMcbC8f5RBAoPviACRlepJoP7?=
 =?us-ascii?Q?wo5Sr1KoWTPBNggFMJeZhrIPlK0aXaW5n0YhLyVL7l1DZhK5ezWm7zz8mW0/?=
 =?us-ascii?Q?J4JKwHu4p19ZJUwqK6dBos68EUZ+82C5ikUmOV8HJkaSmxcyaXfeAd9SJmlg?=
 =?us-ascii?Q?We9eafPFKHKgAN/DRCOXQafDMsGjDio5GxH2NkdhTs/3+K1Hd65WR1cJ1Iac?=
 =?us-ascii?Q?HZ/3kwi3dfZBvS6bROFixy3C+7y4gdA+eSRXXomw9N08a8JF/ZrJfYZc+mvj?=
 =?us-ascii?Q?w0YBFajoDxBiggc89MxJnzPQfvXJ797SHsExzthAkp9SrWxXbOFIb0L4t1HA?=
 =?us-ascii?Q?EnC4Rf+XQLpRB1rakNbV7SnW9ngtw5k4ha8GvsBFnZHHI72/vwynaxDj8UoF?=
 =?us-ascii?Q?5B9ZySi8G1deEW4QNy2QPQl2NyJ+96edqNjMU3ZnpdRyleMnGrR9JvXxjvaT?=
 =?us-ascii?Q?ec6eUZXLTTg8JLvC4b7lKaQeBr4Td55WHunq2A7WbvQM0g8R46aLv0BUH7kL?=
 =?us-ascii?Q?5M5rSoEH3ki2Uscvg/fl7LGlHcj8nwUjQ/Lvw5iu/OaQzkXS3lMTWG+g4Bg2?=
 =?us-ascii?Q?3ecwG2etVjU/R3qs7mRF2UPz3W8+inn72cdJV2IfglVrGAXCWpi+PZcPZTnE?=
 =?us-ascii?Q?SC9zUA37BGdibM9E+YxrfBepz2cs4p4VH1QoMfj6dYjWv6XwZmPURx+M9DhZ?=
 =?us-ascii?Q?i0kQcl/GPQqHiakT44uVBvILupvJA1IsV6kGlV//TW0jysBAIu7PY6viSMKw?=
 =?us-ascii?Q?PSLfBrwtCt8IQzcpVfhfSPuyR5jEZjXoESLXF47w8Aw93XT0qFzuHww4LsKy?=
 =?us-ascii?Q?G4Uv4IiiyB8Nm4HuqJlq/3/3SdyuF3zAxkbHSPR7iBpPGFxsDyflm4RnNlg3?=
 =?us-ascii?Q?szJB9s9pIw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fcad33-afbc-4b6d-e4ba-08da4d7c8ca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 20:37:35.6737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b816nmO+eb0JLR4P37D3JjMoZrFQ2jcOmFGRkgqKrOoTFAfWkfh5cm4G5Vyg4PbdOlZGli5rQ+EC6huf0Y4VMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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
> +	VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,	/* u64 */
> 
How is this different than VDPA_ATTR_DEV_SUPPORTED_FEATURES?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
