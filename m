Return-Path: <SRS0=5FLU=GI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B47EC43331
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 12:30:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47C122AAC
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 12:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47C122AAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 263A921515;
	Tue,  5 Jan 2021 12:30:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id apowVOoCKLJp; Tue,  5 Jan 2021 12:30:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C492F2150A;
	Tue,  5 Jan 2021 12:30:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABCE1C088B;
	Tue,  5 Jan 2021 12:30:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BD7BC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 12:30:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8940685F9B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 12:30:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HFpQ5IiTersw
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 12:30:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 99DC28688B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 12:30:18 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5ff45bda0002>; Tue, 05 Jan 2021 04:30:18 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Jan
 2021 12:30:17 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 5 Jan 2021 12:30:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amx1SjRk8e2dcSl0NSkvEKsOp+ZsiEb6/5QuxnM6NjxKAGP4T4VJpX6xc07BUDa1ATUoFJhOgXzcilijGiukiz4KaNX2uRH3PSEyskFnYcYYhW5eyIx5d54oN7kfwJ2K+Hov1QhH4kxtX+tkRRkZIjBu6H0BOH1q3Ju9Xt8bBIPUB5VYR/NHMlgmnJ7CfldAtJhvzOddzn5seQAOjSMgPHq179aW287DRrrSHizsKdhUszgxkYVGUT1iWHbMrkfJw2/xrGqs5vOX8nq37zX6Fg68nlqxeFY/pu4zfZxVbpKMr2AvoY43edVbb0OzlMKisojrajd09KtX+ljqSITZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9B3G3dD4Z3v8FoagbCby5yjHJ+qSdPJSaPnL6SDaZbE=;
 b=TUDMxaR6E87f09VI1OqH1Jd7f+Ps/5GBVv3nCWCCgSWuicl/DooJ1fb+Zoxlhr7Mq/WXJ5+Iw1dUxCX+Bq9STxnTcN1uCvhMRSouSVK4sO4LXXzLb9qR/iFELg/IXP8oPxQiBzHXF9U9lwQfssaoKowq3mKE/Vm3e9PVeD9LMLyNqDrEH2JFsz85ovtW9nKwEySXize3uW8mdRHHagvIqDtpYqhAI+SN06PEQXEcGUmpSWniBFktYGUXm3SUDcxFn/m4/KG5xz79pE+Wf24CN5olpSoguLFREZs+EMW5PT5dGBirOMAwpmxu5OQ6jDczWPGf/fuRhM/YieWsUIg7mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Tue, 5 Jan
 2021 12:30:16 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%5]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 12:30:15 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next v3 6/6] vdpa_sim_net: Add support for user
 supported devices
Thread-Topic: [PATCH linux-next v3 6/6] vdpa_sim_net: Add support for user
 supported devices
