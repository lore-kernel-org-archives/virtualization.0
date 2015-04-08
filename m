From: "Xie, Huawei" <huawei.xie@intel.com>
Subject: Re: [dpdk-dev] [snabb-devel] Re: memory barriers in virtq.lua?
Date: Wed, 8 Apr 2015 15:15:16 +0000
Message-ID: <C37D651A908B024F974696C65296B57B0F42E766__22019.4024187096$1428511095$gmane$org@SHSMSX101.ccr.corp.intel.com>
References: <20150127160126.GA10651@redhat.com>
	<CADDJ2=M6hwFwooXqUjUc9+JxjW1sVYvKhY9dBavrmMUrej6Ysw@mail.gmail.com>
	<CAA2XHbcU0tV0NrBXT6oh6LOz7sKm9P8jqD1=T-ZgTahSVM_qwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Luke Gorrie <luke@snabb.co>, "snabb-devel@googlegroups.com" <snabb-devel@googlegroups.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 4/7/2015 10:23 PM, Luke Gorrie wrote:
> Hi Michael,
>
> I'm writing to follow up the previous discussion about memory barriers in
> virtio-net device implementations, and Cc'ing the DPDK list because I
> believe this is relevant to them too.
>
> First, thanks again for getting in touch and reviewing our code.
>
> I have now found a missed case where we *do* require a hardware memory
> barrier on x86 in our vhost/virtio-net device. That is when checking the
> interrupt suppression flag after updating used->idx. This is needed because
> x86 can reorder the write to used->idx after the read from avail->flags,
> and that causes the guest to see a stale value of used->idx after it
> toggles interrupt suppression.
luke:
1. host read the flag. 2 guest toggles the flag 3.guest checks the used.
4. host update used.
Is this your case?

>
> If I may spell out my mental model, for the sake of being corrected and/or
> as an example of how third party developers are reading and interpreting
> the Virtio-net spec:
>
> Relating this to Virtio 1.0, the most relevant section is 3.2.1 (Supplying
> Buffers to the Device) which calls for two "suitable memory barriers". The
> spec talks about these from the driver perspective, but they are both
> relevant to the device side too.
>
> The first barrier (write to descriptor table before write to used->idx) is
> implicit on x86 because writes by the same core are not reordered. This
> means that no explicit hardware barrier is needed. (A compiler barrier may
> be needed, however.)
>
> The second memory barrier (write to used->idx before reading avail->flags)
> is not implicit on x86 because stores are reordered after loads. So an
> explicit hardware memory barrier is needed.
>
> I hope that is a correct assessment of the situation. (Forgive my
> x86centricity, I am sure that seems very foreign to kernel hackers.)
>
> If this assessment is correct then the DPDK developers might also want to
> review librte_vhost/vhost_rxtx.c and consider adding a hardware memory
> barrier between writing used->idx and reading avail->flags.
>
> Cheers,
> -Luke
>
> P.S. I notice that the Linux virtio-net driver does not seem to tolerate
> spurious interrupts, even though the Virtio 1.0 spec requires this
> ("must"). On 3.13.11-ckt15 I see them trigger an "irq nobody cared" kernel
> log message and then the irq is disabled. If that sounds suspicious I can
> supply more information.
>
>
