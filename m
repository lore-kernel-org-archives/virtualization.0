From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v28 0/4] Virtio-balloon: support free page reporting
Date: Mon, 26 Feb 2018 12:01:29 +0800
Message-ID: <5A938699.8020804__32156.7104584121$1519617403$gmane$org@intel.com>
References: <1518083420-11108-1-git-send-email-wei.w.wang@intel.com>
	<20180208215048-mutt-send-email-mst@kernel.org>
	<5A7D116B.9070502@intel.com>
	<20180209051212-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180209051212-mutt-send-email-mst@kernel.org>
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
Cc: "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "riel@redhat.com" <riel@redhat.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "nilal@redhat.com" <nilal@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "huangzhichao@huawei.com" <huangzhichao@huawei.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 02/09/2018 11:14 AM, Michael S. Tsirkin wrote:
> On Fri, Feb 09, 2018 at 11:11:39AM +0800, Wei Wang wrote:
>> On 02/09/2018 03:55 AM, Michael S. Tsirkin wrote:
>>> On Thu, Feb 08, 2018 at 05:50:16PM +0800, Wei Wang wrote:
>>>
>>>> Details:
>>>> Set up a Ping-Pong local live migration, where the guest ceaselessy
>>>> migrates between the source and destination. Linux compilation,
>>>> i.e. make bzImage -j4, is performed during the Ping-Pong migration. The
>>>> legacy case takes 5min14s to finish the compilation. With this
>>>> optimization patched, it takes 5min12s.
>>> How is migration time affected in this case?
>>
>> When the linux compilation workload runs, the migration time (both the
>> legacy and this optimization case) varies as the compilation goes on. It
>> seems not easy to give a static speedup number, some times the migration
>> time is reduced to 33%, sometimes to 50%, it varies, and depends on how much
>> free memory the system has at that moment. For example, at the later stage
>> of the compilation, I can observe 5GB memory being used as page cache. But
>> overall, I can observe obvious improvement of the migration time.
>>
>>
>> Best,
>> Wei
> You can run multiple tests and give a best, worst and median numbers.
>

Sorry for my late response (I was on leaves for some other 
responsibilities).

Here are some more numbers of the live migration time comparison while 
linux compilation is in progress (probably the average time is more 
relevant)

average: 52.4% reduction (optimization v.s. legacy = 1242ms v.s. 2611ms)
best: 69.1%
worst: 21.9%


Best,
Wei
