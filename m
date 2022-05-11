Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6714C433EF
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 19:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4362040574;
	Wed, 11 May 2022 19:55:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kHcEuzcf5Siz; Wed, 11 May 2022 19:55:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8AECE4041C;
	Wed, 11 May 2022 19:55:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40AF9C0032;
	Wed, 11 May 2022 19:55:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11CFBC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 19:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0A7D832C7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 19:54:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=vmware.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bMCd3sGBhHCZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 19:54:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::618])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D680D83224
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 19:54:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIGgrw9kVe5DCCFDDOcpc1ul4L7aJiR32YYgamGIAJ28bhh1ACA3wD7UjW6tEUi2lQNwd80c+HrZwTM1JUmlTtuVwwPgDtZa1beMsDOVFG4fN7ksjguwlDoLjjZk9i37a7/PKphnG05sRXZVmJ8Kir5n4ZnGij3uyS5HVbnZ0v+K0s45lNe/uIqOmFbu6HdEl5iWg+vB0vFiHMy1JQ/FJNramReKfO5IweSaSnEixVRwCyifORYjF5tHrUlYMxJPNd/ogjNr9f0K0LsUathPvSBryarn0PibeTbaVH6RlHff6tfsGUSXEnprE9DCen9+OhCsB08Gq6iuePAksV4w8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95YhtPFjoX2oXXIdLJFuAEb8YQx+oacH+EeS5Jjey4E=;
 b=dHn0hLT4BL7lZEBUgKOZC2wmuYS/tUNYEVvSz05dWPRY1/ZtMlNlbtGnMwpG95C/pRYE2vkwG9lTAqzBBqldqU6gBCjbwoDHoiN3qn+INHFSUwE4aldPFye9npSQbMDoDBaOxcq7XmsivmfFSRdpDEJUAtMzMEEJeDfls0iKN8OxzzDXVG6QOpiIuIG3FBI5RMkZY2S4/kJR1qBTzO9wV4h3e3ciP3rrjiV+8P7edyi6ABrqMVym18pCmOlxoDT3EK7rK91jSeULpj2nlHuAmukEqFvJbOtq/9bd3zojsFigGApC1JHMV50ZwEHaBpwuXpgUjUj9f0ba2rGoRGY20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95YhtPFjoX2oXXIdLJFuAEb8YQx+oacH+EeS5Jjey4E=;
 b=VGAKId8BZ/a3U5pRAjhPNLECW26IgZ5X0dy90NNOVysJBq9KNNyVo09B71WrUin0lpi2jt6FVpZ5gSQXU+S2pRbnnP7N9i7het6NKGzr3OfOoKFoFFY5al4z/5uxgZz8h+e4yNZZSPUUyuP0F9KvaUh03wssr7awHWGh48OTsfE=
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by BL0PR05MB5458.namprd05.prod.outlook.com (2603:10b6:208:6a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.4; Wed, 11 May
 2022 19:54:54 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::d048:c348:221f:6be5]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::d048:c348:221f:6be5%7]) with mapi id 15.20.5250.012; Wed, 11 May 2022
 19:54:54 +0000
From: Vishnu Dasa <vdasa@vmware.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] VMCI: Add support for ARM64
Thread-Topic: [PATCH] VMCI: Add support for ARM64
Thread-Index: AQHYUDaHniIGv7MXOEOkPNkDk7HrO60SBp+AgAg66oA=
Date: Wed, 11 May 2022 19:54:54 +0000
Message-ID: <245F4717-CF83-40BC-BC87-5EB8563E0588@vmware.com>
References: <20220414193316.14356-1-vdasa@vmware.com>
 <87levezr2y.fsf@redhat.com>
