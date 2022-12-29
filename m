Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEECC3DA7D
	for <virtualization@archiver.kernel.org>; Thu, 29 Dec 2022 21:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1DAC7402D7;
	Thu, 29 Dec 2022 21:06:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1DAC7402D7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=ad35wNtS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OM8YORWTgTMD; Thu, 29 Dec 2022 21:06:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7627640111;
	Thu, 29 Dec 2022 21:06:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7627640111
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 420E1C0032;
	Thu, 29 Dec 2022 21:06:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACC66C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 21:06:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8102360AC0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 21:06:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8102360AC0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=ad35wNtS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Vn6hcUAd8yg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 21:06:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8308860A81
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8308860A81
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 21:06:40 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id b12so13070355pgj.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 13:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZdskgyIi5HvpyNp2iKqow1i130J9BhAc/PjmQQc1hHw=;
 b=ad35wNtSjdI2C7J3TWPZ7Q8fIEr9Bs3nUGzfTBRwMSBzbHzk9t6nZHlvb8WgQXxam2
 AdNKd88jl1U2+amMvOchU/jBkR5SWNBisccrdJss2PKcttHr5XrBYv4KS3YS0AbnKrYb
 yi+OXqFbHVo8g+dkfaiFOrIlSwEgv1py6pyCG2a3R4m661kObNmU32v/iDyjChFK/t/6
 v0zV+PQxvPBVCDvX9tShxX0q+D41iJa32AJq1RmvZps4ZN2dSQN/6QtkT+jrtoSFwZ93
 ZDMQt5JptE6vqKdqutTEe5d2ZTZaTLzEfF4Mb/ppgPPUp0Z7YIM1jokounBhHivFJV68
 MivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZdskgyIi5HvpyNp2iKqow1i130J9BhAc/PjmQQc1hHw=;
 b=obmLd649dy3/YValEa6qctNnA48Xv6ZemBU4ftFntRUPvtV/anuX7L0eEAdXu24Xpj
 yrFwtJ/D+IDv9ScY/dDglaSZbfMEgdbNg9+VWzdSFOhLsy79/nA8BYzYS9hYDpNYErJ3
 GsF5eAWIxHq8J7uSYqBPNvDfEefE50alttPssmffpOLXS78oL0jkf36E596yH7uK1VHX
 FWgE3+DkZtK1pGeI5uSZUisjkprOL5K6XprGqq0mkSbgO8HHHR1qTlYqstPR6pm6uw4T
 G8rYupLF6YJy2ZMZ+o2YbEeZDQKK04lLwOI3HDO+4ezkjGORwPBGgBJav7OCJi1DI1MX
 4ubw==
X-Gm-Message-State: AFqh2kqy1LpKCwD0Ha5hHFNxZ66sOGQdjifZi4HLLn48KZoJlk++txDK
 8/Owrs0Pak6D70XvspUN7ld8m3QIYB9T0yQJ0/v+TA==
X-Google-Smtp-Source: AMrXdXvMcn8YEvNjJqpoYiiBYNqx15HArmsbU6syFt6sA+P3D05TjOJlkq+YTTlnsJrx4TbdXxRlCvGksokcQ1Jka78=
X-Received: by 2002:a63:40c5:0:b0:489:17a2:a53d with SMTP id
 n188-20020a6340c5000000b0048917a2a53dmr1503230pga.255.1672347999807; Thu, 29
 Dec 2022 13:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20221219083511.73205-2-alvaro.karsz@solid-run.com>
 <20221229195551.GA626165@bhelgaas>
In-Reply-To: <20221229195551.GA626165@bhelgaas>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Thu, 29 Dec 2022 23:06:02 +0200
Message-ID: <CAJs=3_AJnj9udpJ1LRtC+9qvo5Fw-=FjvZRqZkHCaQSEP-FyYg@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/3] Add SolidRun vendor id
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

Hi Bjorn,

> Hi Alvaro,
>
> On Mon, Dec 19, 2022 at 10:35:09AM +0200, Alvaro Karsz wrote:
> > The vendor id is used in 2 differrent source files,
> > the SNET vdpa driver and pci quirks.
>
> s/id/ID/                   # both in subject and commit log
> s/differrent/different/
> s/vdpa/vDPA/               # seems to be the conventional style
> s/pci/PCI/
>
> Make the commit log say what this patch does.
>
> > Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
>
> With the above and the sorting fix below:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> > ---
> >  include/linux/pci_ids.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index b362d90eb9b..33bbe3160b4 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -3115,4 +3115,6 @@
> >
> >  #define PCI_VENDOR_ID_NCUBE          0x10ff
> >
> > +#define PCI_VENDOR_ID_SOLIDRUN               0xd063
>
> Move this to the right spot so the file is sorted by vendor ID.
> PCI_VENDOR_ID_NCUBE, PCI_VENDOR_ID_OCZ, and PCI_VENDOR_ID_XEN got
> added in the wrong place.
>
> >  #endif /* _LINUX_PCI_IDS_H */
> > --

Thanks for your comments.

The patch was taken by another maintainer (CCed)
https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=linux-next&id=afc9dcfb846bf35aa7afb160d5370ab5c75e7a70

So, Michael and Bjorn,
Do you want me to create a new version, or fix it in a follow up patch?

BTW, the same is true for the next patch in the series, New PCI quirk
for SolidRun SNET DPU
https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=linux-next&id=136dd8d8f3a0ac19f75a875e9b27b83d365a5be3

Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
