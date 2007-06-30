From: Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: RFC: multiple address spaces for one process
Date: Sat, 30 Jun 2007 09:30:42 -0700
Message-ID: <46868532.7030208@xensource.com>
References: <87myynt1m6.wl%peter@chubb.wattle.id.au>	<468517E1.4050803@goop.org>
	<4685D9C9.20504@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4685D9C9.20504@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: carsteno@de.ibm.com
Cc: linux-mm@kvack.org, Peter Chubb <peterc@gelato.unsw.edu.au>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Carsten Otte wrote:
> The big difference here is that LinuxOnLinux does represent guest 
> virtual addressing in these mm structs where all other kernel based 
> VMMs do represent guest physical in the user address space. That 
> somewhat disqualifies LinuxOnLinux to share the commonality.
> Whether or not proposed patch makes sense for shaddow page tables is 
> unknown to me, since we have nested paging on s390. 

 From an interface perspective, I think nested paging and shadow 
pagetables should be identical; after all, shadow pagetables are just a 
software implementation of nested pagetables.  There seem to be 3 
distinct types of VMM pagetable:

   1. UML/LoL vmas-as-pagetable/tlb
   2. shadow/nested paging
   3. direct paging

The multiple address space patch definitely makes sense for 1, but 2&3 
both implement the alternate address space by directly pointing the 
CPU's paging hardware at a new pagetable, rather than going via the 
Linux VM.

    J
