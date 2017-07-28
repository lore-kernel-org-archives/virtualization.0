From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC] virtio-mem: paravirtualized memory
Date: Fri, 28 Jul 2017 08:16:11 -0700
Message-ID: <CAPcyv4iYdEAv7wqun5L1C-gT7fMDpO+M918or-bg5XiWLnM3=w__21813.7007243515$1501254980$gmane$org@mail.gmail.com>
References: <547865a9-d6c2-7140-47e2-5af01e7d761d@redhat.com>
	<0a7cd2a8-45ff-11d1-ddb5-036ce36af163@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0a7cd2a8-45ff-11d1-ddb5-036ce36af163@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Hildenbrand <david@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Rik van Riel <riel@redhat.com>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 28, 2017 at 4:09 AM, David Hildenbrand <david@redhat.com> wrote:
> Btw, I am thinking about the following addition to the concept:
>
> 1. Add a type to each virtio-mem device.
>
> This describes the type of the memory region we expose to the guest.
> Initially, we could have RAM and RAM_HUGE. The latter one would be
> interesting, because the guest would know that this memory is based on
> huge pages in case we would ever want to expose different RAM types to a
> guest (the guest could conclude that this memory might be faster and
> would also best be used with huge pages in the guest). But we could also
> simply start only with RAM.

I think it's up to the hypervisor to manage whether the guest is
getting huge pages or not and the guest need not know. As for
communicating differentiated memory media performance we have the ACPI
HMAT (Heterogeneous Memory Attributes Table) for that.

> 2. Adding also a guest -> host command queue.
>
> That can be used to request/notify the host about something. As written
> in the original proposal, for ordinary RAM this could be used to request
> more/less memory out of the guest.

I would hope that where possible we minimize paravirtualized
interfaces and just use standardized interfaces. In the case of memory
hotplug, ACPI already defines that interface.

> This might come in handy for other memory regions we just want to expose
> to the guest via a paravirtualized interface. The resize features
> (adding/removing memory) might not apply to these, but we can simply
> restrict that to certain types.
>
> E.g. if we want to expose PMEM memory region to a guest using a
> paravirtualized interface (or anything else that can be mapped into
> guest memory in the form of memory regions), we could use this. The
> guest->host control queue can be used for tasks that typically cannot be
> done if moddeling something like this using ordinary ACPI DIMMs
> (flushing etc).
>
> CCing a couple of people that just thought about something like this in
> the concept of fake DAX.

I'm not convinced that there is a use case for paravirtualized PMEM
commands beyond this "fake-DAX" use case. Everything would seem to
have a path through the standard ACPI platform communication
mechanisms.
