From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] Why I advise against using ivshmem
Date: Tue, 17 Jun 2014 10:54:04 +0800
Message-ID: <CAJSP0QUcFGSGgQMjU=Ax3n6Gqx6h_ZZ1yXz6QgQiyYYe+e4K4w@mail.gmail.com>
References: <20140610184818.2e490419@nbschild1> <53978375.6090707@6wind.com>
	<87ppie1v4r.fsf@blackfin.pond.sub.org>
	<20140612094413.15e56938@nbschild1>
	<87vbs6qjhj.fsf_-_@blackfin.pond.sub.org>
	<5399CF09.8030803@6wind.com> <87ppidnqmy.fsf@blackfin.pond.sub.org>
	<539AC3E0.9090404@6wind.com> <539ACDE6.7020709@redhat.com>
	<539AFF7C.7090702@6wind.com> <539B064D.2050501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Henning Schild <henning.schild@siemens.com>, Olivier MATZ <olivier.matz@6wind.com>, kvm <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Vincent JARDIN <vincent.jardin@6wind.com>, David Marchand <david.marchand@6wind.com>, "thomas.monjalon@6wind.com" <thomas.monjalon@6wind.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 13, 2014 at 10:10 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Il 13/06/2014 15:41, Vincent JARDIN ha scritto:
>> I do repeat this use case that you had removed because vhost-user does
>> not solve it yet:
>>
>>>>  - ivshmem -> framework to be generic to have shared memory for many
>>>> use cases (HPC, in-memory-database, a network too like memnic).
>
>
> Right, ivshmem is better for guest-to-guest.  vhost-user is not restricted
> to networking, but it is indeed more focused on guest-to-host.  ivshmem is
> usable for guest-to-host, but I would prefer still some "hybrid" that uses
> vhost-like messages to pass the shared memory fds to the external program.

ivshmem has a performance disadvantage for guest-to-host
communication.  Since the shared memory is exposed as PCI BARs, the
guest has to memcpy into the shared memory.

vhost-user can access guest memory directly and avoid the copy inside the guest.

Unless someone steps up and maintains ivshmem, I think it should be
deprecated and dropped from QEMU.

Stefan
