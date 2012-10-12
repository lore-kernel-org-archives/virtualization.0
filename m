From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Using PCI config space to indicate config location
Date: Fri, 12 Oct 2012 11:33:30 +0200
Message-ID: <20121012093330.GA32014@redhat.com>
References: <87zk4c2tqq.fsf@rustcorp.com.au> <874nmajcmj.fsf@codemonkey.ws>
	<87y5jhpuu2.fsf@rustcorp.com.au> <20121010083033.GA4799@redhat.com>
	<87bog9957l.fsf@rustcorp.com.au> <20121011102333.GA5552@redhat.com>
	<87391k7icv.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87391k7icv.fsf@rustcorp.com.au>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 12, 2012 at 08:59:36AM +1030, Rusty Russell wrote:
> >> For writes, the standard seems to be a commit latch.  We could abuse the
> >> generation count for this: the driver writes to it to commit config
> >> changes.
> >
> > I think this will work. There are a couple of things that bother me:
> >
> > This assumes read accesses have no side effects, and these are sometimes handy.
> > Also the semantics for write aren't very clear to me.
> > I guess device must buffer data until generation count write?
> > This assumes the device has a buffer to store writes,
> > and it must track each byte written. I kind of dislike this
> > tracking of accessed bytes. Also, device would need to resolve conflicts
> > if any in some device specific way.
> 
> It should be trivial to implement: you keep a scratch copy of the config
> space, and copy it to the master copy when they hit the latch.
> 
> Implementation of this will show whether I've missed anything here, I
> think.

What I refer to: what happens if driver does:
- write offset 1
- write offset 3
- hit commit latch

?

-- 
MST
