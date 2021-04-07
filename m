Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE89C433ED
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 05:10:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462416113E
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 05:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462416113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E26A14061A;
	Wed,  7 Apr 2021 05:10:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a46oizEt9YMc; Wed,  7 Apr 2021 05:10:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33DC6405DB;
	Wed,  7 Apr 2021 05:10:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15481C000C;
	Wed,  7 Apr 2021 05:10:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79018C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 05:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5F424405EE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 05:10:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7MR1LgzRBRWk
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 05:10:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4D08F405DB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 05:10:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXiYyMmH3cQOUdluVf4+OcE36Al7GO6nDX0Mf7jNfrL4pZNwUskiYqe7kolpCAj9phvAyBjwngv8kOZOxEIY5K4jVWQ6uqqJwA7Tp1IiBhCnnBQ+I1KgvM1Nik2MEcTnpUa3rd4+pa9iQUTW/ib5n+ZUve/mmAZADEWyhlmOhg2GkDH67x1y2Jbewf7TkIoV1JwTH4ZTc7UbWWbY0VUmznA00SlobtvziDdWdnWgv/eCdmQgIK2N6JmOeSRD5uLIbflWOmcO/boQ/MCqCReT9oSTzbhAPQRtVfzwZpmfSYXNJpv9FFpLHbbOPGPxazjiPujcP9pNP83+w6J5oOtZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jrYr7dsR7y8CdiSXARb6EgtxrWHMoaxr2Z8DJBn7qU=;
 b=UJbnJHTmWJuvWKSdoF69PuuAQvCHnKSwBuoYK2o3xpwxNwUAuVdrP93DagGX5DT4H819ENWbIAeIeEosH4uwcNgWjWgrI/of3H3fE7TX6Stpd3X1WDx+IkD7cjhnZj5ykytuyz7nmhF5qo4WMBHzatxU9onYyOJ9ZO4hOdtEh5dk1FsPU6lO1od5TouIWjYXaagf2zWEWegVaNmVXYRMlD2vSMUFGbMPgkKaOzQmffq3keJQNs+wpuuSA1AUohy9DuYWE3nlftiZNymGNDbCPy9gBtD4+a8AMEuggc86bx/AsbBvM/yyv2QN8wA9FJ3D5dC89U7gKoARmGFDHZgGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jrYr7dsR7y8CdiSXARb6EgtxrWHMoaxr2Z8DJBn7qU=;
 b=XaasMnw23FoiVrVQYugXKPxdpIZun6NCXrMQgi9u8pSqd6/4AFX66UvX7eZEG1dldhwSdtGYAIKcy9ng649rz92ylZTDnyfQNsWRI/cfW0tgs8ebWLOyIjib47dU7Ty8rAGqnzIP9P/DAUpsrIDUDplkcJ991PM7ddYRQvqTfnNaIFhJZ2ts6Ih5xU6Uwb48+ll2O89s/Z/48ABA8Nu9F737NZs6R0jsZxWbOdnyFhC+gXBUNg1v4YWbN0YuweTPQzcXPToHKsSl4zpgd0/r5mwiIhcujZIN1YoXE1Ud6HjXjrwUj9ockQ1wBWyezICpQosVc8RaEVZ+RiZD97AYcg==
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB3956.namprd12.prod.outlook.com (2603:10b6:a03:1ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Wed, 7 Apr
 2021 05:10:38 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::7cec:a7fa:db2e:3073]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::7cec:a7fa:db2e:3073%9]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 05:10:38 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v2 04/14] vdpa: Introduce query of device
 config layout
Thread-Topic: [PATCH linux-next v2 04/14] vdpa: Introduce query of device
 config layout
Thread-Index: AQHXKwcKvOK5lWqkQUClIbp9FUDvk6qobdUAgAANqoA=
Date: Wed, 7 Apr 2021 05:10:37 +0000
Message-ID: <BY5PR12MB432289ECA113D8DCD4EA1582DC759@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210406170457.98481-1-parav@nvidia.com>
 <20210406170457.98481-5-parav@nvidia.com>
 <021bd627-953d-2a68-93e5-b4c750569230@redhat.com>
