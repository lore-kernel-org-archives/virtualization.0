Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26B9215177
	for <virtualization@lists.linux.dev>; Mon,  9 Dec 2024 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736609; cv=fail; b=ptFiIFOulca1PA+0cpfgQtk6kwyUhxk8aeYkwakcj0BmJwP3QfelmVrz/u9rF9Gh11Hj3l3NqmVB9gY+hFjkEsittGctB7i+M1O1LkrYfmKjA8Hw3FeeJM9iG/77sJ6FjnDmmz+o9KxUymzKgJ2iDwfLAd1H1Lb0ePyh55Kh16I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736609; c=relaxed/simple;
	bh=x7dKWLcUcqM0vXrUOlLpi09W77mjaKStDumqK2+49OM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dILl+eOhAikKb/gmQAU1dIQHfcDPhSF7TJ21EJpXn2+f7omBSTd034Kcqj7w3T/pt7BCZ4rLghcYJFS8GSTn/4HcWjvbP03I6k3YlDSSAZThxg+jDIpKPcQ304oq/VyFTccBsQM2bUwBmiL4TGc88+XArhpf0+Pvx9zew9o8Mw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=QOF4+9qS; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="QOF4+9qS"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9706cF005397;
	Mon, 9 Dec 2024 01:29:59 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43dus5g8nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 01:29:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tO1vvBTCeJ9W/nhEn2Z3F4/sFig1QqqYcdZIM/kEl0LaZAoXFsLjadm2obn9U5Y8MXN7i1CpPiWrAa6n5Fb3pCk7LqYkKZ/Y4vDHR6vHt6rte4aeXqZPmvoSnxZGLRaVrGt/4KJV1/6ZnFPgce6yTHaj3MH9cYMKC5AKhM8UcOo0jeuTFWfdBI5DZZ6bcgjb2sNG96qJ6BmnSVX/NCufnAmlSpN9S/wc36q1dwqTz8mmDF/bmX2cI2NBrdsYs1RnsXasskJMfH+yU8QxZSTUbI3TQJxRwPVc/OfvXZjaz7IPTCEpnkLK96cKVlz2+j7oaDcLpuL/yLsoQiOu8o/Qdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7dKWLcUcqM0vXrUOlLpi09W77mjaKStDumqK2+49OM=;
 b=jzT2LjQSIxDdmxiHgrK/pasU1eEPzu4yi4Mcq2JuAtGwdiK1kxtLR08qO4px2x15pVSv/jUYfneYtdr79Y+GTZt8d0VLSR8j6WeL9OJNfz4s8ayBArqYNgQL0nJEldLz5BeelRxPuDyandXDhsHQA2CNhYVm2W99V3I/74vBBwcw1RiWp2zgigGXRI52yY+otAfaYhCkQx7nAfLJx7FjkKPkcRz+FlO/uTbksGaw4B970yKnsmisqu6x5w3iIO5USx6az2QVMn/+MS3h0qZ101LOeD0VRGcmlHWl85l+8HZ50sRjS3r40YSkWIM7TmXk9EYZuoYAYbB3PuIbAS9Ifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7dKWLcUcqM0vXrUOlLpi09W77mjaKStDumqK2+49OM=;
 b=QOF4+9qSdaEwicWzgXx4SVRGbZLRIdVjrGVr75weoXyVHjDQB/niWlFuwTRS+xmH9uGld61IGZIUg1w/AQBCJev6gZX6D65kMZ3ACjs5z75tQX8UBh/7BsRKdJLjsK2f8LKlrJUWw0gnxOvHt9iZuIboDTKFyuDikSqafKGNJzg=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by PH0PR18MB4701.namprd18.prod.outlook.com (2603:10b6:510:c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:29:56 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%6]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 09:29:55 +0000
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
Subject: RE: [PATCH v2 4/4] vdpa/octeon_ep: add interrupt handler for virtio
 crypto device
Thread-Topic: [PATCH v2 4/4] vdpa/octeon_ep: add interrupt handler for virtio
 crypto device
Thread-Index: AQHbR9YxPyC7yGrAokm/Bwpmk21207Ldoniw
Date: Mon, 9 Dec 2024 09:29:55 +0000
Message-ID:
 <PH0PR18MB4425117E2D92C46980DBF4D1D93C2@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20241121134002.990285-1-sthotton@marvell.com>
 <20241121134002.990285-4-sthotton@marvell.com>
 <CACGkMEtydc4q5Dc1wwN52na37uWLf24e-Tmp6rYmKyg0TDgXUg@mail.gmail.com>
 <PH0PR18MB442581F8A6914C40E0FEE414D9312@PH0PR18MB4425.namprd18.prod.outlook.com>
