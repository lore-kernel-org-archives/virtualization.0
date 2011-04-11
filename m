From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH] virtio balloon: kill tell-host-first logic
Date: Mon, 11 Apr 2011 15:11:11 -0700
Message-ID: <1302559871.7286.16749.camel__41629.1315145374$1302560032$gmane$org@nimitz>
References: <20110407174325.ED21C82B@kernel>
	<20110411110131.GA23123@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110411110131.GA23123@redhat.com>
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
Cc: Anthony Liguori <aliguori@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2011-04-11 at 14:01 +0300, Michael S. Tsirkin wrote:
> On Thu, Apr 07, 2011 at 10:43:25AM -0700, Dave Hansen wrote:
> > The virtio balloon driver has a VIRTIO_BALLOON_F_MUST_TELL_HOST
> > feature bit.  Whenever the bit is set, we must always tell the
> > host before we free pages back to the allocator.  Without this
> > we might free a page (and have another user touch it) while the
> > hypervisor is unprepared for it.
> > 
> > But, if the bit is _not_ set, we are under no obligation to
> > reverse the order.  Furthermore, all modern qemus set this bit.
> 
> Which qemus do this, specifically?  Amit Shah just pointed out to me
> that upstream qemu.git and qemu-kvm.git don't seem to do this.

I had a conversation with Anthony about it, and I think I managed to
confuse myself somewhere.  Just to be clear, all that I see in the
qemu-kvm git tree right now (df85c051d780bca0ee2462cfeb8ef6d9552a19b0)
is this:

hw/virtio-balloon.h:#define VIRTIO_BALLOON_F_MUST_TELL_HOST 0 /* Tell before reclaiming pages */

> Which qemu did you test this with? 

Probably a week or two old qemu-kvm.

My changelog could probably use some work, but the patch still stands.
The only requirement we have is that when
VIRTIO_BALLOON_F_MUST_TELL_HOST is set we *MUST* tell the host, first.
But, when it's not set, we can do whatever we want.

So, we might as well always have the ...F_MUST_TELL_HOST behavior all
the time.  

-- Dave
