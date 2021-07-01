Return-Path: <SRS0=M3O5=LZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24710C11F64
	for <virtualization@archiver.kernel.org>; Thu,  1 Jul 2021 07:00:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6F861490
	for <virtualization@archiver.kernel.org>; Thu,  1 Jul 2021 07:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6F861490
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7ED6741CFF;
	Thu,  1 Jul 2021 07:00:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 05SX21HkHYZY; Thu,  1 Jul 2021 07:00:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0404C4039F;
	Thu,  1 Jul 2021 07:00:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7968C0010;
	Thu,  1 Jul 2021 07:00:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93F84C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 07:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6CE7040F35
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 07:00:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YGtjWvbbbS1m
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 07:00:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::610])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E23094039F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 07:00:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6LftxlHeGCT1HGRFlWJbEuX1WRHfHEsDjD5cPUwuexgNURhPzY+AbPh8j5R7Fsf8QoEDuNWBkNCLWuzvZbNSKetORoqFE3Vy+4itbteKZjwYZXnMGSim++ke/gVAR+qZ9T93+rCWr/xpo0UD0c6zCJbsQPFAHitXxKa4508agpisyYV7EGqasc43t38MW9WXU9cjEMF+2PEO2lZe01+kZpKGmiHlHMK+gf6ceGp3d994lA2N9nc8VUiG44Ekc4dG3DfiSnPBdQhG5SUEmCjYgCVF91ioqVuoPFYscJfUNC1oBTQjJRwGOqQsB8sK7hQWEiustnpDJgxBwdshC0ctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=267HYyBpyj4pZ/RdQafGpMEsA+cNFs98mmFPeYiqwxI=;
 b=IiqmlH7FCd0lgdreS3bBS2dBbb67HRMJZhm2Tdk9sDkfumhDnonpUPobRU7qSbfyqSYO1cg37Xgxsa2nVEU2LVt3lxoxUkQrC+kw+FFxIq2ZIAU4xQ+GuiNrIAkH036wTG5Ee0zRpHWryrxB3bx0ahSisghrUx96CnAGiE3lRV6pi7UzJjJk+Q/KvOCNezFMKlwxXpi+QD/wXxgPH3RKS9vGs6UCHz5tbnGgEyTz3A5KBvgVKXlGEArryNWfw0Q41Wu0QTeiBxy3LILP89GQGLRlNasXby8Cih1GpUfdLbROu2m+VvK9ObVxfDhCTjcNs71w0B3sJ0CjK34Wkj5nmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=267HYyBpyj4pZ/RdQafGpMEsA+cNFs98mmFPeYiqwxI=;
 b=eQHbe12FYf1CmRJOp39ddaYhD1sICTYx4a0UEbbEdLur/oY+G1xR5pv5pCyNYJcm6fYNYxxXMOQYlu/C2n+4gs9RrfE13GRMapI6yMsFDUGOSWEK2VD9hcKFkaDpcWSZTMPKChligRNn+uSZCD/1cyDTEP5oiXGi9CZ1yEr7mjJHzE4KDIOoYR+B7pOBxD6Nmjh8ChUj5MRujaIgmNciZJOoVFkH0D/oBLbBcNI5zwGHRasFW8QGVRn9qEnlBIiysRzzJnvam5zUxVradMkSxcsqujdMctB/f82PEqKXP4enGnCjBDU1Cy/c0iySqHOkvnAvxXOZuliIRBrITCbQxA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5434.namprd12.prod.outlook.com (2603:10b6:510:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 1 Jul
 2021 07:00:09 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293%3]) with mapi id 15.20.4287.023; Thu, 1 Jul 2021
 07:00:09 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Topic: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Index: AQHXYuOJanS3dn7OPkyC8IVj+8AUaqsfqEMAgABt2KCAAO8RAIAAAJPAgAGsGACAAAPf8IAAEweAgAAIirCAAU1RAIAAMiFQgASfUwCAAF8F0IABH3+AgABhb2CAATvVgIAAFmuQgAFr2YCAADSRMA==
