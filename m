From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: DANGER WILL ROBINSON, DANGER
Date: Fri, 4 Oct 2019 13:46:57 +0200
Message-ID: <7ccbc431-0ca6-0049-fe60-ad232c628209@redhat.com>
References: <DB7PR02MB3979D1143909423F8767ACE2BBB60@DB7PR02MB3979.eurprd02.prod.outlook.com>
	<20191002192714.GA5020@redhat.com>
	<ab461f02-e6cd-de0f-b6ce-0f5a95798eaa@redhat.com>
	<20191002141542.GA5669@redhat.com>
	<f26710a4-424f-730c-a676-901bae451409@redhat.com>
	<20191002170429.GA8189@redhat.com>
	<dd0ca0d3-f502-78a1-933a-7e1b5fb90baa@redhat.com>
	<20191003154233.GA4421@redhat.com>
	<d62a6720-e069-4e03-6a3a-798c020786f7@redhat.com>
	<DB7PR02MB39796440DC81A5B53E86F029BB9F0@DB7PR02MB3979.eurprd02.prod.outlook.com>
	<20191003183108.GA3557@redhat.com>
	<afe2cf69-5c2c-95af-88ce-f3814fece2e2@redhat.com>
	<DB7PR02MB39795E622880231C8F8A6478BB9E0@DB7PR02MB3979.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <DB7PR02MB39795E622880231C8F8A6478BB9E0@DB7PR02MB3979.eurprd02.prod.outlook.com>
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
To: Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>, Jerome Glisse <jglisse@redhat.com>
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C <yu.c.zhang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Samuel_Laur=c3=a9n?= <samuel.lauren@iki.fi>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Matthew Wilcox <willy@infradead.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, =?UTF-8?Q?Adalbert_Laz=c4=83r?= <alazar@bitdefender.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Mihai_Don=c8=9bu?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/10/19 11:41, Mircea CIRJALIU - MELIU wrote:
> I get it so far. I have a patch that does mirroring in a separate VMA.
> We create an extra VMA with VM_PFNMAP/VM_MIXEDMAP that mirrors the 
> source VMA in the other QEMU and is refreshed by the device MMU notifier.

So for example on the host you'd have a new ioctl on the kvm file
descriptor.  You pass a size and you get back a file descriptor for that
guest's physical memory, which is mmap-able up to the size you specified
in the ioctl.

In turn, the file descriptor would have ioctls to map/unmap ranges of
the guest memory into its mmap-able range.  Accessing an unmapped range
produces a SIGSEGV.

When asked via the QEMU monitor, QEMU will create the file descriptor
and pass it back via SCM_RIGHTS.  The management application can then
use it to hotplug memory into the destination...

> Create a new memslot based on the mirror VMA, hotplug it into the guest as
> new memory device (is this possible?) and have a guest-side driver allocate 
> pages from that area.

... using the existing ivshmem device, whose BAR can be accessed and
mmap-ed from the guest via sysfs.  In other words, the hotplugging will
use the file descriptor returned by QEMU when creating the ivshmem device.

We then need an additional mechanism to invoke the map/unmap ioctls from
the guest.  Without writing a guest-side driver it is possible to:

- pass a socket into the "create guest physical memory view" ioctl
above.  KVM will then associate that KVMI socket with the newly created
file descriptor.

- use KVMI messages to that socket to map/unmap sections of memory

> Redirect (some) GFN->HVA translations into the new VMA based on a table 
> of addresses required by the introspector process.

That would be tricky because there are multiple paths (gfn_to_page,
gfn_to_pfn, etc.).

There is some complication in this because the new device has to be
plumbed at multiple levels (KVM, QEMU, libvirt).  But it seems like a
very easily separated piece of code (except for the KVMI socket part,
which can be added later), so I suggest that you contribute the KVM
parts first.

Paolo
