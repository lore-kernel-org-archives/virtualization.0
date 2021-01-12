Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB09BC433E0
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 04:14:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2131522CF7
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 04:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2131522CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 917CE86767;
	Tue, 12 Jan 2021 04:14:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w2Nlw3fTp4YO; Tue, 12 Jan 2021 04:14:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E5E5986196;
	Tue, 12 Jan 2021 04:14:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5F16C088B;
	Tue, 12 Jan 2021 04:14:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 198DBC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 04:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F32C186767
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 04:14:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kExgDTbNGLCI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 04:14:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 61BDA86196
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 04:14:43 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5ffd22320001>; Mon, 11 Jan 2021 20:14:42 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Jan
 2021 04:14:42 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 12 Jan 2021 04:14:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8OwCLar13GCU0OpF4UuUppRFsrpZ7tUBUoKFjj2fSLYIFpozwZDeLd4pc2zgSWotVSx8RCKP9/v0jgsjhHUc3GyVW/4MTqjUF2N8tPSU9ELdbZnRv/va9gP5Qy50WLiq7UFNeiKWgW0s4FNey+pTSIDnNr4uK5C9qnx8NUei8IpdkbN958m91gWpYSfJBT15LLhQOsgQWzQXLDaA5QF1LD/JdjrATXkrIHrQ/X38RHZtZPKD7zE61NDVgUGGLD+pYhe4ys9aqtGwizdl/x1dcEOSHnIqtz7IxRfsy8BBqzEymsT5buYawbwtdtGMGPq6faIcBxVEfX+xUeWnKkW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1FIp+qJHt7RrB2XJ9r3itdm8rqzk/oc3KDhmY93bm8=;
 b=kO5YEVo2l99MdqjIjdMt8ggIZOHfcCT6Fxajhml5E/eibqLr7mSabXjiwymupaeofylkc+RstrYeeMd2/idH3edzF9dsopflio1dBAkX2GnoEckxqub+dobW3w7NIbV2kH08ZVCEMAWTegX0CqQlvRbpAEaoDUHRL+ISPTE6c+t8JmczNraTDHJohsV7DlggmykmS9Nt7CKS/yqgAeGrLcRRwS4MyQPpelJ90yPBzFIzBxPzlFjhkFPLDTGXcT3SpyjalDzscr+grWjW7Yw1yRVe8k+zbbwJtZCbhzLqpHWPu9nVmKuXjSc0q/Z9X96uZz9ASbtkpU5fYtXr1DK+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB3269.namprd12.prod.outlook.com (2603:10b6:a03:12f::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 04:14:41 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%4]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 04:14:41 +0000
From: Parav Pandit <parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next v3 6/6] vdpa_sim_net: Add support for user
 supported devices
Thread-Topic: [PATCH linux-next v3 6/6] vdpa_sim_net: Add support for user
 supported devices
Thread-Index: AQHW404ZeuD1Nrf6EkKQQnhYNrY/9qoY6uQAgAAB4oCAAAVhgIAAAsjwgAAQXACAAoNJoIAH40dQ
Date: Tue, 12 Jan 2021 04:14:41 +0000
Message-ID: <BY5PR12MB432279609B19E1F4F0627652DCAA0@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20210105103203.82508-1-parav@nvidia.com>
 <20210105103203.82508-7-parav@nvidia.com>
 <20210105064707-mutt-send-email-mst@kernel.org>
 <BY5PR12MB4322E5E7CA71CB2EE0577706DCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210105071101-mutt-send-email-mst@kernel.org>
 <BY5PR12MB432235169D805760EC0CF7CEDCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210105082243-mutt-send-email-mst@kernel.org>
 <BY5PR12MB4322EC8D0AD648063C607E17DCAF0@BY5PR12MB4322.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4322EC8D0AD648063C607E17DCAF0@BY5PR12MB4322.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.171.231.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d137087f-06ef-4739-eb0c-08d8b6b095c3
