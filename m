From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] virtio-blk: make the queue depth the max supportable by
	the hypervisor
Date: Sat, 15 Mar 2014 11:13:22 -0400
Message-ID: <20140315151322.GA17270@thunk.org>
References: <1394841445-16142-1-git-send-email-venkateshs@google.com>
	<1394854471-25700-1-git-send-email-tytso@mit.edu>
	<20140315135723.GA10475@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140315135723.GA10475@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Frank Swiderski <fes@google.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Mar 15, 2014 at 06:57:23AM -0700, Christoph Hellwig wrote:
> I don't think this should be a module parameter.  The default sizing
> should be based of the parameters of the actual virtqueue, and if we
> want to allow tuning it it should be by a sysfs attribute, preferable
> using the same semantics as SCSI.

I wanted that too, but looking at the multiqueue code, it wasn't all
obvious how to safely adjust the queue depth once the virtio-blk
device driver is initialized and becomes active.  There are all sorts
data structures including bitmaps, etc. that would have to be resized,
and I decided it would be too difficult / risky for me to make it be
dynamically resizeable.

So I settled on a module parameter thinking it would mostly only used
by testers / benchmarkers.

Can someone suggest a way to do a dynamic resizing of the virtio-blk
queue depth easily / safely?

    	    	      	     	- Ted
