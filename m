Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183FDC54EE9
	for <virtualization@archiver.kernel.org>; Fri, 16 Sep 2022 05:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94EF983EC3;
	Fri, 16 Sep 2022 05:39:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 94EF983EC3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=C/8AA994
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gTHvCLbafOOg; Fri, 16 Sep 2022 05:39:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 397FF83E10;
	Fri, 16 Sep 2022 05:39:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 397FF83E10
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CB17C0032;
	Fri, 16 Sep 2022 05:39:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8AFCC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 05:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8067183E79
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 05:39:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8067183E79
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MWZB2mQfEK9d
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 05:39:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA3EC83E10
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA3EC83E10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 05:39:16 +0000 (UTC)
Received: by mail-qk1-x730.google.com with SMTP id h28so15004479qka.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 22:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=bGui9tpfbXaXph8yxfFfUUcX4Z55523adcOMpqhHVIA=;
 b=C/8AA994O/cZ8hxBpVbmkDWFQfLeN6vQtNqHpX0NNuUGzSxZxIHZzLci5+nTSoRXpR
 0PNc6NT531M56yKg2ezoxMYWIl/G0ZlG+uKkkZUyibSwjts034ATPq+1z04kYvc9DWR/
 YzZORv9pie2TCV56Ni9+JL28+DZbu+kBQpgXtCifI7omPtjgazEWLetEzGKEVoWIzsTc
 wILX9HC95d82SGDP8z+kDfMXpIXvwFIse+9dRbQJbLl8FouPb5lVBO1zr9MJ7BwFRYzZ
 lpP6ghO61dHv4FkMcCcGrxoUo1s2KELgYEBUgMPoDijeo4RUmuD/AR/OJDJpar6hlhwG
 hNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=bGui9tpfbXaXph8yxfFfUUcX4Z55523adcOMpqhHVIA=;
 b=ZuF6tCGTMM5835Ov3kqfgHRL/K94Sw6gvdIMJBEHqV9i9IvEBfD/9FlvTDFHN1sdu1
 /a+p+Wn7F64AvHSNpFKklgt4VGOrgh6joaN1p2sb4z6wLzZbzev9/SkOIuTM0cqpAu2A
 0zRl+OuOq4c30HKw8n1Xzbxo4ZMGe7zvSU5P2iPSDtG9Jo4KeVzrcZxB94l/tjbHQ1sX
 Z7tM206ZO0OTjqegjs9DV8elJp0d1WM0jHs8j+r+Isor7rDctJZwVKIrgg9sVXgIdSjU
 Rv991QFXWSfluv/0n+u49gzKZkdZtZnwEZB0Jw3qWZznje155wx66WCtkaxlqeUHtGsu
 jtGA==
X-Gm-Message-State: ACrzQf1k7A9NRlxWa1RhDCz8KrexKxPD6UtoPam86r888ar1l2m+QJAM
 v6W7H3oHXOgxG3h5d41l/pUjb6S3L6FkWkGUqw8=
X-Google-Smtp-Source: AMsMyM44vljsR7IclcEs7VK9H0/h5xHSaFlh8ZSSxTaRFWhLWFsZx7TrUpGOdPjr32yxI7b0FYCkJK8CYLul6GgbXLU=
X-Received: by 2002:a05:620a:2552:b0:6ca:bf8f:4d27 with SMTP id
 s18-20020a05620a255200b006cabf8f4d27mr2746831qko.383.1663306755654; Thu, 15
 Sep 2022 22:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220915022343.4001331-1-windhl@126.com>
 <f7316f94-433f-d191-0379-423c22bec129@csail.mit.edu>
 <89a1b1f.165e.18344069cab.Coremail.windhl@126.com>
In-Reply-To: <89a1b1f.165e.18344069cab.Coremail.windhl@126.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Sep 2022 08:38:39 +0300
Message-ID: <CAHp75Vd-ZdHJfjdgob7=e3X_=NQR_chWZzTiSVU64S9eTiAY0g@mail.gmail.com>
Subject: Re: Re: [PATCH] jailhouse: Hold reference returned from of_find_xxx
 API
To: Liang He <windhl@126.com>
Cc: jgross@suse.com, jailhouse-dev@googlegroups.com, jan.kiszka@siemens.com,
 mark.rutland@arm.com, virtualization@lists.linux-foundation.org,
 robh+dt@kernel.org, wangkelin2023@163.com,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Fri, Sep 16, 2022 at 5:02 AM Liang He <windhl@126.com> wrote:
> At 2022-09-16 07:29:06, "Srivatsa S. Bhat" <srivatsa@csail.mit.edu> wrote:
> >On 9/14/22 7:23 PM, Liang He wrote:

..

> >>  static inline bool jailhouse_paravirt(void)
> >>  {
> >> -    return of_find_compatible_node(NULL, NULL, "jailhouse,cell");
> >> +    struct device_node *np = of_find_compatible_node(NULL, NULL, "jailhouse,cell");
> >> +
> >> +    of_node_put(np);
> >> +
> >> +    return np;
> >>  }
> >
> >Thank you for the fix, but returning a pointer from a function with a
> >bool return type looks odd. Can we also fix that up please?
> >
>
> Thanks for your review, how about following patch:
>
> -       return of_find_compatible_node(NULL, NULL, "jailhouse,cell");
> +       struct device_node *np = of_find_compatible_node(NULL, NULL, "jailhouse,cell");
> +
> +       of_node_put(np);
> +
> +       return (np==NULL);

This will be opposite to the above. Perhaps you wanted

  return  !!np;

Also possible (but why?)

  return np ? true : false;

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
