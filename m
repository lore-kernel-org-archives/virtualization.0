Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797BC2D836D
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119183; cv=fail; b=shKXv8qxdLvojXWK5i+prTjdFh9nJa3QI+E5bgaPA34JgT16RfFnKXYLPlBgEH+4dpzpB1kB2nV519LUWsjy2oq08mFZsxGKNBwq2m14zD9j1TARojr1wcEnU+Py/Uawh+4acWw33X42oxwVDprrnyP/i9VkXHWhqGlcRoOWjDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119183; c=relaxed/simple;
	bh=oLNn0lil4i7dIoE8vHSRQYLQcCZiEhuk37wI4ZAlUXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eC40heuNG4hSSPU8ReuI6J9rvEubrWANXdZ7il2ZUVzjgQL3CQtgt6Gt39D/RzwLLLFKpfQ4zinvAq3obJ5KwY7lAGm3UFyuYqucz9vuLCAmXzVEwGzLJueLpTJiZnIJF/ub4f9mb963bpMUxsxoCujY5bMGJeTjeG0tx7VHrrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=U1F+oCFj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=djdV7T+e; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U1F+oCFj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="djdV7T+e"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770119182; x=1801655182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oLNn0lil4i7dIoE8vHSRQYLQcCZiEhuk37wI4ZAlUXk=;
  b=U1F+oCFj8yMf9fj7OBM/CHeLOXjF5PcoQ9LkAKT/xkp2MZQCwaROeSE+
   fLiSTYInraKLQ7Q4q/p5jYLuM0SRQf7O8dgax+sj0XPdj9dFcsvxTuE07
   Qx6lgVq3ZuscMOkS6hepyXWaGxwD9/vvEk6YoVsHMN4vH8MpltJn3Fmjx
   3sbs5Xje234QPv3QplO2RLqhXhBecf383i56imO7D+WE1/AT/WClpWg3p
   r/ySKk9jafJpWY5oZaUYHVNSaKlO18GSppDV+9EeAm4XYgrmKksVckhv4
   gPJHu0AZsVejrB6wvFvXT4xijG2KjvLmIA6ElsgerDWupv7b3eXc7XOsB
   Q==;
X-CSE-ConnectionGUID: 2Pq/UZ8AREOwK+FBHMxpYQ==
X-CSE-MsgGUID: Zqs1yn37QuemxCy2e9Y7AA==
X-IronPort-AV: E=Sophos;i="6.21,270,1763395200"; 
   d="scan'208";a="139189213"
Received: from mail-eastusazon11012013.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.13])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Feb 2026 19:46:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPzamU4FuqW0XOgOj+ks7ikQxfTxT71PuQFGr/dai2QFqo9HL0Xw6yRoKNIeiS4YY+hVB/bjbDUtfCxdntMkUgwBursDqgpGnVPCyLdsPrmX+hoji8dRpfMfVuquRzUsEoXAnmezq98KMpHwTs3IPTJaI5oEe6qZGs3n7zzD9mbThDVaTV7SKsDc1rNGpGovQCuFIc9d8h3xDy5k//EuiI0dyuZlktvzSK9BeMEzMKmccjrGg3czNiHgfKj8WLGPY+DVeMAit28ZXYiSatktyx6yKvqilqWVMMtEeCsF3EzXvp/kOQF6bSgkkUMJ4bQanP2L4fkyqDoyA6JdrQzG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLNn0lil4i7dIoE8vHSRQYLQcCZiEhuk37wI4ZAlUXk=;
 b=Ua21I6k/1KVTK3O3R1b2wpAQC8ERWxWDIzwq0vRY6EbpKy5ktr2IqMifl66hPafTARo0+Jp5CRxVBB3WAGHn9arjg5rn2zgsB1INTmOldR6vU0Hj81dN+VJMieqEF82VkS6R6GwS7nDG2n/V4ywp/fgagItSlLxVbvYYPU0EX1Nxh9mm9l0l03Oc1diLz/7U2uo8XxYml01Drv6YqWjrU59yv4fCvtlrPkC5BoR6Ftit8wehAi5bbmyTwD0fljKQ7H1WZMzCC+NLSOrfolhELXmf6fCPn8a/aYPKwfaZWEsUZQcIzy+2TB8ElCF1BlA7u5J8+xZkxdH3IGIB+m/g8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLNn0lil4i7dIoE8vHSRQYLQcCZiEhuk37wI4ZAlUXk=;
 b=djdV7T+eGKa+AIKlcAWJ5q38bsocblKwH1vjx+5v+3ZdD48+ReX5/QskGs5wBJfOMt0WGF0mcMxNyjsZpT7gunt9dh9MUVnv+CVrhgLN6ouQLlvRMbDc/BxXJRTxOxwuqS5jq88/Zwkb3GISIxibjfPyeFejbupKvJ+dkB0onXo=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by DM6PR04MB6924.namprd04.prod.outlook.com (2603:10b6:5:24d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 11:46:13 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 11:46:13 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: Alexander Graf <graf@amazon.com>, Jason Wang <jasowang@redhat.com>,
	=?utf-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, "open list:VIRTIO
 CORE" <virtualization@lists.linux.dev>, open list
	<linux-kernel@vger.kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3] virtio_ring: Add READ_ONCE annotations for
 device-writable fields
