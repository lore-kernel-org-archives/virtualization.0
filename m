From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: virtio: Add memory statistics reporting to the
	balloon driver (V2)
Date: Wed, 18 Nov 2009 09:02:26 -0600
Message-ID: <4B040C82.6070901__34752.4119577885$1258556952$gmane$org@codemonkey.ws>
References: <1258488996.2820.35.camel@aglitke>	<1258490189.2820.37.camel@aglitke>
	<200911181200.39971.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200911181200.39971.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: qemu-devel@nongnu.org, Avi Kivity <avi@redhat.com>, virtualization <virtualization@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Wed, 18 Nov 2009 07:06:29 am Adam Litke wrote:
>   
>> virtio: Add memory statistics reporting to the balloon driver (V2)
>>
>> Changes since V1:
>>  - Use a virtqueue instead of the device config space
>>     
>
> Hi Adam,
>
>     If Anthony's happy, I'm happy with this approach.
>
> Couple of minor points:
>
>   
>> +static inline void update_stat(struct virtio_balloon *vb, int idx,
>> +				unsigned int tag, unsigned long val)
>> +{
>> +	BUG_ON(idx >= VIRTIO_BALLOON_S_NR);
>> +	vb->stats[idx].tag = tag;
>> +	vb->stats[idx].val = cpu_to_le32(val);
>> +}
>>     
>
> The little-endian conversion of the balloon driver is a historical mistake
> (no other driver does this).  Let's not extend it to the stats.
>   

I think the mistake is that the other drivers don't do that.

We cheat in qemu and assume that the guest is always in a fixed 
endianness but this is not always the case for all architectures.

That said, since we make this mistake everywhere, I guess I understand 
the argument to have consistency and to just admit that we're broken 
here.  But this is where the endianness bits come from.

> Here you've done one and not the other, which is even worse.  (Sparse would
> have found this, I assume).
>   

Yup, that's definitely wrong.

>> +struct virtio_balloon_stat
>> +{
>> +	__le16 tag;
>> +	__le32 val;
>> +};
>>     
>
> Is 32 bits sufficient?  A big machine might get over 4bn faults, and certainly
> 4 TB of memory isn't that far away.
>   

I think making the interface u64 and byte based would be the best 
solution.  Making assumptions about page size across guest and host is 
another thing we should try to avoid.

Regards,

Anthony Liguori