In-Reply-To:
 <PH0PR18MB442581F8A6914C40E0FEE414D9312@PH0PR18MB4425.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|PH0PR18MB4701:EE_
x-ms-office365-filtering-correlation-id: 8b7eec3d-da7e-496e-a7c6-08dd18340af7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T3VvQzdlTEV5NFY5bzQxakRvWWhQUjRETGpUNHpseVE4TWNubVVDcnlIS0Zu?=
 =?utf-8?B?ajdnRDlNNUdlbjZNc0JmaUdMVFpsUXNoT2w1ekR2THJ4NVdzYmZLemhmRDVl?=
 =?utf-8?B?OCsxZW5IUllkNU1VZGNVNjljRWh2VDBEdnN5eHZRTEt3OFFITE95YWgvTzUy?=
 =?utf-8?B?R2NYMnhXYzNzOFBZQmhrSmhjNnhYcEJMbUhzSk5nMFRyMnNoU20rSkgwTktO?=
 =?utf-8?B?cy93ZVJhRERyOFE1dFFlK2ZCSjhoc3VIdnBNNkhTWDRwZWhFOFZILzgwelV3?=
 =?utf-8?B?VXN2T3NEU3RCb1M4K3VlS2xGWEYxdHJuZ2hUdmJUblVqWTIzNXBXOFJuRzBx?=
 =?utf-8?B?NjQxanhKWDhWMkhzLzNuSURDV3o5VkMrZnFOcmNIR1ZDVWRKUUVGQTZyNlVB?=
 =?utf-8?B?SVpiUE9heUc1Kyt6eHROcnZ5a3pCUGR1ZkQ3emtsUWNQTkwvTStWZnJ4d3dw?=
 =?utf-8?B?UnVuNFZRSm5rMWkramdVUkZnVVo1Qms1Y3JJN1ZJOUtyTDdNdXFYR2UrSGxR?=
 =?utf-8?B?T3VSYXkrVnAzK3AzNmtIMXAxNDRyMEszemxuQ2d2UnJnbWZLTFlqZmtianhL?=
 =?utf-8?B?MmI4Vzc2aGZXcldab0Z5Uy9iNVNFMmlsMjVhOEZhY0JwNmVuVExacVNZZEhB?=
 =?utf-8?B?ODZ4RDVhNGxaVlAvbTFnTEloekhjZjBYNXpGQzdCTWRSb2F5dksyYkZUWGhS?=
 =?utf-8?B?ei9DeFZ0VWdQbkM2dklOUUZsZ2Rodjk4U2dBWEFDMm1KRlVjV280T2tjZlNQ?=
 =?utf-8?B?NEVBMW42VUxpazNBNC9XQnlJai9BWlB2bXN2QUFZK0N4ODd1NzRvRzJaYTc1?=
 =?utf-8?B?NWJOa1dqQzY2NERrUWVuMHN6Zm1aS3RZRk80aVNkdTRjTmhrc3JlNUgyOEdR?=
 =?utf-8?B?WjRQaE9qTmxJZWRSZ3FPTnA5RW9lY0V1Q1FEQVJQQ1UrN3pQYlhoZ1VocStE?=
 =?utf-8?B?cWxjZWVJT2ZBc3ZMOWJjUnRySU5nTGJxMmpHb2lpZEdIeHdtVExqV28wS29Z?=
 =?utf-8?B?czJQUkFWNGdtMGhvdTJaQ3UwNGhCVHhOdG01RXBQMjlrRGdtZVIyYUhCcDNy?=
 =?utf-8?B?Wng2VmRuNHVySlhkMmtxRmZTMXRiWWNNWmJ3NWYyV082aUgvSlVJcy93OVlJ?=
 =?utf-8?B?V3NTbVpXZUlEeFdKcDZHQ1ZxUEtHL0l4d2FRWE1wWk9lVkFGNUlkL2dPVFNj?=
 =?utf-8?B?d1FtVzNZZE4vKzNkQUN6eHd1T0szZFdBWnhRNEZrVGVGSTNaS0JwbHJMeEo0?=
 =?utf-8?B?VzZ5ZVJtZ1JRTHE3KytyMUJHS3pLcmpIWHdkcHdjaSsrUmpXTy90eC9kejI2?=
 =?utf-8?B?RG56N2RmOG5BZkd5b0NiaG9ySGlXZ2t0akZzTy9ad2dJZkNpR1NZaVdvYkE4?=
 =?utf-8?B?WU5UVExsNWdMUmpQMFQyMG1wbVJTSGFORHlKdG45SHJKOU1xNm9HYnZDNVg4?=
 =?utf-8?B?NTNYNXZxeGhUUElnQVRFTTllZ01lZ0NZV2lYcEwrQjhpcGlrcEQ2RWF4a25I?=
 =?utf-8?B?dmdtQUU0SlRua0lHbS9PaVFaL0JiQ2RNQ0NLOEc3QUY3U00rMmtZRkc3N1pS?=
 =?utf-8?B?ekhSOE1ualZuNllzVnV0cXJrQjE3aHA3THlRdnZlWkhxWWRHTTlnWFplRVha?=
 =?utf-8?B?Y09jMEZuVWV1RVBwR0ZVTWlDN0FzZGxEd2JheTFWVlVsNUQ2ekxPV1JXRldu?=
 =?utf-8?B?Q1V0VmFNT3Bkc3Zhem1FU2cyTFNjMWVTK1hySHdoUTJyR2FrclBEN0twa1FQ?=
 =?utf-8?B?K3B6RitoMzFOZG9JVTNkOXBpUzFKWmZTMjk4Vit0d3BSWjZDS0VLSi91UHk2?=
 =?utf-8?B?bjZvZjVRM0NMdWsyeFdiTWdQSDJYaU1EM0o1VlFYTUxoSjBUVFZSM3B6Ulpt?=
 =?utf-8?B?YUJwMWdhZTRVcVdMUS83TDNXUWlHUjJ5YS9abERHZUlLNlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y01iTmhOQWlHUFZPQ1VXSW1vN2V5WmJ5ZlR2L2FBd2JiLzFlWVlBSFVINVRm?=
 =?utf-8?B?djcvakx0b2NZWVBVRmxKMWRWcFZQdjZmbEZyN3JndmV3NnpsRHBoaWZ6ZnBp?=
 =?utf-8?B?Tjg0a2xDTVVtUGN4aXczWVdUdHRBbHN2cithNFJmVW9nMDM2K1hCQUVMbktX?=
 =?utf-8?B?TFRBNVhnS05rUVM5MVl3U1p2TG5GNGdka3B6a0cybC93d21NbEtRYWRreEE3?=
 =?utf-8?B?YlYzU3FkSGV6N0prcVNDWk9RcVNEZ0RabEJXV29JdCtZMU9qQ1M2QnlBZjM1?=
 =?utf-8?B?b2d1QTVkaVcxeHplWXYvSi9XelRJUk4wRkU5enk2SlRjZExNLzdVSnowOTFT?=
 =?utf-8?B?QkN1bzdRNDdsblY2QTNidEJ5WForOWdlUnI1dUk0Q1d4aktaSGRoWExsc0FM?=
 =?utf-8?B?V2FuelRXby96Q3ROM1NGUHB5eURGYk9iMDVIVFFTNlNwdzIzSmF3TzRTOG5I?=
 =?utf-8?B?c05DWTJINFpDSUhPcmQ4UUZZQWM2eTJ5dnlnUVBPWHROeWE4NDJ2MTVQQkNr?=
 =?utf-8?B?YjA5YWtxVENVYWFhOE01d2JabGRpcjdoK3E3SFArcE5mdGV4eFlXVm1hdUFr?=
 =?utf-8?B?WFBxT1pLdU15UlAwZzBJTXlDbnhhMlZFKzdvMHlFQzFHQ3ZONmNnUTV3VDg3?=
 =?utf-8?B?eWNNWWd4Z0dYUEdmVDExV3Q1Ry8wNU5OVkNDT1VrcFZDTFFMWkpMR2Ztb2U1?=
 =?utf-8?B?T3I5UXA3dllkQmpjUlVPajc3UGZ4emNtcnJtTUwvSGZ1UnFUR1RMbWR6bkpz?=
 =?utf-8?B?WXlva1RnWmt6cWxIckRBNmNoWmE3RnRFVU1icUYvSGJpOTdCL3RXWFl6ajZo?=
 =?utf-8?B?dGsrVSsvUmdFczQyYzlvUGpRN3RRL1Y2Ym51N2NQZHJPTlN1MWJjbkxJamsv?=
 =?utf-8?B?cm9md2UvdnJBQnNVTndkQkdKSlRlUVVJYnNuQ01GOGVXeVAyeXNDOWN1VkFT?=
 =?utf-8?B?dkVoSlRId2dFaFVscUdvd3BZeHRyaWtTTDUxU3llK25lMkdJWWgvQktoU2Zv?=
 =?utf-8?B?YW1vOWthSFNXbHFLUHFGcWxyVkFQdk8yV1h5RGhaTjRhSnNIbzN3YWxTalI1?=
 =?utf-8?B?bmY1R1k2WTg2Mm1IM3ZIUlVvZ0xaTHIxb0p4U052QTBCMG9yU1lhZEJ1STV3?=
 =?utf-8?B?OUEvcm1GOW1oRVZOZ3pTcnEzRVgraWRVZzB2ZUJLZHU3MXc3U3l6MUMycmhO?=
 =?utf-8?B?bXVRdjJ6OXZkay81NlNVUDRZelZJRkI3VllmaFJ1WDFTU1JUamxQZnl5YTlZ?=
 =?utf-8?B?czJJRGZCTmdocHRmYkVYcHRKVUMraFpkeTFYUWRBRS9kUEFueUNDKzJQcWlC?=
 =?utf-8?B?L3VmdjE2MUZaL0RoU3NJTys4cm9jL3lhZC82MFkzTzkzVWQ2Qlpwa1AyTlhp?=
 =?utf-8?B?aVFKdWFDSzk1bXYyMWp0T1R2U1Y2R3RmZXJjUGQ4TUlHRy9DVlV1SE9kN3I1?=
 =?utf-8?B?MWlwQTBzOFNiNlNJZVprYmIxdnhWUlI2d0RDRlRuVWFocUUvK1AvditqSnNV?=
 =?utf-8?B?bDRHK1d5VTIvdWl3b1ZkNUdzWWxCNUI4R0dSMHpEVUVsNkVoL01EOGprd1U1?=
 =?utf-8?B?WmhJSllVaXBJK3piUjVGRG1JdDZzZnlMUXVQYzFQazVhUjFsRFI3UE1vT3hF?=
 =?utf-8?B?L05rM2pITGxzdnF6MmxSazdYVUw3dzVJYnBzKzFtV1hlb0FTUVRWVlM0RDhn?=
 =?utf-8?B?clo2M1dJbVQrZHFCMWphOWN6VDNHMkxhTUhXc0dUNFp4NTVRYWUxN25LQ3dj?=
 =?utf-8?B?WU1Fa1M1Y1YyaWJZbmlyWGtpWGtrd1JqazVFaVY2VU1KZ20yc2pKOTVwNU41?=
 =?utf-8?B?YU1vL0FmSXQxSHNVZUNoUUVDNVdKTnlpVlBPVTdtczd4V0hmamZFNjJTdjdt?=
 =?utf-8?B?TGd6UHhib05BQmhwQnA3VFBYdndVaUNWY2tEY0s2ZWlzL3JlTjBzcWdKVVlx?=
 =?utf-8?B?Z3dLblNJZUFVUm0yaDdkT0JTU0JMNFJ5Mi9IUE1vM1plTnpqVVBhTzB6MFBO?=
 =?utf-8?B?L1JOblBGV0JMYnVrejNZbGliVVd6SUdKbTVScmJ6WDhuK0k2blBDYUpWUWFs?=
 =?utf-8?B?MUFpemJHdXo1RFhicTBkaXB0VTVrMVUwODZZRTJRTmZGbDI5clordzVDdkVW?=
 =?utf-8?Q?TD7CKLeFxTbzt69PbrYJTQdg7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7eec3d-da7e-496e-a7c6-08dd18340af7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 09:29:55.7264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXZKyrpHKIcZjhvQJrrUDzySK7PJttXza12iXVCPpXgYLaucSPSe4SXQwJ+soWNaRX95igCtgNAkmAGxJaZNWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4701
