Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5251BE871
	for <virtualization@lists.linux.dev>; Fri, 13 Dec 2024 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086661; cv=fail; b=slLbz8uK+DETO/9CWdccY20eVxhpQJwx0HM12f82ST7k5HSAU6UHZygMhCHTB+TIRciSopWJeTvJpEhals15xgnUewtMOWSP+0+tTmnTCx89CS6gC7bHTxnZvgi5Y8/4AeIAbBu54k5Rqqc0IAPUjOe41hK9TLuxIJc/CpgEPqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086661; c=relaxed/simple;
	bh=8TmChjqqPfN8uJMa5EKOD1MFYjTU6d5vrP38JohW5t0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ec56DbJ1JPeBIDzZUfwp880PbihYz9Bu70qz7dBqZGD+PT5A4DWx970cxW9nDQ5pBUKWKv1U3m2v5txWRaeGTsKVJjfI+F+K9jdn7BXKdtr2x1YjYGDa6dyKriU8SWWY/djBKiM+JmyumxWGAzSNQWkqquw2Uih+htEd61vDTA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Z4gUvO6J; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Z4gUvO6J"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCHVK51026843;
	Fri, 13 Dec 2024 02:44:11 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43eyqh6bdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 02:44:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHMoBoWa+ty3bKMFQJOw3K0zqlXyNc6K6QaQ6rAdzMG1WvxakqCLx1ECO5nXca3Yh3KM40elxdwpgUzuXFdDhcW6EHq/mvEZ+W3qV6Wu0tr7iOxLgYL8cTdtGNgBLF7n/dDiiIwzV8FPF2j/3OACbf1YTM0HVYgR1tqypUw9f4harQwG56FZBOJ4/D7yz3r/HqxH4E29d4QOdBIpPY7Ilv0H3v/RBZQswknyvAgikS2HCL7Eu8fkpaeUxyvp24b0qmJr+CdExlm6J6l0Ni64C7J9LQ+fPElhoMRt5XgaFcnvL0diBLrAhxEt65t0JAKIVduZZmrl4ruBy2x0F+jozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TmChjqqPfN8uJMa5EKOD1MFYjTU6d5vrP38JohW5t0=;
 b=KPquLnNJGs2x+Bu/jCz/S/q6LopI6Xkh2K3xjvG0DEF6FEQsYXuPZ+NJvhhfVXWPr9kLyywvCmJiFLZMC/6n0lT9Es0u48esML0/pGW07XQDrU8pYJCuHcJ5V8zJzl+IICvrjR6svvoG4zohoUXFzD8WwJEE7cNuljFF47XoJyTxNLk+appn8XYM8F/jwT2jaoAaI0cqFyNwL4G0k4zfX7tGvm9ELE4Moqdf2DiaFq9+HtcaqQ5R26iTxSldNQCJ9x+o5RRYDEsbkf1DR6B4Pa2vH9rhxdtvHFwzyd/PB8yNTJqA0fl4qnGTte65KR/kbnKu+eDIW/BkWtYu+OUq5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TmChjqqPfN8uJMa5EKOD1MFYjTU6d5vrP38JohW5t0=;
 b=Z4gUvO6J71G9ffDeTyBv1md0CsHM4LwXqq6a6GZC3xtsiIZBOijraDX64LBT0OwKbYiTat46BrR1bu61zbDHIIjmlPBT7iN+7OIBQZXYO8q304LEfCz/wnZFadUIzi+m4TEVOx+3Mr59dCgTsSPBj0c9KQDvYs62jpJAFBqAaXQ=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by IA3PR18MB6335.namprd18.prod.outlook.com (2603:10b6:208:527::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 10:44:07 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 10:44:07 +0000
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
        Satha Koteswara Rao Kottidi <skoteshwar@marvell.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] vdpa/octeon_ep: read vendor-specific PCI
 capability
Thread-Topic: [PATCH v3 4/4] vdpa/octeon_ep: read vendor-specific PCI
 capability
Thread-Index: AQHbTUvv2mV3YxnNrUyyI5JMNPrScA==
Date: Fri, 13 Dec 2024 10:44:07 +0000
Message-ID:
 <PH0PR18MB442538D91F856F27F3C37A9AD9382@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20241209151427.3720026-1-sthotton@marvell.com>
 <20241209151427.3720026-4-sthotton@marvell.com>
 <CACGkMEvuObS4RCk2BjQ4sm6r4jaC3fN4ui5EXd6SVzYxYZV7iA@mail.gmail.com>
