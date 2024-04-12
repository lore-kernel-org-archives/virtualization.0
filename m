Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8117BA9
	for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 05:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712898821; cv=fail; b=Zbk3Pnc0lwlyZq/j0QR9biGCqwyJ7kFMBcZLmDfzdVjwR5zuWaaLqaqdz3SDkPwLEl1EVOSikfa1Q9W/MN7qB5x5GOqAoSizw5PtvQWwVROchJp5uDY69X6LRl8VUmjkVdbad0zTLHFqF6hLIP3ZS/4rblHQmKhq9fUEr23s9dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712898821; c=relaxed/simple;
	bh=9JF7cTQZss/TeCyaol006ANwxE+gNVG9W6v9MICqeTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CagezPTAdLsy+cjNu1Rglrp5D5RJhi7FmWPQD03pzJNwpignelj/Wp+FF+KqXd11eMQEZ8/PgRwI4ZMP7Z2rmxp4w0e4t4ghk65tOkiro0JQAsJJv3TNxSyElMjcEGn0xpPfjxARvAUOUU6DETYr0p7p6gosvpN1STxPbiQF6ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=jEttoZuu; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="jEttoZuu"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C4ADuB009071;
	Thu, 11 Apr 2024 22:13:33 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xewph04mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 22:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2L8XbaPlrRXeuNLGq3MxFK9WtjcUre9wppDVG+O86QlHLFB7mOgWPBj+nO55/VWrh56dmjfPrtIsJL9yVGPZu3QCkzv5drQd3xCZE8MhuS3tI9vTuOtvGpAiIjUESx6aCQOW+OmBlGpG6qGOpyyI8mLmq9JPjpYQtNMFOH23jyVc3pzSmnXkTysvOsTtU5v5G4xHY2ene6F3+BEZMKlkUACKUxgjr+YD22CQIRGGPKjXcmaZC7i7KefBEqWrrdNy4YXcefBEaM7ZdK9v/enk1xZoTmDk0fktByxXARkaWuz3ct9NfZjOVbVhbDP+iYUHLqW4NjWJPbifs+lBTkozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JF7cTQZss/TeCyaol006ANwxE+gNVG9W6v9MICqeTw=;
 b=VIpCPKoMUGo5dwvunf6gi8uARS4qz9mF89Ye1DOQiE1k8hI2VrV6idjGICdRZgZEkVeeGKidm6ZKFVXUaKjDUHAapBY9zRwmswx9Ks0AI0+8dT7iN63nkPyUDoqGSO0XZgCCcTPgVAhy25nsv+NFFCxuUvHEQWIjGM9j5HN4XlNE20Y8IEJoxwY4KKJ1ODYUShSud55VKeb/eU0emZZ5uCl393wqdg/lVDR0J7zgBIuA5PQp8sj0vK6m952PYSdHrZfDXwM+Q+LdgR/Aoe3VliAHkz75VYLjnzUsefvGAMDgaLhctpukWjXTL+Njbt5PAzCfmPu4tvu+xQz4Hr+HYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JF7cTQZss/TeCyaol006ANwxE+gNVG9W6v9MICqeTw=;
 b=jEttoZuuOAK6yNwc0dw7/tI/vPK5BxJSc+KcgBtNXaRJ/xpPtbWUDFFFHKoH/Dfs/rI636MAX0aHhd8kkpPlvVIqWcnxjM26XU+Lvv/qIPwxCa+nmBAXXblO2uN3zxEIsdaVSu41P+MS6bJz3eTyk9lxpUCnnK88GtSAZ6dxucA=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by CH0PR18MB5529.namprd18.prod.outlook.com (2603:10b6:610:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 05:12:54 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::9728:b607:b464:a2dc]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::9728:b607:b464:a2dc%7]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 05:12:53 +0000
From: Srujana Challa <schalla@marvell.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>,
        "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        Vamsi Krishna Attunuru <vattunuru@marvell.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Nithin Kumar Dabilpuram
	<ndabilpuram@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>, eperezma
	<eperezma@redhat.com>
