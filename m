From: Shannon Zhao <shannon.zhao@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2] arm: change vendor ID for virtio-mmio
Date: Thu, 30 Jul 2015 09:23:20 +0800
Message-ID: <55B97C88.6010004__38919.1009606749$1438620858$gmane$org@linaro.org>
References: <1438196676-30255-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1438196676-30255-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Igor Mammedov <imammedo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



On 2015/7/30 3:16, Michael S. Tsirkin wrote:
> ACPI spec 5.0 allows the use of PCI vendor IDs.
> 
But virtio-mmio is not a PCI device, it's a platform device.
Why do we drop the previous way using "QEMUXXXX"? Something I missed?

> Since we have one for virtio, it seems neater to use that
> rather than LNRO. For the device ID, use 103F which is a legacy ID that
> isn't used in virtio PCI spec - seems to make sense since virtio-mmio is
> a legacy device but we don't know the correct device type.
> 
> Guests should probably match everything in the range 1000-103F
> (just like legacy pci drivers do) which will allow us to pass in the
> actual ID in the future if we want to.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/arm/virt-acpi-build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f365140..dea61ba 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -145,7 +145,7 @@ static void acpi_dsdt_add_virtio(Aml *scope,
>  
>      for (i = 0; i < num; i++) {
>          Aml *dev = aml_device("VR%02u", i);
> -        aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
> +        aml_append(dev, aml_name_decl("_HID", aml_string("1AF4103F")));
>          aml_append(dev, aml_name_decl("_UID", aml_int(i)));
>  
>          Aml *crs = aml_resource_template();
> 

-- 
Shannon
