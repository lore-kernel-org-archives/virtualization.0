Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F59215F6D
	for <virtualization@lists.linux.dev>; Mon,  9 Dec 2024 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737189; cv=fail; b=kvqksN1WLubdgY7Bun8zGMIU7GPE38p813XTywqrV0NSkyTgG4VhTuoQLWihikE/VCVYvaggkSgmp3Gt7aHU+wsgRW5GtRkk11uKGu2F79IVp7gGBvF9N1QgpshRBfR32mnyv9XYJPLDs3jOjnp+cxlhPpdBVXWmEWMYxLZOhLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737189; c=relaxed/simple;
	bh=APmaSNWAMWV/+RjuG0wtzLZj5hQNPNPflfdbL+eMPlU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=no0rSaa+xt1QQMXkh5aXmwdKsbFKWmjV2HOjwkL34bDEmTZ/XKmFEiBYbpOGQxGTgF1hLEm2sGMu8mx6O+Eu/bmhzKZTnV9ttEp/93jI+NRCq8Q3u58V0OAm9VsLG4dAkSfqfpi7WV5xzEbRXTu5Ey99InS0T3Fq9lnd6dGIBFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=OLSyTUbY; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="OLSyTUbY"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8NQY5e021160;
	Mon, 9 Dec 2024 01:39:35 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43cprpk0wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 01:39:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pg4QhsY6Qb775gUcaKHYCb/iasekJjx3eT2zKnUu9rhmqFhM7oHMs3frTauOa8X+Bi+n9y5y6G6hJRopjekV0U3OUUIcv/ZB79ptiEJka+AGywX2LCyuLNHXb/TQ/iSL8RRg6dsxsozpkr+do6tkXAJ1oMUcCa4CKJa3c8HYUr31iXuGoo3QD/8xY9mVICPBWQEarUgkcc53D9l1pX3Z2SDrkGiLmz8gGmjxkjJmqOY7BOx8ZCHAQdyQIE9zlztQMJI2v7K94hotyn5xe9ib/s1+hEQT3Gq/i7Ky9I1EK6WbVwZiqmLLxQT0UasJKuT4aAeEuq6XhmBszZU6bxBecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APmaSNWAMWV/+RjuG0wtzLZj5hQNPNPflfdbL+eMPlU=;
 b=mvb+OOzomxBD2Ei4DH4d8gWkxXxdyHpBykkvafYnLS87TEF30dQYdIq46m4Oyr2e2C7CLa6uxzOL9CDZZHh8kWFPMfTkHb5eYTKIW017qjXWhsrSwkwmKWSs9Rcp6pJlrMx036xj5PPTteBEYOnRjKL1Bo9mU55MWsB3l1Jeo9e7GBdbfvW7HcLLbFSeVLuP9tHtzNur6pfMZ0paGP8U2cB6fnghiSAMRg213zdhs5YbX3w0LhrypkEbXIVjhdgJ5mkMnzO/aWwu+lolE0oLWb6XwR0qcMm9YqWa3/sCwrVbtEP1dqFNFhykjQX+PmE4DCygqeorC8nMPy8stOS9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APmaSNWAMWV/+RjuG0wtzLZj5hQNPNPflfdbL+eMPlU=;
 b=OLSyTUbYG1X1GbxX0gzBdAQfxUfVa6QAs9I9HJecS1DUOGRxumK0n5/oRUEpJXQNdCWD0mXUxQSQvjSmtEb/vIIYMnXkTxYNVzQb9SCkv/+skzA1cmKQHRs2jrMTaLQqDHyWIRUpePJFNMnBR0Bxlzrdge1gmP/I3xqhVHRIcFs=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by DM4PR18MB4160.namprd18.prod.outlook.com (2603:10b6:5:38b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 09:39:32 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%6]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 09:39:32 +0000
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
        open list <linux-kernel@vger.kernel.org>,
        Shijith Thotton
	<sthotton@marvell.com>
Subject: Re: [PATCH v2 1/4] vdpa/octeon_ep: enable support for multiple
 interrupts per device
Thread-Topic: [PATCH v2 1/4] vdpa/octeon_ep: enable support for multiple
 interrupts per device
