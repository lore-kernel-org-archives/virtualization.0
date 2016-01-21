From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: virtio ring layout changes for optimal single-stream performance
Date: Thu, 21 Jan 2016 16:38:36 +0100
Message-ID: <20160121163836.1091943d.cornelia.huck@de.ibm.com>
References: <20160121145418-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160121145418-mutt-send-email-mst@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, dev@dpdk.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, "Xie,
	Huawei" <huawei.xie@intel.com>, virtio@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 21 Jan 2016 15:39:26 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Hi all!
> I have been experimenting with alternative virtio ring layouts,
> in order to speed up single stream performance.
> 
> I have just posted a benchmark I wrote for the purpose, and a (partial)
> alternative layout implementation.  This achieves 20-40% reduction in
> virtio overhead in the (default) polling mode.
> 
> http://article.gmane.org/gmane.linux.kernel.virtualization/26889
> 
> The layout is trying to be as simple as possible, to reduce
> the number of cache lines bouncing between CPUs.

Some kind of diagram or textual description would really help to review
this.

> 
> For benchmarking, the idea is to emulate virtio in user-space,
> artificially adding overhead for e.g. signalling to match what happens
> in case of a VM.

Hm... is this overhead comparable enough between different platform so
that you can get a halfway realistic scenario? What about things like
endianness conversions?

> 
> I'd be very curious to get feedback on this, in particular, some people
> discussed using vectored operations to format virtio ring - would it
> conflict with this work?
> 
> You are all welcome to post enhancements or more layout alternatives as
> patches.

Let me see if I can find time to experiment a bit.
