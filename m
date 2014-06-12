From: Markus Armbruster <armbru@redhat.com>
Subject: Re: Using virtio for inter-VM communication
Date: Thu, 12 Jun 2014 08:48:04 +0200
Message-ID: <87ppie1v4r.fsf__19162.2047489092$1402556128$gmane$org@blackfin.pond.sub.org>
References: <20140610184818.2e490419@nbschild1> <53978375.6090707@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53978375.6090707@6wind.com> (Vincent JARDIN's message of "Wed,
	11 Jun 2014 00:15:17 +0200")
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
Cc: Henning Schild <henning.schild@siemens.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Vincent JARDIN <vincent.jardin@6wind.com> writes:

> On 10/06/2014 18:48, Henning Schild wrote:> Hi,
>> In a first prototype i implemented a ivshmem[2] device for the
>> hypervisor. That way we can share memory between virtual machines.
>> Ivshmem is nice and simple but does not seem to be used anymore.
>> And it
>> does not define higher level devices, like a console.
>
> FYI, ivhsmem is used here:
>   http://dpdk.org/browse/memnic/tree/
>
> http://dpdk.org/browse/memnic/tree/pmd/pmd_memnic.c#n449
>
> There are some few other references too, if needed.

It may be used, but that doesn't mean it's maintained, or robust against
abuse.  My advice is to steer clear of it.
