Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0882DC6FA99
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 13:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8119082278;
	Fri, 10 Mar 2023 13:36:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8119082278
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=O6CacF+L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QysfBMP7JVLz; Fri, 10 Mar 2023 13:36:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E5AD082258;
	Fri, 10 Mar 2023 13:36:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E5AD082258
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9802C0035;
	Fri, 10 Mar 2023 13:36:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE705C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 13:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B517E40374
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 13:36:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B517E40374
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=O6CacF+L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RMDzYjSR-wWN
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 13:36:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 929AD40123
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::606])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 929AD40123
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 13:36:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPF210vlpYFKIXzqkYGfDI6H2m3lCGRXfMZYDftjTXORbYBdJkN4doguCl0f8YreJn8Y9LTpp1Pt3A2+KWBM4hD8S9ESPb4rn54Waeqqb4iqXRnMik0Osw2gI6wcmtV0kiaD9CJrLFE/R0fzZCOcY/fvgFMRoyC3MhnYbkpIG0d5szXtnXbBOZiThfX25ni43ASuiLDfTVy5t0ZY5xONLkxpa//nrWquWg4O6RHw+eWjsX328PtIZtIlswZx9mNEAw2jqfqmwfwTsu37kChoFajTgzR7u9CAlAEJhFaG62XU3wxd+gYJ57fvoWiXxS3Pf+KyhizuK7HG/RKNDp1O+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnvVfR3B0/Ux1Pywxa4FvCOz5ni3yUii3NyMENoF3Ns=;
 b=Hc75GaVCTkokyp+lmTYGX1k31t9+hgXDd/gEXxn/wQoLbugNNtFSBsu3b0JYGAJkJ4UB0Syey3LmOtSvK7DTivVAPxVIIMVNLJs4x0q2d5AuVWujHC5hhJ2qUh/QgMDvgOo2KXndkve+zd234+/cyyaotMKG9DjpJBMhEcs+5IeZReT3Z4LBz7g9fxKY0Vz9FsYrZcSGqua9IMKfljR60nXphN9ID1ooRdkGv3TWKhempbJiD4KFNPghfRFEaje5K30eWIKqu6g64diAE77MXrz7KwLTiBxOYPtf9Xs/hMQw1G+rWbhv0DcoofrEj/MR3w0WsCVXMLz9/WaN6sYL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnvVfR3B0/Ux1Pywxa4FvCOz5ni3yUii3NyMENoF3Ns=;
 b=O6CacF+LktoAXUXbSv6OM8zuSYM5ahhC054MiVWRYJ5VzTD/z/M5rqQnbZjSNJ/0pUAZ9BFrbk5elVwYI7ksWNz2b7PoV2rLcZTKXbG9z9jsTglgk3KwBKf38CE8DbRz95qyhx1MLmU+JcgHUWdARWUx6eTK5w78Q1ZkGWTIsiYZeQGrAhlBwmRV9VXyXTaEncEGWkM/Pa0Z7d8eePzLyq/YzwQa+cO1PNH6IPKOeYSc7rcz6zB4P4ZuXpAmy+ZfNY0wXMXjza6Z0vwvK1N8Yxifrj9oMi5SemgJfUC4NfjMQAy0TWwpdHEPgP0bZKX2u0XpzVuexKUnF3g9Fki0Ig==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 13:36:35 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ee61:8dc4:14c8:7cbb]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ee61:8dc4:14c8:7cbb%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 13:36:35 +0000
To: Feng Liu <feliu@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH v2 1/3] virtio_pci_modern: Allow non power of 2 sizes for
 virtqueues
Thread-Topic: [PATCH v2 1/3] virtio_pci_modern: Allow non power of 2 sizes for
 virtqueues
Thread-Index: AQHZUxII490ikX8VQkyQbTVcmihFNK70A7dg
Date: Fri, 10 Mar 2023 13:36:35 +0000
Message-ID: <PH0PR12MB5481188C606714C32353ED88DCBA9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230310053428.3376-1-feliu@nvidia.com>
 <20230310053428.3376-2-feliu@nvidia.com>
