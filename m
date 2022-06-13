Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8FFC43334
	for <virtualization@archiver.kernel.org>; Mon, 13 Jun 2022 20:31:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9AFD81AD1;
	Mon, 13 Jun 2022 20:31:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qIggQqVN2wdg; Mon, 13 Jun 2022 20:31:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6C40F81A92;
	Mon, 13 Jun 2022 20:31:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46672C0032;
	Mon, 13 Jun 2022 20:31:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F632C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 20:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D86E60DB2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 20:31:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FdzVzelOfOaq
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 20:31:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D9DD60A94
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 20:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heAAikv+tFdAiAcoNcc8VJ80PHXwIln2oi5i9TMVWIuv+0yWsMJCDnaEOSQNp5wqhzZRdu7g7hZIo1pp9RRXcqMV5ByoRWoesJgBqWUEpddab74iDHfMy587HPtnL6NiR4ng/lOE7ABzX9Sxl2DaKRBEZr7Bq1EgYgSkcV5OVwEOvGLU0OEUEIsj42Micp7T2DXANcrkUr2HNc6SCU+ldwDU/5UOH6ie5i494zBOSJiluJen3EXw1qlvHuNZaE81/YpcjB2pCtIjCBiCNMKUByju40432Q1ubeKCtmZgdi4Trg4eKhcKwCW+yYhiWG9yj42TJZDVJLB4WMlKqdxVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJTF1Rbgt/zc15Q+TM79KmNMEg4ELiy50hb4+LcNuew=;
 b=Nz9QJ8mgjZ99z3IQTLc6R6klhJbZlAKUpmZTsPM+lA6E22XgBkVCxaaKG0m/LGe0+4wHfPPYlUwVIq0MtOCK2kySNfTbw/XXidx054xl1r1BDCuhL6ko3IvWPcjY3ucE2f0STIzspQyzCDYw5x8umwsC8T7sQpe7W1oKSG+XEiUURv6TGe8LIUzG5O0TaSxNMpWPP0lop/lmFV0ASkFc9y6l9A3YAe3KmROo4V7oAYP3/udRMbtVNT4ltrk3BOnvOoxp4N364FdZ5nLl8JhI/NMjSZnZfEjcIpHrMHHpVWALCQ+fvP/88J+s81bPvaqQFG1jWfFynHYUypVI381lAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJTF1Rbgt/zc15Q+TM79KmNMEg4ELiy50hb4+LcNuew=;
 b=URJ/1Ru8xOEgw9PbBy6gHPt7cDJFZf9Z/LresNa/VP9aU5YjpNVFO0ncviclVtmQC4Gi1xRT82De/r02avh05DoyCc6Vv/XkySz059CUINCKm3ObefBny3JrBR7TVIGwb8Dja8N8ceNGg09vMZ6o1Fy8/Ikg/g1dsPrX1lacpFeOJL+z5iAYBGvKy9QbZRuSqOfldytdosK5SQbqNPQJfSBZ6amM3lxKum4/3zyRfrzTYcIk81rwrVOlBmWU5Ueg9eRncP+np196jsc6YIck2eY6f8/agB5kd5c+b2lUqAYKs4vNPSuTpGagtV1cMtu5kzDPXb4qHKtYakbJRE5bBA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DM6PR12MB3771.namprd12.prod.outlook.com (2603:10b6:5:1ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Mon, 13 Jun
 2022 20:31:22 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::8c53:1666:6a81:943e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::8c53:1666:6a81:943e%3]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 20:31:22 +0000