Thread-Index: AQHbSh5AwkhK96DqH0Wil25bBOBaPQ==
Date: Mon, 9 Dec 2024 09:39:32 +0000
Message-ID:
 <PH0PR18MB44252BB64B7CBABED515FBDBD93C2@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20241121134002.990285-1-sthotton@marvell.com>
 <CACGkMEueyPOfgA4W72CMCZHP06fHw07PxbpvKzxm=O2udhRLxA@mail.gmail.com>
 <CACGkMEvhZJCidEf2b5-cppvnX4=JwhbVX_cT9x+LMKLh_N3NcQ@mail.gmail.com>
In-Reply-To:
 <CACGkMEvhZJCidEf2b5-cppvnX4=JwhbVX_cT9x+LMKLh_N3NcQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|DM4PR18MB4160:EE_
x-ms-office365-filtering-correlation-id: 72adfbfe-32ee-4ea8-a5a8-08dd183562a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L3d3UEVFS2VaUmlkaTV4VzFIK0x3VjRRbGVIMXBNb21peVVRN3dIZWhDRzBw?=
 =?utf-8?B?dHNKdjg0TkVFVDE4aTE0bjh1ZGt6Z0dsbjg1MFBpOE5qY2hGRkZIUGFuT1lk?=
 =?utf-8?B?K2dKL1BmRWFPN0dDM0ZGcWt0blYrVnMxZlk2RjZPck5Xd2xiSUQrVEF2NmNk?=
 =?utf-8?B?d1NmMG43dVJKZWpzRnRKZWZzK3lQVHowOUdiWldUaWdDWkp3NjE4b2dFUmdE?=
 =?utf-8?B?TThPV2dZbGttN2ZxYnhCR1BiSXRwZUlkbHNpZ1dCSFBSTG44c3FXM0trUHYx?=
 =?utf-8?B?cm9seUFoSnhuVGpNY2EvcEhKb2prZUd1U3pYTzlJZThxQkdRbExTNk5yS2Rv?=
 =?utf-8?B?TzIwTkVyUjZHS1EwOGFIa3gvOG9sYnZ5Q2l0Z0VSY1hJKzFFZkR4WCtzeXBI?=
 =?utf-8?B?VXhvYjNaMnlHUlRoQmVlenk4SW1Gb21XWG9hY2NlNk5vcmcxWXhIS0kwT2pk?=
 =?utf-8?B?eTlNSkxjRDNvQTJGcnJ5RFVaK1QxY3JkYXAyRHllUElubmNjeVoyVGt6c2s1?=
 =?utf-8?B?ZkRYSnNyak4zZEptVXhKOVRESXZtOUpiODRndjBybzljMEFGT0JmRVQ2MVE0?=
 =?utf-8?B?dEF2TWVielFyQ2txcDN2QTRteXl5MEc5SEhleElmcVJLT202Y1hmWUhIWlh2?=
 =?utf-8?B?YTdyNit5SlVUN01weVpqTEJmOEdKd2tYSGpXSVdpVWQvdnBPM0JCSU4ra2hE?=
 =?utf-8?B?UmdsYlJDZjlNL3dHYVQyK2hWL1B2VGpmUklkanU0UUQzQWcwOXYrQVNQRUEv?=
 =?utf-8?B?M2MzMzI5bGlZSzJRM2ZPdytlTmlPRUNTclRHTi9VZSs2eVZ3Ryt6SDlLaEIy?=
 =?utf-8?B?ZGVBRWJnYkl1Y1lTL2JWVFpET3Q0RTIzZVdTYXpjUDlhMjhLOFBkY2hhNllh?=
 =?utf-8?B?cmUxZTFSWXQ2U1BaUHlUcWV2OFAzQ0V4aWZWZXpIQmhwMGJ2OGpQSEYyU3pv?=
 =?utf-8?B?MFZoSVZVWitMc0hoL3FOdHhOUGw3dG1IZU1jVzlvV25saWdKYjlwemczWHpw?=
 =?utf-8?B?c1ZhTzJuNEtQWVU0cVpHeVdQb0Q3dU54ckwzN0tWWmtzOWVCcjIyNllVVjFO?=
 =?utf-8?B?dXJLTVBnVk1MYU1mSzQxRFU0TVBSUTNoZkZMMDQrY20xQkdSQTg3bDVhQnp6?=
 =?utf-8?B?MXVOUUpKMk1UaGpWOUNvSW5pamVCVUhnMCtvV2xoK0pHRjJrYU1IZnpIcnRq?=
 =?utf-8?B?UnZ2dVhIYnN2U2V3ZlNSM2ErYW5Od1RhR3BqVWxrRTlac2JObTVyM1Y1Qm94?=
 =?utf-8?B?aE9nanlLTkF0SjI4cFlSNkJ5S3NWZzRTRjIyNkl5UTIxQXZ3MDFjTmdwTkFX?=
 =?utf-8?B?WlY4WG8wK2pPNTRwRjd2OWFuNmhYTkxJbG9VMGpmUHl6a05JZ29qZDR3ZkZT?=
 =?utf-8?B?a2VESUMyZEgrTkFKWXZhV1l3ZzhPQ21mWHBiMDMzeVNQcDk5SzExdWZ4UUJT?=
 =?utf-8?B?MC9jWTBOb3VaMTVtdG9lNTJEUmh2UUdVNFJVN3FyQVFmMVI5dXUrVFlNZERn?=
 =?utf-8?B?d3pkcEUzendwcGxZUkhuZkJXenhnWkZHOUtsNWx5QlFXQ1IxN3NTbC90TllL?=
 =?utf-8?B?dk1NZzVCdjFEeXBPNUN6ZXVMNGZxdjNnOUFLcDJNU1c4NVFzNitOQWJBVS9X?=
 =?utf-8?B?bHl0QjcwdDduOFg0VjBtWUpJdWZhV0hvYklwenRKdkJkNndGOVZkMk5VK1Jo?=
 =?utf-8?B?YkhBa0d6TTNDYmx5SzZ6bDhmWGl1bVEvNmRwQ21neXU2ck1yM0MzN1BSQ2hv?=
 =?utf-8?B?VDZVVlc4aFhOT0dMTmRSQkZobTRkMExoM2U0aFp5Y1JLYkNzNjZ1dWc5d3Bm?=
 =?utf-8?B?L1ZqL2FnbHFqMGhTQm1VZ211Wi9OdHVESVRMcElIc2xGTUlLNEJUNWxSVGtW?=
 =?utf-8?B?QVJhVjIyZG9mQVdTcTcxMy9ZUjk0QVBaTHdVTVU1ZW5IdkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STNuU2o3MGNtUUtYaEVPcm0za3VWRnErNCs4dUZodDR6K2N6WkRHM0hudHBI?=
 =?utf-8?B?L1diWEZTT3VJSkRTc2VtY05OMklxanJGUENiU00xRnZCMVc3dXgvRmVJVVJv?=
 =?utf-8?B?dmpOKy92SW5DMjA2LytnbXdtcW1tbm9POENwL3g0NU5aRXdxMVhXb0YyL1lR?=
 =?utf-8?B?VG0wT0lvU0RuNENRdGkzOHJ0eTBHOTdLZGFGNE1SdTVBVzRuMU1iWldyT2Rl?=
 =?utf-8?B?MUh4Tkt2ang0dG5PQVhRYXBRSzNiRXdkUTJaenVrZ0JlWnlyUHA1QldRSkpK?=
 =?utf-8?B?Q3dnZkI5OWV4RXRpYmloSDZvUVEraXNpWklYSWZ5NkFDdEVGd3JyWjdybkxs?=
 =?utf-8?B?d2RZV3VHZDR3YTZWeGRoSlZJSjgrcklHa2tMa24vbndxRFgrWGdwLyt0cGFI?=
 =?utf-8?B?VU5MRTZPMk9vWkhOcUp6V2R0ZldzdDJjdEF4cGlYSk0yMFd2UVI4Y3JiSWJi?=
 =?utf-8?B?U1BFa1RsWG1JbldFcjl2RGRvWCtFWkxtL2s5L0RqZmliOWlRNlhwZFBVK1FU?=
 =?utf-8?B?K21yNkNTdkljOThhOVFPUllYN1BZdlR5OWtNdlV3MUZQTFhQaUhCWnU1NmNk?=
 =?utf-8?B?dXdKV0kyakkxT2RBcEFLeS9jRS9tQU53UVljNTNMUHk1S0tPbWJWbVpmenFV?=
 =?utf-8?B?dWIwN3hydHhlNjltaFNIVEZkRU95eDBHYVYzZFk3d3VFMFZKT0pjcjZOSndR?=
 =?utf-8?B?am9MNnB1eDFjZ1hZQkFQQnJHZ2U4OGxQTVRYNDJGQXFXUGtvdkhic0x4d3Nt?=
 =?utf-8?B?TUg5ZDExOWlCc1dWQVFUaFV4RzRlTDYwdEM1aG5xb3gwYUF6Z1JLelVDZGdC?=
 =?utf-8?B?RmRJZ0JMZFA4djZiV1d5cHVNckJhRWsvKyt0MFBDaEFnZzVjeE9KUFNGcGhv?=
 =?utf-8?B?SjFMWmV6ZERHa3NrbEUzVGpodTlNV0NRWmNzZVlvaHV0c29EWUpSL2NPTVVY?=
 =?utf-8?B?VW5DOUhJN2o3ZU5DWkhKVEhodGVOTGY2WWdRT2JMLzBBTUFUcFptV3l5cGl1?=
 =?utf-8?B?eGw0a2wrUnRrMS94UTNZMlREVlFsZ2NDWjBBdjRFVk1PZjRrbWtHRVBYUERS?=
 =?utf-8?B?aG5waDRqTTRsaFF3RXg4YnhGaUpxSWRZS2ZZcWVjalkzeDY5WlZDQzF5c2dR?=
 =?utf-8?B?dm0zYzIyeDhDcHU4Tk1aaTd1Rmt6RTQ2ekRNWjNWaDhFQWtpMWwyUXJlZkN4?=
 =?utf-8?B?K0Z5NVRoYjRzOWd1cjNmdTRia3UyVjJSOWtXRVUyWkx1QVl0WDJES21UWVBl?=
 =?utf-8?B?Mm9qem1sYWRyMXJTUzJoL3N0eUk4T25SV1FPY2YvMDNaeVZkTG9meDE2WnFx?=
 =?utf-8?B?bWtiSTRCNFpEeE8xV2FWMjRKb292M3NIMVNGNVQzb3hBc3FBUTZieWlwUWFS?=
 =?utf-8?B?bmViQmUzWmhmL1dPVmg0VFNBcTJDQmtpU0tZa3QxN2xoZzcyb3YvTGo1bjYx?=
 =?utf-8?B?dXZZTGdTTlBGb2FTVTNTbXZHTnNsVlc1VjFqNUcvSXNweGxmQmFFRnpPekhT?=
 =?utf-8?B?bkV5ZWZndXJLTDdaSEsrS3pXM2hOek9yY1dCTW1zNEZhQlJVRTFIdi8vWHU0?=
 =?utf-8?B?VXJTbHVWY0x6Q0kvMnAzM2ZDUVVHWkRFSFhlV20wOXZQS3pWWng2d3BZUGxP?=
 =?utf-8?B?bDkwRmo2QmdGR2l2WUFxYUd1dHlNT2FpNnZnTGp2SUlhdkc3SXdWZFRFby9X?=
 =?utf-8?B?bkZ2dHQ2L1NFbGNTellZMjdaMWRXL0Q0QUl3bmkrQktsMFZRTjdUWTJyNDdR?=
 =?utf-8?B?NWFReTcyUnBQUS9QRGpsRXFscCs5ZjlTaDhUL1FmVWpaV1dmZzBVUmVMYTg5?=
 =?utf-8?B?ZnMzK2JiY2pmQmUwRjRqZzB6YWFHVU91UlBJK29SQTVZS2xqRWw1Y0tscVB5?=
 =?utf-8?B?MWNaM1ZOWXEwM2lzUGlONFlPSkxFTHFiUDc1QnkvYXpYcHlYbGp4aHZtR0hk?=
 =?utf-8?B?OXF4Y21qcEdHMnZFZGcwOTFUb1NPeHAvNkQwNCtTbVpnaWhWdlQxZXhpNUtM?=
 =?utf-8?B?NndHLzljVkhzWlF1b1dmMnFsY29KRnhCdlNSbURrZndyaUpXdXhaeEd3TUp3?=
 =?utf-8?B?NVFRenBIbW1PSEZYSEhiN3pSZWkycGR4RXNSc05tMDBIWW1IMDFBTFd4dUVs?=
 =?utf-8?Q?/uNEIso1N2WTU9paMRe6dgMm4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 72adfbfe-32ee-4ea8-a5a8-08dd183562a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 09:39:32.3564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M4PSd78YXnj7TcD2uTPyXzrbOPXo8LnnbjYkofLd4usy4ez6T2UnIU1dNTD8OiRFSWtsO5k0dxsvBftX95KW/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4160
