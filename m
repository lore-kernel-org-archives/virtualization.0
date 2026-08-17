Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023124.outbound.protection.outlook.com [40.107.162.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916A3B83E3
	for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971691; cv=fail; b=ov7RnZQR8BuX7sKDychIqBvJrtyL6rUxN2p9v3nCh9OHbwu5tA0gie5+eSwfiPXceCZHS9ukG5B8WvG+GbN6SAkYZW9O5XSKGkp3Hie1olG4Vpealoi0dY43kPBPrqJD8B6SzujwBEOpwvWIPiCzTWBieHU0CmZXIJwbDYZMNHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971691; c=relaxed/simple;
	bh=gwnbMRX6snLzL7cgrHyKuUZ5Zg89/13UJXJhsu7PnR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dWlmiXeyJ3JZpSwkqlpwfpRoHQWoMc4HFA9Q35c5F5XEbyKfxPTRXDxq/L/fc+RHW24NUrBIW8ahIiTc95FVMw4UHI90cYPuSNB6pj7DqXnOZc397j7ZsciicG96fxEBBHkzP28jxbCL8J5HRkpgBYdnPOCEQNdRd2uerr2C9ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=studenti.unipi.it; spf=pass smtp.mailfrom=studenti.unipi.it; dkim=pass (1024-bit key) header.d=studenti.unipi.it header.i=@studenti.unipi.it header.b=hdNjrHCj; arc=fail smtp.client-ip=40.107.162.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=studenti.unipi.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=studenti.unipi.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=studenti.unipi.it header.i=@studenti.unipi.it header.b="hdNjrHCj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4muf9Pt/1WN1K/SimnAtcPs3iTu9hdKiQeloiEXJuBfEWBBMl5b5q/Rno/pFg19MOCKSi8A5HlCWkeDPX41UXhRnWePGTpeYe/D/oDglPFFgxyag2zVVpcfbZKpGGUKN9IqBfhmjC+5yJC3Z3Q5jTKaBh56nyfAdq5RUS0d5XQnD3CmSVjpV+it1sEXJEbeFlei6CosWytNfieK273RNe0ARbOuKI/m24k4g+HQSul7J672XPz8WYmj7lqEDjL2RNMPXDsibv6sm1qiD6/UCfyT+WCGd6J4Ag3PPITZLCOMskrqqA19fGuXdBJQdg2XZuPe14rsYBxZMQBXuOl7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwnbMRX6snLzL7cgrHyKuUZ5Zg89/13UJXJhsu7PnR0=;
 b=woug/bX02LjaYfyKh6mbKaN58aQFCeGWBvq69Xb2jfCjM8k31IgOeqaF9dpUbGna3gFpV7hy7IY3XQ6HOLSD2Zh/K577Zliu+gFXrAqklCuDXgVcmz+h7p41o742qdbMwQd50elnosSNIU0h+fmFJ3uxVBFxdfqxltZl6p+oc7TLrv/2yEp6avhYjQnXSHY6D5WrPwMWbWd58Glm/ID/oseBJpij0iHVWaS+v9utM2ZHYJz0IaWJcvNz/9LlZXMBh9e467HqKl2tPqqmHJ6E1tvb4IC6x521r1zuR1jQQcXLpNP0dfBs8NCVA1ihX2v6Scw2Fv+b0vqqYVn+QVyN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=studenti.unipi.it; dmarc=pass action=none
 header.from=studenti.unipi.it; dkim=pass header.d=studenti.unipi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=studenti.unipi.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwnbMRX6snLzL7cgrHyKuUZ5Zg89/13UJXJhsu7PnR0=;
 b=hdNjrHCjmP7c+lYyTjhw5SX33tB8fUkGv8HBLcU7ISwAI8MMgO4WGuMOsZ8kRaBof2oqxQ2ogtgEzOfKFUIvjG3n7zRf5D0fCKW/Q4SUZRvZfCK/Te1XshojHaoVycwHaWdkQhpF/04ANT4pprc46y/N1Z/5bB08E+c+DSUoxog=
Received: from DB5PR07MB9477.eurprd07.prod.outlook.com (2603:10a6:10:4a8::18)
 by DU0PR07MB8764.eurprd07.prod.outlook.com (2603:10a6:10:310::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Mon, 17 Aug
 2026 13:01:24 +0000
Received: from DB5PR07MB9477.eurprd07.prod.outlook.com
 ([fe80::d1be:a299:c9b9:ddf0]) by DB5PR07MB9477.eurprd07.prod.outlook.com
 ([fe80::d1be:a299:c9b9:ddf0%5]) with mapi id 15.21.0339.007; Mon, 17 Aug 2026
 13:01:24 +0000
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
Thread-Index: AQHdJnlcNrl6Tzh57UqO2XafG8uVA7aiQv7T
Date: Mon, 17 Aug 2026 13:01:24 +0000
Message-ID:
 <DB5PR07MB9477B461B0993275162F08E2E5A72@DB5PR07MB9477.eurprd07.prod.outlook.com>
References: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is>
 <anXnRcX65PnfMe9W@sgarzare-redhat>
In-Reply-To: <anXnRcX65PnfMe9W@sgarzare-redhat>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=studenti.unipi.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR07MB9477:EE_|DU0PR07MB8764:EE_
x-ms-office365-filtering-correlation-id: 0b89b2b8-04cf-4a0c-4254-08defc5fa447
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|786006|1800799024|366016|38070700021|3023799007|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 iyH2B9SiE914lUc7u4ZL/xaTCccan7Gg/TM3xRbQrXd4OCltb2LMImVG68DdPb45QFrnbusb435sB+dJ0neAByXFQAGoikoHYa5qPZ2OndyCIMRYdt89kVStcbZ444y9rLy18KttojZuDJWvVtAmAI49V749uW1s2mPGyF90L90n26Dt0REi/ZYq10XIRDSqRp7VnLZijbovldEenNGbKzYTbF+HSVKSN32a0HZydu9cSUQzRSX9FuKblOR947CTD1GvJ+jeiWwR3StpRqYAik3ZKH+mDntToKrqCZzA2A2Ao1Cwq7con+t09hQC8rjIhaU4w1+UkpexI9XAW6UAMWuJ0jzFhQGKzXfYa+mH5fDCzUo5OSgVduaEU+pM6B0HPrP/YtlJrvxCESpymsNr4+afr3JT61u9+GTlpvfR3Y2+CrdC3Wm6S+Qt1NBQuW3J8qhKf5VEI+odwNG81H58SLGVCOoNtlK2fAECGx493JBS+mGXgEz8Rc9UUTezqBaWxQBSTSKuo+6LIwbHqZAS8uIgnnBRcuAXyn29Q0z0QOW+giuvjOKZkaBGZx08XsJo0xG4NfgBFwJ3+ceFoPTwRFLE3IjjTrRCNWe1Rwqznev3DvRC8wJaloCTFW8t1Bsbq+6gm2yxi1Bj2yLeoMsKXY5aPEtzLPnPmHuzq9aoipVl87XcsaErHNWrhwonoIOU2OLLAgYvFcQxGO0FlO59mvarM73GQhXBw4aw7zVFRhI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR07MB9477.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(786006)(1800799024)(366016)(38070700021)(3023799007)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tivrpoD3pr+SDHhJg9vLGlFpry06brxfltC7nTPzRttShbGw6jloT/6qiI?=
 =?iso-8859-1?Q?lm9AI8tsBn2h/ufvS5cGlUC2gZDqj+s9SbvoD3sdHuobSpm1vPvTL4fOji?=
 =?iso-8859-1?Q?fFpyDAZxNIrCrKE9PoGcaYnB3+UHGZqFDJLL0cKM63q0/lFtqThncXooMq?=
 =?iso-8859-1?Q?4rs8mKk7o6cNNqKoeWqjwWOUHnB838OKuGKb9S2pvHX/T4r+iHOQ4rcE/P?=
 =?iso-8859-1?Q?LAsRDTq8w+XhkptGFPJGQnij0EtXqeS9Sz3GMHDAX55JyLAGtlN8Z8s07B?=
 =?iso-8859-1?Q?fajP+pZcrWD57Vxfd2Vtfrko7pONZ76dIXl5qqVRbllX+Jdb0GTOgmlQbF?=
 =?iso-8859-1?Q?Wx4Bd/RchivNPmpBHw3hMs8f9emal8q3iUvZfxdPfYti0C5LRf/ixKL6Oc?=
 =?iso-8859-1?Q?sXQAwQfPiWQAb49eSjNB9/N0koMijoxgfMWzE9ahL8We1EoX63AnwUgfBi?=
 =?iso-8859-1?Q?c9/RzLRA2Ce8HWyyjzfKrvPXNAeK17g2kULp88T+r4FS2i+Gb8D6FJ9/4Y?=
 =?iso-8859-1?Q?xfGL3QbW2Or6FSQ3BhZpgHpYxjLieHPiJ4wH1olgFqrBFL3RLiOj97ytUb?=
 =?iso-8859-1?Q?INFjNJxVZw2kJfYVbQ2k0duuz/6TQroFxAJ3s02fW3BRMwHsnEHVuLUalk?=
 =?iso-8859-1?Q?vjEOgbLbd0vadAgXulktNEEvporVOnBQ4G9f2sYUPxtLVIbIutQNaUsNBy?=
 =?iso-8859-1?Q?EiqrJ/mqr7e6PvzbEUztL3qWOwSaTnnOzkO4y2GFd7NdHui8MshkSP/5IH?=
 =?iso-8859-1?Q?3nPpNCPXQXUlpth++e/PXKO+fDdDmO4rq5/mk4D41zDv/clk9g4sNFuEKx?=
 =?iso-8859-1?Q?HFIr6Z65NS+2vxA8qUG6YLMvfXe6TmHMBC8RfvpIRj/7kyXinT1Iz2Q5Ke?=
 =?iso-8859-1?Q?kEUMmfspknxon2CgACUtrdVPQZGyBlYZaZtLhvCicvUYf3qiriFAo6ua0y?=
 =?iso-8859-1?Q?oQPPRe0gGRsHyQdysTfVfCo6bIlyb2JNIqplmO1j/8cgmO1BVwskOGFtRV?=
 =?iso-8859-1?Q?5wIAqCb1+7F8OyLSwNSkklfL3CQ0XPMtoHvZX3hTpEM1TzIqUVMSvo/Y0A?=
 =?iso-8859-1?Q?Enbrt+3kWdWVwaNWyxqMVHorkFxXrxQMfnq8KRssEeVSZSJQwAAl3x6PXS?=
 =?iso-8859-1?Q?TMaudNnSJ+jRAKUFQl7k1W5MOYqppSkwyDpCXCFKf80gvmg159lx9dY3cs?=
 =?iso-8859-1?Q?e4G0/bGIQFKiJQFy8x0CHOwRSLdQh+CypW3af5pEwxICpNRCDSbop6J3Bm?=
 =?iso-8859-1?Q?bDG3XZpr1XYme1BElRzgqgA1tINFaP988E2iUNpRq0Y8s16KkJA4jln1Gw?=
 =?iso-8859-1?Q?y3V9JqcQy5c0E6fbGdwdaXfFbX/Cf/9RSQ8N9nMlpZsVCge9YVv6cT2U9X?=
 =?iso-8859-1?Q?yEH1RigY14vZPWsaDNqKHlJuMVmPuD+9ju9kQwF9slgkXVZNh2NiuAHuyz?=
 =?iso-8859-1?Q?hGUk/ybDBa7eEDLQ0/wOuDk25Mv9+4j8/XmmFhvuADpbLkC94O9b82I7sm?=
 =?iso-8859-1?Q?dEX6ii93stD8u4Hcwe7Nc7IHwe0JBupr2YN8PTRHibpEk3Z/BUeS05WVBA?=
 =?iso-8859-1?Q?JJdC6SGytLmq3IgNVuvkMMBJCTi6ZgY2IPP4mLWGt4SZysCCz2E77A5OXy?=
 =?iso-8859-1?Q?aAb5w4BJA1svvrMjh0MCjaNh95StE2Tp0RrwFoS3KMWsH1yeAt4qonCXU5?=
 =?iso-8859-1?Q?VUHqFUIiu4PTbngAPwpU0C0iqAu7V/0gF+pbpADJT5iG7zFUszOScYMtha?=
 =?iso-8859-1?Q?T8aDALiabGhxmP3CZhl9O1HkhxGoR56+D6CLcy/QR8t3qctF5G8O53B2fM?=
 =?iso-8859-1?Q?b4Hl+SIyqw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b89b2b8-04cf-4a0c-4254-08defc5fa447
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 13:01:24.0932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c7456b31-a220-47f5-be52-473828670aa1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ci7xaazBm/Gcf9Dd28yZwxyIfOP94r8JqGgU3sEy0I4OBGLJTWxRDgGsC/0NepMSUjdsoej03JAYqrpO6EvIoboz+IhPeVqpliKiZoFPDko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8764

> We are mentoring Matteo who is working on his Master thesis at University=
=0A=
> of Pisa. His main effort is to provide crates for virtio drivers (e.g.=A0=
=0A=
> virtqueue, driver-specific request/reply processing, etc.) that can be=0A=
> generic enough to be used in different OSes, providing the right=0A=
> abstraction.=0A=
> We pointed out to this series and he would like to collaborate.=0A=
> Matteo and others can add more on this of course :-)=0A=
> Feel free to continue in-list or off-list for sync.=0A=
=0A=
Hello,=0A=
=0A=
As Stefano said, our purpose is to provide generic OS-independent crates fo=
r virtio drivers.=0A=
To begin working on it, I started from the VirtIO framework introduced by t=
his patchset and=0A=
extended it to support the virtio-rng driver, both to take confidence with =
the current=0A=
implementation and also having at disposal a simple driver for tests.=0A=
This means that I also had to add the HwRandom wrappers.=0A=
=0A=
You can find the virtio_rng source code in the following repository:=0A=
https://github.com/matteogiugni/rust-virtio-rng-driver=0A=
You can find the HwRandom extension to this patchset in the following repos=
itory:=0A=
https://github.com/matteogiugni/linux/tree/virtio-base=0A=
at rust/kernel/HwRng.rs=0A=
=0A=
I have recently seen that you implemented yourself the HwRandom wrapper, wh=
ich followed=0A=
a different approach from mine, but did not have the time yet to study it.=
=0A=
I used the same pattern as in miscdevice.rs registration instead.=0A=
=0A=
The framework was missing a few bindings for my driver and in particular th=
e scan=A0callback,=0A=
you can check the modifications in the commits.=0A=
The driver is a simple baseline that can be optimized and improved.=0A=
=0A=
After the driver implementation I moved to the implementation of the generi=
c Virtqueue crate.=0A=
I am currently working on it and i will be pushing the current work soon in=
 this branch of the repository:=0A=
https://github.com/matteogiugni/linux/tree/rust-virtqueue=0A=
The aim is to make it work with Linux at least, with your implementation of=
 the VirtIO framework=0A=
and then extract the OS-independent logic.=0A=
=0A=
This is just a recap of what i am currently doing to get in sync with you, =
feel free to look at it and=0A=
ask whatever question you please or problem you see.=0A=
=0A=
Kind Regards,=0A=
Matteo Giugni.=0A=
