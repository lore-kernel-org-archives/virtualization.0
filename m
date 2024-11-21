Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7653A2309B6
	for <virtualization@lists.linux.dev>; Thu, 21 Nov 2024 05:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732167817; cv=fail; b=g+2CNo/fn7y2Q4RkWIPlc3X6Qjf4grqKK17HeysBAPJgKVHtO07vonFQZIA+Zu8vcZ32cXUrdm2wjhdd2s0+CW35RrZu1T+bkytOuFByb5Cj6wPlb10UZ26hUCfLKUj8l9QUJ7ofvvUQBRiSB5jO31BH72LUoQKac3t56tSuEjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732167817; c=relaxed/simple;
	bh=Y2wbF9YMQuAd6rDaG8CxcMigcvo0DItdbCidNQLf0uM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UI+odEHuPH6+kdxCaHwy7BIwb475Gv71Jg7o+Kgx8QZ6JO9zrPmJhejBMih/SyzaFNZQFv9f7RTmn+yGdv1ob9WCUmy/BaTza4NhzOW3tu3sl25QMcH/tZB8ujDenUmWFoqSiZcRCS3daELQXCrq3oNq6u4BRXrcq5PenGVKUK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=P5snKWme; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="P5snKWme"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKLsCOY000402;
	Wed, 20 Nov 2024 21:42:50 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 431h4y1n7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 21:42:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thTTdPbZscNyJmIQEsNci2TmdsbQlw9fs4jhNLNkUAIhCUtMnacLZfMAVk2K51gPvEyb1b1yQkfCDtIweiYY/EpAGubILEwdliaQZ3Kj/vsVTVJ00nbwR3cRWPcQypYHALc7VutyHeL4j4wGUwMHbPzPXobgdhsPlK7cxtNnzUDEhhVD7cZMsFCAJYTloP0sC3spu4qsDcZHfIic9ITAt/FO2x70SmU9hnEibEIHyHqDvoUWYlVszc81GGQPH9HR82sdsYMNUJp5+AhJQhiwlTvJParV9Q5P2Hh+TlPMrifDf01BV/oMK761ysLodluRi0tR7BQHytcZ/QKYW5AXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2wbF9YMQuAd6rDaG8CxcMigcvo0DItdbCidNQLf0uM=;
 b=vQ/UFY9c42HVYGcFWqQzdNtN8uqLhCAt+/xlhce5398rpbdBLWiNoiQzqP/j6CVnezrlTwJF09Eeml8orfRmA+nO+0nVTJ2cn9drtNrPCK3joYxjl+MB94STxJ376wqE6d9oB4Lofe3Ah0zwUhXar/ZygUzh/w781NWrdkawqkyFtis/TZXelpfl8+JLhcbDkbstzNdkrf5OjBwGb6qDDAsK2ZHlR/lfa4yCOogSVcDTTTXz9rY7/onJ3tquyMtC7jq683pB1wMscOdUPmOusTqU8F9jC4EoJkV3eBIBr8+cdcVQjSJaqbNAZxYxxY4SSjU53WmvIfs5VlDRY+8BLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2wbF9YMQuAd6rDaG8CxcMigcvo0DItdbCidNQLf0uM=;
 b=P5snKWmeWWvQFkOyE5chxrqO3VgwLpoX4/tqzpxyszPVP7ZreuMyMr1xKLpSgE6DNxZj8BY6Pv09S9nHvgIIccGBtLSLgUIUCG1RMeFT4MqS3fRsOj+W/44Kk+5U0lqG1t3rUMKIukn7QTlqDS1ENRyiuFyv+deXHqGthl1AJL0=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by LV8PR18MB5758.namprd18.prod.outlook.com (2603:10b6:408:1ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Thu, 21 Nov
 2024 05:42:46 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%5]) with mapi id 15.20.8158.019; Thu, 21 Nov 2024
 05:42:45 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com"
	<jasowang@redhat.com>,
        Srujana Challa <schalla@marvell.com>,
        Vamsi Krishna
 Attunuru <vattunuru@marvell.com>,
        Nithin Kumar Dabilpuram
	<ndabilpuram@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>,
        =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?=
	<eperezma@redhat.com>,
        Satha Koteswara Rao Kottidi <skoteshwar@marvell.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] vdpa/octeon_ep: enable support for multiple
 interrupts per device
