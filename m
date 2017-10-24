From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1 3/3] virtio-balloon: stop inflating when OOM occurs
Date: Tue, 24 Oct 2017 09:58:36 +0800
Message-ID: <59EE9E4C.3030207__45861.8061071776$1508810219$gmane$org@intel.com>
References: <1508500466-21165-1-git-send-email-wei.w.wang@intel.com>
	<1508500466-21165-4-git-send-email-wei.w.wang@intel.com>
	<20171022062159-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171022062159-mutt-send-email-mst@kernel.org>
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
Cc: penguin-kernel@I-love.SAKURA.ne.jp, linux-mm@kvack.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mhocko@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 10/23/2017 01:13 AM, Michael S. Tsirkin wrote:
> On Fri, Oct 20, 2017 at 07:54:26PM +0800, Wei Wang wrote:
>> This patch forces the cease of the inflating work when OOM occurs.
>> The fundamental idea of memory ballooning is to take out some guest
>> pages when the guest has low memory utilization, so it is sensible to
>> inflate nothing when the guest is already under memory pressure.
>>
>> On the other hand, the policy is determined by the admin or the
>> orchestration layer from the host. That is, the host is expected to
>> re-start the memory inflating request at a proper time later when
>> the guest has enough memory to inflate, for example, by checking
>> the memory stats reported by the balloon.
> Is there any other way to do it? And if so can't we just have guest do
> it automatically? Maybe the issue is really that fill attempts to
> allocate memory aggressively instead of checking availability.
> Maybe with deflate on oom it should check availability?
>

I think it might not be easy to do it in the guest in practice.
For example, the host asks for 4G from the guest, and the guest checks
that it has 4G that can be inflated at that point. While it is inflating 
and 2G
is done inflating, another new task on the guest comes out and
takes the remaining 2G to use. Now the guest has nothing to inflate.

This would raise the questions:
1) what is the point of checking the availability?
Maybe we could just let the guest inflate as much as it can, that is, till
balloon_page_enqueue() returns NULL, then stop inflating.

2) How long would the host has to wait for this guest to get the 
remaining 2G?
If I understand "guest do it automatically" correctly: now the guest is 
responsible
for giving another 2G, which he owes to the host in this case - not 
giving up inflating
whenever there is some free memory. Maybe in the next 1 hour it wouldn't 
have any
memory available to give to the host. The time seems non-deterministic.

If we leave it to the host to define the policy, I think it would be easier.
Once the host finds that the guest can only offer 2G, then it can just 
give up asking
for memory from this guest, and continue to check other guests to see if 
it can get
some memory there to satisfy the needs.


Best,
Wei
