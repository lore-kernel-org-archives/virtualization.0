Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110B43BB661;
	Thu, 17 Sep 2026 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641646; cv=fail; b=kCzOm/H1Gc6lr4xjzmTmaXK1hkxlJgRGnmHLNsOvomdr/K6mjjqmWie4VD3Hrr43ei8gxNeVwMRvkYyPGgGu6yK9pgXD08pR6wLM0mjrKFMQAg0zUkrNaWzKAZ9u6qU1DY9mxxNMCRq/T8BRrbJhP9ctNTSGHuz1ODiGrJGUpp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641646; c=relaxed/simple;
	bh=Y560cLXIb+xZjpDFLM0BKraVd89shcuCEx/1/nHGumg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EFXnudCQ0YzKTgjp5MYmopJaOxh9VryNzeT3ePSJ10wmTUVEY3YFPxNnNSn9477CIASL/RMJ2An6wxdkJPa8W9p78PBemR1I3/tMN30aMbFwvFpKMInNYjTGPnWT/U3PClLO5BOD3xsz4mnWC6UjapHpghrz6gdWAG2qmn34WAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mg40Vaoq; arc=fail smtp.client-ip=40.107.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mg40Vaoq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1gXc+srhgACfvDp86Zots+XPeZnKlsPONr7jFK0yoc5m9q3I3nHxQpK6LwZpAeJg9O/wWrfXjR0MyumtrRj2+yp+m87AMZxAVIYCE832AjIj+6YdV8e2IOuD4U1D/cKkNFLphcYfAhlfH9PeK3doV6YlrndlgO2Ehm+geJKsNNLubINJR+00cmnTM9lDgnAKkCHzcbQ5r+463hL2D2q6abvJTF1sKCS6rpdP6N+SIhcHbcV00E2/o84uuvvHPChJGibF6v+UULSq6RMcRDr8Wfq8RoPIQG+85osOivUyJm68LT9Tzq1pJlkvkAVgNUOSpXcr5v0vk7KUUzSlKxP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y560cLXIb+xZjpDFLM0BKraVd89shcuCEx/1/nHGumg=;
 b=CwWsMjIaCAyEwvkDqIgsYvXBGmb0NSAWIKosNM6BjhZCgNRKUUpep8Q3EsUWwvQjgJWU4edkqdqNvWYheCCypTiiascx9pSSSRXD6td8iTJG9DHkMkPlhc59SN/ZxRH0dCpi0+OMB5d5VWxPupRM+j4kht+Nn+W2TRliXEopejIWemuWnrlqa4BXhjPoJW61xAd75oovGsDe2itzfIq/ibf/14px98xwuwrMbRWZCmHkZWeS7Uuz7M+5E5o2qqF2vLFHolrzivB65QZ8DDoLRsQYjI5FXjj4mmjgB3WxHba7BKOJJr1EC/tZqF+S9GgVaA+C56b3FVrOrCXYGuoAhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y560cLXIb+xZjpDFLM0BKraVd89shcuCEx/1/nHGumg=;
 b=mg40VaoqjSSmx5+IvsCmYLjcnYfXUPs0ukSxC2h/x3IZy0C+d5lCF/LD/RqCASFpcMpTcVQJ/Z+OJskGhvNgg9USJHtl92LDOzOLfIKoeAEnzBi8DpAKPVeHODMEOrBGGb2s4QGSutmyGaWbjSTUih/RCo7opacIcvbdGkE1kMg=
