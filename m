Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ED62F3E;
	Thu, 10 Jul 2025 04:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121293; cv=pass; b=rrXXboI0cPWgZ4dJONvsTTA8PIBpzyEeDZ2w6iFNbyTWA3wJrmQK0wJO4m5uFnPwOGpwcKoi9XuucOqGG89pZm8lpyy8ZGKzh2voJjoWnI/emDrkPR2UsKKxsCHpm7x6IkyuDNCLkaCNVM3YBuH6ItRmLZOb9vJURsfI4Q7Gavc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121293; c=relaxed/simple;
	bh=2VbC2+PHxu7MfeflJa6IM8C0NP5yvx9ELdjXHHwMqB0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=jpDnOGgJjH6gOjsTOWbHce8cI9S7/LAuFyQ/wEdeGXH+IxVymi+xMQZTYgZa0swOw/6tLmrQ6ZvbPrN3icusmvGCqGU5nNPDah8XWWSxD7UXKMOAI2zZOIqAYElgqgqJCU2m66YmL7Z15CrrxCY6HZMcDE+mFfC4M1tqILL+7Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=ZuvkDFZw; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="ZuvkDFZw"
ARC-Seal: i=1; a=rsa-sha256; t=1752121274; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jGi44jQwA7tguYk5YZjML2i+Nulyuo9Ynfuhu1ecDj5pcnzZ2W72tZXT6aTn0TLFWhGI+r9LdE7yIStE7CKwyGJnixDvsd5QaecrxTTMFfrQKvWt/By93jWfMpiK9IL2/ByRdu4YhNlkhJAYOlJq7VZFzQTapSMRMX56GEjZ8jQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752121274; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=na0G9oSIayf8FlikNV7gtwZPYaQOEoLGKYXdYzgdS9k=; 
	b=a+V65wFS5esFJUWEc13f9P+NNakTyfo7t82YJPu/is0v64yVcN6PGls9ClCrdUa+oAnan7wcsxQsqsN4dsrDmIudiwOAe+R02gQd15ddOH+BoaIbFMf339RCgdaAoHXK6XKLJfyrxW0tFSXeikRUpBs9Km6jTpFAsF4wO5wj5sk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752121274;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=na0G9oSIayf8FlikNV7gtwZPYaQOEoLGKYXdYzgdS9k=;
	b=ZuvkDFZwQeBjmWLmCjVbIgizfhlqTLDV+tQhbMRxfgBVsD+wKYwvJoUny/SsQEIS
	Nxl5gw2CetJSJdrH0U74VEvSSy8Kd/dGrqkuu/0uISWuSsjaFN0VILY6TOnlq1fThk7
	l9P8PaB+MqnaS5+BlzYj2w7D8/V1V8DiAW7jYvW4=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1752121271070711.9049000586574; Wed, 9 Jul 2025 21:21:11 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Wed, 9 Jul 2025 21:21:11 -0700 (PDT)
Date: Thu, 10 Jul 2025 08:21:11 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: "Gerd Hoffmann" <kraxel@redhat.com>,
	=?UTF-8?Q?=22Noralf_Tr=C3=B8nnes=22?= <noralf@tronnes.org>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	"Maxime Ripard" <mripard@kernel.org>,
	"virtualization" <virtualization@lists.linux.dev>,
	"ryasuoka" <ryasuoka@redhat.com>,
	"dri-devel" <dri-devel@lists.freedesktop.org>,
	"qemu-devel" <qemu-devel@nongnu.org>,
	"regressions" <regressions@lists.linux.dev>,
	"Ben Hutchings" <benh@debian.org>
Message-ID: <197f290e30b.eaadc7bc7913.7315623184036672946@zohomail.com>
In-Reply-To: 
Subject: [REGRESSION][BISECTED] kernel panic is not displayed correctly in
 qemu (CONFIG_DRM_BOCHS)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr0801122790668314d3e7598558fab2f00000b21b3131e1cba2be67469372c133335d571ffc8e519baac7e9:zu08011227d7920ca060ce8fe32fd401540000013924a5d43a3055ccb51e43fa56fe3fe68126103551561102:rf0801122c2ab99bbc73d925393f3821570000c3b2a3c5e818d6fc6d6488d74d56ca5edd8f3ed2b5cf3f3cc4cb6569b782:ZohoMail

Steps to reproduce:

- Build Linux v6.16-rc5 so:

