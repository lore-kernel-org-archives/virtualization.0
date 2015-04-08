From: Alexander Duyck <alexander.h.duyck@redhat.com>
Subject: Re: [PATCH] virtio_ring: Update weak barriers to use dma_wmb/rmb
Date: Wed, 08 Apr 2015 07:41:49 -0700
Message-ID: <55253E2D.5020704@redhat.com>
References: <20150408004742.2112.25484.stgit@ahduyck-vm-fedora22>
	<20150408093032-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150408093032-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On 04/08/2015 01:42 AM, Michael S. Tsirkin wrote:
> On Tue, Apr 07, 2015 at 05:47:42PM -0700, Alexander Duyck wrote:
>> This change makes it so that instead of using smp_wmb/rmb which varies
>> depending on the kernel configuration we can can use dma_wmb/rmb which for
>> most architectures should be equal to or slightly more strict than
>> smp_wmb/rmb.
>>
>> The advantage to this is that these barriers are available to uniprocessor
>> builds as well so the performance should improve under such a
>> configuration.
>>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
> Well the generic implementation has:
> #ifndef dma_rmb
> #define dma_rmb()       rmb()
> #endif
>
> #ifndef dma_wmb
> #define dma_wmb()       wmb()
> #endif
>
> So for these arches you are slightly speeding up UP but slightly hurting SMP -
> I think we did benchmark the difference as measureable in the past.

The generic implementation for the smp_ barriers does the same thing 
when CONFIG_SMP is defined.  The only spot where there should be an 
appreciable difference between the two is on ARM where we define the 
dma_ barriers as being in the outer shareable domain, and for the smp_ 
barriers they are inner shareable domain.

> Additionally, isn't this relying on undocumented behaviour?
> The documentation says:
> 	"These are for use with consistent memory"
> and virtio does not bother to request consistent memory
> allocations.

Consistent in this case represents memory that exists within one 
coherency domain.  So in the case of x86 for instance this represents 
writes only to system memory.  If you mix writes to system memory and 
device memory (PIO) then you should be using the full wmb/rmb to 
guarantee ordering between the two memories.

> One wonders whether these will always be strong enough.

For the purposes of weak barriers they should be, and they are only 
slightly stronger than SMP in one case so odds are strength will not be 
the issue.  As far as speed I would suspect that the difference between 
inner and outer shareable domain should be negligible compared to the 
difference between a dsb() and a dmb().

- Alex
