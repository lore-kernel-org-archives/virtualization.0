From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Using PCI config space to indicate config location
Date: Wed, 10 Oct 2012 10:30:33 +0200
Message-ID: <20121010083033.GA4799@redhat.com>
References: <87zk4c2tqq.fsf@rustcorp.com.au> <874nmajcmj.fsf@codemonkey.ws>
	<87y5jhpuu2.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87y5jhpuu2.fsf@rustcorp.com.au>
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

On Mon, Oct 08, 2012 at 12:51:25PM +1030, Rusty Russell wrote:
> (Topic updated, cc's trimmed).
> 
> Anthony Liguori <aliguori@us.ibm.com> writes:
> > Rusty Russell <rusty@rustcorp.com.au> writes:
> >> 4) The only significant change to the spec is that we use PCI
> >>    capabilities, so we can have infinite feature bits.
> >>    (see http://lists.linuxfoundation.org/pipermail/virtualization/2011-December/019198.html)
> >
> > We discussed this on IRC last night.  I don't think PCI capabilites are
> > a good mechanism to use...
> >
> > PCI capabilities are there to organize how the PCI config space is
> > allocated to allow vendor extensions to co-exist with future PCI
> > extensions.
> >
> > But we've never used the PCI config space within virtio-pci.  We do
> > everything in BAR0.  I don't think there's any real advantage of using
> > the config space vs. a BAR for virtio-pci.
> 
> Note before anyone gets confused; we were talking about using the PCI
> config space to indicate what BAR(s) the virtio stuff is in.  An
> alternative would be to simply specify a new layout format in BAR1.

One problem we are still left with is this: device specific
config accesses are still non atomic.
This is a problem for multibyte fields such as MAC address
where MAC could change while we are accessing it.

I was thinking about some backwards compatible way to solve this, but if
we are willing to break compatiblity or use some mode switch, how about
we give up on virtio config space completely, and do everything besides
IO and ISR through guest memory?

-- 
MST
