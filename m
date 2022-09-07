Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF33C38145
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 14:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD4E760C2B;
	Wed,  7 Sep 2022 14:33:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD4E760C2B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EmyGIKaV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Woenf_HqtfB; Wed,  7 Sep 2022 14:33:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 50BB960C26;
	Wed,  7 Sep 2022 14:33:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 50BB960C26
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 289CCC0033;
	Wed,  7 Sep 2022 14:33:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A950C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:33:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ED01060C27
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:33:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED01060C27
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IO4ej8JTMbS1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:33:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8330D60C26
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8330D60C26
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:33:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S18v9kWz5e9qggNPGg/bvIKq0TQiOB/uo0UgiRJr050B78xx8HYXlvrnyFIAHggmHYsAOlYfe8o+M3maowVLFzGwzDtT+1RTMtYE3WkCKOTleVw5NvlvPEYlwmIObwAw7wtwolf4c4gIcZbj35Qz7EOPOALJ/hsZ+sqK9xk/Drf0bqPTiCCtcW51SSTUbNA2VZ3VcAPHG9aprIhC2BSaCxSegg4++9iWbpmTDybgdXU7XifAZxVHfXtiQqgit0kmtzRh2uK/8jzfPForjlgLCUrPR6PGz4id0K9xfmgfAeh1JxrwDXaLHWQGPFd+u41CH+xrbzrdPZTmFza3/r4T9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Rbp+Kc4k3KKzNoSNzLF6aqlXvjsuNAZ/HMOiWNITQ8=;
 b=Xgon0al5VTkDHlHboMO9qffl9p5P8x1w0WAYAH9Y4LAj7zptI3DxHdOMUkubSa/umbnLTQF8rs/BFqNEnzZ8e6gcQKc3KxJDg/YIrCeb7hrhgd9JpboWDMBU+HRqcDaFKnM9p1W6QhhlV7qoCh4QQNqB0BMCx2rMAORhU81MgyXk1QjEH/jqVEyZ2RjvQQy63+xkgfsQGQP/T1cVocz62Y1Wjbd/m/xpuYOgpPg2ZjGF95CQklUFTXkBMOReUBKcCnqYTX6SNolyUwdow29FlqcbZT+k4I0HHL0uWpwgkMyXrxfjclj+2nlDf9rmekt08aPNng8aDr+9cmhqvNxvhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Rbp+Kc4k3KKzNoSNzLF6aqlXvjsuNAZ/HMOiWNITQ8=;
 b=EmyGIKaVwrTuID5yphcoSV18lvnuRizVSl27xhXCqYFNqNnK0BPvdj852xOe4ii1r2qj8zB3ZC6YtPt90A33siZ37byUlvop9ELjSh2Swyr9Sj0pmynQcgy94/nQ8IVZQ0I6BZ+Swa1g7teVd7EtfMPUcV4Fa53Rg1qksMkD4pjrmfOUo2rZ99RG+bpKxp0Vru3Dzo31s+fyyfxoW7AnG1JnFYma/BI3vgWlJPnIH/0Y95lbQ9/R1im7F3bkd2yrNwKCV5paYyFF0Bzl3WFk0jwsYa0vLysEPGWmifZErXtOnsLE04s1CJ3MSy1HhkbeZpDJar4ey+n90CEnsDGylg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DM4PR12MB5279.namprd12.prod.outlook.com (2603:10b6:5:39f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 14:33:02 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98%9]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 14:33:02 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Thread-Topic: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Thread-Index: AQHYwpEbqLdY6RByfkyoSMo8wpA6EK3TsrMAgABG8oCAAA3LAIAAADnA
Date: Wed, 7 Sep 2022 14:33:02 +0000
Message-ID: <PH0PR12MB5481D19E1E5DA11B2BD067CFDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220901021038.84751-1-gavinl@nvidia.com>
 <20220901021038.84751-3-gavinl@nvidia.com>
 <20220907012608-mutt-send-email-mst@kernel.org>
 <0355d1e4-a3cf-5b16-8c7f-b39b1ec14ade@nvidia.com>
 <20220907052317-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812EC7F4711C1EA4CAA119DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907101335-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220907101335-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5279:EE_