Received: from PH8PR12MB7183.namprd12.prod.outlook.com (2603:10b6:510:228::20)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 10:40:29 +0000
Received: from PH8PR12MB7183.namprd12.prod.outlook.com
 ([fe80::d54c:d13c:6346:4009]) by PH8PR12MB7183.namprd12.prod.outlook.com
 ([fe80::d54c:d13c:6346:4009%5]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 10:40:29 +0000
From: "Huang, Honglei1" <Honglei1.Huang@amd.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, Eugenio Perez <eperezma@redhat.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH v6 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM
 capability
Thread-Topic: [PATCH v6 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM
 capability
Thread-Index: AQHdRo7hr9nhfSJPs0e/jl04/6cYcLbSktmAgAABphA=
Date: Thu, 17 Sep 2026 10:40:29 +0000
Message-ID:
 <PH8PR12MB71838D22AB70026D0396E9B6D9B82@PH8PR12MB7183.namprd12.prod.outlook.com>
References: <20260917102540.1312102-1-honghuan@amd.com>
 <20260917102540.1312102-2-honghuan@amd.com>
 <20260917103331.A8A7D1F000FF@smtp.kernel.org>
In-Reply-To: <20260917103331.A8A7D1F000FF@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-17T10:39:24.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7183:EE_|MW4PR12MB6949:EE_
x-ms-office365-filtering-correlation-id: 3bda21f3-1f12-4bbf-5040-08df14a817a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|3023799007|18002099003|4143699003|56012099006|11063799006|22082099003|10067099003;
x-microsoft-antispam-message-info:
 fw3kN+IGgEXiS8xwbHfzP4syo/8xfw4PNzPFBDAC3QhqTA7FVbvyUfW+3jCK5meJrf+RBLCqSULgr/I9phG/EgrlxYtAhkOhAd1uawArsMR2HzyxjMYK9DiYd+WfkqxFgQe/NrGRBQE6UYVSt07qllLXNXxoh3a19O4dYJF9z4VlFeFSAtSZfpJ2Rjp/iTexxwUhSmKMCLKuNlE4kHpHAd7i2ohVFTWnv3iNpks0vfl7soLjbWtgaVsuapou4Y9jh/DZfwVxZACrMEB2lMx5jcCZcdwqZa+dwsCDCnUsSbRJU4TfNqL7Qtc778G+xRi8dNpqkvbvDzYv6G+pyEOQQ23eLLvaOoGYGmijFYJLeXTNRA5K5KQN5JQj6dklfNgqK/xn1IMoceh7QPYfYK0tfzSDqg5hLZ8tTyzRdKAnGSHn78XqfoVDB6adJ499CCA6dzq1lE4F2Gw6tiu1pTxLmUm6FQwUxsJ5dv6kqTnzUMxulUhQr1uu6Qs4lsB4i23k+v98NMF3uMFZTY5wS+0SfwZIdVGQ2BS8gO/zSb5Lp3jXdVIztf/dRbr9VaKyu5YDL9cfTdWwDOiJ/z4VvGtJ0H2jiC6TyDdTn9d/nF4mZ7NtsFMNGfaLHeWFfAUNxd6mep3NRmJYFKMbIvSKZYYcOirdEdMm4G3MqG+IE8hBy5Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7183.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(3023799007)(18002099003)(4143699003)(56012099006)(11063799006)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2kzTGNmVW5lTFpxRnRQZVVCbVRPNFlkWE4rSEZMZ0JRTkVnSzl4REVhbE92?=
 =?utf-8?B?bmlsY2lmenlIRTkwUmJsem12UzNITG50Q3dYVVRuTmdGSlhTd1RKZi9uTW9w?=
 =?utf-8?B?UjdFSldSRmM4YnhHOXpUYWVMMDVyb3NvVE9GbytzRmZrenVrazBPMmIwNTRJ?=
 =?utf-8?B?REpXREdkb1pRclQxbWFueVdNR2pKbUtWTVpnb3JRR0NpNmxuMU5UVHZ1VlFa?=
 =?utf-8?B?aXdNbGxGblF4M2l5U245cGFMcFlqc1pzRS9WNmlsRk50MU81eTIvNnBrSDlt?=
 =?utf-8?B?THlFSW1mM0g4dWZ6dkVIY2JsSCtXZGdVNklHNFFHYnZXTEdxclEzWXR3bjA5?=
 =?utf-8?B?T29vUHZaeTRpTlRLU2p6eDFENVgvZURPYTg5d0pCRndMR0Nab29BV043NGZz?=
 =?utf-8?B?TXh4THc1TWt6Y2ttOFNlYWdKZnFxTnVqZ21KWHFzUTZ0THNqOUJsejJhZDBO?=
 =?utf-8?B?aXNwb25OUEx6NERmSzZkVE11d2FaSU1iRFo5K1R0aVVZN3hJcHZOcHRpTHdm?=
 =?utf-8?B?M2lTZjAzQ1RvZnFlN0F4dGtrMFpWb1paSm5NeHBsNG9NOUhNWDBhT2ppSWdO?=
 =?utf-8?B?YXc0azROYnhzemhtR1JnWXJyTm9seitJTWdReTBjQ1Y0cEMwWEVObDVhbHZQ?=
 =?utf-8?B?ckxsanZTazlETlllWFBDNk1LT3E0VGdsWitFRWVtSU1Rd3NxUXR3L2Urd3dP?=
 =?utf-8?B?eHRpOTdUTXVHdEJINlJRMGxiZ2ZGaVhmY1A3Ky9hNlZuT3IxMUwxZS9EVGNH?=
 =?utf-8?B?eEt6d0R1M3B6dmIzcUdDK3ZyTXFTZUdYS2xiQUVWZi9QZFFmbGY5akRzODE3?=
 =?utf-8?B?ZWFvL0R5OHJ1UTBQUVdFZEtPc3FjSjc2M0tlYjNiWWg3aitBdldIZWw1SEZh?=
 =?utf-8?B?aExTcVhuZE5uekhOaHJBL25VV3pIYXBnTVZBN1pYUGFNdHJSdExadVlwMUhD?=
 =?utf-8?B?TVR0bm11cG5DM2pzb1NaRW1MNWpadmhtRUhWZld4bVZqRnVaMHpveG5KUlp2?=
 =?utf-8?B?YjlQTm85ODVyRVBJNHFGRm55TDc5MTlHVVFYYmJlVkNZajlaUllVRWl4OVY5?=
 =?utf-8?B?dFRpdjdrYW9OeUtFYnFBb2NSUXZjTi84dDJGOThzVWdwekw1eG5VY0xKQzFJ?=
 =?utf-8?B?RlFEZkZOcVhBVktiT3FaaEptZ2h1NlRqT2FTMTF1dFBrVnAwdzhraGo3c0F3?=
 =?utf-8?B?YzV1YzVTVmFTMXM4NWNya3p1VndTZVNYQ3licmxKQkpiRTd0RTdCQXk2UXZ6?=
 =?utf-8?B?ckt5UFNaVjRYR2JmT1JldGxrdXlrSlV0R29hYzhpdlkvdll1bENvTlRIM0VM?=
 =?utf-8?B?SGlaRWkraFRZYlF0Yy9GN2tJNExGcjZYOWFqNHhOTDE1cjNyNGtjYndtVHFq?=
 =?utf-8?B?NnZ4dDFoRlBGMTZWNVVJNzVVZGp4YkpCL0krekhsQjJtOEE0cE1oOUM0bk1J?=
 =?utf-8?B?MmRBYlA0dDJNOWd0b2xnV3g0aXdUN2RaVFNTWDh3cy9YWEVvcmRpa2NNcFY0?=
 =?utf-8?B?cmNHczRoQ0JySHlxNUx0QW1uRlR5aVdlcVQrM0NUY2k3dTREUG5hcGQwUllQ?=
 =?utf-8?B?MTNFaTJHOFVrYVA5RHkzajRWR09FZnc5bGRTUGNya1BQeXZ0VWJnTGtUQmtZ?=
 =?utf-8?B?OTRLeFdwZytwTFlxL05ZSUx6bFpPUDNOb1BYTXBnNytUQ3hVK3NjVkd3UDFt?=
 =?utf-8?B?REF6Vkl1N1J2MnJlMG1QT2E5bEVmeFowYjNZMkVIMjEwWFR3aE9DRFhiUkwz?=
 =?utf-8?B?K3l5c3IxRVdFQ3NiYmNESm1EdHc0VW54Tk1XN05nN3BiNGhjN2h3TnNNdVFN?=
 =?utf-8?B?Y0tVaHozZ3prN28zSEUxRWlLSG9kcEpBUnA2WGhkZ2JXZ3lRWjEzZ0RXODNl?=
 =?utf-8?B?QjdZenlOcEtVU3ZMRXpZb0tuMDE0Sm9wNWg1c2dwUXkyaWsvY2hvMXpweFhG?=
 =?utf-8?B?Mkt2UDBraFZkTk5VR1A5bGp0amd3T0ZrZk0rSWVYT1ozSzU0MzRPU2xkb1JM?=
 =?utf-8?B?SEM2UVF1b0VkOS9hK2VyTmIveE9KV1V3WVdleUk2RDlEekpkNmNxM3JFZ2VS?=
 =?utf-8?B?SkNHeThOUnYwR3ZnQzBVenEyckJYOEZZRTVRcnJRSkppaXFaQXpPeHdpU09j?=
 =?utf-8?B?OWM4SDZRWFJESUY1Vjh1RW4xN3JDWFRKb0VHeVhDa3hEUVVmYjJLMlZOVVhp?=
 =?utf-8?B?dHprM0tpdG1qc3l0Ny95emlSMk5ReVRkNnhMSERjSlBScmhmbWJhR3E1NTV3?=
 =?utf-8?B?eVA5YTNHN2dJODVYTjdDQ3o2SnJtQ3ZXWDNFbVp1YTJWK2dNVEl6YTVXUnZJ?=
 =?utf-8?Q?tMQ5+kyc1gnADJd9Pd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7183.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bda21f3-1f12-4bbf-5040-08df14a817a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 10:40:29.3091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRjaOKjL12Z5NoxUKrn0BBn7IoIGYkJ8ZhvOKwRHinGbhZJ7mzHFMzduT/WQhzWQfEs7T5n5AatxIRPd+UlSQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949

QU1EIEdlbmVyYWwNCg0KQ2Fwc2V0IElEIDcgaXMgYWxyZWFkeSB1c2VkIGJ5IFZJUkNMIGluIHRo
ZSB2aXJnbC92aXJ0aW8tZ3B1IHN0YWNrDQpTbyBST0NtIHVzZSBJRCA4LCBhbmQgIHdlIGhhdmUg
Y3JlYXRlZCBhIHByIGluIHNwZWMgdG8gcmVzZXJ2ZSB0aGUgSUQ4DQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBzYXNoaWtvLWJvdEBrZXJuZWwub3JnIDxzYXNoaWtvLWJvdEBr
ZXJuZWwub3JnPg0KU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAxNywgMjAyNiA2OjM0IFBNDQpU
bzogSHVhbmcsIEhvbmdsZWkxIDxIb25nbGVpMS5IdWFuZ0BhbWQuY29tPg0KQ2M6IE1pY2hhZWwg
Uy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+OyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC5k
ZXY7IEV1Z2VuaW8gUGVyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+OyBkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHY2IDEvNF0gZHJtL3ZpcnRpby1n
cHU6IEFkZCBWSVJUSU9fR1BVX0NBUFNFVF9ST0NNIGNhcGFiaWxpdHkNCg0KVGhhbmsgeW91IGZv
ciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91bmQgMSBwb3RlbnRpYWwg
aXNzdWUocykgdG8gY29uc2lkZXI6DQotIFtNZWRpdW1dIHVhcGk6IFZJUlRJT19HUFVfQ0FQU0VU
X1JPQ00gZGVmaW5lcyB1bnN0YW5kYXJkaXplZCBjYXBzZXQgSUQgOA0KLS0NCg0KY29tbWl0IGRk
YmYwMmQ4YTE1NTdhNDk3NjM3MWRiNGE5NGJlODhiYzFmNzA1MmYNCkF1dGhvcjogSG9uZ2xlaSBI
dWFuZyA8aG9uZ2h1YW5AYW1kLmNvbT4NCg0KZHJtL3ZpcnRpby1ncHU6IEFkZCBWSVJUSU9fR1BV
X0NBUFNFVF9ST0NNIGNhcGFiaWxpdHkNCg0KVGhpcyBjb21taXQgYWRkcyBhIG5ldyBHUFUgY2Fw
YWJpbGl0eSBzZXQgVklSVElPX0dQVV9DQVBTRVRfUk9DTSB0byB0aGUgdmlydGlvIGdwdSBVQVBJ
IGhlYWRlciB0byBzdXBwb3J0IFJPQ20gY29tcHV0ZSB3b3JrbG9hZHMgaW4gdmlydHVhbGl6ZWQg
ZW52aXJvbm1lbnRzLg0KDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlv
X2dwdS5oDQo+IGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19ncHUuaCBpbmRleCA0ZjUzMGQ5
MDA1OGM3Li4zZDRkZmFkYzlkNzg5DQo+IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGlu
dXgvdmlydGlvX2dwdS5oDQo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fZ3B1LmgN
Cj4gQEAgLTMyMSw2ICszMjEsNyBAQCBzdHJ1Y3QgdmlydGlvX2dwdV9jbWRfc3VibWl0IHsgICNk
ZWZpbmUNCj4gVklSVElPX0dQVV9DQVBTRVRfVkVOVVMgNCAgI2RlZmluZSBWSVJUSU9fR1BVX0NB
UFNFVF9DUk9TU19ET01BSU4gNQ0KPiAjZGVmaW5lIFZJUlRJT19HUFVfQ0FQU0VUX0RSTSA2DQo+
ICsjZGVmaW5lIFZJUlRJT19HUFVfQ0FQU0VUX1JPQ00gOA0KDQpbU2V2ZXJpdHk6IE1lZGl1bV0N
CkRvZXMgYWxsb2NhdGluZyB0aGlzIElEIHdpdGhvdXQgc3BlY2lmaWNhdGlvbiBzdGFuZGFyZGl6
YXRpb24gcmlzayBwZXJtYW5lbnQgQUJJIGNvbGxpc2lvbnM/DQoNCklmIHRoZSB2aXJ0aW8gc3Rh
bmRhcmQgbGF0ZXIgYXNzaWducyBJRCA4IHRvIGFub3RoZXIgY2FwYWJpbGl0eSwgdGhpcyBVQVBJ
IGFkZGl0aW9uIGNvdWxkIGNhdXNlIGEgY29uZmxpY3QuIEZ1cnRoZXJtb3JlLCBza2lwcGluZyBJ
RCA3IGxlYXZlcyBhbiB1bmRvY3VtZW50ZWQgZ2FwIHRoYXQgbWlnaHQgY29uZmxpY3Qgd2l0aCB2
aXJ0aW8gc3RhbmRhcmRpemF0aW9uIHByb3RvY29scy4NCkhhcyBJRCA4IGJlZW4gYWxsb2NhdGVk
IGluIHRoZSB1cHN0cmVhbSB2aXJ0aW8gc3BlY2lmaWNhdGlvbj8NCg0KPg0KPiAgLyogVklSVElP
X0dQVV9DTURfR0VUX0NBUFNFVF9JTkZPICovDQo+ICBzdHJ1Y3QgdmlydGlvX2dwdV9nZXRfY2Fw
c2V0X2luZm8gew0KDQotLQ0KU2FzaGlrbyBBSSByZXZpZXcgwrcgaHR0cHM6Ly9zYXNoaWtvLmRl
di8jL3BhdGNoc2V0LzIwMjYwOTE3MTAyNTQwLjEzMTIxMDItMS1ob25naHVhbkBhbWQuY29tP3Bh
cnQ9MQ0K
