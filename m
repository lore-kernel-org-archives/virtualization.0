From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors	and	Linux.
Date: Fri, 03 Oct 2008 16:30:29 -0700
Message-ID: <48E6AB15.8060405__26184.962274465$1223077088$gmane$org@zytor.com>
References: <1222881242.9381.17.camel@alok-dev1>	 <48E3B19D.6060905@zytor.com>
	<1222882431.9381.23.camel@alok-dev1>	 <48E3BC21.4080803@goop.org>
	<1222895153.9381.69.camel@alok-dev1> <48E3FDD5.7040106@zytor.com>
	<0B53E02A2965CE4F9ADB38B34501A3A15D927EA4@orsmsx505.amr.corp.intel.com>
	<48E422CA.2010606@zytor.com>
	<0B53E02A2965CE4F9ADB38B34501A3A15DCBA221@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0B53E02A2965CE4F9ADB38B34501A3A15DCBA221@orsmsx505.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: the arch/x86 maintainers <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "akataria@vmware.com" <akataria@vmware.com>, Ingo Molnar <mingo@elte.hu>, "avi@redhat.com" <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Nakajima, Jun wrote:
> What it means their hypervisor returns the interface signature (i.e. "Hv#1"), and that defines the interface. If we use "Lv_1", for example, we can define the interface 0x40000002 through 0x400000FF for Linux. Since leaf 0x40000000 and 0x40000001 are separate, we can decouple the hypervisor vender from the interface it supports.

Right so far.

> This also allows a hypervisor to support multiple interfaces.

Wrong.

This isn't a two-way interface.  It's a one-way interface, and it 
*SHOULD BE*; exposing different information depending on what is running 
is a hack that is utterly tortorous at best.

> 
> In fact, both Xen and KVM are using the leaf 0x40000001 for different purposes today (Xen: Xen version number, KVM: KVM para-virtualization features). But I don't think this would break their existing binaries mainly because they would need to expose the interface explicitly now.
> 
>>>> This further underscores my belief that using 0x400000xx for
>>>> anything "standards-based" at all is utterly futile, and that this
>>>> space should be treated as vendor identification and the rest as
>>>> vendor-specific. Any hope of creating a standard that's actually
>>>> usable needs to be outside this space, e.g. in the 0x40SSSSxx
>>>> space I proposed earlier.
>>> Actually I'm not sure I'm following your logic. Are you saying using
>>> that 0x400000xx for anything "standards-based" is utterly futile
>>> because Microsoft said "the range is hypervisor vendor-neutral"? Or
>>> you were not sure what they meant there. If we are not clear, we can
>>> ask them.
>>>
>> What I'm saying is that Microsoft is effectively squatting on the
>> 0x400000xx space with their definition.  As written, it's not even
>> clear that it will remain consistent between *their own* hypervisors,
>> even less anyone else's.
> 
> I hope the above clarified your concern. You can google-search a more detailed public spec. Let me know if you want to know a specific URL.
> 

No, it hasn't "clarified my concern" in any way.  It's exactly 
*underscoring* it.  In other words, I consider 0x400000xx unusable for 
anything that is standards-based.  The interfaces everyone is currently 
using aren't designed to export multiple interfaces; they're designed to 
tell the guest which *one* interface is exported.  That is fine, we just 
need to go elsewhere.

	-hpa
