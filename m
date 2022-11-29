Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506A5C4321E
	for <virtualization@archiver.kernel.org>; Tue, 29 Nov 2022 00:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABF73416A5;
	Tue, 29 Nov 2022 00:19:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABF73416A5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JJCCO3wq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V3xYCkO_ak61; Tue, 29 Nov 2022 00:19:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BC5FB40361;
	Tue, 29 Nov 2022 00:18:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC5FB40361
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EEB8C0033;
	Tue, 29 Nov 2022 00:18:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F089C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 00:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 35CA78140F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 00:18:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35CA78140F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JJCCO3wq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g24DbRPyM8CS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 00:18:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E19181406
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E19181406
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 00:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669681137; x=1701217137;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZkFjBInh/fhG0j6exqojI/PJmS1lxQ1MVAYvu5Ekg3U=;
 b=JJCCO3wqq8QU4DqGsaOIqbZJQi/WH2QrgfSOwn1GQCwKXhNjow9drXfj
 a7DxOSZN4SBA9qfeKzKx+LrjeUuPzGCprSozgCzKlQc5Ts2RcjePEKV8B
 GW7wraMXIx7kKFDPj76bJbk/SA5Ug0llae/SR0CF2Y3rnDATpGC/02pTU
 WtoBJXTBd/PxvfFhhKfyBJ/PnudrzEAhkfJXcgDuuyXw6kxnmaL8YRVit
 e+jaIOptCvcySSJ5VatiUfzuzWBsEM++CNNULDN1GStqGDiCzmOEEhJNP
 WeGZGRKWx7PzmsGOLPo9qUIo1gorDzR76tQ/tMi5u8JKg1UU/F8GW9l4V g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="294674387"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; d="scan'208";a="294674387"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2022 16:18:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="594064385"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; d="scan'208";a="594064385"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga003.jf.intel.com with ESMTP; 28 Nov 2022 16:18:56 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 16:18:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 16:18:56 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 16:18:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrnhHJeIg6k3GAxqTXyp98ofNniyd7eLwlHfl82aVWmSU7ifPKc20AvNqmLRIiSV3wWdA/iZ6bjWsD8g9ikCQaXzQV3ltF05sDtnOgrSG+kWOEKIHc7eAQ67pvnv9Qyn9jWXvfbb1l2WKVZlnC85kQe9UOZMWgl/K84+LYBKf8FlDXbLYjrLZpDNlnZXcC+OfZYcL8JrpCL9q9652GrlOxm7KwkVRwhY23cKX+656xFISvRd+MWq2kG8JW6jJDRq3O9FzcXHbaYH0soq9QtQOhjMIgdsUZRGhrTgCDPK/4II2/p3Ls2NHBvbcmWQhwNKEUU7HYySdsP/es8MsWKk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkFjBInh/fhG0j6exqojI/PJmS1lxQ1MVAYvu5Ekg3U=;
 b=e7ipMZcbS2KJksk9rmQUFpbRV23TKX5hadT5pszy+Ex80VqfrJDjRX+Z6ijSC0tZZq0yRwobXRpffpmAD5BTPDpd8Khl/Ko3LW3on58PN+P84DezvFNbb8pvjYOXel8lnQMdGUzz0LxkfNG8xnPZN4prFzSbgO6p9LmycBHd+x7/bxqp911ZBrMWZeDH/Q5nTkLHm/Rlttrq+F16fBslua6NQQnqJuDhNK1FDNM5vcTF63Yu/SG41rQO/z0MSQrLqxGaK47O1Gs9Un8H8Pnh8V1wo+6L0IsH/uddgrZYGOfbDsuk+I5TJb0TS/ZLYjHKkPRG14aFUAH/NuzJmrJO5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN9PR11MB5546.namprd11.prod.outlook.com (2603:10b6:408:103::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 00:18:53 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3862:3b51:be36:e6f3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::3862:3b51:be36:e6f3%6]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 00:18:52 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Shannon Nelson <shnelson@amd.com>, Jakub Kicinski <kuba@kernel.org>
Subject: RE: [RFC PATCH net-next 06/19] pds_core: add FW update feature to
 devlink
Thread-Topic: [RFC PATCH net-next 06/19] pds_core: add FW update feature to
 devlink
