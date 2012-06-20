From: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 1/2] scsi bus: introduce hotplug() and hot_unplug()
	interfaces for SCSI bus
Date: Wed, 20 Jun 2012 15:10:06 +0200
Message-ID: <4FE1CBAE.5010503__15025.217497214$1340300264$gmane$org@suse.de>
References: <cover.1340022196.git.mc@linux.vnet.ibm.com>
	<287bf70a546a1ce51a6f3405ba620daaf284bdfe.1340022196.git.mc@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <287bf70a546a1ce51a6f3405ba620daaf284bdfe.1340022196.git.mc@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cong Meng <mc@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>
Cc: stefanha@linux.vnet.ibm.com, qemu-devel@nongnu.org, zwanp@cn.ibm.com, linuxram@us.ibm.com, senwang@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am 20.06.2012 08:47, schrieb Cong Meng:
> Add two interfaces hotplug() and hot_unplug() to scsi bus info.
> The embody scsi bus can implement these two interfaces to signal the HBA =
driver
> of guest kernel to add/remove the scsi device in question.
> =

> Signed-off-by: Cong Meng <mc@linux.vnet.ibm.com>
> Signed-off-by: Sen Wang <senwang@linux.vnet.ibm.com>
> ---
>  hw/scsi-bus.c |   16 +++++++++++++++-
>  hw/scsi.h     |    2 ++
>  2 files changed, 17 insertions(+), 1 deletions(-)
> =

> diff --git a/hw/scsi-bus.c b/hw/scsi-bus.c
> index dbdb99c..cc3ec75 100644
> --- a/hw/scsi-bus.c
> +++ b/hw/scsi-bus.c
> @@ -177,6 +177,10 @@ static int scsi_qdev_init(DeviceState *qdev)
>                                                           dev);
>      }
>  =

> +    if (bus->info->hotplug) {
> +	bus->info->hotplug(bus, dev);

Tab.

> +    }
> +
>  err:
>      return rc;
>  }
> @@ -1539,6 +1543,16 @@ static int get_scsi_requests(QEMUFile *f, void *pv=
, size_t size)
>      return 0;
>  }
>  =

> +static int scsi_qdev_unplug(DeviceState *qdev)
> +{
> +    SCSIDevice *dev =3D SCSI_DEVICE(qdev);
> +    SCSIBus *bus =3D DO_UPCAST(SCSIBus, qbus, dev->qdev.parent_bus);

Since the tabs need to be fixed anyway, I would suggest to avoid using
DO_UPCAST() with QOM types:

SCSIBus *bus =3D SCSI_BUS(qdev->parent_bus);

Also I'd like to raise the question towards Paolo and Anthony whether we
might want to start naming new functions like this one
scsi_device_unplug() to avoid the "qdev"? In this case sticking to
"qdev" provides symmetry so there's good reasons for both approaches.

> +
> +    if (bus->info->hot_unplug)
> +	bus->info->hot_unplug(bus, dev);

Tab. It seems your editor converts all 8-space indents, please check the
second patch.

Otherwise looks okay from my side.

Andreas

> +    return qdev_simple_unplug_cb(qdev);
> +}
> +
>  const VMStateInfo vmstate_info_scsi_requests =3D {
>      .name =3D "scsi-requests",
>      .get  =3D get_scsi_requests,
> @@ -1575,7 +1589,7 @@ static void scsi_device_class_init(ObjectClass *kla=
ss, void *data)
>      DeviceClass *k =3D DEVICE_CLASS(klass);
>      k->bus_info =3D &scsi_bus_info;
>      k->init     =3D scsi_qdev_init;
> -    k->unplug   =3D qdev_simple_unplug_cb;
> +    k->unplug   =3D scsi_qdev_unplug;
>      k->exit     =3D scsi_qdev_exit;
>  }
>  =

> diff --git a/hw/scsi.h b/hw/scsi.h
> index 2eb66f7..5768071 100644
> --- a/hw/scsi.h
> +++ b/hw/scsi.h
> @@ -130,6 +130,8 @@ struct SCSIBusInfo {
>      void (*transfer_data)(SCSIRequest *req, uint32_t arg);
>      void (*complete)(SCSIRequest *req, uint32_t arg, size_t resid);
>      void (*cancel)(SCSIRequest *req);
> +    void (*hotplug)(SCSIBus *bus, SCSIDevice *dev);
> +    void (*hot_unplug)(SCSIBus *bus, SCSIDevice *dev);
>      QEMUSGList *(*get_sg_list)(SCSIRequest *req);
>  =

>      void (*save_request)(QEMUFile *f, SCSIRequest *req);

-- =

SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer; HRB 16746 AG N=FCrnberg
