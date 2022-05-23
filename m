Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F4BC433F5
	for <virtualization@archiver.kernel.org>; Mon, 23 May 2022 02:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A890983F58;
	Mon, 23 May 2022 02:00:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LgXcIpbfaJLe; Mon, 23 May 2022 02:00:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A9E9483F4C;
	Mon, 23 May 2022 02:00:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EBEEC0039;
	Mon, 23 May 2022 02:00:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5ED4DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 02:00:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3EAC341767
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 02:00:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1aT3JmG9H0_g
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 02:00:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B83A41735
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 02:00:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jk1L1jLxfKWtHCZnCGfDP0Wa0AKn72bUE2b7MWj903Cww2wyEnZluobsCOWnQFKl4s8WTiPwzi4/iiX6+/6Uqt2Fn9fxLUkGQk33/xygBMHhKLA99c6zq/RNk6RjtDywRHzw61p5TRF2Z93eA8kRAkg5i+HSATQBzpBdqfgkZBZkk7HRgnDwHu5Juq8PEbQB37fVDKfgwgrTae0x6WdtTZNfuNxaljCTUA3Q/Fu5gKXGh42mjde+BAeJczowRkn7tOCNdgfE3TD1HwQhNNuRmnxEVAAQYlkzCc8jvuDVIQDEURC+pLP3mZ2jiVavfUzJJbLbUN0Bw1Y9/qTJLIGmIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+9DnZ6KVFL4fcVlqxWPOxl0nV5r9HIEcpMp+emD1tw=;
 b=DLprj31l2w+yfAHzDnSyDgXkTZgRVkufHdfsEw/MTnKFKl6TpeWRhUG6vWe+oxNzo9q/A9eflRdjjOVyt1kxQKhrPMBHHRIpUAHWRo05TMzfXmJWmG6LMCK0lLEratMaaqVKT0s7S4r2dVz4EdpPHTZjs/2qhiQ/k6xU7/kvUssvoAnFJF74oS0xjK1Tvg/HQu2hWBSZ7EyFfbPL/FO6hUETMEGo12M0kUIoZQCE/RMyI0v5nRPd/lTx0ya7X3Hqbrnv72OoZPquy/MhcgHezNZN9QyMdrWIuN9CqKMZgFHRDSl4AgtCGj9HQ3T9XoZnAH+XUB8BEB5E3S038JF2Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+9DnZ6KVFL4fcVlqxWPOxl0nV5r9HIEcpMp+emD1tw=;
 b=KFwi3D/GEkaOoin5167gRvSaGmtagu9udh2wauIzIE1BRdC5708P27Ry86gwDCLGZC8GyflQNsI7PRJxhlwMI4VkZnEPS9Ficabl5OAbs5YPKzU//fvaCFowcs01XMAPmJ6hcW2NGflI+hnQ/sgjYQ2hqGQ2k6F0A+TzumgR8bsp181maWxIFpie7Xc58bT5EX+qUg0ypT4QI3BMjvZcKP6fHWu6brolFxGIHqhpN1k0IjeHqySkEjSc1uIt4bfiVtOI817RDA+6j8dWIMpYmZyZxl/O3xkVp7mCiwifUY61N5Qc2aKi31lPoAgUbCg/0bFXEEcQJdBj0vKmp5KDmQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BN8PR12MB2882.namprd12.prod.outlook.com (2603:10b6:408:96::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 02:00:48 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854%3]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 02:00:47 +0000
To: Jason Wang <jasowang@redhat.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
Thread-Topic: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
Thread-Index: AQHYaOqkgz3W9mP+EUqOpcefr9+WPa0h7mWwgAC+VgCAAEk50IAAI2SAgABj/vCAANQvAIAHXd1g
Date: Mon, 23 May 2022 02:00:47 +0000
Message-ID: <PH0PR12MB54817B6BE5796E237A50FB2FDCD49@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220516060342.106-1-xieyongji@bytedance.com>
 <20220516060342.106-2-xieyongji@bytedance.com>
 <PH0PR12MB54813F96E346D591FBE238C1DCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACycT3sRc4bk+3oq7FLzpBMCG_XRN7tOaeEAtNg69o3h8c3=EA@mail.gmail.com>
 <PH0PR12MB5481AD3C1517331EAC4EE078DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <YoOpBaWcaoujWqO7@kroah.com>
 <PH0PR12MB54819F4E48BE36460BC89457DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <28a689dc-a9de-ca1f-6b9f-26c735e96781@redhat.com>
