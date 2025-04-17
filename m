Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7B35979
	for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894598; cv=fail; b=MJGkorNJELCPguDX5R2aXGL3fI9HAg0lZePAq9SqV6O+4G9Esu91Nq1B+K+xcDFcRJDcUi5XlBNvMSrJsTjZbsd+oN/RSH7ljyZhSoWiaxX7xUWzlAMMLt4stjzUgsWRF5PT2ooictd/RpxuCMbsbAjc9hk/KbT2Snck+6+yFBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894598; c=relaxed/simple;
	bh=VDnyBIEvZiPzNrF7Nw7RJfLemt7SFQ7AouUaFQYjLVE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=OsHDDHndMQH1D386JKIeEENlqyxdAVceFuVmXirEwcq667X/5TBzk2MNeagySY5Yp4q59WmXYD/ykX/d2waW2z1MIiC90WicWmrWQz8QPuhVmS3VbUUh9D6HUHLNeFp9+ptEVYuKWb0GyM0XDjZJLO3EdVC9MZLQc6dW9GY1vbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=OsimisQE reason="signature verification failed"; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="OsimisQE"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HArWif006042;
	Thu, 17 Apr 2025 05:56:19 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45yqpjm28r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 05:56:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPaL8YT13w2/XaC6CsUWu1cFJMA1pOzYxZf7CDkkZVnuuVMeiCcnKDQUJ9fgeeTPw9/LU4Nmgpzh0Jsg1tZdNEWuT0r4ddCxoC5aAZ8QQq8MUP2oZp1WlNArx+iT5elyb2yV3PrIwr5SDFQTeCOmtpDIHybl33mTROr5SLTQfn4iOuvVx/yNW1zPf1aTJ9kQVVLVm0jrrOMwxUbtZefxOw+ic9Cx4vB8Id+iemOyM4Yz7k1TxEB19QNnSnHnlgqucqr9k9JEns/8lC/Je6rJa5JWY8OGoSBIpyLMzYxWZZBEPbDrv7758hcCYOZ0wBaoxyxu33xg3cWozeU1Cz53Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lkUaD4gAA8aWkqLLNiUCBaBQays5CQdhips4q6JkqE=;
 b=PRKdp7cd+Na/sJ3GtrbS8GJbmdmlMjUuPM+Ti+p3bSYCxy/l6WuT/em1qnc8PA8Ru2w4KX3OXnCiqepAWIEX70HsnywaK85X2sOFaEkm2VYjPTjchUrGgrB4N7D8IiCnw85kQ/3s1gBNp4dx7+E4X6juBzzDNgSEhXFzoLu3F5FPGtLext6cc4iu7AEpEcwA5+7JCCQsA6nJ+wzyGmlPF2BojmP+XQbueosV/i2ArbBzYhpwFEz9Y54vvm9xL9bZ2SmB2YTkk4HWwK0JRzboDQ/hLyBwtN+Uw1ez+7vbpO0q00mCLrZf0/1+k72/9Lbp1Z5jls1WsyFkQFAPGYGwYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lkUaD4gAA8aWkqLLNiUCBaBQays5CQdhips4q6JkqE=;
 b=OsimisQEn1UkEcywYyMj2KU6MngNRUpOPU4vPq6x0jg7LHSBS7hqZVvhteVvbpSIxUTi15NblOBlo7ljbN8HCm9fYBA6AX2PlYjIqOAbAgG/SttV09ruGqfS6lEXYAzu3UGfT0eOWcaDwxCNsFrRVEUoN9LMXYHUsDd6XxlEuBQ=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by DM6PR18MB3505.namprd18.prod.outlook.com (2603:10b6:5:28e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 12:56:14 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b%6]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 12:56:14 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: "phasta@kernel.org" <phasta@kernel.org>,
        Srujana Challa
	<schalla@marvell.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang
	<jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>,
        Shijith Thotton
	<sthotton@marvell.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] vdpa/octeon_ep: Use non-hybrid PCI devres API
