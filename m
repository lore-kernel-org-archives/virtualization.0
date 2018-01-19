From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v22 2/3] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_VQ
Date: Fri, 19 Jan 2018 14:24:11 +0800
Message-ID: <5A618F0B.4090805__18785.93899678$1516342833$gmane$org@intel.com>
References: <1516165812-3995-1-git-send-email-wei.w.wang@intel.com>
	<1516165812-3995-3-git-send-email-wei.w.wang@intel.com>
	<20180117180337-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180117180337-mutt-send-email-mst@kernel.org>
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
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/18/2018 12:44 AM, Michael S. Tsirkin wrote:
> On Wed, Jan 17, 2018 at 01:10:11PM +0800, Wei Wang wrote:
>>   
>> +static void virtballoon_changed(struct virtio_device *vdev)
>> +{
>> +	struct virtio_balloon *vb = vdev->priv;
>> +	unsigned long flags;
>> +	__u32 cmd_id;
>> +	s64 diff = towards_target(vb);
>> +
>> +	if (diff) {
>> +		spin_lock_irqsave(&vb->stop_update_lock, flags);
>> +		if (!vb->stop_update)
> Why do you ignore stop_update for freeze?
> This means new wq entries can be added during remove
> causing use after free issues.

I think stop_update isn't needed, because the lock has already been 
handled internally by the APIs. Similar examples like 
mem_cgroup_css_free() in "mm/memcontrol.c", there is no such locks used 
for cancel_work_sync(&memcg->high_work).

Best,
Wei
