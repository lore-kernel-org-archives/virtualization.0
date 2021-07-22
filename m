Return-Path: <SRS0=qcdz=MO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D676C63793
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 08:46:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA4B61357
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 08:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA4B61357
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4C7460AD9;
	Thu, 22 Jul 2021 08:46:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sNzeazT5ClS0; Thu, 22 Jul 2021 08:46:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 15FC660AD6;
	Thu, 22 Jul 2021 08:46:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE67CC001A;
	Thu, 22 Jul 2021 08:46:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D485C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 08:46:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF6A24013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 08:46:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hYO4fgLys8Th
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 08:46:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DCC34400D2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 08:46:00 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A43AE6128C;
 Thu, 22 Jul 2021 08:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1626943559;
 bh=iHEKpKP05yPtSDo0WVw13tR4OsPIw3x7iurEQu7Pc7Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d2l4V14jYNVya/romP2w2ezg4x2LnX47K9dLSJmCxQOKyIqkdonEoIsuSyzycFfD4
 aHamBXJweC7B8K4Qi3lPBaud6oc7vHctb7fViEzj6oXWZWpeL9VSuOZpThr23TyNei
 Kh7xAATxCTMeB2NBX21iFqK668swZChaCi9FSwpo=
Date: Thu, 22 Jul 2021 10:45:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 0/5] bus: Make remove callback return void
Message-ID: <YPkwQwf0dUKnGA7L@kroah.com>
References: <20210713193522.1770306-1-u.kleine-koenig@pengutronix.de>
 <YPfyZen4Y0uDKqDT@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YPfyZen4Y0uDKqDT@kroah.com>
Cc: nvdimm@lists.linux.dev, linux-sh@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
 Jens Taprogge <jens.taprogge@taprogge.org>, Jaroslav Kysela <perex@perex.cz>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Wei Liu <wei.liu@kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Halil Pasic <pasic@linux.ibm.com>, linux-acpi@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-pci@vger.kernel.org,
 xen-devel@lists.xenproject.org, Tomas Winkler <tomas.winkler@intel.com>,
 Julien Grall <jgrall@amazon.com>, Ohad Ben-Cohen <ohad@wizery.com>,
 Yufen Yu <yuyufen@huawei.com>, Alex Elder <elder@kernel.org>,
 linux-parisc@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>,
 Geoff Levand <geoff@infradead.org>, linux-fpga@vger.kernel.org,
 linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, kernel@pengutronix.de,
 Jon Mason <jdmason@kudzu.us>, linux-ntb@googlegroups.com,
 Wu Hao <hao.wu@intel.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Manohar Vanga <manohar.vanga@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, linux-wireless@vger.kernel.org,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 virtualization@lists.linux-foundation.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 target-devel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-i2c@vger.kernel.org, linux-s390@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Jiri Slaby <jirislaby@kernel.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 YueHaibing <yuehaibing@huawei.com>, industrypack-devel@lists.sourceforge.net,
 linux-mips@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>,
 William Breathitt Gray <vilhelm.gray@gmail.com>, greybus-dev@lists.linaro.org,
 linux-m68k@lists.linux-m68k.org, Florian Fainelli <f.fainelli@gmail.com>,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>, Frank Li <lznuaa@gmail.com>,
 Mark Gross <mgross@linux.intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, Johannes Thumshirn <morbidrsa@gmail.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Peter Oberparleiter <oberpar@linux.ibm.com>,
 Wolfram Sang <wsa@kernel.org>, Joey Pabalan <jpabalanb@gmail.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
 Bodo Stroesser <bostroesser@gmail.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Tyrel Datwyler <tyreld@linux.ibm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Tom Rix <trix@redhat.com>, SeongJae Park <sjpark@amazon.de>,
 alsa-devel@alsa-project.org, platform-driver-x86@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org,
 Vineeth Vijayan <vneethv@linux.ibm.com>, Ira Weiny <ira.weiny@intel.com>,
 Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Dave Jiang <dave.jiang@intel.com>, linux-staging@lists.linux.dev,
 Dexuan Cui <decui@microsoft.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-input@vger.kernel.org, Matt Porter <mporter@kernel.crashing.org>,
 Allen Hubbe <allenbh@gmail.com>, Alex Dubov <oakad@yahoo.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Jiri Kosina <jikos@kernel.org>,
 "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>,
 Ben Widawsky <ben.widawsky@intel.com>,
 Harald Freudenberger <freude@linux.ibm.com>, linux-cxl@vger.kernel.org,
 Michael Buesch <m@bues.ch>, Dan Williams <dan.j.williams@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Cristian Marussi <cristian.marussi@arm.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Martyn Welch <martyn@welchs.me.uk>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc@vger.kernel.org,
 linux-sunxi@lists.linux.dev, Stefan Richter <stefanr@s5r6.in-berlin.de>,
 Sudeep Holla <sudeep.holla@arm.com>, "David S. Miller" <davem@davemloft.net>,
 Sven Van Asbroeck <TheSven73@gmail.com>, Rich Felker <dalias@libc.org>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 sparclinux@vger.kernel.org, Kirti Wankhede <kwankhede@nvidia.com>,
 Andreas Noever <andreas.noever@gmail.com>, linux-i3c@lists.infradead.org,
 linux1394-devel@lists.sourceforge.net, Lee Jones <lee.jones@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-scsi@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Thorsten Scherer <t.scherer@eckelmann.de>, Andy Gross <agross@kernel.org>,
 linux-serial@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 linux-hyperv@vger.kernel.org, Michael Jamet <michael.jamet@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Johan Hovold <johan@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Juergen Gross <jgross@suse.com>,
 linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
 Alexandre Bounine <alex.bou9@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Mark Brown <broonie@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
 dmaengine@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 Maximilian Luz <luzmaximilian@gmail.com>
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

