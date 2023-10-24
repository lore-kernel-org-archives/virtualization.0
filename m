Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A6BC07545
	for <virtualization@archiver.kernel.org>; Tue, 24 Oct 2023 21:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3401A84D85;
	Tue, 24 Oct 2023 21:37:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3401A84D85
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=jgS0xGKi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8pwqWHxeT9YS; Tue, 24 Oct 2023 21:37:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 641BC84D6F;
	Tue, 24 Oct 2023 21:37:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 641BC84D6F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47AD7C0071;
	Tue, 24 Oct 2023 21:37:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0D7DC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 21:37:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F7A9706A2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 21:37:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F7A9706A2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org
 header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=jgS0xGKi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kgPHF_Jjo94Y
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 21:37:40 +0000 (UTC)
X-Greylist: delayed 1696 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 24 Oct 2023 21:37:40 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43721706A1
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 43721706A1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 21:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Reply-To:Content-ID:Content-Description;
 bh=ChkYc+GULd0fN/nFw+559WVZQK+W9W42DJqglKFeScU=; b=jgS0xGKis2ZlA68GNnBZdMS9lD
 oXP0rqV8nrev5Hm8P6PbGRjqoO0d35X0DquI6KsdZ+2y8e7KMp/O/vw84ZSaC+FHU/kkdtK+4Oc6W
 tIy4SpCLEn3SOB80+ZzO/kHWQTl2R3/DiU3KrAvuJ7/p7ilBDYSFLl6rRoso34QL3qXjznQraJP9l
 1Vi58fBIQUHN1ACufUi80hd+5Wfr74+TTtHf0kXwqXFGjDgR/78gXF0Ji1uuQ6wGPO/cuuyNS6f8Z
 GP5TmRw4MlPYFa8RqA4RHDl+w6yAJLCqy3ou5sgU2jjfcsf/7ILH2L19WF3CF6ZWQ3ZxsLfcWipzX
 X6BQ/EEA==;
Received: from authenticated user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2) (envelope-from <carnil@debian.org>)
 id 1qvOeG-00FPhY-LQ; Tue, 24 Oct 2023 21:09:12 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
 id 9ED23BE2DE0; Tue, 24 Oct 2023 23:09:10 +0200 (CEST)
Date: Tue, 24 Oct 2023 23:09:10 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Timo Lindfors <timo.lindfors@iki.fi>, 1054514@bugs.debian.org
Subject: Re: Bug#1054514: linux-image-6.1.0-13-amd64: Debian VM with qxl
 graphics freezes frequently
Message-ID: <ZTgydqRlK6WX_b29@eldamar.lan>
References: <alpine.DEB.2.20.2310242308150.28457@mail.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.2310242308150.28457@mail.home>
X-Debian-User: carnil
Cc: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, spice-devel@lists.freedesktop.org,
 Dave Airlie <airlied@redhat.com>, regressions@lists.linux.dev
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Timo,

On Tue, Oct 24, 2023 at 11:14:32PM +0300, Timo Lindfors wrote:
> Package: src:linux
> Version: 6.1.55-1
> Severity: normal
> =

> Steps to reproduce:
> 1) Install Debian 12 as a virtual machine using virt-manager, choose qxl
>    graphics card. You only need basic installation without wayland or X.
> 2) Login from the console and save th=EB following to reproduce.bash:
> =

> #!/bin/bash
> =

> chvt 3
> for j in $(seq 80); do
>     echo "$(date) starting round $j"
>     if [ "$(journalctl --boot | grep "failed to allocate VRAM BO")" !=3D =
"" ];
> then
>         echo "bug was reproduced after $j tries"
>         exit 1
>     fi
>     for i in $(seq 100); do
>         dmesg > /dev/tty3
>     done
> done
> =

> echo "bug could not be reproduced"
> exit 0
> =

> =

> 3) Run chmod a+x reproduce.bash
> 4) Run ./reproduce.bash and wait for up to 20 minutes.
> =

> Expected results:
> 4) The system prints a steady flow of text without kernel error messages
> =

> Actual messages:
> 4) At some point the text stops flowing and the script prints "bug was
>    reproduced". If you run "journalctl --boot" you see
> =

> kernel: [TTM] Buffer eviction failed
> kernel: qxl 0000:00:02.0: object_init failed for (3149824, 0x00000001)
> kernel: [drm:qxl_alloc_bo_reserved [qxl]] *ERROR* failed to allocate VRAM=
 BO
> =

> =

> =

