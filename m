Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13074139587;
	Sat, 14 Dec 2024 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734158645; cv=fail; b=beLU0qiFMEvzoS4HNKCqPwEb+s9AyMC2nQaGwvXbYZqA1i+RU1423nyP096hUsSrFCSsO8ufgTUmzwAwS7V7qVbv5SW7qp6tUQdLK/kAj1VFciE/9UAIBZXE5sDg+rqzhF3gRANX3hcUnpYYYwbcAyqBeLPKIFXdz8vhc5YTwjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734158645; c=relaxed/simple;
	bh=auJZ+ok5KgZ/Mvme4ElZJNU/AnduaZrDQGYogGV0JrI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RCIkVzffNKD3Om35mY2RcmyS5mAMrRVd1HKx+vSNT0EZz/91Hy/tIocIOEyNDWEGBjj23crg+IYWLjLKJtL0k96u6UlGwBf7FMafScrHpKB9aJa3p33S9ON1v7xiyIHPWctykiKJ8vDD+KHRIFvJwPjJqCvuL9VeAs7puFVZ/KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=YxoS6ikE; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="YxoS6ikE"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BE5Tnww007695;
	Fri, 13 Dec 2024 22:29:23 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43h2w707mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 22:29:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ast/jkX4zGP/Be2zOsRpGfyttDc66W49mVEqyq4DAoV2izq97Hh7V3g3qvB6FXlxWtZtJmivjG/k3ElECnsUoDG99UICf5HWZmdy7UhoXteX7nhU+2jzWGdT5bowaMLdOYyHZtFTpyNWdAVyz7nGGspz/HYHhSete7HpyGCd4GR53DI7QZVqzkZeQGQyZQHrDCJGKd6OuJTOYYh1SPGrc9WXvQ1CqIJqkXJOlozNpBaN28mI34I0Y0GCxp/nVfoFGIKlqpaiQuz/Fqzh7Ox/hFegP+JqFhHh8FfPUK8l07kcVFQ80CssHwxCleUH+F4fDNvXQEEKLB7KwZ/eREmYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auJZ+ok5KgZ/Mvme4ElZJNU/AnduaZrDQGYogGV0JrI=;
 b=HmLOi+yZyeaz635C8CxKUOfjaHQeu1uu6XTfIp5z9iH6lxdz7nxNE5y4Vfwq4aNX3xWB5KzlFGmQ8HZ3toVgjWtUMhZ89S8SVhdB/WItDwF2TEGAmnuyyZ7FHQLfUriI102GsNIv1zZZGUhXYtnL5V/BEU58ITBa4udD2VcltMCYQ6BVaV1g/yS7DSOYCTedyhbBZ9JVa769hjt4CYHdCwYVg57Vz/+Rge2VZqb6QTrD1j1SrH5h76GSA2E1ouD/xBbeqoOvcEGvsQS02dIwBqhHDntDvdBLE2VGZw8lQuUtWQI1Q8qwO+p0UBjb8Ani+aaOtxUFg0LIvdpB4dT2KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auJZ+ok5KgZ/Mvme4ElZJNU/AnduaZrDQGYogGV0JrI=;
 b=YxoS6ikELG0vUy6YbFZyDHJFWBYGUF1I306kYWxT2yJ8Y/lD4LK4xKp9NNewJ//DMrRenWwrntuRSasdtHSL0PILpJpon2mweiW/8fx3uTKMHnNmVLnXajJwb8B6ntzFHhnS+kxvLoMo5/uq8BpbwlxpmBjys1u2Rfyam9cWMeE=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by BN9PR18MB4220.namprd18.prod.outlook.com (2603:10b6:408:119::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Sat, 14 Dec
 2024 06:29:19 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%6]) with mapi id 15.20.8251.015; Sat, 14 Dec 2024
 06:29:19 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>,
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
Subject: Re: [PATCH v3 4/4] vdpa/octeon_ep: read vendor-specific PCI
 capability
Thread-Topic: [PATCH v3 4/4] vdpa/octeon_ep: read vendor-specific PCI
 capability
