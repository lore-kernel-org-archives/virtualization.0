Return-Path: <SRS0=8Uya=NJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1B6C4338F
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 03:15:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DFC61056
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 03:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22DFC61056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E238280D3B;
	Wed, 18 Aug 2021 03:15:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zguMaVb4K37F; Wed, 18 Aug 2021 03:15:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A0EE280D33;
	Wed, 18 Aug 2021 03:15:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 785CEC0010;
	Wed, 18 Aug 2021 03:15:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87912C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 03:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F9C480D3B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 03:15:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SBT9PkKaDW6i
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 03:14:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::604])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5DE8280D33
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 03:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfZTWgnPztkZmxw7fLQqRo7JeMw832dj1TymjeiPSqgTZARmhlun2st6/K8W8/OCqQ710g+V5XiQeNBndv9XavrQlf7jYQMcM3YOrjsbzFG1e5hcDypkMfJeNUazjnEFQnl3Fi4WY51s6eL492rRiBlymka9Iki8rUHazfFY+rOvdsfIifFC0JoJrcCHpmq18/dhgJ8P/oFgfZlGzsj3eXviNf+2OxAbxhnbdXSpuenTYMxeAQq01loi/2Ul5QOzTIZEPyH5nUip8N05+/OrJpT1q6B8rmfY4fcSlDewRSeEWr4ly9A7AkotTLYW8mgVVueuC+fEl/QMabt+2XJU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smTiGbZqJAFj9dH6iNFZNqOPs7jtLZ9eK+PJnfgCU7o=;
 b=AWWw8w7qVzAux9HwJgEHGVVm05r9/FRADUrnKkZ/tTngAwzfcUnQOLkiTD9+uh4YUtsyk0kJP3unD9IbrPwqEP2QqWfjqLJKxE9IpaAItlxl7/SSxbsfY5mpDsOjvuBwdsaHzdy/djtlDOyWsfX9A2XKKU5nuyDU5zqGS4r9SNwKOYvYfzG4NCoX8aASKst2qQpRg81toji/FX0lBDfWANPS+XlqVyDnzxDHIMlGiGZmM9svcEpkSUENuDvwytAAgFhkS0FFNsV3ukE09UPHkb44C1xiVJLVl36O4ksNr3OEC/2dsGUjlaaxGi7vJ03HSTGhMgNowjS8c0Xv/5pHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smTiGbZqJAFj9dH6iNFZNqOPs7jtLZ9eK+PJnfgCU7o=;
 b=buYlR1STIRjj4di4I7OBYIrmkXI8PS09opVafrNUM0J3WXMnKJqRV09B7BnCCI1Z4S3X3SwLQgxcbe4La+FAb/UxgJrZGtuFm9o2/mkEFWtlgJRiap3N30CiPKHoVLFIBVKwfR6IKk76SfyeEJYEg8GgDolHpD2IFRtJf2jKB4j+HaEsKu5BBcLmhfSAYC4bLENzJc9tLEWsFQwXGMcS/HAqkfBP8tspXk3dtbio5DXubkLi0wx9tRzCxGv7ViZHK/nLUCyowWPFbGd5XmyHlg7kKRCvvj5v4c3RYghtfxiJ+HzBz2jIaAVU1XWOsIlpRFeZwoiBYEXz5EIURJcfRw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5419.namprd12.prod.outlook.com (2603:10b6:510:e9::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 18 Aug
 2021 03:14:53 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29%4]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 03:14:53 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Topic: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Index: AQHXYuOH3YVTcMY6VEeAGlknhW/FN6tk+uIAgAEa9oCAAGJZgIAAALAggATGdICAAADAkIALu+yAgAH5tgA=
