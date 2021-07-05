Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE06C07E9A
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 09:38:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF5D613BD
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 09:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF5D613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D90C5401B8;
	Mon,  5 Jul 2021 09:38:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L1m5b3uV48Nt; Mon,  5 Jul 2021 09:38:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 89FBC400B5;
	Mon,  5 Jul 2021 09:38:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59F31C0010;
	Mon,  5 Jul 2021 09:38:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C23D4C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 09:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3837400C6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 09:38:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z4nX3_J1q2Xs
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 09:38:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 95C1B400B5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 09:38:43 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id q91so11395155pjk.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=N8hIsrfFLK/2fysdRAf2HmCsPkpZLqChCVq+sN96CK0=;
 b=ZfimxbTmkj7HgeUqV2zuTBqyMmPTk+kT/xnWRb5YOaRD2L0ZDEYBWaE8vAoETumG9Y
 y9bO+O57OeKB0LcBJAP3vNCzvGz+Irsgih05umjacIU665atpiU+hsUTPhrYUhxBMf8E
 WbPa4D4T1QAz0D/Ew6Zwf16xo8HjxEAi5+dQkF/W0J7ARTi6f3ObvvflVyCehgaT9J1f
 EJa2/ugXZ1Qb5t51f5GKkQ60Lsla0764LPokF4fgCHseaTSc8fieunlbik515efim5Z/
 cdkC8c7XGgACr1gDmNDCIlhVnqkeW9Ttaj9XNQo1qt1bJjfePmaLqNDXaDNZ8QAToe7F
 nn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N8hIsrfFLK/2fysdRAf2HmCsPkpZLqChCVq+sN96CK0=;
 b=D/euGrhc4ZmbhlyyS3+Afvm9Gsz3/5HG43qkAcp4qtY2HJyHubPGIm9tLJv26+pJTi
 0Bjm2a87KYS+v45ph0kRFtHllAfnEKP/tOViiyj4D7b8GBymmPWDZlVJdXzwI0mlfkle
 C+oVJaZF2NByVMCIbfE6gGdolTYygyXeBRS9WrJrhnEIsM7mDQDtF89Q5OIT6EtLkfwE
 P8+Gt2xvo2tsrybaBuoTYWeUq+RwkW+RNgQ6ocRQhlNLKPzoEDByShMaX2QZsMjM2UeR
 t1jlw2NjeLd0vE6xGeYC42hIqzcs9YmQkfjxjF195EcS8q9epoMLonHtrecyf2ngmaCj
 ehNQ==
X-Gm-Message-State: AOAM530dP24pN9oC0djazdlT42IZ+9k33XEoGsEsFIDlRztQvIBtkfXQ
 gP5aYhM1QxvIIvaSwpUFXnUT/qRGoAd2n+P/LGg=
X-Google-Smtp-Source: ABdhPJzAMt+FJukCPw3nefv6guPPNvSz9T/UHEsyqI80wJBwv2O7EwFmtiaowKJfv7zFQNdH6RNCJAM+d4KMe1sStAw=
X-Received: by 2002:a17:90a:17ad:: with SMTP id
 q42mr14627083pja.181.1625477922944; 
 Mon, 05 Jul 2021 02:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <8908f35a741e25a630d521e1012494e67d31ea64.1625466616.git.jie.deng@intel.com>
 <20210705080245.yabjlrgje5l7vndt@vireshk-i7>
 <CAHp75Vf0_8+KW_cp2g0V1miMx1cegBdjLzBjTbtpmcmdCHQJxA@mail.gmail.com>
 <20210705085610.okcvnhwhwehjiehy@vireshk-i7>
In-Reply-To: <20210705085610.okcvnhwhwehjiehy@vireshk-i7>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 5 Jul 2021 12:38:04 +0300
Message-ID: <CAHp75VeE4Du29XJV54VWR4CH4yfCEqokRUFFRY_sdMKsp1oXyQ@mail.gmail.com>
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

On Mon, Jul 5, 2021 at 11:56 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 05-07-21, 11:45, Andy Shevchenko wrote:
> > On Mon, Jul 5, 2021 at 11:03 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > On 05-07-21, 14:53, Jie Deng wrote:
> >
> > > > +#include <linux/types.h>
> > > > +#include <linux/const.h>
> > >
> > > Both of these need to be the uapi headers as Andy said earlier
> >
> > They are already since this header _is_ UAPI,
>
> Ahh, there is some tricky header inclusion there :)
>
> > what you are suggesting is gonna not work,
>
> Why ?

Because we do not have "uapi" in the path in /usr/include on the real
system where the linux-headers (or kernel-headers) package is
installed.

It's still possible that our installation hooks will remove that
"uapi" from the headers, but I think it makes things too complicated.

> > although it's correct for in-kernel users of UAPI
> > headers.


-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
