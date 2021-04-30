Return-Path: <SRS0=eK/B=J3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC1DC433ED
	for <virtualization@archiver.kernel.org>; Fri, 30 Apr 2021 10:58:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591D261456
	for <virtualization@archiver.kernel.org>; Fri, 30 Apr 2021 10:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591D261456
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0445D84CC4;
	Fri, 30 Apr 2021 10:58:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vWY2bG4o_sli; Fri, 30 Apr 2021 10:58:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6990D84CDA;
	Fri, 30 Apr 2021 10:58:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFC40C0025;
	Fri, 30 Apr 2021 10:58:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C8F3C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Apr 2021 10:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1547C84CDA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Apr 2021 10:58:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t62F_qUfCfaU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Apr 2021 10:58:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C099184CC4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Apr 2021 10:58:45 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 68D0CB28F;
 Fri, 30 Apr 2021 10:58:43 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, kraxel@redhat.com, corbet@lwn.net, lgirdwood@gmail.com,
 broonie@kernel.org, sam@ravnborg.org, robh@kernel.org,
 emil.l.velikov@gmail.com, geert+renesas@glider.be, hdegoede@redhat.com,
 bluescreen_avenger@verizon.net, gregkh@linuxfoundation.org
Subject: [PATCH v5 0/9] drm: Support simple-framebuffer devices and firmware
 fbs
Date: Fri, 30 Apr 2021 12:58:31 +0200
Message-Id: <20210430105840.30515-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: virtualization@lists.linux-foundation.org,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
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

This patchset adds support for simple-framebuffer platform devices and
a handover mechanism for native drivers to take-over control of the
hardware.

The new driver, called simpledrm, binds to a simple-framebuffer platform
device. The kernel's boot code creates such devices for firmware-provided
framebuffers, such as EFI-GOP or VESA. Typically the BIOS, UEFI or boot
loader sets up the framebuffers. Description via device tree is also an
option.

Simpledrm is small enough to be linked into the kernel. The driver's main
purpose is to provide graphical output during the early phases of the boot
process, before the native DRM drivers are available. Native drivers are
typically loaded from an initrd ram disk. Occationally simpledrm can also
serve as interim solution on graphics hardware without native DRM driver.

So far distributions rely on fbdev drivers, such as efifb, vesafb or
simplefb, for early-boot graphical output. However fbdev is deprecated and
the drivers do not provide DRM interfaces for modern userspace.

Patches 1 and 2 prepare the DRM format helpers for simpledrm.

Patches 4 to 8 add the simpledrm driver. It's build on simple DRM helpers
and SHMEM. It supports 16-bit, 24-bit and 32-bit RGB framebuffers. During
pageflips, SHMEM buffers are copied into the framebuffer memory, similar
to cirrus or mgag200. The code in patches 7 and 8 handles clocks and
regulators. It's based on the simplefb drivers, but has been modified for
DRM. These patches will be squashed into one for the merger, so that the
result is bisectable.

Patches 3 and 9 add a hand-over mechanism. Simpledrm acquires it's
framebuffer's I/O-memory range and can be hot-unplugged by a native driver.
The native driver will remove simpledrm before taking over the hardware.
The removal is integrated into existing helpers, so existing drivers use
it automatically.

I've also been working on fastboot support (i.e., flicker-free booting).
This requires state-readout from simpledrm via generic interfaces, as
outlined in [1]. I do have some prototype code, but it will take a while
to get this ready. Simpledrm will then support it.

I've tested simpledrm with x86 EFI and VESA framebuffers, which both work
reliably. The fbdev console and Weston work automatically. Xorg requires
manual configuration of the device. Xorgs current modesetting driver does
not work with both, platform and PCI device, for the same physical
hardware. Once configured, X11 works. I looked into X11, but couldn't see
an easy way of fixing the problem. With the push towards Wayland+Xwayland
I expect the problem to become a non-issue soon. Additional testing has
been reported at [2].

One cosmetical issue is that simpledrm's device file is card0 and the
native driver's device file is card1. After simpledrm has been kicked out,
only card1 is left. This does not seem to be a practical problem however.

TODO/IDEAS:
	* provide deferred takeover
	* provide bootsplash DRM client
	* make simplekms usable with ARM-EFI fbs

v5:
	* fix build error introduced by rebasing v4
	* fix typo in documenation
v4:
	* provide interface for acquiring firmware framebuffers (Daniel)
	* make simpledrm and simplefb mutually exclusive (Maxime)
	* documentation fixes
v3:
	* clear screen to black when disabled (Daniel)
	* rebase onto existing aperture helpers
	* detach via hot-unplug via platform_device_unregister()
v2:
	* rename to simpledrm, aperture helpers
	* reorganized patches
	* use hotplug helpers for removal (Daniel)
	* added DT match tables (Rob)
	* use shadow-plane helpers
	* lots of minor cleanups

[1] https://lore.kernel.org/dri-devel/CAKMK7uHtqHy_oz4W7F+hmp9iqp7W5Ra8CxPvJ=9BwmvfU-O0gg@mail.gmail.com/
[2] https://lore.kernel.org/dri-devel/1761762.3HQLrFs1K7@nerdopolis/

Thomas Zimmermann (9):
  drm/format-helper: Pass destination pitch to drm_fb_memcpy_dstclip()
  drm/format-helper: Add blitter functions
  drm/aperture: Add infrastructure for aperture ownership
  drm: Add simpledrm driver
  drm/simpledrm: Add fbdev emulation
  drm/simpledrm: Initialize framebuffer data from device-tree node
  drm/simpledrm: Acquire clocks from DT device node
  drm/simpledrm: Acquire regulators from DT device node
  drm/simpledrm: Acquire memory aperture for framebuffer

 MAINTAINERS                            |   7 +
 drivers/gpu/drm/drm_aperture.c         | 221 +++++-
 drivers/gpu/drm/drm_format_helper.c    |  96 ++-
 drivers/gpu/drm/mgag200/mgag200_mode.c |   2 +-
 drivers/gpu/drm/tiny/Kconfig           |  16 +
 drivers/gpu/drm/tiny/Makefile          |   1 +
 drivers/gpu/drm/tiny/cirrus.c          |   2 +-
 drivers/gpu/drm/tiny/simpledrm.c       | 896 +++++++++++++++++++++++++
 drivers/video/fbdev/Kconfig            |   2 +-
 include/drm/drm_aperture.h             |   4 +
 include/drm/drm_format_helper.h        |  10 +-
 11 files changed, 1245 insertions(+), 12 deletions(-)
 create mode 100644 drivers/gpu/drm/tiny/simpledrm.c


base-commit: bf25e1addaf44137e20ce95de72ff118b37d808c
prerequisite-patch-id: c2b2f08f0eccc9f5df0c0da49fa1d36267deb11d
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
prerequisite-patch-id: c59ca2ddb182af06006fa360ad3e90fe16b93d3a
prerequisite-patch-id: dd15fb5fe2130e0dbf2fb7df6cae76d808ef6816
prerequisite-patch-id: 90618028e0df10398d6a0e4ae261e1e855905d38
prerequisite-patch-id: 3ee4d936e76da021ac3ea2dea586582813263876
prerequisite-patch-id: 8f302cdd86509f93ae2f573718264a7fb332c098
prerequisite-patch-id: b4b1d4a05a1db29696b3aea8572ff982677ec4b5
prerequisite-patch-id: 2a9db4556e8ecf0f2f2caa23ee288579d00ae002
--
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
