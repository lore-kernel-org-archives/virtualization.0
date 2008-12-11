From: Mark McLoughlin <markmc@redhat.com>
Subject: Re: [PATCH 2/6] virtio: add register_virtio_root_device()
Date: Thu, 11 Dec 2008 16:16:43 +0000
Message-ID: <1229012203.7968.79.camel__40638.1883462474$1229012645$gmane$org@blaa>
References: <1228931096.5384.63.camel@blaa>
	<1228931139-12956-1-git-send-email-markmc@redhat.com>
	<1228931139-12956-2-git-send-email-markmc@redhat.com>
	<20081211135924.4394cc56@gondolin>
Reply-To: Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081211135924.4394cc56@gondolin>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Kay Sievers <kay.sievers@vrfy.org>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2008-12-11 at 13:59 +0100, Cornelia Huck wrote:
> On Wed, 10 Dec 2008 17:45:35 +0000,
> Mark McLoughlin <markmc@redhat.com> wrote:
> 
> > Add a function to allocate a root device object to group the
> > devices from a given virtio implementation.
> > 
> > Also add a 'module' sysfs symlink to allow so that userspace
> > can generically determine which virtio implementation a
> > device is associated with. This will be used by Fedora
> > mkinitrd to generically determine e.g. that virtio_pci is
> > needed to mount a given root filesystem.
> 
> Nothing about this is really virtio-specific (just as
> s390_root_dev_register() is not really s390-specific), and a 'module'
> symlink doesn't really hurt in a generic implementation, even if it is
> unneeded. I'm voting to put this in some generic, always built-in code
> (or have the users select it) so we could also use it from s390.

Okay, coming up ...

> > Signed-off-by: Mark McLoughlin <markmc@redhat.com>
> > ---
> >  drivers/virtio/virtio.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/virtio.h  |   10 ++++++
> >  2 files changed, 81 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 018c070..61e6597 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -1,6 +1,7 @@
> >  #include <linux/virtio.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/virtio_config.h>
> > +#include <linux/err.h>
> > 
> >  /* Unique numbering for virtio devices. */
> >  static unsigned int dev_index;
> > @@ -200,6 +201,76 @@ void unregister_virtio_device(struct virtio_device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(unregister_virtio_device);
> > 
> > +/* A root device for virtio devices from a given backend.  This makes them
> > + * appear as /sys/devices/{name}/0,1,2 not /sys/devices/0,1,2. It also allows
> > + * us to have a /sys/devices/{name}/module symlink to the backend module. */
> > +struct virtio_root_device
> > +{
> > +	struct device dev;
> > +	struct module *owner;
> > +};
> > +
> > +static struct virtio_root_device *to_virtio_root(struct device *dev)
> > +{
> > +        return container_of(dev, struct virtio_root_device, dev);
> > +}
> > +
> > +static void release_virtio_root_device(struct device *dev)
> > +{
> > +	struct virtio_root_device *root = to_virtio_root(dev);
> > +	if (root->owner)
> > +		sysfs_remove_link(&root->dev.kobj, "module");
> > +	kfree(root);
> > +}
> 
> Can this code be a module? If yes, move the release callback to a
> build-in as there are races with release-functions in modules.

Not sure I fully understand the issue here, but it won't be an problem
with it if we move to driver core.

> > +struct device *__register_virtio_root_device(const char *name,
> > +					     struct module *owner)
> > +{
> > +	struct virtio_root_device *root;
> > +	int err = -ENOMEM;
> > +
> > +	root = kzalloc(sizeof(struct virtio_root_device), GFP_KERNEL);
> > +	if (!root)
> > +		goto out;
> > +
> > +	err = dev_set_name(&root->dev, name);
> > +	if (err)
> > +		goto free_root;
> > +
> > +	err = device_register(&root->dev);
> > +	if (err)
> > +		goto free_root;
> > +
> > +	root->dev.parent  = NULL;
> > +	root->dev.release = release_virtio_root_device;
> 
> You must set ->release before calling device_register(), and setting
> the parent is unneeded.

Okay.

> > +	if (owner) {
> > +		struct module_kobject *mk = &owner->mkobj;
> > +
> > +		err = sysfs_create_link(&root->dev.kobj, &mk->kobj, "module");
> > +                if (err) {
> > +			device_unregister(&root->dev);
> > +			return ERR_PTR(err);
> > +		}
> > +
> > +		root->owner = owner;
> > +	}
> > +
> > +	return &root->dev;
> > +
> > +free_root:
> > +	kfree(root);
> 
> You need to call device_put() if you called device_register().

Oh, I missed that subtlety. So the rules are:

  1) To release before calling device_register(), use kfree()

  2) To release if device_register() failed, put_device()

  3) To release once device_register() succeeds, device_unregister()

Cheers,
Mark.
