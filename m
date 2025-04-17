Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4AA320F
	for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744880554; cv=fail; b=R0x+XW0qne6qB7PWqqPnqWcVM8nH9lmedGh/LcbNa0T71qO1P4Fn2cVDGS5e3WvHf+K13/g0foF5oa4DmJj072GyptiH8pQ9O93lrKF8JmlGwja/XdXibfjro8fKg8T9YRTBU7ZDYhurx7mhXLYXx3n+9+FpmPg2bv7LrUzBMhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744880554; c=relaxed/simple;
	bh=oCUOdq/5hFAI9XAbOt6eitGtS9Zyh9knnbwZMO1xfiw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=sbTrGmP4lZ5s3oVI0ZnjmpELVLBMVTa825tdQ1OxxKLemNWZYrHHt4Mnp7/NxfpV16ht/FzATy3lp7OHAeEWI2StaEZfHj+a4swo4d/qJR4mp6pBd8UMhTAAtB4HT/6kasrFS/PRuMtYdlM3AD5d41dUZwyN7ZUecjKgJRLf6Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=B8U8KaVy reason="signature verification failed"; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="B8U8KaVy"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H4hWHO027963;
	Thu, 17 Apr 2025 02:02:13 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45yqpjkq1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 02:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFmE36qtfkUkJId63AEvAzWVYo4p4UoPUlK9Nl84hjaWun6Gdh1/rD4CwGuKk2XYWZHIgnrtWDh/2yznQ9W7Y62zWX4jxlorYXCQJWhqIbpuXs+yy775ZbvaMr88uUQLlTuyAfQm9rrFM2JF8LaLpAs+3Hrh/aw92xrV0U1uoOYokfSppNzamvrrnBzHAVH/91pdIG2PfX99F55JqPBKm2Lrb/lCrgg252KASCQYsHQG7JBwhHisUnVj+pIVJXpKb4UlkK2lB3AkQmzCT6XMfacs0nhRGJ3dXhJnvV0HY9F2Rqx/ACuNkF8GstFJANcMdGtN/B05z8C3XeaCLp6OFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/qENP797JX4+No33Au8NESu7d8s5+fYwt2s+aFuQ4k=;
 b=UPYhf8j3mn0NdKRn/6iPbcrHF6fettkFvhXTWFeQMLk4EA921n+oPpnu+YT71w4qpFxw9OSUIxwlHLPqHXA/DoFVGufC5lAVB7rdhBlRfpI70s8GtOCOV6auJrBFTAPLaNad/w2yNNuk/e6AjXm8ryRciMMu3Zv+L8hHep9IPyv5cpp5+oba1QI+aGHpHKVdL6rBIuiAAlqr5owMJWeWnSx/HxxNfJo4O4BNIIc/fp+z6gP2wfyXqemx6THFgf7nP4Q4OYaHhrL2XpHDwYpbYRRvUc4bEWRyl1WaChTgKnluy/vdxyVFjDroaUduaPlw31Rm8DyUWDOpAroLdDsdkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/qENP797JX4+No33Au8NESu7d8s5+fYwt2s+aFuQ4k=;
 b=B8U8KaVyKLw+7Q+9iaOG1k1icbZvf8vH4P/Y5zDEbv55XY7kiemNyAuFOJyubM054SWjYe02/qzqKFhikt3ZaHMEFkNrIu9J7LUe6BfsjXy/iOJhQnclhJRDoxdPcl5V916gytkfrGi4AOQc2vZ3SdNCgK9jq5ij3TGdHfzM+qA=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by BY3PR18MB4643.namprd18.prod.outlook.com (2603:10b6:a03:3c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 09:02:09 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b%6]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 09:02:08 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Philipp Stanner <phasta@kernel.org>, Srujana Challa <schalla@marvell.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>,
        =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?=
	<eperezma@redhat.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Satha Koteswara Rao Kottidi
	<skoteshwar@marvell.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] vdpa/octeon_ep: Use non-hybrid PCI devres API
Thread-Topic: [EXTERNAL] [PATCH] vdpa/octeon_ep: Use non-hybrid PCI devres API
Thread-Index: AQHbr29ELSp8NJgL1kWOf97yfETcxrOnjC/Q
Date: Thu, 17 Apr 2025 09:02:08 +0000
Message-ID:
 <MW4PR18MB5244915E54967510C5356B4DA6BC2@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <20250417080211.19970-2-phasta@kernel.org>
