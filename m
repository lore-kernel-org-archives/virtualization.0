From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v2 2/2] virtio_balloon: replace oom notifier with shrinker
Date: Thu, 02 Aug 2018 18:32:44 +0800
Message-ID: <5B62DDCC.3030100__39019.0440150493$1533205581$gmane$org@intel.com>
References: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com>
	<1532683495-31974-3-git-send-email-wei.w.wang@intel.com>
	<20180730090041.GC24267@dhcp22.suse.cz>
	<5B619599.1000307@intel.com>
	<20180801113444.GK16767@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180801113444.GK16767@dhcp22.suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michal Hocko <mhocko@kernel.org>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/01/2018 07:34 PM, Michal Hocko wrote:
> On Wed 01-08-18 19:12:25, Wei Wang wrote:
>> On 07/30/2018 05:00 PM, Michal Hocko wrote:
>>> On Fri 27-07-18 17:24:55, Wei Wang wrote:
>>>> The OOM notifier is getting deprecated to use for the reasons mentioned
>>>> here by Michal Hocko: https://lkml.org/lkml/2018/7/12/314
>>>>
>>>> This patch replaces the virtio-balloon oom notifier with a shrinker
>>>> to release balloon pages on memory pressure.
>>> It would be great to document the replacement. This is not a small
>>> change...
>> OK. I plan to document the following to the commit log:
>>
>>    The OOM notifier is getting deprecated to use for the reasons:
>>      - As a callout from the oom context, it is too subtle and easy to
>>        generate bugs and corner cases which are hard to track;
>>      - It is called too late (after the reclaiming has been performed).
>>        Drivers with large amuont of reclaimable memory is expected to be
>>        released them at an early age of memory pressure;
>>      - The notifier callback isn't aware of the oom contrains;
>>      Link: https://lkml.org/lkml/2018/7/12/314
>>
>>      This patch replaces the virtio-balloon oom notifier with a shrinker
>>      to release balloon pages on memory pressure. Users can set the amount of
>>      memory pages to release each time a shrinker_scan is called via the
>>      module parameter balloon_pages_to_shrink, and the default amount is 256
>>      pages. Historically, the feature VIRTIO_BALLOON_F_DEFLATE_ON_OOM has
>>      been used to release balloon pages on OOM. We continue to use this
>>      feature bit for the shrinker, so the shrinker is only registered when
>>      this feature bit has been negotiated with host.
> Do you have any numbers for how does this work in practice?

It works in this way: for example, we can set the parameter, 
balloon_pages_to_shrink, to shrink 1GB memory once shrink scan is 
called. Now, we have a 8GB guest, and we balloon out 7GB. When shrink 
scan is called, the balloon driver will get back 1GB memory and give 
them back to mm, then the ballooned memory becomes 6GB.

When the shrinker scan is called the second time, another 1GB will be 
given back to mm. So the ballooned pages are given back to mm gradually.

> Let's say
> you have a medium page cache workload which triggers kswapd to do a
> light reclaim? Hardcoded shrinking sounds quite dubious to me but I have
> no idea how people expect this to work. Shouldn't this be more
> adaptive? How precious are those pages anyway?

Those pages are given to host to use usually because the guest has 
enough free memory, and host doesn't want to waste those pieces of 
memory as they are not used by this guest. When the guest needs them, it 
is reasonable that the guest has higher priority to take them back.
But I'm not sure if there would be a more adaptive approach than 
"gradually giving back as the guest wants more".

Best,
Wei
