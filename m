Return-Path: <SRS0=gSim=QG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4980FC433F5
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 16:30:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F8C611C7
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 16:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 02F8C611C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBC02828DF;
	Fri, 19 Nov 2021 16:30:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qKq3fJbcLOMF; Fri, 19 Nov 2021 16:30:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7E215819BC;
	Fri, 19 Nov 2021 16:30:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52FEBC001E;
	Fri, 19 Nov 2021 16:30:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA645C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 16:30:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 98F0881BF4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 16:30:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cm1zXHnjKU9w
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 16:30:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 776D2819BC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 16:30:46 +0000 (UTC)
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M8hEd-1mjPsY10Cn-004nik for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 17:25:39 +0100
Received: by mail-wm1-f44.google.com with SMTP id
 p3-20020a05600c1d8300b003334fab53afso10928844wms.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 08:25:38 -0800 (PST)
X-Gm-Message-State: AOAM532idPlMWBqvePZDF01HbIB3v9f8g1A5z+XJ9rX9a3k6tvcUIaMr
 8IMPJbOuQvykbJmZZQMwDCuJLhPriJjf+KLzNtw=
X-Google-Smtp-Source: ABdhPJxceAOgZg4K9oWzLDHPv4QMPRjgvN2Y7oQmQdzE+p3Y265dv2VJvOf0muRFSn+nfOr9pX8E0TuGzsEYEIm5yn0=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr963230wmi.173.1637339127628; 
 Fri, 19 Nov 2021 08:25:27 -0800 (PST)
MIME-Version: 1.0
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <CAK8P3a0qT9tAxFkLN_vJYRcocDW2TcBq79WcYKZFyAG0udZx5Q@mail.gmail.com>
 <434296d3-8fe1-f1d2-ee9d-ea25d6c4e43e@gmail.com>
 <CAK8P3a2yVXw9gf8-BNvX_rzectNoiy0MqGKvBcXydiUSrc_fCA@mail.gmail.com>
 <f751fb48-d19c-88af-452e-680994a586b4@gmail.com>
In-Reply-To: <f751fb48-d19c-88af-452e-680994a586b4@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 19 Nov 2021 17:25:11 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0DD+odXthvGq2UWwrvhDDavukUB=bW-m+=HohjoiTE6w@mail.gmail.com>
Message-ID: <CAK8P3a0DD+odXthvGq2UWwrvhDDavukUB=bW-m+=HohjoiTE6w@mail.gmail.com>
Subject: Re: [PATCH 00/17] Add memberof(), split some headers, and slightly
 simplify code
To: "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
X-Provags-ID: V03:K1:3QdsB1spx96KbwMhIIuU8iajiYsYXRVA7Yo9k4LjCtad44clhtO
 8uFrL0xa3cJUEwQ5Sqs7cQc4N4dSVMdnjXmWXZkA0fycZL54gZR7jpoXsR4QtSkcdA9tSe/
 VIyUKHAijneukk3NoEQdopJFgVwL8mvms0HghufvrEV87jCCdnidgzj/JMvF4n4jlCZmLsU
 p+7dq7sx/YoTp1u1GOqng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZKcanNy4P5g=:ZSkDRNmt89XTg7V1uxtYqQ
 Ffn/ziFLCG0DtGOBaffqdOcWxWE1/MXTihMNduF6rISIMRARCYh1ceZKsYDcC1hchqI7G1OrH
 4CsZtaaKhoUsPG6c0RpF5oiWATnnZVuSMqZz0lOtjcMCGX/E+U/4NwVohqa4xHBeDL26iXBhS
 WiCXzlNZj1e8UBzkBxBfHeuRxNO8plpZvDpijXLZ391Yq9KdgtSjj9XRXgTkXbBFYEurzcPi5
 f2OsNleDRu6GZ3M5w6G4rWUlGzRUMDFBkKjd/sb/3Paf3n5wq+AAVyyjemCr4c6pJRKfYN+L6
 swRrtSYUPv7If0HWmxvQM4h+CyBlBIJJ3dFXGoqkcLXEz24Txl4cMuDgQe3rUtdWxcaJ8LrOf
 si017EaAJ8+G6peIIyOnPBXV61FHAVdiNShzNjGo+uIx3KGti9O+W13wAKL5zf1hDTFjUHonz
 suYaHx9kgVYipS2YA5TpH2Vvaq3rUJ1rUH0PEf9e43YfmGyY+R1z5kaaopHmxvFPC+4qdk/uP
 EF48JVWgmAGI+Hw/JFUpNGQtBQVD0QKdyco2a3N+G+K7TL77jJ+P33Xqz4VGc3uwmioh9yNUU
 rN1I9VwP5H1UkAhuvdS9bo4lBYZX+igiYxvOH0FnVOMKQmHdrxuhr/BV0BKUUvnirCzfOfmHs
 RcNPJHiNK/K/spLTplYjsUAIlwAiux3dC3YFf7XGa1VxicOuEH4tF1LFJucYDgCbUpquk8VVb
 56VZD3Qt0mvELx0GloYVBbM1k/VBAh7j5NowZX8nCz7/q0lLCRz0apJNY2LUU/FD3Ni1rYSfD
 4ALV7kSBTV3N02oJASeUM08JAMQqS3tgUX/i+jCUI0H2OQwPRE=
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

On Fri, Nov 19, 2021 at 5:12 PM Alejandro Colomar (man-pages)
<alx.manpages@gmail.com> wrote:
>
> On 11/19/21 16:57, Arnd Bergmann wrote:
> >
> > From what I can tell, linux/stddef.h is tiny, I don't think it's really
> > worth optimizing this part. I have spent some time last year
> > trying to untangle some of the more interesting headers, but ended
> > up not completing this as there are some really hard problems
> > once you start getting to the interesting bits.
>
> In this case it was not about being worth it or not,
> but that the fact that adding memberof() would break,
> unless I use 0 instead of NULL for the implementation of memberof(),
> which I'm against, or I split stddef.
>
> If I don't do either of those,
> I'm creating a circular dependency,
> and it doesn't compile.

Sorry for missing the background here, but I don't see what that
dependency is. If memberof() is a macro, then including the definition
should not require having the NULL definition first, you just need to
have both at the time you use it.

> > The main issue here is that user space code should not
> > include anything outside of include/uapi/ and arch/*/include/uapi/
>
> Okay.  That's good to know.
>
> So everything can use uapi code,
> and uapi code can only use uapi code,
> right?

Correct.

> > offsetof() is defined in include/linux/stddef.h, so this is by
> > definition not accessible here. It appears that there is also
> > an include/uapi/linux/stddef.h that is really strange because
> > it includes linux/compiler_types.h, which in turn is outside
> > of uapi/. This should probably be fixed.
>
> I see.
> Then,
> perhaps it would be better to define offsetof() _only_ inside uapi/,
> and use that definition from everywhere else,
> and therefore remove the non-uapi version,
> right?

No, because the user-space <stddef.h> provided by the compiler
also includes an offsetof() definition. In the uapi/ namespace, the
kernel must only provide definitions that do not clash with anything
in user space.

        Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
