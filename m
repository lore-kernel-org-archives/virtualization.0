Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF90DC433F5
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 12:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CEDF41626;
	Tue, 17 May 2022 12:21:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tqoIn-ZeBcrt; Tue, 17 May 2022 12:21:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9C3C9416E3;
	Tue, 17 May 2022 12:21:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61F8EC0039;
	Tue, 17 May 2022 12:21:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 715B9C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 12:21:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4DD99605AF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 12:21:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u3PJFcKMnmlh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 12:21:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9655F61164
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 12:21:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5Bg73ZOi5AfRM5pNqeG0HkDmwdloleZYBI9/NEnIQcJbf12mz/Zv8B0tUM/RY5v0vV0raaR+nwjq2jv1BQUEvaC7rB00n6aG0EBNzaWFSCKncS/1ltZ7tN2v01uJ5kcUHJKNJ7r7k0jwmCBy9mMq/3GJ8BSS2Phpf7DQcFsn0SUHC2UFi2eohXr5eTojqc3NY5Y2V0Wn11Z5HrlSvEkGd1C0hWzuT3jCEUketsmZDlKXy+aAXLBhgCMJpk8Ym+vS4dQe7dCAEnRPW7u/28OP8Bh4rtqCzA5vs71PhrPyFtZWdpDO0oanUj/t9TRqVWktmVL8iFMLe6Mm/yyhYzUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kf2zgphztjmZJMNl+YKgZgK8wPvcUpP0e2M2zAvKfiM=;
 b=eL6lS+uLlggtJqeCqx0gqDYLmgzCaqTY6ilzN07RyRnr9Z9RxiM3HUaRy51fN3pXu3lKKJr08Hv3LJSbEjPl6dXuY+lbaPJU5+z3hECB18uhzwcIWBbJ/nS80CvuEetg5bDB3pIGjjaMK+6tF439hcdmHLnCmqWit22WajJDlLWk4nQio7NmycfDV0C5Zy1dnUdvaA91sHZHr44u/kwl7yHSVvxgtWcWSjGIV8wyOJqtR0DfNibWuLQRd/LC4dFzJT1oZqld4aG6npK5JNtRQh4wiM+ejNPEBvq8tP+Tj2TqcYGYpb39YHzR/uFcIlg+iGCtTRxu3BuD94vVgeu2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf2zgphztjmZJMNl+YKgZgK8wPvcUpP0e2M2zAvKfiM=;
 b=VHPRgwfiCav9Aqt2LoClgc6ff84T+OqaDa/Mu2m1fbHKXagW50q0KvuSziLAAE7j/diAXNyv32r2BYiXVgomA6OgWcnLf57gaafF8ogFgJifadRj9HsdtiBlMAG4g7DQCNFGym67ybxpJYG5SUbMeG/5GX40hgmHK2TV8Z7PHLR+B7slkdrQVFv0/MkziFOKQj0fHdrhDzBMHIRanjNhG9RbZ+nVyTVCTtHTy6DAoJ/Q5sBIg2gcLrchorKGX/Rm0caw5zq5JjsS5UMdOtvEiCu/M4kWuxT9jvEqOMneAbgjl6G/pMwEVAZ9D09ZuubO7+dFiaO91E4UWfO6RsSZAA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 12:21:03 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 12:21:03 +0000
To: Yongji Xie <xieyongji@bytedance.com>
Subject: RE: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
Thread-Topic: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
Thread-Index: AQHYaOqkgz3W9mP+EUqOpcefr9+WPa0h7mWwgAC+VgCAAEk50A==
Date: Tue, 17 May 2022 12:21:03 +0000
Message-ID: <PH0PR12MB5481AD3C1517331EAC4EE078DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220516060342.106-1-xieyongji@bytedance.com>
 <20220516060342.106-2-xieyongji@bytedance.com>
 <PH0PR12MB54813F96E346D591FBE238C1DCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACycT3sRc4bk+3oq7FLzpBMCG_XRN7tOaeEAtNg69o3h8c3=EA@mail.gmail.com>
