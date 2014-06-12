From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Why I advise against using ivshmem
Date: Thu, 12 Jun 2014 18:54:47 +0200
Message-ID: <5399DB57.4070500@redhat.com>
References: <20140610184818.2e490419@nbschild1> <53978375.6090707@6wind.com>
	<87ppie1v4r.fsf@blackfin.pond.sub.org>
	<20140612094413.15e56938@nbschild1>
	<87vbs6qjhj.fsf_-_@blackfin.pond.sub.org>
	<5399CF09.8030803@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5399CF09.8030803@6wind.com>
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
Cc: Henning Schild <henning.schild@siemens.com>, David Marchand <david.marchand@6wind.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 12/06/2014 18:02, Vincent JARDIN ha scritto:
>
>> * Get all the required parts outside QEMU packaged in major distros, or
>>    absorbed into QEMU
>
> Redhat did disable it. why? it is there in QEMU.

We don't ship everything that is part of QEMU, just like we selectively 
disable many drivers in Linux.

Markus especially referred to parts *outside* QEMU: the server, the uio 
driver, etc.  These out-of-tree, non-packaged parts of ivshmem are one 
of the reasons why Red Hat has disabled ivshmem in RHEL7.

He also listed many others.  Basically for parts of QEMU that are not of 
high quality, we either fix them (this is for example what we did for 
qcow2) or disable them.  Not just ivshmem suffered this fate, for 
example many network cards, sound cards, SCSI storage adapters.

Now, vhost-user is in the process of being merged for 2.1.  Compared to 
the DPDK solution:

* it doesn't require hugetlbfs (which only enabled shared memory by 
chance in older QEMU releases, that was never documented)

* it doesn't require ivshmem (it does require shared memory, which will 
also be added to 2.1)

* it doesn't require the kernel driver from the DPDK sample

* it is not just shared memory, but also defines an interface to use it 
(another of Markus's points)

vhost-user is superior, and it is superior because it has been designed 
from the get-go through cooperation of all interested parties (namely 
QEMU and snabbswitch).

Paolo
