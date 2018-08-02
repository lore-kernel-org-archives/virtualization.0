From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v2 2/2] virtio_balloon: replace oom notifier with shrinker
Date: Thu, 02 Aug 2018 19:27:40 +0800
Message-ID: <5B62EAAC.8000505__38552.9490341016$1533208886$gmane$org@intel.com>
References: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com>
	<1532683495-31974-3-git-send-email-wei.w.wang@intel.com>
	<20180730090041.GC24267@dhcp22.suse.cz>
	<5B619599.1000307@intel.com>
	<20180801113444.GK16767@dhcp22.suse.cz>
	<5B62DDCC.3030100@intel.com>
	<87d7ae45-79cb-e294-7397-0e45e2af49cd@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87d7ae45-79cb-e294-7397-0e45e2af49cd@I-love.SAKURA.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Michal Hocko <mhocko@kernel.org>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/02/2018 07:00 PM, Tetsuo Handa wrote:
> On 2018/08/02 19:32, Wei Wang wrote:
>> On 08/01/2018 07:34 PM, Michal Hocko wrote:
>>> Do you have any numbers for how does this work in practice?
>> It works in this way: for example, we can set the parameter, balloon_pages_to_shrink,
>> to shrink 1GB memory once shrink scan is called. Now, we have a 8GB guest, and we balloon
>> out 7GB. When shrink scan is called, the balloon driver will get back 1GB memory and give
>> them back to mm, then the ballooned memory becomes 6GB.
> Since shrinker might be called concurrently (am I correct?),

Not sure about it being concurrently, but I think it would be called 
repeatedly as should_continue_reclaim() returns true.


Best,
Wei
