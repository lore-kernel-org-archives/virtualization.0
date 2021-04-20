Return-Path: <SRS0=4Agt=JR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE70C433ED
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 04:47:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729DD6127C
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 04:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729DD6127C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14953835A6;
	Tue, 20 Apr 2021 04:47:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KpQBB-niwVuV; Tue, 20 Apr 2021 04:47:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89CC083576;
	Tue, 20 Apr 2021 04:47:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61EB0C000E;
	Tue, 20 Apr 2021 04:47:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64E07C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 04:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4456F4045C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 04:47:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mzy2wQkHs5Mj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 04:46:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 520BC4045B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 04:46:58 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id k18so32850919oik.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 21:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=UO9nTuCIT9hOADKmHVu9Q6LDo50ZfH52u0q+oxEEAHc=;
 b=j/5ZHSClavO58DdOR8CQCuVPItUEwUA4i9HSWSH2FvfvZiGzVKWn5cCZtAMeJJBNQa
 fcvpLt3NSoj1hwt9tNcGDNPny4tGaguD40VcvKxN7SpHPe94iQCR5o3Z7/UeIOVS8m0J
 l6QJmJ1SggSFttQsmZYTowtrpKmVMhr8k9PvsJiQ/gR01mU/kbjiS3icdp5mNLXRE0xD
 kXWCMzWLOSOKpcJ1tzkzgXjDFSw9Z4NzZzPUNo7wkJ9KVTqaUYCyC9NQ8pGr46bk81u6
 jACGdjOTH3LlpRHiiifXEWJixol54ep9ndNgfmM+VPbbwLpFHPRzssyZjr7ej/yHTPkB
 jDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=UO9nTuCIT9hOADKmHVu9Q6LDo50ZfH52u0q+oxEEAHc=;
 b=V7Je2MKHjsZyjLb0GNGmw5wKCzQ5ZoWij6+H2D9pbsXHJ9aS+yG1FlHLsLiRnPucyQ
 gJPv0GQrMX2kcBHEpu5M1+onkpz6Vzn79jv1hvoCJb5TIrDYhKWlZVeTBCav88NrkRgC
 Pt+JD1hqzduPfiu6vQckzQzm18RA/Hab2FwvovB2P89Nfs+B7uCyNbeVymLw/UOV/iOP
 hvyH1ojVMkVsYT3H8VvxxMYmLH8GbKauLvGYZs68H7DxrVxy0tCA49DQWjUNy5wYFlj7
 XSEdi+956jTXS1HuQzU+5gzSglP+vs+9vhjXJgszn8RSEpoAGd3IoyUQ8YAcRgmEyE+u
 5+iQ==
X-Gm-Message-State: AOAM533p+lHeyjMHoHARf6ZsgapnPqGZ6CPTi2oRZq37PfAXt2FcKq42
 K9pZLeYubXAXxF7S+8g3leU=
X-Google-Smtp-Source: ABdhPJxADw0CenHCjbN9MQoMQ26Fd9xaAM4JGpqTObX2mFtMlTzju/EXU9GsK2Iiw6IEKPkSZB0Y6A==
X-Received: by 2002:aca:4791:: with SMTP id u139mr1753600oia.83.1618894017330; 
 Mon, 19 Apr 2021 21:46:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id a73sm2098261oib.23.2021.04.19.21.46.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 19 Apr 2021 21:46:56 -0700 (PDT)
Date: Mon, 19 Apr 2021 21:46:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [net-next, v2] virtio-net: page_to_skb() use build_skb when
 there's sufficient tailroom
Message-ID: <20210420044655.GA144160@roeck-us.net>
References: <20210414015221.87554-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210414015221.87554-1-xuanzhuo@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, Apr 14, 2021 at 09:52:21AM +0800, Xuan Zhuo wrote:
> In page_to_skb(), if we have enough tailroom to save skb_shared_info, we
> can use build_skb to create skb directly. No need to alloc for
> additional space. And it can save a 'frags slot', which is very friendly
> to GRO.
> 
> Here, if the payload of the received package is too small (less than
> GOOD_COPY_LEN), we still choose to copy it directly to the space got by
> napi_alloc_skb. So we can reuse these pages.
> 
> Testing Machine:
>     The four queues of the network card are bound to the cpu1.
> 
> Test command:
>     for ((i=0;i<5;++i)); do sockperf tp --ip 192.168.122.64 -m 1000 -t 150& done
> 
> The size of the udp package is 1000, so in the case of this patch, there
> will always be enough tailroom to use build_skb. The sent udp packet
> will be discarded because there is no port to receive it. The irqsoftd
> of the machine is 100%, we observe the received quantity displayed by
> sar -n DEV 1:
> 
> no build_skb:  956864.00 rxpck/s
> build_skb:    1158465.00 rxpck/s
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Suggested-by: Jason Wang <jasowang@redhat.com>

Booting qemu-system-alpha with virtio-net interface instantiated results in:

