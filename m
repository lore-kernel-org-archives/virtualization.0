From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC 1/2] virtio_console: Add support for DMA memory allocation
Date: Wed, 5 Sep 2012 15:00:20 +0200
Message-ID: <CAJK669bUXHqaDUZDNZ9i85pRKENUMS_RXw4z7BsSq7Hiw=OOfg@mail.gmail.com>
References: <1346680277-5887-1-git-send-email-sjur.brandeland@stericsson.com>
	<20120903143018.GA5353@redhat.com>
	<CAJK669bkHHMAPYMEr22-6uOwfgJv1uKTbzNBQVVCq=OooExC0g@mail.gmail.com>
	<20120903202737.GD6181@redhat.com> <87zk56e2xc.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87zk56e2xc.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>, =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

> The driver certainly shouldn't offer VIRTIO_CONSOLE_F_DMA_MEM if you
> don't have DMA!

OK, so the feature table could be done like this:

 static unsigned int features[] = {
	VIRTIO_CONSOLE_F_SIZE,
	VIRTIO_CONSOLE_F_MULTIPORT,
#if VIRTIO_CONSOLE_HAS_DMA
	VIRTIO_CONSOLE_F_DMA_MEM,
#endif
}

If the device then asks for VIRTIO_CONSOLE_F_DMA_MEM
when DMA is not supported, virtio will do BUG_ON() from
virtio_check_driver_offered_feature().

Is this acceptable or should we add a check in virtcons_probe()
and let the probing fail instead?

E.g:
	/* Refuse to bind if F_DMA_MEM request cannot be met */
	if (!VIRTIO_CONSOLE_HAS_DMA &&
	    (vdev->config->get_features(vdev) & (1 << VIRTIO_CONSOLE_F_DMA_MEM))){
		dev_err(&vdev->dev,
			"DMA_MEM requested, but arch does not support DMA\n");
		err = -EINVAL;
		goto fail;
	}

Regards,
Sjur