x-ms-traffictypediagnostic: BYAPR12MB3269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3269E4778E0D6D0D3A6B8066DCAA0@BYAPR12MB3269.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TXABty8EbIY7tNboWKDVpkkASgAwHlkpotf5DqH9XmjNe4Ufs7+IZYR/cUVMf4+uNEhofp0MgtArpJ0tDJPLKH0/hOO+2pZ6riskKXX1e+PDEZEym8Yx9Pig+MSVmeGTDE7CSTs/ebD7+UUuNIfXl/96zKhms7sYnMGF6qSru9Hv/7JRvaH5yJZdlwIbm9+zRpV0out3kAu47VOIuY6Fuae4xmt/4ZVCm6CgwjmaXqwjbksKg+x7oepqsuz19ryrAoiwbmzn6e12twXRFCY45Hx6qxPDhWTg+AEFupCql9vQ4Gi9kF1ZJIpmeLz/IligJh9IDHbCKAUG3O8vbe7jEy0QUSmYvSYpGOAB6uqMmz0EXFO7RbFeL34lZWIL1j6e4G3AQpVG//GiJL/DUOd6nA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(316002)(4326008)(2906002)(76116006)(5660300002)(54906003)(71200400001)(64756008)(26005)(66476007)(8936002)(6506007)(86362001)(66946007)(66556008)(52536014)(66446008)(33656002)(186003)(4744005)(9686003)(55016002)(8676002)(110136005)(478600001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UDlPxl4joN0fAWTlmP/hLYPU6mAhuD1KbcvRdTkQK6lO9VhJkxYB7m1PzbxM?=
 =?us-ascii?Q?AZJmEAIXxuUKS1yk1spm/FyF3LBHv97vxwZ9z5Yz571IAbYc6O41tfcyYg+H?=
 =?us-ascii?Q?cJnIPA0SKoLHv/fSlgT63ctFudFLH0xbZEW4ulbqrBlvvcfkqcPzLtvcC7XU?=
 =?us-ascii?Q?vmrZGwkbDcQiSe7Ag8OM152RrHg1bgEeLASE35MmOLIfkiskQ1Hb8kaSvY34?=
 =?us-ascii?Q?v6e9QUH+SD9Wp9y3YOgRdqhNzxaeCpUrM2HPfqGssKTSIhgBUfiM50pXA1Ow?=
 =?us-ascii?Q?E/eClWCTdUT79Xjguf0AvedgsT9EEr43NRlF8luPyoHYILPhiuqN16Dst3SN?=
 =?us-ascii?Q?NjfuqsdSfc0yCe7q/LOFSaLsZ4aJ2guT0PZq8eyDtSdkHXaEUkz+28PXA+Ya?=
 =?us-ascii?Q?JjbebiylxBBNh3Un8tZqlYp2enRabp/MHxDy+u0Ql5F+cxOLwev6+2Jo/z9Q?=
 =?us-ascii?Q?7RkMdUYM+8idd0wkaQQWUKMUa8vLYMV+iC6awMAzEEFnn6CPjzIEzC/VeJgk?=
 =?us-ascii?Q?M8sh3blmIV0HTor5SxcHBa7EcYu0nNDQsS5Db5wlH2ZWvXx2DgeQpNA8jrj2?=
 =?us-ascii?Q?lZvzQfWZWeU2JGJvC/amhMHnn2ZSjM4J7Ho8SmtaHbbD3laOwZwTVqaC3Q1h?=
 =?us-ascii?Q?c5GZt1skXbB36HQ4EL8FT+4I7ggYO14NWHx8x49Wv6GzTRSU9SPL0plMtLJI?=
 =?us-ascii?Q?tZ8GJvWxfYN3aEJVdKNF2vZuuYKOt37sZ6mcJHiE4Jmie4EgCtAGgjlKp3J6?=
 =?us-ascii?Q?W0SlSPy5t7XkjStaEDKqf5ROq7LWZqDVAfVLXn+1ibcJKbE0O9a0PVQyhDqs?=
 =?us-ascii?Q?DyelBveINB32fD6QzrTOA6Rpcvk2AesjUMKnXCz49WSCM8/NmuVOeOR/BqZO?=
 =?us-ascii?Q?SNvASbXu+QzZ4Dy7FMsvALcqjfwTvV4katxqwUUO8+6kgxaabnzQuxSqH5qw?=
 =?us-ascii?Q?BEbEYv832BrVirXotu+zdcYVB1ep9Yf7VRLTB1+iIWo=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d137087f-06ef-4739-eb0c-08d8b6b095c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 04:14:41.3898 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LVrvJuZ8CJlY5JbUYmvQ5H9olQHLqsAwFThqbvI7dh+4w760edVZ20pCWHOHaZl24DV0xtv5lSuBONyGa1h8fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3269
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1610424883; bh=A1FIp+qJHt7RrB2XJ9r3itdm8rqzk/oc3KDhmY93bm8=;
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
 b=QcfOzq9vkqZ8YRmONzCt/Ho1tRLLOPRjAARx2ayegkh7TvgqBjHv5t7lu+NfqMMm+
 sdGXODkD5RbllY1rdmDsZIDp50RqYUzFiF9IwsQQWbHJDOscOXRJbgNpEV+y2jujiP
 UpwjDuN0ey6tUtvZfiSMP73oySVJ3ei6ccN9BpddySa26k1lDd2BIb55Hi2fFwgD7q
 kVnABX8C20macZgOnJpZqo9dAAPuH+OiNgT1WzLuDU5WoPH8tYrnSWvWP0iULEdf90
 t1Ih/YVMAzbA7LqtmN7tRyHyBiiO0lmHBJOjyvOaszEBxF+bxTyC+UKZbPaDFrRkqP
 yc0vgJpFfsj5Q==
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Michael,

> From: Virtualization <virtualization-bounces@lists.linux-foundation.org> On
> Behalf Of Parav Pandit
> > >
> > > When we add mac address attribute in add command, at that point also
> > remove the module parameter macaddr.
> >
> > Will that be mandatory? I'm not to happy with a UAPI we intend to
> > break straight away ...
> No. Specifying mac address shouldn't be mandatory. UAPI wont' be broken.

Shall we please proceed with this patchset?
I would like to complete the iproute2 part and converting remaining two drivers to follow mgmt tool subsequent to this series.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
