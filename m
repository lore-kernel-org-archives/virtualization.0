From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] arm: change vendor ID for virtio-mmio
Date: Thu, 30 Jul 2015 11:04:38 +0300
Message-ID: <20150730105923-mutt-send-email-mst@redhat.com>
References: <1438196676-30255-1-git-send-email-mst@redhat.com>
	<55B97C88.6010004@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <55B97C88.6010004@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Shannon Zhao <shannon.zhao@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, qemu-devel@nongnu.org, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Igor Mammedov <imammedo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 30, 2015 at 09:23:20AM +0800, Shannon Zhao wrote:
> 
> 
> On 2015/7/30 3:16, Michael S. Tsirkin wrote:
> > ACPI spec 5.0 allows the use of PCI vendor IDs.
> > 
> But virtio-mmio is not a PCI device, it's a platform device.

Yes. ACPI spec 5.0 says:

	A valid PNP ID must be of the form "AAA####" where A is an uppercase
	letter and # is a hex digit. A valid ACPI ID must be of the form
	"NNNN####" where N is an uppercase letter or a digit ('0'-'9') and # is
	a hex digit. This specification reserves the string "ACPI" for use only
	with devices defined herein.

	It further reserves all strings representing 4 HEX digits for
	exclusive use with PCI-assigned Vendor IDs.

The second paragraph means if PCI SIG assigned you an ID, you
can use that without need to register it with ASWG.


> Why do we drop the previous way using "QEMUXXXX"? Something I missed?

So that guests that bind to this interface will work fine with non QEMU
implementations of virtio-mmio.

It's just playing nice with others.

We could have done something similar to pvpanic as well, except we
didn't and guests using the QEMU prefix have been released,
so we have to keep using that.

> > Since we have one for virtio, it seems neater to use that
> > rather than LNRO. For the device ID, use 103F which is a legacy ID that
> > isn't used in virtio PCI spec - seems to make sense since virtio-mmio is
> > a legacy device but we don't know the correct device type.
> > 
> > Guests should probably match everything in the range 1000-103F
> > (just like legacy pci drivers do) which will allow us to pass in the
> > actual ID in the future if we want to.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  hw/arm/virt-acpi-build.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index f365140..dea61ba 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -145,7 +145,7 @@ static void acpi_dsdt_add_virtio(Aml *scope,
> >  
> >      for (i = 0; i < num; i++) {
> >          Aml *dev = aml_device("VR%02u", i);
> > -        aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
> > +        aml_append(dev, aml_name_decl("_HID", aml_string("1AF4103F")));
> >          aml_append(dev, aml_name_decl("_UID", aml_int(i)));
> >  
> >          Aml *crs = aml_resource_template();
> > 
> 
> -- 
> Shannon
