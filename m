Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6180C433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 06:09:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 338D260241
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 06:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338D260241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C84D5860EF;
	Thu, 18 Feb 2021 06:09:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P31Gme0D1Zka; Thu, 18 Feb 2021 06:09:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5508D860D1;
	Thu, 18 Feb 2021 06:09:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C6B9C000F;
	Thu, 18 Feb 2021 06:09:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B6D5C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 74C93864CB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:09:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MN3YRMPkIer1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:09:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com
 [209.85.166.54])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 75C9E864A0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:09:05 +0000 (UTC)
Received: by mail-io1-f54.google.com with SMTP id y202so921419iof.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 22:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:message-id:in-reply-to:references:subject
 :mime-version:content-transfer-encoding;
 bh=atQAOiXOaMqgkt/WAy6i7CPw9uCPqigPDIhb+m8D4Y8=;
 b=nxC60e/uUY4jw8+FJ0kmQWgUsuJGK5wdf9HeGp2FM0gZei3SirMeYsXmQ8XlDIR04l
 L6mtzeOBsFhv9c2EKURuPpuOXsfGgZQLLZmCyDAfnP2HTft3XWGKKqX2DWiMvs3WNdZ+
 EutwcGVe9QKoXc4bwbY5A/zwZM5ajqgNseOweUvPgGfgM/gVSOYvwm/4FzGan29lH4cO
 S5GZopYOy0XuXQ9LbvdyyJyd0pS63ylKBXmx1jgutD99r5lmBWCG76ANFPOfblwNjDnz
 a4q4n9jIesPN5al1RmTCCFbBFprYVSGYqpYJB27XgjWpD9y/jDzOHEMjlKrT5/eFeIfi
 4zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
 :references:subject:mime-version:content-transfer-encoding;
 bh=atQAOiXOaMqgkt/WAy6i7CPw9uCPqigPDIhb+m8D4Y8=;
 b=jm2iDl+eOCK+aDShI4jrb9TjHD2oqyneCALjH5UP1l7dqJxXle0z67E8DFxCNi1czw
 SMhWfrDiQ57gJZfqp6D41s83dNv4yxCug8AEvm1eEajLRcE3cOQA0aaNMt/KRuiQjvPM
 qblDEuP39Nat64z5Pd8/EmPO0VwAIMFHomFD+azCjFHWMSz/iSCs4K2a/A7GJKdUZi7D
 KFfEn9ZcfryptmpyCvyRCPS+quUlCM7JvzJ0Tq2x/wwsee7x5bpagBdecA92IsadKGVv
 kqo30+KgwiADxyN+KrKwVTxsBs/OktmKV+RwI/2hxSCnqN1XS5XXj2ezDoOr+kwRe9zY
 hPVA==
X-Gm-Message-State: AOAM533UUJ9d3nJ9zo2zu6fLHASbkcMQksg/B91YN4A6jhmySgSiIRz/
 neiV4jgZl3/62wezTBc13Ew=
X-Google-Smtp-Source: ABdhPJyWEr2p5NJfyVcac6POCKwY2UVRF2my+lH+aP4hrOuC6NQOqiSfIPl7hpFEPYSDm9t0Vn/2vQ==
X-Received: by 2002:a05:6638:33a0:: with SMTP id
 h32mr3133952jav.143.1613628544803; 
 Wed, 17 Feb 2021 22:09:04 -0800 (PST)
Received: from localhost ([172.243.146.206])
 by smtp.gmail.com with ESMTPSA id w5sm3220548ilj.40.2021.02.17.22.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Feb 2021 22:09:04 -0800 (PST)
Date: Wed, 17 Feb 2021 22:08:55 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Alexander Lobakin <alobakin@pm.me>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Magnus Karlsson <magnus.karlsson@intel.com>
Message-ID: <602e0477af4c2_1f0ef2088e@john-XPS-13-9370.notmuch>
In-Reply-To: <20210217120003.7938-1-alobakin@pm.me>
References: <20210217120003.7938-1-alobakin@pm.me>
Subject: RE: [PATCH v7 bpf-next 0/6] xsk: build skb by page (aka generic
 zerocopy xmit)
Mime-Version: 1.0
Cc: Song Liu <songliubraving@fb.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Lobakin <alobakin@pm.me>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <eric.dumazet@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Dust Li <dust.li@linux.alibaba.com>, Yonghong Song <yhs@fb.com>,
 Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>
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

Alexander Lobakin wrote:
> This series introduces XSK generic zerocopy xmit by adding XSK umem
> pages as skb frags instead of copying data to linear space.
> The only requirement for this for drivers is to be able to xmit skbs
> with skb_headlen(skb) == 0, i.e. all data including hard headers
> starts from frag 0.
> To indicate whether a particular driver supports this, a new netdev
> priv flag, IFF_TX_SKB_NO_LINEAR, is added (and declared in virtio_net
> as it's already capable of doing it). So consider implementing this
> in your drivers to greatly speed-up generic XSK xmit.

[...]
 
> ---------------- Performance Testing ------------
> 
> The test environment is Aliyun ECS server.
> Test cmd:
> ```
> xdpsock -i eth0 -t  -S -s <msg size>
> ```
> 
> Test result data:
> 
> size    64      512     1024    1500
> copy    1916747 1775988 1600203 1440054
> page    1974058 1953655 1945463 1904478
> percent 3.0%    10.0%   21.58%  32.3%
> 

For the series, but might be good to get Dave or Jakub to check
2/6 to be sure they agree.

Acked-by: John Fastabend <john.fastabend@gmail.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
