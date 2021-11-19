Return-Path: <SRS0=gSim=QG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C09C433F5
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 03:09:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C239661026
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 03:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C239661026
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86E96403CE;
	Fri, 19 Nov 2021 03:09:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id joU8X10CXS9t; Fri, 19 Nov 2021 03:09:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 15E9F403D4;
	Fri, 19 Nov 2021 03:09:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D65DDC001E;
	Fri, 19 Nov 2021 03:09:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA97AC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 03:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BBB7B615EE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 03:09:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t2Ll9F6anPSP
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 03:09:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2042.outbound.protection.outlook.com [40.107.101.42])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 985EF60664
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 03:09:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=am6TeTXl+Bcp1pKI6aidCsCY0PPVN9Pb4Cct9kp+yvYGHHJzLZIsDKEc/BP/FCyNYUSiKjyYqX5qVo0J18O2w9np7jsS2tPXmQDfs5nYS4XtJbYRd1v5fnNckTsL66Q9m5OTIOkfnaEQvxCAt23FjeF2LQSQ+WBAWshkEYzMzKxej13Qzgx/mSY5ujcwx4SeOetRhTMHZNRB0MXqT/meEL6zp0YYxC2gQBOcFa2G12wjdsSc0EHgcKYdfJrItMOWSlMWxDuO3IifxSxJpZLCWuGN2jyIujmKRxfFNYxqyIGr23HqaUukbD4fQZ/mN9raiitgdb0i094J1nG2YfNBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+9+TGIBGNTr2WM6HGExn6kAep1fc9kvhlBkdLYODIk=;
 b=VoBZx2ehW7vilpXyWvCXxLCg/iZWf1T3CyuX1nx61CY8Wuub8r3Kc/DMjOrAdkcu3ROJNnAtfZai1+Mqim7cNRGMde9EfrCh3T2WU9o7dF2lXdcKdKLYGy6VJ7WJv3lRY/rJOXzX/vBoBqEnoRO26EH07gAFZmA39V0TGybJQ9/mrZaoKWC1avjd4TZYGXwopTLI38zQMAUNxtxaBbWmTag9ix9JvUlxGvoKKE9E431kWsrEJHUS0qUMvgtiSBVA2fcwfPOntOQC70DXHFT0qVkfcIsXjKhLnIh5GzE28yLwPBRT8zjA/mEFeB4Nr78oWFgsRz9SqHX5oxds1CGH0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+9+TGIBGNTr2WM6HGExn6kAep1fc9kvhlBkdLYODIk=;
 b=XJgAU1ouzb8lE+yZrGDG36nVtEviO35A+f7LND+Ji9VOUYcYIZcVXEN7clLohyn7Apwpy6UTuq+E57cOr0PjxE4/Yrq9D0N7d1iGRWwkfq8yt9fx45enmgc3HhIAMidhKw6Zb13kbK3XA3H+00CDFC2i3faPcxL5UJfgusqObB5EMED6csB1zMNMjycpwlwf5G88RpHJ8B2wLNRdZ6e/b9AIhKgZBohdOLgdIiK1JQoeS1fxG9TFSjfpEkEguCkQZnKDAUZuz+OYPbuMECSvRLMcIAusF7Na/Ca6gsI7CVsPgHAUwRBXRX1x+p6QyoEwZl7SF8FK31TO2zsEN7g4wg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 03:08:58 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a%3]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 03:08:58 +0000
To: Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>
Subject: RE: [PATCH 1/2] vdpa: Add support for querying statistics
Thread-Topic: [PATCH 1/2] vdpa: Add support for querying statistics
Thread-Index: AQHX3EFM7M5U7I8roEu6kosjxQg7cKwKJX8AgAAE5hA=
Date: Fri, 19 Nov 2021 03:08:58 +0000
Message-ID: <PH0PR12MB548187F4DE8C789908839F9DDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211118055741.239639-1-elic@nvidia.com>
 <20211118055741.239639-2-elic@nvidia.com>
 <CACGkMEsDHKCTSHtLBp3Pr0wntgYzsSBNjCNjQjGkmk2iap80rg@mail.gmail.com>