Thread-Topic: [PATCH v3] virtio_ring: Add READ_ONCE annotations for
 device-writable fields
Thread-Index: AQHckpxYqkgBDNzXGkKIg3bTMcVVebVwqJ8AgAA3iwA=
Date: Tue, 3 Feb 2026 11:46:13 +0000
Message-ID: <04ac8ca2-a54d-48e0-8dc2-e1640aedcb59@wdc.com>
References: <20260131102810.1254845-1-johannes.thumshirn@wdc.com>
 <1770107244.8746088-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1770107244.8746088-1-xuanzhuo@linux.alibaba.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|DM6PR04MB6924:EE_
x-ms-office365-filtering-correlation-id: fc9298ad-cd82-487f-4dd6-08de6319d50d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eUk1N0k5MzlCbzloeHg2L0o4TURSeHRLQndDOFFaSEliaTU2V3F0M1o4QWlD?=
 =?utf-8?B?VDd2ck16L2ZTNVN2SjdTd1FKdkxvZ2J6OWk2MStkYzMxcXEwVS9nUHhJRGRU?=
 =?utf-8?B?UktqQnIvbWRSdmZaQ0dOekxJMmZOSEN0S3orMGpQbnlodFBVQ0V4ZVF0d3U5?=
 =?utf-8?B?TTNPRnNuOG9vVWFBbVZFTDgvdWFvQzZiNTdJTnQ2RklCMzB3NUh5dzJVbXI3?=
 =?utf-8?B?YVUrelBJckpmanBMYVVUN1VLRW5XN3lrL1U1a0lWNkpCNEh0ay9ybUVOUmZh?=
 =?utf-8?B?RWRyaWJYK2l0ckhkZGkyOUdsbENOeDJzdXAxaWNDRERWZXUzeStFNWRNc1Na?=
 =?utf-8?B?cHNzOStOY04rVFVleFI2UkJrS3JscnpyckkrSXAvVkxNalYyRVpYYXJ1b3Fj?=
 =?utf-8?B?RXRqc0FHSE1sNDdOM3BuZ1F4bWJmMzFLZEIvS2NyNlVWV0h6cklkb09lam9l?=
 =?utf-8?B?aHVFY2lzcjlFQitIYlZIbnJGdGdmRVNzVjhmTWNBZzltQkdMbWZDV2xCQTcz?=
 =?utf-8?B?WWxTQmN2RlJONWV0dUpSd0VYY0hYRGc5TFRORE5PMmtiR3FrQisrczdyU204?=
 =?utf-8?B?MmNUSnNLQ09jMkpGek1JNzA3QkwxY3dnK0U1MGtYYkQ4SjdacVRRNnJhdkx5?=
 =?utf-8?B?WFFCSFFiMWljWnoxMFBERS9CaEVEeTc1MFYzYk5sTVpEZXU2RENJOWFwdVF4?=
 =?utf-8?B?MXpWbUF3K3d6N1kvSElmVWc2NHcyN3BIL1NJYUdMVTJBc0FFWUZjVEY4Q3BD?=
 =?utf-8?B?aW9tcmhIbGJ1K1dxRXNDbW5GTVd6ZTl1VmRsanRNK1ZOeGxDbUpsemNBQXEy?=
 =?utf-8?B?aUgxam9TYTRjTzgybHRyWXh6RlBzeDU5ZFhHamNXdmt2emRNUld3M2NFVlJM?=
 =?utf-8?B?S0NaWWlKbC9EblZKRlBsZ3kzRlVjbEtNOVQ1MzVNQ3RFUnFRczZFRU9oVWEv?=
 =?utf-8?B?RWpBbUNjY1Y2NXFXclJ0MU1qZUlweVRhZzVDQ3lXTDBXbklDVE01UDc4aGxE?=
 =?utf-8?B?b1JQeDNqS0kyRzYyZlRsTld0SXdDVHFaSHVBNS9mWVpDaEhIdWtpOXE5anA3?=
 =?utf-8?B?aG96eXFaUnM4ZzkvdFI4S3VuNlltbUpIVDVkQkNnSytrZFJ0bFhyRWhMbXNk?=
 =?utf-8?B?MUFjV2t2c014QmVjSTl4TVlBN0kxVlFKYWZ5ZDNFQ0Zqa1Jla3d6eTh0Q0l3?=
 =?utf-8?B?MStObXlhNmxjdmh6bjd0UloxcFI3R1JGMTNvYnNUY004NmNFQ1RTOEk1Z2Ux?=
 =?utf-8?B?MUN5cFZ4eGkxS1NwMFoyWEZwVXF6SFdpcmgwcXFsTG91WDR4T2FiNGV6dW5M?=
 =?utf-8?B?ZHBLa05RemlUSEhUYTZ1djJLd3dBcmJqY0E2R0tzV243TFV2RTA4WlB2YitY?=
 =?utf-8?B?bGVIZUZ0aEh6THIzYVlDYjllM3I0c0ZRdExCOXRIQSs5cTA2cEtGbi9ieHI2?=
 =?utf-8?B?K2k3SitRaWZmM01DZDlYdkUrU3JKZEVjczJyeUM4aVN4ckFpem96eVRpUDBv?=
 =?utf-8?B?ZlZmVXB4MG84d0pyMDB6Z240ZTNGdm1Zc3QrNGo5VlNOS09heFpHek00SExQ?=
 =?utf-8?B?V1ZSamJ1QURFY3FuRXJtWElIQkp2Zzk5TW5vQjBqZ0hTWjY1Ni9iejU4T08z?=
 =?utf-8?B?MFBpSTdzQlBYbjdocURCczlxN3pKWGd3KzJIZnJnQ3MzUkx4Q3FjdlB3ZVRr?=
 =?utf-8?B?a1hZdDBoSnBpeEFQSUJEU3pSVWVFNldWSDhFcUp2K3FjMFpYY0hvQ0w5NDJy?=
 =?utf-8?B?a21ZVGxuUUxPTWg1Z0ljLzdzOVB3VHMyUUNUSzNzbTF4Y1o4aHRQajhBNGN2?=
 =?utf-8?B?V0c4RHdNd0JsOWVsaVpPaXpIblJSeHRIODRudDFiYm5FMzQxSDVzbGt6aVo2?=
 =?utf-8?B?emxCUFltbnNSZ3IyRWdWZmt1UGZNMW5GclFCSldHL1M5UmdPTC9BQkdBejEr?=
 =?utf-8?B?N1dwcEtjSE1lWFJvTWl2bWllQTZxOUJ1SVBJYVVIZURUQ1NXWUZ4NDcwa1U5?=
 =?utf-8?B?bVpNTE1XZjIyU0ZrbENERW5RTnp2aERjRXpnbW9SZzArU1NDY3ZQQnBZRXIw?=
 =?utf-8?B?UkE2ZHp4Ym5wL3Iza2MwTnc0QU91TTQ2MWV4Ny9zN1hiVnVmdjVRMzBFaEdi?=
 =?utf-8?B?TjY4bzlROW1iQTJMbVVqR21iNkRKUnBOeXdkdTg4eHg5bU5jVEpmbk1oSUll?=
 =?utf-8?Q?ocmelc87JG0WagijSSOcAtM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mjk5UGNOcUZleFV1R2lvd3paaDUxOVFZVnpXNWVGeTFkR2JrYVc1bjFycmJB?=
 =?utf-8?B?azhKb0R6S1FZQmd6VVAzMmc3TDVHY21yQUlRWlFzaXFqdlJtdUFnN3A1OGQy?=
 =?utf-8?B?VkpaY1ZlMjVUOHJCZUxpTDMydXU4TmNXenFEUEN5SnRMZitObUYyWm5Nd2kx?=
 =?utf-8?B?M2g1ZG9ZNVFPZXNLVWIyV0M3encrSzNiSFlsVjE0RHdnRDhHUzNCeW9SU3JQ?=
 =?utf-8?B?dEJBVllRTXJ2NE93VTVzOERETUdOSVlHdld2V204QzhEWjR6Rm1FRG1DMzFn?=
 =?utf-8?B?SWJHL0xqMGVnbWVIb1RqaFhiQXc4QVQ4d2hheXkvelJMaFluYm95VFNEWkZn?=
 =?utf-8?B?Y3dZWGl0eEVEZXEyV1d5Wkp2aGlBT3dQWXBRekpybzJLTnhiNmRITWJLVURZ?=
 =?utf-8?B?YVlRQ24rRG10WUEwZ1ZoaTNJdDV0bzRaaGtmR01GdVlicFdIa0tJOGgwelVt?=
 =?utf-8?B?SnJ3SXhjQVVETEhhczlGVU1zZDUvVmFnZ1FHV0JTYzdndFp3SzAzRzRFbjMv?=
 =?utf-8?B?NE10MDRBRnUwcitOTmlpemFKREhQbVA2YlZGTXMwYisxdE1aSG1NU2hvMmlT?=
 =?utf-8?B?bDk5SE40aWtTNjkvRll3M1BtRUt6RFdSdWtFa1V1U2hJb0Qrbnh1dHQvUDBG?=
 =?utf-8?B?VFZPd0ZGWjVGL0p5ZHJSZTh1cmRxRHFTYndoV1NqLzN5eklyTUZWUU1PZHhH?=
 =?utf-8?B?NzRQMUhVMTlmTmloS1ZkRnNmV25CU3JnTEFzM2UwY2YzMHRkOXZZKzN3aGc4?=
 =?utf-8?B?TW45NTlFL3IwT2hqaThDQWFwL1hiS01aQmtuYlZOd3U3b1NPMlVsNkthNGdE?=
 =?utf-8?B?bGZSeTJ1RUlYVGRBMzA4d3RnUm5INnNnZkFZNVNoMC9UUk9sekRyMldtOUtD?=
 =?utf-8?B?N2dpSEZucVV3aTVPeDlCazBDTEhnNitObmxhYVQvVkxEYTRSV1lndlM1RHM5?=
 =?utf-8?B?STZCSG5HUkU2WExHWUlXTldkQmFaWGw0cTRFV1d4eG8rUjFVWGo1Yk5mRlJI?=
 =?utf-8?B?M01nb3A2NmpOS205TTR0Y2djanM1M1FHdVR4VGljeFRQbHJNM1h1M1lsRXpo?=
 =?utf-8?B?M0FjRkJaZjFOVGdJMzhCdnhJQVdQVEdxdkxtZnVYUThCK2JXSncwYmkyZC9a?=
 =?utf-8?B?NS9LSlpIcTMvMTVBV3k2WDFEdlNVZm9SQ0dSaHBLV04xUEdzK1lKY3FuZXUz?=
 =?utf-8?B?TnN2SEh6YW53bFExd3paalg0TjlKWWJ1dWx4NE9YcEdiREsya3NrM1dqL05i?=
 =?utf-8?B?M29Od1J4ZjZmQlhyZ2hOR1I1NTZXSGhmWjliWnpaS2xuMWo3VWpQdHF5Tmxx?=
 =?utf-8?B?bkFkbW5rMXpwLytKekZPeE5ySUwzaFQ5WHpCYysvR3BtZWxuKys2bVpHbFdD?=
 =?utf-8?B?TVEvKzNvT0sxT3BLYnRkZ25odTlQaGhrVVdJQ0QreGxpSUVRTjRlQy9vazVn?=
 =?utf-8?B?UG1JK0I5aHY3SGFmVFkwTHIwd202RDJxaHRMTFNGTEI3VlVpTW42bmlvZGlK?=
 =?utf-8?B?K1hsMno0U2NWRGN3Nzdyd0VYUThqVlJURHlEM1Rhc2lTRW43TVNjSFlmWVZo?=
 =?utf-8?B?cHlIaWVUaVFoVzhpUGtNcEZqMUFhWWd4UmVERnhmYjRvZlJmcFZ5ZDMrZUdo?=
 =?utf-8?B?ckRuMUs1cGhLaXR5OVhGZ0NoWjdiekdkWDlyemVKWXVOMDZEazNxQm5LckVG?=
 =?utf-8?B?eGZSekh6VVFMVFptOS9PdlFmNjF0SUhVQXpOdGJIeTJEbEpUM3B3b1hRV1hD?=
 =?utf-8?B?ZW0zMVBodTdlZ3BBU2NrMzhoakdyeXVMdDZ4Y0ttTFBVTTVnQlBGbGo3Zm15?=
 =?utf-8?B?R1JUTXRhOGJjQ0c0MVRIcGJacmc3SmVZM0pTVXhEbGtHWFFSN0ZqYjBkNXZC?=
 =?utf-8?B?WlJlRHIxVVhOQmpSQW9ia0p4Rlg1UXYrZVIrNnZmd2pxSE8zY1JURUMvb20x?=
 =?utf-8?B?ekJrTXZjMGZJUS90RkwrSHRQL1JoVjdjV1ZlS2tkSXlhUjBTTTR0T0NtSmFu?=
 =?utf-8?B?SVNMOVhSR0UveUFnZ3ptQ1JZQjg1NmNtSkQ0ekJDK1RYdTgrOVNNMlpjU3BW?=
 =?utf-8?B?MVdyeTdkeXRzUjdIYkZnZmxMVnVaMVlmSGE1MVl1RUJlZHBoVWRjUGVJbFk3?=
 =?utf-8?B?Z3NycFJZblpOeWFaVG1PSzVTSUNrcSt0eWx3TXUzbTZ1S05UWkw5c0ZtMHIv?=
 =?utf-8?B?SmR0N0tBRFUyREdxb1pDWElFQnU2MHJjK1NWOG5WY2pBRTlWZTBsUlQ5RThW?=
 =?utf-8?B?WHhCZ0NieldwdDVMUlBYMWsyRm5XeGdJVk1GM3BkNlRSN1BBeHhnY1JyUXky?=
 =?utf-8?B?UHVUZXlSZUVsQ2VjcFQ5WmpNVTlPK1puMTRCNkRkekRLVGVkNVRLZ3VjRWs0?=
 =?utf-8?Q?qSDWit5CG9A9SKoQUoUZ0p0zYH69FzeFM5QmbxDpjyWvv?=
