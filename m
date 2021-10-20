Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6690BC433F5
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 11:03:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A493613A3
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 11:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A493613A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFF5E60C29;
	Wed, 20 Oct 2021 11:03:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u5xY20Vmo5LP; Wed, 20 Oct 2021 11:03:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 76FF460C15;
	Wed, 20 Oct 2021 11:03:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C56EC0011;
	Wed, 20 Oct 2021 11:03:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C136C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 11:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D9AE560C16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 11:03:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vY04RPdmigWR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 11:03:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2E39860C15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 11:03:19 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id f5so22156488pgc.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 04:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8A9C5E8tdK3Q1/o4m/27R2aNTTSBIWA+hDzCu4axFW0=;
 b=XL2jKHlr/fyCAFaxWGlvHVmU8AtpFp0D/QTIzup/lf4toTqvizjmReZiGgUfASJQWz
 qhRSldMBBAPK0WZr9mOTUoRTtp+gFoRbGHhjo24DFksiOmhma/THWyHmPIDYjci7mXV/
 DGDi02PbSGfW4iux8MsflOkpO0GFekIfyoAMA4RJ2ESOJx+4zFjK+YU9XPxXUcrYJ1T2
 iu+aFFLvfhgwoz3Bmp3qz+84Hzjf5H/QcPceMTHaaAlRUxG0WxaEjgG4W/i25u8mgNTn
 IfIzOGQv0Ka4lvz4qFlc+1IrL+y2DsNn11SBk8YfQEKaxbSyNVuh0x948ZwqCCLTVt64
 LSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8A9C5E8tdK3Q1/o4m/27R2aNTTSBIWA+hDzCu4axFW0=;
 b=nbc/6B+aeFDOoq9E7n/47iJ1F2PZFgtImWizdV9ah6ysYJLYmY4dZhwCko/nde0sw3
 pZbmR1XdccAXu3OWg9Hn9zAeKdKO2kMjsD02ONrQ/NlsizBBGFuDLmT549QOMMsFuZn4
 jkZ5qL0uPFekyFcPa646SrjofcWLKnVovOY3KSYIn0NI5OrzugieFkssyULy5RqFQsNu
 YssbewhLj96uPv1mi+QEEqfmjuNHdp618iuAru3SElhDRNchbqOOGBFBzHKosPGGHaz4
 EQdovX9K2ISoh1RcrGW4IjV8+I1sbDd2dy8J2X5Q3iW2TTb3RSO5s/WWu+d40mFPRyu/
 htRQ==
X-Gm-Message-State: AOAM531kF4Y8FLSnqroofJQRe16EpLireBoKH7M1r50dTJR4z44ck8QL
 RbQiSn99WNCiToBY5y3RLZC40A==
X-Google-Smtp-Source: ABdhPJyWkuXXFp3ZxNT7p7PUzM9PhzJYLXZlo4BivbFG7A9jO5Flh1SqidEe2k3WzY/nScRxzTDanw==
X-Received: by 2002:a63:6b82:: with SMTP id g124mr732952pgc.20.1634727799170; 
 Wed, 20 Oct 2021 04:03:19 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id ob5sm6296790pjb.2.2021.10.20.04.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Oct 2021 04:03:18 -0700 (PDT)
Date: Wed, 20 Oct 2021 16:33:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH 1/2] i2c: virtio: disable timeout handling
Message-ID: <20211020110316.4x7tnxonswjuuoiw@vireshk-i7>
References: <20211019094203.3kjzch7ipbdv7peg@vireshk-i7>
 <YW6pHkXOPvtidtwS@kroah.com>
 <20211019143748.wrpqopj2hmpvblh4@vireshk-i7>
 <YW8LFTcBuN1bB3PD@ninjato>
 <94aa39ab-4ed6-daee-0402-f58bfed0cadd@intel.com>
 <YW+q1yQ8MuhHINAs@kroah.com>
 <8e182ea8-5016-fa78-3d77-eefba7d58612@intel.com>
 <20211020064128.y2bjsbdmpojn7pjo@vireshk-i7>
 <01d9c992-28cc-6644-1e82-929fc46f91b4@intel.com>
 <20211020105554.GB9985@axis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211020105554.GB9985@axis.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Greg KH <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Wolfram Sang <wsa@kernel.org>,
 kernel <kernel@axis.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
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

On 20-10-21, 12:55, Vincent Whitchurch wrote:
> If the timeout cannot be disabled, then the driver should be fixed to
> always copy buffers and hold on to them to avoid memory corruption in
> the case of timeout, as I mentioned in my commit message.  That would be
> quite a substantial change to the driver so it's not something I'm
> personally comfortable with doing, especially not this late in the -rc
> cycle, so I'd leave that to others.

Or we can avoid clearing up and freeing the buffers here until the
point where the buffers are returned by the host. Until that happens,
we can avoid taking new requests but return to the earlier caller with
timeout failure. That would avoid corruption, by freeing buffers
sooner, and not hanging of the kernel.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
