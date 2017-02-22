From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: packed ring layout proposal - todo list
Date: Wed, 22 Feb 2017 06:27:11 +0200
Message-ID: <20170222054336-mutt-send-email-mst__10563.732047058$1487737659$gmane$org@kernel.org>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio-dev@lists.oasis-open.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Here is an attempt to summarise the list of things
we need to do with respect to this proposal.


Stage 1: update prototype and finalize proposal

At this stage we need to update the prototype under
tools/virtio/ringtest/ring.c to make it match
latest proposal, adding in verious options under discussion.
Then we will measure performance. While more ideas are welcome
there won't be useful without ability to test!

Tasks:

- update tools/virtio/ringtest/ring.c to proposal, adding
  options as listed below.
- compare performance with and without indirect buffers
  issue: how to estimate cost of memory allocations?
- batching descriptors - is it worth it?
- three ways to suppress interrupts/exits
  which works better?
  issue: how to estimate cost of interrupts/exits?


More ideas:

- current tests all indicate cache synchronizations due to r/w descriptors
  cost as much as read-only/write-only descriptors,
  and there are less of these synchronizations.
  Disagree? Write a patch and benchmark.
- some devices could use smaller descriptors. For example,
  if you don't need length, id (e.g. using in-order, fixed length) or flags, you can
  use a single 64 bit pointer as a descriptor. This can sometimes work
  e.g. for networking rx rings.
  Not clear whether this gains/costs us anything. Disagree? Write a patch and benchmark.

Stage 2: prototype guest/host drivers

At this stage we need real guest and host drivers
to be able to test real life performance.
I suggest dpdk drivers + munimal hack in qemu to
pass features around.

Tasks:

- implement vhost-user support in dpdk
- implement virtio support in dpdk
- implement minimal stub in qemu
- test performance. Possibly revisit questions from stage 2
  if any are left open


Stage 3: complete guest/host drivers

At this stage we need to add linux support in virtio and vhost,
and complete qemu support.

Tasks:

- implement vhost support in kernel
- implement virtio support in kernel
- complete virtio support in qemu
- test performance. Possibly revisit questions from stage 2
  if any are left open



Stage X: Finalizing the spec

When are we ready to put out a spec draft? Surely not before Stage 1 is
done. Surely no later than stage 3.  A driver could be wish for some
party to productize an implementation.

Interested? Join TC and start discussion on timing and which
features should be included.


-- 
MST
