From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Mon, 06 Aug 2018 07:30:54 +1000
Message-ID: <00113a1e9ec3e111ee4e12d682168142dcbbcf61.camel@kernel.crashing.org>
References: <20180802200646-mutt-send-email-mst@kernel.org>
	<e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
	<20180802225738-mutt-send-email-mst@kernel.org>
	<de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
	<20180803070507.GA1344@infradead.org>
	<eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
	<20180803160246.GA13794@infradead.org>
	<22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
	<20180804082120.GB4421@infradead.org>
	<a3ec0a454928e880dabc3782ea906e318634abf9.camel@kernel.crashing.org>
	<20180805072930.GB23288@infradead.org>
	<b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, mpe@ellerman.id.au, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, paulus@samba.org, marc.zyngier@arm.com, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2018-08-06 at 07:16 +1000, Benjamin Herrenschmidt wrote:
> I'm trying to understand because the limitation is not a device side
> limitation, it's not a qemu limitation, it's actually more of a VM
> limitation. It has most of its memory pages made inaccessible for
> security reasons. The platform from a qemu/KVM perspective is almost
> entirely normal.

In fact this is probably the best image of what's going on:

It's a normal VM from a KVM/qemu perspective (and thus virtio). It
boots normally, can run firmware, linux, etc... normally, it's not
created with any different XML or qemu command line definition etc...

It just that once it reaches the kernel with the secure stuff enabled
(could be via kexec from a normal kernel), that kernel will "stash
away" most of the VM's memory into some secure space that nothing else
(not even the hypervisor) can access.

It can keep around a pool or two of normal memory for bounce buferring
IOs but that's about it.

I think that's the clearest way I could find to explain what's going
on, and why I'm so resistant on adding things on qemu side.

That said, we *can* (and will) notify KVM and qemu of the transition,
and we can/will do so after virtio has been instanciated and used by
the bootloader, but before it will be used (or even probed) by the
secure VM itself, so there's an opportunity to poke at things, either
from the VM itself (a quirk poking at virtio config space for example)
or from qemu (though I find the idea of iterating all virtio devices
from qemu to change a setting rather gross).

Cheers,
Ben.
