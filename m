Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13569253F31
	for <virtualization@lists.linux.dev>; Thu, 29 May 2025 06:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748499648; cv=fail; b=UjhDdyaEnwDQGwr3VoAty4Lz/DoKKv/63bJVyugqMz4Z1PDkwYIk3lNRZ04hAAQzBUTNrdSJ01kwETU4oKeAMMmu4ANoPddPnQvJtfkM+hqZV1oK6CjWpPlZyBT50PavkA8sIHXzRSRx4lb6colVW/pp0doo3P9R0CrdWPQwD34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748499648; c=relaxed/simple;
	bh=1tYupESXyEal5IDnKcWb4Nl46JsQ02JQyyGih20krng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NTwrROwEpQPxjVwjV93kEyqEVeJIlTlp0bcrIbcpCRXVwXBNC+a6ugZ35FUhKZpiJGmX07N+30WplDADcYKJ7eA7fZoVXTSkVm33748Fbn/kAI1e+K3dDED/2p6AH0t8YyJJUs5nyBp8fS+alxHcF/lMzuqP/3XX7Bad5IaU4g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hF0cQptg; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hF0cQptg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dz/15zmB6k93V91R9j3w9qunFEgkhnzkjm/ovy2CVCRLAZoNBsD5tn/XIqtFAvKyAWU10/AFse9mutY9+KjxFGq5Icr5xw3orEI/PBnpMwdxrBUbFYhtgsfTRjT7tHGBXDG3+fqd2MqNgqNtmUNKPCauV2gnCwJTl4e7bpK7S+Qen9A/jJwbhszpMW5cgv/SYRLQNy7UdipQ7Gz9YDHJ81ntJ4PezLnUOB3VjVMVqPVqZSkuvZROUzqpeK4IQNmfvHjXmbP33acT7ZYXYxxnKCrgQaTYi0V+IQEC15WUNEwqvOdMgdHSqhujdafEmdsVDh5AnvQm21r4ZeggqdY3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4j6qWbDXv6+8a+rHOHWyBEX+wS986IZM/BgtetnMSdk=;
 b=ctXtxTopiWYAMbhl2QOjPWyoZlD77wKOIDtqjF9Ec4CI4tddIdiVa/Io218n1zz8UsIwO0IZCFo3tKCQY44ci7XKyA9hecIWidZO2yZupsssc22t2ba5uV/PZwqtlk7zGVSn+Y5dGeoUnDHmWISw6Tqpw7dj3z7LJMKvpUId2ja2xglWfFCHHt5qHvc9/KZrvF1iHc7rHeMwGijLhJg5a3lQMXL0AoaO+/kEYwgvlf4et2C1q0SYa7pDvf1f/uZxZG3r9NysCuvGtaPnjD+2iUzh9cIFzp+CxW5KABkMP3xOzMzJRFjezvVHCTscvA9zTg0VmF2QdSHD4vDdst90zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4j6qWbDXv6+8a+rHOHWyBEX+wS986IZM/BgtetnMSdk=;
 b=hF0cQptgzkCYybzQlFB42Gykqd9IqE+BX3sjozgZYczrROcanaw3tGtjqSj/dVyEcoeqBeTRr14WLSnI+Y32DLWCTgQsbjF/F9CoNC7Q0zZ6qD+p+FX5ZtdHojU5f9/YXg4JU0gVdHZ2tgIeKXaaJ8T2UL219amX6IvYi0/It0QhvNTg03RLolrGQ6bUfO2ZwVyIH1UmrG9TqX5itdXdX0blzbJYNygpI6asa50M7dqk7kX8O+MzJiGPTzdV3RWOtGRCl2oP/Icbk+ZNnKEXftT1BZPlpEOuzckhSGErBePjjHUCBO3JRolLuR6z+zX6AMIb3jCLf577DKpxU/ToDg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SJ0PR12MB5674.namprd12.prod.outlook.com (2603:10b6:a03:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 29 May
 2025 06:20:41 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8769.021; Thu, 29 May 2025
 06:20:41 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?iso-8859-1?Q?Eugenio_P=E9rez?= <eperezma@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: RE: [PATCH] virtio: document ENOSPC
Thread-Topic: [PATCH] virtio: document ENOSPC
Thread-Index: AQHbzxN5rPhsbVY0QU29JEFp70W/WbPpJUPQ
Date: Thu, 29 May 2025 06:20:40 +0000
Message-ID:
 <CY8PR12MB7195E5B1664941A7B09E5461DC66A@CY8PR12MB7195.namprd12.prod.outlook.com>
References:
 <2e6ec46b8d5e6755be291cec8e2ec57ef286e97b.1748356035.git.mst@redhat.com>
In-Reply-To:
 <2e6ec46b8d5e6755be291cec8e2ec57ef286e97b.1748356035.git.mst@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SJ0PR12MB5674:EE_
x-ms-office365-filtering-correlation-id: f710a7ff-7ee0-42da-7db1-08dd9e78efa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?8bMSziaQ8RbEr8rz4oeq790q36fa4+QTI+KQUpJxWK9vnoo8Wnpr2b4tEe?=
 =?iso-8859-1?Q?9Z+kKKMo6GYurAHOIb4YAFGMnaV590sfeN/aXTDMmynead2ev4OoOD0Zgr?=
 =?iso-8859-1?Q?QEoZsV/2gW+aWn6HviRRQI7SNMOJpUBeZQC34i60Pg/N4zCV/1N3XwkZSj?=
 =?iso-8859-1?Q?ZY9byDHtdLy/L4v4pfWO+U0D67WLf83masdeA3lhfBRrIjrHlgIlVrJnkL?=
 =?iso-8859-1?Q?SJivN9VIQCM9hInTIb642m9SF+6oV9HzyjZTQRd3kMpH8fIFJNZb+sT1/Q?=
 =?iso-8859-1?Q?o+6FmKpJihv8G6FSgNJBD6BYrs4vZu6RQMqcd32FLKvohZqx+NEW3uL7/j?=
 =?iso-8859-1?Q?KqwM7XeJUNhTPhzS1obTMzBEus8g1cNE7EdhNmL/pY1zJfff3MP5NmXaQK?=
 =?iso-8859-1?Q?qZlc+OoNBxsVqYFPQGmB7MKj7VauXLqwizy2sbE4s8ZwR7zQ5Rf5ifnf+V?=
 =?iso-8859-1?Q?zJBDhLgHzPL/lk0yPsl7GFNQGEw5pD7UaYNSR4L6qkd2OYur3Kdq9JCBEi?=
 =?iso-8859-1?Q?QlmJso/TbdVU4EA8Aask7DpjWjUC46BhMrwnLwS9BdR5cUxf0sQuAhzNHj?=
 =?iso-8859-1?Q?uqnJ4O24tLGZJ1RKp0Vjn4Gvp8fTRPmEv8yWfLLIhvWvXfzU3q4WT4OrU8?=
 =?iso-8859-1?Q?2p7PA81w0up2zcgIhFxs6Wjicsr/YmnCOd/IYaXWcAAXBqKxxibrbTA0aP?=
 =?iso-8859-1?Q?IpK91g4sw7yo/hNLPwYyesSUukZIUoumY+qfLthUJ2ZycYSdRpYxc52cBY?=
 =?iso-8859-1?Q?x+vzzRIDXpOQPm7niB3U8bqtIXkwBAMyj8KNcDavsSZV0uWbjp3GiFSDFC?=
 =?iso-8859-1?Q?2YqQH5OmtAnZxH7RJcdXVqT+9abFKad4PoPZ0DmWBZ25DJwrvbpnsDCPfl?=
 =?iso-8859-1?Q?Wun7MZiddigA924MYIiGcV/7d8hnG54J3X5/8uRPYcSiJILO+exL7LNV1T?=
 =?iso-8859-1?Q?QbrD5GixmDqbxmT9hJIrGgXRoiT1q44xeqfYYhLhCm/jHjT4pkJTGkdowk?=
 =?iso-8859-1?Q?xnXlbIApEnRifhxwoKFLuWYUSjJ51NbGObWPHu0nBbjrHJgbR7vFHJ2AAO?=
 =?iso-8859-1?Q?cjR1gnSdwtdSVP2uFOWXiRWh3w7iFhPrArAMDt33vLfH1FXh0hRGJlfQ+U?=
 =?iso-8859-1?Q?EA8rAx8tggl+aUHwOA3dGz2fbtHhvWcRfQ/4pelN0SBSaxAXFQN0Bcehq7?=
 =?iso-8859-1?Q?4ZVpIYlST6FVTeZ/kgswVvAcPi+F25CAu29uE7FBVWrgRDBIO7jpXn2otu?=
 =?iso-8859-1?Q?7Ay6MQnXQ9c+wnYhfR54EJiSPxK2kJxGJss4MHnZ9EHkbCvyhESs+kKcV5?=
 =?iso-8859-1?Q?Z8NkG50Ym+0G7EHfQeND4PtQL/13ZbPF4YHcXIA167b+LXkeNzk8n3VFor?=
 =?iso-8859-1?Q?oyq6o7F3nFXI2NJdLa+if8scuHsT9kEvmVewuuGTk+qtuJddl9bcL/p95O?=
 =?iso-8859-1?Q?cXcSpv4kZPXzsk/+cSu4yu4Vz/48p0aaXilWCt1CkRNx+x3W6JUF/TE9NA?=
 =?iso-8859-1?Q?bAiSkoNeSsBHkUE+zm1Z3gxxyh6W7bfPyKyr0Y0dr4ySSIlxWOM3Mh6lKv?=
 =?iso-8859-1?Q?t52YhK8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0ahJSLSk+E+OKnLZWhGpNjirboUmmX4zgVLshzGBR1pFYmtLGSATmD1uqa?=
 =?iso-8859-1?Q?IM8VZKkPQeSJw6l7eQmMw6zRcnRjxj6RxobllEff5G26WlauvFz2EHCzqZ?=
 =?iso-8859-1?Q?5KGUYboYkD6g2v8iwL833mAjZE5KbcQ7tTYx8PNuL/LO0AQCwNFxzSkkqf?=
 =?iso-8859-1?Q?mCy2/6E1jxGNa2AJ1CLXCKa8cDFphWNHjii9TN/g3YAYl9tEa+at0dJJ9u?=
 =?iso-8859-1?Q?2Kv9WZyHwu1zVc9dwdP8q9PYht4x8Brp3mDSgxTu5kzneuEg/KbbsHAx85?=
 =?iso-8859-1?Q?FW04gSvlgcFoBu/oJU2ItBVPy4C+jCE0cL91ZcIVbs8B/Ye5CsZlcAF0mi?=
 =?iso-8859-1?Q?72/qZvuq6qXaiYI3Zpth2sELF6xgPULqEEXi08MBU/HaXnwSdLk+ly2yEN?=
 =?iso-8859-1?Q?pE/8wBhlYFz/aZPk3R0SeqMYqIEiCQkLg17fz9dTJegwl2IDUtjHkD3iKZ?=
 =?iso-8859-1?Q?sJMdWetSW6pJVFQWqWbNApe5S4LBaQ+CIHl82CDh+SKU4ciMEvKuI0KINf?=
 =?iso-8859-1?Q?Tef+zi3++yI/4579G4N+WJlPSI2omxTZyegND7z1yiobguhjhYz/zhXu0D?=
 =?iso-8859-1?Q?urQr4BPc4llj5T7szAIhd3AvoJdC/ggWUvkCWkHhQFNqJckA2qaZbNBn2H?=
 =?iso-8859-1?Q?d1coM4u0kTKe9FgrccMZ5IzovNrFXNpSe3RTFV6fs3o6qiovEIoYaVl1zG?=
 =?iso-8859-1?Q?z8ueckjT9bCfbbINnKgt/MOQ62G4NPzXBM/3KbUyDEC0BKMcZ5oKq88H21?=
 =?iso-8859-1?Q?lmqOucrn2AG7iJsDbTw1uh5TWyQcH5ejO/iHVGuPSJQR9NC9I5z+6bvrzM?=
 =?iso-8859-1?Q?KdcJ7CrznRb/OlscRTfRXVF/DO7SNXH/RMZmLYMhyNPHJnq1agyzWgofxR?=
 =?iso-8859-1?Q?AJD+HUgi71vjc4EE26fD+IlVAyiWkwMP7F7Jmakigv0ZZteANFa6kP1Del?=
 =?iso-8859-1?Q?WEA5Bzt2gTdEUOWw83MdM65SCiDtFOTlEnUJCB595GkK7UbguQgC7LvATy?=
 =?iso-8859-1?Q?S0224StoG1EF1DsycLvd4rsNGUl+lLEUKo1vnnepLmc7yBSpPzkDON9zsS?=
 =?iso-8859-1?Q?DhDLfIc1h7sWZWYbPBRhDKtyuzlKS2ToRNJ60/guY5CYoTrbrQjHRfBgPr?=
 =?iso-8859-1?Q?234pZc9Dw/8VM8YtnZUazjvBOEhinYjVIX2umijlR/8qRbaicAI8wFZbLy?=
 =?iso-8859-1?Q?tBD1aQvjb/3FEAwEbR2mAVYrVWVn8q/UjlIf5G8t2B09KSwARCOKZ8M0tn?=
 =?iso-8859-1?Q?8SLJF81QBy7Xnt153RfsoS4P/vbbBqMteDGdRF/Xkf66OkwD9RfwvUvdxJ?=
 =?iso-8859-1?Q?9qvb73rdbF6yD6SGgapC3ip+OLIMLTZskgxjcRau5mcy9ev080l7WSHpOf?=
 =?iso-8859-1?Q?nfCWW2mAGw7QUCGxxELUs/qFdCJu1gWA80QTsB6iEF/LYZ21hkn/xX1ggT?=
 =?iso-8859-1?Q?a5fU8Naacfme9VkJxJsitPj0z0pSrxjdcFP0Q7F4TAjvskdJ/f+uTACG+R?=
 =?iso-8859-1?Q?aqAeuoFSCGDdEPt+SAxfyhg/MkFtth6fsxXq0EALd5z7pWszYH+6jVVFO+?=
 =?iso-8859-1?Q?YJWJV+3qKTEi9knpNFtbNdQoLPimAoSIB/nuGTHQAc46djrDGXjvXp+722?=
 =?iso-8859-1?Q?2A1Sn/63IG8G8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f710a7ff-7ee0-42da-7db1-08dd9e78efa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 06:20:40.9928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQjggAufOXwUXSKfhAo4CsqPk2s2g3/7nig88RGqYuNEIU+Omm/bVEc57vVNDksxhoa1j/8TslLLhZenccKVPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5674



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, May 27, 2025 7:57 PM
> To: linux-kernel@vger.kernel.org
> Cc: Parav Pandit <parav@nvidia.com>; Jason Wang <jasowang@redhat.com>;
> Xuan Zhuo <xuanzhuo@linux.alibaba.com>; Eugenio P=E9rez
> <eperezma@redhat.com>; virtualization@lists.linux.dev
> Subject: [PATCH] virtio: document ENOSPC
>=20
> drivers handle ENOSPC specially since it's an error one can get from a
> working VQ. Document the semantics.
>=20
> Reported-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c =
index
> b784aab66867..97ab0cce527d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2296,6 +2296,10 @@ static inline int virtqueue_add(struct virtqueue
> *_vq,
>   * at the same time (except where noted).
>   *
>   * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> + *
> + * NB: ENOSPC is a special code that is only returned on an attempt to
> + add a
> + * buffer to a full VQ. It indicates that some buffers are outstanding
> + and that
> + * the operation can be retried after some buffers have been used.
>   */
>  int virtqueue_add_sgs(struct virtqueue *_vq,
>  		      struct scatterlist *sgs[],
> --
> MST

Reviewed-by: Parav Pandit <parav@nvidia.com>