Thread-Topic: [EXTERNAL] [PATCH] vdpa/octeon_ep: Use non-hybrid PCI devres API
Thread-Index: AQHbr29ELSp8NJgL1kWOf97yfETcxrOnjC/QgAAe0YCAACGnMA==
Date: Thu, 17 Apr 2025 12:56:14 +0000
Message-ID:
 <MW4PR18MB5244B9A5E105A514BB3D5272A6BC2@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <20250417080211.19970-2-phasta@kernel.org>
	 <MW4PR18MB5244915E54967510C5356B4DA6BC2@MW4PR18MB5244.namprd18.prod.outlook.com>
 <a57d5f6f47ec8ba2860df853aca324e96320eba5.camel@mailbox.org>
In-Reply-To: <a57d5f6f47ec8ba2860df853aca324e96320eba5.camel@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|DM6PR18MB3505:EE_
x-ms-office365-filtering-correlation-id: fd5e2db9-7463-42d8-90b7-08dd7daf3c93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UU1SWlRDbzlyNkJkM3dhNXZ1dXc4TEVRaVI0ZTZsVXl6NW42L1ZSRGY1a2JI?=
 =?utf-8?B?dlFwMTl0WURDdkdkNnZSYzJVNnJKMExpTEF4Z3I2RkRHaVlsVUVNNnJaMU44?=
 =?utf-8?B?WDJUM0lCa2lmek8zMlZKUWZRWjR3cnFwWklSamRoNmJvYWhwVlo2dnA5Q2ZX?=
 =?utf-8?B?YjRBcXg0QTA3bTcvK0lXODlPV2NhTW1CSmdzcnkvNSsxazFuc1dPNWFmbWpm?=
 =?utf-8?B?Yi94bGVVZFVvNVIxWXdUczBLRElORC9nRnJMd3ordWdRUmFUaEhmYzFqK0U5?=
 =?utf-8?B?OXVGaGM3eUxremlTNUQwSEMyekZUdnovcExMQ2xXZnV3TkxqMHZUdUpyY0ZJ?=
 =?utf-8?B?ekF6Q3ppNUt5Z0NObXFEb1g0NmowaU1GbXhEaHRIVWMrRHNYVlJOSFRxRXdS?=
 =?utf-8?B?dFRCTGN2NGhrOXVrOS9MV0VKczdoMWEvemo4NjV6WjdqSDBZL3RrbUJVNnpt?=
 =?utf-8?B?Zi9YMzFNZjU5Ykt6aWxoalBURWUySUgxdDJwMUVXUXZVQkxYSWtUQ3NBUDhT?=
 =?utf-8?B?SFk2cjg2MHBPSDBVY3JjRmcyc2J5eDAxKzhnL3gwWTl2MFMwdFdiYmZRK1hq?=
 =?utf-8?B?WTN6NjhaRHVCVDFvaVppcjhRcjNPdURMWVdsMWMwcDRKbmRTeXNQM2ErWnpl?=
 =?utf-8?B?ai9MSVFjOGlHRkJFa2VpNWIrcC8vcmtpaFJCbTlaajlXTmptdnUzdzEzWjRI?=
 =?utf-8?B?VkdxZWY3WDUwdUJZV3BNeExjeXNTSHY1NE03SlVvR2ptZDBDejJraUt6SEsy?=
 =?utf-8?B?a3NqL0hGUzd6cUpiaGRDRnpDVm9YYmF5RThtZkJleW9DSmRYbUlhWEFnSStC?=
 =?utf-8?B?WnQwQjN3Y05YWXdiYnpyVjZWRENwV0IxWkpkdC9vUDRtM016Z2JDQ0Q4TFgz?=
 =?utf-8?B?RS9HQ1pYdERva0dOYzYvem1wenp5WE9WeUtSVlBmYVNrSlZ0TldNa2lpaENn?=
 =?utf-8?B?cGt3Qk1mVU5uRGVGNm1odGVsOVc4dHk3UWRNeGl5UFl6YUY2cUZHRm05RnJt?=
 =?utf-8?B?ZTVqTWdld3A1SzZ4enpBekxwUHdRRnZmSEJQbld0a0krZDNKZ01JMmVPRkRs?=
 =?utf-8?B?dWx1YmRXWTJhZEUrcEQwL0cyblN3aXkybWprU3YzTXVyT0VORERBOThSSWtD?=
 =?utf-8?B?V2NBZVpEOXNIUGlVTmZiUlp3NkZWNTgxSlBJbTdMTHpJdEIvS044VFUvSWNX?=
 =?utf-8?B?Q0JYS0xZSm1abGNTZ3g2SkRSSWZlS0NEMzJYaFVoNUF6UlJRZW5CemFVNTdw?=
 =?utf-8?B?QUErRENNWFFsemZqcnlZWDRPcy92blNTbzdqL3BCQTh1dCtrMHBOTUEvenlu?=
 =?utf-8?B?SktyVjhXbmxHaWdrQWV0RnBQa1FXVk82enl2Q1R3c045KzJvbkMzT2tWam93?=
 =?utf-8?B?dWYxYUVLY1EwbE1USy9uMUxXTGNJUjY4Uksyc3psZ3BpK1RkZFVOY3IzK2lL?=
 =?utf-8?B?M1pYZnVmS2k2NkxRbGpVTWRrSkhrSHBhV0VnMVpiR0RyNGNUcFVGRFluMjFB?=
 =?utf-8?B?L1lQdGppNy9tSDh1bjZ3S0VMbkxYaXp6WEx6UkhFTXRLdnJNdlFrZ25TY2NO?=
 =?utf-8?B?blpOU0k0MmV5N3lRSFkxNnU0NzVKRWk4Zk1PdVVTaitlalEveHVKdmhVRmVB?=
 =?utf-8?B?UGtkbmIyZjVuL0c0Uzh6NStLN0x3T1VJSzZzN29vSUJobXR4Rk9NK0dtUUpW?=
 =?utf-8?B?Q3N1UGxXLytQVXJPcFdWbWFTUWNuTVQ0SWNYZWQwbGRmVkV4SkMzQ3dRQytQ?=
 =?utf-8?B?OEp1TklhS2YySlRCcEU1QldNN256dkZ4MkFyOHJkcGpJd2NHUmd2TlFyZHhl?=
 =?utf-8?B?OGQzZ0VKVGVvYTZtelY5ODcwOGNCaHFCYlNTT0toZ2Z3WnJJNHJSSkw0MkF0?=
 =?utf-8?B?bndMZFlvdmdjYWMyR0tOWjJiQjArSnozQnA3b2o3K3IwSTcyYUovZkV0WE54?=
 =?utf-8?Q?6M24wId7lkk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anNkZ0RwNGFrTlpJVWlqMXdEamlrRW40eUJhbTdXaUxuOG1aNVpKSDJTa25G?=
 =?utf-8?B?Zkowd0F5a01mTjZ0dWpGUDhwWU1hSG5mQVpJOVEyZFUyRkFKbUF6QS9HVWVk?=
 =?utf-8?B?TEc3T2M3UERrTGlMZFFIcHppbXlydHlKVFgwQ3o4YW0wUGNpdGZyRVNxdFRJ?=
 =?utf-8?B?SW8vZ2Q4ekZLc25SQ3M4TjFiVDRMRkQ5bVhHRm1mM3lYNUVFNDZxR2NEZzhS?=
 =?utf-8?B?eE9nUW01ZG9KczZmbS8yM3hvSW9ISlJUdWM2amdIai82OW1TS3Y1ZEZLeWky?=
 =?utf-8?B?NjJHNjRPMXBKQll4T1JhM3I3ejBDdEhZaCt3SWZRNks0OTVZRHRlYWdTamZ4?=
 =?utf-8?B?eDhIZW9hdm1mM05IV1RQeFFiQUVGL1pHVVU3ck5lM216KzArdU1VcHFka205?=
 =?utf-8?B?OTZ3c2sxeWZiOTVPWmIwalRXWUk0aTAyUksvUGRvQjJ2OUZDbVRyY0h3Mi84?=
 =?utf-8?B?bDBHZVpubDdFdVpwcFJScXd1bUlIL1Y4WkhjYnZsY01GS1gxVWdEZXNKZGRI?=
 =?utf-8?B?S2Z0clZ0S1JxVDBzWUtueDEzY0dENWtTQzJTbmhwd3dhY1FWNVhyTUczRDlT?=
 =?utf-8?B?RU9sclQxSVlWNzQyek42WjdjdFNiMDFnYlg4SVcrczN5ZDdsNVg0bEFNU2g3?=
 =?utf-8?B?UzRHZmovRDJBWGRFczhjUGpwSnRVajZycEcxb2dhYTZObTBZMnFYMmRYSXdh?=
 =?utf-8?B?WmNzWUdNT0l4TlNqNmVTYXlLS2FwT3N6eXBud0VPYytjSDd5Q1ZBUURDZHJq?=
 =?utf-8?B?WWh2WVRQZnBmQ3pEbjVkZFZVQ3loN3ZST2ExSTBwc0JXTmJZMmFsRDYrWUZX?=
 =?utf-8?B?VWRsK3U5ZndMeHBGdlhHTFlSbERCNUVLUFNRVzI2LzFPNmtKMDZFUUIyOU1k?=
 =?utf-8?B?d29OMWtSeUkyVktjc2c1M1E2eWFzcThPNkpVcnlSUVN5T2hoYU16ZndDTXpK?=
 =?utf-8?B?clo0Qmg0d3lBeERiZERvbmM0WjZkd2VFOVFxekxOOEFaN0p1dzljN1Zkbm4y?=
 =?utf-8?B?YzUyWTFXU2VLcjloaUhHdFBxMmhxTGcweTVieHlPRTErQjQwRlBHdERDQTR5?=
 =?utf-8?B?UWltbU5sdURENEpKN0YzZ2xyTmV4eGo1NXdZU1JxUk9mUlBoVVovT21DS3Jh?=
 =?utf-8?B?dXRUS0VyMFdTMTR2U3NLM0tWZDdjeXBzU0gwMlFqQUhvMmhvRW4ralJzL0Mw?=
 =?utf-8?B?dTY2Tm5GTElrQ0xzdUxJZlNEcHYyb3dxVFBFV1Brd2M3ek4rZGNzL2s2RW1o?=
 =?utf-8?B?TllaRXZGU0dTQngrTTRxaVJHMHNta0N0Q3Q1WXl4R0s5NnRzODJ0NFZDSzNR?=
 =?utf-8?B?SlZnSmZTOThXeEUrRUx6dVlYZDR3aFZ6NGhZVzlTSzJGd0hxdkpRZTRFS1RL?=
 =?utf-8?B?SmluZnladVJ3cjN1VmxuMXFGWENxMzJid1JHeGUvUUtxNWgySkJITGlsdmhw?=
 =?utf-8?B?Qko2Q1RidWduUVl3eHM5NmczcHRDd1BIRnUzM2RreHB1NElERzQ2T0poYldL?=
 =?utf-8?B?YjlxYnFDV3lYb01NaVZVaThxMUhGNWorZFhYS0Z5WGlGd3RiRnNwSTdicERM?=
 =?utf-8?B?MENpb0FrVlJjeHJIMDdSbjdZL3hYZHI5c01YRzBpSkR4d201VzEzd3puVjN1?=
 =?utf-8?B?OG9EellVNkN0OEpnQ0VMZHJDS0xSZDJZeHJGNUdtNExEZCs2TGlpbzZ0YmNG?=
 =?utf-8?B?dDgxdFZmSzFUdHliUUdvRlZJeTVid3VDUkJBNzVyYllTdXBVVERaSm9Sb2ww?=
 =?utf-8?B?OExjaVg0d1VCRXJSOVJ0Z0Z5eEVRYnkyaDZGalIrOSswclVzaHREaHRGOUdY?=
 =?utf-8?B?T25xTWtIUFdFcE4wSjlya2RZblVQSVFrblNMcW8zRmM0cXNlQ09SRk9OVE14?=
 =?utf-8?B?K1RZUXJBYUlmN25sWGo1QUw0UDBOV1YxRkw0RWRPZWNtU1ErMVBjWnpEWm9i?=
 =?utf-8?B?bTBwRWFqN1UrQ3E5U09uZFEyZ2pSMEJDTng3Yys2Q0lzUXVUNWpJVmovc0pU?=
 =?utf-8?B?RU93TnliN1BzMW5aMWlSMUxTd1lhUC9zMXdIRWRDdjlmQkZkdi82RUJuZUI0?=
 =?utf-8?B?RkV3SW1CUktLL0pXOXY3UzhCd093cWwwd1pYMG5mMCsrcTNBVlpMTjNsTlIw?=
 =?utf-8?Q?ZwymjEA75rYF5DmSPS99pTRpM?=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5e2db9-7463-42d8-90b7-08dd7daf3c93
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 12:56:14.4958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /GONZZkGC7xb9ZXm7J+QgeIyrmBNsJ/HBSAup5WkaDF4zcCzXNBF2eQBedWhVGkNGllQjFcpoOvG5zy0iMnZqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3505
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: L8wfp5tmdk1Py0Sl9BkiaaLqcifMpBYU
X-Authority-Analysis: v=2.4 cv=ZOvXmW7b c=1 sm=1 tr=0 ts=6800fa73 cx=c_pps a=fpyyTn7Kx2iM0+fj1eipXw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=-AAbraWEqlQA:10 a=b3CbU_ItAAAA:8 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=SRrdq9N9AAAA:8 a=KKAkSRfTAAAA:8 a=RpNjiQI2AAAA:8 a=_LJuURw_w5ljwYwsAHIA:9 a=QEXdDO2ut3YA:10 a=Rv2g8BkzVjQTVhhssdqe:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: L8wfp5tmdk1Py0Sl9BkiaaLqcifMpBYU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-17_01,2024-11-22_01



