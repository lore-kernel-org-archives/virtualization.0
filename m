From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and Linux.
Date: Wed, 01 Oct 2008 10:21:33 -0700
Message-ID: <48E3B19D.6060905__38250.0252839693$1222882050$gmane$org@zytor.com>
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
> (This proposal may be adopted by other guest OSes.  However, that is not
> a requirement because a hypervisor can expose a different CPUID
> interface depending on the guest OS type that is specified by the VM
> configuration.)
> 

Excuse me, but that is blatantly idiotic.  Expecting the user having to 
configure a VM to match the target OS is *exactly* as stupid as 
expecting the user to reconfigure the BIOS.  It's totally the wrong 
thing to do.

	-hpa
