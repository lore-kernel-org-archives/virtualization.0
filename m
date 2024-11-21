Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76D13665B
	for <virtualization@lists.linux.dev>; Thu, 21 Nov 2024 05:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732166209; cv=fail; b=VI6XVovqIbhuAYwy9Uo3J85kBPDPu3PFkbpwS1r3b7HHbvrSiCODTUq6g+FbPRAFcNQNv2AKj2Cw3AShBuDGrl/qYYAgDPVVfkvv3ecMxoyJxCuRDyxByx7npKrJo+KZwXQ0Hpueb7FMqTjCBaT49CXI9kdmBF2lzyIO89gsUaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732166209; c=relaxed/simple;
	bh=l7tzx5fWP+ppaN1S5o0Mcu6zrVLO6hXPwcj/EEyKjIc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iN2BNXqJXD9KRw89hhauITauNFSomltKGhrJHrH/tGBd5fdA7QFIVCAgs/V/Grj495DSfNP3oiGATvdi78/jV5Xo6esxMPv71bRx/mRvgDRO4pYZAJ6JYTq5rfpYcI0/k7/nDK93cAc/BJ+YctuFDvx/ZXyqdm8oVNHmICJbaX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=SZEKasLt; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="SZEKasLt"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKFTxiJ004531;
	Wed, 20 Nov 2024 21:16:32 -0800
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 431h4y1m49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 21:16:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puF2Ub2axlohbsOx+kmsMSuOzUwgwZsYt1q7s3oxgbvLu/1g0Znd7EHJM7GAHZPYCmNW4Nvqe0tHLixySg2mAx2DospduG9eXWRYpFP9/+JdiuzoTFp1s72wpBHXQLvbFx/dsTA8iDtU8uYUhBS/Cqq3+GV/hKKIf7cNC/q8SNwpEHXFtds9hAGj9UWeH2WeOE8oBVIw7ICgKz73ahMLkAL1BBdtABuNMlZiHWtCgbSDKMDQlT1HzZ4sI83iqexP88ilAGe6p53tWsuCTjeWkeznXy3CVIvs44K31GtmeTdZb83EgzAL/wvIlWJMHwqtXPo2WfDXh2DgFGq2NGUzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7tzx5fWP+ppaN1S5o0Mcu6zrVLO6hXPwcj/EEyKjIc=;
 b=TyIq2cgIBQe3rAF0B9WpOP3PMqOnIOXI2dFcNyp93wuOjRKH7a4oR8GFXxoSEDJazq8QCtfgIbRwM+eJ+cmkcfaaHSywpr0QSP5O6fDDPQOPnmh5P6DWrm+FnVLQrOY53qqJCj7HvtPJ3a1J0WVYb31WgcQRwe6k3mk0JPQfK7Z7LrKWeEbytuxOcneqJJPhIriVLSIr5slAHBqeSLuUzuYF/u/pC/uPj9GnGSiyYuLc0+pQLa6CF6PYKTH/fNN1qQFIxC2M3i+yrFNzM+9AIuBEfhgz0LwpFpOSwm2SzZ8TrMEmPGRFrcMYS3nFKUfbkwZnLVxsyVNU1WA+xr0owg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7tzx5fWP+ppaN1S5o0Mcu6zrVLO6hXPwcj/EEyKjIc=;
 b=SZEKasLt+t+w9jpVGOKLaPGhG7tgVVOxc5soGgcFsk1WIEZMObZ8yTpbGIAEX26BS941VA1wnw7DdovQ2DVnP/2buUl8btFeSLkD82WFnndTq2pDD45AJfpAMgtHOfrvJRt2hks3bHwuVTvjs3LljL7PThen659u9kI1xGMeV7Y=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by PH7PR18MB5032.namprd18.prod.outlook.com (2603:10b6:510:15e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 21 Nov
 2024 05:16:27 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%5]) with mapi id 15.20.8158.019; Thu, 21 Nov 2024
 05:16:27 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com"
	<jasowang@redhat.com>,
        Satha Koteswara Rao Kottidi <skoteshwar@marvell.com>,
        Srujana Challa <schalla@marvell.com>,
        Vamsi Krishna Attunuru
	<vattunuru@marvell.com>,
        Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] vdpa/octeon_ep: handle device config change events
