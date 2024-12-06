Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529D8191F9B
	for <virtualization@lists.linux.dev>; Fri,  6 Dec 2024 11:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486337; cv=fail; b=D6UFhdYLOHOwmONVKml138nq2UB4FvlrlmEnnI1vhVlyS1mWmdxgFkuWvtg5nVaIXnHKI5T1x3qptVDoobVJpstyHtLPeX4riVQ2nSYnapaBUzhWDpDrTaVg3JEU4HYng8nazkmv5N1m/OTuTpSRXLzMZQ71wYj6iIhnFcpYKxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486337; c=relaxed/simple;
	bh=6CvnBj78TzvDXxmOXbjJzhVfwEYjM7Pw3fXBkFM65AY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qUcmkmA79ulUWwpbZZfIKfIj6Z70xjIQD3LcVJrG+eFKawm96vBgI59of6jqqvXQrgT3fOhSfjkeVeBLgjY3r/6AceIB8DrIxp5nLdYlFr0hVIxL7nlnfUayb48GqWGz/iWY8mc27XyZX6rrckF9KCh5eWAlt+df+OjltTNAdwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=UxnP0Tji; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="UxnP0Tji"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6AgOYA009848;
	Fri, 6 Dec 2024 03:58:46 -0800
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43byq7g3yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 03:58:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzB+jiUMmAVb39SrEpGfwFcPTxTO7G/EY8q/vMwjjMmtnFtp7EfuHbsjuIdXLXCmJFy20vlc8i7rFp+e4kAKpQ9aQZTfodbaqQlscvSo3ilcaWExvAL+XO25MeR4ZqEsH3q+NXqULNtIwLtjsVvmCrKeAaR7nRn3q3tjgNtB8ALtwHoeQc665gePQFCdCSZ+Nwcr3aWaRWlaWV6v0vbQmXJ7r6TTq0PKL6XpwHCWTrewDy0NbrbTC/13134R+kCg17lWsz4x9rlLApTfgJ+CXveyV9bWHERVe4gCQtpzgq+UTgPO+ihEN7y+ft7BwNsuE5ChDpGNlz1E00H8oRxLhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CvnBj78TzvDXxmOXbjJzhVfwEYjM7Pw3fXBkFM65AY=;
 b=m3Pv7nkr8apWEIyDhv87LShFddz0wTMDTPmXUniIUDXXoUthK7MPJW01cGASgn6V7vU6/J/u2rw/O+uwj2TRkHIfQIHLUDjOmRPx+qRo9JerfeTH5sS2/WmHyhZ+nf5PuHpY2u+EceMgbCugmiSO1ZZBO55Z5eD9neX8EA7thlSm7npIvKoRg77TxAUI1icYSOXT+6wK1EsyySz3R6tG2c7p0Ak7gM2CrVjS6TSRjjJR+iEIWiNp/hgjAue4El0W9/qGDJNedIgXltmPz3bhIFMO4I45iX/nat9X2D3I15Cit9lXPyGDZHwUdjKTcamc0xPCxcdtgZ6uU2Hpyr6BQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CvnBj78TzvDXxmOXbjJzhVfwEYjM7Pw3fXBkFM65AY=;
 b=UxnP0TjigTw8f9BYqYz7yWLyLmKPdKtbzE0Fi/MHsrfHd17BE/knRirATGjW9c/aEY1kH3ve4XIkQNIOGlr+CZybOH78efN5Dctk3oBAItn1ODLI5zN/4+OjVU1g1vuO+G9MSiK4WharKr6vV7vWVaMiUUmWrYCzDKQq3cPR/Fo=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by DS0PR18MB5288.namprd18.prod.outlook.com (2603:10b6:8:126::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 11:58:42 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 11:58:42 +0000
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
Subject: Re: [PATCH v2 4/4] vdpa/octeon_ep: add interrupt handler for virtio
 crypto device
Thread-Topic: [PATCH v2 4/4] vdpa/octeon_ep: add interrupt handler for virtio
 crypto device
Thread-Index: AQHbR9YxPyC7yGrAokm/Bwpmk2120w==
Date: Fri, 6 Dec 2024 11:58:42 +0000
Message-ID:
 <PH0PR18MB442581F8A6914C40E0FEE414D9312@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20241121134002.990285-1-sthotton@marvell.com>
 <20241121134002.990285-4-sthotton@marvell.com>
 <CACGkMEtydc4q5Dc1wwN52na37uWLf24e-Tmp6rYmKyg0TDgXUg@mail.gmail.com>
In-Reply-To:
 <CACGkMEtydc4q5Dc1wwN52na37uWLf24e-Tmp6rYmKyg0TDgXUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|DS0PR18MB5288:EE_
x-ms-office365-filtering-correlation-id: c880a591-cefb-4e1d-699c-08dd15ed5477
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TkdyOWhaVUU2RTAweVZPbTR0Tk1IOHg2dGZiL3RnZWdhdzZSanBoa0dLK0VK?=
 =?utf-8?B?QTZ3S0ZSc255RGZlMWdCVTNMWVJKYzB6TFJSbWJ0Sk9Dd0dweHNaVW5LU2NS?=
 =?utf-8?B?K2d5aFd3ekNSVU9mOWVRc3V6U3gxeXNJUGNsMTNsdW4yV1I5OVRYcFVyYjYz?=
 =?utf-8?B?Y284d1B1WWRnc0JwSmVkKzdVWXgwSTlGbXIvNEJnL1JqYUN2T2VZckw5RFBP?=
 =?utf-8?B?ekxzVUh5Wmw0TG9LWDFabXBRUHY0WnlUKzBYQmV2bUZ3R2xtNlVFa3lWWWxU?=
 =?utf-8?B?bytXWGlFSW9VOEs4cDcxb3dRUGNtY1RoUmJTNS9RUmVQTDRiVXQ2TFZBUlNZ?=
 =?utf-8?B?QmV1NHA5OTgzQWhCd0JwUlRRNGIvTFhDTXZkSTNRZ25MLzR6aXJHbXhwZElX?=
 =?utf-8?B?eW5EY0Q0WnZ3aHlQbzdVMDg0bXNYcTdIZkc4OVZBbnNraFVoOG1TaDRvd2Q5?=
 =?utf-8?B?Q1VyREdEM2wwcUw5NkgxRUxiL2tiUCtCUWw3cFd6SFRiVzhWU1JUMnMyckpv?=
 =?utf-8?B?MkxQUlR0MjRxMjZzTjIvTUVmRVZ5VVkwVm9VeFNQVUtXL2xFbWk0dWdncVAv?=
 =?utf-8?B?bnVwd1pFWHlJalhMWUJEOTNDNEZmblRTN0NSSGF3Tmc3YXo0eFVuMWlURzZz?=
 =?utf-8?B?dXZaT2p3VHBYdGNYbDB2OGtiL0l6ZGsvZS8yeGthaUNjR3k5OWZ3VENoVnJJ?=
 =?utf-8?B?RnMrL3dOb3BZT0tIZkdaVEVpdFgwcitZNEEreVJPeTRTUVk3VW9qbnQzSTZ0?=
 =?utf-8?B?NkIwTFlYL3dTdzZzM004eE90eEZ6YlBLbVFXK2tsRU5yRHFEaWF1MWVSS0pF?=
 =?utf-8?B?R2FNTVE0WmhtaDg3UzlTQkZIM1RJSTU2cENqREhudUV3TlJDcW5yN3dudlJx?=
 =?utf-8?B?dG1VMExEZHJ5OCtyZ1hRZnowMHhWeWlteHZNVXBYVVBnOGs3YjM3cWhEVDlO?=
 =?utf-8?B?b3UrakRDODlrK3Z5MGxkY1h6OVdjVEVDdU5IMzNHVEdzTXpkdVhFQlpaL2NI?=
 =?utf-8?B?M3NseGRJcTdlTlowTUY1Uzc3bTVYZDAwUEF4NEpMRVBGY0tqWndrWVpVZFY3?=
 =?utf-8?B?RFhwTE9xU2w3Wkx3VmRuNTRZcnU2cnMwbHcxandzb05EMjJHZi9zQ2JpeG44?=
 =?utf-8?B?OEhIMEFlbWhCZ21oSXZNTXlFSHZyQ1ZDWitCODJ2OU1QQzN1RW14T0QyWUJM?=
 =?utf-8?B?Y3doWFEwc2pSKzJLdERXenQ2dlQveXlGWUd3ZHd0VlZWdHZSTElMUW4zR3BJ?=
 =?utf-8?B?SFVxdFI0eGdtZEk4R09Id1kzbGx3QUdtbUJJTGhsNmQzWmZDcWRVNW5lcGtj?=
 =?utf-8?B?L0EvbkNRamp6NjdlMUJ1ZDB1SGVHcTl6bzJxUUhyM0FUOFVneVpLQVZvb2Z0?=
 =?utf-8?B?N2E1U2xlM1M0ZjlZRDNBaHREZ2YwNE1QM0NoaVQ2bzN6aEJadTBQWGNTUGRP?=
 =?utf-8?B?aXA2cnFwTW9CWktFT3Evb2tJZzRTN3ArMFVrczlwbGo1YUdMWmU5aHhHMkx0?=
 =?utf-8?B?dk1ZNjJpWUovbnF1L000SitwdzNybXVTenM0NTFPM1JDSElQdmVIM3hLWEEy?=
 =?utf-8?B?bE1La2tQT0czaiswZTBneWdYRXFOVkJ0bjU0b2RWeng3RTkxSUNRbzF3aDNz?=
 =?utf-8?B?dTRCVng1YjNlNGRPUmk3Z0J5OFF5YnlVNG1Da085U1ltV1Jsbmhkb3krZzNY?=
 =?utf-8?B?K25FSjkySWxpTzZKMFBHejRiUzFoR1pkb0RXbmtOQnJNbm9kbVNJZEkyUjN4?=
 =?utf-8?B?dDliWTBaRTJ6RVd3ak5zcFdnc1FqK2RseE1nR2UwZzNYYlNBU0Y3T0ZpL1dy?=
 =?utf-8?B?aGJqU0t3WHZTZUZvQUxaYmhYTmUxdHNtWnY5Umd6enZUbkExUFpwSHhXOFVu?=
 =?utf-8?B?N0lpSFFXZEZyaVhrOFErOXE0ZW5mMmMyRS9ZQ0k4RlVocXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1czMXdXS1E0cVZMczMzS04vajhYNDdhRzVxUThLTVowNlM5cXhjSFcyZXVu?=
 =?utf-8?B?b0U5YmpWQmJEcUJxVkg4dGdPWkpEOE1PSjhmeVpvejdrUnkvU1VYN2w2ejQ5?=
 =?utf-8?B?dnVnQVZNT2pCY1NjbVhKNjViMzhMcXJOUXIyeGlKVlRsVlZoblFXc256bFRs?=
 =?utf-8?B?QTBLbEFPY3VGdHFmM1FDeDZpWFFNcDl1L2ZQcERRK01IeEJjSHFSSGF3RVpo?=
 =?utf-8?B?cVJIYmRDSWw3TzlzS2tsRWdvb1o1MkwweDluMEpGdEVWNmN2cXp3d3NyY3pw?=
 =?utf-8?B?OVF4RmgweEdHbys4Y0JMTHZkaThpbHJoNGZ3QzRQVjZhUnh1dU9KOEF1K1E3?=
 =?utf-8?B?TlE2SjUzS0gwSzNENFJyd3AwdkpPTGVFSW0yQ2hTUEUvZmh4K0ZrSlNvb1R0?=
 =?utf-8?B?MmtKYVp6a2hBQXFBYmVpb0hQRDMvL2JVcW13MkcwOTIwS2tOYi85M1hWLyt2?=
 =?utf-8?B?dVNSR2JwdVVNTy90U0FzUnBxVCtjNDlJK0JERmhtNFU1azRadlhEcENQa1dj?=
 =?utf-8?B?ajFNNVh4OGNsSnNXMVF3elVqbUlGZXRNdVlnM1o2WEE2RWFTcmtsVUtaU3g3?=
 =?utf-8?B?L0Y0U0Q3M0RDaExjWjJtT0lTclFjeVZQZVM4Wm5kYVNRMUlEcCs0Z0tlUEhF?=
 =?utf-8?B?cUphS0pqS3pYY29ZbzN4YkRMUENZR2p1RUhkdlZzUG5rakhDa1ltQ01mdzc3?=
 =?utf-8?B?bi9vQlg2UEFObGNPaktPQW5qcFFiUGFuQW9aMk5IUFVRbDl4YXQyTDhSNjla?=
 =?utf-8?B?Yjh4MnVlNEM4ZFNZZllUdUo0ZW1VNktFN29LeTZJd1U3M2NzMDdTNHJBSzMr?=
 =?utf-8?B?QjZITGtKNnNlMTdCTW5BQzcxMWQwdHJLYWV0MmtlSkUwTmZncWN6ZDk0bnZT?=
 =?utf-8?B?OEwzVEhqNUpmYURQUXpIK29Zbmt4NE5HMDgzRmVYVUN4M0FDSHJCQkFRU1U3?=
 =?utf-8?B?akVYUlRMKzgxeFA2Y2NWd1B2aXhGem1wckVPZnFsc0haMGh3RTFwaWk3M2hs?=
 =?utf-8?B?MTVHdVpaOThOdGZpeEdlQnZvZmhrMStGVmU5TDh2YnZTSFZvY292eW9qZHh4?=
 =?utf-8?B?c2V6R0VtZVZCeHZrUjBtWStRd0MxWjdGcWFWdGczQ0dHK3FHc042THZzaEtS?=
 =?utf-8?B?U0RISnVTTnF5RkRhNlZGOXEycjlqZ25aVnhuZmw5RHhuOVdLb3UyUm1UTHd5?=
 =?utf-8?B?dmNXblowaFFtbHVRUlovQmV2QkJLbVFKTFd2ZzVXdFZ3UTVtcFhtem1NZ1Zn?=
 =?utf-8?B?Q0hoMm1WRmpyd0M2N1g1ZE9tZTRqK3pPb3JncnhpUUpFcUJzWFBwUndOcWQr?=
 =?utf-8?B?TVJkS2tZWmhhOXNOOXl2ZlJxNHAyWS82TUxNcHNFem5YTG5iZTlnZmxGUmgv?=
 =?utf-8?B?M1dldkQ4WjQ2OG1sbVprLzZFSStJSkRQZjlpb3c0YUR4QlZsaU5YVDhUTE9p?=
 =?utf-8?B?VUU3bzJneFh1TDVxUE9ibzk2TkVNcGF3b0JIVXFGQ2xCK0YwbTVlT00waDZ4?=
 =?utf-8?B?S1F6WGJYWDRMb1dOV3JFQkNaWkhER0J1eVJUZ1RFeTBxemh4U2h5QmMrc3ZP?=
 =?utf-8?B?THArbjRhS2dJeTRpaHluSk9Eejc0dFE1RkhJVit6UXlTVThvWFFxSzNpK3Mw?=
 =?utf-8?B?dnd1dkZaeFpla3lIRjFEUDZXa01wbFBhaW55RmlXL1N5Q2JZR1V6VWZOTDdU?=
 =?utf-8?B?Z0dBcXhYS29BUldpYWtFNVFvQmlZdHpmbFZSZFc4VVpnc2w5RXdOdHpPUGox?=
 =?utf-8?B?UkZaQVFEOG8zam1HMlpuYkgxTEhnaFBpTmJoRzd1UVJQTTVOL2szZzVsSHVE?=
 =?utf-8?B?ZDhwNmcydEVhRWpGTitHbEhLMW93cElyY1lKTElpa0tFOU1ITDVtQWluN01L?=
 =?utf-8?B?b2huTUtBQnBuVXVUU21vb3dZc2xLVGdwZDA0Mko5dTJTYTVTSDl5bEtXcE9u?=
 =?utf-8?B?MVdEYmZYTzRMTTNjU09GblF5SWFqTlNYRTh5Y2c3cUppb0Q1Q1luL1QzMk1H?=
 =?utf-8?B?b3hMSjRpUmd4MUlPMGNJQWpPbFF5aGNjWlRSSGs0U0x3TFg3ejNZd0V0SEFQ?=
 =?utf-8?B?ZHNhbmJKK25hR09ZL2FKL0FrblFmQnhxamt5WEt5UXVwSGJJVE5jbW5NU1F5?=
 =?utf-8?Q?3hSMbKphXIvSlusHW8nbXkS/4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c880a591-cefb-4e1d-699c-08dd15ed5477
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 11:58:42.4568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuE+r2yGh+xQtIWvisAz/A8Pvxq8TdeApx9DJ28vbo6lae1rJji6sayZwVbFLvxd41eSnynvMyiCdsn1QtHM9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB5288
X-Proofpoint-ORIG-GUID: snqFTwl0X5pDjOFlvjUc5ABpiyE1ryei
X-Proofpoint-GUID: snqFTwl0X5pDjOFlvjUc5ABpiyE1ryei
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Pj4gSW50cm9kdWNlZCBhbiBpbnRlcnJ1cHQgaGFuZGxlciBmb3IgdGhlIHZpcnRpbyBjcnlwdG8g
ZGV2aWNlLCBhcyBpdHMNCj4+IHF1ZXVlIHVzYWdlIGRpZmZlcnMgZnJvbSB0aGF0IG9mIG5ldHdv
cmsgZGV2aWNlcy4gV2hpbGUgdmlydGlvIG5ldHdvcmsNCj4+IGRldmljZSByZWNlaXZlcyBwYWNr
ZXRzIG9ubHkgb24gZXZlbi1pbmRleGVkIHF1ZXVlcywgdmlydGlvIGNyeXB0bw0KPj4gZGV2aWNl
IHV0aWxpemUgYWxsIGF2YWlsYWJsZSBxdWV1ZXMgZm9yIHByb2Nlc3NpbmcgZGF0YS4NCj4NCj5J
J20gbm90IHN1cmUgSSB3aWxsIGdldCBoZXJlIGJ1dCB0aGUgcmVjZW50IGtlcm5lbCBkZXBlbmRz
IGhlYXZpbHkgb24NCj50aGUgdHggaW50ZXJydXB0IGZvciBza2IgcG9zdCBwcm9jZXNzaW5nIGFz
IHdlbGwuDQo+DQoNCkN1cnJlbnRseSwgdGhlIGRldmljZSBkb2VzIG5vdCBzdXBwb3J0IFRYIGlu
dGVycnVwdHMuDQpUaGlzIGJlaGF2aW9yIG1heSBjaGFuZ2UgaW4gdGhlIGZ1dHVyZS4gIA0KDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogU2hpaml0aCBUaG90dG9uIDxzdGhvdHRvbkBtYXJ2ZWxsLmNv
bT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvdmRwYS9vY3Rlb25fZXAvb2N0ZXBfdmRwYV9tYWluLmMg
fCA1Mg0KPisrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA1MCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZkcGEvb2N0ZW9uX2VwL29jdGVwX3ZkcGFfbWFpbi5jDQo+Yi9kcml2ZXJzL3ZkcGEvb2N0ZW9u
X2VwL29jdGVwX3ZkcGFfbWFpbi5jDQo+PiBpbmRleCBkNjc0Yjk2Nzg0MjguLjFiZGY3YTgxMTFj
ZSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9vY3Rlb25fZXAvb2N0ZXBfdmRwYV9tYWlu
LmMNCj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9vY3Rlb25fZXAvb2N0ZXBfdmRwYV9tYWluLmMNCj4+
IEBAIC00NCw3ICs0NCwzNSBAQCBzdGF0aWMgc3RydWN0IG9jdGVwX2h3ICp2ZHBhX3RvX29jdGVw
X2h3KHN0cnVjdA0KPnZkcGFfZGV2aWNlICp2ZHBhX2RldikNCj4+ICAgICAgICAgcmV0dXJuIG9j
dF92ZHBhLT5vY3RfaHc7DQo+PiAgfQ0KPj4NCj4+IC1zdGF0aWMgaXJxcmV0dXJuX3Qgb2N0ZXBf
dmRwYV9pbnRyX2hhbmRsZXIoaW50IGlycSwgdm9pZCAqZGF0YSkNCj4+ICtzdGF0aWMgaXJxcmV0
dXJuX3Qgb2N0ZXBfdmRwYV9jcnlwdG9faXJxX2hhbmRsZXIoaW50IGlycSwgdm9pZCAqZGF0YSkN
Cj4+ICt7DQo+PiArICAgICAgIHN0cnVjdCBvY3RlcF9odyAqb2N0X2h3ID0gZGF0YTsNCj4+ICsg
ICAgICAgaW50IGk7DQo+PiArDQo+PiArICAgICAgIC8qIEVhY2ggZGV2aWNlIGludGVycnVwdCAo
bmJfaXJxcykgbWFwcyB0byBzcGVjaWZpYyByZWNlaXZlIHJpbmdzDQo+PiArICAgICAgICAqIChu
cl92cmluZykgaW4gYSByb3VuZC1yb2JpbiBmYXNoaW9uLg0KPj4gKyAgICAgICAgKg0KPj4gKyAg
ICAgICAgKiBGb3IgZXhhbXBsZSwgaWYgbmJfaXJxcyA9IDggYW5kIG5yX3ZyaW5nID0gNjQ6DQo+
PiArICAgICAgICAqIDAgLT4gMCwgOCwgMTYsIDI0LCAzMiwgNDAsIDQ4LCA1NjsNCj4+ICsgICAg
ICAgICogMSAtPiAxLCA5LCAxNywgMjUsIDMzLCA0MSwgNDksIDU3Ow0KPj4gKyAgICAgICAgKiAu
Li4NCj4+ICsgICAgICAgICogNyAtPiA3LCAxNSwgMjMsIDMxLCAzOSwgNDcsIDU1LCA2MzsNCj4+
ICsgICAgICAgICovDQo+DQo+U28gdGhpcyBhbGdvcml0aG0gaXMgbWFuZGF0ZWQgYnkgdGhlIGRl
dmljZT8NCj4NCg0KWWVzLg0KDQo+SSdtIGFza2luZyBzaW5jZSBpdCdzIGJldHRlciB0byBub3Qg
aGF2ZSB0eXBlIHNwZWNpZmljIHBvbGljeSBpbiB0aGUNCj52RFBBIGxheWVyLiBBcyB0aGUgYmVo
YXZpb3VyIG9mIHRoZSBndWVzdCBtaWdodCBjaGFuZ2UuDQo+DQoNClRoaXMgbG9naWMgaXMgY2xv
c2VseSBsaW5rZWQgdG8gdGhlIGRldmljZSdzIGJlaGF2aW9yLiBJIHdpbGwgY2hlY2sgaWYgaXQg
aXMNCnBvc3NpYmxlIHRvIGF2b2lkIHRoZSBkZXZpY2UtdHlwZS1iYXNlZCBsb2dpYy4gIA0KDQo+
Rm9yIGV4YW1wbGUsIGZvciBuZXR3b3JraW5nIGRldmljZXMsIGluIHRoZSBmdXR1cmUgd2UgbWF5
IHN3aXRjaCB0bw0KPnVzZSBhIHNpbmdsZSBpbnRlcnJ1cHQvTkFQSSB0byBoYW5kbGUgYm90aCBS
WCBhbmQgVFguIEFuZCBub3RlIHRoYXQNCj50aGlzIGlzIG9ubHkgdGhlIGJlaGF2aW91ciBvZiBM
aW51eCwgbm90IG90aGVyIGRyaXZlcnMgbGlrZSBEUERLIG9yDQo+b3RoZXIgT1Nlcy4NCj4NCj4+
ICsgICAgICAgZm9yIChpID0gaXJxIC0gb2N0X2h3LT5pcnFzWzBdOyBpIDwgb2N0X2h3LT5ucl92
cmluZzsgaSArPSBvY3RfaHctPm5iX2lycXMpDQo+ew0KPj4gKyAgICAgICAgICAgICAgIGlmIChp
b3JlYWQzMihvY3RfaHctPnZxc1tpXS5jYl9ub3RpZnlfYWRkcikpIHsNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIC8qIEFja25vd2xlZGdlIHRoZSBwZXIgcmluZyBub3RpZmljYXRpb24gdG8g
dGhlIGRldmljZSAqLw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgaW93cml0ZTMyKDAsIG9j
dF9ody0+dnFzW2ldLmNiX25vdGlmeV9hZGRyKTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGlmIChsaWtlbHkob2N0X2h3LT52cXNbaV0uY2IuY2FsbGJhY2spKQ0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBvY3RfaHctPnZxc1tpXS5jYi5jYWxsYmFjayhvY3Rf
aHctPnZxc1tpXS5jYi5wcml2YXRlKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPj4gKyAgICAgICAgICAgICAgIH0NCj4+ICsgICAgICAgfQ0KPg0KDQpUaGFua3MsDQpTaGlq
aXRoDQo=
