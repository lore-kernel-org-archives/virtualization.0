From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_mmio: add ACPI probing
Date: Tue, 28 Jul 2015 13:27:18 +0300
Message-ID: <20150728132113-mutt-send-email-mst@redhat.com>
References: <1438076642-12080-1-git-send-email-graeme.gregory@linaro.org>
	<20150728130604-mutt-send-email-mst@redhat.com>
	<CAFEAcA9H6_oEFKFFNhcGW-8Yy8ng9iNnPbweTvMC46fwLmwA0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAFEAcA9H6_oEFKFFNhcGW-8Yy8ng9iNnPbweTvMC46fwLmwA0w@mail.gmail.com>
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
Cc: Shannon Zhao <shannon.zhao@linaro.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 28, 2015 at 11:12:33AM +0100, Peter Maydell wrote:
> On 28 July 2015 at 11:08, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Tue, Jul 28, 2015 at 10:44:02AM +0100, Graeme Gregory wrote:
> >> Added the match table and pointers for ACPI probing to the driver.
> >>
> >> This uses the same identifier for virt devices as being used for qemu
> >> ARM64 ACPI support.
> >>
> >> http://git.linaro.org/people/shannon.zhao/qemu.git/commit/d0bf1955a3ecbab4b51d46f8c5dda02b7e14a17e
> >>
> >> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> >> ---
> >>  drivers/virtio/virtio_mmio.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> >> index 10189b5..f499d9d 100644
> >> --- a/drivers/virtio/virtio_mmio.c
> >> +++ b/drivers/virtio/virtio_mmio.c
> >> @@ -58,6 +58,7 @@
> >>
> >>  #define pr_fmt(fmt) "virtio-mmio: " fmt
> >>
> >> +#include <linux/acpi.h>
> >>  #include <linux/highmem.h>
> >>  #include <linux/interrupt.h>
> >>  #include <linux/io.h>
> >> @@ -732,12 +733,21 @@ static struct of_device_id virtio_mmio_match[] = {
> >>  };
> >>  MODULE_DEVICE_TABLE(of, virtio_mmio_match);
> >>
> >> +#ifdef CONFIG_ACPI
> >> +static const struct acpi_device_id virtio_mmio_acpi_match[] = {
> >> +     { "LNRO0005", },
> >> +     { }
> >> +};
> >
> > Hmm - we have reserved QEMUXXXX in ASWG explicitly for this purpose.
> >
> > Pater - do you think it's a good idea to change this before QEMU 2.4
> > is released?
> 
> Shannon's call, I guess. I don't know enough about ACPI to say.
> I thought these ACPI IDs were already fixed because they were
> what the kernel was looking for...
> 
> -- PMM

Apparently not :)

-- 
MST
