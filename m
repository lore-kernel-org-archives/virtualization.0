From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [RFC qemu 0/4] A PV solution for live migration optimization
Date: Tue, 8 Mar 2016 13:11:30 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E0414811E__29407.959993887$1457442820$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
	<20160308111343.GM15443@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160308111343.GM15443@grmbl.mre>
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
To: Amit Shah <amit.shah@redhat.com>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

> Subject: Re: [RFC qemu 0/4] A PV solution for live migration optimization
> 
> On (Thu) 03 Mar 2016 [18:44:24], Liang Li wrote:
> > The current QEMU live migration implementation mark the all the
> > guest's RAM pages as dirtied in the ram bulk stage, all these pages
> > will be processed and that takes quit a lot of CPU cycles.
> >
> > From guest's point of view, it doesn't care about the content in free
> > pages. We can make use of this fact and skip processing the free pages
> > in the ram bulk stage, it can save a lot CPU cycles and reduce the
> > network traffic significantly while speed up the live migration
> > process obviously.
> >
> > This patch set is the QEMU side implementation.
> >
> > The virtio-balloon is extended so that QEMU can get the free pages
> > information from the guest through virtio.
> >
> > After getting the free pages information (a bitmap), QEMU can use it
> > to filter out the guest's free pages in the ram bulk stage. This make
> > the live migration process much more efficient.
> >
> > This RFC version doesn't take the post-copy and RDMA into
> > consideration, maybe both of them can benefit from this PV solution by
> > with some extra modifications.
> 
> I like the idea, just have to prove (review) and test it a lot to ensure we don't
> end up skipping pages that matter.
> 
> However, there are a couple of points:
> 
> In my opinion, the information that's exchanged between the guest and the
> host should be exchanged over a virtio-serial channel rather than virtio-
> balloon.  First, there's nothing related to the balloon here.
> It just happens to be memory info.  Second, I would never enable balloon in
> a guest that I want to be performance-sensitive.  So even if you add this as
> part of balloon, you'll find no one is using this solution.
> 
> Secondly, I suggest virtio-serial, because it's meant exactly to exchange free-
> flowing information between a host and a guest, and you don't need to
> extend any part of the protocol for it (hence no changes necessary to the
> spec).  You can see how spice, vnc, etc., use virtio-serial to exchange data.
> 
> 
> 		Amit

I don't like to use the virtio-balloon too, and it's confusing. 
It's grate if the virtio-serial can be used, I will take a look at it. 

Thanks for your suggestion!

Liang
