Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010072.outbound.protection.outlook.com [52.103.72.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174492F60B2
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 03:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788838370; cv=fail; b=BHgN8YrkJgtu+gTAXxgEkoOUx9xNwy4UqAghPXdJa+gbaFtRhLDQry6/L427l33WQLIWCJe56NErj8YTjS7jOT7BwCgB0cK7uREfyCEtC0yL/S0oCOTvEfLQxAusrwGEYzwgSfLaXhWSvjLs5Nk1H9MMFIsVhjeqMpVetrOGxoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788838370; c=relaxed/simple;
	bh=oQRwkM3DByZvdeaSwE9zBtvd/fm1CiM3zRcdN5wjfbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EYQdEF32ft4GZH9O7tv/MYR5km179Ba2TVXNCAXtICuqTFQB8KGVzPOSNtHmIsGOqJgL6a/wTFIrPGnMTXgG5gDoey3CLI3nMbxHlNLULTIi/xuXEBFQf3Igs2fo2l5cjiItkO4IWyDGJEUTyQG97B3a8f94vXrzwUQUZdIZXe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FxPLjm0V; arc=fail smtp.client-ip=52.103.72.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FxPLjm0V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJbsqNx1DANN4u9mfGBm76O58+qhyVBS+ea9ybVjnH1aot9trpF7Jd5j1+WwA+bkSYVXxmGUPDGiUTyy3QUnVHYQyXX+xvoYZmgZI1Wp6cLmAJEqtN794rzd9EXFlF7GUUcLIbvlcTapWYZ9BKPY6HMrdC4qwZ1Gx6Q5IN+61OjHJVdFYi7H0MVcg0THWzPkCUrShStePNZNDfKeYzIE14vHrOmkJX+wubFFah+4jxZ1pERA4b5uUtZzqrzWFl7uXjS3BhaoGI+Vpq34ObVxjVHD+CzTD3oIP8N2EZ5rTBnVs4egAPOYUFz6zaWekga842O4Yaql0L7HEkggUXfEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQRwkM3DByZvdeaSwE9zBtvd/fm1CiM3zRcdN5wjfbc=;
 b=ScCM7w/C9xFn80p0BFCR0wtM8FOQGReQFbyTSoFYOvgR1WJ/MuHAGhKZxWGGqi6+b1EkblC+3nHri1RojJmX04ufRXPEPVVn3eL+6HsmlGdjlhmFMkQadZ/8Zz32GsSv96zzxZLUlJLLUxCIxTLnCmu4wLaHdi02y+jF9ZvRYGWgYDh1FGlWMTeCPOv4sFm4dgB67F6uRmDpkbn/JNopY0fOBmtUqjoSEvkNFn92ZjbNUG7C8NwYsg+C7NtOgguzq03kRgoymQja3OcxkK7v4MuaQR+lp9+lMAWRHYA0YSSKOphAkhAwjk5mD9C3CoIAmwgJiz8vIceF1QH3r55Wjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQRwkM3DByZvdeaSwE9zBtvd/fm1CiM3zRcdN5wjfbc=;
 b=FxPLjm0VME40+CdH6v+ixZ0H7zVA2FG0wAXMaJL3hYc1mZ48UaIpwydNcU2dvYZiTiyker9RuSoMYSK3JEvS2FRJ1Gm9Owks57YfM7FS/OgtUqYplt8Iw/E4Nd2eMnxeZtc+l+zCaJ/4R6dxD0e1E7N0a5tZaZDTEF7hNN5HQb23PVN8SfdJJwEq1gLWx4lGj8B68Ral4L4T3C6hVvF8JoNwqc8SpjGq51VyNrjfwM7hc51asDISN5Krk1dNXTlxpg2WnH6zK7l2keMv3m4W31HmrFAv2M6fuY1Qd5MHoH6cXV6GKqxtmw3IVo0hLuRkkpBhimqbgMcTLOxxwc07bw==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY8PR01MB9111.ausprd01.prod.outlook.com (2603:10c6:10:22c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 03:32:36 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%7]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 03:32:36 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
CC: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter
	<simona@ffwll.ch>, Dave Airlie <airlied@gmail.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH] drm/virtio: fix object leak when drm_gem_handle_create()
 fails
Thread-Topic: [PATCH] drm/virtio: fix object leak when drm_gem_handle_create()
 fails