>-----Original Message-----
>From: Philipp Stanner <phasta@mailbox.org>
>Sent: Thursday, April 17, 2025 4:09 PM
>To: Vamsi Krishna Attunuru <vattunuru@marvell.com>; Philipp Stanner
><phasta@kernel.org>; Srujana Challa <schalla@marvell.com>; Michael S.
>Tsirkin <mst@redhat.com>; Jason Wang <jasowang@redhat.com>; Xuan
>Zhuo <xuanzhuo@linux.alibaba.com>; Eugenio P=C3=A9rez
><eperezma@redhat.com>; Shijith Thotton <sthotton@marvell.com>; Dan
>Carpenter <dan.carpenter@linaro.org>; Satha Koteswara Rao Kottidi
><skoteshwar@marvell.com>
>Cc: virtualization@lists.linux.dev; linux-kernel@vger.kernel.org
>Subject: Re: [EXTERNAL] [PATCH] vdpa/octeon_ep: Use non-hybrid PCI
>devres API
>
>On Thu, 2025-04-17 at 09:=E2=80=8A02 +0000, Vamsi Krishna Attunuru wrote: =
> > > > -----
>Original Message----- > > From: Philipp Stanner <phasta@=E2=80=8Akernel.=
=E2=80=8Aorg> > >
>Sent: Thursday, April 17, 2025 1:=E2=80=8A32 PM > > To: Srujana
>
>On Thu, 2025-04-17 at 09:02 +0000, Vamsi Krishna Attunuru wrote:
>>
>>
>> > -----Original Message-----
>> > From: Philipp Stanner <phasta@kernel.org>
>> > Sent: Thursday, April 17, 2025 1:32 PM
>> > To: Srujana Challa <schalla@marvell.com>; Vamsi Krishna Attunuru
>> > <vattunuru@marvell.com>; Michael S. Tsirkin <mst@redhat.com>; Jason
>> > Wang <jasowang@redhat.com>; Xuan Zhuo
><xuanzhuo@linux.alibaba.com>;
>> > Eugenio P=C3=A9rez <eperezma@redhat.com>; Shijith Thotton
>> > <sthotton@marvell.com>; Dan Carpenter <dan.carpenter@linaro.org>;
>> > Philipp Stanner <phasta@kernel.org>; Satha Koteswara Rao Kottidi
>> > <skoteshwar@marvell.com>
>> > Cc: virtualization@lists.linux.dev; linux-kernel@vger.kernel.org
>> > Subject: [EXTERNAL] [PATCH] vdpa/octeon_ep: Use non-hybrid PCI
>> > devres API
>> >
>> > octeon enables its PCI device with pcim_enable_device(). This,
>> > implicitly, switches the function pci_request_region() into managed
>> > mode, where it becomes a devres function. The PCI subsystem wants to
>> > remove this hybrid nature from its interfaces.
>> > octeon enables its PCI device with pcim_enable_device(). This,
>> > implicitly, switches the function pci_request_region() into managed
>> > mode, where it becomes a devres function.
>> >
>> > The PCI subsystem wants to remove this hybrid nature from its
>> > interfaces. To do so, users of the aforementioned combination of
>> > functions must be ported to non-hybrid functions.
>> >
>> > Moreover, since both functions are already managed in this driver,
>> > the calls to
>> > pci_release_region() are unnecessary.
>> >
>> > Remove the calls to pci_release_region().
>> >
>> > Replace the call to sometimes-managed pci_request_region() with one
>> > to the always-managed pcim_request_region().
>>
>
>Hi,
>
>> Thanks you, Philipps, for the patch. The Octeon EP driver does not use
>> managed calls for handling resource regions.
>> This is because the PCIe PF function reduces its resources to share
>> them with its VFs and later restores them to original size once the
>> VFs are released. Due to this resource sharing requirement, the driver
>> cannot use the always-managed request regions calls.
>
>so this would mean that the driver is already broken.
>pci_request_region() in your driver is always-managed since you call
>pcim_enable_device(). Or am I missing something?

