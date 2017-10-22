From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1 0/3] Virtio-balloon Improvement
Date: Sun, 22 Oct 2017 19:19:45 +0800
Message-ID: <59EC7ED1.2000907__4216.36023461378$1508671086$gmane$org@intel.com>
References: <1508500466-21165-1-git-send-email-wei.w.wang@intel.com>
	<20171022061307-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171022061307-mutt-send-email-mst@kernel.org>
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

On 10/22/2017 11:19 AM, Michael S. Tsirkin wrote:
> On Fri, Oct 20, 2017 at 07:54:23PM +0800, Wei Wang wrote:
>> This patch series intends to summarize the recent contributions made by
>> Michael S. Tsirkin, Tetsuo Handa, Michal Hocko etc. via reporting and
>> discussing the related deadlock issues on the mailinglist. Please check
>> each patch for details.
>>
>> >From a high-level point of view, this patch series achieves:
>> 1) eliminate the deadlock issue fundamentally caused by the inability
>> to run leak_balloon and fill_balloon concurrently;
> We need to think about this carefully. Is it an issue that
> leak can now bypass fill? It seems that we can now
> try to leak a page before fill was seen by host,
> but I did not look into it deeply.
>
> I really like my patch for this better at least for
> current kernel. I agree we need to work more on 2+3.

Yes, we can check more. But from the original intention:
(copied from the commit e22504296d)
balloon_lock (mutex) : synchronizes the access demand to elements of
                               struct virtio_balloon and its queue 
operations;

This implementation has covered what balloon_lock achieves. We have
inflating and deflating decoupled and use a small lock for each vq 
respectively.

I also tested inflating 20G, and before it's done, requested to 
deflating 20G, all work fine.


>
>> 2) enable OOM to release more than 256 inflated pages; and
> Does just this help enough? How about my patch + 2?
> Tetsuo, what do you think?
>
>> 3) stop inflating when the guest is under severe memory pressure
>> (i.e. OOM).
> But when do we finally inflate?  Question is how does host know it needs
> to resend an interrupt, and when should it do it?

I think "when to inflate again" should be a policy defined by the 
orchestration
layer software on the host. A reasonable inflating request should be 
sent to a
guest on the condition that this guest has enough free memory to inflate
(virtio-balloon memory stats has already supported to report that info).

If the policy defines to inflate guest memory without considering 
whether the guest
is even under memory pressure. The mechanism we provide here is to offer 
no pages
to the host in that case. I think this should be reasonable.


Best,
Wei
