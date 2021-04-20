Return-Path: <SRS0=4Agt=JR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2396DC433B4
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 18:12:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ABCA613AB
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 18:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABCA613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F2FF83C37;
	Tue, 20 Apr 2021 18:12:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DJwEOuh2liQl; Tue, 20 Apr 2021 18:11:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id D531A83B8A;
	Tue, 20 Apr 2021 18:11:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B291EC000F;
	Tue, 20 Apr 2021 18:11:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53797C000F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 18:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 41414405CD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 18:11:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fYvOkZ5cB3Ca
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 18:11:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C5E3405D6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 18:11:53 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id w4so34903316wrt.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 11:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hQWhZtT22zqU5R3lo1xjNZxW6vcxZimRrtATo/q41NI=;
 b=pIyVaaJUQ4x5lSujaqfXT3PmyA+uCv08tNwiQ4f1ezSEgV1Pp6rYaVM/8B7t56qQyl
 oe34ptP+U/mfn9DbEwy1XXue7VVIP5urlym81/lm5K0yldIbOBni2oEGlv9066fikiUt
 LbYvBKCdH4q/9YsOL2zFzQRRevdPAbiNPenKROkFgGmXxNq7Xvq5cXG28/zARNvigeFq
 9AWEL1wMUEp9DGrxPLa7Z5hKTtWPa+Rv3SZEpm0VR62J+ndyixYlx9VC7M28Qi2ydtRj
 lurxZGpx1KextcJMCYUwqrSuPLOdH+rGATg7sFNzaHvBTf/gtlQr0/qSecX7cIiMV68+
 zA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hQWhZtT22zqU5R3lo1xjNZxW6vcxZimRrtATo/q41NI=;
 b=MTf139BbFs0pC+NJwLpuGpoDSXoIbnfd/x6DhLDtVJzygID6uqI7r9YQmL/ldylNoW
 97efk34KU4myB09iIeqUJq25s6331pdkbEcQjUjfBB6Cr65YeOYh+FSBQDtmrFfaBb0w
 sxLUdErGyu36xYFRXpYAswabc762rUY2tIVqEJPgKwZ3ULGK2tArtHZvoWnrQ3XyKqGm
 k2yhzF+QVgBTnuRxs/V3QnKHCqNRLq9PNyCxnf0lDdZCZFeKxT5cJPYK39sASLAaa1BK
 ODbtN+a7AP90hpOuqarQEn0gxhdP6Yv73tzLODZRp603LdpMOUOtGpx145eMN3Oct5Rt
 g5pw==
X-Gm-Message-State: AOAM5333aQ4kPkVjzmDx7QVSC5F8BzRuwvkBhz7T1ld4G+VOatQfcutr
 THE67RRmWAQada3USABHOnnLznNoHno=
X-Google-Smtp-Source: ABdhPJxJyQ+reuUJ+i9f1VohSZJ1ZM9glsEVAqxWes1u2s+E8litN06maC28OoT1Cp2GExACCDn0Ag==
X-Received: by 2002:adf:e58f:: with SMTP id l15mr21709376wrm.175.1618942311555; 
 Tue, 20 Apr 2021 11:11:51 -0700 (PDT)
Received: from [192.168.156.98] (64.104.23.93.rev.sfr.net. [93.23.104.64])
 by smtp.gmail.com with ESMTPSA id i12sm26829354wrm.77.2021.04.20.11.11.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Apr 2021 11:11:51 -0700 (PDT)
Subject: Re: [PATCH net-next] virtio-net: fix use-after-free in page_to_skb()
To: Guenter Roeck <linux@roeck-us.net>, Eric Dumazet <edumazet@google.com>
References: <20210420094341.3259328-1-eric.dumazet@gmail.com>
 <c5a8aeaf-0f41-9274-b9c5-ec385b34180a@roeck-us.net>
 <CANn89iKMbUtDhU+B5dFJDABUSJJ3rnN0PWO0TDY=mRYEbNpHZw@mail.gmail.com>
 <20210420154240.GA115350@roeck-us.net>
 <CANn89iKqx69Xe9x3BzDrybqwgAfiASXZ8nOC7KN8dmADonOBxw@mail.gmail.com>
 <335cc59c-47c4-2781-7146-6c671c2ee62c@roeck-us.net>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <7f2caba4-cdc1-c45b-6b41-18c9de703349@gmail.com>
Date: Tue, 20 Apr 2021 20:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <335cc59c-47c4-2781-7146-6c671c2ee62c@roeck-us.net>
Content-Language: en-US
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eric Dumazet <eric.dumazet@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 virtualization@lists.linux-foundation.org, syzbot <syzkaller@googlegroups.com>,
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



On 4/20/21 7:51 PM, Guenter Roeck wrote:

> 
> sh does indeed fail, with the same symptoms as before, but so far I was not
> able to track it down to a specific commit. The alpha failure is different,
> though. It is a NULL pointer access.
> 
> Anyway, testing ...
> 
> The patch below does indeed fix the problem I am seeing on sh.
> 
> ... and it does fix the alpha problem as well. Neat, though I don't really understand
> what a NULL pointer access and an unaligned access have to do with each other.
> 
> Great catch, thanks!
> 
> Guenter
> 

Note that build_skb(), without an additional skb_reserve(skb, NET_IP_ALIGN)
can not possibly work on arches that care about alignments.

That is because we can not both align skb->data and skb_shinfo(skb)

So unless we change build_skb() to make sure to align skb_shinfo(),
a fix could be simply :

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8cd76037c72481200ea3e8429e9fdfec005dad85..9cbe9c1737649450e451e3c65f59f794d1bf34b0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -415,7 +415,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 
        shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-       if (len > GOOD_COPY_LEN && tailroom >= shinfo_size) {
+       if (!_NET_IP_ALIGN && len > GOOD_COPY_LEN && tailroom >= shinfo_size) {
                skb = build_skb(p, truesize);
                if (unlikely(!skb))
                        return NULL;

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
