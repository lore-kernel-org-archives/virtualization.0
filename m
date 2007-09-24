From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH 1/3] virtio interface
Date: Tue, 25 Sep 2007 09:37:38 +1000
Message-ID: <1190677058.27805.225.camel__28538.7062853717$1190677206$gmane$org@localhost.localdomain>
References: <1190625194.27805.199.camel@localhost.localdomain>
	<1190625256.27805.201.camel@localhost.localdomain>
	<200709250018.12705.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200709250018.12705.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: kvm-devel@lists.sourceforge.net, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-09-25 at 00:18 +0200, Arnd Bergmann wrote:
> On Monday 24 September 2007, Rusty Russell wrote:
> > This attempts to implement a "virtual I/O" layer which should allow
> > common drivers to be efficiently used across most virtual I/O
> > mechanisms.  It will no-doubt need further enhancement.
> 
> Hi Rusty,
> 
> Thanks for your update, as you can imagine, I'm much happier with
> this version ;-)

Hi Arnd,

	Yes, I thought you might be...

> > +
> > +struct virtio_bus {
> > +	struct bus_type bus;
> > +	struct device dev;
> > +};
> > +
> > +static struct virtio_bus virtio_bus = {
> > +	.bus = {
> > +		.name  = "virtio",
> > +		.match = virtio_dev_match,
> > +		.dev_attrs = virtio_dev_attrs,
> > +	},
> > +	.dev = {
> > +		/* Can override this if you have a real bus behind it. */
> > +		.parent = NULL,
> > +		.bus_id = "virtio",
> > +	}
> > +};
> 
> This is a pattern I've seen a few times before, but could never understand
> what it's good for. What is your reason for defining a new data structure
> that is used only once, instead of just
> 
> static struct bus_type virtio_bus_type;
> static struct device virtio_root_dev;

It's copied from the lguest bus which was copied from somewhere else.
Creating a struct like this is a quiet complaint about the requirements
to do so: it's not clear to me why I need to create a fake device,
rather than making the bus the parent of the device if it needs one.

> Also, I would not mix the two in a single source file. Instead, I think
> every driver that can provide virtio devices (pci, lguest, ...) should
> be responsible for setting the parent appropriately.

I don't mind: we could expose it.

> > +struct virtio_config_ops
> > +{
> > +	void *(*find)(struct virtio_device *vdev, u8 type, unsigned *len);
> > +	void (*get)(struct virtio_device *vdev, void *token,
> > +		    void *buf, unsigned len);
> > +	void (*set)(struct virtio_device *vdev, void *token,
> > +		    const void *buf, unsigned len);
> > +	u8 (*get_status)(struct virtio_device *vdev);
> > +	void (*set_status)(struct virtio_device *vdev, u8 status);
> > +	struct virtqueue *(*find_vq)(struct virtio_device *vdev,
> > +				     bool (*callback)(struct virtqueue *));
> > +	void (*del_vq)(struct virtqueue *vq);
> > +};
> 
> The configuration logic looks more complicated than it should be.
> Maybe more of this can be done using data structure definitions instead
> of dynamic callback. E.g. the virtqueues of a given device can be
> listed as members of the struct virtio_device.

I agree about the complexity, but the reason I didn't do that is the way
the config system works.  Drivers look for fields they want, and those
fields are marked so the host can see what was used.  This makes it
fairly easy to add new fields and then tell if the guest understood them
or not.

This includes new virtqueues, so the core must not simply grab them all.
My previous solution was to put a "new_vq" and "del_vq" inside
virtqueue_ops: the driver found the config field and handed it through.
That was a little messier for the driver.

> > +/**
> > + * virtio_config_val - get a single virtio config and mark it used.
> > + * @config: the virtio config space
> > + * @type: the type to search for.
> > + * @val: a pointer to the value to fill in.
> > + *
> > + * Once used, the config type is marked with VIRTIO_CONFIG_F_USED so it can't
> > + * be found again.  This version does endian conversion. */
> > +#define virtio_config_val(vdev, type, v) ({				\
> > +	int _err = __virtio_config_val((vdev),(type),(v),sizeof(*(v))); \
> > +									\
> > +	BUILD_BUG_ON(sizeof(*(v)) != 1 && sizeof(*(v)) != 2		\
> > +		     && sizeof(*(v)) != 4 && sizeof(*(v)) != 8);	\
> > +	if (!_err) {							\
> > +		switch (sizeof(*(v))) {					\
> > +		case 2: le16_to_cpus(v); break;				\
> > +		case 4: le32_to_cpus(v); break;				\
> > +		case 8: le64_to_cpus(v); break;				\
> > +		}							\
> > +	}								\
> > +	_err;								\
> > +})
> 
> Especially the macro looks like something better avoided...

C'mon, everyone loves optimization!

(Which reminds me, I said little endian here but didn't actually do that
in the lguest launcher, bad Rusty).

Thanks,
Rusty.