In-Reply-To: <87levezr2y.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ef46176-95cf-45ba-d54b-08da33881e58
x-ms-traffictypediagnostic: BL0PR05MB5458:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BL0PR05MB5458735D32A66EA991B4F1FBCEC89@BL0PR05MB5458.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Ro/KCY0zYvWkvogflpjbdkUE6xek9EEWfGIe7kyiQqOLTTW6pyXZstx2djKQywqlWLbLY+OE+scEp6l2Z9hRHvD6KJe6PY2VA5olwHIkoP8VsMHY4FkWTpkO16fSmMtKZngXsVFf/We6LA+9UUSADWORBT/AcJ+CcfSS7Y180wWM+oUgArlbdgkeNU8GWNcG/FhFkIeupLu51uTtx+EPBJxu24vjlql0zi7zumo8EBXByym6PXWDp0lWD7Xuhw6A/8i8BB3E5UEPZ3dYNuuxrczOC3JykR9rv7kr5F5ThXz1Yjqw0GmewJnhJxA3PHGVGWV+q78A4Em+TmxPEvD6fIrGo3sY5QAnjq9IcICoM9wwsDMZBLx0auOLKhD1bRPu2RKIA1hyTZWMRmtOpIz2+o0v1zhc5ep6UGAAauhmWgNt7PcDaSVDN4x6FrnPKUfYT2WFiJvSMvbrBPEemyKKH1LBlk1pu414oizCmTw+OL7bWEChrdOxOkzZgPnlN7XomBSHA+y0HqUuxBH1HWXGKzvaHK1RwQzJ5i25dx8GaMFOUEBU15ukLHUKzIUBh5+8UeMVCMz3M6zhBArb1FIojLhecEMZqGjI+5Jx41qFDD36PF3aW0OUgx6dPvYPC/1cTNsveuyG/Bv56G4x8MFe1c7c25BWzNT0siahAuGgLQbzJ1y+1imyRf4oIFoDWQGMnYQIIvPCIt6ZFleZ+hJgcy1GWJ4xX2VPOGaifpixpWuzDBirID8YG2AgXl2xsGy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR05MB3960.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(2906002)(36756003)(71200400001)(38100700002)(54906003)(508600001)(38070700005)(6916009)(122000001)(6486002)(8936002)(33656002)(316002)(5660300002)(6506007)(86362001)(66556008)(64756008)(66946007)(91956017)(8676002)(4326008)(76116006)(66476007)(186003)(2616005)(558084003)(66446008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4MsL1rF8TgbSDqeO2bkfoAFSeE8pysvKcAWIG3CxwXIHCC/Q9gpYI6fS1vTf?=
 =?us-ascii?Q?FR2dCT5pYlgkytm5dhvdhfQf07BBZqAdKopwWLhbYnxlxZojqLccLWcWd8K0?=
 =?us-ascii?Q?pGOMk7UN3h78gajvz5vU6PW0uaeQAZy1rCYaxOaFi37Zgphv2MJxDpJNlWwr?=
 =?us-ascii?Q?lIc++Y9TQunIBg2BjJAHZvcj5chaOPUF4Ww+BhmqdgoyYVOqSVNBxblkO5ZK?=
 =?us-ascii?Q?eEeMoGhajs3KxIEQGF8qdWS8Pth6oOibRSgS0Af8XheD93qoQPXTLa87Rlqw?=
 =?us-ascii?Q?Wy5ARM8FtY8e08Jx1axnhahWOhB5g6ISa6Y82VKD+Q4brE2hU+9rGGGy/dzC?=
 =?us-ascii?Q?mK5T9EvvAUEn6ThvctVlVPzeKk3DNq3DK1RvAHrHmJ6qiQ6HyTY4ctGvvDdG?=
 =?us-ascii?Q?mgytH31Ma3ezmvDXi2sSfRKsAZ5RcqdyeDSpjSxPqPVCuYVb2pkD2nv93p/3?=
 =?us-ascii?Q?m9A26GP3QXmiTIWpHmHhj+EQKYMzpZhewHFT8jsSNc+xMHawT0o7Tiuyc0tg?=
 =?us-ascii?Q?RJ1ZyJoOA/ZsSaprTLZpxGKjwNyyrC8lhCm4N9l0gEDQtU17mobZsX8hOYPW?=
 =?us-ascii?Q?AyCb+7Njh4V7c6wS8ODXRfWghiR4T52I8lW5R2uRiXkyNk3kie2kHHDs/2TX?=
 =?us-ascii?Q?fKWI9bKJs2VuElztP7jDS9qprlraM2AGL24uXa+T1B+M2JUrdcrLKBzl38Ne?=
 =?us-ascii?Q?EYUlGOKNOCiy5ISMlGYYiYdjXAFCLaAKZRnz+rBWa/cUbE4KXwf3BvUgdX/3?=
 =?us-ascii?Q?IY9UeXurunKHY2Vk91bFil9LGRLLoSge4qL31161a4pWMrxRRk+GWmOpXuuv?=
 =?us-ascii?Q?XBjloVlXTrx+mQspTAvORAsVtlF2GFM/6naIzTqgq6z45TlQ0epIfXK14PmQ?=
 =?us-ascii?Q?iTka7knrKiZEH6y+0WV3VlzQqStSAnw6BXThtBmYNU4OvB66zg8D/LWk3Wnv?=
 =?us-ascii?Q?6yPMcKRxxWo6cwxnaH5MWitinBJym5bKgSY7TYJWFlj59dRK/Gvca/vaPPac?=
 =?us-ascii?Q?KtcRt36tAWfqPhy0owrheTMsZFRxuC/d0o2qJ3YP/W2dqwwn+WXqjh/w80Xz?=
 =?us-ascii?Q?Fe0DGf8F9YpC/QKwVxbSrFANzvkCrU3O6j5giZidAFQSU3dcqkaOUH/+Tn7E?=
 =?us-ascii?Q?wKzf1p99kIx90/d4fRCCLFDVskFHhVpBbL4t/fLt9rgXR3rGSVowMd0X3dH8?=
 =?us-ascii?Q?kuUnpf49PZwYA1OOCgGiXqsZtaHncX7ak0GzdBr4atTXwC8x82V3gKN9/rEt?=
 =?us-ascii?Q?DJ/w0rtLddrmzvj2cLgGToULXIwH0+iQQPVocajjK3p+JvlZlbgVUhkBkt62?=
 =?us-ascii?Q?Nk6RU3GfGxSJNf1AKzA58TKoC8s9f94tlJYS5xk49OVXbTOcub8atk17cfBb?=
 =?us-ascii?Q?KLjJ0P9LSQMUVsRzZtVJ4TSCXrdtm8UhiY5vu0s926BIeKqaohwfZOAIkUGQ?=
 =?us-ascii?Q?6+OAVXDF+IJRAD1OqZGAFMBrAkatY0Tg0rhdUSxI3Yt4Haa1SwiPoi43k3JB?=
 =?us-ascii?Q?rUudGpHjle4pp2yqVZY7JXqkW6KRL3qgZ84ZurApnQzu+MCHOBmlX3/Vxynw?=
 =?us-ascii?Q?fKxX1d62euhjnr0IZqH9QJ0BybAh32ip/bv99X4WU4WSa4cpVtS9i7NT9hwH?=
 =?us-ascii?Q?HsYSRPfz+a6tgxXTG0BbXnvuY2GGlCkgo7t6ixDEGspgsmJx7xEZkzfLKSsq?=
 =?us-ascii?Q?djbRiAmrmC0qSMM5KxSv8sjjuZrUn8Yu/uetLSYsmvnz7GrCZ7+zTpNAEGHd?=
 =?us-ascii?Q?ttyTkwuo+l5v3b0q9XQH0bACsa1BUkx0C3/cygMosQBJgYn+bJ0qwSdwEvTg?=
x-ms-exchange-antispam-messagedata-1: 5+NC0f+OGTx51A==
Content-ID: <D3B57034A7A513498B4CA31FDD986FB0@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef46176-95cf-45ba-d54b-08da33881e58
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 19:54:54.3428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a58uDGoFocTonHse9F2JlU1udtQNhF2G+mDCaC8/D9/ZpROYus6rYwYvlqxKQJa1uOJPEEHxJP4BSZBBJhQtag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB5458
Cc: Pv-drivers <Pv-drivers@vmware.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 linux-kernel-review list <linux-kernel-review@mailman2.vmware.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Bryan Tan <bryantan@vmware.com>,
 Cyprien Laplace <claplace@vmware.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


> FWIW, it seems you're doing three things at once, better split this into
> a 3-patch series.

Thanks for the feedback.  I was debating between the two ways of doing
it and ultimately did it one way.  It is a bit late now to change it as it has
made its way to linux-next already.

Thanks,
Vishnu
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
