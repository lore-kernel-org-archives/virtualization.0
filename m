Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA3749A
	for <virtualization@lists.linux.dev>; Tue, 21 Nov 2023 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTs92Oq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700564533; x=1732100533;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y0fqh0XpBAy2ZjADrJBlj5R3Qm1uwRtVHE29sBD8z+Q=;
  b=CTs92Oq9TKe0TlS7g26T9PM39UrJCo/z8SLE+wcXP+EdjqYPbAK6E3Ue
   ApBIIzlwwTmI2iWVn8p4xQDMGeaoHs5pmtJ3UVr94Ujxv0wI7culM5fl+
   0FaZU5pOnAVQVCAXhrHBVUuECNxPwNV7FjCKV6rvF/7hBPYBGnu01BcI9
   C5unKPJr5eOcee0wwQ9od2tEcVj2h3CbKkF9E+iUPNG21yrpUdvePAgfZ
   0WpM9Euwnrt6HqDiXt538t4F+eVHtuz9S5/WMGJXs0/eOi2z6u1uBEQhY
   Zc/4Bkwwsys8AfVlyqGNIoWcR43jP43jh4uCXA7BWbn4e6T40cxtxJIf4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="10478737"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="10478737"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 03:02:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="7861313"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 03:02:11 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 03:02:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 03:02:11 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 03:02:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSWLW0evw6JTaa4LZrnmhL+ublglhZbYrKsCpS1D/lcLJGLkYhKVarluhOkN2Zq7il2181XTK+h+NbMHcahtflaJxpVrLAy+P1hYDaCKVQeLX5PsyLQSa2fJGcMHzbD1pZ/He/jcBDXoedofCWYrgUnZNHxXdSWkVz6k3h1Q/QLKQ8oDRaHMQes2OIXrBBXEjeKVX0sv4qivMjR2hCXbTV+F2o2asvY8It/Jnjc77g/NnZxR0jtS5TVmB9Q3dPuP7nSPc8Fjtaq7ne0vaHDc3i4RWQOKh08Gi2j3CZ7Dza81tuqpoKz/flLoAU5BOSi4p6ynAQyqcB5F5fFl0iELOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0fqh0XpBAy2ZjADrJBlj5R3Qm1uwRtVHE29sBD8z+Q=;
 b=NBUNHOIyLKxfy2ZHUhfWcT6XyPcce0mE3v8qsnr2tYL+ErFDgsfE9mn+mtOdHOq9p/6l4MXwqJ02CfE9zog/5a7GgWmov4tWEAheMhuRaB9XTihlWhx7U4EVwxkmQtxETdWLutX4DOY/uQZf8gpIW51HwIV/iuC5J9L01odSHjKESJTICYcJ1vBtwVm44DU0ixy6x59TnQqKOEix97UVdo1U4TddNt0cMcM4GAb6bb4KkDqnzU1IPbj5qZS3OlLumslxsYGjkdkZRLgP2JYAT1UlNOBwwBHoWnge3u+1pHzFAKx+M6pabcboFpsn4wVRA82TmiCNobwgMu+DspmNUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 DM4PR11MB7302.namprd11.prod.outlook.com (2603:10b6:8:109::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.28; Tue, 21 Nov 2023 11:02:08 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::dda6:fae0:4e18:6612]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::dda6:fae0:4e18:6612%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 11:02:08 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
Subject: RE: Using packed virtqueues in Confidential VMs
Thread-Topic: Using packed virtqueues in Confidential VMs
Thread-Index: AQHaGNtrdQxC+BiFpU68a4SKDQwhiLCC/ktwgAAqc4CAAXGoAA==
Date: Tue, 21 Nov 2023 11:02:08 +0000
Message-ID: <DM8PR11MB5750E412CA2CA0D0776A0E02E7BBA@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20231116200245.GA336841@fedora>
 <DM8PR11MB5750765B1310C904A8B1B00BE7B4A@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20231120072623-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231120072623-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|DM4PR11MB7302:EE_
