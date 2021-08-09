Return-Path: <SRS0=ROIW=NA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6198FC4338F
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 03:13:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEBD161002
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 03:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DEBD161002
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8E48B401E5;
	Mon,  9 Aug 2021 03:13:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qSPRgph4xe5X; Mon,  9 Aug 2021 03:13:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B6049400F5;
	Mon,  9 Aug 2021 03:13:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87986C0010;
	Mon,  9 Aug 2021 03:13:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E9A8C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 03:13:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B8F382E14
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 03:13:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N-k_hD4cKeXb
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 03:13:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2075.outbound.protection.outlook.com [40.107.95.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 176B982D45
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 03:13:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWcUubyUV6VuN31nL1E6uq2qTdnRQ4r/9fZ+LMmEA1fyWbqDPorvEXSa//Ed5lM2k2FYO9Ty2AAqGuDynTPn63pCjLq8HKHekGLTZLrOgxSfPvRFSpIr+LeUE9o8YNA0FrB5p7A4a8MKOj8OIQ5goGSb4jnIJcF1uwrrRzhSGb6/AIgQS1fB6yrvrjsB1DWYbQLoWWTqC2F0Cbq0VpQMN3A2PZsNz6mA3Kp6j3lOnaQA0FRMJ/Sk0IpgQdr+BSHfU0nKXDTE4cr9BwdojYRQXLmpbv4G+3bT9LCY7Vz6TnsEllB7kNK1CYRZcQSQfunPAIqYEBu5AufQYSbRZgpfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOeH/9l8+Vyn5ERW0a0Z4sHrb2mNLcIE0+8FG/lFj+Y=;
 b=cR/DNid/d0sspNRYG6xxijmZ4mdc6YfGvKa05QQK8GES/Mwm1XKCrn7/zlKLDjXS/eEJABcsHmlOt6eysj9PUPCp8S0m5BIIsOYhvx+QJUF9dQwQjuTG6Kmar2XpiwKQV+J2M5nnbXtRCi2f3SeHvzrYMP+DP4EZjn72u9QaWdldS9NkK+SLhZZBpBO6D/MiCF0kHoUiPr9QhBOJZy9yj4mDFovLQGXXcxctyu28HYGivKZBYer1OG2432onZm4U0Cu6X6y++2kXlum+ngL3G1ptqCnhX4mv7TDAwRftvflio2irqeATkttdLryDNUzU+4vEAuz/H3OpBIbN3EpgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOeH/9l8+Vyn5ERW0a0Z4sHrb2mNLcIE0+8FG/lFj+Y=;
 b=Ig6zqDXoEFWW1cStD6H5WTCoGUcpqdaKimGKeTWYAnE86dMeSVTwuozJU/nEXpzJavmqzK4iKNAhTtzOECFPllDEpEFzEbLg3Mwo4LByseBi4vvmp6vJSFy0hvg7umFA1dxyK/RIdP0EVxRq8VCXEUgiHqpA6/HY+iYG9dblFBepsVVkfPNgaSHlJjnu6H2OgpJcXecGH4OkAKoRlWSbia0N/85ZZPX1AB+PBuzHV8Kh8V1o9LTNuMDzhY6NERT+vScBBeQUye1Zyv4v7l59De6F6KfU9eXDFm5LZ6I79xZqgcFM0AHjMoLh2Nv0LiLFiX5jtqaHi8l8/7FFXwaX2w==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5467.namprd12.prod.outlook.com (2603:10b6:510:e6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Mon, 9 Aug
 2021 03:13:11 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29%4]) with mapi id 15.20.4394.022; Mon, 9 Aug 2021
 03:13:11 +0000
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Topic: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Index: AQHXYuOH3YVTcMY6VEeAGlknhW/FN6tk+uIAgAEa9oCAAGJZgIAAALAggARY0QCAAACsYA==
Date: Mon, 9 Aug 2021 03:13:11 +0000
Message-ID: <PH0PR12MB54814CEFF97574642C78171BDCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
 <be8a0173-b7fb-eabf-bc4a-9492133674ef@redhat.com>
