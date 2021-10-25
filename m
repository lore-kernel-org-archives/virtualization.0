Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BB9C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 07:11:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5871861002
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 07:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5871861002
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 08F8A40192;
	Mon, 25 Oct 2021 07:11:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6flWIerB6rQs; Mon, 25 Oct 2021 07:11:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 730D840264;
	Mon, 25 Oct 2021 07:11:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56456C0012;
	Mon, 25 Oct 2021 07:11:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 604FAC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:11:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F58980E68
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:11:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nijFtAWhNC5G
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:11:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::614])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3BB7480E6B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:11:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldOuGPX5ptyXiO9LkAdPvdejtoGTV8Z9gXvO09r5GOSl+5ozSK/b1lMaBTczxuai0Xe5Wl2uq114EPeeDLz7WmmOAG34nzRuTIKoeGJFgIEix4YTYviHdaDBkyvUZbdcgLLt4t8ethrOP8xdfQQ0EsgMFEBpue/BiLGWsYGk5H5bWHkYc495InjSEFZ3GvuhdbqigCnJDScR3Z0CazsSUmCIMVi6WqxUjZCYiZ1nh71e9yIknuMyr7V4qj+SHdxIS5k2OomS/n9sePxcwhaC8zntZH96qn3tjfS3H+ghcd58GGPhMcYZueyUxtgzR4zc9gzRwSroqOcAO/FOSIYSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AjTHtsqWfl1NLaQZyTlkJsEakF+EwGt1Q/4ztlH4kc=;
 b=YIMLFX4qAGTJpJ4unqVPwXl2SzrlSbqU28CBTD2QVTYqVCnAUATkIUhvFWDEFoIlVQ0A9rBMkO7DdSTxzC8jo+R9xrxiRHlL5rMt/Z+cMxOZpIdrA5EWfBDXqeBfu0UBwC9qEyH7uhROitWY0SSy3YLTms68HWui/NKC8g5bCZOVu2TKVMR78QZ0I1Sn1RAUXLAXzBV1aDQJtDOjJREKEOLIWvkihMbERewDVf9bgbwvOCEsSKVCddOvpBu97Uzhrc3jO86wFGhZ4QixqqpWJhjA6WbQrXm9U9A7y7FTGZHI280i5xo3wsA4D+4F1vSf+dJGYUmtvb0nSowFyVGaLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AjTHtsqWfl1NLaQZyTlkJsEakF+EwGt1Q/4ztlH4kc=;
 b=FQ7tUuZviZ583H/n5U/0RYPEJTXi5B8K2vnEL5K+U6fzq7jW0OOEdG4k2bTUmTu43STbBLCPcbM6yu4l9tRttp2tnnadba78bBJMzjDRiN/b0+c0kPfKLvm3Tu9JwNdTqxO3IyKY3eM7SY/PA4PVRBPVEZCmgA4Q0uKW9FdOh4kJpIwHeEhBjFf+pu986mbGs/ZCwPxheisKs0ccdSiHeLSMHSJFkdpNiXYzSzPI8ly1NJScvd7GVB1EN8T73HY1+4FzrWI0xOuKntsw+XaZTQ44T13MWbsREpq9jf11UG18+REAHRFiid7NE47sVG8DlGL3BE2iuroLsbnA5GoVIQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5401.namprd12.prod.outlook.com (2603:10b6:510:d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 07:11:23 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 07:11:23 +0000
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v4 5/8] vdpa_sim_net: Enable user to set mac
 address and mtu
Thread-Topic: [PATCH linux-next v4 5/8] vdpa_sim_net: Enable user to set mac
 address and mtu
Thread-Index: AQHXxpm1m80mTV7hq0uYnXMEWxV+O6vjT0WAgAACM+A=
Date: Mon, 25 Oct 2021 07:11:23 +0000
Message-ID: <PH0PR12MB54818C925D446110117F01DCDC839@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211021163509.6978-6-parav@nvidia.com>
 <03d8d907-f54d-f9e2-a058-fd8d50ff927e@redhat.com>
