Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED659ECAAA6
	for <virtualization@archiver.kernel.org>; Fri, 26 Aug 2022 16:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 787D783F8A;
	Fri, 26 Aug 2022 16:41:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 787D783F8A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XiMuY5MC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m7ujxEmyBmJP; Fri, 26 Aug 2022 16:41:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 10DC583F86;
	Fri, 26 Aug 2022 16:41:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 10DC583F86
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB3BEC0033;
	Fri, 26 Aug 2022 16:41:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EA4AC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Aug 2022 16:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA9ED403F9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Aug 2022 16:41:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA9ED403F9
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=XiMuY5MC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WfysUEikyufP
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Aug 2022 16:41:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65FD0400BB
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2068.outbound.protection.outlook.com [40.107.212.68])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 65FD0400BB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Aug 2022 16:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnO1a6poO3MLT+7dFGxmGCfx9CmhAbHGIfI26YoTg646l+OfMWEYzTqQwaiFQaN1ldDLiSTWwCEcp+fd2FKA8P7eeDRYenPbX2kWXsQjqPLtErjvd17btROMDeJrlEQlsrtisCnUgwP4g5irYitCjDIIaTNW4TcorK9mAhmRUrnRKmcGhxQ5ZX6LMbCIn7I05V1/1UVNfoD6PjUzgFtoJuoAzr7gAuEGPAUb04KWn8WZ1kV7FRJFaPzMyUkQGRAVh6gU5zoy+G7iaPkdtWoT8ZOiKgLX9AY5Z1gXMRQexDrD4qzmPpULs2prvvkyqUnWq2c8/HX3JHPPSDAa+z9h5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaE9PF8KLY/xsf0RS0KH8IxAh+6mV5nq7it517NM44Y=;
 b=gOhvShg1xe6GMalfQuW0Kw9mHTC62K3IyHfETkbLbR9WXiAf34QUt4/x1RRk/d7JmaD1i9ML5hKvqq0gvypqkpnv0n9mVHNbP3r/ZvIEVdGMLUJSVw1UuVZrqPdGeSTKaZeHHq1pggRqOHKqMd/2KiLNgTK0ilcoqzslo85vjrUICs+KTMlESAQN2SGxMCj19SHHIwG8WzVwQUZ6gb+QP64DobSkvfRgWkKa0AYn8+JHZd7Q/MtUVcHxZ/46xy8TNuAJfTUHCmZvrysKq2L3UR3ebE2GN00u8XX/I4a3L6EFHjGkXvYV4zUqwFIqRSu7sbNnmHmRgs0hQqYlzLoShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaE9PF8KLY/xsf0RS0KH8IxAh+6mV5nq7it517NM44Y=;
 b=XiMuY5MCEOgrot53SoWHqvhaNejFOMFlZNgS+2cQuXIuIpf7+naNOFI/RBDwAE84AGrtHhsGzVSWqHnkPgPdkXtqEnvKsUZvC4K6+gcoEdHJSa1pIal6cl6aJqKN4IDoni2HGajsY6hFmcXd2ZamzE4l/C/WvIVm3RDCWeqc3/krWmDfRhirtsm5Q7BsHBUCuk01phSpvJMfDs90Gpc8ZtMXc3aT2ISl0RzrMYRAOnCdmCqi2/sZk0bJY/WNq7QuvY99C/BVhSX/EoLnACx6pHxDD3KLv0A2sV112bFnen05ItMUdC9ibVSWOXSuH06Vt5e0yugiMAlNuu7dCX1eEg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 16:41:16 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98%7]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 16:41:16 +0000
To: Si-Wei Liu <si-wei.liu@oracle.com>, Gavin Li <gavinl@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "jesse.brandeburg@intel.com"
 <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com"
 <alexander.h.duyck@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "loseweigh@gmail.com"
 <loseweigh@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "mst@redhat.com" <mst@redhat.com>
Subject: RE: [virtio-dev] [PATCH RESEND v2 2/2] virtio-net: use mtu size as
 buffer length for big packets
Thread-Topic: [virtio-dev] [PATCH RESEND v2 2/2] virtio-net: use mtu size as
 buffer length for big packets
Thread-Index: AQHYuH+wBUa5TQ3am0iRtxWTyhCUA63A4UyAgACAwLA=
Date: Fri, 26 Aug 2022 16:41:16 +0000
Message-ID: <PH0PR12MB5481BB5F85A7115A07FBC315DC759@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220825123840.20239-1-gavinl@nvidia.com>
 <20220825123840.20239-3-gavinl@nvidia.com>
 <27204c1c-1767-c968-0481-c052370875d8@oracle.com>