Thread-Index: AQHdLH2jXN/VA5CZgEOlcQYzQq97d7bDS2sAgADg6AA=
Date: Tue, 8 Sep 2026 03:32:36 +0000
Message-ID: <52E0FE3A-C867-4AD7-85C4-2AA7AD1123E6@outlook.com>
References: <20260815-virtgpu-gem-create-leak-v1-1-a4e9fb18caa3@outlook.com>
 <55240372-c265-4b38-be94-f29a58ddbb22@collabora.com>
In-Reply-To: <55240372-c265-4b38-be94-f29a58ddbb22@collabora.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|SY8PR01MB9111:EE_
x-ms-office365-filtering-correlation-id: c77a53f2-4537-4f9e-5541-08df0d59d377
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8062599012|22091999003|15080799012|25010399006|4140399003|19110799012|16041099003|8060799015|24121999003|55001999006|24021099003|31061999003|12091999003|440099028|3412199025|102099032|40105399003|53005399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjBjTXlwMnNWMDVuWi9LWm5FWHZzMWRGbmtZKzB2c3dtK3ZUZy9rRWRiUmlt?=
 =?utf-8?B?dEhPZzVLSDNOc0JNWGh1UUR6NXVsekJVSHdCeFpQQktXUVBmakVGWUR1d3Jt?=
 =?utf-8?B?NEpTYU4vaDY1REZ2YWR4R3hYQW01K1FUSlMwMHhFcm15YTdSQk1UbmdHbmIr?=
 =?utf-8?B?Rm1uV2pvUml2SHdQdFk5VENNVElxSU9zbW9WQVh5UG9YYVJ4RGJ3eWd4WnZX?=
 =?utf-8?B?d0M1VG5OQ3BTbGNleDhhMFZTQlZnU2kycjBneUVSZC85SHYxN3VlSXRuRXhk?=
 =?utf-8?B?dE1ITWxhLzNlb3NNSndaZUJNcndDTXhOMzExeTBLTytuQkpCUnRQdDlXNWlr?=
 =?utf-8?B?UXk3ZG5RbHlVbHB1RnlrakxBRU5rdVJMVWJPVGtoVElYdkxyb1p2cHBOa1A2?=
 =?utf-8?B?WTk5cGt0RUMrTUV3SGdRaVI4b0ovZjQ0ems4NXhJK2hpVkxLVVFZMUVvTC94?=
 =?utf-8?B?dTVzZ3MwOEtOamQ5NHB6TEI2clQvOEFvYlZJbGgwWnRQWThLRUJRbkVaMXhi?=
 =?utf-8?B?dEY4dml2UWZGdndvVkxUNVFWdHhWZGI2ZW9TeXFJTjVhZEdnNkZtMWkyYzFQ?=
 =?utf-8?B?QkZsY2E1czlsVVdBSFowQnQxRDhiMWs0U0VpVG5DOEk4RjRNaTY3Q3Vjc201?=
 =?utf-8?B?VVk1RWdJOGd5Z1N5SEhYQUZBV3FCdXkxOTQ3c2U1NERQNi9uRVQ1YStvY25a?=
 =?utf-8?B?VWZnakJxTlVCQUExOE1ObG1UM1BzY2FhTFdid0VnT0I0ckR0K3FEVkxuYzdX?=
 =?utf-8?B?eXUxaXZSWHdGTEVGWHRBSzRVMG5EektzdDlFUXhQRmlZdzFmS05ISng3WHZ6?=
 =?utf-8?B?ZkhIN29hcEI5c2FCZ1dNMWxwOFJZUlFLWWVRWkM4YzdpT29mWW5sNlQ0ME9s?=
 =?utf-8?B?dlhnSnFYNzBOcEtsZUhZamExQWJyOVZvZHh1eklqdkkvRWxwUzQ4bmJSRU5S?=
 =?utf-8?B?bE80ei9hWXV2TUNWODVkS2kzMy9ma0VUWXI2MDBFemxEblBseGIzYmVKNzNh?=
 =?utf-8?B?N3BwMUd1aUtMdXhsUXlPUGw4VmVLRTlhQndIR1EzY0hrNG53M3lpc1V6V2RN?=
 =?utf-8?B?WFhLbkFVdEZaTHVqdUREQWVuS2ZZdWl2Vit6TG1IMkhMTGRlcHc1dGIxQ3Ft?=
 =?utf-8?B?bDhsYUVHR1dUTEs4K2Y5NExMZ0hJeDR5Znk4ZGJ3VE5zb3BTcFN0cjNiTWU3?=
 =?utf-8?B?REsyL1FlSjJLRks5L3YwMEFVNGQ5WGdyaDB5MW1RM3M5VkZWVlJEa0RVeTM3?=
 =?utf-8?B?c1FBVXVNZU5nQXV0SDlBSjNZY1NhQm12dWkzZzJody9WYTBvT2s3WGZaODgr?=
 =?utf-8?B?L1dWbUFtWkZZLzNYZlR0ZUNOZTB6N0h3ZE96akU0a2ZUdE53NjUxNlhMc0Rw?=
 =?utf-8?B?L1dJRXRQQytpMHpUb05acTJTSXM4UU5Jb0pDT0lBSXhLYVNNRW5IVmVMSUx1?=
 =?utf-8?B?dEMzbUdwbzNUeDJtVTZUNnFRVkZYSzFUdE9TRE56dGZqMzJTbHAvakxnQ1Bt?=
 =?utf-8?Q?3y774iC4qfn+xtNDE+I6VL9AJxZ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OW5GMTF1dFVaYTNCT2hlMkFaZEdBU05IYVRra2VZV0VHYnZISTZoa2hFemEw?=
 =?utf-8?B?MnNCSFlhTGhIK2YrTCtSL3hsVjQvSVpNR1RkNU5KOXhJQTJmRHA4Uzc4d3hR?=
 =?utf-8?B?djh4RXJ0YW1UM0owYTh3dTJUWmQ2ZFYwMnZhWGd3STNwVG1XQjhqMk5IN2Nr?=
 =?utf-8?B?Rlg5WmhLT1l4S3lZemZRYVpVRXBUTW81YWxXV2xKQ2Njak1yZTVpa3paN00x?=
 =?utf-8?B?V0hyaEt3VVFKOXc2by9JTWxqS0RRYzNBeUxjVGNLRXhRamVhOWYvTmVsL3RV?=
 =?utf-8?B?VVA4STVLc09zdWxvU1d1TlpZdnVkQ0lYWWpXSU5TeDZkNk5QUGNXZmZLSnh5?=
 =?utf-8?B?RDA3b1cyaXBhNlQwZ0tmeC8wUFdZVkNCMGFQc2JMR1hDTi9PZk4vczVub3Q5?=
 =?utf-8?B?c05WN3QvL25YSUhXSFpaTDk5aythR1Q1R3lXRVk5cUV1MnJiangrVVJ0a3Zz?=
 =?utf-8?B?ZkVnYXp5YzNEQVhzNVArYnBtUUEyTVRhTk83T3pZdzBtbGR0cU5TbVFuKzRC?=
 =?utf-8?B?R0NVdS9MQmhsZnJIUllNRDNyTGpUbXVjaGJvdjNsZnYxOExYajBja1RVdGl0?=
 =?utf-8?B?QnFpVDhSUFZwZTVzSjIrNzRUa0UwN21mQk9jWUo5bVNUTDl3TS8rWUlCUGhm?=
 =?utf-8?B?Tk0vbnVwcWVaWkNMZlRTNEZUOTZlQnZDMmJSQjY5VzdzQ09tYmN2a1NqbllJ?=
 =?utf-8?B?RGMyVHNOUFBsRHplVFkyZFNubHBWRTdTeHZnRkxMVS9mcDJiNm5iWG41YUR2?=
 =?utf-8?B?Z3NGQWE0QU1MT2JVWmc1UU42KzM5YmhQVFptWXRrQ0lJQTc2Nkg1cmluM1dr?=
 =?utf-8?B?b3F4QXJ2cG54WUdoOGtwbW5aV0VuNFE3aE1uemF1amFxdm5LdGZxeFJDZXBE?=
 =?utf-8?B?ZDhad1VJNDlVczlKak5MUXRSaXplMUhnU0lSdDZQaE5MT2RPc1pVUE41L3lL?=
 =?utf-8?B?RFAwRk5KUkVQeEQxMWlDczVma3FVNHFvT0FmMzJYZGMxY2loL1IxMUp1ZmpR?=
 =?utf-8?B?NlJoY09PcU1UZEg5TFZLUlBDcjl4Ynl6LzRmWUU0ajd6RDBnK2FsRUtxNFNq?=
 =?utf-8?B?Y1NaTUNPb3RJV3pVbVV4ZFBlcEF5Y0tnemxGekZXTm96UktXU1ZJN1grT2ZR?=
 =?utf-8?B?WXZZUURET05OSkdJRWc5c3NNU21nUWNMR2lFQXVtUStkdTM2bTVMLzZSSDdL?=
 =?utf-8?B?SmZJdWViZ3gzdmJ5a3ZkZkQ0eXNyektYTE9scldhL3BXQTRsSFJ1TE1EVHZU?=
 =?utf-8?B?d2ZvS1ZkK0ZKNnZZcXYvcXpJaWFpeGhCU1BnY1ZxNEIrYWlibklGN0c3QmNC?=
 =?utf-8?B?S1dCRWxWYzBENTQ4Z0o1M1RISjZ2QklCeUJhQkc5b3YxYno1a3V2QlVMcEYv?=
 =?utf-8?B?M0NvS21Ydyt0K3YvL1VLUnU3S05tc3JCTG9yM2lieFlrQW55QStmUVdQNnpn?=
 =?utf-8?B?QThWY1RiK3FtWWg3MnR6bVQ5SWxkamRtakRodEJkS3MvNk1SbjRrcExzdzlB?=
 =?utf-8?B?VWFFQ3lCQmh3Q0FISURac3ltSCtObmhmLzJzVTVzNEkyaG00YW9VRlhFSzZk?=
 =?utf-8?B?WXJwRTdBMjQ1WEVUdzdNREJlT3BOUUQzWTJsK2VDc3NoRWlITXdGczFNRmdw?=
 =?utf-8?B?UkgyWTQwVDFvQWlJU0d3RWtpWnc0eXdEVi9MclJIN1ZhMG5lNHozOEFzZlJL?=
 =?utf-8?B?bnhhT2VZT0loSDJiS2RtT0J0N1FKT2Y3Qm05ZGhxWGI0ZWZpa0FPM2c1aS9P?=
 =?utf-8?B?dWhlSldXMi8rWE12VzJ4aGpML1RISmpxR25hVlRIdGtKUDZseGFYTWo3dHRS?=
 =?utf-8?B?N1RNQTJQZllZVGdXU3hUU0Q3d2dZYkxOVHVSUnBPTnM1YXVRSENlUlVRSDFI?=
 =?utf-8?B?cVZZQmh3UEFKYVBDdWdkMnB4QTFkU2xGRVFxOGZXZkU0aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E769CBE85583E439A1DEE7E2BA37361@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c77a53f2-4537-4f9e-5541-08df0d59d377
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 03:32:36.0914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8PR01MB9111