In-Reply-To: <CACycT3sRc4bk+3oq7FLzpBMCG_XRN7tOaeEAtNg69o3h8c3=EA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c79f390b-c393-43f1-c7f6-08da37ffb606
x-ms-traffictypediagnostic: DS7PR12MB6238:EE_
x-microsoft-antispam-prvs: <DS7PR12MB62388E147638EB4ED1D2948FDCCE9@DS7PR12MB6238.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LIplP0ebSCQGl0HzQOOrQun22ZNcOGoGtLZ3ICPdeJGB5REUJzZ8MJp6aBdX/zETVFksMkQ5669lkHBPDiY2G7FD6Sgu1ooLGRJPmwGAmIaLVQwmrqQRGSb6aNi3Ue78n9v1WtQo2HFfZJ+Kd4NW28nZ//FXhTegN/37CqCZQtYLMzaNNaez9XHi5rBI0VZOdCECQh8s5aOMGaC+fTw1l1xzqWUaN2gHCFJHcSxSIYdKYmLao6X3DoYD/2cwMhCKY3CoEUvXyoIsekrQB8ir0zZ29V4NHN6Nr6IdqyaLOJ7IaXOK5LOrHcOHHNG+3E5xgku2nBr4NiRNDzhPM5EPxkqY60PliuN6DNoaKbElTICgpuzehMpQZS0QihHYC43W99WKSnO0sA47xkyCNyR563S9Cau/Ej5hYA8sGKVixZ9yPydcBO8BKIQxMGF1Ec0L4FzGPYW4VXWk5p4GD4dtLj4wnJe/i0Z3TOwp84LtFUqFox4kTksAJDnd8LWtkHUtR0v/ZfFRK7HgkMJX8ADT2ncmFe6om7gQepDVMt0Qzr2fKt+mLAutHXqaVQYS+yNfwkUZooACZInzQ9Ja4h9rlZ2nLeCop9QjHAC3aPyD2c0B8xDPLS19L9EA86S/bgVXOEhIxV6um+WtA/DQVTeqzpqBwyrUXYmU/XkgRH0nEJ8pCM1eTzvY/AI6FcpdEPGzv0VIpRdnoylnalPDkoPxQF930vYiPeiCaeEqPv8QBoeIE4Lm0652MipdgUX92d86RB0bVckxuH/CwCH8JuTQR91I0ZrX0XFhLowvWk6r8e0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(66476007)(66556008)(66946007)(66446008)(64756008)(4326008)(71200400001)(86362001)(76116006)(122000001)(7696005)(52536014)(508600001)(8936002)(6506007)(53546011)(33656002)(5660300002)(83380400001)(186003)(55016003)(54906003)(9686003)(2906002)(316002)(966005)(38100700002)(38070700005)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JlsejtuhT/IVStriCWCWrmP8O+Jo+POuQXm6bqkGsJqDVYbi6cNYJR7bHjQq?=
 =?us-ascii?Q?2QIax1SK7xeeTc53Q0hxFVG0EATkO1dtPtU28i5QsAA0RIE8xanId5etFH67?=
 =?us-ascii?Q?3uKqbSjClsh5eC7jeZcxfAhf0nIYvxmeUq/xi4U1LHGlPsBst+RhJ4dPqoIU?=
 =?us-ascii?Q?q4QWIjLFfyTk/4RUj1wKjZkQYOKnXLwJb5iqe380qAXpK7vZIoONeaqpDHCO?=
 =?us-ascii?Q?AilhsCPYhNeHC9ww/nXCdfrJfl5xm+Q5oSfcSQbrmHEQZNGyK5SeWjsajvpO?=
 =?us-ascii?Q?EYn3CC1wFGLS2sZDA15TuuTtaFyMSHtAWVF3yssoQ1QELlkt18PV42jw5y2S?=
 =?us-ascii?Q?hMsUMZR9L5LPzuEf+iyqCK+JhW6c6TtOeilp+KZHpq8w2+iv+HroG+8aMxNS?=
 =?us-ascii?Q?CO5IBuFA8cVGVVbwagsroJEJQSN7Bx+b+et09JmOWXHb63oP4D+6oFMbO6HS?=
 =?us-ascii?Q?0fP1Y3WdlahlN2EHj4BUn9sfsfhTVlHyPbzK7/x/fZgDzhDY/4acmexnUUtQ?=
 =?us-ascii?Q?YxSRz/lMt6IFP0nXwo93I1X4sOhKJqGvDlo28HOzAjgYBk/Tlvykn/lz6lUc?=
 =?us-ascii?Q?6l2/7L5tCzWjV6jDyqHSeCT0cmjFtOukaS6Fr1LClECjrfOdTyqb2jIXetgo?=
 =?us-ascii?Q?V46z6R9Vc0Lxr4OC08Nd0/FaYfFt5eh/Wvpg8VtiGCgwuDI8zucfdQdW3jHy?=
 =?us-ascii?Q?7sfwrm7GSGoFVCEJyQKRZyrd1+sbMgdZrUv+/9ilemRKyq2cJfz7or2L0KFP?=
 =?us-ascii?Q?qbL+66KlV++6K8T/URAx1Ci2A5XIKIbHFFfcb6du6rXUq7fZduG331i/+Bpb?=
 =?us-ascii?Q?ICcsBkZGjCnW5fZzJjbkZzYXY88eVeavl5K1bH53tsDIWZ3MMNtgNzvRviKy?=
 =?us-ascii?Q?quosM0gdO0buqZK7zQFgX30zzAofrowf13PrFbiz6jBr4GPDV4GXeYUe4GEp?=
 =?us-ascii?Q?ul5DkubH8j2q9nFZT1+LpUy43N4v4UwOez1lr3wahSryRQtQjciOgmTu9/cp?=
 =?us-ascii?Q?NHDDKMXSqMT6pyQ1h3Xb+XmkNQD2i/3uvPMb1psPcVj1Qz00YSPwbYqOW9qN?=
 =?us-ascii?Q?CAhe3ufs9N219E4DvEPjPdw1lCxslQPD6be5/CyG46VFJHpQSQ+ubkHXo+cc?=
 =?us-ascii?Q?/s6N4lqk0fP5RxJxi69tAf+pLOcmmzYyNb0KS0Q2w+YFWpP3cjkHJWjtS3sp?=
 =?us-ascii?Q?xe86yxCH9t/cjpQXApfFbJvsl3Lequfm5R7Xx14DlZndgOHFxqQKi8lQeD6f?=
 =?us-ascii?Q?GUxwp3vGMZ3AAFm2EGxvCiyhxYV4a89BFr+Hdtw2NFozDU6m0mB0JWUH9h1z?=
 =?us-ascii?Q?4rbubMcNwslCKvpBy3Bzi/MBzwsivdPCAiV0qTmAwAY2fOdYERIECPbIizXG?=
 =?us-ascii?Q?aQwPYSh1kaPcONiP/qzoj7ECzEZnrgcwnyyPX53cKTkB1mNcZ6/Px6MoPYCM?=
 =?us-ascii?Q?Igmtu0VukKbgRWtrKpG6qQVGKiVrbl/lYvQYHIG8gZ7SkV38zLQ7jPvLmEFq?=
 =?us-ascii?Q?fSKDuqq65rgWldrSUQP0uh3CKLOcaUePMaHAXgizNhSjajTNFAclMafiqxGU?=
 =?us-ascii?Q?wfIIvQowvvWIlUJ6AyJ8RQklGm4DQiMhUCvqaonRF2hp3cgbJ4AspN5moidh?=
 =?us-ascii?Q?HjkJjPhucSY19nYZ3dIT/PEv8Q98pNDnw65xuiV0lLoOSqRJv3ecLilujVbc?=
 =?us-ascii?Q?7G5VZzqrb62wcWK+H3EcH6xOpZJbhYboiUyCMmEuhjYEKOXbZ/yNiEPfSrLA?=
 =?us-ascii?Q?YrIqWrEL8hOuqBidadBm28BaJZ1vlYa6ylRE0/84+9SwKns2KRXkI8gMOjxR?=
