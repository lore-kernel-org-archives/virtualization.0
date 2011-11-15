From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 00/11] virtio: Support for hibernation (S4)
Date: Tue, 15 Nov 2011 18:22:46 +0530
Message-ID: <20111115125246.GB26378@amit-x200.redhat.com>
References: <cover.1317309123.git.amit.shah@redhat.com>
	<20111002094920.GF29706@redhat.com>
	<8739f9ipsi.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8739f9ipsi.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Virtualization List <virtualization@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) 04 Oct 2011 [10:36:05], Rusty Russell wrote:
> On Sun, 2 Oct 2011 11:49:21 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Sep 29, 2011 at 08:55:56PM +0530, Amit Shah wrote:
> > > Hello,
> > > 
> > > These patches add support for S4 to virtio (pci) and all drivers.  The
> > > patches are based on the virtio-console patch series in Rusty's queue.
> > > 
> > > For each driver, all vqs are removed before hibernation, and then
> > > re-created after restore.
> > > 
> > > All the drivers in testing work fine:
> > > 
> > > * virtio-blk is used for the only disk in the VM, IO works fine before
> > >   and after.
> 
> I'm not familiar with the suspend code, but:
> 
> 1) Does it already ensure there are no outstanding I/O requests?  If
>    not, we want to restore them when we unfreeze.

For the blk code, I added blk_drain_queue() and related calls to the
freeze handler, that was missed earlier.

> 2) Does it stop more I/O from reaching do_virtblk_request during freeze?
>    If not, we need to.

Added blk_stop_queue() and blk_start_queue() calls to ensure this.

> If we need to save and restore requests, I don't think we should do this
> on a per-driver basis, but try to do it in the core.

Agreed, however currently we don't save and restore any pending vq
items.  If it is necessary, we should do it in common code (earlier
version of this patchset did that).  I think we can get better results
by flushing the vq instead of trying to save/restore elements.

		Amit