In-Reply-To: <20230310053428.3376-2-feliu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH8PR12MB7255:EE_
x-ms-office365-filtering-correlation-id: e7c3a40c-0ced-4333-2faf-08db216c77e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ba7jfMaml70IQNVsI+yBLHjrgU2mtnrA7H3N1g5PBOkCdsywJaPP+/5YAV00Dz0raO6oqNMLuIjVdB7Lkxjlvr7ozdOwD812VgaccaorO5Z6d8rKSSpWL2ximMT08J7vXG54OlS5JggKPFn8F6jfz9oe++Mw/hahRFXW/p1Thlt9rYwpjQy+/pdvAmZhsqA6Io60z/IqOqMeyRpBwtEv7KX4FuVqb7YQdJ2d+yt1pAtgZ8M/Nfme8TZR3p4kkAM2pXlLa9LL4lVEE1GxXCZ+tZ26MFVXWouDWMxhEjsliGwaX+fNk2DykxJtWSmYKjTzxXB0Df2aiD4wT90A+wAFQnA05qltaGJOqWA4WHEUjl1rhfaNF18nz2USOIRXdfo2lWQFiXdueKJqcXdNZfVrbe8b2h8NnV8ygi3K7JRTCEiSEnymvUAisibxFeMI07D/7nZmQqXIbH18gAYcNeGx+ZWWVhiW+GBzPY/eqsr7zv2u/XszrXJvSI+uBqob3UAMeJlq/RrH+hEpFqgjCVTHJUsGj9e1f/WTLQkAQMPnlhswEzwQf726PsScqNqdqLSKkSsnxuWJ2IusrVuv+8bfU6oMhWh2cYXC4tqzriMbXA5AyRHqz4G3FNJ7hJbsQ61Z9tyfex45ZK2bAZUbk4c7ViMn8+NUUjCeQ/1OVe6Otu93E1dFWj0ECJ0qmtK+Tt2TsNPZ8GMgm2gmyjEqL6tdag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199018)(55016003)(7696005)(71200400001)(33656002)(186003)(478600001)(54906003)(110136005)(122000001)(86362001)(316002)(38100700002)(38070700005)(26005)(41300700001)(6506007)(8936002)(9686003)(5660300002)(4744005)(52536014)(76116006)(66946007)(66476007)(66556008)(2906002)(8676002)(64756008)(4326008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/t5fBiVWXJkdiWp6NrqzgIrPvfCEWrKb3nKEXLpvZye4Bmcsek5R0H2BdMSU?=
 =?us-ascii?Q?oma6eif8ym/pfs04EhD3ggmNmzy0uyCuVEbSmapsU2jb9QEVglLbLZ0KyWgv?=
 =?us-ascii?Q?g3VS3sxdyZljSHCfNWU6rUXAri1PrXTS1DfJIMNNCTGv9TZHYhoeQ5/hXlyD?=
 =?us-ascii?Q?uIRLVbMIquxdbUlXAaH+AtJ3BRofKMq2GPQhUJ+/O9FLKtryKLMaxqliPmJu?=
 =?us-ascii?Q?1z6A8PUesKpQKWuh30vLYVICzeI8yagLLs4zp/D7iQfdzQDjGd/uQCNbTPXF?=
 =?us-ascii?Q?CFLBEdg/koWz6N39/X+6YB2Vs/3J5NdxxY6y1uW+jlWkRP00gCtuPfone17k?=
 =?us-ascii?Q?GEa4sSmMyg5MLnL8TW9Sd5m42HnS/9pXjcrX2ouk5l0hotl9aJwQpgDwpNqD?=
 =?us-ascii?Q?9Vm1iH5BDmFhGJWISoBloe9bdjcyBUEOrL/PHBL4iyh9svKBfR8/upDRVhCu?=
 =?us-ascii?Q?59ZtoMRG8JVEBtom0/XT2+XbfNyqQ+PdcT47ALOFsW3zUa2hcN7kYrxEiy40?=
 =?us-ascii?Q?s2DXAU3x80kwOScmiqfVt16pvzVdC15jMquKQ6v9lxaA6HyBVgODGKXybJiW?=
 =?us-ascii?Q?hOp7pIPlqH7FTX4KEHJrXKVoDPAdsKZUMWYx8RnzxDKzB1MDTU5JEopswGeu?=
 =?us-ascii?Q?Xwn+5jy+dmDB089Z70QzUmKEzdrW65MKu5KTv65XRotxS/xaHTBZ1h2Hj6p7?=
 =?us-ascii?Q?MEs9CqI9ImjjP4hG1hjpNwWHgzJbbTJoZxdO/XIxTs8Ei51EW01yHf9RA8zY?=
 =?us-ascii?Q?neyhKeodsbGhgrc1/o0G4kd42VhZxbD2vf+f4p91k/zolTDLkmcGZVgGcjgQ?=
 =?us-ascii?Q?/m7mVgzNubOwKNvVo+Z1njbJS7qaHod/VPzIY/DFgF+AAZc/8BrHgFzDqlpV?=
 =?us-ascii?Q?QKzIHhqT/deVJSh1NoN4p5I5aehnq/+af7I3eYDgHPB1dKXkvZAzwHwjAeGT?=
 =?us-ascii?Q?wjwTrSrq/xehDZF/p4IS1quTkMCkf0gIFvYEsQdvqySnDE2jDsoJn+8enn/L?=
 =?us-ascii?Q?aAgBFoPM/gnN+5hYHLS/91ayH65thlaG6JdpxxjAwLF2qkRwam92TZvCgG7O?=
 =?us-ascii?Q?ma2jf5ePwR39frW0LM6SDunVaOrK4/YjTGNijUkWH7xlqG/c4eu4RhZ5M/cU?=
 =?us-ascii?Q?WOUJj6PYRQOXLffd8bFUFYCFNXr/Eptzin0FYCJsH6F8xFucE7C0PksuQQcu?=
 =?us-ascii?Q?Rh15b9+G2OtqCxjOWcQSB0TXE+5OX+Z5Cbo9o3bhmYO3gEPGTA206wwOCQxY?=
 =?us-ascii?Q?MfcWzT+eE8HBxM04DbvUQmAMz7KKYTb8tLZWZXl5vs0gM+V/nEsHVIleSAYk?=
 =?us-ascii?Q?LHBD8BFeOdni3JDuVWviX8I3vPLyfShyg3BXDJVPsMwxboIc3cANwECzSU9d?=
 =?us-ascii?Q?iQmibxX85Vxt9W+X8w5dexRBOqlOrUUymbB7j42PF39FuhI8oHBgw6oyM57f?=
 =?us-ascii?Q?LKQrIHPhzRBzzGUY+G9GQz/Xo/4nYA0AnTLf5X1AhT5hahSOznD9u+lOK0DX?=
 =?us-ascii?Q?DuSEysvoyTASnPnhhYCDFj1OTvzNaPPbO5020CI33jtigMgm3xXLXn74BTN/?=
 =?us-ascii?Q?YPOeDTRIGjd02vzJu0c=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c3a40c-0ced-4333-2faf-08db216c77e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 13:36:35.4085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4VB3KiemZKZxvhC0B+PwUe1rvkeNb+RgZVzZDgGPdzgccQm4RVMAP19I7Euw+AqN7GpBIZwfJtAxoutuUOyOrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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



> From: Feng Liu <feliu@nvidia.com>
> Sent: Friday, March 10, 2023 12:34 AM

> 
> -	if (!is_power_of_2(num)) {
> -		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u",
> num);
> -		return ERR_PTR(-EINVAL);
> -	}
> -

The check is still valid for split q.
Maybe the right place for such a check is not the pci transport driver.
But layer below where split vs packed q knowledge resides and hence, power of 2 check can be omitted for packed vq.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
