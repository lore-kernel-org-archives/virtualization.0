Received: from fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.74.81.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57254306B3D
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=3.74.81.189
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348648; cv=fail; b=bZk2/VkOJju7sDcAaL2rTCVKYjpgiEqkcOWUZCR8pg04J+YKIDlIcHblGDWrQ2dISdF5gcKZ79kJIhssjutfSXeQ5Ohdv8Pfi00ZdR+nUDgpKjRah4gfQE6YfCSc9fyVncBht0DwNLtjYcCWmoau4DTdK3LDJ0bGDXxLu3HSY2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348648; c=relaxed/simple;
	bh=vq+VbzwQEes7IRNNA7yDX/zEV5SqvZzgZaknyV1pCfg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GYWJHP95F/p1WiUKumJ1QpuQaYO6v20Vd2ZdEa9Iq0b798RIWGNsohk6iLyosagHtdd20YfM3mHy27OXzpJFtd5rLPYYZ6NEOJQiyOVzR/5Ta1gCEyu8XVcb/V1L0EEZoGq0lcoQck0bat6ss+g4frJKNWiyH1s9GaHnQR7aaO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=ibMTJbDb; arc=fail smtp.client-ip=3.74.81.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="ibMTJbDb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1786348646; x=1817884646;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vq+VbzwQEes7IRNNA7yDX/zEV5SqvZzgZaknyV1pCfg=;
  b=ibMTJbDbHO63yoiCmDJuGs24FVUgXVRhuioGcRWVG3p7xX2tHbUXkgXD
   Br1HPP4gkGoJ8I8bdTW5cmiOVGYxJEjpp8JjL2Bsg4qnsLmzLb34c+m7b
   tEbM1HR/vto7gvW1LWbrtKOkSRwf1ezaVORVxGjarspMSODvEtcKbU03J
   A8mr1KcY5dz88DbpOUIfSgCGhYcay1nmvwkMfM4OKD+jDDoOR8WrQOlds
   qPeb5Cq1fXzwAv0D1mZZIQdx7Jt1od8VehPFq6IFPVlylpDbrLdRryKzc
   IFlSKlLvIMDiiTA8+grNLW7lnp4YROC0sUydvfuP1bZP+xeo/doHVpIIr
   w==;
X-CSE-ConnectionGUID: wqnL83yVTxyuwXll/ZN3qg==
X-CSE-MsgGUID: kgBBxdhdRtKmZGtEuhNfdA==
X-IronPort-AV: E=Sophos;i="6.25,215,1779148800"; 
   d="scan'208";a="17637712"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 07:57:23 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.233:8420]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.26.8:2525] with esmtp (Farcaster)
 id 772f8b3e-89ff-48ee-ae5f-15ce5faebf2e; Mon, 10 Aug 2026 07:57:23 +0000 (UTC)
X-Farcaster-Flow-ID: 772f8b3e-89ff-48ee-ae5f-15ce5faebf2e
Received: from EX19EXOEUC001.ant.amazon.com (10.252.51.133) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Mon, 10 Aug 2026 07:57:23 +0000
Received: from EX19EXOEUC001.ant.amazon.com (10.252.51.133) by
 EX19EXOEUC001.ant.amazon.com (10.252.51.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Mon, 10 Aug 2026 07:57:22 +0000
Received: from BEUP281CU002.outbound.protection.outlook.com (10.252.51.199) by
 EX19EXOEUC001.ant.amazon.com (10.252.51.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45
 via Frontend Transport; Mon, 10 Aug 2026 07:57:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seuu0SBz/eIkfNP6jQJEUILaAcpvn3aD4oV1SrxtB0sFvNaZ61/kbHWUctMPsHnK6xjbisp68T/NBFBk05Q00EtnhzDvaOBybKuhcSdsb1FIIptMW8uy6Onh6BCN0X/v1LnR/MSQuSxC05yZMLgSBTRL3rGJCav01jO6xTG2KWsOsAmzV/uLh0dGaH3I9SyNt09JiuKrWP/40u7WYeySp4NSoXTbz5FSAmTntXscHKrjor6DvOi6/aE6Bm31CCV0+uancCEMTUtnAea2SFRpSiIXRy0YBMYYQpZs95FltwS3KxyR9GuL5qgzPZrzfqgzy++gwjNMjVTy4YPfpLvNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vq+VbzwQEes7IRNNA7yDX/zEV5SqvZzgZaknyV1pCfg=;
 b=zW238Db6IHGbIhxFlonN1hDrH5qZYd5J387DDfZUj2wm9QBOBay7PcRi/A4M+GlvBw4IUb5OQxm8/AMPC0Zljip+bxOC3VDjt81ULz1wJg+1v834wboYRgpyAeBh1piAZnGfSmV06Uc46mGPKn9uncbGWlLjjARZcJoQcJuw9kNjjggZMhkzTv9aaNIzrwfAWIvjr/U45NvEEwXO0ojshlLsEBF3KcmYLiKgTvbDHAwNWezK0Yq9u7V0qB04OjPpskKuamVk2db+6N7846P6PEFMuJT4PXpwqKVIYl5yyY2wWJJVI3T6J2YpJfiOVwT+rOEsdN3vKtLPDr1tysKPUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1e0::23)
 by FR3P281MB1661.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 07:57:13 +0000
Received: from FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7ad:f028:e0a7:bd4b]) by FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7ad:f028:e0a7:bd4b%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 07:57:13 +0000
From: "Graf (AWS), Alexander" <graf@amazon.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?utf-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 06/12] virtio: add a device memory buffer region
 allocator
