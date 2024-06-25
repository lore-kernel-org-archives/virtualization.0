Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED327145FF6
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297724; cv=fail; b=pXMQtHkhivlBn+T2TzsQE/C9scUoymkB0JBOUWvxdh03gnnpaOSoVa4siNCrzCAoceVrgREmadQbZ5BC/s2HK0OS3PK0LbmkTHdN6yNEl5eGS/HlWFjxZTv78KuBT9utL4Xp59cA68eNOEwMtw8VA4nWs5EeEBofceW4fze1I8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297724; c=relaxed/simple;
	bh=Tayi3WzZw/eFSm08xu7wGXzT8dIUHDhR8FVDy9NnZVk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QN5cfzhH7KDqoigNpOm76M1mqWPp5bk7Y2yKc3djUfOnchsumtxs1/ZSTEwVQapCNW0nzqti24QflqCv9AyRaTm7ktC/6xD0OaosP8v0upj8yd1a49CMd5e9RJ3EWtH9BEqU+E/ZBMTuhvu8WhUp4o+ERxwn7Gy7B/AO5HF1sQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sej+DBNS; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sej+DBNS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3eLdb4oRzcZlvr1UylZKlhy9onoQGJd7SeugVqZWTUbMMb0wrdzRZvh0A18a8P/kT0ZPZjKJteWU8bimHoBhRUpNeG2ualGObm+J+z8ipWYHM2fjCHE0Ya0qEPB0hjIb/E867EDCnA9Kzv3mGOVBkiZDAihBTch8wMhtrHswyWgeZ1ku/n1Bp7drelUQzTMVUaJISEjft65BRmnF7C/jNJOxeMtWRU/VHJgjLAVMMNUDggST6brPbGlq+jugkZekMvzArgBM5/Kc+n00CoqElXTaHmWPZhrzFR+T6pzwagx63/6lfMVQ6ayeuITfYZV6TnmDEAkCW1dYgc3OituMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tayi3WzZw/eFSm08xu7wGXzT8dIUHDhR8FVDy9NnZVk=;
 b=M9kxqj5e1AC7A0vWFKvrHwM7Swk2NoM2NwT3LZb0wCV0292e2PTGpij9zruomDxfPDcdnh67rnQfYlnPhq94hvvBwQCeWpNL73MVm76TgqF2O9nzTkDXOXwvxSNO4zF6MTcbEd55uDMOOx1jkag2QH5MR6GeZjaoeQyaw1EOaPXFVpbu2hKqYntnHkX8QJOuJbzSoEr3Oy0cHNel2cBTfiMWOSHKjxqOfnYyh5DBSP9uH4vdkPUEJ5eUK0QGmHdfWWqrFaFbojsD3auAYKdzySG1gF0VOp8WWQE+C0HjV4EPcJBUG9xetpqeRBTvhOGypV8IRLT/+gs4U4FIKzKzJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tayi3WzZw/eFSm08xu7wGXzT8dIUHDhR8FVDy9NnZVk=;
 b=Sej+DBNSiGHgWfjgcQONxXZrmS4WrP4FWmIhQ7KAdhzbRArTevXs50RM/SOlp7M+kLMY7wcx6TPefLgpNBGm5BWJIkGDu7gmlp1zadZdte5Omiukt1DEvPh7T2o5F0uSbpaBtBzZzomdxk8+qB7zpoKsmh9GYTLsgdV9xG+Pt+bksbPeqvWPlXhjYB66M9yvO4bd535XUF/WbZTryIzIC+y56/NjakAhzvEGEOtShnkHlLO1zBKItPxnCJrHtGqmmZaKf8xVULIdYltpQ812xEUVQY4PIhzYCHwIPSaNNVS5LdVkYsUZ1vsPbqVeLLjDJ+XW/1eznpASOMT2va//uw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Tue, 25 Jun
 2024 06:41:56 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd%3]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 06:41:52 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, Heng Qi <hengqi@linux.alibaba.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	Feng Liu <feliu@nvidia.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
Subject: RE: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Thread-Topic: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Thread-Index:
 AQHaxhWYDh9AqSDb90uEf0IIROIBL7HWrKsAgAAY6ICAACgKgIAAAqyAgAAPkoCAAAcGgIAAtusAgABKlACAAABeUA==
Date: Tue, 25 Jun 2024 06:41:52 +0000
Message-ID:
 <PH0PR12MB5481409E517CD45449CAE1FCDCD52@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <1719222832.5704103-18-hengqi@linux.alibaba.com>
 <20240624070832-mutt-send-email-mst@kernel.org>
 <Znl4q_ArglG1aqPv@nanopsycho.orion>
 <20240624095239-mutt-send-email-mst@kernel.org>
 <ZnmH-eMBfsPkDpkd@nanopsycho.orion>
 <20240624111347-mutt-send-email-mst@kernel.org>
 <1719281486.8829272-20-hengqi@linux.alibaba.com>
 <Znpl3lrArGU8EdFQ@nanopsycho.orion>