Subject: RE: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
Thread-Topic: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
Thread-Index: 
 AQHagDj2SsvzR050EUWY0iVJi2EC1bFOIr+AgABzqcCADaIjAIAFJBEQgAAU+ACAAAv1kIABLXgAgAGCvNA=
Date: Fri, 12 Apr 2024 05:12:53 +0000
Message-ID: 
 <DS0PR18MB53685690485AACEEFB8D766CA0042@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240327112136.2897479-1-schalla@marvell.com>
 <CACGkMEuKhKOtqYUk4Sbv1QmVSuo3AJ1-tX13ZZxdbPmSSNYk9Q@mail.gmail.com>
 <DS0PR18MB53686F5F53AF5D26B7CE37B6A03A2@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEuAEsApX0ZT=FWVgtvYwpAVhzQGh_1yrUaN5f8A8K7iCw@mail.gmail.com>
 <DS0PR18MB5368C214A318C026C6A64E45A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
 <20240410071350-mutt-send-email-mst@kernel.org>
 <DS0PR18MB5368C21CDDE827AA2A496510A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEvYXPPp9Jbkx4ucXL7WYBkCMggCJJHVZUg2JuNc7DMJPw@mail.gmail.com>
In-Reply-To: 
 <CACGkMEvYXPPp9Jbkx4ucXL7WYBkCMggCJJHVZUg2JuNc7DMJPw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|CH0PR18MB5529:EE_
