Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFEAC433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 18:07:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0A4460A43;
	Tue, 23 Nov 2021 18:07:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QAEWNYlsjE5j; Tue, 23 Nov 2021 18:07:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 37A1460A48;
	Tue, 23 Nov 2021 18:07:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00D50C001E;
	Tue, 23 Nov 2021 18:07:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D70FCC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 18:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7E6581011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 18:07:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k1J5lGDyAC-v
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 18:07:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DCEC58100C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 18:07:19 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id
 w6-20020a9d77c6000000b0055e804fa524so160746otl.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 10:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zISZonE+jfcuqih+VqZkba/z0VBN8Lm0GEq4vywk61c=;
 b=WnxEZykv6BEYRNelON5+FyygL99DZdDcnjUXR+kg0XhYzXfQqaGYf6gRiiDEh6LXNG
 7T7mcFBOg15XbAwjPl2LGY2CMY7KrwH2mD3cNs0n44ccI0Ij0xDFN4FX9rkSlxbpCI+/
 6TmpBOJjTh7SRuJOrUyBFMHTVibrJHB6K5NS/eoGp+DT41QOfJhlJ1y1LWgyQGKzSgjF
 7UQfPn6ubz1ehv2SZhpJsdxdXgWCAXXcIRJ9ddedE+0pYp+tJX4lX1ogi0DqWMpg8VFM
 zeZjP8YYW0P9aFdNP69Sz5sa2ZBB/G7AoljmLmngAQQAbHTeXTivn/Rq+t+x61PwLyBz
 CqKA==
X-Gm-Message-State: AOAM532LXD1qcIdb8G43QUf8CE4CN7HQTJ/rcpVx82I3WutW622ZftKJ
 7OVCVlAjYpM8/MvokgggCetYu1p3ks0v9DLyg7Y=
X-Google-Smtp-Source: ABdhPJwF2ep52rxDLG6UpRp3xdWO1LK2aeGUp8ki3Y6ep8Od1B4KnhnGqvqMfV3sQKXaxIByEQB9U2fm2A3fPfoMQds=
X-Received: by 2002:a05:6830:1e57:: with SMTP id
 e23mr6327907otj.16.1637690838752; 
 Tue, 23 Nov 2021 10:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211119113644.1600-3-alx.manpages@gmail.com>
In-Reply-To: <20211119113644.1600-3-alx.manpages@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Nov 2021 19:07:07 +0100
Message-ID: <CAJZ5v0jGgxgTWQ-DLehRE_GPoRMz2TnT469uNE8k6TX7NxQdEA@mail.gmail.com>
Subject: Re: [PATCH 02/17] Use memberof(T,
 m) instead of explicit NULL dereference
To: Alejandro Colomar <alx.manpages@gmail.com>
Cc: Corey Minyard <cminyard@mvista.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Chris Mason <clm@fb.com>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Ketan Mukadam <ketan.mukadam@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Mike Rapoport <rppt@linux.ibm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Borislav Petkov <bp@suse.de>,
 virtualization@lists.linux-foundation.org, Len Brown <lenb@kernel.org>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 John Hubbard <jhubbard@nvidia.com>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 Josef Bacik <josef@toxicpanda.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 David Sterba <dsterba@suse.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 netdev <netdev@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
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

On Fri, Nov 19, 2021 at 12:37 PM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
>
> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
> Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Corey Minyard <cminyard@mvista.com>
> Cc: Chris Mason <clm@fb.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: John S. Gruber <JohnSGruber@gmail.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ketan Mukadam <ketan.mukadam@broadcom.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Somnath Kotur <somnath.kotur@broadcom.com>
> Cc: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
> Cc: Subbu Seetharaman <subbu.seetharaman@broadcom.com>
> Cc: <intel-gfx@lists.freedesktop.org>
> Cc: <linux-acpi@vger.kernel.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Cc: <linux-btrfs@vger.kernel.org>
> Cc: <linux-scsi@vger.kernel.org>
> Cc: <netdev@vger.kernel.org>
> Cc: <virtualization@lists.linux-foundation.org>
> ---
>  arch/x86/include/asm/bootparam_utils.h  |  3 ++-
>  arch/x86/kernel/signal_compat.c         |  5 +++--
>  drivers/gpu/drm/i915/i915_utils.h       |  5 ++---
>  drivers/gpu/drm/i915/intel_runtime_pm.h |  2 +-
>  drivers/net/ethernet/emulex/benet/be.h  |  7 ++++---
>  drivers/net/ethernet/i825xx/ether1.c    |  7 +++++--
>  drivers/scsi/be2iscsi/be.h              |  7 ++++---
>  drivers/scsi/be2iscsi/be_cmds.h         |  5 ++++-
>  fs/btrfs/ctree.h                        |  5 +++--
>  include/acpi/actypes.h                  |  4 +++-

The change in actypes.h would need to be submitted to the upstream
ACPICA project via https://github.com/acpica/acpica/

Thanks!

>  include/linux/container_of.h            |  6 +++---
>  include/linux/virtio_config.h           | 14 +++++++-------
>  12 files changed, 41 insertions(+), 29 deletions(-)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
