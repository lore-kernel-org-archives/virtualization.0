Return-Path: <SRS0=C5bb=M4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7BAC4320E
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 00:43:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB1C56105A
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 00:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB1C56105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6A1A240201;
	Thu,  5 Aug 2021 00:43:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fMtMQw1uKjjn; Thu,  5 Aug 2021 00:43:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C0D4B40003;
	Thu,  5 Aug 2021 00:43:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 944B3C001A;
	Thu,  5 Aug 2021 00:43:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AEFCC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 00:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0BF98605EB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 00:43:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KdbTwXCXhSvz
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 00:43:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5E364605C1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 00:43:26 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 e13-20020a056830200db02904f06fa2790cso3451863otp.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Aug 2021 17:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vGJp7Qm+vWDqCZWodUNjzWvMf7Y6QRcUPiH81G9CbDc=;
 b=sQkknu+u8jaaB0OcDj6EoRyQO9F7NA9Ud0m6EJ+C2C0ePjqe9hNCnkVkIhC0pjyIZP
 W97xALtifJROfE1qpdGxVX7t01xf3OUl9KJgqZPDl5v3D6FxuuVF0VVTvppzKi5XXtsE
 4ed0zRbT1+oeflIJYRddJz7nhap0Itb932QISt28jF0AZkADODWGr6pauN4688v0ms2M
 NL3LcQi8aY7fs3XjiOEGT3q7TyCWHHsWz+H/9xBY3cUpaylthKBA06O7oI6ZQSb+zUI6
 Oxd5Gj32aEAFvzY1Eyn/QvPv46r/JIqp3cYCy2IUn4Zc1ZseVwoPv3/E1/xwjWiG8rg8
 wnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vGJp7Qm+vWDqCZWodUNjzWvMf7Y6QRcUPiH81G9CbDc=;
 b=C42xnB6HT0beuhrNJy9buPJZSwffqi2f3koH5a62OsX3r8w9j5xEQ+p7PMCGknqt2b
 +ONWrEicNxG+qX5xGZw9omg47VBcUFSTkCz8yaERWsQPbVdUqflentk0FUTSet+oBEsE
 ujqRvYuqmn3dlt6tdnV8JPOfOGftsttOe/tNspxMsOyAGwdxC9sJnnECbtoGqTUAKA5o
 xLEHTE+eCab5v1gHcqZtoRvwGCVZP5lrRyuxrq7CzkLq2Uk0+7bWBM7TnuqFdbQ/am6A
 Fs8kzW+Rr6SMv+EBzh2Fl0g59Hw8+ab8VOih8v6CcPbeBZKoJwVBv2kpdK9kZlbkvVsw
 AR1A==
X-Gm-Message-State: AOAM532WUBUVgl55BL4GqMDZHTl/I53PNB3TytCxvERCdqxeDxl4PV5R
 gstEkC38bOKohyr16MVeOJU=
X-Google-Smtp-Source: ABdhPJz7SOE1TlkK7NDXzrAWjDSQbCEogTY9jw9xb8Kf3WqLv/BBMLwqDVgoBq0L3LxOht5ewMZflQ==
X-Received: by 2002:a9d:63d3:: with SMTP id e19mr1640471otl.147.1628124205501; 
 Wed, 04 Aug 2021 17:43:25 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([8.48.134.45])
 by smtp.googlemail.com with ESMTPSA id v13sm563634ook.40.2021.08.04.17.43.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Aug 2021 17:43:24 -0700 (PDT)
Subject: Re: [PATCH net-next 03/21] ethtool, stats: introduce standard XDP
 statistics
To: Saeed Mahameed <saeed@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Tariq Toukan <ttoukan.linux@gmail.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20210803163641.3743-1-alexandr.lobakin@intel.com>
 <20210803163641.3743-4-alexandr.lobakin@intel.com>
 <20210803134900.578b4c37@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <ec0aefbc987575d1979f9102d331bd3e8f809824.camel@kernel.org>
 <20210804053650.22aa8a5b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <43e91ce1-0f82-5820-7cac-b42461a0311a@gmail.com>
 <20210804094432.08d0fa86@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <d21933cb-9d24-9bdd-cf18-e5077796ddf7@gmail.com>
 <11091d33ff7803257e38ee921e4ba9597acfccfc.camel@kernel.org>
From: David Ahern <dsahern@gmail.com>
Message-ID: <4b2358e1-a802-b0ab-129d-1432f49c46ec@gmail.com>
Date: Wed, 4 Aug 2021 18:43:19 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <11091d33ff7803257e38ee921e4ba9597acfccfc.camel@kernel.org>
Content-Language: en-US
Cc: Michal Kubecek <mkubecek@suse.cz>, Andrew Lunn <andrew@lunn.ch>,
 Song Liu <songliubraving@fb.com>, Vladyslav Tarasiuk <vladyslavt@nvidia.com>,
 Sameeh Jubran <sameehj@amazon.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 YueHaibing <yuehaibing@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Zheng Yongjun <zhengyongjun3@huawei.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Petr Vorel <petr.vorel@gmail.com>,
 Alexander Duyck <alexanderduyck@fb.com>, Jian Shen <shenjian15@huawei.com>,
 Arthur Kiyanovski <akiyano@amazon.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Michal Kubiak <michal.kubiak@intel.com>,
 Martin Habets <habetsm.xilinx@gmail.com>,
 virtualization@lists.linux-foundation.org, Guy Tzalik <gtzalik@amazon.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Ido Schimmel <idosch@nvidia.com>, Lukasz Czapnik <lukasz.czapnik@intel.com>,
 KP Singh <kpsingh@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>, Dan Murphy <dmurphy@ti.com>,
 Yonghong Song <yhs@fb.com>, Shay Agroskin <shayagr@amazon.com>,
 Marcin Wojtas <mw@semihalf.com>, Johannes Berg <johannes@sipsolutions.net>,
 Danielle Ratson <danieller@nvidia.com>,
 Michal Swiatkowski <michal.swiatkowski@intel.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Netanel Belgazal <netanel@amazon.com>, Marcin Kubiak <marcin.kubiak@intel.com>,
 Yangbo Lu <yangbo.lu@nxp.com>, Saeed Bishara <saeedb@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>
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

On 8/4/21 12:27 PM, Saeed Mahameed wrote:
> 
>> I just ran some quick tests with my setup and measured about 1.2%
>> worst
> 
> 1.2% is a lot ! what was the test ? what is the change ?

I did say "quick test ... not exhaustive" and it was definitely
eyeballing a pps change over a small time window.

If multiple counters are bumped 20-25 million times a second (e.g. XDP
drop case), how measurable is it? I was just trying to ballpark the
overhead - 1%, 5%, more? If it is <~ 1% then there is no performance
argument in which case let's do the right thing for users - export via
existing APIs.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