$ cat mini
CONFIG_64BIT=3Dy

CONFIG_EXPERT=3Dy
CONFIG_EMBEDDED=3Dy

CONFIG_PRINTK=3Dy
CONFIG_PRINTK_TIME=3Dy

CONFIG_PCI=3Dy

CONFIG_TTY=3Dy
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_DRM=3Dy
CONFIG_DRM_FBDEV_EMULATION=3Dy
CONFIG_DRM_BOCHS=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_PROC_FS=3Dy
$ make KCONFIG_ALLCONFIG=3Dmini allnoconfig
$ make

- Then boot this Linux image in Qemu so:

$ qemu-system-x86_64 -enable-kvm -m 1024 -daemonize -kernel arch/x86_64/boo=
t/bzImage

Kernel will (predictably) panic (because it has no initramfs, nor real disk=
), but actual panic message will not be shown!

Last shown line is "Run /bin/sh as init process"

My host OS is Debian Trixie. "uname -a":

Linux receipt 6.12.33+deb13-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.33-1 (=
2025-06-19) x86_64 GNU/Linux

Qemu version is:

QEMU emulator version 10.0.2 (Debian 1:10.0.2+ds-1)

Guest kernel is v6.16-rc5 x86_64.

The problem doesn't reproduce on old guest kernels. I. e. old guest kernels=
 actually show panic message.

I did bisect, and bisect showed the following two commits:

=3D=3D=3D

commit a6c3464f69cf5a8a31eb31cc436e7dbd325b8ff9
Author: Thomas Zimmermann <tzimmermann@suse.de>
Date:   Thu Jun 13 09:30:33 2019 +0200

    drm/gem-vram: Support pinning buffers to current location
   =20
    Pinning a buffer prevents it from being moved to a different memory
    location. For some operations, such as buffer updates, it is not
    important where the buffer is located. Setting the pin function's
    pl_flag argument to 0 will pin the buffer to whereever it is stored.
   =20
    v2:
            * document pin flags in PRIME pin helper
   =20
    Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
    Acked-by: Gerd Hoffmann <kraxel@redhat.com>
    Link: https://patchwork.freedesktop.org/patch/msgid/20190613073041.2935=
0-2-tzimmermann@suse.de

commit 58540594570778fd149cd8c9b2bff61f2cefa8c9
Author: Thomas Zimmermann <tzimmermann@suse.de>
Date:   Wed Jul 3 09:58:34 2019 +0200

    drm/bochs: Use shadow buffer for bochs framebuffer console
   =20
    The bochs driver (and virtual hardware) requires buffer objects to
    reside in video ram to display them to the screen. So it can not
    display the framebuffer console because the respective buffer object
    is permanently pinned in system memory.
   =20
    Using a shadow buffer for the console solves this problem. The console
    emulation will pin the buffer object only during updates from the shado=
w
    buffer. Otherwise, the bochs driver can freely relocated the buffer
    between system memory and video ram.
   =20
    v2:
            * select shadow FB via struct drm_mode_config.prefer_shadow_fbd=
ev
   =20
    Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
    Acked-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
    Link: https://patchwork.freedesktop.org/patch/315833/
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

=3D=3D=3D

Commit a6c3464f69cf5a8a31e changed good behavior to absolutely wrong: after=
 a6c3464f69cf5a8a31e I see just black screen.
Then (after many commits) 58540594570778fd149 made screen working again, bu=
t now panics are not shown.

So, result: all commits in range a6c3464f69cf5a8a31e .. 58540594570778fd149=
 are not testable (black screen), all commits before a6c3464f69cf5a8a31e
are "good" (panic is shown) and all commits after 58540594570778fd149 (incl=
usive) (including v6.16-rc5) are "bad" (panic is not shown).

The next commit after 58540594570778fd149 is 5fd5d2b7c53de5a1290d82, thus c=
orrect regzbot instruction is:

#regzbot introduced: a6c3464f69cf5a8a31e..5fd5d2b7c53de5a1290d82

Config above is not special. It is result of minimizing standard Debian con=
fig.

The bug is reproducible with standard Debian kernels (if we use them as gue=
sts).

Reproduction steps are so:
- Install Debian Trixie to Qemu VM
- Boot it with "init=3D/bin/true" added (to cause kernel panic)

You will not see panic message.

I minimized this Debian bug to small config shown in the beginning of this =
letter.

--
Askar Safin
https://types.pl/@safinaskar

