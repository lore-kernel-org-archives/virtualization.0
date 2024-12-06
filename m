Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5387F3D6B
	for <virtualization@lists.linux.dev>; Fri,  6 Dec 2024 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733469949; cv=fail; b=rE26rJ8PtsyPYTEfE07T+WNRGbL5tzzvz6gda5Mzih5xBRnsX0uYMWjpRNYZSUMLdNEoezFP0ABQgg3l5qvk53nHnJCSPXKMMWF3/cP9tLBy722vjQ7KmI5tqKHc7gSxmwOdwlH7vqhSWwwl7ukJF830/DNyGBLavZlG6jUkysk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733469949; c=relaxed/simple;
	bh=I7KS0tWrrg11Jm54Jj9AhNPDqCehtN7DzkjM+/k2KT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lmA7aBJPaeOjEWqN9nBoBHZyGclZClWDyx5T/mK1snm9dX9WANZ9SYsnldJqYcq5v68l8QznAbSth7c4FET40YkvDnd2bphfBIZBq8SAq9khIYRa7+VWgBU+e8JZmnV7dWlgf3OlvxVLCc26ZMrQDzr1kdc6OFUoyw//vt22Cd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=prR2NveH; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="prR2NveH"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B64X09t026492;
	Thu, 5 Dec 2024 23:25:41 -0800
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43btb78aac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 23:25:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrfP+uDva+U8lr7sc57rHLrto8EeezMxKVOj6Hv2n7KY1cogTL1nIZDDrkQDqjv24OBTpXLjsJLLqBotxVWlex4fHLytjONf1iHXJkhohTKvaFZY5BpOE0JOAzAT4K1a58q4CgEpIX/uxLg2qjR0RC1N010BRxR1aVNHqx8BjqFDDwJzrewOB/Ffwc76/y1zEXVSySjOH1FmAwGrBDfuSe/TPRPCtP7fRoXrKSft98lGNq4UA0Us+SCOWT+lX87ZFc/jk4yd0gei+pDYCeOdmppF2+KG0hRACOM9d05vgZ0r0rwmeFe33/TplF0JSErvf2VznMVigpOST5EOnut6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7KS0tWrrg11Jm54Jj9AhNPDqCehtN7DzkjM+/k2KT0=;
 b=jPWecbxLOEp6+h8BK0tt1WDzHUDYbIpqAWAfvHcSidS3oFTpxJmN7beiq1gJeFtuP61dvO0uebtfRvE4SPARL3OKNxhyavXilrxQbmCp0o2vSbQCiuL0kLVkmz4Hjxovs7nUzCelAArD+0NCpx2DnyO8Uc+sDDa1Ss71bs2A7fvRZmCS8FArxXLAbupzNYsTEfk9kootSH7aJajjkqnfzy8SB6NDv1jPWiU6n8XNtp/y49FfvMczQZwVl6iSjbR00HhsK3/ZrnLx4s/dpbV+vjdsM5Jyc9WRpPWypVNgNcHltQTU+lhp/TgN3tRyBcaws4Tyq86ofPJCs/xRhQsKCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7KS0tWrrg11Jm54Jj9AhNPDqCehtN7DzkjM+/k2KT0=;
 b=prR2NveHuwu6yuA2QLHWWZNrwqsLgEseaNH/uQYX/KiUfwyjatV46DdsBwUdFcFSUT+OjH8O3gR1HMne0gOPWoP+LpoLZ72h3tTxatMrPTNLrcoRdol4AdnYqHcYCYZmB0LitwwAubva27jqwVQVVj0mGn3P0mtCSsIaDSNylPY=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by PH0PR18MB4457.namprd18.prod.outlook.com (2603:10b6:510:ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 07:25:35 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 07:25:35 +0000
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
Subject: RE: [EXTERNAL] Re: [PATCH v2 3/4] vdpa/octeon_ep: read
 vendor-specific PCI capability
Thread-Topic: [EXTERNAL] Re: [PATCH v2 3/4] vdpa/octeon_ep: read
 vendor-specific PCI capability
Thread-Index: AQHbPBtbfqWtBytIsk2QkOET3y+vQ7LYksqAgABUHRA=
Date: Fri, 6 Dec 2024 07:25:35 +0000
Message-ID:
 <PH0PR18MB44258399D99FBE01DEB6A479D9312@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20241121134002.990285-1-sthotton@marvell.com>
 <20241121134002.990285-3-sthotton@marvell.com>
 <CACGkMEt_wUm7GEZ6zxUUO=JSRLYfj8ah9pwYbT0ZhO9-pnD+Ew@mail.gmail.com>
In-Reply-To:
 <CACGkMEt_wUm7GEZ6zxUUO=JSRLYfj8ah9pwYbT0ZhO9-pnD+Ew@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|PH0PR18MB4457:EE_
x-ms-office365-filtering-correlation-id: c4214923-05be-472d-33dc-08dd15c72d24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0pwMnFhYjIxOUM4UHdMTjViWWdRSk5tdmkvTVNEbzFCRGFDcmxPb1ZwM3NO?=
 =?utf-8?B?UG9wdjNrOVcvU01zQ045NjFiYlBiWUJOUVhpeDEwZkJuMHhESVpDUjdmZlFD?=
 =?utf-8?B?TTFleWNJc2p0WE1yQ1JqZkM2V0dRSHJodU9CNllvbm9UTjFKejlweWEzdFNL?=
 =?utf-8?B?SDJUZjZtbDBaNE1NTHV3T0I3WjhZNDlxSkFwWFFYRXBCTjRYbTU5MklJck14?=
 =?utf-8?B?YmMrOWU0UDlwVEFHNk5yb0JPSVBPK3hjVE14Wk1PWGQ1VkYyVWpZcGg3N1I0?=
 =?utf-8?B?S1ZEN3JOaHhqQnNldjBXRDNrVE9ld29iMFgrYUQwWXlXNWltWUZIRHhFT3Yx?=
 =?utf-8?B?UllmNnRTcjlaUWpYQnBUWXN4RXp6VzZRdEdJbVdKVXlVeHpmN3p3NGE5cExv?=
 =?utf-8?B?QkJobElNL0tuR0llb2RmRVQ3anNHUWFVU2N3NVp3WExjYVNkbHRnWWxzeFo3?=
 =?utf-8?B?eUxlRURQanE5aTgzL0MwUVZUSDRuTmNNZ0xJNGg3SnpZYkFUVFpkbnlWZHh4?=
 =?utf-8?B?MGo0MFkrekM3d01JcHZQcFM3UE1BS2ljRlpVcWlnZElYaVBxR2VFQngzL29T?=
 =?utf-8?B?R3JrV052SWxxL3I1WlJzbkFkdkJidHhobXpYeC9GbzlyR0tIRUt6KzJJK3B2?=
 =?utf-8?B?M1dKa3ZwdDNTY3RoUEpTaE9mdVRIWGJsTEljc3NnVk1TUTE2TTErZGpUaUUw?=
 =?utf-8?B?RldEUi83cHc2TzBHdGlpd214V00rNkptWW1YUzdMeFppZVdkdlNNanM0K3ZW?=
 =?utf-8?B?TW82ZlpjZnM4Zjc2ay9EZWJNOXVsM1FmYi93TFVQOTNKdkdpN0pQY2hHdVNZ?=
 =?utf-8?B?eEpWMU1EQldMR0E2M2VlU0RuRFplKzlJWUZ1VEpCMUNldVdjNjhOUW5CQllB?=
 =?utf-8?B?ZGdpeVQ0b2xmU3ZQZCtsd1NDeUhFVUFaYU1rK051RlZ5VmdreTR0ZExzVU50?=
 =?utf-8?B?M1VYS29GakRMdS83UnR1Q1JqWWlkUGJiZHNQbDhQendRYXExaUJRWTg3V3d6?=
 =?utf-8?B?eHRDM2haL21pNC81c3Fib1FjOS9SeWl3OTArYWl4Q00vV2RyTnFBVDlOSEpk?=
 =?utf-8?B?dDI3WHJvV0dOdTRDaExMMXh5czMyQnV1c0FZUng5em8yZ0pVRzVBb1BaSE5K?=
 =?utf-8?B?emhHTUtudVdXZFhyVGpqMjJnMXlpS1lybldHODJ5MisrOXFKNFJibG05TkFW?=
 =?utf-8?B?RE9ySEVBekZucHllSWtxMEtDb2tEV1B5UllLMWhUWmxVN01WU0J4c0FOdzEz?=
 =?utf-8?B?YTU2M3UvZnRKRnVKMUlEeEdmNFhNWXArYkhyTjkxeUFLWS9QWkJESVBTSjRp?=
 =?utf-8?B?NjVncWxZWTZQZWdIeFM2d1QvUjh0WXYyUlhYdnJqa0NWdGRFeUpzVW1rSXZ4?=
 =?utf-8?B?NFFoTURVQ2F5NWtZWWpSRTZDNkVFM2grMjB0bUV2L1pBb2JveHFWTjArS2Rr?=
 =?utf-8?B?clJTSzJiVGFackY4ZDVacmJHOEczVjBYdy9VVmcxNk1QaWIzdElFVG1PVzl4?=
 =?utf-8?B?SFJvMkNsVU1jQTZGd2RaZFlRL1FFS21iR25TK3pRT2hIY1hsaTZ2SkYvZk9y?=
 =?utf-8?B?ZkpOU0RrbHJtenVHeExZd0drMWtxTlhqLzhONWtQWVJaT1BGUU1QVHpGQjlQ?=
 =?utf-8?B?NVV6SXBxQzBlaFYzc056TXlzbXJEQ00xOEJHcHhmZ2pqY2pmLzBNWUZVSU1B?=
 =?utf-8?B?TEdYa3VreWgrZHlNS2pNMzg3MmFjYkNRUy9LbGthR3BjY2JYY0J0dkNrczhz?=
 =?utf-8?B?OVlqNkcyQy9OTUJvMTVPTkVoSzVpQVR1UzZSMURuV3YxdldrOHl0bHc0bUht?=
 =?utf-8?B?WjNaUG1lcHlzRUZCY0NiMTVuci9Kc0t4TDVtWmNPUzNBUEYwYjdreUlVVXdT?=
 =?utf-8?B?MG1zb05oTzFNaExFeUVLZTJyN3ZXTEg0RitBZG4rNjFEYXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWVLNjluRVNWaVVDemFEUHBST3NlUUc4VVJDOCtXSjJIeHNCOVpaczhGdUIr?=
 =?utf-8?B?RmlSdG5xRnZIVURWY0g3ZGhBU3ZsTUJEOXhYam1hZ0gzRFl0N2x0dGtzd0pE?=
 =?utf-8?B?L3ZwTXVJRDU2NW8vT2RwMXJLa05qRkZ4SW1lRElEWDFwV3VXNlpUaUp3Rzdp?=
 =?utf-8?B?YTVBL2F0cWNNY0tEanVyc2xDbXA3anFmdWJzRlhYZDhXRzdSM3BjYmU2aGhh?=
 =?utf-8?B?QkFBUFpSRW5VS2laeXo1VlhvVVJ3SkFLTWpVaXpsUXRwejZmb3ZEQW9qZmQz?=
 =?utf-8?B?QmxjSUI4bjY3RXhHVGpORm5zT2s1OEdlY1phb2o5REJOT0JiYW9aNFYzSmYv?=
 =?utf-8?B?T2xNaGZPLzVWRWhleklFM2Q2TkZKZktxU0o5YUVhZHg5RWJpZFZjb0prVlJi?=
 =?utf-8?B?SkpUTnNTdlZ3cjhXRU5qb1ZJcEtyUC84SU9tVjJMVXI1TGkwYS9UMXluNFZi?=
 =?utf-8?B?dmtOVGl6eDBscnowNWdXbnc0YVVjWnF1ZG9ZdjZPblZ3dzFaZXNUMmQwQ1g0?=
 =?utf-8?B?TlhkZ0I4OERDanhNTzBnamdiWDhjTjRsTVdqbHV1TjQyN1FEK3FhaDI0WjFu?=
 =?utf-8?B?Q3duY01zTHpEb2gyc3JjbE1qUVBtWmxzdmorb3NnczVkY0RXZ2NVVXVtd1A5?=
 =?utf-8?B?RlkrbEtCMW9iY1ZuYWp6eGVtZG5yUHBoUDF0Rk04TnQ1NUhIeUkydnRTenFH?=
 =?utf-8?B?N1NqdHBKV1dwZGEyRjRWVWFWWUVvZ2NRenJwYWlvQkYvb3diZzdleEVNSW9z?=
 =?utf-8?B?eEFKMkJjWVV3RlVRTk1lajA0YnpGZGM2WStKREgrOW00dW1mSG11Z1ZFcUhR?=
 =?utf-8?B?QlpFQlhJNWhmZTZRRjRDamZ2OUdxbG44N01uNEx1YVhQcjNSckRnSml2aU15?=
 =?utf-8?B?cHZES2FtZHFzNDBCRkpwRUltTFF1VWU3QkF3STRleHhjSUp3cHRrY0Q1YzhD?=
 =?utf-8?B?VEZDYWdUQVQweXpjcXhaejZlQkN1VzZpNzRoWUhCcTljMXI2eWM5VUNKNzAw?=
 =?utf-8?B?OTJON3oxVzU1YkxUcURYOGJsZWM2ei9iaS9USnlvRWE1cUFSODRlWlNpa0p2?=
 =?utf-8?B?Rkd3dGRNUE50aDlJQy9SUXdJbnJOQ2VlYm9LSlFHTk5vRDRlOUxEZzF5RjJl?=
 =?utf-8?B?UUZ5a1REYkVMdGtWYkxtVjJCekVCSW1aTG5LMGJqdUFKcnpTcmxaZklKRExS?=
 =?utf-8?B?cC8vbjhMa2Q3ZjE3RERDSkxVenBVUHhER3AxV21kTXZUcEZ2WnByK0h6Tklv?=
 =?utf-8?B?SkJzT1VUWU1BSkZOSzJPQmUvcmVSNTR1T09HWWNudm5ZSytWWVc5RllDNGhP?=
 =?utf-8?B?aXFPTUNGZDJhRnNkVzgyQ2VoN2MyeWw4YnRONE9XQjZ5a0NzM2hLclVDMUY2?=
 =?utf-8?B?N0ZTckdwZVNTMjhKRkttQjZQS1NLNlNGaytGa09waVhkZzFiQ3VUWFNnYWZm?=
 =?utf-8?B?Q2pGUVdZWmZZd3hkR0tIb0RWbGtPa0g0ZHpSQ3hlMTgrd3F3NXE2UkMrUU81?=
 =?utf-8?B?NlJITUcyVjh0cjJxUE42T1FsL2dDamw4SzRxV041N0RXV1hXV3FreEFqQ3lS?=
 =?utf-8?B?YlNlSUdydlIwSEdSanVqVjMyV2wyc3hoc0x0ZlpvT0o5d3RMd1VwTzJaRHBJ?=
 =?utf-8?B?VmdONE9IZkNNRFUwcUZKYnFlblg2REN3dWtXcEtrUU1rWlJhNW9rbVdIWXph?=
 =?utf-8?B?OHFEWXBXNHQ2YU5rczdWRkRHVGoxRGYxNFpxQi9Gb0tiQjJhQUtIRTV1eVRl?=
 =?utf-8?B?VUgycW1jS25zMldieWNCbnZqRlNzUW43TVkyVmgzU0V3QUhRYlJyZUtwa1Qx?=
 =?utf-8?B?YmFxWDhlcUt5bzRSenFOMWRndDIrcVZCSlB6WFJIeGtMY2Y5TXJvVDJTb3Z6?=
 =?utf-8?B?dGYyVXk0RHBnQ1JlN01zUU1mRVlxRXJlUkUxVEFYVjNLUUpGaWUwYjQ1N0Fu?=
 =?utf-8?B?VWErNHk3SUMyeno1NDAzbWQ3KzdjZTRoN3N0MGZJRndKaWhxMWovVFNFbHdm?=
 =?utf-8?B?cjdLZDA5Y3VhRnF1Q3dEb1dYdmx1RjdZWGxmSWl1TEhJRHVJNm1OcHhLbkFl?=
 =?utf-8?B?YzJRWTM3ajhVRUlKUVp5VkhHUU9yMnIwOVYvaEFqK2VaYTVla3ZyTmg3ZnIv?=
 =?utf-8?Q?Z+0Kzc243RGmY3UQa4CormBkw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c4214923-05be-472d-33dc-08dd15c72d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 07:25:35.5882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vg4pSLtdNZvnONcsdli4FiYpBDMblUYMJMx92evJzqcR/4VA3KFax/bozQCVIprA3PxR1kCU52FaZ3funOniDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4457
X-Proofpoint-ORIG-GUID: 6w21C8EsMgMus16ZRIiDpk9qbPeAQwnk
X-Proofpoint-GUID: 6w21C8EsMgMus16ZRIiDpk9qbPeAQwnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Pj4gQWRkZWQgc3VwcG9ydCB0byByZWFkIHRoZSB2ZW5kb3Itc3BlY2lmaWMgUENJIGNhcGFiaWxp
dHkgdG8gaWRlbnRpZnkgdGhlDQo+PiB0eXBlIG9mIGRldmljZSBiZWluZyBlbXVsYXRlZC4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBTaGlqaXRoIFRob3R0b24gPHN0aG90dG9uQG1hcnZlbGwuY29t
Pg0KPj4gLS0tDQo+PiAgZHJpdmVycy92ZHBhL29jdGVvbl9lcC9vY3RlcF92ZHBhLmggICAgICB8
IDI0ICsrKysrKysrKysrKysrKysrDQo+PiAgZHJpdmVycy92ZHBhL29jdGVvbl9lcC9vY3RlcF92
ZHBhX2h3LmMgICB8IDM0DQo+KysrKysrKysrKysrKysrKysrKysrKystDQo+PiAgZHJpdmVycy92
ZHBhL29jdGVvbl9lcC9vY3RlcF92ZHBhX21haW4uYyB8ICA0ICsrLQ0KPj4gIDMgZmlsZXMgY2hh
bmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92ZHBhL29jdGVvbl9lcC9vY3RlcF92ZHBhLmgNCj5iL2RyaXZlcnMvdmRwYS9v
Y3Rlb25fZXAvb2N0ZXBfdmRwYS5oDQo+PiBpbmRleCAyZDRiYjA3ZjkxYjMuLjBmODNhMWVjYTQw
OCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9vY3Rlb25fZXAvb2N0ZXBfdmRwYS5oDQo+
PiArKysgYi9kcml2ZXJzL3ZkcGEvb2N0ZW9uX2VwL29jdGVwX3ZkcGEuaA0KPj4gQEAgLTgsNiAr
OCw3IEBADQo+PiAgI2luY2x1ZGUgPGxpbnV4L3BjaV9yZWdzLmg+DQo+PiAgI2luY2x1ZGUgPGxp
bnV4L3ZkcGEuaD4NCj4+ICAjaW5jbHVkZSA8bGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaD4NCj4+
ICsjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fY3J5cHRvLmg+DQo+PiAgI2luY2x1ZGUgPHVh
cGkvbGludXgvdmlydGlvX25ldC5oPg0KPj4gICNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19i
bGsuaD4NCj4+ICAjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fY29uZmlnLmg+DQo+PiBAQCAt
NTIsNiArNTMsMjggQEAgc3RydWN0IG9jdGVwX3ZyaW5nX2luZm8gew0KPj4gICAgICAgICBwaHlz
X2FkZHJfdCBub3RpZnlfcGE7DQo+PiAgfTsNCj4+DQo+PiArZW51bSBvY3RlcF9wY2lfdm5kcl9j
ZmdfdHlwZSB7DQo+PiArICAgICAgIE9DVEVQX1BDSV9WTkRSX0NGR19UWVBFX1ZJUlRJT19JRCwN
Cj4+ICsgICAgICAgT0NURVBfUENJX1ZORFJfQ0ZHX1RZUEVfTUFYLA0KPj4gK307DQo+PiArDQo+
PiArc3RydWN0IG9jdGVwX3BjaV92bmRyX2RhdGEgew0KPj4gKyAgICAgICB1OCBjYXBfdm5kcjsN
Cj4+ICsgICAgICAgdTggY2FwX25leHQ7DQo+PiArICAgICAgIHU4IGNhcF9sZW47DQo+PiArICAg
ICAgIHU4IGNmZ190eXBlOw0KPj4gKyAgICAgICB1MTYgdmVuZG9yX2lkOw0KPg0KPklzIHRoaXMg
YmV0dGVyIHRvIGRlZmluZSB0aGUgYWJvdmUgaW4gdWFwaS9saW51eC92aXJ0aW9fcGNpLmg/DQoN
Ckkgd2lsbCBtb3ZlIHRoZSBzdGFuZGFyZCBkZWZpbmVzIHRvIHVhcGkvbGludXgvdmlydGlvX3Bj
aS5oDQpUaGUgZGVmaW5lcyBhcmU6DQoNCi8qIFBDSSB2ZW5kb3IgZGF0YSBjb25maWdfZ2VuZXJh
dGlvbiAqLw0KI2RlZmluZSBWSVJUSU9fUENJX0NBUF9WRU5ET1JfQ0ZHICAgICAgIDkNCg0KLyog
VGhpcyBpcyB0aGUgUENJIHZlbmRvciBkYXRhIGNhcGFiaWxpdHkgaGVhZGVyOiAqLw0Kc3RydWN0
IHZpcnRpb19wY2lfdm5kcl9kYXRhIHsNCiAgICAgICAgX191OCBjYXBfdm5kcjsgICAgICAgICAg
LyogR2VuZXJpYyBQQ0kgZmllbGQ6IFBDSV9DQVBfSURfVk5EUiAqLw0KICAgICAgICBfX3U4IGNh
cF9uZXh0OyAgICAgICAgICAvKiBHZW5lcmljIFBDSSBmaWVsZDogbmV4dCBwdHIuICovDQogICAg
ICAgIF9fdTggY2FwX2xlbjsgICAgICAgICAgIC8qIEdlbmVyaWMgUENJIGZpZWxkOiBjYXBhYmls
aXR5IGxlbmd0aCAqLw0KICAgICAgICBfX3U4IGNmZ190eXBlOyAgICAgICAgICAvKiBJZGVudGlm
aWVzIHRoZSBzdHJ1Y3R1cmUuICovDQogICAgICAgIF9fdTE2IHZlbmRvcl9pZDsgICAgICAgIC8q
IElkZW50aWZpZXMgdGhlIHZlbmRvci1zcGVjaWZpYyBmb3JtYXQuICovDQp9Ow0KDQpUaGFua3Ms
DQpTaGlqaXRoDQo=
