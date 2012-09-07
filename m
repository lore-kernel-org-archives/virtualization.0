From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC 1/2] virtio_console: Add support for DMA memory allocation
Date: Fri, 7 Sep 2012 11:24:24 +0200
Message-ID: <CAJK669bqRF6WiQ8=21pEyUB565i80CeN0eniWcPBxXNLCOcxXA@mail.gmail.com>
References: <1346680277-5887-1-git-send-email-sjur.brandeland@stericsson.com>
	<20120903143018.GA5353@redhat.com>
	<CAJK669bkHHMAPYMEr22-6uOwfgJv1uKTbzNBQVVCq=OooExC0g@mail.gmail.com>
	<20120903202737.GD6181@redhat.com> <87zk56e2xc.fsf@rustcorp.com.au>
	<CAJK669bUXHqaDUZDNZ9i85pRKENUMS_RXw4z7BsSq7Hiw=OOfg@mail.gmail.com>
	<20120905143558.GB10925@redhat.com>
	<CAJK669bhVfgnxuF6wVtdnzs2bgiJ2HzgwfWw4uZ=EqTdm43Jow@mail.gmail.com>
	<20120905191657.GA15868@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120905191657.GA15868@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael.

>> Not just fail to work, the kernel will panic on the BUG_ON().
>> Remoteproc gets the virtio configuration from firmware loaded
>> from user space. So this type of problem might be triggered
>> for other virtio drivers as well.
>
> how?
...
>> Even if we fix this particular problem, the general problem
>> still exists: bogus virtio declarations in remoteproc's firmware
>> may cause BUG_ON().
>
> which BUG_ON exactly?

I am afraid I have been barking up the wrong tree here.
Please ignore my previous rambling about panics related
to device features.

I hit the  BUG() in virtio_check_driver_offered_feature():
First I did not declare the feature because DMA was not set:
static unsigned int features[] = {
...
#if VIRTIO_CONSOLE_HAS_DMA
	VIRTIO_CONSOLE_F_DMA_MEM,
#endif
};

and then in probe I checked if the feature was supported:
	    virtio_has_feature(vdev, VIRTIO_CONSOLE_F_DMA_MEM)

This triggered the BUG() in virtio_check_driver_offered_feature(),
because the driver was asking for a unknown-feature.

I can get avoid this by simply checking the devices feature bits directly
instead of using virtio_has_feature().

Regards,
Sjur
