From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and	Linux.
Date: Wed, 01 Oct 2008 10:45:55 -0700
Message-ID: <48E3B753.7000309__49620.9672456191$1222883616$gmane$org@zytor.com>
References: <1222881242.9381.17.camel@alok-dev1>	 <48E3B19D.6060905@zytor.com>
	<1222882431.9381.23.camel@alok-dev1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1222882431.9381.23.camel@alok-dev1>
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
> 
> Hi Peter, 
> 
> Its not a user who has to do anything special here.
> There are *intelligent* VM developers out there who can export a
> different CPUid interface depending on the guest OS type. And this is
> what most of the hypervisors do (not necessarily for CPUID, but for
> other things right now).
> 

It doesn't matter, really; it's still the wrong thing to do, for the 
same reason it's the wrong thing in -- for example -- ACPI, which has 
similar "cleverness".

If we want to have a "Linux standard CPUID interface" suite we should 
just put them on a different set of numbers and let a hypervisor export 
all the interfaces.

	-hpa