x-ms-exchange-antispam-messagedata-1: XCgssP4VsLBJhA==
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79f390b-c393-43f1-c7f6-08da37ffb606
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 12:21:03.5963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3b5Baw8RPL9QgQHTN/qsXWc82z0qRMipUNJk8eYdVbe6x3zqpJTiH2JMTKGNsddsQn6NbALLGUIFsCzxynCyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238
Cc: "mst@redhat.com" <mst@redhat.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Eli Cohen <elic@nvidia.com>,
 "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>
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

Hi Greg, Yongji,

> From: Yongji Xie <xieyongji@bytedance.com>
> Sent: Tuesday, May 17, 2022 3:25 AM
> 
> On Tue, May 17, 2022 at 4:06 AM Parav Pandit <parav@nvidia.com> wrote:
> >
> >
> >
> > > From: Xie Yongji <xieyongji@bytedance.com>
> > > Sent: Monday, May 16, 2022 2:04 AM
> > >
> > > Introduce a device object for vdpa management device to control its
> > > lifecycle.
> > Why is this needed?
> > What is the limitation of current approach that requires new device for
> mgmtdev?
> > The primary motivation is missing in the commit log here.
> >
> 
> OK, I will add one. This patch actually comes from the discussion:
> 
> 
> https://www.spinics.net/lists/linux-virtualization/msg56371.html
> 
> The "vdpa_mgmt_dev" makes things a little confusing. Embedding the
> device struct in it to control its lifecycle simplifies the logic and makes the
> driver model clear.
> 
No. it doesn't.

vdpa_mgmt_dev is really the handle for all the netlink socket messages targeted.
It is not really a struct device.
We can rename it to vdpa_mgmt_handle, if the _dev suffix is confusing.

And regarding vduse_dev_release() and existing empty release function, they can be dynamically allocated.
This is because they are really the struct device.


> > > And the device name will be used to match
> VDPA_ATTR_MGMTDEV_DEV_NAME
> > > field of netlink message rather than using parent device name.
> > >
> > > With this patch applied, drivers should use vdpa_mgmtdev_alloc() or
> > > _vdpa_mgmtdev_alloc() to allocate a vDPA management device before
> > > calling vdpa_mgmtdev_register(). And some buggy empty release
> > > function can also be removed from the driver codes.
> > What is the bug, can you please explain?
> 
> I'm not sure if "buggy" is the right word. But the empty release function
> should be removed as mentioned in Documentation/core-api/kobject.rst.
> 
Sure. So, struct device in the vdpa_sim and vduse can allocate the struct device using kzalloc() and release callback can free it.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
