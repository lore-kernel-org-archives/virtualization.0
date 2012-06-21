From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/2 v2] scsi bus: introduce hotplug() and
	hot_unplug() interfaces for SCSI bus
Date: Thu, 21 Jun 2012 10:17:34 +0100
Message-ID: <CAJSP0QVigcaPO_6ZjGb9wq52jHua8vFO7iGrmXDeAKfX=ZOhVA@mail.gmail.com>
References: <cover.1340264611.git.mc@linux.vnet.ibm.com>
	<ad3714e594248d5a8d558b6983db3fb2da65ae9a.1340264611.git.mc@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <ad3714e594248d5a8d558b6983db3fb2da65ae9a.1340264611.git.mc@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cong Meng <mc@linux.vnet.ibm.com>
Cc: stefanha@linux.vnet.ibm.com, zwanp@cn.ibm.com, linuxram@us.ibm.com, qemu-devel@nongnu.org, senwang@linux.vnet.ibm.com, Anthony Liguori <anthony@codemonkey.ws>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, =?ISO-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 21, 2012 at 8:54 AM, Cong Meng <mc@linux.vnet.ibm.com> wrote:
> +static int scsi_qdev_unplug(DeviceState *qdev)
> +{
> + =A0 =A0SCSIDevice *dev =3D SCSI_DEVICE(qdev);
> + =A0 =A0SCSIBus *bus =3D scsi_bus_from_device(dev);
> +
> + =A0 =A0if (bus->info->hot_unplug)
> + =A0 =A0 =A0 =A0bus->info->hot_unplug(bus, dev);

Please use scripts/checkpatch.pl to ensure that your patch follows
QEMU coding style.  if statements must use {}.

Stefan
