Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010061.outbound.protection.outlook.com [52.101.193.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2975B221299
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763513873; cv=fail; b=gi2iar4HdeyeJJAP1zDdYHtx1mYLOloPXjZ3j/fjTi+1r1/gd3Xf/liK9u7Zm8oiLYu+H2cXMcwa7civ/0/AGbJZm9UYKslicdOuLmGVj988+5tpXJyBq37opiGrVHt+0RPK1Lu7bSv6C0O/zIAJj7UtJq/Eck8sSbgFvPE0CJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763513873; c=relaxed/simple;
	bh=U+KMzw2jHaWUxQY3Mutdrf6UvJpU7L3+GyYUpIjsZb8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WpY52pA+BvufCTu09l82rFsoFuXYyR3t5ryMddfMhSCHP+vDEs2zjkPcJ5V76tYi8eOtBOAm/JmDluKtAoGHBZp8DrjCaoWK2nhl2JW+toVpNQZzGT4t7y68EmlijylLI11OpQa9nXDnklRZzNDFvqBcFQyfnRiNnr72tgcI2+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cOdstI1Q; arc=fail smtp.client-ip=52.101.193.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cOdstI1Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9YnW6LAc+sQdX6jWZve3Tk0j8OwFRr07BqjzKKVIglEmPTSM1obkFsNXt4eluUOtCL1xXc4orX3kZdJZOOjvcKX7Dgcx6jGNUqooUBjuCxq1snt6FqloDf6kcdcXPMb9yA4/4PTLu33cpg/eHZlkuFl0UHsQlBLnXjKcrcguXh9NJLnmUcBMHfPfoGypKC22DGy+JNw+h6Vve7hx8EOxVsdnPVrtdGhV9/vVuSiUHwVlm/AYh3nVxRPJGFwi0zS6r/jn4bTF08BeRffzH/OgBfR9IsorGiEA1g4XRurv34UxFGKE2VWbZCT1pG2KQ+QuFaBdLdNUpM0SYjsYM7fYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+KMzw2jHaWUxQY3Mutdrf6UvJpU7L3+GyYUpIjsZb8=;
 b=i37BnSzHfWZok+OW0Jb8r/OwRhB628YrQudsx+qOd3vfZpJ1WlN136bE1IhocWLwEpJp3vSckgfMV9KE7cwDOkWhNEtKCvTicilXghfUkot7Ri+i6AqrqGJwI40ec3giwFH9Js1r++KdWeWxNWsISixKjI4IEzL9n/DUwNzVdeuX9ebDdX4d9gm6CuUV/LjULxstYlS70w84g+BtaQd0Pwtr2GOrZrMfnt94Mr1tXI1tXPjk0WFny2T5PWWMJUVwew9bxMjgF6PW9xp32cYaeTlyicbmuQEnKzdCoPRhlJapU2DrfezQHvoXYvOQqXa8ORyNBI+NHwx/fjimT/3gtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+KMzw2jHaWUxQY3Mutdrf6UvJpU7L3+GyYUpIjsZb8=;
 b=cOdstI1QuAqwKTlEPVws5bwQ4BQtkjJtkmyYqdgTtXtcLUwv1521A0RuWAHvBgd2lYHpFVMsP9yEDepgzOYgCcI1FuX7+B1ZnR7FBgaPlORb4nbSYUSAbwERs2VQt0wFkoPCoPwJIr3X81L8EoM4xu5XfFshq8ubehnPmRS6lIntQQwnIU74p+P26klWHX2HvKa2Us63bFhxkXEOMRo1+QylE3mZbvRj1b3chd6lMMrFtS/195rs7Hfg8/RfDoKtRDoBT38yOi3EBqVVSHDShw1s5w28OReQNiLFPfgaJURc+2kVOxeJOYBCi9bQHYpaJW794L8zWBe+Yg+K8HzN5g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 00:57:47 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 00:57:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Yishai Hadas <yishaih@nvidia.com>, Alex Williamson
	<alex.williamson@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?=
	<eperezma@redhat.com>, Alex Williamson <alex@shazbot.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_pci: drop kernel.h
Thread-Topic: [PATCH] virtio_pci: drop kernel.h
Thread-Index: AQHcWOBVf8Fs9CCLKEqwN/T3A3OcwLT5LUgA
Date: Wed, 19 Nov 2025 00:57:47 +0000
Message-ID: <3d58c482-c171-45a9-ba13-2cc9ff50ad3d@nvidia.com>
References:
 <a1efb550481fc67973c0a86860e0724c8f5b9957.1763507303.git.mst@redhat.com>
In-Reply-To:
 <a1efb550481fc67973c0a86860e0724c8f5b9957.1763507303.git.mst@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB8771:EE_
x-ms-office365-filtering-correlation-id: c96ff252-ec7c-4ddd-654a-08de2706a7d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?R2g3ejk4eUdnQlFMMS9JVlVMMHpZNFRiVXMyL1NVSTNJak9LbG94eVVvVmcz?=
 =?utf-8?B?a1JCa3RNTzdIV2dCQlBGNXJzQjdXWDBrcEQ4ZEpKaTliYTUxL05pVG90NlFR?=
 =?utf-8?B?VnhDZ09KUDBhNElKOTFFYjIxUTVTRmpkWWlCQStqWEQxSEI4WE54bVBRb1BX?=
 =?utf-8?B?WURpZzdPenlzbmkwODQwS0N4ZEhxZDBJQ09RVE9nZGdoYzQ4L3hoVGdNbWh4?=
 =?utf-8?B?elRldTdCWHVUdy9kT09wMVBOQlpvaHhkeko3YTJKTGlyaHBQc3VNY1BQLzFN?=
 =?utf-8?B?N1FOZ0p5QVUzMHl3RW9qYmZITFVvNlZBd3RJUUpyeU5uZDdGeklNOWs3SzlF?=
 =?utf-8?B?Mk91TnRqRTdOYW9Pc21VbUNPc0dNdlhSQXhKb2tPUWVFcVk3OWRiVWo5TW1o?=
 =?utf-8?B?R2k1Uml3eUlBdFlaSzdwTEFFL0VFQkRFK3J0U3lXTFVYalptYWNpOFpjM1kv?=
 =?utf-8?B?bXFaQTdEbVBWd2IyOFVMbnhWUzJtVy9JTjNNQnRPOUZxQTNTZ3pzWHg3a1Nt?=
 =?utf-8?B?Y3JsMHVreGNHRzdFanBRMDlwbGcvNUkza0dDeDBNeHY2R2VrTlo4N0hzWEdK?=
 =?utf-8?B?dFY0SW82a1R5N3p0ZUFuNi9XU2xQb1c0a0VNZTlyRVc1VFh3SnJZSWgrVFJs?=
 =?utf-8?B?SUY4blF5RnlNMkFaYzlEN0RDMTU0d291aXRTbVV3M3JXL1NhQ1h4ZzRra1JE?=
 =?utf-8?B?Y3RKNFYrM3dFTXRnUFBJZVY3b0ZsOTRMOHl3TDNNYVZrcXduLzRPL1c2U0lp?=
 =?utf-8?B?dlZsODJNV2NxdG16SytoNUxLNmRuZHNlbit1Wkl0U2ZaVFQrRDU3TmprU2hk?=
 =?utf-8?B?ZExERFlpUnlQWnJJK2tydXZMbmtmNHMvVnJrL3A0bytubU4wc0FwTEFjMlg2?=
 =?utf-8?B?NWNDU29scTRVRGVLRkxVcnhjaDErUEFYenVsL1dnVi80NTNXVk55b0xuV2VO?=
 =?utf-8?B?R1REd2RqWG9tTDc3U0ZZOU9WNy91eVduU2RkMVpGTWVVVDYycTBPRTR4cnBi?=
 =?utf-8?B?RUhQNk1JTXIyQzV4S3FGWTJuN1ZzK1FVams2enlEQVpGVTZNNnJEQ09TcjIy?=
 =?utf-8?B?RmQvYnZFRk5jSmlUZU1xS2NxbVNwOEVTdHdnRlAvSkt6VzRqVlo5U04vZjNP?=
 =?utf-8?B?ZkczRnViaUoya1YxeUc3cjNJMGRrMjFLOFVrOVR4ZTlFd1YraUdydjIzUS9L?=
 =?utf-8?B?dC9mTlZqZFQ3Y3NMVnpIUGZVRVY4K2lqR3BzMWlTQ05pUnRBSWtTUzRad3Z0?=
 =?utf-8?B?WDJQQjA0aXlFWm00alZVZTNtclhKZisyNXRrNEhZL2JpbCtmWUR3MTRxYzRX?=
 =?utf-8?B?bzl2dnAyeWlXQWYycTR4OG1EZW1XdjVlWHhTSFJJMWxVUzgxWnFBU2o0K2R0?=
 =?utf-8?B?VnArQ084RlovNEwvdy9mRVNFTG15aG0yT3U5SkxTUnVnU3VHNHE5UHlwTHNs?=
 =?utf-8?B?NC9rZVhFZDZYWDFVUVltQzFqNmFNcStPNndHUVZKTGhhNjhNRiswaWV5Si9Z?=
 =?utf-8?B?N01LeVFMUnI5SFVpM3VlUUtUa2RFeEVXYkRyYWRlZHlQa2ZRZnU3YU82dVFT?=
 =?utf-8?B?RTZ4bGFYNEtqeGdPczNrMk9rNkdSdVRia3N4bmRyTUFsNjNSd1lHR000dDA4?=
 =?utf-8?B?dFN4ZGdUZCt6YXV4MjJ0YUoxYkppcUxYS0tDbHR4eFAxSS96MjltMUVuUXlr?=
 =?utf-8?B?clg0Si9pdUhEZEtZeGxBYXdiWFE5b1dsZ0NXWWVReThtdTNqSUlPMk9oTy8r?=
 =?utf-8?B?TlM3YWY2cXFPMmVwZ1F2bXZPbzhOR2oxRjg4TloxWVludEpLOHN4Zi9qNWd5?=
 =?utf-8?B?SldJNldwVFJIYW4vTmM5aHhveGhFYW1wR2JNbzBmL1FXZDloNUxOeStjbnhP?=
 =?utf-8?B?UjhYNHova2c2LzltWXd0ZzBmSE9LUGJNaTI0SU1meCtGdCtPNVNSQmZXcU9E?=
 =?utf-8?B?SVpHN3VxNUlYYWNKb0lXeG96WURDQXV3NFBydlhFdXFWYWNxekRmV1FrMm9q?=
 =?utf-8?B?NE9kaDBJSVU2cm9DNnhHaFBDTVVQU3poVXRJaGJIYmh1L2FWVVlDQzc5WVJr?=
 =?utf-8?Q?suS8bH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dG9LcFM2OWNYSDVrU0IxNTZ1dXd6MEwrcWF2VmhnL2NvbWZtczZFbFIzeE5o?=
 =?utf-8?B?T1NBa0krem0weW8yQ1NaQ3diVm1QVGFWaElwZndsVUVsVUJoZThwWkZ0ZWpC?=
 =?utf-8?B?eWxKK3ZWc0FMUnhZeXZEVkhBQ2d0MHFHYjZLTy9ib2R0VjVhTDlCSXJLZkhS?=
 =?utf-8?B?bGZtVXFjcURrdTViYXlNVTlYK0FCeTBrRUtEUk5PQlZCTkJIcE5saUV5RFN3?=
 =?utf-8?B?bEVDUGdTOWRnREhoY2dTWk10eHFwZ3dyWnJKMU1DakZha0lQOHF4aGJ0RWVC?=
 =?utf-8?B?ZThoaG90b2UxaTB6RUVrK3dwRjhBc1FMWVVSMHoxY2NPNkliWm9tTXNZTkN0?=
 =?utf-8?B?Y1FjYmlCZWhUc0tySmd4b3RKb3AwRXUvSHMvbUtMdWlGRnF5REJKSCt1a0Ey?=
 =?utf-8?B?c3pjTUhOZkNjZ2dPU081M2ErSlVuZmtvWUp0UTRjMHJlQ2pUK1B3bVd6Nzht?=
 =?utf-8?B?RG1ISFovNTd3UkJjN0drdUR0QlVaT3JGelR5Q3U3VStQa001RFVsQTJWM0tl?=
 =?utf-8?B?TXc5bnVVZnpjc1UzUDlSNGxqeXc5Q0g0OGkvcUNJNEVMR28xQzRITzRHdTI3?=
 =?utf-8?B?SUJSQXJLWFJkTG1ZNFgzRG5vanliYURoYjJXblJ6aEJrWlZQenBjTzJKZDZR?=
 =?utf-8?B?eGVOZitDcERuOW10dWRCM2dpaDU1cjJ2YjZNaEVXcUlJQk9EQXQ0QUFKTVFE?=
 =?utf-8?B?aTE3aEcwV3ZHYmw1NEZLdHp1b1dqdGdJTk5MTHFVZ1NqK2ZObm9MdTEyY1pU?=
 =?utf-8?B?Tm4rVFNCSnBzZkVQSjNNazMrOHhvQVpDUmVza1dhZ1I1VVp1aDBvUlpIWjZT?=
 =?utf-8?B?OHZ5Y2srR0lrNG9qN0VUM0dmTzNWM2hmT1R2bkhveXZoam9OaG5DNktiNkpn?=
 =?utf-8?B?bzJWZ2tKL1l5YXJLSGJnQ0lHRFR3MkVDbzRkcEVmeXRTSEdiU0pqVW1ZMXEr?=
 =?utf-8?B?dGZBRlZNODFqQUxBUnFZQ1QrQ1JMTlZ1VjRtd09BVGVtQ3hLRkJ2ZW8zei9v?=
 =?utf-8?B?MnNqSUh2OWtQTC9xanYxRUY1YU1WYTUzMGF1TmlNaDRwTC9iWUJIRElOSE85?=
 =?utf-8?B?emtOY2tSb2NmMTJldTg1bnB6cEgyd1MwcE5mM2VENklYWnFka3czZUxuYWlv?=
 =?utf-8?B?OWtzTnZvZFRETE92WXBkVlo5QUVKbGUyc0hWTUJ5emNoeUdrcXN4NSt0dzdC?=
 =?utf-8?B?cWk2a0wxU01xM3BEcWNaQ05LSkZBdGVNQ2NrZk1vN1J4SFI2ZE5OeCtrMDR0?=
 =?utf-8?B?dEx1bUNzN3VyWHRlaDdQcnVzeVNoV2pVallWZ2V2YWg2SThCMVlCM0s1a3lj?=
 =?utf-8?B?NTdvb2EveXo1bklSeEtqVWFtUnBQdXNObm1pdU5jNWhvMDV2aU5wckJWN04w?=
 =?utf-8?B?VGk2QjhVQTlWQ0JUUE9FTlRwTldlbFExZFl4WUttN1dEbFRYbVJiaktHQ2NV?=
 =?utf-8?B?TFV6RGdWTW1oVXg5a0tPSzA5cDBvM0hZSnpjRTlkR2dvUDRGVzg5NlB0SFJh?=
 =?utf-8?B?WVZRM2x2NlcvODdvdVRxbkJlTGpXS1dvTlpsdDQ1dnpJMmQ1eWgyeStDdDhY?=
 =?utf-8?B?S2FnMkxSU0g5S01JY3ZRSlQydHVSNXh3T1JWeUxhaWI0TG92emVsVG95L3NE?=
 =?utf-8?B?UjRTaUcwaHcxcVA0eTZCM1dwSGNGVytQSFB3ZW9Mb2wyUmRoMlZrTnloelJW?=
 =?utf-8?B?U1ZBRUd0WlpWb09MRzUrai9ZRmR3ZmNTVVJ0ckxKY3BCOFhDTW5laEtycW1o?=
 =?utf-8?B?YWtYVm02ZDZNNVNkaVlUZHNTU3E4cnh2QmF0WDl2WGZ1eXRDczc3UGFXNUVr?=
 =?utf-8?B?Z1BDNXdGSnl6RjAwVDBleGhjQkRYNVpxLzM5Z3h4M2twcmJ6QjBlYm5hUkkx?=
 =?utf-8?B?ZzlLVmIzZVpNcXVpWGNqbTQxVUVpT0tocG1ubGZ2U1BYRlZqQUY2aUFKY0xn?=
 =?utf-8?B?bFYxMlRKZE1tMCtLcUUvcFFESUFpcEhEanBMMzZSeVdhTi9pYnZ1b1ZjNGkx?=
 =?utf-8?B?SnBxMXV0L3dQYU1wazVncEYxaDBVanVGZGQ1dGZtdGtweUo2SW80WUlJQmhm?=
 =?utf-8?B?OWYzVG1OMElnMWtZNWhaQ3NMYVBqa1lXclJtbEVlNFpseHZORDM2V0syMStB?=
 =?utf-8?B?OUpPUEFHZXRqWnV3akdPUlFla1puNlY3eEVmNWVqVm83NXdWd21qQnNLKytk?=
 =?utf-8?Q?i7QNFzPT190nmDpjanSs8BLNsgKnfcW2X6r8DFSNfYpW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46BCB715F1BCC041A7CFF381E43092F3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96ff252-ec7c-4ddd-654a-08de2706a7d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 00:57:47.2157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SQNzaJwdR4UW2MP8435/oFqlzsOoBVm/mFAwCtEYsQH2MOMf2UyU24OXDS2/fVyxoWSqWqS/5NH69EUdFARHFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771

T24gMTEvMTgvMjUgMTU6MDgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gVUFQSSBoZWFk
ZXJzIHJlYWxseSBoYXZlIG5vIGJ1c2luZXNzIHB1bGxpbmcgaW4ga2VybmVsLmgNCj4gRHJvcCBp
dCAtIGl0IGRvZXMgbm90IHNlZW0gdG8gYmUgbmVlZGVkLCBlaXRoZXIuDQo+DQo+IEZpeGVzOiA3
YzFhZTE1MWU4MTIgKCJ2aXJ0aW9fcGNpOiBJbnRyb2R1Y2UgZGV2aWNlIHBhcnRzIGFjY2VzcyBj
b21tYW5kcyIpDQo+IENjOiAiWWlzaGFpIEhhZGFzIjx5aXNoYWloQG52aWRpYS5jb20+DQo+IENj
OiBBbGV4IFdpbGxpYW1zb248YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbjxtc3RAcmVkaGF0LmNvbT4NCg0KSW5kZWVkOg0KDQps
aW51eC1ibG9jayAoZGlzY2FyZC1yZXQtdmFsdWUpICMgZ3JlcCAia2VybmVsXC5oIiBpbmNsdWRl
L3VhcGkvbGludXgvKiAtaXINCmluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmg6I2luY2x1
ZGUgPGxpbnV4L2tlcm5lbC5oPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRh
bnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