On Wed, Jul 21, 2021 at 12:09:41PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 13, 2021 at 09:35:17PM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello,
> > =

> > this is v4 of the final patch set for my effort to make struct
> > bus_type::remove return void.
> > =

> > The first four patches contain cleanups that make some of these
> > callbacks (more obviously) always return 0. They are acked by the
> > respective maintainers. Bjorn Helgaas explicitly asked to include the
> > pci patch (#1) into this series, so Greg taking this is fine. I assume
> > the s390 people are fine with Greg taking patches #2 to #4, too, they
> > didn't explicitly said so though.
> > =

> > The last patch actually changes the prototype and so touches quite some
> > drivers and has the potential to conflict with future developments, so I
> > consider it beneficial to put these patches into next soon. I expect
> > that it will be Greg who takes the complete series, he already confirmed
> > via irc (for v2) to look into this series.
> > =

> > The only change compared to v3 is in the fourth patch where I modified a
> > few more drivers to fix build failures. Some of them were found by build
> > bots (thanks!), some of them I found myself using a regular expression
> > search. The newly modified files are:
> > =

> >  arch/sparc/kernel/vio.c
> >  drivers/nubus/bus.c
> >  drivers/sh/superhyway/superhyway.c
> >  drivers/vlynq/vlynq.c
> >  drivers/zorro/zorro-driver.c
> >  sound/ac97/bus.c
> > =

> > Best regards
> > Uwe
> =

> Now queued up.  I can go make a git tag that people can pull from after
> 0-day is finished testing this to verify all is good, if others need it.

Ok, here's a tag that any other subsystem can pull from if they want
these changes in their tree before 5.15-rc1 is out.  I might pull it
into my char-misc-next tree as well just to keep that tree sane as it
seems to pick up new busses on a regular basis...

thanks,

greg k-h

-----------------------------------


The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags=
/bus_remove_return_void-5.15

for you to fetch changes up to fc7a6209d5710618eb4f72a77cd81b8d694ecf89:

  bus: Make remove callback return void (2021-07-21 11:53:42 +0200)

----------------------------------------------------------------
Bus: Make remove callback return void tag

Tag for other trees/branches to pull from in order to have a stable
place to build off of if they want to add new busses for 5.15.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Uwe Kleine-K=F6nig (5):
      PCI: endpoint: Make struct pci_epf_driver::remove return void
      s390/cio: Make struct css_driver::remove return void
      s390/ccwgroup: Drop if with an always false condition
      s390/scm: Make struct scm_driver::remove return void
      bus: Make remove callback return void

 arch/arm/common/locomo.c                  | 3 +--
 arch/arm/common/sa1111.c                  | 4 +---
 arch/arm/mach-rpc/ecard.c                 | 4 +---
 arch/mips/sgi-ip22/ip22-gio.c             | 3 +--
 arch/parisc/kernel/drivers.c              | 5 ++---
 arch/powerpc/platforms/ps3/system-bus.c   | 3 +--
 arch/powerpc/platforms/pseries/ibmebus.c  | 3 +--
 arch/powerpc/platforms/pseries/vio.c      | 3 +--
 arch/s390/include/asm/eadm.h              | 2 +-
 arch/sparc/kernel/vio.c                   | 4 +---
 drivers/acpi/bus.c                        | 3 +--
 drivers/amba/bus.c                        | 4 +---
 drivers/base/auxiliary.c                  | 4 +---
 drivers/base/isa.c                        | 4 +---
 drivers/base/platform.c                   | 4 +---
 drivers/bcma/main.c                       | 6 ++----
 drivers/bus/sunxi-rsb.c                   | 4 +---
 drivers/cxl/core.c                        | 3 +--
 drivers/dax/bus.c                         | 4 +---
 drivers/dma/idxd/sysfs.c                  | 4 +---
 drivers/firewire/core-device.c            | 4 +---
 drivers/firmware/arm_scmi/bus.c           | 4 +---
 drivers/firmware/google/coreboot_table.c  | 4 +---
 drivers/fpga/dfl.c                        | 4 +---
 drivers/hid/hid-core.c                    | 4 +---
 drivers/hid/intel-ish-hid/ishtp/bus.c     | 4 +---
 drivers/hv/vmbus_drv.c                    | 5 +----
 drivers/hwtracing/intel_th/core.c         | 4 +---
 drivers/i2c/i2c-core-base.c               | 5 +----
 drivers/i3c/master.c                      | 4 +---
 drivers/input/gameport/gameport.c         | 3 +--
 drivers/input/serio/serio.c               | 3 +--
 drivers/ipack/ipack.c                     | 4 +---
 drivers/macintosh/macio_asic.c            | 4 +---
 drivers/mcb/mcb-core.c                    | 4 +---
 drivers/media/pci/bt8xx/bttv-gpio.c       | 3 +--
 drivers/memstick/core/memstick.c          | 3 +--
 drivers/mfd/mcp-core.c                    | 3 +--
 drivers/misc/mei/bus.c                    | 4 +---
 drivers/misc/tifm_core.c                  | 3 +--
 drivers/mmc/core/bus.c                    | 4 +---
 drivers/mmc/core/sdio_bus.c               | 4 +---
 drivers/net/netdevsim/bus.c               | 3 +--
 drivers/ntb/core.c                        | 4 +---
 drivers/ntb/ntb_transport.c               | 4 +---
 drivers/nubus/bus.c                       | 6 ++----
 drivers/nvdimm/bus.c                      | 3 +--
 drivers/pci/endpoint/pci-epf-core.c       | 7 ++-----
 drivers/pci/pci-driver.c                  | 3 +--
 drivers/pcmcia/ds.c                       | 4 +---
 drivers/platform/surface/aggregator/bus.c | 4 +---
 drivers/platform/x86/wmi.c                | 4 +---
 drivers/pnp/driver.c                      | 3 +--
 drivers/rapidio/rio-driver.c              | 4 +---
 drivers/rpmsg/rpmsg_core.c                | 7 ++-----
 drivers/s390/block/scm_drv.c              | 4 +---
 drivers/s390/cio/ccwgroup.c               | 6 +-----
 drivers/s390/cio/chsc_sch.c               | 3 +--
 drivers/s390/cio/css.c                    | 7 +++----
 drivers/s390/cio/css.h                    | 2 +-
 drivers/s390/cio/device.c                 | 9 +++------
 drivers/s390/cio/eadm_sch.c               | 4 +---
 drivers/s390/cio/scm.c                    | 5 +++--
 drivers/s390/cio/vfio_ccw_drv.c           | 3 +--
 drivers/s390/crypto/ap_bus.c              | 4 +---
 drivers/scsi/scsi_debug.c                 | 3 +--
 drivers/sh/superhyway/superhyway.c        | 8 ++------
 drivers/siox/siox-core.c                  | 4 +---
 drivers/slimbus/core.c                    | 4 +---
 drivers/soc/qcom/apr.c                    | 4 +---
 drivers/spi/spi.c                         | 4 +---
 drivers/spmi/spmi.c                       | 3 +--
 drivers/ssb/main.c                        | 4 +---
 drivers/staging/fieldbus/anybuss/host.c   | 4 +---
 drivers/staging/greybus/gbphy.c           | 4 +---
 drivers/target/loopback/tcm_loop.c        | 5 ++---
 drivers/thunderbolt/domain.c              | 4 +---
 drivers/tty/serdev/core.c                 | 4 +---
 drivers/usb/common/ulpi.c                 | 4 +---
 drivers/usb/serial/bus.c                  | 4 +---
 drivers/usb/typec/bus.c                   | 4 +---
 drivers/vdpa/vdpa.c                       | 4 +---
 drivers/vfio/mdev/mdev_driver.c           | 4 +---
 drivers/virtio/virtio.c                   | 3 +--
 drivers/vlynq/vlynq.c                     | 4 +---
 drivers/vme/vme.c                         | 4 +---
 drivers/xen/xenbus/xenbus.h               | 2 +-
 drivers/xen/xenbus/xenbus_probe.c         | 4 +---
 drivers/zorro/zorro-driver.c              | 3 +--
 include/linux/device/bus.h                | 2 +-
 include/linux/pci-epf.h                   | 2 +-
 sound/ac97/bus.c                          | 6 ++----
 sound/aoa/soundbus/core.c                 | 4 +---
 93 files changed, 107 insertions(+), 263 deletions(-)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