To: Zhu Lingshan <lingshan.zhu@intel.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH V2 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Thread-Topic: [PATCH V2 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Thread-Index: AQHYfw/RDmT3L7mEX0yuURF2HTgWnq1NyqsQ
Date: Mon, 13 Jun 2022 20:31:22 +0000
Message-ID: <PH0PR12MB54816C51011A667F25C4FF7ADCAB9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220613101652.195216-1-lingshan.zhu@intel.com>
 <20220613101652.195216-5-lingshan.zhu@intel.com>
In-Reply-To: <20220613101652.195216-5-lingshan.zhu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9464155c-f387-4c27-bdd6-08da4d7bae64
x-ms-traffictypediagnostic: DM6PR12MB3771:EE_
x-microsoft-antispam-prvs: <DM6PR12MB377189FC6A88ABB76956AC51DCAB9@DM6PR12MB3771.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oCyccwn69F77CjXkPf9BABNWLtrsp5M0Imb4wNESFyKDsgVZYnbH+zBfz738rE6DPutm3yEaI8aDcBAxaZP0Ih4kgJvbjCa/A0uqPDnigG61tHsn6QArghx/wergSR+rikENBdcYGUEalxJJPl4n1qMXwV8gDXlC+oqlTVz6Z9Kk1bKIXb0nXjMagJWKx3c9h3aouhGUQJF36PlACE2l4a348z+QgdXqeYnaLndSGoqkEjvKYKCEG3VMno40f0/mAJqEIjHddJjExp373hieYSRANj3/qtt/gwuPTb2lCZZZfXM+d3fLVvIQO1Pva41amrmRFSU8ZA7oiTXSgtO7ScX22Ioz/GAaYWJrYYOGMV4ttdVqT2zVNyJbHmY31KqtB9IFIJvvC3iAvknTKpHpB/qzjPe4NxOtihmEIYrTERgo7T5OUJq0oytLOKRkVYLGFtV2O0iI2GkcV8WdIAW52QCtI0nXdud/zdvr+p9UEO8LaQms8In53V1AewFldFEyJSJS/5kE+r4AfX975LrxoD8kZPf6pC8CeK8Mm61OuPsDXiswAw5SbMXw9APN6SarysxkPB9qk7tw62RoLnwAfE8o6UbvB1M1xVLdksdTZzT7XGNl7vIU4dqy5lGq0fyDA9kIk1tdPD+5K5TrJsb57dJ6VKqqCv4efbPz0A58vIOX3qdf+NDAAmGhQjjgCRhTbhM8hkJE9bMc0MuSm20AhA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(54906003)(26005)(316002)(7696005)(71200400001)(5660300002)(6506007)(86362001)(38100700002)(66446008)(508600001)(55236004)(110136005)(33656002)(122000001)(9686003)(55016003)(83380400001)(186003)(4326008)(66556008)(76116006)(64756008)(38070700005)(8676002)(66476007)(52536014)(2906002)(66946007)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MFewK2zlKlgVTtmtiBaE7M2b28VzDuW9TLQ4IygDjM2rYZITUdP+rqXvOC3u?=
 =?us-ascii?Q?xPaIZUnTvFVNpwP5UUA0LdtCEBj5h5q1mDy1DsRfdYaixHBAwupjBUY5ssVL?=
 =?us-ascii?Q?zFub7yjXNgcyxEbg4eUioer6ypYcTFY7aslhwUNcXxt1jvQ30uIZSVr99CuQ?=
 =?us-ascii?Q?q2/dLDu7dDItVnuKepV8nwtgWrAdYtmJITayN2ZduInsso3dTLz/f7qB1Rrx?=
 =?us-ascii?Q?yw9RABnABR+pMzR3Ny9EEe9AsApH8AT9cQ5RfOzD6lGdAP+lzzJpai3mWmzM?=
 =?us-ascii?Q?sssAvl1ocC5XACAWWRaF3xDiGa+6Qt06TYe7Ayf1ZPeraihX4O+CrnWtlndm?=
 =?us-ascii?Q?nFLmX377DcXVho+K+VA1kMmpDO1oEDsQXXruOzUsZWlLqTK6NxQJ4SVUhDod?=
 =?us-ascii?Q?VdIly5K9mjXImMRCIAdNmLSHRjLL5bAlBJ5CED9VknTRqOABenWDvgPyXilO?=
 =?us-ascii?Q?9U+QmwRilogFhkagovwO704LIA0Ae2M0pB8VmfAntZU575j4QiKpiD06xeGq?=
 =?us-ascii?Q?cd+/nhcTBTPL4bqRUcT4qgYOj1ps9EzObiNRyODpMJzL8ZCoDCXp5OJ3XyqC?=
 =?us-ascii?Q?WlEHbbfNcWGP2P6gXkftBzglXOIoOB6BHADXh6+Zl9PTpUGzuOicohSbOWv3?=
 =?us-ascii?Q?Qd1lAdrkymUzSyqyg5lk7cA47/RxoNTpSUIuIHtV2ZoGzPMTBInxNeI/9eWJ?=
 =?us-ascii?Q?L7TjccS7ZEzxI9Moshl4WVjEW5XjrPiJ4b+XPbgLVZ/9Rv7FJTeJvWt6Oj6H?=
 =?us-ascii?Q?N+ApLtOajVHpX+dv9WaNDsFuRhmITq2c0ejcXd/X/cHsbngkIFEXRwCWymcO?=
 =?us-ascii?Q?IC2iV84ZcbDkjSIEnZwhGhfu2JJXAFMhalCIQVBbwos8ICrn/rpk9KLHWwEH?=
 =?us-ascii?Q?O0ENwP50cM+WdXyOmfWfrDA0RZkEfAty6XEDIrnfoMFqi4c+GHMSD/swrBW6?=
 =?us-ascii?Q?AqrtbKlmXNm7/K3GwQ4F/WjYIT7HqtXLd7wvS9PTcqVFzQRMJPMP9S8LWbFS?=
 =?us-ascii?Q?oMjNHz+ZL6hgluFFUOPeduqRckGi3m5z3xSVbBJ4TtIvUxrtZiaPSiHlJcFY?=
 =?us-ascii?Q?X7sEG51Tk0C2qoCPp/EzCm4lwqiazh9W67EN7jJ0OguFmjOVREKtFmAvzbEX?=
 =?us-ascii?Q?Mdp6LT0dG9lKPEE9JwPGbqY6mr59T6cW/wkE/IsnOGyaHGab19fPmy88xswf?=
 =?us-ascii?Q?2VeWj0ntttbBbbhSHeM8pRIEI2h8KYGKzJJt6CRn+VRoZ5gC65mEXiyIJv65?=
 =?us-ascii?Q?/zBM1UYAAfI4IogVgXPFGInvy4pzmXaoX2TWYSWv2nOnjqCJPHI6uHlGNMFb?=
 =?us-ascii?Q?QFFsayM4KpgvrBxqeXS7xv0zhp2y8fybFusc/I4q+duopR4beh5NW/R9PEhn?=
 =?us-ascii?Q?o9uXu1EIngU30Y/07+isuJQEeI76oI2mwNPNCic184F54Gi16Vz5Uj93SMRw?=
 =?us-ascii?Q?L3GzGgLDPCXki0VHWXYyvhF5gOeE8gEJ4BBRfBnYuGQirvV/o3Y7SzspNC+I?=
 =?us-ascii?Q?nnZfaH/RF30wAT1FZRswDB6g459OjwXz4XlGh+XuewRrSf8z0aOjW+ZAdx88?=
 =?us-ascii?Q?+iBSbpvWrqmllFnHd0Jjxm2Hova1pa+iXOXA6kiTEy04KKImd2/yFWxT9/Oi?=
 =?us-ascii?Q?PYndCngARgbvLvDvG3I0TLyWzaHYUCcZ7OuysIhWeHtlX7b+82vTJdwKRMx/?=
 =?us-ascii?Q?Rh/Qs7NdHzwaxM7ofBqffGPxyJGsrLzvrEHUnsGrs+OqlDY3OF7ib/3rA+RB?=
 =?us-ascii?Q?1dhzO2wWBw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9464155c-f387-4c27-bdd6-08da4d7bae64
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 20:31:22.7875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RLlgrpbF1fKga4n05gLlVdTyh4sznX0SqeK/Fw/juu9cadrvaltrm7jmefPfiSfPGvx7MpYYLxv4DEdGekKKXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3771
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: Zhu Lingshan <lingshan.zhu@intel.com>
> Sent: Monday, June 13, 2022 6:17 AM
> 
> Users may want to query the config space of a vDPA device, to choose a
> appropriate one for a certain guest. This means the users need to read the
> config space before FEATURES_OK, and the existence of config space
> contents does not depend on FEATURES_OK.
> 
> The spec says:
> The device MUST allow reading of any device-specific configuration field
> before FEATURES_OK is set by the driver. This includes fields which are
> conditional on feature bits, as long as those feature bits are offered by the
> device.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/vdpa.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> 9b0e39b2f022..d76b22b2f7ae 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -851,17 +851,9 @@ vdpa_dev_config_fill(struct vdpa_device *vdev,
> struct sk_buff *msg, u32 portid,  {
>  	u32 device_id;
>  	void *hdr;
> -	u8 status;
>  	int err;
> 
>  	down_read(&vdev->cf_lock);
> -	status = vdev->config->get_status(vdev);
> -	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
> -		NL_SET_ERR_MSG_MOD(extack, "Features negotiation not
> completed");
> -		err = -EAGAIN;
> -		goto out;
> -	}
> -
>  	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
>  			  VDPA_CMD_DEV_CONFIG_GET);
>  	if (!hdr) {
> --
> 2.31.1

Management interface should not mix up the device state machine checks like above.
Hence above code removal is better choice.
Please add fixes tag to this patch.

Reviewed-by: Parav Pandit <parav@nvidia.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
