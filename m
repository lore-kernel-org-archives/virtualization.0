From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH] virtio_balloon: fix deadlock on OOM
Date: Thu, 19 Oct 2017 15:59:54 +0800
Message-ID: <59E85B7A.1090800__8933.1001080156$1508399912$gmane$org@intel.com>
References: <1507900754-32239-1-git-send-email-mst@redhat.com>
	<201710132306.FBC78628.OJLHFVQSFOtOMF@I-love.SAKURA.ne.jp>
	<20171018201700-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171018201700-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-mm@kvack.org, mhocko@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 10/19/2017 01:19 AM, Michael S. Tsirkin wrote:
> On Fri, Oct 13, 2017 at 11:06:23PM +0900, Tetsuo Handa wrote:
>> Michael S. Tsirkin wrote:
>>> This is a replacement for
>>> 	[PATCH] virtio: avoid possible OOM lockup at virtballoon_oom_notify()
>>> but unlike that patch it actually deflates on oom even in presence of
>>> lock contention.
>> But Wei Wang is proposing VIRTIO_BALLOON_F_SG which will try to allocate
>> memory, isn't he?
> Hopefully that can be fixed by allocating outside the lock.
>

I think that would still have an issue even without the lock, because we 
can't do
any memory allocation in the OOM code path.

Probably, we could write a separate function, leak_balloon_oom() for the 
oom notifier,
which puts the oom deflating pages to the vq one by one, and kick when 
the vq is full.

In this case, we would need to stop the normal leak_balloon while oom 
deflating starts.
However, a better optimization I think would be to do some kind of 
consolidation, since
leak_balloon is already deflating, leak_ballon_oom can just count the 
number of pages
that have been deflated by leak_balloon and return when it reaches 
oom_pages.


Best,
Wei
