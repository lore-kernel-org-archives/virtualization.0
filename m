Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F60DC433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 19:02:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0257F22D01
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 19:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="jrMhH7Gz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0257F22D01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id ACE5C87899;
	Wed,  5 Aug 2020 19:02:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t4If3IyBnTE3; Wed,  5 Aug 2020 19:02:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DF3D5878AE;
	Wed,  5 Aug 2020 19:02:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1214C0050;
	Wed,  5 Aug 2020 19:02:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 038D4C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 19:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F27AD88360
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 19:02:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wBPZoNy6Rw0D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 19:02:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20044.outbound.protection.outlook.com [40.107.2.44])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 571BD8835A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 19:02:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0q+rNnVGpn4TN+tiLTcVrRyx+IqtgR797tEDYTYLUxZwzjq1VoYA5JaINJ4DaBGk20jM5OwCQGvU6J1SWOAPgWJldqNd9k3Z8Na1nqd2DsqJJ85ED6fmjrFM/iCCSU1rPBhY/8qdp8UEOMD9Zjdvl7357enbgIyuUxAKIzukbxCqwpiBw4r6NB9MsIYabHDH2f42DNuNUaVYf31ebUq6LuOkJorVBlK+mZwpM8dJ5l5NMcurPFDQcGlTH1Bqgk3z4Lw4iR0ttcAlyjf4LZjBCBbhO8hxKOZNkmIbcmhAxcXGJ+16+2H10c8cjJjFrJ0+YMqT9jhqmCy8hZs6om0ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ0UuXA0B/P3jZ0oEItR0+FoOacBoKCh8V4DxqtmpTM=;
 b=g7hzQ1noBgXeDv8Hh+rJl4dWs54/JbqC2cILgJF+vxpP6VlfNUPD7rcWT0IJh2XsKs6hjnybXspLH8xrrZ1Sj4IBj0pGuHRaZF7tou2mQH9YvLwR6UJ8++3h7+bTCxv84+j2+wBF5fgPsUvrWf79YSutGTb/l9cTfKqtMOtD8PxYy0+jGsT8aWvSxifQ6eim7zucB1itgutKKHWgR5DHicRdQgNBPLIC/GAaWLFgsW7JF60ESFSh0iIvKqHEqPUklb86R5W+rPkS8JD5/lo+P8tQKwXfadhVRKXYcauTh8s3kzAiLTuXqZ3XYF0QtQMJUXzszVCZkRzZOT48goiHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ0UuXA0B/P3jZ0oEItR0+FoOacBoKCh8V4DxqtmpTM=;
 b=jrMhH7GzJScEzXR7QM9w/wx+z0ZJ6wsz0wb5WsqCAJ9NSljtUMTHW3b/oN2hB/iCPYXajzo7GM88so6y5uKTUgPQowvYcy5JpVrkvYrOw1AH84H7JHuUUvBY3apbbTHXww1rmBFP1w+XYbTR1EA71AMfrfmztFe+VicfDp9kVzo=
