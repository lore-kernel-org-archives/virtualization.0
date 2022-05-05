Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9ADDC433F5
	for <virtualization@archiver.kernel.org>; Thu,  5 May 2022 02:39:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CDAF83F75;
	Thu,  5 May 2022 02:39:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 78DaqNfwEcLo; Thu,  5 May 2022 02:39:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EC9B783F6F;
	Thu,  5 May 2022 02:39:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA182C0039;
	Thu,  5 May 2022 02:39:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EFEDC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 02:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 18A3A401F2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 02:39:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yo---nkM9QYC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 02:39:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AF55340182
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 02:39:11 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id x18so3143041plg.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 May 2022 19:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=aEOiwyG+eTh6W3KHKpg7shbqlJQ76/KhFzFg57zL5/0=;
 b=SxFvslkZn6Q7OGlLS0jfiCTQI0xExlJuAPCV/QgaRH9jHQ3UvOSGxz4PqWTvGgBoOj
 gBffuL3wuhZtQhDfJigr7X7r7hQ7pNB++kVGMw+ILNK+ZJOd/AkCeDcxTSmZg47MtDoD
 z80FE3h2Xcbh2AjufRmu/kpVcavdLzpyMOpSRw6Xj1hH6rfCCnRe0xK7XDskvZdjifBr
 2INqvNc4tChqAjFbu7htLf9yRlSjmfKGuHKu0S1g273gLnpPseYMXEplQsMUT3NjD+fr
 CGrdIGglM3GN0s8WNVIib+e6y9hsThmkkioTe5fxw/nghkpclZz6l0mWXwD+MKQlmaVj
 Ui8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=aEOiwyG+eTh6W3KHKpg7shbqlJQ76/KhFzFg57zL5/0=;
 b=pBEsuRYHlncbA4pAD5loJCACCX3ixAuZLz4i1QQMZtio4xBRMvr/kTVirjGBcX1EdN
 hhkF8ymFjyrbVaLQC8+gJBsG/RxxzPXKc4RDZLFopMLWxWXa0r8XjnCGdmVw5pHOc9dT
 jEMVmA7uiQ++UmbDAi1VYlwS+siUl8gLIoBHC/Wtye6m+psU45UaI1tnZWNROOjToDid
 eDn/1FFOFxYRNX8oZFumB6Iknn2d9fzIR9CgpyfClkl+cjTt7ylHahzdZn0zhrnLmhB4
 QVQVrRI01FNCN1TmLRw+k3bn5Hj+sYiF40zls6FcorzEQVHcURMVC3JQvV1lzpKIory5
 99iw==
X-Gm-Message-State: AOAM530JYXpurXCYcEScoiRYM7qQTnizje0hTV3zTBDjOfkGuQ/gYrI0
 repho1yYevRcxpBST+yWp+qpVQ==
X-Google-Smtp-Source: ABdhPJxJbVfMb0WtsafX9eaZn5+JI7p1n0mchGmJpTKtQMX5xjsduPiS9ugOP+49TDJNvmYc0nwoQw==
X-Received: by 2002:a17:90b:3903:b0:1dc:8fe0:df4d with SMTP id
 ob3-20020a17090b390300b001dc8fe0df4dmr3327533pjb.191.1651718350808; 
 Wed, 04 May 2022 19:39:10 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 n1-20020a170902e54100b0015e8d4eb252sm203223plf.156.2022.05.04.19.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 May 2022 19:39:10 -0700 (PDT)
Message-ID: <cc9eb4aa-2e40-490f-f5a0-beee3a57313b@bytedance.com>
Date: Thu, 5 May 2022 10:35:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: PING: [PATCH v4 0/5] virtio-crypto: Improve performance
Content-Language: en-US
To: arei.gonglei@huawei.com, mst@redhat.com, jasowang@redhat.com
References: <20220424104140.44841-1-pizhenwei@bytedance.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220424104140.44841-1-pizhenwei@bytedance.com>
Cc: helei.sig11@bytedance.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 davem@davemloft.net, herbert@gondor.apana.org.au
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

Hi, Lei

Jason replied in another patch:
Still hundreds of lines of changes, I'd leave this change to other
maintainers to decide.

Quite frankly, the virtio crypto driver changed only a few in the past, 
and the performance of control queue is not good enough. I am in doubt 
about that this driver is not used widely. So I'd like to rework a lot, 
it would be best to complete this work in 5.18 window.

This gets different point with Jason. I would appreciate it if you could 
give me any hint.

On 4/24/22 18:41, zhenwei pi wrote:
> Hi, Lei
> I'd like to move helper and callback functions(Eg, virtcrypto_clear_request
>   and virtcrypto_ctrlq_callback) from xx_core.c to xx_common.c,
> then the xx_core.c supports:
>    - probe/remove/irq affinity seting for a virtio device
>    - basic virtio related operations
> 
> xx_common.c supports:
>    - common helpers/functions for algos
> 
> Do you have any suggestion about this?
> 
> v3 -> v4:
>   - Don't create new file virtio_common.c, the new functions are added
>     into virtio_crypto_core.c
>   - Split the first patch into two parts:
>       1, change code style,
>       2, use private buffer instead of shared buffer
>   - Remove relevant change.
>   - Other minor changes.
> 
> v2 -> v3:
>   - Jason suggested that spliting the first patch into two part:
>       1, using private buffer
>       2, remove the busy polling
>     Rework as Jason's suggestion, this makes the smaller change in
>     each one and clear.
> 
> v1 -> v2:
>   - Use kfree instead of kfree_sensitive for insensitive buffer.
>   - Several coding style fix.
>   - Use memory from current node, instead of memory close to device
>   - Add more message in commit, also explain why removing per-device
>     request buffer.
>   - Add necessary comment in code to explain why using kzalloc to
>     allocate struct virtio_crypto_ctrl_request.
> 
> v1:
> The main point of this series is to improve the performance for
> virtio crypto:
> - Use wait mechanism instead of busy polling for ctrl queue, this
>    reduces CPU and lock racing, it's possiable to create/destroy session
>    parallelly, QPS increases from ~40K/s to ~200K/s.
> - Enable retry on crypto engine to improve performance for data queue,
>    this allows the larger depth instead of 1.
> - Fix dst data length in akcipher service.
> - Other style fix.
> 
> lei he (2):
>    virtio-crypto: adjust dst_len at ops callback
>    virtio-crypto: enable retry for virtio-crypto-dev
> 
> zhenwei pi (3):
>    virtio-crypto: change code style
>    virtio-crypto: use private buffer for control request
>    virtio-crypto: wait ctrl queue instead of busy polling
> 
>   .../virtio/virtio_crypto_akcipher_algs.c      |  83 ++++++-----
>   drivers/crypto/virtio/virtio_crypto_common.h  |  21 ++-
>   drivers/crypto/virtio/virtio_crypto_core.c    |  55 ++++++-
>   .../virtio/virtio_crypto_skcipher_algs.c      | 140 ++++++++----------
>   4 files changed, 180 insertions(+), 119 deletions(-)
> 

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
