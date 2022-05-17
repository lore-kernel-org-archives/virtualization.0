Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688B7C433F5
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 23:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17F938378C;
	Tue, 17 May 2022 23:03:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LweVMvvhzFcp; Tue, 17 May 2022 23:03:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 61C198349A;
	Tue, 17 May 2022 23:03:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A75AC0039;
	Tue, 17 May 2022 23:03:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65CF7C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 23:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3DBD041714
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 23:03:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rgoi7Kqq5DLO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 23:03:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::604])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 03CAE41712
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 23:03:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpWFwx5VQjey9VPGxV2oDDqEE7zvNEl5CJGiJFOA46CQaPN9KuiZ3t/TXwUggwR/FpRT0GgjpORXyNT5ZIfsZaI2wwCa7v1B/EEeVCGUX2I7AxrJ3HEYdyFjhR2fNuHYx8ZHbCowG1iXonGum7tfnXazdEdu4VMwWW/ms3ULGxDDyKozYN5Pu3escmvyvHqyLIUwAitpD3yAVJeBSQ3qBw/k+xv6ylHNBkm4dSU/moPnSpaXt6TNqkiE+bTKBPiZwnmqI7bP2stzEkPVIuXZOsag+jTkxkTM3JcWsszMufeCfGUlJVihj2tgLCUZs0MbTfN+WW9ZtWlsFJo5mYL2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vugZWmjZfj3+BG3RXsRLPV4Wr2GNrH2koHSY5zBRBDY=;
 b=ASW9Oqil9jqORG1OPQjzpWemSzRDhpTP2m94NNQ/yo2skSboY8aHp/Y544T/MvFyjq4Nxs7ZobAKQ1Mgpwq8T2VHPbl7OPNhFMxIK/WiCPLwclrAfV6NAG6819JyorHz5PZB8xKs14Q6oMSNa7XVRUBwNAuJQ9TiKeCxhAAt+WNCt2OLmyAil9qDhirUEM0g2LhT3zyWOghlbtqh1EDPWRbowDiXgNfaUCeX8C1R3FMkOcxc02nd8JkR+eSTOR/aQyQ+CVmqGXehRob7D/Uvzq8Zp1MzBbdsd40Vg5Bmu6hHvZNWfk31l9lWM6CwMvGSrwJ6kiuVP7OYFEsGB9HReQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vugZWmjZfj3+BG3RXsRLPV4Wr2GNrH2koHSY5zBRBDY=;
 b=dmMYEzOfGZ1/BzvVSOuH7qRc02Y6yb8OdGwXyPl+cZ4uC7iusrNYnrPpYB4lgd1f74Df44nQeg1kUfvtCaKjC5FBiHZXCbKvKPZG/3yj297o51uyb4aATyOKlBgUR1jfBnh2YDvmn7hNvxp3WU0CYcsZpzQhJUhLOfKlrKl+R98uCj/OnU3P3uc/vQCIrbDKQ7x7jDpbEa627aWmwdzAq7RMNrJ9pDns3Qn1FVWgYGr/GIoZuuPeuv8OLrzNH07ikY7flIizxXQ+TLeB61KYMeNK4KjwzfePsB/iaZsyf2jxQt1DFcBMK6DjbwYQV5ctYn5KVvIHBjYv9ygQFiRxDg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 23:03:34 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 23:03:34 +0000
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
Thread-Topic: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
Thread-Index: AQHYaOqkgz3W9mP+EUqOpcefr9+WPa0h7mWwgAC+VgCAAEk50IAAI2SAgABj/vA=
Date: Tue, 17 May 2022 23:03:34 +0000
Message-ID: <PH0PR12MB54819F4E48BE36460BC89457DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220516060342.106-1-xieyongji@bytedance.com>
 <20220516060342.106-2-xieyongji@bytedance.com>
 <PH0PR12MB54813F96E346D591FBE238C1DCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACycT3sRc4bk+3oq7FLzpBMCG_XRN7tOaeEAtNg69o3h8c3=EA@mail.gmail.com>
 <PH0PR12MB5481AD3C1517331EAC4EE078DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <YoOpBaWcaoujWqO7@kroah.com>