x-ms-office365-filtering-correlation-id: 13d55a05-135a-46e9-0dbe-08dbea814e52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DO0XpdiHJsela7+n1szDJXP1NDd5iU9tc/5bDCHTCiekF0PBhIdXL2K3J/ENirWuNMF+N0KPfufUPwSgwO+HCHT3FMRUWWnUQf/A2W1L+WGxcl+IKSDgG1TKLCoZIXIbGjVn7xy7yq47EN44A//lnDdqDLCpKBoMizj3XfZ2O4S6EHKvcgk1NWG4kHUS5W4WGBAAwVQMsyquS1AENzodLAjPGXiQ6z6K6MJL9SAY/ZX8TmGk2b5saNIeuMuvATFr5VzgAvcA1yonCC7bZi800aniL8o0WZhgTbB33QDodPyBJWsCZbaq8jOWfKl5TZqjBQgQFuSnZcYiEF8QsMSXLVzLk3c1w+PbDjY2gApzddBoc6oNBWLHSgzYt8bECE3OpQ1fszT1SSee+YAVLzksHkd40KdCA6bsZNGWBU4xngZerVwSS2McnxOzB46zNl53QGMd2+q3njVmdvsS9hR3nWXaqGs5OFzCRjDIQDUDdcwvx96gHlvbct4hYqRVT14yT+oymFIJV1ikZx1nWgRUCiJTbZbj7+USsIwwFDH7FEuWCS4y9621PoiPnVRWCS0/3FbmgvxVWbXa/1WzJtgsE0EVNp90pobujVM6Cx3SKCdoNPVMiBzcXd127/VeFrKZfqMmCPufXNX4IXrjo+RB5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(55016003)(26005)(82960400001)(53546011)(7696005)(83380400001)(9686003)(6506007)(122000001)(76116006)(66946007)(966005)(478600001)(71200400001)(66446008)(66476007)(54906003)(64756008)(66556008)(316002)(6916009)(86362001)(52536014)(5660300002)(2906002)(4326008)(8936002)(8676002)(33656002)(41300700001)(66899024)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHNPN2luekxKR3BiTXdNalRNdGQwMGU4Znd6UitSRGc4R21Uc3ZGTVR2eEhl?=
 =?utf-8?B?blNaelBXTm9vVXE5eDFRcW55TjZlOGh2b1dUQnlWQXpzTVFRak15bzRnb3ZJ?=
 =?utf-8?B?NXFTbUE0c245L3puNUpZelljTis0eGxwZXVKNUJpR0M4c2lWM0M2S01qbUZ0?=
 =?utf-8?B?YlFMSVlqUlhmRE5mQ2VEOVdzY3NzU0hFRzBVSlF1NmVKMkE3cTVvZWwwRXN4?=
 =?utf-8?B?ZzhQYXdOR0xTL0F2VE9IVzdKVDlmamVpMXVTZ3hBQlpnUnVXYVlSZnhZVEx3?=
 =?utf-8?B?NlBqTGszRVU3VTEyYzUvNm1Rb2E3NWRLQ05WVVV6MjhIM0RoUUlHMzF5Nnds?=
 =?utf-8?B?SzlBK1VIb2xQenJ5NFdBWCtLV3BNR1RPa1pDczhlaWNVUEIzcEJvcDNlSFBk?=
 =?utf-8?B?R0N5bWt4cXRiTzNvRGdRUTdhNVpuZ2ZFeHB1N0pZTS9zU2Y1TWI2VkFqV0RC?=
 =?utf-8?B?NGZGbXV1MlVOZ2dlUllrY3BwQmxBdDIzdmZ1dzFXY2loQ2tmcnBjbW04NjRz?=
 =?utf-8?B?ck5SclRnajh2eWJLM1EvTGtaL1pRUytqa1BMdzBwNTFzUzBQNGpXVFpEYmJl?=
 =?utf-8?B?b1RzenVsZGNQK3dxdnIyanI3NEdpN29PRm5venZMbEpxZGtuTldSRWFHTU5q?=
 =?utf-8?B?UW5vS0tsdlNNRzhxbDhobitHeDg0aU1lc01rOUYyTW5tcHErbTl6OU15TThF?=
 =?utf-8?B?M0w3TVZNZ0VwQ2pUUkZqdlhnb2hqeDI2emZFRFUwYVRyTnpBemVSdisyZEE0?=
 =?utf-8?B?WU96UGRvODJ6R2hKbzBYSnJlYVE0ZUdiUU9JQWdya3dpd1V5UnptQWEvU25w?=
 =?utf-8?B?SEVsRCtRdmlIcTlTcHQwNi8rRTZNb3lUV1Y3VFdxMmplUkdHRXRVQksrSWpi?=
 =?utf-8?B?ZmRCSStpTTZtazhWOFZPcjlCYTZ5Uk5wdDRPZTgvcTR6TG1SZjROV3E0QUNO?=
 =?utf-8?B?d0ZmSENISW1IRzFqZWlHdkZqR21rYmY2Z3hoUk83dnZ5WThHa0hHd0wyd29Q?=
 =?utf-8?B?ak5kRnpDOVhRYk5GbjZzSVZXR1BCSVp2VHpOY1RaUEJpV0xKTU1GNnBJU05P?=
 =?utf-8?B?d0h2eHp4QUNFR3YrSTBRczBBeUtHbFhCYWVZZVZBek1pZCtIcXJEcVU2WHNs?=
 =?utf-8?B?NFBpbE8rbHdLYUFWK1hxRElBS0Z5amlsS0IvaitpaWIzTmVHU0c5V2xhSGU1?=
 =?utf-8?B?RkhvWGkvTE8zcTFBQkI1dG15QTFSYWNUUUZsSkR3dGFicUhTUUc1RVFIWHRV?=
 =?utf-8?B?QllUVVV5UDBQNVcrQ1psTnd1ME1YcWFxdjEwVjV1RUN1NDNudk82T2dvMEdz?=
 =?utf-8?B?QnBRU2g2ZzBSYSttRXFpR1JDdTFxY2RNRXJKZkFrWU0wdXdmdmVHckNwaVAy?=
 =?utf-8?B?ZzR5TjZQRm4zWU9IZFR2V216WFVrU3dzZUsza3RWTG5MWVJyZjB3czlJVjIy?=
 =?utf-8?B?QUhzdmFlU2dtazhhZVNyeGMvV3U2K0pLWDhsc3hPNDlPQWswTnVNVkc1S1NX?=
 =?utf-8?B?amxCcTJvQnRzU0RXbDVYNG5sL3NHeUFwZWY5T2NjWWRselM4YjlsYUw0eHR6?=
 =?utf-8?B?L2FGWFhaTjQzMXBrSUhQdWZ6MEloZlJMVUc5OFNBZ0tsK3l5YUdUSHBKajho?=
 =?utf-8?B?Yi9TSlR0L1ZvejM1bDY4VnVqTndwSEd0Mk9TTXAxck4yU2VwempBN3JDeUg5?=
 =?utf-8?B?ZXhNeFdBeGFNUVl6ekp6RGhib05Kd1k0Wm1xYkNwN0VYQ29ZcXZCbU50dDQ5?=
 =?utf-8?B?emxEbHhRT3d3K1RpTzY1Yys2Ry8wdWg4eXJ0TlpnSTNwUmRWQjBwaGhtaEVP?=
 =?utf-8?B?UW5UL0N0eG9sbS9LdlhlRERIN3hrUlgxamJhaG5oQWFnMUN1cndaTVRzWjYx?=
 =?utf-8?B?SmtLNWNZaVRKVXRxQk92S1JpNHYyUk1MZk5OVkNmQStWWFkrUWVCRzM2V3Ru?=
 =?utf-8?B?cUVWT2x6emFuQU41K21oeXZhL3pNTU1ROU1pdjZTcExGMHFNZ3o3cnQ1SGRO?=
 =?utf-8?B?aGJwdlE4RWY1SWoxS3BKZkZCZ2JJS2p1UjdiKytVQlh1NWVub29ELzJOanRB?=
 =?utf-8?B?VlNXdER6QmtuMGt5Y3hQWll0TWJjTjMzYTNxOXJndWFPVTlGM3lLMndONXI3?=
 =?utf-8?Q?Oiy6+I30zuNphxjPE86aAuXMJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d55a05-135a-46e9-0dbe-08dbea814e52
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 11:02:08.8237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H0JUp4PdC/RSNoU7CeYLXpxag+e2XFzf+wKunexpP6Gbm0l82wtNmaBJWf1VLZ3IeDrqL96+UvaP65URwY5p5V9zP3Uht309pGfIaxFxvJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7302
X-OriginatorOrg: intel.com

