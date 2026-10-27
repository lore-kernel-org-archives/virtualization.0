Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098219;
	b=dWX/No8Yp7uPIj8RqzwjoQGfag/8JHX2FY5O2Adc0ESKDUIAPDo3VUDJQTbQxGjKa7L2
	 fAwhaSnCE7sp+Rq8ZS7vBZ+GIvUMpxNAcBzZ0aU+A8NQDE1rRp/W0ORQ43Ra/5ZcMYq/D
	 lJo1qkVVCcsiHyAm267XwZcXY0kjZ4gVkfbiCkBpfYuWRHeBfoPJTwuTDTgaVFfbNuYrg
	 2RQJMNR7nWtbjMyNveGer1xiP2/AW0caAJ1rYIFXKhS5TN2eROmbHyqMXqHn6DGYgUx78
	 pMFGH9B6bxXLDjS5qI66O/eQzXfu5eyhNXBqLf41m1cDtp3e5vfCLzhYrbSJQFbsBPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=XFZzZHqRNst1BMPTvXE87RueOS4Ft9OJQfvt5VLbbcE=;
	b=wwPOQNSBTaHvFyRzCHac7dAYYX2nXYuU5y3mumF/c91LNd4Q8zjBwnYFoKBYNHR5aTnb
	 2b7TbUiwnTztRLdAXrD+UL+RlIi/o0vN8/bhxydM9uxRUEvYr8R7h5mFR3wKirD+zzkjU
	 kPjOh34hSIEyZAqFd3fw2B3o0lRcVbJGHglrifkL5JcRZ5g7y9lO6MPlwvNPJPRiIyHyO
	 yqChVI8CmiLQfUG3uigtEy2W1YZZELRcpnP/KUxv3EZ3NVOawSj8h6VAZnlAj+rcuLRZz
	 sP76MdofRDYrLymNpMKNYwUVdh8ZRsr+4k3f4JmfMhoe0c2WUEzEy+GI90klXA1Vp9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lvVUB54F;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9094860A261D
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 10:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9094860A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lvVUB54F
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so608340f8f.0
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 03:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793098216; x=1793703016; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFZzZHqRNst1BMPTvXE87RueOS4Ft9OJQfvt5VLbbcE=;
        b=lvVUB54FX07PZbj8Rrjf0w6eN69IV+Y+8eU9FDv/u26hZ7rw+UhYvK5O7ciK0AE7SV
         OJjJqH8c1ebC9BweY1p2ufe80cRdcmV2VDmsJFlXA3X2+0KgQpyZQ9zo+PqFhJqXifcn
         ocj+9uOdKevfX+V+GHhsSmbDLcJboeVLVL8SUQ4CIi8uxhrQAzx4dG92ovECebzPswuo
         8gKkRDuU9wNmSjEWC3F8n8LTWn9JhRxRGiJgrt17uNo3270+/B3AJ7H7r3WtkAeRFsXg
         aOekhuTpGiCZHhmI+VPTbpZ39/AKnMax45NkqmKXm+TMDQS5KkZCNmMvuo/fSSFwrKnq
         TrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098216; x=1793703016;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XFZzZHqRNst1BMPTvXE87RueOS4Ft9OJQfvt5VLbbcE=;
        b=tEW7ZPRPwRINtgaaq2Nm1YO5xAxLSyBmJNGJX/NDarEb7dJon9wA/5XUinS6QjeCyT
         izMmmYA2Nk3rwcL9XJJLfDFl0sCxjCq8cfVaxAMxb1X6bHNEykpQPehK39czp97lyWlo
         IfILv6+p53c1U/Vp15EQnS19Sc4QiKH6v1Kai4OfcRNfvbDKQ8ZFBPBAizhVEOZn/V3S
         HNSeXsm4Bn7nZvJvS+sVO1rSdTCCzNWlEspZENWtnXai/xFJfN8zrvjnj00sPeieqhwl
         aNdEU2tnwMtCk0Askh+TN/n/WqOnF1R2gIMf7ESfg6NWa/Z/91N1JUc9ULP5uI+rH9yu
         Aqhg==
X-Forwarded-Encrypted: i=1; AKwUvBws1F4OPuOv4u+EKJQetUL8LzxyKjxp1QKuI1n42GxwcBGZ1vWyvxVnSiBcTbOiVGPNfT8l5ZIS4DQ1pi1oJw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKrZLf2Tm2vmC1VLG+z0GbPCwFkih6ZYYrBniAYdKdJewnHOEkZ
	6lmiDA9qZUHzdJDNtLccywMC2NHU9mHsK/3t8Uph4a4DtSXE0TjORPjIUwIikG+72eQ=
