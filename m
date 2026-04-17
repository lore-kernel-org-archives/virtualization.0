Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C2B2E1F06
	for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776418864; cv=fail; b=ogxfKaF169SZBaClCFw3zeZ8rGNocFmqlt3GzJCCoH7h1X1d3OFEyKF5mr2ZvNzYlUu4frB5ArWWtePZDtq7743FmXCdIIKUWQNmSksxlNTtGbW8oOd94m7gWEjmMJ09GMwOtGUpTiP6mmaxcKNoFQmszo9UAoJOw/bhShNyzjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776418864; c=relaxed/simple;
	bh=+IDJ8rmDqrQe9QlVcnDYCWmL879IXUXwkIM9kPL9GWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IEAK01ZaXHavTARSHiV/sEfy0VdJsGVYfe0xXhUeBv48wTe/OFTHl5MpZkW0k/A7xtz/OfHl0ZYHb/kHr+zq9qYhur/zT4VqLBOTYD+U115RvOvav81QQTUHdub86uG68MjaM9/xuEttHJA7DSmT+EVXEdJHxSqFSLvZz9xUXZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dZAgscaU; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=KEYj1ce2; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dZAgscaU";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="KEYj1ce2"
X-UUID: 88d258883a4111f19a16598d5ca7f8ec-20260417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+IDJ8rmDqrQe9QlVcnDYCWmL879IXUXwkIM9kPL9GWU=;
	b=dZAgscaUUTOLivEbwAsIPXSM4oCzq1CfmZimWcJfkeiuTGsIRvgta1PKZCx8glahTFHeiFIQzo1CWVY5yOaloj/bPUtzPqookLFdlpxoMFpBcDZAc8/oBPr1LWSadIhafLn4fkOu0WTD+DlKVULQ/TD/i/jogNMM+ACSxbG9gH4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f15ebaa3-db6c-4c70-8fc2-ea4203b6b7cc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:c4f7f9d5-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS
	:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 88d258883a4111f19a16598d5ca7f8ec-20260417
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <morris.pan@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 818725417; Fri, 17 Apr 2026 17:40:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 17 Apr 2026 17:40:55 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 17 Apr 2026 17:40:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAFW47RLbyhgLMF136YBBAHrnDYASJvvstounTWfsmLdcyexBSho00MGoNo5Uf0VVVKuieMXFqhDpJO7lCFEgYv/FBmyLDJNhauDUy1Rj77WF9PlVNBmp6FPvOFUSmbxbXf/cJBi02dPsVmk/9hvzCGsyydO28KD66sAL6FRixUUCRgGywViCRNOZ3omv//cXRJP/qIN0f0+Rowcvo9pW2BhNUMuR/enNywiA9/rLsLDy+aZ8reM+933tzF79EzeKt09j+PNROzFi+aZGFzWspRkZcrtCIsrm56vK4TXzCml85sfFZICwqzzybQJYKfyQCX2XEpu6f8cmnfBAYX4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IDJ8rmDqrQe9QlVcnDYCWmL879IXUXwkIM9kPL9GWU=;
 b=VKk+0WytJbjKHbSLte2PWKt0vCrqLcxEGH68BGEy6PmizqIbjd7fFwIMekVPlfEhUN380rHcviMCvWNCCxaX7iYXs7HeXCa0/jvl5O0hREdntbJAkUUMADcbgHjKEBgqPufiwI/G+LzqXalCfZa3jUByJS65IcLNAyKGj4DR/NRqPp51bHvbJLCSBH1LIOaGYZUaGNOdyKliImL0LqKo70x6qoXkHDCTBdXy2y5ziixjyuZjMBLIV+fQBzchhe0o60tuECC0w4F6iut6NthUiu3PLa81uAf5evHwoO3P0cwhoo08cweiJh+3GUDzW9LWMNfd45xJpIR9DGsWVoY2kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IDJ8rmDqrQe9QlVcnDYCWmL879IXUXwkIM9kPL9GWU=;
 b=KEYj1ce2xY+03zr+OGqNG2Z9OmofnsqL+vch/Ru+0iVt0LnunGxwQNKbvFoS2Jvqmrtwlb+X+kcUCnjL4vhlVY2u9cfGQEJCoCfSJPjfxOsae2NMH6AOZHG+a1g6VJVGJ7xNC3lD/aQZIRV1TZAXNZrOJ1hMOky2LE+7RaG4tCo=