In-Reply-To: <CACGkMEsDHKCTSHtLBp3Pr0wntgYzsSBNjCNjQjGkmk2iap80rg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0a4372c-1984-408b-35f4-08d9ab09ee27
x-ms-traffictypediagnostic: PH0PR12MB5420:
x-microsoft-antispam-prvs: <PH0PR12MB5420923932D9F9D83E40A292DC9C9@PH0PR12MB5420.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WAleRvE0Vp0ce+NB9h0BtdgUltD+fmw+lL6KmTlEAb1tkVpc04PigYqWutvRt5onmgbOCl6TKeGAP/gz3Ctngu0mse5kzH/GsMw1N4FK5kjHnSxD/IyPxDoCW33UhLyeZ2kvQ3V7pUKy/4A+acnTwz2jP5binXpJPmt3/WynE2rsdF1aD/0ts+7Ji/dO1uLDR8/R+l6T6luhjck86nDDfuJOv20ZPgCI39YHKRe4qALwQCsHjm2ih5XycP6wouAi3FIq7qw99i4d5A8XnF/gvuGAYLt+6/WHx6Bmu7cUcowmtwRYioVSSpxlO/32YIKKDEesqFmoi0vltUEC3ha8tlpnkiQMCqnijsmG9WQvADM7jqDjjRXQUpHcxeoORNVhlp880A5rq2xocTUPZWJv+oYUXiNBOaMSIVfBwwldp1WTikKz/HCqy9DfaMOzszUQKHxzBVekZl/FtI5Bl40Qjr1ojF4vrkoB+Zp1FEQ+SWWTZxdH/w8S9GAKZoMERCR5nb/R2r7vg02SwFJRCwn1dNkDtrSB1OdFQUpW9XfunOO0UQtZI9usAwuaqGmhxK5u9MDVKO+ME+BmL2S6RuYkiwg7PRSkEihjTDnv5M9Xlqk2s3saRoRv2vi1gLlMP8Q8xZ33kqvAPMX3cRUYRFbaG9tRifgUZ3AM7/2Bx/RZKTJF58hAhHkF1lNbZJW6u/FyLUTqnr3YDQ1I1dahulJErw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(508600001)(38100700002)(55236004)(5660300002)(33656002)(6636002)(4326008)(86362001)(52536014)(26005)(53546011)(6506007)(8936002)(8676002)(7696005)(55016002)(9686003)(38070700005)(110136005)(64756008)(66556008)(54906003)(186003)(66446008)(66946007)(76116006)(66476007)(2906002)(71200400001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFRjVWpWcVVtODRnS2dkZllpbVJvZFh4ZFhSRk5GTXpVeFVaN2NnWE5EejZE?=
 =?utf-8?B?M2lyRWdZQ0tEZW1ab0ROZFBMVnRmVG1jVGFmcHVWM2d5TFZXNmkyQ0NnQ3RG?=
 =?utf-8?B?a08wU2JjeVBjMEU3R2hsYkQzRm9ab2tKSzY1NThHLzlpRE9YVXdhWjdYczQr?=
 =?utf-8?B?b1RUb0hZajVGSXl1Q3ZmV1BKM3ZuWUtUUkMvVDJoNEMvME14MDl3TnZvbWNG?=
 =?utf-8?B?OHBBRmIyazFLelkxU2JxMHhFS2RaTGR0YmxuMEtiM0hJbVl3cFlpY0EwOVEr?=
 =?utf-8?B?ME4vclV1SFNIZzIzc0JBZFFPdXB1Q2JaS0gvNkxHUFFRVnJPVDIvbm13Ulpq?=
 =?utf-8?B?d2pROTEraVlONnVxVkRzOVFBY2xpWXdnOERxTzViL3h3QnFkVXp5MFFXa0NM?=
 =?utf-8?B?bFhDUE5NaTAvMzcrTnBjMHFyZTBKY1VhWEZhNUY5b3I1MW5sL2QxdWJjWlRo?=
 =?utf-8?B?TnhOd2preThuNDA1a3N0S01XbGJaeDFHL2k0Ymc2c3NXV0dYYUtKOFl1YVFM?=
 =?utf-8?B?UmhSMk81UTcwWFhXZXplNHdTSGlLcmZnaS9lQUVNcnFwL2lqTG5ZQTlBQjI5?=
 =?utf-8?B?Smo1UW9qTHV2a1JCNE9zVUVjcnVSQktxNk8zUVZ6SFV1RmRzUERjVnhLN3F5?=
 =?utf-8?B?eWppcHFMSSt3SVAvbHg4aVBEV0tScWo5bWpJK3VtWURmTzRlM0VyQ0FsRG05?=
 =?utf-8?B?OTlhdjJ4NGIySXhoMkJnNnBtQmx0d2plcWQrZlFCdUlndzBQR2hUdkwrQ2VP?=
 =?utf-8?B?QnpBT2xmbk1Rd0VhZ2FCNUJkeGIrZHFjR3ZPelNhckxXNU4zQTlJRTZheC9o?=
 =?utf-8?B?dHRhV09ta09CUGlsYkplb1UwMkxMWWFQNHZ3cG5USytlL0xReU9TTDJ4VE9R?=
 =?utf-8?B?MFNzQlpjUGJKZ0VtSlVKUzl0VnQ4a2FVMGt3T0dDODZqTUdPRmV3N3V3SzIy?=
 =?utf-8?B?VGVGM1pHMnB4bEJyTTdIeFQ1OEU2WFlrdjJBbnN0ZUFDbkZIMVRuSndYdlEw?=
 =?utf-8?B?SXozQTBzYiszWlozUEFPRUMzNmNPZlVBN2JWUzRueFBaVk44MDB6Ukdld1pH?=
 =?utf-8?B?Q29aaEpUZm9xMm9XZXZYVFZOZktKMkxyWU1nZmpjaGZ3cFdOd3MrbVpSRzYx?=
 =?utf-8?B?MjF0Vnp4dzg5ZlJnMGpGSDRpSUF6SndWSmFxVC9TZ3lNaGE3NVpQb2dLOFFl?=
 =?utf-8?B?M0l6eExrM1hRVDg5VjlhOVZzNDFBbkxrRFZRcmVnNjFIZXA3QUFUc0F6eHJU?=
 =?utf-8?B?elhmRWlmYWU1aHE0d3RNNGk0TURIajAwbVk0QndCRzRZRzhmQlYyS0NQODdW?=
 =?utf-8?B?d3ZlZUtoZ2dJLzZZY0d4Y3l4WlVjTUlPZURsZmtpQ0dGcVd6cmVEbVNVM05P?=
 =?utf-8?B?eVFMRWQxVC9EdTR5aFFRYmNGOFNpMVBldTQvZC9DV1F6SFRGMzhLNUxWQnJZ?=
 =?utf-8?B?NTcwWTVLYkJiNFNuWnNHZjhkWkd4bENBN1YwUSt2eFB3QUR6NEdNQmhOQVZ3?=
 =?utf-8?B?ZzNYUTgxRVlES0tOME9ITkp2UlMzbnBiQ2crT052KzdFckY4dTg4ejYrb1pv?=
 =?utf-8?B?bWduNnh0aXVRZnpKaDcvQWZWZ3FuSDMzWXJtNG1OSHFRN1B6eGhORDBnVUFF?=
 =?utf-8?B?QVR3TTBjbEdadGNtQTlPU3JLVXN1UmtydnU5UnduYjNsRzBnem5DbW9ycHBN?=
 =?utf-8?B?ZUNRN2ZuZm9JYkdIRkxGWHZ6bmxKOExxWUFlQ2NkYTZrOFgybS80L1BoQSta?=
 =?utf-8?B?RElZRmtIeGRBemkwVkdxQ1RVZjJBTkg4TVdLbFNBdm1uVUpMdE1ndDc4RVJM?=
 =?utf-8?B?TlRNb1pGWHBkd3B4Ym5SejdjeFpKSkZmY2p2UFY4NTZVUTVRWmdCcElxM1FQ?=
 =?utf-8?B?YjFQWUFVZ3JlR1JFYmxGS2o1M1Q5RjJEUzF3Tzk2czA4K2E5OGhjeGlORjVR?=
 =?utf-8?B?TmkzKzkzN3lwYTJzT2dLVkVaaWhJcmVGcHhXZkljbjlObXVRd0FWUCt4aUxq?=
 =?utf-8?B?dzhHa1pIMjRsYWtwUzVaaFdNOG96MWZUMmxGcVVWbjh0VldDK3pOcUhKbExQ?=
 =?utf-8?B?MXM4Q0kwZmV3blJHRXlFWlpVQldlK1FxZmJJSEwwKzFaQURnWUx4OVF3ekNw?=
 =?utf-8?B?aXg5MlB1ckdOcDM1WEdBMlZUZ3FTbDIrRjQyTWlVaEtQN1g5VlZqRXJZL3BM?=
 =?utf-8?Q?LLVbOsT66rsnCoTwzx4oKVg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a4372c-1984-408b-35f4-08d9ab09ee27
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 03:08:58.7053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEs1J/tN+s+FBM1fYdpY1LUE3eN0DE8u1k3TbMFA0Pq6auUCtkN7BCRhmoSFm712g1p1dZB1c6h2U8CkCmci5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5420
Cc: Laurent Vivier <lvivier@redhat.com>, eperezma <eperezma@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>
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
> Sent: Friday, November 19, 2021 8:12 AM
> 
> On Thu, Nov 18, 2021 at 1:58 PM Eli Cohen <elic@nvidia.com> wrote:
> >
> > Add support for querying virtqueue statistics. Supported statistics are:
> >
> > Received_desc - number of descriptors received for the virtqueue
> > completed_desc - number of descriptors completed for the virtqueue
> >
> > A new callback was added to vdpa_config_ops which provides the means
> > for the vdpa driver to return statistics results.
> >
> > The interface allows for reading all the supported virtqueues,
> > including the control virtqueue if it exists, by returning the next
> > queue index to query.
> >
> > Examples:
> > 1. Read statisitics for the virtqueue at index 1 $ vdpa dev stats show
> > vdpa-a index 1
> > vdpa-a:
> > index 1 tx received_desc 21 completed_desc 21
> >
> > 2. Read statisitics for all the virtqueues vdpa dev stats show vdpa-a
> > vdpa-a:
> > index 0 rx received_desc 256 completed_desc 12 index 1 tx
> > received_desc 21 completed_desc 21 index 2 ctrl received_desc 0
> > completed_desc 0
> 
> Adding Adrian and Laurent.
> 
> It's quite useful but I think it's vendor specific statistics.  
These are vdpa device specific of Linux.
And are very generic of the VQ for all device types.

> I wonder if it's better
> to use "vendor" prefix in the protocol, then we use this instead:
> 
> vdpa dev vendor-stats show vdpa-a
> 
May be. Lets evaluate if stats of this patch are generic enough or not.
 
> Or if we want to make it standard is exposing virtio index better?
> 
> qid 0 last_avail_idx X avail_idx Y last_used_idx M used_idx N
> 
I did consider this option a while back. Shows indices are equally useful.
I think we should show that as vq info, along with other VQ attributes (addr, len).
$ vdpa dev show vq

But showing indices are not less statistics and more current state of the queue.
For example roll over of the indices won't cover absolute number of descriptors processed for the queue.
And even if we make them u64 (not good), non_developer end user needs to keep using side calculator to count the delta.

So I think useful q indices belong to q info.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
