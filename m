Return-Path: <SRS0=OmMZ=GV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1D9C433E0
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 18:04:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E487522CA1
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 18:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E487522CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7ED03860CE;
	Mon, 18 Jan 2021 18:04:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y-X+X1bwEfH7; Mon, 18 Jan 2021 18:04:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7543086030;
	Mon, 18 Jan 2021 18:04:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6241FC088B;
	Mon, 18 Jan 2021 18:04:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 187F8C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 18:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F30E6860B5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 18:04:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F4k6kUyM1uwn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 18:03:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A91AC86030
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 18:03:59 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6005cd8f0000>; Mon, 18 Jan 2021 10:03:59 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Jan
 2021 18:03:58 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 18 Jan 2021 18:03:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDdJ0ipda071ldt3RsaEBVN1pbie8bajELkHjgg5T57AG69vs3ClOP6HZTLTJkvs0HETDzZr8Uhyt2Ad8Lk5a7jE2gL4wHeevPdwjBQltGtK0us7ZKsJvm3slxmSj3kqNjiXKOLI7ynzQKJ58pUypUj2MBk67g1Is/FRg7M0Hk0yEuD8he4cF6jvaUW+AxAHkOfz/xTB8Wv/Ti3TBoq2Lh2urDTyLGDUJO9JCzJkxPNOJ/jDbzt+jFGINaU/K8QrOpYKPrUF8URYYfhBBSbOP6xjvF7/I9nYUh/Wd1d/4ly5GclrBo0AS5u5ey0X6f048Fz4vRzEu4/3N4oN1Gd0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/iOP/l4GpqXY6nDAMxJ++R+44+aQ03UyIOR0+7AABk=;
 b=nU0Y5e5R7YdlN4EQfwFVlxkyHYUoHUdWGfe4OVDuGMNnPfN1nVl88wGs+ZdVYK2jT/zIdDS09O+dTjpR8iCUoEBL722Zzykznx4r9z1RLNir/pEC21qFruQemlozpnSgPgx5oUL51ORH9QKlISZG/dAFSbmMekIuwVpo9Tg5vAPqwKV+MralXlFTPzEV6zK7nzhNgNqHJMX57XadKoDRqqirqBtVetOJOrw7a0tb7UbZnwuqikZHzNIwTr803wpG/vvh5CWWRJ7TrqciNbJ2zjbBTBNrFGOqyec6RUG9GUj8ZseOxBQUzuaNmhTM/0VpszshPqJkLxYQpX4cpddcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB3730.namprd12.prod.outlook.com (2603:10b6:a03:1ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Mon, 18 Jan
 2021 18:03:57 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%5]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 18:03:57 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next v3 6/6] vdpa_sim_net: Add support for user
 supported devices
Thread-Topic: [PATCH linux-next v3 6/6] vdpa_sim_net: Add support for user
 supported devices
Thread-Index: AQHW404ZeuD1Nrf6EkKQQnhYNrY/9qoY6uQAgAAB4oCAAAVhgIAAAsjwgAAQXACAAoNJoIALCUSAgAAyM0CAAXa1gIAFhtvw
Date: Mon, 18 Jan 2021 18:03:57 +0000
Message-ID: <BY5PR12MB432239B28EC63D80791E1459DCA40@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20210105103203.82508-1-parav@nvidia.com>
 <20210105103203.82508-7-parav@nvidia.com>
 <20210105064707-mutt-send-email-mst@kernel.org>
 <BY5PR12MB4322E5E7CA71CB2EE0577706DCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210105071101-mutt-send-email-mst@kernel.org>
 <BY5PR12MB432235169D805760EC0CF7CEDCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210105082243-mutt-send-email-mst@kernel.org>
 <BY5PR12MB4322EC8D0AD648063C607E17DCAF0@BY5PR12MB4322.namprd12.prod.outlook.com>
 <66dc44ac-52da-eaba-3f5e-69254e42d75b@redhat.com>
 <BY5PR12MB43225D83EA46004E3AF50D3ADCA80@BY5PR12MB4322.namprd12.prod.outlook.com>
 <01213588-d4af-820a-bcf8-c28b8a80c346@redhat.com>
