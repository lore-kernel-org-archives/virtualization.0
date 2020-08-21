Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD2EC433E1
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 14:45:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC392086A
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 14:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WZPAanfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC392086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B72FF87F0C;
	Fri, 21 Aug 2020 14:45:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HNWS1Xjow6-i; Fri, 21 Aug 2020 14:45:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BE9B787ED7;
	Fri, 21 Aug 2020 14:45:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7E8CC07FF;
	Fri, 21 Aug 2020 14:45:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36834C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 14:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 321D387FBF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 14:45:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 09i5y5FqudSp
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 14:45:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
 [209.85.166.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 657228830F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 14:45:05 +0000 (UTC)
Received: by mail-il1-f193.google.com with SMTP id v2so1601826ilq.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 07:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=C90nSWF13UnmUXT/t6zouheV3b/caGvmm+rEBKqVpdg=;
 b=WZPAanfw3FhXa7h3fxpfrymu1+iAfN7jYZZcDC1ZwufOlcLwlqqC5JQ2Jdaa7axmC/
 AuKMmUn6G9SHn8uiHiSKtQMcKmXt4qJnS6XfrG5tH/F6ZqV3GjPWYDc8S9VMsqwuj4fV
 6+e5S2jm62HjwvxTNFR+qtMpHYZegRDCQMV3NIelDb+CZcphTnuK8QJcZnufxa59Xgzw
 6LY26EQ0sduFkqL66yNRVSu0VnzkIRq8w0QDD/s+udlfz3bK6/yqg7LAN3a8nAsf0Nuw
 +g0YGzid/aIb0K/qP+EjYkCkDGRtudkM4AUj2vRZDEX+cRQXswzarbNLHhDu+3bRbWns
 eC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C90nSWF13UnmUXT/t6zouheV3b/caGvmm+rEBKqVpdg=;
 b=lTLEakeeJYkjrD1gk6mCutrcn+Nv/T97UX4LFE8p+CMTj6fsSDLlxdRUllSwhXsFJV
 lzYqbZMF1m5xqR9soAZppsfny3qkl/EggRBSNiavMzB9BwX/tSLfPDO3bLAhX5GBd3Ar
 9Q1VwBazq8wtxgeFafT4xvtv36TEb/jMWoL7151nt2cc1Oz5LfYfwvg2HNPYE0bFETS7
 lkzq4jYwQ5Ju1toL1Kt3dk+PSn/zH3AIDzapn2mfE1k8aw6IjGA6iJaISiZcRA4E69Ie
 sB61lqK3PX8ugYKoytlHSr9ZKuSy5+FUzMZW34C3jHZgiUx54+aAZGRMPBXt1j7A/SGb
 IGvA==
X-Gm-Message-State: AOAM530SfuK4vuMBLmGkx3A+EFTEo4S/hNGCG1NbTKVBJIPSlarNopSv
 7YxqHD6XvfyFJwOFVEQ38SUc2g==
X-Google-Smtp-Source: ABdhPJzv5Uro5gqLH9Madfn+I7njnS1pYD1IAyxJA8wxLh1cPMqD/A08/j+1u985vO8tNXtdISywww==
X-Received: by 2002:a05:6e02:d44:: with SMTP id
 h4mr2812734ilj.296.1598021104562; 
 Fri, 21 Aug 2020 07:45:04 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id u89sm1313919ili.87.2020.08.21.07.45.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 07:45:04 -0700 (PDT)
Subject: Re: [PATCH] virtio-blk: Use kobj_to_dev() instead of container_of()
To: Tian Tao <tiantao6@hisilicon.com>, mst@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org
References: <1597972755-60633-1-git-send-email-tiantao6@hisilicon.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0d6b9b5b-cf44-6d77-8d3c-7a9f6063d457@kernel.dk>
Date: Fri, 21 Aug 2020 08:45:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597972755-60633-1-git-send-email-tiantao6@hisilicon.com>
Content-Language: en-US
Cc: linuxarm@huawei.com
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

On 8/20/20 7:19 PM, Tian Tao wrote:
> Use kobj_to_dev() instead of container_of()

Applied, thanks.

-- 
Jens Axboe

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
