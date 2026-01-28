Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A77333DEF7
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769591631; cv=fail; b=M2W8fVSvFLzDw5Ssv1R+pHbwkw0tq0cO+DNhCmqS6IV8Na7kQfDWmif9Nc2zmuZuHNk0/W8jM/t5kRtbyZ5Lu6kI1LRZiqYhh8gvs7DmnImo6HYQKy/oXJzfGrxjCPeyfaFQWCGHQ2GEgJhG6VMOXOcFV2b4EKooZEBojzKZpG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769591631; c=relaxed/simple;
	bh=PorSB9W0aTe+OHPI4tGKjIYogzneqVAmuhPfC5ljuNA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sGg/RnokgC+LjybiAETgtZLFeLe/7izHWFDZ/OtscE6yyctG/RMzp4NUElHFOkW4vzMQTJhor6OQeRfC5blg+Pp7pnILYmqw9KoY2lwmQGywyhxzKdelheevfAp38xCofRU6pdR32dBl8xlhFUUYxGUt/JrwR8Va/zr4PVqqhdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=g0jEOx9t; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ihpOp4zr; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g0jEOx9t";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ihpOp4zr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769591630; x=1801127630;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PorSB9W0aTe+OHPI4tGKjIYogzneqVAmuhPfC5ljuNA=;
  b=g0jEOx9thUzJnTf4exjIabUSKO3TLUex+3AN7IYItwXXYkx7fulrANdf
   OZpuesuADENi2eGw87mUyQiK6rOkvuICAwuL3RzjDAFlVMuFKY2fK30fg
   NKfcX3wDELfFtZ3KL6L8pivLYr620DXHxXhiSunPtGNQ9luLUGZxiDKwK
   7ma+fWROahDWvzKpGKj/jeQmPUx/UgmI+GegZOZPvk7hcxy+BtU24u06H
   gyfRX5hL3lyov3sa86ntteRSJ6tPjPDKSmrSz1+QLOG2sPzP8YBSn2gcr
   rt3j7ljc5rWWsSF/cKhvqx7n01vWZvCAaeSohnuKfih/qhU8DijHQw1U4
   Q==;
X-CSE-ConnectionGUID: zVtJSH6RTGG59AcvLUZ58A==
X-CSE-MsgGUID: BWM5ypZaRh2oOPwpRR/PQw==
X-IronPort-AV: E=Sophos;i="6.21,258,1763395200"; 
   d="scan'208";a="140785656"
Received: from mail-westus3azon11011029.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.29])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2026 17:13:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veQEz6gkoQo+SMBIi61kjhwPzwYvNY4/XFGLr/hTKJDLaSaw8VIdMMUSkDaAnMy7yyQwKb86mUFAsJUKy8Tb9U3wwd/Br2wFo5hSgok/fbF+JDD7JVu4zZQ45Mfqn1n5E6dlxEW4KM+vS6M8VBOVfrnOWWvxqUBI3+wRFxLNS2xqC2LmqQBWfTpNyypZOQgWu48XNevEWrWigRQqEQqP9B65hY2WzP16XJXHRlKTGlohCzijpmH7sOsnkyfBpqZGuZUfSqQ8aG/RaUaTJVpD+13hZ+3f+CU8n2QPt5JuhnUc0yEm1bB7X2/E07er3/egWYwX/1Y8Jt59DfapkGIpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PorSB9W0aTe+OHPI4tGKjIYogzneqVAmuhPfC5ljuNA=;
 b=F1agaI/Lb/mS9d1YmVyVw+foNsxZY2tyF4au1f5B9fxjcRwtF+a4PEcZm1wi1BGGu7DJJ8zohjOb8ZLohhP2FB6jS+S5JBMm19BT+N3HAupBnwZ1xrXIp2eCCwb3i2TGFAqwQ5ZzqsoPDM3SIMABTMBnUit6hQ7tuGVufOjcx4P/3d4SeD/nzSu+TIAYo3BtsnX1W3KtvxpLk0N7pc4nxx7wKv9twq0nWstBQo0bV02KCcrkxRrszx+PLWcPCNAGPi61fSrlyiU5cVnPytXj/mvshQT4XCAs/NSHEGWjqZ+XXB2ss4bvZoA3OQeduYY5CdcyRMnk7kTJ2zFy58ZgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PorSB9W0aTe+OHPI4tGKjIYogzneqVAmuhPfC5ljuNA=;
 b=ihpOp4zrP8QmAao4KkNbCHQSIZbD2vDwtnlNxNjZNQ6Kq2rlxuZNTd57VsVoePL8nJ0N4rI4zZ1ryfCFD509y7uFKPupUEJV/iObRqyfntk+j8w5QsnInvYelZPy5mIOg2jtsF3UDkZ9IZY0Bv7j2lPWBG5AHliy7BotRrssTbc=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SN4PR04MB8335.namprd04.prod.outlook.com (2603:10b6:806:1ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.6; Wed, 28 Jan
 2026 09:13:39 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9564.001; Wed, 28 Jan 2026
 09:13:38 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Alexander Graf <graf@amazon.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?=
	<eperezma@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] virtio: silence KCSAN warning in
 virtqueue_get_buf_ctx_split