In-Reply-To: <YoOpBaWcaoujWqO7@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39662db3-6d52-426e-739c-08da3859782e
x-ms-traffictypediagnostic: PH7PR12MB6465:EE_
x-microsoft-antispam-prvs: <PH7PR12MB6465292DD34B142C5E87FAD6DCCE9@PH7PR12MB6465.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jENP4eX7ymwJztWwRNGCKBL1vYwvfVkmp00yhdfbNX8nZwxzE246z3IWvidajz88Tc+WyG8AjVK7uiCub/0Y+YqlHm7a/KzISHWH1o+dF0RmdJ8CykKDR66eT6vSo3NG4KazqdWvcBM3cEH7s5R49+ELXA3I42apR/9b7fykvz8I4wFcNQMz5M0jRIgqamF/BEjq9cjumLLTGd5cWHxXRz5PGfWi2r3g1lcYLgmRuiSxsdJN1SmfReldf0VGQAhMHo7ttSgkR3v7rpF9BdyQCA+VE0a6e6l0G5mpKDseIfNpzExpPKHiid0TqQ77aHCOaJMPK5BR5IOoq7r0wdlpwuAUvUtbmFLjQCMZE7ums2bqva2P7G/eWC5GPuyqJP69k1VhCT+/kb3pNm25iUHRVZaWJoWOXpBlrN0xQFsw7U1GB5KNOxfJS9iU7TBrHiTFmeWXj8f9rwvyeMieS2k+BxYQIIjaDZqgPwvJOXe1Plz9s/x3Jk40ugEncBgZQ6ATR5lxsuHSTGQzgvsQ6TFVpxlA12P7u3thpoPIjVp6f0BowWH49jv6DBG1gy//XhksiKhnK3y0LD+9Ha2nb0UpADaBZTbhFYlKtXB7DOdHgSIJmStVronVHlQ/uHpLODq2KwE49JrqpXo1gdV5Yi7wIiv0hxnXoguyvbybni6JAOEkRi5QfmQT1uWTlnp7wJs0G9p9ohsanbwx1Xta1tQBtIbokUo7wwJqhcutd2LAHErgvNn7ID5J3vPVgdLH6nzBKV29Bwhximi7gehRMpitDTRkQpq46dk4prQvfYbxOtU00o0u2EcKDOldJFH+tsA48vFeMCgBfdGJqfh/lrqNTg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6916009)(66574015)(33656002)(66946007)(54906003)(122000001)(9686003)(86362001)(4326008)(966005)(64756008)(53546011)(71200400001)(66476007)(66446008)(8936002)(52536014)(508600001)(76116006)(6506007)(186003)(66556008)(8676002)(7696005)(55016003)(38100700002)(2906002)(38070700005)(5660300002)(83380400001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?boc+mRegel3YB0mSbGcWYX6P22ooykKG8BaeImJuC2H39BUwaQRBp+IoNfxe?=
 =?us-ascii?Q?c9Lj7TiL12PCZFaJuVExWxiKYjaGan9KKETb87Jc9V2b0urfJyNjsAHH5F5y?=
 =?us-ascii?Q?k9/KFfIRyFm4zuqkHJHLxMZr8OU0K0tQQ8UxX6On9cM+ycvJMLeSe0D0nDID?=
 =?us-ascii?Q?T+jSNGA3FM3PT5bXYWLWhcRDVfJohznG+uQcUKHSZnWWvEzTB2bHmUbL69t1?=
 =?us-ascii?Q?L+GsXms2qwlMmebocjR8/vLB/feNF7YPIWUJ3kecJ2UD4N7A9DARTmDxDRQi?=
 =?us-ascii?Q?+LslTnVCMM2d7hJASHw7edC7dViCdxLp83CvhcKU3sAEh7BK2xJNz7jHIfIt?=
 =?us-ascii?Q?ivlnuBQWO9kmcho+nLkGIdHvmxztPawksjpYqXGn5l56qk9YHtjG+rTcTI48?=
 =?us-ascii?Q?Y7oLSNVw6B79ELiLGili12Yzzicit5GmVy0SuYg20u8ByYze3ozSJp7fj6BW?=
 =?us-ascii?Q?VJMyb/KBpu8w1+2rjhEr0D7BUTSBeFoq8084veKneDnmsE9KImeiyFD+v193?=
 =?us-ascii?Q?deolFZFaa1aOBgaqQsQC3DFZWNadmzp2lMnXFoTUYelKmd0tEJa9VnPR7sWb?=
 =?us-ascii?Q?kKdO2Jc35e5PQUHPlIe9ZY4t/PFt/oTGtUdrqgUy/9scsQGuCNFgMYcEbFC+?=
 =?us-ascii?Q?bwDUsjtIT2ZWUSGG9MwPMnW3SBL8iYAujXVXm9AljsWD0mCBVzEjbAhuWnpY?=
 =?us-ascii?Q?B8V6Fc7C/NuTJgHmvtmhzrAxihkk+dI8eG1RT4o4Ee+xoKAkuQUYIrXkRdSN?=
 =?us-ascii?Q?QysVwR5NhIX1ZKxizah6x4YW3Xoi2GrisguF4fWULX25dIXwJ5slsx///pAV?=
 =?us-ascii?Q?duUWjblpZwfqy0988qNYhiAUxWXHA+jQtSKXv9oa6GxgEE5JyrXGMiq7v9Yt?=
 =?us-ascii?Q?/1Ue0p85LW9D9E7Q6FnXOY5she0mszdxpvAo6ydNhAe2luIopXSpzM1D5K3i?=
 =?us-ascii?Q?YBLnnWcGKhj8A64GmjbhRXxi6jz2pbYGd9i09niLxGQIpp1mQsL4L0s9hmEN?=
 =?us-ascii?Q?6C5UZi/DA3jYb8GMMvZRvjnR3AKeW6ZV+/8iX30EgSS8fCS46xJ2es7gfe3S?=
 =?us-ascii?Q?AAutAkSaw3GW4dlF0uflqXswygc4eBa7UJpKN6erQRYPKzvjrypQSuh4KyIy?=
 =?us-ascii?Q?cr58dTmL1QQIHRW05yplWeVipkolO5CZTLz/LfuWuDopT17kpCdHxPneZyJz?=
 =?us-ascii?Q?BA8cesGYUCi6Ko0WB/SMk/iiQFa3TSB9FBsunZyn/JHHc/BnWDLHipvxH341?=
 =?us-ascii?Q?CfXNiQwe1j9/KUU8ZPP6Ni6O878/aoPXA8dTBtXTanTKFQYtVNmv2Xs9kuxn?=
 =?us-ascii?Q?sgnNIHtDfNXsdP1fciLtERhyie870rBLSkhqVWaGJh5/6g/cbFv20MTn/xDN?=
 =?us-ascii?Q?qWv8fUJIX4g9cC8PsDIMwE/n/jMTNJzPQngtm5KikvcyuVlJFLfHeJc1yo6K?=
 =?us-ascii?Q?brU9wDJTFqVps7VYLYJyB12wGeE5HJ6EvvVTUw7foX7FtNFXU12UaGO2EvCB?=
 =?us-ascii?Q?0iNhsV7P6uCI2zvL4YzO2Ab+hp1cyC2CyluMYlC9QyNJdYISssGrnvXsYMAe?=
 =?us-ascii?Q?ZN2Hj+hQn0lyUasdcb/A1Z94N7kAsTchf2uqnac/TaJIWjZC3WOQAXU5h/ZI?=
 =?us-ascii?Q?3CRaW4lheFiMScrgLVGsMalQH2WzULXOlGCsbTYmmMwXaa7vWAf5OtuH/ZyP?=
 =?us-ascii?Q?h4rS8uqd+7oprn9zfB2URGHfP9lxl4kxhl90irYB5EIya7F//vkQ0KYRhfno?=
 =?us-ascii?Q?1vpxwK9akbd7YMyNufrFBkIYYSVGNi03MbI/TVGFaFmM6XvnYMBxfioZ3p1u?=
