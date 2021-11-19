Return-Path: <SRS0=gSim=QG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F77EC433F5
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 15:58:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9AE61549
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 15:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E9AE61549
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C785E827AF;
	Fri, 19 Nov 2021 15:58:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7vYNuC5Ts8Jb; Fri, 19 Nov 2021 15:58:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1D4838275C;
	Fri, 19 Nov 2021 15:58:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E35BCC002E;
	Fri, 19 Nov 2021 15:58:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6491DC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 45C608275C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xFeiDmSGnyxq
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:58:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CCDFE8274E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:58:15 +0000 (UTC)
Received: from mail-ed1-f52.google.com ([209.85.208.52]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MIMKq-1mrSKX37bw-00ELkg for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 16:58:13 +0100
Received: by mail-ed1-f52.google.com with SMTP id z5so44635660edd.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 07:58:13 -0800 (PST)
X-Gm-Message-State: AOAM531BJleLX90dlXq3l6vZYHio8XV9MpwBqn9Xl6vJQSz369ygBu66
 02V0QmfvXC1CJO3hw0QjcPlRat5RihRrres79ik=
X-Google-Smtp-Source: ABdhPJwnsTso3SJsyzelpHMk45ZnrIpUGUkP3Z97jucoO4GjyflpBdZvuKfoRBo685VC8w89e5cIDe6TdYLQkVPBgCM=
X-Received: by 2002:adf:efc6:: with SMTP id i6mr8808061wrp.428.1637337483020; 
 Fri, 19 Nov 2021 07:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <CAK8P3a0qT9tAxFkLN_vJYRcocDW2TcBq79WcYKZFyAG0udZx5Q@mail.gmail.com>
 <434296d3-8fe1-f1d2-ee9d-ea25d6c4e43e@gmail.com>
In-Reply-To: <434296d3-8fe1-f1d2-ee9d-ea25d6c4e43e@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 19 Nov 2021 16:57:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2yVXw9gf8-BNvX_rzectNoiy0MqGKvBcXydiUSrc_fCA@mail.gmail.com>
Message-ID: <CAK8P3a2yVXw9gf8-BNvX_rzectNoiy0MqGKvBcXydiUSrc_fCA@mail.gmail.com>
Subject: Re: [PATCH 00/17] Add memberof(), split some headers, and slightly
 simplify code
To: "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
X-Provags-ID: V03:K1:GcO7cxvBy+K9Dr4yVKG5ZVRHZAvRP+uxsaZTQgSVRAfDCrh6s9M
 FgSbKlyFCdWSCdbt4eiDK5XNLInaqvns/CkyI9wkaNthYVTTd4bP4tA03a8xrE6FtIUP57g
 0i18yvbJZaOt7FQxeuxEuGxSDvWB4fWpDKjRu6+LOyqxomffwQnIeF+LlEFQ0YTD43to9hf
 kycK41z7xhxPNK2uoDeRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:895NfZToKUM=:90Ymi5Os+WOYPoG8dwXNTd
 RW7CCgW7qcMMM8xxXNgEANtXhYVidvy9FKq69J07/l6qBw+h1TUl5Lxkd91qMvOuDqYxxHTHa
 hG/72mrG86CmAU6ypSDQ4S3rbJLeKmoMi+yPDyKTkPaZEwRRN5i2Nht8El+/RtCp9p4qRy6cC
 V9HiLxnjn/QmHFHNLjRAQcC5HbK/kdgr4DgCvN+0Q5DcsnWkFhx2Eojwgn09u5ZZZnRjFZvFq
 E4wfm4Qk9QazVVbMLxaccMzl6XhVKf/BgJz5/NLtvZdpnf5T/4Cnreg2TaVM0fNs5MwqP8LL7
 n1R/DKYmWsrLnTAZY8vZApQFzntiakzM7p2TtHYWvCzFn9OXvIPGWsLhw93eMECvboU4bAnbn
 MCRKoN84eTn4VLKpskCOw4Fz+AkbhYItiZwGM/tyaevIx9F3NhXNIr00zjwzRuvcXc2Cn4gL3
 CFBqINA1U6tFfs7RM5M6d+iuq9JoHAXScPAa9jc6sbdT6jopd3YWX11836rbRXpTi2RcK5fKt
 yblUoO9QOlQbR4mxCfftNtzfKGg600OJsM/qnSfcaNyBUM5DgmV08zifnKpnpvawcXc3a/1Li
 XOYjEz4KEtCmnr6qQLs1B8vEd+mXhUyW6aFR/VjjX83wZn612fBAbT5Mq5oO7xFTq/azGjaMW
 ZYZFYzKkKjGS/tRi/A3prBBt3KzAxViYlEhZu9E8GPIzPwO0G2mfMeSJt2BLqMXoF+dJd7e5e
 56VI0EVVWK+1BUI9FVeqT00WQ8El/fKKlR/PVKrDkHj9/bJANVGByX3htBBcfjqhEjGjaFGF9
 KArm6TDMv2vGBGsrv5I8IpGPYTs6wg8rorLF2e5dBLadM2io3xHi4QJmVPRdD2BnUazH+9WI0
 7PIAhAq9PihM/awnvL9A==
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

On Fri, Nov 19, 2021 at 4:06 PM Alejandro Colomar (man-pages)
<alx.manpages@gmail.com> wrote:
> On 11/19/21 15:47, Arnd Bergmann wrote:
> > On Fri, Nov 19, 2021 at 12:36 PM Alejandro Colomar
>
> Yes, I would like to untangle the dependencies.
>
> The main reason I started doing this splitting
> is because I wouldn't be able to include
> <linux/stddef.h> in some headers,
> because it pulled too much stuff that broke unrelated things.
>
> So that's why I started from there.
>
> I for example would like to get NULL in memberof()
> without puling anything else,
> so <linux/NULL.h> makes sense for that.
>
> It's clear that every .c wants NULL,
> but it's not so clear that every .c wants
> everything that <linux/stddef.h> pulls indirectly.

From what I can tell, linux/stddef.h is tiny, I don't think it's really
worth optimizing this part. I have spent some time last year
trying to untangle some of the more interesting headers, but ended
up not completing this as there are some really hard problems
once you start getting to the interesting bits.

The approach I tried was roughly:

- For each header in the kernel, create a preprocessed version
  that includes all the indirect includes, from that start a set
  of lookup tables that record which header is eventually included
  by which ones, and the size of each preprocessed header in
  bytes

- For a given kernel configuration (e.g. defconfig or allmodconfig)
  that I'm most interested in, look at which files are built, and what
  the direct includes are in the source files.

- Sort the headers by the product of the number of direct includes
  and the preprocessed size: the largest ones are those that are
  worth looking at first.

- use graphviz to visualize the directed graph showing the includes
  between the top 100 headers in that list. You get something like
  I had in [1], or the version afterwards at [2].

- split out unneeded indirect includes from the headers in the center
  of that graph, typically by splitting out struct definitions.

- repeat.

The main problem with this approach is that as soon as you start
actually reducing the unneeded indirect includes, you end up with
countless .c files that no longer build because they are missing a
direct include for something that was always included somewhere
deep underneath, so I needed a second set of scripts to add
direct includes to every .c file.

On the plus side, I did see something on the order of a 30%
compile speed improvement with clang, which is insane
given that this only removed dead definitions.

> But I'll note that linux/fs.h, linux/sched.h, linux/mm.h are
> interesting headers for further splitting.
>
>
> BTW, I also have a longstanding doubt about
> how header files are organized in the kernel,
> and which headers can and cannot be included
> from which other files.
>
> For example I see that files in samples or scripts or tools,
> that redefine many things such as offsetof() or ARRAY_SIZE(),
> and I don't know if there's a good reason for that,
> or if I should simply remove all that stuff and
> include <linux/offsetof.h> everywhere I see offsetof() being used.

The main issue here is that user space code should not
include anything outside of include/uapi/ and arch/*/include/uapi/

offsetof() is defined in include/linux/stddef.h, so this is by
definition not accessible here. It appears that there is also
an include/uapi/linux/stddef.h that is really strange because
it includes linux/compiler_types.h, which in turn is outside
of uapi/. This should probably be fixed.

      Arnd

[1] https://drive.google.com/file/d/14IKifYDadg2W5fMsefxr4373jizo9bLl/view?usp=sharing
[2] https://drive.google.com/file/d/1pWQcv3_ZXGqZB8ogV-JOfoV-WJN2UNnd/view?usp=sharing
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