Thread-Topic: [PATCH 2/4] vdpa/octeon_ep: handle device config change events
Thread-Index: AQHbO9SEo13J2eTchU2L3QNN+IXeQQ==
Date: Thu, 21 Nov 2024 05:16:27 +0000
Message-ID:
 <PH0PR18MB4425DF39509A4EE6F4E81D32D9222@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20241120070508.789508-1-sthotton@marvell.com>
 <20241120070508.789508-2-sthotton@marvell.com>
 <e939fa9f-fedf-4097-8dbe-45d3bc2523d9@stanley.mountain>
In-Reply-To: <e939fa9f-fedf-4097-8dbe-45d3bc2523d9@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|PH7PR18MB5032:EE_
x-ms-office365-filtering-correlation-id: 1342b496-385b-40ad-bbe7-08dd09eba6a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmpXdzhrSUtEdGpFb2RRZzNyK0xEU1c4N005MzZWWU5zaVNIZTdIdy8xejh0?=
 =?utf-8?B?WVZQc0NWUHdFTjFVOXNWZVRkdERraWtnb0pOSld5UjRyaSswSXlKZXNDa1lU?=
 =?utf-8?B?MTZmM21PM3hkWExvcC9ydFZKNWY3WXg0ald5Yml5bytxWDUwMTcvdytudXc2?=
 =?utf-8?B?L0lRS3pEcWVIQitVT2JpeGZ2N01NZnpNOXF3MHQ2U2xlbzJ3UldQcG16VStF?=
 =?utf-8?B?MkFzR1Zxb29MMHpUUlVlUHExZ0lBRTNNWFNjUlhXSGhvTUtPdy9MSzNHOFhZ?=
 =?utf-8?B?MDJJY1ArcENBQlV0QkM2MWZldU1DaG92TnhOQlkrdWxRN21GOXkrZDBVUDAx?=
 =?utf-8?B?YzhuOG9LRnRCSld4Z0dmQ3RENld2VDhJU2lpd3VrOURKcFo0SjZabUtSV1hz?=
 =?utf-8?B?Q3Z5MVFiTE9JZjByb1NyQWpXdjFYNThGQjZ6eEkxcDY2dFh6ejVuaVhuWmpE?=
 =?utf-8?B?V1M4enJxbHlkZnE3bzRiVlBNWjRnckxHR3dCUDlGSnltT2ppamIyZ0phZkUw?=
 =?utf-8?B?TzVEcmdiV1doWTg4MW1GbklQK1pGRlEwQnR5K3BuUDRCZDhEUGZJUU8vS3Y4?=
 =?utf-8?B?ek9tbzB1a3Y5MzAweUl5cWEzVWM3VkduQ3h4ZVU2dXdCcTk5bk0vRlJuYUxv?=
 =?utf-8?B?Q3JoYVp3OEZLRXdmbVBYb3UwUWlKMkhiS3lUQjRaK2ZPSFZ4UDk1ME9LY09G?=
 =?utf-8?B?dHJPVlBacFdXM1l1T0VnNjZ4SDZNdHRlRzdMcXF5L1hUYkdhazE0OFdaNHBV?=
 =?utf-8?B?c1J1MUdlbEtsTUg4LzNtR3ZhSjNqZDRHOVJheGsvV2VXeEJEUjg4SUcxVkdv?=
 =?utf-8?B?K0tOZzNkaWJnS1p5UzdQUGQwOW5xakUrZDYwWnZkRmF3TjRxcUVTV0g1YTZn?=
 =?utf-8?B?K2FrUDlQUkJjTnhDV1VWUnpQMXJla216Z1k1SzBzdnlzM3ZCcHFyZEdkUzFK?=
 =?utf-8?B?MlZjK3NJYWhIS0JjT0g4bmFJTnlDSzVXTzMvTWxYb2g1UVlObTMwelFFTjFR?=
 =?utf-8?B?SFFXSEJMR0RPaThub1I0NlpNNm5SOUNZZi9wZzJxMUtZTHNKR2UzQmZZVU9q?=
 =?utf-8?B?ZHhnVkZmQlFLSkl5M2kvdHJUcXBsTW5RR0pCbkRMZ0hoRWhTaXhHOEFhakN1?=
 =?utf-8?B?WldkUFUzZW1MckRKdWQ5cGRwUFh1cFpQZ3Q5NjUyM2F5bVJpSk1KbjZkS0ZZ?=
 =?utf-8?B?ZW9LRXl5OUk2NzlINGpERnVsL1czZ1ZuakVnbkwzMWYxeTBiYjAweVM0SlY1?=
 =?utf-8?B?NzhVV2g4K3Y3Z1YwVFpFcjJrYlJtU3dMUGhobVRlUHJrekgxK2VZZ1hlT3hE?=
 =?utf-8?B?ekFySnExdjNTbTZselFJVCtYUUlMalNQdW1rZDN3ZkhKc3picTRYN3FVQnRH?=
 =?utf-8?B?Q2ptU2RhRlAxRjZ4aElJOVU1ZDZacmk4S245dDQwVkpBNWhvOFpubTVjQXdC?=
 =?utf-8?B?SDlhTzdGYXBvSjdxM2pWd1dCYTJUek5NbUU1TGh4eUJPeWFwWnMwSndvaUxM?=
 =?utf-8?B?dVhhLzVhcGEzN2N3enVzcEtvQ0JvVlZzUldIcGZvc2pWeDdMMWlOQUU1amY2?=
 =?utf-8?B?YkxFNlQxY3lMME5VZjg2RDAzakU1YjRnQ3lBZStTVDRsTzA3b3FDNGpOZXR0?=
 =?utf-8?B?c3NKaDhIakZIZnFyeXphWjhLOXNvUmFiZWcvYjJFaVpSSFZqUVQ0QWVMZ1BB?=
 =?utf-8?B?WlFYK1kxeGluWmwraDBKVnRLdUJNSlYzMXJMdWwzeGpPclEzMmh3Mmh3UWlE?=
 =?utf-8?B?OWpYeWMydWZiazJjTHZpbjNJc1hlSFJGUGpRUlliMERoSWJYNVVqdjhadkE0?=
 =?utf-8?Q?z5ApyRc5VRNWolOJEU8xLAASLJIyYfA0REhsA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aitRb0RFdk0wdTFieUF2ay82eEJsa1hlSWFwd01ta2lGNGQ0MVJVbStDcjMy?=
 =?utf-8?B?MUIyVFJHR3M5eXZoWStPUE5OdU9GVUdOZ2h0TEhtTmNESXo0TXRDU0oxZndu?=
 =?utf-8?B?SUpDMFAzc2FVU2pvUGh3WS9lWGNycUd3VWhIMGhLS01yL3RpOHZLWithT2VM?=
 =?utf-8?B?eWZDWGhJUERLWks0VXRXb0l0RlFYbzNJK01TaWNIRW9zczRCdS80bldHbEQ4?=
 =?utf-8?B?UEEzRks5eUtSc25JNENtUDRaMnpRR1FFUStBaEZQZWNPVEd0QVRERG9xMXh5?=
 =?utf-8?B?enBlVmNKaFd6NldyV0tGUkR0eUtXSzhVVEtvYUROeExwVFdhVUlyQ054M3VJ?=
 =?utf-8?B?QTN6RTY5VzBZdHdrRUljR3oxWWlHczcyNFZMVXB2U0Q2U0RYTkhIRUhaWk5z?=
 =?utf-8?B?S0dUSEhvNE9iM0dweGtMdjFvQlZaVzh5akxhbVRKeFhMSVZLNlBLbU5OQ0Vj?=
 =?utf-8?B?aVZzRUEyY0FNVjdvSERTaU1VV2w1ZVYxVTdEZTFsajBzeVR5aTRPZkh3Slg2?=
 =?utf-8?B?MEI1cm14NzZMM0J4VWYyL1E0SjhDcHdQbEFWVHh5alk0c3FmUndLNGppdW1X?=
 =?utf-8?B?NkQ5eENrdDhSMy9xamsxeDk0b0ZoOGdjb3dzblE3RC93TVpMTmIycDVrcnR1?=
 =?utf-8?B?YW1jdE5ZN0hHNnNhZnZzMlBOZXZjQTU2YVZVNERoRFFsdjE2a1N5SS9wTnVn?=
 =?utf-8?B?NUdlM3pMNWh6YXZkK1FBYUNPMEpqQjZnUFFEaHJmTmFNMXhkMEZtVnJZZDFz?=
 =?utf-8?B?RjJWVnZpeGRJTm04UjI5UEt2aStDY29FZ3pYbHlYVWtBYklGeEtWVTFNRmk1?=
 =?utf-8?B?OFRWaTJTa0FyRlRlOU0rRjZ2eFpkVzZzQjhnSlBpK2RyQXRTbEE3aEhFR2pS?=
 =?utf-8?B?RXJqUzRTajhYTXo4ZzE3aFpTais2NmNoMS9vbTVqSzZCTWM3WjMwR2JGcGUx?=
 =?utf-8?B?TmNLa3F0SVlCV1Q1eWhuRSt2MHROdFhNZ1h6Tkl6SDNVVmx0Vi9BRVM2bWdm?=
 =?utf-8?B?WWlpdEJrYXF5bGxqUGZ1dW43Y3VuYldIT0pabTBrKzhkVW1ienBPVVNlRy94?=
 =?utf-8?B?YWVqSFdnSy9HWFA4ejVFQnBLMFVlQnd6Vm9LdW9NMlEvdnZGbTRJMCs4SzlS?=
 =?utf-8?B?S2h5NDRYeGZPYTh4dEdSODBXRWEzSXo3SmR2V1owcEFCYkw3M01OT3gvbnVB?=
 =?utf-8?B?RHFrZ3NEOWV5UHJXTkpJMHRSbjRxWk9zcHZTbTNHdUp5NkhLYkxOQlRUQjhF?=
 =?utf-8?B?OWRDZ0k5TjUra3g4anZCblltL0pYdlZGYU1GZVVUVTY0aGU3bXdTc3NBQ0pP?=
 =?utf-8?B?ajkzYlhSTXlPdWptQU9Cc1BJVEdqaGxZaExEZ3doOVlBTUMrMzJ6RHNjMHI5?=
 =?utf-8?B?aThtb2g4YlRYTHpFRVlFeG1SenR1RzNVMzVWMXA3eW9McDU4ejZpMG9mR2hm?=
 =?utf-8?B?Q3N1ck92OEJDK3B4Qis1UjhTN1NiSG5oay83bXZhVjdTK1dTbTRTWUVGd2hR?=
 =?utf-8?B?VWVkRDhZUHgwNEdaS0owU1dNcm16ZWNlSXpqMU9QeW1kU3NnTkVXUEJMb2Ur?=
 =?utf-8?B?QnJQTkFMMEFJN1VEaDN0Y044WDNqaW9la3hkOTh6UjNzWFYrZUNkcms5aTE4?=
 =?utf-8?B?VkxvT095d2x3MHAzdkhCeGZzVHBRdjlLbGRWajNFUXlrNVZXR1gzYXlqTTlL?=
 =?utf-8?B?VXFzTWFwektFNHhxVWFOZ2UvUFpwcTNJUGIwcGd3Y2NEd1dCUis3Qnl1d2Vk?=
 =?utf-8?B?Q05iMU1JNzgzZmNPMGw2bkFlS0hIZmgvbkRBYkVlYWc0L1JaSzc3cHd5Vm9S?=
 =?utf-8?B?WktTbEVZY2xmb0VqaG5WT2hndHU4UFNlamFjTVViZFhWSngyYVNiQlVrRE9G?=
 =?utf-8?B?QVZzcWlJOXZtOG9KUW1teGFITkJuZ2dGVXZwMkEzeThwc0Y2Y2pTR1BoT2Rp?=
 =?utf-8?B?aXNYTUMySHpuNVhiZ29lTksyblQ4NEgzeG1RTGkzZ2M2QlhEMmQyaFMrMHRI?=
 =?utf-8?B?eGtxbWpkWC80bmxOR3lUazNNa1FQdHdWWDE3MzdiT3BVK1ZoR1pVWHhHZFZQ?=
 =?utf-8?B?OG1WSEtRZFVvWkdtMGE4YlJoV2VSL3VDMXArR1RWNHZQbVJPekRXaFROb1VI?=
 =?utf-8?Q?bJagCJdG0EgaH2zP9VLejIuvf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1342b496-385b-40ad-bbe7-08dd09eba6a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 05:16:27.3868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+SF+NJfgpMClykHldH3REK/QmarXuQtrwqwVsa3ZDB0H1r2UIdoVVonzHNUtGGidQvymo2PX3x0YKYRuh49vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5032