Thread-Index: AQHY+6OB9jIRuo/XUEmDcCW4ZuKVkq5UtsWAgABCrACAABLagIAAA3+AgAAH6UA=
Date: Tue, 29 Nov 2022 00:18:52 +0000
Message-ID: <CO1PR11MB508985697264AF426CF01AA7D6129@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20221118225656.48309-1-snelson@pensando.io>
 <20221118225656.48309-7-snelson@pensando.io>
 <20221128102709.444e3724@kernel.org>
 <11905a1a-4559-1e44-59ea-3a02f924419b@amd.com>
 <20221128153315.11535ddd@kernel.org>
 <2acf60f9-1ce0-4853-7b99-58c890627259@amd.com>
In-Reply-To: <2acf60f9-1ce0-4853-7b99-58c890627259@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|BN9PR11MB5546:EE_
x-ms-office365-filtering-correlation-id: 706b44ba-85d9-4638-eb08-08dad19f4bb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iTw/BjlBqHtK8CZeVBZ/ygZeuq0ktqpoqwntfI8xkOUVRnU8CYhWi4KfPz+QyWnU6JojzbfbGf1Y8RJiPO7CmqNQFxtDrUgN551SGIpAMtttqLAxwdt4cVp9KUulwsmCOTDSq53AS0rheut5mhy6USqfuqJ21R7QNvF0u5toNndr1nC9KKe2gS2icw6o0qXAnYeDUuRuvx2pZDaBPVC0nq+SNWZMs7u0EvgcnWsjlOtzPy2udalLn5FzkXFmJurBd6uFj9G1WV1Ug2aJKcHVbyrK+TlPmsNVNfo1kQXirk45GBJ0Sq5sqghOto59ONhCQNNzznaWiPVVkOjFFHMUDtjRKS5e80UIAOPVIJ3G2M2OffRHqfWmNGJ/D5Z6jIKgVpF2+mFRLCcBoOcy8eatzy+2GBNgIghnn8bR/U40TjNaP+bTVcFWas39s8Q1ECveXJet9zBpDwg0Ulgk7iryBqnJr+hVH0rcdWbZmFLsgebHF6VEoqHZo07xxOrqytLHKCBIE2UT9/hHY6jYp/Hqn/PNdRYdcFAB75KMQ03Hb8koQ5e0aw0mM7AboqNWxAaCcsQES6eT8nvjLua/I0s9DxaAMFd6Y+ZebSzhOy6hXnq1kXrCZwcuRSK/S54bYyeX1k08uj/gN2ZSlLuiZsEtzRd0ighoMd35PdGDaWuLFGHOizmWIQypGG0fgLBK4mxBVshvglG9TuyAgGYKN8hPOg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5089.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199015)(55016003)(38070700005)(86362001)(9686003)(83380400001)(33656002)(71200400001)(54906003)(7696005)(6506007)(110136005)(53546011)(8676002)(478600001)(8936002)(52536014)(5660300002)(66556008)(2906002)(316002)(4326008)(15650500001)(66446008)(41300700001)(76116006)(64756008)(66946007)(66476007)(82960400001)(122000001)(26005)(38100700002)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWVORlovOUpYdHpjMkk0Nlk4M0h0R01BeFN1WDBNek9GZ2J3alYwNVZtZVFD?=
 =?utf-8?B?MkxlaEFqeS80T0xtQVltRUN4NTVHSVlHQ21rcnJZTTdnTGlaa2ZiQTZnaVdV?=
 =?utf-8?B?RDlUd2VmZDVnQ2g0TitLalhGYzVRMVVjdHZTYys0VTA2Y0NTaS9Ba2xzTGcz?=
 =?utf-8?B?N0tzeHI4QUxMZk5wWUsyeU1uU0lHcGtYbDR4bHV3T00yNEVUOHo4SEtaanBx?=
 =?utf-8?B?c3RXeWFUR1J6NHdCZDJ6cGZjS2NTSWdQUis5T0lsdWJHa0ZWeXo2b1Z0Ni9j?=
 =?utf-8?B?eEt5MFpzN2hTcmV3VzN5eVNwTW5MVFpmMzJSR1ovaXhTM0dldXZoWHkvbnNu?=
 =?utf-8?B?MDh0OXVvSDl3cmgzd2RhSjloOVJ3TjhEVHE1RzNhWit1ZGJVd0luWGxQZHdO?=
 =?utf-8?B?ckliVHRGUnNTd2YyTzdYZnA4UitKbFBJUmNhbERFL2kvSkhVQkJlbHRzb2JW?=
 =?utf-8?B?RFA5NERpVHBqU3g1ME5KczRjdHBOMDBKM01FVCtNdGZzRjY4WDZoVlBWL2pB?=
 =?utf-8?B?Z0VXSmhvcXdIY1VRMitITUVobXpNNThYYlIxbEV1K0dXbi9YbWtFd3Q0RWpH?=
 =?utf-8?B?QXhRVDRDTUhPRzRMYzhsODVKZmhtTUhBeTl0aFNHVjN4TlAxVWcxMUJ4dkZQ?=
 =?utf-8?B?NjVZWEJKdzZOQlZpQ0tKU1RKWEJWOHUyNkI2c291RG5NSy9TZ3owYy9rT2d0?=
 =?utf-8?B?MllEdlNHOEROU1N5bkRBaGRDaXFRSW0zaU5SSGx1TkwvVGwrWnpqRi9uNk1M?=
 =?utf-8?B?aUYzOGhKQ0R4OFA4ZFZ2VC8zQXpJV2x0cSs3ZytSUXpEeDNYTzkzNlZ0YnNW?=
 =?utf-8?B?L01obytTYXpYa0NMaHAvM2ZtdTArYW1XeWVNSERpeXNlZkFJRTFyajhNd3pG?=
 =?utf-8?B?ditIVVl6dVRHNWlEc0kzSk90NC9ER3V6NGdKYkdmcVFEQUE3NVczL2hjdllR?=
 =?utf-8?B?b0hTcXBwT2RiNU5oK1RLUWxOVUxVbnJMN21kNHphK3pzaEIxeHkvN3pucEtq?=
 =?utf-8?B?MWNvUW55VytFKzA0RVAxVWZ6b3A5T1hMcDEzSVpSanRzRG9zeW5Yc3dyelpw?=
 =?utf-8?B?ZzFzNjNaUHhZZjJRRGd0YTFaSnlnbnhtbElzYjA0ai96ZFF1TncwNlNHbTNF?=
 =?utf-8?B?L1lvd2VzUmJINzNzNldlMWhQbHhPMkt6U1FnQkFmRXBWUWtlWGl1SzBMMWtI?=
 =?utf-8?B?Rm5XcXEzbWIxYlhuM2R3WDRIMmY1ZkxNOGlsRFpDWG5Wd3pEZW5LRzBnbm80?=
 =?utf-8?B?UEJuc3VqUVNFMVNNSWxYdUFzcmhGS0Nwc1MwYzVxMnBnR0hjQ2wyVk1sRE9V?=
 =?utf-8?B?clU5eTdxWHlPbmsvcmF1dW9NdXhGTHpKRGhITytBZ3BDcnNVR1BlVnRpc2xJ?=
 =?utf-8?B?M3hzS05PUTdsYU5aSXZvR3Z5SkNvaVY1QjU1YWxFbFlNcTk2VHdLbytiK2tR?=
 =?utf-8?B?T3BCUmlkbWc1SXBQSG0zT1N4Zm9FTEJkZExUTEZVZExJY1NiRVdNZ1RQdVRE?=
 =?utf-8?B?K0NnYmpxZy9KL1N5Zys4UDJWSTc5TGdtSXU2eW9ySVpENFpKeDlsbUl6S1Uw?=
 =?utf-8?B?bUFXaHZqd2pHL2xiSmxaSEdrMUNXcE1jYXQyQlJoVytxWndTR3VYSFFYa1Zi?=
 =?utf-8?B?SmE3b2VQdU9aUlNPWGpHVGtIYWVEbm96SmpEckJ3NFNuNVEvdWIycTF1Q0NT?=
 =?utf-8?B?TnovbTFhWEVKOWJOcGtjUmNkZHEzSk56Rys2dzRBTFBSeFRGYmpwQ091Ny9x?=
 =?utf-8?B?S0dmRVExL08wR20rVCt0emxCSUNQdWhrWkRacUkrREphTmZVanhtcnRMdEFW?=
 =?utf-8?B?MzUvWjVKaFhCeGQ0N0dRQ2NJdW5Pa2RMUVIyQUJDM2p1WDNtY0RIR0VRWjVw?=
 =?utf-8?B?Q3N4dG1ocDNEQnpvTkQrRHNmY1czYmZwRG5QVnlWdTEzZmoxYlZ3WGp6R0tH?=
 =?utf-8?B?REJESkdQNFh4SEhoMDFpVVhuQi9ZTFJnUHQzR0h1clQrWDZ0UGFoajBWUGp6?=
 =?utf-8?B?NWZPMTVkbGpYSmxRaVlJUnM2Skw0eXQvdHM2R2h3ODhOTjZhT2c4YmxNbTNZ?=
 =?utf-8?B?QzljSFg0cWVCeGViZW1QNUJTVEJVWEo3Kzg1ZGRIUWRncURYTWpocGJPSTY2?=
 =?utf-8?Q?pFg2DnrjHuzEjxI1+jaakAg+K?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706b44ba-85d9-4638-eb08-08dad19f4bb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 00:18:52.6005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOz/B0fYmjm0JkAyIUIXTxQweQN0xpeOo2QEn6d3uRn4WAZEVHXsDKWSIckowqi9rpD9ULLBjGW/tW+mJ7aEXufGeaYuJSXnNswsbJE18fU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5546