x-ms-office365-filtering-correlation-id: ad5036fc-a6d0-4484-35c9-08da90ddde8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YHn012JIahBcunXq3BmO1O0Lilmjl9pOtu5sCaACJQgIIpIq9F26/ict6XwpOm10v4OH3k2TgQu52Lsn4E7GmLjajkJ0wq52MafzaKv7+0VNK3Rmytne9nogLHs9+/TkjBlBwJ5A12hF2jyyH2zVTDC/SEY/Thj+A6pXzZ8piJS8RVd33UaqxvdocB6zvDBN32gTq3lDZnvWcd/Ug14aKFl4Ml+irhwRZn0EiV+v38jdgLTpbtmwpd35cO0TMbMUBlO/AokO91bFhx853liZSf8I4+xafTqeb2FKOIVitybnu9rNJOJRYGWb1+JYoJDQ1RjpkgiOkz7QKRMnmpMVi8OJASQiIS7dxgC+BdykxIBKjUVZM21T2PJRXcGqC5U3gZ7mPFvpc/j/vwA8ZhWrialP8uvQsUTxIDgXk9O/40ZsI7nGmSVvjUUZcava0B3+bd89ufdEE7+0HKtWs4Xk/8mHZW5C+6K10w7OfnnHwydFOhysougkeKpcxCvospIwO5xY7RruWDnivyToyy32J96rTnTh6Ibs+ClIPGNrnOqvpaaFEThnunf52xRY5bIzu7ehgcJgkewMtH2jzCPIuRyHiYpwcM66lmtt7QjffziGHDlEIem0EokJRBlJ/WXEA7GhilQ3kvPf5qBsX3HxTdvnstdZtfC/3qbs2NAUswsocGh1BYVeOWcRXakCE6yFjnhcOqYdeLvUFVLE8pKfIHpa46o6AGJUO0zfIGFnIhuadfIz9vDX5uF2GXB+He3n3bvaDCf/mfIvDJMROLJOEg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(86362001)(186003)(55016003)(478600001)(41300700001)(26005)(9686003)(71200400001)(7696005)(38070700005)(6506007)(122000001)(38100700002)(83380400001)(316002)(5660300002)(66556008)(76116006)(66946007)(52536014)(8676002)(33656002)(2906002)(66446008)(64756008)(8936002)(7416002)(54906003)(4326008)(66476007)(6916009)(4744005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SzDlLt0y47SXdPRRDj2Z8s/2JyIIFdolM+Y+MmjsiPoXLJ8xd5IyhyUxhULo?=
 =?us-ascii?Q?2+1YIU+Fa8dZQR+c3y4+s3Ygy+WdJaIHuEs/KZwe+uat3pfCRlV4PrL/2bwY?=
 =?us-ascii?Q?9IHNmK988T3aYxk+yiXZDFzHwuNHMj/Kh+Y0B0Ixu9x+kbo1LTBQhkyIaykc?=
 =?us-ascii?Q?BiVcA+zySg5sZMCT4kLAbb8V7fN0cBbF7ug615ifq7BP++yYCfYAloQLGoAU?=
 =?us-ascii?Q?pomtWuA9hY7SBJEjiYUvke7aURCjvK8pL76eQAG4tT3rSQCu8qleuarRok1H?=
 =?us-ascii?Q?HNpc6XXu3U/qUKOv8axvna+kLD2WQRyYZz8v/8HEXyq60v73vnZdKcM8oLiq?=
 =?us-ascii?Q?Cz5fBwGMybPypGv9nR8R3K6qV9UWXa54iYkEFxvP6KkX6Y6mq3dFVt+O1zar?=
 =?us-ascii?Q?jukDz+g+UBAbnnuOxnSdPuo2ngBTQrQpa6ajzRr2pQgqvKNJUgnGonEUU6+2?=
 =?us-ascii?Q?LUqXCfwJGNslmWh68y0LXa86BiFEGw+T3TJ4dwWRzctDKWg902NGq/Knkv/G?=
 =?us-ascii?Q?WgpWve/s8qPSwZldBrkpmjCAqUEvKkv7MX6yD1P2nv0aou5deWJjmJ/xzQPb?=
 =?us-ascii?Q?qevoy2B4EBotmEU+f0bKEcToQcYAu+txZ0G6gc2LNaBAKqzrClmnT9qrSseB?=
 =?us-ascii?Q?UfY7GIcaJEn47llpFlcsPuIdK2k15zagTuEXAY9iiOG7mZVZJKw0sUSmTDQ9?=
 =?us-ascii?Q?nTBkMUMo4dGnMVlCHCmk4mMb+U2OoBFmst11m7c3mbpvotAWZHdd7ncGX+LM?=
 =?us-ascii?Q?qRaPWsnzmZI8fqYaNexkxO4Nt/bzX48ybxmTdH9/jQFbNsOfRdg7EyUg7hq/?=
 =?us-ascii?Q?JC/Eyd5SgFykJzqtnWJMiFgWtTDVoOMcwfO2qqWrwGCIrYb//bFCpIbedKXp?=
 =?us-ascii?Q?SCOLeqRfUG5iCAAg75R946TjYHR9eUNF6rlM5ccMihwHbO2SKBavvqtuz3HT?=
 =?us-ascii?Q?snrMXkFNZndAUWsW7MQ86JfjvM6kTCdHsafYusKEcBiBsY+9IxwUncTwucuB?=
 =?us-ascii?Q?1+sRdapN2xOuVxzZGgqlXCPlzvtupu19GMfY9qtiuvwWb5tc/9pZanYrVsJj?=
 =?us-ascii?Q?QETjiUUPYGFiHBdSTqYaI5nYOrmQEG7ZwA/Hepofll1sNr1CuAzwk2EvlAWb?=
 =?us-ascii?Q?Vq8kXAlG0eziFfHaLJKEbX4Tb9JJHGTp9LVLUdEpkd4PudMDiCv33VAqaDJQ?=
 =?us-ascii?Q?Xzj4c5kkjE0MFajG19EO3+p2psJMVLCAyoOWArEiyCxVkFmOeeXY8/UlGKQU?=
 =?us-ascii?Q?f/1zioEWxLoeDQCIsmKPXUSK2aOzGCUSFNWADMZJXuUXA7seu9ULNfU2dA8J?=
 =?us-ascii?Q?PWFLmc9QkC5XmXTiPVGszNyp1RnpyBNUluUCsbfh1rqLf35Z2nReY4LIkGKL?=
 =?us-ascii?Q?LzljBuf3Oec6XCTmQH2tV0T1cq5T/B7JGBEDZ5TK0qlcXYYqhW1lOuRcTjXM?=
 =?us-ascii?Q?ly7MMrY6blKfKKEwE6ev+SlrcTrFISVskZcVNqs+QyEhbBzNybFFwHDAzncZ?=
 =?us-ascii?Q?CTDfZQbobO/eZsqhsN3vbCF89n0id5EOv+W1Wffc5s4QW3bg4kEuEkF3m3vD?=
 =?us-ascii?Q?4ydPfmEkc2rVexjmo04=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5036fc-a6d0-4484-35c9-08da90ddde8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 14:33:02.1846 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCkhG0gttAA9/TOjKW/xq5F528p4wisqNAFfL6DJrMbFe5SGTu+QoGqwFtWqCLEqS4Hkd/7SLR33i29bW7yrEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5279
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, Gavin Li <gavinl@nvidia.com>
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
> Sent: Wednesday, September 7, 2022 10:30 AM

[..]
> > > actually how does this waste space? Is this because your device does
> > > not have INDIRECT?
> > VQ is 256 entries deep.
> > Driver posted total of 256 descriptors.
> > Each descriptor points to a page of 4K.
> > These descriptors are chained as 4K * 16.
> 
> So without indirect then? with indirect each descriptor can point to 16
> entries.
> 
With indirect, can it post 256 * 16 size buffers even though vq depth is 256 entries?
I recall that total number of descriptors with direct/indirect descriptors is limited to vq depth.
Was there some recent clarification occurred in the spec to clarify this?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
