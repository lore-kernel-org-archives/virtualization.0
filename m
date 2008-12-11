From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 1/4] driver core: add root_device_register()
Date: Thu, 11 Dec 2008 17:56:04 +0100
Message-ID: <20081211175604.511fc6ae__27880.861136555$1229014845$gmane$org@gondolin>
References: <1229012203.7968.79.camel@blaa>
	<1229012216-4211-1-git-send-email-markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1229012216-4211-1-git-send-email-markmc@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Mark McLoughlin <markmc@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 11 Dec 2008 16:16:53 +0000,
Mark McLoughlin <markmc@redhat.com> wrote:

> Add support for allocating root device objects which group
> device objects under /sys/devices directories.
> 
> Also add a sysfs 'module' symlink which points to the owner
> of the root device object. This will be used in virtio to
> allow userspace to determine which virtio bus implementation
> a given device is associated with.

I was just hacking up a similar patch :)

> 
> Signed-off-by: Mark McLoughlin <markmc@redhat.com>
> ---
>  drivers/base/core.c    |   88 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/device.h |   11 ++++++
>  2 files changed, 99 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 8c2cc26..db160a2 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1196,6 +1196,94 @@ EXPORT_SYMBOL_GPL(put_device);
>  EXPORT_SYMBOL_GPL(device_create_file);
>  EXPORT_SYMBOL_GPL(device_remove_file);
> 
> +struct root_device
> +{
> +	struct device dev;
> +	struct module *owner;
> +};
> +
> +static void root_device_release(struct device *dev)
> +{
> +	struct root_device *root = container_of(dev, struct root_device, dev);
> +
> +	if (root->owner)
> +		sysfs_remove_link(&root->dev.kobj, "module");

I'd rather remove the link before you unregister.

> +
> +	kfree(root);
> +}
> +
> +/**
> + * __root_device_register - allocate and register a root device
> + * @name: root device name
> + * @owner: owner module of the root device, usually THIS_MODULE
> + *
> + * This function allocates a root device and registers it
> + * using device_register(). In order to free the returned
> + * device, use root_device_unregister().
> + *
> + * Root devices are dummy devices which allow other devices
> + * to be grouped under /sys/devices. Use this function to
> + * allocate a root device and then use it as the parent of
> + * any device which should appear under /sys/devices/{name}
> + *
> + * The /sys/devices/{name} directory will also contain a
> + * 'module' symlink which points to the @owner directory
> + * in sysfs.

* Note: You probably want to use root_device_register().

> + */
> +struct device *__root_device_register(const char *name, struct module *owner)
> +{
> +	struct root_device *root;
> +	int err = -ENOMEM;
> +
> +	root = kzalloc(sizeof(struct root_device), GFP_KERNEL);
> +	if (!root)
> +		return ERR_PTR(err);
> +
> +	err = dev_set_name(&root->dev, name);
> +	if (err) {
> +		kfree(root);
> +		return ERR_PTR(err);
> +	}
> +
> +	root->dev.release = root_device_release;
> +
> +	err = device_register(&root->dev);
> +	if (err) {
> +		put_device(&root->dev);
> +		return ERR_PTR(err);
> +	}
> +
> +	if (owner) {
> +		struct module_kobject *mk = &owner->mkobj;
> +
> +		err = sysfs_create_link(&root->dev.kobj, &mk->kobj, "module");
> +		if (err) {;

Stray ';'

> +			device_unregister(&root->dev);
> +			return ERR_PTR(err);
> +		}
> +		root->owner = owner;
> +	}
> +
> +	return &root->dev;
> +}
> +EXPORT_SYMBOL_GPL(__root_device_register);
> +
> +/**
> + * root_device_unregister - unregister and free a root device
> + * @root: device going away.
> + *
> + * We simply release @root using device_unregister(). If @root
> + * has a reference count of one, the device will be freed
> + * after it has been unregistered. Otherwise, the structure
> + * will stick around until the final reference is dropped
> + * using put_device().

I don't think you'll need to explain device handling here. How about
this:

root_device_unregister - unregister a root device
@root: device going away

This function unregisters and cleans up a device that was created by
root_device_register().

> + */
> +void root_device_unregister(struct device *root)
> +{

Clean up the symlink here.

> +	device_unregister(root);
> +}
> +EXPORT_SYMBOL_GPL(root_device_unregister);
> +
> 
>  static void device_create_release(struct device *dev)
>  {
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 1a3686d..9e02980 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -483,6 +483,17 @@ extern int device_rename(struct device *dev, char *new_name);
>  extern int device_move(struct device *dev, struct device *new_parent);
> 
>  /*
> + * Root device objects for grouping under /sys/devices
> + */
> +extern struct device *__root_device_register(const char *name,
> +					     struct module *owner);
> +static inline struct device *root_device_register(const char *name)
> +{
> +	return __root_device_register(name, THIS_MODULE);
> +}
> +extern void root_device_unregister(struct device *root);
> +
> +/*
>   * Manual binding of a device to driver. See drivers/base/bus.c
>   * for information on use.
>   */
> -- 
> 1.5.4.3
> 
