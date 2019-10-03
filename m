From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: DANGER WILL ROBINSON, DANGER
Date: Thu, 3 Oct 2019 14:31:08 -0400
Message-ID: <20191003183108.GA3557@redhat.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <DB7PR02MB39796440DC81A5B53E86F029BB9F0@DB7PR02MB3979.eurprd02.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C <yu.c.zhang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel =?iso-8859-1?Q?Laur=E9n?= <samuel.lauren@iki.fi>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Matthew Wilcox <willy@infradead.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 03, 2019 at 04:42:20PM +0000, Mircea CIRJALIU - MELIU wrote:
> > On 03/10/19 17:42, Jerome Glisse wrote:
> > > All that is needed is to make sure that vm_normal_page() will see
> > > those pte (inside the process that is mirroring the other process) as
> > > special which is the case either because insert_pfn() mark the pte as
> > > special or the kvm device driver which control the vm_operation struct
> > > set a
> > > find_special_page() callback that always return NULL, or the vma has
> > > either VM_PFNMAP or VM_MIXEDMAP set (which is the case with
> > insert_pfn).
> > >
> > > So you can keep the existing kvm code unmodified.
> > =

> > Great, thanks.  And KVM is already able to handle
> > VM_PFNMAP/VM_MIXEDMAP, so that should work.
> =

> This means setting VM_PFNMAP/VM_MIXEDMAP on the anon VMA that acts as the=
 VM's system RAM.
> Will it have any side effects?

You do not set it up on the anonymous vma but on the mmap of the
kvm device file, the resulting vma is under the control of the
kvm device file and is not an anonymous vma but a "device" special
vma.

So in summary, the source qemu process has anonymous vma (regular
libc malloc for instance). The introspector qemu process which
mirror the the source qemu use mmap on /dev/kvm (assuming you can
reuse the kvm device file for this otherwise you can introduce a
new kvm device file). The resulting mmap inside the introspector
qemu process is a vma which has vma->vm_file pointing to the kvm
device file and has VM_PFNMAP or VM_MIXEDMAP (i think you want the
former). On architecture with ARCH_SPECIAL_PTE the pte will be
mark as special when using insert_pfn() on other architecture you
can either rely on VM_PFNMAP/VM_MIXEDMAP flag or set a specific
find_special_page() callbacks in vm_ops.


I am at a conference right now but i will put an example of what
i mean next week.

Cheers,
J=E9r=F4me
