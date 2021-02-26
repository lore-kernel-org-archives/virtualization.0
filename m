Return-Path: <SRS0=m8lA=H4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A908C433DB
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 07:36:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D507264E02
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 07:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D507264E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E77B840EA;
	Fri, 26 Feb 2021 07:36:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qFYOGBDBCqpP; Fri, 26 Feb 2021 07:36:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id D64D0840DF;
	Fri, 26 Feb 2021 07:36:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4747C000B;
	Fri, 26 Feb 2021 07:36:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 828A2C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 07:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5DE17840E1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 07:36:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xdB7S0bch-V0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 07:36:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 73D47840DF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 07:36:39 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6038a5060001>; Thu, 25 Feb 2021 23:36:38 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Feb
 2021 07:36:36 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Feb
 2021 07:36:34 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS)
 id
 15.0.1497.2 via Frontend Transport; Fri, 26 Feb 2021 07:36:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3wi41TnrLIJ+LDKMMtDmjw8Nz9QaL0jvGJqcW2lHGa1hfPTCw3G1pcaKvBvLibufoO3BTxtY6k5S6J4VnNo3Rki5+VMhpw1Ku5XnZ36a/jXA+s5RdHzUKQvdSQbP87ahbdKzxr21GuGscgOCdQxb82asT6jdSsCTBUiCNkNhMXbKppR1rlL7irOBRgcyh1lH3hN/uHU+lcpW2rNnGREdWmn4CLRGF3eSO97PI3sppu38V8/CMPhtGfLWXDEuxGjI8ixB+WBB3MF3xC3A8+HJMNMrmmncY01SKZm9ijQT7VjMFv8EXhdTk57SCjJ/o4i6/oNBlukng7gbqNDBIyPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SStx/WyqDCydiKr+010xOpF2JOFgBF0cRVE082hyCt4=;
 b=W+WDh+i91H8o2DSTfh7/+fr4jJMAWkO9lJxcNA35TBSG/cb9nWSk8bjaKBNUPLN3tGiRhpUdC2pxSdVW8EXcG7/BkB5HtA2lgSPyNlz15jfFzOCi6C7c1T8aQ22FbNKbjS6lRcvm2mWx20YPK8PwWSJbQHxXEiFt+WD43WTG7W0xv0vSseLEXnL7I0jgAM8o0yq+Ajk3+O17yyLQuthjqR2pdcwFB8u+EwP+CQS79picA1Sdml0+dLhLHzmh/nuyX5jvhfbM9o193OpcI4iUcQ+9PyCVJh/Gw6LiylT6s4zUQkENb+13kudDxtQnh+ZCvrI0FECy/IoQXa1ZRrp2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB4759.namprd12.prod.outlook.com (2603:10b6:a03:9d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Fri, 26 Feb
 2021 07:36:32 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%4]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 07:36:32 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next 1/9] vdpa_sim: Consider read only supported
 features instead of current
Thread-Topic: [PATCH linux-next 1/9] vdpa_sim: Consider read only supported
 features instead of current
Thread-Index: AQHXCnT1emy/gsVqvkOvVtDCneHoWapm41mAgAMokPA=
Date: Fri, 26 Feb 2021 07:36:32 +0000
Message-ID: <BY5PR12MB43223107467FBA270BE072F2DC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-2-parav@nvidia.com>
 <20210224020336-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210224020336-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.166.131.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7076e59e-cc9d-4fdf-b949-08d8da293cf2
