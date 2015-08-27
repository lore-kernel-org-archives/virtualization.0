From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: Re: [PATCH] virtio_mmio: add ACPI probing
Date: Thu, 27 Aug 2015 15:55:03 +0100
Message-ID: <20150827145503.GA2426__6087.4110241004$1440687358$gmane$org@xora-yoga13-vm.xora.org.uk>
References: <1438076642-12080-1-git-send-email-graeme.gregory@linaro.org>
	<20150729211637-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150729211637-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 29, 2015 at 09:17:08PM +0300, Michael S. Tsirkin wrote:
> On Tue, Jul 28, 2015 at 10:44:02AM +0100, Graeme Gregory wrote:
> > Added the match table and pointers for ACPI probing to the driver.
> > 
> > This uses the same identifier for virt devices as being used for qemu
> > ARM64 ACPI support.
> > 
> > http://git.linaro.org/people/shannon.zhao/qemu.git/commit/d0bf1955a3ecbab4b51d46f8c5dda02b7e14a17e
> > 
> > Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> 
> To summarize, let's wait a bit with this until QEMU 2.4
> with the relevant code is out, to make sure ID does not
> change.
> 

It seems qemu 2.4 released with the LNRO0005 identifier.

Graeme

> > ---
> >  drivers/virtio/virtio_mmio.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > index 10189b5..f499d9d 100644
> > --- a/drivers/virtio/virtio_mmio.c
> > +++ b/drivers/virtio/virtio_mmio.c
> > @@ -58,6 +58,7 @@
> >  
> >  #define pr_fmt(fmt) "virtio-mmio: " fmt
> >  
> > +#include <linux/acpi.h>
> >  #include <linux/highmem.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> > @@ -732,12 +733,21 @@ static struct of_device_id virtio_mmio_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, virtio_mmio_match);
> >  
> > +#ifdef CONFIG_ACPI
> > +static const struct acpi_device_id virtio_mmio_acpi_match[] = {
> > +	{ "LNRO0005", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, virtio_mmio_acpi_match);
> > +#endif
> > +
> >  static struct platform_driver virtio_mmio_driver = {
> >  	.probe		= virtio_mmio_probe,
> >  	.remove		= virtio_mmio_remove,
> >  	.driver		= {
> >  		.name	= "virtio-mmio",
> >  		.of_match_table	= virtio_mmio_match,
> > +		.acpi_match_table = ACPI_PTR(virtio_mmio_acpi_match),
> >  	},
> >  };
> >  
> > -- 
> > 2.1.4
