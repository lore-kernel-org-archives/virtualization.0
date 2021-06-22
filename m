Return-Path: <SRS0=aA1Z=LQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65A5C2B9F4
	for <virtualization@archiver.kernel.org>; Tue, 22 Jun 2021 14:10:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7019C60238
	for <virtualization@archiver.kernel.org>; Tue, 22 Jun 2021 14:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7019C60238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3E0E6402CD;
	Tue, 22 Jun 2021 14:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hYUoytR7DUzr; Tue, 22 Jun 2021 14:10:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C108D4029A;
	Tue, 22 Jun 2021 14:10:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2CFAC0010;
	Tue, 22 Jun 2021 14:10:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C04A3C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 14:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9EF374026D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 14:10:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wqn-k21kcsB2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 14:10:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2066.outbound.protection.outlook.com [40.107.212.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6140E4026B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 14:10:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuW6B7jJ1saQBYlpUUQ+MuEZVxDOUQczH6ivzsWLZCcAESJFD6eV8hsmuhLNLOnw3FzuPFhPdrC0wuo2on3zvpd5Rx+PkmZF7npjgofy4HFrLwaYFo3s2l/ZphCrTViyuZ1Ai2OfcDGoQf6YhhQHZ2D4OeuJjkeo7vnL1znr4iz3T0A2X7V6S0CGoFdtzJmAcTrKsoZVlooZfI+K5WYWvWj3PnUq5ZDZ0hVmR6UdVynowLo6HNdRd1/vJO5m+t95F0VxXHhK4KTlDQ2pOB9AygqRh66Uc/Q/v2d0YxIYdj4aCfHf6G1acppwHbG+uIVtPYpYBGWwIXHQ65ceq9bAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC3JH3wQsxG4hJJTtP9E1q6O6zWjxkjwU3JO1c6lPUA=;
 b=LwlbYckidG/1fEmOKQMDv/dedjjWZqJGhf2ooA11Gj7SazU39x87Okz6Ttn3srUBSjAioAEYOZZ5aHj3JavY8vY9wZcZvvGSUDhA6Ekqlg4OufGaf65d/ptstLdk+JMMojbK5kBbpTx0XQoII9rSMJ4WtjfO3d2h6Srk+2S2fjWNlsVnyF/gqPzSt9oc+ZKu7shfs5dduuqsvr2lBbnSJoIjDkpayVNyS9u7IiBOimr8XlUUwH1tiJyj6V1LXPcZi5FBXXoczh72k+lp4UgOSlQUkyIjLttvn/RL5tbc51UhsxVjJZ6APTs0Ycx13HK2TP49ybzNlhwo2GZ9118tew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC3JH3wQsxG4hJJTtP9E1q6O6zWjxkjwU3JO1c6lPUA=;
 b=DM/Jxr40cXFk/LInq2lj/tCzW7tVj4066oSM5OEqfMe7pweBWvouW50tS+41iwJl8UGomKYeUaGdkBv3v3fpmoBfNJ3yo7Auv9q/hk1rb6/V9gc1jVDV4Jzmyirvss8bv25Eh70ITdv4Yt9RrtmD38McvnigtJGZv80tKP3H/HAfJkHuLsPLqGpwSLIyDPyh8iA33tg13N+KI4kndET4gP1Gzzhq2HllJYq7diZ6jOBICKjAdnV9OUEN66uUyMdBw1j/WDk3mo8jgwgji8Oq6gApvsNGwfWn/Pxhh0QzoTHgQAdmpKgBrygxH3hBg/kjhvhkoBD7+Num6oCYAB5f9A==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5498.namprd12.prod.outlook.com (2603:10b6:510:d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 14:09:59 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdf9:42eb:ed3b:1cdb]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdf9:42eb:ed3b:1cdb%7]) with mapi id 15.20.4264.018; Tue, 22 Jun 2021
 14:09:59 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v3 3/6] vdpa: Enable user to set mac and mtu of
 vdpa device
Thread-Topic: [PATCH linux-next v3 3/6] vdpa: Enable user to set mac and mtu
 of vdpa device
