Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F63C04AAB
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 17:09:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6B0741B43;
	Thu, 21 Sep 2023 17:09:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6B0741B43
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g/CPQ13r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wSOFvUgoeYjI; Thu, 21 Sep 2023 17:09:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EB30C41A60;
	Thu, 21 Sep 2023 17:09:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB30C41A60
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0EB9C0039;
	Thu, 21 Sep 2023 17:09:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D95AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 474C06102E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:09:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 474C06102E
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=g/CPQ13r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xkHYdAF8cDpa
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:09:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::623])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8AAFD60F9F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:09:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8AAFD60F9F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ve1BahMOTIKlXQbNRxI/PiqDnN1bDV/eK97ZRocnwWydUWQe59NSUkkBY2VIyl7uxkXLBG+o81bjpS6I2UzFwD3K0aU6rm32Pgn+KYc5zLVOwDrDyYjksQWWJVg8t5LTpBBVuw6sXEwZ6u6Y8xSgzTNIcfdvTViw+egWFO/oXkWDWKSI9GFTWYvkdaoKPabOw0TgV6wLjPAZ1llOxSkYjuxeSIXqSMA9A/zBZPyubzWCwGm6dh9BmTLLtrFQFMpYngWFXfxffRZlki1rFYEGVEG82cDVwBHaTCENLlBDwRGnc3/0HeeHMufkYkU9K/cBK/YQ8A1L1ISkGxFOXlip+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hspoE7rP7AWqQkP3u32lWkBYABu7ccTe9qqFJjG7sYk=;
 b=QDAKZeWkPD1ZB4yZKM87WEMuKbTwxULgYMGrLWGjfPXCoPLn589WCciliFPxvfYZ1DWzB53n7f02UXfM2zYvDa0CYbusiLTQH6HM2b6f1540pnv4QEazCWAGGhwh51ZReqrrmcyLBrTvxCAlNClu3GkJ9DLsRp/1pxzU/c6ihO2WfMCCt46q1ZdnQLYof0k/RoG5lhFy9enHujPFY82c5ZCy23lZ8MHj4yFVNpaS9nTgJkOZeZj8kBJRG6J7v88DkZMeiVN3mVxs+rS52i+NxgKKwAeSAJZGRdcGLa6/UImc3endoI2pew61fU6RkJL3G7QpIQhKyBOSHjaW4GwJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hspoE7rP7AWqQkP3u32lWkBYABu7ccTe9qqFJjG7sYk=;
 b=g/CPQ13rqRAGrdZC6poYkyDfG5qC1MCjeIRVvMenNR7TqvAF4IrlXQHkm67X4u+t1xrLnFw/10bgG6mCEOfhaQzas1p+S4Mx0ELpdNHFxL/tcg4Zp/A4ykXIN7FK62R0lwEu9zpbisrRoX+UhxVNRRytwM/6rnBi5PSTX8P9/bCO8NA8bkOue1yAQs6yfdtMixTGkWUA0iRij6ClXoQjLKbbsjgXHrw8VTuRZbfbAt4NcWbdBwcIm6nC7xQsR/hbdiApftCyEYp+nONnIOxqvon3pIPlmKT+X0oRLXmhrMFmtGNA3kbT91l893vBUvij/OO8tK7+TnuU7OtX6hj4qw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 17:09:04 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199%7]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 17:09:04 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Thread-Topic: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Thread-Index: AQHZ7IkPl5ENqOgMC0yEzkOHANq/CLAlfIYAgAACZQCAAAJ1AIAAAZQA
Date: Thu, 21 Sep 2023 17:09:04 +0000
Message-ID: <PH0PR12MB54813216D57AD82FAC0C10A7DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921104350.6bb003ff.alex.williamson@redhat.com>
 <20230921165224.GR13733@nvidia.com>
 <20230921125348-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230921125348-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA0PR12MB8864:EE_
