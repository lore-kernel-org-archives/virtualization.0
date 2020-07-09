From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 0/5] drivers/char: Constify static variables
Date: Thu, 9 Jul 2020 22:54:47 +1000
Message-ID: <20200709125447.GD31057@gondor.apana.org.au>
References: <20200701200950.30314-1-rikard.falkeborn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-crypto-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200701200950.30314-1-rikard.falkeborn@gmail.com>
Sender: linux-crypto-owner@vger.kernel.org
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>, Matt Mackall <mpm@selenic.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Corey Minyard <minyard@acm.org>, virtualization@lists.linux-foundation.org, openipmi-developer@lists.sourceforge.net, bcm-kernel-feedback-list@broadcom.com, linux-crypto@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 01, 2020 at 10:09:45PM +0200, Rikard Falkeborn wrote:
> Constify some static variables (mostly structs) that are not modified.
> 
> Rikard Falkeborn (5):
>   hwrng: bcm2835 - Constify bcm2835_rng_devtype[]
>   hwrng: nomadik - Constify nmk_rng_ids[]
>   hwrng: virtio - Constify id_table[]
>   ipmi: watchdog: Constify ident
>   virtio_console: Constify some static variables
> 
>  drivers/char/hw_random/bcm2835-rng.c | 2 +-
>  drivers/char/hw_random/nomadik-rng.c | 2 +-
>  drivers/char/hw_random/virtio-rng.c  | 2 +-
>  drivers/char/ipmi/ipmi_watchdog.c    | 2 +-
>  drivers/char/virtio_console.c        | 8 ++++----
>  5 files changed, 8 insertions(+), 8 deletions(-)

Patches 1-3 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
