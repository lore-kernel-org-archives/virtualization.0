From: Venkatesh Srinivas <venkateshs@google.com>
Subject: Re: [PATCH] virtio-blk: make the queue depth the max supportable by
	the hypervisor
Date: Wed, 19 Mar 2014 10:48:44 -0700
Message-ID: <CAHdzE-_cAndCNhBM1N0RpjQDhoh3Snas-eza4rYN33Rf69PXyw@mail.gmail.com>
References: <1394841445-16142-1-git-send-email-venkateshs@google.com>
	<1394854471-25700-1-git-send-email-tytso@mit.edu>
	<87siqhu048.fsf@rustcorp.com.au> <20140317054053.GF14162@thunk.org>
	<871txysnw2.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <871txysnw2.fsf@rustcorp.com.au>
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
Cc: Frank Swiderski <fes@google.com>, virtio-dev@lists.oasis-open.org, tytso@mit.edu, "Michael S. Tsirkin" <mst@redhat.com>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> And I rewrote it substantially, mainly to take
> VIRTIO_RING_F_INDIRECT_DESC into account.
>
> As QEMU sets the vq size for PCI to 128, Venkatash's patch wouldn't
> have made a change.  This version does (since QEMU also offers
> VIRTIO_RING_F_INDIRECT_DESC.

That divide-by-2 produced the same queue depth as the prior
computation in QEMU was deliberate -- but raising it to 128 seems
pretty reasonable.

Signed-off-by: Venkatesh Srinivas <venkateshs@google.com>

-- vs;