Thread-Topic: [PATCH v2 1/2] virtio: silence KCSAN warning in
 virtqueue_get_buf_ctx_split
Thread-Index: AQHcj6E1GOgBNh07wUeJzhZS9L8GVrVmNS6AgAERDQCAAARvAIAAAtkA
Date: Wed, 28 Jan 2026 09:13:38 +0000
Message-ID: <9004e3b6-fbd0-42a8-b722-bf6d25833dd7@wdc.com>
References: <20260127152524.200465-1-johannes.thumshirn@wdc.com>
 <20260127152524.200465-2-johannes.thumshirn@wdc.com>
 <184ced70-f3ec-49c0-9b18-96f0ad044a78@amazon.com>
 <42d57017-88b6-4ab6-8fa9-10658d268fb6@wdc.com>
 <4fde2f6e-d272-4aa8-9701-63bc6b7e7d16@amazon.com>
In-Reply-To: <4fde2f6e-d272-4aa8-9701-63bc6b7e7d16@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SN4PR04MB8335:EE_
x-ms-office365-filtering-correlation-id: 2571cb05-4432-4313-086c-08de5e4d861c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WXdybHluOGZGZVV6OWRpZTZtWXBqeDArNGhHWENUeHQvN0dHc2VNTlJNMUdi?=
 =?utf-8?B?ZWZrL3RsNXp6dmlUOGZDUDR5czhuNEZoby9xR2ZraER2aWF0anA5c1NDUXNL?=
 =?utf-8?B?TFRubEQyUExQeWUwdE9NaUdlY3NrVUZvK3k2bGlUeS9qd0FRazZRYTErWmRC?=
 =?utf-8?B?bjhyWEpNYVJVNXJwcXFTNVV2VVBaNkdMcE5qWlpJcGxIaWwvQjJkM0FPL3M5?=
 =?utf-8?B?bFA4Uktla3NRQnZVUTRHRlg1S3VkVlFKMFJhd3VzTlZIaGVXOG5ubjdacVdB?=
 =?utf-8?B?ZmhGVEh4c3B6NmZMdUNhbHdSdWE4WVYzNHhkY2xmVmNQVVdTRzArTVVsRVFm?=
 =?utf-8?B?eEIwZnVhZEZJY2orQ296YWdranM4bnllQlpQN3J5anRWSGhxRkxvSXlBUTBH?=
 =?utf-8?B?K0t1c2hBTnlpclZwSkg2UndUK3F1Q0N0aldEZktESmd4MFo2YWVNUnR3d25D?=
 =?utf-8?B?NWFMVUp6eUsvNXlKZE5ZV3FUSkNsZHJaSy9uS0ZWZXFKMW0waGYyek5udU1O?=
 =?utf-8?B?SloyVG1lUS93czlYRmFBWU1pVjlwWlphd0xNNlhINjZOTnNFbkdyS2RaOU04?=
 =?utf-8?B?QmticnNlNWEzM0xGZjUwOHpwVEpiWVg5RHRJcXN4UDN2MDFPc3h6bzdjckF0?=
 =?utf-8?B?UUJ0NHVCMmE5ZzhESW5lVjlCT25pRGdKcmNPbEtuMmFuQklBaDBOcTMwdDdu?=
 =?utf-8?B?d3RjdksrbFlBanRqcm5Jcm9POXhTaWJUMWlYQzA3aFVtMkJ5akNPY3c3WXFX?=
 =?utf-8?B?NlVwT0VrSXBkMnltTGVOYlB0ZFlCOTJSUnh2UkI0d1dnNjNmZkhuMGQ3OFY2?=
 =?utf-8?B?cFNSVG1DZ0loNk94VVhTYnRsdTRaNE53QjN6dk9FQlAyVDZWWmFFY052ZTVN?=
 =?utf-8?B?U2RMQVorNkRCQzRWeEtLR0tDYXprWHM4OEdGU08zWXJ2SCtQZ0hBR2RweG45?=
 =?utf-8?B?aWcvRWZTY1BjRUhWOHE4MHZHK3BrSGxydFF6TjRzM0l2eDdWNS9HTk02K1lE?=
 =?utf-8?B?bXZlSE53WGNHZUVRMkk2SGp1VmYvS3N3bHN0c2VIdjBBeXJ5S1VLNmhXc1cv?=
 =?utf-8?B?UGtXUXFFZHJOTzdIcElrSnZKNjBsYzF5K1NhbkhFWjZJajBrODZ3V1VyMmZN?=
 =?utf-8?B?dFpnaklPb2tFY3BJZW03V0lIbHpsUTZqTWZ4cUZaenFGL3laY1diOUVOM29I?=
 =?utf-8?B?UEt0eVcxV0JPdEc4b3dNcVlmcXRxVnI3RUNEZThjaStPcm5zbDdwT0YyYXg4?=
 =?utf-8?B?cW85eE9HMmRvcXBBVlFDclR1VVRlRnU3REhWZUNPVXFuZUtFeTlKWWdwSWNL?=
 =?utf-8?B?c3hDMWlvSThONHhHMTBxTG1tTk1BTW1XbzFydG44OHU5MFoxQkNObFhua1ZY?=
 =?utf-8?B?MXJVRms0d1JGSTZFYjl5clZiMG44WThiQXlTVVl4SEorTERqbnZUdWxqdWt3?=
 =?utf-8?B?UE12TE9KSzZQTEFGaU1pd3QwTkplYUZ3QVA3UE45USsvOUczazBnazhUaG0v?=
 =?utf-8?B?VW9kTG9ZZURHRlRxQmY2eHVLcnRBWnR4SHBxQW1USVAwTEVURTVFTmcrZHBX?=
 =?utf-8?B?d0RFeWdmSnBuWTlrL1k3UEpQSGxFNFB6R0lkRzRLSXJCVmhRUkdaMXNkQytJ?=
 =?utf-8?B?SjhaTFFrLzFZQlZYZEdxSDVBdGNpRk1GY2JCMHNkcWNVSTliSlkwOTJ3K1lM?=
 =?utf-8?B?dmt1UUNGSXRJQXBaNmR1Wlg2blgrQ2F0ditnTnVNOGdUN0FRREwrVHpCQWlu?=
 =?utf-8?B?TlFna0oyVU5WdjJVN3NIOG5UcFZGb01TUkJsR2ZJRURvSEJxWHBSN3FaSm1n?=
 =?utf-8?B?akFhYmZTWDZwQzBGbDVvZmRjYnp2Vm1Gd2ZNOStSb3kyUUVvUjZzdklLbEFv?=
 =?utf-8?B?ajdXQytmYTRhUkVMMjlVR3k3MjVrMDZjcTlXSTFaYnV6d2owWWwzYVpYaVR4?=
 =?utf-8?B?QzdFSTVnYlJaY0JXYXdLOVZYUi9MakVwK2JjYXhyMFh1TG9Delk4TzAxRmFB?=
 =?utf-8?B?YnQrM01aSzJIQ0tIZC9FWG5BMUxhR2JqN0JBSXN0Z3RzdWZVT1doUGw5aXZI?=
 =?utf-8?B?ajhqSWw3VlVrTkxtVXNEOXBqWnlCMm9icEVlTEhYeWkzS1A3YjN5RmhBaU1n?=
 =?utf-8?B?R1R4WDgycVd0SVJBSnp0TjhtTk9Oa2ZXRlIzMTVxclF3UTdWMzdPeDYrRXFZ?=
 =?utf-8?Q?Qn7BYVivGSs11RIZacm5WLk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1BnNVljUFpjRU92WXdXd2FmWFVXSVZ5N0xUeUVlQS8vTTg2a2h5dG4xKzNL?=
 =?utf-8?B?c0RESVZIdEZCRi8rY0hVTXJDYkNrOGwxWno0SnFYNk1EUXJQMzI0aEtUbGwr?=
 =?utf-8?B?dmN0SEtEOGRIQ1R5czVENEVVVG05NWZiSWJMNEMvOWZnVHBRdW42YmNaeDZV?=
 =?utf-8?B?dlFQWHZsbVE0MkRQQjA2RERyWW8xZktOY3V3M0JjdzNnRkRkTmw2Nzcya0tP?=
 =?utf-8?B?YjJQeERtS2ZzcXJhbEtIU3QzWGpTY1hVM0p6WGVyS0tFQzhobVVnWkJBeU44?=
 =?utf-8?B?ZWQ5MllXVWhDZ0h3djlqYjNHMFcxQ3N0aTRLN1RiNDBLSTR2d3RISU9YdnF3?=
 =?utf-8?B?blAxR2U2SCtUVHY1dTJRVWNQdDFuNGN5WTRBaFNIcEpyV2lnSlRQRjg0U2Vz?=
 =?utf-8?B?eGF0ejM1M3d3QmNObzEwQlpkTFdMeWNOL1duYXVidVprVElyQU5WaTBJbzlt?=
 =?utf-8?B?MnpIT3FQdWh4Qmc2aEUySSt0UjBWaXNCVitoWDQ0V0JpRWg4c1FjSXBadnVI?=
 =?utf-8?B?a3Rqd09EWkgxWS84SWJ4dWpmeGJNNzd3blBNSlM3U3JSeWthaC9JMDNnMFEx?=
 =?utf-8?B?ODE2cTdqUTBQV0xGZFRZWnZXd0Q1QTZ4eDlucUgvRldBR214ckhQMjc4UXJo?=
 =?utf-8?B?VnlwSTR2SnYzZzNJcXU3Q3YwbkJVdnhFOTZZTUE1aEJydUZzeW45aGV4SDlY?=
 =?utf-8?B?Mk94am1LT3hsaXVCYnpkZUhVMS9Nd2J2czRSQ2Zzdm11ZjY5MlY2ckE5ck0x?=
 =?utf-8?B?b1Y3SzJta2Z4bmVSaHhKKytMRkFHVXNxWDdRMEVBTnJGMlpQUHBSeGU3NzNU?=
 =?utf-8?B?TkVtYzZ4SG80YWxZSC9jeFZVanpWcU5KdjJYc1c1YXVHYnFRVE80NkRWdW8y?=
 =?utf-8?B?UzZRRnB3MDgzZktLNWxreUZremViVm91RzB5d0ZKQ3VveDNPdXZ4ZDNkVS9v?=
 =?utf-8?B?bEZ4SUZ3TTlFVXk3TFJWNGd1QlpOamJHaUZuUUVyOGhnR1lyMThiRnFLN1RL?=
 =?utf-8?B?UUNOcHRqbVZ3d3lSM2pPNkc0QWZ3ZmMxVEpjWDU4dnA3YVBlc2JPSGNBcHhH?=
 =?utf-8?B?Z1RqUUZMWGU3dXpCbzEyOG9UeEhERi9mbFlGOURTSlptZmJ6ODcwSXY0dlh0?=
 =?utf-8?B?NmhOWHdic0xWemZBZU5oQWN3eGxidnJRUVpmUzJUaWNNWTFBS3V4b3hxZko0?=
 =?utf-8?B?MU1wZlY3K3ZZb2VUc2ZBSE95Q2dUajBPb3VKNnplZW5JMGNXZG8zNlVFL1Jj?=
 =?utf-8?B?Tk5vVTYra1JleG04cGhnVU9lTSswRW1KRk0yMDVnSy85M0xaRGRCYVRGWlF0?=
 =?utf-8?B?RSt3SnNickVSMHcwVTNwcS9nbTFYWlZaTkNpVHdSVmRndkZTMEZwdllOTys1?=
 =?utf-8?B?WjFLY0J1K0xOYUVVUW1LTVNYRFBPSGVNTEljRTZDdkFoWUJnb0JUQzl6SGZC?=
 =?utf-8?B?aUlRSHVjQldNQlFqUzRFUnBVaGhoK3hpMDFYdzFLV0lXa1FORk9oRUJQWXVs?=
 =?utf-8?B?aU1wbml4YjJTenF1Vzd0Z0JQTzJCdU1iazU4RFFUKzI1SUFTTVByaTZwV2ww?=
 =?utf-8?B?TXcxN2dCV2YvbElwL2dTVUF2elVSK0xReFdndEV0QThYekJxWDNwZXhDcGt1?=
 =?utf-8?B?a2VHVmFvSkw5M1FvdXVjVTBCMWFxOGhrZ3Q4UnlIV3NEaTZFN1RpKzBTOWJv?=
 =?utf-8?B?VkFEMVZTU1l3cE4zbXFzaDV1Q3pTNGsrcDlQeW1EZ0Q5Vmh2TjdzSFJXZ2Ez?=
 =?utf-8?B?bTEwUFkxMXhnV05vaHY4ZTRuZjI3ZnVzbXVvRkRrMkpNVFZRVEwrc2lSRGs1?=
 =?utf-8?B?cndUeW1HaE1ydW1PY0NNLzVJRUhZMitHUW5tVk1WUkVvWThYOU4yRlNBeVJt?=
 =?utf-8?B?azk2Skh2QjF6TDlFU0MwNS9PMUVTVG9hVnRFMGVwNndvNnFpendyNnMwaE9t?=
 =?utf-8?B?UStzK0w3N3d2RWtlOXhUTWpLVWpTZ3R1L3NWRkxMblJHOXZ5cEw4bEZoTEk4?=
 =?utf-8?B?Ynpqd09zRm1vZjlMUUNmclpvZzMvcVloMXV3ZHlXbTVqWXUyWTdzZVQzRnZ2?=
 =?utf-8?B?b0ZGcEFXOVdkMHJXK2tRRWg5MmtwUjRMaWRyUFM5T2hRaHdMSlR4NHBSTkgr?=
 =?utf-8?B?RDAwSFZkR0k4bzMrOTU5OG5MMXRjbGRVenIzWGZ6THZ3L0RGRVVpblpYSnMw?=
 =?utf-8?B?Nnl1NWxDc3JtN0FnbUd6M0M5RlZ5algzSHZjMVpZSUx3QVk0bGhneDNIOGU5?=
 =?utf-8?B?bGQ0dnIvV1YxZW1LL2RIZGpYbVM3Y2l4Z2NQbUJ6bitWamZPTXFZV0doZkEv?=
 =?utf-8?B?b3pVeUdKeTlWQ1FZZ1ZFVDRDZVF6VWhTWk5OOS9MY2NRUlRhQUR1YlF5Z0RQ?=
 =?utf-8?Q?dMbOYBojM82tX5/8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E24F96FDD761640B0669AAD198AC03D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x3nbZr8a7Pu2oFRgv9XphsDfmbieWSPrxXesws5bT5225yFKnJf58aapLBaMxTVsu+O7ALq/ryk6MhCj417XT8/3/WWxQn9ZlAMCHA5EViXQnXQZCq5VY3sWuRoeG2bQ4YeP/RktVavGXkrePlr4IluVotuJVVO6lrgB3FqBqlCm5VBczN7sunRX1dfRX2TWxHbJIFPyuVWrNGyQXhE9xvmyS86DBWNCqhgNt1NXHRlDfheGSZbU/XvETKigk17o5q+/sG3x+XmsSRMbTIZrO9E0/cI5M6ynnYCEHJmqOH0vt4f7ckIfmsKheOeDNSlCvxY/pSuTbtIsbBtap9DzLb4FPWxCPLuGQ4lSRJ4Zxr895yLjfm5TUBMeXg9mZJZ9hhvh73IfyspM/QuIlNiOA1nk6d/s6n77GncGU6X/qA+EFFjC6EKwFwPe5ZIwgl8KbTGDZ1ubUCIvC9p7Yx9iAgMEs+WxMXHMt6vTTabk32unonyCRuLtwazAgSQMiPLXR3ciDvbGhs0j1cmQC007noTDWUksPWaByOACZodEKrxajWepN3QjmDIYOOlicOMLjlLKKBJyrzl0+8FzI/tiDtFZ28qlyJIoIFWu1h2DKEsv8L8gGeO8m6o905a3v+PH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2571cb05-4432-4313-086c-08de5e4d861c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 09:13:38.8159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZVLpqakAorDdaq76qhLtlqdIRW4SZWFinsTpuead0GDqmpwgf7VCy9J/UMejOMTtb0lkSavCYFFRNXdCDkayLCagTBXsLkCG7W9Zxd0zoz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8335

