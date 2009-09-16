From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Wed, 16 Sep 2009 19:08:30 +0300
Message-ID: <20090916160829.GA6034__6506.2511749149$1253118161$gmane$org@redhat.com>
References: <20090914164750.GB3745@redhat.com>
	<200909161657.42628.arnd@arndb.de>
	<20090916151329.GC5513@redhat.com>
	<200909161722.37606.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200909161722.37606.arnd@arndb.de>
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
Cc: kvm@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, Avi Kivity <avi@redhat.com>, hpa@zytor.com, mingo@elte.hu, alacrityvm-devel@lists.sourceforge.net, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 16, 2009 at 05:22:37PM +0200, Arnd Bergmann wrote:
> On Wednesday 16 September 2009, Michael S. Tsirkin wrote:
> > On Wed, Sep 16, 2009 at 04:57:42PM +0200, Arnd Bergmann wrote:
> > > On Tuesday 15 September 2009, Michael S. Tsirkin wrote:
> > > > Userspace in x86 maps a PCI region, uses it for communication with ppc?
> > > 
> > > This might have portability issues. On x86 it should work, but if the
> > > host is powerpc or similar, you cannot reliably access PCI I/O memory
> > > through copy_tofrom_user but have to use memcpy_toio/fromio or readl/writel
> > > calls, which don't work on user pointers.
> > > 
> > > Specifically on powerpc, copy_from_user cannot access unaligned buffers
> > > if they are on an I/O mapping.
> > > 
> > We are talking about doing this in userspace, not in kernel.
> 
> Ok, that's fine then. I thought the idea was to use the vhost_net driver

It's a separate issue. We were talking generally about configuration
and setup. Gregory implemented it in kernel, Avi wants it
moved to userspace, with only fastpath in kernel.

> to access the user memory, which would be a really cute hack otherwise,
> as you'd only need to provide the eventfds from a hardware specific
> driver and could use the regular virtio_net on the other side.
> 
> 	Arnd <><

To do that, maybe copy to user on ppc can be fixed, or wrapped
around in a arch specific macro, so that everyone else
does not have to go through abstraction layers.

-- 
MST
