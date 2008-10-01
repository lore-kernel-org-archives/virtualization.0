From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and Linux.
Date: Wed, 01 Oct 2008 10:47:48 -0700
Message-ID: <48E3B7C4.2020707__15459.1123726734$1222883610$gmane$org@zytor.com>
References: <1222881242.9381.17.camel@alok-dev1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1222881242.9381.17.camel@alok-dev1>
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
Cc: kvm@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Dan Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, "avi@redhat.com" <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Alok Kataria wrote:
> 
> Hypervisor CPUID Interface Proposal
> -----------------------------------
> 
> Intel & AMD have reserved cpuid levels 0x40000000 - 0x400000FF for
> software use.  Hypervisors can use these levels to provide an interface
> to pass information from the hypervisor to the guest running inside a
> virtual machine.
> 
> This proposal defines a standard framework for the way in which the
> Linux and hypervisor communities incrementally define this CPUID space.
> 

I also observe that your proposal provides no mean of positive 
identification, i.e. that a hypervisor actually conforms to your proposal.

	-hpa