X-Proofpoint-ORIG-GUID: pyzjTwK3la2GWHehhJFQ8hYZC6kz7LHI
X-Proofpoint-GUID: pyzjTwK3la2GWHehhJFQ8hYZC6kz7LHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Pj4+IEludHJvZHVjZWQgYW4gaW50ZXJydXB0IGhhbmRsZXIgZm9yIHRoZSB2aXJ0aW8gY3J5cHRv
IGRldmljZSwgYXMgaXRzDQo+Pj4gcXVldWUgdXNhZ2UgZGlmZmVycyBmcm9tIHRoYXQgb2YgbmV0
d29yayBkZXZpY2VzLiBXaGlsZSB2aXJ0aW8gbmV0d29yaw0KPj4+IGRldmljZSByZWNlaXZlcyBw
YWNrZXRzIG9ubHkgb24gZXZlbi1pbmRleGVkIHF1ZXVlcywgdmlydGlvIGNyeXB0bw0KPj4+IGRl
dmljZSB1dGlsaXplIGFsbCBhdmFpbGFibGUgcXVldWVzIGZvciBwcm9jZXNzaW5nIGRhdGEuDQo+
Pg0KPj5JJ20gbm90IHN1cmUgSSB3aWxsIGdldCBoZXJlIGJ1dCB0aGUgcmVjZW50IGtlcm5lbCBk
ZXBlbmRzIGhlYXZpbHkgb24NCj4+dGhlIHR4IGludGVycnVwdCBmb3Igc2tiIHBvc3QgcHJvY2Vz
c2luZyBhcyB3ZWxsLg0KPj4NCj4NCj5DdXJyZW50bHksIHRoZSBkZXZpY2UgZG9lcyBub3Qgc3Vw
cG9ydCBUWCBpbnRlcnJ1cHRzLg0KPlRoaXMgYmVoYXZpb3IgbWF5IGNoYW5nZSBpbiB0aGUgZnV0
dXJlLg0KPg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogU2hpaml0aCBUaG90dG9uIDxzdGhvdHRv
bkBtYXJ2ZWxsLmNvbT4NCj4+PiAtLS0NCj4+PiAgZHJpdmVycy92ZHBhL29jdGVvbl9lcC9vY3Rl
cF92ZHBhX21haW4uYyB8IDUyDQo+PisrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4+ICAxIGZp
bGUgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvb2N0ZW9uX2VwL29jdGVwX3ZkcGFfbWFpbi5jDQo+PmIv
ZHJpdmVycy92ZHBhL29jdGVvbl9lcC9vY3RlcF92ZHBhX21haW4uYw0KPj4+IGluZGV4IGQ2NzRi
OTY3ODQyOC4uMWJkZjdhODExMWNlIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9vY3Rl
b25fZXAvb2N0ZXBfdmRwYV9tYWluLmMNCj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvb2N0ZW9uX2Vw
L29jdGVwX3ZkcGFfbWFpbi5jDQo+Pj4gQEAgLTQ0LDcgKzQ0LDM1IEBAIHN0YXRpYyBzdHJ1Y3Qg
b2N0ZXBfaHcgKnZkcGFfdG9fb2N0ZXBfaHcoc3RydWN0DQo+PnZkcGFfZGV2aWNlICp2ZHBhX2Rl
dikNCj4+PiAgICAgICAgIHJldHVybiBvY3RfdmRwYS0+b2N0X2h3Ow0KPj4+ICB9DQo+Pj4NCj4+
PiAtc3RhdGljIGlycXJldHVybl90IG9jdGVwX3ZkcGFfaW50cl9oYW5kbGVyKGludCBpcnEsIHZv
aWQgKmRhdGEpDQo+Pj4gK3N0YXRpYyBpcnFyZXR1cm5fdCBvY3RlcF92ZHBhX2NyeXB0b19pcnFf
aGFuZGxlcihpbnQgaXJxLCB2b2lkICpkYXRhKQ0KPj4+ICt7DQo+Pj4gKyAgICAgICBzdHJ1Y3Qg
b2N0ZXBfaHcgKm9jdF9odyA9IGRhdGE7DQo+Pj4gKyAgICAgICBpbnQgaTsNCj4+PiArDQo+Pj4g
KyAgICAgICAvKiBFYWNoIGRldmljZSBpbnRlcnJ1cHQgKG5iX2lycXMpIG1hcHMgdG8gc3BlY2lm
aWMgcmVjZWl2ZSByaW5ncw0KPj4+ICsgICAgICAgICogKG5yX3ZyaW5nKSBpbiBhIHJvdW5kLXJv
YmluIGZhc2hpb24uDQo+Pj4gKyAgICAgICAgKg0KPj4+ICsgICAgICAgICogRm9yIGV4YW1wbGUs
IGlmIG5iX2lycXMgPSA4IGFuZCBucl92cmluZyA9IDY0Og0KPj4+ICsgICAgICAgICogMCAtPiAw
LCA4LCAxNiwgMjQsIDMyLCA0MCwgNDgsIDU2Ow0KPj4+ICsgICAgICAgICogMSAtPiAxLCA5LCAx
NywgMjUsIDMzLCA0MSwgNDksIDU3Ow0KPj4+ICsgICAgICAgICogLi4uDQo+Pj4gKyAgICAgICAg
KiA3IC0+IDcsIDE1LCAyMywgMzEsIDM5LCA0NywgNTUsIDYzOw0KPj4+ICsgICAgICAgICovDQo+
Pg0KPj5TbyB0aGlzIGFsZ29yaXRobSBpcyBtYW5kYXRlZCBieSB0aGUgZGV2aWNlPw0KPj4NCj4N
Cj5ZZXMuDQo+DQo+PkknbSBhc2tpbmcgc2luY2UgaXQncyBiZXR0ZXIgdG8gbm90IGhhdmUgdHlw
ZSBzcGVjaWZpYyBwb2xpY3kgaW4gdGhlDQo+PnZEUEEgbGF5ZXIuIEFzIHRoZSBiZWhhdmlvdXIg
b2YgdGhlIGd1ZXN0IG1pZ2h0IGNoYW5nZS4NCj4+DQo+DQo+VGhpcyBsb2dpYyBpcyBjbG9zZWx5
IGxpbmtlZCB0byB0aGUgZGV2aWNlJ3MgYmVoYXZpb3IuIEkgd2lsbCBjaGVjayBpZiBpdCBpcw0K
PnBvc3NpYmxlIHRvIGF2b2lkIHRoZSBkZXZpY2UtdHlwZS1iYXNlZCBsb2dpYy4NCj4NCg0KSSB3
aWxsIGRyb3AgdGhpcyBwYXRjaCBhbmQgdXBkYXRlIHRoZSBpbnRlcnJ1cHQgaGFuZGxlciBpbiB0
aGUgZmlyc3QgcGF0Y2ggb2YNCnRoZSBzZXJpZXMgdG8gbWFuYWdlIGJvdGggZGV2aWNlcy4NCg0K
Pj5Gb3IgZXhhbXBsZSwgZm9yIG5ldHdvcmtpbmcgZGV2aWNlcywgaW4gdGhlIGZ1dHVyZSB3ZSBt
YXkgc3dpdGNoIHRvDQo+PnVzZSBhIHNpbmdsZSBpbnRlcnJ1cHQvTkFQSSB0byBoYW5kbGUgYm90
aCBSWCBhbmQgVFguIEFuZCBub3RlIHRoYXQNCj4+dGhpcyBpcyBvbmx5IHRoZSBiZWhhdmlvdXIg
b2YgTGludXgsIG5vdCBvdGhlciBkcml2ZXJzIGxpa2UgRFBESyBvcg0KPj5vdGhlciBPU2VzLg0K
Pj4NCj4+PiArICAgICAgIGZvciAoaSA9IGlycSAtIG9jdF9ody0+aXJxc1swXTsgaSA8IG9jdF9o
dy0+bnJfdnJpbmc7IGkgKz0gb2N0X2h3LQ0KPj5uYl9pcnFzKQ0KPj57DQo+Pj4gKyAgICAgICAg
ICAgICAgIGlmIChpb3JlYWQzMihvY3RfaHctPnZxc1tpXS5jYl9ub3RpZnlfYWRkcikpIHsNCj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAvKiBBY2tub3dsZWRnZSB0aGUgcGVyIHJpbmcgbm90
aWZpY2F0aW9uIHRvIHRoZSBkZXZpY2UgKi8NCj4+PiArICAgICAgICAgICAgICAgICAgICAgICBp
b3dyaXRlMzIoMCwgb2N0X2h3LT52cXNbaV0uY2Jfbm90aWZ5X2FkZHIpOw0KPj4+ICsNCj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICBpZiAobGlrZWx5KG9jdF9ody0+dnFzW2ldLmNiLmNhbGxi
YWNrKSkNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9jdF9ody0+dnFzW2ld
LmNiLmNhbGxiYWNrKG9jdF9ody0+dnFzW2ldLmNiLnByaXZhdGUpOw0KPj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGJyZWFrOw0KPj4+ICsgICAgICAgICAgICAgICB9DQo+Pj4gKyAgICAgICB9
DQo+Pg0K