x-ms-office365-filtering-correlation-id: d1b7a345-d082-4655-8789-08dbbac57556
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wJh3XaB5aYqJVgqyaRZxn7o5F42pRoCwC2iIOsBOgcF/Y0YCp/BsLvv6vz1yKlPj6GuMwp0RE6gS/vRg5HGOPniRCQULdviFBbl8hULy8twk/1E1yuMqh3ae4o1vP01orGXpcT5IuC4L6/Y4YN/ocSnt6fMvU2eiE6zpEapXoSg7VjjQlTnXheGBxPizns9euexh8LNgYmDI4pvS4arxc+ZVSFMIqF/JxvkGA+3Mwj/KbXRWV1fPc8TT9/l2p3sUZzUWF8UyFqIf2OXMHOY+EQN300JKlcVDx25EpKpw9eB5/pa9Pf385EsUNanRqxMSs0LsnqdnpyVcpc/PJY+P8UkssEYkKaIQxRMDN6Q+F0iFLW3tshehWEwmYl3MbRMBF/YVthdo/2ESK2F1mmFTbT+m3y6CmZztrdTzfkWvQOyjztd2wfKPE1RHKEfmUs/3Yp1gPS5reNVMiUoH3cDV8VvbStYeJXTU54zKl0j+kR0kIENnLyFUMt8nWfwS7trBCROF4FxGyHduJEtWHlp/5FB/jZAIejgd9ez0kI8mGtQKA8DIetkk8aHe1eSiqZT/WJLtCTTzNoBuAKIBl6n29kPbTAlSunbgcjFgUhzE36rCr/3rNibB1IjEKbi/O7Mj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(1800799009)(451199024)(186009)(2906002)(38070700005)(4744005)(38100700002)(83380400001)(9686003)(107886003)(86362001)(33656002)(7696005)(71200400001)(6506007)(478600001)(26005)(55016003)(8676002)(4326008)(8936002)(41300700001)(64756008)(52536014)(5660300002)(122000001)(316002)(6636002)(66556008)(110136005)(66446008)(66476007)(76116006)(66946007)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DyqO4xsH1/MZ50LmJlzDVHUXHmvBd8tJqWlAtugen2Cl76eGUSB4B9qQiyql?=
 =?us-ascii?Q?NV7VxqLb5Z6qboKW70es8LIU4nZRouGpdgU/jWZxeX0eJJhIWxIMu85SJMMw?=
 =?us-ascii?Q?Ph4OqegK1ecLNkhM7Bchgygv789g1jz1z3ZDVEw2TJABA+HTtqIhTSKl+JqZ?=
 =?us-ascii?Q?WC1x0ZysEdMbkECtvNfiSIRs5lYcFFKYYE5kBOvswSc6NZoXs2Y+DaOqJNll?=
 =?us-ascii?Q?l0XG5BvzXm3ciozB3WdBBTDolONkHsYpS2WntPfv4D7s9cBiKwUEqPgOt3R3?=
 =?us-ascii?Q?jJX0DC7f9e0J0iKnSX8ZKnbJlyS61d8ZkUw/AmvfGclhW9d0qcfiIBVUb6v2?=
 =?us-ascii?Q?AdUbv5J198IgWG0mspMhGS+oPuoijYuLYPokQ8pby5ZP+9a3AAFxgJbuQk+U?=
 =?us-ascii?Q?cWeR4rxNd28beg8Hl9x4ngDs7IGmjaslNnIv3/X7wF+87P6/+M27MY+c4L42?=
 =?us-ascii?Q?vePRyHYA87VYJXEvlWgud8PnybJFwIpCx6ww81X3k6xcjoMCLC0aZsHRnQF3?=
 =?us-ascii?Q?vdnHOB7ayEhl+5ub3nEyqVLFnrz2gpWRgl6A5PSrRvY5FK3ljHlVCQud2ZH6?=
 =?us-ascii?Q?elI0dVJg+KJkoZns/a8yqKqte+pigX0dnVVmergAyBUcWXMS3SAwqU1u5N48?=
 =?us-ascii?Q?acCHj2CconDJEqoaFCHLpz2IrxmE14XINAU9j48GbPWtuL3nainbkRDFnoIE?=
 =?us-ascii?Q?OTnN0CYWs0rmDGNtIh47+Xw3Xe3AcxW3W1HQHAy5kntiOfssp5oR4WGBowrk?=
 =?us-ascii?Q?hYS42dm8FwlfCAv74i62ZRLhNBm7uchYhILGXZZb+9f3nnMTDLul7lTq38CW?=
 =?us-ascii?Q?XDb+JPxpRHdz1liFn2jzhUI5yqQmprqMkXcOBhGIYp0/seVHkbTs/rPvu7jU?=
 =?us-ascii?Q?LSwRYJW/eQPi5chvBPvGKMiw+WR2RpqV4KfRSOAOh0bMk3HIfSEqJJjRLSqB?=
 =?us-ascii?Q?k1TJWgO4ltPdMnhNg3Hkq31p4tIYDz2I9H6+YLHlj+GVXi73nrIDiAP79bko?=
 =?us-ascii?Q?NKNCceafcsBdujVruFxMU7GbnDsWglZCZjAC0KSuwGcDRsHb4HU2q1IH3yZl?=
 =?us-ascii?Q?gbOCvYdfaRkFQLi/mH6zIIFh7s/D5CLqzMNI0B6Fig065TuI0dIyjrKEhjjU?=
 =?us-ascii?Q?MLD0jnjCZYmeIK9ZlkH1jhPk5O/WSdbfRa8vr+97tmzpCEBnSvGoq1NcB7fD?=
 =?us-ascii?Q?9/mIaRGnI3WI3sKiM43g0zU8y2hK8jqqG+soXRFUoG95oFupYv6OoI380qfL?=
 =?us-ascii?Q?9C/1kfzT+BLGOTqH972VgDfUcmwaFa5fzBnOSHm+GafgxJ1pu7bCGKf1ZSda?=
 =?us-ascii?Q?y9EGkJJgjx33CbIs4J5V6gS7D9zc0GG1ZVxVPLoCzJrraRwneeC9ucUbKfzw?=
 =?us-ascii?Q?Zq5pI6J1qOYuZWng4hkhfQgnL3mmB1cGGTgJ3LxeqrblUpPqStlE7A89Eb1X?=
 =?us-ascii?Q?z2CcJxp+N5AEMnZppc1gfYRoUy6lAAdNMmxg6fgAiCgbLD/B/rCJfrgGWSCi?=
 =?us-ascii?Q?NYC9KD9k3p+iL2vuZjAGJnZ2ju1OmXWan4BwdV0elfP+r0Jdd1vs8ieOnlcu?=
 =?us-ascii?Q?5WgLZs2YvAVOaXmSV6A=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b7a345-d082-4655-8789-08dbbac57556
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 17:09:04.2436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dl3pQ5NS1YElZoKyTLm/7Nux2Wzm/dL9xbYSSeKnPjOpz+kCK3fbu7jYK2zqKxC9meLO7871fZ8KE2usIA6Tow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jiri Pirko <jiri@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
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
> Sent: Thursday, September 21, 2023 10:31 PM

> Another question I'm interested in is whether there's actually a performance
> benefit to using this as compared to just software vhost. I note there's a VM exit
> on each IO access, so ... perhaps?
> Would be nice to see some numbers.

Packet rate and bandwidth are close are only 10% lower than modern device due to the batching of driver notification.
Bw tested with iperf with one and multiple queues. 
Packet rate tested with testpmd.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