In-Reply-To: <20250417080211.19970-2-phasta@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|BY3PR18MB4643:EE_
x-ms-office365-filtering-correlation-id: 3714b602-ebc3-4e15-c4bb-08dd7d8e8894
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YzJIdlo1NmhSZ2dPYk84aTk0ekNmUjlDTFhzNEs3SGx5eTNWa21ZYk1VS2Zv?=
 =?utf-8?B?WHpKOC92dWp1aHVDVWtlaGgwVHFaYkNzem04dzlqZitYQ1g5aXZWZE9iUEdI?=
 =?utf-8?B?aTF3b0RLQzZZWUhOQ0RnQ0wxZ3YxbzhyUERwS2RQSWNlTjZJVUlxeDIwNmVu?=
 =?utf-8?B?TUZUNlcrRFcwRTdYd0tpMXdsOTQ5blc3c2pMUFBNRERoY1FyVURzYW90UHRu?=
 =?utf-8?B?WElTVkVRZWpBWlBheEtPZTFwTG9qRHhoYWlyMUc5c3dPcTI5cXZSRjVhc2RV?=
 =?utf-8?B?TWc1YU5zalVUWFk2b0xXb280czIvU3lubi8wVFJ2RnpjdTJYZk4xdUdITWt6?=
 =?utf-8?B?L3VneVVLUU92K2ZIT0ZtMGZSaVlhRThNS2ZIRExtN3JqVmZhTEdVZTdiNEM3?=
 =?utf-8?B?QzJ0TThvT1lOVEk0NzZlY0Z2bDBkREVic05RNTZUMmNQZUQvbjNFbDZvdXJV?=
 =?utf-8?B?eHV0cFZNZGsrdk1TWlRRVUdNeTQ2M2p5TGFLTEg1eFBWUGRsUmhqZGZQWWZ0?=
 =?utf-8?B?dHdtMmFwSXN4enR5Z0dHbWpmZExkdGlITVlHTktSRW1QMUhqYTJYeXQyWUk4?=
 =?utf-8?B?TFlXZk1zWkFlUW9UU2tWZEpTczRMUWF3SFV3dHdoN05PT290UldsMldyZzkr?=
 =?utf-8?B?bmFzSWFPSHNWYlllaytFWUFWdzBrd0hHNlFqaUhhYVU1cDdhZmZ2cXFLaXV0?=
 =?utf-8?B?QUhmcWcvOHg4QWJJMXQxbXI5N25BNDYybFV1c0R4SUMydHhNWDhrNFpSR1Rn?=
 =?utf-8?B?bkRKTEJuV2lsQ1c2RDh1Y3BKa0ZsaEFBSjRsWkdWcWYzeGxGNXE0MUM5RGhk?=
 =?utf-8?B?cFNnWGhuTWxuVEVNTkoxemJvNU0xSkVMRnF3dFZEUnZIUk1oeGhkYzFKOUxY?=
 =?utf-8?B?TjNtWUtFbjBzZzVUcTZiNDVCNUxBZWZzMEFwVmlTK2VUVHdGcU9wVkhTTHdh?=
 =?utf-8?B?V2hEdkNTWjV0WTBwWXdjcE9mOUk5Y2VQR29NQ3Y2S2h5S3E1cmZSNDVyRVdR?=
 =?utf-8?B?ZFU5TzJzbVpIWkQ1ckxaQ3gyZm5Ebmp1YUV1NjlNRmtOSzFrQUtwOHdFQXlp?=
 =?utf-8?B?RnIrbFNEUG9qTkxsNkhvN2Q3MGN0UmcxNHZKVldhWkh2bUR6SlRocldXbjJq?=
 =?utf-8?B?TTVLREZWb0I4eWZVS1ByRk9TK05ZSzBFMWl6NWVENitENkQ2dE1JUzRPT0s0?=
 =?utf-8?B?OTFmaWkvMzM0djA3Y1lyMmREaUx0bTlqcHZGOXhTWnJXdVkybXJBWTZwVjRQ?=
 =?utf-8?B?cFNUZEo1NU5OM0JSTWRKN1RTVW9WamZtM21tN1NEczJkenlyREJaaXRuRHFZ?=
 =?utf-8?B?ZVRTTjdFOGROblk1YnRHUG4yRzFWTkZSOEhlL0ZMclc1NzhaenkraTFZcGFF?=
 =?utf-8?B?Z29za2ZCVm9kYklseVkxV1NsWFpMeW8zNVFxcExLR3hPMmdZQnZUUDJDMjdy?=
 =?utf-8?B?bUpSalQrWTcxSG1PODlRMDNhWlZxVWYvSm9Yb3J4U0M0RnVNdkYrMXVTdVlK?=
 =?utf-8?B?c0I4Ui9RMUJGY2RxV0QrNnVBVkpoejlYL3RVc3VJQ3RvVitRQzFUbTlrTkdR?=
 =?utf-8?B?R3MzMlpTTGQ3UytGUmt2YUtpNCt3aDdNVEhLbFdjNGVxV0dZanc2eHJoZUQ2?=
 =?utf-8?B?SjRRMHdrQ3FFOGJyazM2N1VoclhYU1NybW0wUWRsR04rR0o3Y1NtWHhqZGVC?=
 =?utf-8?B?NFkwdkMyNmgrNWNHeXZXN1dhNG1zK1ZHYlNLanIvaXdUVXlKWk1uYm5LUW92?=
 =?utf-8?B?ck9WVDBEb0JkOUhuSGEwR01zaFAycFJiMEUxa25PZGhuVE9nTWtJNHlHMzJU?=
 =?utf-8?B?MHlKcnJyTkpIczNqMHN6anZEMmJPTXZraUpKSmx0SE5nUFdXc29uWWg1cXkz?=
 =?utf-8?B?Vy9JYzMwbFAwNUUwTnlqSHRMUlBuOCsyRWRwemUvc0ZoNXYwY3E1VHgwQTB0?=
 =?utf-8?Q?9EWF6+4Qwjk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVh0TERYZE04cDJad2tlcW5DM1FrUWZjbXdaVXlPUmllMTh0RGhqeU1XcWxh?=
 =?utf-8?B?ek5zU2VYK05CbTF3YjJuZDFTUUxYZWNuWmtvWG40Qzg2eW00bjljb2FMUlc3?=
 =?utf-8?B?Wm5BT0ZTRm1VRWZTWXJBMjJDU082dEdYQUtCREtUcTJseTJIREwrY1ppZlhN?=
 =?utf-8?B?Uy9Bc3Nqc2xoSEFMc1dkUjR3WVNwem4wRHlCUExVSkZ1WDBPbEF4ZlRrbXVO?=
 =?utf-8?B?cHgrWG93emFFSnFuNXdnWElmWXlUY2dJNGQ2VFRta21IN1E2UnoyVWExVlRi?=
 =?utf-8?B?eC84TmUySElxT2hvTDB3ajZHWTZjRDliQkNkbnI3OTIyZEp6SGhrVlhPZmVk?=
 =?utf-8?B?cDhEK003MUNtYzd0cU9FYUJvTWNRaVhWQVYxMThoTHZJYmlGMXJtdXlFeitV?=
 =?utf-8?B?OEZhZUY3WVZJZkZBa0VGbWJxRjRFTWZmUnhtUEFsNWdOM1VxK1NmMmR0bFdv?=
 =?utf-8?B?ZHF3K2d2QVNSeTczazF0SzJsL2Z4b3hMTFRjMXhGUThPcWhVK2ZndkRJQkoy?=
 =?utf-8?B?TlNUcnE2TGZabGxqOExZdlc1M3g2WmN0SVdDVFBmbE5CSm94S09WN1RPS0xX?=
 =?utf-8?B?bnpEOTJVa1QvMytyWVhNTUc1ODUyaGFYUHdRaFlORmdMOWRPY3FMNVp3eWJp?=
 =?utf-8?B?aGlNTHZEaEdsZHZzRVBHNXdCMXplN2MwdzJQNEZENVpDWmllZDhEbVFoUkZT?=
 =?utf-8?B?MzNYTFV1WUNYUXN3QWphV215R093QlZ3eGpGeTRhdmZiN0RCNDQ1UWhhOHJm?=
 =?utf-8?B?eXAvNG41MGNDK2Z0cnFSZlAzOFdsdE5OcEo5akFaUncvUzJLQk8zWSsySFQx?=
 =?utf-8?B?cDc4dndxQjA4NXVuZ2pMQUd2OGJKQnNzSlJKUjlzM2NzY1AreTBQY09aTGgr?=
 =?utf-8?B?NUZyVUI3RXVyTk5sWkpodHk5TW5FcVRQTkpJVTF2V1VyWCtjVTZ4Zk9nblU2?=
 =?utf-8?B?akVlQXJoN0Jnd2VTVStZRlZaL3o5Q0dOUzJ3eGk2WFBqSjE3cktyNU5ZRmd3?=
 =?utf-8?B?K1pjOVF0dEVRY3prUDNHdnJpWDV6eGIzMll5MHA4ZGNYK0tsNEVQUHAzZy9O?=
 =?utf-8?B?VmtaYkdUZkxESGVBOWZHQm1nNENoZWZPMG9nalBxTmcvcXo2KzdWa2NST1hL?=
 =?utf-8?B?dFJTdFVEbjFZZ1VrYXU2VElVZHYyeU9QSzF3bVF1UkFmdzlSRWpNcUJNUjBk?=
 =?utf-8?B?bHVVcG82Y1VoUXQ3V29FQXJIZStid2FMWGhjbDJtdkJ2aFdoQjk2WTBTY2tm?=
 =?utf-8?B?T296NlY3NU1UQ0dMUUxIQ3NybVRlckdkLzZnTWxEbnR1ekdkcWJPWUhGbTZw?=
 =?utf-8?B?TzJaSHNPMzN2OWVzN0p0Wm05ZGFKdjNjV0pIN1BNTW0zYUhDSEVSSzluVUhW?=
 =?utf-8?B?bjh5aHpvdloweTQvcjZtS3IzNC9mOFVxQ3UraTYwZFBlS2dzT2xQNWRTbU1u?=
 =?utf-8?B?a2VuT0lnTEM3NEhsWm5xbW1yaW4yakxZeE9KYkl5TVVKcnRmRzEwbURoWEtF?=
 =?utf-8?B?YzlTcTV3Sll4ODU2ZURNdlVZMTBPbHFrN0FGd0hTaDZGUHJSZkZIR0wzOHFX?=
 =?utf-8?B?c2xGUmhrOWErL1RUYWczUFpTWXdJNE92NUJORE5WVnF4ZGdIWnFNY3QwaDU0?=
 =?utf-8?B?bHZNVUU0RGpDczAzU3BMS1Vkamh6VU0zeW5VWnpKVDRWRmY1S3lPZUhXVzRO?=
 =?utf-8?B?UkNRdFJhYlhoNTNzbDJqMkNCVHpiT1ZrUFJYdWNLZ1ZIcU5peTRMRFVYb0Zk?=
 =?utf-8?B?RnB0bDUzN29qdDV3UHhuZG1HSHA5WjNEZldaeksxTDkxTVptaExIWWdETHhT?=
 =?utf-8?B?QWNkV0F3L3pObmtROEE0YnEzVTV0dmg4L3NLZ2NzWFpNY0s3TmJCWlBVWEdx?=
 =?utf-8?B?QkQ3ZU94N0w5bW9FUDhyLzFYY3BEQzZzREFFa2ZObGdJS3IyekVkODZnTUhE?=
 =?utf-8?B?UnI2YzJ2STU3cEFLK2s4MTlORzhUTFZFYmt0bFVVcXpnS0VSczFXc0w1cWlM?=
 =?utf-8?B?WmJLZEo4NmhLalROSHFTSDdZeWxTeVZpREJDUnRySjlrdklCWDFMd2RhbmpG?=
 =?utf-8?B?c2R5SmlIY2tYMlpZWUYxTmZDSXNEWlQ5MXFaM0trSzhFRlBRYmo4REh2allC?=
 =?utf-8?Q?tMuz/F+KRN1svZxv4j1IutGuh?=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3714b602-ebc3-4e15-c4bb-08dd7d8e8894
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 09:02:08.6552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f/D6swouaKV4oaIsqblY8BNkrvGNx8x5SpA318UdZ41/hytgvwtCS4uqJDkOjaTsk1TWhAXExCJBSBppk6jCLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4643
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: C9_PYOm7CHuffhPu8ssoRGcikfIhepgF
X-Authority-Analysis: v=2.4 cv=ZOvXmW7b c=1 sm=1 tr=0 ts=6800c395 cx=c_pps a=rPWB9DPlu1VaKM/QD/CSBg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=-AAbraWEqlQA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=20KFwNOVAAAA:8 a=SRrdq9N9AAAA:8 a=KKAkSRfTAAAA:8 a=RpNjiQI2AAAA:8 a=Sejk7yUJ_Ez6IWeQFvwA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: C9_PYOm7CHuffhPu8ssoRGcikfIhepgF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_02,2025-04-15_01,2024-11-22_01



