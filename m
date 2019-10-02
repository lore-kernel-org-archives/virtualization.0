From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: DANGER WILL ROBINSON, DANGER
Date: Wed, 2 Oct 2019 13:04:29 -0400
Message-ID: <20191002170429.GA8189@redhat.com>
References: <20190815191929.GA9253@redhat.com>
	<20190815201630.GA25517@redhat.com>
	<VI1PR02MB398411CA9A56081FF4D1248EBBA40@VI1PR02MB3984.eurprd02.prod.outlook.com>
	<20190905180955.GA3251@redhat.com>
	<5b0966de-b690-fb7b-5a72-bc7906459168@redhat.com>
	<DB7PR02MB3979D1143909423F8767ACE2BBB60@DB7PR02MB3979.eurprd02.prod.outlook.com>
	<20191002192714.GA5020@redhat.com>
	<ab461f02-e6cd-de0f-b6ce-0f5a95798eaa@redhat.com>
	<20191002141542.GA5669@redhat.com>
	<f26710a4-424f-730c-a676-901bae451409@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <f26710a4-424f-730c-a676-901bae451409@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C <yu.c.zhang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel =?iso-8859-1?Q?Laur=E9n?= <samuel.lauren@iki.fi>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Matthew Wilcox <willy@infradead.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>, Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 02, 2019 at 06:18:06PM +0200, Paolo Bonzini wrote:
> On 02/10/19 16:15, Jerome Glisse wrote:
> >>> Why would you need to target mmu notifier on target vma ?
> >> If the mapping of the source VMA changes, mirroring can update the
> >> target VMA via insert_pfn.  But what ensures that KVM's MMU notifier
> >> dismantles its own existing page tables (so that they can be recreated
> >> with the new mapping from the source VMA)?
> >>
> > So just to make sure i follow we have:
> >       - qemu process on host with anonymous vma
> >             -> host cpu page table
> >       - kvm which maps host anonymous vma to guest
> >             -> kvm guest page table
> >       - kvm inspector process which mirror vma from qemu process
> >             -> inspector process page table
> > =

> > AFAIK the KVM notifier's will clear the kvm guest page table whenever
> > necessary (through kvm_mmu_notifier_invalidate_range_start). This is
> > what ensure that KVM's dismatles its own mapping, it abides to mmu-
> > notifier callbacks. If you did not you would have bugs (at least i
> > expect so). Am i wrong here ?
> =

> The KVM inspector process is also (or can be) a QEMU that will have to
> create its own KVM guest page table.

Ok missed that part, thank you for explaining

> =

> So if a page in the source VMA is unmapped we want:
> =

> - the source KVM to invalidate its guest page table (done by the KVM MMU
> notifier)
> =

> - the target VMA to be invalidated (easy using mirroring)
> =

> - the target KVM to invalidate its guest page table, as a result of
> invalidation of the target VMA

You can do the target KVM invalidation inside the mirroring invalidation
code.

Cheers,
J=E9r=F4me
