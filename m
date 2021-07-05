Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D5FC07E99
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 08:56:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5696142F
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 08:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5696142F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C57760790;
	Mon,  5 Jul 2021 08:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4P-smqPdJ4a3; Mon,  5 Jul 2021 08:56:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 32D84606A3;
	Mon,  5 Jul 2021 08:56:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 147F1C001A;
	Mon,  5 Jul 2021 08:56:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00B3DC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 08:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D54A240371
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 08:56:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t7c9K3jkjP73
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 08:56:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F392D40343
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 08:56:12 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id f17so4599936pfj.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 01:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=al5EeP8QXH1RSq+yYN15w1dJ9cxYy0MXetYFBHF4BSo=;
 b=qxMcLlfGOx0W2JA5nKbBKobaGjC/IWWZnUhRyQ6J3/Ux38uY7SbIZQH3eWvXKiXIIQ
 gTGNHlA9cNQZVeFzOyeMFf9ipQXRGMbQSXZ2t2WUY/KqnsbKWGLA/xchnGdhv3D6T4Kh
 9M8IM1PcZRSN9uXxO5MWZqMoyms6DbbXqgdZNYKQL8DycFbVx6So919oFjhW5IIeF1lw
 jGNi7JgVNRAHGfoo4jHeLmEvz6DrG7P4icd03qbBvrWfQ4oL7/MkPb2HOE14rvSejuvZ
 4Zr6BZusasXGeBGZLwNBTKfKoaupAg9r1YazNL/uwaIq7jNc+6NYfqeLazMFVV8Dshum
 aL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=al5EeP8QXH1RSq+yYN15w1dJ9cxYy0MXetYFBHF4BSo=;
 b=Rc4q+vH5KrDBa8TU7Ox9I9lIkgtlamh5+1wJHQgY2ewcd3cCG1oLQUd5YoxIM36CTa
 ajg+AmQSuXWupPdLazWbwGIvzB/vuh17T/+KSM+mJj6w2Ii3oXh10Danji8lGAsxvOUw
 yBcSKeXqo469c+7nmcnIDd+t9dMuq281T9mPO6SRXBC2BNgvhQYRqscBi8H4TpsX5Ekv
 mN8Cov4HfYdhUpwpz1cjKGaDg/TZVj3gUcDeMITrl8NrXyKwU9SH3WdoRuzNZN/skSXr
 vwKepkbisN/yumqdR2muDFxFZmMmAq1ob3OBuuAK9JAAbX2MoscExWLlxKnhtOlQxXtW
 H8zQ==
X-Gm-Message-State: AOAM532Zc5AeDNcFRakvxIqf4dQUEdFk9gVnNd4BglJxgGXp3XJoTBE1
 eNz80gyBDEFWamrX7NkA3or6Mg==
X-Google-Smtp-Source: ABdhPJyIQbG4Z5iuwB551KL53cMIMxfhI49MIvYS5ne9261aa9T6dN/WzZgpRpsdddED6oNm+/NA6w==
X-Received: by 2002:a63:4c19:: with SMTP id z25mr14586040pga.160.1625475372402; 
 Mon, 05 Jul 2021 01:56:12 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id ga1sm10547756pjb.43.2021.07.05.01.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 01:56:11 -0700 (PDT)
Date: Mon, 5 Jul 2021 14:26:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v13] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210705085610.okcvnhwhwehjiehy@vireshk-i7>
References: <8908f35a741e25a630d521e1012494e67d31ea64.1625466616.git.jie.deng@intel.com>
 <20210705080245.yabjlrgje5l7vndt@vireshk-i7>
 <CAHp75Vf0_8+KW_cp2g0V1miMx1cegBdjLzBjTbtpmcmdCHQJxA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHp75Vf0_8+KW_cp2g0V1miMx1cegBdjLzBjTbtpmcmdCHQJxA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-i2c <linux-i2c@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 shuo.a.liu@intel.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 conghui.chen@intel.com, yu1.wang@intel.com
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

On 05-07-21, 11:45, Andy Shevchenko wrote:
> On Mon, Jul 5, 2021 at 11:03 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 05-07-21, 14:53, Jie Deng wrote:
> 
> > > +#include <linux/types.h>
> > > +#include <linux/const.h>
> >
> > Both of these need to be the uapi headers as Andy said earlier
> 
> They are already since this header _is_ UAPI,

Ahh, there is some tricky header inclusion there :)

> what you are suggesting is gonna not work,

Why ?

> although it's correct for in-kernel users of UAPI
> headers.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
