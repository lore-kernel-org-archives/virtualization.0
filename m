From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Qemu-devel] Why I advise against using ivshmem
Date: Fri, 13 Jun 2014 12:09:42 +0200
Message-ID: <539ACDE6.7020709@redhat.com>
References: <20140610184818.2e490419@nbschild1> <53978375.6090707@6wind.com>
	<87ppie1v4r.fsf@blackfin.pond.sub.org>
	<20140612094413.15e56938@nbschild1>
	<87vbs6qjhj.fsf_-_@blackfin.pond.sub.org>
	<5399CF09.8030803@6wind.com> <87ppidnqmy.fsf@blackfin.pond.sub.org>
	<539AC3E0.9090404@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <539AC3E0.9090404@6wind.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vincent JARDIN <vincent.jardin@6wind.com>, Markus Armbruster <armbru@redhat.com>
Cc: Henning Schild <henning.schild@siemens.com>, Olivier MATZ <olivier.matz@6wind.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, David Marchand <david.marchand@6wind.com>, virtualization@lists.linux-foundation.org, "thomas.monjalon@6wind.com" <thomas.monjalon@6wind.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 13/06/2014 11:26, Vincent JARDIN ha scritto:
>> Markus especially referred to parts *outside* QEMU: the server, the
>> uio driver, etc.  These out-of-tree, non-packaged parts of ivshmem
>> are one of the reasons why Red Hat has disabled ivshmem in RHEL7.
>
> You made the right choices, these out-of-tree packages are not required.
> You can use QEMU's ivshmem without any of the out-of-tree packages. The
> out-of-tree packages are just some examples of using ivshmem.

Fine, however Red Hat would also need a way to test ivshmem code, with 
proper quality assurance (that also benefits upstream, of course).  With 
ivshmem this is not possible without the out-of-tree packages.

Disabling all the unwanted devices is a lot of work and thankless too 
(you only get complaints, in fact!).  But we prefer to ship only what we 
know we can test, support and improve.  We do not want customers' bug 
reports to languish because they are using code that cannot really be fixed.

Note that we do take into account community contributions in choosing 
which new code can be supported.  For example most work on VMDK images 
was done by Fam when he was a student, libiscsi is mostly the work of 
Peter Lieven, and so on; both of them are supported in RHEL.  These 
people did/do a great job, and we were happy to embrace those features!

Now, putting back my QEMU hat...

>> He also listed many others.  Basically for parts of QEMU that are not
>> of high quality, we either fix them (this is for example what we did
>> for qcow2) or disable them.  Not just ivshmem suffered this fate, for
>> example many network cards, sound cards, SCSI storage adapters.
>
> I and David (cc) are working on making it better based on the issues
> that are found.
>
>> Now, vhost-user is in the process of being merged for 2.1.  Compared
> to the DPDK solution:
>
> now, you cannot compare vhost-user to DPDK/ivshmem; both should exsit
> because they have different scope and use cases. It is like comparing
> two different(A) models of IPC:
>   - vhost-user -> networking use case specific

Not necessarily.  First and foremost, vhost-user defines an API for 
communication between QEMU and the host, including:

* file descriptor passing for the shared memory file

* mapping offsets in shared memory to physical memory addresses in the 
guests

* passing dirty memory information back and forth, so that migration is 
not prevented

* sending interrupts to a device

* setting up ring buffers in the shared memory


None of these is virtio specific, except the last (even then, you could 
repurpose the messages to pass the address of the whole shared memory 
area, instead of the vrings only).

Yes, the only front-end for vhost-user, right now, is a network device. 
  But it is possible to connect vhost-scsi to vhost-user as well, it is 
possible to develop a vhost-serial as well, and it is possible to only 
use the RPC and develop arbitrary shared-memory based tools using this 
API.  It's just that no one has done it yet.

Also, vhost-user is documented! See here: 
https://lists.gnu.org/archive/html/qemu-devel/2014-03/msg00581.html

The only part of ivshmem that vhost doesn't include is the n-way 
inter-guest doorbell.  This is the part that requires a server and uio 
driver.  vhost only supports host->guest and guest->host doorbells.

>> * it doesn't require hugetlbfs (which only enabled shared memory by
>> chance in older QEMU releases, that was never documented)
>
> ivhsmem does not require hugetlbfs. It is optional.
>
>> * it doesn't require the kernel driver from the DPDK sample
>
> ivhsmem does not require DPDK kernel driver. see memnic's PMD:
>   http://dpdk.org/browse/memnic/tree/pmd/pmd_memnic.c

You're right, I was confusing memnic and the vhost example in DPDK.

Paolo