In-Reply-To: <03d8d907-f54d-f9e2-a058-fd8d50ff927e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: caa78c2e-8902-40ed-65eb-08d99786a729
x-ms-traffictypediagnostic: PH0PR12MB5401:
x-microsoft-antispam-prvs: <PH0PR12MB540154074E68FE7AA77C8C38DC839@PH0PR12MB5401.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hp4OdACP79GYiE7DeNiCI2hGTqDcblWi/aAABdVfyLSPFltXm/VI7nBQU0CFXo5hF4WBlN7enBgN+lpF+o6VoGKn0uQwfO9yyhKiTVk5ecZnNCKzcDH3xTZXBl8FlRYVe6aQh/rmKXjevNGuAyk2GRJKlARoYLSPYgb0bSq3dJZT7ewKlSg+xWqNMbucL1aIOXy7xg0PmafyHrZRz9uEuMQydDXRzc3vjQ8LMyyCARFhkfBQ3fe5nCdw4OaFrVedgdTdrFjRURQ0waYiyJVrOfiljEw6VHLMJ9smn4FVQeQFSrc40tahXnYOt8PMo+/MwOobW7e+IP5QfqFS+Pb4Hrqi/5GRqoEnl+7ceT3BIVNuSww6Itz7Ai7dGPtROzCyZeE5/+Bw1gsccUeMdNj763jM9r+Rk1J3beeaVvd9O4DlXMEPyvijnmZBju5q8bwGYZvZo7qpWz3ZPE0tdnQRnmfMGMzpAsgmxVkbqU8vffz5WcDBE5GE+3qsIFrVUJlgHb5m+7f2ccZbzjCH+0bF9JStvtRDXTik2wRK4NvvzC2jyX32i64cmhlrJpEC9DKW3lL22crcdF4VzT1IRqygXf+vTf47XBMkUePuwtsIOgn5OcJi3X8TFK3qlYmSRO8KjknubaUljRquEUOdSTnaL238JtqCryL5SIVGIoFx0cXHyKg1xAsWuVu042WHBLPLRz+KRsrwpGUC4JX+WtKqLg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(66946007)(66476007)(52536014)(508600001)(64756008)(4744005)(71200400001)(4326008)(2906002)(38070700005)(5660300002)(76116006)(26005)(33656002)(66556008)(66446008)(8676002)(9686003)(54906003)(38100700002)(6506007)(55016002)(110136005)(122000001)(316002)(83380400001)(8936002)(7696005)(86362001)(107886003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ekFIbXQzbm1jWnBUdlNEYVBJb3BhZDMwZDcra1RRYzZGY3kwZ2JxV2dY?=
 =?iso-2022-jp?B?MmJiOURTM0VYT0FQMkQ2RmZsWUFtTHJiNG5IWG5nYzNFQnlibUJyYU4y?=
 =?iso-2022-jp?B?K0ZubnB1NG0rYzRhdXNOdExlamh0YUlvcHBLRXVKbzJtM0Y4aXV3eVd0?=
 =?iso-2022-jp?B?NERHZEprT2ZTemdLV0hWOFNpdktKSE5TMURIU25UcUxPUXdtRGxqMExi?=
 =?iso-2022-jp?B?ZjZ0RW5uSnp5by9vL2JEZ0xWV05GQU1CY1J2bkJzZjc0QnVIWUx6Um5P?=
 =?iso-2022-jp?B?b09HaTV4NEVwRXZlMGJLanVLaDNlU0tDcHVENGp5RlpObi9vT3VXVklQ?=
 =?iso-2022-jp?B?R1ZlQW5xRWhMVU1LajFNYzlPVnlSL1J2RlpDaXN6RnFWTVMyUlRGU3Q3?=
 =?iso-2022-jp?B?Qm10aDFNd2R1NGpqU2NQZmE5K2pvWnlhTjJuRE1Dd1RrWkVxdE1UWm5Q?=
 =?iso-2022-jp?B?bnBkQXBweDNmSVRZbVh0Yjc3Q3NXOE1aazRaRURkbm5HMU13c3h2dnZt?=
 =?iso-2022-jp?B?WGtNOGp0N2sxbEhYenBZRGhONDErZW52a1pMblQ2QW5wNmlkNTJiRXFQ?=
 =?iso-2022-jp?B?dUVLOWlUOThRd0VjcFg3cE85eThIVFFnQWUyaTZsRDFpcUdldTFjZjRV?=
 =?iso-2022-jp?B?WkxCZkpYcks1eTI4bGIwSHJWTDl1VGRrRUlFbTFXREFjTXhKbDFydWxV?=
 =?iso-2022-jp?B?cE82RzI4T0RqZ2hVQzFaNWQ3OWtLTDMxTzFhM243ZmhGRHBTSUJ4eDVB?=
 =?iso-2022-jp?B?eFd1WWZXN3Bhc1NoL051UGRNbWpKU25FTHFBRkNHcHIvYVhNM0d3RXRl?=
 =?iso-2022-jp?B?SzdZbmZINlo4UEkvamxFcDgzcHFOK0RuY3RqNVdlckhoQ2FmcW8zN3pi?=
 =?iso-2022-jp?B?eVphakVqdlZoK3ZRbHA0bWVMS29EOCs1T1lLdlY4VGZKN2o5TzNjank5?=
 =?iso-2022-jp?B?U0lwWC9KcHB4US82bXBYSkVwdDh5UzB3bmIwWGVPZ3duWXpHTGVJTG8w?=
 =?iso-2022-jp?B?RFZBTytIQm5YeGJRZzI1T3FIT2w4UWxtLzFKZ01zVnQ1SWM5MFJBVG9C?=
 =?iso-2022-jp?B?bk4ybHhCbVlnMDI5aHpFM296OE1xdEsvVHR3V0dnVGxDMmUwNy9PVE8z?=
 =?iso-2022-jp?B?MG1iYmFGTG5LSlB0a2N5ZUpTR3RrMVIzdTR1QnpLZlRzMThMRjQ5N3Ev?=
 =?iso-2022-jp?B?OWkzWGx1VXRBZmNBWEVzOVhpa1JPQThqS2dLb1EzRy9SYzdYejc3OUZq?=
 =?iso-2022-jp?B?QW1WNmMraS9VZUlxVktKcVl1QSs0M2JoWjZWOEhYcG9vWHZKbFRZbFJS?=
 =?iso-2022-jp?B?K2Znb0VMOG03TlhpT2U2ZVVBaXE0aGdreElHL0lKTlFYWFJ6SDkzTlh2?=
 =?iso-2022-jp?B?Q1J3dE51SUZUcktWS2k5QWRIbDVQaWc5b1FPWEMwMWw4a25LZDdHVVdR?=
 =?iso-2022-jp?B?MmVycG1taUtEblZ4UW9SODhseWc2YVJWSGIxWWNRN3pGeXEzbGw5S1ZF?=
 =?iso-2022-jp?B?SzdmZFRQOHJKeUo0MFBxVEtJa1hnRnBGQUt5RThNdUtVRzRkRkwrQzl6?=
 =?iso-2022-jp?B?cktwSU1vZ2EvbVBscEh1ZmIrT2dmNGorUGczcUpnbGlBNEgvYnFXS0ox?=
 =?iso-2022-jp?B?b0M0SmxnZ3ZSbG5KVjJFcmQ3YU5NbzBGaTJyTEFXSzdwcFd4TFRHczh3?=
 =?iso-2022-jp?B?akFIdVRiaG44Z0l1Y3lXRTJTNWd6bC8xSEZUWjd0azI0S0lKeFJZa2JR?=
 =?iso-2022-jp?B?eTBtc3lJU0h2TWptUkM0cVV5YzZKakh1c0pqU0ZrTUM3WjNkeGJ4Y2hv?=
 =?iso-2022-jp?B?VW1ySUFoTnJpVjNwMFY4UmcxYkNqU3B1NFZhWVF6NlU0OVlVeTNLT0k5?=
 =?iso-2022-jp?B?VFZQS3hoYk5iN1ZqZjhvU0t6OXJKK3ZpWHFoQWtWVTRzVzlTOURwWWQ3?=
 =?iso-2022-jp?B?cDAvazZGcWtxc1Zlc3lLc0pETVhzQnI0OEdHYmM1b052cU5jcEVEZWx3?=
 =?iso-2022-jp?B?MG96QmtrTnYrK3lhSVJEV1VYd1FxcEMzRFgzM0VqQ2xpUFh6Ym8rWlds?=
 =?iso-2022-jp?B?MWh2dUg3bTFTZnh6RzRFa3dwQXlMcHlYazZpaWR5TkdQQUpLZkNXSXZl?=
 =?iso-2022-jp?B?d0liRURFb3E4T1M5ZzByVHFDcUtYNXJhVzl0VkVSQ0VOcGt0ZzZTVVpG?=
 =?iso-2022-jp?B?U1I4T3BnSFBhc2c2Y1BzMTMzbFpXcVIxcm90eFBsNE5QVXJ4RWJoOVBI?=
 =?iso-2022-jp?B?c2lTb1ozbE9FQm4vclRPVGJOQnpjMWkzTFZCamExQ2R6bHRab0JpNnFn?=
 =?iso-2022-jp?B?L2NsRkFsUlVmTHFpNGkzWDE2cXZGYTJJamJrKzN5c2F1YlZqdEVTL0Fv?=
 =?iso-2022-jp?B?NE1TYVU9?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa78c2e-8902-40ed-65eb-08d99786a729
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 07:11:23.4898 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ibwaqoca5UK3ZLudTsNdWwJBWvJ9HZmswmBSo1GGpPIH1i5P4M5Z1BFYe5iCG9HPn19NsXycov8UjgZuplsKUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5401
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: Jason Wang <jasowang@redhat.com>
> Sent: Monday, October 25, 2021 12:32 PM
> 
> 
> 在 2021/10/22 上午12:35, Parav Pandit 写道:
> > Enable user to set the mac address and mtu so that each vdpa device
> > can have its own user specified mac address and mtu.
> > This is done by implementing the management device's configuration
> > layout fields setting callback routine.
> >
> > Now that user is enabled to set the mac address, remove the module
> > parameter for same.
> >
> > And example of setting mac addr and mtu:
> > $ vdpa mgmtdev show
> >
> > $ vdpa dev add name bar mgmtdev vdpasim_net $ vdpa dev config set bar
> > mac 00:11:22:33:44:55 mtu 9000
> 
> 
> The attributes were set during dev add if I was not wrong.
> 
You are right. I missed to update the example here. Code is just fine.

> Thanks
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
