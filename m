Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBBFC07E98
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 08:46:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DFFD613CB
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 08:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFFD613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 030E8400DE;
	Mon,  5 Jul 2021 08:46:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YnP-3yMdkkqu; Mon,  5 Jul 2021 08:46:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AA782400B5;
	Mon,  5 Jul 2021 08:46:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 784DDC001A;
	Mon,  5 Jul 2021 08:46:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4819FC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 08:46:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 254AB40450
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 08:46:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RmQhgTPujBRL
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 08:46:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6BB4140407
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 08:46:00 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id s13so6782380plg.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 01:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6tzBQn21ISHfDplCImGeslYtqyN4YOQPVRToQhASUVY=;
 b=lsyuPfdJN1JWMUyysgrmTUfLuyr+r0n/yyXQm8uXA8jGs2fsp5d4/xg38840DuDWnP
 dNwFse8mYFi+94lzCONUh+VbsDypmP81Gh2xIx/jklcTzT0DJbocwiXiasCTWRv9h3Fs
 Qsu0ukBiK1gHvejWCW+J4KessUsdPdovGVfQSfGAW6fuAAl5ooVWYkpdMxDhNsAPl64E
 y3O0fJcB2t51hSu5/KJNeVRB7lEkDoV2AxlnEioAB4vJDsJ4d60MXfUfvtrsOIubi6tB
 0H2WFtDCmj/EQs/tc0f96x0/ZANR04KZEdWJCJdFipN2zFC98IzkhaGHGG02AbZ1Sqbm
 72WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6tzBQn21ISHfDplCImGeslYtqyN4YOQPVRToQhASUVY=;
 b=YIMoNNUoFKLOZ0VXJ7MOHQqgzHazJ9x/8nmVQD6i8DnHmLx+MQTk75vqJt6EjgKEsF
 IJpIJYtOQ2+5TLnlY3ScnHCFaZ1ZdJT7k5PCuZuRQ29VuozF1fljLve80jcrUFUCcyR7
 JaIDaVS1fL5rFBkKsEkUoz6yLGNM8Fu348eAfrDsWx54CFPLhqP5RqIAm2riTFqYgekt
 XBFwFkw3qsiwMXSH+vNQCrG4OuhlQcjXwON7VirMr0pdqDUYK7VrR4wS08nfAFDq/UcV
 lJqhg4M8Riudw7+19kSvNR2N7Nsfw96TIqFBu+lVrptNqFl1puZbl/Dg+9P4fWVwXoB2
 tZrg==
X-Gm-Message-State: AOAM531rGwlqdyQ1GpsYAu+t/2K94HJm99qYxjVw94ytW6BFPpyLyiB+
 4h6HvYTA57tpc3Nogi78QqMtjr53Nx8mly2VzrU=
X-Google-Smtp-Source: ABdhPJxaGRHGr1fnUoBJYB2DuDcGdLzBdN2BoqqbsjtiY+qO7FtCAXUoJSviJ2x8m0W3QCYd0ctKBmkOnhJEbg53W+A=
X-Received: by 2002:a17:902:fe0a:b029:11d:81c9:3adf with SMTP id
 g10-20020a170902fe0ab029011d81c93adfmr11680070plj.0.1625474759804; Mon, 05
 Jul 2021 01:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <8908f35a741e25a630d521e1012494e67d31ea64.1625466616.git.jie.deng@intel.com>
 <20210705080245.yabjlrgje5l7vndt@vireshk-i7>
In-Reply-To: <20210705080245.yabjlrgje5l7vndt@vireshk-i7>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 5 Jul 2021 11:45:23 +0300
Message-ID: <CAHp75Vf0_8+KW_cp2g0V1miMx1cegBdjLzBjTbtpmcmdCHQJxA@mail.gmail.com>
Subject: Re: [PATCH v13] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
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

On Mon, Jul 5, 2021 at 11:03 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 05-07-21, 14:53, Jie Deng wrote:

> > +#include <linux/types.h>
> > +#include <linux/const.h>
>
> Both of these need to be the uapi headers as Andy said earlier

They are already since this header _is_ UAPI, what you are suggesting
is gonna not work, although it's correct for in-kernel users of UAPI
headers.

>  and they better
> be in alphabetical order.

I prefer that as well.

> #include <uapi/linux/const.h>
> #include <uapi/linux/types.h>

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
