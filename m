From: "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: RE: [RFC] CPUID usage for interaction between Hypervisors	and	Linux.
Date: Wed, 1 Oct 2008 18:11:11 -0700
Message-ID: <0B53E02A2965CE4F9ADB38B34501A3A15D927EA4__9041.90562800995$1222910040$gmane$org@orsmsx505.amr.corp.intel.com>
References: <1222881242.9381.17.camel@alok-dev1>
	<48E3B19D.6060905@zytor.com> <1222882431.9381.23.camel@alok-dev1>
	<48E3BC21.4080803@goop.org> <1222895153.9381.69.camel@alok-dev1>
	<48E3FDD5.7040106@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48E3FDD5.7040106@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>, "akataria@vmware.com" <akataria@vmware.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "avi@redhat.com" <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On 10/1/2008 3:46:45 PM, H. Peter Anvin wrote:
> Alok Kataria wrote:
> > > No, that's always a terrible idea.  Sure, its necessary to deal
> > > with some backward-compatibility issues, but we should even
> > > consider a new interface which assumes this kind of thing.  We
> > > want properly enumerable interfaces.
> >
> > The reason we still have to do this is because, Microsoft has
> > already defined a CPUID format which is way different than what you
> > or I are proposing ( with the current case of 256 leafs being
> > available). And I doubt they would change the way they deal with it on their OS.
> > Any proposal that we go with, we will have to export different CPUID
> > interface from the hypervisor for the 2 OS in question.
> >
> > So i think this is something that we anyways will have to do and not
> > worth binging about in the discussion.
>
> No, that's a good hint that what "you and I" are proposing is utterly
> broken and exactly underscores what I have been stressing about
> noncompliant hypervisors.
>
> All I have seen out of Microsoft only covers CPUID levels 0x40000000
> as an vendor identification leaf and 0x40000001 as a "hypervisor
> identification leaf", but you might have access to other information.

No, it says "Leaf 0x40000001 as hypervisor vendor-neutral interface identification, which determines the semantics of leaves from 0x40000002 through 0x400000FF." The Leaf 0x40000000 returns vendor identifier signature (i.e. hypervisor identification) and the hypervisor CPUID leaf range, as in the proposal.

>
> This further underscores my belief that using 0x400000xx for anything
> "standards-based" at all is utterly futile, and that this space should
> be treated as vendor identification and the rest as vendor-specific.
> Any hope of creating a standard that's actually usable needs to be
> outside this space, e.g. in the 0x40SSSSxx space I proposed earlier.
>

Actually I'm not sure I'm following your logic. Are you saying using that 0x400000xx for anything "standards-based" is utterly futile because Microsoft said "the range is hypervisor vendor-neutral"? Or you were not sure what they meant there. If we are not clear, we can ask them.


>         -hpa
             .
Jun Nakajima | Intel Open Source Technology Center
