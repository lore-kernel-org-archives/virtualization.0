From: Olivier MATZ <olivier.matz@6wind.com>
Subject: Re: [Qemu-devel] Why I advise against using ivshmem
Date: Fri, 13 Jun 2014 11:48:11 +0200
Message-ID: <539AC8DB.4040109__3533.49196161634$1402701395$gmane$org@6wind.com>
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
To: Vincent JARDIN <vincent.jardin@6wind.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Henning Schild <henning.schild@siemens.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, David Marchand <david.marchand@6wind.com>, virtualization@lists.linux-foundation.org, "thomas.monjalon@6wind.com" <thomas.monjalon@6wind.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

On 06/13/2014 11:26 AM, Vincent JARDIN wrote:
> ivhsmem does not require hugetlbfs. It is optional.
>
>  > * it doesn't require ivshmem (it does require shared memory, which
>  > will also be added to 2.1)

Right, hugetlbfs is not required. A posix shared memory or tmpfs
can be used instead. For instance, to use /dev/shm/foobar:

   qemu-system-x86_64 -enable-kvm -cpu host [...] \
      -device ivshmem,size=16,shm=foobar


Regards,
Olivier