Thread-Topic: [RFC PATCH 06/12] virtio: add a device memory buffer region
 allocator
Thread-Index: AQHdKJ3a7qi0KJDGLkCAMU3zrvky1Q==
Date: Mon, 10 Aug 2026 07:57:13 +0000
Message-ID: <6f34275a-6320-4be1-b8e4-b96aa3289344@amazon.com>
References: <20260809182010.32931-1-graf@amazon.com>
 <20260809182010.32931-7-graf@amazon.com>
 <20260809181455-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260809181455-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRSP281MB6250:EE_|FR3P281MB1661:EE_
x-ms-office365-filtering-correlation-id: d2a63884-3050-4dd7-5e6c-08def6b4fcf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|4143699003|56012099006|38070700021|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: KdZiKFL0ZIsnkT8LACH6URb5X3FP2y/LyAh4tMxn3e7XrpgGPwqyW7I9t35i4BEcBfr6LyF0qnnFSxUwaWkrg/EZu7jlDk61SIXpS+7B0QmIN8rLOaO+Ca2evEyRIi5LGPDIkvaN7PCdmb35SQrsPsKhTWtCYslAKJTLfaInqsMhY6+1zQUKmwBNkwvSaA9hnW37weJfW5u07kSzb/reqYwihmTIsrF/qlJCp8rtaG0w9W4YVlD16YOaJ0Ty8zvR/UgmR8qM0ey0KueIZqSESR39qJvo28rrPVmToVgv+QQCO6dpdzBjM+ddeM3GM84aF1jZ9bI7LDIKD1Xe2QTs1jBAder5Iz7UGvGmwQzkbY1B3nxBcAlL70Xkkv4Xm9OuAGtpd0GUbwmGBzGKAtobQ1z824wCf1+V9zJ5F6fTwAQShqVNHdi4lGMeABxAQy9cTtAahL2uyTWPTgCeAEAeUW9FPq9StknD9N9sEVOJfJbopf/2weN8XgdiMMYm1wjzeC+sqxbSshfShmz+YjCXlA1pp4iWOMrIks8a20//d38kshiykZmRjx8ePMr4Xy1hJfoHLmCghXuz6BeyzaHZMmB2hatUejTYa6jgOUUpQcFwsuRkRTqjSaW/nkQBG3QgZoCN1eNYUmtVAt5kvhZcbLXiaBM0vtjrmWMPa/hJ74/+I3o0XwAQkdSuoSxazP4IfgWr9c6nh8IH5ip8REKYANQv4qI9Kga8W/hAtaLi1V4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(38070700021)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWtRTVdib1FzYmkrcElZWVFmY1BSbmN4ZTRTRUYvVWJabG9oVFhJNEJ3dHRT?=
 =?utf-8?B?ZXdaYjVQM3JkTjlMcTVsaTdrSzQ3M1pWeVBZZG16V0FqQWF6RVNGU1EwVHF1?=
 =?utf-8?B?aTFRdGRYL0Y5N3BHU3dVWXJ6QjEwZWNpZXhJVVlFR0F1WDVYMmhoSU5ma0RH?=
 =?utf-8?B?d3dRZml2RHJzSjFKaHJSa0lxMmErV1d5WklkV0F1T2d3WEk3TExGdXp0cFFJ?=
 =?utf-8?B?OVVKcU5RQ09PSUFFYXdremN1eW1peVFnS1Q2NHhMYXJPNUpzTmhMbkpHWlFr?=
 =?utf-8?B?aFc1cjJoWWxNVm16WjhnWFZ6Zm0wWmJpMSs3N3ZaZjE0Qzh6QmlqanQvL2gr?=
 =?utf-8?B?dzd3MXBDL0laVnNTSHNUd3VsNHVucmtMdnI4UG9CaFNoUE1KbW9TYnJZdXY3?=
 =?utf-8?B?Z0IxL3M2MnFINkNKdTlLVnQwd3lRdTVMOWxnNUFEL1lDUkdydVl1VFJrL0ZR?=
 =?utf-8?B?NmJUN21hTndIUHhJL1FYaDFkb3JYK3pDRzhvbXpZQzJ6Vk9HZSsycHVFOU1v?=
 =?utf-8?B?NHJKVWVOMTZMNWY1cEMrUmxoWWY2SC9qdkVJeUlNQzZGeDQ5WUtDenNpanU3?=
 =?utf-8?B?U0RoWSsxMVVGdTBaZzlnN0U1R1dWOHJ6eXV1aks0NXcxekVpZncwbjljTDBJ?=
 =?utf-8?B?WHBNUDJuRWlsTnEzemJFY2pKWmtSb0ZCZW5vbExSdjk4c29wRzVWcVFpajV1?=
 =?utf-8?B?ditrVUZtbWxUZ21DRDZWd3Z1ZUs0RVcwZWo1SW5uWXhLcldyeFd5cUx6aWU1?=
 =?utf-8?B?L241Vjk5anJLZWV3UHZBbEgwNVhtNkJwUm5rOWJoQzl6dWU2N1J1NXg1Tkxl?=
 =?utf-8?B?OEJMbTcyTlpRMS9OUkV0N05YZmczUzhBd0cxUVNQMFlxVWpCNHAycE9UMTVE?=
 =?utf-8?B?T3IxTkVnVDNmM1IrOVk3N1VGb1NQSFo1Mlk0cTBzandUY211dk04aGpGMFZm?=
 =?utf-8?B?aTJhdUZkenBJeS9GTlBNZ2ZIR0RPTmFJeUFxUURYekVGK3RFY25JT3ZNLzND?=
 =?utf-8?B?N0xxTHJUdXVCV2hKR0pla0dBTzFlbTE1WGY2YXhYWG5tMngreWxZZ2F6bnNa?=
 =?utf-8?B?MVkzUFlwVVlkL1RqTkIzMVU1Ri9tK0VjaEZyNk9Tb0c0MS9ERGxsK3lwNGRH?=
 =?utf-8?B?eXEwKzk2UDhwWEpwU3hwV0lpZkdEcW9wbCtvbXhtd0lyZHlMaG1QL2tpbStT?=
 =?utf-8?B?SXJPZVNRbjhBTDlmUFU2SXJuUUJuaStIanEwU0ZKeDdQYkRTVS9HNUF6bUVq?=
 =?utf-8?B?bnZzbnJWQnBvTWxQVWVmUDFXSGNqSXdwcWxqazJZK3Y3Ujd5bEw1WStWbytP?=
 =?utf-8?B?YmtjMkxDVjY0ZytqR3ZOWml2Sm1ickQyRFYzcldENW8yTklnbTJuVW53ZEpG?=
 =?utf-8?B?YWpqT2QxYUpCM0FJTnlqK1IxS2NZVzc0Mk5MZTNPTGZJTVlwVnlUUXVTR3cv?=
 =?utf-8?B?K25pREh0ZTUxR0Zicmk3Y2VtUmZjcW53aVZKYUhBQVQ5RUJQQ3J5dVBqV0Yz?=
 =?utf-8?B?elAwVkFpbW1USUphczRwWUE0U1BCdkhRbkRuVkUxUzBqOVRiekFPUmxtQ1J5?=
 =?utf-8?B?cmhIK0MwNTVMMEVzM1RGcXJWS0tKVkRRRkNMMHl3c21hQWFOUjRscmpFelFn?=
 =?utf-8?B?OWdvcFUweU9SWjFjT2xNSUVvbDBUL2dDenZNQkV2Ukk5azEzTTZxci9zcU1S?=
 =?utf-8?B?UGNzQThNZEFUQkkvWlg3S2VseUdmYmQranFjNEFWSGVaSzYzemxWY1lzcFlO?=
 =?utf-8?B?a3VyL2JpYlB3VkxEaHByYzArcW93a25zUWFHUGlqcFRqbTJGcEZoa2tQVE91?=
 =?utf-8?B?dFliN2NSQWZGUERVZlFkSGh1eGhQZklvQzdXNmc2d3QzNit5UDV4K2tRc29m?=
 =?utf-8?B?RTc3eFhWWUdPY3dzL2d6Z2EyT1liaDVxM3Y2SjgrQ2FyMjdJVTBZNjJKT2xu?=
 =?utf-8?B?aHFWdWJvZVlJR2hSYWllYVR1NjJnWHZXUTRSekRtcTN0RkJvV2Ewbmh0MVdw?=
 =?utf-8?B?ektlOGhKN1d0STBQNm9yeEZ6SmdRc1lBTmNqRjRGWXFSV0JJSE1DcDA5S2FS?=
 =?utf-8?B?bXZZSjdXcnNzRy9lMEtSQS9FREpobkxGZzJ2MG1EaXEwSE1XL1ZpVTZZOXhV?=
 =?utf-8?B?RkhNZ0ZEWFpWWEpvbnUrUXAwUFUwUHhTSGpxaGRjdDV6WlZ3Ym1WaDRWNTlK?=
 =?utf-8?B?ZWpuWnUzNmxpSkdHQlBZVTIyc1M2MTdwRzhobjFPRkJCSzBrVmFjc29OMjF0?=
 =?utf-8?B?Uzc4Q3I5a0ZEMkhnYlFVeFBQeTJ1Z3BWZ3d1NVZxd1FHcXF3UWg1U1k4Mkl5?=
 =?utf-8?Q?8QJJCcBGRUKMJlH1jG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <305F49E7E6744349AD8D3FC55315ABDB@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MFuwY84drdG1GbTV2pCOy1a/WQw6c8SPCegi2640/2+WhO7uSwYH/U6Eo3C4zEcQAa1e19O3Kt6W79DqVxNJJ8mpFVlke0RBzS15U9cx2NvPg5ESqRibDWVjNc4gYFeTz2+UzL0Vw+xge8P1S7Ox9gaqIiJE707DQ+NLQitT+drid3R/sDxmuM59VQFvnkQgDwi4DrhNMZrm/RpXKkdTLdyu1b9qAaLK54QR6cbwVtdZADY+cQQRhqozOPxgLo7jI7rV2byqHO8IJ5ouB1De737AqXaZ+Gi2bZJPa6qTqiYg1k2dorwaDpUMn9HTRMlLH945OiJklb54vSpUDZmjEg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a63884-3050-4dd7-5e6c-08def6b4fcf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 07:57:13.1211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U2smaRq8HGqTufO18lOcD8ZdffSSGiQ2Pxk9RcFPpLmbd/tIKl0Gd6C0BU1stn5P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1661
