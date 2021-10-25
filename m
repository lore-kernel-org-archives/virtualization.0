Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B482C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 07:00:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216A26008E
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 07:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 216A26008E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CD273401FA;
	Mon, 25 Oct 2021 07:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m1YAWWX7F0cV; Mon, 25 Oct 2021 07:00:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 56D69401EE;
	Mon, 25 Oct 2021 07:00:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C656C0019;
	Mon, 25 Oct 2021 07:00:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCD64C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:00:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BDE98607CA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:00:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mhtEd4HTHyNy
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:00:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BFB23605A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:00:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJdPALehjiYMcngaW0V+3RYmqagY4W9KFB1sNaR7eozhWU5Z8yUlkxlPX3CgGNqFAMMZjstfdAnGceRmCm5EKdLAsuY8Ju1UfBKDmXLrD1V+5Gk04+4ZjrLjsj+Y8wr5pN8vQWRU+oew0+xwfQk3XNuzbLGTZF3af01iNOqyIIUAwv635p06wpBN7HaSggOH8ZILAJYY3PEpuZCGmM5cpB6kKbMC2/M4TM1gru1YOGSiQaYMNEtE4LMjNcPaImUmTAHcOAHPyHi6Hi6sCJKMhdCXR8APIFsvAhqrFxkIp4uZrwKbAGZi9YzzAFma73ch5L2HAaEaDLdq4kjBm/8DCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayynpRVIXBsnCh3nTyGEIu9uq1z/rQ315kFXLGfXoYw=;
 b=GDABMJzf+RHxWUtwsD9mgZE3u3WM/2un8O7piRkhtWB9YFjP71SufIPYyHY0yOVyTlGCqPLe5FFzhfguzb2bEFZVUrlccvv+MmOt6yzk9Jkxtw//21YSkDqoQlU+rXbpbi3qut0kGz56B+d5Hv+VKOMjMEfkUkvmRnZ3bG1EwpJHZNSeYSb5i6C24oxWNsV89Zn6JRXryfUCdFc7bVTTas5bKX+A7aGbVLMnOnpHaJPXAOxmwU4hggWjaB/6zfq+EgOIGMdyzg6dsvgU0zMy97+ir5PnolorG2P7CmKPVKCj/5d4MgdO2ah+jEa+hvpiRqYC70DSb/DzZ6OOLBIpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayynpRVIXBsnCh3nTyGEIu9uq1z/rQ315kFXLGfXoYw=;
 b=CgXC4bJcTG+dYOAg3R4lwwMIX/NASn4Fy1KXyf1grfYJeQo1RCqYVNSUNUukPXiZZbGsop3LLSuMV9YMyujzi0jK6iyROHixHPJHR6QmgPV1CekiTBFquvrGX4O4sLNEkZ+x9iI2LkvQwia3utO6NZoUqntpAJbbdTS3MPTMoxiEfODppcdd2CrtaO75+sDSZL5ba8tizzkavKfJ1tls7Y1EuR9niUTYdU3IW5Jvc/6qS+dLxo6H4dS/Yz9l0/qfNpll4POaSQ/Hq0divNB+sqfTJ32OtLd2cUAG5SxSB4N0o1Ynw7BTeI2sy19xxUEnyXazMd+3PbQrbQLHZiSK+A==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 06:59:56 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 06:59:56 +0000
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v4 2/8] vdpa: Introduce query of device config
 layout
Thread-Topic: [PATCH linux-next v4 2/8] vdpa: Introduce query of device config
 layout
Thread-Index: AQHXxpmyR8cFa1w650eZ8wWHy5IdYKvjP4OAgAAJjmA=
Date: Mon, 25 Oct 2021 06:59:56 +0000
Message-ID: <PH0PR12MB5481196C8E3509E55709C91FDC839@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211021163509.6978-3-parav@nvidia.com>
 <05bf6f39-66fc-cd9a-83d7-0836caf53239@redhat.com>
