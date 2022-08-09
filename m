Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570B1C19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 18:42:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C6338400E4;
	Tue,  9 Aug 2022 18:42:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C6338400E4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PMebyx1E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6obGlXz6LIM9; Tue,  9 Aug 2022 18:42:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 31CA840181;
	Tue,  9 Aug 2022 18:42:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 31CA840181
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E63E8C0033;
	Tue,  9 Aug 2022 18:42:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8307C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 18:42:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 92C1F4058C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 18:42:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 92C1F4058C
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=PMebyx1E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DHxLB75eTmld
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 18:42:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB1EB404B9
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB1EB404B9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 18:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dX+G9MzEhcWAOcQ8Dtp+z5hpJvUVJpcfFE0J4NtwPsxn9RwRixKIAn6C+6Q1vhlXZSqt0VU3ovxpNFL/swdR2raTzjslQkTeRQQvJ/2H0oggbDRfy2vpxz7iJyw+MxMlMH1InxVO1BePlcqbZB68hEngI0GelCK0DaxSSfbTELzhrgl+OdEsZN8TWxoy4+DJHF3SpZ07kNsSPbm47Qe236yXAFH1NTs+HTPtFgzVYDm3UkYofPrE6wIFB+14Or42RFqIOcb8Kpl5YKQlypF4Bj6N9M30JQtWZcfpD++FqRPiHg9zJM98j1VJ1/H36+Ppf+LRdpJk6lHIR7armYvG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jn596/VYk5GD/XhIu2vvX3lFmBhRh7BWs2hrsQj/QCo=;
 b=cjMz76itKbSpoa4KaomFOaNN50gRkuEz/XbC7W+yhxiwCjTxtrqHofcMzv8vbu/HTLOiHtBIMlHEby+zK/p0CzpuSE8G8ko7L4zt0+bFmK2dCiUpbI3YsfiFzO4WQIZWeAJxKIAvSnA9GEWvcsMZHwENemZ67ekfr0KD3di4lZ8tP1MyruJjsVt9JvI0O3rX1lFP4pjKqL1vbRePlKCtNtn7eUMnCKXSLY2zMUIES1voRK2V7T+b0eyajMICsHK+GoICwBNvGbj87+lszCWGGFEkVH4BeBMpU/S+L2LZHQP0vQOSLnz5IZ6OKnr8xsyo9D8gGc4fwQz7KDek6T6Elg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn596/VYk5GD/XhIu2vvX3lFmBhRh7BWs2hrsQj/QCo=;
 b=PMebyx1ErZ6a0Ut3RApAinXFXdW3mCFuQDM4GdkxmtCwRAoEU5ZhYu1qDPvyAVLPdbDT+3TudvX+TxShfH+ba0rWckXYPdIZPKvxrXrLZaP6AMKl1rh3YkutUMv9jDifUpfsdSGvueRc1UEdaegpL0mxOp2av/jy9T/OX960j5v2dZYR0ZdZrIQwqyVuGbon6hOP5TLfbwStgKxSbAwrbqvqfQ/9thGu0m1p0cL9pTadx/20QTHvVyqDGiCfecQ2fcVSLL649rtEbdXo3t61InpCjeRNr0UpQwEW9g+WM41HSrMefIkgR3QB5v37vgG+bE1nU3Ce5+Q4EjwSHaUtRQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by MWHPR1201MB0253.namprd12.prod.outlook.com (2603:10b6:301:52::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Tue, 9 Aug
 2022 18:42:23 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::957c:a0c7:9353:411e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::957c:a0c7:9353:411e%5]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 18:42:22 +0000
To: Si-Wei Liu <si-wei.liu@oracle.com>, Jason Wang <jasowang@redhat.com>,
 Gavin Li <gavinl@nvidia.com>
