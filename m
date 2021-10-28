Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2FEC433EF
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 09:48:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0800D60F9B
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 09:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0800D60F9B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B165040549;
	Thu, 28 Oct 2021 09:48:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CiLsG2WR0gsx; Thu, 28 Oct 2021 09:48:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 62256401EC;
	Thu, 28 Oct 2021 09:48:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34FB3C0019;
	Thu, 28 Oct 2021 09:48:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58965C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 09:48:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 45F7B4032C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 09:48:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gyfEKOkWaIvg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 09:48:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7D36401FC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 09:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/qOSx4AK3yfogbru04kmJBUtHEXvhcwQFm0werLg8Srnrue3VjTxnKU0ZmuM4RL50o29I31y4vfpmreIad6H2aB5JtZ7ycZF3Zol/2h+rNgbJ74gsKmYReB4o3F+q21X3HRJPhllvQiPRqUYJpnqzmwbyJruTfvqbwHQ0/BFUCOVdk43lcN+i4F2FFCjBoE3EgVaoBERt/S3vIhzvONVMIFpmQ9izqQPeQEgnwxXoXPLyhKBuF/Amns70F3N/0frBD58/RY94visTGUCS+4mIPZrzHqljr6O+nYK5yUTEhd7s9SnJ8hM6ad/kJEPCdynEwTuTxUZLdF+tJ4n95SIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSyhAlqv/5ad3gbIOuVa4V3t2yj8papoIJDRcNHQ2vQ=;
 b=nEk/48CWJ6AuJ8bgaIVPSsdPvMcdaFg6vpP2Lu5L9GSWsuW5oF3ZYFt1XBksl3cjs/qOTHOSxN3n8fzCnIllkG8it2mFa3SydJpXlLCReOYtOZjSe0DmpZXzchcaNSHw4P+g5Bp81kYRI6MTFvYfRnaStaAMT/655FeluJDTdq+PL8KgTiWMGmvnNjV6HA5OC8V6A4wXi7w9viTQNHeBkG6op1q9DWCyOpe75pPLFoanUKnvOH6kq8fD2bkE1tNdimnk0FNsgGLCm268Az2IjCVTWAFA1uIYVFhMITc1Axqb2dg12RvQ4ZR/hBjYD8OoPC/usZv9smyq4fmaG7EJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSyhAlqv/5ad3gbIOuVa4V3t2yj8papoIJDRcNHQ2vQ=;
 b=Kwec0gZ+IqY49h6S78ooMNB0BGmPXRmR91R+ZiwBi8ds/fzIVQE2g8W/0WESNJ/4iL6P8PCIFZ+rRPkYFPEGiOIhJ6k8a3VNP8R1WOHj6Z5Bw0nLY0KC907TbsJH5lwIZBpuaSCJqmqREgponO+BOtQ88d+c/9pnro9UiBJuRCziE+MG2aIgCN+Xe4cqtywS6AHg0mMh97WNB2xeHMVpoXm7FmTHYPX8kV4gWwCIaMgtu0Gtwf8Zj45dFMKSgfNp2mmj34mGrXgeznBJfWaP7tHtVg5Y/YXc96CeYmD5KjbTF3m7mJgM1OCtlUKUOvo4YadQ/s4+Ut5PjcdNp5U/Og==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5466.namprd12.prod.outlook.com (2603:10b6:510:d7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 09:48:13 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 09:48:13 +0000
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: RE: vDPA bus driver selection
Thread-Topic: vDPA bus driver selection
Thread-Index: AQHXyz+5W8bHEdMi9Ue0cOjhXwdA36vm745AgAAN1gCAAAHeEIABKSQAgAAA2yA=
Date: Thu, 28 Oct 2021 09:48:13 +0000
Message-ID: <PH0PR12MB54813F6CFDF8A1E1F7AE68B8DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <CAGxU2F7r7=P8E-f1Nnm2h18S-hL8YBt7s=J81fkQcrAdpZ-KwQ@mail.gmail.com>
 <PH0PR12MB548115FD6354339B41A11CE3DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211027154728.qkrtl6jtfoqlbwfu@steredhat>
 <PH0PR12MB548104D8BE92D2C5DC49A7A4DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211028093740.jv7gfqrgrmq7elje@steredhat>
In-Reply-To: <20211028093740.jv7gfqrgrmq7elje@steredhat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5133fc07-23ff-446b-ae96-08d999f80f45
x-ms-traffictypediagnostic: PH0PR12MB5466:
x-microsoft-antispam-prvs: <PH0PR12MB546681A644CA9E0B2EEEDC84DC869@PH0PR12MB5466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ibRCs6iYFO6TYRb9imoxzWT3Gd6fNGly1kgt0AXfFwdzhIEcI4Ruhf4f1wpBOBOuUdekciUhf8gVPP6X5IcRQLpRSt0u3wd/EnzDcprQKxHP4/JOuKRTobuDeELf1UfhK9xCJnnVQYgIr14/fzCOHsHX0UI9cTZDnM+qZ5zzAGP0XgyfO0SxReiRRNyAfj8PWhQuQ3xGTul1QN1Sp8vnS7FVX6mZduTEpM9jL7N2cZcqqub6FznRtkslQhRAwpYp3jbbMOU0Fa0bu4SiratXN1jaWm2Mdx7TgsszqZghkwME114xXkOEF6Rj9oEBrODeIikOizuPOk/TwrJOUFgJRetB6FlDfZgGNccyi/SbAvukIogtkzb6po3ZpEALgBqz+1EJAHBtSGpG0N8mWQQ89IF8xc3RLIFd6kbb6KjHJfYmWshLpurWbMU96fQHU6LVrf6vjfHwrPKCBzo/Yuu12BrOxzWEUjROBOO3Vl8bQm1VwfloO3wjzf4qTxQgwqFgy27MKiIjO0/D/+fXOJmQSMrxiowNl0vSzKni7+QyPNcsvuI1aQTDjTv0rr18QJyi3iPggUauHqO6b0ZIMaXYAPIbNeiyLhzjiVLheiB5iqNsj3E58zAKxj9wNGzVgOV0wHoJbqkgu3VXs0cMI6yJCSiQplwcPRzgUJoba93Tk28clxmIqSNMZp93RlkBBM3JgPjani3Zkw/pZJsSW9qlDA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(66446008)(66946007)(6916009)(2906002)(4326008)(508600001)(76116006)(33656002)(38100700002)(8936002)(316002)(66556008)(8676002)(26005)(5660300002)(71200400001)(6506007)(7696005)(3480700007)(64756008)(9686003)(122000001)(66476007)(86362001)(186003)(52536014)(107886003)(38070700005)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O5HFczXMAT0TVJfevrtIZ4l2SDMmwvBIEDaii3RcPrx/N3xb9SNFh//v1Qax?=
 =?us-ascii?Q?y0pKjek/lRgJJLfQ2nStxkJhAqckNT/ci4bJH+6Lf/qSuo4uIyFBKAT3Nvt/?=
 =?us-ascii?Q?4vPnOPufTJcw0xdC4QCeV+Yy1hH8BCQHo/Turma/dD5d24Uz0fpuJ0bB/1PS?=
 =?us-ascii?Q?m3p/+XffkWdCySTRMe5sizjKO00wUZP16RSufXGIkDYyHj7uIrAN/kPkJ3mx?=
 =?us-ascii?Q?rxJwW2+1/oIQF5ypl2bqPeoH8jpj9mN6RYc6OQKAc+GlpJ7HlWzz7nozRpWo?=
 =?us-ascii?Q?JVMzpCkhXOj4yI85PZDZwSAhGzJjQShEt9wBJc+3lOxuQfXaJZKu2HJLKA2q?=
 =?us-ascii?Q?p2gAyODs4hjY9w5Eq9rhnn30MEvP5L/mXS7m0GtENJZeHZj+fotNLTmxM9jP?=
 =?us-ascii?Q?mxP+jNLs11WbE5og7kbMdEsHSPNz/jAi+kLiuxogi2ol0m6xpw7Oc38J6MRb?=
 =?us-ascii?Q?apxndttEdjy2kakhmzNgld7MD+nzXIGH8zCNMb1diQUb5NRbSZOvH1e2T7EW?=
 =?us-ascii?Q?tjIlIRpxhBgtUL5jBhbwiYQsgr7zURLmUjyogczmsLrqSMAz/+UxuMDw2fvY?=
 =?us-ascii?Q?TQ79IpChaz/lDl1Y7kmM7YkcXVluI1Y/Uzt7N62tYApxsrLHvM/Bic8Ya43T?=
 =?us-ascii?Q?8qPlRl7y1KmLqtaBseGKOcZs8HLgtuyX9qW8FL4vdsq5qtdUOmPu9U8i9+y8?=
 =?us-ascii?Q?ERs7yPV5MREEofvqOUDNpmsPDZLnULDAfV0PVaeXdY1cuMLtzzmk8JSYkew0?=
 =?us-ascii?Q?1qPuJ9OeITQvCNi0WeTReUiDmsUoCqK4CgXnzwuK/ugZNnnmUIZ2KLl1jGq/?=
 =?us-ascii?Q?qbs0wHwo480k7beo+C37/sLBQjx2prHbjyiZeq/yGyEGJ73eW+Cto7op231S?=
 =?us-ascii?Q?NcEG36fylfQAkc1NFlYM0c+Z2IbE51l+YSd/F5S+if3LGDGnet8Qoml8AS9A?=
 =?us-ascii?Q?SR7+WGrl2Vjc1I/05IM9UlcDlsf3yb7JLqW/C3vx11lhzGzyD1muiue9lOhd?=
 =?us-ascii?Q?xwlR8dJHvCmisuo+XPjrVc0iWMn076kmbc0brDDuRvVRz0DkjhJ+jid5jyb5?=
 =?us-ascii?Q?zYLrjvHG4coPFaRrPVX8OA01jo/3nboXVHy1YVO2uIIzmGJWfvMEYatTaY2/?=
 =?us-ascii?Q?hCi1q6fUdvJ2jTUJvR0x+4QvvL/+YsUcHU/g3ZR4MfHjJaDd28OYHEq+5y3Q?=
 =?us-ascii?Q?ptPtGNV9z95AnLocYvP2VUVhcxVWeH90iImKEnN95xWrZoB9vadCCrsEfMsQ?=
 =?us-ascii?Q?W4HReTlfQmC7Tv5hKwsP2wGtmSCi0TTKGwW79DsQrY0AK+w9GcELlfC54uMn?=
 =?us-ascii?Q?D/6A38nfO/phFBMVr74ZZDclhFnEUk5EQPlS8IQgW7p29+C0xbVoz0Jl9W6C?=
 =?us-ascii?Q?BLR1vzMNY4/yatXGW0El4zEAwFltT8EADJjXDOCfuhCL0sI9jZL0MlvgcprJ?=
 =?us-ascii?Q?fQbSueENR6b+b2aF40zJJCi6+VSTqmWzgfUKnvFtb7bGpFFnxp233x8CuQWs?=
 =?us-ascii?Q?9E1C5FEpPOKS4uUosnyAQYai6uANYulwcYxxsWaaR9fLrQQdSeOQSEEXr83q?=
 =?us-ascii?Q?JxNJHvXZc6gTFfHF5JTssRZsuImBONuzRraHJqVx/YavXIMTvvmKErn1xrtw?=
 =?us-ascii?Q?edqmMDJDgGoun9toEaGUYNE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5133fc07-23ff-446b-ae96-08d999f80f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 09:48:13.5943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Djf40t+TgS0tGdwUHLFZHPDhLPOEvg/Eh04nfzBlaDHQeBXSFnZwOm3N9Nz4QxVH69CUsqzorGYVBSttYZ6P+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5466
Cc: Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <elic@nvidia.com>, Michael Tsirkin <mst@redhat.com>
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



> From: Stefano Garzarella <sgarzare@redhat.com>
> Sent: Thursday, October 28, 2021 3:08 PM

> >> >$ vdpa/vdpa dev add mgmtdev vdpasim_net name vdpa0 mac
> >> >00:11:22:33:44:55 $ echo 0 > /sys/bus/vdpa/drivers_autoprobe
> >> >
> >> >And after vdpa device creation, it manually binds to the desired
> >> >driver such as,
> >> >
> >> >$ echo vdpa0 > /sys/bus/vdpa/drivers/virtio_vdpa/bind
> >> >Or
> >> >$ echo vdpa0 > /sys/bus/vdpa/drivers/vhost_vdpa/bind
> >>
> >> Cool, I didn't know that. This is very useful, but do you think it
> >> might be better to integrate it with the netlink API and specify at
> >> creation which bus driver to use?
> >I think it is useful; for vduse case we need the ability to say "none"
> >as well and when nothing specified it should be default driver.
> 
> Yep, the default can be the actual behaviour.
> 
> >
> >More than netlink, I think we need the ability in the core kernel to
> >make this choice.
> 
> Okay, but I think we can include that in the vdpa tool.
If functionality and interface exists in other part of the it is hard to wrap that in vdpa tool that does the duplicate work.

> 
> >I haven't explored what is already available to make that happen.
> 
> Me too, I only saw the .match() callback of "struct bus_type" that could be used
> for this purpose.
> 
> >If/once its available, I am sure it has more users than just vdpa.
> 
> Make sense. I'll spend some time next week.

Ok. yeah, may be a desired driver can be stored in the vdpa_device that match() routine can use.
And if that driver is not available,  it returns EPROBE_DEFER; so whenever such driver is loaded it can be bind.

But I think before wrapping something in vdpa, need to find a reason why the current interface doesn't solve the problem and also to figure out plumbing.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