x-ms-office365-filtering-correlation-id: 49ab9e13-9037-43a8-a182-08dc5aaf352e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 x0O1CrkmMR2GkMEMF8+XAcQs4zyH+vOtrAJYazlmLvXedTAII87UOoVRCqan7J8ucI8UySGBRhY66AUUIdB5nB5p4VTI/tny10/tgz+y51z81Tj5nq9DtiFSXqXR95IsfWI2LDZ9nJ0c8s72b83iukrNwSsmZvVilCsHiipZzbz+00JbZq5EKQeMRFLuOl7n98N7WXQGwPvqtALcZYUf3g5VyhM0Ohy6RT/SJfj+JzrYZgQw/2jCfAM5U56yc1TJwM3f67r87ky2A156CyK8ADgqoUzY8YFzii6Ru03AIc77Fn4V596Nrp3WgOk6voZ5pNWIdeWyqfUA/kPuZ5PKvtQm+lIzHwJn3Axb4xCuTna0UCGA2U4L5sV1ZjejXUwt9xnwZdqPrm7yFhQ5UIUxurGniWYFIerfHn+mHzWnf2lsI/QOFVztlrgSLKZ82sSswXXA4CWyb59PH2HxgcE7D64SEvKqpquXJAaBLtahWo7TPtHhFDAx4N82Ie4HgbT/AS6HnzhGepSchr39d7tNEeOjYk/ks46zp8CA3u6qKwmlnhf+AjxyyXnee/9QksYQpyqPuoc5DTlLV8PgfvY7zZvr34FLhh0YzzEy3vaXQ1/DXeyJ7r3TdnoYRb0yh7633Q028uB5+Buvp0940oC6MYLzqqomfkZu7TLDnkl0nqpXYBta+yUvNe390wZOMJ29nBuizpASmA9zRRuzIrjRhW7N+AMBmogfVVLlmPw6fXI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR18MB5368.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U0lIZS9JS0V0dzJpdHY1Ni9WZG1NWUozQnlLN3RvMGI4S2JHMUFrUk56T2lG?=
 =?utf-8?B?aUcraTN5dWlQa0tsZVdaMmJ3V0tTYUhJYnBzRlZzOWhnSkFxSWtUYnVpQ2sz?=
 =?utf-8?B?dDNtNExwdjV5RDcwZ3FTWFlYUU1zSzRiaXoxNkhCcmY4OFJ1QVQ3VS9vQlcv?=
 =?utf-8?B?eHcySGVldkNzcU9yRCtYMmtLNmk3STNqYzFzUFpJYmhhL0QrV0JQODB4Tkg1?=
 =?utf-8?B?VWcyQ1JsU2FhaDd5RzROS0VIWFg0a29GWWNLa0tlLy9wZjgxQVVDbCsxVmM4?=
 =?utf-8?B?TXR0NE1IYUR3cXE2dmQ1UE1HYU9qeTZsUG9aTVF2SnMrQVhxVU8wdW96VDNE?=
 =?utf-8?B?TWhlS1dBbWxsMzJCaEJsb0dTU21iOGNSclF5Mlp5eFl0dVExQ3laSU5JVWJP?=
 =?utf-8?B?SWtxQkxQOFB2MnlYNVpabm1RTEdyQVFZUjVHUXIwcjk2Njk3dzZvZ291KzNw?=
 =?utf-8?B?VVhqdXpndndMdnMyT05qNlM4WnhSdDVWcWhESG1vb0dIaFRJdDNPUkhvQ3pw?=
 =?utf-8?B?Q3NrdGZWSkRaLytSanlpQmEvZHcvc3EwM0ZWSHFMVGp6L1FZY0I0MVlLNFVF?=
 =?utf-8?B?MmxxTmNSbTM0eDloYWxHZWlmOEIxQ081NEV5VlVYcjdydDJ1RGJOUHB0MWJI?=
 =?utf-8?B?dUFYOVRtRHRMVnBIdHRTQlNTZDZqTkxIR0JPZVJneW0ybkxqWWQvdUZRYmFU?=
 =?utf-8?B?bEdCeUpteXN5L1ZQVTFJNldBVjBqOVlMRTQrMGtMTGNSR3VITGl6WjgxVksw?=
 =?utf-8?B?VFM1RThOWVVJWUIvdmo5M2tUNXcxK3JxVmY2eVZnVWxNVnQ0YTdxalBPaHZy?=
 =?utf-8?B?amlBZWR6eHJCbjlMREdxamI4NWM2SnlUTHplYTRGWUlscWFramlZcW5UcmJV?=
 =?utf-8?B?TlpIc2NiM3pQMERVZmNmSytybXUrM212OTRjWHhwbTJoR1FpNUFudUVUVFEw?=
 =?utf-8?B?dEtuZ1R5aGFJaitra1luMzBIc08zZmlIT3daYm51SzlJTjNubmN3VDBmUVgv?=
 =?utf-8?B?eG1YelI2cWZnWnd3czY4UHNRQ2tWUXI5VDJZYjZoYmRsSVY2b2twVXFPQzNs?=
 =?utf-8?B?Tmw1d0RrWU1WWEcyNU03dGI2N3pMdi9rMHZVOFFobTlJdGtNOW9PNlB1Z25J?=
 =?utf-8?B?RThmQ3k1TFZidTlmNi9BMkZmZjlIY0diY0VXQng2Q05jNTFEdjkxY0lsLzk2?=
 =?utf-8?B?YWF4QUljVmZWeXI4TjVZSmRkbDAvcmovZitGZmt4OXh4djU4S1FhbWhkQ0dC?=
 =?utf-8?B?RlZoalVybGZOblg4V3RHOEJZWk1DM0wrZ3FZdXBTSDBCSldyLzBRM0U1S1lk?=
 =?utf-8?B?WExOMnY5UTY0OWtiSU1BdDZsaFRHRWczSXVnU2o0cW9yTlh5ckNDSktGcUdl?=
 =?utf-8?B?a05FZWs1SW45YVpmK2VkWGJmRHdscGRCa01zMEc2V29SaUpuTkc1eTczZ3BV?=
 =?utf-8?B?Y2l2d3A2TFlsbGVCa09YV2xQUDA5OC9IemxGdi9WNG9XcEVmYkJ5dStSalp1?=
 =?utf-8?B?L0o1dkhZekhUdTVWNXFPTUhTK0Jua3ZXNklmZzhBa2hiY0ZZY3ZISVVWcVVa?=
 =?utf-8?B?Zlg4MGlOR0s4RHBhRm9hTXJCdXp4eGQvUVhTY1VKQ20wcXBSUVpUN0hUYi9U?=
 =?utf-8?B?R0VZOVJNeXE4bGlMVXdJNFBxTW5YZk96WlFlRkVmSkc3bkdvUFNlN2JHbk1W?=
 =?utf-8?B?Q2tZcFhnS2hSVDYrSjZGMjErZDBQUVE2dzA2blVWU2YzZ1FTNno0VGJxclBD?=
 =?utf-8?B?TjVoQ29LS08zMUlETi9CQ1NNT1BlNitTUm1YTjk1aHg5dmJjbC95clIxSmVq?=
 =?utf-8?B?TGFWdytiRWVhbk44eDVRalZjakp3b1VUdXVPN1RSSk1CN1Q2NlYrc3VPc1E3?=
 =?utf-8?B?OGJyelpqa2tabDY1OCsvKzZqcWN1emZMYnlUbTI5TExRLzN1NGZhZWJzRUFZ?=
 =?utf-8?B?YTJQcUZTdm11dWtQR2Y5TEhCOWdRQ2xkYUg2SzZtendOQ3oxVlRqbERZend3?=
 =?utf-8?B?UmlDNDltanVwK0tJOHRtMVBlcEZQQkJETldiT1BlRXlYSVBGa2JsY1NIekE2?=
 =?utf-8?B?Y1h6WFZvcnh1am5WNHhzbk41U2FrREd5VEF4c0RaT21Iazdtc08yZ2xEdDVR?=
 =?utf-8?Q?nKkIzkvoDioxroSf0dSBcjplh?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ab9e13-9037-43a8-a182-08dc5aaf352e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 05:12:53.7574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: auEIkaKYTbuegldi6emRopkviEgYudD0SPecRHDHAfXCIZIo0mHX1/I/3CEai7JLJYVpm8jkWQEpLhmayf1VyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB5529