In-Reply-To: <28a689dc-a9de-ca1f-6b9f-26c735e96781@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4040e79b-1e35-4b59-0d98-08da3c600de7
x-ms-traffictypediagnostic: BN8PR12MB2882:EE_
x-microsoft-antispam-prvs: <BN8PR12MB288293136904D0F528E8C92EDCD49@BN8PR12MB2882.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OB8vUR43Xt2gzuYyFWfSLGmR5Vmlpsho9tMDw9SRwCJJiVEGTF/JKa0fYsg3b4WWw4naFXqTlu8X1UxSzj/bBWmywA6AVeLASZuK7ku09GdPWKoruOtBAKEkw4t7+Jy1aiYgYMR8Kx4aNXeNTLgpZByazSnVd41wKe7lfI4ZDlQLyX8Ccn3/6UvWsfe7iJCz57YyzrjlPkHNsEigpqOoB8zUaC9P9GPH4KP4fBYvJVsGLG0KQDU1hyDaj7AeBs3OEM1xTBUP9Qu2zJrSsjejRWQT36BVVFfoIuD/iix5IbMc3EEahxUAWU8l77vQSb6Icf79EKKnDedyQKcQsF3+wCJk9/9QJqKx6HiNXvii6e6qJz6bZMEDp87RQunFTzcSbzfB8MHdJJduGn9FwDi6jqqkVAOYclkAyeRrDa8GLqi/ML4TMBNjASbCASU9+jSh5GvKsBJGF9FCM3Rh41Cu4xvpnZMx6hApP32NJUUl3NOKhVnfkQuwGjifMKt8lcsK57A3ZGqaf95ZQ4iVGggSesASUz1goAzihkzIidTT/QVDyLjZEKZKf/clWmGkEIYpi3f9q58Ji1AB8P8j0na+vPypKBhqTHFOTx8dlWh6GKxhgzvihTn9f9Rjhkmm1I3C9CD6w1QWs34ZFfG4SUmLI0rSQVVpDWeO+E5dVGhs4tooZ/z8h1t7pbue6Azn61S3Gsm1RMBDkNLYPlkJoUcZQRm2orVgDfNoh+aK0GSLQSa/amiyCnotU+mLeaN9QDEo9TJxVTGCrUwku+7YxohadwtQrxFfvpoVWX72zdROjyQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(38100700002)(4326008)(64756008)(66556008)(38070700005)(8676002)(66446008)(52536014)(76116006)(4744005)(66476007)(122000001)(66946007)(316002)(54906003)(9686003)(110136005)(508600001)(71200400001)(186003)(2906002)(7696005)(6506007)(86362001)(26005)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0xSZXRwd0lUL0pMZzhsbWhCTU01eHJpMVdCT3o3THIxc1lpdmw3TktzdmI1?=
 =?utf-8?B?bk1vaENwOWJkMksya28zSUgzVmJUc2Zhc05XOThpd25uekVZL1RRNU1nYWMx?=
 =?utf-8?B?bExCLzJMTzlxODlDbXFUQm9aUW1DMXQrc3MxMk1Rb1JxZmVndXp5ZWpHWi9D?=
 =?utf-8?B?eXlIVlpIMGU3Y29CYzJEWnBzaTBrTU1CMUpNd2ZHNDl6bzI0dUJsVVNTUkkv?=
 =?utf-8?B?QklESzdaYm9yT3pZZzJsRUV1TnBCbUZGTmFHa1R2VjYxbEtWa3NnR1VDS29M?=
 =?utf-8?B?M1VuZ0ZrMDZOOXJzblF2SVpZbXR1Q3dFYVhuU1BUbitoalpsRUdJd0EzREgy?=
 =?utf-8?B?VDl5VS81dVZsbGI1VVdqQjExM1ZPZWJVcXZGZHJDVlRtakhtbVI5ZWpIcEpU?=
 =?utf-8?B?dkxZeGk3SnB6NkpPbUplQjd3RzgxQUw0VFB0QmJOUmZzQlpnSWRzb256ZHJU?=
 =?utf-8?B?WTNQMEtzRldIRkp2dzdaSTNPSHpLMCtqaXo0TmRKSnJhTXB5RzNzSVl2ODNP?=
 =?utf-8?B?SVFZaGx3TUc5NHZuMDlRWStKY2EwcDdWU2xQODlVQktYRGJ6OFZ4TzVLYW04?=
 =?utf-8?B?SHhBZ1VNMUovOUxxemh4dGtGTHA3eUdqTlNwTGdKc2tEeDdOZng2SUdRQklr?=
 =?utf-8?B?RmhYeGQvTEtlVWdGVkthM0ZqV0ppM1dZN29MR0NqYjk2NVlNNjMwYkV2aGJJ?=
 =?utf-8?B?Kzg3ZjNYbTdPVWo0YWEwZkFzRW45MUhQOE9sTVczZE9hMHAvVksreUxNU0dx?=
 =?utf-8?B?S1l2SzRKTG1xdzMwa0h0bVJTclNrYXVmRFlnQ01ZdDlJaUp4QUxRMDRVUjRm?=
 =?utf-8?B?dTVhUDlFcmtSSkdkNk9aSi91cXpicEk4S1VweEFFWnlUd0R0cWt6QVltMmhi?=
 =?utf-8?B?VStEU2RNbCtvTnpmbnBoTjZxZXlLRWVIdThNVnBaWi9iQU1BVUxuNFhDS000?=
 =?utf-8?B?K3R2T25NdmxwWWFyQ2hKRXAyMGFZbGtycUdwaitPNTJHZGxzTGZOdzNuRVdT?=
 =?utf-8?B?bjhWcmZESk9jQnFYM1RLaU00YTdiQ2Z3aUE3U2w0SEhVVGlTUWtwOEhJQ0N3?=
 =?utf-8?B?MFdHQ1VwZisyb2pPRCtNNFFIUXNLY3BzNUZZZEpJcFlNVTZqYno3WG9lS1FP?=
 =?utf-8?B?YURVUlZBVlU4TnBDOE0yM2VscytZckxOa1FjTEFXQy80bmlKWnRKUHJNbzh4?=
 =?utf-8?B?YjJYWkxHZW5rYjE2YjVzVVY5UjFCZHpSQ0Q3QlduVEZHZ3VVb3FZN1JDMWZY?=
 =?utf-8?B?T0RqOGxBcDFSNzJWSEpIT2kvZXlxYVVOOUN2aHpQS2d1VWRIN3N6YjV5eUZY?=
 =?utf-8?B?elRYcU5qdnAwNnNKQWVsMEVWeTFKdHN1WGl1alEzWTFHNlFlWjdxZWNleTdS?=
 =?utf-8?B?bk1OOUFSK1BQVlNVbTluVTVQNFRXTlZnazRTTTZkSjJBZnpSc1IyYjFodjR6?=
 =?utf-8?B?aFQ1bmpCWnhlcmhvR0I4K2xTYml5NmxkcjZMVEZPSGs5VmJVSjBUeEttVFJ1?=
 =?utf-8?B?bjhSbk1rTDlMdFBHT3lNcHRXcmxUOXlDWWlTOUJ5UExrazEvaWNBd0cvamZJ?=
 =?utf-8?B?S3hZckpBK3V0QUU5aHc0bitUS21rWjI1V2ZXL085QzRFaVp0R283L3AyVGRC?=
 =?utf-8?B?QURBdFQxK2srYytIRUNmSDlRMWJBaUh4RXpzVXB6eHo3RjdTbjBvaFZoRlg0?=
 =?utf-8?B?ZjZSMUcvNHJhQWowVDZlUytQU1ozM3lOc242SzBCUHJHaG45elNjMERQUGRP?=
 =?utf-8?B?aXcycDE1b3VFQVBxN0pNdkZpRG1mcjh1TGdRWktXVi8yY3NmQ0VMWUR4RVVG?=
 =?utf-8?B?eldiVk0vangxTUZZNWZramFXSUVMK3ZQdkdFd0RjNTlSN0RvckpJaEFXTndw?=
 =?utf-8?B?a08ySWFZQllYbitUYXJRc3FJdDE3TzkweXBmOERGaDF3Rmx2Mk9pbXdSSFRk?=
 =?utf-8?B?aEFac2FvOHQrcldWSlNtdVVyNHFEUU0yM0pQS29LdE4rSGtraGxZVkVFdGxo?=
 =?utf-8?B?RkF6K0tCNWxkWWpwL0RudTdDY3NLQTkraVpBeVYrYW0xTFpMZm9WNmROd2xC?=
 =?utf-8?B?NkRBOU9oQnF3TUVVSTU4RzdYVENkb0NmYWgxaUd6OEVzdFFHek92Z1FWL2Zu?=
 =?utf-8?B?WXlsUlF4dlB6QjFxUVJ6Mnh2MVJKckhNWUQ1MERlYVhIbEZWbUlzWGtqRFJk?=
 =?utf-8?B?MCtOa0lXK2RlM0RQZGE3N25EMHdqUGpJWkZEREVhak1Jd0xKZWFlTzMvelpO?=
 =?utf-8?B?MlVzMXJPdU1yU3ZoOC9PSlV1ZlBueU13SlFmTHZobDQ1dnkrUkJjZDQ3aXlK?=
 =?utf-8?B?UHdVTjFuYVIwQTZqU1c5NUZEMkc3Vittc2MxZXVNK3dOdnJSYm9vUT09?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4040e79b-1e35-4b59-0d98-08da3c600de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 02:00:47.3650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sG4EdniooUHYRJL3368geKoknEUWT15WSLB72jE388Udo7T5hRUJrRhpAYtgtEKRqW/9+to+Dxg9bTkCYMnt6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2882