X-Proofpoint-GUID: P0xrWRarkHqGvUxQVexuwBjetXKtFnHJ
X-Proofpoint-ORIG-GUID: P0xrWRarkHqGvUxQVexuwBjetXKtFnHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Pj4NCj4+IFRoZSBmaXJzdCBpbnRlcnJ1cHQgb2YgdGhlIGRldmljZSBpcyB1c2VkIHRvIG5vdGlm
eSB0aGUgaG9zdCBhYm91dA0KPj4gZGV2aWNlIGNvbmZpZ3VyYXRpb24gY2hhbmdlcywgc3VjaCBh
cyBsaW5rIHN0YXR1cyB1cGRhdGVzLiBUaGUgSVNSDQo+PiBjb25maWd1cmF0aW9uIGFyZWEgaXMg
dXBkYXRlZCB0byBpbmRpY2F0ZSBhIGNvbmZpZyBjaGFuZ2UgZXZlbnQgd2hlbg0KPj4gdHJpZ2dl
cmVkLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNhdGhhIFJhbyA8c2tvdGVzaHdhckBtYXJ2ZWxs
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFNoaWppdGggVGhvdHRvbiA8c3Rob3R0b25AbWFydmVs
bC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL3ZkcGEvb2N0ZW9uX2VwL29jdGVwX3ZkcGFfbWFp
bi5jIHwgOCArKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL29jdGVvbl9lcC9vY3RlcF92ZHBhX21haW4u
Yw0KPmIvZHJpdmVycy92ZHBhL29jdGVvbl9lcC9vY3RlcF92ZHBhX21haW4uYw0KPj4gaW5kZXgg
NDgyYzE3OGE1MjIxLi42ZGI5NTFjNmNiOTIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEv
b2N0ZW9uX2VwL29jdGVwX3ZkcGFfbWFpbi5jDQo+PiArKysgYi9kcml2ZXJzL3ZkcGEvb2N0ZW9u
X2VwL29jdGVwX3ZkcGFfbWFpbi5jDQo+PiBAQCAtNzQsNiArNzQsMTQgQEAgc3RhdGljIGlycXJl
dHVybl90IG9jdGVwX3ZkcGFfaW50cl9oYW5kbGVyKGludCBpcnEsDQo+dm9pZCAqZGF0YSkNCj4+
ICAJCX0NCj4+ICAJfQ0KPj4NCj4+ICsJLyogQ2hlY2sgZm9yIGNvbmZpZyBpbnRlcnJ1cHQuIENv
bmZpZyB1c2VzIHRoZSBmaXJzdCBpbnRlcnJ1cHQgKi8NCj4+ICsJaWYgKHVubGlrZWx5KHJpbmdf
c3RhcnQgPT0gMCAmJiBpb3JlYWQ4KG9jdF9ody0+aXNyKSkpIHsNCj4+ICsJCWlvd3JpdGU4KDAs
IG9jdF9ody0+aXNyKTsNCj4+ICsNCj4+ICsJCWlmIChsaWtlbHkob2N0X2h3LT5jb25maWdfY2Iu
Y2FsbGJhY2spKQ0KPg0KPkFkZGluZyB1bmxpa2VseSgpIGFuZCBsaWtleSgpIGh1cnRzIHJlYWRh
YmlsaXR5LiAgSXQgYWRkcyBub2lzZS4gIFlvdSBzaG91bGQgZG8NCj5pdCBpZiBpdCBtYWtlcyBh
IGRpZmZlcmVuY2Ugb24gYSBiZW5jaG1hcmsgYnV0IHRoYXQgc2VlbXMgdW5saWtlbHkgaGVyZS4N
Cj4NCg0KWWVzLCB0aGlzIG9uZSBjYW4gYmUgcmVtb3ZlZC4gSSB3aWxsIGRvIGl0Lg0KDQpUaGFu
a3MsDQpTaGlqaXRoDQo=
