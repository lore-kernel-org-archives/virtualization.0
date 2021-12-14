Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15473C433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 04:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A159B4013B;
	Tue, 14 Dec 2021 04:11:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GvHvcbI2_lAt; Tue, 14 Dec 2021 04:11:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 00DC44010E;
	Tue, 14 Dec 2021 04:11:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1DBDC002F;
	Tue, 14 Dec 2021 04:11:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB048C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 04:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9210C40137
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 04:11:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4OhHt0LQcE3f
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 04:11:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 03B194010E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 04:11:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCxYt4rxGmsWqQgzG6ybNrSgfMZa710ZuH82W0DQdU6lRvQfwEgF8tMIIAr6V50xAp0zPqqMlXF2s6DE+z6W1GHKnCVMMcutAsD4nN2myVbFstdMsCBHAu0k1JuPSBxJc0woB1YPPjB7Kdyq5BgmOpjHLaiuKDCqMBQc4sCqyl3kncAD4E/YBZ+smjrfvPG0xmMYXk5Cl5KUSYDXCfx9PEwIovuGL71eItie6l16OX32VoAJrPndttjus8hTk67/MR7FIjt/gSFy2l/OyJvziowNbg1PkMHdTStQAdgjK92+OT2OJQrAPCaqXm8SlH4f13oKy6j5XBsPVUH+OO9FpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ae0ogU0GdQ8I5OEd8ZypSRd89m7WA8PFKIXC+nx0SSg=;
 b=lSoT8l5PKDvxhxv1Mh0CkYIIctUJivP4v8puDH6u4iHKb5XSp7cZ0+pt1g9v5yr0BQqayyeGfm0pIU2SPYlrnj0zrEkUtu543bIEV6saNr7O+W4oiTAFvTx4bIWG/eTPco51mVsg1vfvRk9O10ZG3uGmy+4PYYVlewvM0tORmEzF7R5iu6MLIYCHwCX4ZD3D4ePKIzASQ7Z3COebcPeo3rt0/1+VyQWG2HK2iKUIeOU+cBxnbdX+4nhg3lChMQWNqtKdeu4v7UKLrFy7PbaR4Q7yr+m/QQjIR3Ivg9ng2apLXWrR9GEgP1W9YEPTcPMF4ijSCKe8MZ12+3OjhGEEog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ae0ogU0GdQ8I5OEd8ZypSRd89m7WA8PFKIXC+nx0SSg=;
 b=gV4bWR25f3namBjhSu8swoG+EIQ9tZM9jAF2lmoS6QlTYNHOypuWtmPhOW42NNNJ0V0RPFQp7izNkvRM6VsI1r9Xn+sIrI6g6osF7mW+OmzasRiRZQkthpz0bbwQk7NjGJDRxaWyTNix2UTT4XF42OG1oRrtOrZQOkInukSwwn9LjyEv4+RR5XZsC3/+ZVZrdZ54UXll/h20DkDMrXlBSDi3tRzhugzlMcd9MS8lZeEqI3GrUdX/wkbaFgw7yywiqw30+TBic5Bn6j/fX/mCpcdwXzyszBAfzOQu1KJa3t2YlB6VG8kP/Atm1In/WP0pQ+hfp1QFamAKR0bCO4jFuA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5466.namprd12.prod.outlook.com (2603:10b6:510:d7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 04:11:36 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51%8]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 04:11:36 +0000
To: Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>
Subject: RE: [PATCH v2 00/10] Allow for configuring max number of virtqueue
 pairs
Thread-Topic: [PATCH v2 00/10] Allow for configuring max number of virtqueue
 pairs
Thread-Index: AQHX8C/UxE4d/Kdx8E29CbnOstyc5awxUb0AgAAO31A=
Date: Tue, 14 Dec 2021 04:11:36 +0000
Message-ID: <PH0PR12MB5481B9C349742AE1E4D9F4C7DC759@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211213144258.179984-1-elic@nvidia.com>
 <CACGkMEtrpx-cEzRZUWJQ91DrwxYQJZqvjWmVAZ=YJX8oFVH2bQ@mail.gmail.com>
