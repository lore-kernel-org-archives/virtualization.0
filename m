Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023117.outbound.protection.outlook.com [40.107.159.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B903B5E10
	for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981983; cv=fail; b=Gt2VtYLEeMOr07+DyZU2y1XSMHHn9zIRvAVYg4Kwks9+PfkS1smh8KLI0uU4rs+wfOewjE2x8VynYXKzEiDGyHsaE3gc3dCU2zA08aS1ApdmBEjHRKDduoRJlew7Vacx/lalkc5yUHLioiocdYW30nftEsGWl7YLex9K/cHhqjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981983; c=relaxed/simple;
	bh=QEiwhtb16KKTxnSNJvcWA5VSHV7yPSwD5tBHmgBK8e4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oMBFHjwZt/6TIyupC3YqCP8i0s3cH7IxGGa9oj2g8mSs9PT4lUN0Sz2w9o9cw2nXF40LITNHXRf5BrOkpoKvSbngnCDF5iMpocxRn7UxtGsYfyIRvxpb/TMELFqbuD/ouRJVV1CfAguq0Ae/IyandEvMsAdvSDbJGT4Kz2vM1DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=studenti.unipi.it; spf=pass smtp.mailfrom=studenti.unipi.it; dkim=pass (1024-bit key) header.d=studenti.unipi.it header.i=@studenti.unipi.it header.b=FAK0d25+; arc=fail smtp.client-ip=40.107.159.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=studenti.unipi.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=studenti.unipi.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=studenti.unipi.it header.i=@studenti.unipi.it header.b="FAK0d25+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzujJc9VQbweqeDPn1CkS/nox+E2h49D04mfb+hmL/bYUevcDVaSFj/n5Qm5yZ8vkNRAQTOxh4TmUNcveHwBzVCe9dfxnbkz8V8D6WEaU9kjgUEGmOv6nj/R4RvKYWVDSkf9OGgeh3kh/5AED2dpcYLo1Gs6XzojgO/Kk098jjJBVPul4X796Bjw9HdLY+yt5+rO1Pdyx//vMUTlcrIpY8Kt3qP6z7gLrrVwAARtsrmIIbgU6CCiIkPb9m4FzobR74EnZFSc25JdQQ/0NYLkqM33TbXxu7j+B9saj+psYHVDvEowMupr9rw4q7JsPotoMg/075/piXpkAbOsyHFhBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEiwhtb16KKTxnSNJvcWA5VSHV7yPSwD5tBHmgBK8e4=;
 b=aEIyqaxNnkVDZyFCjEKBhk535Z039d/isarw3Y7AlcgzQ72WEKZNxzHet0MhPQm4CHJEJDoWEDssLY62gxFTyRGAWxDxdrC0nHQ8p/h0xk4uj3XjHYczSlPyteB+TKmedV505PPRCE4E0vA3nFORIZJ95MrD/49Ti0LJwzC7TJaFcByg3rmCToGtVdlMd5t/DCsShms64Z7k21PqTkv9zQ2B/OO3YzdoFwWWKypFmPis+bYKrvmWeF5f2h36pei/gxcM5mSOn4Ow1OfVEQAcwXICF/GgrrdmW2wY2/Ml8LiwGDFCJf1xxejlhA4PtGSiZe7zOZ9cdGCvGbKela36HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=studenti.unipi.it; dmarc=pass action=none
 header.from=studenti.unipi.it; dkim=pass header.d=studenti.unipi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=studenti.unipi.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEiwhtb16KKTxnSNJvcWA5VSHV7yPSwD5tBHmgBK8e4=;
 b=FAK0d25+vw5qJIOAJ+GBdc78pNPe7ukCg2bBruhGdBRy0WZ5mWMDgbYESqbHj8wnWwLEJrSOWqlRk2QxudgD7YoXUJcnz//vE7MMVul6q4PlpLEwtkQhDIWrTUjUaOaGYAqnSYRbai/q9TscfuZHpZI0oPUzygvvWH08C4rkUvU=
Received: from DB5PR07MB9477.eurprd07.prod.outlook.com (2603:10a6:10:4a8::18)
 by VI0PR07MB12317.eurprd07.prod.outlook.com (2603:10a6:800:346::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Mon, 17 Aug
 2026 15:52:56 +0000
Received: from DB5PR07MB9477.eurprd07.prod.outlook.com
 ([fe80::d1be:a299:c9b9:ddf0]) by DB5PR07MB9477.eurprd07.prod.outlook.com
 ([fe80::d1be:a299:c9b9:ddf0%5]) with mapi id 15.21.0339.007; Mon, 17 Aug 2026
 15:52:55 +0000
From: Matteo Giugni <m.giugni1@studenti.unipi.it>
To: Stefano Garzarella <sgarzare@redhat.com>, Manos Pitsidianakis
	<manos@pitsidianak.is>, German Maglione <gmaglione@redhat.com>, Leonardo
 Giovannoni <leonardo.giovannoni@ing.unipi.it>, Giuseppe Lettieri
	<giuseppe.lettieri@unipi.it>
CC: Miguel Ojeda <ojeda@kernel.org>, Manos Pitsidianakis
	<manos.pitsidianakis@linaro.org>, Peter Hilber
	<peter.hilber@oss.qualcomm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Viresh Kumar <viresh.kumar@linaro.org>, "Michael S. Tsirkin"
	<mst@redhat.com>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
	<dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, Jason Wang
	<jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?iso-8859-1?Q?Eugenio_P=E9rez?= <eperezma@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: R: [PATCH RFC v3 0/6] Add Rust virtio bindings and sample device
Thread-Topic: [PATCH RFC v3 0/6] Add Rust virtio bindings and sample device
Thread-Index: AQHdJnlcNrl6Tzh57UqO2XafG8uVA7aiQv7TgAAwGYc=
Date: Mon, 17 Aug 2026 15:52:55 +0000
Message-ID:
 <DB5PR07MB9477346A42A4178FC9F20BB8E5A72@DB5PR07MB9477.eurprd07.prod.outlook.com>
References: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is>
 <anXnRcX65PnfMe9W@sgarzare-redhat>
 <DB5PR07MB9477B461B0993275162F08E2E5A72@DB5PR07MB9477.eurprd07.prod.outlook.com>
In-Reply-To:
 <DB5PR07MB9477B461B0993275162F08E2E5A72@DB5PR07MB9477.eurprd07.prod.outlook.com>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=studenti.unipi.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR07MB9477:EE_|VI0PR07MB12317:EE_
x-ms-office365-filtering-correlation-id: 151cd85f-6c88-4374-234f-08defc779a80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|786006|376014|7416014|23010399003|22082099003|18002099003|38070700021|10067099003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info:
 xjBPbenuYtLOZ0Xo7n5H5FHJ/gdcOFRYizXTViXjCizniH7LWIU1mguQ8rQ/+JeeYErksdr9r3ZT8BDyk27y1RE/2DhN9lmVwC6qtIJPczQULbR1Y9hTQEs91H3Az8MdgaD9LNB8rUN4U2YZk21cxKPuzZ0OudDWyqem4qyZ1+ZqTVcbO2EqvYlEEu2Fhq2DCb707oAU7dkHj2eqEZMgmygTxgEnQi5KDuj0uSgooQvU/zS9MO5eD/UtXc3YhB+EsKTppUlo0jGz3HwtrS6tq8uNOZBi8LbK8HjW1TpEWnorrFZco6nUTG1AMjZqrMB7jgg9lmRcOLXUhW0nNNKEgo2dh3OdHSNP2bA1SBSvzMJ7MZfp8lapgBpGWvExSWy6xTYCGR7vlkksciimPtISRnsM5Qp66raxgyS8Bv0VMGBTVRcH17K7vgO+gKT1rVHsDAwpaElvHMsJS1vx5Clu7351vBlRRb+wZzXOqSWAKXb4uTnWq21oxvNMRPSQcgqvYkVCKduHzi+5/OcR9waXP/Q/8qq+bMVWP8zZfwRdxrWpSy3oVfkunFN/KuWTQWQy5up0oAAl0O+Le224zi68Gj7KkMDhBqpOAAMFaQ2N1z4mGEQ6aewgnczMCqmojjF+L5t9+pflPNb5eqQfaaXly7XPJnqBu5dnyEqe3Lc0Y8L1MAboKcKDpQ/R+gSoFkY2A30/Cl5ATX381vWNUMtiifWkqnQAQXCs8mMtqL+31Dw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR07MB9477.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(786006)(376014)(7416014)(23010399003)(22082099003)(18002099003)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?03ngFVAdK0n4bYZNV98cUq8NldpMQELnq5hcHo70gdF4m0e1c9aakg+D3W?=
 =?iso-8859-1?Q?gdzLtQaYoDbbiE992DY7PBMIrCG63CLa70xLLNcI2vQJZR5weW39qo6FEH?=
 =?iso-8859-1?Q?xQpZjv5WFBB6eOBPtAMsFZjd1wB+LglTHGFJn/5/uIh/7pbhsqYuJOdJpH?=
 =?iso-8859-1?Q?yEyXSK7hq4QofHIO/3M/g7DKeNyobPKALNEV4lwverNPMgW2GqRKHLTFsv?=
 =?iso-8859-1?Q?vwNURydFVszKrX106oBZJ3qYyKr8rutHbEH6KBYLZd3CsLspZP1BQYl1Vs?=
 =?iso-8859-1?Q?ELlLGoAdv1NJn82zmMPhJPuPp6eHJZx98O3HOEBjVonEedoVY50VbCToDh?=
 =?iso-8859-1?Q?J0m6gObPaOVlOJ9l82XRQdqu6SufAk8jjDgrTSzO86wwv2a+OIt1tSZEMd?=
 =?iso-8859-1?Q?T5ex+dpgnFDLHbQr48XCMjvBopvyWN9K3SDIULPVsOnbCJgkiNIoBxfS92?=
 =?iso-8859-1?Q?UClZ+SZnCuvn1CqYb3vMGpftWeqcRZOgWiUgtEE3+FoRXtWt84HHWSfDZt?=
 =?iso-8859-1?Q?0lLhlQU4p3I/RO9+1I02LnSMQKLRGbzK5yQQf1l8LyI4ihQiI5ngjAlMgP?=
 =?iso-8859-1?Q?jTKpug7RYfpCV1Mi2sTTDRkPWullmWA44t2C9h+G72WBf3DOgFKxvefadx?=
 =?iso-8859-1?Q?naXj8WGMyxovDr5JjDdEuaOODKP/Dd0BkUQCLIwahMaQ45AenemOH8vnwk?=
 =?iso-8859-1?Q?g5+SlQah8SQrxGT3mdB2z9y3iEkmCBSP2i8NZHsKHqZ9QJ+g4b9wFjFUL6?=
 =?iso-8859-1?Q?kf575BufJ3b/VIeffXzqX03+duRqH40ZkVlQHXM+xfOnLi32Kppoo3p3uV?=
 =?iso-8859-1?Q?UoA87Tdxv8Gj77sjF0sBfi+NX1c0fCKrtzB6Ulc18CAb6m1AB6+/0qDwV4?=
 =?iso-8859-1?Q?LFYW9G6JfP2bTqOGj2rsdL1HHzZOyf3K7ASrv/BJDDlrrxE52GIbDVKD45?=
 =?iso-8859-1?Q?c1fCA8wF3YGKP+1zZwebf/CfDnJMH2M7GQSkY/0wRiA1dWLPwaNqZ0w81a?=
 =?iso-8859-1?Q?SCPz5qnSpaJ8DNTcv71M68L3b/6pejbzhMvahQe18viZ5lUvpEouAzI8wY?=
 =?iso-8859-1?Q?gY07NL/AOMkn1l5e++vDGVt4SWq2RE8QROqUKdkJH7oREoYi1Mp+WUnuvw?=
 =?iso-8859-1?Q?q0L+j1Z9O2z8llPIS+oWJiqw7Xreu3Z4CumUTtnc9OoRkVXjxjx4HQS/xo?=
 =?iso-8859-1?Q?uuuogKhElziPeb+KVAnRyN7sO5gcdKRZ7YHPwk2FJJby80fqJ8JqbIAYk5?=
 =?iso-8859-1?Q?LdFaU3OVxmcGRSro/qeQ+AN3uFP78uzgrtqVVv1Wcil+ZpbiWUowmRHbXq?=
 =?iso-8859-1?Q?66jkcRptT61BzKRv+VUtheJI+YNK0zac5YlO1UGJWanpdoNL9l1wIhUCiQ?=
 =?iso-8859-1?Q?AYOaBtnAJf1jwdjFaW4tUZDK1bRqhGzrvtbnB6M8quoewqXbh3BJ2MId2H?=
 =?iso-8859-1?Q?L0ev2XoQE4YCt93BRAzi+NK28t0GUMLf/YCypaQyyrY9p/fM/Y1qf9tkpJ?=
 =?iso-8859-1?Q?KPIEft37dGTEJASf2kNY+rDgDgYFQyif6I4L3oNMjF/P5XCx5E2TIzDX3u?=
 =?iso-8859-1?Q?eee4Wp7jlgR9EZpSkWCQNUcsMDcG0xyJ8PqwRx9gc/LBat77+mVpgF7o3x?=
 =?iso-8859-1?Q?ts6ka57zKnv1fRYYp5DmBc27aA8tmSULVcz9teNWojHVK4OQ4dJjTFgB4x?=
 =?iso-8859-1?Q?BHLxzx0uG3Xkj83TL/phyaVWWYerGxs6Boce4/ONxqFOmLR0XNJIFRmhVt?=
 =?iso-8859-1?Q?pP6Ip9JiwslmVIfIYGH9E4TNCytOd4AzMK0GW4oCDMinP0li3A45cXa2n2?=
 =?iso-8859-1?Q?ixHZjn1ZAw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: studenti.unipi.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR07MB9477.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151cd85f-6c88-4374-234f-08defc779a80
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 15:52:55.6093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c7456b31-a220-47f5-be52-473828670aa1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+hb43zfYQxhwQs0mQylTz6oo5zoRK1EorpGCqjVEHtgmpUHR4Np6B8r/cUTnw0wTrtFFhlBxIUtsV3B5g1zYuM6lgWRmf5zxsyB3FZeno4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB12317

Hello,=0A=
=0A=
Just a few remarks.=0A=
You need any help with your work?=0A=
For example trying to resolve the concerns you pointed out in the patchset,=
=0A=
trying to remove the unsafe code in the drivers' code,=A0=0A=
adding the missing callbacks (restore, freeze..) and bindings etc.=0A=
=0A=
Do you think the virtqueue implementation might be useful?=0A=
Do you have any opinion on the approach?=0A=
In the previous email I mentioned that the current Virtqueue work I'm doing=
 will be tested with=0A=
your VirtIO framework in Linux, maybe you want to collaborate on that.=0A=
=0A=
One of the reasons I wrote with detail what I'm doing is also to avoid dupl=
icate work,=A0=0A=
as it already happened with the HwRandom wrapper. Are you also working on s=
omething similar?=0A=
=0A=
Kind Regards,=0A=
Matteo Giugni.=
