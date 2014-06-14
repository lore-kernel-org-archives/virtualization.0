From: Vincent JARDIN <vincent.jardin@6wind.com>
Subject: Re: [Qemu-devel] Why I advise against using ivshmem
Date: Sat, 14 Jun 2014 20:01:54 +0200
Message-ID: <539C8E12.7050504@6wind.com>
References: <20140610184818.2e490419@nbschild1> <53978375.6090707@6wind.com>
	<87ppie1v4r.fsf@blackfin.pond.sub.org>
	<20140612094413.15e56938@nbschild1>
	<87vbs6qjhj.fsf_-_@blackfin.pond.sub.org>
	<5399CF09.8030803@6wind.com> <87ppidnqmy.fsf@blackfin.pond.sub.org>
	<539AC3E0.9090404@6wind.com> <539ACDE6.7020709@redhat.com>
	<539AFF7C.7090702@6wind.com> <539B064D.2050501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <539B064D.2050501@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: Henning Schild <henning.schild@siemens.com>, Olivier MATZ <olivier.matz@6wind.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, "thomas.monjalon@6wind.com" <thomas.monjalon@6wind.com>, Paolo Bonzini <pbonzini@redhat.com>, David Marchand <david.marchand@6wind.com>
List-Id: virtualization@lists.linuxfoundation.org

(resending, this email is missing at 
http://lists.nongnu.org/archive/html/qemu-devel/2014-06/index.html)

 > Fine, however Red Hat would also need a way to test ivshmem code, with
 > proper quality assurance (that also benefits upstream, of course).
 >  With ivshmem this is not possible without the out-of-tree packages.

You did not reply to my question: how to get the list of things that
are/will be disabled by Redhat?

About Redhat's QA, I do not care.
About Qemu's QA, I do care ;)

I guess we can combine both. What's about something like:
    tests/virtio-net-test.c # qtest_add_func( is a nop)
but for ivshmem
    test/ivshmem-test.c
?

would it have any values?

If not, what do you use at Redhat to test Qemu?

 >> now, you cannot compare vhost-user to DPDK/ivshmem; both should exsit
 >> because they have different scope and use cases. It is like comparing
 >> two different(A) models of IPC:

I do repeat this use case that you had removed because vhost-user does
not solve it yet:

 >>  - ivshmem -> framework to be generic to have shared memory for many
 >> use cases (HPC, in-memory-database, a network too like memnic).

 >>   - vhost-user -> networking use case specific
 >
 > Not necessarily.  First and foremost, vhost-user defines an API for
 > communication between QEMU and the host, including:
 > * file descriptor passing for the shared memory file
 > * mapping offsets in shared memory to physical memory addresses in the
 > guests
 > * passing dirty memory information back and forth, so that migration
 > is not prevented
 > * sending interrupts to a device
 > * setting up ring buffers in the shared memory

Yes, I do agree that it is promising.
And of course some tests are here:
    https://lists.gnu.org/archive/html/qemu-devel/2014-03/msg00584.html
for some of the bullets you are listing (not all yet).

 > Also, vhost-user is documented! See here:
 > https://lists.gnu.org/archive/html/qemu-devel/2014-03/msg00581.html

as I told you, we'll send a contribution with ivshmem's documentation.

 > The only part of ivshmem that vhost doesn't include is the n-way
 > inter-guest doorbell.  This is the part that requires a server and uio
 > driver.  vhost only supports host->guest and guest->host doorbells.

agree: both will need it: vhost and ivshmem requires a doorbell for
VM2VM, but then we'll have a security issue to be managed by Qemu for
vhost and ivshmem.
I'll be pleased to contribute on it for ivshmem thru another thread that 
this one.

 >> ivhsmem does not require DPDK kernel driver. see memnic's PMD:
 >>   http://dpdk.org/browse/memnic/tree/pmd/pmd_memnic.c
 >
 > You're right, I was confusing memnic and the vhost example in DPDK.

Definitively, it proves a lack of documentation. You welcome. Olivier
did explain it:

http://lists.nongnu.org/archive/html/qemu-devel/2014-06/msg03127.html
 >> ivhsmem does not require hugetlbfs. It is optional.
 >>
 >>  > * it doesn't require ivshmem (it does require shared memory, which
 >>  > will also be added to 2.1)
 >
 > Right, hugetlbfs is not required. A posix shared memory or tmpfs
 > can be used instead. For instance, to use /dev/shm/foobar:
 >
 >   qemu-system-x86_64 -enable-kvm -cpu host [...] \
 >      -device ivshmem,size=16,shm=foobar


Best regards,
    Vincent
