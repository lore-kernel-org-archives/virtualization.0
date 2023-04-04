Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6140FC7618D
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 07:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E1B3340590;
	Tue,  4 Apr 2023 07:35:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E1B3340590
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=POjr4zg6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HpMlInDpHLdS; Tue,  4 Apr 2023 07:35:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7E9FC40121;
	Tue,  4 Apr 2023 07:35:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E9FC40121
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F52AC0036;
	Tue,  4 Apr 2023 07:35:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87901C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:34:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52D3D40308
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:34:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52D3D40308
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=POjr4zg6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sEa-RVQQ2yDx
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:34:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C170402E5
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::61b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C170402E5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:34:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJM6JimB1/rdH1+B0IwOLJ49WXpvth7rQLyR57LRg3SRuuoRGBH2xImUEtXtQZlR6q3tPZiiRwI1edlSuHvGsTkg/Kv8sGtmbhOV5O3zvgkdZw2W0pD6PscITAINiUPIKEKj56g/dlhftoR18tM3+G7Z1TxhVkLQ5yUyYTTnkVzpdVZWUUhJ00QdDMVX+BfQQbG2/yIpLVN8PUiEnZ6/pKzpYHLsRl/DiTGoMm7teV0lCsYsBbPR3rrJkEIEHqD3qYOa44AriQguuBXobIjeg0F47c5+xZ06u5wXeEXVgorhrY3pqCZ6+iy4IwTbkLR/wFCtAn3FmAdcCDBZNfCM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsMKdhxfEQnYjqvhbQLLZuVZ+tJtM0u3R8mfQVSkmbc=;
 b=F7/Sd/rZ4jeqWKBQBpO/MU1ZuymlKqagA2KNSHtLLbrQJ3PU7LuokLhcfBkxRgEBkYBPqdw5Juh4kFIxMPC5auhAE4vVolpLMBYYXrOs9fh+4fxJ8ZgnxDN443YQZKbuCCr/bdSO/0iEz7y81rslZDDdTSVqIV2JEu5U9WMqAexXKx491tv8KGdRyJugWLOqWZbP1VSIs664wrmeISRT7Q28h0yZsTlyhQi2fydRa61f2XsyTvwpLLnVX8Vp/dJObTHzYsBtrgWL0m7lUmLhsUlSt4UDJOab+EHgkU1g40Met3gMTkHDOJfNWGl6DdFIbWI3ReLnlEGyLd0EBsoAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsMKdhxfEQnYjqvhbQLLZuVZ+tJtM0u3R8mfQVSkmbc=;
 b=POjr4zg6gOevhh+fFQCzqNBh3mh4SXhmxXJIaw/BXlqoDXA5LHZzvvkk8Bajqf20f1gVVHzLRB0x5R5odKkQ5QuCSJATPnHR0nlyJt04xKson4RI02defV089HXAf8ruYL8DMqt8EYe7W/0ui9PC3/kXGaC+TRd5kW5/E1NSyMg=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by DBAPR04MB7238.eurprd04.prod.outlook.com (2603:10a6:10:1aa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 07:34:54 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d%4]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 07:34:54 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH resend 1/2] vdpa/snet: support getting and setting VQ state
Thread-Topic: [PATCH resend 1/2] vdpa/snet: support getting and setting VQ
 state
Thread-Index: AQHZZWIBe5Qp6TTWaUKs4Mm16+1eFq8ZDo8AgAA8M1GAAU25AIAAK+0p
Date: Tue, 4 Apr 2023 07:34:54 +0000
Message-ID: <AM0PR04MB4723EA323FFB308A290725FFD4939@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230402125219.1084754-1-alvaro.karsz@solid-run.com>
 <20230402125219.1084754-2-alvaro.karsz@solid-run.com>
 <CACGkMEuQpJyQNuYTs2TwCc8SmvynbVwqtcZnF2EEzPEBQnpo5w@mail.gmail.com>
 <AM0PR04MB47239379BDB27553EB5D1E30D4929@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <CACGkMEvOcaRB4eUOUy=GzuGnfeba3wWHWFDNdOgxXVbqyX+wkA@mail.gmail.com>
