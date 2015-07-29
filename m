From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_mmio: add ACPI probing
Date: Wed, 29 Jul 2015 21:03:14 +0300
Message-ID: <20150729210114-mutt-send-email-mst@redhat.com>
References: <1438076642-12080-1-git-send-email-graeme.gregory@linaro.org>
	<20150728130604-mutt-send-email-mst@redhat.com>
	<CAFEAcA9H6_oEFKFFNhcGW-8Yy8ng9iNnPbweTvMC46fwLmwA0w@mail.gmail.com>
	<20150728132113-mutt-send-email-mst@redhat.com>
	<CAGCh1+=4am4xHXark=EMLT-BD-92oWFvvWE4N7TEf=YwMAUCzQ@mail.gmail.com>
	<CAFEAcA-HZVJCa44g0-emN06-_a1DgsjtT4cC2_BBQgEyz-=akw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAFEAcA-HZVJCa44g0-emN06-_a1DgsjtT4cC2_BBQgEyz-=akw@mail.gmail.com>
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
Cc: Shannon Zhao <shannon.zhao@linaro.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, G Gregory <graeme.gregory@linaro.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 29, 2015 at 06:52:29PM +0100, Peter Maydell wrote:
> On 28 July 2015 at 11:33, G Gregory <graeme.gregory@linaro.org> wrote:
> > We assigned LNRO in ASWG to avoid collisions with our prototypes/real
> > platforms so it makes sense to me to switch to QEMUXXXX.
> 
> So just to check, if we switch virtio-mmio from an LNRO0005 ID
> to a QEMUxxxx ID we aren't going to break any existing widely
> shipped or deployed code, right?
> 
> If we can change the ID without breaking anything significant
> then I think the QEMU ID makes more sense; but it doesn't
> really gain us much beyond tidiness.
> 
> PS: https://www.kernel.org/doc/Documentation/arm64/arm-acpi.txt
> uses virtio-mmio and LNRO0005 as its code example, so if
> we change this then it might be nice to update the docs
> as a followup.
> 
> thanks
> -- PMM

So this is the proposed patch. I agree it's merely about tidyness.
Pls ack or nack - we need to decide before 2.4 is out.

-->

arm: change vendor ID for virtio-mmio

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index f365140..d10bd69 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -145,7 +145,7 @@ static void acpi_dsdt_add_virtio(Aml *scope,
 
     for (i = 0; i < num; i++) {
         Aml *dev = aml_device("VR%02u", i);
-        aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
+        aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0005")));
         aml_append(dev, aml_name_decl("_UID", aml_int(i)));
 
         Aml *crs = aml_resource_template();