X-Gm-Gg: AYBFou2mVpJpHacaXxRdTjpzFuvX98I7w4lPVTIEWPJwB+Thgfh8nfGIl/9ZJlFRqrS
	Lwt6qgLbnvQDJa6kV+W667pGnHkBdSZmLh7VW8D0Yt0w08sOHiBf+tzBdMDKWm7VSDQdZo4ZMcJ
	Pxzn4PQ1/ZqO4cYjvs2JYvfU1aCe/Ra6cVm8xb6FLLZ1g0kJLTV6Ezz8QYkIKj19PfkS35bRwwY
	aVJpouKqIoW6qovVTJbpS0BN4281fJ8D81N4kVt8Qw2vLuVP67Ne740DDSkwaE0YGxY88mz/xR/
	4qdgePFNYqWgdkHhtB24JOffVUqxaaStbL9+1TrMuG4tkHGI+Cj2zwt4dDfEr9hXrtiTY5BZf7G
	zoHuK2bBxZXsggjNsp/DFVfipHfLeAepx4voEW8HudrMuiSANcApa1MC8VrWJiN+b+XBhBKFPTw
	x/eVzpIFZq4FMCHSIs5qOtPKm0tXewWl5tzZxDrbu4fMKxckVoykoMNCpKgEWzLKe7aaT58cJah
	KbY+plKAZacqiJORj8UTyesxVrWUUEmSIHpbhe8pdZe8rDiAo81O4c/K2Lty8gZP9OkfQqn+P6D
	oUPDW/Ts4kS1qZwf5qv/DgxH9OUbAbVROqmlPYlBRW0=
X-Received: by 2002:a05:6000:438a:b0:48e:884:affb with SMTP id ffacd0b85a97d-48e55a51758mr5422454f8f.24.1793098215724;
        Tue, 27 Oct 2026 03:50:15 -0700 (PDT)