X-OriginatorOrg: intel.com
Cc: "mst@redhat.com" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "drivers@pensando.io" <drivers@pensando.io>,
 Shannon Nelson <snelson@pensando.io>,
 "davem@davemloft.net" <davem@davemloft.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: Shannon Nelson <shnelson@amd.com>
> Sent: Monday, November 28, 2022 3:46 PM
> To: Jakub Kicinski <kuba@kernel.org>
> Cc: Shannon Nelson <snelson@pensando.io>; netdev@vger.kernel.org;
> davem@davemloft.net; mst@redhat.com; jasowang@redhat.com;
> virtualization@lists.linux-foundation.org; drivers@pensando.io; Keller, Jacob E
> <jacob.e.keller@intel.com>
> Subject: Re: [RFC PATCH net-next 06/19] pds_core: add FW update feature to
> devlink
> 
> On 11/28/22 3:33 PM, Jakub Kicinski wrote:
> > On Mon, 28 Nov 2022 14:25:46 -0800 Shannon Nelson wrote:
> >> I don't think Intel selects which FW image to boot, but it looks like
> >> mlxsw and nfp use the PARAM_GENERIC_FW_LOAD_POLICY to select between
> >> DRIVER, FLASH, or DISK.  Shall I add a couple of generic SLOT_x items to
> >> the enum devlink_param_fw_load_policy_value and use this API?  For
> example:
> >>
> >>        DEVLINK_PARAM_FW_LOAD_POLICY_VALUE_SLOT_0,
> >>        DEVLINK_PARAM_FW_LOAD_POLICY_VALUE_SLOT_1,
> >>        DEVLINK_PARAM_FW_LOAD_POLICY_VALUE_SLOT_2,
> >>        DEVLINK_PARAM_FW_LOAD_POLICY_VALUE_SLOT_3,
> >
> > Not the worst idea, although I presume normal FW flashing should switch
> > between slots to activate the new image by default? Which means the
> > action of fw flashing would alter the policy set by the user. A little
> > awkward from an API purist standpoint.