In-Reply-To: <05bf6f39-66fc-cd9a-83d7-0836caf53239@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fecc37be-38ca-45c3-311b-08d997850de4
x-ms-traffictypediagnostic: PH0PR12MB5450:
x-microsoft-antispam-prvs: <PH0PR12MB5450BB0DC4DD6874D4E7A972DC839@PH0PR12MB5450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uI5P6s8DhmQ0Bn1qTW9cjVgGPqCFEiCY2Vohop0qgSfNYWrymHIvJ4OwUGnNajuIZaVZa2ZGDheBJeEbQH1svf3QscLLD0R7dfgpUCzd077z6mQaqJqlj7XWR4z17G3XHBIT+jli3hbeSZWriVvp73XnZHeFnR9M6EnTWkrkIIurFzTJVY3+mmOMkSBrmBgpoZY486MdFr0ZZ7TBGGt0AOjN2pSIDR2VZYv11uvT5VKVipUf4UU4x3yJL8h6eUOCBaoCs/Nm68RYKZD0VUFR73KDmXVHNnS4s/RcuvdUaol/Jg7IV2F+ustiZ9InPgPD40l6q/7QOeNBbc4HVMqlUixrgbK6GgqO6DZE17wFsmS7Old95Rw1D6ZwgyJl9AKnLDF9VLfRh1kMbHtrX33jPaflR0u+xhMGZ5aQK3UsTgCkdPaJkbKXqXyGJv4lBWTIKwagMDUf8pmg5tpO6JXUE2Jrdh/hwGpuG/3R49p4iSjEq0otyv5CiX8k+FrURkJ5LVTB+q+zhAOATlRDpG5JQn6lUZHXjtF195AAMdyWPOSICqGmtBRz53/9RpaUonI54SSI825J9KSMEZ4WIW2t/tmUOEuivBFVr/qQ4IcejJ9eHYThsrPRqbXaPaFvpMpQtcErqkcbFmHB7Myb0OBmZ0RIczupb5p9n54t3k4qFHHUvgs96srnFys6IP2JDqCYUP2kxsZWL6rZFHIPYRjS7w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(26005)(71200400001)(186003)(9686003)(55016002)(6506007)(107886003)(122000001)(38100700002)(64756008)(66446008)(76116006)(316002)(5660300002)(66476007)(66556008)(66946007)(83380400001)(4744005)(38070700005)(52536014)(4326008)(8936002)(86362001)(8676002)(508600001)(110136005)(33656002)(54906003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?WlRXNm44V1FOczBTVjFycTBQMUoybytMaWtMbEM1QUpZWlkwaE9MUDRz?=
 =?iso-2022-jp?B?VnMza3lQODdYQWw4eWVMUVh4c0QrUDhNVDFYSFRMMzBYb29TeHlPcGFO?=
 =?iso-2022-jp?B?ZVdYUzkzUkpBeEZGWTdHNGlkVHdETHlBNFdxTDRMaHRPOHh0ZXZHazN2?=
 =?iso-2022-jp?B?cGF4VmxOdGEvODRLWmREYXpYMGpzOWlqZ3dSQ09YMno0ZTBSbWd1Mmds?=
 =?iso-2022-jp?B?OTliSjFnUHdlNTV2RzVrR1BtY29haTZ0QmJGNjEwV2FwaURhd0tFUlht?=
 =?iso-2022-jp?B?WEE1S3huT3lZR3NSZTBVTkE3VlhXcUxHNjNBQVBFaTZQMGpGaEpNUVU5?=
 =?iso-2022-jp?B?UGwzbVBCazYyem85OFRyNWhFUkF2clJSS0tncXhYNXFSdmFSSG5Jb3c1?=
 =?iso-2022-jp?B?YkVsaHZoa2xwNFJUbXFtTU0yUUxqZGlJbU1ma21rdHl2Y3ppOTh0RC93?=
 =?iso-2022-jp?B?Nlp2ZThSQ2FFS2hNNXVKS0JiMDU5VndvT0Q0RlFvaHZ3dlpHTkZmdFJ0?=
 =?iso-2022-jp?B?cEM1dG9SRUdQb0xOM0tvbm14Mk10Z2RTd1lXMCtFNGdOdXBZQWNSWVRV?=
 =?iso-2022-jp?B?RjJIZHhqc2tzMWl0eE85elNnaHh5Rnc3VjhnV1dUT0w1R2FPckRXNWpw?=
 =?iso-2022-jp?B?cm96bjZoaDBzKzhUVnpiV2U1aVF2dmRhQ2hIN1VEV3p6dTJNR0U3Yzc2?=
 =?iso-2022-jp?B?TFRYNis0TW91L0RyMnVWUHQvQXAzcmhpa1lUMEdZOEd0dTJkcWs0UGpP?=
 =?iso-2022-jp?B?NWtJbHQ4S2NjVmdMbHVONmpIOWRCQ1FTMm9CR2NDOGRjdXVCYzZYNnRh?=
 =?iso-2022-jp?B?ZDNjdFJrS1djRGxQSzlJQ1RkbVM5cmdoL0ptaXluTXZwQ0dDL3Npc3hK?=
 =?iso-2022-jp?B?WldVV0dFSWtHMXBEZnpLVDBzeWd3OHZ4R0dMaEhGQnNTeVpaREg4YkdX?=
 =?iso-2022-jp?B?dTFqR0FiejB6cnBRaHdyTFE1dWpnbFJFYVpNWEZYSFFKMEN3RUlWRW5r?=
 =?iso-2022-jp?B?dkpRMHlNMnRWMU13OFU4YnN0SnRKbE5FelNSTUY4VWdnejRWNHNqUDM3?=
 =?iso-2022-jp?B?N3dKaXA5ZHh6MUNVV0J1Q3g5U2ROVTc0alpFQ1ZYY0JkdThaTTJTWnRD?=
 =?iso-2022-jp?B?MkNjVzBvdU9ORGlHWVhURDZVck9YbEQyS1B3YTdoMFhkd05ER2hSbWJp?=
 =?iso-2022-jp?B?dW9meTd6TTM3eEIyS3R5VFBkaUpYbDVka2w4OEV2NDUyNGVkTVA3eEdB?=
 =?iso-2022-jp?B?R3VjY0xHTXdKYkVLMHpFZ1kxU3JmNk9QZ0FKNjlmS1JxV2xmSldreE50?=
 =?iso-2022-jp?B?M0trTUpudE9SZEJTWldnSjhTaTEySVZmRjUyMG1vcGVJVlVQeU1aVVFq?=
 =?iso-2022-jp?B?YVAzQ2NPN2xDc2FEaEUrNllnQk5yRjBnUWV1dkQ3bVJmUnMySlFERjdP?=
 =?iso-2022-jp?B?c056bDJndkFvaTVaMFBYL29oVVMzbnp3bEpTSVlDc2hKNGZNWEJ2ZFY2?=
 =?iso-2022-jp?B?a3EzVHEwSlJnRFcwZHpmeHMvUE03eWZRak8rTE5WcWh0Z08rQlRPMjlE?=
 =?iso-2022-jp?B?L0MvK3c0UUl2RW1WRnA2Zk1QYmlUclFDNXNXbUgzNFFWVXk4NjJIeXBR?=
 =?iso-2022-jp?B?aEExTHlNMG90T3RKUEJjSmsxSW0rRmhkeWNyeUVDZDVUdWxUa0habnVN?=
 =?iso-2022-jp?B?cUVqS3NWRXFxVzc1N21IMEJSRDB5OThDN1J2VU1hTWdMVHdiUWsvZnZS?=
 =?iso-2022-jp?B?Wis0Rml1TmpwRnljdTdYa0NuSU01YWJBdERQYzlBL2wxb3F0eGZ6and4?=
 =?iso-2022-jp?B?Zy9QcXlhaEkrOEFHYUdzN1VmaitUVjZRb202RkxiY29KL2lvSGp2b0gw?=
 =?iso-2022-jp?B?KzUrak9mSFhqYWZmVUQvTHBYTFNsSGQ1dFFnZGtHdjFtK2Mvd3ZBM3Qr?=
 =?iso-2022-jp?B?dzk4ZXNuZml4am1IVy8xMk5OYmphZkQ3Y2dDaGJJblQ2SHRTaGlqUVpB?=
 =?iso-2022-jp?B?ei90MnQ4Nk5Uc1ZPUm02cERjSmt6Y0J5UU81aGpxZTZpKzdndlV1d2Rq?=
 =?iso-2022-jp?B?SnJWMHRSUFYyN3FMT2ovN2E4cFpWSmdxYk9qR1RyS280VVhtSU90Skdz?=
 =?iso-2022-jp?B?clByWjM4UEtMYWNoaytWbEZVb2ZkMTlxeHV2aUVkUW5mTjZLN2VxaWFo?=
 =?iso-2022-jp?B?T0xLTDUwZjNEa0NYZTRHZU03b1ZyN3d4aGZoMzNjM3lQYUxIckYwMlFM?=
 =?iso-2022-jp?B?SjhNdnI3ZGt1MlN0QVJlOVNjTk54VU9Qb2J0VE0xb2dXZkRoSW1neWEz?=
 =?iso-2022-jp?B?aUxtQmUybTdyaC95ZDlPNGVrRUZ4akdQc1hEYU5lMzlhWjlISHZMbTdu?=
 =?iso-2022-jp?B?V1NJc0U9?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fecc37be-38ca-45c3-311b-08d997850de4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 06:59:56.7735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JTiy2tTNqcKaA4Gq6qwh541Vmk7dNJ53CzTYhyAIgZkeClDwh+Ros6GE1Ny7EBAkvGUV8R0UGsRNPmygC4d9Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
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
> Sent: Monday, October 25, 2021 11:36 AM
> 
> 
> 在 2021/10/22 上午12:35, Parav Pandit 写道:
> > Introduce a command to query a device config layout.
> >
> > An example query of network vdpa device:
> >
> > $ vdpa dev add name bar mgmtdev vdpasim_net
> >
> > $ vdpa dev config show
> > bar: mac 00:35:09:19:48:05 link up link_announce false mtu 1500
> 
> 
> Nit: it looks to me this patch doesn't expose link_announce but
> max_virtqueue_pairs.
It does expose the net status field that contains the link_announce.
I missed to update the example for including max_vq_pairs.
> 
> Other looks good.
> 
> Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