In-Reply-To: <be8a0173-b7fb-eabf-bc4a-9492133674ef@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e28f5075-4352-479f-cced-08d95ae39ec5
x-ms-traffictypediagnostic: PH0PR12MB5467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5467A99C97018B5A71415786DCF69@PH0PR12MB5467.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BeOJe7gwq7ODC5vCEBvdHhw5DPuw7CWrLJNl+cOup2qPibTYDOgKwRDJFvJjbWoj/n6iAGYfzW21Bo6dZxGbGVY0YLI9Cx7VphCHuqvGoosJOclNn457QI+QmExkCollCFwlEX2vYhCVukSmAA+s1dYoD7YqMomMTYDbraQtCdnhZAOqomvD0wlpQW8X0zi8r2ZCDwfNkp884bsQklO/Q5Cf2ynCBxgRj2VRUE1euCjEvRT5IiZ+VjCWrUELSoXpVY6lSSyzGVUshL7i1DozA8z3V9raHPcVto3j56q4ZVWzdmnArgtJhLPDrNnkBrAti5uAejEDuLWW6O9yYpxrUfUecgZBwDepZVuIFZPdwrzRN1UlunXoEbZff9eKHkB0SdNbhqy0hRNhyExj+dWRPSlG2ZSSGXUkmihbgNRpFncruP37UoNHzw44v0mzZaXEiSJf0pr/yuo3S/uR67pnEEnkJ948VvIKFhnlzBEoawTpz/idbr3V5B8sf91GC4xx4t23OGIVRuuIDyT3TMR1f5wD/X9LD5y/8VSomsfI4q3QY4jws3tEQa1tT1qGKk851RoGUIRAoNKISgo6KWR1gnqtmQlkIKfPV12vBbiFtkxQ7iFXGyUWvoYAt0CzQGoDTSsZlqQRRw2LR9YGIF884P03v6l+NffchuEh/40J/LY5Tp+9Go/iFRCvw2j0UtDbFQGoaFhQwwbEOMyWB0BNuQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(4326008)(38100700002)(66476007)(54906003)(64756008)(122000001)(7696005)(66556008)(316002)(66946007)(66446008)(76116006)(8936002)(71200400001)(110136005)(8676002)(33656002)(186003)(55236004)(52536014)(2906002)(5660300002)(107886003)(55016002)(9686003)(86362001)(478600001)(26005)(38070700005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3luRS9rcGtXcGYvd2xlaFpxRDFkbC9NMFpNbk9Nbmsvck5hMkJsOCtBZEUv?=
 =?utf-8?B?YWNSYjBFUFg0bzh4WHZVQ2lNVDFyMVBSdmtaeHBoV1N6YUhqelltY3lWTXlM?=
 =?utf-8?B?emd6OXhweDhocTZvMGFmVWxybXNWSUMzZ1oway9jeU5PWm50YlJaelBwaGhk?=
 =?utf-8?B?anJpL2s2blkrVnFyeThLMmtkd3N1bk1YTWd4UGhvcnAwcEJSSzRRRyt1UWRQ?=
 =?utf-8?B?S2ZCU1FMWVRrMzh0eXdOSVFueFBGbkdEcHNhTS9iQjFtMm9UaHVwYm5pc2ZH?=
 =?utf-8?B?b1BDNWdaR21VaitRNnNYbHlNdTRKOE9MYmFWRTc3alpBUUx1eWRydEZqOHZE?=
 =?utf-8?B?SXBPMUZkNkRtRXU1RkRja0twb2VINGZYcmh4SE5pT20rSGFTSjN6K01yd01U?=
 =?utf-8?B?Q0ZhMFI4M0o3ZUtBREUxNHVDRWVNRGFNRTh6Y2U4YS9SV1VERkF2Q001cGhr?=
 =?utf-8?B?cm1KdU5DRVNOMTFRVVNUSDZGNFJOUUFud3RzaTFJbWdSbytYbDg0c0JQRWpE?=
 =?utf-8?B?c3lhOVEvSFN1c21YTnpRbGdNeW9sZE9aUDFiYVF4SDZ1Sjg0NUluU2JjVGNv?=
 =?utf-8?B?clhnWFRtUzhIZlNJQThJT1NIaTZycmNYL0NuenFLNzhLV2dkM0FqeXdEYmov?=
 =?utf-8?B?dyswcHpIMXNYa1ZTQnRvZEtoWUhtRnBvTm84OVM0dVNHMTBBQnJZTTJ3cHBD?=
 =?utf-8?B?bWNXd09vdTU3Z3JIOXM3cHg5MFlmV2VhNUxPdHZteTF2T3JFZVkyaU5RaVhO?=
 =?utf-8?B?OVprcTJ6SDFDL0FjcW1VNUdVVGprczN4OHU4a0xJTm1mTWZ6R2ZBWksyRDZS?=
 =?utf-8?B?MVVOZzRYUDE1OU5OYVdKMWc0TXBYZjExQ2FNdVlzdVc0b3lDWWN1bExFRzBX?=
 =?utf-8?B?cmh1YWtKOWd1dHp3bnVBM09udjJzSGRjL1ROdUYvMVlLQ3FZQTIyc1JPem10?=
 =?utf-8?B?YVpsczVjckk0ZmR5dnd5YlNoNFFxb2tZTXI5LzRwemV4OEJxVXBRcEJuUjI1?=
 =?utf-8?B?UlhWanJjNDVjVnNVeEdtWElSeFphQ2kzM3ZMaXVhY28yYlhjODJQQ3doMjdo?=
 =?utf-8?B?VGJPa2NvUkNYNy9wQVlWMFN5azllVTFraDVoZFFoOVlKczdmSERBdkRmVVBs?=
 =?utf-8?B?SS9za3FTeFo0MHdCL1VKZUYrenU2NjdGcmQyYlV4Yno0TzlkdFFQMStLQm43?=
 =?utf-8?B?R3htZTY1MENIa29XMDdHYUlwM0F2dGxLL2JmY1c0RFhCQWJvT0JxRzdWQmFB?=
 =?utf-8?B?elhUaWU4aDYzdVZSaTQxNzhZTGVJRW9lZU55NzA1VXBBbm1ybVFtMEk2a3Vm?=
 =?utf-8?B?c0VJSTNxTkNMN2xCeEdiUTV1Undydk1ndXNXbXRiaG41WWhZREhaSm15cDh1?=
 =?utf-8?B?SkdGK3lKRHVYem51aklRaVpxaGgzRGVIajBSYWhKaEduWkNPQktmU3NKWm9P?=
 =?utf-8?B?YWN0K0lHbUlMZmtwMEw3SDBCNWh6K3VYNk1ZUU5YaHZIMzAxZW1MbW9QU3B3?=
 =?utf-8?B?SmY5WW5SVHM3RXJRQTU5b2FianlkN0JDMlh1OXhNcGdzSG1pR1FVa1E1ZEZN?=
 =?utf-8?B?ZHRUQ0lkMVNBWW42Wlh3TmJQYzJnVk5nNkIrRUdmVVlyaTFYVzAyMUo2QkZE?=
 =?utf-8?B?MHRaMzV0WXNqSVRpVzNEN2dGTTFQODg5eGdSd3hTTVgvN0Jjam1WZG83L2lQ?=
 =?utf-8?B?c3pSSUJVWkhmNTFOSVAxaXVlYmdEZ3NpN28xdDJhUm40eml0UUtJaUJhc1d5?=
 =?utf-8?Q?mxTMA0uzRGDQ3wdjjr1GdkUv4/uR3SdgAxUiekG?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28f5075-4352-479f-cced-08d95ae39ec5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 03:13:11.5941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfBxzi0YWEw0JMybfPAL3KoaeFTGPUOILDP/KwwbOdlcorXpESm1Y+rUsbcBowzmWe7u8xc3bfCZmW6QDPAYZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5467
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

Hi Jason,

> From: Jason Wang <jasowang@redhat.com>
> Sent: Monday, August 9, 2021 8:38 AM
> > For example creator (hypervisor) of the vdpa devices knows that a
> > guest VM is given 4 vcpus, So hypervisor creates a vdpa devices with
> > config space layout as, max_virtqueue_pairs = 4.
> > And the MAC address chosen by hypervisor in mac[6].
> >
> > Guest VM ethtool can still chose to use less number of channels.
> >
> > Typically,
> > ethtool is for guest VM.
> > vdpa device is in hypevisor.
> >
> > How can hypervisor compose a vdpa device without any tool?
> > How can it tell ethtool, what is supported and what are the defaults?
> 
> 
> Reread the cover letter:
> 
> "
> 
> This patchset enables users to set the mac address and mtu of the vdpa
> device once the device is created.
> 
> "
> 
> It looks to me the mechanism that introduced in the series is not for
> provisioning but for post-creation configuration?
> 
> 
> >
> > I must be misunderstanding your comment about ethtool.
> > Can you please explain?
> 
> 
> I guess the meaning is that, if the vDPA is assigned to guest, it's the
> charge of guest to configure the MTU/MAC/RSS via the existing management
> interface like ethtool/iproute2 netlink protocol. The control virtqueue
> is designed for this.
> 
> But if it was used for provisioning, it looks like another topic which
> should be done during the device creation.

We already discussed and agreed, that I should change these params as creation time params instead post-creation.
We were waiting for Michael to respond if he is ok with either 
(a) extendible individual param or 
(b) should prefer to see a typecast based structure blob coming through netlink.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
