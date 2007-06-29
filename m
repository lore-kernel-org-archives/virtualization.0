From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: RFC: multiple address spaces for one process
Date: Fri, 29 Jun 2007 10:32:01 -0400
Message-ID: <468517E1.4050803@goop.org>
References: <87myynt1m6.wl%peter@chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87myynt1m6.wl%peter@chubb.wattle.id.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-mm@kvack.org, Carsten Otte <cotte@de.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Peter Chubb wrote:
> In a hosted VMM like LinuxOnLinux or UML, context switch time can be a
> major problem (as mmap when repeated for each guest page frame takes a
> long time).  One solution is to allow the host kernel to keep a cache of
> address space contexts, and switch between them in a single
> operation. 
>   

Other VMMs which have a large usermode component, like lguest and kvm, 
do maintain two address spaces mapping the same set of pages.  But 
unlike UML (and I guess LoL), the guest mappings are not represented as 
VMAs, but just as a raw processor pagetable.  They need some special 
switcher code to go into that state, so it doesn't look like this would 
be terribly useful for them.

Am I right in presuming that this is really only useful for VMMs which 
want to use mmap/mprotect/munmap for the virtual MMU implementation?

It might be interesting if the two cases could be unified in some way, 
so that the VMMs could use a common usermode mechanism to achieve the 
same end, which is what Carsten was proposing.  But its not obvious to 
me how much common mechanism can be pulled out, since its a pretty 
deeply architecture-specific operation.

    J
