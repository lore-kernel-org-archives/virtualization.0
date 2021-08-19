Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD9AC4338F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 05:23:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348DE6109F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 05:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 348DE6109F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E30B540796;
	Thu, 19 Aug 2021 05:23:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PY9XzMMO2F_3; Thu, 19 Aug 2021 05:23:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9AE9F40794;
	Thu, 19 Aug 2021 05:23:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 727F3C001A;
	Thu, 19 Aug 2021 05:23:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 587D6C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 05:23:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E7EA400E7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 05:23:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 78dx36gS1GSc
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 05:23:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2059.outbound.protection.outlook.com [40.107.212.59])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F3DB54013F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 05:23:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3HpKOGUAxKDX4054fEZmRnAGS76HAAY4+h+9roAzzYI+WMm5EmtVpSlLr6nwL3z6vQpFSFQfPN+Chi4SfqB05wkXWB+8a9Q0eJ1woX7Y/d/iNuzieh+HdmyIrL09NC8XEGluo5FFc+EEaWiCP0FRI/88bmDKfZZnNF/VOxVbh8nCRnJzxhocmETX81BqawlcnmYHnyY6xHov500hdAstIVnOVpTrn6X4zM4cpjRrlTgwLjDFAnDQS0huOjtDc0k8tsfrjic5EdrK8zh3PRQScJQqHL2NkilNbi8rk4IPjf2kQu0vXX8swSx2Fi0Kt7gtfVLqn4QCNy/2FSvXwHxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUV+edqIcF9jBj39HG3hAs3salUggMJufcOmwhzKFr4=;
 b=mow0ubXOPqNFX2r9FHY16IWT9T/p2okt9svR7BwrJTNfCBaKTRDdh1XakXHqisS+q2lM/HW4Pk8WxC4ij0zzCLR56cO38bBgtiZ5Pz/Q1VOaUv5tm64JbCbwbSFAVkFl0dXfoz31Je31b6wfxBkrno+l0CUpceio/iR9nzKo92pUtjId0JmN5DAoBoqsJCiGhqBBHHag8ckxgsNexJg0fWhK2ibwIT0+F2c4RD+nqdUyLwIw+T9RkDTyCpiz0St+yKUf8jnpeVD/BrYJQZlo7S/brFWMYoazy3okumrPtshtursrs7rOsQKKxM0J9H4NrA1TdzvnXOdM6VKBF4Y+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUV+edqIcF9jBj39HG3hAs3salUggMJufcOmwhzKFr4=;
 b=BOgtVt0Zdp5lJHKJiA7Uz9UeU3SwfR5VhVvryqnYxOye+MyxIFXOdJcN0R7G87BLqyw4JtPmW0GfnfWkHZrjSPVJ22EaVFZ4WQCX//gn9yQYwj49m8Pi1Rk96hUC9X3QdZ1fR1zfHWNb+yE+Da/d6TzPHIsXSjfj8jRdhhjVDEEIq9o5rh6Fx1fpFERotdqsRm1EtsrfehgBQ+vueLBFZMzKx3gz9S9WXDuq9MeHPWRCy7PxXPYpUVq4sW1xUgfoYTkc9fZdpjp3nJXXMKMOZLxQ8VaDFx6dlpJDDi1NmXpcvTnMsNZzdi0IAaphYAEImo5XsG+A7ZAXSlhnZvpl7A==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Thu, 19 Aug
 2021 05:23:02 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29%4]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 05:23:02 +0000
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Topic: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Index: AQHXYuOH3YVTcMY6VEeAGlknhW/FN6tk+uIAgAEa9oCAAGJZgIAAALAggATGdICAAADAkIALu+yAgAH5tgCAABhhgIAA2oUAgAC1HgCAAA8tMA==
Date: Thu, 19 Aug 2021 05:23:02 +0000
Message-ID: <PH0PR12MB54810DBD4DCB352FFEAB0550DCC09@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210809053624-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CF2E07B38C45A2829B7BDCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210816165217-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819F68856798FBA8528BBADCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEs4fnV2RT8DSW3i0TtHL6t1rwuNyC-uLi3tRopb7mOhvA@mail.gmail.com>
 <20210818133309-mutt-send-email-mst@kernel.org>
 <4ee539aa-a7c6-d9b9-790c-b8fedc69e5c7@redhat.com>