udhcpc: sending discover
Unable to handle kernel paging request at virtual address 0000000000000004
udhcpc(169): Oops -1
pc = [<0000000000000004>]  ra = [<fffffc0000b8c588>]  ps = 0000    Not tainted
pc is at 0x4
ra is at napi_gro_receive+0x68/0x150
v0 = 0000000000000000  t0 = 0000000000000008  t1 = 0000000000000000
t2 = 0000000000000000  t3 = 000000000000000e  t4 = 0000000000000038
t5 = 000000000000ffff  t6 = fffffc00002f220a  t7 = fffffc0002cd0000
s0 = fffffc00010b3ca0  s1 = 0000000000000000  s2 = fffffc00011267e0
s3 = 0000000000000000  s4 = fffffc00025f2008  s5 = fffffc00002f21c0
s6 = fffffc00025f2040
a0 = fffffc00025f2008  a1 = fffffc00002f21c0  a2 = fffffc0002cc800c
a3 = fffffc00000250d0  a4 = 0000000effff0008  a5 = 0000000000000000
t8 = fffffc00010b3c80  t9 = fffffc0002cc84cc  t10= 0000000000000000
t11= 00000000000004c0  pv = fffffc0000b8bc10  at = 0000000000000000
gp = fffffc00010f9fb8  sp = 00000000aefe3f8a
Disabling lock debugging due to kernel taint
Trace:
[<fffffc0000b8c588>] napi_gro_receive+0x68/0x150
[<fffffc00009b406c>] receive_buf+0x50c/0x1b80
[<fffffc00009b5888>] virtnet_poll+0x1a8/0x5b0
[<fffffc00009b58bc>] virtnet_poll+0x1dc/0x5b0
[<fffffc0000b8d14c>] __napi_poll+0x4c/0x270
[<fffffc0000b8d640>] net_rx_action+0x130/0x2c0
[<fffffc0000bd6f00>] __qdisc_run+0x90/0x6c0
[<fffffc0000337b64>] do_softirq+0xa4/0xd0
[<fffffc0000337ca4>] __local_bh_enable_ip+0x114/0x120
[<fffffc0000b89524>] __dev_queue_xmit+0x484/0xa60
[<fffffc0000cd06fc>] packet_sendmsg+0xe7c/0x1ba0
[<fffffc0000b53308>] __sys_sendto+0xf8/0x170
[<fffffc0000461440>] __d_alloc+0x40/0x270
[<fffffc0000ccdc4c>] packet_create+0x17c/0x3c0
[<fffffc0000b5218c>] move_addr_to_kernel+0x3c/0x60
[<fffffc0000b532b4>] __sys_sendto+0xa4/0x170
[<fffffc0000b533a4>] sys_sendto+0x24/0x40
[<fffffc0000b52840>] sys_bind+0x20/0x40
[<fffffc0000311514>] entSys+0xa4/0xc0

Bisect log attached.

Guenter

---
# bad: [50b8b1d699ac313c0a07a3c185ffb23aecab8abb] Add linux-next specific files for 20210419
# good: [bf05bf16c76bb44ab5156223e1e58e26dfe30a88] Linux 5.12-rc8
git bisect start 'HEAD' 'v5.12-rc8'
# bad: [c4bb91fc07e59241cde97f913d7a2fbedc248f0d] Merge remote-tracking branch 'crypto/master'
git bisect bad c4bb91fc07e59241cde97f913d7a2fbedc248f0d
# good: [499f739ad70f2a58aac985dceb25ca7666da88be] Merge remote-tracking branch 'jc_docs/docs-next'
git bisect good 499f739ad70f2a58aac985dceb25ca7666da88be
# good: [17e1be342d46eb0b7c3df4c7e623493483080b63] bnxt_en: Treat health register value 0 as valid in bnxt_try_reover_fw().
git bisect good 17e1be342d46eb0b7c3df4c7e623493483080b63
# good: [cf6d6925625755029cdf4bb0d0028f0b6e713242] Merge remote-tracking branch 'rdma/for-next'
git bisect good cf6d6925625755029cdf4bb0d0028f0b6e713242
# good: [fb8517f4fade44fa5e42e29ca4d6e4a7ed50b512] rtw88: 8822c: add CFO tracking
git bisect good fb8517f4fade44fa5e42e29ca4d6e4a7ed50b512
# bad: [d168b61fb769d10306b6118ec7623d2911d45690] Merge remote-tracking branch 'gfs2/for-next'
git bisect bad d168b61fb769d10306b6118ec7623d2911d45690
# bad: [ee3e875f10fca68fb7478c23c75b553e56da319c] net: enetc: increase TX ring size
git bisect bad ee3e875f10fca68fb7478c23c75b553e56da319c
# good: [4a51b0e8a0143b0e83d51d9c58c6416c3818a9f2] r8152: support PHY firmware for RTL8156 series
git bisect good 4a51b0e8a0143b0e83d51d9c58c6416c3818a9f2
# bad: [03e481e88b194296defdff3600b2fcebb04bd6cf] Merge tag 'mlx5-updates-2021-04-16' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
git bisect bad 03e481e88b194296defdff3600b2fcebb04bd6cf
# bad: [70c183759b2cece2f9ba82e63e38fa32bebc9db2] Merge branch 'gianfar-mq-polling'
git bisect bad 70c183759b2cece2f9ba82e63e38fa32bebc9db2
# bad: [d8604b209e9b3762280b8321162f0f64219d51c9] dt-bindings: net: qcom,ipa: add firmware-name property
git bisect bad d8604b209e9b3762280b8321162f0f64219d51c9
# good: [4ad29b1a484e0c58acfffdcd87172ed17f35c1dd] net: mvpp2: Add parsing support for different IPv4 IHL values
git bisect good 4ad29b1a484e0c58acfffdcd87172ed17f35c1dd
# good: [fa588eba632df14d296436995e6bbea0c146ae77] net: Add Qcom WWAN control driver
git bisect good fa588eba632df14d296436995e6bbea0c146ae77
# bad: [fb32856b16ad9d5bcd75b76a274e2c515ac7b9d7] virtio-net: page_to_skb() use build_skb when there's sufficient tailroom
git bisect bad fb32856b16ad9d5bcd75b76a274e2c515ac7b9d7
# first bad commit: [fb32856b16ad9d5bcd75b76a274e2c515ac7b9d7] virtio-net: page_to_skb() use build_skb when there's sufficient tailroom
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
