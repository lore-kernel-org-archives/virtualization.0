Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EFC2BAEB
	for <virtualization@lists.linux.dev>; Tue, 17 Sep 2024 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726576360; cv=fail; b=YH/XVr5qg6Inl4s7nyUDHNL1dmBiSljr3QgMDWTtmIgKYYprO1Vbkv5O8X97IvZJtzIZQUwc652esOHezQ2wvdpUKFuKAlbYMAEkajq0OdJHe3+B9rL1B3fv8uUfL1Kpiyq7qlaGjuwkhNoOFGS9glM2slDZ0TOFSeLYzy53Knc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726576360; c=relaxed/simple;
	bh=qL8M6FVyahuV6SF0dp5p0Kxs65z1K8diqvltULMJe6U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f5VevzcU94ZMrl0tul6UwL6wlpDV5FZS6LPSJMOXBhcY6OcUCADdcese1JjhmBFprMlI1vR8KvMfZSe6PY/vHEtT9LWdGUvV6CuP0U/A0mSv4lkG6oH349dAej1FYngCvvAP0KZPzLg1jsQEsEzX869howSD5B34QvaYRzd5xvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=JMs0tAzl; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="JMs0tAzl"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H1jBiS009676;
	Tue, 17 Sep 2024 05:32:06 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41na0g28b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 05:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMbjUYMGE9udK42KELX9gZrCHsBSNrQXWbaeqVFBkA+9WHB1OkhZO0BA2t0EFXZ67SruibBx0Hy/9aGANnTpYb3B5k0GlGUJnF7LcLH13X35viaqiR0TsRR8UuSu13hF6kRXp8tg/ChLGQRPAThL/u7nd9p54SEOk2OojgVZTUb15GwYr9UzSztIzFk5WjFLacAz6TnGKigBZ7S5uK+1wLgR8TSaG8rbVRPtqXwpaSoVtydLvEN2gsfjXMb89vGd88+qNPGcJ1YjIiO41W06WUF+Ds0TT/Fzv7WHyzwL5fiagwtmLakqtab6ZZhMcXX/V9KBqr2yZVD3U89Bb3tXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qL8M6FVyahuV6SF0dp5p0Kxs65z1K8diqvltULMJe6U=;
 b=WFmC3/cV+VDHqJswtvMx+pDUCxnQdfC/oqKprB0Yfn0ooSPQh5Q/sWtY57yERc9bi9/wn3ZFOEbcT/EdsQH5dF8Skd8ORbpjhVdA8C3RX/6ugbwxls9LvvE/HLHCnDDOkGjipNQcqs7Qk/NcjjxPAPisMT98HiMfZ/YB7myc+/VIcc3ncVB8rwDJlsh3iWH6YzXIjSMbrGmRVSjhf6a8HgsVsTBRqVR7jYdK7UKru1fJ0eXAT1PTcz0Z5MyQtchpB75DPGYsfncVQgg/1S9ubrPuLXvWflbHjNL/Sn06Ln1YDs3ryLQBcqXxH4shI2ECQNACJVk7tiE6Eeez3k4Tpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qL8M6FVyahuV6SF0dp5p0Kxs65z1K8diqvltULMJe6U=;
 b=JMs0tAzl6yGzUSSJL0fo9EfA86iFHhbH7/GVcprcirG6cUgAnMpWHhNa2akynv11YY9jgVjx330VdZ3LC/xOxEgvmGDkdGSDN6tzs3YjA/HNF3gfW84/a3ZspvZz31vNfN2qlKQ57QhpUlb5ijyqg+Vru0HMPcyq3aS6o3DEEBE=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by PH0PR18MB4733.namprd18.prod.outlook.com (2603:10b6:510:cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 12:32:01 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::ad53:bef2:cc17:13ac]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::ad53:bef2:cc17:13ac%4]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 12:32:01 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
        Vamsi Krishna Attunuru
	<vattunuru@marvell.com>,
        kernel test robot <lkp@intel.com>
Subject: RE: [EXTERNAL] Re: [PATCH] vdpa/octeon_ep: Fix format specifier for
 pointers in debug messages
Thread-Topic: [EXTERNAL] Re: [PATCH] vdpa/octeon_ep: Fix format specifier for
 pointers in debug messages