x-ms-exchange-antispam-messagedata-1: cT7e4kbOkv2UA8J3FpTsWo8ZnKRFh3xKH2g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91AA664FD8723F4EB1852D215F80FFBA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KIt8XC9L18bn+7NBG7ErA5h8aBb5qaRQbJYp294lkfPJYLbXLo5PG6dluwgjO6Hon7FqtdHeTMTziG0scKaX5kes0yWA/QG9loB6asROD5uLqOEjF6WUH/ZRFFJ3q0WoMMk4Gu6vp2mum6NXo63qEDSTbCJLiLEtiX9CeCMz+vBpg53nmgjZXhi3LazArkLMaesiFgkrsqMSL/tm81u+vGNxkzAEbCYSN4QeacdHMNNDDqJet++jwf0Ul1U/3Rw5g+Tx/aqS06qRIV8859gyXDZAoJy+nKT+cc1M2aB0t006lAiIbebMECqnSgOVY3CA6UL91HyDObXAjQzEjtJn/0GWCOVcZBT5oFqXC2ux10YGnZQZWlJT3M8AcCCjvkeYYE2l6oQ1JpCdjwzLwcPSI3NyPPiOT53zC/ZapAl3snJEdYcu+/F789qnMQYpmu3hfWX66ohIOwT8JQhL7ac909F9iQMPjUlYOorR4CZpIECdS8HzlBBQ0JP6lJSVk6JXyuMcxOmrPw4hPqE6FPFPLHsHvPb8iEdX1hgq/wlRWe6Bbxo/6MvH/yfmvaEQq/U0ttJRI5NGCOV1CscS5Flos3LcpvCKgU/iOCygdx4MYrkNaBJIblFcgFHSjuucf/n2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9298ad-cd82-487f-4dd6-08de6319d50d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 11:46:13.2552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ncod3t0O3QYRlcTv2B9/s3PKvnFzno8XbwtzidWQhCulP1kWWYI4Qb5lJstVabK/WE4S8V2j5KYpfMvYPiKGPykM99lNc8E9l9SIKYQCTMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6924

