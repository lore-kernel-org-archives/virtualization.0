From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCH] virtio: Don't access device data after unregistration.
Date: Tue, 4 Sep 2012 14:12:33 +0200
Message-ID: <CAJK669ZVHOZVEw+1UeLU5KyxZexGfWC0VPnrK5XZd9x935PznQ__16742.2073231593$1346760769$gmane$org@mail.gmail.com>
References: <1346680242-5717-1-git-send-email-sjur.brandeland@stericsson.com>
	<20120903141445.GA5054@redhat.com>
	<CAJK669aRsbOOmjmT+K8OHYvenOhkYWuSOx6nBM7hxC_C4mmw-g@mail.gmail.com>
	<20120903201847.GC6181@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120903201847.GC6181@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, "Guzman Lugo,
	Fernadndo" <fernando.lugo@ti.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael,

>> >> Fix panic in virtio.c when CONFIG_DEBUG_SLAB is set.
>> >
>> > What's the root cause of the panic?
>>
>> I believe the cause of the panic is calling
>> ida_simple_remove(&virtio_index_ida, dev->index);
>> when the dev structure is "poisoned" after kfree.
>> It might be the "BUG_ON((int)id < 0)" that bites...
>>
>> >> Use device_del() and put_device() instead of
>> >> device_unregister(), and access device data before
>> >> calling put_device().
>>
>> > Why does this help? Does device_unregister free the
>> > device so dev->index access crashes?
>>
>> Yes, if device ref-count is one when calling unregister
>> the device is freed.
>
> Interesting. Where exactly?...

I was wrong here, the reason is not related to ref-count being
above one. The reason this issue do not show up in virtio_pci
is that the release function is a dummy:

[snip]
static void virtio_pci_release_dev(struct device *_d)
{
	/*
	 * No need for a release method as we allocate/free
	 * all devices together with the pci devices.
	 * Provide an empty one to avoid getting a warning from core.
	 */
}

The device structure uses a kref for reference counting the device.
In virtio_pci() the release function virtio_pci_release_dev()
will be called when the device is unregistered, but because the
release function is dummy, data isn't freed or reset at this point.
So for virtio devices created from virtio_pci my patch is not
currently needed.

However, empty release functions are not the preferred way, e.g look at
https://lkml.org/lkml/2012/4/3/301

[Greg K.H:]
> > > > +static void hsi_port_release(struct device *dev __maybe_unused)
> > > > +{
> > > > +}
> > >
> > > As per the documentation in the kernel tree, I get to mock you
> > > mercilessly for doing something as foolish as this.  You are not smarter
> > > than the kernel and don't think that you got rid of the kernel warning
> > > properly by doing this.  Do you think that I wrote that code for no good
> > > reason?  The kernel was being nice and telling you what you did wrong,
> > > don't try to fake it out, it's smarter than you are here.

But remoteproc frees the device memory in the release function
rproc_vdev_release() and needs this patch.

Regards,
Sjur