Cc: Yongji Xie <xieyongji@bytedance.com>,
 "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Eli Cohen <elic@nvidia.com>,
 "mst@redhat.com" <mst@redhat.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgTWF5IDE4LCAyMDIyIDQ6MzIgQU0NCj4gDQo+IOWcqCAyMDIyLzUvMTggMDc6MDMsIFBh
cmF2IFBhbmRpdCDlhpnpgZM6DQo+ID4+PiBBbmQgcmVnYXJkaW5nIHZkdXNlX2Rldl9yZWxlYXNl
KCkgYW5kIGV4aXN0aW5nIGVtcHR5IHJlbGVhc2UNCj4gPj4+IGZ1bmN0aW9uLA0KPiA+PiB0aGV5
IGNhbiBiZSBkeW5hbWljYWxseSBhbGxvY2F0ZWQuDQo+ID4+PiBUaGlzIGlzIGJlY2F1c2UgdGhl
eSBhcmUgcmVhbGx5IHRoZSBzdHJ1Y3QgZGV2aWNlLg0KPiA+PiBJIGRvIG5vdCB1bmRlcnN0YW5k
IHRoaXMgc3RhdGVtZW50LCBzb3JyeS4NCj4gPiBJdCB3YXMgYmFkIHNlbnRlbmNlLCBteSBiYWQu
DQo+ID4NCj4gPiBXaGF0IEkgd2FudGVkIHRvIHNheSBpcywgcHJvYmFibHkgYmV0dGVyIGV4cGxh
aW5lZCB3aXRoIHJlYWwgcGF0Y2ggYmVsb3cuDQo+ID4gSW4gY29udGV4dCBvZiBbMV0sIHN0cnVj
dCB2ZHVzZV9tZ210ZGV2IGVtcHR5IHJlbGVhc2UgZnVuY3Rpb24gY2FuIGJlDQo+IGF2b2lkZWQg
YnkgYmVsb3cgaW5saW5lIHBhdGNoIFsyXS4NCj4gPg0KPiA+IFsxXWh0dHBzOi8vd3d3LnNwaW5p
Y3MubmV0L2xpc3RzL2xpbnV4LXZpcnR1YWxpemF0aW9uL21zZzU2MzcxLmh0bWwNCj4gPg0KPiA+
IFsyXSBwYXRjaDoNCj4gDQo+IA0KPiBPaywgaWYgd2UgZ28gdGhpcyB3YXkgKGxvb2tzIG1vcmUg
bGlrZSBtZGV2X3BhcmVudCkuIEkgdGhpbmsgd2UgbmVlZCBhdCBsZWFzdA0KPiByZW5hbWUgdGhl
IHZkcGFfbWdtdF9kZXZpY2UsIG1heWJlIHZkcGFfcGFyZW50IChsaWtlIG1kZXZfcGFyZW50KT8N
Cj4gDQpJdCBjYW4gYmUuIA0KUGFyZW50IGlzIGFsc28gYSBkZXZpY2UuIFNvLi4uDQpTaW5jZSB0
aGVyZSBhcmUgbm8gZnVydGhlciBjb21tZW50cyBvbiB0aGUgaW5saW5lIHBhdGNoLCBJIHdpbGwg
c2VuZCBpdCBhcyBzZXBhcmF0ZSBwYXRjaCB0aGlzIHdlZWsuDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
