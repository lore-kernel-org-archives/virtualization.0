From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: virtio ring layout changes for optimal single-stream performance
Date: Thu, 21 Jan 2016 15:39:26 +0200
Message-ID: <20160121145418-mutt-send-email-mst__22024.4446456947$1453383586$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio@lists.oasis-open.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, dev@dpdk.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, "Xie,
	Huawei" <huawei.xie@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi all!
I have been experimenting with alternative virtio ring layouts,
in order to speed up single stream performance.

I have just posted a benchmark I wrote for the purpose, and a (partial)
alternative layout implementation.  This achieves 20-40% reduction in
virtio overhead in the (default) polling mode.

http://article.gmane.org/gmane.linux.kernel.virtualization/26889

The layout is trying to be as simple as possible, to reduce
the number of cache lines bouncing between CPUs.

For benchmarking, the idea is to emulate virtio in user-space,
artificially adding overhead for e.g. signalling to match what happens
in case of a VM.

I'd be very curious to get feedback on this, in particular, some people
discussed using vectored operations to format virtio ring - would it
conflict with this work?

You are all welcome to post enhancements or more layout alternatives as
patches.

TODO:
- documentation+discussion of interaction with CPU caching
- thorough benchmarking of different configurations/hosts
- experiment with event index replacements
- better emulate vmexit/vmentry cost overhead
- virtio spec proposal

Thanks!
-- 
MST