In-Reply-To: <021bd627-953d-2a68-93e5-b4c750569230@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [136.185.184.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c0f0ef3-a637-4bc5-092a-08d8f9837b7e
x-ms-traffictypediagnostic: BY5PR12MB3956:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB39562FEDF858395DDBAD7419DC759@BY5PR12MB3956.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a3CcdnozsyaEFSGtvUw+OR2u51bVm6gbfi0RdKnnX10Ad+zXJ2AB9ObRHpOfUbggDuT9s78lDTdtsA/Ka8AQfD19aAEuL5xqzJrEk9/CbUxSZuOWJUiRkCq5MF/sWCpih0YDOf/kFlM8yMiPsQZg5nAcsWqXLJR96gcPO+W2zJVC+dKw3GkBmObJ+5O8/wTHht3WDiIhTH6v2HUUDnbeNgjD1S8rX5I7CM4g4Jzj/ii43u2LuLznSIlDBeBaChRFDg9Sc1r+hT1Mw+c2mMzaE/g8AtLlQBXI0uRSJ5E1Zg5R8kNlk6UknD+HIgitC8/8JfPArtqQ2dSGXk+zHpofyo8FLkC9Izds5Qni/1mQ1MQjEDzwAblF2bGqmCJWI3KZ0EaO3OlO+GJ6Ik+2eu01vW2lfM+zE5youDlVQPCSjQALop7Nrl28xnNbEIYfYhH60e4JkjEdh3PW3GjL669NSaU0nfCXcWg68lliOIjIfB9N7Z+g/BVw1+9CsIroGorx4iEJeAZOKxMfSJOvMKYdlw8HMlCerit5bsFOU6ybgpMhT117e/j1qdT5UFhZCJ+UGHbqATpNIhbpHLy4TVrPtcAFEMuM2HXjhDpjKOK4t456gyLp/6nJzMT+/HiP2uJK4wK4/3lU9S1RUmldC4ic7Y6SZ6IlnDr/UtpAPi6MWuBZ5tNUddsyLZpNX33Fks3C8KE6DN0lBExCLzscX2oYzHy4fL6IZWz9NMtX2+NQaSl1siHdrEWLxjMU9gDOlyEofddNsaRXQ6gh9HU+yQJGxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66946007)(76116006)(66446008)(66556008)(71200400001)(6506007)(8676002)(498600001)(107886003)(9686003)(52536014)(966005)(64756008)(186003)(26005)(38100700001)(110136005)(5660300002)(55016002)(7696005)(2906002)(54906003)(33656002)(86362001)(4326008)(8936002)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dt6h37DUhjgt2ybUvKbLox5aYHW4+zO70Vv0roPouQ27/3ezlTt3RNoBrIzF?=
 =?us-ascii?Q?xqGVGTVzsovhnMUApR5xdQ8f5iYTAXz6CAp6+Kdlcl/sc2ZlXCpOYVxUQunM?=
 =?us-ascii?Q?8vrvBrTehE/xMU/Ob96SkfA/OayBQKiSXim9IdVTYdKRqFHRwIR6/q2Zu2vP?=
 =?us-ascii?Q?CDaZJdJXSZ1QoXNvBzZDzkC6ldYRIL466NIU02E2e/rraB9qfVzuDHWvAxqn?=
 =?us-ascii?Q?PQfIMWUbdMxBtBgL6L4U+50jGXUzxrsIu/fSQMpDYTh4rZe1D+pZz4Zl1w6x?=
 =?us-ascii?Q?ARjqDg+6BZuT5uBp2JmHgeY/Nds+EDc7uovJGsa3StYQMBfwJ1lMy4VTL4ne?=
 =?us-ascii?Q?xYOvOZwVULEZsvwyO1knw3+yzaux52YrTeL9yrMuIHd+cKi3sSSXUrqskoly?=
 =?us-ascii?Q?3Ol6sLVHfwGjqz+4XamRowaUmC7IzvJm0Ot+lXuc5GbIMW3BGpwVQ4nGFYTt?=
 =?us-ascii?Q?8sgkjhppBgKweJTlyMdRf6EHF3Zye/KoXmTQNF2y1mSm3k3NVzyrDybBbT7L?=
 =?us-ascii?Q?B+g1DviA6DRjuHHpcQEMq3GMJFBN+0mggdrYc7NNrmaYHO8rcTiAW9INvfWe?=
 =?us-ascii?Q?sk17DKg4260jlPNDUqwHZCH/phDIFielTQK27MOsspg3DMthlDwrsr4ldNUf?=
 =?us-ascii?Q?DerE5kcWnoFeCcurzTU/KsgTDaQTmp//+RgJ8uJC8o+IHKKrpC4vv6hXo/NH?=
 =?us-ascii?Q?6QhM9E7wB+l/hM5ELgvfAmQQ2VpHHr43kDfMYpdjiDtyy0sX/CVefO7GvEPh?=
 =?us-ascii?Q?byMMQCeZHX2ebzlCETE8uZ3zHbs+MwCRBI69x9IxdXbf6sXxqjP9n6rQpSpM?=
 =?us-ascii?Q?DDFnD3P90f7TsRgWGklliTVdaUATP7KSiSS/XY2llWxxKWzp850aYlzf4lln?=
 =?us-ascii?Q?nGE0f/qNS2YWALUGvLI7nbPB7HpL7mm4U267yVK4+bZFpBNB5Z0K+fNubXXt?=
 =?us-ascii?Q?CohQBEtpOzVjN80hri3f0rqkID5eO3G1aOrdQCT+SSrey1pRIvs36NIuY+8M?=
 =?us-ascii?Q?S4aZAR2CuYjEm89Fk80KyzKJPRMylmZIRJp5Hye8dFQh7Z+23dmmCx83CsVl?=
 =?us-ascii?Q?LIiANjNhUsHF1ECLjk+1CUWAA8HllrLmOuGRYYFLUqAIMekKmRrQq/txLddE?=
 =?us-ascii?Q?A3pDDXpMOKgqYFFmvqWfU3wB7nJHVpzbwRRSbwAQEmvLZFTpm0LUOE04ScFd?=
 =?us-ascii?Q?OQdafC0fC6RCWcKfK0J/c8riD/+fA2WeMZ3vR/amINyF/sDrD2IlsH2fzVGX?=
 =?us-ascii?Q?gVAIBSV086frgp4oO9nFgvbKr97e+Dgmsiyn5LoMzYcrY6UTAEqcc7xvP1Pi?=
 =?us-ascii?Q?snnUTgGUlD79L2JrN+4et/7M?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0f0ef3-a637-4bc5-092a-08d8f9837b7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 05:10:37.9928 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Tno1XQUGFHrD9iH+3H0eCim7sUtpovHxvBc/NU0/iX520xCLPZdwZjIiGkIt5LxOvlm5YS7Sjr+DaPsym2viA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3956
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