In-Reply-To: <CACGkMEvOcaRB4eUOUy=GzuGnfeba3wWHWFDNdOgxXVbqyX+wkA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|DBAPR04MB7238:EE_
x-ms-office365-filtering-correlation-id: 9c000077-eb51-46d0-824e-08db34df1564
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zdlb+pPfZOmyF9+eRH8uUSrHluWrg2fJ8XfUyRtPTsLZbPI+zaCvXR/Bfjzf29DeCaOhqi21S+u0ShUf5FS91TWQ5BKI+eu54Nix/a/BYMvXWU6/zVpZh1HDguoO2Afyyf7ioRs87x4Ej/Ackyqied6IU/tGUiRPLkMNicDWH+udNFpwBcEFbD7LkKG3yCjVhpDe049G2ebqP76duJPglV6DPcLkp5A5cRisyzf/0TDxdKQmo39k8qVNddccKkk8cSz+wZ4lzzKzi/HPq1i7dqpbVs2eUg1+q2j9d/8TtT8Vt6i8UmkwMHTWryEWldBucfXqeqQFHqzBhbPqJf8GsDIDnWP1jhvscM2cGpYRw2CKWYnHhoQsacxSFKMPZN4TatflYu9JLGHD/qtLKcM0Wnfy2LGAXqP2uM8fZchEAWobnPqHLrnSpEk2HDQY1D4ZTcIjmQNHEvQBSr+mmDSWpCCGzjSEiOSuiZKzkPDbAIUcxKCYxk5EkgwcuD8LtlXcuq+pIqLS1HIxUARIHGawV2VzOnx5jph4R/K8ts2dkJrAe+ewXNjOZ+Pqyxq6vM90MYyRIYYfC+ys2sbUSKE+0wTJdIuCJb3AKF65Ro4Yq7EpcaZMy2A8VJWit8G6lx+I
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(376002)(136003)(396003)(39830400003)(451199021)(55016003)(76116006)(478600001)(8676002)(6916009)(91956017)(66946007)(66476007)(64756008)(66556008)(66446008)(316002)(54906003)(52536014)(8936002)(41300700001)(5660300002)(38100700002)(122000001)(4326008)(186003)(83380400001)(7696005)(6506007)(26005)(44832011)(9686003)(86362001)(2906002)(33656002)(38070700005)(558084003)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l0rWasuuMVcxofvb+1/jaM6TtgkiiQo1YjQqMw9kh0DRBDM92ebB+JHyq+?=
 =?iso-8859-1?Q?r+2i2yLyA57Y1yisCQYPujlT62fWguJjYNFohaS+snO6xJn1z47Dho3HbZ?=
 =?iso-8859-1?Q?w3fic21GdCV0wt8zG4SHD29I0QC/K13Yh9UP45Ww/GqJzp6L0fJWGrIlVz?=
 =?iso-8859-1?Q?O9MJmfBAy53zvOXtvDYBaljGvAV7EOlthLPwsw5H4ojqIFPy3ksjTlbwhU?=
 =?iso-8859-1?Q?7pAzXBaNSuuOGpFHhIaDF6A5DZAkhVsCryUqZSFkFROS95IVZ0kgeEcde/?=
 =?iso-8859-1?Q?nzClX6Rh/dNPs9ggqeZMoKj/HxvtIAVbIh3C82/oxw6JiUjQPRYTQuqlVj?=
 =?iso-8859-1?Q?shvt4KRdmA8nQgFrjSFF8ilw8/fA5ahrVo9chqcnOuYgaFyy4ee4Z5UuOl?=
 =?iso-8859-1?Q?fC/bLajs8MRS9mryQ//yvvZeCQVvHRB5LLAqjzyqo5UcuRxVkEaNeV+80j?=
 =?iso-8859-1?Q?o1A8a0DY2pUT2g0zZJqeA8GcGVZs7rs5Z0uVSIIsQ0vpO9SP/NItmK7OSC?=
 =?iso-8859-1?Q?0w5f9OSULSgltX6+v0lBb9E3vZcFG6ABX9OvjE2fQR5VrIjuKEF/XCgO6X?=
 =?iso-8859-1?Q?o36EMUL9Phs0W8lGKBI/91yoctmeF4ikiypixZbs1BHF0NeAEzw50zxLKr?=
 =?iso-8859-1?Q?7kDk9MlgbTBMANsBxxlwSrjTtF+E3DK9vCGKiYxbKIXt+Cbkqfo8QaixWX?=
 =?iso-8859-1?Q?DU3FzlIqlnBq908wINZl49mHkpIdu7vzmhCmpPZcguOB2g8xF9CPL1PKcM?=
 =?iso-8859-1?Q?xl/4nSlwUecJ6KKO5qBo+QcdcOmb+p/TC2Sb4IFwYTVhWD7Gy/bWTZtc4x?=
 =?iso-8859-1?Q?xU50wspc1kQJ4wbhu0Gj9zdYCehXDSVmgn4oi4ikN2dOHtF6BVCEIZl7cq?=
 =?iso-8859-1?Q?DcRIHnAOysnRqKrXPZQOC9+M8f9HBuFfKxn0F3BLNRmtXN95GrxlgKmyCp?=
 =?iso-8859-1?Q?vCcHGRvGmqfUYHdygEi8Cte7VXxGsCbu8a8PX97wIev+0yzalo6eAJC8wk?=
 =?iso-8859-1?Q?E6tQFWMv0mF9MjXufGyDNlo2y5P74Q7mfa1BI1AnFG10+UDnY7dYvmsDVU?=
 =?iso-8859-1?Q?rFP6M6kfCG6bw+42gpKMGaGtr923KtQ9oFgAujdthcICViolNu4xUH4l80?=
 =?iso-8859-1?Q?5nRYPQ0GBK6+UvBElKFwevZCHjSzF6cekx6mYBzO1ffFOXTIXNMNAEIMno?=
 =?iso-8859-1?Q?76xostq8PW3SKFiVGKm19QgOgVZTU+5txa8M9zqzu7g8wmoummHKhoyQC6?=
 =?iso-8859-1?Q?08DC2mi+Vt7P2EKZMTjz3Spp3lRIQzKN3Q6onMN8xhzpweHYV33WEaszK9?=
 =?iso-8859-1?Q?mxsEDoCdqC32aXIyQ3RPPfuN9M1cckzUAX3rLIcutEf/1NulUJu1HTAB1c?=
 =?iso-8859-1?Q?zSmPMg3R77HS7ujbbEQTYVBHHrdhM9k/K4C8xiKqRxIQHTKo4HBi7y6Z9I?=
 =?iso-8859-1?Q?KmRdJuI76/Qpw5d/X6aH8vMIrxvOzuiTm+8eG58KWfjNgY5Bl/KvO8Z3hX?=
 =?iso-8859-1?Q?4fGvWhrcTXFJz1Ry/1TeaaDpTeOX7G/fx4pKTlJq+3wQcpeAOnE2x53BNF?=
 =?iso-8859-1?Q?3SEPmB8tUJGMD0RWdZFQthiYtSzGZW6RS3kogREfUCOgQ8RtfUFyKcWTdo?=
 =?iso-8859-1?Q?oqOGZdt62e4bNxxUqzNIEYilVp45c4zr1B?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c000077-eb51-46d0-824e-08db34df1564
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 07:34:54.3797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K10St7K0cSZR8W5Nf0Na0V9larUii/1PVM0WdxAH6QbWDGJZoP0NUs86cd1C0veAGqHTObEuomSvrv0MHKQz4yEnL2m8gJehmCzAYAkBWQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7238
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "mst@redhat.com" <mst@redhat.com>
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

> > So it will arrive to the pci subsystem in program order, but the pci subsystem may reorder, right?
> 
> This is not what I read from the above doc. It said "to a particular
> device will arrive in program order".

In this case, I can just remove the wmb and that's it, right?

Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
