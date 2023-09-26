Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2255E7D0C5
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 05:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 432AE82240;
	Tue, 26 Sep 2023 05:33:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 432AE82240
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QNwIfAsr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kZxLXrWj0gWr; Tue, 26 Sep 2023 05:33:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8CAC18223D;
	Tue, 26 Sep 2023 05:33:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8CAC18223D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A2ABC0039;
	Tue, 26 Sep 2023 05:33:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CE19C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F4218223F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:33:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F4218223F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6iw_ayM9h2he
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:33:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 469A58223D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:33:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 469A58223D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwdI8dK46oaEgQ11Y0Iu9KmhqDq/LVAZ8E+nUGuquw+xalaCDfCIJ3O467cVA9M/8yZ6GOXMDX+5E8Uk8P1m9sEuIxRlmSMf4JE6oHrDRsb++rWYh1mjw0C/3RD8aOcCwU/FNthcHIUfpngUeKNZ2lnzEVRqRi3nReBo1Mj2a9NIfcQzOpNZlYUpKk2wA/koIehFafsNKSRvBIOoS8Felw31sh1NP8JXWL4S95A8bAtpfqmJvL10ijpKmWe7wP/D5qrIZp4+zsgEuJA5cRYvuOlEwmn1aayMRF5tbtm91JwJqregh9LugnKRNfGdSjDrF0yVAKeB/GX9Z3asqeRBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqYdHX+ave7hAsQM1HJYYu0Ggv8DN8yzxJktLOsGosE=;
 b=kQ2a9LoEQCkBHpLCNEyYBUHvCBuvXn+7HvEB+S+gP49I2ZtSvQ3ojIkwMbEidlcdzIkeGpxMKOgA3b6UYFo91sn2AwMqpusyalY9T0fGRbvypOffv51qUGtKbE+D7pcFQoECA75JZg1m0/OT90hAw3gkc3xTtKldWK4ennCTzHg41uWTu7ttrvt3Ungx3kmb8/qpQtrPsRkxg/QDWA/9oJi/WMiW5fq1A6pJ7G3K5WrR3675CzzFp9uv/XiVZy4GCsr3XbDVyXmdI8Qw5yvjCy3NIr0REuZuMYJQytIFEzY4khvg3HB5dt+H7uPZ8jiQPSS6oKnSt0OBZX9GkpofXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqYdHX+ave7hAsQM1HJYYu0Ggv8DN8yzxJktLOsGosE=;
 b=QNwIfAsrIOrVzWeCmDsMX/RVhMR/Gs1YrWRoBctHbWXwr/YgEiziI+AWUtuFa+5c/W5TJkBmpQozS2xN3VOVMHMWWeznJ3FRZvIF/Poro7ZL69IlT+Ina1eMz77Qknbab8FU8x7Ilp34DqXyYTlKOJ2PEP/oxZM6HXwYIdnxEqhRu33J6veiRj5+e3KUifd1GI5W+908t0GaqMinGiqsMJ3xMBpxURye4xIEzoq51jalbPo+KKLOEm+l8kujSI3kzAXEhrQ0bh0oF4iMCrmQn7ns9QUqAjdfPfhNJhQCgw0Ej+vc5BoIQ11s5EQiwDViz9hB9ogU/SqeZr51UJmp+w==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 05:33:14 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199%7]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 05:33:14 +0000
To: Jason Wang <jasowang@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Thread-Topic: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Thread-Index: AQHZ7IkPl5ENqOgMC0yEzkOHANq/CLAlQo6AgAAPYoCAAAFNAIAAKK2AgAADMACAAB24AIAACW0AgAAKOgCAAHiYgIAAmbUAgAQV4wCAAKUvgIABD3oAgAAO/AA=
Date: Tue, 26 Sep 2023 05:33:14 +0000
Message-ID: <PH0PR12MB54818E0BBE6638E0D971F24CDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230921141125.GM13733@nvidia.com>
 <20230921101509-mutt-send-email-mst@kernel.org>
 <20230921164139.GP13733@nvidia.com>
 <20230921124331-mutt-send-email-mst@kernel.org>
 <20230921183926.GV13733@nvidia.com>
 <20230921150448-mutt-send-email-mst@kernel.org>
 <20230921194946.GX13733@nvidia.com>
 <CACGkMEvMP05yTNGE5dBA2-M0qX-GXFcdGho7_T5NR6kAEq9FNg@mail.gmail.com>
 <20230922121132.GK13733@nvidia.com>
 <CACGkMEsxgYERbyOPU33jTQuPDLUur5jv033CQgK9oJLW+ueG8w@mail.gmail.com>
 <20230925122607.GW13733@nvidia.com>
 <CACGkMEv9xaMi_Hxex02QUkLD95+1nWBRJz9g8sfQGzN8gkxt=w@mail.gmail.com>
