Return-Path: <SRS0=B6Di=JF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87106C433ED
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 03:45:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2867B610C7
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 03:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2867B610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2F8D84D24;
	Thu,  8 Apr 2021 03:45:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tTkcsAV-fqIf; Thu,  8 Apr 2021 03:45:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89F9284D21;
	Thu,  8 Apr 2021 03:45:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49065C000C;
	Thu,  8 Apr 2021 03:45:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEEFBC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 03:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D0A8E40541
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 03:45:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9fjzSdPo0pTm
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 03:45:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760083.outbound.protection.outlook.com [40.107.76.83])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2BF5640536
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 03:45:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpYG9CrBfNJaQuRrccX7EKHQvbhHqpD5mwypSgDkywOkf33ZXR3sHyg237EIJnmbiNIReqhSXtCmQxIl8WJjMbISciwQzPPHx45KdgIGOR9qBZsaodaBRhq/4+qhxroF3dxilfNfCQp0jF4LCTF0r8cfBVWXHQbbxsy7KIJ0fpCisbReDhwKvf7BmPvmPfEoO30d2E7iP7ponGBmulUh0jMFg8wIvxEfytTyg2i6cpy5tv8ydkKIU6lCeQ/4N7Hfpb66jjqVExujBPtQcLH5Ks7NbjrH8QoAMsGi8VtYo4F4WQMEhWnHvYxFIm0o1WzuKuTnYBIqGTRKxl+3XgiKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDq1vhN4GLapNdcSkxpzr0sl1I6c5V4UPmAasyPnVE4=;
 b=Ud8FIuAqydM0atxiZ8kr3jUWJGoCPtFNDgGxQlRUtVPE69iq3eUQGijJGc01oOXxFok1H959pja1ySTPmIhHXxUyvGKYC7Xgo6gHuU+0TcSL+fpg+leK6/0O36fWsH36AhH9FIcJQ//pVMtJbvH1xeusj2nHhk9RlLZTz22nhMyWvgAiIA3EQyIa5Lrv2GT8tYZPHanM5FHMdxSC5qiQiY36wCq5HCWwa6lpRsb5/q07uHvwibr7FWlJUuqvgvBTDadesnULFdzYEserCGrKkiQnen/myNQ/act1v1eAO3UtZyuS6e8/gBCM1bhxwM+T3csf7QPdGWqwxiSy2OpSwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDq1vhN4GLapNdcSkxpzr0sl1I6c5V4UPmAasyPnVE4=;
 b=kGuJIB/MvEK65IslVCSneL9dMutxhu4Xn81aUhyv404ZhZe1kYAzZoAm9HH0lfpAa6sQQBZBBGmte1Trm1ytO2Pfvpg2UNo7hNWxtzKRRCDcq8bW/4sgGvZl4xhEshuSFUOW4E1Ipfz2iOMKuXy24iOg+6sDxDBgv6kcsTblrqJ0/WGah79c4+DG3k88LiP7eqCASnyoTb/98A1A00j1boEcl1mBya3ikdJU/cV0wj7XdRtK8lRmwj0HbFU4qSVKYGo6g8GLIGrGly9UCRfTlLi6la+OkbYsO5n9UkgHsKOQP6MXUeaNuIIm6ROHXjeogSy+r1sB4/7X5FjdrpHcwA==
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 8 Apr
 2021 03:45:49 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::7cec:a7fa:db2e:3073]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::7cec:a7fa:db2e:3073%9]) with mapi id 15.20.3999.034; Thu, 8 Apr 2021
 03:45:49 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v2 00/14] vdpa: Enable user to set mac address, 
 mtu
Thread-Topic: [PATCH linux-next v2 00/14] vdpa: Enable user to set mac
 address, mtu
Thread-Index: AQHXKwcJe1aBJsclM0qH864cE138x6qoqSqAgAFSx+A=
Date: Thu, 8 Apr 2021 03:45:49 +0000
Message-ID: <BY5PR12MB43228BD3EABEC2D90AD1EF9FDC749@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210406170457.98481-1-parav@nvidia.com>
 <438c74dc-6cdf-0278-8dcd-27a75f07dbc3@redhat.com>
