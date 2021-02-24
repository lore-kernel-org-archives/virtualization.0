Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD1CC433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 08:02:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C4B64ED1
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 08:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C4B64ED1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 610254EBD4;
	Wed, 24 Feb 2021 08:02:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EGMVnJG5gABs; Wed, 24 Feb 2021 08:02:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D3BA4C27B;
	Wed, 24 Feb 2021 08:02:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 649A5C000C;
	Wed, 24 Feb 2021 08:02:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3D08C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C39F483C9D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:02:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m7YDyDPqADmg
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:02:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E04A983C9C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:02:52 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6036082c0000>; Wed, 24 Feb 2021 00:02:52 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Feb
 2021 08:02:52 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 24 Feb 2021 08:02:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOMwL9Wbpr+Vc4Cfuy5Bahs6xTvE0ZlwFG0zZj85ahI/vM4gMqRAQt2uoY67+kipl1ee10gx4rHtbcT+O7zkzGhATo0du8bLSwukwIlRRVSKBaBD/+wUv0414x0/Z5BqcVpSrSuEkJ3xSKz22ie0Vu4XraR/8wAZMsKVZmdVOjqUD+sngdgAjuRespW4B47irwb3ovmnT0jkSN+Yt14WHiwT9AXHJhKHBw8ecMS3Wt4dsggdFfXsZFFDrneOoTTIocComSwQdl/kn/NqaKb8V0KIOrMSfvywY2SdnX1vvF2wEz9YB4v+EsHjpvpFC9oAjryPtqtCpChwKDMOb8JfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5ZLNse6N0gNAbLOURbnNIIvOOCnItPH7UOmD/tsn+M=;
 b=ic1ntSjg/d57uhvhc6AnfgEquwPCoxP63tVAgDjJNniTT50DiR8WW6tWrsvMvYivsB2IODIlFOpVe6eMj/agEPxYP+Zc2+0eb+MIdjCm5E5RM00g6EOmP2XKoD+eYl0kuq1A9g065KmPzGO1a721lGBVaFcQ0ijDbJlpbGR536Yde7JwsPLRuUC8RRGdIBSdpuThJYYkq3zMkugIrKz87iLkIVIyRN66b/jmH2hkn7shOsMfIlBv/v2RftEx6FuCRYZg+9p96qbceRTUM9BD2RcIcq3w4w/kwA/Qlv4/CUz4/I3RU1PGI8q7BJVu9SmDijl+oXKoRda0dHXRiWmjAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB3956.namprd12.prod.outlook.com (2603:10b6:a03:1ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Wed, 24 Feb
 2021 08:02:50 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%3]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 08:02:50 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next 0/9] vdpa: Enable user to set mac address,
