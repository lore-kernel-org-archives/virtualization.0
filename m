Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13957C433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 05:34:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 749CE40018;
	Thu, 25 Nov 2021 05:34:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OpkViZ1ggA1i; Thu, 25 Nov 2021 05:34:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6200B4019B;
	Thu, 25 Nov 2021 05:34:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21A5DC002F;
	Thu, 25 Nov 2021 05:34:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D751C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 05:34:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8149B81B84
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 05:34:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jLRgTkU1YwQN
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 05:34:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5422281ADE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 05:34:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEyXV9PRIVoDNuAPu8y+0WZ+nQ/TbOijMsxhILhBnsgYp8nH41MH/UOasZmfTTrIDTfgaOD4IXaDdazWp0to7U912++Rw6YsMT+u5c8V5q1Jjx3Z9WCU5y/AUkvBmAacbRc8k2VR+a4zYx8VhEjXT1ec4XtezlNoFhA8t669CYcSQopISqWQS7LAV/OXAGF20ERXeJvXgZ1LEh5d7CCnrIh1CewKKJ1wg5mMooUcnxdSq/M1tIDppaiN7OzbuhRM3Mtv8cPtZ4Fko8p7LpxaAFywwYpw3jdcjFwa7Q3OJZVHmgBAW6WCqdJXVc830bT/sHBVQyquYlyUhOBg1eSULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUcKqgRUjL4w/dxkE2BSlEH4aV0W5r8wotlT5hvs/V4=;
 b=WXz/K7S9j+mqQH74hIMAW0RNfe0ghmQS1SyB9uyTIf99gbtJsYoadKkigiqywXgPIuDZx/WO3sT4zQ7J49CVndQPynlI4dTs4DiPoOXdb/s94kge3uuwFKc3OEgOeyOKUL/FFzamUttsEmPeB7RJf226j0zWY7hYtGN+UUEhN6ReZ3luNNkywrv7m6fgxo5g9TxYrMgW6VAsPmi26BSA9WuJZ1PmDInpgBwyClMYLiqD9jpi5K4JzlwGWQQ6t/ADRbF1Mmjso3ZbImiz1HsUKJ3xxN11ZurLEcMGfIQSVOeHvvjZhRtSCda8Vo1CTLhd7mHTQ2EfogkjZXsmijf/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUcKqgRUjL4w/dxkE2BSlEH4aV0W5r8wotlT5hvs/V4=;
 b=jyYEreTRTcuA8l8+XgEAyt9wR2PwZfgGr68Ypnd+kUjVRqPqHQCfRYjnaCgWidZC04RpfLr9uN358HcEF+Qq1CL4AdyoQYwF1a/1r7vzBtaM4yEYYSYpo6M6h7i6tL0KC2sMKyfj+vHlcUHcCzStnBQUfTvQuIx1lUqKzS4XUvUADrDsqfGdErxd9dbPlJ9l+AyNqcKf34PYdZk1B05xZA0joFCmNJ8nMqEpjSb6HusUMz53kznds4FykPfBVIrnWkye5ZWGKwstcqpG4Z2B/klvBpAq+eEepPelHVSUJ8fXgpCOENnreOcncyTPG+23FaoMcvAc2mCbJ4fFM3RF+w==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5451.namprd12.prod.outlook.com (2603:10b6:510:ee::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 25 Nov
 2021 05:34:22 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a%3]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 05:34:22 +0000
To: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATH v1 1/2] vdpa: Add support for querying vendor statistics
Thread-Topic: [PATH v1 1/2] vdpa: Add support for querying vendor statistics
Thread-Index: AQHX4VQrJsRhfsS90kGFJYDRg8aaW6wTuC2g
Date: Thu, 25 Nov 2021 05:34:21 +0000
Message-ID: <PH0PR12MB54818A0D2D4B3ABE5DD081B5DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211124165531.42624-1-elic@nvidia.com>
 <20211124165531.42624-2-elic@nvidia.com>
