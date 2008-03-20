From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: [kvm-devel] [RFC/PATCH 01/15] preparation: provide hook to enable
	pgstes	in	user pagetable
Date: Thu, 20 Mar 2008 21:35:56 +0100
Message-ID: <47E2CAAC.6020903__35998.2480099008$1206041942$gmane$org@de.ibm.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<1206030278.6690.52.camel@cotte.boeblingen.de.ibm.com>
	<47E29EC6.5050403@goop.org>
	<1206040405.8232.24.camel@nimitz.home.sr71.net>
Reply-To: carsteno@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206040405.8232.24.camel@nimitz.home.sr71.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Christian Ehrhardt <EHRHARDT@de.ibm.com>, hollisb@us.ibm.com, arnd@arndb.de, kvm-devel@lists.sourceforge.net, mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, jeroney@us.ibm.com, borntrae@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, Linux Memory Management List <linux-mm@kvack.org>, rvdheij@gmail.com, Olaf Schnapper <os@de.ibm.com>, jblunck@suse.de, "Zhang, Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Dave Hansen wrote:
> Well, and more fundamentally: do we really want dup_mm() able to be
> called from other code?
> 
> Maybe we need a bit more detailed justification why fork() itself isn't
> good enough.  It looks to me like they basically need an arch-specific
> argument to fork, telling the new process's page tables to take the
> fancy new bit.
> 
> I'm really curious how this new stuff is going to get used.  Are you
> basically replacing fork() when creating kvm guests?
No. The trick is, that we do need bigger page tables when running 
guests: our page tables are usually 2k, but when running a guest 
they're 4k to track both guest and host dirty&reference information. 
This looks like this:
*----------*
*2k PTE's  *
*----------*
*2k PGSTE  *
*----------*
We don't want to waste precious memory for all page tables. We'd like 
to have one kernel image that runs regular server workload _and_ 
guests. Therefore, we need to reallocate the page table after fork() 
once we know that task is going to be a hypervisor. That's what this 
code does: reallocate a bigger page table to accomondate the extra 
information. The task needs to be single-threaded when calling for 
extended page tables.

Btw: at fork() time, we cannot tell whether or not the user's going to 
be a hypervisor. Therefore we cannot do this in fork.
