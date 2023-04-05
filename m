Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4743FC76188
	for <virtualization@archiver.kernel.org>; Wed,  5 Apr 2023 01:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B38B541716;
	Wed,  5 Apr 2023 01:22:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B38B541716
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=lnRyzmMU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oejj8VqSrgmk; Wed,  5 Apr 2023 01:22:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 230334090A;
	Wed,  5 Apr 2023 01:22:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 230334090A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E50D5C0036;
	Wed,  5 Apr 2023 01:22:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AD0CC002F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Apr 2023 01:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E34E641716
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Apr 2023 01:22:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E34E641716
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XfoZpc2cKJPj
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Apr 2023 01:22:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 527244090A
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 527244090A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Apr 2023 01:22:07 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id d13so32437849pjh.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Apr 2023 18:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1680657727;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PMZrmMwRVjfayGfEKZ5/Wh+uf7NTWdPEZjK/ywMGWbw=;
 b=lnRyzmMUBzt+VBlN5/kcDBg8RroinuDrfbciKMwqQwLIuaHTHlEBACCxutv53kRs7O
 0piT5yMXkTblwA/V126tw4KL6d48qex0ewc7RX3hPtyi9o2vTfWuIWCffSFX0z9veXw5
 2lGvowhgkxo3OaOyjZSS9sOG24Les0MeYsQrM0YX1PFFx9Tp48ShY+oYbhSqTsDAaih9
 VctYuChx8qvwghczBGyKMXQJ3D8Sc776C0ntWEhTQvx+9xUY3CNiWdfZChayMDUGrTVb
 OFA0gamskvvneAMDWv7T1aEkpvjh3hxw45CJRjMjU1hiuZD09JC3Yk9A6XuInOPBm1an
 +c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680657727;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PMZrmMwRVjfayGfEKZ5/Wh+uf7NTWdPEZjK/ywMGWbw=;
 b=XGVoviUgYEkrc+aGRcUKrW0ajNNdt0D63XQQMP5vloBVCta/HTVdDUy8ZOMwqay960
 X27hL9zAn1vkR+PrUDN0P4GxofWD1GODxafbMBpfLiXMK2TyEvB6jJp9v9onDs9kRU4X
 MnM7UDnzurXbj6ba8yaycAWiKzgFDd9PS9jirZ8m1oK4prRORCUcLJhSUugtve8C6xSo
 kwROLyKVeJqWJkhc3x0gluGbyvpHTqzdrVYkeNie8MAf82SkPihh9bmL9fh8l2M2Agu7
 8o0NT0IhYaHr8RMwcT3JTW1EdpURxCBhvqQPJ8SpeHc4D/KzSt7iNABOjW6jiih1BJ95
 XFtQ==
X-Gm-Message-State: AAQBX9fWro+6CtVaw/Sw84o924Vw5EAkwHuyOoauhIQT0Xc9aMAxqC/3
 RZ0LPs0mBxUeoTpjzNPvV8UK9w==
X-Google-Smtp-Source: AKy350YFg5M4Wfdwi60nxK/2w+Z902ux2yIkzfxHjSBUhr16zkDivckeO7pjVqcGWM0F3n4oJT8JHA==
X-Received: by 2002:a05:6a20:1bc6:b0:bf:4563:e647 with SMTP id
 cv6-20020a056a201bc600b000bf4563e647mr3276440pzb.40.1680657727161; 
 Tue, 04 Apr 2023 18:22:07 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 r26-20020a62e41a000000b006281273f1f5sm9340798pfh.8.2023.04.04.18.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Apr 2023 18:22:06 -0700 (PDT)
Message-ID: <ad0217de-3db8-e3f9-3824-62b36dc7d2ee@igel.co.jp>
Date: Wed, 5 Apr 2023 10:22:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP
 function
Content-Language: en-US
To: Frank Li <frank.li@nxp.com>
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <HE1PR0401MB2331EAFF5684D60EC565433688D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <CANXvt5qjDDEK0NB=BWh00-HGU-p+sC=8TyP-oPdccnZxKxZt9w@mail.gmail.com>
 <HE1PR0401MB2331A8D5C791C34D9C39A62688DB9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <796eb893-f7e2-846c-e75f-9a5774089b8e@igel.co.jp>
 <AM6PR04MB483881DFA2C35F02011FE74D88899@AM6PR04MB4838.eurprd04.prod.outlook.com>
From: Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <AM6PR04MB483881DFA2C35F02011FE74D88899@AM6PR04MB4838.eurprd04.prod.outlook.com>
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


On 2023/03/30 1:46, Frank Li wrote:
>> On 2023/02/08 1:02, Frank Li wrote:
> Did you have chance to improve this?

Yes. I'm working on it.I'd like to submit new one in this week.

> Best regards
> Frank Li

Best,

Shunsuke,

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
