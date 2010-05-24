From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] virtio: put last seen used index into
	ring itself
Date: Mon, 24 May 2010 09:37:05 +0300
Message-ID: <4BFA1E91.8060706__11007.6750432656$1274683106$gmane$org@redhat.com>
References: <20100505205814.GA7090@redhat.com> <4BF39C12.7090407@redhat.com>
	<201005201431.51142.rusty@rustcorp.com.au>
	<201005201438.17010.rusty@rustcorp.com.au>
	<20100523153134.GA14646@redhat.com> <4BF94CAD.5010504@redhat.com>
	<20100523155132.GA14733@redhat.com> <4BF951BE.1010402@redhat.com>
	<20100523163039.GC14733@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100523163039.GC14733@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 05/23/2010 07:30 PM, Michael S. Tsirkin wrote:
>
>    
>>> Maybe we should use atomics on index then?
>>>
>>>        
>> This should only be helpful if you access the cacheline several times in
>> a row.  That's not the case in virtio (or here).
>>      
> So why does it help?
>    

We actually do access the cacheline several times in a row here (but not 
in virtio?):

> 		case SHARE:
> 			while (count<  MAX_BOUNCES) {
> 				/* Spin waiting for other side to change it. */
> 				while (counter->cacheline1 != count);
>    

Broadcast a read request.

> 				count++;
> 				counter->cacheline1 = count;
>    

Broadcast an invalidate request.

> 				count++;
> 			}
> 			break;
>
> 		case LOCKSHARE:
> 			while (count<  MAX_BOUNCES) {
> 				/* Spin waiting for other side to change it. */
> 				while (__sync_val_compare_and_swap(&counter->cacheline1, count, count+1)
> 				       != count);
>    

Broadcast a 'read for ownership' request.

> 				count += 2;
> 			}
> 			break;
>    

So RMW should certainly by faster using single-instruction RMW 
operations (or using prefetchw).

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
