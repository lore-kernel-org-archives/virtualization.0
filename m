From: "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: RE: [RFC] CPUID usage for interaction between Hypervisors	and	Linux.
Date: Fri, 3 Oct 2008 15:33:30 -0700
Message-ID: <0B53E02A2965CE4F9ADB38B34501A3A15DCBA221__44578.4770105549$1223073366$gmane$org@orsmsx505.amr.corp.intel.com>
References: <1222881242.9381.17.camel@alok-dev1>
	<48E3B19D.6060905@zytor.com> <1222882431.9381.23.camel@alok-dev1>
	<48E3BC21.4080803@goop.org> <1222895153.9381.69.camel@alok-dev1>
	<48E3FDD5.7040106@zytor.com>
	<0B53E02A2965CE4F9ADB38B34501A3A15D927EA4@orsmsx505.amr.corp.intel.com>
	<48E422CA.2010606@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48E422CA.2010606@zytor.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: the arch/x86 maintainers <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "akataria@vmware.com" <akataria@vmware.com>, Ingo Molnar <mingo@elte.hu>, "avi@redhat.com" <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10/1/2008 6:24:26 PM, H. Peter Anvin wrote:
> Nakajima, Jun wrote:
> > >
> > > All I have seen out of Microsoft only covers CPUID levels
> > > 0x40000000 as an vendor identification leaf and 0x40000001 as a
> > > "hypervisor identification leaf", but you might have access to other information.
> >
> > No, it says "Leaf 0x40000001 as hypervisor vendor-neutral interface
> > identification, which determines the semantics of leaves from
> > 0x40000002 through 0x400000FF." The Leaf 0x40000000 returns vendor
> > identifier signature (i.e. hypervisor identification) and the
> > hypervisor CPUID leaf range, as in the proposal.
> >
>

Resuming the thread :-)

> In other words, 0x40000002+ is vendor-specific space, based on the
> hypervisor specified in 0x40000001 (in theory); in practice both
> 0x40000000:0x40000001 since M$ seem to use clever identifiers as
> "Hypervisor 1".

What it means their hypervisor returns the interface signature (i.e. "Hv#1"), and that defines the interface. If we use "Lv_1", for example, we can define the interface 0x40000002 through 0x400000FF for Linux. Since leaf 0x40000000 and 0x40000001 are separate, we can decouple the hypervisor vender from the interface it supports. This also allows a hypervisor to support multiple interfaces.

And whether a guest wants to use the interface without checking the vender id is a different thing. For Linux, we don't want to hardcode the vender ids in the upstream code at least for such a generic interface.

So I think we need to modify the proposal:

Hypervisor interface identification Leaf:
        Leaf 0x40000001.

        This leaf returns the interface signature that the hypervisor implements.
        # EAX: "Lv_1" (or something)
        # EBX, ECX, EDX: Reserved.

Lv_1 interface Leaves:
        Leaf range 0x40000002 - 0x4000000FF.

In fact, both Xen and KVM are using the leaf 0x40000001 for different purposes today (Xen: Xen version number, KVM: KVM para-virtualization features). But I don't think this would break their existing binaries mainly because they would need to expose the interface explicitly now.

>
> > > This further underscores my belief that using 0x400000xx for
> > > anything "standards-based" at all is utterly futile, and that this
> > > space should be treated as vendor identification and the rest as
> > > vendor-specific. Any hope of creating a standard that's actually
> > > usable needs to be outside this space, e.g. in the 0x40SSSSxx
> > > space I proposed earlier.
> >
> > Actually I'm not sure I'm following your logic. Are you saying using
> > that 0x400000xx for anything "standards-based" is utterly futile
> > because Microsoft said "the range is hypervisor vendor-neutral"? Or
> > you were not sure what they meant there. If we are not clear, we can
> > ask them.
> >
>
> What I'm saying is that Microsoft is effectively squatting on the
> 0x400000xx space with their definition.  As written, it's not even
> clear that it will remain consistent between *their own* hypervisors,
> even less anyone else's.

I hope the above clarified your concern. You can google-search a more detailed public spec. Let me know if you want to know a specific URL.

>
>         -hpa
>
             .
Jun Nakajima | Intel Open Source Technology Center
