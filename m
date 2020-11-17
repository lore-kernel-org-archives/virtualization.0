Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0BEC2D0E4
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 19:41:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 890BB2463B
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 19:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="M5mJlTNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890BB2463B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CC2C786420;
	Tue, 17 Nov 2020 19:41:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TQjxMdscnt-b; Tue, 17 Nov 2020 19:41:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 997948636A;
	Tue, 17 Nov 2020 19:41:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70A4CC0800;
	Tue, 17 Nov 2020 19:41:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C025C07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 19:41:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 97F9A86382
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 19:41:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fBe2SVylzqFn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 19:41:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DD65A8636A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 19:41:11 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fb4274e0001>; Tue, 17 Nov 2020 11:41:02 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 19:41:11 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 17 Nov 2020 19:41:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5JLNGKBMG45L9zkB+IUi/wL/KtMweGcoDMg0qCh7DuTreZBsAb+/4lPtxgwVMmSvLnybAERsQNTjdhB+ibg8SkJ0uPpZ9+aAGGr1XqxypkgANK4VanuKlbohKgtXhht9irT/wIPc5nbZe+FGFqCHlPfGIm4s4NS4Dcp5+MOFadl6wh8GBS4Vc1h3gMecdAcdfG8QOqy1vtIf2pqwWMQNQ9sxw2p2yhj4J6fCUAKazyBKXpyGt91E8YD21Md8tRW1uqP1ka/+bJqQCE9JE6UeCacMOaUbnzJdk8+AbVOH8GnvMlP9ZoeLv1YYQS9H0giVbKUnUOxLmG6xHuphSmIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRXDLlU836JL6Wst/iRa1qpVIa67RLiFh03xVO0oeuk=;
 b=TMmqhvJ0Ydo5uk4S1pFJf0ARBpgqM/TvpZdsy9tL3fLnyB+4awlhOHmANjSLT0OkDgJhM1gWVC3WNxscx7VIyD/n9ytolg1h0904hoD02exhXCok6kaXIauDgr/YyXtWego2SRD4h9xb4H6bykbyYOJEKmEz3B/rWkkKoE5uSEeNHOwWpG//MiCNFFhxe41l2pNF9tliUjqsjwunGmCpVF5dWas+vQ9l/+XJP2jjPQoavvrPgz44sm9MVgCS99fcbzG5YX+E9V8OX92+CEd9gCXzB5Vpzct2vr7hz3uOXCpVLIlTEUQxYGVOw/67MKmJutw02YsVZzxOmgVBR8INsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB4917.namprd12.prod.outlook.com (2603:10b6:a03:1d1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 19:41:10 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::9493:cfdd:5a45:df53]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::9493:cfdd:5a45:df53%7]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 19:41:10 +0000
From: Parav Pandit <parav@nvidia.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: RE: [PATCH 0/7] Introduce vdpa management tool
Thread-Topic: [PATCH 0/7] Introduce vdpa management tool
Thread-Index: AQHWuL6/zQf/qaV5ZkSpuhr8mZ5CmKnKh76AgAI1YkA=
Date: Tue, 17 Nov 2020 19:41:09 +0000
Message-ID: <BY5PR12MB4322C2DC5E9C8250CE2EBEFEDCE20@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201112064005.349268-1-parav@nvidia.com>
 <CAJSP0QXN2VGgKwQ_qL3Fr0dAYDviZcFDgUrE8FhHZwBm9wpBoQ@mail.gmail.com>
