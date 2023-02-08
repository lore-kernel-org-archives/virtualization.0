Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C6EC636D3
	for <virtualization@archiver.kernel.org>; Wed,  8 Feb 2023 05:46:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EAAEB40B7F;
	Wed,  8 Feb 2023 05:46:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EAAEB40B7F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=cQmLD187
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DRE7_6gbEZrW; Wed,  8 Feb 2023 05:46:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 78DDE40370;
	Wed,  8 Feb 2023 05:46:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 78DDE40370
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54621C0033;
	Wed,  8 Feb 2023 05:46:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6120C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 05:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A9D9781F1C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 05:46:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9D9781F1C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=cQmLD187
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pSKSBF7CDRFr
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 05:46:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 248A781F1B
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 248A781F1B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 05:46:11 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id g13so13317496ple.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Feb 2023 21:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gGlOEIPzV+FTI/GF62gic89emIZoIYryIf9WL0MuhjI=;
 b=cQmLD187qGYvCE95MDfRyufr4leKm51MnluIeCu1mwvtokMHZKgE9e6RJ8OIsqQPMi
 ewo6oAXyGxCRbEjKCgm4EeLHmc7c1UiRoK0i3HL4F1a36+75ZRjyF8O3SOmfmpJ7ytt0
 dQg2rz8F2L7Ui9fsllAshRSkZVoeQVeI9aoXCVMh1Y1Q1Tvn2mv5tjOBLCXCS1Ny1+GA
 MvaRH6AvLYEw4coHFQ991tFAM6de03LOhkoEkeZZQ6Hoh7iD4gLL0JjaVYDwD6eoWIfU
 iplJ7Y7j89AMoh7SbAVtaUpa5WXzb2ilRqD6Ra8tHg7cjviJFyNZfbHaJff8klqkWaWv
 nDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gGlOEIPzV+FTI/GF62gic89emIZoIYryIf9WL0MuhjI=;
 b=EIDR9mNk0yeNe0z0TrMxrLRc7XAxNo8NOuF4y3z7++OGA32jtOI05CIRT0cTwciuuB
 ijIvg/8bU8xe+4N27NTWrYKxaidGiiT/5DxoSb+mv1fRozxWfNys96aeqpa0oVp+M9EB
 /ZTzaiNCYsLZxatJ1g2/5G6OQGcWGh0Oeetw0OJZRP9JooIVBCUNcgTxQCAvFCc5aSxE
 C/VPRdtGS3nwHWPw1nUX9fj9aBJFV4AceVPB0jQSaiDqMVc0BFIYDLFV7FC8HkrQ8f4y
 TSInXigsN7Uc58pIAmWjdGlaroLrrzjAkNz1mjt1qNbJmXS8IXlWIVDaMLuVoh/sCoj/
 BQ1A==
X-Gm-Message-State: AO0yUKW/q/boN0wVkIUJWdCx2cUlKaqZCmM9AoMTT9Cm9NtgdE+9QuBh
 4Lg/zOoUTky7/gAjY61zPWNNgg==
X-Google-Smtp-Source: AK7set94skn6M5M9CT0xtS0+tEYXm95sJCOLMhuwaiyK3S9cl/nNQN5VoK2Af4LK20Th3wzFVP00fw==
X-Received: by 2002:a05:6a20:8403:b0:bb:b945:4865 with SMTP id
 c3-20020a056a20840300b000bbb9454865mr7962364pzd.8.1675835171325; 
 Tue, 07 Feb 2023 21:46:11 -0800 (PST)
Received: from [10.16.128.218] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 iz17-20020a170902ef9100b001898ee9f723sm5008429plb.2.2023.02.07.21.46.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Feb 2023 21:46:10 -0800 (PST)
Message-ID: <b86a549a-5c8e-55dc-d6f4-edc5ca75ac05@igel.co.jp>
Date: Wed, 8 Feb 2023 14:46:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [EXT] Re: [RFC PATCH 4/4] PCI: endpoint: function: Add EP
 function driver to provide virtio net device
Content-Language: en-US
To: Frank Li <frank.li@nxp.com>
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <20230203100418.2981144-5-mie@igel.co.jp>
 <20230203052114-mutt-send-email-mst@kernel.org>
 <HE1PR0401MB23313FC60955EADE8A00133088D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <CANXvt5qjgVKccRcsARSkDF+boVkVi7h=AMHC+iWyOfp4dJ-_tQ@mail.gmail.com>
 <HE1PR0401MB2331D1335BFACBD23B7676EF88DB9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
From: Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <HE1PR0401MB2331D1335BFACBD23B7676EF88DB9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
 Takanari Hayama <taki@igel.co.jp>, Manivannan Sadhasivam <mani@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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


On 2023/02/08 0:37, Frank Li wrote:
>>> but it may need update host side pci virtio driver.
>> Thanks, is it possible to use  MSI-X as well? The virtio spec
>> indicates to use legacy irq or
>> MSI-X only.
> I supposed yes. It is depend MSI controller type in EP side.
> But not like standard PCI MSI-X, it is platform MSI-X irq.
>
> If use GIC-its, it should support MSI-X.
>
> Thomas Gleixner is working on pre-device msi irq domain.
> https://lore.kernel.org/all/20221121135653.208611233@linutronix.de
>
> I hope Thomas can finish their work soon.
> so I can continue my patch upstream work.
> https://lore.kernel.org/imx/87wn7evql7.ffs@tglx/T/#u

Thank for sharing this those information. I'll see the details to embed.

>> Best,
>> Shunsuke.

Best,

Shunsuke.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