Date: Wed, 18 Aug 2021 03:14:52 +0000
Message-ID: <PH0PR12MB54819F68856798FBA8528BBADCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210809053624-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CF2E07B38C45A2829B7BDCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210816165217-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210816165217-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb5597d2-4f7d-4214-9c25-08d961f658d7
x-ms-traffictypediagnostic: PH0PR12MB5419:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB54198E8817FC28175509D131DCFF9@PH0PR12MB5419.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6gNNuddbOa9onbBHeWqVCb1c0XhHUN9Fg59KgilDtaGXfbX5diUSNwJ7hC5hT+uIwc2Oavt08PXghkaxfvMj4Ph5WI3kKZNrnOfUzC44+CoTisHZjkmn/5GKT/hHiBXdtoutxCOb2CqWVs4v9QPjKzEoESn8ESOTYxxuELKCNp2k1oYgru3nO290KBJQM53bJ8E8ClULm/e/cxzyEzIe5e/HkC8Kv2ulFVTSXQ7CtHpFDiaAKKUlN42bN3vzgicd3hZHBMAXjDbcZ/Vr1K78F2EOuyXG7JmEBAZ0jk/NlOr4mSGY6yUe0wlgwP4JALp5WwMnXeZId16gRzEty0eJDC3i8xvRVMpxffBwDzv1JidpbwhuL/h/2GN7HEsAGa0Tb5cgYeYfchgqWz6n2R8Oz8xiCvfdDNyaipbWW8iIc00znUO5WSNwHg7riWO5dTk1aTXKA3Ir7XmXxCixgXadBvC6ND50kTfPG2GX6HUgnnD/U8cvY/0qaUgjff52rHA7pK4EKggDyQdnhzmOjA49vYz8em4zzZPNWPe+McSW+O5+re78cO3e+eaX8fImwJZ2bPr50WTEc7ZQd9ofVYr5rh3by/mZj1FicXbaz8ibj27Vbj7ZKwZfEsBGfHm0stx9QJPAyIYCccMGACsy+bOkdk4s4UAhSoZXTfT0uUhPcYoTGZwmJtp1eXwJgydjortnyCBEuLRiduMVRcQQlvD0yw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(6506007)(38070700005)(5660300002)(6916009)(7696005)(55236004)(38100700002)(83380400001)(122000001)(478600001)(52536014)(71200400001)(54906003)(2906002)(316002)(4326008)(107886003)(76116006)(9686003)(66556008)(55016002)(64756008)(66476007)(26005)(66446008)(66946007)(8936002)(8676002)(86362001)(186003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x9ldFwKCv/XxdZf/pQwyuAltvJi8XPdAu3wUf1eXJ+BhUUSowvE1ylYUG68T?=
 =?us-ascii?Q?uka+vbacBdTR/jDpL9vpReQYn6HbUPkP1P0J8vVubTkciNaVRhcJ5zvekjup?=
 =?us-ascii?Q?DMbNgVBgW+Uu9s76nR3wKngtrAtqJlicvS3VnH9DVCRfnoMMfE957xuFXN++?=
 =?us-ascii?Q?hTBIDCOZV9SX7CZUIo2fuWpr8hvYqkBZTKytp2DMdPb4c6eHyrKJp1aU0bNG?=
 =?us-ascii?Q?7ICLL707JBpN8vGU0/h0hu1qu4FHIZMZotEBoUBAkCSWscjeJ0FfhWofxRLq?=
 =?us-ascii?Q?ULHTri+6HFUKdQLagO54b10nHbe4rOHWYFjDTrxRzO6G5TX3TFfntfe6Mqkt?=
 =?us-ascii?Q?K0jduXZ6zKhOZxKrSB88sZpaDl0xDASpfrStvRpH8B2SzT9unGt2qw5l/j9j?=
 =?us-ascii?Q?HfX/hUmji0bbafvk57Kr3dQAa6MyKxkDxr1NAn0v8FJ5h/W2XZojx5ipJaAp?=
 =?us-ascii?Q?nD89mQGySI+ayfxf9ZvDHfMJA2Fxc9sF2PsQGqjQgPaG/9+7xnNFy1KgeEHO?=
 =?us-ascii?Q?rf0wRQnhx7scK2ClHOBDjFUesaHV+YHHgtJurGVjYPJ0uzHEbnxZpUCdBL/R?=
 =?us-ascii?Q?zUo7+QDl8TlNtWxio+XCyVDwnnoe5pWRUSzCTCMk1xcI6A1sOGCCd34BSLK7?=
 =?us-ascii?Q?WXJ/C09d6Qv03eeY08WHXIObsv2Ac4cBSnn0QBUzlnnDbxshNoL8yq6hF6ka?=
 =?us-ascii?Q?Rn1Emsx2/89o5xoAb7A1qTM3Hhp469RiSanv6aKWohhnXp5/dBk6yp1+rYeY?=
 =?us-ascii?Q?QEjKbEWULJTABjkUfyNDExaILZysqK4m4uG3wR8ADhglD1zZywtu3i9ngcZk?=
 =?us-ascii?Q?AhXIomnWv/sMOgBqrtHq9JtVz9fc+ITkg8dcNIjiC7bX9BkJjjb+3ZKp9O2N?=
 =?us-ascii?Q?umCG9tqIRULHaDJ92UlEVrERP3ppxlNqeW6M0w6xEEZhcl1a/EqQiLm3NNek?=
 =?us-ascii?Q?I6sfGJ6p/5fpZC4m4h3Rsb1np7yTxWif2GS2AfcNWS69kPpek/udYqH8ACdA?=
 =?us-ascii?Q?g/DlxAEYAiq2FH0iKS1e+UqctlfgfgnVgp97MdKi73On1DUxM2COa0tLiA4y?=
 =?us-ascii?Q?H4ZqNA60QLg+BS6hOi2E0BinzMBE94YzBJHzEs4btLyRBLjyaldOjfHKnyKn?=
 =?us-ascii?Q?MnV/fO3iaaD3+DaOBaXuT94VFhvOz7clu3R97tESifQWEyRviiEqGLrqhLo3?=
 =?us-ascii?Q?8EMEUNr338Wy59NUmf2dvbl6lsOGqYWe2D4P31LKEIuzN+/V/nDav2euA3LQ?=
 =?us-ascii?Q?PgU25j97Q0KFNfv6DfXO1S/uA3jQJ0tr19wSzKIXaNsJr4pk00cPpx13PZjC?=
 =?us-ascii?Q?msEp0aFUwDKaVoc5O+qM7SJu?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5597d2-4f7d-4214-9c25-08d961f658d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 03:14:52.9253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iXCXJ0wm9m5Ol72kZXRekWKD4GM7VN4XrWA3G6JFyH0A0pbZwPHeIN9elW6YB2V3IhJfQ64F+CDO4ACvEs/oUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5419
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, August 17, 2021 2:24 AM
> 
> On Mon, Aug 09, 2021 at 09:51:49AM +0000, Parav Pandit wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Monday, August 9, 2021 3:10 PM
> > >
> > > On Fri, Aug 06, 2021 at 08:55:56AM +0000, Parav Pandit wrote:
> > > >
> > > >
> > > > >
> > > > > The point is to try and not reinvent a dedicated vpda interface
> > > > > where a generic one exits.
> > > > > E.g. for phy things such as mac speed etc, I think most people
> > > > > are using ethtool things right?
> > > >
> > > > As you know vdpa is the backend device for the front-end netdevice
> > > accessed by the ethtool.
> > > > vdpa management tool here is composing the vdpa device.
> > > >
> > > > For example creator (hypervisor) of the vdpa devices knows that a
> > > > guest VM is given 4 vcpus, So hypervisor creates a vdpa devices
> > > > with config space layout as, max_virtqueue_pairs = 4.
> > > > And the MAC address chosen by hypervisor in mac[6].
> > > >
> > > > Guest VM ethtool can still chose to use less number of channels.
> > > >
> > > > Typically,
> > > > ethtool is for guest VM.
> > > > vdpa device is in hypevisor.
> > > >
> > > > How can hypervisor compose a vdpa device without any tool?
> > > > How can it tell ethtool, what is supported and what are the defaults?
> > > >
> > > > I must be misunderstanding your comment about ethtool.
> > > > Can you please explain?
> > >
> > >
> > > I am basically saying that we probably want to be able to change MAC
> > > of a VDPA device on the host without desroying and recreating the
> > > device as long as it's not in use.
> > Ok. I understood your comment now.
> > Yes, this was the objective which is why they are present as independent
> config knob.
> > Jason was suggesting to have them as creation only knobs, which requires
> recreate.
> >
> > I don't have strong opinion for either method.
> >
> > Passing them at creation time is simpler for user.
> > If user needs the ability to modify and reuse same device with different
> config, extending such support in future like this patch should possible.
> >
> > So there are two questions to close.
> > 1. Can we start with config params at vdpa device creation time?
> 
> I'm not sure whether we need both but I'd like to see a full API and I think we
> all agree host wants ability to tweak mac after device creation even if guest is
> not allowed to change mac, right?
>
Yes.
$ vdpa dev add name foo mgmtdev pci/0000:03:00.0 mac 00:11:22:33:44:55 maxvqs 8 mtu 9000

Above API if we do at creation time. It is likely simpler for user to pass necessary params during creation time.
 
> > 2. Is it ok to have these config params as individual fields at netlink U->K
> UAPI level?
> > This is the method proposed in this patch series.
> > (Similar to incrementally growing vxlan ip link command).
> >
> > Or
> > They should be packed in a structure between U-> K and deal with
> typecasting based on size and more?
> > (Jason's input).
> 
> I'm inclined to say vxlan is closer to a model to follow.
Ok. thanks for the feedback. We are using the model close to vxlan.
Lets resolve should we have it at creation time, post creation or both?
(a) Creation time 
Pros: 
- simpler single api for user
- eliminates needs of inventing stats reset in future series
Cons:
- inability to reuse the device with different config
- This may not be of great advantage, and it is probably fine to have creation time params

(b) post creation time:
Pros:
- able to reuse the device with different config for say different VM.
- will require stats reset in future once stats are implemented
Cons:
- more commands for users to config a device, better to have the ability at create time.

> 
> --
> MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
