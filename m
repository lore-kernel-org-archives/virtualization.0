From: Andrew Jones <drjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] arm: change vendor ID for virtio-mmio
Date: Mon, 3 Aug 2015 14:09:41 +0200
Message-ID: <20150803120941.GC7109@hawk.localdomain>
References: <1438196676-30255-1-git-send-email-mst@redhat.com>
	<CAFEAcA-dr_QBnM+h-4EQ9uZMRwVVi=UUazBLWmDWxLH+35ZKLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAFEAcA-dr_QBnM+h-4EQ9uZMRwVVi=UUazBLWmDWxLH+35ZKLQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Graeme Gregory <graeme.gregory@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Igor Mammedov <imammedo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 31, 2015 at 01:37:44PM +0100, Peter Maydell wrote:
> On 29 July 2015 at 20:16, Michael S. Tsirkin <mst@redhat.com> wrote:
> > ACPI spec 5.0 allows the use of PCI vendor IDs.
> >
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
> 
> So, I've just checked, and I believe that the kernel that RedHat
> are shipping in their RHEL7 dev preview for AArch64 (and probably
> thus also the Fedora/Centos one) includes a patch which adds
> ACPI support to the virtio-mmio driver using the LNRO0005 ID string.

Yes, we have https://lkml.org/lkml/2015/7/28/216 in the RHELSA kernel.
Although, while that kernel is floating around already, it hasn't
really been released, particularly not for virt use cases. So we could
change it (although that change needs to be soon).

> 
> This to me suggests that we should just stick with that ID,
> rather than changing to QEMUxxxx, the hex one based on the PCI
> vendor ID, or anything else.
> 
> We're obviously under no obligation to make life easy for people
> who ship kernels full of patches that haven't gone upstream yet,
> but in this case there doesn't seem to me to be any benefit to
> QEMU from picking an ID string that would break compatibility...

I'll remain abstained on this debate, but if the consensus is to
change it, then let me know, and I'll handle the changes on the
RHELSA side.

Thanks,
drew

> 
> [The kernel I checked was the one in
> https://git.centos.org/sources/kernel-aarch64/c7-aarch64/c589ab77889df6d93dbe817c373080631ab3275b
> which despite the filename is actually an 80MB .tar.xz archive,
> as pointed to by
> https://git.centos.org/blob/rpms!kernel-aarch64/910dbce5f13419d68002f58e67ee6e762a93a425/.kernel-aarch64.metadata
> ]
> 
> thanks
> -- PMM
> 
