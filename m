From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RFT: virtio_net: limit xmit polling
Date: Sun, 19 Jun 2011 13:27:00 +0300
Message-ID: <20110619102700.GA11198__16794.299070216$1308479288$gmane$org@redhat.com>
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
To: Krishna Kumar2 <krkumar2@in.ibm.com>
Cc: habanero@linux.vnet.ibm.com, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, netdev@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

OK, different people seem to test different trees.  In the hope to get
everyone on the same page, I created several variants of this patch so
they can be compared. Whoever's interested, please check out the
following, and tell me how these compare:

kernel:

git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git

virtio-net-limit-xmit-polling/base - this is net-next baseline to test against
virtio-net-limit-xmit-polling/v0 - fixes checks on out of capacity
virtio-net-limit-xmit-polling/v1 - previous revision of the patch
		this does xmit,free,xmit,2*free,free
virtio-net-limit-xmit-polling/v2 - new revision of the patch
		this does free,xmit,2*free,free

There's also this on top:
virtio-net-limit-xmit-polling/v3 -> don't delay avail index update
I don't think it's important to test this one, yet

Userspace to use: event index work is not yet merged upstream
so the revision to use is still this:
git://git.kernel.org/pub/scm/linux/kernel/git/mst/qemu-kvm.git
virtio-net-event-idx-v3

-- 
MST
