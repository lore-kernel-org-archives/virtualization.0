From: Markus Armbruster <armbru@redhat.com>
Subject: Re: [Qemu-devel] Using virtio for inter-VM communication
Date: Thu, 12 Jun 2014 14:55:47 +0200
Message-ID: <874mzqwalo.fsf@blackfin.pond.sub.org>
References: <20140610184818.2e490419@nbschild1> <53978375.6090707@6wind.com>
	<87ppie1v4r.fsf@blackfin.pond.sub.org>
	<20140612094413.15e56938@nbschild1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140612094413.15e56938@nbschild1> (Henning Schild's message of
	"Thu, 12 Jun 2014 09:44:13 +0200")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Henning Schild <henning.schild@siemens.com>
Cc: Vincent JARDIN <vincent.jardin@6wind.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Henning Schild <henning.schild@siemens.com> writes:

> On Thu, 12 Jun 2014 08:48:04 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Vincent JARDIN <vincent.jardin@6wind.com> writes:
>> 
>> > On 10/06/2014 18:48, Henning Schild wrote:> Hi,
>> >> In a first prototype i implemented a ivshmem[2] device for the
>> >> hypervisor. That way we can share memory between virtual machines.
>> >> Ivshmem is nice and simple but does not seem to be used anymore.
>> >> And it
>> >> does not define higher level devices, like a console.
>> >
>> > FYI, ivhsmem is used here:
>> >   http://dpdk.org/browse/memnic/tree/
>> >
>> > http://dpdk.org/browse/memnic/tree/pmd/pmd_memnic.c#n449
>> >
>> > There are some few other references too, if needed.
>> 
>> It may be used, but that doesn't mean it's maintained, or robust
>> against abuse.  My advice is to steer clear of it.
>
> Could you elaborate on why you advice against it?