>-----Original Message-----
>From: Philipp Stanner <phasta@kernel.org>
>Sent: Thursday, April 17, 2025 1:32 PM
>To: Srujana Challa <schalla@marvell.com>; Vamsi Krishna Attunuru
><vattunuru@marvell.com>; Michael S. Tsirkin <mst@redhat.com>; Jason
>Wang <jasowang@redhat.com>; Xuan Zhuo <xuanzhuo@linux.alibaba.com>;
>Eugenio P=C3=A9rez <eperezma@redhat.com>; Shijith Thotton
><sthotton@marvell.com>; Dan Carpenter <dan.carpenter@linaro.org>;
>Philipp Stanner <phasta@kernel.org>; Satha Koteswara Rao Kottidi
><skoteshwar@marvell.com>
>Cc: virtualization@lists.linux.dev; linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] [PATCH] vdpa/octeon_ep: Use non-hybrid PCI devres
>API
>
>octeon enables its PCI device with pcim_enable_device(). This, implicitly,
>switches the function pci_request_region() into managed mode, where it
>becomes a devres function. The PCI subsystem wants to remove this hybrid
>nature from its interfaces.=20
>octeon enables its PCI device with pcim_enable_device(). This, implicitly,
>switches the function pci_request_region() into managed mode, where it
>becomes a devres function.
>
>The PCI subsystem wants to remove this hybrid nature from its interfaces. =
To
>do so, users of the aforementioned combination of functions must be ported
>to non-hybrid functions.
>
>Moreover, since both functions are already managed in this driver, the cal=
ls to
>pci_release_region() are unnecessary.
>
>Remove the calls to pci_release_region().
>
>Replace the call to sometimes-managed pci_request_region() with one to the
>always-managed pcim_request_region().

