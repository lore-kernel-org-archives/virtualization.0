Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFD3C433EF
	for <virtualization@archiver.kernel.org>; Mon, 16 May 2022 20:06:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E4F8840917;
	Mon, 16 May 2022 20:06:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0s_Xr-Rz0FYG; Mon, 16 May 2022 20:06:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 871FC4052D;
	Mon, 16 May 2022 20:06:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65CE9C0032;
	Mon, 16 May 2022 20:06:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EF85C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 20:06:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6DDF56112E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 20:06:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0S8smNGqwSV4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 20:06:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::620])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7322C60C0F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 20:06:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZ3RvzQHS0MracGZf8MKip6Q+WFyAjXNVpwS++mq4uCMjdWoe9M4TFrccdrZ5WybxeivFqagUzOIEZoi4EtpCdslZf2+q6cuCFQ8f91X7jwBzW7yxW8FXY5TpYj3TVMLiBG1o7YTlY3/aqLSqnOQ0w48KlHhjgoELof7Ztn4lVRZxdTGA79fVg2I5/DgBCwosDlCK/XJYSEXvc292wck+GsL35UtRW+55VonglmipPOC2ZAfLzRx4N3dj19BYOqaVwHvlLlJJGEs5QPkx/Y0UiXs5CaVNjoMWOHkz9gqlP1w3my6yT3b98kr7OW5HSU5I18jTymG4o78f9BVtcUP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UBfRQVZs3MlcMC7HYY/7v6qn5y97Rjbx24HJas+9kE=;
 b=Zv/cvmEcyYHDJ1vvbqSPVlka2lUC9M51repkmofbGsjDdyUXPPXVYfdILNBxxkxbvpPnUL5qXPf9q/gcAb054tJptI7jMiTe7YvYQJTRknfqJ3ZNWY+jB8ryezdfiuS6T99jn7Lxtx+pNvICfkSe2uN/bNTXiIzLyofdP5qzMvtvpXCfANggxY2qpZyo9VKpw9EzgyZN7uKpftTwB6ymfPKj0xfqHE4mDLdOw8kLNSzdT8vam4b7RlInvreNZM+Qav2Yp2Lf75ppWL4ZJTty0zr46Id6mR0dEm3ruQk6TuXYMQGN3W59/rE24oDHTR2mZZu6aEphnqdfyVpjmjpwIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UBfRQVZs3MlcMC7HYY/7v6qn5y97Rjbx24HJas+9kE=;
 b=CsjrF6SWUH+r0Fy0+aPs79QQGJEWW775xtKb8Xcfs5uLsI8CEY3OuEbxNVoy9rDRBJwa6+8x3WQu5IbJyr7YXYdQncNb10NDU5RpHDWtOnnJNlHU5v7Ig6ARlEtdFjDI9zQQ85qjhlQwqRnwm5cGTINr7x/KNuFGpxXlu6oMg+FutzbrtiWnA1odmVb9YQ6N6Atp94+/41GAUT7M8eTZUcbMk0RAtqlPX9c2ITMGWOiIc/klfr+mR/u0rtRpGvy6xIBqXQDbb6MABpbg0Hg0/OpE4Xt9fgTc/8uHCpKNobGBDsMGu6A9vAKxlsJ9dl2CbMIG67RiBeyFAysAdKbfWg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Mon, 16 May
 2022 20:06:23 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854%3]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 20:06:23 +0000
To: Xie Yongji <xieyongji@bytedance.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "lingshan.zhu@intel.com"
 <lingshan.zhu@intel.com>, Eli Cohen <elic@nvidia.com>
Subject: RE: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
Thread-Topic: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
Thread-Index: AQHYaOqkgz3W9mP+EUqOpcefr9+WPa0h7mWw
Date: Mon, 16 May 2022 20:06:23 +0000
Message-ID: <PH0PR12MB54813F96E346D591FBE238C1DCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220516060342.106-1-xieyongji@bytedance.com>
 <20220516060342.106-2-xieyongji@bytedance.com>