In-Reply-To: <4ee539aa-a7c6-d9b9-790c-b8fedc69e5c7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8c3fcca-7f3f-4d84-5e59-08d962d16a83
x-ms-traffictypediagnostic: PH0PR12MB5420:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5420EAD836C2C100AC0FE577DCC09@PH0PR12MB5420.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nGxPObD3F5zGhKdIjpx+UuV2FdJrv+nDLtW+Dw6C3fv2bsB26+r1JqEljVKzCRr16YvlhGTLylfw8MGZr3LaONDttfl+n+XeRgCuBzhAo+lu/O1xtGcsgQAqnA8arIpSt8kSrUxfthd5qtLqa1kALXJrrn0ygST72k2f6ld31DsAgT/fz0NKoxmWhaI8aILx2Dcva7oXm4IwSP2ha/jIDuLmG1IU52OydL7sa+NmlCaGywEcn0RIgxCfclrrvaWp3Po3knlPvrpoRlJvnDsRVvMssVOqJAvMylEPR/qWvkik33EcBvpU7gjFMOX2t6mbVvfwppf4N6mKolHCsaQ7uyC3i2wEYc5jps2rpZvwH9kjdtVzTTaz5BybLpU8XLey/g0jiAFKAsYv1TnGdq9F1X5Cyfnx31oRK8H0AfxG9PcE3j7TkNUKDHo4E3Vo64Y70SLL2eyeTs/MebG7bTdRYUmeGWbBw2btWGK5Ye4+WHS6H/+AeeH4GFrsEriv1BAEekF4c3DwBVf+qrZiYpsPUqWT/KmvW4y7DGUO60UmnnzzBwyvqsIQRDnO2pVA1WXE7++Xn+sQvODvLvD0IyzEF6seH5mk6gBdysD+es1yYtbH8XIPhTfln5KNqoP5oZrIi70QSB3X/1HDzZoasxRWtEykj9xUn7RzIy89eyffpkwo8+rQlVhVpsq2BP1nIxBzc84cQMKobGSB6Z3wP5NTrw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(186003)(38100700002)(66556008)(66446008)(8676002)(53546011)(5660300002)(54906003)(9686003)(4326008)(66476007)(478600001)(107886003)(86362001)(76116006)(66946007)(38070700005)(64756008)(2906002)(83380400001)(122000001)(8936002)(110136005)(55236004)(33656002)(316002)(7696005)(52536014)(26005)(55016002)(6506007)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?T0VnQmxpckQwWGpBeUdEb2ZSclhjNjZEU0JFdDBoQnIwMGpwS3hIbnlq?=
 =?iso-2022-jp?B?VHBJQlhnQnppckFVWXAwOTdnMEdHYmhaWEhocEZYUW9LSVNPTjUzRXA0?=
 =?iso-2022-jp?B?K3l2YUo1WTVNN1EzUy95QnNnKzkvZ0NpT1l1ZThSQ2RzbXlJeklZRkpt?=
 =?iso-2022-jp?B?bEY4dXFIK0pEQ1p1cTh6MWI2aTh2c2dHaG5KOUNSNTBQVnZ3b2g4d3lC?=
 =?iso-2022-jp?B?Wk1pOWpqa1prZlkyMVd6MW03Wis3TEc2dW5jYnE0TlBSS0xTKzlicnNR?=
 =?iso-2022-jp?B?NzI3UG1KOWViQ2wxMVZxUkZVUDJqVE1HOHh6T050cXFkMTFHLytWRG4z?=
 =?iso-2022-jp?B?QXJYdkkrNUV1RTFuWGJac1hOamxva3VYT3lDRkFyOWs0T3J5L3gzejBX?=
 =?iso-2022-jp?B?SXNzTnpjb0RCQUtEODQ1SnA0eEdNTzIzTXZIeTlEVit6dHFoL3Z3QkMv?=
 =?iso-2022-jp?B?c1ZrSjlUckoycE0xbHBjZjZCN1k5TGpVWjgyYVFNTTU1R0NKQ2pOTFNI?=
 =?iso-2022-jp?B?QTNsa3lzMTEwUFBOa0p3d3psOGx6VFNFdHRmdUk4S0xmV2tzSlROek84?=
 =?iso-2022-jp?B?ay9QMUczQmNKcUFqMFhtcXdMaHpySGNSLy8zcW02Mll2MDJ2TVJ3eGN2?=
 =?iso-2022-jp?B?aHRpWlFDSHRqTE43UTcrdVBHZWNsQkp3WGV6V3QrNUIxQ3lseEdXODZo?=
 =?iso-2022-jp?B?U25TWlRHclcyMjAyOWY0K1ZpUnNKWFhITEdEanl2dFVNU2ZHRGIvUFBQ?=
 =?iso-2022-jp?B?ZkNlWVhaOFNhNzZVL3ZPZC9xVm1qbW5FMXdZWFI2eUdIbyt4QlBNSXNr?=
 =?iso-2022-jp?B?YVFwY3FTcDE0aC9uK1A4emRPcHc3ZTBaRU9WME1xNWgrY1l4elhuWkVC?=
 =?iso-2022-jp?B?MWx1RVI0MzBrQjIyMStSaGpGejNJc0J2YnNRQ2E0bmZEQ2RZUDY5c2Mz?=
 =?iso-2022-jp?B?cmJ1UXhhMkFHM1JsMkpORTNpVFhmcGtIMm9CU1ZUblB1bjZzTU5mR0ZM?=
 =?iso-2022-jp?B?SGsvOHZzNlordG9ielVKd2o0WE5iNk9ONGNhZnVMT3luYW5pS010bUlN?=
 =?iso-2022-jp?B?NWZqUi9BRlF2Wi9BNExHYWFpcVFwSHgxbFlya1hBUTJ4RUd1b1N3Z3Fn?=
 =?iso-2022-jp?B?TDQ5RHpCOGl1bFBlTTRKd1FnRkFIOHdGMjMyOTUwVlNma3d6RU00VTN5?=
 =?iso-2022-jp?B?aVorNG1GWW1vSXFoTEo3bFY2dFNUT2twMFpTT0h5UU85cDVZSmVMMlNY?=
 =?iso-2022-jp?B?eWlVUC9JTUZPY0lKRkNueHVqMVNZMThxWktFbG5kV1o3WHQ2UHRGSVdp?=
 =?iso-2022-jp?B?U0QyUXZlZDdzL1QwVzIrN1RlaHpyZkJHbkIvS1NRWUpKeTFYOWdiWVlq?=
 =?iso-2022-jp?B?T3FTYUJWTlJ0bXdqdVdwOHFzeDRPOGhvNDBBZUJsTjhuWFM0YXF5OVZT?=
 =?iso-2022-jp?B?VDdveGZScnB2ZWxFcHNlcWRpRWhkd0pMYyszUzV6b1ZaRWhvQjJTck10?=
 =?iso-2022-jp?B?Y0RkaUQ0TkFkVmMvZzVTdWdNWFE0cXQ1c0MxT1c5VkRORGVNZGV4bkNr?=
 =?iso-2022-jp?B?ckFYZEpOMWVIVDU2NWRIMm9xc3hkTnpsZERVdlY5Z0NGZk5kTHZsWnlG?=
 =?iso-2022-jp?B?VExad2dBZGpSNmR2bzhOOW9aMEpwTW9HdWhTeXlyVmI4QThQRDJUZm1x?=
 =?iso-2022-jp?B?WmFyK1drM1Joc3hlangxSm1tVHh3Z21id1ZLYnBRV2F3SnB6dzNRLzZl?=
 =?iso-2022-jp?B?WTUreEZXMGtNWXpRNk1lZUlrVWVCTW55V3RkcHJSMFZuWXJ5VXVjVzdW?=
 =?iso-2022-jp?B?WVkyVkUzVnpXcHRyd3VaT0FNNlM0dktQVm5RbzRDWm1CdHZ0VHJ5dEF1?=
 =?iso-2022-jp?B?QXUvZE9KajFhMkUrdDVha0RPaFM3UlJ6Z21hTlRKMFNhUGNzRGJXNmpO?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c3fcca-7f3f-4d84-5e59-08d962d16a83
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 05:23:02.2664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PN632RjUf8JjCS+rSRD2awrSrxBjeJLNILk1ZfxKaknEYUBBFv66wGl8xTep5jSUg1pyw5DJh4GEuu2p5vw+jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5420
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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
> Sent: Thursday, August 19, 2021 9:52 AM

