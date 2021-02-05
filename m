Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AADAC433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 17:54:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA07964DEE
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 17:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA07964DEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4465485DDC;
	Fri,  5 Feb 2021 17:54:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4p8erZ8hdfjN; Fri,  5 Feb 2021 17:54:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AF6B585D6C;
	Fri,  5 Feb 2021 17:54:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98A80C08A1;
	Fri,  5 Feb 2021 17:54:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA609C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 17:54:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B39C9870FC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 17:54:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GaRrw9-v1yXV
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 17:54:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3D69486A16
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 17:54:30 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B601d86550005>; Fri, 05 Feb 2021 09:54:29 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 17:54:29 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 5 Feb 2021 17:54:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbT3kQ0wlYVRjgzYft6ue1DT6WaTlY8Gs/uoSX9i9saXWkFYf4rGu+cqn7KWcIhY8JJTzm88fon4/Sy5KN4vf6iNvDaWhgVCCPRrTWf6Sb4C9dBAZS+iX0KNNdIFJ69XZBkNinR/UmkOt9fsAa83F/FpxkfeaBw/A1KitruNPs3qpdYONM2nVyn9DnTtlVXzwX17UsVKQJhfoOFbCBciouddiBMpyjseBVjIH8bPdNhxD/8FhPD5GHv6C0F6KSofAbR272FqcE5EDJOoSMC0llvPSi4LTELUJBloDv/iAY6ybTUEhjGNXwf+yZiOlqZ4WrlBo8NB2zei/dlllCD9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b98JUQLjckr3Ao/hkdUeRRhITs6Ho0Yf+DGw/n0UAYY=;
 b=OwPlQIiE/ww9sqsKjOsusqh6On6wmIzc97i22FMtorFt5Fu2An2EEjUlCIYisOtGFI/SnQtg8h9bvgULqcAKUCKZlMc2uN9xvdrexJKyzi8pGs4KqKqud9GBwSx4CIfTdnSy88St4BZV8q1t9aw0GMDkl7UVTfxpSK0JMRYmQfpyWdl8557afRlwqNt44YnUarVxqmgo922Yu6IwteTVawKE38aW33PJfk5Izlj40imu3LbXFMhOc3Egl4+9vgil8AHND+karAOuHlDxh+ZZHTqiZ2IuiEEjDvsqoaJWisEnRr2J49p6+lbRfr0LjkMbMRJsyFH/VINyWrBBSNqDCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (52.135.54.148) by
 BYAPR12MB2997.namprd12.prod.outlook.com (20.178.54.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.20; Fri, 5 Feb 2021 17:54:28 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%3]) with mapi id 15.20.3805.033; Fri, 5 Feb 2021
 17:54:28 +0000
From: Parav Pandit <parav@nvidia.com>
To: David Ahern <dsahern@gmail.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH iproute2-next v3 1/5] Add kernel headers
Thread-Topic: [PATCH iproute2-next v3 1/5] Add kernel headers
Thread-Index: AQHW+U8lir/8J9qemkGDQ/lTLMNAIqpHOfIAgAKjJRA=
Date: Fri, 5 Feb 2021 17:54:28 +0000
Message-ID: <BY5PR12MB43221EDD86F33912C1A591E9DCB29@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210122112654.9593-3-parav@nvidia.com>
 <20210202103518.3858-1-parav@nvidia.com>
 <20210202103518.3858-2-parav@nvidia.com>
 <abc71731-012e-eaa4-0274-5347fc99c249@gmail.com>