In-Reply-To: <CACGkMEv9xaMi_Hxex02QUkLD95+1nWBRJz9g8sfQGzN8gkxt=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB9060:EE_
x-ms-office365-filtering-correlation-id: 4e0c2582-f069-415b-f3d0-08dbbe52149e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iw3WPDFo00zg4wqe+FdOpdL40tTFWD//L1m2JCyd5+sFEVx4YbkyntGcwg4YiGdx2hx2kr43jEl4j/FEIx2eBczAIXB2b2BWGDGznWXLdniVM/RIX4INrzgSkZpeIf8jwAkw8eQ+LZ1EPNGlsVjaX5ADWBRhqUDuu4WJBsdczQWpyWZUWtnS1gIoL3rZL7hkz5tqcZa+OJf/kzTZVIsMyRO3r+hfvPchFBMOEE7X27DObvOYQVMYrAe8y8y7kGF5jersa78+7sfBKQ4WuFv33d6X7Y0H9GP5NtMWYOKNBhIcFpN0ip63YG81yA1xZcFM8BjZNEDzBUNFXooYGUCKeS8VEdIecDkacGuy+sGdsbNl7EpzhNRb0AqmGiV+s/J4/ZvwWa+9fSVnzR6wZoT+Zm6jFC+0Vmj+vrGEqdfxopl8Kw+/VBPZ181hrr02dts+2TO52MskNJXIrALA3P9srqWKxQcpEKmoCHGh0MsCAlF3MivNUGIWh8jPLA16zySuHZyIFMMg3sFh7c+PUww2QTCCnivtwiz054wAXZI6YwOSNQhNIr1MgoO0SEnxIAUTCdkjKC3Jn5mFvO3r8ppX/UFFeEVGa7Mys/pjRDga0911rEzMOUyzA9rZXty+VSuYZry8QhVgM6tL+FKk557wYikJg14omLHOSenpuWERFNE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(55236004)(38070700005)(478600001)(122000001)(41300700001)(71200400001)(966005)(2906002)(4744005)(6506007)(107886003)(33656002)(86362001)(38100700002)(83380400001)(26005)(316002)(9686003)(6636002)(7696005)(54906003)(64756008)(66476007)(76116006)(66446008)(66946007)(55016003)(66556008)(110136005)(8676002)(4326008)(8936002)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2VzQ1JLZ1h3eHdoOVVHeEVJbGlPYzkrQlMzejRDS2VFbWRocnNmVVBUQkdB?=
 =?utf-8?B?akMra0puanQyM1ZnOFgwRFUvV0NhNmxKNWdiOGRaYnNiM0tOQ1U5RUlhSkhr?=
 =?utf-8?B?bHBRaTJQUDRBdEpMT1RrM2xTQm8zTGJpVjJVTDNBK3JSdnRSUVM5cFZaWFBE?=
 =?utf-8?B?TW1ZS3pDK3lRN3BhK1VjM1gxRGFqMW16OW4rYm5jWnYzWllDYzVCQkQxY0R2?=
 =?utf-8?B?TzhWY0lTOVQ2V0p2ajRhaHMzNTR3THpWV21EUU9aMklkbW84TVBEd0VHOHhC?=
 =?utf-8?B?TFpORGJHVEJONFdhWGMrcmVqc1Z6WVE0VzZrajFuK1RGdSszTVpqZXpiMEF4?=
 =?utf-8?B?WnhBNEM0SmhIeFU2Z1Y0RE9kWm8wU2VicmJlNzhNaTZCNUFBSzgxNzhEVC9X?=
 =?utf-8?B?SUxZM1p4dEh2ZGpUNVFPZjJhcXBQVmxCMk5EcUd6TzZNUWVLUWswaHgwSXZJ?=
 =?utf-8?B?L0FtT1ZUcVhGRnMxWmtxNy9Pc1o0TXBqODJJTjk0YUNtSzIwaC92c3hjTmF1?=
 =?utf-8?B?OVZJNzVQYkdkazJTdG9LSmg2QmFvcXdsa3FCK09tSWJUa1I1QkxoRzkxNWtB?=
 =?utf-8?B?cmFmZTgrWEZGajQvOE4wWHZlTllXQXR5ajNUMXQ1L0xpSmVZT2VFOEpvSWht?=
 =?utf-8?B?K0szdndaL21LcWV4ZHMva0o5UXZYMVZ3cjhrajA1UUk1SEFFcENVR0dWWUhE?=
 =?utf-8?B?WjZaWkpnaFdCclh6N0E1bG1FbStOVFByYW1LZmRGczFXYnB0MjNrV0w4YlRT?=
 =?utf-8?B?TDVpUVA3VFM3azZLVzVlL2kzL2pvdHJ2Qzc4ZHBXMXljWXBMbnBmZFNydmhp?=
 =?utf-8?B?aWJaWkhPWmdvSWhXS3dBTGwxcVlmanpZVDB3dnVrdjVQZHFRS09QWW14a2pK?=
 =?utf-8?B?azZ1Yzh1akIzekZ6ZUoxQUkzbVlVbjlkUkk0YzU0NjFUM2hydElCTm0xWDNK?=
 =?utf-8?B?MlV6ZW5nWjdWVTRFQ1dXaUxKKzVOVXI0MjJ1VU5TNVZjakVlRW1JQnFCL1Js?=
 =?utf-8?B?V01nQ2N0dFBOS0JVRVBCTzRpdGR6Y3RqV0dMcDJsNitTbDE4a1E3NVlUS2Zz?=
 =?utf-8?B?RUxBYmlXOEN6U2UvMkhsK21lSWU4di8zczg0VnNIQTc5QzB0Nk4zM0lpOGlV?=
 =?utf-8?B?bWJLSVRnM0pDTDZ2Q0xuekNFNElVZXJrQWN2Tk13UW5YZ2wxTGlSQ3pCekdC?=
 =?utf-8?B?K3phWFlIRUs2bmROZ3d5LzVtTTFJeVg3alUwb1hTUzFyaG4yWnoyVHc4elBr?=
 =?utf-8?B?bE5HM0dhQWhtdC9IZk5mTUdNMmVmTk1JTk01VGFRZStLQ3cvUjJUWVFwVExZ?=
 =?utf-8?B?SWhBT3V2NHNJNFdzWlBOQklmWU5telRTTWZXcmFQdEwzZVBTNHlvem02b0wz?=
 =?utf-8?B?a3hJcm9FNXJndG01U0g1bE5MVnArSjdkL3Z4aGxRRDlUNzMwZ3JMUHhjK3pw?=
 =?utf-8?B?YThLblIyWXRMUjJNNHd1NVlDUnpEd2g4ZWVQTmFvREZRbzFsK0tHb0hIUVlZ?=
 =?utf-8?B?b1YwR3dRdE9QYllrdWRTZ1AwbWYxaWZMdFYvdmZEQUdvRlY5L2h1U3dEQVR5?=
 =?utf-8?B?YklCKytwdXJlckxlMThQYVl4V2NDeWJLeVVIamJsWmovR1NJVktPeis4OGlL?=
 =?utf-8?B?bUR4VFFQQTlzWjZxTUpiNXpvOUR6Uk9pVTRraGN6a2dzcS95MXVycXVXVGJu?=
 =?utf-8?B?eUlXaWlpWjRUZjZlSzBuMkwzSmRSUDZOSkFlYjhGWUVtdXF4T1FvaTdKa2Zi?=
 =?utf-8?B?VzJDRzJRSk1VdVJtdzdVbkdJUGRRQ0Q5Mi9ITzVhYmJ3MVdpbkJxYTRiQ3hs?=
 =?utf-8?B?WnV1UkR5MVRmZVh0dTkveklvOUtnYkRoK0JMS3MrMmFsN0NhanMwdGZtUWRE?=
 =?utf-8?B?L3hDVi93N0FYdWVDczR2NitIUjRWeC9JVGRmeEtodkZ6K0NWUGs4bHpsejRG?=
 =?utf-8?B?UkRWM05oOW5XRk54WVZqQ2twWWczT3ZGNTBVSCtIcTY0b1NPLzhQZnN2cUEx?=
 =?utf-8?B?YklQNlVpWVZ6SW4xaG1JUlZPQnVGS1ZUWFRFcTkvV2s3bGtXaHB4N0U2cUEv?=
 =?utf-8?B?VG5TQXRiTEtUWWVQZ3JQeGkxOWM2ditKTEovQ1VVbmV0QXpqSFREb2x4djZu?=
 =?utf-8?Q?/Lx0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0c2582-f069-415b-f3d0-08dbbe52149e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 05:33:14.5507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZAcUKkjGpvmLpVpWzJz6tdpUCbNkJ0AMHkkyaOHdfBxdJIMhsP5/0okh//UiDfaAWUOlItlzAJOG/N4Jbmhqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jiri Pirko <jiri@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: Jason Wang <jasowang@redhat.com>
> Sent: Tuesday, September 26, 2023 10:08 AM

> Right, so if we'd consider migration from virtio to vDPA, it needs to be designed
> in a way that allows more involvement from hypervisor other than coupling it
> with a specific interface (like admin virtqueues).
It is not attached to the admin virtqueues.
One way to use it using admin commands at [1].
One can define without admin command by explaining the technical difficulties in admin command may/cannot work.

[1] https://lists.oasis-open.org/archives/virtio-comment/202309/msg00061.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
