Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B58CC432BE
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 02:30:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E0660EE8
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 02:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D0E0660EE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A26B82F49;
	Tue,  3 Aug 2021 02:30:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dhQSd93TYGzJ; Tue,  3 Aug 2021 02:30:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3038182F4F;
	Tue,  3 Aug 2021 02:30:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3FFAC001A;
	Tue,  3 Aug 2021 02:30:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77E1EC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 02:30:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 612A082F4F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 02:30:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cP3CJwxQWXdr
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 02:30:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::610])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0FCCE82F49
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 02:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMHVhDcNMvoi8CaxkMh+QOurKsSBVfR/jLUEKDGxp48N9DlHDf3wDNSocbxDybfzmh2KAkqJ2Sh5zPW28WnDtze1j7I9hSQUwEQWTRE6XmzLJB8qupq6wSRY1WJL4VhAEu4uUn16a5C9eme5YNxkCRipBZdI4TihmifVjzILgk9bhmDtYtoD85ZUX/20mNWx7AyAvcKUY1gzHWHMrwkG9tZ9bQGZzOn2qU1L2qfAS8NNorTkBP3OVb6lDUjb/fwB911bMFlG+D7aXtduy3E/UjCYd/2LXsajdm5NllfLYNU0gmFieuPjPG22YKjHx11G9vx9+7T63FlH9r3NqbpkZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRAn4uOxw3Mt1tum1fkXTHW62TYa7a5koq7jmqEYJ9o=;
 b=YdI/72Klt9zbFbIaeXOIDF8Lkg22zNyoUlQE07Kd7Bh4xxA9GBZWvIDbE4LEnq7mgUJj6S+83BuBpKwaCOGiiHbfHCpAyfKk3oz/En7cyJbGalooT5YWVlrN7IeSoSi7B1UnvF7d6dhDmj+4xt6jNxe7FzfhCig+/4929v61oWCjEhaSLHYGcigNQFIsWXSuFXBvk/zAvZrEWdjjjEAEhvb875O6Vr1lV1EBakCV6+1IWozfvHov9oNHsCzaLQG6zWzHVJnIfQX/hfYWUzjEzljoB8TIzIskGlLkhN4XyOILB2No4pfiLMhbNlOiee9jgAk47KBW7l1ElWzTQSwR7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRAn4uOxw3Mt1tum1fkXTHW62TYa7a5koq7jmqEYJ9o=;
 b=nZX9gyDYSyZeJSOYwJ6kW5p0WNDiI5qeiGZLwVZcU41+BWE2Q25hpsiS1G7+nl0wqoN8XkVXVuJRO1RqIfm1ljSJqvBZE94daCdK41IkR647Cv8sPlx1iwEKMVv7aXrtDjzEDiXOp5a1nC0xiP4p4pNp6NPSnXc/b5+5v3jt8GrmdKr/ZxmTjNvSj2WNf1zsDQm60QLHqwXBEMuUxZP7aglDTtLa0xg9SA+XeIEcXUpqsQ7JOF7UAR2zJW6W6XJxRxjvjlRkFjYGCa+i/qXnwOOF5maSWZsAHcbR+pcHuNxziQm7FVshb/AsSZI/hUnNrx65I68OgArdtZiaStEoJg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5497.namprd12.prod.outlook.com (2603:10b6:510:eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Tue, 3 Aug
 2021 02:30:11 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 02:30:11 +0000
To: "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH v3 0/4] virtio short improvements
Thread-Topic: [PATCH v3 0/4] virtio short improvements
Thread-Index: AQHXfjyEgkBpWMMsPk+MOQpth6qjnqtZajIggAe3oAA=
Date: Tue, 3 Aug 2021 02:30:10 +0000
Message-ID: <PH0PR12MB54813F761DEA56B792B29E0EDCF09@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210721142648.1525924-1-parav@nvidia.com>
 <PH0PR12MB54815548E4E659AE8A023702DCEB9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54815548E4E659AE8A023702DCEB9@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a80d919a-1df2-4ecd-860c-08d956269e19
x-ms-traffictypediagnostic: PH0PR12MB5497:
x-microsoft-antispam-prvs: <PH0PR12MB5497C44B88D0D5FB5BBD7621DCF09@PH0PR12MB5497.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5XB9M+ivQszDPsqq1fEO1lEKWEmIFJbrSgd1L+rbkFndmUX94ZcyGDFqGMHvaxUfBZPA6CeHkRgzZAobQpbpH9/tI+xQgAWTAclzSjpANKcPkmZHh2kaZJayb9iMmDeNK3I3Mya1aB5YfVg96Xtu+wKm0ynS71muppuEUeFSRhXIRjsgPzw4nDmxkxZt2DETghWFRB7MxsBbC/uB4aj9ek4+bQ/w2GcJ7W9+woL5mYgYsaJB1apZuqLw9YBsH7tGzEU5AXT6iqEJqJRE5ZbKOBkqv6KtCdn8ius7+XuOGAj+AY3a9DpN8yiJFo6/uGFVMQcjjG+1L9yS4CLbjfYVY+/5S6/hqHSS+yNS7EfH7foy9+unCim6Fm4EXDkmzC3L0SwystCEt4SO4+pSRr2q8sHL0TyoyOg7S8npmR7D/i9o+8rcXaSl9VC47LFY1kD6MLweAJdYy7urTQfp6iMQaxEJkkm7sMGDSniRTgIIaSMgUtY2XKKcaKtJLpCg2vTA7yxW2K1g6QmqzsjeHPwdSiLYR1S2misYenl7TcDAk8cBJUT/5483ovyDXPqc5Q/XUaYVG9FghsCTFt2hD69gv0RBT7UNbQdamBEPhiCt2zeKzIMTfiBcnbu+o5GrXqGmdq3xDdxwpDT5tO0Z+auer+I26N/5YxNF3RUiv0y0/pi6ztAw2c2qJ+UcEaPmIzaikMIp3V/JRgw8aR2KXT8hhA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(38100700002)(122000001)(8936002)(83380400001)(2906002)(33656002)(110136005)(7696005)(52536014)(38070700005)(478600001)(5660300002)(66476007)(71200400001)(26005)(6506007)(76116006)(8676002)(55016002)(66556008)(186003)(9686003)(53546011)(66446008)(55236004)(64756008)(316002)(66946007)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OZaW3TaGROYDf0OQH0jHIGgIbRzj0kqIg+G9KdBlfkkY06V/0VfeoEujxsZK?=
 =?us-ascii?Q?eX92c54Pw1COINHFQoUi83HaB2cZne8ZwrfDZ27b+RmqGby90GKR544StKoA?=
 =?us-ascii?Q?NKnvLNf/MEkFN1yx9TNESbfy1rPG2ooi8ecjDXssK1olgdIdUxU17Mk1TMkZ?=
 =?us-ascii?Q?73jSxCCyfwNcTnbjxkzCjUrdmNNSuwXJW7sfT2eSBqN7yIMjIR6z98MfDLeg?=
 =?us-ascii?Q?lD9POD4Clc6xl2OjpcjCjc4rtDn3t4Wir5zDUelRmbxfid23OY/Yr8QcMWg5?=
 =?us-ascii?Q?5dAB9wPe25mVnVSRAzM/rcrRi5bPihWw35W+pUzD4TYQfLLsl6aCMNbjPlro?=
 =?us-ascii?Q?gkyTl3J720zl2HxaVTB64Bp/PZbqa7vCc6kRt0wROXv3zVXvouj5j/PWLawW?=
 =?us-ascii?Q?Rm/nlAvojkuQtxAfJCT+tP2FYq2MqwRrOfeuLlkS0BYC7cjVmvSHseYss487?=
 =?us-ascii?Q?ZqLLTBri9IpRAiPrQBLuyAbVSK4Z9AvjKge8D+Z1pRs01aCqzRSvQI5Rv34S?=
 =?us-ascii?Q?Cp6ZdED5sk+uJa/oJWCOdp4LWtWBTqmTlYTnwTbuLjjPYHcJcnUrYD+rM0fG?=
 =?us-ascii?Q?qB7XvgQlcO2B8r/2MaH1QpPRuLl2DMfrE2I3fVAZ1sgyBRR+2eLopy9V4Kcl?=
 =?us-ascii?Q?fzPs1VTKGSkxViuKJtqSXAYH9e8QlviqdbidGD+CsepU926++PNxkMZ6j670?=
 =?us-ascii?Q?UYqr11tVguRKOq3V3MmOdvUpYkBvTk7o2FNjOBKMztG+jGlRVFtoSduTzQSz?=
 =?us-ascii?Q?l9s2o3ELUrbLP0TVae270XrhfMny9bSPdX+DLLJLqpHusGZDsDdo87DiEa0q?=
 =?us-ascii?Q?QmRWTa1UXRyZ7Ek+XjO0Pq2+iv/17C8/0JpXWaQNXUPKIGZSgxoF0d/c4/Sx?=
 =?us-ascii?Q?mgQxzjwsm1cYTJhmCksMDzeQfYjXpFxP+himOgVQ915kFfgOVxMW7QJUGYh4?=
 =?us-ascii?Q?Nvq9g2NTEVi/xU3CBzIT60T24c6MWqa6Zv/JOz1k7xNUdwVDH1NbR70HluT1?=
 =?us-ascii?Q?dklajn0SblJfh5s8jQ0NVp8SZjAgtWZlTP7P6ndMb8hW5VutqK04jh9U++js?=
 =?us-ascii?Q?eCQe8jnvAX2cnLgokcnySP0Sp/LtUNPoLl86wxYumcpGQ9K61K9VSystUMVl?=
 =?us-ascii?Q?YIOPFJtvyo0ci6CarKrx943rQ2im+dL/rilj0aYRYnmyYKM06LxCaF67Q0SV?=
 =?us-ascii?Q?5o53NjZMF7x7KIyENk0vU4M0QYWEMCQsch4YMav5dqprCamtu6xQHCvc4jQW?=
 =?us-ascii?Q?e3FOW0UbtfK7+6Hsq4VqWMz2EAHlaGCrebuaXJIecnlcOnagOh/kl8Z2ouAu?=
 =?us-ascii?Q?p+7hoGhncrjGEoHrvkFBY7UX?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80d919a-1df2-4ecd-860c-08d956269e19
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 02:30:10.9301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MrdzhkHJ1Enh4+25yMOTmO7cnOCDb1ZFF0oUrU2XjjHpKrM7jT6tYuAMcK/75FqoluQeVbj3ykqf6PT8nJLb/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5497
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

Hi Michael,

> From: Parav Pandit
> Sent: Thursday, July 29, 2021 10:09 AM
> 
> Hi Michael,
> 
> > From: Parav Pandit <parav@nvidia.com>
> > Sent: Wednesday, July 21, 2021 7:57 PM
> > To: mst@redhat.com; virtualization@lists.linux-foundation.org
> > Cc: Parav Pandit <parav@nvidia.com>
> > Subject: [PATCH v3 0/4] virtio short improvements
> >
> > Hi,
> >
> > This series contains small improvements for virtio pci driver.
> > The main idea is to support surprise removal of virtio pci device when
> > the driver is already loaded. Future patches will further improve
> > other areas of hotplug.
> >
> > Patches 1 to 3 prepare the code to handle surprise removal by marking
> > the device as broken in patch-4.
> >
> > Patch summary:
> > patch-1: ensures that compiler optimization doesn't occur on vq->broken
> >          flag
> > patch-2: maintains the mirror sequence on VQ delete and VQ create
> > patch-3: protects vqs list for simultaneous access from reader and a
> > writer
> > patch-4: handles surprise removal of virtio pci device which avoids
> >          call trace and system lockup
> >
> Any comments to address or will you please take this short series?
> 

Can we please proceed with these series?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
