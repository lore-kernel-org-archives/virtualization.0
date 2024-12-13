Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1B518A6A3
	for <virtualization@lists.linux.dev>; Fri, 13 Dec 2024 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086726; cv=fail; b=PhcpswJ0wzEuqik884uEm9PmMe2zpQI4VkNbJ4d+aZbjUTKh+BKdUpCmdyPxpTACMT3VQTJOZ2YoYXQa+Fuyh/jeL7ebgPIu+Lcrk8pu4eB/IryDdsicTBQ3zP6Q8bTNrlgAD7BZzUbxZHgB7oZ6yiAmYu8MVcx5fPsDeSO+i68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086726; c=relaxed/simple;
	bh=qx7Qp0Ri8+YS7SIQWk1FlsQtlyB6hX+1+Xwv3cHLtjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OnebPTmnfPwH5xm0MYEY+LY1z/t4PlBUdcDSLxZNNXSY/MkVBA9Yb013PYBRLiLJFRdf2YuMwaKUcNMiDJB7NbVVnJs6aT/5uNNk566Lry+HRVHYgp0jbzIfzNl6nSocWORbx59lHdxWof/hmtdvjUvicfrVX6/qAkn6LKSyLdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=bRSKBncj; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="bRSKBncj"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD92c3O030037;
	Fri, 13 Dec 2024 02:45:18 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43ghxsg59d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 02:45:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrnrIJK9wlpSor7UcmkHNY4XQF0cVztrgR74wdwjfW+Junt6NiPMYq1k983b38ukHdTSR2I8F70hlAh1tcLJ1fTJ75ccZ2wzysN6Db7ioAZCB4Tg4x/ZFrp09av2MlVz788sfLhALdWBMM+iBBaalYDNoY+EItGObAJaiNu0SyHvUKjTE/+EQsGuruuG9oNnjLYb/L7O91X4JWtW5Tc5qYJMEpCFMzdYCS0k+YBt2kCRvTREd8pJmk5WDJNwI75Y5DKhzzXvFAi0I7TF4IRky4Df8r5M/BbZwBL+MjelYfhbeaioz/HcfdjrM7i/QVFN7HkGLFoTEKsaSxpiIxmj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qx7Qp0Ri8+YS7SIQWk1FlsQtlyB6hX+1+Xwv3cHLtjs=;
 b=psLfiZHU4IwcGHickiS3c92Z3PGiARNHzcM8Ayeba4H9p2UYUFnfDnt76O8ii+2mvfQgW8RoQ0bQDpQjF9e8hzqSRfdjvsyL1SpRsJimQ+TFK0kGorIq9n9yfzBoP5Gr+ZVxfCTSzBpGnCkRUYbkWUNEXxqL80xoyHsBMkPrjPK6NQjKOPKqNryzkUTXY7XxQVkK/M3e5jGJrs0/h8kxYuCVNZqcwSgbTOVWH3PPywSzgPyxbO49WtYYCVTN0QpXcOw7U8bR73DOiKIUll/E1BACuCWjA9r98snceHtB8iBG0n58JZt49GIMmQtcVtcCURfxE4FOEw0RBu0Yfjsu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx7Qp0Ri8+YS7SIQWk1FlsQtlyB6hX+1+Xwv3cHLtjs=;
 b=bRSKBncjUBi0CpmNoV0D7oLyYzFCQ2Nvp5QbOfNfjbse812p3viI+1ZoYRAEmrqerjz/Lv/uGZZirx8NIuPhqitPNwgUJeyBg9wpOJ8TsaawNMa0LUH1AA0wHSGPc4AcVKIg3A+lLs+ZhK09m28tpnJUA5Hf6bwcueZJKKuv9nI=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by IA3PR18MB6335.namprd18.prod.outlook.com (2603:10b6:208:527::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 10:45:15 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 10:45:15 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: Jason Wang <jasowang@redhat.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "mst@redhat.com" <mst@redhat.com>,
        "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>,
        Srujana Challa <schalla@marvell.com>,
        Vamsi
 Krishna Attunuru <vattunuru@marvell.com>,
        Nithin Kumar Dabilpuram
	<ndabilpuram@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>,
        =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?=
	<eperezma@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] virtio-pci: define type and header for PCI vendor
 data
Thread-Topic: [PATCH v3 3/4] virtio-pci: define type and header for PCI vendor
 data