In-Reply-To: <01213588-d4af-820a-bcf8-c28b8a80c346@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.167.131.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd1111e6-6e3b-4ba8-7997-08d8bbdb6cf9
x-ms-traffictypediagnostic: BY5PR12MB3730:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3730B90A9B798EF5EAF5F4D4DCA40@BY5PR12MB3730.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M1zPhIyb67s4o5vp0BwJfMZWuPOeCQ7PSyagXOXEdEkyqpU4FF/TfeUXXWOwvkiUDSOJO8io6Hf2Jdpq/vUjY190rEtTJysIUl7nk+4wgL1SNpGcAW593KhPzJ3xDFejKHtar2kvRX02vbSzbDlZnKyiYdbp3RzhaYPomgD6y/oNccxOKzSS5RWkqqYSH1YiPjuQgv02tG2RIowWcz7gyeC49jvAZS+Ka8oKRNfXwhTaWe9PnTdHAxFzn8Z1Cxq0FiNaDkmVyZi0wGiDGH3ENY9tZh1y626Al0m/XDi78n8ZSFiYGafumIpXybS37ef1XXrfYiOy+bVguwXEtKOgw5ITyfB2qLY+Xmcn2uo3LL3IF6G8IjHPaqPXl7BpmIi3NVf0+MksrNbIk9f/pkpMgQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(478600001)(66556008)(71200400001)(6506007)(66946007)(64756008)(33656002)(4744005)(66446008)(5660300002)(76116006)(66476007)(86362001)(26005)(52536014)(186003)(4326008)(7696005)(8676002)(55016002)(9686003)(110136005)(54906003)(2906002)(316002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?d2pjcXJIOGZIek1ycytBbWZHTEdFWkZJalJ6Y2p0Tm1CRFFLejUvQktDRG9P?=
 =?utf-8?B?VFZGSVBqSzVPWEp6bEFRWktWMzN2alFPZEFkUXlWclZ4TkxwNU83MmVDbnlv?=
 =?utf-8?B?TStNWFhjVWR4SGhpUC9kMm51SUFKVFQycUhDMjBLazRJU2dzV2ZVQ0NFTTJX?=
 =?utf-8?B?b3IzZXNqejNFRVYvNm9Ya3I5Wk01Rlh3QVdTZHhBVWpEQkRINmRiWEwvSXl0?=
 =?utf-8?B?blNuaUw3eXhEWkVDdVdFVm9oc1ZHYUFDRGZNRkUxcGc3UDIrdityaVMrSnFj?=
 =?utf-8?B?ZERJRkZLMTlaNVRFeDJzVUkwR2tLUURUYW1rV3ZDRFR3MkJmd3JQMWJuRTlh?=
 =?utf-8?B?UkhQNm9lTUJhRTRZaktNcU9jdkFHU2szNkVubUVYNWFOMzBzbXUvUXlvWktH?=
 =?utf-8?B?aU1jMC8wRGJFajlFR1RyTDJsZ3lWQU9tMWRxYWtpbWh0L1JDcnJ4VjlSb09B?=
 =?utf-8?B?RDNlNDZxTHBjdGM5U1BkdDkrTEUwcG1NKytVMGpIVTMwRk5rSTZWV1VlSXNF?=
 =?utf-8?B?ZFl2QTdIdFYrUlM4bUxNdzRIcmRDdS8zSWRkTExZV2pEbUh1a2UrKy9JSExm?=
 =?utf-8?B?cHphVUNacFh2YnpCc2pRYVQ4UWRtTU5QWEFOTmVkcDg2eXEzTVAycnpGaXdm?=
 =?utf-8?B?aTRjK3dYM0tpRHYvUC9WU2RwVG1yL2lJVHRRRmRGaTRsakxZdThHblBsdFBw?=
 =?utf-8?B?WXFFa21xNVhGU2dGWUNObzJsSitTUzNyejJZd3lWaWlqTlM1V0NIUk1wVWhl?=
 =?utf-8?B?bmhNZ2hBdzM5VXNsRC9MZllnTjNWSFVYS0lXMXFlaEJZcUxBSGJ1QThCUnFC?=
 =?utf-8?B?SFg2czMyd2ZJdGRlWnhQNGEzZWVQSGNqZ3M3OUt5NzZIZDBPcEdFN2hOaFps?=
 =?utf-8?B?bjhseWJZSlc5T2JPMmxGRTVTazIyNlE4RExwQmQ5Q2tKUms4UXlkZVhRalEr?=
 =?utf-8?B?SnRrUHg4amFDMlIzRzBPdlpFeVdPUHZiVW10aUtBR2U2WEN0VGlyUTRoalVz?=
 =?utf-8?B?b2FseUNZUGNXMm83UXBrR1hRSXRQWEZaQkNEeUw1b2hVd3J1LzQyUHJnL2F5?=
 =?utf-8?B?UmpYT3pZcGxlNC8wWEdtZXUrN1BZaXFWUUE4MWdvQmxVdW4wNk9QZUFTdk5S?=
 =?utf-8?B?amxra2gybHBSbXQ2MGZ1OWlPRzVRcXpQb2UyeTYvNVo0ZnlhU0dvcVhMYVlJ?=
 =?utf-8?B?SWZQY0V0ZWVhS0pGSmtSWlZkZlEyWU83bGNrQk0wdUVPa1JIYzZabzRnRm5z?=
 =?utf-8?B?UkxYWDAxRXR5MERZaDFTZ3RGMGhDRjhydEI4TTZBenJnTm1YZTkydUM2bncw?=
 =?utf-8?Q?UQKv1LmwlgjEs=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1111e6-6e3b-4ba8-7997-08d8bbdb6cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 18:03:57.2141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0mNmDGjsjnu2YuwJTA/RzppB2zC7zMt0zIISf1H3jMpxmmNm94WJEfIpPBIGKId9UNYviKkhz6N6TXHItjx9/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3730
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1610993039; bh=g/iOP/l4GpqXY6nDAMxJ++R+44+aQ03UyIOR0+7AABk=;
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
 b=rYsfiMdRZSSt+zXKwo9cY4WviYekJyUeuL+U5KvblN+XkW5S/ZNB+dzvGIUBzN7Yu
 w7eLsDGJTK8bUMzASv+MTsIXG75CpSRuLEeJSJnREp5zFefrnvb43HsQlWLbxlJuQ8
 hgYcYtw1V5KWLtkAYSLJ5TrCNXVsp2oe40crSOswrasHcuHx4EEm5kIa7Fn2TBGJHT
 FB9o3bGFk2kVgvqEelPfCflHlgOxqNBinnA4jeBJlMldgR7LNaYTwZXkuzjkUOT5DS
 D6LspVs41YH9pqppAk7dHsiqGHa4c0jneuy8VAUE6KJ2YL02xRGtXbPnRmGkA8iP3u
 Zd25gt9J21ClA==
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

Hi Michael, Jason,

> From: Jason Wang <jasowang@redhat.com>
> Sent: Friday, January 15, 2021 11:09 AM
> 
> 
> Thanks for the clarification. I think we'd better document the above in the
> patch that introduces the mac setting from management API.

Can we proceed with this patchset?
We like to progress next to iproute2/vdpa, mac and other drivers post this series in this kernel version.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
