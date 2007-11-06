From: Anthony Liguori <aliguori@us.ibm.com>
Subject: virtio config_ops refactoring
Date: Tue, 06 Nov 2007 11:48:35 -0600
Message-ID: <4730A8F3.6020008__24332.9160650775$1194371468$gmane$org@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Dor Laor <dor.laor@qumranet.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

The current virtio config_ops do not map very well to the PCI config 
space.  Here they are:

> struct virtio_config_ops
> {
>     void *(*find)(struct virtio_device *vdev, u8 type, unsigned *len);
>     void (*get)(struct virtio_device *vdev, void *token,
>             void *buf, unsigned len);
>     void (*set)(struct virtio_device *vdev, void *token,
>             const void *buf, unsigned len);
>     u8 (*get_status)(struct virtio_device *vdev);
>     void (*set_status)(struct virtio_device *vdev, u8 status);
>     struct virtqueue *(*find_vq)(struct virtio_device *vdev,
>                      bool (*callback)(struct virtqueue *));
>     void (*del_vq)(struct virtqueue *vq);
> };

Semantically, find requires that a field have both a type and a length.  
With the exception of the VIRTQUEUE field used internally by lguest, 
type is always a unique identifier.  Since virtqueue information is not 
a required part of the config space, it seems to me that type really 
should be treated as a unique identifier.

find_vq also is curious in that it is stateful in it's enumeration.  
This adds seemingly unnecessary complexity.  The result is that in my 
PCI virtio implementation, I have to use an opaque blob that's self 
describing and variable length in the PCI config space.  This is not 
very natural at all for a PCI device!

Here is how I propose changing the config_ops:

struct virtio_config_ops
{
    bool (*get)(struct virtio_device *vdev, unsigned id, void *buf, 
unsigned len);
    bool (*set)(struct virtio_device *vdev, unsigned id, const void 
*buf, unsigned len);
    u8 (*get_status)(struct virtio_device *vdev);
    void (*set_status)(struct virtio_device *vdev, u8 status);
    struct virtqueue *(*get_vq)(struct virtio_device *vdev, unsigned 
index, bool (*callback)(struct virtqueue *));
    void (*del_vq)(struct virtqueue *vq);
};

config_ops->get() returns false if the id is invalid as does ->set().  
get_vq() returns NULL if the index is not a valid virtqueue (and we'll 
mandate that all virtqueues are in order starting at 0).

The id space is defined by the driver itself but is guaranteed to be 
non-overlapping and starting from 0.  For instance, the block device 
would have:

/* The capacity (in 512-byte sectors). */
#define VIRTIO_CONFIG_BLK_F_CAPACITY    0x00
/* The maximum segment size. */
#define VIRTIO_CONFIG_BLK_F_SIZE_MAX    0x08
/* The maximum number of segments. */
#define VIRTIO_CONFIG_BLK_F_SEG_MAX    0x12

This maps very well to the PCI config space.  For lguest, the actual 
config items would simply be packed in a single page.  Since lguest uses 
the config space for virtqueues, lguest_device_desc will have to be 
changed to also contain an array of virtqueue infos.  It doesn't prevent 
an implementation from using the id's as opaque keys though (as one 
might do for Xen since presumably the configuration data would be 
represented within xenbus).

If there's agreement that this approach is better, I'll start submitting 
patches.

Regards,

Anthony Liguori