Thread-Topic: [PATCH 1/4] vdpa/octeon_ep: enable support for multiple
 interrupts per device
Thread-Index: AQHbO9gxPAKfOlf6lUm9TWcjfKGBkw==
Date: Thu, 21 Nov 2024 05:42:45 +0000
Message-ID:
 <PH0PR18MB4425C21F5BA5A5B39135B7F2D9222@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20241120070508.789508-1-sthotton@marvell.com>
 <b799bf24-876a-41da-b297-d2323c314674@stanley.mountain>
In-Reply-To: <b799bf24-876a-41da-b297-d2323c314674@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|LV8PR18MB5758:EE_
x-ms-office365-filtering-correlation-id: 5e41426d-d895-4d3c-7e27-08dd09ef5380
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UTR2VjlmR3ZkOFF3VVhqU3o2SFYwWDBBVmxCRlRwdjJQSlFwZXdTY2xoNG9H?=
 =?utf-8?B?OEt6RDF4SjlpTy9ERUJLdHU3eW9sM21GZS8wMVlsbEtwV1pVZ2Q0MkRxK2ho?=
 =?utf-8?B?RWxHdVN3dE8reVE5QVNIem9qeHBXVzhTTndBeHlkdFdLVklGakkrc3VsSXlk?=
 =?utf-8?B?Mm1HWDBDbEwzSFl1OUVzTy9neVZGaHNNY1VWT0IyV0dtc2JRcUJNSnpMb25i?=
 =?utf-8?B?eVI4cFlLUUhNaEtUdVB1NWlRL1h3Nkp5aHdnM0lWWThJaTkxd2U0NC84U1l5?=
 =?utf-8?B?b2ZIMFMzQmZabTVGTFAvVUJCdkJMNlM3cyt1NDFEV1lZM25Gem9NSWd4cUw2?=
 =?utf-8?B?enFRd25rM2d2QVQ3MXVuNkl5LzRxYUMxQkhIUk1uMldIYlRoMkRLZGJ0bXJ4?=
 =?utf-8?B?d205Mjk2OERBUFFPRFZRNEM4QllkRU9WYXRIYjR6bTNUQmNvMnVmVGx3c1Rj?=
 =?utf-8?B?TWdWN1dUcFowcXprbmxUNWJIc2ZwRUw4SDdhcEVZTlUwRU1nRVpCb1g1UnNB?=
 =?utf-8?B?OU9wUytvMUtxYUYwTkZQRDBydEwzSDJ3bGRVYTZPYmNsMVltbk5qbHk3SWgx?=
 =?utf-8?B?SXNaMXBreXJnUDYyckFwTUJWZHUzU1Y1NnYzRXlFb2dUWDNGbk9rWnVkaVNI?=
 =?utf-8?B?YzMvMk4xRXFBMkJXV210YU94aGhjZHptVHpVWjRTM3ZzV3QycUtsV0RlaTB1?=
 =?utf-8?B?V3Y4WjRDSXFjMHQ2dVVrNXFBUVR6S0xMNklMenpnWnUrQXBNcFJkVnJYQmY2?=
 =?utf-8?B?QW9YYzVnWXF1SDArdExTNUo4M0NXTXp5clAyWkg0Sjg3RmQ1djJVeDhnTjEy?=
 =?utf-8?B?YkI3T1dRN1VKVEF0TXZwY0E4WTBjdHNUZEFPaG1pMnpTc0FEOERKK2t4U0V3?=
 =?utf-8?B?ekN3OHE0N0JtR0JINUMvdHIvREd2SG9WZWZ5Umx6a3F0cTcwUlNMQlJtVTc4?=
 =?utf-8?B?Vk91ODlkTTVVVDZtRE5TMDRRcENPdEt0UTNyL2tYd2F4QzErd3BRdmtublha?=
 =?utf-8?B?akpNYTZmTWUxUUcwUnBVUnNWcnR3NCtqVStMSFRvQ25pSTZIQ2xQcU56SHd1?=
 =?utf-8?B?bDFTQ284L3RVRTZ6TC8xcXJUY2RUVkc3S1FWWTJXaGhqaWxpV3FYRXBJQnNx?=
 =?utf-8?B?ZGJDSVBWSkNoekpSV0dCUTR0QnBnVnFyVXExQ05Nc1pYWVg3UXEvdjh0SFRY?=
 =?utf-8?B?MUdhYzZZYTRiendUMmU3Y3RhTEs1bU8yNlAwZXJhcm9RVnY3Tmo2RFJZY3VO?=
 =?utf-8?B?SXZtdVVoODV6bWRpME1NcDdOY0JiOEdaUGc3TngyTUVGOVRLOWhxdDRqOTZ1?=
 =?utf-8?B?YTRJUDNCSVJyU0IvY1ZBNzBWL2EvNVdZSjlLSkRSN3ZTRXBXM0JtdDNmdWFq?=
 =?utf-8?B?aW01S042OFU0NkRadjBHNUZqV1owdmJ4UURteW4xR25BNHZaalh6MTczK3hM?=
 =?utf-8?B?S3BvMHlOTWl5S1FQc0ZXbGJ5L2NweXlXUzhSWjFXNk9lZnRaNzZNVVBld3c3?=
 =?utf-8?B?cVp6elBYTkovU0xwZDdsYm9DNW96TWtvTkorL3lQTGdUQlVpVExEeVpkSFpO?=
 =?utf-8?B?aG5iZWtqbDVmKzdIS1VvSngvVEZxRElnaEVNcWd5UWx0M3NCOEZOZTErMFda?=
 =?utf-8?B?RjIvRC9CMVlzTkNXbUZkMCtlTEoxS0RZNGF0cE1zM00raFdUMGJ0VHAyZDR1?=
 =?utf-8?B?VUg5VlZDa2QvSDR3Qi9HS2MwQzdpSHBUaGpyOHpQYzBWN2haUFIwNmhGeThw?=
 =?utf-8?B?c1grZjNDN3NlS3JxcVZJMnQ0NnkrS3d4NTVtWmlnQktqbEJFcWgwU3lxNDNK?=
 =?utf-8?Q?W2oytGEzSnIFgFjXxyU/aTl1MiUI1Ntafr0A0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZU9OcHRJNzRsVTI5VkZCdTRkTVNkSnFQdWN6Z1Rld0J1dFZNTFBKMndMZTRZ?=
 =?utf-8?B?WXhSU0JqWU1Ja3lFYUF2dVc1ckdqWVl2Zk9lSWRSclVWY2o5UHd4UU1rcEpr?=
 =?utf-8?B?aXpEUjk2S1VVQzZ3WXBqN09XbWRZekd3L2EzS015UGZiR2lDKzhlZVJTVVJh?=
 =?utf-8?B?dWJkVm42Z2syWDNwNWE3Qi8ySTV3Q1JtMTFRdUFuYVN4Q3dvcjZ1Z25tSDc5?=
 =?utf-8?B?b0U0RlJZckVWVWpDMUtMK3NPTk92bG9XZWxBWFpURWlVMlVrdnJOL2xBN3Nz?=
 =?utf-8?B?cVc4b1Q0dE93T1YyNHJwMG1GOFBjMVhsTnczOGtUWVZ6Z2hwU3MwTUNhV1RV?=
 =?utf-8?B?aThja25LVVJEdjl4YnlSeno1L3M2eFkxOTc4V29nV3A1VU9haHF4U0U5L1pR?=
 =?utf-8?B?TDk1WEJGVlFTUnhydURjc2NSekVXd2haRm55TmlRQnN0OWpEbEY1WXQ3dUlj?=
 =?utf-8?B?VEVXZHJvdmtDc3BsODhGTk52VUIyY1MwaW1DVW5wZWZzQUVWYnpnY2NVcGww?=
 =?utf-8?B?cmxHck1zeEhOTEorZ3lRRm5DbGVLZFhhMjVuWCttMHJ1dHM2bWp0a0RSMitN?=
 =?utf-8?B?WFZad0xyN2xON2NJSHpTRmlGL3FqTFd2aHRma08yQlQvZCtqMTlZUGVjblls?=
 =?utf-8?B?a3Y0KzBjYTZUV3hBOHBjY0xubzM0RTFLOCs1d1Z3ZlZuOTF5K0lYK1Q1NXpI?=
 =?utf-8?B?cTBuMzNkeXVYakZ0YUJDSHQ0blkvM3JWelhhcDJCd0JTNXh3VCsxblVWcHRo?=
 =?utf-8?B?R1ppWC9kUGJGbHFQUVdDZXRac2ZEUEV2VnE3SXlxZ1NCc1hnei9adVNqdFla?=
 =?utf-8?B?TTFLS1FaOGpTRUZPZjB3VkJSL2xZZENTNkIwdUxvZElBQTdiVDBTODRVYVhk?=
 =?utf-8?B?TnhBcjY4MnpFZVdYRFFydDRBcFBTNWQxUjA4MVJOSFpQU0ZIMlZiNHJSUkJz?=
 =?utf-8?B?UzIzbWt1ZnRpaTcvZFE2Nm9MV0tRNFlTK21kSmlNbTY4dEtUM05hSE9Oekw2?=
 =?utf-8?B?bXEwQXg0c0gzQ242N2NKSnRHbzZhSUowdnlYSWZzczhaT0NaRzZpQjZzN3dK?=
 =?utf-8?B?VGZpLys1aDJVN08wQXJ0dE5uNWFzaStGQkZma2JsdENOeU1NQXI5eXNNSlVi?=
 =?utf-8?B?N0RpTEpZZWJncmhmRFdxQjNkeWRsekFUaFNkYkhzaFZ0WXJmQXE0ZEdYOFNk?=
 =?utf-8?B?TEdkN1A3TDJuZDFNa0xCaFpXYXJadG1zYTIzSzY0K29ScEZ6NURzNTU1aVVn?=
 =?utf-8?B?S2ZDTm1ua3VoRDlvNzNLUytHR2JBaDh3RXFsbGpubEJJR1djQzgxc0p5TEJ6?=
 =?utf-8?B?Zmg1VVFCTGZXRXpkYm55VHhrRlZBeTR3S3djRllUbVJyQjlrM1R3bElKWnlB?=
 =?utf-8?B?QkxpVFVJZnNrZVVlakordVBud1kwS3VLZEluTmN0OCtTY2JpRlFFNmw2eXVK?=
 =?utf-8?B?V3YvRms4WUt4RmExcFhHTWZMNlRVN2pwcFVmTXhFZmZQM1puQmN2VDZxSXdX?=
 =?utf-8?B?WlBRQzUycnAvMFd3NUwwaGNSVC9oY29NbVBMOUZtaUUwbk5IME5saTJiLy9X?=
 =?utf-8?B?NVloUW5KTXYzU0VaU1BGUzRKWmxKcTdHQzVpR1lpaXViQUJlcm5qckVsWFE4?=
 =?utf-8?B?Wll6eThhTkl1d2dtaEwrZTVuTjRITzVOeWQwbVE3UVdvL28xUnRMdjNGaUht?=
 =?utf-8?B?SHFkVEdyN2RUKzIvdlFZM2RXZXdzWGhMQWFTK2d2Q1JXK2Z3UUs3NU9abG5o?=
 =?utf-8?B?K2NHL0VRZjZib0V5NmxuSHZ0ZkhkZzJyU283UXJqVTY3K1NiUGJNTHN3ZGw3?=
 =?utf-8?B?Y0QwRVZTMG9uc1dhZ29Bc2tvelc2WVkzRjFsNHZRYzQ3MGRKZG11ZWRSRElR?=
 =?utf-8?B?S1hJQzhVbTlxTnBmSktrZ1VvNU5sell3YWRoSWx0VThtdEt4bmY4ZjlSR0Iw?=
 =?utf-8?B?N1ZVMHVsM0pyRm9tcW1OdjRUbFJZM3dUTk95WDY3ZTNHaTlUbUR4b1JUeEds?=
 =?utf-8?B?SGNYcGNWOVJyZnpwOHpWTzByRUFyWW9hYUlBWk1KeFh5UTNYdFFkRkQvMUwv?=
 =?utf-8?B?MkhiRktRU0pUVGs0aHZqSWx5enE2VEVWTnF2YTdoRXFkNm9VSXg2dk9TdHNK?=
 =?utf-8?Q?/AlXCjH4oYRcyZa8UMLnZ+/Ya?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4425.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e41426d-d895-4d3c-7e27-08dd09ef5380
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 05:42:45.9168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kcbf1tAlwj+NvC/XxlHxnM1sdSwlSqLigsx1iiXwLLEXp2jt88zsUstN4OSNEq0UOV4jDHpaO2KG2AEDxnTBxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5758
X-Proofpoint-GUID: Vkwxdc-oJ3Rjv1_hYFibpRSLPl4095Kg
X-Proofpoint-ORIG-GUID: Vkwxdc-oJ3Rjv1_hYFibpRSLPl4095Kg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Pj4gQEAgLTYzLDQ0ICs4MCw1MyBAQCBzdGF0aWMgaXJxcmV0dXJuX3Qgb2N0ZXBfdmRwYV9pbnRy
X2hhbmRsZXIoaW50IGlycSwNCj52b2lkICpkYXRhKQ0KPj4gIHN0YXRpYyB2b2lkIG9jdGVwX2Zy
ZWVfaXJxcyhzdHJ1Y3Qgb2N0ZXBfaHcgKm9jdF9odykNCj4+ICB7DQo+PiAgCXN0cnVjdCBwY2lf
ZGV2ICpwZGV2ID0gb2N0X2h3LT5wZGV2Ow0KPj4gKwlpbnQgaXJxOw0KPj4gKw0KPj4gKwlmb3Ig
KGlycSA9IDA7IGlycSA8IG9jdF9ody0+bmJfaXJxcyAmJiBvY3RfaHctPmlycXM7IGlycSsrKSB7
DQo+PiArCQlpZiAob2N0X2h3LT5pcnFzW2lycV0gPCAwKQ0KPj4gKwkJCWNvbnRpbnVlOw0KPj4N
Cj4+IC0JaWYgKG9jdF9ody0+aXJxICE9IC0xKSB7DQo+PiAtCQlkZXZtX2ZyZWVfaXJxKCZwZGV2
LT5kZXYsIG9jdF9ody0+aXJxLCBvY3RfaHcpOw0KPj4gLQkJb2N0X2h3LT5pcnEgPSAtMTsNCj4+
ICsJCWRldm1fZnJlZV9pcnEoJnBkZXYtPmRldiwgb2N0X2h3LT5pcnFzW2lycV0sIG9jdF9odyk7
DQo+PiAgCX0NCj4+ICsNCj4+ICAJcGNpX2ZyZWVfaXJxX3ZlY3RvcnMocGRldik7DQo+PiArCWtm
cmVlKG9jdF9ody0+aXJxcyk7DQo+DQo+WW91IHNob3VsZCBhZGQ6DQo+DQo+CW9jdF9ody0+bmJf
aXJxcyA9IDA7DQo+CW9jdF9ody0+aXJxcyA9IE5VTEw7DQo+DQo+T3RoZXJ3aXNlIGlmIHJlc2V0
IGlzIGNhbGxlZCB0d2ljZSBpbiBhIHJvdywgYmVmb3JlIHJlLWluaXRpYWxpemluZyB0aGUgSVJR
cyBpdA0KPnJlc3VsdHMgaW4gYSB1c2UgYWZ0ZXIgZnJlZS4NCj4NCg0KSSB3aWxsIGZpeCB0aGlz
Lg0KDQo+PiAgfQ0KPj4NCj4+ICBzdGF0aWMgaW50IG9jdGVwX3JlcXVlc3RfaXJxcyhzdHJ1Y3Qg
b2N0ZXBfaHcgKm9jdF9odykNCj4+ICB7DQo+PiAgCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gb2N0
X2h3LT5wZGV2Ow0KPj4gLQlpbnQgcmV0LCBpcnE7DQo+PiArCWludCByZXQsIGlycSwgaWR4Ow0K
Pj4NCj4+IC0JLyogQ3VycmVudGx5IEhXIGRldmljZSBwcm92aXNpb25zIG9uZSBJUlEgcGVyIFZG
LCBoZW5jZQ0KPj4gLQkgKiBhbGxvY2F0ZSBvbmUgSVJRIGZvciBhbGwgdmlydHF1ZXVlcyBjYWxs
IGludGVyZmFjZS4NCj4+IC0JICovDQo+PiAtCXJldCA9IHBjaV9hbGxvY19pcnFfdmVjdG9ycyhw
ZGV2LCAxLCAxLCBQQ0lfSVJRX01TSVgpOw0KPj4gKwlyZXQgPSBwY2lfYWxsb2NfaXJxX3ZlY3Rv
cnMocGRldiwgMSwgb2N0X2h3LT5uYl9pcnFzLCBQQ0lfSVJRX01TSVgpOw0KPj4gIAlpZiAocmV0
IDwgMCkgew0KPj4gIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiRmFpbGVkIHRvIGFsbG9jIG1zaXgg
dmVjdG9yIik7DQo+PiAgCQlyZXR1cm4gcmV0Ow0KPj4gIAl9DQo+Pg0KPj4gLQlzbnByaW50Zihv
Y3RfaHctPnZxcy0+bXNpeF9uYW1lLCBzaXplb2Yob2N0X2h3LT52cXMtPm1zaXhfbmFtZSksDQo+
PiAtCQkgT0NURVBfVkRQQV9EUklWRVJfTkFNRSAiLXZmLSVkIiwgcGNpX2lvdl92Zl9pZChwZGV2
KSk7DQo+PiArCW9jdF9ody0+aXJxcyA9IGtjYWxsb2Mob2N0X2h3LT5uYl9pcnFzLCBzaXplb2Yo
aW50KSwgR0ZQX0tFUk5FTCk7DQo+DQo+VGhpcyBpc24ndCBmcmVlIG9uIHRoZSAtPnJlbGVhc2Uo
KSBwYXRoIG9yIHdoYXRldmVyLiAgb2N0ZXBfZnJlZV9pcnFzKCkgaXMNCj5jYWxsZWQgb24gcmVz
ZXQoKSBidXQgd2UgcmVseSBvbiBkZXZtXyB0byBmcmVlIHRoZSBJUlFzIG9uIC0+cmVsZWFzZSgp
LiAgVXNlDQo+ZGV2bV9rY2FsbG9jKCkgaGVyZSBhcyB3ZWxsLCBwcm9iYWJseS4NCj4NCg0KU3Vy
ZS4gSSB3aWxsIGNoYW5nZSB0byBkZXZtX2tjYWxsb2MoKS4NCg0KPj4gKwlpZiAoIW9jdF9ody0+
aXJxcykgew0KPj4gKwkJcmV0ID0gLUVOT01FTTsNCj4+ICsJCWdvdG8gZnJlZV9pcnFzOw0KPj4g
Kwl9DQo+Pg0KPj4gLQlpcnEgPSBwY2lfaXJxX3ZlY3RvcihwZGV2LCAwKTsNCj4+IC0JcmV0ID0g
ZGV2bV9yZXF1ZXN0X2lycSgmcGRldi0+ZGV2LCBpcnEsIG9jdGVwX3ZkcGFfaW50cl9oYW5kbGVy
LCAwLA0KPj4gLQkJCSAgICAgICBvY3RfaHctPnZxcy0+bXNpeF9uYW1lLCBvY3RfaHcpOw0KPj4g
LQlpZiAocmV0KSB7DQo+PiAtCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJGYWlsZWQgdG8gcmVnaXN0
ZXIgaW50ZXJydXB0IGhhbmRsZXJcbiIpOw0KPj4gLQkJZ290byBmcmVlX2lycV92ZWM7DQo+PiAr
CW1lbXNldChvY3RfaHctPmlycXMsIC0xLCBzaXplb2Yob2N0X2h3LT5pcnFzKSk7DQo+DQo+VGhp
cyB3b3JrcywgYnV0IGl0IHdvdWxkIGJlIG1vcmUgbm9ybWFsIHRvIGp1c3QgbGVhdmUgaXQgemVy
b2VkIGFuZCBjaGVjayBmb3INCj56ZXJvIGluc3RlYWQgb2YgY2hlY2tpbmcgZm9yIG5lZ2F0aXZl
cy4gIFRoZXJlIGlzIG5ldmVyIGEgemVybyBJUlEuICBTZWUgbXkgYmxvZw0KPmZvciBtb3JlIGRl
dGFpbHM6DQoNCkkgYXNzdW1lZCBJUlEgbnVtYmVyIDAgd2FzIHZhbGlkIHNpbmNlIEkgc2F3IGl0
IGxpc3RlZCBmb3IgdGhlIHRpbWVyIGluICANCmAvcHJvYy9pbnRlcnJ1cHRzYC4gSG93ZXZlciwg
aXQgbWlnaHQgYmUgbGVnYWN5LiBJIHdpbGwgdXBkYXRlIHRoZSBjb2RlDQp0byBjaGVjayBhZ2Fp
bnN0IDAgaW5zdGVhZCBvZiAtMS4NCg0KPg0KPj4gKw0KPj4gKwlmb3IgKGlkeCA9IDA7IGlkeCA8
IG9jdF9ody0+bmJfaXJxczsgaWR4KyspIHsNCj4+ICsJCWlycSA9IHBjaV9pcnFfdmVjdG9yKHBk
ZXYsIGlkeCk7DQo+PiArCQlyZXQgPSBkZXZtX3JlcXVlc3RfaXJxKCZwZGV2LT5kZXYsIGlycSwN
Cj5vY3RlcF92ZHBhX2ludHJfaGFuZGxlciwgMCwNCj4+ICsJCQkJICAgICAgIGRldl9uYW1lKCZw
ZGV2LT5kZXYpLCBvY3RfaHcpOw0KPj4gKwkJaWYgKHJldCkgew0KPj4gKwkJCWRldl9lcnIoJnBk
ZXYtPmRldiwgIkZhaWxlZCB0byByZWdpc3RlciBpbnRlcnJ1cHQNCj5oYW5kbGVyXG4iKTsNCj4+
ICsJCQlnb3RvIGZyZWVfaXJxczsNCj4+ICsJCX0NCj4+ICsJCW9jdF9ody0+aXJxc1tpZHhdID0g
aXJxOw0KPj4gIAl9DQo+PiAtCW9jdF9ody0+aXJxID0gaXJxOw0KPj4NCj4+ICAJcmV0dXJuIDA7
DQo+Pg0KPj4gLWZyZWVfaXJxX3ZlYzoNCj4+IC0JcGNpX2ZyZWVfaXJxX3ZlY3RvcnMocGRldik7
DQo+PiArZnJlZV9pcnFzOg0KPj4gKwlvY3RlcF9mcmVlX2lycXMob2N0X2h3KTsNCj4+ICAJcmV0
dXJuIHJldDsNCj4+ICB9DQo+Pg0KDQpUaGFua3MsDQpTaGlqaXRoDQo=