In-Reply-To:
 <CACGkMEvuObS4RCk2BjQ4sm6r4jaC3fN4ui5EXd6SVzYxYZV7iA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|IA3PR18MB6335:EE_
x-ms-office365-filtering-correlation-id: ca694dfc-e924-440f-e803-08dd1b63121d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dGpoN1c0eGJBOWZUR0ZBdU1JNXVqdjBlRFpFeFFDU3l3VUR6RUYrUHFzbWJz?=
 =?utf-8?B?dHBqNUlkOWduOWpKYUhzWWxGeWVYazNJWHZUZzd0ZW1BNHpBOWNrdEFHblVl?=
 =?utf-8?B?NWJrTjE0Q2NidHZVUXFrUjRaL042bURmMnZoaVAvdUFtY3BZdm9vZUFmckJD?=
 =?utf-8?B?YThURUs2ZHBJWnNoQWlpOGJPTVNybE5hQUU5ZWNodkFzN3MrWUJvMEVYQzln?=
 =?utf-8?B?M1MyZ2F6cWc1WmU3cUVVbkJ6NHJjS215aDl5ZnVDRjRBOThBN1BEcXhHQlpx?=
 =?utf-8?B?Smw4STlzL1NuNFBNQVNrY2h5Mms0Y1hDNTFxRG9vZy9tREdBZTNjY2FhWUhy?=
 =?utf-8?B?RFdMZXJkeTJJYTVObUdpRVM4clFsTGxjTlNwN2ExK2hvcEM3aklGajNiTEhU?=
 =?utf-8?B?RFB6Z0EzSFhNdThQckJ2NjM4aHpjdGV4MTRhOTF2elViOWZHdGNWeDVJNDRk?=
 =?utf-8?B?VmxGWElWb3FGV3Z6b3ZYakhrbDlrL2NFZDdTNlhDTHNjYVNWMkJMRnlnVkVO?=
 =?utf-8?B?bDNlc2l1OGY2TFNSYXRQUFUwSkdIQStNcU9LbUllQloxRy9VcjZ6U1ZMeWgr?=
 =?utf-8?B?Z2YzQ3I2S3Zad0NQVlJDV21ua2RURkpwL25rK0tUYitYOExpeEdUWXp6NlVq?=
 =?utf-8?B?eDJwSVc0T2s0Y3VEa25Ba3UyVHEvVWJNSG4yUFc5RlYxT2tqMnEyeFQxMEZj?=
 =?utf-8?B?QW1ZaTBlRzZsWTNTOVhzY0NTcmZxYlJVN3JWeFo2aC9hTFRONTlDdDNHYVpl?=
 =?utf-8?B?MEtyNHRNa1BrVVhLNlNQTUxYVDk2eTJ3L3Vua1lEc1FnWFZvWUQxTzc2a1RS?=
 =?utf-8?B?VTVFZFJXRThST2gyd084S1orQldTWjFTMkN2YjZnaWRXYitjclJOMXk0TzRC?=
 =?utf-8?B?NjNzL2FldnNFQjU1YllPVDBmQWsrcVVwK0ovQnlobi9RSnZYMzlJd0xGQUox?=
 =?utf-8?B?dHUza2VvdGRGZTFoVnhHNVQyTHA5OUI1bnV3Nlc5Mld1cTlQSEF0Zk9VUGh5?=
 =?utf-8?B?dHJSbnhsZkZ1WStQK0U0WlNnOUdzMUtUUU5jL3VibzhvajE3WjBxYUUwNmR5?=
 =?utf-8?B?MkVNYXg5MjdtRU1Gd2FuK0YvMUducUJ5NWdLUXRmREhiWDdrYmhhcUlMODUy?=
 =?utf-8?B?ZEN3R2dYUnQ4Z0JORCs4UUdyeHhzZGpGRnY3ZkZ1RmVSTkRINXlwQ01YWklq?=
 =?utf-8?B?c1JvQkdPTTBXWmgyUmdkdlhlc1ZnTzFhb3MxbXVwaWxEeHU0anI5OEVrcGFu?=
 =?utf-8?B?Z2w1ZlMvQlNYemthTEdqSFV6WU9LMmV3Z0x1akpqS3FzdHg2cy9GbFJkdElM?=
 =?utf-8?B?WnpkVFFVeWVBeElTUGF6bGV0cWFESkUyUGE5aVg1RXlZeTRaRkxKekNWaUVa?=
 =?utf-8?B?SFYvVkduczluSkZtaXhtL0pIQmpUSFpDYjE3c2NTL2NYQnVVZ3RmZzhaNFdj?=
 =?utf-8?B?cWxqaFlUN0dLYzEvUVJrck1uZzJYRE1rOXhXUjJiU2RNY2NGdVBqVjhOV1Z0?=
 =?utf-8?B?c01GQkdtSGFhdWRFanhHSnFuVEVyZlZwNmRFd0Y1RE43SzZ6UVZhbTJveTdN?=
 =?utf-8?B?VmlGd2NjM3Vtemkra25telUxTTlHaWhXeVVNYUZ5Qkh4WExIT2JGTEtmSjA3?=
 =?utf-8?B?aGd4QVpaV0x3dkFUOUQyUzljQ3FaWXd1MXo2NFdiSWhsWVlRVnN3dHNjbWx1?=
 =?utf-8?B?L1Yyc3J5eUIyTGNKcTBJWEVyWHFrb2JWODJaZjlqRWwvV2pOUXJna3VGamRq?=
 =?utf-8?B?RVN5S0NscEZ5MFJYMzFadXJnUkhoV2ZLSUI0Mk11aE1UTEIrbEJUYzBqUHdM?=
 =?utf-8?B?RGlCTU1WVFp6eURuN1JvRXI5c1R4SEIvWXF2bnlCN3oxblR4Z1cvNWZhcVQw?=
 =?utf-8?B?cGlCR2ljQjNPUWJHYWpldWhTVXRGRm1ldnBpcXVrY2VKbUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cytrbDJ6L0w2OC9PcnBmTFhLWlBUdndNaUpSWUxmYVQrZmJKMERuTFgvbExv?=
 =?utf-8?B?ODlUMXpwUE1UTnd2L3JJOEJyL29BOEJTWW5PbkwwZ0tnakIrendYc0QySmU5?=
 =?utf-8?B?YTZkYld1NGg5WEtLRTk5cUdES2xMSDV5VFdDNjVnN0dLM1ZnSUlVSEpNOXV1?=
 =?utf-8?B?YVQ5ZElkZDRQeURPTS84MnQwVUZYbGVOWjJoVmYzY3hLWk9TY0w4eGtEdnBJ?=
 =?utf-8?B?dmxBNkcvSnhMM21HQ1pnb0E0dHg3ajMxdjdQSzJCV2gxRkdXZHE0RkZRcVYw?=
 =?utf-8?B?czlRV2Q2bHBqQ0liSlJjWHVobnMrTFZPZjZacUFzdTJ3VVIvblY0MVRzdlE0?=
 =?utf-8?B?SkdKZFRKUDFmRnV0UC9say9SL1licmJzOHl3MTVWaTY1d2k3b0FpL0tja29S?=
 =?utf-8?B?RTRQSjFIamM4aVZwL3h2Ym5WMG5DM1U2Z2o4OEtzOEpGY1hvNFluUGZ0WW1G?=
 =?utf-8?B?ajlhRjNlVmw5ZjdDWEdyQkFKQ2Q1Mkl4MUZEeFJpWXNaZlZJQ01yS2lONjBG?=
 =?utf-8?B?SG04OEttb2t3WEJyL2d1Qm5uNzNrNXNSNEkyZ3NWRXRWUHpnd0UrQ3JFSGti?=
 =?utf-8?B?V0Q3NTZjTVB1SjVmM1pzZEIreklWajZZRlBKQ1VXTGUwYXh0T1hHQlRBS3lz?=
 =?utf-8?B?cjg3QkVjbDlndEZsMnVIV0M5M2FDOFp3Tm92U3h4bjRlTEdkUWFVZS84UVpm?=
 =?utf-8?B?TWw2NWU4MHNidG0ra1c5NnVEUkE2T0lZMVYvYThkZE1VemlsclNSSHFCcGZN?=
 =?utf-8?B?eDJpNFBxdmVXaGVGUFJNM2tKYUVwWVh1QmZvRVNKR3gxcS8rSFhLUG5wQzFI?=
 =?utf-8?B?R3g1UEcza0lqdGU3dHg5QWljUmdNNEJWSWdURGd2VXlWd3pKZGx5RTFjZ2Uy?=
 =?utf-8?B?RmpyblNPakJHcWsrMllUVWRxaHJ1Wnk1M1ExWm5lN0p3OUIxUFJzRXFUMk0y?=
 =?utf-8?B?cVNlSjJwa0dNNUpraWhDaUlnaWFkSEZyajdIYjVCK0VuaCtXSUpYWTh0T083?=
 =?utf-8?B?RzZtK2RqNlNOSVRzQjc2bnZuVytabDNlRHNobkFCVWNOdzJqUncwUHRGVlFV?=
 =?utf-8?B?b3N0TElIQko5N1JHUnNMaXVZSU83aWc2VzEwMUZBZWc2UCtkZGpleDUvWVZD?=
 =?utf-8?B?RTNhTVVadWw3TnlsUnk1R1BFR2dHc3lic1RVWTAwK1VVNm5XM2M3S3hzZTc1?=
 =?utf-8?B?K2ZCYmRjSFNvN3ZlNFhFZUkyQkQxTXR0RzRxekdsR2g5emdlK3QwU2RtaWdk?=
 =?utf-8?B?VWx2WUJTQThBaG01Q2JKNm56dGx5QlhUNXJSWGRtOEtYSUJ3K09EUVFYRVRM?=
 =?utf-8?B?clZFMlRJQitnWjRtSzlOME9QS0NRZk5hSExXcUZ5VmZKbndqVmNtSzJYazV4?=
 =?utf-8?B?SDdWanU0TDAyOWpuSlBMMk9XUEFGZW42ZnBOZGg1Znl6L0FQN0tSMTBpb0cx?=
 =?utf-8?B?UVNkd3htYzhRYy93L3I1NlRkK3VLbS9DbTVXUUR0WmdQR1hiRjcyKzFsRnov?=
 =?utf-8?B?RjRlemswSWNNblI0OEJaR2Q0VHlOdEZoVW5qTnl4RE1vdWVpZzRvR25Nelox?=
 =?utf-8?B?bkxJbmltbjBjMXFQOGEyTWhhbGZuSWl5em1KWGVhV2tPUjJKRVZaWUJrWm9v?=
 =?utf-8?B?VXZ6dUtVRVpRRnFpZGowRktsYk8rSjNtZlRJaWpDcEFJUmVZS3BZaGpFclpP?=
 =?utf-8?B?cFU4Yjl0aG5GdC95UFNYem95cUFrY0dBamYrSHRxR29rNGE0dUJWTXlmUTY2?=
 =?utf-8?B?M1ovTU14dXpwZnJZSEJ6QUdTbWNMcDdPT3owaExwbUI5MEF0RkdjRWFIdUZy?=
 =?utf-8?B?ZHdudkEvdHV4SmhxRjRlNGxQOXpjSU0xS2RkWVZ3Nkh2UDg2eUZkNTJWOWxl?=
 =?utf-8?B?NnFiaEJCR0xRRk9uNVFjNkNmOVN0eVB6a2RjQkRxc2czbmZUQzd6aHRERzZW?=
 =?utf-8?B?NFZQTGNBYTN4Mk43SDRIWEo4eFlraTVpN0gwTTF5M1RISVd5WFo5ZXhET1ZJ?=
 =?utf-8?B?a1VkWlhKWVpON0E0VGZGalNMNjlCTUZ2c3NiMUlXdGRtanFxNmpaQVBBZW1x?=
 =?utf-8?B?QU8xQU5saHBiL1ZLSjgrc3J4cmNCZmdYbzBTNnZpSWhrdzd3S0pIOWhiMWIz?=
 =?utf-8?Q?n9SGOfZ+YR861FyfwXUMQshWT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca694dfc-e924-440f-e803-08dd1b63121d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 10:44:07.5686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CV50spgiL1iKpqGjXCDxLMhGu9Oyze589reQA7A873jfpyTi7Oc/xgFkEmtbKcBXyq0PAB4TRQ3A36Z/9LIoLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB6335
