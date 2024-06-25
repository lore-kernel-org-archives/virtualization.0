Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF09414AD2B
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320046; cv=fail; b=DT+4UF9E/eWLADBevrRZOx6kw4BLp0UErtJ0Bf/+Utr5yU7JLyJWZp6txBtzCS1sCvZK9AfwvN+w36q+dkU+KUiUZCD2VRn+CNJYWdhRdXziDgX8Uk8BxeZOa5BVDJnCNpQFcDbvnrkjATI3EbfG4pCAs2y7Xe39Xh9E1QTGWck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320046; c=relaxed/simple;
	bh=dmlJdMPMocwCItqrJDAIB83ibcWrrftUjl0bGABTZRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u4D8rGrxK+o7Cp1qK2UOWrQnTmE0KDajmiDYcmoTM9vfBdzX0RWDqivbYS0sXQKFi5r7VP+rnev8S+n7vGwJ7Hv0qbXVUs2WSckf1jPwE6m3c94xo4S3A5Z8vatXt0gB/rP/pdiZJDMmjRaDuVILmfwOQbVh+Czoua44m9A4IHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W9M1elaV; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W9M1elaV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P65wbJ9gY1tyFz7E2kCb+q29oteBRCgehHpkChsH1KvGJXqxaC2yBN816sts2YEiBDEUqXqcL0HOmUta2sQJ3A0gs2diIvsieFUVliX//eW28E6DDa3Kv8Mm4GXKeepi6bSnNrX1gXFsZcNNz1mzXhR3uxRk9OvKkUPSFEKRSOp82X13yJh6VAd944KigwUjFtos/GCWWosAoJultdlqWCMQpd+D/9kYSDvSeoPjAp9izp6ZmgBxSgLtZmEQxi7XCNouWzqGOnID5piJWCJz7mdrQDaaTeGuKYQ95M5rGVeKdlZmGHH36ibgiCANyM7gWs4RlMfBNPa/qmX4EmzRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmlJdMPMocwCItqrJDAIB83ibcWrrftUjl0bGABTZRw=;
 b=TCS7VQxZCCs3N51gHuM1fMIXJDea6dMhKu1YVKvCq1BmE13qHp79E9AaPhyvN/QWoCt0tu+CkLOYnF/sLb9EIM2x+VUysHKsenpdhz4Z5h82d80jY+ZWiIG4KPRfVBZY/BLVWbVoZdR3TRaBPWo6ct5QBqFz+B5oMhFklV+NTirkJOvl9/V0isAqtTIZoJVFepIpL9UlRqM0hiOxkhj9+D5shIHNE4pz3C4LIW9/ykPs81sZaZS9vGAliTnsl5aCqT6nNevs8uNKybk19YHlWPsp/aeyt7KtzJKDv9Zt8MlSQAF00PjAJfUHNmlBbRLQyxGQ2PzuZHtSZ1/ANMRimQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmlJdMPMocwCItqrJDAIB83ibcWrrftUjl0bGABTZRw=;
 b=W9M1elaVQXYW778nTGNe2R+aswjqPE6v+8knjjCGluQvfDysYXhf+pncKqBFT2aArFejE+pSodWm5fI/V/qeKdzXt0lhBU3gBuZgx67hh99/cYZ6EwWxRbikPcBHTlETxJuATEIB1B88cKA+gDFchAJT5fCuqlhIMgA/3RADaLz69ZRbFbjPlPHQqDRE+8+9ZebN5ZwFtK+HOKz5+0lft6nJpjBH5JzHj7VGtv1GsBzIXtj/WXNz2htjPuNP3eRjgTGQSfiEnC56Rx/npwgECwe+JZ+0IK/P0dkhUd0kQ2pni2DxEbcvQC1kcLpCFT7rpMVmprJB97Cfe2+h3t6QCQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 12:53:58 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd%3]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 12:53:58 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	Feng Liu <feliu@nvidia.com>, Heng Qi <hengqi@linux.alibaba.com>
Subject: RE: [PATCH virtio 7/8] virtio_pci_modern: use completion instead of
 busy loop to wait on admin cmd result
Thread-Topic: [PATCH virtio 7/8] virtio_pci_modern: use completion instead of
 busy loop to wait on admin cmd result
Thread-Index: AQHaxhWlMJcIKQNTd0yiRzyg0DVf5rHWx8cAgAGLsQCAAB2JEA==
Date: Tue, 25 Jun 2024 12:53:57 +0000
Message-ID:
 <PH0PR12MB5481C79EC78C589800FC865BDCD52@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <20240624090451.2683976-8-jiri@resnulli.us>
 <20240624072340-mutt-send-email-mst@kernel.org>
 <Znqk3LaiyhKhb2sg@nanopsycho.orion>
