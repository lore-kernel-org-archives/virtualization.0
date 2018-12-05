From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v9] virtio_blk: add discard and write zeroes support
Date: Wed, 5 Dec 2018 08:41:43 -0500
Message-ID: <20181205084049-mutt-send-email-mst@kernel.org>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
	<20181101224035.215548-1-dverkamp@chromium.org>
	<20181102041751.GA13688@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B7817C5@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B7817C5@SHSMSX103.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Liu, Changpeng" <changpeng.liu@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


On Wed, Dec 05, 2018 at 09:46:16AM +0000, Liu, Changpeng wrote:
> What's the status of this patch ? anybody pulled it for the branch ?

I will merge it for next.

> 
> > -----Original Message-----
> > From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> > Sent: Friday, November 2, 2018 12:18 PM
> > To: Daniel Verkamp <dverkamp@chromium.org>
> > Cc: virtualization@lists.linux-foundation.org; linux-block@vger.kernel.org;
> > Michael S. Tsirkin <mst@redhat.com>; Jason Wang <jasowang@redhat.com>;
> > Jens Axboe <axboe@kernel.dk>; Paolo Bonzini <pbonzini@redhat.com>;
> > Christoph Hellwig <hch@infradead.org>; Liu, Changpeng
> > <changpeng.liu@intel.com>
> > Subject: Re: [PATCH v9] virtio_blk: add discard and write zeroes support
> > 
> > On Thu, Nov 01, 2018 at 03:40:35PM -0700, Daniel Verkamp wrote:
> > > From: Changpeng Liu <changpeng.liu@intel.com>
> > >
> > > In commit 88c85538, "virtio-blk: add discard and write zeroes features
> > > to specification" (https://github.com/oasis-tcs/virtio-spec), the virtio
> > > block specification has been extended to add VIRTIO_BLK_T_DISCARD and
> > > VIRTIO_BLK_T_WRITE_ZEROES commands.  This patch enables support for
> > > discard and write zeroes in the virtio-blk driver when the device
> > > advertises the corresponding features, VIRTIO_BLK_F_DISCARD and
> > > VIRTIO_BLK_F_WRITE_ZEROES.
> > >
> > > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> > > Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> > > ---
> > > dverkamp: I've picked up this patch and made a few minor changes (as
> > > listed below); most notably, I changed the kmalloc back to GFP_ATOMIC,
> > > since it can be called from a context where sleeping is not allowed.
> > > To prevent large allocations, I've also clamped the maximum number of
> > > discard segments to 256; this results in a 4K allocation and should be
> > > plenty of descriptors for most use cases.
> > >
> > > I also removed most of the description from the commit message, since it
> > > was duplicating the comments from virtio_blk.h and quoting parts of the
> > > spec without adding any extra information.  I have tested this iteration
> > > of the patch using crosvm with modifications to enable the new features:
> > > https://chromium.googlesource.com/chromiumos/platform/crosvm/
> > >
> > > v9 fixes a number of review issues; I didn't attempt to optimize the
> > > single-element write zeroes case, so it still does an allocation per
> > > request (I did not see any easy place to put the payload that would
> > > avoid the allocation).
> > >
> > > CHANGELOG:
> > > v9: [dverkamp] fix LE types in discard struct; cleanups from Ming Lei
> > > v8: [dverkamp] replace shifts by 9 with SECTOR_SHIFT constant
> > > v7: [dverkamp] use GFP_ATOMIC for allocation that may not sleep; clarify
> > > descriptor flags field; comment wording cleanups.
> > > v6: don't set T_OUT bit to discard and write zeroes commands.
> > > v5: use new block layer API: blk_queue_flag_set.
> > > v4: several optimizations based on MST's comments, remove bit field
> > > usage for command descriptor.
> > > v3: define the virtio-blk protocol to add discard and write zeroes
> > > support, first version implementation based on proposed specification.
> > > v2: add write zeroes command support.
> > > v1: initial proposal implementation for discard command.
> > > ---
> > >  drivers/block/virtio_blk.c      | 83 ++++++++++++++++++++++++++++++++-
> > >  include/uapi/linux/virtio_blk.h | 54 +++++++++++++++++++++
> > >  2 files changed, 135 insertions(+), 2 deletions(-)
> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