Thread-Index: AQHbTUwY5/KXTbqgBUm4BxZr1oMWcg==
Date: Fri, 13 Dec 2024 10:45:15 +0000
Message-ID:
 <PH0PR18MB4425CF73641F3C1DDBDF96C7D9382@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20241209151427.3720026-1-sthotton@marvell.com>
 <20241209151427.3720026-3-sthotton@marvell.com>
 <CACGkMEsmU4LjUzKFfyoY1ao8pRCETHRqPM3X8uK9KO-TCN8Trg@mail.gmail.com>
In-Reply-To:
 <CACGkMEsmU4LjUzKFfyoY1ao8pRCETHRqPM3X8uK9KO-TCN8Trg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|IA3PR18MB6335:EE_
x-ms-office365-filtering-correlation-id: 6d04502c-c604-4278-4b2b-08dd1b633aca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V3R0WVN6U0IrODdjQVdJQXBsUkZRVDVvQWFBQlhzSnJidG0xTUdvcE54SkE4?=
 =?utf-8?B?cUU0Q1hTek9XcmFFRm1zcXl0RC9pL3ZPMTZQeEx0emJLa3krSC9TdGNtUi94?=
 =?utf-8?B?eFZ4ME9qT0ZLUTVaenlmdndMNW9RaG1vT28xVVhNbGNkNjZCNlRUQ1IvUGJN?=
 =?utf-8?B?YklMb0VGUW9LUWFYSlhTNFZUQXNKSG1XTEU2S1BxQ2h4SnRKeWZLWUNoeVN1?=
 =?utf-8?B?eU1pMTNUREIxV0Z2bVBMK1VjV0dZRkxxaXpGd1BEWkc4aHJZRUE0cHdpRFNr?=
 =?utf-8?B?d0tZVmJwNEFYY29rNmZRZUxOcmhqcTFwbHMyQ3ByWEdTZUFScHZQN2V1ZFZK?=
 =?utf-8?B?OEprUjFmQjdFNGpuMzdGOHNzT1hpUXhWKzNQcEVhdXFJU21JdjAvMzUvSllQ?=
 =?utf-8?B?SmhXaVFuRklwa0UvOXZKbEtwdFRKUkNLK0lmakUrRnlHSEVrQ3BZaUY2d1R1?=
 =?utf-8?B?dDNCRnFYNm93KzBxaWpoVzVaQ21XMSt4M3VxejM4OER4SUptY2NPMlRkbUFo?=
 =?utf-8?B?VjVabzlVRE50djFhejJSajVCeGdocit2ZFlHUHVtRTVJWXRNQ2I2dHBFWTBU?=
 =?utf-8?B?QXhnQU9OMXk2NUQ4ZmpaQzh4c3BPdGt0S09sKzdwT21zYjNra3BlOUFnRDVn?=
 =?utf-8?B?TlhseGhWdkg0MUo2bHFKRzVaUGVSM2tjUjJiMUNIeW9PWmcyMzVneFF5dFVW?=
 =?utf-8?B?S2o5a3piVTk2UEo2NTRsMzlaVk9rOENnMkJHQXBXdEh1eFpSdXNjOWh2S0x4?=
 =?utf-8?B?Ym1FUkpoNW9ZRDZCeVg0TUswbHNDdVU1MkhEU09TQUNWQUdhWFpYb0Q1Z09w?=
 =?utf-8?B?YXprUVBsYUFTR2Y5U21JN0Vvb0dReVVXWDVpa3RCU2pGU0JPbkJaaWFUT2V6?=
 =?utf-8?B?YlVsalVkTG1hZDVObmp6MkFjWm9PWDBhNkpKMTFsemFlZUQ2K2FXdThDUFVG?=
 =?utf-8?B?ZER1VkhvWStwRGg0SU8zMjRGUEZHeWNSMmtuQ2FiekVjWSt2RGdDcUVXTkdy?=
 =?utf-8?B?dHU0WDlxL2w3SGlLdmlwYTRudHM3R1pFK3YwY1RRWFhHbUtmZmw2OU95enQz?=
 =?utf-8?B?ZXg2SWVGY2UxYmVvRkM1a3V6SDVWcVJGdWFzd3lHblc4Y25EM0VqZVNYWDFt?=
 =?utf-8?B?Mnlpc1RkY2kyQktlYzhWUWRqVitBYUh3b01iNUNJRWJWUzlRRXhHdXR5aGxE?=
 =?utf-8?B?bExWMVYvYTkxanRDdjI2Z1kxNkRseGJGbU51K25wZ0tSWjF2eHUvOVVFdlpi?=
 =?utf-8?B?a3NxN2pVRGo0dmovU2JDVUxBdEMvVERXZnFsMUN5MmhCT2NmK2t0WnREQjcy?=
 =?utf-8?B?eGlLWWZzeDljWmhOSnZ3cXNNUVdoQVhWSFdTYWV6dFY0T28vVUxrN3BlOUY0?=
 =?utf-8?B?Q01nSG5lU0VJZU5KVW5WRWZTQ2hjdVo4TUxZWGlZNjcwTFVOcE1yRzdWNnhP?=
 =?utf-8?B?MTVmcktYdnduTXFlaENnek1LbHZUUHNZdzZJLzdRK2RyTURzZXFXZ2w5M0ox?=
 =?utf-8?B?N2JYMEhDWTFtYVRNYjdmQkVZZTVEdi9ETVZINE9iNURKMFNlSEcwVW5Jamtz?=
 =?utf-8?B?bExhMC9OaU8vbGdxODhscFdGdVlhYWJZMVdIT1ZiSFB3cFl5QkpEeE13VDA4?=
 =?utf-8?B?TW9tVlhQdUNYWVNiQXVXZDI3M0JWMFUzNFlWN2EvdzlRMlFvOTMwUk5HbFFn?=
 =?utf-8?B?K2hzZjRScmJHSXdoYVUrRDZ0a1hMa0FFbkNDSC9Sb2ZGN1VndWp2NzBPKzJP?=
 =?utf-8?B?VnBCdG1tdnhpd3lNK1AvMTl5Tm85SndFUCs1S05aR1hqcXRaQlpUVlZlTS9R?=
 =?utf-8?B?c3pQQkpMaGJseFBHZlQ5aWp3VkY5WTZEQ1B4QlFUa09MZXhmdnp4eGtKOGFL?=
 =?utf-8?B?Mk15TzgwbmlJQWEvMXQyMnU1TTFIVWY1K3BsalhmeFBCc0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cTBUdDNML3pxaVdhb2NoeWI5dkVrZldrdlY3dW5FN0ZQaldMTVIyamhqUkVu?=
 =?utf-8?B?dUIrcktyVFFKSDZwQlc0c29zc0RLdmNudjh1cjEzSERPaXBzeWVoOFVBNkI4?=
 =?utf-8?B?ZWFwaHl4TDBGYkhFN053UUZDMGZleG5VVHlnblUyVTBQYWcrdUU2ZUxvalp2?=
 =?utf-8?B?a3ZNZUhqWi9kVlRNa08yZk9tam9aUG1CNEZqQ2hPSUpBNXRPN2VDWklVSytM?=
 =?utf-8?B?bFV5SnJFdjdOb1BsSHdjUG40Y0xuL0JNdGExTStqSGRUcmpGZlNsR1M0a0FG?=
 =?utf-8?B?ZUpsR3dFSDBlTk1EWlhwTWRtWmRScHFJcHNEQlU4b3NKZ0kvZEdDMEs4SnZz?=
 =?utf-8?B?U0I2ZkFSaGVITlJjaDZRV2xCUmZsM0VUV2t4cW1ZM0NwRlFLeHExRFFHMmtL?=
 =?utf-8?B?d0FRS0cyNGkrY1M4T1FtUVlNZVU3c3dVSERINUlpQzdXOTlBdXRUQURZMjNq?=
 =?utf-8?B?WjdlcnZsNzBad0tCYStUSkNpb2tBdTFTbEp1czdPa3BIRW9lbGNTQlJUZDht?=
 =?utf-8?B?MlY0QmNFZFUvYkxqTFdtdkRkWnl5MURTZytGK0EyQzNMakQxakdKRk1UOXJU?=
 =?utf-8?B?bW1XdEo2eXJNWElad3NSR3I0ajBGcVRlZnJXamk0cjJlTjc3SXFFNXN3dm9V?=
 =?utf-8?B?ZUdxUEVzVU1SQ2FrY1BxMjhuTGo2emtQWjhwRElGK1VIUW8rY3dZMTg0MnFo?=
 =?utf-8?B?VkZRZENsaUw0NGJRRTE1eDBHSlVwU0pPWXQvVllmQVdLbm4xQkZnblgrTEFu?=
 =?utf-8?B?SFljTE9MeHp0cmUyd0I3UXIrVWVQQ3NFR1NCdWNjN091SXBBMFovTmJuK0k0?=
 =?utf-8?B?clJkdXRhc3ZxaStlelNRZmlJeTBXeUFXUnBSWkxKd3BmYm16aGN0ZS8yeE84?=
 =?utf-8?B?b0VUc1NWVXhmdjAxRzRDVEZtZHRlL2p0eUdXMEl5WDI2YWpNRXUzYmhMRkJG?=
 =?utf-8?B?KzlPKzUxR21mU2tDQXhhZlNteXBOV2dPY2ZkRlJBN2w1UFlkb2RYc1A0N1dj?=
 =?utf-8?B?bndGNmZONk04ejdzaXByWG9oY0pXbDZncU5RZEdobG9vRE02bkwrMHFNSGVz?=
 =?utf-8?B?WXhyVk42SFJnb3g1bElmT3VLODMwbForSXovNldlL3JKV3RRRVdlTDl0L0dO?=
 =?utf-8?B?QzJGVHYrSDl4aWl0L3g5cDVoMEgwWTNaZmlIR1RmWmFpN2lHWmZRS2tBK3RE?=
 =?utf-8?B?aStLRWlDSXE4WDdGTXYzcGhZZGtrQ1hjSVFSRDhUMDA5dDRuWGpmQVpIQVNT?=
 =?utf-8?B?clltbkcyVE9oSVltVnFSdXdza3BRemNMWGdkTm4wN3lJVlRsUlk4U3hjR1ox?=
 =?utf-8?B?V20vQThwWUZ3aDBJQnhTSGMyRC92OVRGRmJjcUY1NHdUaXMyUndZSGh0Q2pX?=
 =?utf-8?B?RFBETkJmSU5iMWp6dFV0cmVxRldNamVuTlNvektJdC9yenVhZ3VCb21QZ1RP?=
 =?utf-8?B?YWxicmxuNlV0MHZHR040MzlEUVZnalF6ZUtXWm1aUVoySmNnM0JxMVhjSk5o?=
 =?utf-8?B?TXV0NGxpVWJwMmhtQS9YU1dmb0ZEc3RyQ1ZNZlE5cDJUTHZoZ1ZPeTlWTXlG?=
 =?utf-8?B?QmdSN3ZURXR1ZWFNVnRBL25tQU1KMEJNRWROcm1MM1JxMGtKbDBuVHBLcGIr?=
 =?utf-8?B?Qm5RbTJTcnlpSUlqYS9lZ25EcXZWYTJmZXN4ZU5IeEZvbnRRdGo1YUttOG9m?=
 =?utf-8?B?SHViZmIrSUswZlVhV1ZXbnM1Y3J0SkhlY1F6T1ZaWDdHc09pcitvVEZ5UDRv?=
 =?utf-8?B?YTJPTGwzalFPMWpram1FY0JaT25vMkd4WkkzbDc2dGVMRzRGV29sekk3eHN3?=
 =?utf-8?B?VU1aSi8zZ2loUzZSUnFPOVBMQm0rZG13dVFqWEtIazBXSnkzYi95SXRCVENI?=
 =?utf-8?B?Q0RJSUpRajRsbG04Q2VRRU00Z3FRb0FYUi9UTHl3WTlLaFBmcEd3c1BFRXJm?=
 =?utf-8?B?SStqVkZLSzdTQnFYVXZ6QUhJVVN6dTdXeHVYbnFsdUFXUEFUc2xTbGt6NmNS?=
 =?utf-8?B?bzBkL0JTb2c0WHRBUU5iaXpFMFZGKzdrRTgrdk5ncFBteFI3bzY5WVl6UWFx?=
 =?utf-8?B?dHBteXZzekVkR3NRa0QraXEyVGpZYlR4UmppNm1rbENFL1c0cDJaNnpZZkRY?=
 =?utf-8?Q?vfi+3QlonoekKNsxKiIwyduK3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d04502c-c604-4278-4b2b-08dd1b633aca
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 10:45:15.8293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MfTm2REO8bnLoH3ll+6v64RYgwSo0Gr5v6Bpn6iefeZD3MVXNvJTuoMVvLotGL3jG+60G+QcOy9c75DqNX4DSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB6335
X-Proofpoint-ORIG-GUID: kug9LheTyQMzQmgSsnV18rxBP-ZqX5iF
X-Proofpoint-GUID: kug9LheTyQMzQmgSsnV18rxBP-ZqX5iF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Pj4gQWRkZWQgbWFjcm8gZGVmaW5pdGlvbiBmb3IgVklSVElPX1BDSV9DQVBfVkVORE9SX0NGRyB0
byBpZGVudGlmeSB0aGUNCj5QQ0kNCj4+IHZlbmRvciBkYXRhIHR5cGUgaW4gdGhlIHZpcnRpb19w
Y2lfY2FwIHN0cnVjdHVyZS4gRGVmaW5lZCBhIG5ldyBzdHJ1Y3QNCj4+IHZpcnRpb19wY2lfdm5k
cl9kYXRhIGZvciB0aGUgdmVuZG9yIGRhdGEgY2FwYWJpbGl0eSBoZWFkZXIgYXMgcGVyIHRoZQ0K
Pj4gc3BlY2lmaWNhdGlvbi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTaGlqaXRoIFRob3R0b24g
PHN0aG90dG9uQG1hcnZlbGwuY29tPg0KPj4gLS0tDQo+PiAgaW5jbHVkZS91YXBpL2xpbnV4L3Zp
cnRpb19wY2kuaCB8IDExICsrKysrKysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2Vy
dGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19w
Y2kuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmgNCj4+IGluZGV4IGE4MjA4NDky
ZTgyMi4uMWYzZWE1ZDJhNmFmIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3Zp
cnRpb19wY2kuaA0KPj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaA0KPj4g
QEAgLTExNSw2ICsxMTUsOCBAQA0KPj4gICNkZWZpbmUgVklSVElPX1BDSV9DQVBfUENJX0NGRyAg
ICAgICAgIDUNCj4+ICAvKiBBZGRpdGlvbmFsIHNoYXJlZCBtZW1vcnkgY2FwYWJpbGl0eSAqLw0K
Pj4gICNkZWZpbmUgVklSVElPX1BDSV9DQVBfU0hBUkVEX01FTU9SWV9DRkcgOA0KPj4gKy8qIFBD
SSB2ZW5kb3IgZGF0YSBjb25maWd1cmF0aW9uICovDQo+PiArI2RlZmluZSBWSVJUSU9fUENJX0NB
UF9WRU5ET1JfQ0ZHICAgICAgOQ0KPj4NCj4+ICAvKiBUaGlzIGlzIHRoZSBQQ0kgY2FwYWJpbGl0
eSBoZWFkZXI6ICovDQo+PiAgc3RydWN0IHZpcnRpb19wY2lfY2FwIHsNCj4+IEBAIC0xMjksNiAr
MTMxLDE1IEBAIHN0cnVjdCB2aXJ0aW9fcGNpX2NhcCB7DQo+PiAgICAgICAgIF9fbGUzMiBsZW5n
dGg7ICAgICAgICAgIC8qIExlbmd0aCBvZiB0aGUgc3RydWN0dXJlLCBpbiBieXRlcy4gKi8NCj4+
ICB9Ow0KPj4NCj4+ICsvKiBUaGlzIGlzIHRoZSBQQ0kgdmVuZG9yIGRhdGEgY2FwYWJpbGl0eSBo
ZWFkZXI6ICovDQo+PiArc3RydWN0IHZpcnRpb19wY2lfdm5kcl9kYXRhIHsNCj4+ICsgICAgICAg
X191OCBjYXBfdm5kcjsgICAgICAgICAgLyogR2VuZXJpYyBQQ0kgZmllbGQ6IFBDSV9DQVBfSURf
Vk5EUiAqLw0KPj4gKyAgICAgICBfX3U4IGNhcF9uZXh0OyAgICAgICAgICAvKiBHZW5lcmljIFBD
SSBmaWVsZDogbmV4dCBwdHIuICovDQo+PiArICAgICAgIF9fdTggY2FwX2xlbjsgICAgICAgICAg
IC8qIEdlbmVyaWMgUENJIGZpZWxkOiBjYXBhYmlsaXR5IGxlbmd0aCAqLw0KPj4gKyAgICAgICBf
X3U4IGNmZ190eXBlOyAgICAgICAgICAvKiBJZGVudGlmaWVzIHRoZSBzdHJ1Y3R1cmUuICovDQo+
PiArICAgICAgIF9fdTE2IHZlbmRvcl9pZDsgICAgICAgIC8qIElkZW50aWZpZXMgdGhlIHZlbmRv
ci1zcGVjaWZpYyBmb3JtYXQuICovDQo+PiArfTsNCj4NCj5OaXQ6IEkgd291bGQgaGF2ZSB0aGUg
Zm9sbG93aW5nIGNvbW1lbnRzIGZyb20gdGhlIHZpcnRpbyBzcGVjOg0KPg0KPiIiIg0KPiAvKiBG
b3IgVmVuZG9yIERlZmluaXRpb24gKi8NCj4gIC8qIFBhZHMgc3RydWN0dXJlIHRvIGEgbXVsdGlw
bGUgb2YgNCBieXRlcyAqLw0KPiAgLyogUmVhZHMgbXVzdCBub3QgaGF2ZSBzaWRlIGVmZmVjdHMg
Ki8NCj4iIiINCg0KSSB3aWxsIGFkZCB0aGUgY29tbWVudHMuDQoNClRoYW5rcywNClNoaWppdGgN
Cg==