Received: from TYUPR03MB7137.apcprd03.prod.outlook.com (2603:1096:400:344::14)
 by SG2PR03MB6432.apcprd03.prod.outlook.com (2603:1096:4:1c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 09:40:51 +0000
Received: from TYUPR03MB7137.apcprd03.prod.outlook.com
 ([fe80::be01:24ff:a95d:a7e]) by TYUPR03MB7137.apcprd03.prod.outlook.com
 ([fe80::be01:24ff:a95d:a7e%5]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 09:40:51 +0000
From: =?utf-8?B?TW9ycmlzIFBhbiAo5r2Y5rOw54K6KQ==?= <Morris.Pan@mediatek.com>
To: "airlied@redhat.com" <airlied@redhat.com>, "kraxel@redhat.com"
	<kraxel@redhat.com>, "dmitry.osipenko@collabora.com"
	<dmitry.osipenko@collabora.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "gurchetansingh@chromium.org"
	<gurchetansingh@chromium.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"olvaffe@gmail.com" <olvaffe@gmail.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
	<mripard@kernel.org>
Subject: Re: [PATCH] drm/virtgpu: Add PM support for suspend/resume
Thread-Topic: [PATCH] drm/virtgpu: Add PM support for suspend/resume
Thread-Index: AQHcwZ5JG8otlcPAHU6mSWtMIDwtXrXVK7iAgA3tmAA=
Date: Fri, 17 Apr 2026 09:40:51 +0000
Message-ID: <26884a5a6043ce2d146456644cd7e37278b0edb0.camel@mediatek.com>
References: <20260401061050.1035881-1-morris.pan@mediatek.com>
	 <2175a05a-d83f-4252-bbf8-581ae652a6b8@collabora.com>
In-Reply-To: <2175a05a-d83f-4252-bbf8-581ae652a6b8@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR03MB7137:EE_|SG2PR03MB6432:EE_
x-ms-office365-filtering-correlation-id: 68afddea-71fc-4103-0764-08de9c6569f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Ygd/fOccy3I5F4Ps/UrIYdzGQ6NNWJcimjNON9HzaQH8Iud3FH1hnOEi+61A4UM+osrgJ+NlBrm8hrrgP+ScNmgzq4p46oEILsOX85Y5PhJuU6GOCDj1JKey6BE5983NKpBvzI2JbtJSwswjFP2pjmNla/tYvms5AuUTGMK734qSjepLQZcpPKBwtfRDN/O5rATSQ35psTJf6q0xeplmhr+dFIfGpJE7SmL2IUqyfN+EuDpcA4WbOFcpBxHUDRINVyPZSu9eVdo8NNb3jiJnv2HykLoe3yAahy0r+ty3+MMTVkg8dmJM/Bc22WDQ9Q0mvDlBleNSMnTr/tKhSOTB5EsWJCA+ZmTH1cPerLgNxe6hT33YG7fCoZVatAFUq4VpQJmRVwK4qzqmaPjktI8+WnQmP+gJtSR9wmKH18kU3ePO3I0bnxGANPII4bjjox55+9CmttwEJqC2k0g4Nf5uGRPpl+CpQ805CT4wiLhKB06oHCfEgadONPP3Ji2vYvWin4MD+QjgW+iYtfH1gsAmu+DpdXxzQK+Q6olgN0ktYtH7VVkJHAhr7+ZwJrmCAiwOXsGKRgYozLojeCaIZSxLTiYIVbz3Q2PWMali0RiP33b0Tvusi5WmN5dKS5kBIcXEEuN+hPp5MXNN/2lpFGZgWbbBkmN5sRHRXTDuqIMIxStFtGI5L1Wor4WMQRULNdUWRjy2od7oGh2gDw1CSoMfNmvz2PYQZcsi2swx/qgU/0xOzeUzFvGerBnR9G8RK++OWDBO7GOSPl+rAZmt/uSmSmfg1ltVBbI9/GhBpXWhJ74=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR03MB7137.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVF5U1h6ZnpxemYvV2ZRUjhXY2t1RVlLL0ppNkpzSHE1VDlJcTBvaDBYQi9u?=
 =?utf-8?B?WjFhSTkveXRRVE9pOElwZm1TQURtcFRKR05pMUd4UEZEWUtiaVZMWE5tTnhn?=
 =?utf-8?B?VkhYK0lFOVo4SW5TeXNHaUM4WGd1NXBpSldHOG5CNkowSnlHbzMzY25BdVBK?=
 =?utf-8?B?OXNqRklFQWlpSnhaSzNmbFUyOURsc1pRak5Vc09XWFJsVTd2cGdSOW9ZZHZG?=
 =?utf-8?B?TG5MU2Y2a002Q2V2K1VtdVhyaDhHTCtYRWsxdVBnVWNKdXhZMTN6Y0lTKzRm?=
 =?utf-8?B?aEJRUnpHeDNZby9OM2tKUW94QjZxbEFWRWJ2YmNHbS96OUd2dDliZytFTTFZ?=
 =?utf-8?B?NTVvbjNTREZVYWJpNC9uZ2pCNmYvak1XWGJLODE0azNkSGNKWmY0NUIwUTBV?=
 =?utf-8?B?SjNEdWp4cTBSeVJpWkxHVjc5UmFwN3RXOWVIRUEvREpObkxab2tscXZrVXpj?=
 =?utf-8?B?OXVNd3BmRHBHdHlCSzBUUDRaeXdlTldhdGlXR2xFTGZvOGNNRTQ3MWptVWs2?=
 =?utf-8?B?QS9rSzRONkNVaUpSUkIyRjZyWWZvaTM5Q1ViWXhjRVBpZlREamd4a0xEQUt6?=
 =?utf-8?B?SWdtZ0pFaHdXNG9tOTJJWnFBQlBTWnJOWGZ3NTg5Y3NxNXYyYWkxbkpDTEh4?=
 =?utf-8?B?R2xHeWkzZzhMM2V5aGhjMlVZR3dDM0xKWHhybS83V1lDT0xKejF2MlgzTXdE?=
 =?utf-8?B?YVY3d1BzajdwZTJJS2N2YXA2T2tXRVVKbXAycnlDN1dxazU2UndOSkQ2TTR4?=
 =?utf-8?B?SCsyRUhBYzBKRFJTOGJ6WU5uNVRPLzZ4R3lQc0NMNW9vTlIyZ2xPYjJsamZE?=
 =?utf-8?B?dHFMdEcyQ0hySldzRzR2TlRRTERqS1dWU3Fmc0ROVVBHQ1poMjZHSklOM0Vr?=
 =?utf-8?B?OHNHb0phMDVHTjdvdzFOZkRnWm5NcFBsbldSWTN2enB0eXBkNE1kakRXZVJQ?=
 =?utf-8?B?UFkxL2FSTkRKOTk2VXVXYUNHTXVZWVJCeHVEbHJwUHFXMWpuUG1RVWxyR2Nr?=
 =?utf-8?B?OHp6VURCanFaRTlsMkhGSUh0QVo4K01wVXVpZStKU3VGR1ZNdFpWQTQwY21C?=
 =?utf-8?B?c25GUGcya2FXZW5YbjdFc2JEbDhKWURsRGdFZDA5U3ZOZWxOSlhmUitWR0dw?=
 =?utf-8?B?Y1dsL0ZGRHRwSHJKdVBTNEVNTVMyMFlJYjk3SU5aWXFEbW9neXVBY3BHbTQ0?=
 =?utf-8?B?S000R2tkd3hTSUN0a2tCZ2tDY1hlWG0xY0FUTWsvNmZJaUZ5cEhXMVhXbmJx?=
 =?utf-8?B?Vjlxa0pVSlF2UFU0UDNLT1FOeFQ4QlZ3NVhucHRXN1RpVjJ6QVV0eHJBaGEv?=
 =?utf-8?B?RnJzK1hVNFArSUorbitweDErT2MyWVNybStmZ1Y1NEo4WmlkYms3em9vWjNy?=
 =?utf-8?B?RkNsMk9ranVOK2xidFJJMWpSN1pqZEJPdkVtY2tqZmVyNUwrKzFaOEMxbE80?=
 =?utf-8?B?YWh3QTZwSmVkZ3dDeFM1RGtJYW9wMlVCei9mdit1K1RkSnR5Mis3cEdQdnZO?=
 =?utf-8?B?ZjNJYythN3hDL0NIQmgxZHY3KzNhV0FYNXV4a1Y1bzk3QTJGN0ZNRTluNmxR?=
 =?utf-8?B?MWVWaHpzNDdOMUk4N1dHemtFTUVlTDEvWGxpRVlsd1plU1RDR3pzZW5leWlD?=
 =?utf-8?B?UGg5bmhPVE42L2E2aUdzSDJycmpseUNlKzRTcW1qazNla3crU2dlVjVlRDR1?=
 =?utf-8?B?WFgwSWVPWXordFN5cWpRQ1IyaFN4MWc1bUZRWkt3dWRrOEhMTkRkQnNURTVp?=
 =?utf-8?B?WGpyYnpWT3BXMmNmS3AyZ0piWDB1ZXR3WU5Hald2UjNNWDdwaW5ZckVPOW5m?=
 =?utf-8?B?OEJ3U2N4eE5wSUc0NEkxV2VlQTZJWHB3aUFhQTZDTWN3a3hTWWNoYUUyRUdr?=
 =?utf-8?B?ekRGWjkvaWVMR0R6d0pHeG0yOVM4dFU1cXpwVHU3Z3lEWS9kRTlVclVOOXRm?=
 =?utf-8?B?eVhRZUJvTWgvNHJjWitEb21UclZ0ZS9xVVhlTGhUSjRLbUxWY0hXanN0d0p2?=
 =?utf-8?B?TTBVdVBQZ0dQcys5TUFJL05NWGdwdUtSMGMza2REUDQ5VXhWVytGYnZVNWU2?=
 =?utf-8?B?QzdxMkh2NnhjdFJHS1FieEZpblBLd0s1OEtrMWFPK0RzUUJTNFlobHBVWmdq?=
 =?utf-8?B?Z1dQd3JMcDY1YzRlN05nQlZUU2k4Y3JjNldSMEJEaDhFSGtYNXpoamp4OGZu?=
 =?utf-8?B?ZXRvNHRRK1hqeG5ZT1BkMWxFd0lXb1VVdzdURmVvL011S0lEL2g1T2pna1NX?=
 =?utf-8?B?YkZxWi9Qbi9PeVhFOW9ERmwxcG5Za1NaZkFOUVhaT0N6bXdFU0tIcVRpc1dK?=
 =?utf-8?B?Q0NEeDdQZjhNZFM5Q3ZiUEtMUUVCM0xtZUp2QTNCL2hLcWwrQ0FRckdJZ2R1?=
 =?utf-8?Q?s/K6f2ZQ1GY1XL1o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B31FC8576670EC40B7BE20F7FE66A798@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NjZT8fqUyGRhqA6zEKShH3wFlmddeRL5BWgHp+W6TQBWMq6a2mUsUFUu87sNj1ttbCo5BuEDOp/ALqifwuPKs4WKVhBOZ/Rs/uJhFo/J1zNnSxUDcC8NmimifKkwc8hj5MCNF4u6bYztD6vaNL4TVqshCmw42MiU/Ypw4G8z5xr07pOcIZ42Lyz+U7ttSH7/ZdL/DcCk5ZzIHQYf5yekXfblP3v2RlbCUFw/MzG3mX1mu631c1+cDioS5+dTfozKFze/BsNG+sSNXPZ6A6jLOo70OirDNZFE9CUYEC1HIFthqaZtmokYwmHdynw7ORZr8Nv/Tex7X3mjtltw4LN65w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR03MB7137.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68afddea-71fc-4103-0764-08de9c6569f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 09:40:51.6019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIN0JlV9/5uplui0dvdd74jzdMx36f8FY0xWmsrNz26js6Tv8/PkvRP2iN8jcg6E06YQmwN8vg6cftZEzHrSOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6432
X-MTK: N

T24gV2VkLCAyMDI2LTA0LTA4IGF0IDE1OjU5ICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6
DQo+IEhpLA0KPiANCj4gT24gNC8xLzI2IDA5OjEwLCBNb3JyaXMgUGFuIHdyb3RlOg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdmlydGlvL3ZpcnRncHVfZHJ2LmMNCj4gPiBiL2Ry
aXZlcnMvZ3B1L2RybS92aXJ0aW8vdmlydGdwdV9kcnYuYw0KPiA+IGluZGV4IGE1Y2U5NmZiOGEx
ZC4uZmJjYTBhODI5NThjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS92aXJ0aW8v
dmlydGdwdV9kcnYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS92aXJ0aW8vdmlydGdwdV9k
cnYuYw0KPiA+IEBAIC0xNDUsNiArMTQ1LDQwIEBAIHN0YXRpYyB2b2lkIHZpcnRpb19ncHVfY29u
ZmlnX2NoYW5nZWQoc3RydWN0DQo+ID4gdmlydGlvX2RldmljZSAqdmRldikNCj4gPiDCoAlzY2hl
ZHVsZV93b3JrKCZ2Z2Rldi0+Y29uZmlnX2NoYW5nZWRfd29yayk7DQo+ID4gwqB9DQo+ID4gwqAN
Cj4gPiArI2lmZGVmIENPTkZJR19QTV9TTEVFUA0KPiA+ICtzdGF0aWMgaW50IHZpcnRncHVfZnJl
ZXplKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQ0KPiA+ICt7DQo+ID4gKwl2ZGV2LT5jb25m
aWctPmRlbF92cXModmRldik7DQo+ID4gKwl2aXJ0aW9fcmVzZXRfZGV2aWNlKHZkZXYpOw0KPiA+
ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+IA0KPiBWaXJ0SU8tR1BVIHNob3VsZG4ndCBi
ZSByZXNldCBmcmVlbHkuIFNlZSBbMV0gYW5kIGZvbGxvdyBwcmV2aW91cw0KPiBoaWJlcm5hdGlv
bi1zdXBwb3J0IGRpc2N1c3Npb25zIG9uIHRoZSBNTC4NCj4gDQo+IFsxWw0KPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9kcmktZGV2ZWwvMjAyNjAxMDcxODI3NDUuMjI5NDgxLTEtZG9uZ3dvbi5r
aW1AaW50ZWwuY29tLw0KPiDCoA0KPiANCg0KSGkgRG1pdHJ5LA0KDQpUaGFuayB5b3UgZm9yIHRo
ZSBndWlkYW5jZSBhbmQgZm9yIHBvaW50aW5nIG1lIHRvIHRoYXQgdGhyZWFkLg0KDQpJIGhhdmUg
bG9va2VkIGludG8gdGhlIHNlcmllcyB5b3UgbWVudGlvbmVkLCBzcGVjaWZpY2FsbHkgIlBBVENI
IHY3DQoxLzM6IGRybS92aXJ0aW86IEZyZWV6ZSBhbmQgcmVzdG9yZSBob29rcyB0byBzdXBwb3J0
IHN1c3BlbmQgYW5kDQpyZXN1bWUiIChsaW5rKS4NCkkgaGF2ZSB2ZXJpZmllZCB0aGF0IHRoaXMg
Y2hhbmdlIHJlc29sdmVzIHRoZSBpc3N1ZSBJIHdhcyBleHBlcmllbmNpbmcNCmluIG15IGVudmly
cm9ubWVudC4NCg0KSSB3aWxsIGtlZXAgYW4gZXllIG9uIHRoYXQgc2VyaWVzIGFuZCBmb2xsb3cg
aXRzIHByb2dyZXNzLiBUaGFuayB5b3UNCmZvciB5b3VyIHRpbWUgYW5kIGhlbHAuDQoNCkJlc3Qg
cmVnYXJkcywNCg0KTW9ycmlzIFBhbg0K