X-OriginatorOrg: amazon.de

DQpPbiAxMC4wOC4yNiAwMDozOCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOg0KPiBPbiBTdW4s
IEF1ZyAwOSwgMjAyNiBhdCAwNjoyMDowNFBNICswMDAwLCBBbGV4YW5kZXIgR3JhZiB3cm90ZToN
Cj4+IEluIHByZXBhcmF0aW9uIHRvIHN1cHBvcnQgVklSVElPX0ZfRE1CLCBjcmVhdGUgYSBtZWNo
YW5pc20gdG8gYWxsb2NhdGUNCj4+IGFuZCBtYXAgbWVtb3J5IGZyb20gdGhlIERldmljZSBNZW1v
cnkgQnVmZmVyIChETUIpLiBUaGUgRE1CIGlzIGEgc2hhcmVkDQo+PiBtZW1vcnkgcmVnaW9uIGEg
ZGV2aWNlIGV4cG9zZXMgYW5kIG93bnMuIEEgZGV2aWNlIHRoYXQgbmVnb3RpYXRlcyB0aGUNCj4+
IGZlYXR1cmUgZXhwZWN0cyBpdHMgdmlydHF1ZXVlcyBhbmQgYWxsIHRoZSBidWZmZXJzIHdlIGhh
bmQgaXQgdG8gbGl2ZSBpbg0KPj4gdGhhdCByZWdpb24sIGFuZCBldmVyeSBhZGRyZXNzIHdlIHB1
Ymxpc2ggdG8gaXQgaXMgYSBieXRlIG9mZnNldCBpbnRvDQo+PiB0aGUgcmVnaW9uLg0KPj4NCj4+
IEFkZCB2aXJ0aW9fZG1iX2luaXQoKSwgd2hpY2ggbG9jYXRlcyB0aGUgcmVnaW9uIGJ5IHRoZSBz
aGFyZWQgbWVtb3J5IGlkDQo+PiB0aGUgZGV2aWNlIHJlcG9ydHMgYW5kIGJ1aWxkcyBhIHBhZ2Ut
Z3JhbnVsYXIgYWxsb2NhdG9yIG92ZXIgaXQsIGFuZA0KPj4gdmlydGlvX2RtYl9kZXN0cm95KCkg
dG8gdGVhciB0aGF0IGRvd24uIEFkZCB2aXJ0aW9fZG1iX21hcF9vcHMsIGEgc3RydWN0DQo+PiB2
aXJ0aW9fbWFwX29wcyBpbXBsZW1lbnRhdGlvbiB0aGF0IGhhbmRzIG91dCBhbGxvY2F0aW9ucyBm
cm9tIHRoYXQNCj4+IGFsbG9jYXRvciBhcyByZWdpb24gb2Zmc2V0czogYWxsb2MoKSBwbGFjZXMg
YSB2aXJ0cXVldWUgYXJlYSBpbiB0aGUNCj4+IHJlZ2lvbiwgbWFwX3BhZ2UoKSBjb3BpZXMgYSBi
dWZmZXIgdGhhdCBsaXZlcyBlbHNld2hlcmUgaW50byBpdCBhbmQNCj4+IGNvcGllcyBpdCBiYWNr
IG9uIHVubWFwLiBUaGUgbWFwIG9wZXJhdGlvbnMgcmVhY2ggdGhhdCBhbGxvY2F0b3IgdGhyb3Vn
aA0KPj4gYSBuZXcgZG1iIG1lbWJlciBvZiB1bmlvbiB2aXJ0aW9fbWFwLg0KPj4NCj4+IFRoZSBz
aGFyZWQgbWVtb3J5IGlkIGlzIHRyYW5zcG9ydCBzcGVjaWZpYywgc28gYWRkIGEgZ2V0X2RtYl9z
aG1faWQoKQ0KPj4gY2FsbGJhY2sgdG8gc3RydWN0IHZpcnRpb19jb25maWdfb3BzIGZvciBhIHRy
YW5zcG9ydCB0byByZXBvcnQgaXQuIEENCj4+IHRyYW5zcG9ydCB0aGF0IGRvZXMgbm90IGltcGxl
bWVudCBpdCBtdXN0IG5vdCBhY2NlcHQgVklSVElPX0ZfRE1CLiBBZGQNCj4+IENPTkZJR19WSVJU
SU9fRE1CIHRvIGVuYWJsZSB0aGlzIHN1cHBvcnQuIEl0IGRlZmF1bHRzIHRvIHksIGFuZCBhIGtl
cm5lbA0KPj4gdGhhdCB3aWxsIG5ldmVyIG1lZXQgc3VjaCBhIGRldmljZSBjYW4gdHVybiBpdCBv
ZmYgdG8gbGVhdmUgdGhlDQo+PiBhbGxvY2F0b3IgYW5kIGl0cyBib29ra2VlcGluZyBvdXQuDQo+
Pg0KPj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdmlydGlvLWNvbW1lbnQvMjAyNjA4
MDQxNjEyMDIuMzg2MTktMS1ncmFmQGFtYXpvbi5jb20vDQo+PiBBc3Npc3RlZC1ieTogS2lybzpj
bGF1ZGUtb3B1cy01IGNoZWNrcGF0Y2ggc3BhcnNlDQo+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5k
ZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPg0KPg0KPg0KPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMv
dmlydGlvL0tjb25maWcgICAgICAgIHwgICAxNSArDQo+PiAgIGRyaXZlcnMvdmlydGlvL01ha2Vm
aWxlICAgICAgIHwgICAgMyArLQ0KPj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fZG1iLmMgICB8
IDEzMTcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb19kbWIuaCAgIHwgICAyOCArDQo+PiAgIGluY2x1ZGUvbGludXgvdmlydGlvLmgg
ICAgICAgIHwgICAgMyArDQo+PiAgIGluY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oIHwgICAg
OCArDQo+DQo+IFJlYWxseSA+MTAwMCBsaW5lcyB0byBpbXBsZW1lbnQgYSB2aXJ0aW8gc3BlY2lm
aWMgYWxsb2NhdG9yPw0KPg0KPiBDYW4ndCB3ZSBzdGFydCBlLmcuIHdpdGggZ2VuIGFsbG9jIGFu
ZCBtYXliZSB4YXJyYXkgaWYgeW91DQo+IG5lZWQgc29tZSBtZXRhZGF0YT8NCj4NCj4NCj4gSSBn
dWVzcyB2aXJ0aW8gc3luYyBpcyBhbm5veWluZywgaXQgZ2V0cyBoYW5kbGUgKyBvZmZzZXQgaXMg
dGhhdCB0aGUNCj4gaXNzdWU/IFdlIGNhbiBmaXggdGhlbSB0aG91Z2guIE9yIGxldCdzIGp1c3Qg
bm90IHN1cHBvcnQgdGhlbS4gVGhlcmUNCj4gd2VyZSB0aGVyZSBmb3IgcHJlbWFwcGVkIG9yaWdp
bmFsbHkgYnV0IG5vdyBpdCB1c2VzIHBhZ2UgcG9vbC4NCj4NCj4gTWF5YmUgSSB3aWxsIHNlbmQg
YSBwYXRjaCB0byBkcm9wIHN5bmMgY29tcGxldGVseS4NCg0KDQpJIHN0YXJ0ZWQgb2ZmIHdpdGgg
Z2VuX2FsbG9jLiBBbmQgdGhlbiBvdmVyIHRpbWUgaXQgc2xvd2x5IG1vcnBoZWQgaW50byANCndo
YXQgeW91J3JlIHNlZWluZyBoZXJlIHdoZW4gSSByYW4gaW50byBpc3N1ZXMgd2l0aCBtdWx0aS1x
dWV1ZSANCmFsbG9jYXRpb25zIChzcGxpdCB0aGUgYnVmZmVyIGJ5IFZRIHBhaXIgc28gdGhhdCB3
ZSBkb24ndCBydW4gaW50byBsb2NrIA0KY29udGVudGlvbikgYW5kIHplcm8tY29weSB2c29jayB0
cmFuc2ZlcnMgKGJ5IGtlZXBpbmcgRE1CIGJ1ZmZlcnMgDQpzdGF0aWNhbGx5IGFsbG9jYXRlZCku
DQoNCkkgYWdyZWUgdGhhdCBpdCdzIGEgYml0IG11Y2ggZm9yIHRoZSBpbml0aWFsIHBvc3QuIEhv
dyBhYm91dCBJIHJldmVydCANCmJhY2sgdG8gdGhlIGdlbl9hbGxvYyB2YXJpYW50IGFuZCB3ZSBs
b29rIGF0IHRoZSBvcHRpbWl6YXRpb25zIGFzIA0KZm9sbG93LXVwPyBTaW5jZSBldmVyeXRoaW5n
IGlzIGd1ZXN0IGRyaXZlbiwgd2UgY2FuIHBsYXkgd2l0aCB0aGVtIGFzIA0KbXVjaCBhcyB3ZSBs
aWtlIGluIGZ1dHVyZSBpbXByb3ZlbWVudHMuDQoNCg0KQWxleA0K
