From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 01/34] Documentation/memory-barriers.txt: document
	__smb_mb()
Date: Mon, 4 Jan 2016 13:27:36 +0200
Message-ID: <20160104132634-mutt-send-email-mst__48784.2050767087$1451906879$gmane$org@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
	<1451473761-30019-2-git-send-email-mst@redhat.com>
	<alpine.DEB.2.02.1601041104290.19710@kaball.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1601041104290.19710@kaball.uk.xensource.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 04, 2016 at 11:08:19AM +0000, Stefano Stabellini wrote:
> On Wed, 30 Dec 2015, Michael S. Tsirkin wrote:
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  Documentation/memory-barriers.txt | 33 ++++++++++++++++++++++++++++-----
> >  1 file changed, 28 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > index aef9487..a20f7ef 100644
> > --- a/Documentation/memory-barriers.txt
> > +++ b/Documentation/memory-barriers.txt
> > @@ -1655,17 +1655,18 @@ macro is a good place to start looking.
> >  SMP memory barriers are reduced to compiler barriers on uniprocessor compiled
> >  systems because it is assumed that a CPU will appear to be self-consistent,
> >  and will order overlapping accesses correctly with respect to itself.
> > +However, see the subsection on "Virtual Machine Guests" below.
> >  
> >  [!] Note that SMP memory barriers _must_ be used to control the ordering of
> >  references to shared memory on SMP systems, though the use of locking instead
> >  is sufficient.
> >  
> >  Mandatory barriers should not be used to control SMP effects, since mandatory
> > -barriers unnecessarily impose overhead on UP systems. They may, however, be
> > -used to control MMIO effects on accesses through relaxed memory I/O windows.
> > -These are required even on non-SMP systems as they affect the order in which
> > -memory operations appear to a device by prohibiting both the compiler and the
> > -CPU from reordering them.
> > +barriers impose unnecessary overhead on both SMP and UP systems. They may,
> > +however, be used to control MMIO effects on accesses through relaxed memory I/O
> > +windows.  These barriers are required even on non-SMP systems as they affect
> > +the order in which memory operations appear to a device by prohibiting both the
> > +compiler and the CPU from reordering them.
> >  
> >  
> >  There are some more advanced barrier functions:
> > @@ -2948,6 +2949,28 @@ The Alpha defines the Linux kernel's memory barrier model.
> >  
> >  See the subsection on "Cache Coherency" above.
> >  
> > +VIRTUAL MACHINE GUESTS
> > +-------------------
> > +
> > +Guests running within virtual machines might be affected by
> > +SMP effects even if the guest itself is compiled within
> 
>                                                     ^ without

Right - this is fixed in v2.
Could you review that one please?

> > +SMP support.
> > +
> > +This is an artifact of interfacing with an SMP host while
> > +running an UP kernel.
> > +
> > +Using mandatory barriers for this use-case would be possible
> > +but is often suboptimal.
> > +
> > +To handle this case optimally, low-level __smp_mb() etc macros are available.
> > +These have the same effect as smp_mb() etc when SMP is enabled, but generate
> > +identical code for SMP and non-SMP systems. For example, virtual machine guests
> > +should use __smp_mb() rather than smp_mb() when synchronizing against a
> > +(possibly SMP) host.
> > +
> > +These are equivalent to smp_mb() etc counterparts in all other respects,
> > +in particular, they do not control MMIO effects: to control
> > +MMIO effects, use mandatory barriers.
> >  
> >  ============
> >  EXAMPLE USES
> > -- 
> > MST
> > 