Thanks you, Philipps, for the patch. The Octeon EP driver does not use mana=
ged calls for handling resource regions.=20
This is because the PCIe PF function reduces its resources to share them wi=
th its VFs and later restores them to original size
once the VFs are released. Due to this resource sharing requirement, the dr=
iver cannot use the always-managed request
regions calls.

>
>Signed-off-by: Philipp Stanner <phasta@kernel.org>
>---
> drivers/vdpa/octeon_ep/octep_vdpa_main.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
>diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
>b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
>index f3d4dda4e04c..e0da6367661e 100644
>--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
>+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
>@@ -391,7 +391,7 @@ static int octep_iomap_region(struct pci_dev *pdev,
>u8 __iomem **tbl, u8 bar)  {
> 	int ret;
>
>-	ret =3D pci_request_region(pdev, bar, OCTEP_VDPA_DRIVER_NAME);
>+	ret =3D pcim_request_region(pdev, bar, OCTEP_VDPA_DRIVER_NAME);
> 	if (ret) {
> 		dev_err(&pdev->dev, "Failed to request BAR:%u region\n",
>bar);
> 		return ret;
>@@ -400,7 +400,6 @@ static int octep_iomap_region(struct pci_dev *pdev,
>u8 __iomem **tbl, u8 bar)
> 	tbl[bar] =3D pci_iomap(pdev, bar, pci_resource_len(pdev, bar));
> 	if (!tbl[bar]) {
> 		dev_err(&pdev->dev, "Failed to iomap BAR:%u\n", bar);
>-		pci_release_region(pdev, bar);
> 		ret =3D -ENOMEM;
> 	}
>
>@@ -410,7 +409,6 @@ static int octep_iomap_region(struct pci_dev *pdev,
>u8 __iomem **tbl, u8 bar)  static void octep_iounmap_region(struct pci_dev
>*pdev, u8 __iomem **tbl, u8 bar)  {
> 	pci_iounmap(pdev, tbl[bar]);
>-	pci_release_region(pdev, bar);
> }
>
> static void octep_vdpa_pf_bar_shrink(struct octep_pf *octpf)
>--
>2.48.1

