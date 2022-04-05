Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A98C433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Apr 2022 06:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 631784055A;
	Tue,  5 Apr 2022 06:35:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NMn-wCCgfJJ1; Tue,  5 Apr 2022 06:35:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DA7A540531;
	Tue,  5 Apr 2022 06:35:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95B30C002C;
	Tue,  5 Apr 2022 06:35:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B41CEC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 06:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8CA1960BE5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 06:35:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2PMGgq_2GhL6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 06:35:01 +0000 (UTC)
X-Greylist: delayed 00:05:05 by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ECE41605EA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 06:35:00 +0000 (UTC)
Received: from mail-wm1-f47.google.com ([209.85.128.47]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MGiF0-1noG0o3odG-00Dsrd for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Apr 2022 08:29:52 +0200
Received: by mail-wm1-f47.google.com with SMTP id q20so7298873wmq.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Apr 2022 23:29:52 -0700 (PDT)
X-Gm-Message-State: AOAM533wAXhwzsZFZBqkY9ql8DTJ++Rh03699fpGuGdSwZuj3jqtoSYp
 0dnxfDpQjSjGFOfR59qF25Vm7Vbj/qN8AF1FpSQ=
X-Google-Smtp-Source: ABdhPJwsEWf6Kh9ZmIXYYN/M9onvtdd1lx+p5bH1oV2EAH9/3o2ZPWJZ3zKpIpvz66ZNFBOP57JnZalCuJjU3V4Z5Fo=
X-Received: by 2002:a05:600c:4e11:b0:38c:bd19:e72c with SMTP id
 b17-20020a05600c4e1100b0038cbd19e72cmr1618846wmq.174.1649140192243; Mon, 04
 Apr 2022 23:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-9-masahiroy@kernel.org>
 <Ykqh3mEy5uY8spe8@infradead.org>
 <CAK8P3a07ZdqA0UBC_qkqzMsZWLUK=Rti3AkFe2VVEWLivuZAqA@mail.gmail.com>
 <YkvVOLj/Rv4yPf5K@infradead.org>
In-Reply-To: <YkvVOLj/Rv4yPf5K@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 5 Apr 2022 08:29:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0FjfSyUtv9a9dM7ixsK2oY9VF7WZPvDctn2JRi7A0YyQ@mail.gmail.com>
Message-ID: <CAK8P3a0FjfSyUtv9a9dM7ixsK2oY9VF7WZPvDctn2JRi7A0YyQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] virtio_ring.h: do not include <stdint.h> from
 exported header
To: Christoph Hellwig <hch@infradead.org>
X-Provags-ID: V03:K1:tELV21OnWyIDmEIjsPBrk4kp0CyU4jd2ooHC5K1j3N+sJzzebf1
 OygxtcGu9vrDhhezdWOOT6hYpUc3VN/F/Tuz+KEV81jYSakxjke2n/v1fyK5eSPyChTD8G6
 izUlS+Cs0ssoCBPpf8YAt5I2PX1CrnJxm8sgBJ6GluBVrLO5j/khZW5fQXkpKGUzHfBOa94
 hJbteBtLYtZohEuJ0Z7fg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u8A1RCSHuKM=:hv6d8yIO0ihJQ+wcPB2Fmm
 7KjswlnMg6E7N7TCTD0QnGqDeKLP0aLwZzWe6W1ErIChBwu5vv2qRKnqCB5RzPmG2Vd3ICrpm
 3bMzh6Ogj88Y1yH2sLvam5EDjJcJRtNE6d6UomNxizNzxe/OT21wuRzjlCauN0f3QWnT9IErZ
 ParFfcUlYjVqca46zVcoYCWKIaEecYtAghqbCxwwkvaerLOLtP4RV5HiM3kfARBVrVi4+uA9q
 zdsP6VoqZ2ey1KSh+ehZ6iCRuE2O0i2aKnT/MWMCVpbKbGPopC779vqefXogVfreSJnxxe+5V
 2NdW4AA6efGSViK8Wci6Hl/pLinFCj/mnEKE3mrVE8G4AnFN0PhWAAUlKpId42/ycqmdKlRH3
 k0shXYAWHs4rPt1raRrKD364fXqjcy/q8NcPnUPtLwWfRyUmVJHxFaPA3iQPz4DWxuo3le1yu
 Vdg8uR9+aU780sTaUY6EPlZeVzsyI+WDH2X3drOMeN0frQQS4wKEmjbLWGkPWnyqiXDRslHAq
 qwrHgDFWXteIQLUEUDky1zeRGzstvw5x1xVFEKpp/UC6639M8DkpAWooVBAn+lFWgCxuY3+EH
 WgmBzE0466JzkVpUYOVnZA3LOrmxRGby/nDqeV0IjkNFig5t0aBvhFX45ylLqKPko3gOxoN7t
 kpzRUKuG2yjz3hY00dDqhoAWgcnHc6OY7xbQ04VX9SR51Bci1QZkdEKKuLvMcHtuyXPU=
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization list <virtualization@lists.linux-foundation.org>
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

On Tue, Apr 5, 2022 at 7:35 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Apr 04, 2022 at 10:04:02AM +0200, Arnd Bergmann wrote:
> > The header is shared between kernel and other projects using virtio, such as
> > qemu and any boot loaders booting from virtio devices. It's not technically a
> > /kernel/ ABI, but it is an ABI and for practical reasons the kernel version is
> > maintained as the master copy if I understand it correctly.
>
> Besides that fact that as you correctly states these are not a UAPI at
> all, qemu and bootloades are not specific to Linux and can't require a
> specific kernel version.  So the same thing we do for file system
> formats or network protocols applies here:  just copy the damn header.
> And as stated above any reasonably portable userspace needs to have a
> copy anyway.

I think the users all have their own copies, at least the ones I could
find on codesearch.debian.org. However, there are 27 virtio_*.h
files in include/uapi/linux that probably should stay together for
the purpose of defining the virtio protocol, and some others might
be uapi relevant.

I see that at least include/uapi/linux/vhost.h has ioctl() definitions
in it, and includes the virtio_ring.h header indirectly.

Adding the virtio maintainers to Cc to see if they can provide
more background on this.

> If it is just as a "master copy" it can live in drivers/virtio/, just
> like we do for other formats.

It has to be in include/linux/ at least because it's used by a number
of drivers outside of drivers/virtio/.

        Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
