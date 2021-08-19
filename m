Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9894EC4338F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 11:43:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FC9A6108B
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 11:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0FC9A6108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA7D44078B;
	Thu, 19 Aug 2021 11:43:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I-SNlJ1PnYVj; Thu, 19 Aug 2021 11:43:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 90B1A40770;
	Thu, 19 Aug 2021 11:43:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 483F3C0010;
	Thu, 19 Aug 2021 11:43:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CD7BC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 11:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4281080F40
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 11:43:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VM8M32uVvd-J
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 11:43:14 +0000 (UTC)
X-Greylist: delayed 00:06:40 by SQLgrey-1.8.0
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 14A1E80F46
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1629373392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04b+NE4w/cLhOZi/S3EFpSodgKUUbHQ/SWtYgCYi4Hk=;
 b=SUwCJYyK1nI8vO60wp4yB2qN6XYg0jL6khiyT6znGqzS4Zc1j6djZbLoptHUNQ0o2R1/6b
 jpODU3XpjcCjSBNmvt7bdjN3ot7Otne52ZbWtmwcj8pHrjtw+jyf7GvEObxboC5qtnQyMJ
 tqUx8gB7cPNefLEEmEW0PzCnTbfL/B4=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2055.outbound.protection.outlook.com [104.47.9.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-27-yeLtHeXlPreNzmDFkygy0g-1; Thu, 19 Aug 2021 13:36:30 +0200
X-MC-Unique: yeLtHeXlPreNzmDFkygy0g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZEpD870zTFDeesr3WPiKX5qdDokXLGBJPsc3iqAussQX/M5XQjaZpFP+DQOc1k2h+ETRa119LZj50JCWkydkQ4oWUwtlh0eh0RPz4pQtPy/13CjCoS40vKrjTzbpadbLwyZiFzLDW/xnYmhxe1jGRwpHqwakJ95XGPe/uLaNgvbRXDb1z1milMONlVmqiL0F0JL/dvEbtyWu+Tz3oJ9d6oaX7ADSyTUn07kO6kuEWCbYroCle2onaUMdyAZuoqiXLc82wtuhmg0KyqCmCuXj2QyQ6fBJv6MGOcImrGDg1iztBVWkidjXaX00sL6LDi90wdD0C6Vu/q9iLrPNBCbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv8ArHVpuKh3DwOdxYZkF2y7SE0mzb8kJhrbRfF08Wo=;
 b=DAOUMjOImoALO9Xl/41JBtObYILrZVK3OnF1tWFdXj3jigmpOYWYlQGW7aFWT/8VOJiIPki8PfepAQeF5hUKbTg/W6cXEngfPF/M+HU2G71HHRQpgKJevWXnFdFmLAocvBMmDpwdJRXaeE6Z4HCF9BCmmG6fF9RenSMat3k8/elqWsvcxMqLwDHgQxOME7iE5MTv6aBiSPUMsTZlMNS5IPZYkcQknSnkD7bSNUkPtOUC8eW8BNTpZ7rzq1nE4XzkWHZsaeUFfZGfoMfD5Pwp17ydyn21cDhz3eX/EAf3ieM22gTUBWRezVICP1IfiOS0xlQvxPjcqfW7gDnSgmq/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com (2603:10a6:208:128::18)
 by AM0PR04MB6866.eurprd04.prod.outlook.com (2603:10a6:208:183::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 11:36:28 +0000
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::3d8a:3492:1e60:36af]) by AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::3d8a:3492:1e60:36af%7]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 11:36:28 +0000
To: Marc Orr <marcorr@google.com>
References: <20210702114820.16712-1-varad.gautam@suse.com>
 <CAA03e5HCdx2sLRqs2jkLDz3z8SB9JhCdxGv7Y6_ER-kMaqHXUg@mail.gmail.com>
 <YRuURERGp8CQ1jAX@suse.de>
 <CAA03e5FTrkLpZ3yr3nBphOW3D+8HF-Wmo4um4MTXum3BR6BMQw@mail.gmail.com>
 <71db10eb-997f-aac1-5d41-3bcbc34c114d@suse.com>
 <CAA03e5H6mM0z5r4knbjHDLS4svLP6WQuhC_5BnSgCyXpRZgqAQ@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH 0/6] Initial x86_64 UEFI support
