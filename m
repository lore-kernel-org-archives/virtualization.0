From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 26/32] xen: Add Xen virtual block device driver.
Date: Mon, 30 Apr 2007 11:52:19 -0700
Message-ID: <46363AE3.2000208@goop.org>
References: <20070429172835.284784000@goop.org>
	<20070429172915.805798000@goop.org>
	<20070429181646.GB3551@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070429181646.GB3551@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>, Jens Axboe <axboe@kernel.dk>
List-Id: virtualization@lists.linuxfoundation.org

Christoph Hellwig wrote:
>>  source "drivers/s390/block/Kconfig"
>> +source "drivers/block/xen/Kconfig"
>>     
>
> Please don't add a new subdirectory for a tiny new driver that
> really should be only a single .c file.
>   

Yup.

>> +config XEN_BLKDEV_FRONTEND
>> +	tristate "Block device frontend driver"
>> +	depends on XEN
>> +	default y
>>     
>
> Please kill the default statement.  We really should have script that
> autorejects every new driver that wants to be default y..
>   

I guess.  But if you've already decided to enable Xen, it seems to me
that the default option should reflect the common case.  But I don't
feel strongly about it either way.

>> +#define BLKIF_STATE_DISCONNECTED 0
>> +#define BLKIF_STATE_CONNECTED    1
>> +#define BLKIF_STATE_SUSPENDED    2
>>     
>
> enum, please.
>   

OK.

> Please get rid of all the forward-declarations by putting the code
> into proper order.
>   

Yep. I'll de-generic the names too.

>> +static inline int GET_ID_FROM_FREELIST(
>> +	struct blkfront_info *info)
>> +{
>> +	unsigned long free = info->shadow_free;
>> +	BUG_ON(free > BLK_RING_SIZE);
>> +	info->shadow_free = info->shadow[free].req.id;
>> +	info->shadow[free].req.id = 0x0fffffee; /* debug */
>> +	return free;
>> +}
>> +
>> +static inline void ADD_ID_TO_FREELIST(
>> +	struct blkfront_info *info, unsigned long id)
>> +{
>> +	info->shadow[id].req.id  = info->shadow_free;
>> +	info->shadow[id].request = 0;
>> +	info->shadow_free = id;
>> +}
>>     
>
> Please give these proper lowercased names, and while you're at it
> please kill all the inline statements you have and let the compiler
> do it's work.
>   

OK.

>> +static irqreturn_t blkif_int(int irq, void *dev_id)
>>     
>
> Please call interrupt handlers foo_interrupt, that makes peopl see what's
> going on much more easily.
>   

OK.

>> +static void blkif_recover(struct blkfront_info *info)
>> +{
>> +	int i;
>> +	struct blkif_request *req;
>> +	struct blk_shadow *copy;
>> +	int j;
>> +
>> +	/* Stage 1: Make a safe copy of the shadow state. */
>> +	copy = kmalloc(sizeof(info->shadow), GFP_KERNEL | __GFP_NOFAIL);
>>     
>
> Please don't use __GFP_NOFAIL in any new code.
>   

OK.

[...]

The rest looks sound.  I'll go through it in detail, but a lot of your
points things I've been meaning to get to anyway.

Thanks,
    J