In-Reply-To: <438c74dc-6cdf-0278-8dcd-27a75f07dbc3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [136.185.184.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f693f57-88ba-4d90-5543-08d8fa40ccd9
x-ms-traffictypediagnostic: BY5PR12MB4114:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB41147B4DCCC7CCE64C8125FFDC749@BY5PR12MB4114.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AVzq4s0TlkED8oVkZg5dBI3/15RYKIVGSXFxxiM/axYan+qcLkVMIJoLIk3XdxUIT6eZJWp7MTaP5fICZ9CKk2g92iY+yFkB72p5QdynZTrJgLgwzNyUwZYYoqnpgo5LG5hZKz0uY46QhyG1XHEguxgHHFGUH65l3xAvgumILtSbMHx/9jVKPxaUj83AwGULv5KGRu7feQPxXSyO+WISIy5/UmlhePE+pJfmkOxrKiRHN2f64NeOz+hjRI7Gq21i2QWg/nGtY75KYpLSmbKNuOcJB6oI4ur2mh9b0a2+h0NGdkvXMTT9rY0Od4DhsfXi59pTIByTawonoWGh7IrdOtXGm744xls3fW9o0z5UUA7Iilbpxawn7YT2XvM2v5vYrQQwiDW3aHP9N/k5e+QcPF0Z6RW68oM3q1+irZe7hRPLT+olJ1jdoevPkpZCEKGmCe9c3Y0+Tdu5dow3O6Y+Hixgs67qG4XdD02ApUJY4CCyCejhphueSV3BxtT2QCsJXgsiFQQY4QdE9nTQ3UJksXgGKFZsIBaYCzjt/6/YXY17bjVBjJEU8Oeo6YddzXqp2uLeEGSQo/xrcaOAjSMNCsU+NlYBgkb6i4SfU7ERB4NCSAlwAHb4rXdhKcl0/3Nc9rfEr32aQbYpaHyTRToYUwjl4G3PtVEU46peNXPtvkwuVyYY/VK4WcLAngLBygi23tBp6zFRVKcNppwOPZWxYJwHyesAmOLkJl06YchAV9ZgPpRvTwtxhx3tPAIP6ab1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(4326008)(54906003)(107886003)(110136005)(83380400001)(316002)(71200400001)(966005)(8676002)(66446008)(33656002)(9686003)(38100700001)(52536014)(66946007)(64756008)(76116006)(8936002)(5660300002)(186003)(6506007)(7696005)(26005)(66476007)(55016002)(478600001)(2906002)(66556008)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0kjnWDYBo/EAZoXvlzw6ip0EtTmgWE1RNaIFsMSUuKITmfyt4as/lAmWK7iZ?=
 =?us-ascii?Q?ubGeYcVlDZ4icMGnRN8Hv+VoGwBwqchbz7LXxm2kedftx+VLvZlafJ47nyOH?=
 =?us-ascii?Q?9rp7EwHDssjjYGZEqx6DQQlNYgOLwO1E8o1q4lYUshexNDF8gWWSKOr80EKz?=
 =?us-ascii?Q?Ae8rKtDYekKnskV5fkA3bZkPGNDO2VcOudDB6Nl2mfiOK9X07Qlf9UihI++N?=
 =?us-ascii?Q?3bR82tMon4jMRrkBUfvlSAFq6BE3+WVHFIDxqNZyY2yNRV3dId1ImQGJdDHp?=
 =?us-ascii?Q?N31Hidd8gvPVidSQjiRqL/fJT/uXHHwUGB2p9qsIwJ29if+RCu1pYqsdhSXV?=
 =?us-ascii?Q?0u1D1idFPn9YRyC9EvWaO33gyzAql1pzqNMTtdZSQdc7Er08V29tzrvq21mK?=
 =?us-ascii?Q?o5ZIw5ykGNTjzOQ9p7N/poBXpdKY2ukOJnh0asP4zrzZCCuW+rj0ewOBgrJf?=
 =?us-ascii?Q?ObywRcqUC/8rNKZ6Lt5b/Ts7Rgnqy7J4HZUN4fFE9IVIR+5ZAyaIsuHYtIns?=
 =?us-ascii?Q?sz/ykbe0RwqZ/96okA4eYoJznmtNZ43luXYo6NRsp0MeIOaKbn16YP6aqqzn?=
 =?us-ascii?Q?mpb/RrWJiihYQVQx3jc9Y6hMm8kIrQUQ3cNU6YG7Yr8oPB2XbzKTs6wM5MbF?=
 =?us-ascii?Q?DbBLXsk8JrweItnFhhVHbXNkovVO7PHWINt5YFLSjwH/9QuEDXLPFzRlKdKK?=
 =?us-ascii?Q?VnRwfUIPqhty6Yg49MBvTu9DXy7FQH1hB0C2ITALsnyyj2oLXJ0EiZxSoAW2?=
 =?us-ascii?Q?gXpqDkOltX3i58SfyQI1SL2Uygz1xqatE3Ls3Rwwz+Kb05TcDzu0jubFKeBt?=
 =?us-ascii?Q?gvJZ006rYN96klqBIARyS5Rw6JsndXCV5tngNFeKBwHqwfINqsVTqv7Fwaq+?=
 =?us-ascii?Q?54wLGcIZcdamrfjeDm5bT2WCAP5atlhZbrvAzAIJALZd7gC7bJ2uKzjJMelU?=
 =?us-ascii?Q?nYTlx09VI4iQykuvbHlSTUA3kfxPzx5hyjZ+Id2Cdga03mP8IBG9tE9bAtcQ?=
 =?us-ascii?Q?/ssWcOatqCNayIFFvAu/Twm0Rmt5EyySr4uAL0MY2EI6dlTUJuZTEgSs65us?=
 =?us-ascii?Q?eE9Wmcd52ejgpHE/r23/dePJFrHs+2+Tl1ClZ6ulXLOUqEWk4skplX+kjE4W?=
 =?us-ascii?Q?iK0ZnFSINIDe3paotksseB8G1kcdR49ybmdsk04lwwi3LKmEEJMKXHeIdoHe?=
 =?us-ascii?Q?92N7BPqN+SovR0ps8PW4W+FaUnEiPa7AXr87HIKOsEZf94ShAFPmDN7nvhRV?=
 =?us-ascii?Q?BF6dqKLySEAnEotYekJLUnVlphD1M7cH7CKvAbSSfJMSbCiWXb16xiGj4iod?=
 =?us-ascii?Q?f1iHIH5gc2vHHYJbc7ElyEE8?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f693f57-88ba-4d90-5543-08d8fa40ccd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 03:45:49.2629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcclZtECEspud65v42/5aLY41rFRkwdr3zfNeWnlTG8K5LsCIINoJUzLRA3L1XP34jY94/agdn2RF+F33NFFrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi  Jason,

> From: Jason Wang <jasowang@redhat.com>
> Sent: Wednesday, April 7, 2021 12:59 PM

> >
> > Patch summary:
> > Patch-1 fix kdoc style comments
> > Patch-2 fix kdoc style comments
> > Patch-3 introduced and use helpers for get/set config and features
> > Patch-4 implement query device config layout
> > Patch-5 enanble user to set mac and mtu in config space
> > Patch-6 vdpa_sim_net implements get and set of config layout
> > Patch-7 mlx5 vdpa driver use right dma device for PCI PF,VF,SF
> > Patch-8 mlx5 vdpa driver uses right BAR offset for SF
> > Patch-9 mlx5 vdpa driver migrates to user created vdpa device
> > Patch-10 mlx5 vdpa driver supports user provided mac config
> > Patch-11 mlx5 vdpa driver uses user provided mac during rx flow
> > steering
> > Patch-12 mlx5 vdpa driver excludes header length and fcs
> > Patch-13 mlx5 vdpa driver fixes index restoration during suspend
> > resume
> > Patch-14 mlx5 vdpa driver fixes bit usage
> 
> 
> Hi Parav:
> 
> I think some of the codes should be sent independently: patch 7-8,
> patch13-14 are needed for -stable.
>
Patch 7-8 are specific to subfunctions. However linux-next branch of tree [1] doesn't contain the SF patches present in [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/log/?h=linux-next
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/?h=v5.12-rc6

How to send them through vhost tree with fixes tag?

For 13-14, yes will send them as pre-patch to this series.
I think patch-12 also fall in same category.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
