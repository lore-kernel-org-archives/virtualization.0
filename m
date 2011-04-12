From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [RFC][PATCH] virtio balloon: kill tell-host-first logic
Date: Tue, 12 Apr 2011 22:13:42 +0530
Message-ID: <20110412164341.GQ13631__48629.0901819759$1302626761$gmane$org@amit-x200.redhat.com>
References: <20110407174325.ED21C82B@kernel>
	<20110411110131.GA23123@redhat.com>
	<1302559871.7286.16749.camel@nimitz>
	<20110412054330.GH26678@amit-x200.redhat.com>
	<1302625352.8321.2126.camel@nimitz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1302625352.8321.2126.camel@nimitz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: Anthony Liguori <aliguori@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) 12 Apr 2011 [09:22:32], Dave Hansen wrote:
> On Tue, 2011-04-12 at 11:13 +0530, Amit Shah wrote:
> > Sure, the only contention was on the commit message, where you stated
> > modern qemus set this... qemu doesn't, and it should.  Care to do a
> > patch for that? 
> 
> If Rusty hasn't pushed the commit out anywhere, we can still amend the
> commit.  Otherwise, we're in a _bit_ of a pickle since you can't patch
> git logs. :)

I should've been clearer: care to do the qemu patch? :-)

> Whatever is easiest for Rusty works for me.  
> 
> How about this for a replacement log?
> 
> --
> 
> The virtio balloon driver has a VIRTIO_BALLOON_F_MUST_TELL_HOST
> feature bit.  Whenever the bit is set, we must always tell the
> host before we free pages back to the allocator.  Without this
> feature, we might free a page (and have another user touch it)
> while the hypervisor is unprepared for it.
> 
> But, if the bit is _not_ set, we are under no obligation to
> reverse the order; we're under no obligation to do _anything_.
> That's the state of affairs in current qemu:
> 
> 	#define VIRTIO_BALLOON_F_MUST_TELL_HOST 0

Actually this is just the bit number; it doesn't get set.

		Amit