Received: from VI1PR05MB5102.eurprd05.prod.outlook.com (2603:10a6:803:5e::23)
 by VI1PR05MB6591.eurprd05.prod.outlook.com (2603:10a6:803:102::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Wed, 5 Aug
 2020 19:01:53 +0000
Received: from VI1PR05MB5102.eurprd05.prod.outlook.com
 ([fe80::2dde:902e:3a19:4366]) by VI1PR05MB5102.eurprd05.prod.outlook.com
 ([fe80::2dde:902e:3a19:4366%5]) with mapi id 15.20.3239.021; Wed, 5 Aug 2020
 19:01:53 +0000
From: Saeed Mahameed <saeedm@mellanox.com>
To: Eli Cohen <eli@mellanox.com>, Jason Gunthorpe <jgg@mellanox.com>,
 "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
Thread-Topic: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
Thread-Index: AQHWantUSBzq7a8TBEiYyqdYt1Lu16kpay6AgAALLACAAAI6AIAAA6kAgAADEwCAAGF3gA==
Date: Wed, 5 Aug 2020 19:01:52 +0000
Message-ID: <063f66418da235ee459b367c5049948ee6db59ce.camel@mellanox.com>
References: <20200804162048.22587-1-eli@mellanox.com>
 <20200805075856-mutt-send-email-mst@kernel.org>
 <20200805124054.GA125576@mtl-vdi-166.wap.labs.mlnx>
 <20200805084604-mutt-send-email-mst@kernel.org>
 <20200805130158.GA126406@mtl-vdi-166.wap.labs.mlnx>
 <20200805090304-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200805090304-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4 (3.36.4-1.fc32) 
authentication-results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
x-originating-ip: [73.15.39.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16e148a5-ea84-4e8e-0ccb-08d839720427
x-ms-traffictypediagnostic: VI1PR05MB6591:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6591BDF2ACB4C00C7E790B06BE4B0@VI1PR05MB6591.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FuuKhSwQCfM+HxFXK1uzvM3UIh/fOoZjxOXSvK4UcYULlQXRo1yFUSEORb5FSGrZt/edEuogPKqbhQPqtL8Nrusv6+hFYQ2XA5yCurP8MJaBPJd3NGP/Pkg0KB5O1TQkSRVx7RpC25LW3rgW2mTKaZS5u44M2rxhF27PjxzG7ZhdWNCJEBSEj9MFzLd3z6xWeRa+UGRmOAhdomK+/Zv9m2dG1o/pCX0UlPITjp8ILB+f+AX/h28DhJJJY2FeANHW2pItCW1+hHtm9nE4r1KopYsTg3CYehDnRCfHU0Uceh4fNP0BsUxDvWqzbOuUgxIaXL1+KIHx8qiBslCLTHXZqQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR05MB5102.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(478600001)(64756008)(66476007)(91956017)(6506007)(66446008)(5660300002)(8936002)(4326008)(76116006)(66946007)(66556008)(26005)(71200400001)(186003)(6486002)(8676002)(6512007)(36756003)(83380400001)(2906002)(2616005)(107886003)(110136005)(54906003)(86362001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: fxHluJ0U8KLREBEwZfrzzrYnAUE26jA5r+0yECv0guvTRdbeK0VD0PChAJXHIi9PThJ2XadFOq4byrhxRC8zi+T0xFsNZkgqQxcc4QXldfESiYYFqNZ0z/kW+dmDmWl9RKyx+Ye3IqV1bYXsMs28Lpgqp1iCcYR8tnPA3iPqoiVK7hxiVSJ40+wGKIZ4KjJe3RHxzBiH4cdJuTDLxrqqQJDuz2viy4fx7DLHfWOE0NmbzeFV6fMc/cvHwkRjnNhZKfNxyqgcwQPOem/jkgTTBDHUGELoVyL7COx8vXzhyFReTCWp4GCXR0PQI14pRgAfLqQx1TO4LLQrEhKdex/HNrPgoGQwm49VnPLpQdbmlfx6NBnuaX53ELF0QAjh4Fpdc/v8gO6Q7PBIAAy0RTL9VyG2WUIEdjS3v9Mz1PVTfv81DYh8qmQlyHs2eGxX0z93fJbYkUBjMWQms+JbHL5GLW/psCB6OQdX3jQF4dVZfUAH3slz765luNZLnZF5C6N2ZNfobRx8lxMpBA5z9ZBl2IqUqWz9fWFyXkNsBSCjUaKYkPidw6+Y7mouFmHu4pJpt2QlLfs5XH6wg8HvKsPKw4MMuYJj2Y/H0uqYyRqvothCHmIubj5WiQREhGIt1fM9mLSBmkvT+Hr2zuraTKR0nQ==
Content-ID: <B7847450D4DD7E47AA98320776D669ED@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB5102.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e148a5-ea84-4e8e-0ccb-08d839720427
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 19:01:53.0488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPOuybNTsM+rV1urIpyoYHy9P6xRWUMB3D+AmM3+Qj+5hzfCtQk/W6olb1sGYprxQlnUoS51q5dJ4YW3+fqt9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6591
Cc: Shahaf Shuler <shahafs@mellanox.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Parav Pandit <parav@mellanox.com>,
 "virtualization@lists.linux-foundation.org"
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

On Wed, 2020-08-05 at 09:12 -0400, Michael S. Tsirkin wrote:
> On Wed, Aug 05, 2020 at 04:01:58PM +0300, Eli Cohen wrote:
> > On Wed, Aug 05, 2020 at 08:48:52AM -0400, Michael S. Tsirkin wrote:
> > > > Did you merge this?:
> > > > git pull
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.gi
> > > > t mlx5-next
> > > 
> > > I can only merge this tree if no one else will. Linus does not
> > > like
> > > getting same patches through two trees.
> > > 
> > > Is this the case? Is mlx5-next going to be merged through
> > > my tree in this cycle?
> > > 
> > 
> > Saeed Mahameed from Mellanox (located in California) usuaally sends
> > out
> > net patches. So he's supposed to send that to Dave Miller.
> > 
> > I think Saeed should answer this. Let's wait a few more hours till
> > he
> > wakes up.
> 
> Alternatives:
> - merge vdpa through Saeed's tree. I can ack that, we'll need to
>   resolve any conflicts by merging the two trees and show the
>   result to Linus so he can resolve the merge in the same way.
> - extract just the necessary patches that are needed for vdpa and
>   merge through my tree.
> - if Saeed sends his pull today, it's likely it will be merged
>   early next week. Then I can rebase and send a pull with your
> patches
>   on top. A bit risky.
> - do some tricks with build. E.g. disable build of your code,
>   and enable in Saeed's tree when everything is merged together.
>   Can be somewhat hard.
> 

Hi Michael,

We do this all the time with net-next and rdma,
mlx5-next is a very small branch based on a very early rc that includes
mlx5 shared stuff between rdma and net-next, and now virtio as well.

we send pull requests of mlx5-next to both rdma and net-next with the
respective features, exactly as we did here, and it works nicely, since
we reduce the number of conflicts to 0 between different subsystems
that rely on mlx5 core.

all the alternative you suggested have never been tried before :),
net-next is Closed, so i can't do further submissions.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
