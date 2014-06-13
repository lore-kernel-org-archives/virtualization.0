From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Qemu-devel] Why I advise against using ivshmem
Date: Fri, 13 Jun 2014 16:10:21 +0200
Message-ID: <539B064D.2050501@redhat.com>
References: <20140610184818.2e490419@nbschild1> <53978375.6090707@6wind.com>
	<87ppie1v4r.fsf@blackfin.pond.sub.org>
	<20140612094413.15e56938@nbschild1>
	<87vbs6qjhj.fsf_-_@blackfin.pond.sub.org>
	<5399CF09.8030803@6wind.com> <87ppidnqmy.fsf@blackfin.pond.sub.org>
	<539AC3E0.9090404@6wind.com> <539ACDE6.7020709@redhat.com>
	<539AFF7C.7090702@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <539AFF7C.7090702@6wind.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vincent JARDIN <vincent.jardin@6wind.com>
Cc: Henning Schild <henning.schild@siemens.com>, Olivier MATZ <olivier.matz@6wind.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, "thomas.monjalon@6wind.com" <thomas.monjalon@6wind.com>, David Marchand <david.marchand@6wind.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 13/06/2014 15:41, Vincent JARDIN ha scritto:
>> Fine, however Red Hat would also need a way to test ivshmem code, with
>> proper quality assurance (that also benefits upstream, of course).  With
>> ivshmem this is not possible without the out-of-tree packages.
>
> You did not reply to my question: how to get the list of things that
> are/will be disabled by Redhat?

I don't know exactly what the answer is, and this is probably not the 
right list to discuss it.  I guess there are partnership programs with 
Red Hat that I don't know the details of, but these are more for 
management folks and not really for developers.

ivshmem in particular was disabled even in RHEL7 beta, so you could have 
found out about this in December and opened a bug in Bugzilla about it.

> I guess we can combine both. What's about something like:
>   tests/virtio-net-test.c # qtest_add_func( is a nop)
> but for ivshmem
>   test/ivshmem-test.c
> ?
>
> would it have any values?

The first things to do are:

1) try to understand if there is any value in a simplified shared memory 
device with no interrupts (and those no eventfd or uio dependencies, not 
even optionally).  You are not using them because DPDK only does polling 
and basically reserves a core for the NIC code. If so, this would be a 
very simple device, just a 100 or so lines of code.  We could get this 
in upstream, and it would be likely enabled in RHEL too.

2) if not, get the server and uio driver merged into the QEMU tree, and 
document the protocol in docs/specs/ivshmem_device_spec.txt.  It doesn't 
matter if the code comes from the Nahanni repository or from your own 
implementation.  Also start fixing bugs such as the ones that Markus 
reported (removing all exit() invocations).

Writing testcases using the qtest framework would also be useful, but 
first of all it is important to make ivshmem easier to use.

> If not, what do you use at Redhat to test Qemu?

We do integration testing using autotest/virt-test (QEMU and KVM 
developers for upstream use it too) and also some manual functional tests.

Contributing ivshmem tests to the virt-test would also be helpful in 
demonstrating your interest in maintaining ivshmem.  The repository and 
documentation is at https://github.com/autotest/virt-test/ (a bit 
Fedora-centric).

> I do repeat this use case that you had removed because vhost-user does
> not solve it yet:
>
>>>  - ivshmem -> framework to be generic to have shared memory for many
>>> use cases (HPC, in-memory-database, a network too like memnic).

Right, ivshmem is better for guest-to-guest.  vhost-user is not 
restricted to networking, but it is indeed more focused on 
guest-to-host.  ivshmem is usable for guest-to-host, but I would prefer 
still some "hybrid" that uses vhost-like messages to pass the shared 
memory fds to the external program.

Paolo