Thread-Index: AQHbCFS0KAG75dfAdEi6PPVo2f4H3bJarx2AgADLwkCAAG6XQA==
Date: Tue, 17 Sep 2024 12:32:01 +0000
Message-ID:
 <DS0PR18MB536803CD67DECB122BF1B97DA0612@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240916162255.677774-1-schalla@marvell.com>
 <20240916134226-mutt-send-email-mst@kernel.org>
 <DS0PR18MB5368A29EFA2094A2253CD6B2A0612@DS0PR18MB5368.namprd18.prod.outlook.com>
In-Reply-To:
 <DS0PR18MB5368A29EFA2094A2253CD6B2A0612@DS0PR18MB5368.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|PH0PR18MB4733:EE_
x-ms-office365-filtering-correlation-id: 491feb76-0732-4c3a-1d6f-08dcd714bac0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U2FsYUlNSjVWb0cwd0I5UGNpTFdENlR5VEZ2Q2dpd2d5eW1UTWFqNlVPWWhV?=
 =?utf-8?B?cm1wbXNlOFNjQ3NYQnhhUTRIMGtjRTBWeER6a3FxL3JHQmJWbzZESkkyTk54?=
 =?utf-8?B?b0JnY0tQcDk0TVR1WXZjRmVLS3MrNXd3OUFXWFZndjBtcU9USDZXV0t4VFEz?=
 =?utf-8?B?YlAvK1R5Mlc0MFE1ZVRPcFVDOE1LY1dlRnhDWmFVUmpHdHhKSHAyZUp1eDVO?=
 =?utf-8?B?MXJxcWV2YjcydUZNRFBLcnJUQWZkclVCUVp2SStkeFpKOC9xK1lVazAvV2hI?=
 =?utf-8?B?V2ZWMjdFYy9VazZXRTNnUzVxTFBZY1dMcXVTWWxnb1JQdVdybmoxSGJqcUlH?=
 =?utf-8?B?QThiZVB2aGRVeVczQTErNHBSZ0pJQkVGMWVqTkFaeXFCYXlxOFB6MG1sUmFR?=
 =?utf-8?B?U0Fzai8wSlhyUk9YelhIR3Y4V3FvdjFUVUc0bkJPMHFKVTFmTmRzQ2NTelJH?=
 =?utf-8?B?cFBkeE00VVVsL25nSnBub2EvUFlVRnZVTUNkUjZHdnkrczhMb0dPSi9yOWFh?=
 =?utf-8?B?b2d1Y01uemdKQmVBQ1RxcHJQM2tDUVdOT3VSdnRPZWFEQzhuY2dINVBYVG1W?=
 =?utf-8?B?ZDFyaXJpU0hDVERwOHkwV29oeURDalBOVkF3VTlkb29OeDg4YjNFSDNFSDRV?=
 =?utf-8?B?M2xhTlQ5RkRzWW9aRkljM05FWUpRWjlzSC9pcWVJUUgyNEU0N3QxS2F5aVJC?=
 =?utf-8?B?ZWVEMHFFVlFzNEtReVM5WURiR05TZHppRVFIMXk3c1hyZEhOcHNUa2N2a2o4?=
 =?utf-8?B?d1BIVlRBZlgwbDVjVmJzWHlKMnNZeEtNZ0hBVFNHSUQ5NmluQnhHb0R5SlBo?=
 =?utf-8?B?dUFJUlltTzR3T2UzWFRMNDdyNUp5LzZJZkowZDc4R2tramo2c09rOFNHb2hG?=
 =?utf-8?B?S1hQZUt4RFVrYmNSY3ZWaDdudklDR0JaMEQxVkxia2xodTJlQXFwakdzdDha?=
 =?utf-8?B?TTFrd0p4Sm1GZnFJYmE4UDhqMXRXamdKTGVTWTVrd1I1TVlmWjlqV0xreFpz?=
 =?utf-8?B?THE2MjI5cVpubDRkcmJ2Nm1RYXVieW1qNFIwQ2t6ME42VG1JUFRUWWRwaEpN?=
 =?utf-8?B?S3hadjFnbmJSUFFEVXd4T1ROWXdPdjgwNDdsRko1S0VISC9lU0NHQ3M0cmpD?=
 =?utf-8?B?anRjOGU5SzBIcDIrd1Bqam1XMXpUKzRuOGc5c3NzU1Z1RFI2NzhiYjlzbktm?=
 =?utf-8?B?N1hhVUxJSlArNjlFRkkyaWcwcFpVazB1d0grbVVjM284c1dWRU1SSjl1V3ky?=
 =?utf-8?B?MnlxNDhXVUI1aXhuQlFnQ2hURWh1MU5tb0NBc284a2E0ZWgxbUFuclhtTkc0?=
 =?utf-8?B?Z050cWNYREFxb2w4SmFBSjdyWmNObDlNbUpGMlFtZDFuZE5MTnE1WVI1UDF5?=
 =?utf-8?B?eXdVam1nN3lPTk9qeTV0Um9kUVNIZ2xndXdNTTB4VjNxMjJVSmJmN2lYcGFu?=
 =?utf-8?B?N0Qwc3ZvMHpXUVhoOXFHZUQ4ZElJTm13cjVEV0hNVVRGRFNYOTBlY24vUndK?=
 =?utf-8?B?MWFHeTYrL3YwcXVkT0JXcTA1ZFZQV2lWTk1SdzR5ZC9pSXF1a1hTY3QxNlQx?=
 =?utf-8?B?MEU4MkQwb2EyS1hMQTAwblEzb2lvSFlXc0hhS3pDV0lmUGVSb1ExWDRpZzAz?=
 =?utf-8?B?QUZWM0xOVGMzMmVOZkE2OCtpVit4ZFdFeXoxbTA0ZFV3YTFXME9uYno1V2dt?=
 =?utf-8?B?NzlhKzRtbStIVGR2WnFWd01UOHhKbXlIdTc4b2ZIT1c5K1M1Mk1QU2hEUjIv?=
 =?utf-8?B?TWdWbjdrdFBxanN6UDErcTJQbmdPUElxWWtvTVZDVVVrTHhTbGtRc0ZRbWln?=
 =?utf-8?B?WllKUXE0TXNRZnlNWVlNUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR18MB5368.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGJzKzBod2dDQ3pLeFBiV2RXd0x3THBpSHNTUHpMTXcwUGluQ2VvREpnaHFh?=
 =?utf-8?B?eVpBd25PQm1YZjNtZXFENEtxMWJCeEZwbmxNMDRYQ0x3OHNxL2lPOHJUREJB?=
 =?utf-8?B?SFY3cnZZemxSNVcyVXBJTnRqM05wUzRQMUxOQ0pXT2phbmRpb0VUSVRpMlJj?=
 =?utf-8?B?YnRXVFFrM3RZVmpLSXRacFJSSDlOWGdGY09YdEg4NU1mUVRVV25scHJMT1J3?=
 =?utf-8?B?enBIMFpEMEV3VWpzSWVFeHJGM2U4MEZJMEUwNTAxNzJPdnUxcTlGdHFZS2Q5?=
 =?utf-8?B?dXIwNUoxVXQ2eU81Z2hQeHFMcFcrSDhPZThGVTRIZWpIT1BJWkNHOTROREVi?=
 =?utf-8?B?ZGp0U1dlc1NacEt5ZkcxdWVzbnlRYkxWNHBJbnF6NkJacTdUVVdwVCtGL1Bi?=
 =?utf-8?B?Q3BST0Y5eFRYVjF6UXZxaFBJaFg3eHdQOUdMeGhHd1ZrZjY0dVdYNkpYK2RQ?=
 =?utf-8?B?aHlXV1VPdDQ1WDUyM05yNGh0ZWRza3A3YklSZFk2MEh2aGRFSUdlQjg2YzVU?=
 =?utf-8?B?d3VHZ01BS3g2NlBxanpSa3lDbUZUMUE1NE9MU0FhMUp1UUw1S2RCRjB0QWhu?=
 =?utf-8?B?QzJ1M0VFRy8wQVlUSmQyZzFuTzNwdWlYaitEVW96SVVycHh0OFVVbWFMTVpK?=
 =?utf-8?B?alpnOTFCc2t4RUIrQm1HaWw1U0JDMVBHeUwvcVJKOHZNTTh0VE1LQjhHbVNE?=
 =?utf-8?B?enRlcWlGSGRBTkwvNFF3LzBMcEhadExEOVQ3QTVwam8rVng4b0RkWTVYUjJE?=
 =?utf-8?B?cFNMUWc1Q3J0ZzBQaHlJVWY2U0xueUhDSFhyU0dmRDEzYkRsMDdMWHlVOEJt?=
 =?utf-8?B?OHdNdEN6elA0UyszRHRZTmZTeDFDVFh0dUpBRkt5VDNaUFYzamdoZGdNdGNu?=
 =?utf-8?B?TG5LRnJJaDJWTE1iM1B1R1Y0ZmhHRStYM2VScktPUWRjbmFwWElRTjNTQUds?=
 =?utf-8?B?TTYwdG9Ob1FVbXJ1OUhmSzlKNHAyUHB1dklKRW5jQ1VwOVdvNzhzWmlUbW1B?=
 =?utf-8?B?Z3RiY1lwU2hYaGR1dDBLa2pXWHZtM2REVVFOdmc1K0x5aCtjc2lMZWRLeFlS?=
 =?utf-8?B?SEtLZlV2bjNmNGlaN1FRTWJEWnlPNVRzUUllRUxpd1oxUHBKbGdYa1BJUzZ3?=
 =?utf-8?B?YS9GeVE3ZG9GMmdLdXNtQUdGemdJbndscmhjbGxNNUhyU0NLQkl3eGx5cUVw?=
 =?utf-8?B?TzQ2WlZzaW1GZmZJcWVOemExc0s1VTRoMll2MDhJWC9DTHBaNDRxdFlzSkJE?=
 =?utf-8?B?Skd3VnlzdzhsL2xNZTIxbktZaTJlRm5BcGVIb1Voci9KSWY0ZjJXVDl1d3Ex?=
 =?utf-8?B?alN2OXdaQ1h4S1NzQ1p5ejhCbmRybTlrbk5NY2xjZEoydUc0OFlHU24yWmRn?=
 =?utf-8?B?bmhCQ0tWRUtMNEQ1eVZiT1BtbTM4Q01VcVU4WmVnR2pmdXRNaXI4SzlnWllW?=
 =?utf-8?B?akpJVGlNT2ErVnVmT3o5b3kvWGE4SmFaUmluSno2WUcxRXZGMWU1aVFPZnYx?=
 =?utf-8?B?SGZmWVJRR0NOTWo3WXJLb2VnR2ZsRlFvZGp0bXV5WmphbXBibnFTMDFYK0R6?=
 =?utf-8?B?NHFQYkZZdVI0YlVkUWxkZmhobWdSRmJQUklsVEFzcWlrcnRMMUhLeElCN2R5?=
 =?utf-8?B?SWdOWHUxVHhrbXpNdjFES2lqUmFkMXBPa0NqeElVU3pXQ1RRQTZmNldvQWw3?=
 =?utf-8?B?MDRLamM1T1ZRV1VvTUs3TkhlaXZaZjZGeUtlMDNSTWtkdjNwLzRITnNKQkVZ?=
 =?utf-8?B?eE1qdVdia0RlUUpNK1RGL2xPLzBXeHJkOHNQdk9XTE81alRYWkpaM2FVaEcy?=
 =?utf-8?B?QzVqbU9wVWhPbWg4ZVUzWWFyWTVtSG9jN29sSEhXdk1CcHo0WW11NWJESkY3?=
 =?utf-8?B?SlpuQmVSbnFKZkFpUys4MmxoT0JlVVFaZHdJc3VkTm5DZHc4OCtDL2pIZG9n?=
 =?utf-8?B?SzUweGZPZXBKNEdsUDdJUVpIZXhjMEdreVFNbWtJTys5eVFzNEFGTzV5UUdz?=
 =?utf-8?B?K1dycGZRSjVvK1BQVFpDRHhTNFVLZVZORTlSZUdtY0lIdnVrUmd2bHhVSGpi?=
 =?utf-8?B?d2doWGM2VFBubXZyMWMwczUxanRnSEFYdkZlckUvL3JrdURFVUVwTFFCcXlH?=
 =?utf-8?Q?sVrpEFfMOTqtT+mOGNmladR3b?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491feb76-0732-4c3a-1d6f-08dcd714bac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 12:32:01.1716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNOKkfBK9J+6HarnwB9gM8Fibc9rCs/Jcu6CzNPH24yhjkcNfha/rgnrAl1f0r5Mu6gqGYmjiNhtmX0G2a6FlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4733
