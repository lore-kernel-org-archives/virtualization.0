From: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 07/11] vhost: convert vhost_umem_interval_tree to half
	closed intervals
Date: Fri, 4 Oct 2019 12:44:46 -0700
Message-ID: <20191004194446.tomd55ll4nlkelb6@linux-p48b>
References: <20191003201858.11666-1-dave@stgolabs.net>
	<20191003201858.11666-8-dave@stgolabs.net>
	<20191004121021.GA4541@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191004121021.GA4541@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michel Lespinasse <walken@google.com>
Cc: Michael@google.com, peterz@infradead.org, Davidlohr Bueso <dbueso@suse.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, akpm@linux-foundation.org, linux-rdma@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 04 Oct 2019, Michel Lespinasse wrote:

>On Thu, Oct 03, 2019 at 01:18:54PM -0700, Davidlohr Bueso wrote:
>> @@ -1320,15 +1320,14 @@ static bool iotlb_access_ok(struct vhost_virtqueue *vq,
>>  {
>>  	const struct vhost_umem_node *node;
>>  	struct vhost_umem *umem = vq->iotlb;
>> -	u64 s = 0, size, orig_addr = addr, last = addr + len - 1;
>> +	u64 s = 0, size, orig_addr = addr, last = addr + len;
>
>maybe "end" or "end_addr" instead of "last".
>
>> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>> index e9ed2722b633..bb36cb9ed5ec 100644
>> --- a/drivers/vhost/vhost.h
>> +++ b/drivers/vhost/vhost.h
>> @@ -53,13 +53,13 @@ struct vhost_log {
>>  };
>>
>>  #define START(node) ((node)->start)
>> -#define LAST(node) ((node)->last)
>> +#define END(node) ((node)->end)
>>
>>  struct vhost_umem_node {
>>  	struct rb_node rb;
>>  	struct list_head link;
>>  	__u64 start;
>> -	__u64 last;
>> +	__u64 end;
>>  	__u64 size;
>>  	__u64 userspace_addr;
>>  	__u32 perm;
>
>Preferably also rename __subtree_last to __subtree_end

Yes, this was was another one that I had in mind renaming, but
didn't want to grow the series -- all custom interval trees
name _last for the subtree iirc. Like my previous reply, I'd
rather leave this stuff for a followup series.

Thanks,
Davidlohr