Subject: RE: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Thread-Topic: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Thread-Index: AQHYpirEKDhT8iEHv0Wl5fiZieJEBK2g5FqAgAPA+oCAARNOAIAAeEKAgAAKdACAALbdAIAAAJwQ
Date: Tue, 9 Aug 2022 18:42:22 +0000
Message-ID: <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
In-Reply-To: <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9634c98-93ea-455e-9a43-08da7a36e5cf
x-ms-traffictypediagnostic: MWHPR1201MB0253:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vGAP5m3Kzcyb/xgKen50sHzHhE/BPBDpRgH7BKyrN0uktE5DS1q/TF25KDconJvpHW7M1bYgIm9W3fty6jPOwTOu/DE46BN0TOY/LDhK9PRcgRnjBmRHw2Iws6G584k+RjOOTktI9prxu4d6c/JDPA2QL7j39MXPllX73iQSNfLKWzOGaQGKohH+D44XnQSB3WVnsemBZQYHmKLsE11S+D5JHk2JafrD3xTEZuL09gL0hxaoPdhXdjGGKfsBv0r8QNiWPqS/euHMOpHR+fo5BegJ2NG/Gj53bvkbem7SjEnOb2LEApgrykZs08M0wDLI4zqmQ1L1DrvEUyd4d660o4toT5tLnoG3lVMXTsDfskW3RZWh0QWTvmD2o9TgqZVMNGEd+/ZVoBpQDmCrXyEBu6Xpx5MW/r1aqQbfJVGIpgd6j7CdK0UO2a8y8rXtDsUJRrPtvFnTc3RR71vSMZEL053SPxbrttzUy8ArMBUKqHsyS2D2usgkbWWGuqNtls7fXiyGK05s0PaBuZD4RcyQ5iIZCJLhqFy3rRMqoSWDPNR/s//KcoOfgJsyxDooPalHpBBEchzj16vDx8aW6kOmb26Rd5iI+MuWxPSac7fDv1piFh701vdQJFHmW7SUQtNNCaX20WEVXdEBlcBlHQcds3XGLy7tDCaMewBFlITBXUFCQKJ9ONPwsPJVFU4xQLhlL9ESfVjXuZ6ZinHtEHNgrv2Jz3Vt9qUXAjadBqILYY4c7akwE+2bsywz9EgGT71vnvAdJDqjkdbUu//L53ErTvH8RrshJUAJ76tu6fnzVKw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(26005)(41300700001)(9686003)(86362001)(7696005)(6506007)(122000001)(38070700005)(38100700002)(66476007)(186003)(107886003)(66446008)(64756008)(4326008)(66556008)(66946007)(33656002)(4744005)(8676002)(7416002)(52536014)(2906002)(5660300002)(8936002)(76116006)(55016003)(71200400001)(6636002)(110136005)(54906003)(316002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVh0dHRaNEtqR2lZUnJIczd1NVlpVWhmNDBJWHZCNGNWemJyVUtQYkZ3bTZV?=
 =?utf-8?B?dWdSMlJ0emNVUlh1aDRiN1l6Q0lXRDRJR3QrQ2JackY1T1o0WXc3eUJPZDlU?=
 =?utf-8?B?NXhHaFJOdHgrTGJua3Y1NEJpWVpkdWhPaUk1M2NYMGxTeEJCQnVMK2hHdGFk?=
 =?utf-8?B?MUVmNWdJeWNRM3NGdlROMWU3R3JYT2RCYTlNTDlEeGNJZ0lKNmQ1c1RiZHNU?=
 =?utf-8?B?QzFaNzNCMWZYSkxzVi9iRzNnZlZBYjNWb3hRN2hndzM1SGZndjlKYzJ3Vm81?=
 =?utf-8?B?NVk1bEhZQVBQamZnd2NLbVNWWWhxK1FrT3lqMzFGMWcyZ1lWM3dMbmppVWF0?=
 =?utf-8?B?bldDT0M2a3ZWcnFmN25BL2Z3cFZiV2xIclZBNXRSci9LRVJaNWYwRFkvQWtU?=
 =?utf-8?B?QVFEeUxyWnRiSDRYcGxaNVluSWxwOTZJVkRoNytsUzd1SkhZNWY5Y3d0bG9k?=
 =?utf-8?B?MWgwMEJtZGR0SFpLVWJmbUNhdDdSZmpUcEVUQzRBWXl0cXBoWGMrc3hLOWhT?=
 =?utf-8?B?QTJmaXlOWG1xTDE5ejdEMFNGRHJBTDNQUEZVMDNqYUNMN2J5a3BTV05KYzgy?=
 =?utf-8?B?enBsUXpLZUp3R3ZWNnRkR3FWczBPamhmOEtUTkVkeklBeE8zb3pZanVFYXF1?=
 =?utf-8?B?R0k2Z3BMVUhRUlV6OHhDdmgwR3h1QTR6SGFUN1d6WXpzR1JvaGdacmVaU05s?=
 =?utf-8?B?Q0hIbGlqaGxZM09hcjFxWGtkeGVKWmMwOFNuMTFKZTkxUkhlakE2R2VxNEF3?=
 =?utf-8?B?QzYxQldxbFkxOVZhYXU5dHoydlYyYTdkR0FqcDVLeVpDYWJHRlJWbTl0YWRr?=
 =?utf-8?B?T3BnN2hpS3NQL3d5Wm42R2tEWXBpMzZKVnBFTjZWY2NScW9GZ1ZtRFlGT25i?=
 =?utf-8?B?Tlg3Kys5NEYzbzd5U2FsQ3c2QWY0Z2Fka2dGaDNwRGIybExGRlcwN3cxZ2Vu?=
 =?utf-8?B?MkdvUEk2MWFGS1lJd28zdktQM21TV3hYaFdGRlpVV1JBK2hoQnZlMktsQlpj?=
 =?utf-8?B?TzZjZUFqcVZUeVlIZ1loU1VWREk3KzBZS2NBZFlHUTV1MHQ0WC9OSEhySjhG?=
 =?utf-8?B?NVFrY0hyOGt0bFNNTDlpUjk1elBhWDlIa3dlSzZobkdPM3hVMThaaUk0SVBV?=
 =?utf-8?B?aHlROUxsaHNERi9GNmFad2Z3UnJHVWJDSjhpQnJ1OCtWZFJLQ1NhTURraXVQ?=
 =?utf-8?B?b09HRGxYdUZjYnRBNFkzdC96VThiSnhWb1pJdUJXQ0plcnBuODl1a05uM2F3?=
 =?utf-8?B?d01ycmFjeTQrWStzUDR3UnNzcEZFV09tTTVqd2dkWlQrRHhuUWFKa09NQXFS?=
 =?utf-8?B?M3B0ZWdGemdwYjliU1ZpNnhYT2NDMWV5YU5BNjYxNSt6RTBLdjdOeTlXRGJy?=
 =?utf-8?B?L1NsRW5uRFo5MFNtU0kzOE1QWEl0bCtlM2cvdWRpTGlJTmtLSHZNaXF4UmRo?=
 =?utf-8?B?WDBhS0RISCtJeDdkWXNpdHJMaGgyNVBuNDJJRTIxZVczdC9vWVRWQjN0UVNn?=
 =?utf-8?B?cTN2VTZ1QzUwRWFWSmRwVm9uM0NqRTQ2U3pqT2dHdFRlR0tUbzAyWmJ5SEFp?=
 =?utf-8?B?S0dtUGw4ckgvSE0zUk5lWWNvNFgzRE90T09hR2JXbnVyWFRyb2hsWWNyY2Ni?=
 =?utf-8?B?SExJRzdsQTZCeG8zajVkOGtONWNBTTI5RGgyZFVpLzB4ME9PZ2dwd3FITnJ6?=
 =?utf-8?B?TW9xYnNsQVJmbjVhUlFyRXJ2c2ZSaGRXeGJxNW56eGErZ0RZT2JscDh2ZlFL?=
 =?utf-8?B?WS9CaUNrTTRGWWxYZ2w0UldtZXdWSXRTaUkza1JVZnRqMmpKNlgvTVVkd0lH?=
 =?utf-8?B?SzFQWW9DdWEvUzgyeDRnM2JwY1hBaUd6MDZ6Z25rNnozazZpRnBDR3dqbEs4?=
 =?utf-8?B?UkZ4cDc1dkRCNkhNL2E4eUh3eVJMWG9EWk84bUtWTk9HWjNFR2Z5dnBvRFRo?=
 =?utf-8?B?NVBGY0RYRDl0QUN4cGN0bjZoV3RpNlQwenZXRFVJS2RMbWNUeGZaaFVzRkN3?=
 =?utf-8?B?dzZWQURGd0J6M2YyVlBpblRUYlBlb1JOcHg3Sy93RkpWbzNTMDBlbFRLRmxK?=
 =?utf-8?B?dmswOEJaZUxqd21NZW1xNjNrRm5VdEFBb3laN3NXUUNlS2EyMWp3TzE2NTZy?=
 =?utf-8?Q?9avM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9634c98-93ea-455e-9a43-08da7a36e5cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 18:42:22.8132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k7yOU5QF6n8XLoJKqkHdeMP8Q//0XHKa47DWCGVxWcp4n+lh87A/CubJvCJOGzp3Ub7DOM4C0xyDnsNAJYNS6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0253
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>, mst <mst@redhat.com>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>
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

> From: Si-Wei Liu <si-wei.liu@oracle.com>
> Sent: Tuesday, August 9, 2022 2:39 PM

> Currently it is not. Not a single patch nor this patch, but the context for the
> eventual goal is to allow XDP on a MTU=9000 link when guest users
> intentionally lower down MTU to 1500.

Which application benefit by having asymmetry by lowering mtu to 1500 to send packets but want to receive 9K packets?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
