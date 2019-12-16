From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC v4 00/13] virtio-mem: paravirtualized memory
Date: Mon, 16 Dec 2019 12:03:21 +0100
Message-ID: <178a5e94-f1f1-130c-9a28-2b8dd2be2abe__47740.1266967476$1576494246$gmane$org@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
 <20191213201556.GC26990@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191213201556.GC26990@char.us.oracle.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Robert Bradford <robert.bradford@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pingfan Liu <kernelfans@gmail.com>, Luiz Capitulino <lcapitulino@redhat.com>, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Wei Yang <richard.weiyang@gmail.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dave Young <dyoung@redhat.com>, Len Brown <lenb@kernel.org>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Qian Cai <cai@lca.pw>, Alexander Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>, Samuel Ortiz <samuel>
List-Id: virtualization@lists.linuxfoundation.org

On 13.12.19 21:15, Konrad Rzeszutek Wilk wrote:
> On Thu, Dec 12, 2019 at 06:11:24PM +0100, David Hildenbrand wrote:
>> This series is based on latest linux-next. The patches are located at:
>>     https://github.com/davidhildenbrand/linux.git virtio-mem-rfc-v4
> Heya!

Hi Konrad!

> 
> Would there be by any chance a virtio-spec git tree somewhere?

I haven't started working on a spec yet - it's on my todo list but has
low priority (one-man-team). I'll focus on the QEMU pieces next, once
the kernel part is in an acceptable state.

The uapi file contains quite some documentation - if somebody wants to
start hacking on an alternative hypervisor implementation, I'm happy to
answer questions until I have a spec ready.

> 
> ..snip..
>> --------------------------------------------------------------------------
>> 5. Future work
>> --------------------------------------------------------------------------
>>
>> The separate patches contain a lot of future work items. One of the next
>> steps is to make memory unplug more likely to succeed - currently, there
>> are no guarantees on how much memory can get unplugged again. I have
> 
> 
> Or perhaps tell the caller why we can't and let them sort it out?
> For example: "Application XYZ is mlocked. Can't offload'.

Yes, it might in general be interesting for the guest to indicate
persistent errors, both when hotplugging and hotunplugging memory.
Indicating why unplugging is not able to succeed in that detail is,
however, non-trivial.

The hypervisor sets the requested size can can watch over the actual
size of a virtio-mem device. Right now, after it updated the requested
size, it can wait some time (e.g., 1-5 minutes). If the requested size
was not reached after that time, it knows there is a persistent issue
limiting plug/unplug. In the future, this could be extended by a rough
or detailed root cause indication. In the worst case, the guest crashed
and is no longer able to respond (not even with an error indication).

One interesting piece of the current hypervisor (QEMU) design is that
the maximum memory size a VM can consume is always known and QEMU will
send QMP events to upper layers whenever that size changes. This means
that you can e.g., reliably charge a customer how much memory a VM is
actually able to consume over time (independent of hotplug/unplug
errors). But yeah, the QEMU bits are still in a very early stage.

-- 
Thanks,

David / dhildenb
