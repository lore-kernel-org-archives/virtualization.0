From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 1/2] tcm_vhost: Wait for pending requests in
	vhost_scsi_flush()
Date: Tue, 12 Mar 2013 09:34:09 +0800
Message-ID: <20130312013409.GC1480@hj.localdomain>
References: <1362978579-13322-1-git-send-email-asias@redhat.com>
	<1362978579-13322-2-git-send-email-asias@redhat.com>
	<513DC1C5.4070106@redhat.com> <20130311115356.GD23359@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130311115356.GD23359@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 11, 2013 at 01:53:56PM +0200, Michael S. Tsirkin wrote:
> On Mon, Mar 11, 2013 at 12:36:37PM +0100, Paolo Bonzini wrote:
> > Il 11/03/2013 06:09, Asias He ha scritto:
> > > This patch makes vhost_scsi_flush() wait for all the pending requests
> > > issued before the flush operation to be finished.
> > 
> > There is no protection against issuing concurrent flush operations.  If
> > we later would like to make the flush a ioctl (for example for migration
> > purposes),
> 
> For migration I think we need to stop vhost, flush isn't useful
> if we keep submitting requests afterwards.
> 
> > it would be confusing, and I'm not sure how you could extend
> > the during_flush machinery.
> > 
> > What about making vhost_scsi_flush() wait for all pending requests,
> > including those issues during the flush operation?  Then you can easily
> > support concurrent flushes; just add a waitqueue and wake_up_all at the
> > end of the flush operation.
> > 
> > BTW, adding such a ioctl as part of this patch would probably be a good
> > thing to do anyway.
> > 
> > Paolo
> 
> Please keep it separate, it's painful enough that we have a driver
> with to established userspace, I don't want to add ioctls
> until it's used by some upstream.

Let's add the ioctls later.

> -- 
> MST

-- 
Asias