PiBPbiBTZXAgNywgMjAyNiwgYXQgMTA6MDfigK9QTSwgRG1pdHJ5IE9zaXBlbmtvIDxkbWl0cnku
b3NpcGVua29AY29sbGFib3JhLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiA4LzE1LzI2IDA5OjE2LCBK
dW5ydWkgTHVvIHZpYSBCNCBSZWxheSB3cm90ZToNCj4+IEZyb206IEp1bnJ1aSBMdW8gPG1vb25h
ZnRlcnJhaW5Ab3V0bG9vay5jb20+DQo+PiANCj4+IHZpcnRpb19ncHVfZ2VtX2NyZWF0ZSgpIG93
bnMgdGhlIHJlZmVyZW5jZSB0YWtlbiBieQ0KPj4gdmlydGlvX2dwdV9vYmplY3RfY3JlYXRlKCku
IE9uIHRoZSBkcm1fZ2VtX2hhbmRsZV9jcmVhdGUoKSBlcnJvciBwYXRoIGl0DQo+PiBjYWxscyBk
cm1fZ2VtX29iamVjdF9yZWxlYXNlKCkgaW5zdGVhZCBvZiBkcm9wcGluZyB0aGF0IHJlZmVyZW5j
ZS4NCj4+IA0KPj4gZHJtX2dlbV9vYmplY3RfcmVsZWFzZSgpIGlzIHRoZSBpbnZlcnNlIG9mIGRy
bV9nZW1fb2JqZWN0X2luaXQoKSBhbmQgZG9lcw0KPj4gbm90IHRvdWNoIHRoZSByZWZlcmVuY2Ug
Y291bnQgb3IgY2FsbCBvYmotPmZ1bmNzLT5mcmVlKCksIHNvIGl0IGlzIG9ubHkNCj4+IGNvcnJl
Y3QgYXMgdGhlIGxhc3Qgc3RlcCBvZiBhIGRlc3RydWN0b3IsIGFzIGluDQo+PiB2aXJ0aW9fZ3B1
X2NsZWFudXBfb2JqZWN0KCkuIFVzaW5nIGl0IGhlcmUgbGVhdmVzIHRoZSBibyBhdCByZWZjb3Vu
dCAxDQo+PiB3aXRoIG5vIHJlbWFpbmluZyByZWZlcmVuY2UsIHNvIHZpcnRpb19ncHVfZnJlZV9v
YmplY3QoKSBuZXZlciBydW5zIGFuZA0KPj4gdGhlIHNobWVtIHBhZ2VzLCBzZyB0YWJsZSBhbmQg
dmlydGlvX2dwdV9vYmplY3QgYXJlIGxlYWtlZC4gU2luY2UNCj4+IHZpcnRpb19ncHVfb2JqZWN0
X2NyZWF0ZSgpIGhhcyBhbHJlYWR5IHNldCBiby0+Y3JlYXRlZCwNCj4+IFZJUlRJT19HUFVfQ01E
X1JFU09VUkNFX1VOUkVGIGlzIG5vdCBxdWV1ZWQgZWl0aGVyLCBsZWFraW5nIHRoZSBob3N0LXNp
ZGUNCj4+IHJlc291cmNlIGFuZCB0aGUgcmVzb3VyY2UgaWQuDQo+PiANCj4+IGRybV9nZW1faGFu
ZGxlX2NyZWF0ZV90YWlsKCkgZHJvcHMgdGhlIGhhbmRsZSByZWZlcmVuY2Ugb24gYWxsIG9mIGl0
cw0KPj4gaW50ZXJuYWwgZXJyb3IgcGF0aHMsIHNvIHRoZSBjYWxsZXIgb25seSBoYXMgdG8gZHJv
cCBpdHMgb3duLiBVc2UNCj4+IGRybV9nZW1fb2JqZWN0X3B1dCgpLCBtYXRjaGluZyB0aGUgc3Vj
Y2VzcyBwYXRoIGJlbG93Lg0KPj4gDQo+PiBGaXhlczogZGM1Njk4ZTgwY2Y3ICgiQWRkIHZpcnRp
byBncHUgZHJpdmVyLiIpDQo+PiBSZXBvcnRlZC1ieTogWXVoYW8gSmlhbmcgPGRhbmlzamlhbmdA
Z21haWwuY29tPg0KPj4gQXNzaXN0ZWQtYnk6IENsYXVkZTpjbGF1ZGUtb3B1cy01DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBKdW5ydWkgTHVvIDxtb29uYWZ0ZXJyYWluQG91dGxvb2suY29tPg0KPj4gLS0t
DQo+PiBkcml2ZXJzL2dwdS9kcm0vdmlydGlvL3ZpcnRncHVfZ2VtLmMgfCAyICstDQo+PiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+IA0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS92aXJ0aW8vdmlydGdwdV9nZW0uYyBiL2RyaXZlcnMvZ3B1
L2RybS92aXJ0aW8vdmlydGdwdV9nZW0uYw0KPj4gaW5kZXggNjZjM2Y2Zjc0ZTljLi5kMmYwYjhh
M2YxNzIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vdmlydGlvL3ZpcnRncHVfZ2Vt
LmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS92aXJ0aW8vdmlydGdwdV9nZW0uYw0KPj4gQEAg
LTQ1LDcgKzQ1LDcgQEAgc3RhdGljIGludCB2aXJ0aW9fZ3B1X2dlbV9jcmVhdGUoc3RydWN0IGRy
bV9maWxlICpmaWxlLA0KPj4gDQo+PiByZXQgPSBkcm1fZ2VtX2hhbmRsZV9jcmVhdGUoZmlsZSwg
Jm9iai0+YmFzZS5iYXNlLCAmaGFuZGxlKTsNCj4+IGlmIChyZXQpIHsNCj4+IC0gZHJtX2dlbV9v
YmplY3RfcmVsZWFzZSgmb2JqLT5iYXNlLmJhc2UpOw0KPj4gKyBkcm1fZ2VtX29iamVjdF9wdXQo
Jm9iai0+YmFzZS5iYXNlKTsNCj4+IHJldHVybiByZXQ7DQo+PiB9DQo+IENvdWxkIHlvdSBwbGVh
c2UgZml4IGFsbCBvdGhlciBvY2N1cnJlbmNlcyByZXBvcnRlZCBieSBib3QgaW4gYSB2Mj8NCg0K
R290IGl0LCBJ4oCZbGwgd29yayBvbiBpdC4NCg0KVGhhbmtzLA0KSnVucnVpDQoNCj4gDQo+IC0t
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IERtaXRyeQ0KDQoNCg==
