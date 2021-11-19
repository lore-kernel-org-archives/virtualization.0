Return-Path: <SRS0=gSim=QG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F765C433EF
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 16:27:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3558561401
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 16:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3558561401
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 026D7400DA;
	Fri, 19 Nov 2021 16:27:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yyDSH0wNWd5D; Fri, 19 Nov 2021 16:27:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 96AA041BFC;
	Fri, 19 Nov 2021 16:27:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 517C9C001E;
	Fri, 19 Nov 2021 16:27:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2004AC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 16:27:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F419741BFC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 16:27:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GtWW4mIh9Hnm
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 16:27:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5AA5741BF9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 16:27:47 +0000 (UTC)
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1My3In-1mSB0o1G2h-00zW7a for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 17:27:45 +0100
Received: by mail-wm1-f45.google.com with SMTP id p18so9013869wmq.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 08:27:44 -0800 (PST)
X-Gm-Message-State: AOAM533+GLuvIU2UZXEVfp9vp5yiiZ5sJuzVyLqzigaEL57h5TFrhFlF
 t9Hib6RR4uxlmpJSq2BBEhe3M9ih79b0S7ukxJg=
X-Google-Smtp-Source: ABdhPJw9pjl15kxNckhoztOwSEHm2BAFAg53rxD/nLG+Vq3q5u2bghokZvEuTw1FbjRLUctINZWvpCeY9JlD3tiwY20=
X-Received: by 2002:a1c:2382:: with SMTP id j124mr1036531wmj.35.1637339254218; 
 Fri, 19 Nov 2021 08:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <CAK8P3a0qT9tAxFkLN_vJYRcocDW2TcBq79WcYKZFyAG0udZx5Q@mail.gmail.com>
 <434296d3-8fe1-f1d2-ee9d-ea25d6c4e43e@gmail.com>
 <CAK8P3a2yVXw9gf8-BNvX_rzectNoiy0MqGKvBcXydiUSrc_fCA@mail.gmail.com>
 <YZfMXlqvG52ls2TE@smile.fi.intel.com>
 <CAK8P3a06CMzWVj2C3P5v0u8ZVPumXJKrq=TdjSq1NugmeT7-RQ@mail.gmail.com>
 <2d790206-124b-f850-895f-a57a74c55f79@gmail.com>
In-Reply-To: <2d790206-124b-f850-895f-a57a74c55f79@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 19 Nov 2021 17:27:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3O1KLzxSTn1xqi2HjUVw2Utf6m5PZWd1ns7xsExxbJOA@mail.gmail.com>
Message-ID: <CAK8P3a3O1KLzxSTn1xqi2HjUVw2Utf6m5PZWd1ns7xsExxbJOA@mail.gmail.com>
Subject: Re: [PATCH 00/17] Add memberof(), split some headers, and slightly
 simplify code
To: "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
X-Provags-ID: V03:K1:kTuBT3DG3xbYLf8q2Bg6PF8JP+HMxuB8pqol+eHntlRZcx9shFy
 utNFkqVR3Q2LBY/AOMN2M306zqi8xkYUbd25CYSpA/M1HbW+1HRe47uMDPL8yxV0+xlGMBy
 ZWDja7kYXkj1Z27momajxHueH1aqHsimTmkFUmFm7LCHiSXrFAkckTVVZG2qRmnBNuMpLj5
 OvAIdILMPLtwDt+YK5B3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fJKBzID4iqw=:oWgciDRvJAFjsl9Jgnc+cQ
 xJEHjA4FL+/1BJ6AroSb/B4VLQLWEhR9BMJ5WmW+V5IdKvETt6VbG+1SOHwmbzKvpsGtzC907
 UusCXzfG8B+YypqP9VPWuKACikBn/0YZcXutvMc/alZMPlncL6Ubi0GteqObVatiPordNR1SP
 EFh8F3tF9Q8Ugh0Txfvmc+QpdLIX5+cD618hys9Yb763GR6om5PDPKm6NSW/O2fV1KT0nWmE8
 2GFjxHpZI29ZUkWWOXFSoHs4PKxSc/hj5Mi/78Tzh8TnNzScYAODkTLbbetAjQpAAXAFT63Is
 bWkzhf/2jyq0e+XQ/nGcWR2gNkw7akPEm6nBogd9h3yupZSjqRWDR95Mdm7y8p9mLVTt7eFnD
 k/UdskrVuWYUAZPXRPK8JluJjBWnDPgAfBVh6M5mhRaI+bqNkjAk3RJ27O3ErgvVLc0eAzrA+
 oMW8Ycoi7MckTZ/La80iDRZq3nMt54xMEfiAP7R9tQV2ghK4ZyiV/xJxqAsfkNjQlDJTAcWil
 5wzEV6FG6oDOMy0Qqq5ubk2H0x/WlRhbznPVVDtRShuH6V9tII3xop6kxLh+H0RpJtABh6VQP
 gyhOlJ0iKnr2WRrOgyAF+DboGO/djo/rfXAKlkG8cTnSWkIA3PDSgFop1P8ah/dS5nn6YL+jr
 5lKy9qBx9xlAfFF5trCSeBRSgZRfOmXYxBI/Qh6ceRji6FL/B/MBBs4ds5K4mDe/bSudiRkPW
 eMma7DBXBWT3NUWY4CD+g64w6F7Kzc+dEcGPjHL+itth01OqZoT9KDNZoPxHn4M2v4By9yryL
 3omEC1tWSLL1NrcPZFg9E3luhpudY6P4V8sCTe/WGlZ76DCM/RAh+akTvdjEBDt2JXVwWtB
Cc: Corey Minyard <cminyard@mvista.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Chris Mason <clm@fb.com>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Ketan Mukadam <ketan.mukadam@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Mike Rapoport <rppt@linux.ibm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Borislav Petkov <bp@suse.de>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, Len Brown <lenb@kernel.org>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 John Hubbard <jhubbard@nvidia.com>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 Josef Bacik <josef@toxicpanda.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 David Sterba <dsterba@suse.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Networking <netdev@vger.kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 LKML <linux-kernel@vger.kernel.org>, "John S . Gruber" <JohnSGruber@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
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

On Fri, Nov 19, 2021 at 5:22 PM Alejandro Colomar (man-pages)
<alx.manpages@gmail.com> wrote:
> On 11/19/21 17:18, Arnd Bergmann wrote:
> > On Fri, Nov 19, 2021 at 5:10 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >> On Fri, Nov 19, 2021 at 04:57:46PM +0100, Arnd Bergmann wrote:
> >
> >>> The main problem with this approach is that as soon as you start
> >>> actually reducing the unneeded indirect includes, you end up with
> >>> countless .c files that no longer build because they are missing a
> >>> direct include for something that was always included somewhere
> >>> deep underneath, so I needed a second set of scripts to add
> >>> direct includes to every .c file.
> >>
> >> Can't it be done with cocci support?
> >
> > There are many ways of doing it, but they all tend to suffer from the
> > problem of identifying which headers are actually needed based on
> > the contents of a file, and also figuring out where to put the extra
> > #include if there are complex #ifdefs.
> >
> > For reference, see below for the naive pattern matching I tried.
> > This is obviously incomplete and partially wrong.
>
> FYI, if you may not know the tool,
> theres include-what-you-use(1) (a.k.a. iwyu(1))[1],
> although it is still not mature,
> and I'm helping improve it a bit.

Yes, I know that one, I tried using it as well, but it did not really
scale to the size of the kernel as it requires having all files to use
the correct set of #include, and to know about all the definitions.

       Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
