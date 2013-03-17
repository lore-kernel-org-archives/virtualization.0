From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCHv3 vringh] caif_virtio: Introduce caif over virtio
Date: Mon, 18 Mar 2013 00:52:19 +0200
Message-ID: <CAK=WgbbV6mvYC+KeSKJR+jmrAy3Et5opzzno1_kaicMPdDxNXg__33049.3683614351$1363560793$gmane$org@mail.gmail.com>
References: <1363340537-16011-1-git-send-email-erwan.yvin@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363340537-16011-1-git-send-email-erwan.yvin@stericsson.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Erwan Yvin <erwan.yvin@stericsson.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>, netdev <netdev@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Rusty Russel <rusty@ruscorp.com.au>, "David S. Miller" <davem@davemloft.net>, Sjur Braendeland <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Erwan,

On Fri, Mar 15, 2013 at 11:42 AM, Erwan Yvin <erwan.yvin@stericsson.com> wrote:
> diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
> new file mode 100644
> index 0000000..6a745dd
> --- /dev/null
> +++ b/drivers/net/caif/caif_virtio.c
> @@ -0,0 +1,786 @@
> +/*
> + * Copyright (C) ST-Ericsson AB 2013
> + * Authors: Vicram Arv / vikram.arv@stericsson.com,
> + *         Dmitry Tarnyagin / dmitry.tarnyagin@stericsson.com
> + *         Sjur Brendeland / sjur.brandeland@stericsson.com
> + * License terms: GNU General Public License (GPL) version 2
> + */
> +#include <linux/module.h>
> +#include <linux/if_arp.h>
> +#include <linux/virtio.h>
> +#include <linux/vringh.h>
> +#include <linux/debugfs.h>
> +#include <linux/spinlock.h>
> +#include <linux/genalloc.h>
> +#include <linux/interrupt.h>
> +#include <linux/netdevice.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/remoteproc.h>

The driver looks nicely decoupled from remoteproc - do you still need
remoteproc.h ?

Thanks,
Ohad.
