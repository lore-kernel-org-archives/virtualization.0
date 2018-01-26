From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v25 2/2] virtio-balloon:
	VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Fri, 26 Jan 2018 11:31:19 +0800
Message-ID: <5A6AA107.3000607__11982.5001610026$1516937234$gmane$org@intel.com>
References: <1516871646-22741-1-git-send-email-wei.w.wang@intel.com>
	<1516871646-22741-3-git-send-email-wei.w.wang@intel.com>
	<20180125154708-mutt-send-email-mst@kernel.org>
	<5A6A871C.6040408@intel.com>
	<20180126042649-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180126042649-mutt-send-email-mst@kernel.org>
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

On 01/26/2018 10:42 AM, Michael S. Tsirkin wrote:
> On Fri, Jan 26, 2018 at 09:40:44AM +0800, Wei Wang wrote:
>> On 01/25/2018 09:49 PM, Michael S. Tsirkin wrote:
>>> On Thu, Jan 25, 2018 at 05:14:06PM +0800, Wei Wang wrote:
>>>

>> The controversy is that the free list is not static
>> once the lock is dropped, so everything is dynamically changing, including
>> the state that was recorded. The method we are using is more prudent, IMHO.
>> How about taking the fundamental solution, and seek to improve incrementally
>> in the future?
>>
>>
>> Best,
>> Wei
> I'd like to see kicks happen outside the spinlock. kick with a spinlock
> taken looks like a scalability issue that won't be easy to
> reproduce but hurt workloads at random unexpected times.
>

Is that "kick inside the spinlock" the only concern you have? I think we 
can remove the kick actually. If we check how the host side works, it is 
worthwhile to let the host poll the virtqueue after it receives the cmd 
id from the guest (kick for cmd id isn't within the lock).


Best,
Wei
