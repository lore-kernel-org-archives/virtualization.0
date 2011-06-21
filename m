From: Tom Lendacky <tahm@linux.vnet.ibm.com>
Subject: Re: RFT: virtio_net: limit xmit polling
Date: Tue, 21 Jun 2011 10:23:22 -0500
Message-ID: <201106211023.24643.tahm__688.51070614091$1308669869$gmane$org@linux.vnet.ibm.com>
References: <20110619102700.GA11198@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110619102700.GA11198@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Krishna Kumar2 <krkumar2@in.ibm.com>, habanero@linux.vnet.ibm.com, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, netdev@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Sunday, June 19, 2011 05:27:00 AM Michael S. Tsirkin wrote:
> OK, different people seem to test different trees.  In the hope to get
> everyone on the same page, I created several variants of this patch so
> they can be compared. Whoever's interested, please check out the
> following, and tell me how these compare:

I'm in the process of testing these patches.  Base and v0 are complete
and v1 is near complete with v2 to follow.  I'm testing with a variety
of TCP_RR and TCP_STREAM/TCP_MAERTS tests involving local guest-to-guest
tests and remote host-to-guest tests.  I'll post the results in the next
day or two when the tests finish.

Thanks,
Tom

> 
> kernel:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> 
> virtio-net-limit-xmit-polling/base - this is net-next baseline to test
> against virtio-net-limit-xmit-polling/v0 - fixes checks on out of capacity
> virtio-net-limit-xmit-polling/v1 - previous revision of the patch
> 		this does xmit,free,xmit,2*free,free
> virtio-net-limit-xmit-polling/v2 - new revision of the patch
> 		this does free,xmit,2*free,free
> 
> There's also this on top:
> virtio-net-limit-xmit-polling/v3 -> don't delay avail index update
> I don't think it's important to test this one, yet
> 
> Userspace to use: event index work is not yet merged upstream
> so the revision to use is still this:
> git://git.kernel.org/pub/scm/linux/kernel/git/mst/qemu-kvm.git
> virtio-net-event-idx-v3