X-Proofpoint-ORIG-GUID: ALeAuSmpD1reJ0hv-M7BEbMZiAkELHui
X-Proofpoint-GUID: ALeAuSmpD1reJ0hv-M7BEbMZiAkELHui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

PiA+IE9uIE1vbiwgU2VwIDE2LCAyMDI0IGF0IDA5OjUyOjU1UE0gKzA1MzAsIFNydWphbmEgQ2hh
bGxhIHdyb3RlOg0KPiA+ID4gVXBkYXRlcyB0aGUgZGVidWcgbWVzc2FnZXMgaW4gb2N0ZXBfdmRw
YV9ody5jIHRvIHVzZSB0aGUgJXAgZm9ybWF0DQo+ID4gPiBzcGVjaWZpZXIgZm9yIHBvaW50ZXJz
IGluc3RlYWQgb2YgY2FzdGluZyB0aGVtIHRvIHU2NC4NCj4gPiA+DQo+ID4gPiBGaXhlcyBzbWF0
Y2ggd2FybmluZzoNCj4gPiA+IG9jdGVwX2h3X2NhcHNfcmVhZCgpIHdhcm46IGFyZ3VtZW50IDMg
dG8gJTAxNmxseCBzcGVjaWZpZXIgaXMgY2FzdA0KPiA+ID4gZnJvbSBwb2ludGVyDQo+ID4gPg0K
PiA+ID4gRml4ZXM6IDhiNmM3MjRjZGFiOCAoInZpcnRpbzogdmRwYTogdkRQQSBkcml2ZXIgZm9y
IE1hcnZlbGwgT0NURU9ODQo+ID4gPiBEUFUNCj4gPiA+IGRldmljZXMiKQ0KPiA+ID4NCj4gPiA+
IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gPiA+IFJl
cG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+DQo+ID4g
PiBDbG9zZXM6aHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBz
LTNBX19sb3JlLmtlcg0KPiA+ID4gbmUNCj4gPiA+IGwub3JnX3JfMjAyNDA5MTYwNDMxLmJSaFpX
aGlVLTJEbGtwLQ0KPiA+IDQwaW50ZWwuY29tXyZkPUR3SUJBZyZjPW5LaldlYzJiNlINCj4gPiA+
DQo+ID4NCj4gMG1PeVBhejd4dGZRJnI9Rmo0T29ENWhjS0ZwQU5oVFdkd1F6alQxSnBmN3ZlQzUy
NjNUNDdKVnBuYyZtDQo+ID4gPXF5aGxXaDJsRg0KPiA+ID4gRTNTUEZwQl9lSjBLMVJGTWE1Zi0N
Cj4gPiBrY05DaEZIa0NBUkRDWElrek1rX18zc3FzcFBfSzdLR3hhaiZzPWZNdlM2MlhNbWk1SA0K
PiA+ID4gRVNKdUw5djdGWDNjOFJTektDcTdKTTZLaGNvZjR2TSZlPQ0KPiA+ID4gPGh0dHBzOi8v
dXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fbG9yZS5rZXJuZWwu
b3INCj4gPiA+IGdfDQo+ID4gPiByXzIwMjQwOTE2MDQzMS5iUmhaV2hpVS0yRGxrcC0NCj4gPiA0
MGludGVsLmNvbV8mZD1Ed0lCQWcmYz1uS2pXZWMyYjZSMG1PeVBhDQo+ID4gPg0KPiA+DQo+IHo3
eHRmUSZyPUZqNE9vRDVoY0tGcEFOaFRXZHdRempUMUpwZjd2ZUM1MjYzVDQ3SlZwbmMmbT1xeWhs
V2gNCj4gPiAybEZFM1NQRnANCj4gPiA+IEJfZUowSzFSRk1hNWYtDQo+ID4ga2NOQ2hGSGtDQVJE
Q1hJa3pNa19fM3Nxc3BQX0s3S0d4YWomcz1mTXZTNjJYTW1pNUhFU0p1TDkNCj4gPiA+IHY3Rlgz
YzhSU3pLQ3E3Sk02S2hjb2Y0dk0mZT0gID4+IFNpZ25lZC1vZmYtYnk6IFNydWphbmEgQ2hhbGxh
DQo+ID4gPiA8c2NoYWxsYUBtYXJ2ZWxsLmNvbT4NCj4gPg0KPiA+DQo+ID4NCj4gPiBUaGlzIGRv
ZXMgbm90IGZpeCBpdCBjb21wbGV0ZWx5Lg0KPiA+IHJldCBpcyBzdGlsbCAwIGhlcmU6DQo+ID4N
Cj4gPiA4YjZjNzI0Y2RhYjg1ZCBTcnVqYW5hIENoYWxsYSAyMDI0LTA2LTE0ICAxNDAgIAl2YWwg
PQ0KPiA+IG9jdGVwX3JlYWRfc2lnKG1ib3gpOw0KPiA+IDhiNmM3MjRjZGFiODVkIFNydWphbmEg
Q2hhbGxhIDIwMjQtMDYtMTQgIDE0MSAgCWlmICgodmFsICYgMHhGRkZGKSAhPQ0KPiA+IE1CT1hf
UlNQX1NJRykgew0KPiA+IDhiNmM3MjRjZGFiODVkIFNydWphbmEgQ2hhbGxhIDIwMjQtMDYtMTQg
IDE0Mg0KPiA+IAlkZXZfd2FybigmcGRldi0+ZGV2LCAiSW52YWxpZCBTaWduYXR1cmUgZnJvbSBt
Ym94IDogJWQNCj4gcmVzcG9uc2VcbiIsDQo+ID4gaWQpOw0KPiA+IDhiNmM3MjRjZGFiODVkIFNy
dWphbmEgQ2hhbGxhIDIwMjQtMDYtMTQgQDE0MyAgCQlyZXR1cm4gcmV0Ow0KPiA+IDhiNmM3MjRj
ZGFiODVkIFNydWphbmEgQ2hhbGxhIDIwMjQtMDYtMTQgIDE0NCAgCX0NCj4gPg0KPiA+DQo+ID4g
d2hpY2ggaXMgd3JvbmcuDQo+IFRoZSBmaXggZm9yIHRoZSBlcnJvciBjb2RlIGlzIGFscmVhZHkg
aW5jbHVkZWQgaW4gdGhlIGxpbnV4LW5leHQgYW5kIG1haW5saW5lDQo+IExpbnV4IHJlcG9zaXRv
cmllcy4NCj4gVGhlcmVmb3JlLCBJIGRpZCBub3QgaW5jbHVkZSB0aGF0IGNoYW5nZSBpbiB0aGlz
IHBhdGNoLg0KPiBUaGFua3MuDQpNaWNoYWVsLCBjb3VsZCB5b3UgY29uZmlybSBpZiB0aGUgZml4
IGZvciB0aGUgZXJyb3IgY29kZSBzaG91bGQgYmUgaW5jbHVkZWQgaW4gdGhpcyBwYXRjaD8NCg0K
PiA+DQo+ID4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvdmRwYS9vY3Rlb25fZXAvb2N0ZXBf
dmRwYV9ody5jIHwgMTIgKysrKysrLS0tLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92ZHBhL29jdGVvbl9lcC9vY3RlcF92ZHBhX2h3LmMNCj4gPiA+IGIvZHJpdmVycy92ZHBh
L29jdGVvbl9lcC9vY3RlcF92ZHBhX2h3LmMNCj4gPiA+IGluZGV4IDExYmQ3NmFlMThjZi4uMWQ0
NzY3YjMzMzE1IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy92ZHBhL29jdGVvbl9lcC9vY3Rl
cF92ZHBhX2h3LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9vY3Rlb25fZXAvb2N0ZXBfdmRw
YV9ody5jDQo+ID4gPiBAQCAtNDc1LDExICs0NzUsMTEgQEAgaW50IG9jdGVwX2h3X2NhcHNfcmVh
ZChzdHJ1Y3Qgb2N0ZXBfaHcNCj4gPiAqb2N0X2h3LCBzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4g
PiA+ICAJCWRldl9lcnIoZGV2LCAiSW5jb21wbGV0ZSBQQ0kgY2FwYWJpbGl0aWVzIik7DQo+ID4g
PiAgCQlyZXR1cm4gLUVJTzsNCj4gPiA+ICAJfQ0KPiA+ID4gLQlkZXZfaW5mbyhkZXYsICJjb21t
b24gY2ZnIG1hcHBlZCBhdDogMHglMDE2bGx4XG4iLA0KPiA+ICh1NjQpKHVpbnRwdHJfdClvY3Rf
aHctPmNvbW1vbl9jZmcpOw0KPiA+ID4gLQlkZXZfaW5mbyhkZXYsICJkZXZpY2UgY2ZnIG1hcHBl
ZCBhdDogMHglMDE2bGx4XG4iLA0KPiA+ICh1NjQpKHVpbnRwdHJfdClvY3RfaHctPmRldl9jZmcp
Ow0KPiA+ID4gLQlkZXZfaW5mbyhkZXYsICJpc3IgY2ZnIG1hcHBlZCBhdDogMHglMDE2bGx4XG4i
LA0KPiA+ICh1NjQpKHVpbnRwdHJfdClvY3RfaHctPmlzcik7DQo+ID4gPiAtCWRldl9pbmZvKGRl
diwgIm5vdGlmeSBiYXNlOiAweCUwMTZsbHgsIG5vdGlmeSBvZmYgbXVsdGlwbGllcjogJXVcbiIs
DQo+ID4gPiAtCQkgKHU2NCkodWludHB0cl90KW9jdF9ody0+bm90aWZ5X2Jhc2UsIG9jdF9ody0N
Cj4gPiA+bm90aWZ5X29mZl9tdWx0aXBsaWVyKTsNCj4gPiA+ICsJZGV2X2luZm8oZGV2LCAiY29t
bW9uIGNmZyBtYXBwZWQgYXQ6ICVwXG4iLCBvY3RfaHctDQo+ID4gPmNvbW1vbl9jZmcpOw0KPiA+
ID4gKwlkZXZfaW5mbyhkZXYsICJkZXZpY2UgY2ZnIG1hcHBlZCBhdDogJXBcbiIsIG9jdF9ody0+
ZGV2X2NmZyk7DQo+ID4gPiArCWRldl9pbmZvKGRldiwgImlzciBjZmcgbWFwcGVkIGF0OiAlcFxu
Iiwgb2N0X2h3LT5pc3IpOw0KPiA+ID4gKwlkZXZfaW5mbyhkZXYsICJub3RpZnkgYmFzZTogJXAs
IG5vdGlmeSBvZmYgbXVsdGlwbGllcjogJXVcbiIsDQo+ID4gPiArCQkgb2N0X2h3LT5ub3RpZnlf
YmFzZSwgb2N0X2h3LT5ub3RpZnlfb2ZmX211bHRpcGxpZXIpOw0KPiA+ID4NCj4gPiA+ICAJb2N0
X2h3LT5jb25maWdfc2l6ZSA9IG9jdGVwX2dldF9jb25maWdfc2l6ZShvY3RfaHcpOw0KPiA+ID4g
IAlvY3RfaHctPmZlYXR1cmVzID0gb2N0ZXBfaHdfZ2V0X2Rldl9mZWF0dXJlcyhvY3RfaHcpOw0K
PiA+ID4gQEAgLTUxMSw3ICs1MTEsNyBAQCBpbnQgb2N0ZXBfaHdfY2Fwc19yZWFkKHN0cnVjdCBv
Y3RlcF9odw0KPiAqb2N0X2h3LA0KPiA+IHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiA+ID4gIAl9
DQo+ID4gPiAgCW1ib3ggPSBvY3RlcF9nZXRfbWJveChvY3RfaHcpOw0KPiA+ID4gIAlvY3RlcF9t
Ym94X2luaXQobWJveCk7DQo+ID4gPiAtCWRldl9pbmZvKGRldiwgIm1ib3ggbWFwcGVkIGF0OiAw
eCUwMTZsbHhcbiIsDQo+ID4gKHU2NCkodWludHB0cl90KW1ib3gpOw0KPiA+ID4gKwlkZXZfaW5m
byhkZXYsICJtYm94IG1hcHBlZCBhdDogJXBcbiIsIG1ib3gpOw0KPiA+ID4NCj4gPiA+ICAJcmV0
dXJuIDA7DQo+ID4gPiAgfQ0KPiA+ID4gLS0NCj4gPiA+IDIuMjUuMQ0KDQo=