Received: from localhost (p200300f65f19a904240e81f1f32a429c.dip0.t-ipconnect.de. [2003:f6:5f19:a904:240e:81f1:f32a:429c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48e3ebd48e0sm22735578f8f.38.2026.10.27.03.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:50:15 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Imre Kaloz <kaloz@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Hoan Tran <hoan@os.amperecomputing.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-hwmon@vger.kernel.org,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	virtualization@lists.linux.dev,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-aspeed@lists.ozlabs.org,
	asahi@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	openbmc@lists.ozlabs.org,
	linux-omap@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-unisoc@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Michael Buesch <m@bues.ch>,
	William Breathitt Gray <wbg@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org
Subject: [PATCH v4 00/23] gpio: Improvements around device-id arrays
Date: Tue, 27 Oct 2026 11:48:37 +0100
Message-ID: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8137; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=k1gONcl2UIxBepDw11jo8AHu6ai+O1G0nVgkSy8JdIE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq4IGGNXr36bKoBw2PaxVdVtkUGC9jXmJpRnHf2 Csas+gKAK2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCauCBhgAKCRCPgPtYfRL+ TniYCACv6CLczaP+IEWqqjNz0H2IDCNFuAhnXKDLb4106wpApOzW0y6gufg8fEnzsamxLLEBdjV dqq25XfWZfdmZg3FMHHPJqnBr5fh7Zg46EwNe1jZvPkIkqY78ho7ESao5AKRIVqqTbQRpIaZEgz NNeJQhmaiL16rAeAP+okNpbCcIyWa33O12ZEutJCFYTQrA6235nE9ZSMLfl07igU0+tu+iunwWQ mCsDqRmK3fija+zCgkc0dIt3ssbXfQa1/DrtcjbcwgL9Jsq5zWCdDhzr7Rb8pliP+Uu/VBJJxty 27ri9KePaXD/wGvqViL+tL8IZZtej2Vgp0hRAsZI/QNPpgp7
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

the original motivation for this series are the patches that convert the
arrays to use named initializers, see
https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
for the idea behind it. Looking left and right a bit while implementing
that, the series grew a bit.

Changes since v3 (available at
https://lore.kernel.org/all/cover.1793030820.git.u.kleine-koenig@baylibre.com):

 - Picked up review tags (b4 even found some from v2)
 - Add a 2nd MODULE_DEVICE_TABLE(of, ...) in drivers/gpio/gpio-mpc5200.c
   (My grep didn't handle >1 driver per file well), noticed by Sashiko
 - New patch to use named initializers for auxiliary_device_id arrays
 - Fix code style of of_device_id array in drivers/gpio/gpio-grgpio.c
   (My script doesn't handle of_device_id::name) and
   drivers/gpio/gpio-ppc44x.c (didn't exist yet when I sent v2 and
   failed to notice that for v3)
 - Fix code style of auxiliary_device_id array in
   drivers/gpio/gpio-shared-proxy.c, missed as I didn't have a script
   for auxiliary_device_id before.
 - Dropped a few broken email addresses from Cc:

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (23):
  gpio: Remove __maybe_unused annotations from acpi_device_id arrays
  gpio: fxl6408: Remove __maybe_unused annotations from of_device_id
    array
  gpio: Drop unused assignment of acpi_device_id driver data
  gpio: max7301: Drop unused assignment of spi_device_id driver data
  gpio: mmio: Drop unused assignment of platform_device_id driver data
  gpio: ljca: Drop unused assignment of auxiliary_device_id driver data
  gpio: xgene: Add missing ACPI module annotation
  gpio: sodaville: Add missing PCI module annotations
  gpio: Add missing OF module annotations
  gpio: pxa: Add missing platform module annotations
  gpio: pl061: Use empty initializer for amba_id terminator
  gpio: Use named initializers for acpi_device_id array
  gpio: Use named initializers for auxiliary_device_id arrays
  gpio: pcf857x: Use named initializers for of_device_id array
  gpio: bd73800: Use named initializers for platform_device_id array
  gpio: Use named initializers for spi_device_id array
  gpio: virtio: Use a named initializer for virtio_device_id array
  gpio: Unify style of acpi_device_id arrays
  gpio: Unify style of of_device_id arrays
  gpio: max77620: Unify style of platform_device_id array
  gpio: Unify style of spi_device_id arrays
  gpio: Unify style of pci_device_id arrays
  gpio: Unify style of various *_device_id arrays

 drivers/gpio/gpio-74x164.c          |  4 ++--
 drivers/gpio/gpio-adnp.c            |  4 ++--
 drivers/gpio/gpio-aggregator.c      |  2 +-
 drivers/gpio/gpio-altera-a10sr.c    |  2 +-
 drivers/gpio/gpio-altera.c          |  4 ++--
 drivers/gpio/gpio-amd8111.c         |  2 +-
 drivers/gpio/gpio-amdpt.c           |  8 ++++----
 drivers/gpio/gpio-aspeed-sgpio.c    | 10 ++++-----
 drivers/gpio/gpio-aspeed.c          | 10 ++++-----
 drivers/gpio/gpio-ath79.c           |  2 +-
 drivers/gpio/gpio-bcm-kona.c        |  1 +
 drivers/gpio/gpio-bd73800.c         |  4 ++--
 drivers/gpio/gpio-blzp1600.c        |  4 ++--
 drivers/gpio/gpio-brcmstb.c         |  2 +-
 drivers/gpio/gpio-bt8xx.c           |  2 +-
 drivers/gpio/gpio-cadence.c         |  6 +++---
 drivers/gpio/gpio-creg-snps.c       |  5 +++--
 drivers/gpio/gpio-davinci.c         |  8 ++++----
 drivers/gpio/gpio-dwapb.c           | 14 ++++++-------
 drivers/gpio/gpio-elkhartlake.c     |  2 +-
 drivers/gpio/gpio-em.c              |  4 ++--
 drivers/gpio/gpio-ep93xx.c          |  1 +
 drivers/gpio/gpio-ftgpio010.c       |  3 ++-
 drivers/gpio/gpio-fxl6408.c         |  2 +-
 drivers/gpio/gpio-graniterapids.c   |  4 ++--
 drivers/gpio/gpio-grgpio.c          |  6 +++---
 drivers/gpio/gpio-gw-pld.c          |  4 ++--
 drivers/gpio/gpio-hisi.c            |  6 +++---
 drivers/gpio/gpio-hlwd.c            |  4 ++--
 drivers/gpio/gpio-imx-scu.c         |  1 +
 drivers/gpio/gpio-ixp4xx.c          |  4 ++--
 drivers/gpio/gpio-ljca.c            |  4 ++--
 drivers/gpio/gpio-loongson-64bit.c  |  4 ++--
 drivers/gpio/gpio-lp3943.c          |  2 +-
 drivers/gpio/gpio-lpc32xx.c         |  4 ++--
 drivers/gpio/gpio-ltc4283.c         |  2 +-
 drivers/gpio/gpio-macsmc.c          |  4 ++--
 drivers/gpio/gpio-max3191x.c        | 12 +++++------
 drivers/gpio/gpio-max7301.c         |  2 +-
 drivers/gpio/gpio-max7360.c         |  8 ++++----
 drivers/gpio/gpio-max77620.c        |  4 ++--
 drivers/gpio/gpio-max77759.c        |  2 +-
 drivers/gpio/gpio-mb86s7x.c         |  2 +-
 drivers/gpio/gpio-ml-ioh.c          |  2 +-
 drivers/gpio/gpio-mlxbf.c           |  6 +++---
 drivers/gpio/gpio-mlxbf2.c          |  6 +++---
 drivers/gpio/gpio-mlxbf3.c          |  4 ++--
 drivers/gpio/gpio-mm-lantiq.c       |  2 +-
 drivers/gpio/gpio-mmio.c            |  3 +--
 drivers/gpio/gpio-mockup.c          |  4 ++--
 drivers/gpio/gpio-moxtet.c          |  4 ++--
 drivers/gpio/gpio-mpc5200.c         | 10 +++++----
 drivers/gpio/gpio-mpc8xxx.c         | 25 +++++++++++-----------
 drivers/gpio/gpio-mpfs.c            |  1 +
 drivers/gpio/gpio-mpsse.c           |  3 +--
 drivers/gpio/gpio-msc313.c          |  1 +
 drivers/gpio/gpio-mt7621.c          |  2 +-
 drivers/gpio/gpio-mvebu.c           | 13 ++++++------
 drivers/gpio/gpio-mxc.c             |  2 +-
 drivers/gpio/gpio-mxs.c             |  4 ++--
 drivers/gpio/gpio-nomadik.c         |  7 ++++---
 drivers/gpio/gpio-novalake-events.c |  4 ++--
 drivers/gpio/gpio-npcm-sgpio.c      |  6 +++---
 drivers/gpio/gpio-octeon.c          |  2 +-
 drivers/gpio/gpio-omap.c            |  2 +-
 drivers/gpio/gpio-palmas.c          | 10 ++++-----
 drivers/gpio/gpio-pca953x.c         |  4 ++--
 drivers/gpio/gpio-pca9570.c         |  2 +-
 drivers/gpio/gpio-pcf857x.c         | 26 +++++++++++------------
 drivers/gpio/gpio-pci-idio-16.c     |  3 ++-
 drivers/gpio/gpio-pcie-idio-24.c    |  8 +++++---
 drivers/gpio/gpio-pisosr.c          |  4 ++--
 drivers/gpio/gpio-pl061.c           |  2 +-
 drivers/gpio/gpio-pmic-eic-sprd.c   |  2 +-
 drivers/gpio/gpio-ppc44x.c          |  2 +-
 drivers/gpio/gpio-pxa.c             | 20 ++++++++++--------
 drivers/gpio/gpio-qixis-fpga.c      |  3 +--
 drivers/gpio/gpio-rcar.c            |  2 +-
 drivers/gpio/gpio-rda.c             |  2 +-
 drivers/gpio/gpio-realtek-otto.c    |  2 +-
 drivers/gpio/gpio-rockchip.c        |  4 ++--
 drivers/gpio/gpio-sama5d2-piobu.c   |  2 +-
 drivers/gpio/gpio-shared-proxy.c    |  2 +-
 drivers/gpio/gpio-sifive.c          |  2 +-
 drivers/gpio/gpio-sl28cpld.c        |  2 +-
 drivers/gpio/gpio-sodaville.c       |  3 ++-
 drivers/gpio/gpio-spear-spics.c     |  3 ++-
 drivers/gpio/gpio-sprd.c            |  2 +-
 drivers/gpio/gpio-stmpe.c           |  2 +-
 drivers/gpio/gpio-stp-xway.c        |  2 +-
 drivers/gpio/gpio-tc9563.c          |  2 +-
 drivers/gpio/gpio-tegra.c           |  6 +++---
 drivers/gpio/gpio-tegra186.c        | 32 ++++++++++++++---------------
 drivers/gpio/gpio-thunderx.c        |  3 +--
 drivers/gpio/gpio-tps65218.c        |  2 +-
 drivers/gpio/gpio-ts4800.c          |  4 ++--
 drivers/gpio/gpio-ts4900.c          |  2 +-
 drivers/gpio/gpio-twl4030.c         |  4 ++--
 drivers/gpio/gpio-usbio.c           | 14 ++++++-------
 drivers/gpio/gpio-vf610.c           |  4 ++--
 drivers/gpio/gpio-virtio.c          |  4 ++--
 drivers/gpio/gpio-visconti.c        |  2 +-
 drivers/gpio/gpio-waveshare-dsi.c   |  2 +-
 drivers/gpio/gpio-xgene-sb.c        |  6 +++---
 drivers/gpio/gpio-xgene.c           | 10 +++++----
 drivers/gpio/gpio-xgs-iproc.c       |  2 +-
 drivers/gpio/gpio-xilinx.c          |  4 ++--
 drivers/gpio/gpio-xlp.c             |  6 +++---
 drivers/gpio/gpio-xra1403.c         |  6 +++---
 drivers/gpio/gpio-zevio.c           |  5 +++--
 drivers/gpio/gpio-zynqmp-modepin.c  |  2 +-
 drivers/gpio/gpiolib-acpi-quirks.c  |  2 +-
 112 files changed, 278 insertions(+), 260 deletions(-)


base-commit: 20a33c6b6cbe7e4805dfb6cd68816937443aa148
-- 
2.56.0.rc1

