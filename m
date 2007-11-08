From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 3/3] virtio PCI device
Date: Thu, 8 Nov 2007 18:46:35 +0100
Message-ID: <200711081846.36821.arnd@arndb.de>
References: <11944899922822-git-send-email-aliguori@us.ibm.com>
	<11944900152750-git-send-email-aliguori@us.ibm.com>
	<11944900163817-git-send-email-aliguori@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11944900163817-git-send-email-aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 08 November 2007, Anthony Liguori wrote:
> +/* A PCI device has it's own struct device and so does a virtio device so
> + * we create a place for the virtio devices to show up in sysfs. =A0I th=
ink it
> + * would make more sense for virtio to not insist on having it's own dev=
ice. */
> +static struct device virtio_pci_root =3D {
> +=A0=A0=A0=A0=A0=A0=A0.parent=A0=A0=A0=A0=A0=A0=A0=A0=A0=3D NULL,
> +=A0=A0=A0=A0=A0=A0=A0.bus_id=A0=A0=A0=A0=A0=A0=A0=A0=A0=3D "virtio-pci",
> +};
> +
> +/* Unique numbering for devices under the kvm root */
> +static unsigned int dev_index;
> +

...

> +/* the PCI probing function */
> +static int __devinit virtio_pci_probe(struct pci_dev *pci_dev,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0const struct pci_device_id *id)
> +{
> +=A0=A0=A0=A0=A0=A0=A0struct virtio_pci_device *vp_dev;
> +=A0=A0=A0=A0=A0=A0=A0int err;
> +
> +=A0=A0=A0=A0=A0=A0=A0/* allocate our structure and fill it out */
> +=A0=A0=A0=A0=A0=A0=A0vp_dev =3D kzalloc(sizeof(struct virtio_pci_device)=
, GFP_KERNEL);
> +=A0=A0=A0=A0=A0=A0=A0if (vp_dev =3D=3D NULL)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENOMEM;
> +
> +=A0=A0=A0=A0=A0=A0=A0vp_dev->pci_dev =3D pci_dev;
> +=A0=A0=A0=A0=A0=A0=A0vp_dev->vdev.dev.parent =3D &virtio_pci_root;

If you use =


	vp_dev->vdev.dev.parent =3D &pci_dev->dev;

Then there is no need for the special kvm root device, and the actual
virtio device shows up in a more logical place, under where it is
really (virtually) attached.

	Arnd <><

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