PiBPbiBNb24sIE5vdiAyMCwgMjAyMyBhdCAxMDoxMzoxNUFNICswMDAwLCBSZXNoZXRvdmEsIEVs
ZW5hIHdyb3RlOg0KPiA+IEhpIFN0ZWZhbiwNCj4gPg0KPiA+IFRoYW5rIHlvdSBmb3IgZm9sbG93
aW5nIHVwIG9uIHRoaXMhIFBsZWFzZSBmaW5kIG15IGNvbW1lbnRzIGlubGluZS4NCj4gPg0KPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFN0ZWZhbiBIYWpub2N6
aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAx
NiwgMjAyMyAxMDowMyBQTQ0KPiA+ID4gVG86IFJlc2hldG92YSwgRWxlbmEgPGVsZW5hLnJlc2hl
dG92YUBpbnRlbC5jb20+DQo+ID4gPiBDYzogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0
LmNvbT47IHZpcnRpby1kZXZAbGlzdHMub2FzaXMtb3Blbi5vcmc7DQo+ID4gPiB2aXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC5kZXYNCj4gPiA+IFN1YmplY3Q6IFVzaW5nIHBhY2tlZCB2aXJ0cXVl
dWVzIGluIENvbmZpZGVudGlhbCBWTXMNCj4gPiA+DQo+ID4gPiBIaSBFbGVuYSwNCj4gPiA+IFlv
dSByYWlzZWQgY29uY2VybnMgYWJvdXQgdXNpbmcgcGFja2VkIHZpcnRxdWV1ZXMgd2l0aCB1bnRy
dXN0ZWQgZGV2aWNlcyBhdA0KPiA+ID4gTGludXggUGx1bWJlcnMgQ29uZmVyZW5jZS4gSSByZXZp
ZXdlZCB0aGUgc3BlY2lmaWNhdGlvbiBhbmQgZGlkIG5vdCBmaW5kDQo+ID4gPiBmdW5kYW1lbnRh
bCBpc3N1ZXMgdGhhdCB3b3VsZCBwcmVjbHVkZSB0aGUgdXNlIG9mIHBhY2tlZCB2aXJ0cXVldWVz
IGluDQo+ID4gPiB1bnRydXN0ZWQgZGV2aWNlcy4gRG8geW91IGhhdmUgbW9yZSBpbmZvcm1hdGlv
biBhYm91dCBpc3N1ZXMgd2l0aCBwYWNrZWQNCj4gPiA+IHZpcnRxdWV1ZXM/DQo+ID4NCj4gPiBG
aXJzdCBvZiBhbGwgYSBiaXQgb2YgY2xhcmlmaWNhdGlvbjogb3VyIG92ZXJhbGwgbG9naWMgZm9y
IG1ha2luZyBvdXIgZmlyc3QgcmVmZXJlbmNlDQo+ID4gcmVsZWFzZSBvZiBMaW51eCBpbnRlbCB0
ZHggc3RhY2tzIFsxXSB3YXMgdG8gZW5hYmxlIG9ubHkgbWluaW1hbCByZXF1aXJlZA0KPiA+IGZ1
bmN0aW9uYWxpdHkgYW5kIHRoaXMgYWxzbyBhcHBsaWVkIHRvIG51bWVyb3VzIG1vZGVzIHRoYXQg
dmlydGlvIHByb3ZpZGVkLg0KPiA+IEJlY2F1c2UgZm9yIGVhY2ggZW5hYmxlZCBmdW5jdGlvbmFs
aXR5IHdlIHdvdWxkIGhhdmUgdG8gZG8gYSBjb2RlIGF1ZGl0IGFuZA0KPiA+IGEgcHJvcGVyIGZ1
enppbmcgc2V0dXAgYW5kIGFsbCBvZiB0aGlzIHJlcXVpcmVzIHJlc291cmNlcy4NCj4gDQo+IEhv
d2V2ZXIsIGJvdGggd2l0aCBwYWNrZWQgYW5kIHNwbGl0IEkgZG9uJ3QgdGhpbmsgc3BlY3VsYXRp
b24gYmFycmllcnMNCj4gaGF2ZSBiZWVuIGFkZGVkIGFuZCB0aGV5IGFyZSBsaWtlbHkgdG8gYmUg
bmVlZGVkLg0KPiBJIHdvbmRlciB3aGV0aGVyIHlvdXIgZnV6emluZyBpbmNsdWRlZCBhdHRlbXB0
cyB0byBmb3JjZSBzcGVjdHJlIGxpa2UNCj4gbGVha3MgYmFzZWQgb24gc3BlY3VsYXRpb24gZXhl
Y3V0aW9uLg0KDQpSaWdodCwgdGhlIGFib3ZlIHdhcyBvbmx5IGZvciBub24tc3BlY3VsYXRpdmUg
dGhpbmdzLg0KRm9yIHNwZWN1bGF0aW9uLCBJIGhhdmUgd29ya2VkIGEgd2hpbGUgYWdvDQp3aXRo
IHNtYXRjaCBtYWludGFpbmVyIHRvIGNyZWF0ZSBhIG5ldyBzbWF0Y2ggcGF0dGVybg0KdGhhdCBp
cyBhYmxlIHRvIGRldGVjdCB0aGUgc3BlY3VsYXRpb24gKHNwZWN0cmUgdjEgc3R5bGUpIGlzc3Vl
cyBvdmVyYWxsDQppbiB0aGUgd2hvbGUga2VybmVsIGZvciBob3N0IDwtLT4gZ3Vlc3QgYXR0YWNr
IHN1cmZhY2UNCihzaW1pbGFybHkgYXMgaXQgZG9lcyBmb3IgdXNlcnNwYWNlIDwtLT4ga2VybmVs
IGJvdW5kYXJ5KS4gSXQgY292ZXJzIHZpcnRpbyBhbHNvIA0KKG1vZHVsZSBteSBtaXN0YWtlcyBv
ciBsaW1pdHMgb24gZnVuY3Rpb24gcG9pbnRlciBwcm9wYWdhdGlvbiBpbiBzbWF0Y2gpLiANCg0K
SGVyZSBhcmUgdGhlIHBhdHRlcm5zIGluIHNtYXRjaDogDQpodHRwczovL3JlcG8ub3IuY3ovc21h
dGNoLmdpdC9ibG9iLzA0NWQyOWY5MGM0YWIyMWMzNzRmZjU4N2I4NTZmM2MzMDM2ODc1MGY6L3Nt
YXRjaF9rZXJuZWxfaG9zdF9kYXRhLmMNCmh0dHBzOi8vcmVwby5vci5jei9zbWF0Y2guZ2l0L2Js
b2IvMDQ1ZDI5ZjkwYzRhYjIxYzM3NGZmNTg3Yjg1NmYzYzMwMzY4NzUwZjovc21hdGNoX3BvaW50
c190b19ob3N0X2RhdGEuYw0KDQpIb3dldmVyLCBkdWUgdG8gbGFjayBvZiByZXNvdXJjZXMgYXQg
dGhhdCB0aW1lIHdlIGhhdmUgbm90IGJlZW4gYWJsZSB0byBpbnZlc3RpZ2F0ZQ0KdGhlIHJlcG9y
dGVkIGlzc3VlcyBhbmQgbm90aGluZyBoYXMgYmVlbiBkb25lIGluIHRoZSB3aG9sZSBrZXJuZWwg
YWJvdXQgdGhpcy4gDQpJZiB5b3UgYXJlIGludGVyZXN0ZWQgdG8gZG8gdGhpcyBleGVyY2lzZSBm
b3IgdmlydGlvLCBJIHdpbGwgYmUgaGFwcHkgdG8gd29yaw0Kd2l0aCB5b3Ugb24gdGhpcy4gSSB0
aGluayB3ZSBjYW4gZmlyc3QgdmVyaWZ5IHRoYXQgaXQgcmVwb3J0cyBldmVyeXRoaW5nIGl0IG5l
ZWRzDQp0byBjb3ZlciB2aXJ0aW8gZnVsbHkvY29ycmVjdGx5IGFuZCB0aGVuIGRvIGEgcmV2aWV3
IG9uIHdoZXJlIGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gDQppbnNlcnQgdGhlIHNwZWN1bGF0aW9u
IGJhcnJpZXJzLiANCg0KPiANCj4gPg0KPiA+IFRoZSBjaG9pY2Ugb2Ygc3BsaXQgcXVldWUgd2Fz
IGEgbmF0dXJhbCBmaXJzdCBzdGVwIHNpbmNlIGl0IGlzIHRoZSBtb3N0DQo+IHN0cmFpZ2h0Zm9y
d2FyZA0KPiA+IHRvIHVuZGVyc3RhbmQgKGF0IGxlYXN0IGl0IHdhcyBmb3IgdXMsIGJhcmUgaW4g
bWluZCB3ZSBhcmUgbm90IGV4cGVydHMgaW4gdmlydGlvIGFzDQo+ID4geW91IGFyZSkgYW5kIHRo
ZSBmYWN0IHRoYXQgdGhlcmUgd2FzIHdvcmsgYWxyZWFkeSBkb25lIChbMl0gYW5kIG90aGVyIHBh
dGNoZXMpDQo+ID4gdG8gaGFyZGVuIHRoZSBkZXNjcmlwdG9ycyBmb3Igc3BsaXQgcXVldWUuDQo+
ID4NCj4gPiBbMV0gaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL3RkeC10b29scw0KPiA+IFsyXQ0K
PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxk
cy9saW51eC5naXQvY29tbWl0L2RyaXZlcg0KPiBzL3ZpcnRpbz9oPXY2LjYtcmM0JmlkPTcyYjVl
ODk1ODczOGFhYTQ1M2RiNTE0OWU2Y2EzYmNmNDE2MDIzYjkNCj4gPg0KPiA+IEkgcmVtZW1iZXIg
bG9va2luZyBhdCB0aGUgcGFja2VkIHF1ZXVlIGxvbmcgYWdvIGFuZCBub3RpY2luZyB0aGF0IGF0
IGxlYXN0DQo+ID4gc29tZSBkZXNjcmlwdG9yIGZpZWxkcyBhcmUgdW5kZXIgZGV2aWNlIGNvbnRy
b2wgYW5kIEkgd2FzbuKAmXQgc3VyZSB3aHkgdGhlDQo+IHNpbWlsYXINCj4gPiBoYXJkZW5pbmcg
d2FzIG5vdCBkb25lIGhlcmUgYXMgZm9yIHRoZSBzcGxpdCBjYXNlLg0KPiANCj4gcGFja2VkIGhh
cyBSL1cgZGVzY3JpcHRvcnMuIFRoaXMgbWVhbnMgaG93ZXZlciB0aGF0IGRhdGEgaXMgY29waWVk
IG92ZXINCj4gZnJvbSBkZXNjcmlwdG9yIGFuZCB2YWxpZGF0ZWQgYmVmb3JlIHVzZS4NCg0KTWFr
ZXMgc2Vuc2UuIFdlIGRpZG7igJl0IGtub3cgeW91IGhhdmUgZG9uZSBhdWRpdCBvbiB0aGlzLCBz
byB0aGlzIGlzIHRoZW4gY292ZXJlZCwgDQpidXQgaWRlYWxseSBpdCB3b3VsZCBoYXZlIHRvIGJl
IHZhbGlkYXRlZCB3aXRoIGZ1enppbmcgb24gdGhpcyBtb2RlIGFsc28uIA0KDQpUaGlzIGJyaW5n
cyBtZSB0byBhbm90aGVyIHBvaW50IHRoYXQgSSB3YW50ZWQgdG8gYXNrOiB3aGVuIHlvdSBkaWQg
dGhlDQpoYXJkZW5pbmcgYXVkaXQsIHdoYXQgZGlkIHlvdSBjb25zaWRlciBhcyBwb2ludHMgb2Yg
dW50cnVzdGVkIGlucHV0cz8gDQpJcyBpdCBqdXN0IGF0dHJpYnV0ZXMgb2YgdmlydGlvLXJlbGF0
ZWQgc3RydWN0dXJlcyAocXVldWVzLCBldGMpIGV4cG9zZWQgdG8gaG9zdA0Kb3IgZGlkIHlvdSBh
bHNvIGxvb2sgYXQgcGNpIGNvbmZpZyBzcGFjZSB0aGF0IHZpcnRpbyB1c2VzIGF0IGF0dGFjayB2
ZWN0b3I/IA0KDQo+IA0KPiANCj4gPiBIb3dldmVyLCB3ZSBoYWQgbWFueQ0KPiA+IGlzc3VlcyB0
byBoYW5kbGUgaW4gcGFzdCwgYW5kIHNpbmNlIHdlIGRpZG7igJl0IG5lZWQgdGhlIHBhY2tlZCBx
dWV1ZSwgd2UNCj4gPiBuZXZlciB3ZW50IHRvIGludmVzdGlnYXRlIHRoaXMgZnVydGhlci4NCj4g
PiBJdCBpcyBhbHNvIHBvc3NpYmxlIHRoYXQgd2Ugc2ltcGx5IG1pc3VuZGVyc3Rvb2QgdGhlIGNv
ZGUgYXQgdGhhdCBwb2ludC4NCj4gPg0KPiA+ID4NCj4gPiA+IEkgYWxzbyByZXZpZXdlZCBMaW51
eCdzIHZpcnRpb19yaW5nLmMgdG8gbG9vayBmb3IgaW1wbGVtZW50YXRpb24gaXNzdWVzLiBPbmUN
Cj4gPiA+IHRoaW5nIEkgbm90aWNlZCB3YXMgdGhhdCBkZXRhY2hfYnVmX3BhY2tlZCAtPiB2cmlu
Z191bm1hcF9kZXNjX3BhY2tlZA0KPiB0cnVzdHMNCj4gPiA+IHRoZSBmaWVsZHMgb2YgaW5kaXJl
Y3QgZGVzY3JpcHRvcnMgdGhhdCBoYXZlIGJlZW4gbWFwcGVkIHRvIHRoZSBkZXZpY2U6DQo+ID4g
Pg0KPiA+ID4gICBmbGFncyA9IGxlMTZfdG9fY3B1KGRlc2MtPmZsYWdzKTsNCj4gPiA+DQo+ID4g
PiAgIGRtYV91bm1hcF9wYWdlKHZyaW5nX2RtYV9kZXYodnEpLA0KPiA+ID4gICAgICAgICAgICAg
ICAgICBsZTY0X3RvX2NwdShkZXNjLT5hZGRyKSwNCj4gPiA+ICAgICAgICAgICAgICAgICAgbGUz
Ml90b19jcHUoZGVzYy0+bGVuKSwNCj4gPiA+ICAgICAgICAgICAgICAgICAgKGZsYWdzICYgVlJJ
TkdfREVTQ19GX1dSSVRFKSA/DQo+ID4gPiAgICAgICAgICAgICAgICAgIERNQV9GUk9NX0RFVklD
RSA6IERNQV9UT19ERVZJQ0UpOw0KPiA+DQo+ID4NCj4gPiA+DQo+ID4gPiBUaGlzIGNvdWxkIGJl
IHByb2JsZW1hdGljIGlmIHRoZSBkZXZpY2UgaXMgYWJsZSB0byBtb2RpZnkgaW5kaXJlY3QgZGVz
Y3JpcHRvcnMuDQo+ID4gPiBIb3dldmVyLCB0aGUgaW5kaXJlY3QgZGVzY3JpcHRvciB0YWJsZSBp
cyBtYXBwZWQgd2l0aCBETUFfVE9fREVWSUNFOg0KPiA+ID4NCj4gPiA+ICAgYWRkciA9IHZyaW5n
X21hcF9zaW5nbGUodnEsIGRlc2MsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgIHRv
dGFsX3NnICogc2l6ZW9mKHN0cnVjdCB2cmluZ19wYWNrZWRfZGVzYyksDQo+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgIERNQV9UT19ERVZJQ0UpOw0KPiA+ID4NCj4gPiA+IFRoZXJlIGlz
IG5vIHByb2JsZW0gd2hlbiB0aGVyZSBpcyBhbiBlbmZvcmNpbmcgSU9NTVUgdGhhdCBtYXBzIHRo
ZSBwYWdlDQo+IHdpdGgNCj4gPiA+IHJlYWQtb25seSBwZXJtaXNzaW9ucyBidXQgdGhhdCdzIG5v
dCBhbHdheXMgdGhlIGNhc2UuDQo+ID4NCj4gPiBXZSBkb27igJl0IHVzZSBJT01NVSBhdCB0aGUg
bW9tZW50IGZvciB0aGUgY29uZmlkZW50aWFsIGd1ZXN0LCBzaW5jZSB3ZSBkb27igJl0DQo+ID4g
aGF2ZSB0byAobWVtb3J5IGlzIGVuY3J5cHRlZC9wcm90ZWN0ZWQpIGFuZCBvbmx5IGV4cGxpY2l0
bHkgc2hhcmVkIHBhZ2VzIGFyZQ0KPiA+IGF2YWlsYWJsZSBmb3IgdGhlIGhvc3QvZGV2aWNlcyB0
byBtb2RpZnkuDQo+ID4gRG8gSSB1bmRlcnN0YW5kIGl0IGNvcnJlY3RseSB0aGF0IGluIG91ciBj
YXNlIHRoZSBpbmRpcmVjdCBkZXNjcmlwdG9yIHRhYmxlIHdpbGwNCj4gPiBlbmQgdXAgbWFwcGVk
IHNoYXJlZCBmb3IgdGhpcyBtb2RlIHRvIHdvcmsgYW5kIHRoZW4gdGhlcmUgaXMgbm8gcHJvdGVj
dGlvbj8NCj4gPg0KPiANCj4gSSB0aGluayB0aGlzIHdob2xlIHRhYmxlIGlzIGNvcGllZCB0byBz
d2lvdGxiICh0aGlzIGlzIHdoYXQgRE1BX1RPX0RFVklDRQ0KPiBBRkFJSykuDQoNClllcywgaW4g
dGhpcyBjYXNlIHdlIGRvbuKAmXQgaGF2ZSByYWNlL2RvdWJsZSBmZXRjaCBpc3N1ZXMsIGJ1dCB0
aGUgbWFpbiBpc3N1ZQ0Kc2VlbXMgdG8gcmVtYWluLiANCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEN
Cg0K