> From: Jason Wang <jasowang@redhat.com>
> Sent: Wednesday, April 7, 2021 9:26 AM

[..]
> >   /**
> >    * struct vdpa_config_ops - operations for configuring a vDPA device.
> >    * Note: vDPA device drivers are required to implement all of the @@
> > -164,6 +200,10 @@ struct vdpa_iova_range {
> >    *				@buf: buffer used to write from
> >    *				@len: the length to write to
> >    *				configuration space
> > + * @get_ce_config:		Read device specific configuration in
> > + *				cpu endianness.
> > + *				@vdev: vdpa device
> > + *				@config: pointer to config buffer used to
> read to
> 
> 
> So I wonder what's the reason for having this? If it's only the reason of
> endian, we can just use get_config.
> 
Didn't follow your suggestion.
How does in kernel management tool caller get_config  know how to do endianenss conversion?
Or you are proposing to send this whole virtio_config structure as binary data to user space via netlink?
If so, it is not a practice in netlink to return struct.

Also making netlink user space to understand __virtio16 doesn't sound correct.
Often orchestration is not written in C. I cannot think of returning virtio_net_config via netlink socket if it is your thought.

And decoding it requires to query features too. Querying features and config are not atomic so parsed value can be wrong.

Endianness has to be self-contained in fields return via netlink. With that baseline, lets think further.

> We don't plan to expose a legacy or transition device, so we can simply do
> the endian conversion in the device.
>
I am bit confused with Michael's suggestion in v1 [1].

VIRTIO_F_VERSION_1 is set today by mlx5 and ifcvf driver.

> Then we can stick to the uapi of virtio_net_config and there's no need for the
> VDPA_ATTR_DEV_NET_CFG_XXX?
> 
[1] https://lore.kernel.org/virtualization/20210224020336-mutt-send-email-mst@kernel.org/
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
