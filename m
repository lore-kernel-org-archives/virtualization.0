From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [kvm-devel] [PATCH 1/3] virtio interface
Date: Tue, 25 Sep 2007 00:18:12 +0200
Message-ID: <200709250018.12705.arnd__32916.3586641245$1190672960$gmane$org@arndb.de>
References: <1190625194.27805.199.camel@localhost.localdomain>
	<1190625256.27805.201.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190625256.27805.201.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel@lists.sourceforge.net
Cc: virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 24 September 2007, Rusty Russell wrote:
> This attempts to implement a "virtual I/O" layer which should allow
> common drivers to be efficiently used across most virtual I/O
> mechanisms.  It will no-doubt need further enhancement.

Hi Rusty,

Thanks for your update, as you can imagine, I'm much happier with
this version ;-)

> +
> +struct virtio_bus {
> +	struct bus_type bus;
> +	struct device dev;
> +};
> +
> +static struct virtio_bus virtio_bus = {
> +	.bus = {
> +		.name  = "virtio",
> +		.match = virtio_dev_match,
> +		.dev_attrs = virtio_dev_attrs,
> +	},
> +	.dev = {
> +		/* Can override this if you have a real bus behind it. */
> +		.parent = NULL,
> +		.bus_id = "virtio",
> +	}
> +};

This is a pattern I've seen a few times before, but could never understand
what it's good for. What is your reason for defining a new data structure
that is used only once, instead of just

static struct bus_type virtio_bus_type;
static struct device virtio_root_dev;

Also, I would not mix the two in a single source file. Instead, I think
every driver that can provide virtio devices (pci, lguest, ...) should
be responsible for setting the parent appropriately.

> +#ifndef _LINUX_VIRTIO_CONFIG_H
> +#define _LINUX_VIRTIO_CONFIG_H
> +/* Virtio devices use a standardized configuration space to define their
> + * features and pass configuration information, but each implementation can
> + * store and access that space differently. */
> +#include <linux/types.h>
> +
> +/* Status byte for guest to report progress, and synchronize config. */
> +/* We have seen device and processed generic fields (VIRTIO_CONFIG_F_VIRTIO) */
> +#define VIRTIO_CONFIG_S_ACKNOWLEDGE	1
> +/* We have found a driver for the device. */
> +#define VIRTIO_CONFIG_S_DRIVER		2
> +/* Driver has used its parts of the config, and is happy */
> +#define VIRTIO_CONFIG_S_DRIVER_OK	4
> +/* We've given up on this device. */
> +#define VIRTIO_CONFIG_S_FAILED		0x80
> +
> +/* Feature byte (actually 7 bits availabe): */
> +/* Requirements/features of the virtio implementation. */
> +#define VIRTIO_CONFIG_F_VIRTIO 1
> +/* Requirements/features of the virtqueue (may have more than one). */
> +#define VIRTIO_CONFIG_F_VIRTQUEUE 2
> +
> +#ifdef __KERNEL__
> +struct virtio_device;
> +
> +/**
> + * virtio_config_ops - operations for configuring a virtio device
> + * @find: search for the next configuration field of the given type.
> + *	vdev: the virtio_device
> + *	type: the feature type
> + *	len: the (returned) length of the field if found.
> + *	Returns a token if found, or NULL.  Never returnes the same field twice
> + *	(ie. it's used up).
> + * @get: read the value of a configuration field after find().
> + *	vdev: the virtio_device
> + *	token: the token returned from find().
> + *	buf: the buffer to write the field value into.
> + *	len: the length of the buffer (given by find()).
> + *	Note that contents are conventionally little-endian.
> + * @set: write the value of a configuration field after find().
> + *	vdev: the virtio_device
> + *	token: the token returned from find().
> + *	buf: the buffer to read the field value from.
> + *	len: the length of the buffer (given by find()).
> + *	Note that contents are conventionally little-endian.
> + * @get_status: read the status byte
> + *	vdev: the virtio_device
> + *	Returns the status byte
> + * @set_status: write the status byte
> + *	vdev: the virtio_device
> + *	status: the new status byte
> + * @find_vq: find the first VIRTIO_CONFIG_F_VIRTQUEUE and create a virtqueue.
> + *	vdev: the virtio_device
> + *	callback: the virqtueue callback
> + *	Returns the new virtqueue or ERR_PTR().
> + * @del_vq: free a virtqueue found by find_vq().
> + */
> +struct virtio_config_ops
> +{
> +	void *(*find)(struct virtio_device *vdev, u8 type, unsigned *len);
> +	void (*get)(struct virtio_device *vdev, void *token,
> +		    void *buf, unsigned len);
> +	void (*set)(struct virtio_device *vdev, void *token,
> +		    const void *buf, unsigned len);
> +	u8 (*get_status)(struct virtio_device *vdev);
> +	void (*set_status)(struct virtio_device *vdev, u8 status);
> +	struct virtqueue *(*find_vq)(struct virtio_device *vdev,
> +				     bool (*callback)(struct virtqueue *));
> +	void (*del_vq)(struct virtqueue *vq);
> +};

The configuration logic looks more complicated than it should be.
Maybe more of this can be done using data structure definitions instead
of dynamic callback. E.g. the virtqueues of a given device can be
listed as members of the struct virtio_device.

> +/**
> + * virtio_config_val - get a single virtio config and mark it used.
> + * @config: the virtio config space
> + * @type: the type to search for.
> + * @val: a pointer to the value to fill in.
> + *
> + * Once used, the config type is marked with VIRTIO_CONFIG_F_USED so it can't
> + * be found again.  This version does endian conversion. */
> +#define virtio_config_val(vdev, type, v) ({				\
> +	int _err = __virtio_config_val((vdev),(type),(v),sizeof(*(v))); \
> +									\
> +	BUILD_BUG_ON(sizeof(*(v)) != 1 && sizeof(*(v)) != 2		\
> +		     && sizeof(*(v)) != 4 && sizeof(*(v)) != 8);	\
> +	if (!_err) {							\
> +		switch (sizeof(*(v))) {					\
> +		case 2: le16_to_cpus(v); break;				\
> +		case 4: le32_to_cpus(v); break;				\
> +		case 8: le64_to_cpus(v); break;				\
> +		}							\
> +	}								\
> +	_err;								\
> +})

Especially the macro looks like something better avoided...

	Arnd <><