x-ms-traffictypediagnostic: BYAPR12MB4759:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB47598DBA2AE0EEED8D81D9C3DC9D9@BYAPR12MB4759.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zc/UzNTLBbuE6TCR4Zx95HRL5jeT136EXsBd0fi+aKTDx8S5/9oAlZ/6mRYWI57oPO4Evcs1hREZrMwtRYg1OKQW27z7ZtlRmiPCd73bf5Dhr26dALN8SuPrqls1HsJOmVsW8yV/Q50+fDRVhFf6lkXzyIL+h+O1nzDWmgTQ0n6FE/rrEQgdJJijef1GmevyrvL4AfZzuTlkLfS9d9rD6NempzXD0+i9uh/488FAPtlOhTF8h6VuqVQME9ZVZQl2GoCeq1ko3guwd41AnuCDlPp6aZb2Srk5sTRI8OMBvXaU2ry09XiaCLXmqYlWqV1rP9decwHsXHD3jkY44yHhV6XeBGpuum0ZWi6DyEUkymROtr/QcyS93WJ6bJOYUe25aCiHEnerZQkUnq/khQq73pzeYRBClTrEjh16SoEcD5sPnfPudKdKi2U5WIDkPVghOpvKv0UJe5gIwSZ9OAmP9pBvmD54GP69nhsnnMwAtKUWnFeA/CPuT5OclTwOSWv5ZmL4gZ2nngDAU3ki6scOFw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(316002)(86362001)(8936002)(6506007)(8676002)(7696005)(9686003)(54906003)(4326008)(76116006)(66446008)(52536014)(83380400001)(33656002)(66556008)(66476007)(5660300002)(478600001)(26005)(66946007)(55016002)(64756008)(107886003)(186003)(71200400001)(2906002)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/J2OIcjVfIMA56+LIHjcBvYM75eCbI7diCO7iarpyhCEXsLvzpjEDVC9086e?=
 =?us-ascii?Q?WRRoPgeV1mOKy172lQZI/IjTquj7RGoqJ54zKrDZ/i6t4JOWTH2FnWCPxmfS?=
 =?us-ascii?Q?7osG9epVEqzz6OLQq80eSJ0/UWKWVlYcJmkEoPAF6DrTjHqa0fs50sCYGPBu?=
 =?us-ascii?Q?6Vg/2mNQQI3g/S4VZKdLf3WudvLUVnGkzu8ND+AOoJTdnqqlhwRndxg6H8JG?=
 =?us-ascii?Q?/P2vOoul799FuEQzXQyUgeeUEP3z0LKcUsBIY7WLyI2155LUL2SSSVuyINnT?=
 =?us-ascii?Q?415Xz9R7dIJ5UoMJ4Q+iNr/4aCIQQ58zvdHIFU+ud9q3Gx5yiI0w9NN2aH4s?=
 =?us-ascii?Q?zAXzD0w3OTEZd10KkkoIrC9zgHzvYIXO6jyS+aHduERw2AgiCTk4NYzqZtnS?=
 =?us-ascii?Q?x1k5OorL/tb+Zww+PK91657NkpZyxuFNJBdz+6BWQlYSL2+fPQz+HTUhmKfE?=
 =?us-ascii?Q?ZE7LPzsPQzSUybYqDP9lnN/Tdd8+SxYvdIZXORkG07q5COAQvJ3UckZRu+FH?=
 =?us-ascii?Q?Jx8HTDH9oRHdJZfAAo5plITmQXoaj0BZj4c7bAaLSsGCyBYh+bosaduh7iXo?=
 =?us-ascii?Q?Ga6uC98XmE4WNF160c0dVseVqUmbGrb6KQV/14owhxcZw65P06xBdN1lANqb?=
 =?us-ascii?Q?pPyNIly7oQM9Z0b4fgnPV0LHa5wqQvGYTMswNzKqb0yTWUi/Z38j1qJpEAhp?=
 =?us-ascii?Q?g9faQih693l6IVEog0NHt9U15721l8MqT8IIelOeWuZQKufMJY9oaOKUTypv?=
 =?us-ascii?Q?HQz+XC8snutrO5vcIVg65k7ObOErVpM9bN3BDro3SULhLKOL1epjhASLaaAo?=
 =?us-ascii?Q?WpMdMY11U+EVS+35BmeQgTaPoVmx2xO1leSPP9k9cFY3Aaibp6xZEPrFIOS6?=
 =?us-ascii?Q?C3RTteJmvQaAK7fL5556Ivtbr2ncqNfhctpCWLuimiy9cD6kayoe816ysFHA?=
 =?us-ascii?Q?L57JqBUXC1aEuniD1Hpw7V1UoORlD44vv7J8I5tibsHQzEWyL24hDbs5617u?=
 =?us-ascii?Q?TSHnQ3Emub2M84mMKlZgC/LHMLJ53zWUc7irri6kCV4N/fepe1eZWz9eOER5?=
 =?us-ascii?Q?iE1ESR1E748EyCb+xFRWJhit5MSpdcAKq0IUjG2f3RmBgyxGbmkM3+1y2PIs?=
 =?us-ascii?Q?nSEov6G6zBfFnMKhEREFnTqgMv35kKDv9NL/L5mxVQLR++2T39Vp6TLlV0T8?=
 =?us-ascii?Q?qhqecFICkAhSC9GKim5bzM1QPNrMoi11YnHOaktz3zM66+hrkmkrv0IsY/Im?=
 =?us-ascii?Q?Qml6T7MZksqDeIJwy2fcU6jPCYna+99i1u1m3utgQTe+zfFeaik8hxUOsXfy?=
 =?us-ascii?Q?tBoEhuDfvhztyAxeI7HnBXna?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7076e59e-cc9d-4fdf-b949-08d8da293cf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 07:36:32.2784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8zraaB9gzxqemj7msT5vwbdxc5k24yJSXXQUqrZiUm4S9qICvHHO++ocs38HqSD5tQ/RtXbprRuyUU+9bcdTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4759
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614324998; bh=SStx/WyqDCydiKr+010xOpF2JOFgBF0cRVE082hyCt4=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
 x-microsoft-antispam-prvs:x-header:x-ms-oob-tlc-oobclassifiers:
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
 b=Tq0ea6p9Ps9J23cBRt3AOYYqQ7psQYurPLqvgrICQh0iqtv3eh1NA9gZFjkOGH7EX
 0//rqn/w5oMOB6GaaWL11aNPAtLAKqUxcF2b9yZqT0Tz9nWhPF8bz4vVZv3jyO1GTz
 OuzMlHvnGCvtMEwzJdv/5vMpIoWvIUVuKiaRDRCeCOouN14keIrqyF3jXoxpwCFVA2
 GxHskwhB9pfak95taJ6FR4/7FzDEw7ppUv1BeS89nVAAO70L1+iknhUYr6QEOqznVN
 VtkvYqSjonZ3vqyfsgTPCSaY09l8f8fojSCvwCe6ryRHcArbYSAuLd3H2L50/PmMo0
 gCbDTLfccpaSQ==
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
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