X-Proofpoint-GUID: LRo4dmbWVSV7XFPTALcuW2RAIVdatehS
X-Proofpoint-ORIG-GUID: LRo4dmbWVSV7XFPTALcuW2RAIVdatehS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Pj4NCj4+IEFkZGVkIHN1cHBvcnQgdG8gcmVhZCB0aGUgdmVuZG9yLXNwZWNpZmljIFBDSSBjYXBh
YmlsaXR5IHRvIGlkZW50aWZ5IHRoZQ0KPj4gdHlwZSBvZiBkZXZpY2UgYmVpbmcgZW11bGF0ZWQu
DQo+Pg0KPj4gUmV2aWV3ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJv
Lm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IFNoaWppdGggVGhvdHRvbiA8c3Rob3R0b25AbWFydmVs
bC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL3ZkcGEvb2N0ZW9uX2VwL29jdGVwX3ZkcGEuaCAg
ICAgIHwgMjAgKysrKysrKysrKysrKysNCj4+ICBkcml2ZXJzL3ZkcGEvb2N0ZW9uX2VwL29jdGVw
X3ZkcGFfaHcuYyAgIHwgMzMNCj4rKysrKysrKysrKysrKysrKysrKysrKy0NCj4+ICBkcml2ZXJz
L3ZkcGEvb2N0ZW9uX2VwL29jdGVwX3ZkcGFfbWFpbi5jIHwgIDQgKystDQo+PiAgMyBmaWxlcyBj
aGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZkcGEvb2N0ZW9uX2VwL29jdGVwX3ZkcGEuaA0KPmIvZHJpdmVycy92ZHBh
L29jdGVvbl9lcC9vY3RlcF92ZHBhLmgNCj4+IGluZGV4IDJjYWRiODc4ZTY3OS4uNTNiMDIwYjAx
OWY3IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy92ZHBhL29jdGVvbl9lcC9vY3RlcF92ZHBhLmgN
Cj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9vY3Rlb25fZXAvb2N0ZXBfdmRwYS5oDQo+PiBAQCAtOCw2
ICs4LDcgQEANCj4+ICAjaW5jbHVkZSA8bGludXgvcGNpX3JlZ3MuaD4NCj4+ICAjaW5jbHVkZSA8
bGludXgvdmRwYS5oPg0KPj4gICNpbmNsdWRlIDxsaW51eC92aXJ0aW9fcGNpX21vZGVybi5oPg0K
Pj4gKyNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19jcnlwdG8uaD4NCj4+ICAjaW5jbHVkZSA8
dWFwaS9saW51eC92aXJ0aW9fbmV0Lmg+DQo+PiAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlv
X2Jsay5oPg0KPj4gICNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19jb25maWcuaD4NCj4+IEBA
IC01Miw2ICs1MywyNCBAQCBzdHJ1Y3Qgb2N0ZXBfdnJpbmdfaW5mbyB7DQo+PiAgICAgICAgIHBo
eXNfYWRkcl90IG5vdGlmeV9wYTsNCj4+ICB9Ow0KPj4NCj4+ICtlbnVtIG9jdGVwX3BjaV92bmRy
X2NmZ190eXBlIHsNCj4+ICsgICAgICAgT0NURVBfUENJX1ZORFJfQ0ZHX1RZUEVfVklSVElPX0lE
LA0KPj4gKyAgICAgICBPQ1RFUF9QQ0lfVk5EUl9DRkdfVFlQRV9NQVgsDQo+PiArfTsNCj4+ICsN
Cj4+ICtzdHJ1Y3Qgb2N0ZXBfcGNpX3ZuZHJfZGF0YSB7DQo+PiArICAgICAgIHN0cnVjdCB2aXJ0
aW9fcGNpX3ZuZHJfZGF0YSBoZHI7DQo+PiArICAgICAgIHU4IGlkOw0KPj4gKyAgICAgICB1OCBi
YXI7DQo+PiArICAgICAgIHVuaW9uIHsNCj4+ICsgICAgICAgICAgICAgICB1NjQgZGF0YTsNCj4+
ICsgICAgICAgICAgICAgICBzdHJ1Y3Qgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgdTMy
IG9mZnNldDsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHUzMiBsZW5ndGg7DQo+PiArICAg
ICAgICAgICAgICAgfTsNCj4+ICsgICAgICAgfTsNCj4+ICt9Ow0KPg0KPlRoaXMgc2VlbXMgbm90
IHRvIGJlIHBhZGRlZCB0byBhIG11bHRpcGxlIG9mIDQgYnl0ZXM/DQo+DQoNCkxvb2tzIGxpa2Us
IHRoZSBzdHJ1Y3R1cmUgaXMgbmF0dXJhbGx5IGFsaWduZWQuDQoNCnN0cnVjdCB2aXJ0aW9fcGNp
X3ZuZHJfZGF0YSB7DQogICAgICAgIHVpbnQ4X3QgICAgICAgICAgICAgICAgICAgIGNhcF92bmRy
OyAgICAgICAgICAgICAvKiAgICAgMCAgICAgMSAqLw0KICAgICAgICB1aW50OF90ICAgICAgICAg
ICAgICAgICAgICBjYXBfbmV4dDsgICAgICAgICAgICAgLyogICAgIDEgICAgIDEgKi8NCiAgICAg
ICAgdWludDhfdCAgICAgICAgICAgICAgICAgICAgY2FwX2xlbjsgICAgICAgICAgICAgIC8qICAg
ICAyICAgICAxICovDQogICAgICAgIHVpbnQ4X3QgICAgICAgICAgICAgICAgICAgIGNmZ190eXBl
OyAgICAgICAgICAgICAvKiAgICAgMyAgICAgMSAqLw0KICAgICAgICB1aW50MTZfdCAgICAgICAg
ICAgICAgICAgICB2ZW5kb3JfaWQ7ICAgICAgICAgICAgLyogICAgIDQgICAgIDIgKi8NCiAgICAg
ICAgLyogc2l6ZTogNiwgY2FjaGVsaW5lczogMSwgbWVtYmVyczogNSAqLyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgLyogbGFzdCBjYWNoZWxpbmU6
IDYgYnl0ZXMgKi8NCn07DQpzdHJ1Y3Qgb2N0ZXBfcGNpX3ZuZHJfZGF0YSB7ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAg
ICAgIHN0cnVjdCB2aXJ0aW9fcGNpX3ZuZHJfZGF0YSBoZHI7ICAgICAgICAgICAgICAgICAvKiAg
ICAgMCAgICAgNiAqLw0KICAgICAgICB1aW50OF90ICAgICAgICAgICAgICAgICAgICBpZDsgICAg
ICAgICAgICAgICAgICAgLyogICAgIDYgICAgIDEgKi8gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAg
ICB1aW50OF90ICAgICAgICAgICAgICAgICAgICBiYXI7ICAgICAgICAgICAgICAgICAgLyogICAg
IDcgICAgIDEgKi8gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICB1bmlvbiB7DQogICAgICAgICAg
ICAgICAgdWludDY0X3QgICAgICAgICAgIGRhdGE7ICAgICAgICAgICAgICAgICAvKiAgICAgOCAg
ICAgOCAqLw0KICAgICAgICAgICAgICAgIHN0cnVjdCB7DQogICAgICAgICAgICAgICAgICAgICAg
ICB1aW50MzJfdCAgIG9mZnNldDsgICAgICAgICAgICAgICAvKiAgICAgOCAgICAgNCAqLw0KICAg
ICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgICBsZW5ndGg7ICAgICAgICAgICAgICAgLyog
ICAgMTIgICAgIDQgKi8NCiAgICAgICAgICAgICAgICB9OyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIC8qICAgICA4ICAgICA4ICovDQogICAgICAgIH07ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiAgICAgOCAgICAgOCAqLw0KDQog
ICAgICAgIC8qIHNpemU6IDE2LCBjYWNoZWxpbmVzOiAxLCBtZW1iZXJzOiA0ICovDQogICAgICAg
IC8qIGxhc3QgY2FjaGVsaW5lOiAxNiBieXRlcyAqLw0KfTsNCg0KSSB3aWxsIGFkZCBfX2F0dHJp
YnV0ZV9fKChhbGlnbmVkKDQpKSkgdG8gYmUgc2FmZS4NCg0KVGhhbmtzLA0KU2hpaml0aA0K
