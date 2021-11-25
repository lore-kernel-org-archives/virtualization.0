Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3298DC433F5
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 18:31:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A8DCD401D4;
	Thu, 25 Nov 2021 18:31:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q8CTf3HrPmKl; Thu, 25 Nov 2021 18:31:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 72841400A4;
	Thu, 25 Nov 2021 18:31:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46301C001C;
	Thu, 25 Nov 2021 18:31:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8240BC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 18:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A79A408FB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 18:31:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hdbX-B8xBSiM
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 18:31:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3AFCA408FA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 18:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVqNvkneEzUPE999MR6XVjGJ0MTdSFHOT1oHLPzSO4XCyYcX39T+xeTiPhEKG8z9sOTQw4yYISCnDVAHyrH8NKI085Gi38CD6U10x0FW5hNkfz8wDfkTwn2ga0B9CYXeEH4nkQuALIHOhlkkck6GFsUmYsOkJy+EE2iZ6SqIl5ew51F71WBc++9FwcL6G6bKXr2VaSF3zIoEDKzDIJLfetN/kFCNeCkfUKY+6cHC/O7uRDBldaiy05LQSi7Oq5pV0ch332QgA9hi2sw9zH5PfgUoouPLg0T+Gj49jZ7hIzZlJC1omSxsTONvyslVTrg69/IbY0y2nOnjJ3tlbMyn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDwiRk2Il8D1kh5ezleLuejshnlE1V46HQxdXlJU9JI=;
 b=lWkvkY8asDPpFthGroPw0cxiCCs1wwprJ5uxUSTTCcf3qTqsTUSWMUXM99XWJkTOCFxUh/hpn4gq5E+y6OpCac4QHznIxUMDHwWqkXquqwoYYP+7IPN1sTQMQPbk0lZz+QbcjGuDoHqLvgtI9E67PNCxYqEsRwWI814Hay0Chy5IttZu4g7kTGhFraOFkkrtot9AjLohFnrGtcmXlonx0XhtDRjCpPFhzyMPgr9aIgbgnE8j9rurYaddM7ek2FpsxqUC+JDsrfIqddOLErFzte1eGoqFLERwtjAvAYE6BZWzoJKF2/Unw03MeWVh83T9kn7XSMod145N0ocXf9aQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDwiRk2Il8D1kh5ezleLuejshnlE1V46HQxdXlJU9JI=;
 b=un3642K7L5SXJxo81gaZRJJ9fSc4EJQGC6OsYVylEm5QuQUiIquHAEtOpt1exVjOcXML2Ry9a/s3Q4vOfi7+LUT74RBZkioWCvUdycbJ53tZtEl5JVMA6J9sfldgS1R80EB799XQlL/fXYcDamr/Iy+nN3CnzOWU7EXm+PcsHmsYXrT4D/2ikfzt4122g8HYaM1PSAuJw4xnpXJuZEUL/j1bEUfP6ee2jtPbrOFBvwv8Y5EJ8QDEo51epZcAASeLP/Tnjkbvi6SIH6PckBeaGY4FfVzGPrDi7Xpe+j3ORBZFFWu51cohqLsujKgicV9oOYDoqWTldqXUerTCamKd0Q==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5482.namprd12.prod.outlook.com (2603:10b6:510:ea::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 25 Nov
 2021 18:31:37 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a%3]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 18:31:36 +0000
To: Eli Cohen <elic@nvidia.com>
Subject: RE: [PATH v1 1/2] vdpa: Add support for querying vendor statistics
Thread-Topic: [PATH v1 1/2] vdpa: Add support for querying vendor statistics
Thread-Index: AQHX4VQrJsRhfsS90kGFJYDRg8aaW6wTuC2ggAAsBICAAK2QsA==
Date: Thu, 25 Nov 2021 18:31:36 +0000
Message-ID: <PH0PR12MB548197999B38399048A1406EDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211124165531.42624-1-elic@nvidia.com>
 <20211124165531.42624-2-elic@nvidia.com>
 <PH0PR12MB54818A0D2D4B3ABE5DD081B5DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211125080701.GF214101@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211125080701.GF214101@mtl-vdi-166.wap.labs.mlnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f817ed42-64df-484d-7d7b-08d9b041d0a5
