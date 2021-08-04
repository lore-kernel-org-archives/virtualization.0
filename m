Return-Path: <SRS0=5nkl=M3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCEFC4338F
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 17:28:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E9F60EE5
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 17:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 23E9F60EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1FCA605C3;
	Wed,  4 Aug 2021 17:28:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c-p0sCit-6oJ; Wed,  4 Aug 2021 17:28:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5F5AD600BB;
	Wed,  4 Aug 2021 17:28:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35647C0010;
	Wed,  4 Aug 2021 17:28:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88523C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 17:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8407F40665
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 17:28:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tV55twuJTnRO
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 17:28:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B707A4065A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 17:28:33 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 v8-20020a0568301bc8b02904d5b4e5ca3aso2292093ota.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Aug 2021 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1gu89wY9LreYODHlzcyea31Rq8lJ9lifCsibkahK734=;
 b=twallvAmbFxBl9Z6qyLi8tqJmCVWfRSu/r/bTsFejuxvtLNsGrdH36quktEn8bDI+f
 gDUiowVe2a0q9gRWDDvzbWNLcm0YPIHYtEcKjx3LWpHkjO1VMuXLmq1JGO8Wbh08dPuU
 WijtEETtWIn8YQmPUOaTBpfBLNnFlD0us43hrTvzZe12eO8kkPqBTfFEMkP9SoZksxfw
 mFpegkN7IiZ2ZzbSWutYBzy9TESGxJC5cr0ITIkkuyY+WPUbdtDzUlLPmjPuVt8jbTuc
 TTlAd7VxK0h+dgZHGDQt/wHli10k0oluN271z2YqbNgFZ56E+kmYRNNR6KOq/mgAMO8A
 NOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1gu89wY9LreYODHlzcyea31Rq8lJ9lifCsibkahK734=;
 b=WN7BNFwlsDIaNu+pgovvmHHTYVmEPnJGESDF0CjQ8Qipk0I/Hl62CZNqn0TZkgL3w7
 WIYEBHDjNDSvSj36tejUiU1hbs+Jz1NUjueswp6xn20XaEbjpXKzUu5hrfnHjPLAmevc
 TKABgkb9Gkdj0tLpwTEs0QwEcXlX26UQOHXdw60XHh301SxG2a+bulZziY2HJHSzscJG
 Q9tAiT+PuBXOCqNXu87NOQDGemNJLakft4S/LebXbB7T1PRwpdHIuN0exqFLIAyG03lY
 IYobaN0dT4OGZIQ+AdcfjDHh1dY/7GAsnbOqMGSYJTin9tARtfmME/Z4dw1sJd0PoSAc
 13Iw==
X-Gm-Message-State: AOAM531BpUIu6Ap1vVz00mLT6KgME6BtEC4N4YIkYBHkavw1nEpvG5PR
 5nxFnqpFvsoK7BoD2wTFiqQ=
X-Google-Smtp-Source: ABdhPJxfTJB+1amIiaMzKYuEzbZBRIy7VzQ7/+ItNJE/ANxFmOKfDrAXgp4L0cILRQmu/1zpKeW+wA==
X-Received: by 2002:a9d:7550:: with SMTP id b16mr623424otl.309.1628098112834; 
 Wed, 04 Aug 2021 10:28:32 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([8.48.134.45])
 by smtp.googlemail.com with ESMTPSA id r25sm418421oos.24.2021.08.04.10.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Aug 2021 10:28:32 -0700 (PDT)
Subject: Re: [PATCH net-next 03/21] ethtool, stats: introduce standard XDP
 statistics
To: Jakub Kicinski <kuba@kernel.org>
References: <20210803163641.3743-1-alexandr.lobakin@intel.com>
 <20210803163641.3743-4-alexandr.lobakin@intel.com>
 <20210803134900.578b4c37@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <ec0aefbc987575d1979f9102d331bd3e8f809824.camel@kernel.org>
 <20210804053650.22aa8a5b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <43e91ce1-0f82-5820-7cac-b42461a0311a@gmail.com>
 <20210804094432.08d0fa86@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <d21933cb-9d24-9bdd-cf18-e5077796ddf7@gmail.com>