X-Proofpoint-GUID: Qbq6Rwj8I6osVV0qRwbBzb49ARQ4HjnI
X-Proofpoint-ORIG-GUID: Qbq6Rwj8I6osVV0qRwbBzb49ARQ4HjnI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_01,2024-04-09_01,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDExLCAyMDI0IDExOjMy
IEFNDQo+IFRvOiBTcnVqYW5hIENoYWxsYSA8c2NoYWxsYUBtYXJ2ZWxsLmNvbT4NCj4gQ2M6IE1p
Y2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+OyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC5kZXY7DQo+IHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tOyBWYW1zaSBLcmlzaG5hIEF0
dHVudXJ1DQo+IDx2YXR0dW51cnVAbWFydmVsbC5jb20+OyBTaGlqaXRoIFRob3R0b24gPHN0aG90
dG9uQG1hcnZlbGwuY29tPjsgTml0aGluDQo+IEt1bWFyIERhYmlscHVyYW0gPG5kYWJpbHB1cmFt
QG1hcnZlbGwuY29tPjsgSmVyaW4gSmFjb2INCj4gPGplcmluakBtYXJ2ZWxsLmNvbT47IGVwZXJl
em1hIDxlcGVyZXptYUByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBSZTogW0VYVEVSTkFMXSBSZTog
W1BBVENIXSB2aXJ0aW86IHZkcGE6IHZEUEEgZHJpdmVyIGZvciBNYXJ2ZWxsDQo+IE9DVEVPTiBE
UFUgZGV2aWNlcw0KPiANCj4gT24gV2VkLCBBcHIgMTAsIDIwMjQgYXQgODozNeKAr1BNIFNydWph
bmEgQ2hhbGxhIDxzY2hhbGxhQG1hcnZlbGwuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+ID4gU3Vi
amVjdDogUmU6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSF0gdmlydGlvOiB2ZHBhOiB2RFBBIGRyaXZl
ciBmb3INCj4gPiA+IE1hcnZlbGwgT0NURU9OIERQVSBkZXZpY2VzDQo+ID4gPg0KPiA+ID4gT24g
V2VkLCBBcHIgMTAsIDIwMjQgYXQgMTA6MTU6MzdBTSArMDAwMCwgU3J1amFuYSBDaGFsbGEgd3Jv
dGU6DQo+ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgZG9tYWluID0g
aW9tbXVfZ2V0X2RvbWFpbl9mb3JfZGV2KGRldik7DQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICBp
ZiAoIWRvbWFpbiB8fCBkb21haW4tPnR5cGUgPT0gSU9NTVVfRE9NQUlOX0lERU5USVRZKQ0KPiB7
DQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIGRldl9pbmZvKGRldiwgIk5PLUlPTU1V
XG4iKTsNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgb2N0ZXBfdmRwYV9vcHMuc2V0
X21hcCA9DQo+ID4gPiA+ID4gPiA+ID4gKyBvY3RlcF92ZHBhX3NldF9tYXA7DQo+ID4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+IElzIHRoaXMgYSBzaG9ydGN1dCB0byBoYXZlIGdldCBiZXR0ZXIg
cGVyZm9ybWFuY2U/IERNQSBBUEkNCj4gPiA+ID4gPiA+ID4gc2hvdWxkIGhhdmUgdGhvc2UgZ3Jl
YWNlZnVsbHkgSSB0aGluay4NCj4gPiA+ID4gPiA+IFdoZW4gSU9NTVUgaXMgZGlzYWJsZWQgb24g
aG9zdCBhbmQgc2V0X21hcC9kbWFfbWFwIGlzIG5vdCBzZXQsDQo+ID4gPiA+ID4gPiB2aG9zdC12
ZHBhIGlzIHJlcG9ydGluZyBhbiBlcnJvciAiRmFpbGVkIHRvIGFsbG9jYXRlIGRvbWFpbiwNCj4g
PiA+ID4gPiA+IGRldmljZSBpcyBub3QNCj4gPiA+ID4gPiBJT01NVSBjYWNoZSBjb2hlcmVudCBj
YXBhYmxlXG4iLg0KPiA+ID4gPiA+ID4gSGVuY2Ugd2UgYXJlIGRvaW5nIHRoaXMgd2F5IHRvIGdl
dCBiZXR0ZXIgcGVyZm9ybWFuY2UuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGUgcHJvYmxlbSBp
cywgYXNzdW1pbmcgdGhlIGRldmljZSBkb2VzIG5vdCBoYXZlIGFueSBpbnRlcm5hbA0KPiBJT01N
VS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IDEpIElmIHdlIGFsbG93IGl0IHJ1bm5pbmcgd2l0aG91
dCBJT01NVSwgaXQgb3BlbnMgYSB3aW5kb3cgZm9yDQo+ID4gPiA+ID4gZ3Vlc3QgdG8gYXR0YWNr
IHRoZSBob3N0Lg0KPiA+ID4gPiA+IDIpIElmIHlvdSBzZWUgcGVyZm9yYW1uY2UgaXNzdWUgd2l0
aCBJT01NVV9ET01BSU5fSURFTlRJVFksDQo+ID4gPiA+ID4gbGV0J3MgcmVwb3J0IGl0IHRvIERN
QS9JT01NVSBtYWludGluZXIgdG8gZml4IHRoYXQNCj4gPiA+ID4gSXQgd2lsbCBiZSBoZWxwZnVs
IGZvciBob3N0IG5ldHdvcmtpbmcgY2FzZSB3aGVuIGlvbW11IGlzIGRpc2FibGVkLg0KPiA+ID4g
PiBDYW4gd2UgdGFrZSB0aGUgdmZpbyBwY2kgZHJpdmVyIGFwcHJvYWNoIGFzIGEgcmVmZXJlbmNl
IHdoZXJlIHVzZXINCj4gPiA+ID4gZXhwbGljaXRseSBzZXQgImVuYWJsZV91bnNhZmVfbm9pb21t
dV9tb2RlIiB1c2luZyBtb2R1bGUgcGFyYW0/DQo+ID4gPg0KPiA+ID4gdmZpbyBpcyBhIHVzZXJz
cGFjZSBkcml2ZXIgc28gaXQncyB1c2Vyc3BhY2UncyByZXNwb25zaWJpbGl0eS4NCj4gPiA+IHdo
YXQgZXhhY3RseSBlbnN1cmVzIGNvcnJlY3RuZXNzIGhlcmU/IGRvZXMgdGhlIGRldmljZSBoYXZl
IGFuDQo+ID4gPiBvbi1jaGlwIGlvbW11Pw0KPiA+ID4NCj4gPiBPdXIgZGV2aWNlIGZlYXR1cmVz
IGFuIG9uLWNoaXAgSU9NTVUsIGFsdGhvdWdoIGl0IGlzIG5vdCB1dGlsaXplZCBmb3INCj4gPiBo
b3N0LXNpZGUgdGFyZ2V0ZWQgRE1BIG9wZXJhdGlvbnMuIFdlIGluY2x1ZGVkIG5vLWlvbW11IG1v
ZGUgaW4gb3VyDQo+ID4gZHJpdmVyIHRvIGVuc3VyZSB0aGF0IGhvc3QgYXBwbGljYXRpb25zLCBz
dWNoIGFzIERQREsgVmlydGlvIHVzZXIgUE1ELA0KPiA+IGNvbnRpbnVlIHRvIGZ1bmN0aW9uIGV2
ZW4gd2hlbiBvcGVyYXRpbmcgaW4gYSBuby1JT01NVSBtb2RlLg0KPiANCj4gSSBtYXkgbWlzcyBz
b21ldGhpbmcgYnV0IHNldF9tYXAoKSBpcyBlbXB0eSBpbiB0aGlzIGRyaXZlci4gSG93IGNvdWxk
IHN1Y2gNCj4gaXNvbGF0aW9uIGJlIGRvbmU/DQoNCkluIG5vLWlvbW11IGNhc2UsIHRoZXJlIHdv
dWxkIGJlIG5vIGRvbWFpbiByaWdodCwgYW5kIHRoZSB1c2VyIG9mIHZob3N0LXZkcGEoRFBESyB2
aXJ0aW8gdXNlciBwbWQpLA0Kd291bGQgY3JlYXRlIHRoZSBtYXBwaW5nIGFuZCBwYXNzIHRoZSBQ
QSAoPSBJT1ZBKSB0byB0aGUgZGV2aWNlIGRpcmVjdGx5LiBTbyB0aGF0LCBkZXZpY2UgY2FuIGRp
cmVjdGx5DQpETUEgdG8gdGhlIFBBLg0KDQo+IA0KPiA+IFdlIG9ic2VydmVkIHBlcmZvcm1hbmNl
IGltcGFjdHMgb24NCj4gPiBjZXJ0YWluIGxvdy1lbmQgeDg2IG1hY2hpbmVzIHdoZW4gSU9NTVUg
bW9kZSB3YXMgZW5hYmxlZC4NCj4gPiBJIHRoaW5rLCBjb3JyZWN0bmVzcyBpcyBIb3N0IHVzZXJz
cGFjZSBhcHBsaWNhdGlvbidzIHJlc3BvbnNpYmlsaXR5LA0KPiA+IGluIHRoaXMgY2FzZSB3aGVu
IHZob3N0LXZkcGEgaXMgdXNlZCB3aXRoIEhvc3QgYXBwbGljYXRpb24gc3VjaCBhcyBEUERLDQo+
IFZpcnRpbyB1c2VyIFBNRC4NCj4gDQo+IFRoYW5rcw0KPiANCj4gPg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gVGhhbmtzDQo+ID4gPiA+DQo+ID4gPiA+IFRoYW5rcy4NCj4gPiA+ID4NCj4gPg0KDQo=
