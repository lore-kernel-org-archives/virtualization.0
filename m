Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F46612B8E
	for <virtualization@lists.linux.dev>; Mon, 20 Nov 2023 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HeNPHfKZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700475200; x=1732011200;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=88hskaaQ64zdZFQUz1eZwrhFJTjUklzALWd9bz0kdXQ=;
  b=HeNPHfKZ3igCYK98fkuK0HHUIio5k+/na5GTg1ZHO7j9y0TleWbNiRMj
   uwzkJIMTWSYpRiVZVPoXYziY1vAQdF27cPy/7hxNpebeEj7SVjBP7ecwV
   0gxQoiQ4sR2jfnWklWkLGgYMRBf2HBDJ5TU8VlVeQ0S2CRenqojJ2JpuI
   TxH44bGy/l/Vif7z9MqtbEUHujJIz+i/9mA5cQoDp6tjrdq2OhhAVRv3n
   wyCeFKHDvIL9SMBoiKYPQtpy3OaXpMcKDRXClymnPTCMZKwRhWOf1FR5z
   ZefNy8OMsUSkl57x3HqewC+eu07eDlUmr9ff4lT+KBUhqzvvpqrdVq4k/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="395519937"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="395519937"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 02:13:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="759742115"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="759742115"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 02:13:19 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 02:13:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 02:13:18 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 02:13:18 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 02:13:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcC+bFv2+UG5iTIBBsfRL3CF+E6cd1jqHyNp9l2l/0btzHVPkookvJz8ZlxMpJaTPl0UwaDJlykzGxkjr8YouEcWr7Ri2KLQUAIuiAEzN/NhsjGTKtfRrwxEiVXbNaD/K5hMOCBO869UHUDQiEkHme/EGMlISGNLmmz0NWpu0Y7iy8OEPfOfE+F4zyl8Ki3mXSzOn9ccAXux1Gc57+EAik7k4lWY7zzOl/UBHbpvyx7YhTCQ1HdBit94SQ+BvwCvQyJzOBth97uo9eCJuse+bWJpAo9Pza9hn1EbKt4K8M2lt4LDdRyxxkJmTeQkDbzVfo2tcfsAqji6iJqIyBG8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88hskaaQ64zdZFQUz1eZwrhFJTjUklzALWd9bz0kdXQ=;
 b=m5SXUbb08Sq2d2SPCof2OflWPjA86RM9kiII0AUUQvo955lNiq89hbktV+t+BmZ/Md03by+RPRwixtj6lV3fJCOaCBQFyKU/3gtCHqxn/MJPKL6sqZgh6k2L3lzUeLqWeCCGNjeL4Rb/WiGFVBNcDT7CZz3xV6f4bJR1OF0sp2LOxVGje09LDva7VgzyKPFWlTL0OpYLEmOfFx2fjoEAx1MrjkhWk4W02dFEk19dg84qfbxkSW1+Yq0NPSI5iP9am+mM/7+bLol8XhvtcksvCiMF6hwX98SGiUxsxeI8RP7/xpR4Z9GCiEK65krLzfnreB6vaIJKX9so107Np0Yjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 PH7PR11MB8252.namprd11.prod.outlook.com (2603:10b6:510:1aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 10:13:15 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::dda6:fae0:4e18:6612]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::dda6:fae0:4e18:6612%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 10:13:15 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
