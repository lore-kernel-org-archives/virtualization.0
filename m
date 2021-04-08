Return-Path: <SRS0=B6Di=JF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F1BC433ED
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 06:23:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6488760FF0
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 06:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6488760FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E13B60E42;
	Thu,  8 Apr 2021 06:23:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sfaMdwH1q1et; Thu,  8 Apr 2021 06:23:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F4D66063D;
	Thu,  8 Apr 2021 06:23:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DBA8C000B;
	Thu,  8 Apr 2021 06:23:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6986EC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 06:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C17584CCF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 06:23:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id elIn49zPB41W
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 06:23:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 931BD84CA5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 06:23:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpNmD27hDLZYzJtF5OwI4WL9cbTGDVcWH674Is8HBtpszNzp6KhqzRjyOkN8HdS4uror5nUSDHJ7anpoJAi4d3ckT3JKzE11w2Z6sqBqzbT25bJaGvGRjKs/5r0N5MVkb+OqNg0vxwq/eUJ5I6pftHCjsHrA3p9rdbYHHYvYXQ0dCmYFzH7+ujiVUEMGYr574OK2XasbC+tT4VUYtn0NzwFMNunGDpk0PskHCUcgkMUasmSnRxNFwyUnrWdxlg0ycnVSGYSYA4yYTSQueY2YFgt6aW6Lm9Tt89B40iuba0Bbb5wdoeG+5VLn/dDD9N5nY8hsYPVZsN/BQKjp1E/0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ7CeYurTqcTpn8wg/j05FETH8B7DpXxOxobpJUmqQQ=;
 b=TBU89epLmDoCoCK5qFsve84n0VbQtQB+x8TbEZYs4RVuakgD39LsonUO8WMgtCiKp81zqLyCMLPyup9RXxYSCgATae2J4HysNDW7lwWXtGRc4ubvN6DMYDRG/IIkt/h1ONUlFNks2OKVlgMjo0uypqhNMgHNuiASfC+1FVfNK3TadIX7wPICwLBxWEFfdu/uc2JTgOZj8PBzE0FbifNimAVpsq73os171xxfL8JFpEZBOM4KJQkMbaBJgv0JDgKnJ6iEtV3x6R+uVcxhE/SdJe4PHz4z9iNDOoQceFCk2jJz2mQ63UtwNkzQ97sDlg8fWf02RL4GPkJkTvSY2DYh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ7CeYurTqcTpn8wg/j05FETH8B7DpXxOxobpJUmqQQ=;
 b=Y9bVFp/LI4iU4sSJLUqDpGDeOGvC9CR0imSldHyZPeP/vePWkHt4CE8kh7FSjH+6CzmhzcIdfwZCahcEcK+I3eJcdpttcTEXe87YXROAE4W11uFth1Pxn3CZ7j5k7pqz6ss7jjxckvIjYVGCurfOTSApkr9A3RT35jqL8Sh4F+X3jbk+HjTV5GE632eaf+z1j69zBMFIfHI8YWaBgTE2C4fZF1wm8Jt0WNaIl/anaoEmSSYwlHirKPixthwphh3o44jddHHRQ9pZ01fVssR648xgHStvTQPy1222+gZvet/jh6sIzmK23gC3Q6WNM5BuDgeLQDw/wh9LxnOovikAfA==