Thread-Index: AQHW404ZeuD1Nrf6EkKQQnhYNrY/9qoY6uQAgAAB4oCAAAVhgIAAAsjw
Date: Tue, 5 Jan 2021 12:30:15 +0000
Message-ID: <BY5PR12MB432235169D805760EC0CF7CEDCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20210105103203.82508-1-parav@nvidia.com>
 <20210105103203.82508-7-parav@nvidia.com>
 <20210105064707-mutt-send-email-mst@kernel.org>
 <BY5PR12MB4322E5E7CA71CB2EE0577706DCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210105071101-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210105071101-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [49.207.222.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3a8e79c-4e13-4e08-8248-08d8b175a7e4
x-ms-traffictypediagnostic: BY5PR12MB4114:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4114D521A4F837D381337D1ADCD10@BY5PR12MB4114.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SbVxw4Hk+i/2jogez0CPh1G3rH1P30roiJETN46nJvFfnw8l87E99gBUJb2ce5ftd3m81EMUSWpK7yYFvytxzh0NMUiheo7uSfUB7hztJngviJuxLRyZjVwBXeRSdyhsSU3RaufWGnkTHxJBOdNoQfLUeMde9G2mOzhUhAsdVAJdzNqhbe0DoRh5lQDzGReV2PBrQvC8PPFKAh7nm1VgDOYg2uxPFwxYJyCARudxJsXYlDlukqPVeJkKj0ynkMu11JFtvp7BLr96RpekM+mB/uUnN6oaMpXsVoTKVCbTooOkv5R3hsV4I36UASWKQE6xRXari1yeM/PlpGkaiMUV7KOAwkQx8HdDS06a4JfcI5UEW+S+BPVxbx3djd9/REB19k+kpaFKC/d1OUYn5bqpkQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(64756008)(55016002)(2906002)(66476007)(76116006)(9686003)(186003)(5660300002)(52536014)(478600001)(8936002)(7696005)(316002)(54906003)(66556008)(66946007)(66446008)(8676002)(6916009)(26005)(4326008)(71200400001)(86362001)(55236004)(33656002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wGlEmJXdJv4D+ael4XYjTLq5lDVUx8Xug8vW4CpJdKuPMaqc4xtELVZhBZwm?=
 =?us-ascii?Q?YgZ63oeJtvCa1xY0oHyUK+ZpRSM055w7mxEwXuaMnbCNexR0vnl+irloZDuN?=
 =?us-ascii?Q?QS59VG56ioTfPFLzfo8J4U0lkzMdTdrWXsdKvhAX0/w/dNIz8MGTRhci5vyo?=
 =?us-ascii?Q?y5bzHySplyEDYRYa4qj4zhIvioGCG4PZBg5mBE+vHzAFuU3jbJAd5DCru1Xh?=
 =?us-ascii?Q?U0encOaKPuhBEVNzkv9+BFLp3Z9sPjStXn6sxR2vEHvB9nnetsJqudvR5M01?=
 =?us-ascii?Q?eXgE3Gv+ZsA3R6R70JMoFOSUOXJcWzpllFFA+owAnEBeKGNenMDVx4Bd/BIH?=
 =?us-ascii?Q?oKPRzqTFa5gM8JguSZOFM2g1fexlM6DnVgoxbvFrDDM9taqhHIQc74YffP3I?=
 =?us-ascii?Q?uz1DD2/ttLEWGSZqZ8o1ylwNZ6uvz6picKN0MhDmx/+heudQppTg0mXrJxCG?=
 =?us-ascii?Q?zzyfYEAe2vbr2jeXdllusJkar4vLRv+pwUZli3SmBppenamY95CGxbH2ZcOa?=
 =?us-ascii?Q?aom00z7nKcvJbYYNR8bG5uEBKbk8OsD4+/CZ0pRQZGDETRPQ9/PGVQ2j0KqV?=
 =?us-ascii?Q?ZI6QX1gcN6t8sibFjTjgWyZ0AI88MrYKgLs2f3vYiXcuNxXhTMVBo/mZop5N?=
 =?us-ascii?Q?DTPunQTcJIPigeTKE4bilIQcBP8kQqu4RHSo0N8nnFHdp4PRARko5SG5dcQ7?=
 =?us-ascii?Q?710pF8sJQ6yJEowEB6SRNBWMcekPhzd6moz1iTPG5lRKkDJYVDAJZbqfG97e?=
 =?us-ascii?Q?mZUw19sv7xD3a1lRnkK3505Nvom1N5Dge533zo+d66Oe00t8GJd3dEQ/+VET?=
 =?us-ascii?Q?bkDxhgG1ULCkwdywMnWkOPUHl/rGQKv58a6tULUnuAJe6KHsLzWsl+eoA80M?=
 =?us-ascii?Q?tNno/eKrQ0LdFN3qxkJqTKBKOLn7/JMrv8G6K5ltFqtKsfl3qTa0O/g8xf3b?=
 =?us-ascii?Q?GrXpnKzfOefuIWukOOBhycVDUfNWbmg7ztWln+aNQK0=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a8e79c-4e13-4e08-8248-08d8b175a7e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 12:30:15.8159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iowRISQR9KIIj1ZKHNG0rfFAVnwlEUyzeQW30XBtMtPhxjfQXcQjcrckeNXYT6scUbuSCTAFLjM+IjixMUkgQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1609849818; bh=9B3G3dD4Z3v8FoagbCby5yjHJ+qSdPJSaPnL6SDaZbE=;
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
 b=Qbi88/eaNWoUG/VXnv/pHN5UZq+hg42WOL0YaV96hcZHg9MsRedb2s472M129NQjs
 hkRCf5QJUaOG7a7MvzTGssFV0aP70siWCmhXRtqj8ok3G1jysN90ncTfZ2N4RcM6Lk
 qncdgG2AaBj33rz3uBI7ILdMK1TkU6aN/P9XxEle3IgSIpXm9KEU5smw6k0UYGOqwy
 YJiGDrZI+4VzI40XzRmTpFOELOXoD9rr+V3lmqCQQ15CAV/OQF2FBTfBMywXrXkPvZ
 VGA65J0R5cUiwvRxRb1fKQHyZQDILDZKIv5Yk2DO4E7qj+yjig3eKgIGis1d0Ocwss
 wCMGPw7C2ZxtQ==
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



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, January 5, 2021 5:45 PM
> 
> On Tue, Jan 05, 2021 at 12:02:33PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, January 5, 2021 5:19 PM
> > >
> > > On Tue, Jan 05, 2021 at 12:32:03PM +0200, Parav Pandit wrote:
> > > > Enable user to create vdpasim net simulate devices.
> > > >
> > > >
> >
> > > > $ vdpa dev add mgmtdev vdpasim_net name foo2
> > > >
> > > > Show the newly created vdpa device by its name:
> > > > $ vdpa dev show foo2
> > > > foo2: type network mgmtdev vdpasim_net vendor_id 0 max_vqs 2
> > > > max_vq_size 256
> > > >
> > > > $ vdpa dev show foo2 -jp
> > > > {
> > > >     "dev": {
> > > >         "foo2": {
> > > >             "type": "network",
> > > >             "mgmtdev": "vdpasim_net",
> > > >             "vendor_id": 0,
> > > >             "max_vqs": 2,
> > > >             "max_vq_size": 256
> > > >         }
> > > >     }
> > > > }
> > >
> > >
> > > I'd like an example of how do device specific (e.g. net specific)
> > > interfaces tie in to this.
> > Not sure I follow your question.
> > Do you mean how to set mac address or mtu of this vdpa device of type
> net?
> > If so, dev add command will be extended shortly in subsequent series to
> set this net specific attributes.
> > (I did mention in the next steps in cover letter).
> >
> > > > +static int __init vdpasim_net_init(void) {
> > > > +	int ret;
> > > > +
> > > > +	if (macaddr) {
> > > > +		mac_pton(macaddr, macaddr_buf);
> > > > +		if (!is_valid_ether_addr(macaddr_buf))
> > > > +			return -EADDRNOTAVAIL;
> > > > +	} else {
> > > > +		eth_random_addr(macaddr_buf);
> > > >  	}
> > >
> > > Hmm so all devices start out with the same MAC until changed? And
> > > how is the change effected?
> > Post this patchset and post we have iproute2 vdpa in the tree, will add the
> mac address as the input attribute during "vdpa dev add" command.
> > So that each different vdpa device can have user specified (different) mac
> address.
> 
> For now maybe just avoid VIRTIO_NET_F_MAC then for new devices then?

That would require book keeping existing net vdpa_sim devices created to avoid setting VIRTIO_NET_F_MAC.
Such book keeping code will be short lived anyway.
Not sure if its worth it.
Until now only one device was created. So not sure two vdpa devices with same mac address will be a real issue.

When we add mac address attribute in add command, at that point also remove the module parameter macaddr.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
