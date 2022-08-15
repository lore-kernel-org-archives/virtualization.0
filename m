Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0684BC00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 08:02:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7728C408F8;
	Mon, 15 Aug 2022 08:02:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7728C408F8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z24iyj5x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YSAmHmu3XkiM; Mon, 15 Aug 2022 08:02:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A350341571;
	Mon, 15 Aug 2022 08:02:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A350341571
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 757AAC0033;
	Mon, 15 Aug 2022 08:02:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 308F0C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 08:02:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E1DFA41571
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 08:02:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1DFA41571
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yKJN86mpxwAU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 08:02:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6FFB9408F8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6FFB9408F8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 08:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660550534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Jg8oqAlmws/gbyv4WS+sTS1PPZS3LzrawxvloBs8oY=;
 b=Z24iyj5xhKIKE1u3wG4s7TIf7Nrm7kwvTQEKAlSPxyZlY3ZWDMvHsLGX2O8BVeSMxcyjmz
 EqRIPNbAYtE6aTqSkVXmQzZMSlX0FiUOOs9C+u7V3kxrQTcLAYMteXQAqsK7bVR6WDZvth
 3KOsdhkH0oAiJKd7eToCrd5i1D844mc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-592-dcP82rvzNaqo6o8WAaQuFQ-1; Mon, 15 Aug 2022 04:02:13 -0400
X-MC-Unique: dcP82rvzNaqo6o8WAaQuFQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 ga16-20020a1709070c1000b007331af32d3aso923548ejc.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 01:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=4Jg8oqAlmws/gbyv4WS+sTS1PPZS3LzrawxvloBs8oY=;
 b=aiY8Lc2cycMn36+TwhRujyQmXeAr/gOLlyFbqK762aOOSN8ky2UypyJ82tq/z9lY3/
 /fyoPLK+jfb9BpwZwdfqOxPFevEnur8A0jipe/dTiDBCdFEAD7jOdYS1A293Z3KjxIw6
 fWXJHHPGzFNFl6OTSjHuvoTnnWKtpWklujK2CePP+QnyEkJuMw4SR2Is/g9Q4UoLoBwK
 eiWYi0rFYWlL3NGuiAtdpuWBusrZsAT44IcqimbM0MP3ZDlBZLSPymxMaMlg9S/zMVO9
 Xx2BvTjNe7m1TXn9FmzyasGRqhLolkbdeOWwBt2iNm4yRkvSVFLiFkoe19NUehH2pC9f
 5fXw==
X-Gm-Message-State: ACgBeo2eeix0Rf7S48KT5f20oGCzdhs3uNMZf9ydAMp20l1f8pmaJU4A
 BslG7JwgM0u/1a4BwF9m0A7S/B7pAXdkhZfV7zoplddKyggQk96cSAAGOonoK85gOTDj/MUVWPW
 /dCLnFuoDmnunEVxGozEu49IAnAg3GDWKAjMBUzOZZQ==
X-Received: by 2002:a17:907:c0d:b0:730:a85d:8300 with SMTP id
 ga13-20020a1709070c0d00b00730a85d8300mr9882745ejc.558.1660550531936; 
 Mon, 15 Aug 2022 01:02:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4SndJAy1focKXdgrNdhVF4iukl3tw5+oox/Lgaz/m0ZIdCPTQsgSe8Nmrvc7s0AInVcbyaOg==
X-Received: by 2002:a17:907:c0d:b0:730:a85d:8300 with SMTP id
 ga13-20020a1709070c0d00b00730a85d8300mr9882725ejc.558.1660550531668; 
 Mon, 15 Aug 2022 01:02:11 -0700 (PDT)
Received: from redhat.com ([2.54.169.49]) by smtp.gmail.com with ESMTPSA id
 er6-20020a056402448600b00443d8118155sm789834edb.69.2022.08.15.01.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 01:02:11 -0700 (PDT)
Date: Mon, 15 Aug 2022 04:02:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andres Freund <andres@anarazel.de>
Subject: Re: upstream kernel crashes
Message-ID: <20220815035406-mutt-send-email-mst@kernel.org>
References: <20220814212610.GA3690074@roeck-us.net>
 <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com>
 <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de>
 <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com>
 <1c057afa-92df-ee3c-5978-3731d3db9345@kernel.dk>
 <20220815013651.mrm7qgklk6sgpkbb@awork3.anarazel.de>
 <CAHk-=wikzU4402P-FpJRK_QwfVOS+t-3p1Wx5awGHTvr-s_0Ew@mail.gmail.com>
 <20220815071143.n2t5xsmifnigttq2@awork3.anarazel.de>
 <20220815031549-mutt-send-email-mst@kernel.org>
 <3df6bb82-1951-455d-a768-e9e1513eb667@www.fastmail.com>
MIME-Version: 1.0
In-Reply-To: <3df6bb82-1951-455d-a768-e9e1513eb667@www.fastmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 netdev@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>
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

On Mon, Aug 15, 2022 at 12:46:36AM -0700, Andres Freund wrote:
> Hi,
> 
> On Mon, Aug 15, 2022, at 00:29, Michael S. Tsirkin wrote:
> > On Mon, Aug 15, 2022 at 12:11:43AM -0700, Andres Freund wrote:
> >> Hi,
> >> 
> >> On 2022-08-14 20:18:44 -0700, Linus Torvalds wrote:
> >> > On Sun, Aug 14, 2022 at 6:36 PM Andres Freund <andres@anarazel.de> wrote:
> >> > >
> >> > > Some of the symptoms could be related to the issue in this thread, hence
> >> > > listing them here
> >> > 
> >> > Smells like slab corruption to me, and the problems may end up being
> >> > then largely random just depending on who ends up using the allocation
> >> > that gets trampled on.
> >> > 
> >> > I wouldn't be surprised if it's all the same thing - including your
> >> > network issue.
> >> 
> >> Yea. As I just wrote in
> >> https://postgr.es/m/20220815070203.plwjx7b3cyugpdt7%40awork3.anarazel.de I
> >> bisected it down to one commit (762faee5a267). With that commit I only see the
> >> networking issue across a few reboots, but with ebcce4926365 some boots oops
> >> badly and other times it' "just" network not working.
> >> 
> >> 
> >> [oopses]
> 
> >> If somebody knowledgeable staring at 762faee5a267 doesn't surface somebody I
> >> can create a kernel with some more debugging stuff enabled, if somebody tells
> >> me what'd work best here.
> >> 
> >> 
> >> Greetings,
> >> 
> >> Andres Freund
> >
> > Thanks a lot for the work!
> > Just a small clarification:
> >
> > So IIUC you see several issues, right?
> 
> Yes, although they might be related, as theorized by Linus upthread.
> 
> > With 762faee5a2678559d3dc09d95f8f2c54cd0466a7 you see networking issues.
> 
> Yes.
> 
> 
> > With ebcce492636506443e4361db6587e6acd1a624f9 you see crashes.
> 
> Changed between rebooting. Sometimes the network issue, sometimes the crashes in the email you're replying to.
>

OK just adding:

    Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
    Acked-by: Jason Wang <jasowang@redhat.com>
	L: virtualization@lists.linux-foundation.org
	L: netdev@vger.kernel.org

I think we can drop the original Cc list:

Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>

but I'm not sure, maybe they want to be informed.

> 
> > MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