Thread-Index: AQHXYuOJALWG2NjOXkmleF0at+SepKsfrs0AgABrE6A=
Date: Tue, 22 Jun 2021 14:09:58 +0000
Message-ID: <PH0PR12MB5481FB1A9454D19BE910F720DC099@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210616191155.102303-4-parav@nvidia.com>
 <42d53f49-8528-7585-37c5-66b37d69064c@redhat.com>
In-Reply-To: <42d53f49-8528-7585-37c5-66b37d69064c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [223.184.81.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77b9a872-2cdc-4126-a768-08d935876b86
x-ms-traffictypediagnostic: PH0PR12MB5498:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB549805D52DB9995D407EED97DC099@PH0PR12MB5498.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3F8DEOx9nR3/k33FZlXCiKbbd98GKsBzhAS7Qv9hdACcwNA7jeEYJb2sHqLXP3UVAVxONPoUJjJe55DvdFGs9pvn0Q0swktwwPUSax8UHHXSdWzjOIL6+wVlZuX2mOZlTJeE9oW+/exsRXTkgedz7EGBsWgDEnqaMzgq4G76OrLzva8UUhIl72YIfgcbzxKNeChMNlznN+Ek1+cVEesn0OJegtcHwdpmnRFIHDWjolThZVIRDP4ksfSPV2gqfaGYnq0fXckBNH4qi3atMNfwhkVcaOLxzthjQ5Z+99TZh3LzhRjacZu47wFsNQYWf96bxqCRwKr1SPc5f0vudWvh/+a7JarT1BV22HKuMMXAHFq+vTP4iOYF/tUKsD7ZpCRYgeAkZCR78V5ft9RwT7wjjj4+P+AHURE02m2yyw1jqzLZHZWaMpZGsHzC4REqyEn987hdu265cB4Q4siOQ8ZemMOf6gBAoWBPwhBtqU4MjqF/l2iXsxebHCnqeyD7XT3gZ65s+TyS+JZMaEMq8CnNhztbcciVR8HjNZg4jgWmITjyBWzXtRHpiS7oiJ1ZbXHAjQdQ3KO8kl143KNDWTpmnBSXu+lqkmQwggXfef9KpMU/IHQ5YobFUuA5E9iLPDBqX9vaKngLbC1ULM/VC7hOtg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(54906003)(8936002)(110136005)(38100700002)(122000001)(478600001)(6506007)(83380400001)(7696005)(71200400001)(33656002)(107886003)(4326008)(66476007)(8676002)(2906002)(316002)(66946007)(66556008)(66446008)(64756008)(76116006)(9686003)(186003)(52536014)(55016002)(26005)(86362001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?blJ3RUFadHorUXFPVjFyN1NzcFNINVRDTFRoMHVRelIzZ083VlFqYTBN?=
 =?iso-2022-jp?B?ek8rUEUzNUhTemt1d2tFU0JyeDZldkpWaWJYRkFqNENjUFhnVXl0b1VF?=
 =?iso-2022-jp?B?QXQ3a1pkME1KblNDNCtLRXVlLzVOTWQwdDA5MndiWWpRQ01HSXpyVElF?=
 =?iso-2022-jp?B?dWZhSDFUSmlLaUFrM0JQaTBtWlgrUzlCRnlCaGR0dlRMM2syRUdvOUlh?=
 =?iso-2022-jp?B?c2MxNXdVUkhsd00zR2RqOVBrMHBQbWJqWmRMZXVhZnp6bDZ2ZnA5c1Zl?=
 =?iso-2022-jp?B?S1Y1aC9KeHFFeW9TQTM1dUlFeFlFSWJrYmJqRXJObDgxZlNrOHpEMHBw?=
 =?iso-2022-jp?B?eWhPVDJJSEEzNmxiWWFaTjBOc0NmYStlOXl2ZngwYUkyYVBQYnB6Y3p5?=
 =?iso-2022-jp?B?eTlMVWZ2aXdETk5PbUg1MlYyNDd0ZnlkNmx4d3gzdDJ2bFZ3OUdtQW9j?=
 =?iso-2022-jp?B?dVVLdUExZEl3NnpjeDB1QkF4L24rcEJnbzFtdkJxUjBrK0dYcmN5QTRB?=
 =?iso-2022-jp?B?djZvUVBQSXV2eHdqc0tZZXA3NThGZnVmallrbVl2SDdralR5UHU1dXdl?=
 =?iso-2022-jp?B?SzdERTkxQ1BCYndXZWRkVWtUOXFxTVZjL3ZHcXVYb21YM2ZYN1hhRFp0?=
 =?iso-2022-jp?B?NmViTmtSQkJFM1d6YXZ4dkRKWldKdy9GMnpuT1M0ZFNpOVhlZExDK3lF?=
 =?iso-2022-jp?B?NmhUYmxkaGo1Mm82VzY5VmJuTk40SlNOSml4YmVCS2RrZkZMTzhlWVZz?=
 =?iso-2022-jp?B?YmpWNmVkMFZNbXN6REhUTzgrRlNZSmY4YytQcUxCNUZETFRDQUpFZlBN?=
 =?iso-2022-jp?B?c2hKSjZBSE1pbzlGbjRpb3J3RjNPMi9KbURiQmJ5MDZWZkRhZGFCYW1Q?=
 =?iso-2022-jp?B?S2FFOGpzenB1LzJSbVJvczFLOG9wU05iUDJiUmpnK1dMTitUamxvbG1h?=
 =?iso-2022-jp?B?RTlFOHROWG1mV25qOWxMb09WdFMyTWd3S3RPVHFNL1pHR2taaURQYmNt?=
 =?iso-2022-jp?B?bGVEa1VBL2VDTS9DQ0FXVEs4ZndMOUNIN0s2RkQ4Q3BURC9QZ2dueTBX?=
 =?iso-2022-jp?B?eEd0M2RhOGJyUE82QkZIOVlTNnducnp2N0Y1UXJNVjFPR1VCYnJtcW1G?=
 =?iso-2022-jp?B?UHJSWjBSajhneXZCNjlZYlZPdnBmbGw0T3ZteWtMc0J0V1F4WUNmNzhE?=
 =?iso-2022-jp?B?WlZkLzJzeEZkT280RXB0M0NPckhvUHpYbmt4bmNHZGJBUFNSMVNKekNy?=
 =?iso-2022-jp?B?b0pBUHFYeTN6MzhqZUdjOHZJSFRMUURnRGU4SDVsZGxRSGhqOU1INjYz?=
 =?iso-2022-jp?B?bzZWU0czZ1Y3ajRyTG5JeGZTZGowQi9SR0IyNUJmWmJnTHZldTlDRnlm?=
 =?iso-2022-jp?B?MXBzcEFQNzQ3TXFQV0RIZTBGWXAyQUJGMzhZK3hwSjNTTE4vVmdpUkQz?=
 =?iso-2022-jp?B?eWMyZ013dFIyUjNzNUZqZ2NJTjFKQ2wycml0MFpaYldFV0lqbXZrSGha?=
 =?iso-2022-jp?B?ZXQrYTh1akl2dUVvdDRUVzVyRU1oQlFpZXVSMW5pUlYzc2t6c3duR2l1?=
 =?iso-2022-jp?B?cjdUVjZlZnZHbWNyK3V1NkhTQTNXaGJGL2ErY0pzYUpkdnFVUVJzekMv?=
 =?iso-2022-jp?B?TFk3b3grSWM0ZkZnRzNVSUo3U1VuSjUrWldTYTJvYmFQUnlTdVZZMG96?=
 =?iso-2022-jp?B?ZDhTMmlyMnJQZU1JUDViVnNKcVowSXFQdmZlWFdkN3VtRlRpOE9JUlky?=
 =?iso-2022-jp?B?M1dLd2tzQVhvWVNpYzBjV0hNMjhGMldVV213UXliYnk1Y09ZZ091dE85?=
 =?iso-2022-jp?B?ZEZtWm13d3RMRm1YVTYzcG0rZS9xWVNjTVZVVmtZN21MU3B6NzNMRkFP?=
 =?iso-2022-jp?B?YW5SbGNXbTlON1o3TlZpUVBKTXdlQVQ4MWtsekdQY3BQc28rREg1QlNX?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b9a872-2cdc-4126-a768-08d935876b86
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 14:09:58.9085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: emO5cDkrTuTjN/XzF/H9ySiohA26dbR7OH0SklDnuIXsUt88LEirf6xmIjhcBY7H2sKVepU4du483eMjXMID6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5498
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: Jason Wang <jasowang@redhat.com>
> Sent: Tuesday, June 22, 2021 1:13 PM
> 
> 在 2021/6/17 上午3:11, Parav Pandit 写道:
> > $ vdpa dev add name bar mgmtdev vdpasim_net
> >
> > $ vdpa dev config set bar mac 00:11:22:33:44:55 mtu 9000
> >
> > $ vdpa dev config show
> > bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000 speed
> > 0 duplex 0
> >
> > $ vdpa dev config show -jp
> > {
> >      "config": {
> >          "bar": {
> >              "mac": "00:11:22:33:44:55",
> >              "link ": "up",
> >              "link_announce ": false,
> >              "mtu": 9000,
> >              "speed": 0,
> >              "duplex": 0
> >          }
> >      }
> > }
> >
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > ---
> > changelog:
> > v2->v3:
> >   - using new setup_config callback to setup device params via mgmt tool
> >     to avoid mixing with existing set_config().
> > ---
> >   drivers/vdpa/vdpa.c       | 91
> ++++++++++++++++++++++++++++++++++++++-
> >   include/linux/vdpa.h      | 18 ++++++++
> >   include/uapi/linux/vdpa.h |  1 +
> >   3 files changed, 109 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> > 1295528244c3..40874bd92126 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -14,7 +14,6 @@
> >   #include <uapi/linux/vdpa.h>
> >   #include <net/genetlink.h>
> >   #include <linux/mod_devicetable.h>
> > -#include <linux/virtio_net.h>
> >   #include <linux/virtio_ids.h>
> >
> >   static LIST_HEAD(mdev_head);
> > @@ -849,10 +848,94 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct
> sk_buff *msg, struct netlink_callback *
> >   	return msg->len;
> >   }
> >
> > +static int vdpa_dev_net_config_set(struct vdpa_device *vdev,
> > +				   struct sk_buff *skb, struct genl_info *info) {
> > +	struct nlattr **nl_attrs = info->attrs;
> > +	struct vdpa_dev_set_config config = {};
> > +	const u8 *macaddr;
> > +	int err;
> > +
> > +	if (!netlink_capable(skb, CAP_NET_ADMIN))
> > +		return -EPERM;
> 
> 
> Interesting, I wonder how cap would be used for other type of devices (e.g
> block).
> 
> 
> > +
> > +	if (!vdev->config->setup_config)
> > +		return -EOPNOTSUPP;
> > +
> > +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> > +		macaddr =
> nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> > +		memcpy(config.net.mac, macaddr, sizeof(config.net.mac));
> > +		config.net_mask.mac_valid = true;
> > +	}
> > +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]) {
> > +		config.net.mtu =
> > +
> 	nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
> > +		config.net_mask.mtu_valid = true;
> > +	}
> 
> 
> Instead of doing memcpy and pass the whole config structure like this. I
> wonder if it's better to switch to use:
> 
> vdev->config->setup_config(vdev, offsetof(struct virtio_net_config,
> mtu), &mtu, sizeof(mtu));
> 
Well, we need a way to differentiate that the caller is management tool and not the vhost path.

Instead of passing some flag of the caller to setup_config(), a explicitly defined callback served better.

And secondly we need to return the error status. setup_config() cb is void. This is the minor one.

> Then there's no need for the vdpa_dev_set_config structure which will
> became structure virtio_net_config gradually.
> 
> The setup_config() can fail if the offset is not at the boundary of a
> specific attribute.
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
