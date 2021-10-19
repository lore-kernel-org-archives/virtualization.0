Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77869C433F5
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 09:42:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE3060EE3
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 09:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1FE3060EE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CE5A3404DA;
	Tue, 19 Oct 2021 09:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ge-LRZaZ8Cpu; Tue, 19 Oct 2021 09:42:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4678C4036B;
	Tue, 19 Oct 2021 09:42:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A234C0011;
	Tue, 19 Oct 2021 09:42:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CB85C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 09:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3786860690
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 09:42:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8WR0jd98wFfU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 09:42:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4647D60B00
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 09:42:06 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id y7so17116980pfg.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 02:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZObreM2oofTkM3qJIYvGBPc4dPhqrsVSh4sl9pXqX94=;
 b=gvXmPjPnRSNvISobWg1zZ6bO0AluECpeMJn/Wtis+JgxiwNWlke4JGvx/mqVLqczl8
 4jegSqD2RFGK0e+025gFJmGB8Qvce8i7b/zZvQ5P1o4tLw1CzTJCwwCocqUq7fuHZO+p
 MysEs4HafXErdZiKjnpU0yu+cum9rB5wSlO9OOgu1EapetCEmzj0NnS7gBq21lAK4Hmb
 us2FlYi0wzPlsPFN+EMKrExs6+LEEyUnmsxebLREjpYBNZbdZXV2nC9luLFkNAXb785e
 VKs72+TSrOMuYyZ1MUsqyan//oK3gDLuHtSMWLNH5V4uXwMqvV5oIPkyMVN3VdplB57K
 d2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZObreM2oofTkM3qJIYvGBPc4dPhqrsVSh4sl9pXqX94=;
 b=rmCSlTeyVuVQo9yMMbjLB7WcBzUwAVcIazv0Pv2+77Sko9On/E5Hi/0UCLUSeOF676
 q6GDpCaQI07mo69bxhxyllLXj4kzKJV166I5R0rRyd0KEn2JOQfqfbTp8WfAgP+epNoA
 q1wdNg9NYu97MAbOSZAvIWcKo+5a2dqxNvSYR3D+Z49gdttvEepthukKXKLGq+Pn7mA+
 s170Tsq59LTTex1ClXSJwp/aUW953T7w5FTQAflG+apk2V154scflYqhd4oPtDrwh7JR
 vU2TC8BjKe/BB0XXDIZ0D9QcWcoYSxZtSWA1YbiJoQkLrJEzMlDLa8ere+ZZB4iUc4tC
 UrTw==
X-Gm-Message-State: AOAM531reV6G275qjia70EBrt4g60urgLJf+Ba9ZOpNV0mxa8Z1IZ/t6
 xm5Ae5VDOJKW1dGE2ixqeISeQA==
X-Google-Smtp-Source: ABdhPJxcbC3OBgUMO+Lzh3jDx/hudBuFmrzaHwnRyTDEgDNQv+z9BMlhRENFVRvc+ZiQhDZAdCws7A==
X-Received: by 2002:a63:154:: with SMTP id 81mr27360406pgb.38.1634636525679;
 Tue, 19 Oct 2021 02:42:05 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id u4sm2037379pjg.54.2021.10.19.02.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 02:42:05 -0700 (PDT)
Date: Tue, 19 Oct 2021 15:12:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] i2c: virtio: disable timeout handling
Message-ID: <20211019094203.3kjzch7ipbdv7peg@vireshk-i7>
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-2-vincent.whitchurch@axis.com>
 <20211019080913.oajrvr2msz5enzvz@vireshk-i7>
 <YW6Rj/T6dWfMf7lU@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YW6Rj/T6dWfMf7lU@kroah.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, kernel@axis.com, linux-i2c@vger.kernel.org
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

On 19-10-21, 11:36, Greg KH wrote:
> What is the "other side" here?  Is it something that you trust or not?

Other side can be a remote processor (for remoteproc over virtio or
something similar), or traditionally it can be host OS or host
firmware providing virtualisation to a Guest running Linux (this
driver). Or something else..

I would incline towards "we trust the other side" here.

> Usually we trust the hardware, but if you do not trust the hardware,
> then yes, you need to have a timeout here.

The other side is the software that has access to the _Real_ hardware,
and so we should trust it. So we can have a actually have a completion
without timeout here, interesting.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
