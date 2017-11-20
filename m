From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v17 6/6] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_VQ
Date: Mon, 20 Nov 2017 19:42:40 +0800
Message-ID: <5A12BFB0.5030402__10058.2215389752$1511178063$gmane$org@intel.com>
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>
	<1509696786-1597-7-git-send-email-wei.w.wang@intel.com>
	<5A097548.8000608@intel.com>
	<20171113192309-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171113192309-mutt-send-email-mst@kernel.org>
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
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, willy@infradead.org, quan.xu@aliyun.com, Nitesh Narayan Lal <nilal@redhat.com>, Rik van Riel <riel@redhat.com>, cornelia.huck@de.ibm.com, mhocko@kernel.org, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 11/14/2017 01:32 AM, Michael S. Tsirkin wrote:
> You should Cc Nitesh who is working on a related feature.

OK, I'll do. We have two more issues which haven't been discussed yet, 
please have a check below.

>
> On Mon, Nov 13, 2017 at 06:34:48PM +0800, Wei Wang wrote:
>> Ping for comments, thanks.
>>
>> On 11/03/2017 04:13 PM, Wei Wang wrote:
>>> +static void virtballoon_cmd_report_free_page_start(struct virtio_balloon *vb)
>>> +{
>>> +	unsigned long flags;
>>> +
>>> +	vb->report_free_page_stop = false;
> this flag is used a lot outside any locks. Why is this safe?
> Please add some comments explaining access to this flag.

I will revert the logic as suggested: vb->report_free_page. Also plan to 
simplify its usage as below.

The flag is set or cleared in the config handler according to the 
new_cmd_id given
by the host:

new_cmd_id=0:                    WRITE_ONCE(vb->report_free_page, 
false); // stop reporting
new_cmd_id != old_cmd_id: WRITE_ONCE(vb->report_free_page, true);  // 
start reporting


The flag is read by virtio_balloon_send_free_pages() - the callback to 
report free pages:

if (!READ_ONCE(vb->report_free_page))
                 return false;

I don't find where it could be unsafe then (the flag is written by the 
config handler only).



>
>>> +}
>>> +
>>>    static inline s64 towards_target(struct virtio_balloon *vb)
>>>    {
>>>    	s64 target;
>>> @@ -597,42 +673,147 @@ static void update_balloon_size_func(struct work_struct *work)
>>>    		queue_work(system_freezable_wq, work);
>>>    }
>>> -static int init_vqs(struct virtio_balloon *vb)
>>> +static bool virtio_balloon_send_free_pages(void *opaque, unsigned long pfn,
>>> +					   unsigned long nr_pages)
>>>    {
>>> -	struct virtqueue *vqs[3];
>>> -	vq_callback_t *callbacks[] = { balloon_ack, balloon_ack, stats_request };
>>> -	static const char * const names[] = { "inflate", "deflate", "stats" };
>>> -	int err, nvqs;
>>> +	struct virtio_balloon *vb = (struct virtio_balloon *)opaque;
>>> +	void *addr = (void *)pfn_to_kaddr(pfn);
> How do we know all free pages have a kaddr?

For x86_64, it works well since the kernel has all the physical memory 
mapped already. But for 32-bit kernel, yes, the high memory usually 
isn't mapped and thus no kaddr. Essentially, this pfn_to_kaddr convert 
isn't necessary, we do it here because the current API that virtio has 
is based on "struct scatterlist", which takes a kaddr, and this kaddr is 
then convert back to physical address in virtqueue_add() when assigning 
to desc->addr.

I think a better solution would be to add a new API, which directly 
assigns the caller's guest physical address to desc->addr, similar to 
the previous implementation "add_one_chunk()" 
(https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02452.html). 
But we can change that to a general virtio API:
virtqueue_add_one_desc(struct virtqueue *_vq, u64 base_addr, u32 size, 
bool in_desc, void *data);

What do you think?

Best,
Wei