x-ms-exchange-antispam-messagedata-1: GOVt9pvjBMdJXQ==
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39662db3-6d52-426e-739c-08da3859782e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 23:03:34.5264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6MhuuNsw4Pg1Xawp1Iy9YLNO+yWA7E9N8827OahUHtcwV3J/s1HBh2Sziw5tP02iIKWguQ2c1a5jSeUuOjoAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
Cc: "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>, Eli Cohen <elic@nvidia.com>,
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


> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Tuesday, May 17, 2022 9:54 AM
> 
> On Tue, May 17, 2022 at 12:21:03PM +0000, Parav Pandit wrote:
> > Hi Greg, Yongji,
> >
> > > From: Yongji Xie <xieyongji@bytedance.com>
> > > Sent: Tuesday, May 17, 2022 3:25 AM
> > >
> > > On Tue, May 17, 2022 at 4:06 AM Parav Pandit <parav@nvidia.com>
> wrote:
> > > >
> > > >
> > > >
> > > > > From: Xie Yongji <xieyongji@bytedance.com>
> > > > > Sent: Monday, May 16, 2022 2:04 AM
> > > > >
> > > > > Introduce a device object for vdpa management device to control
> > > > > its lifecycle.
> > > > Why is this needed?
> > > > What is the limitation of current approach that requires new
> > > > device for
> > > mgmtdev?
> > > > The primary motivation is missing in the commit log here.
> > > >
> > >
> > > OK, I will add one. This patch actually comes from the discussion:
> > >
> > >
> > > https://www.spinics.net/lists/linux-virtualization/msg56371.html
> > >
> > > The "vdpa_mgmt_dev" makes things a little confusing. Embedding the
> > > device struct in it to control its lifecycle simplifies the logic
> > > and makes the driver model clear.
> > >
> > No. it doesn't.
> >
> > vdpa_mgmt_dev is really the handle for all the netlink socket messages
> targeted.
> > It is not really a struct device.
> 
> Why can it not be one?  It has lifetime rules that must be followed, so might
> as well use the built-in code to handle this, right?
> 
Lifetime rules are followed.
That is, during unloading of the driver for the struct device* dev, mgmtdev must be unregistered.
Following the exact mirror of creation.
I general before deleting the struct device *dev, its upper layer user mgmt. dev must be unregistered.

