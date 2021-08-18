Return-Path: <SRS0=8Uya=NJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CC4C4338F
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 08:40:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F17756109E
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 08:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F17756109E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACA8140272;
	Wed, 18 Aug 2021 08:40:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wXhGZ9tzgFWL; Wed, 18 Aug 2021 08:40:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8D306402EA;
	Wed, 18 Aug 2021 08:40:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B2C4C000E;
	Wed, 18 Aug 2021 08:40:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57996C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 08:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 454CB40205
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 08:40:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8sbhzp0OzQwc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 08:40:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2DDF40019
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 08:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1629276000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kc51P4XEcqU0++0IhQwKDIQV7isn4FEOhxnak9DGNjs=;
 b=jH3RqGZEftmZBSAqZ9NlIMmI3ZQqFIQ3VehCu1O71IBKFElqUWFiDfsvepDpEIs49dQdt7
 UclBQG2KudpuJOryWHsU2nFL38ir9xfPE3gxhnOGFsW1VqbxL2rFxtaTvjMfRqOPip/kMO
 rE3TzDJk/LHUGp9VBld1NcntppCf+nI=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2056.outbound.protection.outlook.com [104.47.0.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-25-h-ybBG7fOw2NbtBPQIKtMA-1; Wed, 18 Aug 2021 10:38:29 +0200
X-MC-Unique: h-ybBG7fOw2NbtBPQIKtMA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvbNF62EOTZLbO/QA/aBYfMvnnNNI2hjH5dcjw10aLvTRMvXrXq7oSEXCXFaJ4HLn1x2U9nVUyHlRJIV6pE3w2rUwZ1Ir2N6rM4LHwzkt+VWsVX4II5OYNpnLFtMso8khggL3mBD1oJevgwhrYhyBmoiHXJ4X5yjzDb46FiEIBzd9UqJDOPQ1LpktBB0Kpn+5yylRWTynbjv37EdgWtRqODvFL3yJHgVktjw+0BlnDnQpHAPuWNVUnQw+jxLy5mF0dm/toHXjFgOlh1DZPVeA9Ty90GERNqIxpmi3bY6Ckx6dbhVUtdAwEL4cqGTk6+vXnbC1JbPWF9PgRXMvRO5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gh4MX63R/yo4LpmqPBaKc+1Ly4DCddWJx5tiT7KnSQg=;
 b=IYyo5SbuOtck09MogFj77ex1X/aNut+wiHGvNH7UrCFSBRcfCVqPE1rWqKUFGreLxNIFCN4SXIZ9UMtjBDYiDGcjrJn799xG+RaQDaajjID8EKdOGAw0UfiYoqlkB6VxQJK56+0dEOO88iR9S+hrFsznTrrUfAV4DWPffSxNCCt5ZDd9GXT8B8y0VLMx+dkUPxkiXIcpYhzmggMjKObb148YwXoAEd7INOUCCHsaOOEwBmVZR8cEDumB/GhBrsmzzYN6LkvCGegAGP49i6eZhB4ycYlPG2/6KUa3n3wOFjrTeFBFf6B6W3xRfA9q5XLZEDccIRk1HjOA6SjvkGBw6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com (2603:10a6:208:128::18)
 by AM0PR04MB4833.eurprd04.prod.outlook.com (2603:10a6:208:c2::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.24; Wed, 18 Aug
 2021 08:38:27 +0000
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::3d8a:3492:1e60:36af]) by AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::3d8a:3492:1e60:36af%7]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 08:38:26 +0000
To: Marc Orr <marcorr@google.com>, Joerg Roedel <jroedel@suse.de>
References: <20210702114820.16712-1-varad.gautam@suse.com>
 <CAA03e5HCdx2sLRqs2jkLDz3z8SB9JhCdxGv7Y6_ER-kMaqHXUg@mail.gmail.com>
 <YRuURERGp8CQ1jAX@suse.de>
 <CAA03e5FTrkLpZ3yr3nBphOW3D+8HF-Wmo4um4MTXum3BR6BMQw@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH 0/6] Initial x86_64 UEFI support