Date: Thu, 1 Jul 2021 07:00:09 +0000
Message-ID: <PH0PR12MB5481AC0B0D9D0AC3A62A5EB1DC009@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <0434617e-f960-eb1a-a682-49b6a754413f@redhat.com>
 <PH0PR12MB548147BE1B95CB294785470CDC089@PH0PR12MB5481.namprd12.prod.outlook.com>
 <d361bd10-3967-8844-1457-48e7e9422fb2@redhat.com>
 <PH0PR12MB54812DD2DADAD0897E24CFA7DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4e0708fb-34e3-471d-ca98-44c75f693b32@redhat.com>
 <PH0PR12MB54811C39B86AC8D6BECA9E05DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7a0a8bdf-4cd2-2fc2-73a5-53fb2ab432b6@redhat.com>
 <PH0PR12MB54819F782D5D7E6F9DCDF5FEDC069@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5350f5c0-c707-c3ec-8ed8-16c884467ffa@redhat.com>
 <PH0PR12MB5481030671D848D951477571DC039@PH0PR12MB5481.namprd12.prod.outlook.com>
 <bf6ec662-b53d-174f-53e2-735589f83d3d@redhat.com>
 <PH0PR12MB548115ACBDA9D76526C370B3DC029@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8c78b8ed-e16c-31dd-7c1c-abd2bef6bb12@redhat.com>
 <PH0PR12MB5481737F058FDE9B947C1ECFDC019@PH0PR12MB5481.namprd12.prod.outlook.com>
 <a23cdc3a-80cb-f5aa-e77c-4b897c8456af@redhat.com>
