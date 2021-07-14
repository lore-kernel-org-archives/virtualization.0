Return-Path: <SRS0=HAf6=MG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB64C07E95
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 02:20:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E7661279
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 02:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E7661279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE844823DD;
	Wed, 14 Jul 2021 02:20:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mirAML1M8s_D; Wed, 14 Jul 2021 02:20:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 67F0D818A7;
	Wed, 14 Jul 2021 02:20:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BEB3C001C;
	Wed, 14 Jul 2021 02:20:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FBBBC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:20:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 41A574054D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:19:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 59zcg-SVNGX5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:19:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9FA4B40251
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:19:27 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id j9so601603pfc.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 19:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YUWPTzB4dLR17/T5lZ7IYCIE7LvDfGsZbPME2WfdaEQ=;
 b=Skmc4/PTwW2vYOAvkxNEp/sYehALwIe3vbYmis9pp8B8s8+wKbwKLLkS2x6Uw0hnu3
 0svGx8KcIUZK3SigWkrI1LBoqGu1Gr/zfFuUkQYY1z+GkIQJyZmhGqeDKIrbtkGJkA9/
 pV4SFmb6Em4EJHyfkvu52ERl3YZgKA2kl4gFPSlJlROoiehQQIfHPqiC99fxTZvdJuLd
 EiLrpiwCuiSYVnmy8yfgjiy36rHG6vuajRXQqWXRpeItlXDPp/KYqloeAmd8U0ejyp7Z
 +rOKfLdJcEVKX2jUAiZJFb1dHgMx8bLQzO3xc3+iNg0jTqpv8EwU3a8X/RGDZ9tV/fe8
 53JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YUWPTzB4dLR17/T5lZ7IYCIE7LvDfGsZbPME2WfdaEQ=;
 b=fBi88WwyNY8xgnlY6I6oZdoUEe3+Kr0yvknU5mPIjsaHCsiY9X8shAHzj77OGY/Hzb
 p6BXo4v93WEF7VdKucbxLKin7NObX6XQ/6lMImx/5daj4rasCwk/3mGtAa+dEc4K1L+4
 tC50Ue27t3vQfn/9kjWQXrdLgi81ylm3mxQPyj6f34OBmTexInuJGbWgAo5rG8dmUXt9
 98+a2grKys9QLBTw5+jsEPdOgP980lxYCMYQRK3lC1dlhX1QXqQlljJjDhUtZt90zO0/
 KrBi38MakZIi+NdYa2b2Yk2ITbSbWLmZzs57B7r5s7Id6aYSIPzELI2gPtyLu7QM6fyD
 qyJg==
X-Gm-Message-State: AOAM532BV2g1YawfBOtVzxRVHPPkwaaEWbL6FRJ+RnAqnRoq5Ft9jr21
 JXCvZ9d/TvWxcXOKlq2ir7xKqw==
X-Google-Smtp-Source: ABdhPJxLOPLEDHG4baKqARncau1utGS0ltDshGrrtQ4HLM6pZ8LZIXvVGdAGINqm7KHcuA2FTBkJpw==
X-Received: by 2002:a63:6e09:: with SMTP id j9mr6980452pgc.275.1626229167125; 
 Tue, 13 Jul 2021 19:19:27 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id a6sm437140pjq.27.2021.07.13.19.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 19:19:26 -0700 (PDT)
Date: Wed, 14 Jul 2021 07:49:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device
 subnode
Message-ID: <20210714021924.uob5wrasipzhbyrj@vireshk-i7>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
 <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com>
 <20210713151917.zouwfckidnjxvohn@vireshk-i7>
 <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, devicetree@vger.kernel.org,
 Bill Mills <bill.mills@linaro.org>
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

On 13-07-21, 13:34, Rob Herring wrote:
> On Tue, Jul 13, 2021 at 9:19 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > We already do this for linux-event-codes.h and so I thought it is the
> > right way of doing it :)
> 
> Humm, maybe it's okay. Please double check then...
> 
> > Else we can create a new copy, which will be a mess, or use hardcoded
> > values.
> 
> Though you may not need the header based on what Arnd and I have suggested.

Yeah, we may not need it at all. New node or not, reg property will
get converted to a compatible anyway..

Thanks.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
