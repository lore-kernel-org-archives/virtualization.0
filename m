Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA8EC64EC7
	for <virtualization@archiver.kernel.org>; Tue, 14 Feb 2023 03:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6A7360F1B;
	Tue, 14 Feb 2023 03:27:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6A7360F1B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=OAGf8NYt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xi2IqhCyIZxp; Tue, 14 Feb 2023 03:27:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 22C25610A5;
	Tue, 14 Feb 2023 03:27:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 22C25610A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBC5DC0033;
	Tue, 14 Feb 2023 03:27:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89185C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 03:27:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 50F3D415D6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 03:27:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 50F3D415D6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=OAGf8NYt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tCwdSb5n7rhr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 03:27:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB3D5409E7
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB3D5409E7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 03:27:08 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id n2so9434376pgb.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 19:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=16MWv8psoN4+i0L8PGIdQnwvghfOx1eJ9GIi//wCpYA=;
 b=OAGf8NYt7iZzPfOLyC3DmCzUXmRCcc8UJSRQtmC25T+cGSs7zaveppl63MjlICHoVX
 hx0FhT2An45tyXSnQdRaRbGnv49TmF4efnhlALuR/nnY+j/Dk6cQ7r1SwGoW39bBe2CC
 /4qjjrdBLwWwRHiaymi0RlmgedtxChRL9Ycnv8bks+op1RafGiGARJr8tzjdS8U9ypoC
 tptEIqc1JwX8vBJJZxTkXTjmGBrQDvN2BcSszFyLWY9qe23WaBb06tLr9301QJhQI3Uv
 bzd0yShKOCSktafnqA4EliUIj+uTSUzwKTH8TOd/N9ft8is8wtQpD2vISgVnSH4ShqXk
 91vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=16MWv8psoN4+i0L8PGIdQnwvghfOx1eJ9GIi//wCpYA=;
 b=tWuokZ5imvxEvxkWBYzB7MRfCld8T4qEXbYPquL5Jdv62nFEFt+V1PbJb2yyrBPp2z
 sEBWtO4MrLFrXJ9Ss4/wd3rIfG+yKVnakvvnFGwgmSWGegllrdXvz9Beiu9TL0n1vQR9
 2Mf6DDlSO5AXcA7cQDLrd0qG5TG8j9Nkihz0UzJIKKWp4czjeOqRtU5vwPiwvD0eWS8h
 DnWO0GlplFhUaTdP/ENQ/mnV3FOBDRxSKk5tEp5HQr3WdbsK+oZ+wwOpS9hAGXwchQeY
 f/1wxHYG5ovJ8zA/yzRRxiBlLfQIkqqU9X23sfv04NgaxJyqJCBv+e0CCyfhq9a7VxG0
 dp3g==
X-Gm-Message-State: AO0yUKXqKayOVJZNXuAUB9hCX9qOkSSn4RC+tH3HCX86Hz0a1QT93sYP
 h4tUDzoCHlyqfuznA115d/P1DQ==
X-Google-Smtp-Source: AK7set94fpeAIjPXN6NZi//iCRtc07wp2w+mCY69vOZmLIU9TZUPQC8iGhn0oI3ucQ43cxPSUy1K6w==
X-Received: by 2002:a05:6a00:c84:b0:5a6:cbdc:2a1a with SMTP id
 a4-20020a056a000c8400b005a6cbdc2a1amr20654537pfv.2.1676345227997; 
 Mon, 13 Feb 2023 19:27:07 -0800 (PST)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 v25-20020a62a519000000b005809d382016sm8587299pfm.74.2023.02.13.19.27.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Feb 2023 19:27:07 -0800 (PST)
Message-ID: <796eb893-f7e2-846c-e75f-9a5774089b8e@igel.co.jp>
Date: Tue, 14 Feb 2023 12:27:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP
 function
Content-Language: en-US
To: Frank Li <frank.li@nxp.com>
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <HE1PR0401MB2331EAFF5684D60EC565433688D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <CANXvt5qjDDEK0NB=BWh00-HGU-p+sC=8TyP-oPdccnZxKxZt9w@mail.gmail.com>
 <HE1PR0401MB2331A8D5C791C34D9C39A62688DB9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