T24gMS8yOC8yNiAxMDowMyBBTSwgQWxleGFuZGVyIEdyYWYgd3JvdGU6DQo+IE9uIDI4LjAxLjI2
IDA5OjQ3LCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBPbiAxLzI3LzI2IDU6MzAgUE0s
IEFsZXhhbmRlciBHcmFmIHdyb3RlOg0KPj4+IFRoaXMgcGF0Y2hlcyB0aGUgc3BsaXQgdnJpbmcg
Zm9ybWF0LCBidXQgZG9lcyBub3QgdG91Y2ggdGhlIHBhY2tlZCBvbmUuDQo+Pj4gV2hhdCBoYXBw
ZW5zIGlmIHlvdSBydW4gdGhlIHNhbWUgdGVzdCB3aXRoIHRoZSBwYWNrZWQgZm9ybWF0PyBZb3Ug
Y2FuIGRvDQo+Pj4gc28gYnkgcGFzc2luZyAicGFja2VkPW9uIiBhcyBhcmd1bWVudCB0byB5b3Vy
IC1kZXZpY2UgcGFyYW1ldGVyLg0KPj4gVGhpcyBvcGVuZWQgdXAgYSB3aG9sZSBuZXcgY2FuIG9m
IHdvcm1zLi4uIDooDQo+DQo+IFRoYXQncyB3aGF0IEkgZXhwZWN0ZWQgOikuDQo+DQo+IEhvdyBk
byBvdGhlciBETUEgYmFzZWQgZGV2aWNlcyBoYW5kbGUgdGhpcz8gSXMgdGhlIHJlYWwgcHJvYmxl
bSB0aGF0DQo+IHZpcnRpbyBieSBkZWZhdWx0IGRvZXMgbm90IHVzZSB0aGUgRE1BIEFQSSBhbmQg
c28gaXQgY29uZnVzZXMgZ2VuZXJpYw0KPiBLQ1NBTiBsb2dpYyB0aGF0IHdvdWxkIG90aGVyd2lz
ZSB0cmFjayBETUEgcmVnaW9ucyBhcyAiY2FuIGJlIG1vZGlmaWVkDQo+IGJ5IERNQSBhdCBhbnkg
dGltZSI/DQo+DQo+IElmIHRoYXQgaXMgdGhlIGNhc2UsIG1heWJlIHdoYXQgd2UgcmVhbGx5IHdh
bnQgaXMgdG8gZm9yY2UgZW5hYmxlIHVzZSBvZg0KPiB0aGUgRE1BIEFQSSB3aGVuIEtDU0FOIGlz
IGFjdGl2ZS4gRG9lcyBzb21ldGhpbmcgbGlrZSB0aGUgKHdoaXRlc3BhY2UNCj4gYnJva2VuKSBw
YXRjaCBiZWxvdyB3b3JrPw0KPg0KPiBBbGV4DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYw0KPiBpbmRl
eCBkZGFiNjg5NTk2NzEuLmIxZGQ3OTBjZTYyMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYw0KPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jDQo+
IEBAIC0yODQsNiArMjg0LDEzIEBAIHN0YXRpYyBib29sIHZyaW5nX3VzZV9tYXBfYXBpKGNvbnN0
IHN0cnVjdA0KPiB2aXJ0aW9fZGV2aWNlICp2ZGV2KQ0KPiAgIMKgIMKgIMKgaWYgKHhlbl9kb21h
aW4oKSkNCj4gICDCoCDCoCDCoCDCoCDCoHJldHVybiB0cnVlOw0KPg0KPiArwqAgwqAgLyoNCj4g
K8KgIMKgIMKgKiBLQ1NBTiBuZWVkcyB0byB0cmFjayB3aG8gY2FuIG1vZGlmeSBtZW1vcnkuIERN
QSBBUEkgZ2V0cw0KPiArwqAgwqAgwqAqIHVzIHRoYXQsIHNvIGFsd2F5cyB1c2UgaXQuDQo+ICvC
oCDCoCDCoCovDQo+ICvCoCDCoCBpZiAoSVNfRU5BQkxFRChDT05GSUdfS0NTQU4pKQ0KPiArwqAg
wqAgwqAgwqAgcmV0dXJuIHRydWU7DQo+ICsNCj4gICDCoCDCoCDCoHJldHVybiBmYWxzZTsNCj4g
ICDCoH0NCg0KDQpVbmZvcnR1bmF0ZWx5IHRoaXMgZG9lc24ndCBnZXQgdXMgYW55IGZ1cnRoZXIg
KEknZCBsb3ZlIHRob3VnaCwgaXQgbG9va3MgDQp3YXkgY2xlYW5lciEpDQoNCkkgc3RpbGwgc2Vl
IHRoZSBLQ1NBTiBtZXNzYWdlcyBldmVuIG9uIGJvb3QuDQoNCg==