In-Reply-To: <20220516060342.106-2-xieyongji@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24729144-1528-4639-2a22-08da37778cfe
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2972E18CDDE450C61900B40DDCCF9@DM6PR12MB2972.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8VAVU+5FM14e9TEH2VEBA727Tblnn97Hx7pAt2bQ2cdQb0bZELGXYJ9EQrnEHmtvCLuYKOJNwZHleVGkLRBOUsFsrjzuOIVql5tNntp0QHSd61Qque5MjzWvlvlFQhkpdrxp5DLdEJal6nTi2CU2rdnnWWg5x6ZBfmRxVAYr/PJfqZqP+RkNvlWRZTaihQAq6DKkrslPj8VGrNNYwdKksrV7Y5MnODBA2gZ1m6mvjg1hcgBgoer7GLPwuJr+p4G5g/F83+nyukMwIG3wway0zLAeXlzEyxKOK3dNIDSLpAuvTjChLZw6m42LDUg0sw2c58fmzyRo0ZJQTF8gH1MbTFFxuqg4wh0PMRf9tkjdS0kfxV7ZObStINVgOqLSC/Lbx/ypT0rOMjmONtq6BE2nP1lZaA/gqMjsM3qBxpVQAUWSFyhsfBmsrO8Ba8Z3+e8xtiCr0gsc+ftLpEM3NZBY0tMTHtvhHNWm+w1fAyHyeZ+mZSgXoChWLJG6dvjZSFmk7tc6fiTrSnI19g8dxmbTtvIU1dK5Qgm8SPU1zIkDqivo2CbgATj6/d6ZpXZdaCLDz+7dhnF+n7cSZpib0B5CuZSQywWCwUdJxfzBqKswJVPe/mavHNIBrMctahEBJA76lkIX5eaTH8WNoKkdeh+xFSkVAviiv+oH2lPutvRY1nKcpKS9krv5yVxsvMWCjopU9JcwhEJ2jnnhFJzifjbZJQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(2906002)(7696005)(186003)(38100700002)(38070700005)(122000001)(508600001)(316002)(4744005)(26005)(6506007)(5660300002)(71200400001)(55016003)(6636002)(76116006)(110136005)(33656002)(8936002)(52536014)(9686003)(66446008)(66476007)(66556008)(66946007)(8676002)(4326008)(64756008)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8J83uTlOEzIVJwnsoBe6cLBQHjUmuqk95lKuTG24zBk30TYh60FrSMhNIVuH?=
 =?us-ascii?Q?MzCKCpFGQB612zt++wbPVaFpQDjgVNHEsq3Cwk2x+SLH4llGU3dwdb7Orkv4?=
 =?us-ascii?Q?MwHH7nE52Fu6X1IicQN1bODFXf18qaiMGCOnUGOvST5IpzrTwx8HBogowqfk?=
 =?us-ascii?Q?/O/Km2SpG+xpNbcCXGlunPBjOs4bCyg34L3894yIWom+mqgejZkdbUibPSaz?=
 =?us-ascii?Q?Ds6ncZONSOUtaFXnNl8U+f4mj6NnepXeD1z07uKxUqJnNrW1vgpcwaC4xBVw?=
 =?us-ascii?Q?sgfXhW9DmErrcyugP2UfAk9ZK+1ZtNoo2go0fSsoAKe26+eVoYBrHxfHzqdx?=
 =?us-ascii?Q?9CMzuICxt07ghaKflEuvnGQoYAu1CSfDvNtIaW0I/tCIbD2q6qXGcKEh2rJ0?=
 =?us-ascii?Q?dmz4t6l8DcHLaqsBV793TUeqKsS3nfzIZ21sPYLBmwwQuDD0KhOmB72OEj99?=
 =?us-ascii?Q?rUBQEmUL2zlahaQmZG9aPz2TrhWakESyt+ANlxQfp3UxFijpOJLc6bEifgYH?=
 =?us-ascii?Q?mnGXe9ZmU6vgNYe2zh76OenvBUolSIYdfxw7jUbZdCicqFVS3lYV2wFr4Lc9?=
 =?us-ascii?Q?gdvzr4koLyETOdJD/esU1gKW6tR0ynGt/dsSHm4PU5V/3CCzGereny+1EVMc?=
 =?us-ascii?Q?lMUhYMwpauhmsDSTi7N9GwBvZ8bOz21N3EvrNaMz0cW+Gx8Rk+h/ezhuSEAY?=
 =?us-ascii?Q?8MYXzcuWRXUgKPylnbaF7V6wQllqMQ8t6w4GWunRV3tvEFa3Bxt43YXbPNul?=
 =?us-ascii?Q?vkZ+IZutIz0hlnjpivV/NwLC9EtNNidADomg2PdymJjq4U5OOFJ56tmEAYW6?=
 =?us-ascii?Q?l/BtyrdNrrR+1obEiQYJD+5nXSFyxJ+BhlL9HJqZSkeXc0aAqXhbkqiYiIEJ?=
 =?us-ascii?Q?DTv+41CM8fqTWbXkSW0ODbieCLND+iXVKVVfotZx4LBTp2SKgwbzuxlr+8MP?=
 =?us-ascii?Q?jcYWBNBGldiTO2qAQBGkTUTKfqTy9gNtSP4qgy1IOCpBzOdMY4wxHcw9S2mN?=
 =?us-ascii?Q?6EDOnudFZogDkow3CLjLF3B4hS20H00aZGKYRS8wLDT+OrmU6II5EKi5tVkD?=
 =?us-ascii?Q?sjaiwDDdsvgqGRWEP+kGL/qArwyMmm4Grhgc8XfQzC0lJJ4HLoavfr4u7pew?=
 =?us-ascii?Q?LGtnAUqzFxAYaYkEOV/lc9E5SK5ofqOMacSvogpKtz8pFbOjameZ7Jz70cN2?=
 =?us-ascii?Q?VVUB68iqShcYjgkYX17SAO24iPYTJHjELKfbJfL6KNjx7S25CN6f7JJ+n4iz?=
 =?us-ascii?Q?guBzSY5R/Bf81bthKONQTHJOozbXhGRSdVFVPRpr5g0icn0pLxLA2sPj8OT9?=
 =?us-ascii?Q?AmIkLW19ra34QEhBSUCz4Q234hHcxYmUoWh6/bF4xf0NemHdkzUVzQdUN2O+?=
 =?us-ascii?Q?Z703S+NxCm4YiAChLWPbwSAdagSMCUPChTljp+71B/8l/bjnTZ0c2Jz+Qq8z?=
 =?us-ascii?Q?ZG9MZPbWdR4dMvQGvZONcAuYIPBBEU/Vz+AyoUIS6HzO4PyKg/QWfjSo3Bi1?=
 =?us-ascii?Q?l79Rp6D8FzufWF5HfdrTV3l5O5JBd+7O+DQlGtlcNjWxxLZYAt/znx9XMnUQ?=
 =?us-ascii?Q?KFKs4jy2dnF9HzDiNxKy6yiwsV0XCJGhIj8rBtPAB9uAX3qHUy/IDSOSj3dS?=
 =?us-ascii?Q?c30COLZehrGfBofQzRT7nnCkvJ8Dk2aS+dKSUoXW2Sk3gPftXmk+eW1He6MH?=
 =?us-ascii?Q?dhDSE+gzLMtUweQ5czilwqsWAKbHcAQmhTVCtcLCyHDP6sGZbvT/HKCjLPPH?=
 =?us-ascii?Q?EDc4OrLQGg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24729144-1528-4639-2a22-08da37778cfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 20:06:23.1980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KYUlxDNTWxleTId5KhAROlb16RZgGlN8/cratzWysghRlF54PmGXt6Mwy+B0PgaOInOVwdKfwn9qa40eYQhx3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2972
Cc: "virtualization@lists.linux-foundation.org"
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: Xie Yongji <xieyongji@bytedance.com>
> Sent: Monday, May 16, 2022 2:04 AM
> 
> Introduce a device object for vdpa management device to control its
> lifecycle. 
Why is this needed?
What is the limitation of current approach that requires new device for mgmtdev?
The primary motivation is missing in the commit log here.

> And the device name will be used to match
> VDPA_ATTR_MGMTDEV_DEV_NAME field of netlink message rather than
> using parent device name.
> 
> With this patch applied, drivers should use vdpa_mgmtdev_alloc() or
> _vdpa_mgmtdev_alloc() to allocate a vDPA management device before
> calling vdpa_mgmtdev_register(). And some buggy empty release function
> can also be removed from the driver codes.
What is the bug, can you please explain?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
