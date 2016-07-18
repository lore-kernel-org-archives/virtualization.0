From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/3] virtio: Basic implementation of virtio pstore driver
Date: Mon, 18 Jul 2016 17:29:55 +0900
Message-ID: <20160718082955.GA12086__15366.2790930413$1468853125$gmane$org@danjae.aot.lge.com>
References: <1468816661-6345-1-git-send-email-namhyung@kernel.org>
	<1468816661-6345-2-git-send-email-namhyung@kernel.org>
	<20160718095439.1eabb340.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160718095439.1eabb340.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Tony Luck <tony.luck@intel.com>, Radim Kr??m???? <rkrcmar@redhat.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Anton Vorontsov <anton@enomsg.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel@nongnu.org, Minchan Kim <minchan@kernel.org>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

On Mon, Jul 18, 2016 at 09:54:39AM +0200, Cornelia Huck wrote:
> On Mon, 18 Jul 2016 13:37:39 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > The virtio pstore driver provides interface to the pstore subsystem so
> > that the guest kernel's log/dump message can be saved on the host
> > machine.  Users can access the log file directly on the host, or on the
> > guest at the next boot using pstore filesystem.  It currently deals with
> > kernel log (printk) buffer only, but we can extend it to have other
> > information (like ftrace dump) later.
> 
> Like the idea.

Thanks!

> 
> > 
> > It supports legacy PCI device using single order-2 page buffer.  As all
> 
> There should not be anything in there that limits this to pci, no?

Yep, there's no restriction AFAIK.  I just choose it to implement the poc
code quickly.

> 
> > operation of pstore is synchronous, it would be fine IMHO.  However I
> > don't know how to make write operation synchronous since it's called
> > with a spinlock held (from any context including NMI).
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Kr??m???? <rkrcmar@redhat.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Anthony Liguori <aliguori@amazon.com>
> > Cc: Anton Vorontsov <anton@enomsg.org>
> > Cc: Colin Cross <ccross@android.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: kvm@vger.kernel.org
> > Cc: qemu-devel@nongnu.org
> > Cc: virtualization@lists.linux-foundation.org
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  drivers/virtio/Kconfig             |  10 ++
> >  drivers/virtio/Makefile            |   1 +
> >  drivers/virtio/virtio_pstore.c     | 317 +++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/Kbuild          |   1 +
> >  include/uapi/linux/virtio_ids.h    |   1 +
> >  include/uapi/linux/virtio_pstore.h |  53 +++++++
> >  6 files changed, 383 insertions(+)
> >  create mode 100644 drivers/virtio/virtio_pstore.c
> >  create mode 100644 include/uapi/linux/virtio_pstore.h
> > 
> 
> (...)
> 
> > diff --git a/drivers/virtio/virtio_pstore.c b/drivers/virtio/virtio_pstore.c
> > new file mode 100644
> > index 000000000000..6fe62c0f1508
> > --- /dev/null
> > +++ b/drivers/virtio/virtio_pstore.c
> > @@ -0,0 +1,317 @@
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/pstore.h>
> > +#include <linux/virtio.h>
> > +#include <linux/virtio_config.h>
> > +#include <uapi/linux/virtio_ids.h>
> > +#include <uapi/linux/virtio_pstore.h>
> > +
> > +#define VIRT_PSTORE_ORDER    2
> > +#define VIRT_PSTORE_BUFSIZE  (4096 << VIRT_PSTORE_ORDER)
> 
> It may make sense to make the size of the buffer configurable through
> the config space.

Right.  I'm considering it too, but it needs a buffer larger than
kmsg_bytes (= 10K) to work properly in the current implementation.  As
this version is just to verify the idea is sane and useful, I used a
fixed size buffer.  Will change in the next version.

> 
> (...)
> 
> > diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> > index 77925f587b15..cba63225d85a 100644
> > --- a/include/uapi/linux/virtio_ids.h
> > +++ b/include/uapi/linux/virtio_ids.h
> > @@ -41,5 +41,6 @@
> >  #define VIRTIO_ID_CAIF	       12 /* Virtio caif */
> >  #define VIRTIO_ID_GPU          16 /* virtio GPU */
> >  #define VIRTIO_ID_INPUT        18 /* virtio input */
> > +#define VIRTIO_ID_PSTORE       19 /* virtio pstore */
> 
> This id is already used by one of the new device types queued but not
> yet in the standard. IIRC, 22 is the next free one.

Ok, will update.

> 
> Speaking of the standard: I think it makes sense to at least reserve a
> device id for pstore, as the idea is sound. Maybe prepare a patch to
> the standard as well if you have time?

I'd love to.  As I mentioned earlier, I don't have enough knowledge in
this area.  Could you please provide some links about how can I do that?

Thanks,
Namhyung
