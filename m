From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [virtio-dev] [PATCH] virtio_pci: support enabling VFs
Date: Fri, 1 Jun 2018 09:36:43 +0800
Message-ID: <20180601013643.GA23128__14492.0447878123$1527816887$gmane$org@debian>
References: <20180530085521.26583-1-tiwei.bie@intel.com>
	<D7004E41-C23D-48B7-94A4-ACBBA06B021D@intel.com>
	<20180530190819-mutt-send-email-mst@kernel.org>
	<20180531025502.GA15516@debian>
	<20180601042004-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180601042004-mutt-send-email-mst@kernel.org>
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
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Wang,
	Zhihong" <zhihong.wang@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rustad,
	Mark D" <mark.d.rustad@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 01, 2018 at 04:21:03AM +0300, Michael S. Tsirkin wrote:
> On Thu, May 31, 2018 at 10:55:02AM +0800, Tiwei Bie wrote:
> > On Wed, May 30, 2018 at 07:09:37PM +0300, Michael S. Tsirkin wrote:
> > > On Wed, May 30, 2018 at 04:03:37PM +0000, Rustad, Mark D wrote:
> > > > On May 30, 2018, at 1:55 AM, Tiwei Bie <tiwei.bie@intel.com> wrote:
> > > > 
> > > > > There is a new feature bit allocated in virtio spec to
> > > > > support SR-IOV (Single Root I/O Virtualization):
> > > > > 
> > > > > https://github.com/oasis-tcs/virtio-spec/issues/11
> > > > > 
> > > > > This patch enables the support for this feature bit in
> > > > > virtio driver.
> > > > > 
> > > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > > > ---
> > > > > This patch depends on below proposal:
> > > > > https://lists.oasis-open.org/archives/virtio-dev/201805/msg00154.html
> > > > > 
> > > > > This patch depends on below patch:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/virtualization&id=8effc395c2097e258fcedfc02ed4a66d45fb4238
> > > > > 
> > > > >  drivers/virtio/virtio_pci_common.c | 20 ++++++++++++++++++++
> > > > >  drivers/virtio/virtio_pci_modern.c | 14 ++++++++++++++
> > > > >  include/uapi/linux/virtio_config.h |  7 ++++++-
> > > > >  3 files changed, 40 insertions(+), 1 deletion(-)
> > > > > 
> > > > 
> > > > <snip>
> > > > 
> > > > > diff --git a/include/uapi/linux/virtio_config.h
> > > > > b/include/uapi/linux/virtio_config.h
> > > > > index 308e2096291f..b7c1f4e7d59e 100644
> > > > > --- a/include/uapi/linux/virtio_config.h
> > > > > +++ b/include/uapi/linux/virtio_config.h
> > > > > @@ -49,7 +49,7 @@
> > > > 
> > > > There is a value in the comment directly before this that should
> > > > be updated as well to be consistent with the new value for
> > > > VIRTIO_TRANSPORT_F_END below.
> > > 
> > > It hasn't been updated to 34 yet.
> > > I suggest a separate patch to replace the numbers with
> > > VIRTIO_TRANSPORT_F_START and VIRTIO_TRANSPORT_F_END
> > > in the comment.
> > > Maybe replace "e.g. virtio_ring" with "e.g. virtio_ring,
> > > virtio_pci etc." as well.
> > 
> > Good idea! Thanks for the suggestion! I'll do it.
> > 
> > Best regards,
> > Tiwei Bie
> 
> Or just focus on the new feature, tweak start/end
> as a separate patch. Up to you, the important thing
> is to have a ready to roll patch before the merge
> window.

Got it! Thank you very much!

Best regards,
Tiwei Bie
