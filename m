From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/3] vhost cleanups and separate module
Date: Mon, 13 May 2013 11:39:02 +0800
Message-ID: <51906056.6060508@redhat.com>
References: <1367559269-8325-1-git-send-email-asias@redhat.com>
	<87sj20prhj.fsf@rustcorp.com.au>
	<20130506091911.GB10601@redhat.com>
	<87zjw7o0vz.fsf@rustcorp.com.au>
	<20130507124433.GD21361@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130507124433.GD21361@redhat.com>
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
Cc: target-devel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 05/07/2013 08:44 PM, Michael S. Tsirkin wrote:
> On Tue, May 07, 2013 at 02:13:44PM +0930, Rusty Russell wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>> On Mon, May 06, 2013 at 03:41:36PM +0930, Rusty Russell wrote:
>>>> Asias He <asias@redhat.com> writes:
>>>>> Asias He (3):
>>>>>   vhost: Remove vhost_enable_zcopy in vhost.h
>>>>>   vhost: Move VHOST_NET_FEATURES to net.c
>>>>>   vhost: Make vhost a separate module
>>>> I like these cleanups, MST pleasee apply.
>>> Absolutely. Except it's 3.11 material and I can only
>>> usefully create a -next branch once -rc1 is out.
>>>
>>>> I have some other cleanups which are on hold for the moment pending
>>>> MST's vhost_net simplification.  MST, how's that going?
>>> Not too well. The array of status bytes which was designed to complete
>>> packets in order turns out to be a very efficient datastructure:
>>>
>>> It gives us a way to signal completions that is completely lockless for
>>> multiple completers, and using the producer/consumer model saves extra
>>> scans for the common case.
>>>
>>> Overall I can save some memory and clean up some code but can't get rid
>>> of the producer/consumer idices (currently named upend/done indices)
>>> which is what you asked me to do.
>>> Your cleanups basically don't work with zcopy because they
>>> ignore the upend/done indices?
>>> Would you like to post them, noting they only work with zcopy off, and
>>> we'll look for a way to apply them, together?
>> Not quite; it's just that I don't understand that code.  It seemed to be
>> achieving something (ordered completion) which was entirely unnecessary,
>> so I went on with other things while you removed it.  Now that's not
>> possible, I'll revisit.
>>
>> AFAICT we should always do zero copy.
> It seems not to be a win for small packets.
> I speculate the issue is that ring space isn't released as promptly.
> Further, we can't do it safely for guest to guest and guest to host.
> And if we try, net core just does a packet copy later (which is less
> efficient). So there's a hack in place to detect that and suppress zero
> copy.

We can do something to eliminate this copy:

- change the vnet header to NET_SKB_PAD
- use build_skb() to build the skb->data from the page directly

Then for packet size smaller than PAGE_SIZE - NET_SKB_PAD -
SKB_DATA_ALIGN(sizeof(struct skb_shared_info)), we can build the packet
directly instead of copy 128 bytes.

>
>> Though I do wonder if we should
>> use a dedicated hook to get an skb into the tun driver and generate it
>> ourselves, rather than going sg -> iov -> skb.
>>
>> Cheers,
>> Rusty.
> I think we'd have to export two interfaces:
> - alloc_skb()
>   .... add frags ...
> - send_skb
>
> the code to add frags could maybe use some
> library functions ...
>
