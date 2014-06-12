From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Using virtio for inter-VM communication
Date: Thu, 12 Jun 2014 11:57:07 +0930
Message-ID: <87r42uq2v8.fsf@rustcorp.com.au>
References: <20140610184818.2e490419@nbschild1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140610184818.2e490419@nbschild1>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: Henning Schild <henning.schild@siemens.com>
List-Id: virtualization@lists.linuxfoundation.org

Henning Schild <henning.schild@siemens.com> writes:
> Hi,
>
> i am working on the jailhouse[1] project and am currently looking at
> inter-VM communication. We want to connect guests directly with virtual
> consoles based on shared memory. The code complexity in the hypervisor
> should be minimal, it should just make the shared memory discoverable
> and provide a signaling mechanism.

Hi Henning,

        The virtio assumption was that the host can see all of guest
memory.  This simplifies things significantly, and makes it efficient.

If you don't have this, *someone* needs to do a copy.  Usually the guest
OS does a bounce buffer into your shared region.  Goodbye performance.
Or you can play remapping tricks.  Goodbye performance again.

My preferred model is to have a trusted helper (ie. host) which
understands how to copy between virtio rings.  The backend guest (to
steal Xen vocab) R/O maps the descriptor, avail ring and used rings in
the guest.  It then asks the trusted helper to do various operation
(copy into writable descriptor, copy out of readable descriptor, mark
used).  The virtio ring itself acts as a grant table.

Note: that helper mechanism is completely protocol agnostic.  It was
also explicitly designed into the virtio mechanism (with its 4k
boundaries for data structures and its 'len' field to indicate how much
was written into the descriptor). 

It was also never implemented, and remains a thought experiment.
However, implementing it in lguest should be fairly easy.

Cheers,
Rusty.
