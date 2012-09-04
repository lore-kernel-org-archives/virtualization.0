From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 1/2] virtio_console: Add support for DMA memory allocation
Date: Tue, 04 Sep 2012 15:37:43 +0930
Message-ID: <87zk56e2xc.fsf@rustcorp.com.au>
References: <1346680277-5887-1-git-send-email-sjur.brandeland@stericsson.com>
	<20120903143018.GA5353@redhat.com>
	<CAJK669bkHHMAPYMEr22-6uOwfgJv1uKTbzNBQVVCq=OooExC0g@mail.gmail.com>
	<20120903202737.GD6181@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120903202737.GD6181@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Cc: Amit Shah <amit.shah@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> Also let's add a wrapper at top of file so ifdefs
> do not litter the code like this. For example:
>
> #ifdef CONFIG_HAS_DMA
> #define VIRTIO_CONSOLE_HAS_DMA (1)
> #else
> #define VIRTIO_CONSOLE_HAS_DMA (0)
> #endif
>
> Now use if instead of ifdef.

The driver certainly shouldn't offer VIRTIO_CONSOLE_F_DMA_MEM if you
don't have DMA!

Cheers,
Rusty.