Received: from DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20)
 by DM5PR12MB1371.namprd12.prod.outlook.com (2603:10b6:3:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 06:23:28 +0000
Received: from DM6PR12MB4330.namprd12.prod.outlook.com
 ([fe80::4d1e:778d:d6ee:b2cc]) by DM6PR12MB4330.namprd12.prod.outlook.com
 ([fe80::4d1e:778d:d6ee:b2cc%8]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 06:23:28 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v2 04/14] vdpa: Introduce query of device
 config layout
Thread-Topic: [PATCH linux-next v2 04/14] vdpa: Introduce query of device
 config layout
Thread-Index: AQHXKwcKvOK5lWqkQUClIbp9FUDvk6qobdUAgAANqoCAACkUAIABg/FQ
Date: Thu, 8 Apr 2021 06:23:28 +0000
Message-ID: <DM6PR12MB4330B0C6144415DCE66685FEDC749@DM6PR12MB4330.namprd12.prod.outlook.com>
References: <20210406170457.98481-1-parav@nvidia.com>
 <20210406170457.98481-5-parav@nvidia.com>
 <021bd627-953d-2a68-93e5-b4c750569230@redhat.com>
 <BY5PR12MB432289ECA113D8DCD4EA1582DC759@BY5PR12MB4322.namprd12.prod.outlook.com>
 <fdc137cf-ad6a-5eec-01cf-52c0165b6229@redhat.com>
In-Reply-To: <fdc137cf-ad6a-5eec-01cf-52c0165b6229@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [136.185.184.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 637f15fe-3593-47be-fb73-08d8fa56d2e2
x-ms-traffictypediagnostic: DM5PR12MB1371:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB13719347A6996BAF7264A86FDC749@DM5PR12MB1371.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1PJLD2A6Mc6QXgDYZVS53HLIen0F5RHegVVOxO8N440Xoop6I/vylBz+peyo6IpwCEqkZj93ue7WJqyVow6E+dWk+v6cpbATtUD1lAfFrkLmb+iNJbgrRjCF54uh6SeYY+p8GereW/UHgP8dSwOf2umCbT/QTPcPZfxKIdrspIu9k8zbtHsHf0/SRGnPD06cJfG6a6Gen1Ep8Wm5Rz3GEbbod+vfgv3MUFr0jC9GjXWbzVTPs/9COpUFMZV/v2haBECPNNALphHTfeT1i8auPlUyXsmBhNHaactvqzfRI6Fmmco0fEwduusVk4u0ri5CJ20csLmSah0rTYYOXFR2dWJ/aCgUEvP+aATUfOmZEFpXlqc0uLkDU333xWDOnBnrfm4yjRO9L/TiAr4v3b4EWKgnoCVQcndRShbcn9vV59OAOelCJF2H54LPJ4HDG3QJxqCuzQ7p+IpqlOVzQ8fU3qb7gp5ekcb4KT5CtWqu1sy82MrfwtkEzEsptiBcOKmM1suod31koA9sWsQ4OMknrCeokXBQ5M/toJo5moF5C7PEDPAlmh3DcqsDtMX3jRMfBkb6S+K36O4P+0OKKZqjQC/OQjnTWmBqfVi10N/462cTVYtMCl4JK+la1I1ruo/0krm6Wx7Kmhh3pBkjKlJRjFyENyMke3PI1XkyumkYUuI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(71200400001)(478600001)(66946007)(76116006)(66446008)(64756008)(66556008)(4326008)(66476007)(6506007)(86362001)(7696005)(38100700001)(26005)(8936002)(186003)(110136005)(2906002)(54906003)(316002)(52536014)(55016002)(5660300002)(107886003)(9686003)(8676002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?MGtvdEFEUFVZRUxNa1k4aThJWmt4WDJZc2pJdFZiem53V1hOVFE4dXBX?=
 =?iso-2022-jp?B?MU5SS1VLM0c5K2pxaFVKZUFtZEJibUEvbEVFdlRnaDdhczJlSWxTVW5K?=
 =?iso-2022-jp?B?UGJQKzdDWmowVnhnL1lDek1lSHFKY3VSbVNmdkxzd1drZnNmeHQ3RkJk?=
 =?iso-2022-jp?B?a1VoM0R1RDNiODdFcm0xZFh5SzBxMG5UbmNMa0xXTTNLZGFFQWxKY2o4?=
 =?iso-2022-jp?B?eUxRR1o2bUdxMGlnOE1GNGdRbHFlVDdpNnUzeFRaUmo4ckljL0dxSFhV?=
 =?iso-2022-jp?B?b2ZDMmF2c1dCdVd1SWFxUXBRYS82YnpPNERGamRiL2R1eUVyeEtYbkpY?=
 =?iso-2022-jp?B?dnpxU0Y0UWFVb20wR0N3Y1JEempTakhkM0pOR3ZuT05NMFM1eXE3U1NR?=
 =?iso-2022-jp?B?KzFVa001S3NxT2R0RkJ0QTBzWHNPS0pYVnNQRVpvU1lsaldmclNvWnRz?=
 =?iso-2022-jp?B?Q2lCUm9YQlQrZ1VwKzY2VFBKcE5wMFJWSWY3U1cxSU1YYkwyUkV3SEgy?=
 =?iso-2022-jp?B?azU0RU1XYjUxSDlsSG0xZVFFT0FlUHZJTFF3VjZ3VjJpRWRCc2RRTm5a?=
 =?iso-2022-jp?B?SEE5YzAya0tHYmRDRGtqb2ErSUhydlBNemdXdnljSUFQOGpZKzZITkJa?=
 =?iso-2022-jp?B?ZXV5aDNOcGd4dG9Kcmh4QnFXa0tneWhpbytKeXhPM0gwd3BZcGhkbzlq?=
 =?iso-2022-jp?B?WHNYRVRpUlIyc214NlhzbmJhNitRZm56MkRnNkpVNTJXN0k3dkxOb253?=
 =?iso-2022-jp?B?d25qNmVjVkFIU1RZSTNQRDg3YmZSTlJnMC9Bb2pzSG9sZWc4MEdtUVVU?=
 =?iso-2022-jp?B?ejBsVTRlTEJaZnhkcHh5ODdnTkEvS2h4bnpDVXp2SVhTRVBaMGpqVnZC?=
 =?iso-2022-jp?B?QUpsWWRidDNiS3d5NTRXSTkzQTVPc1crY01vRStUM1N0REtWVlF1bVQ2?=
 =?iso-2022-jp?B?djIxU242WkFjQmlJVE9UV3ZVclB1cTY4UVFHbDdoVG82SElKbHRSZU9X?=
 =?iso-2022-jp?B?RHVScUcyT2NWVUdCSmFJUHliODVaYUZnZUdmVk1pdUJ0UElySkVjZCtD?=
 =?iso-2022-jp?B?clhUTUlJZ0pkVWo4OERCeGVISThRTzJnMGdJVnF4Y2tpMXYzdlJHMERs?=
 =?iso-2022-jp?B?MkdQR3JnNlVqMWJyVFlKaVErQXJDN2dkTFFnSzhLbXp2U2lpNkw3Y2ZS?=
 =?iso-2022-jp?B?OUR0TzB0Skx4bVdvNEVNd2JHMW1YV0Q2ZmpBL0dWa0dXbFV0ZGZMcTVy?=
 =?iso-2022-jp?B?NW9pVlMzblhab0h2WGxISFVYenVXb21WcGFXV1UxZzZJRVVrRFFubEMx?=
 =?iso-2022-jp?B?M013S0xrZ0pHc0VGU1VDRzJ6bktiMDM3Mm0ybGkwL0tUeFozTDMzZW9J?=
 =?iso-2022-jp?B?MW5QVGlEc2kzQ1oyZm9oWGVjT2xSYUw1bVlZYVY0YnBxVE5sSXVJdVJk?=
 =?iso-2022-jp?B?WGR0MG5BVnZoUVNtRUZZOFFjdWk2Z0pFampvdUtnNVVaRlp5NXpPOUZC?=
 =?iso-2022-jp?B?MjZLbEhUajFldUZLR3BXTWIrN0JQeWE0bTU2c3NaOUtjZXdaTFBQc1JU?=
 =?iso-2022-jp?B?c204aUJSVlpobjMwengzNTBxbnVwU1ZRWXdOenM1VGM4MEM5K0IvS01L?=
 =?iso-2022-jp?B?MTFGSkhtSUM0R2pGb1RaYzhRWXY2UmJGa21SbCttUTVsS1kvY2FseTVC?=
 =?iso-2022-jp?B?RHZpdENHaHhxMjZzb2JQZ0kycXNrMm5GRTNLZmhRREJQWVBPMjNBalZz?=
 =?iso-2022-jp?B?QTdhdHNUbFBpdWVKNEdhSFdTNGdIYVBCNzFZMXNBQ2l1dC9VbURnM1Qw?=
 =?iso-2022-jp?B?NmdxU2o0ek01Q0hGUjlUU1duZzVlQ3JVcml5WW1RZFdabVM5SGZGUzBZ?=
 =?iso-2022-jp?B?ejFvQ3lXSEc2cmhWV3NHMlhNL1pQOHdyU21SRCtPRU5ydmtJVzBlMGJh?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637f15fe-3593-47be-fb73-08d8fa56d2e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 06:23:28.4311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9KMzv6Ho5Qh/KYoS+SN5/rc9u2vGWRo/CzdRSPH7ysmosz01CqGQSZzV5qAjBXRT+PXmHVGdV2DqZvyvJlMNzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1371
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
> Sent: Wednesday, April 7, 2021 12:42 PM
> 
> 在 2021/4/7 下午1:10, Parav Pandit 写道:
> >
> >> From: Jason Wang <jasowang@redhat.com>
> >> Sent: Wednesday, April 7, 2021 9:26 AM
> > [..]
> >>>    /**
> >>>     * struct vdpa_config_ops - operations for configuring a vDPA device.
> >>>     * Note: vDPA device drivers are required to implement all of the
> >>> @@
> >>> -164,6 +200,10 @@ struct vdpa_iova_range {
> >>>     *				@buf: buffer used to write from
> >>>     *				@len: the length to write to
> >>>     *				configuration space
> >>> + * @get_ce_config:		Read device specific configuration in
> >>> + *				cpu endianness.
> >>> + *				@vdev: vdpa device
> >>> + *				@config: pointer to config buffer used to
> >> read to
> >>
> >>
> >> So I wonder what's the reason for having this? If it's only the
> >> reason of endian, we can just use get_config.
> >>
> > Didn't follow your suggestion.
> > How does in kernel management tool caller get_config  know how to do
> endianenss conversion?
> 
> 
> LE should be used, so it's the responsibility of the vDPA parent
> (driver) to do the endian conversion.
> 
> 
> > Or you are proposing to send this whole virtio_config structure as binary
> data to user space via netlink?
> > If so, it is not a practice in netlink to return struct.
> 
> 
> I don't get here, it should work as mac address I think.
> 
> 
> >
> > Also making netlink user space to understand __virtio16 doesn't sound
> correct.
> > Often orchestration is not written in C. I cannot think of returning
> virtio_net_config via netlink socket if it is your thought.
> 
> 
> I'm not sure I get here. __virtio16 is part of uapi which is defined
> virtio_types.h so did the virtio_net_config. Duplicating those through
> dedicated netlink attr looks like burden. E.g you need to introduce new
> attrs for each field of the config for every virtio devices and keep it
> up-to-date with the virtio uapis.
> 
> 
Given that only few fields are valid from the config struct, if we pass the whole struct, we additionally need to pass the bitmask to indicate what is valid.
And so I think passing individual fields via the currently defined netlink is better.
Lets continue using individual fields.
> So I think device should maintain a stable features that will is
> returned by get_features(), otherwise a lot of things will be broken.


> I've had some disucssion with Michael, the conclusion is that we should
> only advertise (or mandate) a modern device to be exposed userspace.
> Otherwise it could be a lot of burden. Qemu can still present a
> transtitonal device by doing the endian conversion when necessary in the
> middle. I'm working on the Qemu patches to do that.

Ok. enforcing this as first thing so that netlink config callbacks can assume them LE would be nice.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