In-Reply-To: <27204c1c-1767-c968-0481-c052370875d8@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 669fd72e-f896-46f2-599c-08da8781cba1
x-ms-traffictypediagnostic: IA1PR12MB6137:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yxAox5ul7t12rnh0rrFu3ihxj9RFq+FBfn6Mtvfus/TauvWCtLbUhdjb/A9Dd0Q4lnL0S2o1gjsokJczqg/ZOCg3zcS9MbcJ5d29YcVPLinXrppc8lIelohy2+UsERbe9XzKZifcP+P+LZrGELdsJ5cQFhKBCB6Ly14pq570JvIm71b4lF4gZgHGSlKr6zoBv41aL49Dnm/iJNhlyxFiI04+6GcjyG44/y15UOqBSnjnsOPXnEfKsY0yBB/Tt8/CEbyJQBLwMzyZS5x8boIHfTa8x1dfZ2SIDvdajQqB4pK0vePUBfPqiSAPns/FukAKM+r0deVGS3T9BWxitUU9Hy6w4P4V4eNFzwmlB1gxujGWjN7ZJkaviXx4c/05AHLPlWz7bpX1Aqnq7UWmn0Zu/Mi6GUx1h929aUJVnPA2ex/9aKwzPgO/4pW13Cg/kZqiaiLNpjqGXkWtf2YaqaUc3LUXEIuZKIvRSRi++BxdyRWPatSnlkAApyCvE9clffDLBwaGr/EnaTeQuvuYoYo5DU4tU5LynVvyReN6qA7kuYpIKlRVwEr/JTnULwOMN2bxK/qVSMfjHUMfn/3j21FpR2JcWaOKL3vQIewiZvZWOnsvBCgimMKZiLU2MEAzWoEyCf8yJE1zIR/GuG9E4oT0t1AFnbAMEjCIu+xygSVaapz+zvS+JNcB6g7r7ow60gI98GjbJELvn0yreOS2fISwhsBL+sezpqmjfemosDVKHIhqRLoVt6oX2XeDyYuvp2iyLv2SrGqGSRtxH6CWCi8+CvO7U5SY+LdcoM0IWU9scJc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(4326008)(52536014)(316002)(8676002)(66946007)(64756008)(122000001)(110136005)(8936002)(66446008)(66556008)(55016003)(38100700002)(41300700001)(76116006)(71200400001)(5660300002)(478600001)(7416002)(66476007)(107886003)(26005)(7696005)(2906002)(186003)(6506007)(33656002)(83380400001)(86362001)(921005)(38070700005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TERzVm10OGtxa2FVMW1oRnJYS3g2WkM5MkIyY0E4cVJ4ZXk2V3NaZ1RWU2oy?=
 =?utf-8?B?OFR1bXNub3dTeTRKV3FRMGQrbGRURFV4YWh2VHVCb3RRMFh3T1dUelZkeWJN?=
 =?utf-8?B?UjJya0RhdEt2MTB4S0krSVY4WiszZkRjaEtGRUVnbjVCWmFIemszQkNlUzVZ?=
 =?utf-8?B?YUMrYzV2NXc3dDZ6RzhpUmVsSlZRcTZiZFZqUjEvcUFMd29JSUZSd1BNQUdp?=
 =?utf-8?B?M210TGZsNElSdVhydzYrQmlOUUtwdzNUZ201bHoyMXRQRnFJZlEyRm1BYk9R?=
 =?utf-8?B?VS9wZmN1NzUyd2lvVHZhRUZBOG9kNlRqT0czckNQVk0xQmNNYjR0aEVxVEZ1?=
 =?utf-8?B?ZmlMc04xSWlMWHowc3IvaHM1cjdYVkZnRkVZeWJSYkhiZVp4WDdzYnI5MnVP?=
 =?utf-8?B?djdheHRuYzNJNXZNY2E1b3ZsbGRwaEg5VjN6N3NvT1E3bFczZ3pqejFoWUty?=
 =?utf-8?B?cXkrQzV0cFlPc3dmN2tZRjhXbVpRWCtadVJveTJuOUQzN0tuVUcrUnl6TDNv?=
 =?utf-8?B?cmtkOVNwZjJReElKaE5SMjdyc2pQUWhxeWJHKzRmWklXYXVXa2w5cDNCZnkw?=
 =?utf-8?B?SWNJWmJPaGU5R2JmeEw2cGg5TTJTYmh2S2JuNXV5N2kybFB3bHpZQlF2WkZj?=
 =?utf-8?B?TDBNaEYyamtsaWsvcWRQQTRXSmgxSTRVNUpEYjM1NTljY1BtMU80OWl0L0lp?=
 =?utf-8?B?VjFFR0VJR3hTSnNwUG01OXZaWVRJVGtSMnBFN3BJREl5YVVZUDJEdEtGWDR3?=
 =?utf-8?B?QlJaVkNRMDVvNUJndCtrb1JJK25jeXBoOU9Bd0J1WGZpZElZMzNXM1RsNHcv?=
 =?utf-8?B?VSt6SnpwUGpTUWtYRHlaME1pam9ER0MvQkp1OWJ1WG10NUVTMVkrTEpqQTN5?=
 =?utf-8?B?a09TcDVXd1BIVk45WmtHa3FIOVFLWk5mcUd5anN6eFR3aGxZRkNQay8xY0xq?=
 =?utf-8?B?SGd3ZG56SHpFVkRaS1JLelFtUTFwSll5ZWtFZkhTOTh4WVluS2ZwNllQNURr?=
 =?utf-8?B?R3J6RjdRcFJqMmF0NFRzNGUveUNJL1ZWVGZtQ2dnYi9MV2ZYbWlIcVg5T3lv?=
 =?utf-8?B?dGl3c0dwZFNpQS9QOUpkNkFtSFlYR3QrMldiNS9GTkZsY3F0bXBuN0RhUDY3?=
 =?utf-8?B?cUhCNS9rN0dVNEhKYWE2RXNaWGZuYkNRc3BFV3M5K2tBaTZwUlJvRUZiSlJP?=
 =?utf-8?B?ZkQxbzlPR040a3JoUFAyYWNzaE5wUVdHdWRJR2hmSmRlOXdqS0xVei91RkhN?=
 =?utf-8?B?WmVGdzdWb0h4aFl0TW5EWFFSWGVBemVSZXRIUGFIRkcyRW9XUlJqdTRpcjl1?=
 =?utf-8?B?ejBRZXNMTGZVd2h6dUI0dG9peVpod3Z3ZldpZi9ZZTNGT3RPNk9NdU9tVGt3?=
 =?utf-8?B?Z011emhUT2Mzem1XdkcvUGtZeFgvaEhCb2UxWG9LRDc1eXk0cnpqSE9CZzZU?=
 =?utf-8?B?RnhkTVlHaXdET3JIM1Vna0o2bHVGWXpsMkZtUlVTRG1OV3Nad3UvZVBOd2Q2?=
 =?utf-8?B?MGs5M29wVGtWZ3ZxZXZicnpzNXMyRWN0M2NHVi9Ld3J5U282M2xNVkdMS3py?=
 =?utf-8?B?ZFJGQnpvVzl6TXB1UWg2c1RuTUh5Wm8zdlNlVnlqMXh6MlR1SlZzQjlrL0dE?=
 =?utf-8?B?ang0NmRJQ2ltS2R3aEdPM3hJb2hsQVlPTHhldU1xMngxR1NLV0FQU3NDWkoz?=
 =?utf-8?B?MThqR2pBYmJ6RjdSeFVLc1UrOXdQYXRIOWg4N0dLcWVCNmo5Y2ZlcVlVd0FR?=
 =?utf-8?B?YlJTZnJqUGN2ZGx1RyttWWVnWG15UVVVWFBlL2dMWUpkdUpYa1E4VUZjSThR?=
 =?utf-8?B?SnZEc21Wb1pxamx0YXcyVktrMTZIclhqRmJ4N0dqeGl4RWh1MXBCYVEydnhr?=
 =?utf-8?B?cnQvb3YzU2dVZW1LVjhHeEdOU1lVQTdBanE4cjkwWmMyVEpxWk4yUHlYRDc4?=
 =?utf-8?B?TlVMYnpRUExKOEtWZmpmYi9WL2pJVTlybWNJKzdsT2VNYTkzNGxER09lWDV2?=
 =?utf-8?B?V29XVzRTY0V1S2I1cjRnVURkRnhCVGwySkVNVVpreTkwZEF5N3hpTkpzQjU3?=
 =?utf-8?B?RDRZZW9Ma2RJOHg4UU81enlZOFFzZmRHM2JmRlZsTTZES2pSUlFhVFRFT2xC?=
 =?utf-8?Q?6QYI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669fd72e-f896-46f2-599c-08da8781cba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 16:41:16.2914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/HdEY2aoZmO/MvUzwCBlSh49uI5agauP18IpdZ40GLVez5u9q6jklNrbkby4kvN3ApKHgnFtPo2MSZsBIO/7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6137
Cc: Gavi Teitz <gavi@nvidia.com>
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

	

From: Si-Wei Liu <si-wei.liu@oracle.com> 
Sent: Friday, August 26, 2022 4:52 AM

> Sorry for the delay. Didn't notice as this thread was not addressed to my work email. Please copy to my work email if it needs my immediate attention.

Can you please setup your mail client to post plain text mail as required by mailing list.
Conversation without it is close to impossible to track.
+	/* If we can receive ANY GSO packets, we must allocate large ones. */
+	if (mtu > ETH_DATA_LEN || guest_gso) {
+		vi->big_packets = true;
+		/* if the guest offload is offered by the device, user can modify
+		 * offload capability. In such posted buffers may short fall of size.
+		 * Hence allocate for max size.
+		 */
+		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
+			vi->big_packets_sg_num = MAX_SKB_FRAGS;
> MAX_SKB_FRAGS is needed when any of the guest_gso capability is offered. This is per spec regardless if VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is negotiated or not. Quoting spec:


> If VIRTIO_NET_F_MRG_RXBUF is not negotiated: 
> If VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6 or VIRTIO_NET_F_GUEST_UFO are negotiated, the driver SHOULD populate the receive queue(s) with buffers of at least 65562 bytes.

Spec recommendation is good here, but Linux driver knows that such offload settings cannot change if the above feature is not offered.
So I think we should add the comment and reference to the code to have this optimization.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