In-Reply-To: <abc71731-012e-eaa4-0274-5347fc99c249@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.167.131.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b679a9f3-61e2-4cf2-db2b-08d8c9ff1567
x-ms-traffictypediagnostic: BYAPR12MB2997:
x-microsoft-antispam-prvs: <BYAPR12MB29972A4E39DD1A66053674BBDCB29@BYAPR12MB2997.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OSkzreSPIxAuFBgxpnQbL63uZd7JIGrmCU9hzYjAfID4MWIB9wuYZz5ll/NlPHeRPSU/W8bDSMoFNrtATVbhwzf8Xf+fZVp/JBxhoKGIuVSmJCI4Ocf/eAg5PrMIoAAeNdjmyc6/KsRgORd8wUk93vWMFXRE4ln54RvVb02UemK49MTTEr3cNv8yXYWzIsQ6CCctQe/i0uM8kZBzKQNc8mpUL2CdE+sXjudeNJMqNMkzj18cIcasykP1ynMpynywcZdcIirDKuTauwlWr+5PlaGLYQ0CPyCmOqHaFWuIlud2l2llLRoRf74BJLvXfDUYDiloKo4xDqgs87/HKq2nQ1SLFdu4gKTSNsRntc413cEnawKERmhrHaG1J8Rvu3JYkBgfuPUcCGhL3NuBTxx0ca53alRtcJv95orVXWosFC1qiUAyXHhfhJ2t0bm8bemFmnaVWHJ9ADIyL4MVv1cSSs2jCN9KSSi+zqtZfMYi9XPtILKiaadR9RbD3i/EK49+MT4iWfN6MXhsadmar4u7EahNReGCYTk4lsNkBne94bc2P2trShPAKxdP+Y9JxPlZsGb48kqpcjplOSof19/57fnXZh05p9W7Kiys8HeGX2U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(66446008)(83380400001)(316002)(53546011)(64756008)(9686003)(33656002)(66556008)(478600001)(76116006)(66476007)(8676002)(26005)(6506007)(2906002)(966005)(66946007)(4744005)(8936002)(5660300002)(71200400001)(7696005)(86362001)(186003)(55016002)(110136005)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?WlpDc0ZEYkk0TEZHK1VGNXFOaFJ0OHEwRFY2dHJUTHI1cHRyNi9HRVU0a3g1?=
 =?utf-8?B?VXRBYTk0eG5NNTFjVEtrUXF4WVQwL2RKMmxCcjdLL1NBWkVWejkvbStMb1B4?=
 =?utf-8?B?eXRyRkdYYzA0MVRkeVJxRzhEdUtkRWdERlNQLzBIdFZMRWxhekhaUXhBSVlS?=
 =?utf-8?B?b3k2K0pCQi9GSzFBYVJIQ1MrSWtBSW5wUlVZcXRYenNrOHBCZHlyN0lQdEU2?=
 =?utf-8?B?YzFNY3lkT3FsYUFSUzhKTUViQkhkajZiVHZSa3hwWVdKd3lTM2J2bmhzNG5X?=
 =?utf-8?B?TWI2NXFXVURuTHpkSVdHUGRkbHg3dmgvNE1KUk4yOUhQdU5sQzBuL3crZGgx?=
 =?utf-8?B?eXBNZkpaWWlNMUo4Wk11Zkd2ZU9pZTNvQzIvV2hXR1EzNmNVamxtNzdtODZ4?=
 =?utf-8?B?SC9pMFEwN0ZHbmYyRzE5RFNtZkNjdGNxWm5EZCtHQTFHUVpNdzczRkpvNG1S?=
 =?utf-8?B?MFhoWHBpbjFEQ1RWSHZvRnhXckVSQTJXdUMxTXVDcHpvZGt3eE1DZDlrYWZY?=
 =?utf-8?B?WTVjU0lnOStiVi91MzAwdzZ5MXpuWVVQdU03bkRGQ2VON0dmOUtsbHp6VC8z?=
 =?utf-8?B?OCtzUy93SXU4cDc4NFJBZFVNM3NXeS9ZYTlSeXNldlVISkZ2dXFUSnIxQ2Q3?=
 =?utf-8?B?TGNNc0FsY01NajZkMVVmRTR2Y2FvdkxJTlNGSlozc0ppd0dheVM3RkN4ZzVF?=
 =?utf-8?B?K2Nmd2J6UFdMdm1xMUowbUtUTUJDM0JMVHJsZ21SbnZoVTFJay9wZ3pnWFJ1?=
 =?utf-8?B?Zmp1RUNnMEhUdXArR1BDZGJrdGNCd1dUaytoT2d2bTIwYnduaGpwaDI2dmFP?=
 =?utf-8?B?ODFuY0ZoV21HVEIremRLKzE5cFN4b0c5TVlJL2lhelVVdm5aY2JOUHI4QzBE?=
 =?utf-8?B?ZkVickhXU21wN3EwV0J0NzE4cG10ZGsvK25FSDRMbmM4MXI0NmliKytxRjIz?=
 =?utf-8?B?cm9LR3lGanRQN0JZV1p3dnp1Nk1VYnJUSmh4NlJxeTR5eVZsMDBxUE1Wckhx?=
 =?utf-8?B?NWI2VlArODV5ekZGSjBtZWNRdVhpTWF0K2p2NGR3cDlBQTJpYXA2SGhjeXUr?=
 =?utf-8?B?NEpTdkh2Y0hsNkZucEhQN1VmYVZYQUJ5OWxnZDd3S2hpRndrSldueW94ZE8r?=
 =?utf-8?B?d1BlcnR2Y2F1T1Jkalp6Y3Rxejk4cTRsZlU4c1dVYlVDVXBseEhXTEdMWnpT?=
 =?utf-8?B?L3N4TUk0cUVEQnRaN0tMQjBQZFZ1dlhJL09zbmFGYVNKVTE4aVRsbzVOQ3dl?=
 =?utf-8?B?ZFE3eFVVSHQ4KzlYTEtwSThhOUsvOS9kSTBSd2g0SG1OTFc4dGpyQ0JxZE5D?=
 =?utf-8?B?ZDBBWG1rOHd5VjkrTVMxUEV3VHBJd3RwcUFkWDBGN0NhUGNMK29WS3I1ay9F?=
 =?utf-8?B?VlhUOThhc3B0NHBRN1hZN0xnckJUazZ5QXhMRS9TcTFxanN5RXZHMnBRSmNQ?=
 =?utf-8?B?czIrQmxkMGRaZmt1LzV2NHU1bDJTcGNBMHBUTTFiK21DanVXSnVlRUpDd0R6?=
 =?utf-8?B?RnVjVTY4bzRaYkdNNzhTbjg4SmYwYzVzNVROTmduYXgvczRTeG1tT1dzRUFn?=
 =?utf-8?B?VmNUMzVpZU9RYUVlekE4R3dKSWw0U0dFVTRDcVNLRHRWdlduejZDcE9VQkNC?=
 =?utf-8?B?dXlYdkNqVmpLRGdxUGl5ZVVrOVRhMHVhVTNBd2NhQjgyUkh6eitZM3BscUhN?=
 =?utf-8?B?RVB6c3NyLzNQTDd2eXBvZEhlY3dNck5ZT2g2WURPUWVsWTNHeUU4R2ZlZlFZ?=
 =?utf-8?Q?/wpABBYOup5EnpuRas9V1QpZWoZ6f2aLHgCD2e0?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b679a9f3-61e2-4cf2-db2b-08d8c9ff1567
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 17:54:28.4383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+oLUwAy8VVMiotX8V6+Widh9TtvG5MmKKoALl1YarxoXTwvIo0Eu3uanqz+1/ya2hdECqSghy72qw8hzg7c6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2997
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612547669; bh=b98JUQLjckr3Ao/hkdUeRRhITs6Ho0Yf+DGw/n0UAYY=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:x-header:
 x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
 x-ms-exchange-transport-forked:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=jM4HYKP7qiBZDsz7hTp+/fBlYXsllKJM9QHrX3BnD4rrnS2iXyYrWRrP20pHhzbee
 zu8M9QTfDgR2cPU5JSiCq2EvIdbfWjlxvklLX7ljIlHidY74NpSZ+OxfkvRZ1zCyGq
 VvzKYNtOP54Un1klHLmNFh0ikj4GWImL+yXEN5gobAkONUIsOqqG04b7khDttyxWxf
 D1/zZG2p2U+GW/SsRyZqelprTR4ZmHgJm8lib0Um6sh7+Bb9OIRXjMYjgfd6WcBr0f
 LEPB2Wy00vhTJmWSIp5keEIM3WWeZy7Y6L6MoEacq22AUmLlyS53e9bE58Abb0zbqI
 BEy7CLbf6Diag==
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



> From: David Ahern <dsahern@gmail.com>
> Sent: Thursday, February 4, 2021 7:07 AM
> 
> On 2/2/21 3:35 AM, Parav Pandit wrote:
> > Add kernel headers to commit from kernel tree [1].
> >    79991caf5202c7 ("vdpa_sim_net: Add support for user supported
> > devices")
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> > branch: linux-next
> >
> 
> Thinking about this flow a bit more: If new features to uapi/linux/vdpa.h are
> coming through Michael's tree which is not sent via net-next, then I think this
> header needs to be managed like the rdma uapi files. In that case it should
> be added to iproute2 as vdpa/include/uapi/linux and you / vdpa dev's will be
> responsible for managing updates. In general, this should not be a trend, but
> seems to be needed since vdpa is more than just a networking tool.

Ok. Sending v4 to relocate it to the recommended directory.
Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