X-Proofpoint-ORIG-GUID: snAFpzbBZKGKsY4flx-QJH6rLY_R1ITh
X-Proofpoint-GUID: snAFpzbBZKGKsY4flx-QJH6rLY_R1ITh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Pj4gPg0KPj4gPiBVcGRhdGVkIHRoZSBkcml2ZXIgdG8gdXRpbGl6ZSBhbGwgdGhlIE1TSS1YIGlu
dGVycnVwdCB2ZWN0b3JzIHN1cHBvcnRlZA0KPj4gPiBieSBlYWNoIE9DVEVPTiBlbmRwb2ludCBW
RiwgaW5zdGVhZCBvZiByZWx5aW5nIG9uIGEgc2luZ2xlIHZlY3Rvci4NCj4+ID4gRW5hYmxpbmcg
bW9yZSBpbnRlcnJ1cHRzIGFsbG93cyBwYWNrZXRzIGZyb20gbXVsdGlwbGUgcmluZ3MgdG8gYmUN
Cj4+ID4gZGlzdHJpYnV0ZWQgYWNyb3NzIG11bHRpcGxlIGNvcmVzLCBpbXByb3ZpbmcgcGFyYWxs
ZWxpc20gYW5kDQo+PiA+IHBlcmZvcm1hbmNlLg0KPj4gPg0KPj4gPiBTaWduZWQtb2ZmLWJ5OiBT
aGlqaXRoIFRob3R0b24gPHN0aG90dG9uQG1hcnZlbGwuY29tPg0KPj4gPiAtLS0NCj4+ID4gdjE6
DQo+PiA+IC0gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBz
LQ0KPjNBX19sb3JlLmtlcm5lbC5vcmdfdmlydHVhbGl6YXRpb25fMjAyNDExMjAwNzA1MDguNzg5
NTA4LTJEMS0NCj4yRHN0aG90dG9uLQ0KPjQwbWFydmVsbC5jb20mZD1Ed0lGYVEmYz1uS2pXZWMy
YjZSMG1PeVBhejd4dGZRJnI9Rzl3NEtzUGFRTEFDDQo+QmZHQ0wzNVB0aVJIOTk2eXFKRHhBWndy
V2VnVTJxUSZtPW1mMGR1SUwyZkp0MFVVSkFXSVB6eXRRV0pxaA0KPjY3MXhCTzc0bzRpRENKekZt
N0RELQ0KPmNTamU0dXhWYnB5dTNJbTAmcz02VEtvNnZPOGNleEoxYTNKcFBLTmdEZFdfQzRzQ1Et
DQo+ZEdLWldPWmpiSWtzJmU9DQo+PiA+DQo+PiA+IENoYW5nZXMgaW4gdjI6DQo+PiA+IC0gSGFu
ZGxlIHJlc2V0IGdldHRpbmcgY2FsbGVkIHR3aWNlLg0KPj4gPiAtIFVzZSBkZXZtX2tjYWxsb2Mg
dG8gYWxsb2NhdGUgaXJxIGFycmF5Lg0KPj4gPiAtIElSUSBpcyBuZXZlciB6ZXJvLiBBZGp1c3Rl
ZCBjb2RlIGFjY29yZGluZ2x5Lg0KPj4gPg0KPj4gPiAgZHJpdmVycy92ZHBhL29jdGVvbl9lcC9v
Y3RlcF92ZHBhLmggICAgICB8IDEwICstLQ0KPj4gPiAgZHJpdmVycy92ZHBhL29jdGVvbl9lcC9v
Y3RlcF92ZHBhX2h3LmMgICB8ICAyIC0NCj4+ID4gIGRyaXZlcnMvdmRwYS9vY3Rlb25fZXAvb2N0
ZXBfdmRwYV9tYWluLmMgfCA5MCArKysrKysrKysrKysrKysrLS0tLQ0KPi0tLS0NCj4+ID4gIDMg
ZmlsZXMgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKSwgMzggZGVsZXRpb25zKC0pDQo+PiA+DQo+
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvb2N0ZW9uX2VwL29jdGVwX3ZkcGEuaA0KPmIv
ZHJpdmVycy92ZHBhL29jdGVvbl9lcC9vY3RlcF92ZHBhLmgNCj4+ID4gaW5kZXggMDQ2NzEwZWM0
ZDQyLi4yZDRiYjA3ZjkxYjMgMTAwNjQ0DQo+PiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9vY3Rlb25f
ZXAvb2N0ZXBfdmRwYS5oDQo+PiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9vY3Rlb25fZXAvb2N0ZXBf
dmRwYS5oDQo+PiA+IEBAIC0yOSwxMiArMjksMTIgQEANCj4+ID4gICNkZWZpbmUgT0NURVBfRVBG
X1JJTkZPKHgpICgweDAwMDIwOWYwIHwgKCh4KSA8PCAyNSkpDQo+PiA+ICAjZGVmaW5lIE9DVEVQ
X1ZGX01CT1hfREFUQSh4KSAoMHgwMDAxMDIxMCB8ICgoeCkgPDwgMTcpKQ0KPj4gPiAgI2RlZmlu
ZSBPQ1RFUF9QRl9NQk9YX0RBVEEoeCkgKDB4MDAwMjIwMDAgfCAoKHgpIDw8IDQpKQ0KPj4gPiAt
DQo+PiA+IC0jZGVmaW5lIE9DVEVQX0VQRl9SSU5GT19SUFZGKHZhbCkgKCgodmFsKSA+PiAzMikg
JiAweEYpDQo+PiA+IC0jZGVmaW5lIE9DVEVQX0VQRl9SSU5GT19OVkZTKHZhbCkgKCgodmFsKSA+
PiA0OCkgJiAweDdGKQ0KPj4gPiArI2RlZmluZSBPQ1RFUF9WRl9JTl9DVFJMKHgpICAgICAgICAo
MHgwMDAxMDAwMCB8ICgoeCkgPDwgMTcpKQ0KPj4gPiArI2RlZmluZSBPQ1RFUF9WRl9JTl9DVFJM
X1JQVkYodmFsKSAoKCh2YWwpID4+IDQ4KSAmIDB4RikNCj4+ID4NCj4+ID4gICNkZWZpbmUgT0NU
RVBfRldfUkVBRFlfU0lHTkFUVVJFMCAgMHhGRUVERkVFRA0KPj4gPiAgI2RlZmluZSBPQ1RFUF9G
V19SRUFEWV9TSUdOQVRVUkUxICAweDMzNTVmZmFhDQo+PiA+ICsjZGVmaW5lIE9DVEVQX01BWF9D
Ql9JTlRSICAgICAgICAgIDgNCj4+ID4NCj4+ID4gIGVudW0gb2N0ZXBfdmRwYV9kZXZfc3RhdHVz
IHsNCj4+ID4gICAgICAgICBPQ1RFUF9WRFBBX0RFVl9TVEFUVVNfSU5WQUxJRCwNCj4+ID4gQEAg
LTUwLDcgKzUwLDYgQEAgc3RydWN0IG9jdGVwX3ZyaW5nX2luZm8gew0KPj4gPiAgICAgICAgIHZv
aWQgX19pb21lbSAqbm90aWZ5X2FkZHI7DQo+PiA+ICAgICAgICAgdTMyIF9faW9tZW0gKmNiX25v
dGlmeV9hZGRyOw0KPj4gPiAgICAgICAgIHBoeXNfYWRkcl90IG5vdGlmeV9wYTsNCj4+ID4gLSAg
ICAgICBjaGFyIG1zaXhfbmFtZVsyNTZdOw0KPj4gPiAgfTsNCj4+ID4NCj4+ID4gIHN0cnVjdCBv
Y3RlcF9odyB7DQo+PiA+IEBAIC02OCw3ICs2Nyw4IEBAIHN0cnVjdCBvY3RlcF9odyB7DQo+PiA+
ICAgICAgICAgdTY0IGZlYXR1cmVzOw0KPj4gPiAgICAgICAgIHUxNiBucl92cmluZzsNCj4+ID4g
ICAgICAgICB1MzIgY29uZmlnX3NpemU7DQo+PiA+IC0gICAgICAgaW50IGlycTsNCj4+ID4gKyAg
ICAgICBpbnQgbmJfaXJxczsNCj4+ID4gKyAgICAgICBpbnQgKmlycXM7DQo+PiA+ICB9Ow0KPj4g
Pg0KPj4gPiAgdTggb2N0ZXBfaHdfZ2V0X3N0YXR1cyhzdHJ1Y3Qgb2N0ZXBfaHcgKm9jdF9odyk7
DQo+PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvb2N0ZW9uX2VwL29jdGVwX3ZkcGFfaHcu
Yw0KPmIvZHJpdmVycy92ZHBhL29jdGVvbl9lcC9vY3RlcF92ZHBhX2h3LmMNCj4+ID4gaW5kZXgg
MWQ0NzY3YjMzMzE1Li5kNWE1OTlmODdlMTggMTAwNjQ0DQo+PiA+IC0tLSBhL2RyaXZlcnMvdmRw
YS9vY3Rlb25fZXAvb2N0ZXBfdmRwYV9ody5jDQo+PiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9vY3Rl
b25fZXAvb2N0ZXBfdmRwYV9ody5jDQo+PiA+IEBAIC00OTUsOCArNDk1LDYgQEAgaW50IG9jdGVw
X2h3X2NhcHNfcmVhZChzdHJ1Y3Qgb2N0ZXBfaHcgKm9jdF9odywNCj5zdHJ1Y3QgcGNpX2RldiAq
cGRldikNCj4+ID4gICAgICAgICBpZiAoIW9jdF9ody0+dnFzKQ0KPj4gPiAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FTk9NRU07DQo+PiA+DQo+PiA+IC0gICAgICAgb2N0X2h3LT5pcnEgPSAtMTsN
Cj4+ID4gLQ0KPj4gPiAgICAgICAgIGRldl9pbmZvKCZwZGV2LT5kZXYsICJEZXZpY2UgZmVhdHVy
ZXMgOiAlbGx4XG4iLCBvY3RfaHctPmZlYXR1cmVzKTsNCj4+ID4gICAgICAgICBkZXZfaW5mbygm
cGRldi0+ZGV2LCAiTWF4aW11bSBxdWV1ZXMgOiAldVxuIiwgb2N0X2h3LT5ucl92cmluZyk7DQo+
PiA+DQo+PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvb2N0ZW9uX2VwL29jdGVwX3ZkcGFf
bWFpbi5jDQo+Yi9kcml2ZXJzL3ZkcGEvb2N0ZW9uX2VwL29jdGVwX3ZkcGFfbWFpbi5jDQo+PiA+
IGluZGV4IGNkNTViMWFhYzE1MS4uZTEwY2IyNmEzMjA2IDEwMDY0NA0KPj4gPiAtLS0gYS9kcml2
ZXJzL3ZkcGEvb2N0ZW9uX2VwL29jdGVwX3ZkcGFfbWFpbi5jDQo+PiA+ICsrKyBiL2RyaXZlcnMv
dmRwYS9vY3Rlb25fZXAvb2N0ZXBfdmRwYV9tYWluLmMNCj4+ID4gQEAgLTQ3LDEzICs0NywzMCBA
QCBzdGF0aWMgc3RydWN0IG9jdGVwX2h3ICp2ZHBhX3RvX29jdGVwX2h3KHN0cnVjdA0KPnZkcGFf
ZGV2aWNlICp2ZHBhX2RldikNCj4+ID4gIHN0YXRpYyBpcnFyZXR1cm5fdCBvY3RlcF92ZHBhX2lu
dHJfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpkYXRhKQ0KPj4gPiAgew0KPj4gPiAgICAgICAgIHN0
cnVjdCBvY3RlcF9odyAqb2N0X2h3ID0gZGF0YTsNCj4+ID4gLSAgICAgICBpbnQgaTsNCj4+ID4g
KyAgICAgICBpbnQgaSwgcmluZ19zdGFydCwgcmluZ19zdHJpZGU7DQo+PiA+ICsNCj4+ID4gKyAg
ICAgICAvKiBFYWNoIGRldmljZSBoYXMgbXVsdGlwbGUgaW50ZXJydXB0cyAobmJfaXJxcykgc2hh
cmVkIGFtb25nIHJlY2VpdmUNCj4+ID4gKyAgICAgICAgKiByaW5ncyAobnJfdnJpbmcpLiBEZXZp
Y2UgaW50ZXJydXB0cyBhcmUgbWFwcGVkIHRvIHNwZWNpZmljIHJlY2VpdmUNCj4+ID4gKyAgICAg
ICAgKiByaW5ncyBpbiBhIHJvdW5kLXJvYmluIGZhc2hpb24uIE9ubHkgcmluZ3MgaGFuZGxpbmcg
cmVjZWl2ZQ0KPj4gPiArICAgICAgICAqIG9wZXJhdGlvbnMgcmVxdWlyZSBpbnRlcnJ1cHRzLCBh
bmQgdGhlc2UgYXJlIGF0IGV2ZW4gaW5kaWNlcy4NCj4+ID4gKyAgICAgICAgKg0KPj4gPiArICAg
ICAgICAqIEZvciBleGFtcGxlLCBpZiBuYl9pcnFzID0gOCBhbmQgbnJfdnJpbmcgPSA2NDoNCj4+
ID4gKyAgICAgICAgKiAwIC0+IDAsIDE2LCAzMiwgNDg7DQo+PiA+ICsgICAgICAgICogMSAtPiAy
LCAxOCwgMzQsIDUwOw0KPj4gPiArICAgICAgICAqIC4uLg0KPj4gPiArICAgICAgICAqIDcgLT4g
MTQsIDMwLCA0NiwgNjI7DQo+PiA+ICsgICAgICAgICovDQo+PiA+ICsgICAgICAgcmluZ19zdGFy
dCA9IChpcnEgLSBvY3RfaHctPmlycXNbMF0pICogMjsNCj4+ID4gKyAgICAgICByaW5nX3N0cmlk
ZSA9IG9jdF9ody0+bmJfaXJxcyAqIDI7DQo+PiA+DQo+PiA+IC0gICAgICAgZm9yIChpID0gMDsg
aSA8IG9jdF9ody0+bnJfdnJpbmc7IGkrKykgew0KPj4gPiAtICAgICAgICAgICAgICAgaWYgKG9j
dF9ody0+dnFzW2ldLmNiLmNhbGxiYWNrICYmIGlvcmVhZDMyKG9jdF9ody0NCj4+dnFzW2ldLmNi
X25vdGlmeV9hZGRyKSkgew0KPj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAvKiBBY2tub3ds
ZWRnZSB0aGUgcGVyIHF1ZXVlIG5vdGlmaWNhdGlvbiB0byB0aGUgZGV2aWNlICovDQo+PiA+ICsg
ICAgICAgZm9yIChpID0gcmluZ19zdGFydDsgaSA8IG9jdF9ody0+bnJfdnJpbmc7IGkgKz0gcmlu
Z19zdHJpZGUpIHsNCj4+ID4gKyAgICAgICAgICAgICAgIGlmIChpb3JlYWQzMihvY3RfaHctPnZx
c1tpXS5jYl9ub3RpZnlfYWRkcikpIHsNCj4+DQo+PiBDb3VsZCBvY3RfaHctPnZxc1tpXS5jYl9u
b3RpZnlfYWRkciBjaGFuZ2U/IElmIG5vdCwgbWF5YmUgd2UgY2FuIGNhY2hlDQo+PiBpdCBzb21l
d2hlcmUgdG8gYXZvaWQgdGhlIHJlYWQgaGVyZS4NCj4NCj5PaywgaXQgbG9va3MgbGlrZSB0aGUg
ZGV2aWNlIHJldXNlIHRoZSBub3RpZnkgYWRkciBzb21laG93IHdvcmtzIGxpa2UgYW4gSVNSLg0K
Pg0KDQpZZXMsIHRoZSB2YWx1ZSBhdCBjYl9ub3RpZnlfYWRkciBpcyB1cGRhdGVkIGJ5IHRoZSBk
ZXZpY2UgbGlrZSB0aGUgSVNSLg0KDQpUaGFua3MsDQpTaGlqaXRoDQo=
