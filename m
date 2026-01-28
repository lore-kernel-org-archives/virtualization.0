Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573BB311946
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590059; cv=fail; b=Pij3I2X84eQkQMTnUNNghbGIhcq03Ks94jzCZdQUiL0iWvcFL1oRCCJ3dfWhIBKg1j356ZAsYBqgP/4fQQ5dEit96UqPl+LK0MC2E5+9dAHKDokvO0NqjWem9iILfXuzTwblgFSijcrVq2/iN6upMYzJAASbMhhXhrFXmeEzo+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590059; c=relaxed/simple;
	bh=sCRQp8XeamFxTnJpGj96xdhe0QEPsZeNuX+lENdK8Xg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GANKaC8DpKKA7L5rd6LcoFHK3hcEFOFgaTYRf02q1t5JY+Z+UoYUiRESCP7z4EQul0HxndklRfYRph7/q3qW16OUYheh2uLOBQY0VBlGZjHveHsOR3aDbeanqSsWa3XaGlVNAkW1824thCOlZ30Yy0vpWJEkUo9/nfd0PgpL6oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=K0GW/47b; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=flUSW1iV; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K0GW/47b";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="flUSW1iV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769590056; x=1801126056;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sCRQp8XeamFxTnJpGj96xdhe0QEPsZeNuX+lENdK8Xg=;
  b=K0GW/47bR7f3OLbmbw6xv8eh44nCYst9Y0okq05PxX2UvfawZwTZePW5
   dkBYbiIOvMA+05scuCzKbbxzm4jZsQBOpBIQjIiklC/6TmOIUOxawBCIT
   BGOyP98IKauLte6ardzb+PG8enqvPZODPDPUKp+nFFoFlaMZ4fSnSxcrx
   RH1TZmKT3jUF8qI2Etwvu8lL4fj7LZwtk8AvaY9x1StNVVUnA4KzgKTx8
   E01Ft/znjdlbhcpktkEWDtDwF5A2hRuWPGxHDp+9o5uoOyU2i8/dE4u5C
   eGxSPnDtLJNsy3le0Y05yLYFZMiFD2reXT6b4ILwIinIt1/NI7NoRqjBk
   Q==;
X-CSE-ConnectionGUID: o4hUBshXTcSbdpyOq4x+pA==
X-CSE-MsgGUID: PJXcKw9dSHS3eTZ9A485zg==
X-IronPort-AV: E=Sophos;i="6.21,258,1763395200"; 
   d="scan'208";a="136192601"
