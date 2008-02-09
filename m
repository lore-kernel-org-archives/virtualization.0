From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] virtio_ring: make structure defines packed
Date: Sat, 9 Feb 2008 09:56:34 +0100
Message-ID: <200802090956.35422.arnd__19584.1346438558$1202605951$gmane$org@arndb.de>
References: <200802081401.21194.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200802081401.21194.borntraeger@de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 08 February 2008, Christian Borntraeger wrote:

> Currently the virtio_ring structure are not declared packed, but they 
> describe an hardware like interface. We should not allow compilers to make 
> alignments and optimizations that can be different between the guest and 
> host compiler.
> 
> I propose to declare all structures that are in shared memory as packed.
> 
> Does anybody see a problem with packed?

Packed structures can lead to unoptimized object code when the compiler
cannot assume natural alingment and does all accesses in single bytes.
It may even produce incorrect code if the host interface requires
larger-than-byte accesses.

I'm not aware of any version of gcc that introduces padding when all
struct members are naturally aligned as they are in the structures
you propose to change, so I'd think we're better off not having them
declared as packed.

Also, if someone does find a compelling reason to make them packed
indeed, the way to express that now should be '__packed', not 
'__attribute__((packed))'.

	Arnd <><
