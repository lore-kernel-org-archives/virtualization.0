Return-Path: <SRS0=XE2Y=MP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF440C4320A
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 02:28:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46FDA60EBF
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 02:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46FDA60EBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0029A605AD;
	Fri, 23 Jul 2021 02:28:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QsSCKX6gV5Cf; Fri, 23 Jul 2021 02:28:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9A1E06066F;
	Fri, 23 Jul 2021 02:28:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 572D3C0010;
	Fri, 23 Jul 2021 02:28:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9416FC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 02:28:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8973B400CE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 02:28:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vZLwGgznW-Hv
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 02:28:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F3667400C5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 02:28:38 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id t21so1347636plr.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 19:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tAw85E8NXV/d5HgkTo259jtbI4ouhmcg6pjHUDSWPjc=;
 b=Q7CIwrCSaunZRhC18Xlo4DvY8+aN4ehQ8+o9kvikwLv3PHHcQ4BFGQhX9vu8e28p3/
 vuFeJmrPpxB4Ach1ym4qW9yJPyYnTIdLn4z3y/8Ihhe+s61EFqv8PjfvgMRR3rOXoUP6
 nLDsUlogdx/HTaxNHdkBk0SzAQKwDkCxTN4Oqz8nvr2FEtbdXnFJt5R4W4Zyb2+qRanh
 SiXn7ka7sLQPZSEj2AlCDkJF+v6Bf0C9cTO4QlY6svJJUVm5F07h6D/Zu4FYwIDkTdlN
 vRLbZA4Lxz5Wp3xNxNCxmu8OO3+cRKITygD40IWp+Q7X5t0CFpEdR9FGfbmsJD6CmHgQ
 g0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tAw85E8NXV/d5HgkTo259jtbI4ouhmcg6pjHUDSWPjc=;
 b=Rq99baWpMjDv9tF7eSvcSbhxYqKsZyWDhUUw+8XCkWbWYo35kW9xlwq8n+uT+Or3Ls
 IU1JjTLMWHSw3sgqJcKh+L3SAJd1zg8PUqxmsnUWwzrmDhIzwS+jSucYz8K+h7l3K09l
 ueMbV6zONX/S0Ev8apLCSTq3GTGSNrU4hCXs7SzUklKf+0cBlT7B8HHZNo8LLKdS5ZHJ
 9dC2VqmHeWZRhwk40k37dmfBXO8CxMGwaCVo+SgkDGcGwHU0gessosUGjiPEHNFSAAjF
 0mrd/zuCcvkElmFUsITOcmQhRyC+Z8eWjtd8rK0tECFUDkUIdbFMWgA+++qjpSjGXRix
 n/iQ==
X-Gm-Message-State: AOAM533JkLMGBbiGsLfCkQv4jZkw1TSdKakr02IND582ltjpZM2tLp9F
 WcCo3y8fj7ISpLpXxDpXeRSsGw==
X-Google-Smtp-Source: ABdhPJxSWSpC//R2a9331w7aLWF4tUcZt/V6puU33PGp87Oq9CNUj0lUb/eotMn0lPyFT2oVs4VjiQ==
X-Received: by 2002:aa7:93ac:0:b029:32e:4fce:bde1 with SMTP id
 x12-20020aa793ac0000b029032e4fcebde1mr2586387pff.54.1627007318309; 
 Thu, 22 Jul 2021 19:28:38 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id y15sm32865753pfn.63.2021.07.22.19.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jul 2021 19:28:37 -0700 (PDT)
Date: Fri, 23 Jul 2021 07:58:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wolfram Sang <wsa@kernel.org>, Jie Deng <jie.deng@intel.com>,
 linux-i2c@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com,
 arnd@arndb.de, kblaiech@mellanox.com, jarkko.nikula@linux.intel.com,
 Sergey.Semin@baikalelectronics.ru, rppt@kernel.org,
 loic.poulain@linaro.org, tali.perry1@gmail.com,
 u.kleine-koenig@pengutronix.de, bjorn.andersson@linaro.org,
 yu1.wang@intel.com, shuo.a.liu@intel.com, stefanha@redhat.com,
 pbonzini@redhat.com
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210723022836.ews7bshlwcsaktud@vireshk-i7>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNrw4rxihFLuqLtY@ninjato>
 <20210629101627.kwc2rszborc3kvjs@vireshk-i7>
 <YNr0uDx1fv+Gjd7m@ninjato>
 <20210629103014.nlk3mpetydc4mi6l@vireshk-i7>
 <YNr5Jf3WDTH7U5b7@ninjato> <YNr5ZRhT3qn+e9/m@ninjato>
 <20210705121832.fmye5xnlbydoc5ir@vireshk-i7>
 <YPmLoeLSPS1tfYUK@ninjato>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YPmLoeLSPS1tfYUK@ninjato>
User-Agent: NeoMutt/20180716-391-311a52
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

Hi Wolfram,

On 22-07-21, 17:15, Wolfram Sang wrote:
> Nope, I think you misinterpreted that. SMBUS_QUICK will not send any
> byte. After the address phase (with the RW bit as data), a STOP will
> immediately follow. len = 0 will ensure that.
> 
> msgbuf0[0] is set to 'command' because every mode except SMBUS_QUICK
> will need that. So, it is convenient to always do it. For SMBUS_QUICK
> it is superfluous but does not hurt.

Yeah, I think I was confused by this stuff.

> > If so, it would be difficult to implement this with the current i2c virtio
> > specification, as the msg.len isn't really passed from guest to host, rather it
> > is inferred using the length of the buffer itself. And so we can't really pass a
> > buffer if length is 0.
> 
> And you can't leave out the buffer and assume len = 0 then?

Would need a spec update, which I am going to send.

We would also need another update to spec to make the Quick thing
working. Lemme do it separately and we merge the latest version of the
driver for linux-next until then.

I checked the code with i2cdetect -q and it worked fine, I was
required to do some changes to the backend (and spec) to make it work.
I will propose the changes to the spec first for the same.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
