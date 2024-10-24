Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F163D69
	for <virtualization@lists.linux-foundation.org>; Thu, 24 Oct 2024 02:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736359; cv=fail; b=LDBQqk9qKQxGTpJ3RATRGq5zUYMw+kVV7qXFdXuIXLxDVUBVVZO1+FBFEBAWZLsg3VAJyeiTG15Glt3bqVYg6NnUmyd0d1ICdI7B8eWV7sVNYI8AlAhRoGZTVLpU6j4prVcLFaqAcsP9KIHrBcUosSKABEbJJ6KNUoV8aUdOOWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736359; c=relaxed/simple;
	bh=wyNheO2cMpsESEfyURt8tonIryNKtnnlNiVkfUmiBcA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IZLpI/FK5kq2KFxJ9uxes+ctZM/ryItLmmOtzzFpQaJd51mA35Y7Q/wcAbRqB7o7/ztzEqyu7IbHr4GrXlbqcKCKxalhtDsVn3KBHdywXHn9KQrJt6Wy5Po45C6jOCrG92r2t7jk8UJHLzSiyHFQQSqvjhOhEWZ0N3yNk/oplQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XuHx4UhM; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XuHx4UhM"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D3316072B
	for <virtualization@lists.linux-foundation.org>; Thu, 24 Oct 2024 02:19:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gxicclC5YEgL for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Oct 2024 02:19:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2407::600; helo=nam02-bn1-obe.outbound.protection.outlook.com; envelope-from=parav@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C5E666064E
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5E666064E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XuHx4UhM
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20600.outbound.protection.outlook.com [IPv6:2a01:111:f403:2407::600])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C5E666064E
	for <virtualization@lists.linux-foundation.org>; Thu, 24 Oct 2024 02:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuD78S4PqcSbPtk/oBu2PQswYYUuyZIHRK9/1irBwv6BOTGTd1FBIgnUXC311NyeA96JdTWGH+mZzJNC95tAEe+iGsGVU+CQWlH1yxlsijOM++43bQnFpLRC6PIZ+9H2SsIDgGatGXAwna1J/XEmYIFhtVQ2sUBG6Gp5JsWf9LSLijJo4tpMrVek0zx7BmrE5NCbsEwhr0C9/HL8WdaaldIJoNhbPGsRY74GIUU244XN6yheM9KxJvHLQWJCPFvv5eNJhzlq9VFKe5z++NAroiV2B/OdmqNMwT/WTfVHc48O1YiieZcElwD7KHfFupyRFf9bvsvFS6Mq/ryFGEmLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2t4whE7rcCP+Riyj646Iih1KKVz0zhO9++3dpfWSsA=;
 b=jc3x3Yv8Zq8GRRiwPpXbHMpSPnSvKxSprR6ePUKf4jquHmhOIr4caM33kjb+3SX9E1ocDETi4MDekiCoEUzzFrzTDJauaJ0BwIzebETwwBb7MZHjs7ftvub02qL6WNEandQdeWAqlZ/TNVgu5h4CDv7+9nQS4DRf58HBOnD/9FoUNgVneoV6c69UdTIVtXO0VEag3nuYdDQRYDz/tDajyfYaOH97OA07gs0fOIxlmLGgk6StB2uHaI4VgAIlgiOSNC3SWdc6hAzZmWQC01JFzGGD7l/qCb+D6N3PF2JgfGRN2jgXSbIYZvAZksOWQomIwX26nD/yLm+USj3nxJQ4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2t4whE7rcCP+Riyj646Iih1KKVz0zhO9++3dpfWSsA=;
 b=XuHx4UhMOPA/5mVWon2VO6gQ0PnUUzBwVyCNyejRyPUwPbtz4ZTt1BlgI3hN+gLj1VkPtWMGDSF57NiUhD/kG5Rc7ZYqJbAxy+UFlNa9lIzz5iq4qttBfNUtbx6a3HFDXVPMSnj7vegl093JuLhFOcY5TF0+sBlN9Wo6W0coH3d3ZKE5v45Yp5Z+HbuYZB3O1m+6GZsEeU0tNVNNLwBhTOi7eEH6oyO4NcEX+OoJRnmml1NPn1MCmFIVjxFgl25kCn5X2xmlCpI9MFkNT2XCQCqpMa+i6pT32jWflQyqW/wf6gjtrgte8hz+IxvOjb39QpI3g0kcmWSUDBDkksyMkg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by PH0PR12MB8824.namprd12.prod.outlook.com (2603:10b6:510:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.30; Thu, 24 Oct
 2024 02:19:08 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 02:19:08 +0000
From: Parav Pandit <parav@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "dverkamp@chromium.org"
	<dverkamp@chromium.org>, "mst@redhat.com" <mst@redhat.com>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "mvaralar@redhat.com"
	<mvaralar@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-dev@lists.linux.dev" <virtio-dev@lists.linux.dev>
CC: Oren Duer <oren@nvidia.com>, Nitzan Carmi <nitzanc@nvidia.com>, Ben Walker
	<benwalker@nvidia.com>
Subject: RE: [PATCH v5 1/1] virtio-blk: Add description for blk_size field
Thread-Topic: [PATCH v5 1/1] virtio-blk: Add description for blk_size field
Thread-Index: AQHbJNmbwr9LZ7Et0Ey+Z8Qo57DBgbKVKwnA
Date: Thu, 24 Oct 2024 02:19:08 +0000
Message-ID:
 <CY8PR12MB71956ACE2D3290FA267B060BDC4E2@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20241022232435.20799-1-mgurtovoy@nvidia.com>
In-Reply-To: <20241022232435.20799-1-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|PH0PR12MB8824:EE_
x-ms-office365-filtering-correlation-id: 8a8ab3ee-e127-40c8-d4ac-08dcf3d23dc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?c4JSfsWUGUh/kDqCWnRXjbSUSHjkI6hCIHkPmE4aN0zOAwMw1t2+pAsmGKMp?=
 =?us-ascii?Q?IEEIPF61tc3+wScKkr3a/qvr/LhaElLl9/WPBxPSc1SD4BgsWgF9ftNpSr3e?=
 =?us-ascii?Q?xtP42012qHVNSSJPcXKuGQSw309eAjFQnURp4i4hZSEZ8Sz8DKzSFn9D7YQC?=
 =?us-ascii?Q?7YsaCpJVg+a6LsV2TZlKenKcD5mRAtChixFprIz0DTcvFG+sZyuwFSp+RjJD?=
 =?us-ascii?Q?SVOplex7qsAjet2gz3HJ/w2p+banLmbUg22HHs7MDynpKQ84VWhpTawcheIx?=
 =?us-ascii?Q?kxlN79mu2b5svybt+Ovfub1M6seAsD/XUYxzJiG5FoGxazlQ5VRR8eS1VsyG?=
 =?us-ascii?Q?TNXUvIJMjQWw7f12RHdRDfeiNcDivOCVIIGSglHOP+IIU6C6Q7TaBtavzs6H?=
 =?us-ascii?Q?1FPSqUNDBihnzo71oUtufG0T/Q78Uw+NgjEQjb2LBoR8uUjp+u7HjReawPHs?=
 =?us-ascii?Q?QDNqT9VhbMkVdumXcZ41yuZK/azc9ybuwpxgt0Zlf20fE//X31fs7+Wmvnip?=
 =?us-ascii?Q?gMOb/vHUvYd3fyeO0+mqeSnFQWMk21OrmXsspFFayW7v2iZwuX+CjvHu4Gc6?=
 =?us-ascii?Q?hfs6G4QFNGlTQGdsC1Tg9tIz/fM3rMbR1U6SlxOARFnJ/fc3qYoTDqu97LbQ?=
 =?us-ascii?Q?GNwfLQ4dGIm09JZfGJfCD8bKChrUGUHHWIlMv1I6eGygkQ8iyjGaKTRCpery?=
 =?us-ascii?Q?OFte3oNvIf85ABIvK5RzTT8tgohQ9hleqEVeaO6v/kObUx8uaOY9nxaHeO5D?=
 =?us-ascii?Q?HEokksBWgXiahdUAl4ZCpIxG9yeKgeuX9LqNuhgzZDCDTq8iFxvxJnxFpO7E?=
 =?us-ascii?Q?ramEiCbWQRjvl/EHPiBXvSB4ISioi/EcdL5jqw9xiWfkzH+PLPtXa0HKD6X2?=
 =?us-ascii?Q?jjzavpdLfGU6RArECcI/zvXenX7zEiEl0wZyeIFwU2Eo9aGAi+SWV5pL4/6X?=
 =?us-ascii?Q?LmoEv129OjU+xLmBhR6vefQOC6VMEwbvRR92NQb7z1Cb7gmN4J4DlUD38F3P?=
 =?us-ascii?Q?NPq+IaA/uBsP8mVoAUW/BWd7xKe/3cYQ/Txyf0mUX54iFLzm9/2MitLPQZoS?=
 =?us-ascii?Q?O8uzbf+zBo20WnHtftAGIVPKLMpVDjCdSawvO/xBwo2F2i1alid3KrYG7l9q?=
 =?us-ascii?Q?I6Gr3QwnaJKNXqNGzsxb5VKF5raLmh6jtoSqftquxci0faO5cpgIgC/Dg0p6?=
 =?us-ascii?Q?hGo0TNXz7Kk0rHlLrehqPrakh1Vh6qRH7Fmk0wbCloU/d/3LOozd+/Qk3Tmg?=
 =?us-ascii?Q?FsZmqfhoP/fHLO6AdKQGRLorUvNeUz+pUpV9amk5AmcT3ngvvrfYKgkEG8Up?=
 =?us-ascii?Q?R4vEs7QzfTD1E+5mJYeGL8kLNUt7IX6FylobsFIvVz322uIRRrX1391GeLWA?=
 =?us-ascii?Q?L1YME98QinkAMhrLro8OCNg6Zggb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?y/Hc3HtAtbkhUAZjYVkZJrDWvcXiIbLVI9X1AHbH9ccYBOmIfE8UowsHvN4I?=
 =?us-ascii?Q?a2vHrdGxvx95tQa4etXSEFaMU31V68dAnbWwbSkn4XdQdzdwbLv5+KplHHVj?=
 =?us-ascii?Q?K27KROJiyBNjnSks/AwQzlSVQBzeDxwMjDMCEXmnNY0faNgYZMr7ipvDlxzi?=
 =?us-ascii?Q?Cn2voqgXYZNLAQpdhBRGN+3OLfUhlyhUoizVy/iK+sfWMxqRFIvrwNsk/SnI?=
 =?us-ascii?Q?mLDMEa+Qo74q5LSIWU7EE25nodkHWg5nLMUxmxc/3/iht3hn97nSxpN60Gti?=
 =?us-ascii?Q?zf9RtQnHXS+Hk+owVdkJnqnrDevRItigqtnrGNtiddN1pvFa4lKZv5g7DRG7?=
 =?us-ascii?Q?1l8op8DQ5WUfRFyIvTjDgr8La0NRJPuTnqRp0C5KfGo8plJXeBwnwGW50VVQ?=
 =?us-ascii?Q?I88Ex6t0znUIzTyiSOxDd3NbAsoWFj8zUIMBLBgODAHymkh5UTdMDaCK1wqF?=
 =?us-ascii?Q?UIZb9tEuHtfvgX281OyaIBA6PAerJFZ5WJQq9AJ21kn3PIE4Pp+61LIvWgv2?=
 =?us-ascii?Q?hLMnqX1CfssrFf5E/q+sEJq69mH9XfLapL6wp3NuIE/vXUxzkT14uPFxFFmZ?=
 =?us-ascii?Q?ZTO6MEeGnLTt199rPp6knqQi8ejVorCKOwJRhoUBZqQHWsvuzB8HladfTnYo?=
 =?us-ascii?Q?GtSQquqlIV4+Sg/3mTEy7P7rOeJUtl4GNInyj6YT+SouFYlLtI+CagPNK4zO?=
 =?us-ascii?Q?Tn2T2OrrF6jN0m7I1kW8s4JnCrjJvWG4QmYeIv3KboBG/FOLj7QpMeToOx0A?=
 =?us-ascii?Q?zmBCqAuzaYE/cFiOLgUxlhIvEy4T+sr2m8KPrbDN8ePssaV7tLBUM4ai7ARf?=
 =?us-ascii?Q?P5HszxQqdMsfHlXcEG46wMgu5r+m3PY4NYKDvIAdO6yn0nI2vGei/7XGXfU4?=
 =?us-ascii?Q?HA16ZCWHFx4jKkMRrqQJliXOO7Wv4Us8DO9yCxA53dX+CPBkWuSC11k04jmj?=
 =?us-ascii?Q?HjjrUwBAVjGGvTPgkWQqr7Z57SWe9fxjjd+3afo1K8XJ+yxtK9KOQ95JKPBQ?=
 =?us-ascii?Q?slwrFYGxeu+/IzAbg0go/uXmFaxDSxUwtfpxLM3ZUWweFi1u/ISNVXfLj9eG?=
 =?us-ascii?Q?w17nz1+D7DRnyxaObzk2snifpkgSXg5oe888W6HppCDf8Jqhfc5jV0nP3X67?=
 =?us-ascii?Q?FuCFpsPnRJ/6k8psu3GzQgUR7jsgP6+//GSgmyc3GSd6IG+OgbG7YAzyFjBe?=
 =?us-ascii?Q?CDrgWg0UPyFG+3LC0SRIKAdMrurZJ+Q/QAqDAk5W1QYRNyapOqJbQ6rN8IDJ?=
 =?us-ascii?Q?KEPsOp31PByrKl+pv7El+C+FOTVUVuT8YxVKLW2+4TdbHAcow0GjYHeyGEQc?=
 =?us-ascii?Q?wcQKdRJs7vC79f3kFq3uKy9fYbTEvKHXLEyDsYkE50owuMOobTDABC9rlwRR?=
 =?us-ascii?Q?Hi67K8LEJJ5zkF/AVZ2Fhv4XKnbNh+BJYzZA+wyoCd88TpQrHn3O37BMVSWU?=
 =?us-ascii?Q?+QSTkNXRU1/INsYDyd2oMYi7zfkPFIRWu3WTmffZxkNVA55vwDrVluCnbocA?=
 =?us-ascii?Q?dUKqJR0Ka0qroRDURXexvPZD0/8RAPU8cSbEk+fGPAwDsFIw7Ck30qHuAAFZ?=
 =?us-ascii?Q?7CiUoKV1zbO6//hI8GI=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8ab3ee-e127-40c8-d4ac-08dcf3d23dc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 02:19:08.3978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3yBLCK3zTY4BM6oWglVjDOWoMusFJtxWOkf1jElR3y2MsPh4OweZqqnqSznXsHD9NDMikJuiYc7P3SXFDkcFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824



> From: Max Gurtovoy <mgurtovoy@nvidia.com>
> Sent: Wednesday, October 23, 2024 4:55 AM
>=20
> This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is of=
fered
> by the device.
>=20
> The blk_size field actually represents the logical block size of the devi=
ce. It is
> always a power of two and typically ranges from 512 bytes to larger value=
s
> such as 4 KB.
>=20
> Add description for this field to provide clarity on its constraints.
>=20
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/208
> Reviewed-by: Daniel Verkamp <dverkamp@chromium.org>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>=20
> changes from v4:
>  - reorder paragraphs (MST, Matias)
>=20
> ---
>  device-types/blk/description.tex | 33 ++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/device-types/blk/description.tex b/device-
> types/blk/description.tex
> index 2712ada..093a139 100644
> --- a/device-types/blk/description.tex
> +++ b/device-types/blk/description.tex
> @@ -135,6 +135,10 @@ \subsection{Device configuration
> layout}\label{sec:Device Types / Block Device /  present. The availabilit=
y of
> the others all depend on various feature  bits as indicated above.
>=20
> +The field \field{blk_size} reports the block size of the device,
> +expressed in bytes. This field exists only if VIRTIO_BLK_F_BLK_SIZE is
> +offered by the device.
> +
>  The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This
> field specifies  the number of queues.
>=20
> @@ -282,6 +286,13 @@ \subsection{Device Initialization}\label{sec:Device
> Types / Block Device / Devic
>=20
>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / B=
lock
> Device / Device Initialization}
>=20
> +Drivers SHOULD negotiate VIRTIO_BLK_F_BLK_SIZE if the feature is
> +offered by the device. When negotiated, drivers SHOULD interpret the
> +\field{blk_size} as the logical block size.
> +
s/Drivers/The driver

No need for plural. This will be consistent to rest of the spec requirement=
 sections.
Some existing requirements are using plural in blk and other places, but sh=
ould not be used as base line.
=20
> +If the VIRTIO_BLK_F_BLK_SIZE feature is not offered by the device, then
> +drivers MAY assume that the logical block size is 512 bytes.
s/then drivers/then the driver/

> +
>  Drivers SHOULD NOT negotiate VIRTIO_BLK_F_FLUSH if they are incapable of
> sending VIRTIO_BLK_T_FLUSH commands.
>=20
> @@ -319,6 +330,10 @@ \subsection{Device Initialization}\label{sec:Device
> Types / Block Device / Devic
>=20
>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / B=
lock
> Device / Device Initialization}
>=20
> +Devices SHOULD offer VIRTIO_BLK_F_BLK_SIZE. When this feature is
> +offered, devices MUST initialize \field{blk_size} to a power of two
> +greater than or equal to 512.
> +
s/Devices/The device/

>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it  if
> they offer VIRTIO_BLK_F_CONFIG_WCE.
>
Fixing above will be separate editorial patch unrelated to current in revie=
w.
=20
> @@ -879,6 +894,14 @@ \subsection{Device Operation}\label{sec:Device
> Types / Block Device / Device Ope  The length of \field{data} MUST be a
> multiple of 512 bytes for VIRTIO_BLK_T_IN  and VIRTIO_BLK_T_OUT
> requests.
>=20
> +When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, the
> +length of \field{data} SHOULD be a multiple of \field{blk_size} for
> +VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests.
> +
> +When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, the
> +value of \field{sector} (multiplied by 512) SHOULD be a multiple of
> +\field{blk_size} for VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests.
> +
>  The length of \field{data} MUST be a multiple of the size of struct
> virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
> VIRTIO_BLK_T_SECURE_ERASE and VIRTIO_BLK_T_WRITE_ZEROES requests.
> @@ -966,6 +989,16 @@ \subsection{Device Operation}\label{sec:Device
> Types / Block Device / Device Ope  for a write request if the
> VIRTIO_BLK_F_RO feature if offered, and MUST NOT  write any data.
>=20
> +When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, and
> +the requested \field{sector} (multiplied by 512) is not an integer
> +multiple of the device's \field{blk_size}, the device MAY set the
> +\field{status} to VIRTIO_BLK_S_IOERR for both VIRTIO_BLK_T_IN and
> VIRTIO_BLK_T_OUT requests.
> +
> +When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, and
> +the length of the requested \field{data} is not an integer multiple of
> +the device's \field{blk_size}, the device MAY set the \field{status} to
> +VIRTIO_BLK_S_IOERR for both VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT
> requests.
> +
>  The device MUST set the \field{status} byte to VIRTIO_BLK_S_UNSUPP for
> discard, secure erase and write zeroes commands if any unknown flag is se=
t.
>  Furthermore, the device MUST set the \field{status} byte to
> --
> 2.18.1

Apart from other small edits:
Reviewed-by: Parav Pandit <parav@nvidia.com>
