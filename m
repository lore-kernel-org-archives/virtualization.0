From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Using PCI config space to indicate config location
Date: Tue, 16 Oct 2012 15:30:45 +0200
Message-ID: <20121016133045.GA12766@redhat.com>
References: <874nmajcmj.fsf@codemonkey.ws> <87y5jhpuu2.fsf@rustcorp.com.au>
	<20121010083033.GA4799@redhat.com> <87bog9957l.fsf@rustcorp.com.au>
	<20121011102333.GA5552@redhat.com> <87391k7icv.fsf@rustcorp.com.au>
	<20121012093330.GA32014@redhat.com>
	<871uh4587d.fsf@rustcorp.com.au>
	<20121012100231.GA32517@redhat.com>
	<87k3uqpngi.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87k3uqpngi.fsf@rustcorp.com.au>
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

On Tue, Oct 16, 2012 at 11:45:41PM +1030, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > On Fri, Oct 12, 2012 at 08:21:50PM +1030, Rusty Russell wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> > On Fri, Oct 12, 2012 at 08:59:36AM +1030, Rusty Russell wrote:
> >> >> >> For writes, the standard seems to be a commit latch.  We could abuse the
> >> >> >> generation count for this: the driver writes to it to commit config
> >> >> >> changes.
> >> >> >
> >> >> > I think this will work. There are a couple of things that bother me:
> >> >> >
> >> >> > This assumes read accesses have no side effects, and these are sometimes handy.
> >> >> > Also the semantics for write aren't very clear to me.
> >> >> > I guess device must buffer data until generation count write?
> >> >> > This assumes the device has a buffer to store writes,
> >> >> > and it must track each byte written. I kind of dislike this
> >> >> > tracking of accessed bytes. Also, device would need to resolve conflicts
> >> >> > if any in some device specific way.
> >> >> 
> >> >> It should be trivial to implement: you keep a scratch copy of the config
> >> >> space, and copy it to the master copy when they hit the latch.
> >> >> 
> >> >> Implementation of this will show whether I've missed anything here, I
> >> >> think.
> >> >
> >> > What I refer to: what happens if driver does:
> >> > - write offset 1
> >> > - write offset 3
> >> > - hit commit latch
> >> 
> >> - nothing
> >> - nothing
> >> - effect of offset 1 and offset 3 writes
> >
> > OK so this means that you also need to track which bytes where written
> > in order to know to skip byte 2.
> > This is what I referred to. If instead we ask driver to specify
> > offset/length explicitly device only needs to remember that.
> 
> I was assuming the implementation would keep two complete copies of the
> config space: writes go to the scratch version, which gets copied to the
> master version upon latch write.

Yes but config space has some host modifiable registers too.
So host needs to be careful to avoid overwriting these.

If accesses have side effects that of course breaks too ...

> But I do wonder if we should just skip this for now, since we don't
> have any immediate need.
> 
> Cheers,
> Rusty.

MAC setting from guest needs this right now, no?

-- 
MST