Thread-Topic: [PATCH linux-next 0/9] vdpa: Enable user to set mac address,
Thread-Index: AQHXCnT1qfLqkyZU4UqOdAUTBhk7UKpm3emAgAATokA=
Date: Wed, 24 Feb 2021 08:02:50 +0000
Message-ID: <BY5PR12MB4322600E5E6422CAF7A44F98DC9F9@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224015027-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210224015027-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.166.131.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0483ebd2-f27c-4511-56d7-08d8d89a94d3
x-ms-traffictypediagnostic: BY5PR12MB3956:
x-microsoft-antispam-prvs: <BY5PR12MB39564B8BAD11D14F679E7FE6DC9F9@BY5PR12MB3956.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WeRrdfHY8eyO40xjN2EfmZ1RMVGl2UwgqR1VP2MBRCxuMhpvn1yVeoCNxBNbcCIY8N6+AwhVPcHG7YFqjnNgLSc5m62UgAOcnZi+7FH7yZt08BNANDhoknTTw9k0ULYCz74BxKMq9/BebJfsHPjxpoFr7lWKvfC0Mj35f2ECqSw/yM3AxPWSuJhkjbV50qQcC2wfk9Y+/XswhkBP4N4qTskQH1Qs663v0nq4z3QWqIae9DbORHe2tHWUaadJ6LSMAVDsdDv7Q5JgJz5Ug2Rmczj7HEr7l5znzCjEAhUIWUiTvDhx5RezBetr4y2pgZXkVRHnOSm8CgFxTjFyB68c1WZIcX/QbjThb7hX663t6QWvZh/Tm/kkV1zPgkeTsKOVsDTyuRxN02vceuMO5jewStDNMZt3Gxwj42ebra5eEfeFokCWCAbj4YSg09nmGuFjx2BvoDXOKpP5oFAw9uz/MTRrHP/SOliQ+6VU33NpMi7FQTYzvK/ydWSQWGW0gBxjCjHJrTHJqwO07OSSw894kQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(83380400001)(478600001)(54906003)(316002)(66446008)(66476007)(7696005)(33656002)(64756008)(6506007)(52536014)(76116006)(66946007)(8936002)(6916009)(5660300002)(55016002)(4326008)(2906002)(71200400001)(26005)(9686003)(86362001)(186003)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?L+2Xiv5L/Pv8JlBA9RVTRO54CaVC2u5ZQ43IKSxgv2Pe3nn+LPaifpO4oOM2?=
 =?us-ascii?Q?raUxOPKpMCUL+fQMTZ3uPfsC62G3dgYKeOjER5QEzuvTTBFQul4wWUV/qRvk?=
 =?us-ascii?Q?259fE5T4aMQQd0SErlpSX+8gxtsrXyWc8lJHE09FMF13vsPPq+etMJSUqlaP?=
 =?us-ascii?Q?OopT35bzGiOiPp8A0XR0fDsE3UhlCkVO53XC6/MqbgepOOXKmYAEKJ789nWl?=
 =?us-ascii?Q?qbLM2luwI9PnUIrHeWxi7hKIZeBwprB2E6Rcatsszrz/rXTr5826v+hMfQSe?=
 =?us-ascii?Q?SSDusRHXnIdKxDul920e+gznz6ByvSvUd5atslLF04KX3On3ITEB/cR8CMMw?=
 =?us-ascii?Q?x0LGKFLBCXwWMM+jVkVvns1kPrsCuKcSY9GqFeQ3ONAh0laoqbJNCoXqCjct?=
 =?us-ascii?Q?NF1vwEqcCo2Xenam7Lydt+OM3iehQQ9yfnYn7B7gYkOwz6J86J7XuuVo2wWO?=
 =?us-ascii?Q?EziDXvcTLsE9tE5/pO2IcLnWaRxbEq43xmhcMpNX0BzSYC5ZRR7wrIOLdPjq?=
 =?us-ascii?Q?laUwjcR3KgzwpjWunjzlWS2rbZRiJKZbri79f6QvNKKwrOXkbxx37IUPwn8Q?=
 =?us-ascii?Q?VCVKqyMcCHf2PG4i/HpDCsNE9Rc4Cu/rO4THh7uHgd70JX4R5MtRRZXZh2A7?=
 =?us-ascii?Q?AbP1oQfFl7S0McoNTLV8gYTNjt3+eaofrz3TfIYCYphBkZ103HF2fSCdieUn?=
 =?us-ascii?Q?nXFge7xLIuPhjj1HQbAGVoFHij6APEb7OF1OXMurMbi5Ag7cKSTdKvzyXhAg?=
 =?us-ascii?Q?H7yyWveety88mGwHkqTw76Vi8wO9nWwQEQq5vv/AL6A3dcdmP0cLCLICt897?=
 =?us-ascii?Q?vImsV5jNJHqjbDIBmFajLRs0W2MJh4bbKgwBARR7Gc9Qt4iMvyl4iu/qLhR3?=
 =?us-ascii?Q?q6Eu9mlNkskED4/kvYwl8LxD6WBebnRoVoSHR8zj4cd9625eE8QaaGiwkCc+?=
 =?us-ascii?Q?a+7u00BVrGRIWA49jE1mAbWnMULtSntOkulKHdn2f1ziZ3h0WVmUZEH3Kpuk?=
 =?us-ascii?Q?2LfU1TxM7TWmfc84l0641yEh/vDy1uQdsPh/LR78XTkL1r9fcF/x9MPmOvTe?=
 =?us-ascii?Q?yu/PZlN8t3ycJjw5F5aR93Wa/dVIhfaHpwqL3or0/29/zBF9ohPECOxzqsa6?=
 =?us-ascii?Q?xfK/L9+1G4ZSqpmX6p/uosu/3QMSzhWaMxIbXX2YSpSNojaB0M4IW0xlmb+b?=
 =?us-ascii?Q?+JQZqc5tFRjFLq+0AmFOdwkg8qHLfcD3P7EYSf3/EjKUhWqDRqFu+/YNhLUZ?=
 =?us-ascii?Q?5ONPZDD60WoW6yqxK/cyTjqgP3yWkUvAMAfj2cw2UhEqjB2OqNgj4Mt1cuXC?=
 =?us-ascii?Q?5PFvBtWzZVXRGNjWmX6PWAnG?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0483ebd2-f27c-4511-56d7-08d8d89a94d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 08:02:50.5480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /iXjc5tzyyqMIpwsz0JMurCPaurfwP65+BxwhaNbIO/nzKOSZ+D/GiPwGX925H9PGCXIURUZBGLYQxsU3mK7wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3956
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614153772; bh=g5ZLNse6N0gNAbLOURbnNIIvOOCnItPH7UOmD/tsn+M=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:x-header:
 x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
 x-ms-exchange-transport-forked:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=UM+gKYkep3rqC7/T81KduoRof5ipFD7oJWpFHx0lA/h8iLkv74YP0lmuWBRWKLGTN
 2ZVo5KBMGWapN4o9VIWA2VivO5YzacgykV+7XXZoxe0dKTFMKLuXQfa8llUJG6G++2
 fIhDvU0f1UBzoh7RWibCC3Mk9d3O1p5sA43Jzrn+vRfWCxDIIq9I1ib9T6aIEvFvms
 XP7SsHK6cxoBZewRexXRFzQCXLmfJ96oyUfw0GhGyA344IqRmyXGlEUIQeLvEwWMVP
 u2Cc6fvuUFb7nmDWFKtUETLPPpW2QVZzP2L9/BQuh5xMhe2AT47MJb8CiDJE4lrss3
 VFmB1hQUvesvg==
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, February 24, 2021 12:21 PM
> 
> On Wed, Feb 24, 2021 at 08:18:35AM +0200, Parav Pandit wrote:
> > Currently user cannot set the mac address and mtu of the vdpa device.
> > This patchset enables users to set the mac address and mtu of the vdpa
[..]

> >
> > Patch summary:
> > Patch-1 uses read only features bit to detect endianness
> > Patch-2 implements new config layout query command
> > Patch-3 implements callback for setting vdpa net config fields
> > Patch-4 extends vdpa_sim_net driver to implement mac, mtu setting
> > Patch-5 removed redundant get_config callback
> > Patch-6 mlx5 vdpa driver migrates to user created vdpa device
> > Patch-7 mlx5 vdpa driver uses random mac address when not configured
> > Patch-8 mlx5 vdpa driver supports user provided mac config
> > Patch-9 mlx5 vdpa driver uses user provided mac during rx flow
> > steering
> 
> which tree is this for? does not seem to apply to linux-next branch of vhost ...

It is for linux-next branch of vhost. However I missed to rebase before sending.
My bad.
Preparing to send v2 after addressing other comments and after rebase.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