This could potentially be handled by having DELVINK_PARAM_FW_LOAD_POLICY_FLASH be the automatic "select best version", and if a user has set a manual value then don't allow flashing until a reboot or the value is set back to POLICY_FLASH?

> 
> Yes, the action of flashing will set the new bank/slot to use on the
> next boot.  However, we have the ability to select from multiple valid
> images and we want to pass this flexibility to the user rather than
> force them to go through a whole flash sequence just to get to the other
> bank.
> 
> >
> > I'd just expose the active "bank" via netlink directly.
> >
> >> I could then modify the devlink dev info printed to refer to fw_slot_0,
> >> fw.slot_1, and fw.slot_2 instead of our vendor specific names.
> >
> > Jake, didn't you have a similar capability in ice?
> >
> > Knowing my memory I may have acquiesced to something in another driver
> > already. That said - I think it's cleaner if we just list the stored
> > versions per bank, no?
> 
> We are listing the stored images in the devlink dev info output, just
> want to let the user choose which of those valid images to use next.
> 
> Cheers,
> sln

Technically I think we could do something similar in ice to switch between the banks, at least as long as there is a valid image in the bank. The big trick is that I am not sure we can verify ahead of time whether we have a valid image and if you happen to boot into an invalid or blank image. There is some recovery firmware that should activate in that case, but I think our current driver doesn't implement enough of a recovery mode to actually handle this case to allow user to switch back.

Still, I think the ability to select the bank is valuable, and finding the right way to expose it is good.

Thanks,
Jake
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