> More info:
> 1) The bug does not occur if I downgrade the kernel to
>    linux-image-5.10.0-26-amd64_5.10.197-1_amd64.deb from Debian 11.
> 2) I used the following test_linux.bash to bisect this issue against
>    upstream source:
> =

> #!/bin/bash
> set -x
> =

> gitversion=3D"$(git describe HEAD|sed 's@^v@@')"
> =

> git checkout drivers/gpu/drm/ttm/ttm_bo.c include/drm/ttm/ttm_bo_api.h
> git show bec771b5e0901f4b0bc861bcb58056de5151ae3a | patch -p1
> # Build
> cp ~/kernel.config .config
> # cp /boot/config-$(uname -r) .config
> # scripts/config --enable LOCALVERSION_AUTO
> # scripts/config --disable DEBUG_INFO
> # scripts/config --disable SYSTEM_TRUSTED_KEYRING
> # scripts/config --set-str SYSTEM_TRUSTED_KEYS ''
> # scripts/config --disable STACKPROTECTOR_STRONG
> make olddefconfig
> # make localmodconfig
> make -j$(nproc --all) bindeb-pkg
> rc=3D"$?"
> if [ "$rc" !=3D "0" ]; then
>     exit 125
> fi
> git checkout drivers/gpu/drm/ttm/ttm_bo.c include/drm/ttm/ttm_bo_api.h
> =

> package=3D"$(ls --sort=3Dtime ../linux-image-*_amd64.deb|head -n1)"
> version=3D$(echo $package | cut -d_ -f1|cut -d- -f3-)
> =

> if [ "$gitversion" !=3D "$version" ]; then
>     echo "Build produced version $gitversion but got $version, ignoring"
>     #exit 255
> fi
> =

> # Deploy
> scp $package target:a.deb
> ssh target sudo apt install ./a.deb
> ssh target rm -f a.deb
> ssh target ./grub_set_default_version.bash $version
> ssh target sudo shutdown -r now
> sleep 40
> =

> detected_version=3D$(ssh target uname -r)
> if [ "$detected_version" !=3D "$version" ]; then
>     echo "Booted to $detected_version but expected $version"
>     exit 255
> fi
> =

> # Test
> exec ssh target sudo ./reproduce.bash
> =

> =

> Bisect printed the following log:
> =

> git bisect start
> # bad: [ed29c2691188cf7ea2a46d40b891836c2bd1a4f5] drm/i915: Fix userptr s=
o we do not have to worry about obj->mm.lock, v7.
> git bisect bad ed29c2691188cf7ea2a46d40b891836c2bd1a4f5
> # bad: [762949bb1da78941b25e63f7e952af037eee15a9] drm: fix drm_mode_creat=
e_blob comment
> git bisect bad 762949bb1da78941b25e63f7e952af037eee15a9
> # bad: [e40f97ef12772f8eb04b6a155baa1e0e2e8f3ecc] drm/gma500: Drop DRM_GM=
A600 config option
> git bisect bad e40f97ef12772f8eb04b6a155baa1e0e2e8f3ecc
> # bad: [5a838e5d5825c85556011478abde708251cc0776] drm/qxl: simplify qxl_f=
ence_wait
> git bisect bad 5a838e5d5825c85556011478abde708251cc0776
> # bad: [d2b6f8a179194de0ffc4886ffc2c4358d86047b8] Merge tag 'xfs-5.13-mer=
ge-3' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
> git bisect bad d2b6f8a179194de0ffc4886ffc2c4358d86047b8
> # bad: [68a32ba14177d4a21c4a9a941cf1d7aea86d436f] Merge tag 'drm-next-202=
1-04-28' of git://anongit.freedesktop.org/drm/drm
> git bisect bad 68a32ba14177d4a21c4a9a941cf1d7aea86d436f
> # bad: [0698b13403788a646073fcd9b2294f2dce0ce429] drm/amdgpu: skip PP_MP1=
_STATE_UNLOAD on aldebaran
> git bisect bad 0698b13403788a646073fcd9b2294f2dce0ce429
> # bad: [e1a5e6a8c48bf99ea374fb3e535661cfe226bca4] drm/doc: Add RFC section
> git bisect bad e1a5e6a8c48bf99ea374fb3e535661cfe226bca4
> # bad: [ed29c2691188cf7ea2a46d40b891836c2bd1a4f5] drm/i915: Fix userptr s=
o we do not have to worry about obj->mm.lock, v7.
> git bisect bad ed29c2691188cf7ea2a46d40b891836c2bd1a4f5
> # bad: [2c8ab3339e398bbbcb0980933e266b93bedaae52] drm/i915: Pin timeline =
map after first timeline pin, v4.
> git bisect bad 2c8ab3339e398bbbcb0980933e266b93bedaae52
> # bad: [2eb8e1a69d9f8cc9c0a75e327f854957224ba421] drm/i915/gem: Drop relo=
cation support on all new hardware (v6)
> git bisect bad 2eb8e1a69d9f8cc9c0a75e327f854957224ba421
> # bad: [b5b6f6a610127b17f20c0ca03dd27beee4ddc2b2] drm/i915/gem: Drop lega=
cy execbuffer support (v2)
> git bisect bad b5b6f6a610127b17f20c0ca03dd27beee4ddc2b2
> # bad: [06debd6e1b28029e6e77c41e59a162868f377897] Merge tag 'drm-intel-ne=
xt-2021-03-16' of git://anongit.freedesktop.org/drm/drm-intel into drm-next
> git bisect bad 06debd6e1b28029e6e77c41e59a162868f377897
> # good: [e19eede54240d64b4baf9b0df4dfb8191f7ae48b] Merge branch 'dmi-for-=
linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging
> git bisect good e19eede54240d64b4baf9b0df4dfb8191f7ae48b
> # good: [1e28eed17697bcf343c6743f0028cc3b5dd88bf0] Linux 5.12-rc3
> git bisect good 1e28eed17697bcf343c6743f0028cc3b5dd88bf0
> # bad: [6af70eb3b40edfc8bdf2373cdc2bcf9d5a20c8c7] drm/atmel-hlcdc: Rename=
 custom plane state variable