> 
> 在 2021/8/19 上午1:33, Michael S. Tsirkin 写道:
> > On Wed, Aug 18, 2021 at 12:31:39PM +0800, Jason Wang wrote:
> >> On Wed, Aug 18, 2021 at 11:15 AM Parav Pandit <parav@nvidia.com>
> wrote:
> >>>
> >>>
> >>>> From: Michael S. Tsirkin <mst@redhat.com>
> >>>> Sent: Tuesday, August 17, 2021 2:24 AM
> >>>>
> >>>> On Mon, Aug 09, 2021 at 09:51:49AM +0000, Parav Pandit wrote:
> >>>>>> From: Michael S. Tsirkin <mst@redhat.com>
> >>>>>> Sent: Monday, August 9, 2021 3:10 PM
> >>>>>>
> >>>>>> On Fri, Aug 06, 2021 at 08:55:56AM +0000, Parav Pandit wrote:
> >>>>>>>
> >>>>>>>> The point is to try and not reinvent a dedicated vpda interface
> >>>>>>>> where a generic one exits.
> >>>>>>>> E.g. for phy things such as mac speed etc, I think most people
> >>>>>>>> are using ethtool things right?
> >>>>>>> As you know vdpa is the backend device for the front-end
> >>>>>>> netdevice
> >>>>>> accessed by the ethtool.
> >>>>>>> vdpa management tool here is composing the vdpa device.
> >>>>>>>
> >>>>>>> For example creator (hypervisor) of the vdpa devices knows that
> >>>>>>> a guest VM is given 4 vcpus, So hypervisor creates a vdpa
> >>>>>>> devices with config space layout as, max_virtqueue_pairs = 4.
> >>>>>>> And the MAC address chosen by hypervisor in mac[6].
> >>>>>>>
> >>>>>>> Guest VM ethtool can still chose to use less number of channels.
> >>>>>>>
> >>>>>>> Typically,
> >>>>>>> ethtool is for guest VM.
> >>>>>>> vdpa device is in hypevisor.
> >>>>>>>
> >>>>>>> How can hypervisor compose a vdpa device without any tool?
> >>>>>>> How can it tell ethtool, what is supported and what are the
> defaults?
> >>>>>>>
> >>>>>>> I must be misunderstanding your comment about ethtool.
> >>>>>>> Can you please explain?
> >>>>>>
> >>>>>> I am basically saying that we probably want to be able to change
> >>>>>> MAC of a VDPA device on the host without desroying and recreating
> >>>>>> the device as long as it's not in use.
> >>>>> Ok. I understood your comment now.
> >>>>> Yes, this was the objective which is why they are present as
> >>>>> independent
> >>>> config knob.
> >>>>> Jason was suggesting to have them as creation only knobs, which
> >>>>> requires
> >>>> recreate.
> >>>>> I don't have strong opinion for either method.
> >>>>>
> >>>>> Passing them at creation time is simpler for user.
> >>>>> If user needs the ability to modify and reuse same device with
> >>>>> different
> >>>> config, extending such support in future like this patch should possible.
> >>>>> So there are two questions to close.
> >>>>> 1. Can we start with config params at vdpa device creation time?
> >>>> I'm not sure whether we need both but I'd like to see a full API
> >>>> and I think we all agree host wants ability to tweak mac after
> >>>> device creation even if guest is not allowed to change mac, right?
> >>>>
> >>> Yes.
> >>> $ vdpa dev add name foo mgmtdev pci/0000:03:00.0 mac
> >>> 00:11:22:33:44:55 maxvqs 8 mtu 9000
> >>>
> >>> Above API if we do at creation time. It is likely simpler for user to pass
> necessary params during creation time.
> >>>
> >>>>> 2. Is it ok to have these config params as individual fields at
> >>>>> netlink U->K
> >>>> UAPI level?
> >>>>> This is the method proposed in this patch series.
> >>>>> (Similar to incrementally growing vxlan ip link command).
> >>>>>
> >>>>> Or
> >>>>> They should be packed in a structure between U-> K and deal with
> >>>> typecasting based on size and more?
> >>>>> (Jason's input).
> >>>> I'm inclined to say vxlan is closer to a model to follow.
> >>> Ok. thanks for the feedback. We are using the model close to vxlan.
> >>> Lets resolve should we have it at creation time, post creation or both?
> >>> (a) Creation time
> >>> Pros:
> >>> - simpler single api for user
> >>> - eliminates needs of inventing stats reset in future series
> >>> Cons:
> >>> - inability to reuse the device with different config
> >> This can be solved by destroying the instance and re-creating it with
> >> a different params?
> >>
> >>> - This may not be of great advantage, and it is probably fine to
> >>> have creation time params
> >>>
> >>> (b) post creation time:
> >>> Pros:
> >>> - able to reuse the device with different config for say different VM.
> >>> - will require stats reset in future once stats are implemented
> >> Any reason for doing this other than re-creating the device?
> > Permissions.
> 
> 
> I would expect that CAP_NET_ADMIN is required for both cases.

Correct. Patch-3 in this series has the code for CAP_NET_ADMIN for setting the mac, snippet below.
For vdpa net device addition we do not have the check yet.

You/Michael mentioned that QEMU runs without any permissions in some other thread.
Do you mean QEMU can run without these capabilities?
If yes, is it fair ask for non QEMU sw to setup the vdpa device which has the higher capabilities than QEMU and after that QEMU runs with lower capabilities?

+static int vdpa_dev_net_config_set(struct vdpa_device *vdev,
+				   struct sk_buff *skb, struct genl_info *info) {
+	struct nlattr **nl_attrs = info->attrs;
+	struct vdpa_dev_set_config config = {};
+	const u8 *macaddr;
+	int err;
+
+	if (!netlink_capable(skb, CAP_NET_ADMIN))
+		return -EPERM;
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