In-Reply-To: <Znpl3lrArGU8EdFQ@nanopsycho.orion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB7144:EE_
x-ms-office365-filtering-correlation-id: c9f2f139-4d7e-4f6f-5664-08dc94e1e61d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+hEkeHvU7tpqoNUOqB9O2XOvo+2DEhMlgEJnSCpRxmiw4dEvku7ZTRmAMlBq?=
 =?us-ascii?Q?bVuCKlSU6d6ZeUQDLX2LP4suBJnbs5y9s/3h7CtDCCYlG2C76RHgLVcsRuQ3?=
 =?us-ascii?Q?T7sS//kazMY9EO4595zGG+avxDMOIcYCOgfobhYHaC64uoaBILmlXkM8frcB?=
 =?us-ascii?Q?Kpy7Kl1d+6V7s3qtH+fwECNKagTdanv4rSpZwaJgUkDuuBnh2nm3hV3lx2cK?=
 =?us-ascii?Q?D1O4leSdvEGYCVv82sNoqkxAde6DO7sxbkWm1wRCLVrApgOCJ3cHzAXwRwXW?=
 =?us-ascii?Q?JRrJH1jBmrM1tPf+NdvCGuRib9cOaYiZ0h3IhiWPLe9mXdv4c/lKp0as2G9K?=
 =?us-ascii?Q?RNCJd74P6+RMpKjt9k1PbCIir+g+w05HRSZ/hUi83/8QB3z6S/Ae/zeW9xMU?=
 =?us-ascii?Q?lAKNd5Aic7QcGKNpmilzmQyFFVDNGE86G3lzU/pjSO4h4CjNasULIqtBVHen?=
 =?us-ascii?Q?zEbs+6utLzukUt7CgywuMvqszmzkz9NhJF03KiWu5IzWfzHhuF33A1xTHaIF?=
 =?us-ascii?Q?3zJYoZS9oBN76Rf6MfuiIkouvSUuG32n3DRDO+cijOhXQ0ia9t/LmjSCbQa2?=
 =?us-ascii?Q?IxTwvWFDqtU8Hv+cwPxa9zQTQvivYGRPSfXcZ9WvMF7+dlvV7dp1OjSWzOWn?=
 =?us-ascii?Q?qwEhrYwfHW9ysPcKNFRfKDgPOEy3ojUApTKVY7YUzImq7XfRZhb4crVc1pZ7?=
 =?us-ascii?Q?Dr1i0Tk9ztuV9P9NaohFXhbT+NYmrZ4sTJKLl595MXXpDVpY1TyXMunca4dV?=
 =?us-ascii?Q?CnWDPQyFg3gB1jQKyF5FrKq1YKIHl9Y/QOvHymDC+f6TjDELJ3tGwAA4s2dO?=
 =?us-ascii?Q?kwPlE0H/l5NlisO1C7RwFQAPGk6tFEJ9OOVIOSJXa+JdtNjbCVIwZR0L13RA?=
 =?us-ascii?Q?9voeeFHMV0yzs2ilO9E1YzsbvLVPohNb7cwMCEXjHtwA6Os36b/UfEMfkBK+?=
 =?us-ascii?Q?nKVIi9b55mQyQQJuzkBmOVJc90SlyQDr0bAWwDlyo/mhWA8VQUGaTUcDv4R4?=
 =?us-ascii?Q?lwMVPqqLW//g4QuoBR+y+NImaU3d+PWrbZuyuuLMe+JZWAyUFaS7WaygF6eH?=
 =?us-ascii?Q?0EnveeDAHaa7eku+l+dyqbLLMA9RtcJdRo12xgCsZI7bEXYCj1/ruFF0lV1g?=
 =?us-ascii?Q?fZPZJ7ORbbkWilzNjx0Gq3Aq1DMbodyGc9tgBaJIJaeePj8b/A58JJ8bNCiW?=
 =?us-ascii?Q?/HWVBLVEo0W9nP0rpNOAS3G+fYLiF6SrOsULTvjCSdV+kSsJH/Z89VutYeSh?=
 =?us-ascii?Q?D0Ne8/OHPeS2adHGe2fMwWmobGC85Q2ut3d+SQH+UefAOiyiFOb/buOWAbAz?=
 =?us-ascii?Q?Jv/abD23RtqAHWnX+ZDifLa6QG4YT+JRdGGbPBNPTXdfRUrDE4/NNriwsWpa?=
 =?us-ascii?Q?BdBxU4Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YvjcnJ+dJNfHViaT9JoJE7q3KKerLTS/SvofZ6zYM6gdYy3Zpmhyyrqxdysq?=
 =?us-ascii?Q?4wnvVH5/dRDUFDSNYSh2bPnZswIhQnAVWXBUEDd5Fr2a/AHLKChBMvGrJa0s?=
 =?us-ascii?Q?7UwTo9rxnMNaFk++lw2IQMczeer2mlWNBglBum5ssgfR31SKraqQW2b5DnJi?=
 =?us-ascii?Q?U9vsuqEgwqam6SttZGugXC/RHDvMw5FwtHB/BkIEznSj6DvGCX3igYrgUp7v?=
 =?us-ascii?Q?6l07k04OYFVjvoCjRm7SOfEdbHefQqsot1c1JYFoYap4inIkgVKqCMxZUZDV?=
 =?us-ascii?Q?4oaEiGZoYp+kMHb5ahbgb7weRLO1LfkGxw8HYJ8VXMG02bza3N2ac7p/5t7C?=
 =?us-ascii?Q?1oABFzxW0YnZ79GmDRs5mo804JHXFGAe0GQKDHFJ2BMQTWiEv89d9M0YNj2C?=
 =?us-ascii?Q?z3nU7uyPEKiywEWpDk9ZqZPTM9Z5n6KM3adfpbQ11cSBF9Jhs5fVxTOa6SG1?=
 =?us-ascii?Q?yY5lSr2UOjBhpMnWe256FApYWY90CpXvy8xnV+BWkcfrCAwZi2WnL3iJWM/R?=
 =?us-ascii?Q?ZG0ecwYY/l/QZAh0Y0mp69ynsfpQzTqNm5xfw+eOcuXRjjj9/HPbwdAiXefp?=
 =?us-ascii?Q?T4C6JTD9cSSeOm8Sr894SjZg4VxJKmNl9nsbxIqqhwm3Wyz8WkYz17JQ//P7?=
 =?us-ascii?Q?6V3OX5K7ohYAvyZG42hmLGGmYKzQf996FZLIDQ+lvwJNzhfHxAFDuKuZUG0x?=
 =?us-ascii?Q?qqpzlhr/MHfx9JCck7upYLf/i5m8J5bxzSCrQIRvi/NMSTYR0xPj0FsgPHa4?=
 =?us-ascii?Q?KmpG/j2krT4/v7GW8/FIK6lcOQ3nZCMyEYx7ZsYd8ApfUY+1VVqnHlbPGxlm?=
 =?us-ascii?Q?fEktvo6CLOMqzy0a/aTNpprBQN3aOfc6GMYAqtcJu75eZQeFwXjZ+ZWV3Eci?=
 =?us-ascii?Q?chU/12lUf0WI9OOKmUwLd/QKJUH+bMmXYcyLVMkV2ZZYGPhWojT8UvLKpzpq?=
 =?us-ascii?Q?HDqEwFT6QvtaQ6DM2cxkc8488O/4eHIoNLM/ZlQQflSPot7QdWiq7ZXqCkno?=
 =?us-ascii?Q?bQDK1FFodZa1zj84zxjCA3UDGcDUbFWqEdcoOPMSujiGhNAJASHFtad//sTf?=
 =?us-ascii?Q?p9omYzs0LxbcI7vBduhZNbNkl0XNsA7TH/3zUxMbmAooPit8JmxUEAKfJU5o?=
 =?us-ascii?Q?5RcGh/Nh/3cGagWJTAOmH1rU3OUtc7Uy8do4s/T/GhBPImai79esmSXPAxQV?=
 =?us-ascii?Q?Yqxk4KrN6fzZu2XLPo1+NHN6f6m+h8pEmB9j3pyW27MIa6QPl4sSkM0POmUy?=
 =?us-ascii?Q?bosnglHIy75530UZmwB3BM4EX2LgvtP5ruqEFuE9NRoD9RkSY3ixMgrbCl+T?=
 =?us-ascii?Q?fl5OKreV4UgJJFoEuKbwLQkRZU3Hk9vmaG18dlNVSp8jEOPSOpTPmdXAf09a?=
 =?us-ascii?Q?5EsyrPOAuZ2iy7/bjrV7ntO98nX7Pbkr7go9IIlgcwTavXnCZxLCJzfhSizD?=
 =?us-ascii?Q?d8ehOrdSIdPp82eLGz3ksUxk8/Hdv7F9uEt9f2rLnObSoEVVtjX8fO/EI3oQ?=
 =?us-ascii?Q?VJwHCjXI+lZrtK9aX2B9PdYCIpng5hz73LUvtad+TR83rCyss4Lsk1LwAG4I?=
 =?us-ascii?Q?OQS4/EfQRtZpu9IwJ9k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f2f139-4d7e-4f6f-5664-08dc94e1e61d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 06:41:52.8661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJx1F3uDQyXt+CcJenmRH6vF9jmgiUugGei+zlL72tIsFyH5rWtoRvlU1Hvl9TRbfIW7QRSBUeWoAVC7pBXY1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144


> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Tuesday, June 25, 2024 12:08 PM

> I'm working on a fallback where admin queue and cvq would share config
> vector. Lets see.

Cvq or avq resulting in performing more MMIO reads of the config space is n=
ot good.
CVQ and AVQ sharing irq is good, but it should not share with config change=
 interrupt.
