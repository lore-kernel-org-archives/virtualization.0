From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: use smp_XX barriers
Date: Wed, 27 Jan 2010 11:36:10 +0200
Message-ID: <20100127093610.GD3476@redhat.com>
References: <20100121171055.GA16693@redhat.com> <4B600740.3060806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4B600740.3060806@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 27, 2010 at 11:28:32AM +0200, Avi Kivity wrote:
> On 01/21/2010 07:10 PM, Michael S. Tsirkin wrote:
>> Documentation/memory-barriers.txt says:
>> Mandatory barriers should not be used to control SMP effects, since
>> mandatory barriers unnecessarily impose overhead on UP systems.
>>
>> This rule applies to virtio, so let's do it correctly.
>>
>>    
>
> This is wrong.  A UP guest still runs in parallel with the virtio device.

Yes, you are right here. I forgot that these macros
are compiled out on UP guest. Rusty please ignore this patch.

> smp_mb() is used for processor-vs-processor ordering, which can't happen  
> on UP systems, but for process-vs-device, we must use mb().
>
> (this shows up if running a UP guest on an SMP host).

Currently, yes. But virtio is not a real device.
Here's what I was really trying to improve: rmb() is an lfence on
x86_64, but smp_rmb() is a barrier() and this is really sufficient for
virtio because x86_64 does not reorder memory reads.

Does this mean such an optimization would need a new macro?

-- 
MST