x-ms-traffictypediagnostic: PH0PR12MB5482:
x-microsoft-antispam-prvs: <PH0PR12MB548228D15E529856389CC64ADC629@PH0PR12MB5482.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d4QUsetYWLO72GeKRxJ5nx/DY1DbJPpokJ0enaup0pA+mMsb89+fTQ7MCVDTB4J11PSyH8RUTH7vkVp/aTCo57xDK3HdmQpCE4dnd0/9yc240fg+xEHeWj3VPjfw6+sLYt8Q2Z68uPKGiiOZU6mRbh8wnCllkl766lHQRbAWySjxiD3tAt37aA5nYy2RTqiXd2DO+nRusXAhyNbTKlLl19oU+nkRh5yhps7oQs5DAi12J2Qy9etL9wXFXAKdHJTfbLZmKuqlskUuyTsTKMCgcmYIdensZWY9KY83KjwIKMTiu4ksaqFJ+S7HfkHmYmxPjY8Qu0XJD/I9EbF5TDqHriuZdptRK4csYoD7wnZp5dQTuSgdeR/2YjyMfBj2ZQ/X6R5GhnspNze60LpDEvd8HnGyNMr1MeCglFKHJjLKfy8o0xkhT/PiTCOr8SPUva4AACZG1i3bVfXHB/jktexdvcMWhLUiaG+dD9hsOmvQKH9EHUbj+7oLGWbEhmLJ7nUhN4DMB3pk49tPMvNEWHe7zruK/Dw4iu5DrV2faR4VzoQULHN5ZPiwMP/Tf2xTueiHaXBe08H3X4FHa6d4c019l/Bx6W4M3vhcVvXYGvNTU4gRlvH2rF6xJKW+P0l7x7lH+OvtdAAUyYGv2SiqpkZpEg0zKUkMUT11dSpaKJILAhUz1LCA4l9XLLPMlCYyEuZ4lPaXWTUnSWza+4JdVFyz6w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(8936002)(66446008)(86362001)(52536014)(64756008)(2906002)(508600001)(316002)(71200400001)(54906003)(66556008)(6862004)(26005)(4326008)(55016003)(122000001)(76116006)(38100700002)(5660300002)(83380400001)(33656002)(66946007)(66476007)(8676002)(7696005)(9686003)(38070700005)(6506007)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dEXUVUbcCss/kFj7uKWRqWR+CwnddQ+UIbzxCyhTAtEiFw8eKr9G2BYgRAnu?=
 =?us-ascii?Q?5BgCg0tr9yVwFpZUTtLFCafoA54PsQKznREyGWYDUmVibk9IYJhCUTlmrL5i?=
 =?us-ascii?Q?7v92JH+F2pU9ul13mB/w6VKOvZk3NGoinWcCm9p8cF61clmr1UJNipbl8bFH?=
 =?us-ascii?Q?y4U12cqy4kBQVjdCqeUBFki6kTLXvcXqPw8+Kf6ANn6R3yWSV5Kgu0zvMX0x?=
 =?us-ascii?Q?ZRqeIRT3IIqfFKbxdzwH0uZr+5V8zUO6cV1MmYHukAyi0I37X6L/RflP+zbb?=
 =?us-ascii?Q?hESoFUHp+OhSmhJ47ZVGAtZKnCtXdFSI5rEidGcmTAe0d3Piqi5DEpNznPkx?=
 =?us-ascii?Q?Sl4Fes7PHhmeagCICWeRnExGAADiYpTYbliADkIdjAn381CToTQFkBGzmu0O?=
 =?us-ascii?Q?bGGK6o2j4m8R7GP4c8w0GSV+dk4nNwN6TpMFlgbJfuKoy7J5hd/D5p3ooWXV?=
 =?us-ascii?Q?to2P2K0LQRvn/7E1SpGTg4aCtaQJyuO6GYhGl3JEXPkbbkA5QsGPTXWKdx4h?=
 =?us-ascii?Q?w7Yb6j+dkkczYCJMgFGM5l3X/m1fQC9cf7LJ53sSAoFVQ2Za0pPyLB3LdpDP?=
 =?us-ascii?Q?eidCUZIlOn7ZI1iqZ+5DngReQ9KNdtIJ7CydUziJ/cfIxAUgVTqhatozWDhJ?=
 =?us-ascii?Q?kuUlEQ6blP7WTzQXk5svvIpyiru3wJIfojW89e9zffQLn22DMkEZTKtZBFix?=
 =?us-ascii?Q?s1OXFl1PZtMwa2U+t+3g4a/7iSPTsYRx3c/ca17SvQW8mxDi2j0jP+qwUHBz?=
 =?us-ascii?Q?eiOIGreyqVAgyXmfwQABzRG1GTr1FRlxvjNA1+W2NEyGpqnGsoFvD80jlTxc?=
 =?us-ascii?Q?9Og4baQzqphpjmGz+OKnWP5VvnU28Kk/3knvdxIIcKiddIoocsSGUOxZhHLK?=
 =?us-ascii?Q?VWF0J8SQiMbb5V49hopIIGXX9HRJggXmw4XntNwdopZuPDaR8xxeOqBKoAtt?=
 =?us-ascii?Q?vok3pDXGYMR9azN2tW5YphZllmSzCd8mS1HsUEQhjWKm9Gg4GcAMMi+Wk3z5?=
 =?us-ascii?Q?L+UrENDYgoQPy6Qk5ezcGW+a4AUw8+g0eC/sMHb0uvNy71n20jIfKuVU78UH?=
 =?us-ascii?Q?96ebUN5mYZcoXmkRKfrzxkTqMrjLZSZQEoF18p/dx5P4gMsR8NRqAd2YJDN1?=
 =?us-ascii?Q?j5VS8E6Z+Qh3AhIpYgf27H3T6m4sJXJB3l6LMKu6Ng8Fa4B0Z6oxqCepNo76?=
 =?us-ascii?Q?RnuffSw8chaHo1r/c3/5dKZ+DSTWlWF1u4Idj6DJN8kMacTQ2MPqwVTHz1CZ?=
 =?us-ascii?Q?vXrUlYXpeEVHQTQj8hHSpimkXMr3up1+iakFW+ruUlulC+GcXQ6RlOu8qEtW?=
 =?us-ascii?Q?gRyZtQTm7ldatzkFO2DbQbxJ3c7R/Oc6cMQIocaflCD4/5sS1iW1ppBi75JY?=
 =?us-ascii?Q?ydjH4L36Yc+XiTEhJI9nFaJ9hLkljvgDQ/9f3ZQLUHtWTL4zCiKWG2s94HWT?=
 =?us-ascii?Q?79V20oNWn3MYsBEMf/q+hZtv2Kj1R8m8qVcUSGcpUEpi3/yUUY/h6kpAsCp2?=
 =?us-ascii?Q?Nm7apBEx9aoF+1BOcMg2JGgvTjB3up/wyHXk8BAxGWWnMafurC2vH4uN+LmF?=
 =?us-ascii?Q?18y8lfbcck+DQQMvyII+jOT46gIUyOKZuxaZoS9g3EqOxSGIAjTVr92XgzPn?=
 =?us-ascii?Q?xw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f817ed42-64df-484d-7d7b-08d9b041d0a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 18:31:36.8469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bSfPQspzLP19q1Y9pJntuaok5HMXsoYQIsytEQgbh02ejjFxBY1YBKAQtlfcyU1ZNi7GTzVV4cm5xBaISTCgHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5482
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
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