From: Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <HE1PR0401MB2331A8D5C791C34D9C39A62688DB9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
 Takanari Hayama <taki@igel.co.jp>, "Michael S. Tsirkin" <mst@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Ren Zhijie <renzhijie2@huawei.com>, Jon Mason <jdmason@kudzu.us>,
 Bjorn Helgaas <bhelgaas@google.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


On 2023/02/08 1:02, Frank Li wrote:
>> We project extending this module to support RDMA. The plan is based on
>> virtio-rdma[1].
>> It extends the virtio-net and we are plan to implement the proposed
>> spec based on this patch.
>> [1] virtio-rdma
>> - proposal:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
>> ernel.org%2Fall%2F20220511095900.343-1-
>> xieyongji%40bytedance.com%2FT%2F&data=05%7C01%7Cfrank.li%40nxp.co
>> m%7C0ef2bd62eda945c413be08db08f62ba3%7C686ea1d3bc2b4c6fa92cd99c5
>> c301635%7C0%7C0%7C638113625610341574%7CUnknown%7CTWFpbGZsb3d
>> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
>> 3D%7C3000%7C%7C%7C&sdata=HyhpRTG8MNx%2BtfmWn6x3srmdBjHcZAo
>> 2qbxL9USph9o%3D&reserved=0
>> - presentation on kvm forum:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fyout
>> u.be%2FQrhv6hC_YK4&data=05%7C01%7Cfrank.li%40nxp.com%7C0ef2bd62
>> eda945c413be08db08f62ba3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
>> 7C0%7C638113625610341574%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
>> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
>> C%7C%7C&sdata=ucOsGR1letTjxf0gKN6uls5y951CXaIspZtLGnASEC8%3D&res
>> erved=0
>>
> Sorry for our outlook client always change link.  This previous discussion.
> https://lore.kernel.org/imx/d098a631-9930-26d3-48f3-8f95386c8e50@ti.com/T/#t
>
> Look like Endpoint maintainer Kishon like endpoint side work as vhost.
> Previous  Haotian Wang submit similar patches, which just not use eDMA, just use memcpy.
> But overall idea is the same.
>
> I think your and haotian's method is more reasonable for PCI-RC EP connection.
>
> Kishon is not active recently.   Maybe need Lorenzo Pieralisi and Bjorn helgass's comments
> for overall directions.
I think so too. Thank you for your summarization. I've commented on the 
e-mail.
> Frank Li
>
>> Please feel free to comment and suggest.
>>> Frank Li
>>>
>>>> To realize the function, this patchset has few changes and introduces a
>>>> new APIs to PCI EP framework related to virtio. Furthermore, it device
>>>> depends on the some patchtes that is discussing. Those depended
>> patchset
>>>> are following:
>>>> - [PATCH 1/2] dmaengine: dw-edma: Fix to change for continuous
>> transfer
>>>> link:
>>>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
>> %2F&data=05%7C01%7Cfrank.li%40nxp.com%7C0ef2bd62eda945c413be08db
>> 08f62ba3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6381136256
>> 10341574%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
>> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=d
>> VZMaheX3eR1xA2wQtecmT857h2%2BFtUbhDSHXwgvsEY%3D&reserved=0
>>>> ernel.org%2Fdmaengine%2F20221223022608.550697-1-
>>>>
>> mie%40igel.co.jp%2F&data=05%7C01%7CFrank.Li%40nxp.com%7Cac57a62d4
>>>> 10b458a5ba408db05ce0a4e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
>>>>
>> 7C0%7C638110154722945380%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
>> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
>> C%7C%7C&sdata=tIn0MHzEvrdxaC4KKTvTRvYXBzQ6MyrFa2GXpa3ePv0%3D&
>>>> reserved=0
>>>> - [RFC PATCH 0/3] Deal with alignment restriction on EP side
>>>> link:
>>>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
>> %2F&data=05%7C01%7Cfrank.li%40nxp.com%7C0ef2bd62eda945c413be08db
>> 08f62ba3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6381136256
>> 10341574%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
>> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=d
>> VZMaheX3eR1xA2wQtecmT857h2%2BFtUbhDSHXwgvsEY%3D&reserved=0
>>>> ernel.org%2Flinux-pci%2F20230113090350.1103494-1-
>>>>
>> mie%40igel.co.jp%2F&data=05%7C01%7CFrank.Li%40nxp.com%7Cac57a62d4
>>>> 10b458a5ba408db05ce0a4e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
>>>>
>> 7C0%7C638110154722945380%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
>> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
>> C%7C%7C&sdata=RLpnDiLwfqQd5QMXdiQyPVCkfOj8q2AyVeZOwWHvlsM%3
>>>> D&reserved=0
>>>> - [RFC PATCH v2 0/7] Introduce a vringh accessor for IO memory
>>>> link:
>>>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
>> %2F&data=05%7C01%7Cfrank.li%40nxp.com%7C0ef2bd62eda945c413be08db
>> 08f62ba3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6381136256
>> 10341574%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
>> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=d
>> VZMaheX3eR1xA2wQtecmT857h2%2BFtUbhDSHXwgvsEY%3D&reserved=0
>>>> ernel.org%2Fvirtualization%2F20230202090934.549556-1-
>>>>
>> mie%40igel.co.jp%2F&data=05%7C01%7CFrank.Li%40nxp.com%7Cac57a62d4
>>>> 10b458a5ba408db05ce0a4e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
>>>>
>> 7C0%7C638110154722945380%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
>> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
>> C%7C%7C&sdata=6jgY76BMSbvamb%2Fl3Urjt4Gcizeqon%2BZE5nPssc2kDA%
>>>> 3D&reserved=0
>>>>
>>>> About this patchset has 4 patches. The first of two patch is little changes
>>>> to virtio. The third patch add APIs to easily access virtio data structure
>>>> on PCIe Host side memory. The last one introduce a virtio-net EP device
>>>> function. Details are in commit respectively.
>>>>
>>>> Currently those network devices are testd using ping only. I'll add a
>>>> result of performance evaluation using iperf and etc to the future version
>>>> of this patchset.
>>>>
>>>> Shunsuke Mie (4):
>>>>    virtio_pci: add a definition of queue flag in ISR
>>>>    virtio_ring: remove const from vring getter
>>>>    PCI: endpoint: Introduce virtio library for EP functions
>>>>    PCI: endpoint: function: Add EP function driver to provide virtio net
>>>>      device
>>>>
>>>>   drivers/pci/endpoint/Kconfig                  |   7 +
>>>>   drivers/pci/endpoint/Makefile                 |   1 +
>>>>   drivers/pci/endpoint/functions/Kconfig        |  12 +
>>>>   drivers/pci/endpoint/functions/Makefile       |   1 +
>>>>   .../pci/endpoint/functions/pci-epf-vnet-ep.c  | 343 ++++++++++
>>>>   .../pci/endpoint/functions/pci-epf-vnet-rc.c  | 635
>> ++++++++++++++++++
>>>>   drivers/pci/endpoint/functions/pci-epf-vnet.c | 387 +++++++++++
>>>>   drivers/pci/endpoint/functions/pci-epf-vnet.h |  62 ++
>>>>   drivers/pci/endpoint/pci-epf-virtio.c         | 113 ++++
>>>>   drivers/virtio/virtio_ring.c                  |   2 +-
>>>>   include/linux/pci-epf-virtio.h                |  25 +
>>>>   include/linux/virtio.h                        |   2 +-
>>>>   include/uapi/linux/virtio_pci.h               |   2 +
>>>>   13 files changed, 1590 insertions(+), 2 deletions(-)
>>>>   create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-ep.c
>>>>   create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-rc.c
>>>>   create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.c
>>>>   create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.h
>>>>   create mode 100644 drivers/pci/endpoint/pci-epf-virtio.c
>>>>   create mode 100644 include/linux/pci-epf-virtio.h
>>>>
>>>> --
>>>> 2.25.1
>> Best,
>> Shunsuke

Best,

Shunsuke.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
