Return-Path: <SRS0=gSim=QG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7869C433FE
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 14:48:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77AC7610F8
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 14:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77AC7610F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 400A5605AE;
	Fri, 19 Nov 2021 14:48:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 69CCKQaWO0xl; Fri, 19 Nov 2021 14:48:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E960460612;
	Fri, 19 Nov 2021 14:48:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3D30C001E;
	Fri, 19 Nov 2021 14:48:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9167C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 14:48:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4DEF401B9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 14:48:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y4LZg03T6uWL
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 14:48:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D7F4401A0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 14:48:08 +0000 (UTC)
Received: from mail-ot1-f48.google.com ([209.85.210.48]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N0nOF-1mQcwy1n0P-00wm1E for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:48:05 +0100
Received: by mail-ot1-f48.google.com with SMTP id
 w6-20020a9d77c6000000b0055e804fa524so17112597otl.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 06:48:04 -0800 (PST)
X-Gm-Message-State: AOAM532zJWiHOht+jDoybUdvGfaUYMDZJMt+7pBb/FkSDs4DUv94A8RD
 9t3yCTS+z7BslbsYlNuHPqPd9hHdWtMqd6TOHPg=
X-Google-Smtp-Source: ABdhPJyEA9Cm9jWRHlNRoILV4HxXKS70yYn95cfqEWkgZ0erwiDK8IdJrB6FynNXAmz1W8+x37fIqweN9je4/+8NifA=
X-Received: by 2002:a05:6830:453:: with SMTP id
 d19mr5257576otc.72.1637333272785; 
 Fri, 19 Nov 2021 06:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20211119113644.1600-1-alx.manpages@gmail.com>
In-Reply-To: <20211119113644.1600-1-alx.manpages@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 19 Nov 2021 15:47:35 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0qT9tAxFkLN_vJYRcocDW2TcBq79WcYKZFyAG0udZx5Q@mail.gmail.com>
Message-ID: <CAK8P3a0qT9tAxFkLN_vJYRcocDW2TcBq79WcYKZFyAG0udZx5Q@mail.gmail.com>
Subject: Re: [PATCH 00/17] Add memberof(), split some headers, and slightly
 simplify code
To: Alejandro Colomar <alx.manpages@gmail.com>
X-Provags-ID: V03:K1:EPfuUPhS4W0zuteSRO8B+RLmegTER9UbcvLsVF5l82osP24Z/iM
 afkNWSIlZqdgMxOvKoKSRfOH5PeMm1PIKNdXyl17/0G8dpVLtoUXHm6T+ag90qYB16vvxEN
 RwPO4X8EYzxvChcb2dNCvaIwpvA3H1JvzXyebFL4sxMCwOMKCgKyxWsezDYNGxDKSITQztg
 pdv+9bnVhwti4Y5wMPcgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fKgZf3QDpnk=:W6c3p/HTEWJQNsB/HXbIc9
 ZKw52nfEFa9sHYSfBXJGus2x75+gKYhlsNWTDy7DlIKBTVeKe7dJbzxStmXdn89d6maBbMc2h
 N0uo7RXGF8wH3n4/TiM7lYMMUgR+xStNcMZNe2avk1/VnACD7oG/Hp+CfBRBRbKXPGS6T7sG3
 13/KwKFvw5zdGPDsVT5jAh+Mit1D0jqEgdvax4jpZk3XuoWQt6AsEOhM/4IZ4icD11m6qpU9S
 GC9Sv0/q29n7KVdPfLs+Y8HrTDqvTxivP2+/0j+uVWn84tTwrDMDdlkzw6EnDXrv6tzDW2E4B
 EHpt1TdGvwkagX7GtE73zjSOnw48p+/09tunQma0/BTVv3Ndc07aFM5qt9Gmdntat5BvZQwUz
 DyMp7FiR0cH2/Q4RblogxRD21ZwZE+DfZLkqfOqcbz6AaG3s/bvz6ZBfZ0ibm6VLc9V8lxMkD
 YZ8xzrj4pGas6EvKbUl3/LvSWKup9h0srGcATSXzRm3dSzCQh8eZapw3wgTp4QRPIJ2tghWuf
 3jCqv6NwCu1VkElzzINeKrLNKlH8dOvMwOADTiqDJuzqvoY43TV9zwYsnz3U+BZFIIN+jmy3a
 3R+Hj2d+08sO12wIRbEESmDaj7U3WcGb75EHw4nbSZAnEAaboWHc24sW8vFwrbp7DFGYriw0v
 ZaCftk7l2yUKhENLxGvwDbHDO3IfEeSH8HdezbSl8rHX+KK66OAQux/h7DuOQT+SPN56bk2ph
 tZiaz86X6CSpp6vzaCg3OafNSD6ksUsfEWc+XCnyhKtOKS74kexT4O1I11Uho4exP9lgSAJ72
 RDC0+4ZHe/P4//xax1vtX7Dd/+FIMZU+mKMcSQ4ZsTFBIDQRTA=
Cc: Corey Minyard <cminyard@mvista.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Chris Mason <clm@fb.com>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Ketan Mukadam <ketan.mukadam@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, linux-scsi@vger.kernel.org,
 Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Mike Rapoport <rppt@linux.ibm.com>, linux-acpi@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Borislav Petkov <bp@suse.de>,
 virtualization@lists.linux-foundation.org, Len Brown <lenb@kernel.org>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org,
 Josef Bacik <josef@toxicpanda.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 David Sterba <dsterba@suse.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 netdev@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
 LKML <linux-kernel@vger.kernel.org>, "John S . Gruber" <JohnSGruber@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-btrfs@vger.kernel.org
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

On Fri, Nov 19, 2021 at 12:36 PM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
>
> Alejandro Colomar (17):
>   linux/container_of.h: Add memberof(T, m)
>   Use memberof(T, m) instead of explicit NULL dereference
>   Replace some uses of memberof() by its wrappers
>   linux/memberof.h: Move memberof() to separate header
>   linux/typeof_member.h: Move typeof_member() to a separate header
>   Simplify sizeof(typeof_member()) to sizeof_field()
>   linux/NULL.h: Move NULL to a separate header
>   linux/offsetof.h: Move offsetof(T, m) to a separate header
>   linux/offsetof.h: Implement offsetof() in terms of memberof()
>   linux/container_of.h: Implement container_of_safe() in terms of
>     container_of()
>   linux/container_of.h: Cosmetic
>   linux/container_of.h: Remove unnecessary cast to (void *)

My feeling is that this takes the separation too far: by having this many header
files that end up being included from practically every single .c file
in the kernel,
I think you end up making compile speed worse overall.

If your goal is to avoid having to recompile as much of the kernel
after touching
a header, I think a better approach is to help untangle the dependencies, e.g.
by splitting out type definitions from headers with inline functions (most
indirect header dependencies are on type definitions) and by focusing on
linux/fs.h, linux/sched.h, linux/mm.h and how they interact with the rest of the
headers. At the moment, these are included in most .c files and they in turn
include a ton of other headers.

          Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