Message-ID: <71db10eb-997f-aac1-5d41-3bcbc34c114d@suse.com>
Date: Wed, 18 Aug 2021 10:38:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <CAA03e5FTrkLpZ3yr3nBphOW3D+8HF-Wmo4um4MTXum3BR6BMQw@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0183.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::27) To AM0PR04MB5650.eurprd04.prod.outlook.com
 (2603:10a6:208:128::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.77.69] (95.90.166.153) by
 PR0P264CA0183.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 08:38:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7b0e84b-0d1b-4cc9-7310-08d962238c55
X-MS-TrafficTypeDiagnostic: AM0PR04MB4833:
X-Microsoft-Antispam-PRVS: <AM0PR04MB4833979DB1014D9FBE228B3BE0FF9@AM0PR04MB4833.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Fbgdr+OKMLXG+qtLIsquV2kpY+6YpX5bymsd+1owh+Q8QrysPhQT6aopsXGhYYjTsE9CJlLaC7APlF6yQBbqimC14Ioah9+7L7COwyHzfZAmsHZL9Asdlj1B445p21yjvLhWOfaeq74TzXEahBq02eGOG9td2jvgSr/i0Emu014t+zpxl9EnchM4Q5ropNQ9DuG0Fj4JHyCLrAIFRHPAjw2DovUedRrtIT5gtvFUmc+Y32A26JW86LaanlIzembYdVPR7MWcV6S+U8Dw3gYWB5JXU06OG9Khmbx+oeyyk6D6H8KWQD6nD3Eyl80d5laxe9VyP0TFKUEAMK29ANRadzcZNEydV7Olgqzr/iG8p5sZr+aOeQlMW+gpZlGON7VY9R7W242F3TtZnVNJF1aJVre9gvVMSCZNnBxnl011+yOwkrblp00xISLAEPZz4G7MhTgXBo3DHIHt27F2OLJg/qdPrHfENnvVQUq91ayCSIIVTUwqYv1xILiI0OYiZHGBlQ8WNnP2ztLXJfRcuzeC8cOM2vfZcxc5z/BW6waJdtLqizs3IL49SztnNSaaBLN146ReSsk3dWssqqSNj9pA4m16Pd3lJCxKgI52PAN9n+WQyD0fbAJGSdszFeGBdRDDy7jLaYwOuyJ9/tIRQ+Hms3CD/UVpSaG+cVXdiH/kCsG+cYK23vgg+J6dPK/PGWjmVx2h+ojXgNl4QmJLsgwVa6Aytyqucl6R/AzODcsZ7zil0yuExlAhqQGe7ox5svBuvqh5KyzNJxGln4zxAOw3ukt98BTTWk5vV0c26oCJV/L/my+Opifph811sBeiJsNQkOS4qMM/46YbHLuQH+Tkf3w2DgPQvgrpTns/qFnR4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5650.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66946007)(66556008)(966005)(508600001)(66476007)(53546011)(31686004)(36756003)(8936002)(2906002)(54906003)(26005)(5660300002)(316002)(110136005)(16576012)(31696002)(86362001)(6486002)(956004)(8676002)(4326008)(66574015)(7416002)(44832011)(38100700002)(186003)(83380400001)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PJCeMXbT6OKCE3XD7n2j1Bx6PEor682ofoQzZTG93dDs2QMOk//3mUL13ijV?=
 =?us-ascii?Q?WRAlIvFgRQmZ7X3nyA4F8qV98dXFYNjB2ilnzZiaIVySD02IV+iVX5eyBUXZ?=
 =?us-ascii?Q?WiEAbFoDccNgX9ULtuO+3A9lq0c6Urxfx0phE7Nl9NhyO0YxdgX1hDevrJQl?=
 =?us-ascii?Q?ykWHcCQjbAzvM2cfu8KVC9tMb7GhFWwTU637IYfvt9SinQqDLAHo0tDraRzW?=
 =?us-ascii?Q?0YG2KK3rwxdjklKuiI/+9xEP3TYc76uWiVyQKVR2WiJk6XHCNwdbvNWu1pgi?=
 =?us-ascii?Q?G/U7Gx5vKCLx18cYoYWgxSFFdhWd3cxMKghCA0Knl8eSKuFrrJbMYu6bi5fP?=
 =?us-ascii?Q?5eNyn0E4KBHgHK39Oy5GHLsWcoNbFl4uGwQDkWYRb+ykR2w7k9xXho+3ZtcR?=
 =?us-ascii?Q?9ULG80J+MFSbVt1XrIWgmGAWrLLcONJTI3OluwSPdGHqN+nQ/plCZq4SHnYU?=
 =?us-ascii?Q?3XWLusvEmMtmVQyrZftgE+hMgjNsgZOASj514hnmJAxkS28TxN4EVjU1BLsr?=
 =?us-ascii?Q?7cuL8fL1Wu/yoq4BrkA0hQh31MSSB54lxVLEOMP76rw90FdZL8KxUTY15t4H?=
 =?us-ascii?Q?K7wx0pt/Q1S5AhaHM83+UPPy6sNFkZmeAD3ouXZFNp565MQH/QaJ7jVrz7md?=
 =?us-ascii?Q?h2USier4SHBUe5NHmv3N08qtcc32/qi8C0Suz2c3uHnPIa9dwrugDBcOUL/e?=
 =?us-ascii?Q?A5irGXdrHhBb111WdbD0GJR8fCO5ubOYQLaYgN5CtQjkoJzoVmkLIFaBXlyG?=
 =?us-ascii?Q?EiM68atAxfrYA2TL86xqnSuoyufvs1vwf7WczLjzCuPYISmcYu3Dn37Rsuec?=
 =?us-ascii?Q?6dgzsBPsSowczX0tuLOPi8Su23KdM0KRlA9NOduD3HKtl87IFbUolliJERU7?=
 =?us-ascii?Q?2h732VDu7NuIWVWH4oBxrgtEMHwFfCoKq8kRBwzWfZsam5nnepB911LH/6Hn?=
 =?us-ascii?Q?fp3AcbIpz6UaTUt+el4nZtN1oC8kdNWqGX8u98DKy+nWUwYnZGATOLD9NLo5?=
 =?us-ascii?Q?/+65bPE1EHndS8Ag7slUi+YZa3GYinxGmHBhqgQXmJRfWHCaIJfxer6h5ihI?=
 =?us-ascii?Q?51dfoxkedM9hDBIAMEc1XbAkwJz7TCAsVJ35xDW6vGfgKLaAyceWagqVosqC?=
 =?us-ascii?Q?XnbNu0pPTShBHexlvfiUR6lPZLYdxdKogqyBW1m4EyQuyB3Ug4IHXXH4oUz+?=
 =?us-ascii?Q?E52cf95Hzvp7jCOKvHG17PizFnWgZhsDRCFvs5z2kFYLe7tJQNVYWwdwOUa8?=
 =?us-ascii?Q?gUcmZcTKGabP04OJ1ZDWtldcKls5xwyw2Y2rvidj0/o/YPG2L96ZAjd6RLeT?=
 =?us-ascii?Q?zkv0v1rfvtSZMeTQPtVnUc62?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b0e84b-0d1b-4cc9-7310-08d962238c55
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5650.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 08:38:26.8732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQ0r/iEVbp+cHj91cpMs5u7m+lkDWMmyoYsQCdpAYfgq0yffVhS3LArLYq3/9DoqWeM92s72GlbTrK4HP4NAvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4833
Cc: "Lendacky, Thomas" <thomas.lendacky@amd.com>,
 Andrew Jones <drjones@redhat.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 kvm list <kvm@vger.kernel.org>, Tom Roeder <tmroeder@google.com>,
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

