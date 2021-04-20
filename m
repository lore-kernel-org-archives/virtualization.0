Return-Path: <SRS0=4Agt=JR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D49C433ED
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 21:53:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A1761408
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 21:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A1761408
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11F7C4066B;
	Tue, 20 Apr 2021 21:53:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ipg0j0H-BEYs; Tue, 20 Apr 2021 21:53:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 950D940669;
	Tue, 20 Apr 2021 21:53:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DCE5C000E;
	Tue, 20 Apr 2021 21:53:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE342C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 21:53:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A488B404B3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 21:53:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D8IH5F8MhE2f
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 21:53:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E4A540362
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 21:53:10 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id x20so6701457oix.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=00OiHd+LRJcqptKfnQ5Z0Sf2+EdKL1vKJSY05rY22uk=;
 b=TZAfxlR5XGQkYdpwkNnMhe2QL/sDEdnfqGivcdlGL1g5oohd/2ubYo16yLNtQTVzfC
 owhG0BE8jcys96nXRL3BUo5nRqiCokqXpF62i2IQcxnfxL6EkGm7B6Dmo23cMxk+9jCE
 VH2LcOLRHdL0i6XAJnASHSp7ilBNfXikRvM0ZrYGkw13YkS0Rz8BaRUMwUi8H4x8qUHW
 A7XmRwPbP1nVeNtznfhW0KcCkkNNeiI4tiFRXAEqPYLcSSHmNHpnTzlRjau6aiihHaBN
 MXy/Ysnq0JAehIgU+EuX8nlNfjikDWRX3Z+q94E2i27+YNXEtm5fMeO2Ha1J3ohaBosY
 U+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :mime-version:content-disposition:user-agent;
 bh=00OiHd+LRJcqptKfnQ5Z0Sf2+EdKL1vKJSY05rY22uk=;
 b=gKtHzArzIh837ZnUf12845apETm9TKMVOyY+aoUtRBEO55BEmYZJbBDvjY+irmCu7D
 ltyswfpau8MX/7mPNrAuYyWjqMHQnJkAZoIFLlpRauF09/BA8rmc8mQ0s8Ufv1+eUaNx
 Fo5lxipfElOXWtx0f6rI0vLRyRy2EnF5l8aL6n5MZgFPrBuIE+s7Af/HAkARh43Mtz3L
 CsHu63ihpnKA3SA2dGla67CBy6fsI3N1pYTNDPLJTpq1TXozWR3imkwT8DMpO6LVLgpl
 BEv3p64Es80qwdiBVWZ1SKXX05R0BWoaPjQ2iUeCaie+pWc+3DRCjsm0iWbDPAywMyQ2
 hmuA==
X-Gm-Message-State: AOAM533SrBz4da/uU2YxW6By38l6jRrXSNcwWxqVCQs6p/oa2gtX2rEk
 0rS4yH9okrosIxhX5DffmMw=
X-Google-Smtp-Source: ABdhPJyyd2j0rETipbc3k7xYBw0Kf9qe4uN6kI+PjPB/SUnPb3jdbp8AKBP3V9uGyBZ6sZz2DrkzyQ==
X-Received: by 2002:aca:db85:: with SMTP id s127mr4531007oig.142.1618955589697; 
 Tue, 20 Apr 2021 14:53:09 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id w29sm68510ott.24.2021.04.20.14.53.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 20 Apr 2021 14:53:09 -0700 (PDT)
Date: Tue, 20 Apr 2021 14:53:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH net-next] virtio-net: restrict build_skb() use to some
 arches
Message-ID: <20210420215307.GA103196@roeck-us.net>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>
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

On Tue, Apr 20, 2021 at 01:01:44PM -0700, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> build_skb() is supposed to be followed by
> skb_reserve(skb, NET_IP_ALIGN), so that IP headers are word-aligned.
> (Best practice is to reserve NET_IP_ALIGN+NET_SKB_PAD, but the NET_SKB_PAD
> part is only a performance optimization if tunnel encaps are added.)
> 
> Unfortunately virtio_net has not provisioned this reserve.
> We can only use build_skb() for arches where NET_IP_ALIGN == 0
> 
> We might refine this later, with enough testing.
> 
> Fixes: fb32856b16ad ("virtio-net: page_to_skb() use build_skb when there's sufficient tailroom")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: virtualization@lists.linux-foundation.org

Tested-by: Guenter Roeck <linux@roeck-us.net>

on alpha, sh4 (little endian).

Thanks!

Guenter
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
