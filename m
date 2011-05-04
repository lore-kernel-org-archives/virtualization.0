From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PDFv2] virtio-spec: 64 bit features, used/avail event
Date: Thu, 5 May 2011 00:17:49 +0300
Message-ID: <20110504211749.GA21244__20835.1561487236$1304543932$gmane$org@redhat.com>
References: <20110504203256.GA20819@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110504203256.GA20819@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

People asked for a pdf for a new spec, so here it is:
http://userweb.kernel.org/~mst/virtio-spec-event-idx-v2.pdf

Guest and host implementation can be found here:
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost-net-next-event-idx-v1
git://git.kernel.org/pub/scm/linux/kernel/git/mst/qemu-kvm.git virtio-net-event-idx-v1

Description reposted below:

I'm working on a patchset (to follow shortly)
that modified the notificatin hand-off in virtio to be basically
like Xen: each side published an index, the other side only triggers
an event when it crosses that index value
(Xen event indexes start at 1, ours start at 0 for
backward-compatiblity, but that's minor).

Especially for testing, it is very convenient to have
separate feature bits for this change in used and available
ring; since we've run out of bits in the 32 bit field,
I added another 32 bit and bit 31 enables that.

I started with using both flags and indexes in parallel,
but switched to doing either-or: this means we do
not need to tweak memory access ordering as index access just
replaces flags access.

A note on naming: the index replacing avail->flags is named
used_event, the index replacing used->flags is named
avail_event to stress the fact that these actually
point into the other side of the ring:
event is triggered when avail->idx == used->avail_event + 1
and when used->idx == avail->used_event + 1, respectively.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

-- 
MST
