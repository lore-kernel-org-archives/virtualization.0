Return-Path: <SRS0=k93m=FM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A197EC433FE
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 22:47:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D88923AFE
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 22:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D88923AFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AAA6B86C4B;
	Tue,  8 Dec 2020 22:47:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EAwLtJeSNM_8; Tue,  8 Dec 2020 22:47:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2FDB886BC9;
	Tue,  8 Dec 2020 22:47:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 091C3C0893;
	Tue,  8 Dec 2020 22:47:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FA39C013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 22:47:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6BE82873AD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 22:47:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G2b6C4RBCvCq
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 22:47:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DB5B18739F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 22:47:16 +0000 (UTC)
Received: by mail-oi1-f194.google.com with SMTP id s75so355843oih.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Dec 2020 14:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=u5UkKTVdVSQdzgLxe0Sijc9KEJH+Y+fH21l3fscA5vs=;
 b=g139F4IDeHgHKJHGAegseG7moYs36Ptas3/bhdgZbuWODhpJYEC3bRoSoX4mahPpZF
 CTgZYCdywqaiwldwn+JhNBIuhHu3JKvCMCNnhKb+w9xguXJc8d9f5ug6LT2wtrErEqg3
 hUZ6RkorqceD+3Iy5LXW8rV1YEYLsnW7dQfWQxtvDKGIo6Ft4p9y1mPCQ8mYhf2kEpIf
 TmCveENINZk+ANva2SY5iswWbb/8Wnj9cXVMC3OtOcT9mJT+InGKIXbCoWtZNsa8+/2R
 Ts/JqcJXs2j+mU/Hn7ZThyzPChd5si0MgALfey+lJ6Y5iWpMnh29pbOWUXcjM3Z4BU6/
 g+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u5UkKTVdVSQdzgLxe0Sijc9KEJH+Y+fH21l3fscA5vs=;
 b=nI2EZUWSGsi2aOejHfoyTT6UYqku7eB8JHLYVqmHysyxBSmYLA4w8G/pqdEqhYtua1
 uCzP1LX6M0ChA4i05YPVbsAz+qTiAo6Wn/ZLUWTVmSMkLlwAnwsDDKf6tUpzFTn2gCh5
 RvCdAKCcn/Lx0Y3xJ9X3iVVyY8mEAEjd4W7zcVfyuKKE0gb6j2H9rkp2lAm9rcz9OaFQ
 T9ESy/Ns/xgYHN1wizC3lOJdp8jfgmx7NRtGM3TGfmOWq5OKhEyo8uVAL/M7SUFqpH+N
 v+a+RdgKB5lCO5HlB/9qmiSNQSAZ1+8/D0uDD7k6sjWsev3avn+W4Z9j1UAk+Bj90PdW
 oYCg==
X-Gm-Message-State: AOAM5301aGf+iWRH7mo7YtsAp01FdsueuC0u6/6qaSRv0S45yDqDNYyc
 pxOCZ1kNFYWoLX6SwdbUtxI=
X-Google-Smtp-Source: ABdhPJwSB4hWMNVXjX4Ea5vURzGXJi/XgHT08yVWomFi+EIMWtOjHX0E2mjpzO3VnHkPUX0tFwkEJQ==
X-Received: by 2002:a05:6808:9a:: with SMTP id
 s26mr123604oic.124.1607467636251; 
 Tue, 08 Dec 2020 14:47:16 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.48.134.51])
 by smtp.googlemail.com with ESMTPSA id j11sm82418oos.47.2020.12.08.14.47.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Dec 2020 14:47:15 -0800 (PST)
Subject: Re: [PATCH 0/7] Introduce vdpa management tool
To: Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>,
 virtualization@lists.linux-foundation.org,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20201112064005.349268-1-parav@nvidia.com>
 <5b2235f6-513b-dbc9-3670-e4c9589b4d1f@redhat.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <831884f7-365d-b974-0bc5-f72729add98f@gmail.com>
Date: Tue, 8 Dec 2020 15:47:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <5b2235f6-513b-dbc9-3670-e4c9589b4d1f@redhat.com>
Content-Language: en-US
Cc: netdev@vger.kernel.org, elic@nvidia.com,
 =?UTF-8?B?6LCi5rC45ZCJ?= <xieyongji@bytedance.com>, mst@redhat.com
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

On 11/26/20 8:53 PM, Jason Wang wrote:
> 1. Where does userspace vdpa tool reside which users can use?
> Ans: vdpa tool can possibly reside in iproute2 [1] as it enables user to
> create vdpa net devices.

iproute2 package is fine with us, but there are some expectations:
syntax, command options and documentation need to be consistent with
other iproute2 commands (this thread suggests it will be but just being
clear), and it needs to re-use code as much as possible (e.g., json
functions). If there is overlap with other tools (devlink, dcb, etc),
you should refactor into common code used by all. Petr Machata has done
this quite a bit for dcb and is a good example to follow.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
