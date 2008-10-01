From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and	Linux.
Date: Wed, 01 Oct 2008 11:06:25 -0700
Message-ID: <48E3BC21.4080803__40760.6006636799$1222884555$gmane$org@goop.org>
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
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, "avi@redhat.com" <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Alok Kataria wrote:
> Its not a user who has to do anything special here.
> There are *intelligent* VM developers out there who can export a
> different CPUid interface depending on the guest OS type. And this is
> what most of the hypervisors do (not necessarily for CPUID, but for
> other things right now).
>   

No, that's always a terrible idea.  Sure, its necessary to deal with 
some backward-compatibility issues, but we should even consider a new 
interface which assumes this kind of thing.  We want properly enumerable 
interfaces.

    J