Subject: RE: Using packed virtqueues in Confidential VMs
Thread-Topic: Using packed virtqueues in Confidential VMs
Thread-Index: AQHaGNtrdQxC+BiFpU68a4SKDQwhiLCC/ktw
Date: Mon, 20 Nov 2023 10:13:15 +0000
Message-ID: <DM8PR11MB5750765B1310C904A8B1B00BE7B4A@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20231116200245.GA336841@fedora>
In-Reply-To: <20231116200245.GA336841@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|PH7PR11MB8252:EE_
x-ms-office365-filtering-correlation-id: 933d2e95-60e2-4b32-cc51-08dbe9b14f38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F8tC8teOQDBTtdhZVvlESxXnagItA+P4Z52INYz0BmWh7O4AN8EzS+nAkbTJJ8BENHoTgQ8n5CX54EMRmmE+TDySFg+Ch6RQ6Mj4/dAqkqYa1khX3B01ZwIy/rDA19PjjLwNYOfihchJX9GhJd6WcVDGRiZkHhIey43aChRdAJG9JKfi0rw5yOyl58aYz94HwBu1cJFFZ++0D55+StlHTeFnuqfWnLEqVseHX0uH3JZUKMP0FpIjDJpllG8wQC0QLzZtZ3bNG2ywVzUMGjwJnZKz/AMp8LeD5oPXXc83KgpkjKZs1k7kNqWSzJTX4jmJdM0i4HJcnQlpk/ia6F5Z6TYQwk8N30IptoIrQvXP/6AL3lb/Rp1ijkQ1X7SNyQhEVkalDZS8+do/TRjDo5UeZjKEhJcFczO/1JIpbM+Vn+3xkypzoug4w1mUE0G0UOpGqWQK/UIco3ZbJw4TUIA67J9Ni9ad/mpRyDUQtI2xziGg9I8XvMgdTnIcJE6ZjNH6LFdpw91PafePZtBvS2Td1Ak2yBGq1ufCVNPR0P8wpJkhKa2X/g34iDsyXAKQ9acKhMir2wAyhcOgxyMkUS21jR8i+5n+etMDVb4Ixwd1hTJ0Ccqb4j68doh1wL6VFpjUvP3fTIMbHSTLEc9iLcrCvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(9686003)(53546011)(26005)(4326008)(8676002)(38100700002)(52536014)(8936002)(41300700001)(2906002)(5660300002)(478600001)(966005)(6506007)(7696005)(71200400001)(76116006)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(316002)(33656002)(122000001)(86362001)(82960400001)(55016003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlI3K0RYbVRMSUpKeWk1SWt0dEEybUQ3Y0c0STAzN011dDk1YkhQWXNUeEJh?=
 =?utf-8?B?WWxXUHg2WHFkbXFyREEyT1lHM2N2dy9mc21GaENQaCt1WndMTmFiKzFzVHNZ?=
 =?utf-8?B?RkV6cGw0NVBRZGRqZitqUFM0VC9QMmE0Y0djYUJMNzEvV0twNVdNeGhnSlhG?=
 =?utf-8?B?NUtoMWNYa3J1VzliRDhZbi9DeVBBTHA1bWVTdE1td1RFbDVXL0IxdEpnQllG?=
 =?utf-8?B?NTd6Tm1EQzJtSlBTTDkyL0g1RkJxdUlrcE4wbE0welVPUTQvVU5TWlZpVVBZ?=
 =?utf-8?B?UlpoQmNnam9maGpGSG5ENy94Vm5NaG9jQW94YW5vZDd1OXhDSlNUcEVhc05M?=
 =?utf-8?B?WjFXZEZmVVM4VXY3ZzBVbVRSYmRielVUSmZ2enNjZE54MTJwVWJMZDJGck1x?=
 =?utf-8?B?dTlxUkdVVFg4VVEvSklLbC9vTzdiU3V5WDVVeTh4UHlUZWNwdENnc09YVnBL?=
 =?utf-8?B?aFVpaUVIeDRGemFpQVNtaGE4SHhjS0I0ZzRDQnJLcTRBNldvQkNGK0FrM1do?=
 =?utf-8?B?K21IK1Y5a0g5T0N0UTNtY2NpL3NmeGVldmpzdXdLckJ5REl0S1BacG5vMmt6?=
 =?utf-8?B?N0pxSGtzMkFWanIrN2dxVjJlaGJJM2lpSzlnNDVqVXUxZHdlK2ZQNVdFb2xR?=
 =?utf-8?B?V2tqY0t4MEFYS2dGRndVNTdmRHVMejVHL0RyWGpnWU5oV3BVY1ZZamlST0tO?=
 =?utf-8?B?N0VkeFNicXVjL2xjVHVINldHc3JkTy9aZFY0bm1mcVhPV2xCZFd6SWdTU3NC?=
 =?utf-8?B?WWtncytObmhVSk9JaGRIUnROZS9uUFVoRFdZa0lSOWhEMU1na2JmV0NWa3pl?=
 =?utf-8?B?aTh2NHc3M0dhOWZFYVN1VmNuQnpsYzYvTDhOSXdXam84VzBuc216bkUvcVdh?=
 =?utf-8?B?R2Y0OUYvMnBxK2hTSHNxZVRNVkZXdE5IT21UZWpyQUc0by9sWVZXMjB2M3lN?=
 =?utf-8?B?ajZZZkpOWkwrcktYWHVrMzBjRFQxS2xaVlAyeWhRMGxyK1A5NHdGaEZMYXBp?=
 =?utf-8?B?ZDcyNytoVVYvM2cydmJZVU1HbGFjemthRk8zQnplRDVBSEdKR0JHTDV5dXNE?=
 =?utf-8?B?YjNObktjUkZVZVNtYXJ3WjhVTVRPZWZSdHdiZTA5aVR6UjRhdUdKV3UxMENn?=
 =?utf-8?B?RVVibGUvSWtMMk9obGM0ZGVXek9SNUJTZGtFMUl5Z25MYXdtNVo3bXFzVUFv?=
 =?utf-8?B?Q2N4ZlBJYVVkbDhFcGRCcC9KVmZocjBESGFRVDk5ZEFMRmVDbVBaY3pjZTdN?=
 =?utf-8?B?SkpxSGpJSWtWMHVNbEhiY2M0ZlpwTzhTSUdFVmRHVTJrS1VMcFlmZHJaRTJ0?=
 =?utf-8?B?Q3VNV3VkUkhNK2pTZnRpSkpZVmFFNlNPaGE4SlZSZ05JY1ZFcGMxbWVLTDU3?=
 =?utf-8?B?RXNWR3ZKL3p5WEJ4MXdLUFYxdE44SnR0ZlZLa3VLRXQ0bU01MFZkbFBQc29i?=
 =?utf-8?B?Y0RwSTc3WjFmMUoxZTh5SGk1cm1rbTRnczdOOE9ZSXhwc1FtN0EzQUFVWnQ0?=
 =?utf-8?B?eThHdXMzTWpUV0hReWhybGhIMFNNQkwvQklUUXVTMHZ2aUsxZXkyWStaQitU?=
 =?utf-8?B?ODRqTlQvd2NRZDFtM0dVdk1ybTM3SDg5UnNXMlVPOFhEK1pBcnBlSzhkOU4y?=
 =?utf-8?B?dlljTVB4V1NIMFhYZWJwZ3J1MzhNSEk1aFNRazIxckM3VXowdm5aeTRkdm0v?=
 =?utf-8?B?Tkpzbk5BcStGcmxNTnRVTUQ4amY4L2JCUkJEclVyUkdadnpzcElhT3BseVlP?=
 =?utf-8?B?dUp4aGg1dkRVOERqbHpjQlkycWYwNWtxam1Lc0ZVZlBqdGRYSkVFMXNENUdv?=
 =?utf-8?B?SzVOMUJPNW03ZEMvRjI3TGkvVENJVGc5RlYwZFI3b0FPSWVIN2l4Mk1wakha?=
 =?utf-8?B?RllrMVlYc3B4MHg0RTk0dEZ4S1Z6QVJDaGNnOGhEeVRGYU5FRlp3SlhwQUtR?=
 =?utf-8?B?TUt1OVdUbXoycmRkUC9xVXBLWmhpOENML29TTVR1WGtoRCs0Um1WRnRUVnZk?=
 =?utf-8?B?N21ZSzZoSjlrbkt4Q21mT0xCNVpJaVh4ekZYSUtwOFVJdEdrRG9id0RWbUU2?=
 =?utf-8?B?ZUJiT3lFTmp4RloycTYzUTMxekRidTA4ZjVlNEZBQk5pRjk0dHpUSmp6Um16?=
 =?utf-8?Q?Z9f4BdTGKYOnSz7Vt/M0fgWFQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933d2e95-60e2-4b32-cc51-08dbe9b14f38
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 10:13:15.0414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKfMconk3gduEIG7l05aPnYxHGbX7j2KDfs6cdWyxOxdjz88KpfV+tRBS71DbyyL30ERPFSRMu1dsy9eX/udn4ZHFtC7Ct0ZY5lFx2e5NYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8252
X-OriginatorOrg: intel.com

SGkgU3RlZmFuLCANCg0KVGhhbmsgeW91IGZvciBmb2xsb3dpbmcgdXAgb24gdGhpcyEgUGxlYXNl
IGZpbmQgbXkgY29tbWVudHMgaW5saW5lLiANCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+DQo+IFNlbnQ6
IFRodXJzZGF5LCBOb3ZlbWJlciAxNiwgMjAyMyAxMDowMyBQTQ0KPiBUbzogUmVzaGV0b3ZhLCBF
bGVuYSA8ZWxlbmEucmVzaGV0b3ZhQGludGVsLmNvbT4NCj4gQ2M6IE1pY2hhZWwgUy4gVHNpcmtp
biA8bXN0QHJlZGhhdC5jb20+OyB2aXJ0aW8tZGV2QGxpc3RzLm9hc2lzLW9wZW4ub3JnOw0KPiB2
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogVXNpbmcgcGFja2VkIHZp
cnRxdWV1ZXMgaW4gQ29uZmlkZW50aWFsIFZNcw0KPiANCj4gSGkgRWxlbmEsDQo+IFlvdSByYWlz
ZWQgY29uY2VybnMgYWJvdXQgdXNpbmcgcGFja2VkIHZpcnRxdWV1ZXMgd2l0aCB1bnRydXN0ZWQg
ZGV2aWNlcyBhdA0KPiBMaW51eCBQbHVtYmVycyBDb25mZXJlbmNlLiBJIHJldmlld2VkIHRoZSBz
cGVjaWZpY2F0aW9uIGFuZCBkaWQgbm90IGZpbmQNCj4gZnVuZGFtZW50YWwgaXNzdWVzIHRoYXQg
d291bGQgcHJlY2x1ZGUgdGhlIHVzZSBvZiBwYWNrZWQgdmlydHF1ZXVlcyBpbg0KPiB1bnRydXN0
ZWQgZGV2aWNlcy4gRG8geW91IGhhdmUgbW9yZSBpbmZvcm1hdGlvbiBhYm91dCBpc3N1ZXMgd2l0
aCBwYWNrZWQNCj4gdmlydHF1ZXVlcz8NCg0KRmlyc3Qgb2YgYWxsIGEgYml0IG9mIGNsYXJpZmlj
YXRpb246IG91ciBvdmVyYWxsIGxvZ2ljIGZvciBtYWtpbmcgb3VyIGZpcnN0IHJlZmVyZW5jZQ0K
cmVsZWFzZSBvZiBMaW51eCBpbnRlbCB0ZHggc3RhY2tzIFsxXSB3YXMgdG8gZW5hYmxlIG9ubHkg
bWluaW1hbCByZXF1aXJlZA0KZnVuY3Rpb25hbGl0eSBhbmQgdGhpcyBhbHNvIGFwcGxpZWQgdG8g
bnVtZXJvdXMgbW9kZXMgdGhhdCB2aXJ0aW8gcHJvdmlkZWQuIA0KQmVjYXVzZSBmb3IgZWFjaCBl
bmFibGVkIGZ1bmN0aW9uYWxpdHkgd2Ugd291bGQgaGF2ZSB0byBkbyBhIGNvZGUgYXVkaXQgYW5k
DQphIHByb3BlciBmdXp6aW5nIHNldHVwIGFuZCBhbGwgb2YgdGhpcyByZXF1aXJlcyByZXNvdXJj
ZXMuIA0KDQpUaGUgY2hvaWNlIG9mIHNwbGl0IHF1ZXVlIHdhcyBhIG5hdHVyYWwgZmlyc3Qgc3Rl
cCBzaW5jZSBpdCBpcyB0aGUgbW9zdCBzdHJhaWdodGZvcndhcmQNCnRvIHVuZGVyc3RhbmQgKGF0
IGxlYXN0IGl0IHdhcyBmb3IgdXMsIGJhcmUgaW4gbWluZCB3ZSBhcmUgbm90IGV4cGVydHMgaW4g
dmlydGlvIGFzDQp5b3UgYXJlKSBhbmQgdGhlIGZhY3QgdGhhdCB0aGVyZSB3YXMgd29yayBhbHJl
YWR5IGRvbmUgKFsyXSBhbmQgb3RoZXIgcGF0Y2hlcykNCnRvIGhhcmRlbiB0aGUgZGVzY3JpcHRv
cnMgZm9yIHNwbGl0IHF1ZXVlLiANCg0KWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC90ZHgt
dG9vbHMgDQpbMl0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC9kcml2ZXJzL3ZpcnRpbz9oPXY2LjYtcmM0Jmlk
PTcyYjVlODk1ODczOGFhYTQ1M2RiNTE0OWU2Y2EzYmNmNDE2MDIzYjkNCg0KSSByZW1lbWJlciBs
b29raW5nIGF0IHRoZSBwYWNrZWQgcXVldWUgbG9uZyBhZ28gYW5kIG5vdGljaW5nIHRoYXQgYXQg
bGVhc3QNCnNvbWUgZGVzY3JpcHRvciBmaWVsZHMgYXJlIHVuZGVyIGRldmljZSBjb250cm9sIGFu
ZCBJIHdhc27igJl0IHN1cmUgd2h5IHRoZSBzaW1pbGFyIA0KaGFyZGVuaW5nIHdhcyBub3QgZG9u
ZSBoZXJlIGFzIGZvciB0aGUgc3BsaXQgY2FzZS4gSG93ZXZlciwgd2UgaGFkIG1hbnkNCmlzc3Vl
cyB0byBoYW5kbGUgaW4gcGFzdCwgYW5kIHNpbmNlIHdlIGRpZG7igJl0IG5lZWQgdGhlIHBhY2tl
ZCBxdWV1ZSwgd2UNCm5ldmVyIHdlbnQgdG8gaW52ZXN0aWdhdGUgdGhpcyBmdXJ0aGVyLiANCkl0
IGlzIGFsc28gcG9zc2libGUgdGhhdCB3ZSBzaW1wbHkgbWlzdW5kZXJzdG9vZCB0aGUgY29kZSBh
dCB0aGF0IHBvaW50Lg0KDQo+IA0KPiBJIGFsc28gcmV2aWV3ZWQgTGludXgncyB2aXJ0aW9fcmlu
Zy5jIHRvIGxvb2sgZm9yIGltcGxlbWVudGF0aW9uIGlzc3Vlcy4gT25lDQo+IHRoaW5nIEkgbm90
aWNlZCB3YXMgdGhhdCBkZXRhY2hfYnVmX3BhY2tlZCAtPiB2cmluZ191bm1hcF9kZXNjX3BhY2tl
ZCB0cnVzdHMNCj4gdGhlIGZpZWxkcyBvZiBpbmRpcmVjdCBkZXNjcmlwdG9ycyB0aGF0IGhhdmUg
YmVlbiBtYXBwZWQgdG8gdGhlIGRldmljZToNCj4gDQo+ICAgZmxhZ3MgPSBsZTE2X3RvX2NwdShk
ZXNjLT5mbGFncyk7DQo+IA0KPiAgIGRtYV91bm1hcF9wYWdlKHZyaW5nX2RtYV9kZXYodnEpLA0K
PiAgICAgICAgICAgICAgICAgIGxlNjRfdG9fY3B1KGRlc2MtPmFkZHIpLA0KPiAgICAgICAgICAg
ICAgICAgIGxlMzJfdG9fY3B1KGRlc2MtPmxlbiksDQo+ICAgICAgICAgICAgICAgICAgKGZsYWdz
ICYgVlJJTkdfREVTQ19GX1dSSVRFKSA/DQo+ICAgICAgICAgICAgICAgICAgRE1BX0ZST01fREVW
SUNFIDogRE1BX1RPX0RFVklDRSk7DQoNCg0KPiANCj4gVGhpcyBjb3VsZCBiZSBwcm9ibGVtYXRp
YyBpZiB0aGUgZGV2aWNlIGlzIGFibGUgdG8gbW9kaWZ5IGluZGlyZWN0IGRlc2NyaXB0b3JzLg0K
PiBIb3dldmVyLCB0aGUgaW5kaXJlY3QgZGVzY3JpcHRvciB0YWJsZSBpcyBtYXBwZWQgd2l0aCBE
TUFfVE9fREVWSUNFOg0KPiANCj4gICBhZGRyID0gdnJpbmdfbWFwX3NpbmdsZSh2cSwgZGVzYywN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICB0b3RhbF9zZyAqIHNpemVvZihzdHJ1Y3QgdnJp
bmdfcGFja2VkX2Rlc2MpLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgIERNQV9UT19ERVZJ
Q0UpOw0KPiANCj4gVGhlcmUgaXMgbm8gcHJvYmxlbSB3aGVuIHRoZXJlIGlzIGFuIGVuZm9yY2lu
ZyBJT01NVSB0aGF0IG1hcHMgdGhlIHBhZ2Ugd2l0aA0KPiByZWFkLW9ubHkgcGVybWlzc2lvbnMg
YnV0IHRoYXQncyBub3QgYWx3YXlzIHRoZSBjYXNlLiANCg0KV2UgZG9u4oCZdCB1c2UgSU9NTVUg
YXQgdGhlIG1vbWVudCBmb3IgdGhlIGNvbmZpZGVudGlhbCBndWVzdCwgc2luY2Ugd2UgZG9u4oCZ
dA0KaGF2ZSB0byAobWVtb3J5IGlzIGVuY3J5cHRlZC9wcm90ZWN0ZWQpIGFuZCBvbmx5IGV4cGxp
Y2l0bHkgc2hhcmVkIHBhZ2VzIGFyZQ0KYXZhaWxhYmxlIGZvciB0aGUgaG9zdC9kZXZpY2VzIHRv
IG1vZGlmeS4gDQpEbyBJIHVuZGVyc3RhbmQgaXQgY29ycmVjdGx5IHRoYXQgaW4gb3VyIGNhc2Ug
dGhlIGluZGlyZWN0IGRlc2NyaXB0b3IgdGFibGUgd2lsbCANCmVuZCB1cCBtYXBwZWQgc2hhcmVk
IGZvciB0aGlzIG1vZGUgdG8gd29yayBhbmQgdGhlbiB0aGVyZSBpcyBubyBwcm90ZWN0aW9uPyAN
Cg0KU29mdHdhcmUgZGV2aWNlcyAoUUVNVSwNCj4gdmhvc3Qga2VybmVsLCBvciB2aG9zdC11c2Vy
KSB1c3VhbGx5IGhhdmUgZnVsbCBhY2Nlc3MgdG8gZ3Vlc3QgUkFNLiBUaGV5IGNhbg0KPiBjYXVz
ZSBkbWFfdW5tYXBfcGFnZSgpIHRvIGJlIGludm9rZWQgd2l0aCBhcmd1bWVudHMgb2YgdGhlaXIg
Y2hvaWNlIChleGNlcHQNCj4gZm9yDQo+IHRoZSBmaXJzdCBhcmd1bWVudCkgYnkgbW9kaWZ5aW5n
IGluZGlyZWN0IGRlc2NyaXB0b3JzLg0KPiANCj4gSSBhbSBub3Qgc3VyZSBpZiB0aGlzIHBvc2Vz
IGEgZGFuZ2VyIHNpbmNlIHNvZnR3YXJlIGRldmljZXMgYWxyZWFkeSBoYXZlIGFjY2Vzcw0KPiB0
byBndWVzdCBSQU0sIGJ1dCBJIHRoaW5rIHRoaXMgY29kZSBpcyByaXNreS4gSXQgd291bGQgYmUg
c2FmZXIgZm9yIHRoZSBkcml2ZXINCj4gdG8gc3Rhc2ggYXdheSB0aGUgYXJndW1lbnRzIG5lZWRl
ZCBmb3IgZG1hX3VubWFwX3BhZ2UoKSBpbiBtZW1vcnkgdGhhdCBpcw0KPiBub3QNCj4gbWFwcGVk
IHRvIHRoZSBkZXZpY2UuDQo+IA0KPiBPdGhlciB0aGFuIHRoYXQsIEkgZGlkbid0IGZpbmQgYW55
IGlzc3VlcyB3aXRoIHRoZSBwYWNrZWQgdmlydHF1ZXVlDQo+IGltcGxlbWVudGF0aW9uLg0KDQpU
aGFuayB5b3UgZm9yIGxvb2tpbmcgaW50byB0aGlzISBFdmVuIGlmIHdlIGRpZG7igJl0IG5lZWQg
dGhlIHBhY2tlZCBxdWV1ZSwgDQpJIGFtIHN1cmUgb3RoZXIgZGVwbG95bWVudHMgbWlnaHQgbmVl
ZCBpdCBhbmQgaXQgd291bGQgYmUgdGhlIGJlc3QgZm9yIA0KdmlydGlvIHRvIHByb3ZpZGUgYWxs
IG1vZGVzIHRoYXQgYXJlIHNlY3VyZS4gDQoNCkJlc3QgUmVnYXJkcywNCkVsZW5hLg0KDQo+IA0K
PiBTdGVmYW4NCg==
