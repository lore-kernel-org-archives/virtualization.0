From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC v6 18/20] virtio: support revision-specific features
Date: Sun, 28 Dec 2014 10:32:06 +0200
Message-ID: <20141228083206.GA6802@redhat.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-19-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418304322-7546-19-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 11, 2014 at 02:25:20PM +0100, Cornelia Huck wrote:
> Devices may support different sets of feature bits depending on which
> revision they're operating at. Let's give the transport a way to
> re-query the device about its features when the revision has been
> changed.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

So now we have both get_features and get_features_rev, and
it's never clear which revision does host_features refer to.
IMHO that's just too messy.
Let's add get_legacy_features and host_legacy_features instead?


> ---
>  hw/s390x/virtio-ccw.c          |   12 ++++++++++--
>  hw/virtio/virtio-bus.c         |   14 ++++++++++++--
>  include/hw/virtio/virtio-bus.h |    3 +++
>  include/hw/virtio/virtio.h     |    3 +++
>  4 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index a55e851..8b6b2ab 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -699,6 +699,10 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>          }
>          ret = 0;
>          dev->revision = revinfo.revision;
> +        /* Re-evaluate which features the device wants to offer. */
> +        dev->host_features =
> +            virtio_bus_get_vdev_features_rev(&dev->bus, dev->host_features,
> +                                             dev->revision >= 1 ? 1 : 0);
>          break;
>      default:
>          ret = -ENOSYS;
> @@ -712,6 +716,9 @@ static void virtio_sch_disable_cb(SubchDev *sch)
>      VirtioCcwDevice *dev = sch->driver_data;
>  
>      dev->revision = -1;
> +    /* Reset the device's features to legacy. */
> +    dev->host_features =
> +        virtio_bus_get_vdev_features_rev(&dev->bus, dev->host_features, 0);
>  }
>  
>  static int virtio_ccw_device_init(VirtioCcwDevice *dev, VirtIODevice *vdev)
> @@ -853,8 +860,9 @@ static int virtio_ccw_device_init(VirtioCcwDevice *dev, VirtIODevice *vdev)
>      virtio_add_feature(&dev->host_features, VIRTIO_F_NOTIFY_ON_EMPTY);
>      virtio_add_feature(&dev->host_features, VIRTIO_F_BAD_FEATURE);
>  
> -    dev->host_features = virtio_bus_get_vdev_features(&dev->bus,
> -                                                      dev->host_features);
> +    /* All devices start in legacy mode. */
> +    dev->host_features =
> +        virtio_bus_get_vdev_features_rev(&dev->bus, dev->host_features, 0);
>  
>      css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
>                            parent->hotplugged, 1);
> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index 32e3fab..a30826c 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -97,18 +97,28 @@ size_t virtio_bus_get_vdev_config_len(VirtioBusState *bus)
>  }
>  
>  /* Get the features of the plugged device. */
> -uint64_t virtio_bus_get_vdev_features(VirtioBusState *bus,
> -                                      uint64_t requested_features)
> +uint64_t virtio_bus_get_vdev_features_rev(VirtioBusState *bus,
> +                                          uint64_t requested_features,
> +                                          unsigned int revision)
>  {
>      VirtIODevice *vdev = virtio_bus_get_device(bus);
>      VirtioDeviceClass *k;
>  
>      assert(vdev != NULL);
>      k = VIRTIO_DEVICE_GET_CLASS(vdev);
> +    if (revision > 0 && k->get_features_rev) {
> +        return k->get_features_rev(vdev, requested_features, revision);
> +    }
>      assert(k->get_features != NULL);
>      return k->get_features(vdev, requested_features);
>  }
>  
> +uint64_t virtio_bus_get_vdev_features(VirtioBusState *bus,
> +                                      uint64_t requested_features)
> +{
> +    return virtio_bus_get_vdev_features_rev(bus, requested_features, 0);
> +}
> +
>  /* Get bad features of the plugged device. */
>  uint64_t virtio_bus_get_vdev_bad_features(VirtioBusState *bus)
>  {
> diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
> index 0a4dde1..f0916ef 100644
> --- a/include/hw/virtio/virtio-bus.h
> +++ b/include/hw/virtio/virtio-bus.h
> @@ -84,6 +84,9 @@ size_t virtio_bus_get_vdev_config_len(VirtioBusState *bus);
>  /* Get the features of the plugged device. */
>  uint64_t virtio_bus_get_vdev_features(VirtioBusState *bus,
>                                        uint64_t requested_features);
> +uint64_t virtio_bus_get_vdev_features_rev(VirtioBusState *bus,
> +                                          uint64_t requested_features,
> +                                          unsigned int revision);
>  /* Get bad features of the plugged device. */
>  uint64_t virtio_bus_get_vdev_bad_features(VirtioBusState *bus);
>  /* Get config of the plugged device. */
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 068211e..1338540 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -147,6 +147,9 @@ typedef struct VirtioDeviceClass {
>      DeviceRealize realize;
>      DeviceUnrealize unrealize;
>      uint64_t (*get_features)(VirtIODevice *vdev, uint64_t requested_features);
> +    uint64_t (*get_features_rev)(VirtIODevice *vdev,
> +                                 uint64_t requested_features,
> +                                 unsigned int revision);
>      uint64_t (*bad_features)(VirtIODevice *vdev);
>      void (*set_features)(VirtIODevice *vdev, uint64_t val);
>      int (*validate_features)(VirtIODevice *vdev);
> -- 
> 1.7.9.5
