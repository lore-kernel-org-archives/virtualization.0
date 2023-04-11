Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DE1C76196
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 10:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C91FD40174;
	Tue, 11 Apr 2023 10:23:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C91FD40174
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=wipKEWC+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J2UhFQJJ453V; Tue, 11 Apr 2023 10:23:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 206B7400ED;
	Tue, 11 Apr 2023 10:23:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 206B7400ED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6961C0037;
	Tue, 11 Apr 2023 10:23:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C57A5C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 10:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D53D60AD8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 10:23:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D53D60AD8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=wipKEWC+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qyf-kOdvBkyc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 10:23:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADC7060E53
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ADC7060E53
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 10:23:05 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6323dca4857so616109b3a.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 03:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681208585;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=byWc1PE6Mr5vjZlhn/A+Tmf4sT9JymgBqL3WiNfAGUE=;
 b=wipKEWC+NFBLOJJbhpgSUVjFSUafgXjLjbN0VovJGlmQZ+sPip1LZhfPCSwaxGbpIR
 5y27wyjQfXgMafJmN3l5LDEzDDBkPoUVaxhAbrrGr8G2vwZGeOn98XLURlvcXvPZ4qM3
 cDhgVsBy41b3PXMKtOPHJGRydsHI7KJ7WoeMGPCr092QrYPTrssz8GhbTBNHpaRlGe9D
 XGUkXayvF0UATBS9tmA4mp/8dmAPz2/eVQgRdwbS8sOMm2hRAE/uYrsZANbuDfI9LxDE
 +O7ClneN7UBboTX8SQvDEJArTt8kuqZcAHadhkx828LR64SCA060juUMoaIP9xqma0rv
 RMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681208585;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=byWc1PE6Mr5vjZlhn/A+Tmf4sT9JymgBqL3WiNfAGUE=;
 b=X+22UkTcuuEsM2Ckl/UlFBlIfkpDjWaxTq6hQiNRgeLgiP+72WwFDftQxL8/emiXUc
 Igf4DzSjidN15c7H3MsvWwWNJGSCc2x70Pte/v6aS4Mc3XH27NM9CsXnloK1qGzpBi7c
 WCep/4ecSVgldtl5ShnX6spg9AkTjY3FTufxh3IqA76aWv8CLqAN4v4bCQenH5AswdfO
 apq3dZyfv+MGg6WDTTE5TfILSw6Evjf6Wctc0c5I0WSzp8UYMlk0+uWIi87kiBQIhQsb
 1ObCxYuNmTSXdSIQoxtnbi+RnJhvqLBp+KOmqdzE9XWHSS/p2tBqppt6KiBJ98NJote/
 kTAg==
X-Gm-Message-State: AAQBX9fSmPomXCg9WJSJrg8pu8ZkHLxf9PCTYloDfi23lWzA/Zw4v1o2
 jpNDrmtGwIMb+DGtgW8D0LoAUg==
X-Google-Smtp-Source: AKy350aRDcPsPp5oCo47lPcOVa42ieYrNa6u+2XtkMrMTyVaJJj188fuLSxe3T+oyEHpmhAG498e7Q==
X-Received: by 2002:aa7:9dce:0:b0:628:1274:4d60 with SMTP id
 g14-20020aa79dce000000b0062812744d60mr14844325pfq.21.1681208584884; 
 Tue, 11 Apr 2023 03:23:04 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 j8-20020aa78dc8000000b0062dba4e4706sm9487628pfr.191.2023.04.11.03.23.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Apr 2023 03:23:04 -0700 (PDT)
Message-ID: <54ee46c3-c845-3df3-8ba0-0ee79a2acab1@igel.co.jp>
Date: Tue, 11 Apr 2023 19:22:59 +0900
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

I'm working on it. I'll submit the next version.

>
> Best regards
> Frank Li


Best regards,

Shunsuke

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