In-Reply-To: <20211124165531.42624-2-elic@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23015e39-37cb-41af-7dd8-08d9afd53c0e
x-ms-traffictypediagnostic: PH0PR12MB5451:
x-microsoft-antispam-prvs: <PH0PR12MB5451000DC3582B6B3571033FDC629@PH0PR12MB5451.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l3ljl4QAgJCeuf0swnFLkCTJ9cBjP69W67I390SJmWUvDjWuo1XKdS/0JgT/o1kkd1DjiULYcTwoFGBV7AUJXOt9EyjMWL8hbtsTZZOSr4VNqoVio5OS64j/4bU/yLZJXNy+uQkVT9r13ZTEbVon02zNqbkHgZxeWs8LiqvaBOE8SuobQZRxtapM+94gzaHcfNvLKfENRTBpKCxm0A3a+ruIa53SnZ+Af0oaU51yg1OrZxVNQeHRcETodYQ5wrsVrZysP6PvO0LsmzXQibYZpejQXMQMpOa2+LV6p9NI39/VGi7dcEOXZOg4qBmLMRQOp8EArhF+233T/dipWl2Z56aQku34nrtb628CjAO3oPw16//3VsDg/KP17fKGNpYjuYo7ScennBv/0ShoGdQKikrBLSThCCCtz4VRwzWTA5F44A/MlU8OeKhswr8PwNhpts3aSi6U8WU4P44fk0EgA9h5JE4Tw25Rmnv/JtHNfH6JjVBarL4IXT2YuHMzCysXSqBNOMAEYGg1aeiaWDyasKdB9WFfGCCFmRjjWUD3DHLvKM9GPrj/n+x8RyNiNdS0JpAbQM/BDFjbf9raUX7NPWto8VY6T7uvAYPcNX//Un5Ryz5i3fhiykwANLx9QllcLqBJ5CpC12zkQLipSw70JbhKCbkuLe9+fqmyod9xI7xG4TkCF9uVBgAwf7qe/nAzd/rnoHyBmq+vPVPJ4ep79g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(71200400001)(110136005)(52536014)(9686003)(66476007)(66556008)(8676002)(2906002)(66946007)(6506007)(186003)(316002)(64756008)(38100700002)(508600001)(26005)(4326008)(5660300002)(76116006)(7696005)(8936002)(55016003)(122000001)(83380400001)(66446008)(86362001)(38070700005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?skRqVmwKavKta6CGmZCJmK+23Ob8+JEmlT88y92aykfp+/+M6qqfWJW9D9Bv?=
 =?us-ascii?Q?G6LfTaFl/GaNrr8Ovg8P+2R2ld81+KjYyYrFBtLNd8FsEx76CXq1zG42P/Tc?=
 =?us-ascii?Q?kzbHXWEQc8FORfjKkkEwIQOeyYOoSJiAn5cXaqd3++TYsaKXQJy3c1i7y9FE?=
 =?us-ascii?Q?7KD/l7PjjhjtFZ3l0kN1M48cIbVY+5bYD82EpN/A5ucAwUWV9cTwQOS+nT/9?=
 =?us-ascii?Q?j5SIrGWcnpDA3v2kgxhKOUMIl5UlE3wvtR+b8JPsyFgaPRv29+097yrLqmgC?=
 =?us-ascii?Q?3lWGkZUaM2XDejYupZz5weAKHJheVTfOrU0s0LbUv1hvjkgUQQJgP/cCiMQD?=
 =?us-ascii?Q?bMWr3Lk3bwAzOpfqT5MjBQ6/vezxshnlGH3SqveOP8DXRdtqfIV6LKLMw23C?=
 =?us-ascii?Q?RTyjg1t523CY4JyjcoiSG+RltskbOOLbS5jBIv5MxqqcisLXW1Ov5LtwNSCl?=
 =?us-ascii?Q?9STX1z02uI7URnGT641ePowglGyQAzdIeXFW9c7oiaVj/TINwEwc8rSuGrC4?=
 =?us-ascii?Q?YnxAoHi1nYxxY4aVD3U4vwPcopprhCCKl+CQB1A6ccvL8DfSYWPsiE3L/QBU?=
 =?us-ascii?Q?J3lKqIdYxYf3bRsCT5QmGYQspet6UBBdp5InyphZD9JKZ9wXTn8ljGEMRIs2?=
 =?us-ascii?Q?bkdglGx7bYqvptgx+BsFqP+Eyd/KiYtTwATCag08ujPqDI3PYKhmK6iO9byz?=
 =?us-ascii?Q?iDeQSD3oIOUVrXpi5zJoEN7kyaimgDV7La4eDRlTgjDeQv9zeMO8m5wjGQtO?=
 =?us-ascii?Q?a/IVaI78JONl1Nhwi6rkz8ZEVNRsiWS7xI2Xkmp6yPhAff5hXSWdCKlZ9c12?=
 =?us-ascii?Q?XxdmI0UbRMeJToRqMQyosZifCAO0gj5Wy9xyr31c3cmds+IvYWTZtgTlcjEw?=
 =?us-ascii?Q?38/IntE1M6nvZCwrVbzFzK8bVWAVWAIeXZZBemvAsEP6ICTlq6UQ5REPSb1V?=
 =?us-ascii?Q?+ZnObxurydpbxi0alh+uAQw5blS/VFsFQMlmHJ6HEDhvKKqV67fR2NOr6wqt?=
 =?us-ascii?Q?9SO+daU5CYfUQe1T6reFX0WaCeT86KXzN+oMtXIw7dDWxegIq3CDavKYymdx?=
 =?us-ascii?Q?6VTAGBbMf5+6u+naDeW0CCcn6ZietwnpcivyLtFmBKo3Qv933urlF3XN1HAb?=
 =?us-ascii?Q?xz5vJFxdyGao19ETFtjq20Hu3M8XIuI8eH9HeW09A8UalK63bPmKFi8k29/B?=
 =?us-ascii?Q?sMVKPwnuKrG+pJxREG2Yp7GsDnLGXxtQDDAJm3ugW1fHp3hXV0Bzw9CFtHi5?=
 =?us-ascii?Q?URGQOnhb2BIR0eFpEjZcJzLVanptDLXNeK08cAFjlq7oidn7h/kZ0oss4wsQ?=
 =?us-ascii?Q?Zf32K1jRhZkEvY+yJ9ibkrJMQhsw4MSbq6h4l2M280S9vuKaRptTXYn/B1+W?=
 =?us-ascii?Q?ctX5NWKoCGics6+Hb/lozLLP7n6xwnA/zcNHntLcRSQo/Ul2FIkHzJ/SocGj?=
 =?us-ascii?Q?qu2JZvIfwR/g/IVetrUfKbfuMLHZsNURLO0XZK1u/DQ/Inn9SWTOaqN5tPSm?=
 =?us-ascii?Q?qbOv5DIggv/52fprsRCUMfS0crimp+qw05wY93iLXdlhBG3E2JRI02G7+yXr?=
 =?us-ascii?Q?T7ek1Y8TEuEMp6e8dilRb6lJ6b3NCs5prNNRGXkhEbRK118TT4qxes2sw0g9?=
 =?us-ascii?Q?dA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23015e39-37cb-41af-7dd8-08d9afd53c0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 05:34:21.8570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: buVMqupgfTXaU1fIm7oZpUtJRBbOmotmHNTTtq6RfL0E9HpQYgywFgVhthNnhrY7R/urtwtgaZCo0vtrEXHWEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5451
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
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