Hi Michael, Jason,

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, February 24, 2021 12:40 PM
> 
> On Wed, Feb 24, 2021 at 08:18:36AM +0200, Parav Pandit wrote:
> > To honor VIRTIO_F_VERSION_1 feature bit, during endianness detection,
> > consider the read only supported features bit instead of current
> > features bit which can be modified by the driver.
> >
> > This enables vdpa_sim_net driver to invoke cpu_to_vdpasim16() early
> > enough just after vdpasim device creation in subsequent patch.
> >
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > Reviewed-by: Eli Cohen <elic@nvidia.com>
> 
> Well that works for legacy and modern devices but not for transitional ones.
> Without transitional device support vendors are reluctant to add modern
> features since that will break old guests ...  I suspect we need to either add a
> new ioctl enabling modern mode, or abuse SET_FEATURES and call it from
> qemu on first config space access.
> 

From mgmt tool kernel point of view,
(a) config space decoding depends on current feature version bit
(b) feature get/set and config read are not atomic callbacks 

Mgmt. tool kernel code need to read them in single call from the vendor driver.
I need to add mgmt_dev->ops->get_features_config(struct virtio_features_config*) calllback that returns value of both atomically in structure like below.

struct virtio_features_config {
	u64 features;
	union {
		struct virtio_net_config net;
		struct virtio_block_config blk;
	} u;
}

What do you think?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
