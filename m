From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/5] drivers/char: Constify static variables
Date: Thu, 2 Jul 2020 10:58:14 +0200
Message-ID: <CAK8P3a0iVY54EMWYDLdn3QoqmO0CkZMJk-P2G19epm8FCTX8bg@mail.gmail.com>
References: <20200701200950.30314-1-rikard.falkeborn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200701200950.30314-1-rikard.falkeborn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Shah <amit@kernel.org>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Corey Minyard <minyard@acm.org>, virtualization@lists.linux-foundation.org, openipmi-developer@lists.sourceforge.net, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 1, 2020 at 11:48 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> Constify some static variables (mostly structs) that are not modified.
>
> Rikard Falkeborn (5):
>   hwrng: bcm2835 - Constify bcm2835_rng_devtype[]
>   hwrng: nomadik - Constify nmk_rng_ids[]
>   hwrng: virtio - Constify id_table[]
>   ipmi: watchdog: Constify ident
>   virtio_console: Constify some static variables

I just realized it was a series rather than a single patch I received. They
all look correct, so

Acked-by: Arnd Bergmann <arnd@arndb.de>

but if you do more of those, I would suggest not including the 'size'
output for the small variables as that is not the main point here.