> git bisect bad 6af70eb3b40edfc8bdf2373cdc2bcf9d5a20c8c7
> # good: [4ca77c513537700d3fae69030879f781dde1904c] drm/qxl: release shado=
w on shutdown
> git bisect good 4ca77c513537700d3fae69030879f781dde1904c
> # bad: [4a11bd1e88af130f50a72e0f54391c1c7d268e03] drm/ast: Add constants =
for VGACRCB register bits
> git bisect bad 4a11bd1e88af130f50a72e0f54391c1c7d268e03
> # bad: [5c209d8056b9763ce544ecd7dadb3782cdaf96ed] drm/gma500: psb_spank()=
 doesn't need it's own file
> git bisect bad 5c209d8056b9763ce544ecd7dadb3782cdaf96ed
> # bad: [db0c6bd2c0c0dada8927cd46a7c34c316a3a6c04] drm/gem: Export drm_gem=
_vmap() and drm_gem_vunmap()
> git bisect bad db0c6bd2c0c0dada8927cd46a7c34c316a3a6c04
> # bad: [f4a84e165e6d58606097dd07b5b78767a94b870c] drm/qxl: allocate dumb =
buffers in ram
> git bisect bad f4a84e165e6d58606097dd07b5b78767a94b870c
> # good: [a7709b9b89a67f3ead2d188b1d0c261059b1f291] drm/qxl: handle shadow=
 in primary destroy
> git bisect good a7709b9b89a67f3ead2d188b1d0c261059b1f291
> # bad: [5a838e5d5825c85556011478abde708251cc0776] drm/qxl: simplify qxl_f=
ence_wait
> git bisect bad 5a838e5d5825c85556011478abde708251cc0776
> # good: [5f6c871fe919999774e8535ea611a6f84ee43ee4] drm/qxl: properly free=
 qxl releases
> git bisect good 5f6c871fe919999774e8535ea611a6f84ee43ee4
> # first bad commit: [5a838e5d5825c85556011478abde708251cc0776] drm/qxl: s=
implify qxl_fence_wait
> =

> I took a look at
> =

> commit 5a838e5d5825c85556011478abde708251cc0776 (refs/bisect/bad)
> Author: Gerd Hoffmann <kraxel@redhat.com>
> Date:   Thu Feb 4 15:57:10 2021 +0100
> =

>     drm/qxl: simplify qxl_fence_wait
> =

>     Now that we have the new release_event wait queue we can just
>     use that in qxl_fence_wait() and simplify the code a lot.
> =

>     Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>     Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>     Link: http://patchwork.freedesktop.org/patch/msgid/20210204145712.153=
1203-10-kraxel@redhat.com
> =

> =

> and noticed that the bug does not occur if I boot 6.1 kernel with this pa=
tch
> reverted (see attached file).

Thanks for the excelent constructed report! I think it's best to
forward this directly to upstream including the people for the
bisected commit to get some idea.

Can you reproduce the issue with 6.5.8-1 in unstable as well?

If not, are you able to isolate an upstream fix which should be
backported to the 6.1.y series as well?

Regards,
Salvatore
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