T24gMi8zLzI2IDk6MjkgQU0sIFh1YW4gWmh1byB3cm90ZToNCj4+ICsvKg0KPj4gKyAqIEFjY2Vz
c29ycyBmb3IgZGV2aWNlLXdyaXRhYmxlIGZpZWxkcyBpbiB2aXJ0aW8gcmluZ3MuDQo+PiArICog
VGhlc2UgZmllbGRzIGFyZSBjb25jdXJyZW50bHkgd3JpdHRlbiBieSB0aGUgZGV2aWNlIGFuZCBy
ZWFkIGJ5IHRoZSBkcml2ZXIuDQo+PiArICogVXNlIFJFQURfT05DRSgpIHRvIHByZXZlbnQgY29t
cGlsZXIgb3B0aW1pemF0aW9ucywgZG9jdW1lbnQgdGhlDQo+PiArICogaW50ZW50aW9uYWwgZGF0
YSByYWNlIGFuZCBwcmV2ZW50IEtDU0FOIHdhcm5pbmdzLg0KPj4gKyAqLw0KPj4gK3N0YXRpYyBp
bmxpbmUgdTE2IHZyaW5nX3JlYWRfc3BsaXRfdXNlZF9pZHgoY29uc3Qgc3RydWN0IHZyaW5nX3Zp
cnRxdWV1ZSAqdnEpDQo+ICJpbmxpbmUiIGlzIG5vdCByZWNvbW1lbmRlZCBpbiAqLmMgZmlsZXMu
DQo+DQo+IE9odGVycyBMR1RNLg0KPg0KPiBUaGFua3MuDQoNCklzIGl0Pw0KDQpqb2hhbm5lc0Bu
ZW86fi9zcmMvbGludXggKG1hc3RlcikkIGdpdCBncmVwIC1FICJcYnN0YXRpYyBpbmxpbmVcYiIg
DQp7YXJjaCxkcml2ZXJzLGZzLG1tfS8qKi5jIHwgd2MgLWwNCjE4Mjk1DQoNClRoYXQncyBuZXcg
dG8gbWUsIHNvcnJ5LiBCdXQgaWYgdGhlcmUncyBjb25zZW5zdXMgSSBjYW4gcmUtc2VuZCB0aGUg
DQpwYXRjaCB3aXRob3V0IGlubGluZS4NCg0KDQoNCg==
