From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors	and	Linux.
Date: Wed, 01 Oct 2008 15:46:45 -0700
Message-ID: <48E3FDD5.7040106__16843.6961518184$1222901543$gmane$org@zytor.com>
References: <1222881242.9381.17.camel@alok-dev1>	 <48E3B19D.6060905@zytor.com>
	<1222882431.9381.23.camel@alok-dev1>	 <48E3BC21.4080803@goop.org>
	<1222895153.9381.69.camel@alok-dev1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1222895153.9381.69.camel@alok-dev1>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: akataria@vmware.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "avi@redhat.com" <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Alok Kataria wrote:
>> No, that's always a terrible idea.  Sure, its necessary to deal with
>> some backward-compatibility issues, but we should even consider a new
>> interface which assumes this kind of thing.  We want properly enumerable
>> interfaces.
> 
> The reason we still have to do this is because, Microsoft has already
> defined a CPUID format which is way different than what you or I are
> proposing ( with the current case of 256 leafs being available). And I
> doubt they would change the way they deal with it on their OS. 
> Any proposal that we go with, we will have to export different CPUID
> interface from the hypervisor for the 2 OS in question. 
> 
> So i think this is something that we anyways will have to do and not
> worth binging about in the discussion.

No, that's a good hint that what "you and I" are proposing is utterly 
broken and exactly underscores what I have been stressing about 
noncompliant hypervisors.

All I have seen out of Microsoft only covers CPUID levels 0x40000000 as 
an vendor identification leaf and 0x40000001 as a "hypervisor 
identification leaf", but you might have access to other information.

This further underscores my belief that using 0x400000xx for anything 
"standards-based" at all is utterly futile, and that this space should 
be treated as vendor identification and the rest as vendor-specific. 
Any hope of creating a standard that's actually usable needs to be 
outside this space, e.g. in the 0x40SSSSxx space I proposed earlier.

	-hpa