Driver is not actually broken. Yes, pci_request_region is always managed in=
 the driver due to pcim_enable_device().
But inside pcim_request_region(), res->type is considered as PCIM_ADDR_DEVR=
ES_TYPE_REGION and
pcim_addr_resource_release() releases entire bar. Whereas my driver needs t=
ype=3DPCIM_ADDR_DEVRES_TYPE_MAPPING
so that pci_iounmap() get called. If I use this patch, driver reload was fa=
iling for VF devices with below errors

[90662.789921] octep_vdpa 0000:17:02.0: BAR 4: can't reserve [mem 0x207ff00=
00000-0x207ff07fffff 64bit pref]
[90662.789922] octep_vdpa 0000:17:02.0: Failed to request BAR:4 region

As you suggested below, I prefer to have non-managed version (use pci_reque=
st_region()) and explicit remove() at required
places for now.

>
>The only way for you to, currently, have non-managed versions is by using
>pci_enable_device() instead and then doing pci_disable_device() manually in
>remove() and the other appropriate places.
>
>This patch should not change behavior in any way.
>
>If you're sure that having no management is not a problem, then we could
>simply drop this patch and I later remove the hybrid feature from PCI. Then
>your call to pci_request_region() will become unmanaged, even if you keep
>the pcim_enable_device().
>
>Tell me if you have a preference.
>
>P.
>
>>
>> >
>> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
>> > ---
>> > drivers/vdpa/octeon_ep/octep_vdpa_main.c | 4 +---
>> > 1 file changed, 1 insertion(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
>> > b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
>> > index f3d4dda4e04c..e0da6367661e 100644
>> > --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
>> > +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
>> > @@ -391,7 +391,7 @@ static int octep_iomap_region(struct pci_dev
>> > *pdev,
>> > u8 __iomem **tbl, u8 bar)  {
>> > 	int ret;
>> >
>> > -	ret =3D pci_request_region(pdev, bar,
>> > OCTEP_VDPA_DRIVER_NAME);
>> > +	ret =3D pcim_request_region(pdev, bar,
>> > OCTEP_VDPA_DRIVER_NAME);
>> > 	if (ret) {
>> > 		dev_err(&pdev->dev, "Failed to request BAR:%u region\n",
>bar);
>> > 		return ret;
>> > @@ -400,7 +400,6 @@ static int octep_iomap_region(struct pci_dev
>> > *pdev,
>> > u8 __iomem **tbl, u8 bar)
>> > 	tbl[bar] =3D pci_iomap(pdev, bar, pci_resource_len(pdev, bar));
>> > 	if (!tbl[bar]) {
>> > 		dev_err(&pdev->dev, "Failed to iomap BAR:%u\n", bar);
>> > -		pci_release_region(pdev, bar);
>> > 		ret =3D -ENOMEM;
>> > 	}
>> >
>> > @@ -410,7 +409,6 @@ static int octep_iomap_region(struct pci_dev
>> > *pdev,
>> > u8 __iomem **tbl, u8 bar)  static void octep_iounmap_region(struct
>> > pci_dev *pdev, u8 __iomem **tbl, u8 bar)  {
>> > 	pci_iounmap(pdev, tbl[bar]);
>> > -	pci_release_region(pdev, bar);
>> > }
>> >
>> > static void octep_vdpa_pf_bar_shrink(struct octep_pf *octpf)
>> > --
>> > 2.48.1
>>

