Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1534C6FA8B
	for <virtualization@archiver.kernel.org>; Fri, 16 Sep 2022 08:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47C0C41BE3;
	Fri, 16 Sep 2022 08:47:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 47C0C41BE3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=FJi75foO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MKIGP4Hyw8kA; Fri, 16 Sep 2022 08:47:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7179E41BC0;
	Fri, 16 Sep 2022 08:47:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7179E41BC0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D004C0032;
	Fri, 16 Sep 2022 08:47:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFBC4C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 08:47:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B29C28426B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 08:47:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B29C28426B
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=FJi75foO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mUQaqNtx6x5T
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 08:47:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E862B8425D
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E862B8425D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 08:47:13 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id cj27so3278463qtb.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=YNQhhnLP2IaYIDCSrmAb0DLC6VTKZOy/Bj93eUvHKMk=;
 b=FJi75foOExmtuxypz3Xi9WUQC6nNaftvRns2MPo2G93f2eM2BYttloXJJqWQtguebl
 Gvnmgf1F5phEYtkc5x6Uk7yekktil/7IwfL3tD8Ae3j3i+ry7UOOtMaQZjwO5fnf3Nnn
 /N09gMYBqX/F2c2VADdz+mdpqtdzqNXsywGoQZwueqQOi4cJSnyXV422IDrLjtHTlYiD
 spIODoF9e4Uvg2fnzN/EyZzCRdIpwXH4eYsOOUeZODUyYqSRO4iAFC0zE0LGwKaClPyk
 XedLOaCqIoFK0WMd0N+eDRwTK3H2zDC2DwSCqRZlIyzEaDp0Pd7LpaTNv49lZG2bOb1y
 3gKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=YNQhhnLP2IaYIDCSrmAb0DLC6VTKZOy/Bj93eUvHKMk=;
 b=wfnaZLAj31VTLEOr9avGau93cHetIE7/ze0SayU/vogF8pG4oX8iNCQq8d60VcAomQ
 DccFJzbuxKlxKJ0oAa0qpF8cKISSdNe/gRXQBTBm68xo7BLMIaBpLm18Y65cEtQTEtsA
 sA5eLQaX3QDmqGVdofLGbAhfF0oQRsUSUx9edL2pIDYNkGStuWP2v6gnbvHuoUpZAJF3
 wGi9R4Enys7S8t3b+VTlelZJJLdPLMt3T8em7d/PVkgsQAlgD5qY7RUbXfTKWhwGHALi
 jvCi/BZT8D2U+JbIkf3L3RU/4hWa898Veb6kQq4mknH2DZ/XyHqcXBWdKDqDggAAvmbW
 9K0Q==
X-Gm-Message-State: ACrzQf2/J1lkHK/ID226vvUD9fuplk3WwqoFr2QAOzajGnEocT/EPJO8
 FBBiYL3sE+X8x11Fg3CqMPR3ZUHf/C3s+nV8xqc=
X-Google-Smtp-Source: AMsMyM4LfpNcDiSq3jKoQg4wR435CJgg/DKANzpsa2x3JtAo53BMy2C7x+xfuHj5zvAa7iOtFUx3GkcLs16oKGmKBnc=
X-Received: by 2002:ac8:7f92:0:b0:344:8cd8:59a1 with SMTP id
 z18-20020ac87f92000000b003448cd859a1mr3479496qtj.384.1663318032278; Fri, 16
 Sep 2022 01:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220915022343.4001331-1-windhl@126.com>
 <f7316f94-433f-d191-0379-423c22bec129@csail.mit.edu>
 <89a1b1f.165e.18344069cab.Coremail.windhl@126.com>
 <CAHp75Vd-ZdHJfjdgob7=e3X_=NQR_chWZzTiSVU64S9eTiAY0g@mail.gmail.com>
 <7f9efc57.4645.183451f5b84.Coremail.windhl@126.com>
In-Reply-To: <7f9efc57.4645.183451f5b84.Coremail.windhl@126.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Sep 2022 11:46:36 +0300
Message-ID: <CAHp75VfQHnt2YxuxbFo96tfDrHEZpEqSFKFV_D7ERe6uXEnvEQ@mail.gmail.com>
Subject: Re: Re: Re: [PATCH] jailhouse: Hold reference returned from
 of_find_xxx API
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

On Fri, Sep 16, 2022 at 10:09 AM Liang He <windhl@126.com> wrote:
> At 2022-09-16 13:38:39, "Andy Shevchenko" <andy.shevchenko@gmail.com> wrote:
> >On Fri, Sep 16, 2022 at 5:02 AM Liang He <windhl@126.com> wrote:
> >> At 2022-09-16 07:29:06, "Srivatsa S. Bhat" <srivatsa@csail.mit.edu> wrote:
> >> >On 9/14/22 7:23 PM, Liang He wrote:

...

> >> >>  static inline bool jailhouse_paravirt(void)
> >> >>  {
> >> >> -    return of_find_compatible_node(NULL, NULL, "jailhouse,cell");
> >> >> +    struct device_node *np = of_find_compatible_node(NULL, NULL, "jailhouse,cell");
> >> >> +
> >> >> +    of_node_put(np);
> >> >> +
> >> >> +    return np;
> >> >>  }
> >> >
> >> >Thank you for the fix, but returning a pointer from a function with a
> >> >bool return type looks odd. Can we also fix that up please?
> >>
> >> Thanks for your review, how about following patch:
> >>
> >> -       return of_find_compatible_node(NULL, NULL, "jailhouse,cell");
> >> +       struct device_node *np = of_find_compatible_node(NULL, NULL, "jailhouse,cell");
> >> +
> >> +       of_node_put(np);
> >> +
> >> +       return (np==NULL);
>
> >This will be opposite to the above. Perhaps you wanted
>
> Sorry, I wanted to use 'np!=NULL'
>
> >  return  !!np;
> >
> >Also possible (but why?)
> >
> >  return np ? true : false;
>
> So, can I chose 'return np?true: false;' as the final patch?

Of course you can, it's up to the maintainer(s) what to accept.

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
