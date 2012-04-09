From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH 2/2] virtio-mmio: Devices parameter parsing
Date: Mon, 9 Apr 2012 18:32:01 +0200
Message-ID: <CA+1xoqfov64Wz9e_G8ZTcXnAatw_VqYxecU5FX3Zrmw_XTL-Cw@mail.gmail.com>
References: <1323712401.2391.93.camel@hornet.cambridge.arm.com>
	<1323712627-17353-1-git-send-email-pawel.moll@arm.com>
	<1323712627-17353-2-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1323712627-17353-2-git-send-email-pawel.moll@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ping? Was this patch forgotten?

On Mon, Dec 12, 2011 at 6:57 PM, Pawel Moll <pawel.moll@arm.com> wrote:
> This patch adds an option to instantiate guest virtio-mmio devices
> basing on a kernel command line (or module) parameter, for example:
>
> =A0 =A0 =A0 =A0virtio_mmio.devices=3D0x100@0x100b0000:48
>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
> =A0Documentation/kernel-parameters.txt | =A0 17 ++++
> =A0drivers/virtio/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +++
> =A0drivers/virtio/virtio_mmio.c =A0 =A0 =A0 =A0| =A0163 +++++++++++++++++=
++++++++++++++++++
> =A03 files changed, 191 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-p=
arameters.txt
> index a0c5c5f..c155d13 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -110,6 +110,7 @@ parameter is applicable:
> =A0 =A0 =A0 =A0USB =A0 =A0 USB support is enabled.
> =A0 =A0 =A0 =A0USBHID =A0USB Human Interface Device support is enabled.
> =A0 =A0 =A0 =A0V4L =A0 =A0 Video For Linux support is enabled.
> + =A0 =A0 =A0 VMMIO =A0 Driver for memory mapped virtio devices is enable=
d.
> =A0 =A0 =A0 =A0VGA =A0 =A0 The VGA console has been enabled.
> =A0 =A0 =A0 =A0VT =A0 =A0 =A0Virtual terminal support is enabled.
> =A0 =A0 =A0 =A0WDT =A0 =A0 Watchdog support is enabled.
> @@ -2720,6 +2721,22 @@ bytes respectively. Such letter suffixes can also =
be entirely omitted.
> =A0 =A0 =A0 =A0video=3D =A0 =A0 =A0 =A0 =A0[FB] Frame buffer configuration
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0See Documentation/fb/moded=
b.txt.
>
> + =A0 =A0 =A0 virtio_mmio.device=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [VMMIO] Memory mapped virti=
o (platform) device.
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <size>@<bas=
eaddr>:<irq>[:<id>]
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 where:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <size> =A0 =
=A0 :=3D size (can use standard suffixes
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 like K, M and G)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <baseaddr> =
:=3D physical base address
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <irq> =A0 =
=A0 =A0:=3D interrupt number (as passed to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 request_irq())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <id> =A0 =
=A0 =A0 :=3D (optional) platform device id
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 example:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 virtio_mmio=
.device=3D1K@0x100b0000:48:7
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Can be used multiple times =
for multiple devices.
> +
> =A0 =A0 =A0 =A0vga=3D =A0 =A0 =A0 =A0 =A0 =A0[BOOT,X86-32] Select a parti=
cular video mode
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0See Documentation/x86/boot=
.txt and
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Documentation/svga.txt.
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 1a61939..f38b17a 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -46,4 +46,15 @@ config VIRTIO_BALLOON
>
> =A0 =A0 =A0 =A0 If unsure, say N.
>
> +config VIRTIO_MMIO_CMDLINE_DEVICES
> + =A0 =A0 =A0 bool "Memory mapped virtio devices parameter parsing"
> + =A0 =A0 =A0 depends on VIRTIO_MMIO
> + =A0 =A0 =A0 ---help---
> + =A0 =A0 =A0 =A0Allow virtio-mmio devices instantiation via the kernel c=
ommand line
> + =A0 =A0 =A0 =A0or module parameters. Be aware that using incorrect para=
meters (base
> + =A0 =A0 =A0 =A0address in particular) can crash your system - you have =
been warned.
> + =A0 =A0 =A0 =A0See Documentation/kernel-parameters.txt for details.
> +
> + =A0 =A0 =A0 =A0If unsure, say 'N'.
> +
> =A0endmenu
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 7317dc2..eab0007 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -6,6 +6,50 @@
> =A0* This module allows virtio devices to be used over a virtual, memory =
mapped
> =A0* platform device.
> =A0*
> + * The guest device(s) may be instantiated in one of three equivalent wa=
ys:
> + *
> + * 1. Static platform device in board's code, eg.:
> + *
> + * =A0 =A0 static struct platform_device v2m_virtio_device =3D {
> + * =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "virtio-mmio",
> + * =A0 =A0 =A0 =A0 =A0 =A0 .id =3D -1,
> + * =A0 =A0 =A0 =A0 =A0 =A0 .num_resources =3D 2,
> + * =A0 =A0 =A0 =A0 =A0 =A0 .resource =3D (struct resource []) {
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =3D 0x=
1001e000,
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =3D 0x10=
01e0ff,
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IO=
RESOURCE_MEM,
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }, {
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =3D 42=
 + 32,
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =3D 42 +=
 32,
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IO=
RESOURCE_IRQ,
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + * =A0 =A0 =A0 =A0 =A0 =A0 }
> + * =A0 =A0 };
> + *
> + * 2. Device Tree node, eg.:
> + *
> + * =A0 =A0 =A0 =A0 =A0 =A0 virtio_block@1e000 {
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "virtio,mmio";
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1e000 0x100>;
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <42>;
> + * =A0 =A0 =A0 =A0 =A0 =A0 }
> + *
> + * 3. Kernel module (or command line) parameter. Can be used more than o=
nce -
> + * =A0 =A0one device will be created for each one. Syntax:
> + *
> + * =A0 =A0 =A0 =A0 =A0 =A0 [virtio_mmio.]device=3D<size>@<baseaddr>:<irq=
>[:<id>]
> + * =A0 =A0where:
> + * =A0 =A0 =A0 =A0 =A0 =A0 <size> =A0 =A0 :=3D size (can use standard su=
ffixes like K, M or G)
> + * =A0 =A0 =A0 =A0 =A0 =A0 <baseaddr> :=3D physical base address
> + * =A0 =A0 =A0 =A0 =A0 =A0 <irq> =A0 =A0 =A0:=3D interrupt number (as pa=
ssed to request_irq())
> + * =A0 =A0 =A0 =A0 =A0 =A0 <id> =A0 =A0 =A0 :=3D (optional) platform dev=
ice id
> + * =A0 =A0eg.:
> + * =A0 =A0 =A0 =A0 =A0 =A0 virtio_mmio.device=3D0x100@0x100b0000:48 \
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 virtio_mmio.d=
evice=3D1K@0x1001e000:74
> + *
> + *
> + *
> =A0* Registers layout (all 32-bit wide):
> =A0*
> =A0* offset d. name =A0 =A0 =A0 =A0 =A0 =A0 description
> @@ -42,6 +86,8 @@
> =A0* See the COPYING file in the top-level directory.
> =A0*/
>
> +#define pr_fmt(fmt) "virtio-mmio: " fmt
> +
> =A0#include <linux/highmem.h>
> =A0#include <linux/interrupt.h>
> =A0#include <linux/io.h>
> @@ -443,6 +489,122 @@ static int __devexit virtio_mmio_remove(struct plat=
form_device *pdev)
>
>
>
> +/* Devices list parameter */
> +
> +#if defined(CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES)
> +
> +static struct device vm_cmdline_parent =3D {
> + =A0 =A0 =A0 .init_name =3D "virtio-mmio-cmdline",
> +};
> +
> +static int vm_cmdline_parent_registered;
> +static int vm_cmdline_id;
> +
> +static int vm_cmdline_set(const char *device,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct kernel_param *kp)
> +{
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 struct resource resources[2] =3D {};
> + =A0 =A0 =A0 char *str;
> + =A0 =A0 =A0 long long int base;
> + =A0 =A0 =A0 int processed, consumed =3D 0;
> + =A0 =A0 =A0 struct platform_device *pdev;
> +
> + =A0 =A0 =A0 resources[0].flags =3D IORESOURCE_MEM;
> + =A0 =A0 =A0 resources[1].flags =3D IORESOURCE_IRQ;
> +
> + =A0 =A0 =A0 resources[0].end =3D memparse(device, &str) - 1;
> +
> + =A0 =A0 =A0 processed =3D sscanf(str, "@%lli:%u%n:%d%n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &base, &resources[1].start,=
 &consumed,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &vm_cmdline_id, &consumed);
> +
> + =A0 =A0 =A0 if (processed < 2 || processed > 3 || str[consumed])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 resources[0].start =3D base;
> + =A0 =A0 =A0 resources[0].end +=3D base;
> + =A0 =A0 =A0 resources[1].end =3D resources[1].start;
> +
> + =A0 =A0 =A0 if (!vm_cmdline_parent_registered) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D device_register(&vm_cmdline_parent);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Failed to register =
parent device!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vm_cmdline_parent_registered =3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pr_info("Registering device virtio-mmio.%d at 0x%llx-0x%llx=
, IRQ %d.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vm_cmdline_id++,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)resource=
s[0].start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)resource=
s[0].end,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(int)resources[1].start);
> +
> + =A0 =A0 =A0 pdev =3D platform_device_register_resndata(&vm_cmdline_pare=
nt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "virtio-mmio", vm_cmdline_i=
d++,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resources, ARRAY_SIZE(resou=
rces), NULL, 0);
> + =A0 =A0 =A0 if (IS_ERR(pdev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(pdev);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int vm_cmdline_get_device(struct device *dev, void *data)
> +{
> + =A0 =A0 =A0 char *buffer =3D data;
> + =A0 =A0 =A0 unsigned int len =3D strlen(buffer);
> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev);
> +
> + =A0 =A0 =A0 snprintf(buffer + len, PAGE_SIZE - len, "0x%llx@0x%llx:%llu=
:%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->resource[0].end - pde=
v->resource[0].start + 1ULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)pdev->r=
esource[0].start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)pdev->r=
esource[1].start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->id);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int vm_cmdline_get(char *buffer, const struct kernel_param *kp)
> +{
> + =A0 =A0 =A0 buffer[0] =3D '\0';
> + =A0 =A0 =A0 device_for_each_child(&vm_cmdline_parent, buffer,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vm_cmdline_get_device);
> + =A0 =A0 =A0 return strlen(buffer) + 1;
> +}
> +
> +static struct kernel_param_ops vm_cmdline_param_ops =3D {
> + =A0 =A0 =A0 .set =3D vm_cmdline_set,
> + =A0 =A0 =A0 .get =3D vm_cmdline_get,
> +};
> +
> +device_param_cb(device, &vm_cmdline_param_ops, NULL, S_IRUSR);
> +
> +static int vm_unregister_cmdline_device(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *data)
> +{
> + =A0 =A0 =A0 platform_device_unregister(to_platform_device(dev));
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void vm_unregister_cmdline_devices(void)
> +{
> + =A0 =A0 =A0 if (vm_cmdline_parent_registered) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_for_each_child(&vm_cmdline_parent, N=
ULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vm_unregist=
er_cmdline_device);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_unregister(&vm_cmdline_parent);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vm_cmdline_parent_registered =3D 0;
> + =A0 =A0 =A0 }
> +}
> +
> +#else
> +
> +static void vm_unregister_cmdline_devices(void)
> +{
> +}
> +
> +#endif
> +
> =A0/* Platform driver */
>
> =A0static struct of_device_id virtio_mmio_match[] =3D {
> @@ -469,6 +631,7 @@ static int __init virtio_mmio_init(void)
> =A0static void __exit virtio_mmio_exit(void)
> =A0{
> =A0 =A0 =A0 =A0platform_driver_unregister(&virtio_mmio_driver);
> + =A0 =A0 =A0 vm_unregister_cmdline_devices();
> =A0}
>
> =A0module_init(virtio_mmio_init);
> --
> 1.7.5.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
