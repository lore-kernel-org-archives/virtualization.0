Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795113413;
	b=E7Xgr2xyfECi740VryQqLuwvnt4nhDvIIt9o6jnSEB25DAdqODfy/g6jZzdmsDmOa8Aj
	 JIlQzZzZr4VbTU5TjZVJhaoNIg7SRzpqHRRSv5sTfjmuQ3wUX9mSYjHt/wHMQhc+GU50s
	 zsbbymYcy0XIFtFxuzlp2zrJrQ9QC6N2C9Y/nmllRG1SXKjywuTzwF9JTxDxjUSWxoUMX
	 h2/wa3KELr2e/09Vf3XORjEab+lXTzmmQhV0tIArcTI6Gtb3Os9ZvkcfV0DKLta0TKuSl
	 j2Nfju4N7BYARo+Y9poZAOWR6rICleGoc/hcaPpUnbUmZwDPA2yULYVsCl4NsZnBl4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113413;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=SbBt2kNglx4CFjfoRHa9xLdMCmxmHW3+wc2Bf0Pf3P4=;
	b=P6CKbHo+m1m9mdB3HmnnTUy66YijP5uagxvm/OCYodFIZW2N/LSPljiMObAOSF5Di6ld
	 iSNBVj0HGMQAHDKySBrCzbD4ZjUnwL6vmPQYpohUlefB1Do1kD408Nf7h/hqQ36LET5C2
	 XOUQMqJER8yjhT9KkV4F6flWSsjguRheM17fBrEbEmG1siOAsRaVPg55E93Cw3/NwCx2V
	 MaLPm2IjhloJaZ7W4sg7o0HcKqqbe0aNrIK1GN2q6NHiaZxHLtvzCn1C5ThwI8+bsuAI8
	 km6OaETiZnjlDdQ/XNx+kLc0lOMKFCNasA+9iAOoLp5sQoQD34eM4U4Nkig/0zmaEnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=C40iEVQo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.67
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012067.outbound.protection.outlook.com [52.101.53.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D53F606A320;
	Thu, 19 Nov 2026 18:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D53F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=C40iEVQo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/oiYwpKfX/n5ov34bzGc1yOe/Mu3T9JK5HgGW0IgvtSe3V9IEGQKp1Ojjh+g7eV5ir0ylB0P3i3NhCMUVTkJ1vttsOiiJsK8hg9/Ik/jz8K8XAUZ1AiV+1z57qcbdGZ6oOq38305Fa9KlI5nhI0XksCTAytITuMxBbtosxm/AM8LxCOnR+hkNH9lxfOgjgtzijj2blt7queSj+AntXLMbwjbcT042QTCKdUeRwBHbXRfNrynZWIYoSARInNjs6ZaNu79/64mopsjLJma2zwzGxEgVTVw+Krwakj1BenqQQNyyF+nQu3K9Ig7DWtw4rkPhfH9TLeJwAyJI6L74tfLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbBt2kNglx4CFjfoRHa9xLdMCmxmHW3+wc2Bf0Pf3P4=;
 b=TQoGVNLKvN8mhfvXXUSFx3Ni2DQBjoimvNjpnfL8aAblekv3Mqm9VkX8BQfyHYZKvAXTaQQubPtpmIuPxBhmhLXUbIUHNZdrYmKSp98IRYAE3nSpUKmjFC/IqkS7aXWG5DT47UeV0SOFqNcyfi8uhDWH/Gr4a3jlujavSzsSbDUHW63cLBLna+fgVfGv6wNbkbHlYB7OFSxhH74H+TF8HVjcuftJnUzVnNwJD+K2MSVi873aoZC1a54h+VGuvOEVO5ys2Vvee8gx+dg4THsOzqpmEVlneVELVPMrspGDu3cRu5cJwJGrZwP6WDTYVb7l04aWARchNhMkmnnVAJARYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbBt2kNglx4CFjfoRHa9xLdMCmxmHW3+wc2Bf0Pf3P4=;
 b=C40iEVQo9yUkF1DmscHS7wFj0uN9S37NLr256EQGfyNR6b6I5WG6Z41mJMHdzGiocxhuuFR5gKF2Fqcyxt9Q3KyTAxfLyQqIZJrQR4zkOXjTgmGYltRql0OL3mZQrmg4MHykqtAgnxI3GSkyMSnaHxygoQuFN2aXO08Wvk9TiGZqBUJpaKw0YNPFEeDZ3FsDTpSC42ydeMRM5RB2/kbO4rZoS/CElZxvvHZ7MKD785Q/pcW0PfqDsTEe4zKy5CPwBq3sawpP6YPMGQz5y++pcVVhuBg0uB93HJJI/7e0G4eEZsnnLHxfvooE3VqTEFtqhgWKTc5cbuKOJ78orgL/Rg==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by LV0PR12MB507217.namprd12.prod.outlook.com
 (2603:10b6:408:3b7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 18:36:46 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%4]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 18:36:46 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Alex Williamson <alex@shazbot.org>, =?iso-8859-2?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@baylibre.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
	<rdunlap@infradead.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, David Lechner
	<dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>, Thierry Reding
	<thierry.reding@kernel.org>, Mike Rapoport <rppt@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Karl Mehltretter <kmehltretter@gmail.com>, "Paul E .
 McKenney" <paulmck@kernel.org>, Borislav Petkov <bp@alien8.de>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Marco Elver <elver@google.com>, Ethan
 Nelson-Moore <enelsonmoore@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	Bradley Morgan <brads@mainlining.org>, Andrew Morton
	<akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Pnina Feder
	<pnina.feder@mobileye.com>, Mete Durlu <meted@linux.ibm.com>, Aaron Tomlin
	<atomlin@atomlin.com>, Rio <rioo.tsukatsukii@gmail.com>, Feng Tang
	<feng.tang@linux.alibaba.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "driver-core@lists.linux.dev"
	<driver-core@lists.linux.dev>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Yishai Hadas <yishaih@nvidia.com>, Longfang
 Liu <liulongfang@huawei.com>, Brett Creeley <brett.creeley@amd.com>, Giovanni
 Cabiddu <giovanni.cabiddu@intel.com>, =?iso-8859-2?Q?Micha=B3_Winiarski?=
	<michal.winiarski@intel.com>, Julian Ruess <julianr@linux.ibm.com>, Nipun
 Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, Eric
 Auger <eric.auger@redhat.com>, Mostafa Saleh <smostafa@google.com>, Pranjal
 Shrivastava <praan@google.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
	"qat-linux@intel.com" <qat-linux@intel.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH] vfio: Allow untainted use of driver_override