In-Reply-To: <CAJSP0QXN2VGgKwQ_qL3Fr0dAYDviZcFDgUrE8FhHZwBm9wpBoQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [49.207.222.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a24b1d1-57b7-4591-a818-08d88b30bbfc
x-ms-traffictypediagnostic: BY5PR12MB4917:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB49177234CBED15780679EC8EDCE20@BY5PR12MB4917.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CQTjYFUa2f+W5jaCmvfAdxBNPz7CVm/czED8XS5amHeFQCr3gSZjj10vsnjTO1mOIrfCb3NG9ZoRlGg5n7NF207VyGna9ruTj6i9Tcgk8vajKb81c3bkwbgD0KkInGSb/MUIccqmDxsjrht7L5ZM39V7Q3jQtroh6U4jWxtE423oXxRo3+uaQ4h22E5r+ivw8gqkpcihwT95fUe5B/Gk3U82Flp5fIjoiQCWeu6dNmaZ4eLf5qVbUVwSyQWu/WynwNPRS6qhNZhTRQoIPKO52oLGhpsqpkrAVj+nwNkO5TTV6JENuG/FJxfagfSVJDXJ7lLE6+A5MmzYufrQE7I3UQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(8676002)(33656002)(4326008)(54906003)(5660300002)(316002)(52536014)(8936002)(86362001)(66446008)(478600001)(64756008)(71200400001)(55236004)(186003)(6916009)(66476007)(76116006)(7696005)(66946007)(66556008)(6506007)(55016002)(26005)(2906002)(9686003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: piRcIhYcXgHRMDhEojQJIJOcm3KzVzcnIrU18b0bEvmzfZnAfu0YiZoLyPJwWZuozXJKrU8aLycBoWceo67t89S4Nh6EK2rBoJFKTPFJ8/PgunmBJ5qUL3XN510E50LCCm384HdMCYpDm2YXibJRywlgfgEA087R/wHDIvxZlHyS0VndVZ+QGzdsnOR00M3nmV9B5OZQqAYBPF3/sQeUxrhop3eXMb0Q2jP58pNurMWWWDBLVXeS2JKIGktkyyxb8duMy5jSbFDOjhP6tqI9qnaPEKZirk7poLxay3zWc4pDcdpAs0zA+vy0evuDo9xUyTgbrnyb8dow/ovsHQzu8PKnrNQFuGE9qftaygf8lTOOgIeJnvLZg1e2lnR3kqBnBVzn1+YrKAMBJitaOGCR416BJA0PXtsoFeX9a01WcIyAcBfE45tXdRsow6Bc8PU7v/Luo4eguhyZK00cA9TGZvqWsZYgcRKNyrqJK8fJs3Ka6mjxM3eKYJKHsctlO8K23v07p1vi4DmhIgyS+expHu7hg2qWWVwtmLZhJ7PyxvnetjRub/flM/OkfBK2xyp/P0xFr7RgGco0wLarIjiqYzwsfDKQ7W+FT4f/F/zhoXCbHS78SEAiPkT4cd5SFzB0T2YTOsm83mR+4Bvq4eP5vA==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a24b1d1-57b7-4591-a818-08d88b30bbfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 19:41:10.0189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yyy/NJX29tco6McAJadytVrIaYM7D57c1lwAiXSKh57hRirXBIqDwzrr5I1pvZ3D4bzZd47itmTZEE2zc+QZ4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4917
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1605642062; bh=JRXDLlU836JL6Wst/iRa1qpVIa67RLiFh03xVO0oeuk=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
 x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
 x-ms-exchange-senderadcheck:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=M5mJlTNUPeTRGOMgwfRD0qQbi2akyYIgY1Pv8nYii5+rlggf+U3VUC82Togm6kNpi
 6L4YmrEoPt3JExWRU6J5GpW0usI+O5dMRppDs0TSrjq6j62O3xt5PPog8GUs8beAvf
 /kX0QvMLyhfgPuKNBhClwN2aMmG8mM1j0snagWvo4dj6yJrdjv9SdFiLvftKcDx786
 4xpNUaVpwwblkbC1my84NbyORrYyAR1AwAmr7wRtRMpHG2loIFXPTmyeg2EXM7Vo3i
 4a1p5/aTTZns3phdY70j2+lGOxLSh3pm+X7hqsQWt86XghxaWrh8uXHV86T6tU6nid
 0FllDfQ8CA5qw==
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eli Cohen <elic@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>
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



> From: Stefan Hajnoczi <stefanha@gmail.com>
> Sent: Monday, November 16, 2020 3:11 PM
> Great! A few questions and comments:
> 
> How are configuration parameters passed in during device creation (e.g.
> MAC address, number of queues)?
During device creation time more parameters to be added.
> 
> Can configuration parameters be changed at runtime (e.g. link up/down)?
> 
For representor eswitch based devices, it is usually controlled through it.
For others, I haven't thought about it. If the device supports it, I believe so.
If multiple vpda devices are created over single VF/PF/SF, virtualizing the link for up/down (not just changing the vdpa config bits) can be a challenge.

> Does the configuration parameter interface distinguish between standard
> and vendor-specific parameters? Are they namespaced to prevent naming
> collisions?
Do you have an example of vendor specific parameters?
Since this tool exposes virtio compliant vdpa devices, I didn't consider any vendor specific params.

> 
> How are software-only parent drivers supported? It's kind of a shame to
> modprobe unconditionally if they won't be used. Does vdpatool have some
> way of requesting loading a parent driver? That way software drivers can be
> loaded on demand.
Well, since each parent or management device registers for it, and their type is same, there isn't a way right not to auto load the module.
This will require user to learn what type of vendor device driver to be loaded, which kinds of defeats the purpose.

> 
> What is the benefit of making it part of iproute2? If there is not a significant
> advantage like sharing code, then I suggest using a separate repository and
> package so vdpatool can be installed separately (e.g. even on AF_VSOCK-
> only guests without Ethernet).
Given that vdpa tool intents to create network specific devices, iproute2 seems a better fit than a own repository.
It mainly uses libmnl.

> 
> Stefan
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
