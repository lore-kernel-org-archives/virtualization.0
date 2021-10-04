Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59069C433F5
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 12:49:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B693961264
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 12:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B693961264
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 835774272B;
	Mon,  4 Oct 2021 12:49:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id prq5pE5fIO7E; Mon,  4 Oct 2021 12:49:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2812442723;
	Mon,  4 Oct 2021 12:49:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1189C000F;
	Mon,  4 Oct 2021 12:49:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47DF5C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 12:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43F0160C0E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 12:49:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VR8qHYvR2P5a
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 12:49:42 +0000 (UTC)
X-Greylist: delayed 00:05:01 by SQLgrey-1.8.0
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A605A60BDD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 12:49:41 +0000 (UTC)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:9ca4:a53a:9ffa:e003])
 by baptiste.telenet-ops.be with bizsmtp
 id 1okb2600G11933301okbfx; Mon, 04 Oct 2021 14:44:38 +0200
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1mXNKd-001rhi-9u; Mon, 04 Oct 2021 14:44:35 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1mXNKc-0042wr-Lg; Mon, 04 Oct 2021 14:44:34 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Enrico@rox.of.borg,
 Weigelt@rox.of.borg, metux IT consult <lkml@metux.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH] gpio: aggregator: Add interrupt support
Date: Mon,  4 Oct 2021 14:44:33 +0200
Message-Id: <c987d0bf744150ca05bd952f5f9e5fb3244d27b0.1633350340.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org,
 linux-gpio@vger.kernel.org, stratos-dev@op-lists.linaro.org
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

Currently the GPIO Aggregator does not support interrupts.  This means
that kernel drivers going from a GPIO to an IRQ using gpiod_to_irq(),
and userspace applications using line events do not work.

Add interrupt support by providing a gpio_chip.to_irq() callback, which
just calls into the parent GPIO controller.

Note that this does not implement full interrupt controller (irq_chip)
support, so using e.g. gpio-keys with "interrupts" instead of "gpios"
still does not work.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
I would prefer to avoid implementing irq_chip support, until there is a
real use case for this.

This has been tested with gpio-keys and gpiomon on the Koelsch
development board:

  - gpio-keys, using a DT overlay[1]:

	$ overlay add r8a7791-koelsch-keyboard-controlled-led
	$ echo gpio-aggregator > /sys/devices/platform/frobnicator/driver_override
	$ echo frobnicator > /sys/bus/platform/drivers/gpio-aggregator/bind

	$ gpioinfo frobnicator
	gpiochip12 - 3 lines:
		line   0:      "light"      "light"  output  active-high [used]
		line   1:         "on"         "On"   input   active-low [used]
		line   2:        "off"        "Off"   input   active-low [used]

	$ echo 255 > /sys/class/leds/light/brightness
	$ echo 0 > /sys/class/leds/light/brightness

	$ evtest /dev/input/event0

  - gpiomon, using the GPIO sysfs API:

	$ echo keyboard > /sys/bus/platform/drivers/gpio-keys/unbind
	$ echo e6055800.gpio 2,6 > /sys/bus/platform/drivers/gpio-aggregator/new_device
	$ gpiomon gpiochip12 0 1

[1] "ARM: dts: koelsch: Add overlay for keyboard-controlled LED"
    https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/commit/?h=topic/renesas-overlays&id=c78d817869e63a3485bb4ab98aeea6ce368a396e
---
 drivers/gpio/gpio-aggregator.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 34e35b64dcdc0581..2ff867d2a3630d3b 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -374,6 +374,13 @@ static int gpio_fwd_set_config(struct gpio_chip *chip, unsigned int offset,
 	return gpiod_set_config(fwd->descs[offset], config);
 }
 
+static int gpio_fwd_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
+
+	return gpiod_to_irq(fwd->descs[offset]);
+}
+
 /**
  * gpiochip_fwd_create() - Create a new GPIO forwarder
  * @dev: Parent device pointer
@@ -414,7 +421,8 @@ static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
 	for (i = 0; i < ngpios; i++) {
 		struct gpio_chip *parent = gpiod_to_chip(descs[i]);
 
-		dev_dbg(dev, "%u => gpio-%d\n", i, desc_to_gpio(descs[i]));
+		dev_dbg(dev, "%u => gpio %d irq %d\n", i,
+			desc_to_gpio(descs[i]), gpiod_to_irq(descs[i]));
 
 		if (gpiod_cansleep(descs[i]))
 			chip->can_sleep = true;
@@ -432,6 +440,7 @@ static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
 	chip->get_multiple = gpio_fwd_get_multiple_locked;
 	chip->set = gpio_fwd_set;
 	chip->set_multiple = gpio_fwd_set_multiple_locked;
+	chip->to_irq = gpio_fwd_to_irq;
 	chip->base = -1;
 	chip->ngpio = ngpios;
 	fwd->descs = descs;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
