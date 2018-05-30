From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] [PATCH] virtio_pci: support enabling VFs
Date: Wed, 30 May 2018 19:09:37 +0300
Message-ID: <20180530190819-mutt-send-email-mst__8248.03932705454$1527696459$gmane$org@kernel.org>
References: <20180530085521.26583-1-tiwei.bie@intel.com>
	<D7004E41-C23D-48B7-94A4-ACBBA06B021D@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <D7004E41-C23D-48B7-94A4-ACBBA06B021D@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Rustad, Mark D" <mark.d.rustad@intel.com>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Wang,
	Zhihong" <zhihong.wang@intel.com>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 30, 2018 at 04:03:37PM +0000, Rustad, Mark D wrote:
> On May 30, 2018, at 1:55 AM, Tiwei Bie <tiwei.bie@intel.com> wrote:
> 
> > There is a new feature bit allocated in virtio spec to
> > support SR-IOV (Single Root I/O Virtualization):
> > 
> > https://github.com/oasis-tcs/virtio-spec/issues/11
> > 
> > This patch enables the support for this feature bit in
> > virtio driver.
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > ---
> > This patch depends on below proposal:
> > https://lists.oasis-open.org/archives/virtio-dev/201805/msg00154.html
> > 
> > This patch depends on below patch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/virtualization&id=8effc395c2097e258fcedfc02ed4a66d45fb4238
> > 
> >  drivers/virtio/virtio_pci_common.c | 20 ++++++++++++++++++++
> >  drivers/virtio/virtio_pci_modern.c | 14 ++++++++++++++
> >  include/uapi/linux/virtio_config.h |  7 ++++++-
> >  3 files changed, 40 insertions(+), 1 deletion(-)
> > 
> 
> <snip>
> 
> > diff --git a/include/uapi/linux/virtio_config.h
> > b/include/uapi/linux/virtio_config.h
> > index 308e2096291f..b7c1f4e7d59e 100644
> > --- a/include/uapi/linux/virtio_config.h
> > +++ b/include/uapi/linux/virtio_config.h
> > @@ -49,7 +49,7 @@
> 
> There is a value in the comment directly before this that should
> be updated as well to be consistent with the new value for
> VIRTIO_TRANSPORT_F_END below.

It hasn't been updated to 34 yet.
I suggest a separate patch to replace the numbers with
VIRTIO_TRANSPORT_F_START and VIRTIO_TRANSPORT_F_END
in the comment.
Maybe replace "e.g. virtio_ring" with "e.g. virtio_ring,
virtio_pci etc." as well.

> >   * transport being used (eg. virtio_ring), the rest are per-device feature
> >   * bits. */
> >  #define VIRTIO_TRANSPORT_F_START	28
> > -#define VIRTIO_TRANSPORT_F_END		34
> > +#define VIRTIO_TRANSPORT_F_END		38
> > 
> >  #ifndef VIRTIO_CONFIG_NO_LEGACY
> >  /* Do we get callbacks when the ring is completely used, even if we've
> 
> <snip>
> 
> --
> Mark Rustad, Networking Division, Intel Corporation