Message-ID: <ffae117c-4961-c0de-1f17-7092b7bc3d65@suse.com>
Date: Thu, 19 Aug 2021 13:36:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <CAA03e5H6mM0z5r4knbjHDLS4svLP6WQuhC_5BnSgCyXpRZgqAQ@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: PR3P189CA0008.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::13) To AM0PR04MB5650.eurprd04.prod.outlook.com
 (2603:10a6:208:128::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.77.189] (95.90.92.25) by
 PR3P189CA0008.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 11:36:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeb4e5c6-f127-455f-8e4d-08d963059572
X-MS-TrafficTypeDiagnostic: AM0PR04MB6866:
X-Microsoft-Antispam-PRVS: <AM0PR04MB6866B23ABB7C81E5D048E172E0C09@AM0PR04MB6866.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SmE9COcJ+Dv5vtj3xNRxHAH2xouMkuyQlwkiqwhqa+hXcmxTjm1ISdl+xJtn0MMjnGuuF/IT3wEr7iH+UVcqq3no06BSL3x5mkWqJZaYY1Dc1QtNfLsZlkRJkJCqhJekv+yocRUDkH6867WnAC0CHuAS9dKvkb4dNBdFPxG3GL1FJqYcuiOWt5tBAT5HmYV3QGewqe/ln7/pkzZAuQxvJ3ii9C+eeznpW/vCLhXdv8nZoSgTWJCc+Ov7b7F5TcfXHiShkoZZ+k4KqPU8LlBzvFhYArDs0UzW+TiewMyMqPafhrICAE80xNbN3LyU+0b7A/GYxrZer2kLQEyMo4Afn2erVyg044dL+4EpEeZPLRbjchntkl2h2g/C6Uv6Vm3ZnfKUlkLzxuxd8ZtMnYwdKChK1zFdYTrrrAAT8A2UYBVxeMUbFp9B89oza0ORwFQuL3Bz7yEPu8D+V4b8KPqfLot3GDtfSbM53UXJP0mDpuYmS9saOyxDGJ2bfN3PyjtBQEQgT1dlzXFVRHQwWozxclHoYxqvS2eQM//WXyQtQ7nN3RHXNNaOx+/KHLdc7Gjb4jWf5PpE80ZIhUnYAwjkynDL4WJXRwrRH/Q0+WdKNJFxaBHiZdSk6JZPbfbeQxbvHwW96ZiBWZAWVE/o4NCnVx5XjznGy02Ub3HAeef0yXATC672yUXrEOL7xNLg+G9lGRjJ/TZFxpbnIIkklKqaJcieYvX/RYEm3smt8ktnOHsU2//H2ejQY7pTf/VWmEmuOGZohAzTiIuqRBFfEX8nTVdW9rXbLRoEJO2KlmPB5jpR+gGK0Y2BrWpUOQCGjPHJI08yWT7UclStTQ6wqN7vfU6mpAFYLIK9/+lW1r7VJhY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5650.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(83380400001)(316002)(66574015)(86362001)(16576012)(6916009)(966005)(54906003)(8676002)(31696002)(26005)(36756003)(38100700002)(6486002)(478600001)(186003)(66476007)(5660300002)(66556008)(4326008)(44832011)(956004)(2616005)(8936002)(2906002)(7416002)(53546011)(31686004)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wAc9rgdg5cnm9qRirzkO/61f5uWaHIW4brG42mBHruzmofEU6Sf55W6+lQUC?=
 =?us-ascii?Q?sVYqvLZWcFigHllaxBdx55JiP7x3LlE5LDbpqIt9E9kRH7r2H4p1y6mQtfao?=
 =?us-ascii?Q?C2Dh1aDg0Zol9n8RBs9DHoZ+HNPyy6sySSmQBItH3EoGdUL1Qze0osTaGBpo?=
 =?us-ascii?Q?2hU4XOIOGBxlMK3Dewf2zn2tv62SFyYIMMQ2KGaN1g0iHuBARmvckt4Xts3n?=
 =?us-ascii?Q?HXmytf+1t1OtWtR04hvEuyPiDBvFrRtLH8qSIZd+l73hBBRMrhHxiX1BJraU?=
 =?us-ascii?Q?Vm9ow3JDEgUIigrN8eH8gRHHjw6xVz/H/Wq0E5mwGyWs7fLM7LZFH0f/Q8dE?=
 =?us-ascii?Q?v7a0cO8QXf7nqjNjFRrPMybys0BrceNFzKqdaN5nM/0pcWhCfNVRzr+gt40q?=
 =?us-ascii?Q?XT5SF6ayEq3fj6nYU3XjLSqBmyTqM4oWxzyJhvGHEORNsnEdv8GWmbCFMafg?=
 =?us-ascii?Q?fMZUicGoLGz8nH5CZkSw8HgwZId6vvBvOGFVzOYLwYUwrAkJkiJc3geYHrRh?=
 =?us-ascii?Q?cqdAEDwiW73WJ+CfYtHOUNRWhFDsxFvrMuzk5hySzs4fkr52MWwZGmt2WSws?=
 =?us-ascii?Q?AfcS4vylB7ZeUCpub+07lv9N5xQUS3mg4Cxu7TtDxzTgc5t9+9smjXbSocP2?=
 =?us-ascii?Q?p4MtCEXClxcZlISzIYnqvOL63j2Hl6K/+pa9gaEpPBMgXYAE7mhxVZ9tAf7n?=
 =?us-ascii?Q?vqpo/33p/YM87G3cI4r9WolHqVVK50n2cO6ly8so7h+vumWTNWWXdl/ADtcY?=
 =?us-ascii?Q?fmHa/tNNJxNq5uxkmz9yFz6qyTAHlUQ9M8MGf3bHlprCVD5+qaF6HunM+pUx?=
 =?us-ascii?Q?w9Z3N2iIERdV1tNjdeu9jqRsyGdPGtVkFNPgPYhaIq9b8Q3cfJw8eJt48DbP?=
 =?us-ascii?Q?LQfmn5tsfCeWWnezMB7sOiOmbCoWLU3cpvXB721snmif8XiSHiejdU9kGadd?=
 =?us-ascii?Q?1nP5pnoO3Z/Xeyrkh46bWgc/crLImsfB1p/K6q0WapvWOtN7aAsUfIUvznp9?=
 =?us-ascii?Q?ztFcA0N6dIg4iaQKMWyAilc1BgXlzku2pUxhUvMUpp/cK5V2fRFj+r+JeUHC?=
 =?us-ascii?Q?IZMCq2l2zLhUPv8CtoO6UO4PGpkGgFeLV85UUycqc/8JdWWMLrXF2Pocp/ug?=
 =?us-ascii?Q?7Sa/hPafly63w1qu1nsZu+TmcOuiPtdxPie9Hvx1z44D0OOhjjJDtpEdi6Xn?=
 =?us-ascii?Q?vVNFTHVOCrJ51+aNo6tuT/8/aHe4dpqOzrNgWPe9e7gL4IZ1fQ5mFugoyY4y?=
 =?us-ascii?Q?Ppah9NZ25xwroHGsH0X8UWrZMlt0JK7OoKK8qW+N2oWoGPjHnAJKYHGJyHo6?=
 =?us-ascii?Q?W5ymv5g03JLdtgnSuZ+e3aQJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb4e5c6-f127-455f-8e4d-08d963059572
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5650.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 11:36:28.6272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LIhBkiPYbMjEUl32QgDRGEqnpxMtmLHY9XDnv7Vxs7WMljLBK55JyaFteGq4i7jhiIXy0AtcEC/BTul7XdOWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6866
Cc: "Lendacky, Thomas" <thomas.lendacky@amd.com>,
 Andrew Jones <drjones@redhat.com>, Joerg Roedel <jroedel@suse.de>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, kvm list <kvm@vger.kernel.org>,
 Tom Roeder <tmroeder@google.com>,
 "Hyunwook \(Wooky\) Baek" <baekhw@google.com>,
 virtualization@lists.linux-foundation.org, Zixuan Wang <zixuanwang@google.com>,
 Erdem Aktas <erdemaktas@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 bp@suse.de
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
From: Varad Gautam via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Varad Gautam <varad.gautam@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gOC8xOS8yMSAzOjMyIEFNLCBNYXJjIE9yciB3cm90ZToKPiBPbiBXZWQsIEF1ZyAxOCwgMjAy
MSBhdCAxOjM4IEFNIFZhcmFkIEdhdXRhbSA8dmFyYWQuZ2F1dGFtQHN1c2UuY29tPiB3cm90ZToK
Pj4KPj4gSGkgTWFyYywgWml4dWFuLAo+Pgo+PiBPbiA4LzE4LzIxIDM6NTIgQU0sIE1hcmMgT3Jy
IHdyb3RlOgo+Pj4gT24gVHVlLCBBdWcgMTcsIDIwMjEgYXQgMzo0OSBBTSBKb2VyZyBSb2VkZWwg
PGpyb2VkZWxAc3VzZS5kZT4gd3JvdGU6Cj4+Pj4KPj4+PiBIaSBNYXJjLAo+Pj4+Cj4+Pj4gT24g
RnJpLCBBdWcgMTMsIDIwMjEgYXQgMTE6NDQ6MzlBTSAtMDcwMCwgTWFyYyBPcnIgd3JvdGU6Cj4+
Pj4+IFRvIGRhdGUsIHdlIGhhdmUgX21vc3RfIHg4NiB0ZXN0IGNhc2VzICgzOS80NCkgd29ya2lu
ZyB1bmRlciBVRUZJIGFuZAo+Pj4+PiB3ZSd2ZSBhbHNvIGdvdCBzb21lIG9mIHRoZSB0ZXN0IGNh
c2VzIHRvIGJvb3QgdW5kZXIgU0VWLUVTLCB1c2luZyB0aGUKPj4+Pj4gVUVGSSAjVkMgaGFuZGxl
ci4KPj4+Pgo+Pj4+IFdoaWxlIHRoZSBFRkkgQVBQIGFwcHJvYWNoIHNpbXBsaWZpZXMgdGhlIGlt
cGxlbWVudGF0aW9uIGEgbG90LCBJIGRvbid0Cj4+Pj4gdGhpbmsgaXQgaXMgdGhlIGJlc3QgcGF0
aCB0byBTRVYgYW5kIFREWCB0ZXN0aW5nIGZvciBhIGNvdXBsZSBvZgo+Pj4+IHJlYXNvbnM6Cj4+
Pj4KPj4+PiAgICAgICAgIDEpIEl0IGxlYXZlcyB0aGUgZGV0YWlscyBvZiAjVkMvI1ZFIGhhbmRs
aW5nIGFuZCB0aGUgU0VWLUVTCj4+Pj4gICAgICAgICAgICBzcGVjaWZpYyBjb21tdW5pY2F0aW9u
IGNoYW5uZWxzIChHSENCKSB1bmRlciBjb250cm9sIG9mIHRoZQo+Pj4+ICAgICAgICAgICAgZmly
bXdhcmUuIFNvIHdlIGNhbid0IHJlbGlhYmx5IHRlc3QgdGhvc2UgaW50ZXJmYWNlcyBmcm9tIGFu
Cj4+Pj4gICAgICAgICAgICBFRkkgQVBQLgo+Pj4+Cj4+Pj4gICAgICAgICAyKSBTYW1lIGZvciB0
aGUgbWVtb3J5IHZhbGlkYXRpb24vYWNjZXB0YW5jZSBpbnRlcmZhY2UgbmVlZGVkCj4+Pj4gICAg
ICAgICAgICBmb3IgU0VWLVNOUCBhbmQgVERYLiBVc2luZyBhbiBFRkkgQVBQIGxlYXZlcyB0aG9z
ZSB1bmRlcgo+Pj4+ICAgICAgICAgICAgZmlybXdhcmUgY29udHJvbCBhbmQgd2UgYXJlIG5vdCBh
YmxlIHRvIHJlbGlhYmx5IHRlc3QgdGhlbS4KPj4+Pgo+Pj4+ICAgICAgICAgMykgVGhlIElEVCBh
bHNvIHN0YXlzIHVuZGVyIGNvbnRyb2wgb2YgdGhlIGZpcm13YXJlIGluIGFuIEVGSQo+Pj4+ICAg
ICAgICAgICAgQVBQLCBvdGhlcndpc2UgdGhlIGZpcm13YXJlIGNvdWxkbid0IHByb3ZpZGUgYSAj
VkMgaGFuZGxlci4KPj4+PiAgICAgICAgICAgIFRoaXMgbWFrZXMgaXQgdW5yZWxpYWJsZSB0byB0
ZXN0IGFueXRoaW5nIElEVCBvciBJUlEgcmVsYXRlZC4KPj4+Pgo+Pj4+ICAgICAgICAgNCkgUmVs
eWluZyBvbiB0aGUgZmlybXdhcmUgI1ZDIGhhbmxkZXIgbGltaXRzIHRoZSB0ZXN0cyB0byBpdHMK
Pj4+PiAgICAgICAgICAgIGFiaWxpdGllcy4gSW1wbGVtZW50aW5nIGEgc2VwYXJhdGUgI1ZDIGhh
bmRsZXIgcm91dGluZSBmb3IKPj4+PiAgICAgICAgICAgIGt2bS11bml0LXRlc3RzIGlzIG1vcmUg
d29yaywgYnV0IGl0IG1ha2VzIHRlc3QgZGV2ZWxvcG1lbnQKPj4+PiAgICAgICAgICAgIG11Y2gg
bW9yZSBmbGV4aWJsZS4KPj4+Pgo+Pj4+IFNvIGl0IGNvbWVzIGRvd24gdG8gdGhlIGZhY3QgdGhh
dCBhbmQgRUZJIEFQUCBsZWF2ZXMgY29udHJvbCBvdmVyCj4+Pj4gU0VWL1REWCBzcGVjaWZpYyBo
eXBlcnZpc29yIGludGVyZmFjZXMgaW4gdGhlIGZpcm13YXJlLCBtYWtpbmcgaXQgaGFyZAo+Pj4+
IGFuZCB1bnJlbGlhYmxlIHRvIHRlc3QgdGhlc2UgaW50ZXJmYWNlcyBmcm9tIGt2bS11bml0LXRl
c3RzLiBUaGUgc3R1Ygo+Pj4+IGFwcHJvYWNoIG9uIHRoZSBvdGhlciBzaWRlIGdpdmVzIHRoZSB0
ZXN0cyBmdWxsIGNvbnRyb2wgb3ZlciB0aGUgVk0sCj4+Pj4gYWxsb3dpbmcgdG8gdGVzdCBhbGwg
YXNwZWN0cyBvZiB0aGUgZ3Vlc3QtaG9zdCBpbnRlcmZhY2UuCj4+Pgo+Pj4gSSB0aGluayB3ZSBt
aWdodCBiZSB1c2luZyB0ZXJtaW5vbG9neSBkaWZmZXJlbnRseS4gKE1heWJlIEkgbWlzLXVzZWQK
Pj4+IHRoZSB0ZXJtIOKAnEVGSSBhcHDigJ0/KSBXaXRoIG91ciBhcHByb2FjaCwgaXQgaXMgdHJ1
ZSB0aGF0IGFsbAo+Pj4gcHJlLWV4aXN0aW5nIHg4Nl82NCB0ZXN0IGNhc2VzIHdvcmsgb3V0IG9m
IHRoZSBib3ggd2l0aCB0aGUgVUVGSSAjVkMKPj4+IGhhbmRsZXIuIEhvd2V2ZXIsIGJlY2F1c2Ug
a3ZtLXVuaXQtdGVzdHMgY2FsbHMgYEV4aXRCb290U2VydmljZXNgIHRvCj4+PiB0YWtlIGZ1bGwg
Y29udHJvbCBvZiB0aGUgc3lzdGVtIGl0IGV4ZWN1dGVzIGFzIGEg4oCcVUVGSS1zdHViYmVkCj4+
PiBrZXJuZWzigJ0uIFRodXMsIGl0IHNob3VsZCBiZSB0cml2aWFsIGZvciB0ZXN0IGNhc2VzIHRv
IHVwZGF0ZSB0aGUgSURUCj4+PiB0byBzZXQgdXAgYSBjdXN0b20gI1ZDIGhhbmRsZXIgZm9yIHRo
ZSBkdXJhdGlvbiBvZiBhIHRlc3QuIChTb21lIG9mCj4+PiB0aGUgeDg2XzY0IHRlc3QgY2FzZXMg
YWxyZWFkeSBkbyBzb21ldGhpbmcgc2ltaWxhciB3aGVyZSB0aGV5IGluc3RhbGwKPj4+IGEgdGVt
cG9yYXJ5IGV4Y2VwdGlvbiBoYW5kbGVyIGFuZCB0aGVuIHJlc3RvcmUgdGhlIOKAnGRlZmF1bHTi
gJ0KPj4+IGt2bS11bml0LXRlc3RzIGV4Y2VwdGlvbiBoYW5kbGVyLikKPj4+Cj4+PiBJbiBnZW5l
cmFsLCBvdXIgYXBwcm9hY2ggaXMgdG8gc2V0IHVwIHRoZSB0ZXN0IGNhc2VzIHRvIHJ1biB3aXRo
IHRoZQo+Pj4ga3ZtLXVuaXQtdGVzdHMgY29uZmlndXJhdGlvbiAoZS5nLiwgSURULCBHRFQpLiBU
aGUgb25lIGV4Y2VwdGlvbiBpcwo+Pj4gdGhlICNWQyBoYW5kbGVyLiBIb3dldmVyLCBhbGwgb2Yg
dGhpcyBzdGF0ZSBjYW4gYmUgb3ZlcnJpZGRlbiB3aXRoaW4gYQo+Pj4gdGVzdCBhcyBuZWVkZWQu
Cj4+Pgo+Pj4gWml4dWFuIGp1c3QgcG9zdGVkIHRoZSBwYXRjaGVzLiBTbyBob3BlZnVsbHkgdGhl
eSBtYWtlIHRoaW5ncyBtb3JlIGNsZWFyLgo+Pj4KPj4KPj4gTm9tZW5jbGF0dXJlIGFzaWRlLCBJ
IGJlbGlldmUgWml4dWFuJ3MgcGF0Y2hzZXQgWzFdIHRha2VzIHRoZSBzYW1lIGFwcHJvYWNoCj4+
IGFzIEkgcG9zdGVkIGhlcmUuIEluIHRoZSBlbmQsIHdlIG5lZWQgdG86Cj4+IC0gYnVpbGQgdGhl
IHRlc3RjYXNlcyBhcyBFTEYgc2hhcmVkIG9ianMgYW5kIGxpbmsgdGhlbSB0byBsb29rIGxpa2Ug
YSBQRQo+PiAtIHN3aXRjaCBhd2F5IGZyb20gVUVGSSBHRFQvSURUL3BhZ2V0YWJsZSBzdGF0ZXMg
b24gZWFybHkgYm9vdCB0byB3aGF0Cj4+ICAga3ZtLXVuaXQtdGVzdHMgbmVlZHMKPj4gLSBtb2Rp
ZnkgdGhlIHRlc3RjYXNlcyB0aGF0IGNvbnRhaW4gbm9uLVBJQyBhc20gc3R1YnMgdG8gYWxsb3cg
YnVpbGRpbmcKPj4gICB0aGVtIGFzIHNoYXJlZCBvYmpzCj4+Cj4+IEkgd2VudCB3aXRoIGF2b2lk
aW5nIHRvIGJyaW5nIGluIGdudS1lZmkgb2JqZWN0cyBpbnRvIGt2bS11bml0LXRlc3RzCj4+IGZv
ciBFRkkgaGVscGVycywgYW5kIGRpc2FibGluZyB0aGUgbm9uLVBJQyB0ZXN0Y2FzZXMgZm9yIHRo
ZSBSRkMncyBzYWtlLgo+Pgo+PiBJJ2xsIHRyeSBvdXQgIng4NiBVRUZJOiBDb252ZXJ0IHg4NiB0
ZXN0IGNhc2VzIHRvIFBJQyIgWzJdIGZyb20gWml4dWFuJ3MKPj4gcGF0Y2hzZXQgd2l0aCBteSBz
ZXJpZXMgYW5kIHNlZSB3aGF0IGJyZWFrcy4gSSB0aGluayB3ZSBjYW4gY29tYmluZQo+PiB0aGUg
dHdvIHBhdGNoc2V0cy4KPj4KPj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMTA4
MTgwMDA5MDUuMTExMTIyNi0xLXppeHVhbndhbmdAZ29vZ2xlLmNvbS8KPj4gWzJdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3IvMjAyMTA4MTgwMDA5MDUuMTExMTIyNi0xMC16aXh1YW53YW5nQGdv
b2dsZS5jb20vCj4gCj4gVGhpcyBzb3VuZHMgZ3JlYXQgdG8gdXMuIFdlIHdpbGwgYWxzbyBleHBl
cmltZW50IHdpdGggY29tYmluaW5nIHRoZQo+IHR3byBwYXRjaHNldHMgYW5kIHJlcG9ydCBiYWNr
IHdoZW4gd2UgaGF2ZSBzb21lIGV4cGVyaWVuY2Ugd2l0aCB0aGlzLgo+IFRob3VnaCwgcGxlYXNl
IGRvIGFsc28gcmVwb3J0IGJhY2sgaWYgeW91IGhhdmUgYW4gdXBkYXRlIG9uIHRoaXMKPiBiZWZv
cmUgd2UgZG8uCj4gCgpJIHNlbnQgb3V0IGEgdjIgWzFdIHdpdGggWml4dWFuJ3MgIng4NiBVRUZJ
OiBDb252ZXJ0IHg4NiB0ZXN0IGNhc2VzIHRvIFBJQyIgWzJdCnB1bGxlZCBpbiwgUFRBTC4KClsx
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjEwODE5MTEzNDAwLjI2NTE2LTEtdmFyYWQu
Z2F1dGFtQHN1c2UuY29tLwpbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIxMDgxODAw
MDkwNS4xMTExMjI2LTEwLXppeHVhbndhbmdAZ29vZ2xlLmNvbS8KClRoYW5rcywKVmFyYWQKCj4g
VGhhbmtzLAo+IE1hcmMKPiAKCi0tIApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdt
YkgKTWF4ZmVsZHN0ci4gNQo5MDQwOSBOw7xybmJlcmcKR2VybWFueQoKSFJCIDM2ODA5LCBBRyBO
w7xybmJlcmcKR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