> From: Eli Cohen <elic@nvidia.com>
> Sent: Thursday, November 25, 2021 1:37 PM
> 
> On Thu, Nov 25, 2021 at 07:34:21AM +0200, Parav Pandit wrote:
> >
> >
> > > From: Eli Cohen <elic@nvidia.com>
> > > Sent: Wednesday, November 24, 2021 10:26 PM
> > >
> > > Add support for querying virtqueue statistics. Supported statistics are:
> > >
> > > received_desc - number of descriptors received for the virtqueue
> > > completed_desc - number of descriptors completed for the virtqueue
> > >
> > > A descriptors using indirect buffers is still counted as 1. In
> > > addition, N chained descriptors are counted correctly N times as one would
> expect.
> > >
> > > A new callback was added to vdpa_config_ops which provides the means
> > > for the vdpa driver to return statistics results.
> > >
> > > The interface allows for reading all the supported virtqueues,
> > > including the control virtqueue if it exists, by returning the next queue
> index to query.
> > >
> > > Examples:
> > > 1. Read statisitics for the virtqueue at index 1 $ vdpa dev vstats
> > > show vdpa-a qidx 0
> > > vdpa-a:
> > > qidx 0 rx received_desc 256 completed_desc 9
> > >
> > > 2. Read statisitics for all the virtqueues $ vdpa dev vstats show
> > > vdpa-a
> > > vdpa-a:
> > > qidx 0 rx received_desc 256 completed_desc 9 qidx 1 tx received_desc
> > > 21 completed_desc 21 qidx 2 ctrl received_desc 0 completed_desc 0
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > > v0 -> v1:
> > > Emphasize that we're dealing with vendor specific counters.
> > > Terminate query loop on error
> > >
> > >  drivers/vdpa/vdpa.c       | 144
> ++++++++++++++++++++++++++++++++++++++
> > >  include/linux/vdpa.h      |  10 +++
> > >  include/uapi/linux/vdpa.h |   9 +++
> > >  3 files changed, 163 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> > > 7332a74a4b00..da658c80ff2a 100644
> > > --- a/drivers/vdpa/vdpa.c
> > > +++ b/drivers/vdpa/vdpa.c
> > > @@ -781,6 +781,90 @@ vdpa_dev_config_fill(struct vdpa_device *vdev,
> > > struct sk_buff *msg, u32 portid,
> > >  	return err;
> > >  }
> > >
> > > +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct
> > > +sk_buff *msg, u16 *index) {
> > > +	struct vdpa_vq_stats stats;
> > Better to name it vdpa_vq_vstats as this is reflecting vendor stats.
> ok
> > > +
> > > +static int vdpa_dev_net_stats_fill(struct vdpa_device *vdev, struct
> > vdpa_dev_net_vstats_fill
> ok
> >
> > > +sk_buff *msg, u16 index) {
> > > +	int err;
> > > +
> > > +	if (!vdev->config->get_vq_stats)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	if (index != VDPA_INVAL_QUEUE_INDEX) {
> > > +		err = vdpa_fill_stats_rec(vdev, msg, &index);
> > > +		if (err)
> > > +			return err;
> > > +	} else {
> > > +		index = 0;
> > > +		do {
> > > +			err = vdpa_fill_stats_rec(vdev, msg, &index);
> > > +			if (err)
> > > +				return err;
> > > +		} while (index != VDPA_INVAL_QUEUE_INDEX);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int vdpa_dev_stats_fill(struct vdpa_device *vdev, struct
> > > +sk_buff *msg,
> > > u32 portid,
> > > +			       u32 seq, int flags, u16 index) {
> > > +	u32 device_id;
> > > +	void *hdr;
> > > +	int err;
> > > +
> > > +	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> > > +			  VDPA_CMD_DEV_VSTATS_GET);
> > > +	if (!hdr)
> > > +		return -EMSGSIZE;
> > > +
> > > +	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev-
> > > >dev))) {
> > > +		err = -EMSGSIZE;
> > > +		goto undo_msg;
> > > +	}
> > > +
> > > +	device_id = vdev->config->get_device_id(vdev);
> > > +	if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
> > > +		err = -EMSGSIZE;
> > > +		goto undo_msg;
> > > +	}
> > > +
> > > +	err = vdpa_dev_net_stats_fill(vdev, msg, index);
> > > +
> > > +	genlmsg_end(msg, hdr);
> > > +
> > > +	return err;
> > > +
> > > +undo_msg:
> > > +	genlmsg_cancel(msg, hdr);
> > > +	return err;
> > > +}
> > > +
> > >  static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb,
> > > struct genl_info *info)  {
> > >  	struct vdpa_device *vdev;
> > > @@ -862,6 +946,59 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct
> > > sk_buff *msg, struct netlink_callback *
> > >  	return msg->len;
> > >  }
> > >
> > > +static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
> > > +					  struct genl_info *info)
> > > +{
> > > +	struct vdpa_device *vdev;
> > > +	struct sk_buff *msg;
> > > +	const char *devname;
> > > +	struct device *dev;
> > > +	u16 index = -1;
> > > +	int err;
> > > +
> > > +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
> > > +		return -EINVAL;
> > > +
> > > +	if (info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
> > > +		index = nla_get_u16(info-
> > > >attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
> > > +
> > > +	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> > > +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > > +	if (!msg)
> > > +		return -ENOMEM;
> > > +
> > > +	mutex_lock(&vdpa_dev_mutex);
> > > +	dev = bus_find_device(&vdpa_bus, NULL, devname,
> > > vdpa_name_match);
> > > +	if (!dev) {
> > > +		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> > > +		err = -ENODEV;
> > > +		goto dev_err;
> > > +	}
> > > +	vdev = container_of(dev, struct vdpa_device, dev);
> > > +	if (!vdev->mdev) {
> > > +		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa
> > > device");
> > > +		err = -EINVAL;
> > > +		goto mdev_err;
> > > +	}
> > > +	err = vdpa_dev_stats_fill(vdev, msg, info->snd_portid,
> > > +info->snd_seq,
> > > 0, index);
> > We should be really dumping all queue stats of the device in the dumpit()
> routine.
> > But there are some limitation from netlink core to enable it.
> > Given that, I prefer we limit current vstats dump to single q whose index is
> specified by the user.
> 
> I can live with this. If no one objects, we can simplify the code to return stats
> for a single VQ.
Yeah.

> In that case we can also adopt Jason's suggestion to let the parent driver fill it
> with pairs of field/data for each vendor.
>
Yes, for now, there is single vendor reporting it and stats are generic enough with only two fields.
So it is not really a burden. We should wait for other drivers to grow and actually diverge from current defined stats.
At that point it will be more natural to move in specific drivers.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