Received: from mail-northcentralusazon11012017.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.17])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2026 16:47:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRuQBzj6L+92a6VPPiig9YOchB9gONwB0fkXwGNUbiq5HBb3hEezKKchnCKOS7uWtB3p4Vq5peUb3ZEZ1XubKXnHyocbniKtP98aWQffOIVYg1oTqrkHbkhnizQHVaL6lkHIYd74ZaKQOTKYAJtqtRnKp9O0bJJLAZKzdBt6E1Hz8L/vXSNIk1YrvaUHuCeQ9G714aX3S2DfdApSAaCBtv5JcI1K2cxLQKq5VM9DZaXYs/tYus9z+J/8AoXLDvB7W3XHZ/qVvEWgV2yAHYKbzqOUQbcrqRM8aNwy63VJ73Li/jUd8gnze2IophlwkJBHTnGzlI8F6r8nqSeur5miwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCRQp8XeamFxTnJpGj96xdhe0QEPsZeNuX+lENdK8Xg=;
 b=Rs2NOmT6q6GMLlC/6JLo9lV0IwDawPlkLtDAWTcIciImk41zGcOqlIle//oVIAH8yn2oWyw5i/eo52vkEW6JfroCyeLSweP+6VP5nEjrvbYADtdUisjfHgXfH9T0qvJWTFWBW/Js31KwK1Qp7Tb4kswZgmkNvWFdOzvs2L4ChSQqkdAg+mL8XAFqVcvO8XtqPKFsZ0VmqmLnaA+gzm7I9YvCJum5XHi4wQePZs+Pt/MFis9F4mTx07ZyMGeWH9FTVDQ1tUX9rSf8UmcDOrRe8jktCU6YhMbfkX68tQ59NdEBhayO7WOmeocpKpvOrHA4hhpMFSXjwiDBmBPypU5Mnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCRQp8XeamFxTnJpGj96xdhe0QEPsZeNuX+lENdK8Xg=;
 b=flUSW1iVA7hrEAohUf6HNTHuDyF0b2Xe/KoktpbbWMM+/+yw9E7XeggUFssBz7XiQf+h9ZLOUU8gZxqn+2YSfKXnzwUE9HIBWQiRgmbENpK+azCi8iGpb/WBedrNsa/520yyVW8EazIW1B2MShAWN3GWUNlSDkMq32OvXOJLIXU=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by DM8PR04MB8071.namprd04.prod.outlook.com (2603:10b6:8:2::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.8; Wed, 28 Jan 2026 08:47:34 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9564.001; Wed, 28 Jan 2026
 08:47:34 +0000
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
Thread-Index: AQHcj6E1GOgBNh07wUeJzhZS9L8GVrVmNS6AgAERDQA=
Date: Wed, 28 Jan 2026 08:47:34 +0000
Message-ID: <42d57017-88b6-4ab6-8fa9-10658d268fb6@wdc.com>
References: <20260127152524.200465-1-johannes.thumshirn@wdc.com>
 <20260127152524.200465-2-johannes.thumshirn@wdc.com>
 <184ced70-f3ec-49c0-9b18-96f0ad044a78@amazon.com>
In-Reply-To: <184ced70-f3ec-49c0-9b18-96f0ad044a78@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|DM8PR04MB8071:EE_
x-ms-office365-filtering-correlation-id: 1246ba0e-9ade-44d1-68e3-08de5e49e1af
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eHhWckloS2pzenpwR2pkVlNsL1N2TDRZYTMyVDBrS3JGQ0pqSnZIaXJZS0VH?=
 =?utf-8?B?SHowR3FMNXJJVUdQZ2h4Zi9tTjdUSnFoZXhBTFdHUWRXdy9GdW01aFNSbUZw?=
 =?utf-8?B?Nm9JY0pFbDA1cDlHVEk0RjN5Q0h3QTVuK25rVDgwNnJOb3VqVUJBV1RMS0VY?=
 =?utf-8?B?bU1jRlY3VDkrL09KOWJPSWtqQk9kL21rMUZkeFlVejlta3RNbjBObXdMYU0r?=
 =?utf-8?B?KzJ1VW1uKzliYTYwMEJsYjdmODgzZHNTRVhwMi9EUzFnbzZBMHdBajZwNlA4?=
 =?utf-8?B?dDB0ZWNwRGNDaks5OGJtSzYwS0lXZXcxSkIzTDNZTVdQN0l0R1lnMlZpZDl3?=
 =?utf-8?B?QUF1bjJHZ3lKWHdIbkt1K0J0d2JiMVRyc3hQZlNJWUFLRmdZNEQzSlpqYWRa?=
 =?utf-8?B?cGx0MGthN25DdFpic2FCM0hQa2QrQ2tuYTN5U0k2WmZtNXBIK1NqL0VyMWxL?=
 =?utf-8?B?SDFKZ2NLd0V3bnlvWkVxdGNEd1RkRGlGRG1BeEdueGRSalF3N0o0NU9iT010?=
 =?utf-8?B?Skh6VDlxSWY3em5FZnZMK0wvTXdkeHFxVXFUZ3oydHZsbTdnVit0dFl1Z1dz?=
 =?utf-8?B?V1hVN0ZibFIrNE5TZFJkR3o5RHl5VEJSRERjMU5KVldKNjhwcmNHVjczbVVM?=
 =?utf-8?B?WkhLYWdnWDVNMmo5YlNnOUt6Q2FiczB0bVBJVGxmRTBWR0ZjOVdsZ3VjK05J?=
 =?utf-8?B?ek5ERjNnNU9GU1lkYzFWcTEvUWtaNTlEVkJzRjJxNGtlVTFsWXlJT2o0dGl5?=
 =?utf-8?B?ckRlcFBYWjBSc3Nzd3lZaG9DY0pNL3FWbWJGWndGVXhtVmlaVUxVR0RXcUxp?=
 =?utf-8?B?NlBzL29uUjZuTUFPM1FjWHNXeFZybktmcnlQNk96aVFZZm9zM3NkQ0FDUFFI?=
 =?utf-8?B?S2R6RUM4U0JBbDMxMkxEb28wSVYvRnlqME5OZ0IwUzJyNUNWSERaV09uN1la?=
 =?utf-8?B?SXNpc0ZKY3kwUGtMN0d4R3JhL1NvbXpsZXlicWFMUXJNbzFrNUhJbEY1OTF1?=
 =?utf-8?B?MTYyM3c3Y0VDMlZhbDJ4Z0Jqc1ZiYmpleXpjZzVsQVFpQk44alVHa05EMlM0?=
 =?utf-8?B?WGp4MnNXeERPNUdSalpaTG5xaDhNZVdlRDZBM1NKTE90UHZWd0IrdEk1TlNa?=
 =?utf-8?B?UVlKUnlFQ0RSWVUrUTJ4b2dKTTl3UmpjRk16eEtRczVqSnBscFNuZHZCWlpU?=
 =?utf-8?B?cFlvVmdGVEF5aVZCSFpuVk5nS3Uxd3Bpck1FM2ZLa0o5RDhXSzIzUlR3Skxh?=
 =?utf-8?B?Rkdpbm45R05aVkxFSlI5bkpqWExRMURLZXl1NkF0OUVRb2RjV2JBMXAyTzJr?=
 =?utf-8?B?NHFMeTRUUm5RdHM4c1F0aTRrWksxNVJNS3hQalhSZ3JhNnI3UmZBckhMVzh5?=
 =?utf-8?B?cmcyY0lzclpmMXArR0hENXgvaHBYcm5kN2xocmlIbG9WVWlYUWtmQS92V3BK?=
 =?utf-8?B?bUpBWlM2cVlyUDJoeWMwdGFvOThFQXM0c01jQXpENWVDSHBtT3N4YUw5Uk9t?=
 =?utf-8?B?YkVsajJOeHUyRmMzUW9mb0dyN0dNc1l0bWovMFZZV01oT2REbUM0L203Rkt5?=
 =?utf-8?B?RFU5QWZoa3ovR2orYWVGK0RYWE1OMlllNkJVZmNBcE5WcklQcG83OVpuRlc1?=
 =?utf-8?B?L0d6WGs2MlQwczBEbnJVb21rcnJCUlVINFZHaHBIWEpqbGEwUzJtTnZmT1pp?=
 =?utf-8?B?Nmowb3FzeXBPamNKaUxLditlbkhRbHAwek9EQ1dUcWFlaWcrQ2VPRnBaTC96?=
 =?utf-8?B?Z2FXOGZqVDVpRnFuQ2VkS0YrU3NHMHFsUXhzbWlNOHNXN3ZZcEg3bDVhVEhs?=
 =?utf-8?B?aDVuc3JOWWxUeFFnTWQ2cnhWRmxiRHdMSFJHOThUSzdTTGd6SHhSM1ZubGlO?=
 =?utf-8?B?ZmtNMzEydHZvcTdrU3Yyc3ZTa0dralBFTS8xRUFFTkcwNHhVa2p6NUhXMEJD?=
 =?utf-8?B?T0JQWVNIcTVaQ0g4SDdHa1JWRFRRUGVaWGRYRW13NENPUUhvc2RjQWF4Y2Ji?=
 =?utf-8?B?WElDTnRvc1pLK2FkNjI4Y29HRTB1RGYwc01aaFV1V2VpM2NjL1F6REZ0eW91?=
 =?utf-8?B?Zk9ReFV6dVJOL1RLck5kVllSRlVOQ1lOcFdtd3V3WTljV2pLejNmWFF3dTFB?=
 =?utf-8?B?MHN6aE5iMVN4Q0JzREFyazh4SUhWUlRGdTl2YkdmOFRseXZhcXNnNHBMMnAx?=
 =?utf-8?Q?FIyGfZ/qEEfIHkQ6tM6fgZE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWlQbXNWd1A0YXdicS9HdXI2a29pK2d4NjEwWWM0WG9hb3l5TUpPdTdUc1VN?=
 =?utf-8?B?UDh4SzRlaCtLb0c4VFRva2lJb0VwamxEbkpUMjZYd3Y5Tm9RcTB4UGFaektL?=
 =?utf-8?B?TllkZWYvNTBkaEVnTzlLZU5JeXdwQXNkRWZMM1VDRGQrMWNrcVpHZjhnUjM5?=
 =?utf-8?B?UE5sd3NxUnVVZ0xETEdPcDNDeWxmMFJSZ3VsYUhlaHgwZ1hVQjdYUkhWcEQr?=
 =?utf-8?B?M0w4eHhtY0lJTmFUeTNlQmxWMGNHbWZ3TzB5NVg0WDZJRG1wNGx3NjdoUXlI?=
 =?utf-8?B?Z01TTjBuT3h3VVZkT1RHQmR2T1JHRjNJY21VdTNwajgwMS94REZyWnlpcE1J?=
 =?utf-8?B?dVhSNFhGeVVCNlQ4bmZtdmdqTWcxdVNDL0gwRjhXbHpnYWxDUURrbmR2RUdm?=
 =?utf-8?B?YkN3K0lIc29xTGRocXZQTlZvUFJhM3FRVU4rcm9pRlg4NWdQYVJrTDRJTVVh?=
 =?utf-8?B?SWhKbHppQ3BzVGwvSnhLaG1jdVJrSG9qcGhoKzQ4NEc3VXJqaTNLY09WUU4z?=
 =?utf-8?B?cGtXU3RXQy9MQ1FLME1Kamp0TG8xQkduSkFlc2JGZlVWMEJ4RGdoRmZaV1Rl?=
 =?utf-8?B?bG82cFNIalg5eWZ1L2ZEOE4xa3hpdlNacFB3L05HMmV6Sk91Ym1BK1lCWlhq?=
 =?utf-8?B?NHFEZm55blM0UDdMcWFvS2dSRjNCQzBDSVoyWXRJUEEvQUJSYm5ZOWszUWI3?=
 =?utf-8?B?S2hvbnZrTnY0eUYrS21GYmp3UFIxazVjMzFvMzdpbWhxRUpGWHNIdlhBODlh?=
 =?utf-8?B?NFBhVWI5R1pYNlpjU0xsUlVITFQ2TWlQYnNBTWtvbEVnZUxFVWRvbHVHc1ls?=
 =?utf-8?B?ckZzZzI3dW5LRXVIZkRNTHZ6SW0wZ3YwRkNwVy9MdGZpQzl4d0V4aVBXZXkz?=
 =?utf-8?B?Z1JoTGtYeGV1a0UxSGFIVTVvbVNXT3FjYnVVWjlOTHQzYlV1aDZOQWpqVFRs?=
 =?utf-8?B?M3lHSXlESFcxanNKUm0xbzNHUzljT05uK2dhcWI3Q1E3VnZ0bmlmS2ZFa2Nt?=
 =?utf-8?B?YU9nREE1VDIxZE9VN1poSjQyZ3pscGk3M2xSYi9sVDJIQ2dNTFVSZ04zZm1D?=
 =?utf-8?B?blFmeTFkSzEwZGhQL2xLS3ZRRWFUMW9QaFVlSG9sazhVZ0taV3JTb0tSeGlS?=
 =?utf-8?B?eDJMbS9UUVdKRDVxMXJUY1pnQ0hPQzkrbjBzbmN6ZG0yZnVIa0RZUi9aVWFG?=
 =?utf-8?B?czhLd1Qrc2Zxb0RSclA4QlJjYnN5WU13M0w5VCs3ZkNCSVFhZVl6ckJyMzZk?=
 =?utf-8?B?UlYzcGp6UW9sc2dINXhBRCtkTDloUlZ6ZGdtaUUwSmRMSGRrNWV5ZjRUTStw?=
 =?utf-8?B?ZUpXTjNGcWdDdThVdEsrT243Ri9sV1dRRmlaTVhtTk45Ry95TGNvMGN4Nm9E?=
 =?utf-8?B?NmRrRWxlcm5QYmJJVDlDcVVtRHpudmlmOThIaHB2UWJneitFUldqcnJJQ1RI?=
 =?utf-8?B?bC9RNmV5VzZnTGZKN1hmaHRnTktWNTVLekczd29XUkV6SGI2TjZFL1JRcG1m?=
 =?utf-8?B?UDYvblpMWmtXbDhFMEQ5dStjVHY0QXdCc0Z0UXJkbisrT3U0NUFEL2RjSjFw?=
 =?utf-8?B?MDFGQWg0TUtwMkRtMjVVTmphVldQREM5Z1ZBWXhBeUViU3pFamhWY2lkMXpS?=
 =?utf-8?B?N2tTM0gyZTFMelVMRHRVRmgxenVDUUlsRXpaZU9Cd2ViUlVJckZ0OXk5dG1D?=
 =?utf-8?B?V3Jaek9DbTdpT1Y2UFdkUUlxTWRYSnZsVzFIaFdrK3R6cWtZVURJOXkvb29E?=
 =?utf-8?B?bklPRkpjWG83amZCbXJlVUp1dmYwRFFTS0llTlBkNThab2tsa29QS0tpTlNm?=
 =?utf-8?B?dURjQSs5YVVNTytRanNlSFlCZ2NMTmYvb0Q2RWlFWnRPMGJZV0M2dGtuV01M?=
 =?utf-8?B?c1ZTV0JKdW1DUVlwUlVva3RnTHRLUEtPb2NKNmJjMHl5UjFVYVpFTzR3NERL?=
 =?utf-8?B?MlBnbG9acjVqZ21hRFRNZGkrLzFDTGlSZXN5ZTZGcnE4NjhPcmxQay9OYTJz?=
 =?utf-8?B?ckk3SHh2c0UwZTc4a3NxQWxJcVJvM3Uwd1NOZlpNVHU2NzNHQ01PSHMvb2JQ?=
 =?utf-8?B?c00yTGl3R0ZBb3hFTVU5OE5Ra3dwWUJWTTZXYXR4WTlWZ3Bldll5ZW8waU4x?=
 =?utf-8?B?bXE5dnl2YkNoM0tGQ2NsS2gwclZDZC9pM3plUnZ4MW93QnN2VHJ5YjZlcWZX?=
 =?utf-8?B?OEU3ZkVZWmxabjVIUHFLQnZHT0VkRUlEVisraE5PaDQ3TXFXWENkdUdRZEw3?=
 =?utf-8?B?Z041MFFCb2VGL3hFU3hyMllKdUZpQm8rT3kxcHRMVWY2UHBqZTFhZVhuSzlV?=
 =?utf-8?B?WEVjTVM5cWQzN1Y4MHppaFRyZ0RENXlqVXdDa011ZjBhc0Y1R1UxSUZIVUhT?=
 =?utf-8?Q?XImN+sYxmcyqLGfs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <704A5E8F993C4641A313B1F546734AAB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CglcSsguN+IOzmR3Ez3f2SUKogPYHpg79Expf1CrBUg5dAGthM4wxSrjWBSToeuHpgo0yCshDcMdGsidE/VFohbSsUF4T+qVZgKeDRtRfJQOoNvcVcELwIugHKfryfVjT4i3xDmZ9WWFR4qOwB/pfG9gK4GKTZ+AFFlel6bJuG9tFqvyJ215bG1v/8cTdETMpHHXpy00tftFdJj91upLSKMvovsGKHfmONEYUFazvby299Af2aXbtMBQ0dSV2p7AzYjplBu396HcQk6R3I+Hnlytkq+sLGQtfQVwOGGY/Xu16xCyYPDonrdczzx2L0ntf7mcXnGqDWtxRvGECp2M3OY+Qc17zr/mFi/vJoVfgCekejVuuwofefsffTymVQCptisr5CGqPXYNQ6i4WGd5k/JqILRtvSJvsD8JKjsGTszdxBWfQd0I6Ru4vh4Pzk+Sk+BlJuoiB0qIrlSp+IgDu5KbC69YlPFhjUYTuAd56XKXoT7AC21aunTuOCyGzQY1v9//tMZuf3kgAuVqC+w8cJ36azDyTEOykeToNU8FrAPFmMM+olhEiV76VrZfgIBJ6MG3fAO/e2TrODSZ+XWtx8aL8oaq6IG2eEvD1+bixTXC4W/mAWFM7dFHOWL0n/R2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1246ba0e-9ade-44d1-68e3-08de5e49e1af
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 08:47:34.4885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EiatyKd6iRFH/pE1cV/Brd03T7jTQ8olDvC7x+Z0lOHUsDHAUXJTwle1tItvGxzPBRWDR1fKvoqPLLwRjAGZNn9fI3DvlJkhgaA1aJcNvrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8071

T24gMS8yNy8yNiA1OjMwIFBNLCBBbGV4YW5kZXIgR3JhZiB3cm90ZToNCj4gVGhpcyBwYXRjaGVz
IHRoZSBzcGxpdCB2cmluZyBmb3JtYXQsIGJ1dCBkb2VzIG5vdCB0b3VjaCB0aGUgcGFja2VkIG9u
ZS4NCj4gV2hhdCBoYXBwZW5zIGlmIHlvdSBydW4gdGhlIHNhbWUgdGVzdCB3aXRoIHRoZSBwYWNr
ZWQgZm9ybWF0PyBZb3UgY2FuIGRvDQo+IHNvIGJ5IHBhc3NpbmcgInBhY2tlZD1vbiIgYXMgYXJn
dW1lbnQgdG8geW91ciAtZGV2aWNlIHBhcmFtZXRlci4NCg0KVGhpcyBvcGVuZWQgdXAgYSB3aG9s
ZSBuZXcgY2FuIG9mIHdvcm1zLi4uIDooDQoNCg==