There will be zero user of this struct mgmt_dev, after invocation of current API vdpa_mgmtdev_unregister().
This is the onus on above unregister API.

Any cleanup cannot be differed until newly thought dev->release().

> What is wrong with it being a struct device?

I am not sure if its fully wrong.
First for this struct device, there is no real driver bind to it.

Secondly, it is simply an overkill without any visible use.
vdpa_mgmt_dev struct has only register/unregister life cycle.
Unregistration of it stops and destroy any outstanding operation on it.
Any code accessing mgmtdev post unregistration simply won't work.

Anything pending cannot be freed in the newly sighted release() callback.
Freeing anything in the release is too late because hw resources are destroy after unregister and before release().

Contrary to it, doing so will hide bugs because such struct will live longer now if done as struct device.

On a side note, these devices are in 500 to 1K range and expected to grow more.
Creating yet another struct device and linking it to its parent would result in additional sysfs links, udev event explosion for no absolute use or doesn't bring any object lifecycle changes.

vduse is a special case in the kernel, that has to create a dummy device because there is no real device (like pci) linked to it that can service vdpa commands.

> 
> > We can rename it to vdpa_mgmt_handle, if the _dev suffix is confusing.
> 
> Where is the "management" device if this is not that?
> 
> What does "handle" mean here?
It a handle to on which commands are arriving via socket from user space.
These commands are serviced by the struct device *dev.
DMA operation etc also happen on *dev.
You can think of it as unique handle to refer to the kernel like netdev->ifindex on netlink messages.

> 
> > And regarding vduse_dev_release() and existing empty release function,
> they can be dynamically allocated.
> > This is because they are really the struct device.
> 
> I do not understand this statement, sorry.

It was bad sentence, my bad.

What I wanted to say is, probably better explained with real patch below.
In context of [1], struct vduse_mgmtdev empty release function can be avoided by below inline patch [2].

[1] https://www.spinics.net/lists/linux-virtualization/msg56371.html

[2] patch:

From f87d557fe939a1632473dd11526a87301adbab8d Mon Sep 17 00:00:00 2001
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 18 May 2022 01:22:21 +0300
Subject: [PATCH] vduse: Tie vduse mgmtdev and its device

vduse management device is not backed by any real device such as PCI. Hence it
doesn't have any parent device linked to it.

Kernel driver model in [1] suggests avoiding an empty device release callback.

Hence tie the mgmtdevice object's life cycle to an allocate dummy struct
device instead of having it static.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/core-api/kobject.rst?h=v5.18-rc7#n284

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 60 ++++++++++++++++++------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index f85d1a08ed87..ebe272575fb8 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1475,16 +1475,12 @@ static char *vduse_devnode(struct device *dev, umode_t *mode)
 	return kasprintf(GFP_KERNEL, "vduse/%s", dev_name(dev));
 }
 
-static void vduse_mgmtdev_release(struct device *dev)
-{
-}
-
-static struct device vduse_mgmtdev = {
-	.init_name = "vduse",
-	.release = vduse_mgmtdev_release,
+struct vduse_mgmt_dev {
+	struct vdpa_mgmt_dev mgmt_dev;
+	struct device dev;
 };
 
-static struct vdpa_mgmt_dev mgmt_dev;
+static struct vduse_mgmt_dev *vduse_mgmt;
 
 static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 {
@@ -1509,7 +1505,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 	}
 	set_dma_ops(&vdev->vdpa.dev, &vduse_dev_dma_ops);
 	vdev->vdpa.dma_dev = &vdev->vdpa.dev;
-	vdev->vdpa.mdev = &mgmt_dev;
+	vdev->vdpa.mdev = &vduse_mgmt->mgmt_dev;
 
 	return 0;
 }
@@ -1555,34 +1551,52 @@ static struct virtio_device_id id_table[] = {
 	{ 0 },
 };
 
-static struct vdpa_mgmt_dev mgmt_dev = {
-	.device = &vduse_mgmtdev,
-	.id_table = id_table,
-	.ops = &vdpa_dev_mgmtdev_ops,
-};
+static void vduse_mgmtdev_release(struct device *dev)
+{
+	struct vduse_mgmt_dev *mgmt_dev;
+
+	mgmt_dev = container_of(dev, struct vduse_mgmt_dev, dev);
+	kfree(mgmt_dev);
+}
 
 static int vduse_mgmtdev_init(void)
 {
 	int ret;
 
-	ret = device_register(&vduse_mgmtdev);
-	if (ret)
+	vduse_mgmt = kzalloc(sizeof(*vduse_mgmt), GFP_KERNEL);
+	if (!vduse_mgmt)
+		return -ENOMEM;
+
+	ret = dev_set_name(&vduse_mgmt->dev, "vduse-la");
+	if (ret) {
+		kfree(vduse_mgmt);
 		return ret;
+	}
 
-	ret = vdpa_mgmtdev_register(&mgmt_dev);
+	vduse_mgmt->dev.release = vduse_mgmtdev_release;
+
+	ret = device_register(&vduse_mgmt->dev);
 	if (ret)
-		goto err;
+		goto dev_reg_err;
 
-	return 0;
-err:
-	device_unregister(&vduse_mgmtdev);
+	vduse_mgmt->mgmt_dev.id_table = id_table;
+	vduse_mgmt->mgmt_dev.ops = &vdpa_dev_mgmtdev_ops;
+	vduse_mgmt->mgmt_dev.device = &vduse_mgmt->dev;
+	ret = vdpa_mgmtdev_register(&vduse_mgmt->mgmt_dev);
+	if (ret)
+		device_unregister(&vduse_mgmt->dev);
+
+	return ret;
+
+dev_reg_err:
+	put_device(&vduse_mgmt->dev);
 	return ret;
 }
 
 static void vduse_mgmtdev_exit(void)
 {
-	vdpa_mgmtdev_unregister(&mgmt_dev);
-	device_unregister(&vduse_mgmtdev);
+	vdpa_mgmtdev_unregister(&vduse_mgmt->mgmt_dev);
+	device_unregister(&vduse_mgmt->dev);
 }
 
 static int vduse_init(void)
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
