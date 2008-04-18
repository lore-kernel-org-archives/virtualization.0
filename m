From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 0/5] High-speed tun receive and xmit
Date: Fri, 18 Apr 2008 14:33:48 +1000
Message-ID: <200804181433.48488.rusty__21725.6055599593$1208493417$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Max Krasnyansky <maxk@qualcomm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

kvm (and lguest!) want to get more speed out of the tun device.  We already 
have an ABI for guest<->host comms, called virtio_ring; extending tun to 
understand this (with its async nature and batching) make for an efficient 
network.

But moreover: the same things that make virtio a good guest<->host transport 
make it appealing as a userspace<->kernel transport.  So rather than do 
something just for tun, we create a /dev/vring.  We could do a system call, 
but /dev/vring is sufficient.  It is a nice, simple format for normal tun 
usage too.

We do need a small (backwards-compatible) extension to the ring format if 
we're going to do this however, since we didn't previously expose the 
consumer's view of the producer (and vice verse) in the ring because the 
other end doesn't need to see it.  However, it means that a middleman (as the 
kvm or lguest launcher process now becomes) cannot save and restore all the 
ring state.

Cheers,
Rusty.