Thread-Index: AQHbTfGB5l3EKVHWqE+e9f024nzMLw==
Date: Sat, 14 Dec 2024 06:29:19 +0000
Message-ID:
 <PH0PR18MB4425608D09BF3BFD4C551D0AD9392@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20241209151427.3720026-1-sthotton@marvell.com>
 <20241209151427.3720026-4-sthotton@marvell.com>
 <CACGkMEvuObS4RCk2BjQ4sm6r4jaC3fN4ui5EXd6SVzYxYZV7iA@mail.gmail.com>
 <PH0PR18MB442538D91F856F27F3C37A9AD9382@PH0PR18MB4425.namprd18.prod.outlook.com>
 <PH0PR18MB4425BB6DE30C3805F31D75CED9382@PH0PR18MB4425.namprd18.prod.outlook.com>
 <20241213135321-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241213135321-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|BN9PR18MB4220:EE_
x-ms-office365-filtering-correlation-id: ecb4ef38-f1ea-46bd-00db-08dd1c08a426
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?THcxRWhYdU1XenBpNEZxeXg2MWZoQjd0NlVKaWtEamRDTU5rdWNxZDBOdTk3?=
 =?utf-8?B?Q0JJbk1CTkJEcmpyRk9mK3BlUThiVGlwa0xmajZiQ1VTaXBvMUg1SEN0NFlw?=
 =?utf-8?B?VkJURk40dXdwSWJaTEJVdE8wS3NFZElYN0h5aWxCbDY0WU5BSkNWN3RHZ0oz?=
 =?utf-8?B?cmVtNmlqY2NXYXRJRUtqcTJHc0JIamdkVTlPejd2SEFjdzZVYy84TDdhQ1RM?=
 =?utf-8?B?bWxIdU1pU0d1Q3lQOUYxSWtiblZscEszdWl0NXFxTFhDRHE2eFlKZVhzbjZI?=
 =?utf-8?B?QWk4RjY5RElDV0NIQzJPUzRHcjc5dm9JSjkrYm9odmNJTFBrZWtwM2RQdHVv?=
 =?utf-8?B?TS9QUS9jaGgvOVl1dWVNWnNMOXRpS1JkK3pqaWFKd1BFMlJJcWt3cWx6Z1Fi?=
 =?utf-8?B?c09vMUxxMDNHa3R1UWNWeWdqVEhkWWJnZFBMeUFYNE15WTkva3RFYVRZRDhm?=
 =?utf-8?B?ZnNOQVE0NmJrWG5YZHJkTS9WQXRlY3JlSXo3M25yZFNXVklnRWNpbGdtaHMw?=
 =?utf-8?B?NTVvKzltSHFGc0gzdUNwWGxlNmNTdVpibVArNGt2a1FSV0FkR2ljd0Q5UmdE?=
 =?utf-8?B?N1hHVURHSXZweXZENENNVnd4M3M1b25MaDZGK3RaTGFqTXU5Smg2Mm50dllo?=
 =?utf-8?B?RlBkZkRhVlBiRnBYVkM5SDBERUlNejZrZC9GVlBSSTlic0tNaGxFOFVQQVM5?=
 =?utf-8?B?ek9meFlWZlBxLzdDTWNVdWlMaWpkVGFzdUtUOTZBNlBYOTlLL242dCtCTTNE?=
 =?utf-8?B?cGt2WVFCOStGbVNBNE85YzVQUld6ajRzOVlRZHhtZHVtSUg3TU1ObElUM1RH?=
 =?utf-8?B?WUhuM0tla3VIdDFwckdTK3QvMmZzcDBHQ0YrVDd4WHRydDVpNTQrSlFra1RR?=
 =?utf-8?B?dTU1SGloKzVqQk44RDhQeHN5M1hkdTVER0JMK0FwcWhISVI4K1NtenFWMnlp?=
 =?utf-8?B?L2JMTG41UXZxaWtWOFBiV1FFYUJ4VjJZd2RxOTY3WW15cytXZStia2ZXZGp2?=
 =?utf-8?B?V1gwT3lTcGVrWHdmWXJrZ3dVY2g0SEt4TlhlWmpIM3MwTE9rVjRHalh4NnVn?=
 =?utf-8?B?Sm80ZWlBSUV3dENkZS9uaWlvTnVNNmM2QS9Jb1Q2ZUxLSnlleFlMUW8vbXND?=
 =?utf-8?B?cU84aGF3NTMvcTM3dE01a2hMekNIS01JVFlVZHhxVXVQZm8vTHJvMnRPMzFB?=
 =?utf-8?B?aWt4WDZ0czN0bGYyTkZrL0lja2xwZU1LQ25ycER0S2pVM1VnU1hkdGp2RzJX?=
 =?utf-8?B?MTQ5SS84WTFlR1JEVHdIVWdnYzBWM1RNZjJodmxVMU44MHRLTzQ3Vlp4VkhG?=
 =?utf-8?B?WFBCbVN6cGF4ZUtTd0VlUnNMaUN2bmVOeVRyZEwwUWw0cTltZlliQ0JaSENT?=
 =?utf-8?B?dllZZkorY2dxZWRvUVNzQ0p1bzljdXQ5WkcxUEwxdGNPckExNENLbWsrdkw2?=
 =?utf-8?B?N1k2dU9FZ2dxZkdXYlNERXRCOEs1bnFkcXRWWlNqbE1pMXFhYTN6TnVPVUtL?=
 =?utf-8?B?Y2dtSmtyeCsrb09JU3pHQ2c1aGUwTjcycTlhYlRrcTJsUDcyci9SYkgzcGtr?=
 =?utf-8?B?QXVBRjRuSVVyOUxBWE9Jd1Y0MGFnRmIrdytmaFQ2MFh1aUxiVklLcXRXV05r?=
 =?utf-8?B?SjV6eS9nN3ZWTER4Tk1idVZLaHBTaWpialJkRjBKZ2tFdzhxMUtFTi81ajdQ?=
 =?utf-8?B?YnB1UUN2cmw4elN3L200UU9lZWZOTE53eEF6S1FZNmpqMG1KNHRXNHVqWXBp?=
 =?utf-8?B?VXRaeElOUm9DSGplcFZodkZZMGtNeVcwSGgwbXkwMDVQS0VWY3p4R2VFZ01s?=
 =?utf-8?B?RXdNc2pnMUMxTlRTVm01UlBKdHhWb2doMGJGVkRyK3RBOWtsNFlQRkVSSlZ3?=
 =?utf-8?B?c1U4STdwWXhwR0NRa1VnNnFYUXovQVM2eTRiUEZiVFFROUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXk2YmEwQjI0OFBNYldQYnM1L001UE9ISW4wV01mTllwWWtJZ0s4T0lUVzFC?=
 =?utf-8?B?aTkvTTlRbEMwaWVFVE9zYUV1eG9IU0puZVQ3WENoekJ6N2lTQzU1a2dpeW5t?=
 =?utf-8?B?Y0dJS2piaGRrUG1tYjFCYWxRUjVIbW9zOHI2QmhKZTFqZmdhYU03SDh1Mytt?=
 =?utf-8?B?NzkvbUlDYm55TmlFcE1MWFV6UXpiUDhYYTFoam56cHpFNytodUVGZ2VwOVk2?=
 =?utf-8?B?Z1VhUTVMTDMvRFV1clJUY1J0N0tjNndLdm1VZXcwQjlWRnI4ZlcyWjNsRnhQ?=
 =?utf-8?B?ZlBSbFFjUUVJZTFwaTF1R0RaUi9QTEU3Y0NQMVBHZW5DNWlMY05qR3VtTlUz?=
 =?utf-8?B?TUFWS1ZjTzh3MzBncmpRRE1VRkhiMkxWV1J2cXNyT1BHYUcyd09RbGk1UUEx?=
 =?utf-8?B?ZFNVa3hPbGYrbkw5aS84K2xHaXdwdWJQZVdGZEZDSjlqUEkrUjBCaGY3NS9x?=
 =?utf-8?B?WVVLT1VSbStGYURDM1JZVWxBVlkzK3F6ZUxucXlKSld5eUczRDZXcXUrYTdC?=
 =?utf-8?B?N25aQ1E2d2NGRjRIOVhnc0EyZjdFakRpa05uM2U1QWFSYUgxZUFMQ0VYZFl3?=
 =?utf-8?B?a2xQM1dIbnd1VHN6NkxDL3R3SUttSjYyRWQ0VUhqa2FVdVNiMk5uNmNvWXdK?=
 =?utf-8?B?Q09OcmVycWdKU1RLR3AvblpuajQ5UkJEcWwwNWc2cWw3KzRCd0tTUUovRFpW?=
 =?utf-8?B?ek9mS1ZnWWlYMG80TVFEWU1ZVHJyQll0Q084Q1J0dzZlRGpvTjdvS2lwTFpN?=
 =?utf-8?B?eGlmS2lnbVE1a2VXSEVBTVF1VkFCU0ZxdzQrVTNsdFdadm9BWUtpVVdXQkJN?=
 =?utf-8?B?NDhVYjNNNTV1SndRcGdvdUNEeUludFB6QTZjN290MWVNb3BqeDR6MjdpdGdy?=
 =?utf-8?B?dTR6WHBlcys1RzNTV1RUZmlyRlRIdmJ4VjlaNnVUY0Q3MFh5VGl5V1dKd1N3?=
 =?utf-8?B?N3l6RXc4eHYxb3A2UG5EeTl5S3Qrcms5M0g1ZlNWbXg0akdHS29rQ1FtRkpC?=
 =?utf-8?B?TzRaOUcrZTVkZmxiMlNTOWFjc1MwdlhGNUdIQUZ1MXpacURRV0szWGhPblJI?=
 =?utf-8?B?U2pyTkxuWGdqR3BPNnBuNWVqZVlyWUI2dEhQYjNDVFNQVHdubWdZT080cER6?=
 =?utf-8?B?SEM0aFVZbklJdmh0UmpXVkVmNG1Pb01GMkVCWVB6T0lwbDhlS0M3L3p5aUEv?=
 =?utf-8?B?NUVMdDhXVXFOaEkvbmlEb2Z3VFNseWJmWVQ5YmROL3NXQ0xTM0h5SDZoektO?=
 =?utf-8?B?aW5EZVpRaFJSbU53OURHSHd0cjdPY3k5SS9YMjQzTExvOERjdzdJODZMM1lB?=
 =?utf-8?B?QjIrV3pXY015NzdRSTNZL1hEK3MrODQ1U2R3cjhPYW9MNVhGbHhRVDV4VW1W?=
 =?utf-8?B?S1NjMy9ybmdkRGJ5a2hhYkoxZEFCRWNCa0lkMGEwd205eDk4RXdGYUVjZHRx?=
 =?utf-8?B?NW1qVEEzT2UwVERXOUEvT2lrc0VnL3VTSUllNjlvR0VWVlgwU3Zvc0NkZnlK?=
 =?utf-8?B?azhYcW0zekpUZkVTYVlIamRKaGhZQlFxdXNUNytoanZ4ZkhFTC82L3VmSW9X?=
 =?utf-8?B?RDNFQUluQzA4dnlwSHczaUVRY2h4ZXgzWWF4NFNwTTlJMy9uOWMwd2hKNjha?=
 =?utf-8?B?UWwwcmNPc1ZCOTRLcFUrOThPZ1dRNC9xcE9sU1RtaUwzdUFVRytwMzJTMjFM?=
 =?utf-8?B?N1I2NGZmT0lVMVpRbXlnTUVmc2w1YW5KZWhDQmZQb1F4U1ZHL2UrNDdadU1Z?=
 =?utf-8?B?RU5FNTJNaUNLTXZzeU8rQTZseE5GZk4zZDFqaW8xbDNKd3BJWGZpYVBpTjNN?=
 =?utf-8?B?dGxtR2EwOCt5bUthK0Z5Q0lRaDZuVmkxYVlnd2xINkF4ZFh2aG52N0o1S2dX?=
 =?utf-8?B?S290YVE3YnRHQXBIYW9ZR3diN1oybENlcUd5SzdQU3JTWWI1Zm5OQi9kRk1z?=
 =?utf-8?B?aGc2dFo5V0YyRkhpZVlicVREbC91a0ZoZVJ3QjZUTFBaVk5wVHBmaFdoM0JN?=
 =?utf-8?B?OXVPRXB1TFR4SkxMQlJhVWpvZU51R0hhWWhFbHN0a0pzcFA5czBlbmdLY3lX?=
 =?utf-8?B?VXdjVUUwa0tUMGVVaGJCUDlKaEVQeStROWZTdGZRR281RE1jR2ZlaDViVUJU?=
 =?utf-8?Q?stbdjBG5omPLHUOyAaUsvU2hS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb4ef38-f1ea-46bd-00db-08dd1c08a426
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2024 06:29:19.5399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38+0FHIIae4K02D5hMBaU1Jxu7twozt7UMOWQdLBq2jsRRtHexlEnC8koQ6LibzgFc1JpolVn/5QUyyIIEh9jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4220
X-Proofpoint-GUID: qlIiDI2jrdj-Pkq8bIlY6ZYW9oRy8d7_
X-Proofpoint-ORIG-GUID: qlIiDI2jrdj-Pkq8bIlY6ZYW9oRy8d7_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Pj4gPj4+IEFkZGVkIHN1cHBvcnQgdG8gcmVhZCB0aGUgdmVuZG9yLXNwZWNpZmljIFBDSSBjYXBh
YmlsaXR5IHRvIGlkZW50aWZ5IHRoZQ0KPj4gPj4+IHR5cGUgb2YgZGV2aWNlIGJlaW5nIGVtdWxh
dGVkLg0KPj4gPj4+DQo+PiA+Pj4gUmV2aWV3ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJw
ZW50ZXJAbGluYXJvLm9yZz4NCj4+ID4+PiBTaWduZWQtb2ZmLWJ5OiBTaGlqaXRoIFRob3R0b24g
PHN0aG90dG9uQG1hcnZlbGwuY29tPg0KPj4gPj4+IC0tLQ0KPj4gPj4+ICBkcml2ZXJzL3ZkcGEv
b2N0ZW9uX2VwL29jdGVwX3ZkcGEuaCAgICAgIHwgMjAgKysrKysrKysrKysrKysNCj4+ID4+PiAg
ZHJpdmVycy92ZHBhL29jdGVvbl9lcC9vY3RlcF92ZHBhX2h3LmMgICB8IDMzDQo+PiA+PisrKysr
KysrKysrKysrKysrKysrKysrLQ0KPj4gPj4+ICBkcml2ZXJzL3ZkcGEvb2N0ZW9uX2VwL29jdGVw
X3ZkcGFfbWFpbi5jIHwgIDQgKystDQo+PiA+Pj4gIDMgZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+ID4+Pg0KPj4gPj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZkcGEvb2N0ZW9uX2VwL29jdGVwX3ZkcGEuaA0KPj4gPj5iL2RyaXZlcnMvdmRwYS9vY3Rl
b25fZXAvb2N0ZXBfdmRwYS5oDQo+PiA+Pj4gaW5kZXggMmNhZGI4NzhlNjc5Li41M2IwMjBiMDE5
ZjcgMTAwNjQ0DQo+PiA+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL29jdGVvbl9lcC9vY3RlcF92ZHBh
LmgNCj4+ID4+PiArKysgYi9kcml2ZXJzL3ZkcGEvb2N0ZW9uX2VwL29jdGVwX3ZkcGEuaA0KPj4g
Pj4+IEBAIC04LDYgKzgsNyBAQA0KPj4gPj4+ICAjaW5jbHVkZSA8bGludXgvcGNpX3JlZ3MuaD4N
Cj4+ID4+PiAgI2luY2x1ZGUgPGxpbnV4L3ZkcGEuaD4NCj4+ID4+PiAgI2luY2x1ZGUgPGxpbnV4
L3ZpcnRpb19wY2lfbW9kZXJuLmg+DQo+PiA+Pj4gKyNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRp
b19jcnlwdG8uaD4NCj4+ID4+PiAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX25ldC5oPg0K
Pj4gPj4+ICAjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fYmxrLmg+DQo+PiA+Pj4gICNpbmNs
dWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19jb25maWcuaD4NCj4+ID4+PiBAQCAtNTIsNiArNTMsMjQg
QEAgc3RydWN0IG9jdGVwX3ZyaW5nX2luZm8gew0KPj4gPj4+ICAgICAgICAgcGh5c19hZGRyX3Qg
bm90aWZ5X3BhOw0KPj4gPj4+ICB9Ow0KPj4gPj4+DQo+PiA+Pj4gK2VudW0gb2N0ZXBfcGNpX3Zu
ZHJfY2ZnX3R5cGUgew0KPj4gPj4+ICsgICAgICAgT0NURVBfUENJX1ZORFJfQ0ZHX1RZUEVfVklS
VElPX0lELA0KPj4gPj4+ICsgICAgICAgT0NURVBfUENJX1ZORFJfQ0ZHX1RZUEVfTUFYLA0KPj4g
Pj4+ICt9Ow0KPj4gPj4+ICsNCj4+ID4+PiArc3RydWN0IG9jdGVwX3BjaV92bmRyX2RhdGEgew0K
Pj4gPj4+ICsgICAgICAgc3RydWN0IHZpcnRpb19wY2lfdm5kcl9kYXRhIGhkcjsNCj4+ID4+PiAr
ICAgICAgIHU4IGlkOw0KPj4gPj4+ICsgICAgICAgdTggYmFyOw0KPj4gPj4+ICsgICAgICAgdW5p
b24gew0KPj4gPj4+ICsgICAgICAgICAgICAgICB1NjQgZGF0YTsNCj4+ID4+PiArICAgICAgICAg
ICAgICAgc3RydWN0IHsNCj4+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICB1MzIgb2Zmc2V0
Ow0KPj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHUzMiBsZW5ndGg7DQo+PiA+Pj4gKyAg
ICAgICAgICAgICAgIH07DQo+PiA+Pj4gKyAgICAgICB9Ow0KPj4gPj4+ICt9Ow0KPj4gPj4NCj4+
ID4+VGhpcyBzZWVtcyBub3QgdG8gYmUgcGFkZGVkIHRvIGEgbXVsdGlwbGUgb2YgNCBieXRlcz8N
Cj4+ID4+DQo+PiA+DQo+PiA+TG9va3MgbGlrZSwgdGhlIHN0cnVjdHVyZSBpcyBuYXR1cmFsbHkg
YWxpZ25lZC4NCj4+ID4NCj4+ID5zdHJ1Y3QgdmlydGlvX3BjaV92bmRyX2RhdGEgew0KPj4gPiAg
ICAgICAgdWludDhfdCAgICAgICAgICAgICAgICAgICAgY2FwX3ZuZHI7ICAgICAgICAgICAgIC8q
ICAgICAwICAgICAxICovDQo+PiA+ICAgICAgICB1aW50OF90ICAgICAgICAgICAgICAgICAgICBj
YXBfbmV4dDsgICAgICAgICAgICAgLyogICAgIDEgICAgIDEgKi8NCj4+ID4gICAgICAgIHVpbnQ4
X3QgICAgICAgICAgICAgICAgICAgIGNhcF9sZW47ICAgICAgICAgICAgICAvKiAgICAgMiAgICAg
MSAqLw0KPj4gPiAgICAgICAgdWludDhfdCAgICAgICAgICAgICAgICAgICAgY2ZnX3R5cGU7ICAg
ICAgICAgICAgIC8qICAgICAzICAgICAxICovDQo+PiA+ICAgICAgICB1aW50MTZfdCAgICAgICAg
ICAgICAgICAgICB2ZW5kb3JfaWQ7ICAgICAgICAgICAgLyogICAgIDQgICAgIDIgKi8NCj4+ID4g
ICAgICAgIC8qIHNpemU6IDYsIGNhY2hlbGluZXM6IDEsIG1lbWJlcnM6IDUgKi8NCj4+ID4gICAg
ICAgIC8qIGxhc3QgY2FjaGVsaW5lOiA2IGJ5dGVzICovDQo+PiA+fTsNCj4+ID5zdHJ1Y3Qgb2N0
ZXBfcGNpX3ZuZHJfZGF0YSB7DQo+PiA+ICAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV92bmRyX2Rh
dGEgaGRyOyAgICAgICAgICAgICAgICAgLyogICAgIDAgICAgIDYgKi8NCj4+ID4gICAgICAgIHVp
bnQ4X3QgICAgICAgICAgICAgICAgICAgIGlkOyAgICAgICAgICAgICAgICAgICAvKiAgICAgNiAg
ICAgMSAqLw0KPj4gPiAgICAgICAgdWludDhfdCAgICAgICAgICAgICAgICAgICAgYmFyOyAgICAg
ICAgICAgICAgICAgIC8qICAgICA3ICAgICAxICovDQo+PiA+ICAgICAgICB1bmlvbiB7DQo+PiA+
ICAgICAgICAgICAgICAgIHVpbnQ2NF90ICAgICAgICAgICBkYXRhOyAgICAgICAgICAgICAgICAg
LyogICAgIDggICAgIDggKi8NCj4+ID4gICAgICAgICAgICAgICAgc3RydWN0IHsNCj4+ID4gICAg
ICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCAgIG9mZnNldDsgICAgICAgICAgICAgICAvKiAg
ICAgOCAgICAgNCAqLw0KPj4gPiAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICAgbGVu
Z3RoOyAgICAgICAgICAgICAgIC8qICAgIDEyICAgICA0ICovDQo+PiA+ICAgICAgICAgICAgICAg
IH07ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogICAgIDggICAgIDgg
Ki8NCj4+ID4gICAgICAgIH07ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAvKiAgICAgOCAgICAgOCAqLw0KPj4gPg0KPj4gPiAgICAgICAgLyogc2l6ZTogMTYs
IGNhY2hlbGluZXM6IDEsIG1lbWJlcnM6IDQgKi8NCj4+ID4gICAgICAgIC8qIGxhc3QgY2FjaGVs
aW5lOiAxNiBieXRlcyAqLw0KPj4gPn07DQo+PiA+DQo+PiA+SSB3aWxsIGFkZCBfX2F0dHJpYnV0
ZV9fKChhbGlnbmVkKDQpKSkgdG8gYmUgc2FmZS4NCj4+ID4NCj4+DQo+PiBTbWFsbCBjb3JyZWN0
aW9uLCBJIG1lYW50ICAgX19hdHRyaWJ1dGVfXygocGFja2VkLCBhbGlnbmVkKDQpKSkuDQo+Pg0K
Pj4gVGhhbmtzLA0KPj4gU2hpaml0aA0KPg0KPkRvbid0IGFkZCBwYWNrZWQgcGxzLCBmb3IgbWUg
aXQgbWVhbnMgInNvbWV0aGluZyBpcyBub3QgcGFja2VkIG5hdHVyYWxseQ0KPmhlcmUiLiB3aGVu
IGluIGZhY3QgaXQgaXMuDQo+DQo+YWxpZ25lZCBpcyBhbHNvIGJhZCwgc2luY2UgaXQgY2FuIGFk
ZCBwYWRkaW5nIHdoaWNoIGNyZWF0ZXMgYWxsDQo+a2luZCBvZiBzZWN1cml0eSBpc3N1ZXMuDQo+
DQo+SWYgeW91IHdhbnQgdG8gYmUgc3VyZSwgYWRkIEJVSUxEX0JVR19PTiBhbmQgY2hlY2sgdGhh
dCBpdCBpcyBhbGlnbmVkDQo+YXMgZXhwZWN0ZWQuDQoNClN1cmUsIEkgd2lsbCB1c2UgQlVJTERf
QlVHX09OIHRvIGNoZWNrIHRoZSBzdHJ1Y3R1cmUgc2l6ZS4NCkJVSUxEX0JVR19PTihzaXplb2Yo
c3RydWN0IG9jdGVwX3BjaV92bmRyX2RhdGEpICUgNCAhPSAwKTsNCg0KVGhhbmtzLA0KU2hpaml0
aA0K