In-Reply-To: <CACGkMEtrpx-cEzRZUWJQ91DrwxYQJZqvjWmVAZ=YJX8oFVH2bQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8097cc45-55d2-409f-0987-08d9beb7d26a
x-ms-traffictypediagnostic: PH0PR12MB5466:EE_
x-microsoft-antispam-prvs: <PH0PR12MB5466FFC99ADDDA2FD2DB1B3EDC759@PH0PR12MB5466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sg2i+pCHgSXQdsEKdQb2Nxp5oHzijB655DB8mgQuKcl6+Mh1PXFN9bgjKZrIhwof5hiLLSFrde83Aet4ikdib3uxxKyU5AAuNd3TSPKpbAr37SPHg2z2rIIo8+lpjvDXd1xwopY3K9AbrtjGlXHV/jj4mdbx850fwLzj8IGOXrl8zP6l7XH4rihPLm2l8bvabs3HDkk2iG76x9blrUo8pVyeNEU9oPq5nkeBcDjAEdWDIuxrkTVBVAh4tlAxtDmx9HyDqL2WHDHAhwPiMXP/HtiglxFdO/UQdIds3QFcEIGS2+TwH9NXgVIdBO6S/WCN4I4IRb9h9muphNA6LByRYc/vn1oyFZYXquHJGodTY6axYcL7TtScJeOeeL9lpS2+Nl09ZnmFG5BoQ4FwAEvxPjSHWCJXeqQm2EZbz+7+Q64QJ310f9W0oe2mYmxBUGoXjciT8Wibn8ODmSsjJu49pBsyETMDyIBg1BgJ7oSOSSc+Ry7Y917aKH9x/tt0qhapthjzNhX1AgxDAWR4Mc8n79+Bziz5/2SppZ5iJ9tX/6gzfO2fmEv0GCZRLJKA0txKkaqvCKIFeLOc7+mTAj2r0wfRQjGjB6/jCz07cOfgXXXL/tw0VkDSUmkkXaxWdAFiOXMJgmr64BukRLQFIJTb1pFMiFOPd7EqIIsm14KHBaPwAt8vuGsQSeInJ3lYb47QTEq8UCkqBgbJhmrepiRvHA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(38100700002)(6506007)(8676002)(2906002)(7696005)(110136005)(66556008)(122000001)(9686003)(316002)(54906003)(4326008)(38070700005)(33656002)(64756008)(52536014)(508600001)(71200400001)(76116006)(4744005)(6636002)(66946007)(5660300002)(86362001)(66446008)(26005)(66476007)(8936002)(186003)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZSsxSGxNU1hpdXJIblBid2kyOWI3K3ZLVEJid0dqbTF6b3VMVFhVNzBtemlG?=
 =?utf-8?B?L2hSeHZGcWgrS0tJeHhkTmFKMXlKdjEwRHQvOUZObS8wRmZuUzFtSENkdGFr?=
 =?utf-8?B?YkhPTk1XL1JTSjhhQkZTUnd5bnRCbWFvV1ZmcEhYaHNwN2hyYjBWdGtNZCtR?=
 =?utf-8?B?VDA0b05PNWozYzErZHRpdEhhdW03LzVBSnlPOGFLRnVHa1VTZU5Md3Nyekpm?=
 =?utf-8?B?RUVqUUdwNTJrQWdhOVBoOWFsZW0rejdpSExFUXYyQS9SNGNmOEc1V1BJYUQz?=
 =?utf-8?B?dTdlNkEyQWpzaE50ZDlhVWgydGMwUDF2VkdnRGFlWVNXR3ZncjNHdXNVcmUy?=
 =?utf-8?B?UHYyL1lSaXBBa2hmUWE1UmdaT0dxakVvWUQwT251eENFOHZBVHZZdjNEU3lG?=
 =?utf-8?B?R1pmdlh2eW1qY0QwellpWFV5NERoS2ZJKzZJR2R3ZGhPa3d0cXJNcC9kc0tC?=
 =?utf-8?B?TS9Tb1JtZ0w4SHlodmRoa3JLOVphT0FCVityTkMvN2wyMlN5UkRDYm1XbUxj?=
 =?utf-8?B?dGhSd1BuKzAvNlNWbTJteGdEUTJ6cGlzL2xjRmdxMUpYNDNyY2Z3MTVMZlVP?=
 =?utf-8?B?L3RQOHVlcEhBWDF4ME4xcVQ0VzRrUFVJLzFUcU9UUVJ2WE5VQU9jcFJOOXVz?=
 =?utf-8?B?aVZMU0grRXNXOUdKWUhHdDJiT2w3ZnFDc2xXaFNXL3J3WEZHWldsS21WQU1V?=
 =?utf-8?B?NFNzWG4vdFk1M01td3VIQ0oxNmczR3hFUWdZMkI5WlFzdSt1eXZkazVLc2t3?=
 =?utf-8?B?UkxhZXVGd1lSeU40U1NjdkRyMHM2K1VTZDlac1FFQ2JQQmMvZEkzSzFnV0NO?=
 =?utf-8?B?KzlmWGsrN0YwTUdQNGZzekVlTEVkTXc2Z21Cb2FYTythdWZzYlF6ZjRRbC9s?=
 =?utf-8?B?dHdSRGxGaU9VMmtkYUNhQ05TTVpGRjJpUHBEZUk4TmdVbGRURnd3cjBDQ2xr?=
 =?utf-8?B?cG1iZUxVMDVVU2R3Q1lEanNmQWV5ZDlWM0NZeGZoVWppWDFYQWRXVyt4S0JV?=
 =?utf-8?B?U3BwSzRWVkNLUnZSTmJwMUI3SEdVMEFkRVprK3FDUmRtRUgxNkMxUGJ6S0Nh?=
 =?utf-8?B?OGdYSWZYNGRvb3lRWXlIN0V1ZXY5bGs3d3hQbVNlSm1oRmNFMndLc05LZmJ6?=
 =?utf-8?B?MzdETWViaEVaVlBHQWs1UytxUlI3QjBwcDRZWUtOVDBGc0VPS3JVN01SeThy?=
 =?utf-8?B?K1NHMFdHOGtCUTNmME5LZTJrZm1MejhiSEh3Y3lObDd0QVk3NGFIN2VSN29s?=
 =?utf-8?B?QXBOVGkxZW1zMmxYalRnZWNBMy9IbG1GSlFFMzRYc1ZxeXA1RjM0L3hhVTdw?=
 =?utf-8?B?NW1SdlFYOU1IaWgzMExrOXo4bUlKb09SdC9vbzFBSTI0blhBbHJaUHJER3Vh?=
 =?utf-8?B?bkNnUXZoS3NXNlJId0hBdjZJTEN2WGNJWkNwVzY4Nmx4TVRjNjBvVnlKSmRH?=
 =?utf-8?B?Sk9rVkY1SHdvS0p1djBUdFJjcjRmUHREOGhkSlZmRE8xazlrN0E3cy9tNVdu?=
 =?utf-8?B?KytwVUZYS0psejA0R3IyeEZhZEVvVUlDdjJiTVRZVGx2d1JsUm5DQUN1V0I4?=
 =?utf-8?B?bngrSlpDVHpxa3lHb1JOTEtOYmJJTzBKUURENW5QTnMzYmlXQVFxTFNUQnZq?=
 =?utf-8?B?a2R0elZ2ODdwczhhUkwvdlc1WHd3WUJmSWZqZWxlWFRDV1lwUHltd3lIbVdH?=
 =?utf-8?B?WmxiQkN2SGxkeVhYSHpza2I4c0tXOHZBMmxKbEExTUZGZzl4YUgyZmtmcksv?=
 =?utf-8?B?OXJVUEdnR0FjWlBrUTNNUDQzRUJTTW82dncyMmthM05sQ1RFT211NENrbG51?=
 =?utf-8?B?K0N6MytLUVRWTmM3WGIzbGsxZkdHc1IzUm52SFhVY2dIK0x4b0tDQ285VDE0?=
 =?utf-8?B?T3ozTU01blBWck1hNGkvMVVTa0ZITmlVTmU4cUpNbmdOU0VZbzdmTmNuSWsx?=
 =?utf-8?B?b0ZlQndBRkZiSlA1Wmdqd2g3MDNpOUppekNLTUU4OWh2OEViUFF3TXkxMjFm?=
 =?utf-8?B?QVB2RE5Nd3p3THdxZVZJOHVGVkxNR2FkNUxXc2ZIUHBEK0VFeHAyWitPYWFZ?=
 =?utf-8?B?eWo4SzhaQmhjRVZnMG1kcUlINUdoV0UyUE45MHRCOUowZmZYTSsyUXU3MzRH?=
 =?utf-8?B?cm1GWm16c1VoZjBtTm9vVDJ6WkQ0UDJGM3hEZC9yN1hVOVpVTE1taXZPdFBQ?=
 =?utf-8?Q?G49VQN9MlfhP/TlM2t+96gA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8097cc45-55d2-409f-0987-08d9beb7d26a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 04:11:36.7455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EYKI5ZSlMod37Le5jU6652T89KcdtuW3lOw0EqBaVo+w/PRAV8IKyYkqd1VMffmA7LjAJjfb4+7h/oOqFm1/AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5466
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
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
> Sent: Tuesday, December 14, 2021 8:47 AM
> 
> A question, consider the parent support both net and block, if user use
> 
> vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1
> 
> How do we know it's a net or block device? Or do you expect some block
> specific attributes to be added?
User should pass the virtio device id of type net/blk etc when creating the device.
No such in-kernel driver exists so far, so when it is added netlink interface should be enhanced to accept the optional device id.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
