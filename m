From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [Qemu-devel] [RFC qemu 0/4] A PV solution for live migration
	optimization
Date: Fri, 4 Mar 2016 08:23:09 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E037714DA@SHSMSX101.ccr.corp.intel.com>
References: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
	<20160303174615.GF2115@work-vm> <20160304075538.GC9100@rkaganb.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160304075538.GC9100@rkaganb.sw.ru>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Roman Kagan <rkagan@virtuozzo.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "rth@twiddle.net" <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

> On Thu, Mar 03, 2016 at 05:46:15PM +0000, Dr. David Alan Gilbert wrote:
> > * Liang Li (liang.z.li@intel.com) wrote:
> > > The current QEMU live migration implementation mark the all the
> > > guest's RAM pages as dirtied in the ram bulk stage, all these pages
> > > will be processed and that takes quit a lot of CPU cycles.
> > >
> > > From guest's point of view, it doesn't care about the content in
> > > free pages. We can make use of this fact and skip processing the
> > > free pages in the ram bulk stage, it can save a lot CPU cycles and
> > > reduce the network traffic significantly while speed up the live
> > > migration process obviously.
> > >
> > > This patch set is the QEMU side implementation.
> > >
> > > The virtio-balloon is extended so that QEMU can get the free pages
> > > information from the guest through virtio.
> > >
> > > After getting the free pages information (a bitmap), QEMU can use it
> > > to filter out the guest's free pages in the ram bulk stage. This
> > > make the live migration process much more efficient.
> >
> > Hi,
> >   An interesting solution; I know a few different people have been
> > looking at how to speed up ballooned VM migration.
> >
> >   I wonder if it would be possible to avoid the kernel changes by
> > parsing /proc/self/pagemap - if that can be used to detect
> > unmapped/zero mapped pages in the guest ram, would it achieve the
> same result?
> 
> Yes I was about to suggest the same thing: it's simple and makes use of the
> existing infrastructure.  And you wouldn't need to care if the pages were
> unmapped by ballooning or anything else (alternative balloon
> implementations, not yet touched by the guest, etc.).  Besides, you wouldn't
> need to synchronize with the guest.
> 
> Roman.

The unmapped/zero mapped pages can be detected by parsing /proc/self/pagemap,
but the free pages can't be detected by this. Imaging an application allocates a large amount
of memory , after using, it frees the memory, then live migration happens. All these free pages
will be process and sent to the destination, it's not optimal.

Liang
