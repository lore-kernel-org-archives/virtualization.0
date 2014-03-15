From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] virtio-blk: make the queue depth the max supportable by
	the hypervisor
Date: Sat, 15 Mar 2014 06:57:23 -0700
Message-ID: <20140315135723.GA10475@infradead.org>
References: <1394841445-16142-1-git-send-email-venkateshs@google.com>
	<1394854471-25700-1-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1394854471-25700-1-git-send-email-tytso@mit.edu>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Frank Swiderski <fes@google.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 14, 2014 at 11:34:31PM -0400, Theodore Ts'o wrote:
> The current virtio block sets a queue depth of 64, which is
> insufficient for very fast devices.  It has been demonstrated that
> with a high IOPS device, using a queue depth of 256 can double the
> IOPS which can be sustained.
> 
> As suggested by Venkatash Srinivas, set the queue depth by default to
> be one half the the device's virtqueue, which is the maximum queue
> depth that can be supported by the channel to the host OS (each I/O
> request requires at least two VQ entries).

I don't think this should be a module parameter.  The default sizing
should be based of the parameters of the actual virtqueue, and if we
want to allow tuning it it should be by a sysfs attribute, preferable
using the same semantics as SCSI.
