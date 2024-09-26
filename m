Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2133120E6
	for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 03:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727321446; cv=fail; b=KG2FeF86ipj2BG0JDlEvIt0BOIU4+S6LSZcbu4rpimYJw9/OnNS2hEpeH5sR4xWjC5oO0uI4tJ5f4EOtA6tFI5zsrbBu+L+8HOWJ0pXeGB2CMAl61W8SFQrf3iymqBfhpEW33lzU33qMgq4jUTqSQ+TTlBxWf3BFF4alc27otdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727321446; c=relaxed/simple;
	bh=ilEppQB/Gay3fGDO1WUIDWi87yx0ONxvqOw9Ts8L8tY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iP7GIdi+AcdmdrQmg6ZvJHzqTrz6PSlEsWp/o/XSCB5Gg8XFPeCoWD7R3WUrxq7Mp0xzVF33BRGSc68NDS7pUmXr5X1Tv3NQkaebl6rs7BMu14UyftVmVKTZvluYawxXDje87sziwpSqXjg/8cRjVNrB04gGsO3ekoM9XE0fEsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GUM2Ap4U; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GUM2Ap4U"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PH5NZA010525;
	Thu, 26 Sep 2024 03:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ilEppQB/Gay3fGDO1WUIDWi87yx0ONxvqOw9Ts8L8tY=; b=GUM2Ap4UaGX1/aHZ
	aoL6ykGT8+jpKeIuZ9kgUhXQCWrbbH/1I/2Dz9d0jk2kRFtrQTJ+w+E1tGkRiRyW
	vvJsEyzUT1d4hIfKonOlJUHo7yUx1W1j4ajX2+4i3mu5ZjzXXV4unSogipUWl++B
	23+M+9yEtUcjo2Pnog05md1WSAvPM1LcgroJ9H4IUM6ESV28WvffpdPHOYnbWpq8
	GZpBmzjbA1oNk5jn6/hjCMzZD1HdLPigsLCvDsQOdFrQg3xC/9hR+okD1h958tmY
	pbpkDQ+wy3NQlMDh7NIPK089V48a74pLHni++6BoVNKCa73Gz8C9QvezsbQhAmbF
	ZxjQjg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sph6xb5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 03:30:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFklxTS/HDE5rw6dQcJNiY4J44w/gHgOvLQl/7ZJlIhgJHekCF8YVVARnEQNje8zCJ3OcSVidExbNFvGzDmZQbZj328eowep2kShb+C4aNM+lR49AqFoetZCjLIRLhCallCvmThYCyNOtfBGkQwwHmtFtZYVAMqM5kkO4t9Ks5LcBInDPSDhKw1MJk7NDdK+7HSn8O0HaCyi37tYS0ZVkSZVSOA5jO6wMeiZulTr8VRePewuqYOIe6JwoMQHkA9oe5EUrDR3G1hVYqGZyR6OrhkS6zIAP/HgZW5nSaJ2nGAQcedkzJu/Xe7ouiHpt1fZRgijiMM8TFgqZEkybIjaEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilEppQB/Gay3fGDO1WUIDWi87yx0ONxvqOw9Ts8L8tY=;
 b=M6W3vBwOU9OF4vrdM6zpEhYfp4HA7UvhM3Avj2P7BM93Cm0PmaAMZgxuPukDlBttCpC45iM5z0ERJf2IIzAihYvnME5B7eTKdJqnumtJX6P/XV45IeS87qpD8DL76mgUy5anMohF0LOSUMXmg7jzOLwEjq7H0MwmLiAuUVb9XHJvZqgfKoMnKkRuNFgGW4YwgNj/QhpdhavTxGhVFTUh9JeMmC5aC0elI7SE/QusF4YFhwrGTRvwWgyg+HSYPBhxSuWKyHdTbCyUdkJTC/wnDboPZqaz1HrR4/83NJvjMTVFrcs+dQ0AcB+fJJQOGf7QRMgAOLUlVPyvtlofrO+/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM5PR02MB3638.namprd02.prod.outlook.com (2603:10b6:4:b0::36) by
 CY8PR02MB9105.namprd02.prod.outlook.com (2603:10b6:930:94::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.26; Thu, 26 Sep 2024 03:30:36 +0000
Received: from DM5PR02MB3638.namprd02.prod.outlook.com
 ([fe80::34d:5c51:bba6:3c08]) by DM5PR02MB3638.namprd02.prod.outlook.com
 ([fe80::34d:5c51:bba6:3c08%7]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 03:30:35 +0000
From: "Jianguo Sun (QUIC)" <quic_jianguos@quicinc.com>
To: Jason Wang <jasowang@redhat.com>,
        "Jianguo Sun (QUIC)"
	<quic_jianguos@quicinc.com>
CC: "mst@redhat.com" <mst@redhat.com>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "Anant
 Goel (QUIC)" <quic_anantg@quicinc.com>
Subject: RE: [PATCH 1/2] Virtio: Add CONFIG_VIRTIO_MMIO_POLL_RESET
Thread-Topic: [PATCH 1/2] Virtio: Add CONFIG_VIRTIO_MMIO_POLL_RESET
Thread-Index: AQHbDOvPkdp1w6dv70m7RzLjw50Z3LJnBSOAgADBhDA=
Date: Thu, 26 Sep 2024 03:30:35 +0000
Message-ID:
 <DM5PR02MB3638C8F46A0F3088DE06402EF06A2@DM5PR02MB3638.namprd02.prod.outlook.com>
References: <20240922123435.17946-1-quic_jianguos@quicinc.com>
 <CACGkMEv1ndVVwVrD1J_ghHpyZB0=3sLdSrXxchZ2QoQzMJihdA@mail.gmail.com>
In-Reply-To:
 <CACGkMEv1ndVVwVrD1J_ghHpyZB0=3sLdSrXxchZ2QoQzMJihdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: jasowang@redhat.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR02MB3638:EE_|CY8PR02MB9105:EE_
x-ms-office365-filtering-correlation-id: a7a00fb2-f652-4dea-85c7-08dcdddb95b9
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZE5IMGJ6blRkdWVqcmxzYWdHSEVadEIyeGZ1UE5JT2lmMzFhbFAzeThEU1hz?=
 =?utf-8?B?MEl5OW9IdWxuUFZTM3JuSVdlT20rK3puVzBXdFN1clFTM2dkanFnZ0NDbFBG?=
 =?utf-8?B?dEdPRS96R1MrUE5yVE9SeHlaY3dMMHJFblArNmF4OFhhU2YyeUQ5Ky9nNFRL?=
 =?utf-8?B?Vy9acjZueThwSExJK2RSZE1aOHg3NGluczIrMDN0aGI5VTdlanJPYmNQNFEy?=
 =?utf-8?B?WTNTTXNUZEIwVi9sV3M2N285a01wa1ZXMGh5MlRUdlZndWhlS1VLanpyWWtK?=
 =?utf-8?B?aDdFcVNJU3dVcCtTc29uc1RTdkV4Tnl0V0dkdThBM3ZtTUhEMGFyWFdGSDMz?=
 =?utf-8?B?L3ZjQ3RmN2RraVNML1NwTkR1Mlpjc1RhMmFhcnhVVkt1Y2kwSUl6Y251Wklj?=
 =?utf-8?B?dWpQSG4yQXhIYVpjNVU2UloweXgyYjh5ekJYTkw5YkhXMmVtYjNlakM3Z3o2?=
 =?utf-8?B?bDJjSU9QaUFOYURWcVB5THJmM01KSCtXeGJ1cXJKVTBwWFoyRUxwUVZ1Q21y?=
 =?utf-8?B?KzRtZ0hXZXdKVSt5VEtsdUNJak9RVUNmSmhTNWdteUh6dEJLVmJmcHk1UldD?=
 =?utf-8?B?dUZCWk85ZXF6U1owcGZCditzRXF5ZVhKYmUyWHN6RXFQUUlidHdtOFNiWUZj?=
 =?utf-8?B?dUZtZEcwZmsyeUtpbFEwT1ZkSXVUdlJWRmNpWDNYa0VKVXRpZTR2bHBSL2Ru?=
 =?utf-8?B?YUhWQjFSWWp4M0oweXU2ME5pNlZ5bUFUaFJONkVsRS8vQm9JRmRrWHJpZHZX?=
 =?utf-8?B?b1J4MXdwRlcxWDloZm82S0o1dUlxSUV0MVhoVllYbjlnVjZwa2xrbEJESVp0?=
 =?utf-8?B?T0djZjBKS2NjSUU2b1RpZlZLQnd0NnlxRlphZWIydHRmd0wwWlMyOFNkYVp0?=
 =?utf-8?B?aFNoUWloVmJTY1AvY282Z28ySCthVUlyTmZtZ2NkK2pTNjNOUmZ0eWx4b1pP?=
 =?utf-8?B?R0s2cnhCTm9GeVVVNDFybXBBc3FIOHRJL0lDWVVvY3pNUnFVcGw3WDdtNms0?=
 =?utf-8?B?MlVJN1hTNDN1cEpTSzYvamNKaDR1V2hTVlFGbVJ6SnNUR3l1bEpXOW5xUmZ0?=
 =?utf-8?B?aElYN1dwQzFHNERaQ3IrVEpoUURiZkFOY0pQUTZpL0ZUOE9YVyt6NmNDclgw?=
 =?utf-8?B?eFBoTVlBYytaRkVFeXM0cmRNZHQ2Z0FoM1pkQTV2VVlYRlBqYzVJQ3ZPTVJr?=
 =?utf-8?B?V2huSW8rb1hueGlrMHR2TE9DNkEzV080dW1IMU5NOHNZOW41dW1nWkppSGM0?=
 =?utf-8?B?TjhoUEQ3MU1NYnJvWnFYSExscUt2dThZMzk3QkZwNnMxWlZheFNlWllwK29w?=
 =?utf-8?B?dDN3Qk1vNGlVSDB5enZJL2Z5Skx4RTkyOE9kTTFGV2JBUFVRa1RvYjVjVzVV?=
 =?utf-8?B?NE51VEF3WXdTR24wYUtCdGxlZXJ4KzJLKzk2U1BWS0Y5cndqMlp0dWsrZEsw?=
 =?utf-8?B?bWM3UjhUempWVWFHYktDVXh4Q1NZcGhydjJDV2syczRJNnJ4WTlacTFOcitk?=
 =?utf-8?B?Tjdzb0VKRGpDK0dMZGIyTkhlTVc2ZjZENDZXdGUwejJub1VHeXFtK3FCcVc2?=
 =?utf-8?B?cjZaVnhVRzVnOTdsWU04V0FIN2w4c01oQ0N5Snc0cTRNY2kyNjN3U292Z2pv?=
 =?utf-8?B?dVh3NkdPZDBoNGV5cjZ2dncvVURHVUVqQzVmV3RabUo2dmQxdzRSaUV4Z204?=
 =?utf-8?B?dTVidnNkdlhtS3YzNVVpbGFGZExRdDhtZzhtYVkwTXdvN0FCU1dQUTgwdUg1?=
 =?utf-8?B?WGdRUGJ1dXRhalpNeVNVblZSVEdKWC9VNEphYTlzUmxFWjhjdzEzZjdyYUJj?=
 =?utf-8?B?STA0U3lCM25uSUJublB4WEErQ1JZZUdkVkE4VFRCNXhmWklORFhsUW94Njkz?=
 =?utf-8?B?QmFuSWxuRldhMEJqS25maEV1YWdETkNGdHpBdlBzSnJLSEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3638.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkxrS2ZZV0xJbXVWMXVtZU96Mzd0ZVVpYkFndEJjRXlwU0E5NHZ3dW1yUmU5?=
 =?utf-8?B?MGpYTlBhRk9nVVpYUVlKdWd0M2ZhWGNhSlJNOFppcCtOV09LUVVkbmI0eUhO?=
 =?utf-8?B?anZ3Z1NyeGVFZGpNQzkxaVA4K1pma1p0eVhXUDZzWk1adFpJQXZMZmFlVmZK?=
 =?utf-8?B?NStkMlNraHVLcjM5S0xvQS9RVm55WW0zRzYzUnlGWmN0VWNpYlFMRWlLNnB1?=
 =?utf-8?B?aTZBaHhXVHpxcmNreS9GZFRBcjh2SXc3VXJGNVhSVXF4bVBpSm0xNVhFc2hy?=
 =?utf-8?B?L3R2OUNldEtjb0NPQVpTbmw5c1lGaXVzdjFnVjkvaTU4UkxteGNjeTlMRHRE?=
 =?utf-8?B?anlEeXZIL2ZodjdpT2FKdHdtbEhOWkxUZGpwUGQ2dklGQ1VXbEpRdE5oWjZB?=
 =?utf-8?B?QXdRdnpVejdmNERYMDJlN1pWTmhuK1ZhSmd3b2kzSjlqNUVjYmp5TUR2NDAx?=
 =?utf-8?B?RDJVa2dNSWEyNGtJaVowcE0yVXMvVE9kVmRFNnhuS0VGRGtvWG10V0JnNEU4?=
 =?utf-8?B?L25OM2s2K1hOTUw1cFpuSTRYL1FJUnFDVHFhWGxVdk9BdjVtbDUzMUtKWFhs?=
 =?utf-8?B?VldBckJwYXNITTVxdXJPbHZILzFsMlR1QzcxK0sxbU4wdW5hN0VsNkZoRnY5?=
 =?utf-8?B?bk5xWndaTjdNVUxub3F2RHMweEJwMXZrZG5tTEdHVTV0VFd6SnQzQUJGc2NH?=
 =?utf-8?B?ZVpta0lnQ3FrZzk5RllreS9GRkZManlEODRTTTBCNFdJUDNiMlJHMDM2WkE4?=
 =?utf-8?B?TmhSYlo4UHdjMjRpK3NrSGhUbEwxSkxlb3U3Ym0vYVZibTVBdFYycUtLTnVa?=
 =?utf-8?B?UWFsdlFXc3BKTTk0ckxIYXVPWThyRWJDaWlVL2ZLcW5DRWlralFDWWxaTjF4?=
 =?utf-8?B?eG04SkpWR0o4ZitURGVXSmdackZqS2lwQWtMaGxyQjlQMzdNMjRBMS9XbU1j?=
 =?utf-8?B?Z1NTQy9wWmtSV3B1OTF1M3FsRDUveDNTQmUvQVJ4VmlRalZsR21FcUlrbWJ2?=
 =?utf-8?B?T2VJR1ViaFRBWnU4UnFmWXRYWFMzd2VnQjZabjROUjR1SGhaaWRNeStRam5r?=
 =?utf-8?B?RVdpV00ybUltR0t5RWRmSGZ6K09WdWV6UTlyczJNT2QwTWpJVk9CL3pDY245?=
 =?utf-8?B?VXBjSFBoL1p4NWFXMm9ZeTZHd1NwSmg0Y2g0WjNWb1JFSmJOdDBpdkZoa25x?=
 =?utf-8?B?YnkrQSt1aU5qK0NRTGxjWkZrakFpVGhrTDdCVmFHTHIzdzRYWk9NdWpxZ1hS?=
 =?utf-8?B?T3ViUG1SOGhEbVJadlhCZkJHYVpZTE56Q3dWYXYwMEZuT3B2QzBlSDVtZGMv?=
 =?utf-8?B?aTBxaEgyN3RFalZPUkVMaFVRRzBwNFJpdi9mRm0zT2lTeGJ1VE1KQ3ZUTjZD?=
 =?utf-8?B?bUJmSlZNbzU0SWg4emRUKzcrYVYwbWN0Z3NkYzZVT3ROWDNiK3NlcC83QnE5?=
 =?utf-8?B?OGtmdmVUd3V1cGx4cS9kSXpNS2RJdjc3RXhneUNNZ3lKMmt5UGNVdFNXd2tH?=
 =?utf-8?B?SnpZM1BMd3ZIc3R5eU1KdDMzZDJRalZYeXpmYWJRSlh1elYrTjlEWTZkZU0v?=
 =?utf-8?B?VHRtU1Q4emxabmNoSU5PZmEvMXZoY291TEI4SHJKdS9IMm4wT3pDMHdhRGZj?=
 =?utf-8?B?V0JPUXROK0hTSVhXd3lldGg4a2RGNEZBRFpVL2ZSSUxUMCtUcjF0aWdqb2lH?=
 =?utf-8?B?SmNnSUU1Rk1BMzh1OVc0c0RIWndNL0VNNG9nNnZIS3VmcFh4SDBCT2VrdzBu?=
 =?utf-8?B?VEMxU05RMUJGNnpXVEtBdzA5OWprdXhVR2lYaUlkQ2d3T2JrRlBISTBwZmcx?=
 =?utf-8?B?Z0xFcnZPM0d6V0pGYVVHS1pOa3dDR05jRm5RRXB0Y1gydXF0V2hIK3p4S3Vk?=
 =?utf-8?B?YW5EMzJ1VHhudk5NcTVZZ2pvRmZDRnM0R3I1MUhCTXVoNDVNblpyZkpWOVFR?=
 =?utf-8?B?SzZOVXUvRjN6Z2RIME5VWWx3a3I1ekZ4MSszUHJmSkUwRFdGZ29FR2twalls?=
 =?utf-8?B?azM4K0NZbVZiNXh5clQvUE15bnNjMlNiSDZVMzNGLzBjeit2V1Z1SFhPK0tx?=
 =?utf-8?B?WHAzWUEvbTd1aUZtY0RpM3ZZV0tGWno2VHBoMkdTeEQ2Ti8yclQvNnFZc04r?=
 =?utf-8?Q?x3xqoh9+SUE/Ox58FUtnl01Eu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mNLXIR3gBW9IPz2K2PWWXRMacXdqi+6R9FGZ5Yvy8opXuVF2x2GYzvTEmH1ZAl6fACXvT76tOtsnBkfvXjzm+Nc0w3DmD1L9TWaI/7039C1nq/KJOo+WKqPKBG+qmSAc5YvdLeJ5haGLB5oKOSVi/mMgRuc0WV9l4qFLXuz1LNP1sTrkjjaJEt2oirThLmJwnGMJwcJLPmAxXX3PeI/r1Yl7yBUTrvszjCcpmZ81ST9JmVa5iXZNXKBONkL0xdQvEctIhOo0QhECD6s7clwa5S3f5ipMqg+NAGCNE3Lz4ngVBNXu3COFORWMYF+V3zTnyRqPeQydUvfrQTAR7ZebrxPl97hk7eRypbX0T7+7aQTNwu8f1F5ZKtjr0VpZKbr65P3GbPE7J2ZuJxUGMptwOXV9LunaB8bF2558gJeCHTiiSDhIIfr/8hpogmM2WIOWHf4T1ue5JNqnnl8OzxsBBgNXBuqSkb6ZJnxc6u25TiZGGKzpiB61cLIc10PhbKjlC3/U8AnIsfR7/NjqjDOgaOwJ6cSNDcU8qJ88WfobXSmMuIoOdvkRLWWLiDBLF/juCT+FU+gMaH2JZJbs9PnJM2GVyu1glMkKty96yFkKCNUbhsBRW4WafB0xt0Or4Qcd
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3638.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a00fb2-f652-4dea-85c7-08dcdddb95b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 03:30:35.9134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+pcJfg30bAzaGQKR6fDOVeT8J4O/9rnP6A32LjoE6KRnLPgW2ntDhYZ+c8AB0Y2xiuJUPMf4DJ0MgyLf8pGat071ZEk0mO7vtBp5VbE+m0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9105
X-Proofpoint-GUID: HFK1DMoqRDX5xERFfYQ0Nahkf07cnvTu
X-Proofpoint-ORIG-GUID: HFK1DMoqRDX5xERFfYQ0Nahkf07cnvTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409260020

SGkgQEphc29uDQoNCkJvdGggaHlwZXJ2aXNvciBhbmQgYmFja2VuZCBkZXZpY2UgbWF5IG5lZWQg
dG8gc3VwcG9ydCB2aXJ0aW8tbW1pbyBkZXZpY2UgcmVzZXQgDQpBZGRpbmcgQ09ORklHX1ZJUlRJ
T19NTUlPX1BPTExfUkVTRVQgaXMgZm9yIHRoZSBzeXN0ZW0gdGhhdCBoYXMgc3VjaCBzdXBwb3J0
Lg0KDQpBIGNvbmZpZyBvcHRpb24gKGZlYXR1cmUgYml0KSBpcyBhIGJldHRlciBhcHByb2FjaC4N
ClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KQlINCkppYW5ndW8NCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IA0KU2Vu
dDogVHVlc2RheSwgU2VwdGVtYmVyIDI0LCAyMDI0IDM6MzkgUE0NClRvOiBKaWFuZ3VvIFN1biAo
UVVJQykgPHF1aWNfamlhbmd1b3NAcXVpY2luYy5jb20+DQpDYzogbXN0QHJlZGhhdC5jb207IHh1
YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tOyBlcGVyZXptYUByZWRoYXQuY29tOyB2aXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC5kZXY7IEFuYW50IEdvZWwgKFFVSUMpIDxxdWljX2FuYW50Z0BxdWlj
aW5jLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBWaXJ0aW86IEFkZCBDT05GSUdfVklS
VElPX01NSU9fUE9MTF9SRVNFVA0KDQpPbiBTdW4sIFNlcCAyMiwgMjAyNCBhdCA4OjM14oCvUE0g
Smlhbmd1byBTdW4gPHF1aWNfamlhbmd1b3NAcXVpY2luYy5jb20+IHdyb3RlOg0KPg0KPiBBZGQg
Q09ORklHX1ZJUlRJT19NTUlPX1BPTExfUkVTRVQgdG8gYXMgYW4gb3B0aW9uIHRvIGVuYWJsZSAN
Cj4gc3luY2hyb25vdXMgcmVzZXQgZm9yIHRoZSBNTUlPIGJhc2VkIHRyYW5zcG9ydCBmb3Igdmly
dGlvLg0KPg0KPiBDaGFuZ2UtSWQ6IElmYTdlMjliNGMwY2ZhMjY5MjI1MzVmOTIxYzZhYjY5ZWFj
ZGM0Y2ZjDQo+IFNpZ25lZC1vZmYtYnk6IEppYW5ndW8gU3VuIDxxdWljX2ppYW5ndW9zQHF1aWNp
bmMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmFudCBHb2VsIDxxdWljX2FuYW50Z0BxdWljaW5j
LmNvbT4NCg0KQW55IHJlYXNvbiB0aGlzIGlzIG5vdCBhIGZlYXR1cmUgYnV0IGEgY29uZmlnIG9w
dGlvbj8NCg0KPiAtLS0NCj4gIGRyaXZlcnMvdmlydGlvL0tjb25maWcgfCA4ICsrKysrKysrDQo+
ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZpcnRpby9LY29uZmlnIGIvZHJpdmVycy92aXJ0aW8vS2NvbmZpZyBpbmRleCANCj4gNDJh
NDhhYzc2M2VlLi5mYjE3YjEwNzhkNTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL0tj
b25maWcNCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vS2NvbmZpZw0KPiBAQCAtMTg4LDQgKzE4OCwx
MiBAQCBjb25maWcgVklSVElPX0RFQlVHDQo+DQo+ICAgICAgICAgICBJZiB1bnN1cmUsIHNheSBO
Lg0KPg0KPiArY29uZmlnIFZJUlRJT19NTUlPX1BPTExfUkVTRVQNCj4gKyAgICAgICBib29sICJW
aXJ0aS1tbWlvIGRldmljZSBzeW5jaHJvbm91cyByZXNldCBzdXBwb3J0Ig0KPiArICAgICAgIGRl
cGVuZHMgb24gVklSVElPX01NSU8NCj4gKyAgICAgICBoZWxwDQo+ICsgICAgICAgICBTYXkgeSBo
ZXJlIHRvIGVuYWJsZSBzeW5jaHJvbm91cyByZXNldCBmb3IgdGhlIE1NSU8gdHJhbnNwb3J0IGJh
c2VkDQo+ICsgICAgICAgICB2aXJ0aW8gZGV2aWNlLiBBZnRlciB3cml0aW5nIDAgdG8gZGV2aWNl
X3N0YXR1cywgdGhlIGRyaXZlciBtdXN0DQo+ICsgICAgICAgICB3YWl0IGZvciBhIHJlYWQgb2Yg
ZGV2aWNlX3N0YXR1cyB0byByZXR1cm4gMCBiZWZvcmUgcmVpbml0aWFsaXppbmcNCj4gKyAgICAg
ICAgIHRoZSBkZXZpY2UuDQo+ICBlbmRpZiAjIFZJUlRJT19NRU5VDQo+IC0tDQo+IDIuMTcuMQ0K
Pg0KDQpUaGFua3MNCg0K
