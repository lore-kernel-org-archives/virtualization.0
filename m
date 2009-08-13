From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] vhost_net: a kernel-level virtio server
Date: Thu, 13 Aug 2009 18:03:44 +0300
Message-ID: <20090813150344.GC5080__15289.9753804833$1250176205$gmane$org@redhat.com>
References: <cover.1249930169.git.mst@redhat.com>
	<200908131538.44465.arnd@arndb.de>
	<20090813143922.GA5080@redhat.com>
	<200908131658.06522.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908131658.06522.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: netdev@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 13, 2009 at 04:58:06PM +0200, Arnd Bergmann wrote:
> On Thursday 13 August 2009, Michael S. Tsirkin wrote:
> > > Right now, the number of copy operations in your code is the same.
> > > You are doing the copy a little bit later in skb_copy_datagram_iovec(),
> > > which is indeed a very nice hack. Changing to a virtqueue based method
> > > would imply that the host needs to add each skb_frag_t to its outbound
> > > virtqueue, which then gets copied into the guests inbound virtqueue.
> > 
> > Which is a lot more code than just calling skb_copy_datagram_iovec.
> 
> Well, I don't see this part as much of a problem, because the code
> already exists in virtio_net.

I am talking about the copying done in low level transport, here.

> If we really wanted to go down that road,
> just using virtio_net would solve the problem of frame handling
> entirely, but create new problems elsewhere, as we have mentioned.
> 
> 	Arnd <><
