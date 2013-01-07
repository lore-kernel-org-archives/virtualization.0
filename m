From: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: [Xen-devel] [PATCH v3 00/11] xen: Initial kexec/kdump
	implementation
Date: Mon, 7 Jan 2013 10:25:50 +0000
Message-ID: <1357554350.14291.134.camel__48788.8114563704$1357554386$gmane$org@zakaz.uk.xensource.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
	<50DBC856.6030208@zytor.com>
	<791b4922-078f-4adc-b3f3-0651f2266147@email.android.com>
	<50DC58C4.3000307@citrix.com> <874nj7qsor.fsf@xmission.com>
	<50E41973.9050705@citrix.com>
	<20130104142257.GC3346@host-192-168-1-59.local.net-space.pl>
	<50E6F81D02000078000B3245@nat28.tlf.novell.com>
	<20130104170751.GB3472@host-192-168-1-59.local.net-space.pl>
	<20130104191146.GC6721@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130104191146.GC6721@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Andrew Cooper <Andrew.Cooper3@citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, "maxim.uvarov@oracle.com" <maxim.uvarov@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2013-01-04 at 19:11 +0000, Konrad Rzeszutek Wilk wrote:
> On Fri, Jan 04, 2013 at 06:07:51PM +0100, Daniel Kiper wrote:
> > On Fri, Jan 04, 2013 at 02:41:17PM +0000, Jan Beulich wrote:
> > > >>> On 04.01.13 at 15:22, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> > > > On Wed, Jan 02, 2013 at 11:26:43AM +0000, Andrew Cooper wrote:
> > > >> /sbin/kexec can load the "Xen" crash kernel itself by issuing
> > > >> hypercalls using /dev/xen/privcmd.  This would remove the need for
> > > >> the dom0 kernel to distinguish between loading a crash kernel for
> > > >> itself and loading a kernel for Xen.
> > > >>
> > > >> Or is this just a silly idea complicating the matter?
> > > >
> > > > This is impossible with current Xen kexec/kdump interface.
> > >
> > > Why?
> > 
> > Because current KEXEC_CMD_kexec_load does not load kernel
> > image and other things into Xen memory. It means that it
> > should live somewhere in dom0 Linux kernel memory.
> 
> We could have a very simple hypercall which would have:
> 
> struct fancy_new_hypercall {
> 	xen_pfn_t payload; // IN

This would have to be XEN_GUEST_HANDLE(something) since userspace cannot
figure out what pfns back its memory. In any case since the hypervisor
is going to want to copy the data into the crashkernel space a virtual
address is convenient to have.

> 	ssize_t len; // IN
> #define DATA (1<<1)
> #define DATA_EOF (1<<2)
> #define DATA_KERNEL (1<<3)
> #define DATA_RAMDISK (1<<4)
> 	unsigned int flags; // IN
> 	unsigned int status; // OUT
> };
> 
> which would in a loop just iterate over the payloads and
> let the hypervisor stick it in the crashkernel space.
> 
> This is all hand-waving of course. There probably would be a need
> to figure out how much space you have in the reserved Xen's
> 'crashkernel' memory region too.

This is probably a mad idea but it's Monday morning and I'm sleep
deprived so I'll throw it out there...

What about adding DOMID_KEXEC (similar DOMID_IO etc)? This would allow
dom0 to map the kexec memory space with the usual privcmd mmap
hypercalls and build things in it directly.

OK, I suspect this might not be practical for a variety of reasons (lack
of a p2m for such domains so no way to find out the list of mfns, dom0
userspace simply doesn't have sufficient context to write sensible
things here, etc) but maybe someone has a better head on today...

Ian.