In-Reply-To: <Znqk3LaiyhKhb2sg@nanopsycho.orion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB8367:EE_
x-ms-office365-filtering-correlation-id: d1bd84b7-2250-49fb-f4d0-08dc9515e0ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1bvh6KS25ClLFgpCIntoQ1h9zoK4+qDV+3aGEeelB84q/zLMpTStOdapOzg1?=
 =?us-ascii?Q?j7cSb52tens87VN6m1K5pa6+J23rCfeKTszHh6F58gq6fbOwNYWd1Ak5ZmIb?=
 =?us-ascii?Q?e0GFPnaTzPpjYibKvJLvZLyrgMC5/iEnLZdg1jLSwxRXWGFEy2IecGdFKoGt?=
 =?us-ascii?Q?8NcDUUvM1kKwCvyBrJaw+Y7hqnG87HQ8LthVnje6o+jihJRfuQw3Whh4Xsd1?=
 =?us-ascii?Q?ogXDSizWyhIiEL7hbTQ+L1PedLjZ6ppD1i4WtgBtxcrQ/Q5gNfrjaFTupPBL?=
 =?us-ascii?Q?hv+b8QwodpWypiw6z9DQK9gSP3l7tC/Q1BvVMNj3opNYLXvboC7gQq2hEYvt?=
 =?us-ascii?Q?3k2pOrg/z9QSpz0hNYTRTYV/vay/oxGG068y+mGlTN37IGH6TqlQB9phoORF?=
 =?us-ascii?Q?X8FtyLuxQgNjrowz7FKRYaHsiXVmQAayI/QDSF8k34QvHAcnQjPrzRqAdjDw?=
 =?us-ascii?Q?hnufii9dJKgku96qOqB+72D0gPr9AvKyIcq6iDbew7dm1sNRtOTN8giCwsuW?=
 =?us-ascii?Q?aTK4a6jK5zm+DsxRqUDO3Dn+EzVyWoiSMZwo3SC2rPLE7ME7emW/s8aBpWYR?=
 =?us-ascii?Q?r1vLQ/3vO2XgQLieoX+y/H4zGk6kTEvpttlliJXAH6u6h9IBaT2nkMLlQJD9?=
 =?us-ascii?Q?9mcs3/Fgz34dj/pcdj0tZ65Buu7nk1u+YovOd1Z+KMMX9Jk85oqpF11AXs14?=
 =?us-ascii?Q?qL2/mLQVzoNL4mSzqyVzNG0ZreoeSEchijDlK9X8Kj8+RCX5gBsocR848UE3?=
 =?us-ascii?Q?hDFe54ZpkhS7Uh7GILW2mAQX6xp9/b8HXdoK+XRMAgCd2GP5sCx7EYNf+5kv?=
 =?us-ascii?Q?BE5inMGnCEVjJOKLvq5XhGFZ44v9djLyc3b60rrF9z6QG9+nuzBWUwQmPZP5?=
 =?us-ascii?Q?dhgt8/vDQTBr8AtGsIebuEtE/mWuLM0FDyhVcS+wYetn4u0cbyJErNoX06cM?=
 =?us-ascii?Q?RHGudUpD2b6y3G2i6tm8yRCJgHHohieeq8emNscf9h5URAyXSAtznWloK4UX?=
 =?us-ascii?Q?zFKmFwDjtw0XTappdYARTED4d2fOtzNgS5gEGp8lbpC07d5WQ7agc0vgKMjA?=
 =?us-ascii?Q?qxn4foM6JjTuK0CYcFKGm/pVffmfNxY1dx7/f4Xj0mKvng+S/TzL6W9igEX7?=
 =?us-ascii?Q?yw7D8gqoxfmgh3OJu9s3K0+MiHCLRZ52da/E6D7riIYXkS3k3YgUlw/PFwKQ?=
 =?us-ascii?Q?BBpfGkqOcByjAtol3nTQwAAwXSH4f7qTx85hj7REWwPJMZKSWSpsCKo354A/?=
 =?us-ascii?Q?+ZT/U3jKTCVU1OwQbzaI2X5ubutPqQCmNSzRSYfMglPfkJra9unIubBYfM2E?=
 =?us-ascii?Q?R0gMubXBw6OHIPdV7yzatJ+CFsZjVWIgA3bJNjmD6VY+vGtkLby4BLtMFj5a?=
 =?us-ascii?Q?bLuu+/+fND9JY5MxE0chwIU6p+JZ/aOeuysS5OQHmNyJTZRfWA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JAjRBM0uW9sVdJ3LdaaGfBVmk/5uWkypDKQshkmdpS6bBt6SWoOXg3r4daNi?=
 =?us-ascii?Q?lbnnnl69OgCySARAPfr/5I6GZtB8v69WlgpsnKjw3AvM7MYf61VKMW0qLXw6?=
 =?us-ascii?Q?MT5IkKLLC5MAfmzEQhwlik5E41RzGx1IOu8DB8ZXiz8W5Y6NL64riM0XILAh?=
 =?us-ascii?Q?IhWGarTwWmMJMgJCgU3NhS5bUI/EJeywQ5OnLS2/UZ3vUxuoBIyOB/HLZXvO?=
 =?us-ascii?Q?Uuy2nVRfNWbIdAxanXEoFL6eoaagLqnhyzHO9epGpPGcE66Y18uZJ4qRbGGA?=
 =?us-ascii?Q?XAe7hpSKB4K57I6XpfM2u0GIHa6Sr9zAF/LLhYy25AefgPnwtiHEOr8VNcFh?=
 =?us-ascii?Q?BBFesR/h0l+bYntflwGByY51EThulg7cK5uF6NeV8q/SZKhk1/+/VoOuZGhN?=
 =?us-ascii?Q?zKic/0RJHXyl1GfeR8WCmYO0Kjclg9aT1RwuI3y2sXqPIQllp9rcJnmhX5W3?=
 =?us-ascii?Q?sQchTieYeTGwbNr4sAoSQKavRxCdkynRxAb2YxscbiH++LHeHtasVoC7TC+B?=
 =?us-ascii?Q?BniqRFXXa4+vvWnM0i7jf1/MtKUC3+ldy1a3oP2bOJCw5B/fI7sEMydHUvGy?=
 =?us-ascii?Q?RvYAsOc1Zp+99Plmxe+tlHL4O087JSyUGX6d3ldTHysBbk7N2ueG88NtrJSd?=
 =?us-ascii?Q?EbEXyfhMPTlJopMrej34Lxe+7L2vTczWjvLYG3N5BpesRmj1ERgUWmX0rCOk?=
 =?us-ascii?Q?Yja55R9Vf52S8kIYvSkXJBmE2NdoNp099NlUQ5ws+78GDpfVtOoYMQsnUcHO?=
 =?us-ascii?Q?WerMNvfJB+FADCX3B4VIaliyLCCAqg7A875ikGP4XlDYqaponwfHeZ2mgUog?=
 =?us-ascii?Q?FPkRyFh1dv07Ekg225RkPoHEs+CNtLPU7+v/DrUqGNq6+InP4p03oj/YbMdi?=
 =?us-ascii?Q?UXHTWZ6IBQz6+g3IvxyrDjzGWuvk0NkKU0nlGNKIVn2Q7Dx+zvP7ZEkyvZ0k?=
 =?us-ascii?Q?1Mg3o2n5WJY9XhVuX08Sb9JWlpN2AA9hJl3WvDWxfyVxXTaJdfqGT++w7Lm7?=
 =?us-ascii?Q?z+NL2f3Gilf5DxaX3qUygagDtjzpblz/r/D/ES2EiBl8MMeLpVU18RU+kT34?=
 =?us-ascii?Q?n+vRldg+PCoPkyYlKGe6U4aticMaoEH/W1klEmJomFBr0MbHo2f6R3Rh9miT?=
 =?us-ascii?Q?0uVsoRo70uI+mxj/o5TDpy2VJM/BasAamCKGuJVSGD1rU4m5idJCpA/a0JFK?=
 =?us-ascii?Q?4C+/cEHaSXVIPS2Br+6Qw1++SbgNPYd+qLb6ZoPIdOE+HL2hIf4/xCQoQtM8?=
 =?us-ascii?Q?9kxG8GSkQZ5SEV4oDb2bxc/ctXVC4HgFIp5kqw8DrhI+4+M/oPP3bz/jdOrb?=
 =?us-ascii?Q?NiqApvL1YcjW/Dsh42e/nYSicU+7GU2up+FmLWCZflnsiJlWrstohqGVykTT?=
 =?us-ascii?Q?Li2pVspqgeEO6D++edvliHk9HCkAC33Bn7qCf+Z6EACKbZyc9mo7EHBZU2WP?=
 =?us-ascii?Q?3LxYtXLmDrQBWPumrI3v5S30VRdvZ9WGj1gHd2ctrTMAYD+HXmE2WbyU1cCr?=
 =?us-ascii?Q?ulmsJPAMIUEIxk1k8P5OqSOLkjt3Ooc9bMh/s5xCKvJXA7FqUze25+1sIaAO?=
 =?us-ascii?Q?wuJLt6P9F9kymgAJcBg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bd84b7-2250-49fb-f4d0-08dc9515e0ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 12:53:57.9557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hncOvRsg64HXcIUeUTY0/L7wzTPym/wEMtSzN02+/W8WP1ms/4wMU8Qi4F2DGKNDxasC0PFesTDU/0GjJ/C50w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367



> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Tuesday, June 25, 2024 4:37 PM
[..]

> >So if you are changing that to a completion, I think surprise removal
> >needs to trigger a callback so the completion can be signalled.
>=20
> What exacly do you mean by "surprise removal"?

PCI devices can be removed from the PCI bus while the driver is running and=
 with outstanding admin commands.
Pci bus's remove() is called and this needs to notify and complete the outs=
tanding commands with the error ENODEV or similar.