Date: Wed, 4 Aug 2021 11:28:28 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804094432.08d0fa86@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
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
 Andrii Nakryiko <andrii@kernel.org>, Martin Habets <habetsm.xilinx@gmail.com>,
 virtualization@lists.linux-foundation.org, Guy Tzalik <gtzalik@amazon.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Ido Schimmel <idosch@nvidia.com>, Lukasz Czapnik <lukasz.czapnik@intel.com>,
 KP Singh <kpsingh@kernel.org>, Saeed Mahameed <saeed@kernel.org>,
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

On 8/4/21 10:44 AM, Jakub Kicinski wrote:
> On Wed, 4 Aug 2021 10:17:56 -0600 David Ahern wrote:
>> On 8/4/21 6:36 AM, Jakub Kicinski wrote:
>>>> XDP is going to always be eBPF based ! why not just report such stats
>>>> to a special BPF_MAP ? BPF stack can collect the stats from the driver
>>>> and report them to this special MAP upon user request.  
>>> Do you mean replacing the ethtool-netlink / rtnetlink etc. with
>>> a new BPF_MAP? I don't think adding another category of uAPI thru 
>>> which netdevice stats are exposed would do much good :( Plus it 
>>> doesn't address the "yet another cacheline" concern.
>>>
>>> To my understanding the need for stats recognizes the fact that (in
>>> large organizations) fleet monitoring is done by different teams than
>>> XDP development. So XDP team may have all the stats they need, but the
>>> team doing fleet monitoring has no idea how to get to them.
>>>
>>> To bridge the two worlds we need a way for the infra team to ask the
>>> XDP for well-defined stats. Maybe we should take a page from the BPF
>>> iterators book and create a program type for bridging the two worlds?
>>> Called by networking core when duping stats to extract from the
>>> existing BPF maps all the relevant stats and render them into a well
>>> known struct? Users' XDP design can still use a single per-cpu map with
>>> all the stats if they so choose, but there's a way to implement more
>>> optimal designs and still expose well-defined stats.
>>>
>>> Maybe that's too complex, IDK.  
>>
>> I was just explaining to someone internally how to get stats at all of
>> the different points in the stack to track down reasons for dropped packets:
>>
>> ethtool -S for h/w and driver
>> tc -s for drops by the qdisc
>> /proc/net/softnet_stat for drops at the backlog layer
>> netstat -s for network and transport layer
>>
>> yet another command and API just adds to the nightmare of explaining and
>> understanding these stats.
> 
> Are you referring to RTM_GETSTATS when you say "yet another command"?
> RTM_GETSTATS exists and is used by offloads today.
> 
> I'd expect ip -s (-s) to be extended to run GETSTATS and display the xdp
> stats. (Not sure why ip -s was left out of your list :))

It's on my diagram, and yes, forgot to add it here.

> 
>> There is real value in continuing to use ethtool API for XDP stats. Not
>> saying this reorg of the XDP stats is the right thing to do, only that
>> the existing API has real user benefits.
> 
> RTM_GETSTATS is an existing API. New ethtool stats are intended to be HW
> stats. I don't want to go back to ethtool being a dumping ground for all
> stats because that's what the old interface encouraged.

driver stats are important too. e.g., mlx5's cache stats and per-queue
stats.

> 
>> Does anyone have data that shows bumping a properly implemented counter
>> causes a noticeable performance degradation and if so by how much? You
>> mention 'yet another cacheline' but collecting stats on stack and
>> incrementing the driver structs at the end of the napi loop should not
>> have a huge impact versus the value the stats provide.
> 
> Not sure, maybe Jesper has some numbers. Maybe Intel folks do?

I just ran some quick tests with my setup and measured about 1.2% worst
case. Certainly not exhaustive. Perhaps Intel or Mellanox can provide
numbers for their high speed nics - e.g. ConnectX-6 and a saturated host.

> 
> I'm just allergic to situations when there is a decision made and 
> then months later patches are posted disregarding the decision, 
> without analysis on why that decision was wrong. And while the
> maintainer who made the decision is on vacation.
> 

stats is one of the many sensitive topics. I have been consistent in
defending the need to use existing APIs and tooling and not relying on
XDP program writers to add the relevant stats and then provide whatever
tool is needed to extract and print them. Standardization for
fundamental analysis tools.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