Thread-Topic: [PATCH] vfio: Allow untainted use of driver_override
Thread-Index: AQHdd7iVYKg+W/xA6kCUHlU6oPWyXLc1ujB7
Date: Thu, 19 Nov 2026 18:36:46 +0000
Message-ID:
 <SAWPR12MB9992678CB10A367CEB922F1E70B0792@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
 <20261118235645.2907908-2-alex@shazbot.org>
In-Reply-To: <20261118235645.2907908-2-alex@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|LV0PR12MB507217:EE_
x-ms-office365-filtering-correlation-id: 0dba5bdc-b8df-4306-879a-08df466c10fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|38070700021|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 XCNvFWm7IHh+NokusGc6C60bSA4C+tNfyp0G0JXQO+zfaT9tkF8OkHXjO3O6M3+2Id/dK2YkziQCsJY9nBK4/C1CvX/iDmBra18WuL5Hjc7PYBcodo62PpPpL+OeLod2JBCgFP0lr4qV43jihuPshNyzybjHs+uK3/BaS+mie8c05aDg3nlTrlAdMf+OEw/Bl+BTndCSA6sbg4NR/APKHqDlR+OOdtNYiSdgjQuZVmy6T7AUSKVlbGyYVdAYS7NcbNUqmreIogOAEnFjt3MykWK9WCMLbAqS0OPWk3vWd6eeNMT5XgMzSZYhUMrQOxp5fEOiwQSM9yonGDvxTWvyOrP8i/BdCd9kUemCfmkZCvNVRH3bWxwv7fsQqLyyoCeQVztSA1kd5UPAMh1KOSybOkYVLvOQ1nFsPMfrazkyKwAaJzbZkTU64LZ2sHQCzFDVlo40BOd4jzcim1ET0Ibmlah1FPqzJLwsZ2ZizUM7bkk82MrgxjNkllwtgMjE2A69/+GcJzmVdPO7WwTvB2+gA8UVdstWjKonoxDM3i+uBBOHdprIHG9XnHn9Uwy4A050SQ/cN3hzRp/soG/GKGqAmAKHI22tDwkH8kfu7PEogSbs3ua+x3WAY2mVRiVrpX5DHemdjXMYsakhl9CbKbQ3y1Tb/YUh+SEJyhusoAAwKPw81m2WdgH/JF6xHntN54UrBgZmX8ZrSwfnv9oI4sj2ULiodekWCx7hqIsae+q1FWg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?ibcmCeWYaAEsMeuQBRPyTEYVfWpjTlzXNo3we70IC6T0dea0uEGVg+4ixG?=
 =?iso-8859-2?Q?Zkj0/7h+vxPfVZbspgC1WC+lwReuB4c1CfUaUQICGti2Gt2UPL4TUtX1Kf?=
 =?iso-8859-2?Q?NBWnwttRfNVHE0GaZD/P9gPjPYDbp4Ixsdj3Rlpr1m7FaDc+TK/F7NdHvg?=
 =?iso-8859-2?Q?uKISS30daIe2pv9dikMvwDN//V3ny2Sc+emJZ6q6eaPgrM7E2A1fgTfoZe?=
 =?iso-8859-2?Q?iWVeU8usjQUVmpD40kWQlumNRM15iy8Seg/yyLPe8g3tnX9WVhl4lW+Rh0?=
 =?iso-8859-2?Q?F5tOD52WDFMEx3k9uMjwmsXWzN+/NswsYz2Eceyhf+oRIn178ANfXgy7se?=
 =?iso-8859-2?Q?5HRA9OWHAWPHSJ/7zfCecaq20ZYYALbhsXSda/PQA3ZNtgP3Y6nDUKoHqg?=
 =?iso-8859-2?Q?AT2+Jy8F4t0138C0JHbclv+1oXZPGHpzBaYwS34svMh1uTt7HqC8ccOZtd?=
 =?iso-8859-2?Q?727+IaStkF+RkT5iXDw+12AR4Djb5+Xzhm5h1wSKRmfS00tFtI2n5LFzgv?=
 =?iso-8859-2?Q?DLtEZdJAHFA1fKJJC0qqFJ1Xzh/joJKREaBxKqx/QP9M621gEngbKMV5gX?=
 =?iso-8859-2?Q?NmAOKo1ZoISTjdHQX1wLE8BHKW5l7MauXHvIyB0OePid8bksiDrhs+Zz2g?=
 =?iso-8859-2?Q?uCtql/YmLgpI1TX3fl90EAmuEUSazuuULneQzPC5W/qG8AzE+tjH3qOk6O?=
 =?iso-8859-2?Q?18cdBXsNJErTGhEpQfSglFuXLp/4lr4B8ZqxT3slpBbv/hU4Su6s0y6FwR?=
 =?iso-8859-2?Q?U9uMr1N2VbP6FrITBg55hkwB9SZC5uO2KQCcEKOMko8NP+siQX8XlyFKRx?=
 =?iso-8859-2?Q?8FLeQ4dY9YlmrIJyzKL2VV5KLqOlZPkzs2ecKL3cXQ0RvzSEHyiBa4sa31?=
 =?iso-8859-2?Q?cPGMTeJZfFzL3xhCD2T7t+qAKpv52gBHkZ16zw60/0t9eOnDJ0B635x+G6?=
 =?iso-8859-2?Q?qf9UNVK0GZUTEn/E/3HxNtprsGtcyy4nO8ZcHq3SEXEURCPOvL2QsSrMF5?=
 =?iso-8859-2?Q?uQzYqE/1+JVoFyFgooTfqV6K1LmLAL8qfB8h2QqFvcmJU2dZZdazRDYuRH?=
 =?iso-8859-2?Q?wuZM+Z2EuB/oBsVG4kYk3+RrFJPT+IssRTEneqCems/X/o/QyndDOypH4e?=
 =?iso-8859-2?Q?APheToAcIVxu9RzdWZeXuf5rKyIyhP5V2DhPRJtT2Vcx2xNVV6Bywniatz?=
 =?iso-8859-2?Q?HXJbLugbmZWCBMPt1rIMUUfjEqblnlJF9qgg5PchVEl+mGbKF77axsti9f?=
 =?iso-8859-2?Q?v/I9py4Ddxib73a7QZbjAjsGV52jTaPOJKqmbogFZ4IzIakwIOLgsvfmcB?=
 =?iso-8859-2?Q?sY4EJtMA58p8DCHFuBoKOAzWdkxhhextNz21HVYx2JbuYycc9EMfxSRD5S?=
 =?iso-8859-2?Q?i8Lev5k7rwHSHGyaD89TtLqanV4E8ZlXtmOpYWjGDiVLOg5WNL7UcQkUzL?=
 =?iso-8859-2?Q?Y1kdGIptDUtiishvxDhTEf4VsW3MGHiHpG7qH17IYlKSlm8pCh8pVVWUTf?=
 =?iso-8859-2?Q?XSBVbZOtNS4U7Rn1L6G76AMFpdRk0OVQd1mEn/832gWt4DI7pGkwtdGCz9?=
 =?iso-8859-2?Q?DSpSiykBRtFq68y58uMM2B/BG+Tb5kpHg9i7gtXUolNckrlPH0qQFhcHR4?=
 =?iso-8859-2?Q?MPwJuccy4ziNPp64ot+PVeQI177n+m4EbD5JVjfxcfKOm7r0qidCIyyoIz?=
 =?iso-8859-2?Q?gip1xQwxFPDxm1cJ9lA5geMi3k1xjGLatkbYDcY2arHJfZfv5zGdDHhOVM?=
 =?iso-8859-2?Q?P8ulrRZyi7qpJs/TTAt04ERvc76YnHkJVW9dlJzN5bUTsA?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SAWPR12MB999267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dba5bdc-b8df-4306-879a-08df466c10fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 18:36:46.4939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y8q8h07uVpspkfij4V8lXCF+oeriL+wLdqQ6NhZst3HpD99Igb1z4M1RdPeR+vtB68A1rx7FmfkgyN65yIjQLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB507217

Reviewed-by: Ankit Agrawal <ankita@nvidia.com>=0A=
=0A=
Thanks!=