> From: Eli Cohen <elic@nvidia.com>
> Sent: Wednesday, November 24, 2021 10:26 PM
> 
> Add support for querying virtqueue statistics. Supported statistics are:
> 
> received_desc - number of descriptors received for the virtqueue
> completed_desc - number of descriptors completed for the virtqueue
> 
> A descriptors using indirect buffers is still counted as 1. In addition, N chained
> descriptors are counted correctly N times as one would expect.
> 
> A new callback was added to vdpa_config_ops which provides the means for
> the vdpa driver to return statistics results.
> 
> The interface allows for reading all the supported virtqueues, including the
> control virtqueue if it exists, by returning the next queue index to query.
> 
> Examples:
> 1. Read statisitics for the virtqueue at index 1 $ vdpa dev vstats show vdpa-a
> qidx 0
> vdpa-a:
> qidx 0 rx received_desc 256 completed_desc 9
> 
> 2. Read statisitics for all the virtqueues $ vdpa dev vstats show vdpa-a
> vdpa-a:
> qidx 0 rx received_desc 256 completed_desc 9 qidx 1 tx received_desc 21
> completed_desc 21 qidx 2 ctrl received_desc 0 completed_desc 0
> 
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v0 -> v1:
> Emphasize that we're dealing with vendor specific counters.
> Terminate query loop on error
> 
>  drivers/vdpa/vdpa.c       | 144 ++++++++++++++++++++++++++++++++++++++
>  include/linux/vdpa.h      |  10 +++
>  include/uapi/linux/vdpa.h |   9 +++
>  3 files changed, 163 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> 7332a74a4b00..da658c80ff2a 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -781,6 +781,90 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct
> sk_buff *msg, u32 portid,
>  	return err;
>  }
> 
> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff
> +*msg, u16 *index) {
> +	struct vdpa_vq_stats stats;
Better to name it vdpa_vq_vstats as this is reflecting vendor stats.
> +
> +static int vdpa_dev_net_stats_fill(struct vdpa_device *vdev, struct
vdpa_dev_net_vstats_fill

> +sk_buff *msg, u16 index) {
> +	int err;
> +
> +	if (!vdev->config->get_vq_stats)
> +		return -EOPNOTSUPP;
> +
> +	if (index != VDPA_INVAL_QUEUE_INDEX) {
> +		err = vdpa_fill_stats_rec(vdev, msg, &index);
> +		if (err)
> +			return err;
> +	} else {
> +		index = 0;
> +		do {
> +			err = vdpa_fill_stats_rec(vdev, msg, &index);
> +			if (err)
> +				return err;
> +		} while (index != VDPA_INVAL_QUEUE_INDEX);
> +	}
> +
> +	return 0;
> +}
> +
> +static int vdpa_dev_stats_fill(struct vdpa_device *vdev, struct sk_buff *msg,
> u32 portid,
> +			       u32 seq, int flags, u16 index) {
> +	u32 device_id;
> +	void *hdr;
> +	int err;
> +
> +	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> +			  VDPA_CMD_DEV_VSTATS_GET);
> +	if (!hdr)
> +		return -EMSGSIZE;
> +
> +	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev-
> >dev))) {
> +		err = -EMSGSIZE;
> +		goto undo_msg;
> +	}
> +
> +	device_id = vdev->config->get_device_id(vdev);
> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
> +		err = -EMSGSIZE;
> +		goto undo_msg;
> +	}
> +
> +	err = vdpa_dev_net_stats_fill(vdev, msg, index);
> +
> +	genlmsg_end(msg, hdr);
> +
> +	return err;
> +
> +undo_msg:
> +	genlmsg_cancel(msg, hdr);
> +	return err;
> +}
> +
>  static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct
> genl_info *info)  {
>  	struct vdpa_device *vdev;
> @@ -862,6 +946,59 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff
> *msg, struct netlink_callback *
>  	return msg->len;
>  }
> 
> +static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
> +					  struct genl_info *info)
> +{
> +	struct vdpa_device *vdev;
> +	struct sk_buff *msg;
> +	const char *devname;
> +	struct device *dev;
> +	u16 index = -1;
> +	int err;
> +
> +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
> +		return -EINVAL;
> +
> +	if (info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
> +		index = nla_get_u16(info-
> >attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
> +
> +	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	mutex_lock(&vdpa_dev_mutex);
> +	dev = bus_find_device(&vdpa_bus, NULL, devname,
> vdpa_name_match);
> +	if (!dev) {
> +		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> +		err = -ENODEV;
> +		goto dev_err;
> +	}
> +	vdev = container_of(dev, struct vdpa_device, dev);
> +	if (!vdev->mdev) {
> +		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa
> device");
> +		err = -EINVAL;
> +		goto mdev_err;
> +	}
> +	err = vdpa_dev_stats_fill(vdev, msg, info->snd_portid, info->snd_seq,
> 0, index);
We should be really dumping all queue stats of the device in the dumpit() routine.
But there are some limitation from netlink core to enable it.
Given that, I prefer we limit current vstats dump to single q whose index is specified by the user.

In future dumpit and netlink framework can be enhanced to dump for all queues of the specified device.

> 
> +struct vdpa_vq_stats {
vdpa_ vq_vstats

> 
> +#define VDPA_INVAL_QUEUE_INDEX 0xffff
Lets avoid this and let user space the qindex for now.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
