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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DE1C4338F
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 16:18:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A03260F94
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 16:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A03260F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B432483C55;
	Wed,  4 Aug 2021 16:18:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4smzmzXDJdYN; Wed,  4 Aug 2021 16:18:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A1FA483C42;
	Wed,  4 Aug 2021 16:18:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D89FC001A;
	Wed,  4 Aug 2021 16:18:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A60EC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 16:18:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD8A983C55
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 16:18:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ub5e-r6PhmnZ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 16:18:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9773A83C42
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 16:18:02 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 c2-20020a0568303482b029048bcf4c6bd9so2111980otu.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Aug 2021 09:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qTPO93ek00ieZ4h1jlHx4mVRBJbxujN/y8xcY6o8WNU=;
 b=vOGVqPRwQG7VOW4uzaSShTmRzf9UrbcW3jjG4dVkIXUL1wcy03pjQ09wMSRwifLbt+
 jy/rgAtrflpyz0lrws8UHJ0Nqwq8VRfadft9DCEBJ/vcqBlajv4vVoNwcudF/nwLE0U4
 M0+lrv+P4KOyOXqys4GGCGizOh4PoYmtiBnyK1fWx0xN9KwQ+eSiOyqQwN2oeXnxwZfK
 T/DxACEFGQcBSrvukZlfizkVa44fLBsZdpfq7TGmgB+MMY8Iqw7J+ttwg3voOdqLB5ea
 XDqq58WpHBme8e0+ByizWvBiVy71HFEMGpogvsZ4iXz48sEEqNB5Yq2fALwRlgAAE/Wg
 2ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qTPO93ek00ieZ4h1jlHx4mVRBJbxujN/y8xcY6o8WNU=;
 b=OEg/1/4ISjEn7l9bZzm253ZmTsaXfk3y9X3Kb8bsV5ZRSyNwAUnJqQZPmcUJtd+7op
 UG/khNvRoB1fcum5hsQmQt+v/jGKaL98CtcivbkP85AdPLIwsCOHWHtgggnBFYR+FTZ6
 xIOVNGF2nlljzsSv+BlmYuwQe55cuEYgZXxsByfuL7Y2tne3M1MDwDMAB4+VyP+BLjOD
 5bASZbppmkZ4Ui7PjrzgPz4m7AyBuZeqHmDUYKgC6X4Omb/qBPsP6EsXBmv7n7rGa7Yi
 sVib+dZeExe+OYhz9rV6IumTYOKlH7tnsxQUUX3QlDyPIZ/iF+c46Y4y3UDoj1rJnr0f
 9dOw==
X-Gm-Message-State: AOAM532s25eHGE/s0ahg+LeL9oI/cek5MDyqNNGBbpgBgjHV1cH6H18D
 pSiPuC36ETwpUUJFsZwU2g0=
X-Google-Smtp-Source: ABdhPJwSKtdqMSiQmc6Z/AVzL+juoGVbxNK3lLBYUFOpDi9n6YEh0UcLX2VLGTRMpx9/Cpt8Q13SNg==
X-Received: by 2002:a9d:d04:: with SMTP id 4mr386968oti.251.1628093880856;
 Wed, 04 Aug 2021 09:18:00 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([8.48.134.45])
 by smtp.googlemail.com with ESMTPSA id a7sm470157oti.47.2021.08.04.09.17.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Aug 2021 09:18:00 -0700 (PDT)
Subject: Re: [PATCH net-next 03/21] ethtool, stats: introduce standard XDP
 statistics
To: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>
References: <20210803163641.3743-1-alexandr.lobakin@intel.com>
 <20210803163641.3743-4-alexandr.lobakin@intel.com>
 <20210803134900.578b4c37@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <ec0aefbc987575d1979f9102d331bd3e8f809824.camel@kernel.org>
 <20210804053650.22aa8a5b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <43e91ce1-0f82-5820-7cac-b42461a0311a@gmail.com>
Date: Wed, 4 Aug 2021 10:17:56 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804053650.22aa8a5b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
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

On 8/4/21 6:36 AM, Jakub Kicinski wrote:
>> XDP is going to always be eBPF based ! why not just report such stats
>> to a special BPF_MAP ? BPF stack can collect the stats from the driver
>> and report them to this special MAP upon user request.
> Do you mean replacing the ethtool-netlink / rtnetlink etc. with
> a new BPF_MAP? I don't think adding another category of uAPI thru 
> which netdevice stats are exposed would do much good :( Plus it 
> doesn't address the "yet another cacheline" concern.
> 
> To my understanding the need for stats recognizes the fact that (in
> large organizations) fleet monitoring is done by different teams than
> XDP development. So XDP team may have all the stats they need, but the
> team doing fleet monitoring has no idea how to get to them.
> 
> To bridge the two worlds we need a way for the infra team to ask the
> XDP for well-defined stats. Maybe we should take a page from the BPF
> iterators book and create a program type for bridging the two worlds?
> Called by networking core when duping stats to extract from the
> existing BPF maps all the relevant stats and render them into a well
> known struct? Users' XDP design can still use a single per-cpu map with
> all the stats if they so choose, but there's a way to implement more
> optimal designs and still expose well-defined stats.
> 
> Maybe that's too complex, IDK.

I was just explaining to someone internally how to get stats at all of
the different points in the stack to track down reasons for dropped packets:

ethtool -S for h/w and driver
tc -s for drops by the qdisc
/proc/net/softnet_stat for drops at the backlog layer
netstat -s for network and transport layer

yet another command and API just adds to the nightmare of explaining and
understanding these stats.

There is real value in continuing to use ethtool API for XDP stats. Not
saying this reorg of the XDP stats is the right thing to do, only that
the existing API has real user benefits.

Does anyone have data that shows bumping a properly implemented counter
causes a noticeable performance degradation and if so by how much? You
mention 'yet another cacheline' but collecting stats on stack and
incrementing the driver structs at the end of the napi loop should not
have a huge impact versus the value the stats provide.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