In-Reply-To: <a23cdc3a-80cb-f5aa-e77c-4b897c8456af@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [223.184.81.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f5768c4-5263-47e6-f760-08d93c5ddd88
x-ms-traffictypediagnostic: PH0PR12MB5434:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5434CB09853B1CDA3C9FDFAFDC009@PH0PR12MB5434.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KqIuqcNcqNEIbp2ngSTZpOfw7SDUyP5Vn5U83KEDPiD0JcIjjJr5wncZWh100l1/k/Yo6EgDkDXodyHgpEZBdN5/cF53IHOy4JFxitt5txCI7gKB1gasK0eyHGKPkypW3hUMTHtf9D1hGMnVhI1YJXCyhOkkEsB7pb5vJOywUZ7UzLUfxILSX2Dg4sooxPhcz4FDFxiTrJjEjrV9tTfOO0tQoLrZI7EULCysBEasszMUd34XTuC5Pvvw/VbstfJRfy4tJ+s7ysm6B5EE4AaqkDhCRptWNHwh7PT6wBcNN6x8Ju6Ps+NMpMkMjCyMfhtlvcKRNTyYGu2kEFhOpudUhOPufMeEDioGeS/tLZAR42DY2YI/3CLPMu4/DLBUGYVcW7vn6+wrUvdnIUl3dNmIEQV4agpzPSJyJ4mcFgoN7HdrqidS9IoExgxfHFNhNuc68KlhIUqqIGEJVqn/Ak+e9QpFVJv/KN9Qq6h9HojFvJLnHOB3Li7/GE1XsUnYy6PRgo6eZ/ddG+6KuG8hEMs1IlTxTxiyAx4QgA6+IUKrSeLxaaHq977XDmck31FmWMDimW7IWgZQO5OT1difTc5gb32TK5VC7nguhpf4MX0QaNjxeGObNMJo438oELhtKNbcey4F1UZOARSF3QFop8f+tqulWdgzrQMfxRzoC76TTT0C4dsCbXOXlVtlAKWo3dqwnYjvIn2aDBEKemR75Xd44g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(71200400001)(107886003)(52536014)(316002)(2906002)(38100700002)(8676002)(8936002)(5660300002)(54906003)(122000001)(110136005)(4326008)(478600001)(66556008)(9686003)(6506007)(64756008)(86362001)(33656002)(83380400001)(26005)(76116006)(55016002)(7696005)(66446008)(66946007)(186003)(66476007)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2N1TEJobkp6VGQxYUQ5ME1qNHhhd3FzR09YTzZsQi9PR200eEhCSDdaOHdh?=
 =?utf-8?B?Yy9UL0ZrTktkM0NBUm9UdEIxa3FMZkcwUkkyVXR0bWpVUjVmRSthM1c4K21X?=
 =?utf-8?B?NHdPZEw1WTZxcUpubjBnbjJNdmFSK2lBSTJLc28zRDFreVMvaFR4RkJYV2FM?=
 =?utf-8?B?ejFSNVV1cTNXQjJ1UGpHY1d2U3dOY2w5TG4xbmc1ckdXSnAyZXhQOGNVbmV0?=
 =?utf-8?B?bkltTkNBejBVbTdDNTVFSUFrTkpFOGFJSDRZdnJEN0QxS2RCYWYyekd3Mm1Q?=
 =?utf-8?B?ZWJSN2g1UjA4cGZSZmNBTFp4aFVhbzJRSXczRTVlMHpVMmtpaVFwMmpPWm5o?=
 =?utf-8?B?bXFmcWNlZ0RIc2RQWWEwZHcxT3dmOXExcGJUOUk4c2NpKzFlNFo0YkFxOVdB?=
 =?utf-8?B?ZFl3V0Q1UFZKcHBWSVpWSkZYcjBsUjhUYUw1WCtqTEZHMzd6OVZmdlN3eGpa?=
 =?utf-8?B?d01WemxRTktqc2svMGhFdndZam5oQk83bFk3RzZUV2V0Yi8wRkF1cy94TDhW?=
 =?utf-8?B?WjVxQ01HaEUzK0lPVGl0K2FlcVEyejhOOUUzZ1N3N3M3NHViZklRZVpmZHpC?=
 =?utf-8?B?L0Q1aitiWnFrWjhMSFFMNGkrZmNqMHM2M1BlRjNvaVVlK1gvQUxsRWNxMUNx?=
 =?utf-8?B?cyt3VzZqUWdQcTFsUVBGRFd1cy9XaytxOWNjcURZU0dNeXp6WmFSMUJUMDBp?=
 =?utf-8?B?QnAvTkJnVks3aUppYUpObHBQdmFYRUhmZTdOc1JvTzVDcGJNaXBNSHA1OWtu?=
 =?utf-8?B?ckI2S09tZGkvb1M4TmxMNFpselhzNEFTNmF3Z0JDbUtFUmo2QnZRSG1XeWR3?=
 =?utf-8?B?SE1JQWJhaDRrdUhWQ3FrR28wdmIyVk1MVHBoOXhQc0VlUVduU2lyTFF3bVpj?=
 =?utf-8?B?YmlpdGdUbVZVU3dpTlRIMXZldWpoMStaeFZHNW11U3M2bHV5WW5NUFdzakRK?=
 =?utf-8?B?T0RIVXJHb0ZDVDRpaTdnUEgvbHdOTzhiVXFNa0YwLzIrRUdJbG5ySmQ5ZHcv?=
 =?utf-8?B?Q0FSMUZ1MjZPMnpsU3lwYlU1UXhISk8yUlZTVVQ0UUx1MDdxMEFLc1VFY1NB?=
 =?utf-8?B?VlRZRlRFZ3d5NXFjdk9KZEZrTVduL0tOMzJVOW9mSkQzNnIxMkdCRnNWSVdq?=
 =?utf-8?B?ZkxXV3Nma3dwNldQTUIzaW9ESnZzNGxNR3Vid1VKRzg0MXVwR21xUk11Y0NK?=
 =?utf-8?B?N0ppc2FKQ3BnalZLMVcveVhBcXQ2aGY4UEw4MkF0RnA1ZkswcEhiWHNGWlIx?=
 =?utf-8?B?cWx1YW0wbGFDcXh4dXNQZWdJS0dwTnlxZWwwR1BocTl3WEtyM1NXcWpjS3lr?=
 =?utf-8?B?ZlBNRktqcC9yRkthbVVreG1nZDhWVkNXYkRkYUY1SnpKSi9STnVCSEV4QjNp?=
 =?utf-8?B?ZUpTUDZJNzM5bDZlbTN4Y2dDRFg2a2tWZllhUWZWS1Y3U21GQzlOaHR4Nm0r?=
 =?utf-8?B?Q21pNUdib2tvMW9hNGpFcjk0ZVkxRkNPSTR2RGNCbXRveTYvZlllNjBXc3VJ?=
 =?utf-8?B?MGsvRkZUNDQ3M21taVVMdlpadGpBZGJwRk9Pa3RjWDlzaW1KYkQ1MmJ1Yk0w?=
 =?utf-8?B?OXZQeitLeXZMek1zS3p0L2o2LzhkdnRXU2x3amNVbEhuTnFPQmJnRC9EeW4r?=
 =?utf-8?B?YTVndjlQckpkSDdOMVRzL3Q1RXZsT25ubVVuUFdqV1NhTit3YjJPMVQ5THhr?=
 =?utf-8?B?NW84UnlFcndEcW0rZUd4UnVUeWxtL1U2Q0hIQkNkVGpEaU13QjVPSXZSY1pR?=
 =?utf-8?Q?tFNpAQgNz7Xb+lWJJTY5DYu4JBmcTnD74sTCcu4?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5768c4-5263-47e6-f760-08d93c5ddd88
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 07:00:09.5016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUPJlLGhTJ6fOluV+F11f8IS+gtSBdIKiOBjrloxz9a8Aunytg8QgDHA+ZDglaY8J02vQ5EX7d1Z8nvcD2a8tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5434
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBKdWx5IDEsIDIwMjEgOTowNCBBTQ0KDQoNCj4gPj4gSnVzdCB0byBjbGFyaWZ5LCBpZiBJ
IHVuZGVyc3RhbmQgdGhpcyBjb3JyZWN0bHksIHdpdGggdGhlIGluZGl2aWR1YWwNCj4gPj4gYXR0
cmlidXRlLCB0aGVyZSdzIG5vIG5lZWQgZm9yIHRoZSBiaXQgbGlrZSB4eHhfaXNfdmFsaWQ/DQo+
ID4geHh4X2lzX3ZhbGlkIGlzIG5vdCBwcmVzZW50IGluIHRoZSBnZXQgY2FsbHMuDQo+ID4gSXQg
aXMgYWxzbyBub3QgcHJlc2VudCBpbiBVQVBJIHNldCBjYWxscy4NCj4gPiBJdCBpcyBub3QgYSBV
QVBJLg0KPiA+IEl0IGlzIGFuIGludGVybmFsIGJldHdlZW4gdmRwYS5jIGFuZCB2ZW5kb3IgZHJp
dmVyIHRvIHRlbGwgd2hpY2ggZmllbGRzIHRvIHVzZQ0KPiBhcyB0aGVyZSBhcmUgb3B0aW9uYWwu
DQo+ID4gSWYgd2Ugd2FudCB0byBnZXQgcmlkIG9mIHRob3NlIHZhbGlkIGZsYWdzIGJlbG93IGNv
ZGUgd2lsbCBtb3ZlIHRvIHZlbmRvcg0KPiBkcml2ZXIgd2hlcmUgd2UgcGFzcyBubF9hdHRyLCBk
dXJpbmcgZGV2aWNlIGFkZCBjYWxsYmFjay4NCj4gPg0KPiA+DQo+ID4gKwlpZiAobmxfYXR0cnNb
VkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFJdKSB7DQo+ID4gKwkJbWFjYWRkciA9DQo+IG5s
YV9kYXRhKG5sX2F0dHJzW1ZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQUNBRERSXSk7DQo+ID4gKwkJ
bWVtY3B5KGNvbmZpZy5uZXQubWFjLCBtYWNhZGRyLCBzaXplb2YoY29uZmlnLm5ldC5tYWMpKTsN
Cj4gPiArCQljb25maWcubmV0X21hc2subWFjX3ZhbGlkID0gdHJ1ZTsNCj4gPiArCX0NCj4gPiAr
CWlmIChubF9hdHRyc1tWRFBBX0FUVFJfREVWX05FVF9DRkdfTVRVXSkgew0KPiA+ICsJCWNvbmZp
Zy5uZXQubXR1ID0NCj4gPiArDQo+IAlubGFfZ2V0X3UxNihubF9hdHRyc1tWRFBBX0FUVFJfREVW
X05FVF9DRkdfTVRVXSk7DQo+ID4gKwkJY29uZmlnLm5ldF9tYXNrLm10dV92YWxpZCA9IHRydWU7
DQo+ID4gKwl9DQo+IA0KPiANCj4gSGF2ZSBhIGhhcmQgdGhvdWdodCBvbiB0aGlzLiBJIHN0aWxs
IHRoaW5rIHJlLWludmVudCAoZHVwbGljYXRlKSB0aGUgdmlydGlvLW5ldA0KPiBjb25maWcgZmls
ZWQgaXMgbm90IGEgZ29vZCBjaG9pY2UgKGUuZyBmb3IgYmxvY2sgd2UgbmVlZCB0byBkdXBsaWNh
dGUgbW9yZQ0KPiB0aGFuIDIwIGF0dHJpYnV0ZXMpLg0KV2UgYXJlIHJlLWludmVudGluZyBieSBk
ZWZpbmluZyBhIG5ldyBzdHJ1Y3R1cmUgYmVsb3cuDQpJbnN0ZWFkIG9mIGRvaW5nIHRoZW0gYXMg
aW5kaXZpZHVhbCBuZXRsaW5rIGF0dHJpYnV0ZXMsIGl0cyBsdW1wZWQgdG9nZXRoZXIgaW4gYSBz
dHJ1Y3Qgb2YgYXJiaXRyYXJ5IGxlbmd0aC4gOi0pDQoNCkkgbm90aWNlIHNldmVyYWwgZmllbGRz
IG9mIHRoZSB2ZHVzZSBkZXZpY2UgaXMgc2V0dXAgdmlhIGlvY3RsLCB3aGljaCBJIHRoaW5rIHNo
b3VsZCBiZSBzZXR1cCB2aWEgdGhpcyB2ZHBhIGRldmljZSBhZGQgaW50ZXJmYWNlLg0KDQpBbHNv
IHdlIGNhbiBhbHdheXMgd3JhcCBhYm92ZSBubF9hdHRyIGNvZGUgaW4gYSBoZWxwZXIgQVBJIHNv
IHRoYXQgZHJpdmVycyB0byBub3QgaGFuZC1jb2RlIGl0Lg0KDQo+IA0KPiBXZSBtYXkgbWVldCBz
aW1pbGFyIGlzc3VlIHdoZW4gcHJvdmlzaW9uIFZGL1NGIGluc3RhbmNlIGF0IHRoZSBoYXJkd2Fy
ZQ0KPiBsZXZlbC4gU28gSSB0aGluayB3ZSBtYXkgbmVlZCBzb21ldGhpbmcgaW4gdGhlIHZpcnRp
byBzcGVjIGluIHRoZSBuZWFyIGZ1dHVyZS4NCkRvIHlvdSBtZWFuIGluIGEgdmlydGlvIHZmIGFu
ZCB2aXJ0aW8gc2Y/DQpJZiBzbywgcHJvYmFibHkgeWVzLg0KR2l2ZW4gdGhhdCB3ZSBoYXZlIHRo
ZSBhYmlsaXR5IHRvIHRyYW5zcG9ydCBpbmRpdmlkdWFsIGZpZWxkcywgd2UgZG9uJ3QgbmVlZCB0
byBhdHRhY2ggdGhlIFUtPksgVUFQSSB0byBhIHVuZGVmaW5lZCBhbmQgZXZvbHZpbmcgc3RydWN0
dXJlLg0KDQo+IA0KPiBTbyBhc3N1bWluZyB3ZSBkb24ndCB3YW50IGEgc2luZ2xlIGF0dHJpYnV0
ZXMgdG8gYmUgbW9kaWZpZWQgYW5kIHdlIHdhbnQgdG8NCj4gbGV0IHVzZXIgdG8gc3BlY2lmeSBh
bGwgdGhlIGF0dHJpYnV0ZXMgYXQgb25lIHRpbWUgZHVyaW5nIGNyZWF0aW9uLg0KPiANCj4gTWF5
YmUgd2UgY2FuIHR3ZWFrIHZpcnRpb19uZXRfY29uZmlnX3NldCBhIGxpdHRsZSBiaXQ6DQo+IA0K
PiBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWdfc2V0IHsNCj4gIMKgwqDCoCDCoMKgwqAgX192aXJ0
aW82NCBmZWF0dXJlczsNCj4gIMKgwqDCoMKgwqDCoMKgIF9fdTggbWFjW0VUSF9BTEVOXTsNCj4g
IMKgwqDCoMKgwqDCoMKgIF9fdmlydGlvMTYgbWF4X3ZpcnRxdWV1ZV9wYWlyczsNCj4gIMKgwqDC
oCDCoMKgwqAgX192aXJ0aW8xNiBtdHU7DQo+ICDCoMKgwqAgwqDCoMKgIF9fdmlydGlvMTYgcmVz
ZXJ2ZWRbNjJdOw0KPiB9DQo+IA0KPiBTbyB3ZSBoYXZlOg0KPiANCj4gLSBib3RoIGZlYXR1cmVz
IGFuZCBjb25maWcgZmllbGRzLCB3ZSdyZSBzZWxmIGNvbnRhaW5lZA0KPiAtIHJlc2VydmVkIGZp
ZWxkcyB3aGljaCBzaG91bGQgYmUgc3VmZmljaWVudCBmb3IgdGhlIG5leHQgMTAgeWVhcnMsIHNv
IHdlIGRvbid0DQo+IG5lZWQgdG8gY2FyZSBhYm91dCB0aGUgZ3Jvd2luZy4NClRoaXMgaXMgdGhl
IHJldmVyc2Ugb2YgbmV0bGluayB3aGljaCBvZmZlcnMgdG8gbm90IHJlc2VydmUgYW55IGFyYml0
cmFyeSBzaXplIHN0cnVjdHVyZS4gVGhvdWdoIEkgYWdyZWUgdGhhdCBpdCBtYXkgbm90IGdyb3cu
DQoNCj4gDQo+IE9yIGFjdHVhbGx5IGl0IGFsc28gYWxsb3dzIHBlciBmaWVsZCBtb2RpZmljYXRp
b24uDQo+IA0KPiBFLmcgaWYgd2UgZG9uJ3Qgc3BlY2lmeSBWSVJUSU9fTkVUX0ZfTUFDLCBpdCBt
ZWFucyBtYWMgZmllbGQgaXMgaW52YWxpZC4NCj4gU28gZGlkIGZvciBxcHMgYW5kIG10dS4NCj4g
DQo+IFRoZSBhZHZhbnRhZ2UgaXMgdGhhdCB3ZSBjYW4gc3RhbmRhcmRpemUgdGhpcyBpbiB0aGUg
dmlydGlvIHNwZWMgd2hpY2ggY291bGQNCj4gYmUgdXNlZCBmb3IgU0YvVkYgcHJvdmlzaW9uaW5n
Lg0KVmlydGlvIHNwZWMgY2FuIGJlIHN0aWxsIHN0YW5kYXJkaXplZCBhYm91dCB3aGljaCBmaWVs
ZHMgb2YgY29uZmlnIHNwYWNlIHNob3VsZCBiZSBzZXR1cC4NClRvIGRvIHNvLCB3ZSBkb24ndCBu
ZWVkIHRvIGx1bXAgdGhlbSBpbiBvbmUgc3RydWN0dXJlLg0KDQo+IA0KPiBGb3IgZ2V0LCB3ZSBw
cm9iYWJseSBuZWVkIG1vcmUgd29yazoNCj4gDQo+IHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZ19n
ZXQgew0KPiAgwqDCoMKgIMKgwqDCoCBfX3ZpcnRpbzY0IGZlYXR1cmVzOw0KPiAgwqDCoMKgIMKg
wqDCoCB1bmlvbiB7DQo+ICDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgc3RydWN0IHZpcnRp
b19uZXRfY29uZmlnOw0KPiAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIF9fdmlydGlvNjQg
cmVzZXJ2ZWRbMTZdOw0KPiAgwqDCoMKgIMKgwqDCoCB9DQo+IH0NCj4gDQo+IE9yIGp1c3QgZm9s
bG93IGhvdyBpdCBpcyB3b3JrIHRvZGF5LCBzaW1wbHkgcGFzcyB0aGUgY29uZmlnIHBsdXMgdGhl
DQo+IGRldmljZV9mZWF0dXJlcy4NCg0KSWYgd2UgZ28gd2l0aCBpbmRpdmlkdWFsIGF0dHJpYnV0
ZSBnZXQgYW5kIGFkZCBib3RoIHNvcnRlZCBvdXQgbmVhdGx5LCBleHBhbmRhYmxlLg0KDQpZb3Ug
YWxyZWFkeSBleHBsYWluZWQgdGhhdCB0aGVyZSBpc24ndCBvbmUgdG8gb25lIG1hcHBpbmcgb2Yg
ZmVhdHVyZXMgdG8gY29uZmlnIGZpZWxkcyBmb3Igb3RoZXIgZGV2aWNlIHR5cGVzIHRvby4NCk5l
dGxpbmsgYWxyZWFkeSBlbmFibGVzIHVzIHRvIGF2b2lkIG5vbiBzeW1tZXRyaWMgdTY0IHJlc2Vy
dmVkWzE2XSBpbiBnZXQgYW5kIHUxNiByZXNlcnZlZFsxNl0gaW4gc2V0Lg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