SGkgTWFyYywgWml4dWFuLAoKT24gOC8xOC8yMSAzOjUyIEFNLCBNYXJjIE9yciB3cm90ZToKPiBP
biBUdWUsIEF1ZyAxNywgMjAyMSBhdCAzOjQ5IEFNIEpvZXJnIFJvZWRlbCA8anJvZWRlbEBzdXNl
LmRlPiB3cm90ZToKPj4KPj4gSGkgTWFyYywKPj4KPj4gT24gRnJpLCBBdWcgMTMsIDIwMjEgYXQg
MTE6NDQ6MzlBTSAtMDcwMCwgTWFyYyBPcnIgd3JvdGU6Cj4+PiBUbyBkYXRlLCB3ZSBoYXZlIF9t
b3N0XyB4ODYgdGVzdCBjYXNlcyAoMzkvNDQpIHdvcmtpbmcgdW5kZXIgVUVGSSBhbmQKPj4+IHdl
J3ZlIGFsc28gZ290IHNvbWUgb2YgdGhlIHRlc3QgY2FzZXMgdG8gYm9vdCB1bmRlciBTRVYtRVMs
IHVzaW5nIHRoZQo+Pj4gVUVGSSAjVkMgaGFuZGxlci4KPj4KPj4gV2hpbGUgdGhlIEVGSSBBUFAg
YXBwcm9hY2ggc2ltcGxpZmllcyB0aGUgaW1wbGVtZW50YXRpb24gYSBsb3QsIEkgZG9uJ3QKPj4g
dGhpbmsgaXQgaXMgdGhlIGJlc3QgcGF0aCB0byBTRVYgYW5kIFREWCB0ZXN0aW5nIGZvciBhIGNv
dXBsZSBvZgo+PiByZWFzb25zOgo+Pgo+PiAgICAgICAgIDEpIEl0IGxlYXZlcyB0aGUgZGV0YWls
cyBvZiAjVkMvI1ZFIGhhbmRsaW5nIGFuZCB0aGUgU0VWLUVTCj4+ICAgICAgICAgICAgc3BlY2lm
aWMgY29tbXVuaWNhdGlvbiBjaGFubmVscyAoR0hDQikgdW5kZXIgY29udHJvbCBvZiB0aGUKPj4g
ICAgICAgICAgICBmaXJtd2FyZS4gU28gd2UgY2FuJ3QgcmVsaWFibHkgdGVzdCB0aG9zZSBpbnRl
cmZhY2VzIGZyb20gYW4KPj4gICAgICAgICAgICBFRkkgQVBQLgo+Pgo+PiAgICAgICAgIDIpIFNh
bWUgZm9yIHRoZSBtZW1vcnkgdmFsaWRhdGlvbi9hY2NlcHRhbmNlIGludGVyZmFjZSBuZWVkZWQK
Pj4gICAgICAgICAgICBmb3IgU0VWLVNOUCBhbmQgVERYLiBVc2luZyBhbiBFRkkgQVBQIGxlYXZl
cyB0aG9zZSB1bmRlcgo+PiAgICAgICAgICAgIGZpcm13YXJlIGNvbnRyb2wgYW5kIHdlIGFyZSBu
b3QgYWJsZSB0byByZWxpYWJseSB0ZXN0IHRoZW0uCj4+Cj4+ICAgICAgICAgMykgVGhlIElEVCBh
bHNvIHN0YXlzIHVuZGVyIGNvbnRyb2wgb2YgdGhlIGZpcm13YXJlIGluIGFuIEVGSQo+PiAgICAg
ICAgICAgIEFQUCwgb3RoZXJ3aXNlIHRoZSBmaXJtd2FyZSBjb3VsZG4ndCBwcm92aWRlIGEgI1ZD
IGhhbmRsZXIuCj4+ICAgICAgICAgICAgVGhpcyBtYWtlcyBpdCB1bnJlbGlhYmxlIHRvIHRlc3Qg
YW55dGhpbmcgSURUIG9yIElSUSByZWxhdGVkLgo+Pgo+PiAgICAgICAgIDQpIFJlbHlpbmcgb24g
dGhlIGZpcm13YXJlICNWQyBoYW5sZGVyIGxpbWl0cyB0aGUgdGVzdHMgdG8gaXRzCj4+ICAgICAg
ICAgICAgYWJpbGl0aWVzLiBJbXBsZW1lbnRpbmcgYSBzZXBhcmF0ZSAjVkMgaGFuZGxlciByb3V0
aW5lIGZvcgo+PiAgICAgICAgICAgIGt2bS11bml0LXRlc3RzIGlzIG1vcmUgd29yaywgYnV0IGl0
IG1ha2VzIHRlc3QgZGV2ZWxvcG1lbnQKPj4gICAgICAgICAgICBtdWNoIG1vcmUgZmxleGlibGUu
Cj4+Cj4+IFNvIGl0IGNvbWVzIGRvd24gdG8gdGhlIGZhY3QgdGhhdCBhbmQgRUZJIEFQUCBsZWF2
ZXMgY29udHJvbCBvdmVyCj4+IFNFVi9URFggc3BlY2lmaWMgaHlwZXJ2aXNvciBpbnRlcmZhY2Vz
IGluIHRoZSBmaXJtd2FyZSwgbWFraW5nIGl0IGhhcmQKPj4gYW5kIHVucmVsaWFibGUgdG8gdGVz
dCB0aGVzZSBpbnRlcmZhY2VzIGZyb20ga3ZtLXVuaXQtdGVzdHMuIFRoZSBzdHViCj4+IGFwcHJv
YWNoIG9uIHRoZSBvdGhlciBzaWRlIGdpdmVzIHRoZSB0ZXN0cyBmdWxsIGNvbnRyb2wgb3ZlciB0
aGUgVk0sCj4+IGFsbG93aW5nIHRvIHRlc3QgYWxsIGFzcGVjdHMgb2YgdGhlIGd1ZXN0LWhvc3Qg
aW50ZXJmYWNlLgo+IAo+IEkgdGhpbmsgd2UgbWlnaHQgYmUgdXNpbmcgdGVybWlub2xvZ3kgZGlm
ZmVyZW50bHkuIChNYXliZSBJIG1pcy11c2VkCj4gdGhlIHRlcm0g4oCcRUZJIGFwcOKAnT8pIFdp
dGggb3VyIGFwcHJvYWNoLCBpdCBpcyB0cnVlIHRoYXQgYWxsCj4gcHJlLWV4aXN0aW5nIHg4Nl82
NCB0ZXN0IGNhc2VzIHdvcmsgb3V0IG9mIHRoZSBib3ggd2l0aCB0aGUgVUVGSSAjVkMKPiBoYW5k
bGVyLiBIb3dldmVyLCBiZWNhdXNlIGt2bS11bml0LXRlc3RzIGNhbGxzIGBFeGl0Qm9vdFNlcnZp
Y2VzYCB0bwo+IHRha2UgZnVsbCBjb250cm9sIG9mIHRoZSBzeXN0ZW0gaXQgZXhlY3V0ZXMgYXMg
YSDigJxVRUZJLXN0dWJiZWQKPiBrZXJuZWzigJ0uIFRodXMsIGl0IHNob3VsZCBiZSB0cml2aWFs
IGZvciB0ZXN0IGNhc2VzIHRvIHVwZGF0ZSB0aGUgSURUCj4gdG8gc2V0IHVwIGEgY3VzdG9tICNW
QyBoYW5kbGVyIGZvciB0aGUgZHVyYXRpb24gb2YgYSB0ZXN0LiAoU29tZSBvZgo+IHRoZSB4ODZf
NjQgdGVzdCBjYXNlcyBhbHJlYWR5IGRvIHNvbWV0aGluZyBzaW1pbGFyIHdoZXJlIHRoZXkgaW5z
dGFsbAo+IGEgdGVtcG9yYXJ5IGV4Y2VwdGlvbiBoYW5kbGVyIGFuZCB0aGVuIHJlc3RvcmUgdGhl
IOKAnGRlZmF1bHTigJ0KPiBrdm0tdW5pdC10ZXN0cyBleGNlcHRpb24gaGFuZGxlci4pCj4gCj4g
SW4gZ2VuZXJhbCwgb3VyIGFwcHJvYWNoIGlzIHRvIHNldCB1cCB0aGUgdGVzdCBjYXNlcyB0byBy
dW4gd2l0aCB0aGUKPiBrdm0tdW5pdC10ZXN0cyBjb25maWd1cmF0aW9uIChlLmcuLCBJRFQsIEdE
VCkuIFRoZSBvbmUgZXhjZXB0aW9uIGlzCj4gdGhlICNWQyBoYW5kbGVyLiBIb3dldmVyLCBhbGwg
b2YgdGhpcyBzdGF0ZSBjYW4gYmUgb3ZlcnJpZGRlbiB3aXRoaW4gYQo+IHRlc3QgYXMgbmVlZGVk
Lgo+IAo+IFppeHVhbiBqdXN0IHBvc3RlZCB0aGUgcGF0Y2hlcy4gU28gaG9wZWZ1bGx5IHRoZXkg
bWFrZSB0aGluZ3MgbW9yZSBjbGVhci4KPiAKCk5vbWVuY2xhdHVyZSBhc2lkZSwgSSBiZWxpZXZl
IFppeHVhbidzIHBhdGNoc2V0IFsxXSB0YWtlcyB0aGUgc2FtZSBhcHByb2FjaAphcyBJIHBvc3Rl
ZCBoZXJlLiBJbiB0aGUgZW5kLCB3ZSBuZWVkIHRvOgotIGJ1aWxkIHRoZSB0ZXN0Y2FzZXMgYXMg
RUxGIHNoYXJlZCBvYmpzIGFuZCBsaW5rIHRoZW0gdG8gbG9vayBsaWtlIGEgUEUKLSBzd2l0Y2gg
YXdheSBmcm9tIFVFRkkgR0RUL0lEVC9wYWdldGFibGUgc3RhdGVzIG9uIGVhcmx5IGJvb3QgdG8g
d2hhdAogIGt2bS11bml0LXRlc3RzIG5lZWRzCi0gbW9kaWZ5IHRoZSB0ZXN0Y2FzZXMgdGhhdCBj
b250YWluIG5vbi1QSUMgYXNtIHN0dWJzIHRvIGFsbG93IGJ1aWxkaW5nCiAgdGhlbSBhcyBzaGFy
ZWQgb2JqcwoKSSB3ZW50IHdpdGggYXZvaWRpbmcgdG8gYnJpbmcgaW4gZ251LWVmaSBvYmplY3Rz
IGludG8ga3ZtLXVuaXQtdGVzdHMKZm9yIEVGSSBoZWxwZXJzLCBhbmQgZGlzYWJsaW5nIHRoZSBu
b24tUElDIHRlc3RjYXNlcyBmb3IgdGhlIFJGQydzIHNha2UuCgpJJ2xsIHRyeSBvdXQgIng4NiBV
RUZJOiBDb252ZXJ0IHg4NiB0ZXN0IGNhc2VzIHRvIFBJQyIgWzJdIGZyb20gWml4dWFuJ3MKcGF0
Y2hzZXQgd2l0aCBteSBzZXJpZXMgYW5kIHNlZSB3aGF0IGJyZWFrcy4gSSB0aGluayB3ZSBjYW4g
Y29tYmluZQp0aGUgdHdvIHBhdGNoc2V0cy4KClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
LzIwMjEwODE4MDAwOTA1LjExMTEyMjYtMS16aXh1YW53YW5nQGdvb2dsZS5jb20vClsyXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjEwODE4MDAwOTA1LjExMTEyMjYtMTAteml4dWFud2Fu
Z0Bnb29nbGUuY29tLwoKVGhhbmtzLApWYXJhZAoKPiBUaGFua3MsCj4gTWFyYwo+IAoKLS0gClNV
U0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSApNYXhmZWxkc3RyLiA1CjkwNDA5IE7D
vHJuYmVyZwpHZXJtYW55CgpIUkIgMzY4MDksIEFHIE7DvHJuYmVyZwpHZXNjaMOkZnRzZsO8aHJl
cjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
