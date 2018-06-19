From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [virtio-dev] Re: [PATCH v33 2/4] virtio-balloon:
	VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Tue, 19 Jun 2018 01:06:48 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7396AA10C__14468.1016718552$1529370289$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
	<1529037793-35521-3-git-send-email-wei.w.wang@intel.com>
	<20180615144000-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F7396A3D04@shsmsx102.ccr.corp.intel.com>
	<20180615171635-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F7396A5CB0@shsmsx102.ccr.corp.intel.com>
	<20180618051637-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180618051637-mutt-send-email-mst@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "'Michael S. Tsirkin'" <mst@redhat.com>
Cc: "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "riel@redhat.com" <riel@redhat.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "nilal@redhat.com" <nilal@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Monday, June 18, 2018 10:29 AM, Michael S. Tsirkin wrote:
> On Sat, Jun 16, 2018 at 01:09:44AM +0000, Wang, Wei W wrote:
> > Not necessarily, I think. We have min(4m_page_blocks / 512, 1024) above,
> so the maximum memory that can be reported is 2TB. For larger guests, e.g.
> 4TB, the optimization can still offer 2TB free memory (better than no
> optimization).
> 
> Maybe it's better, maybe it isn't. It certainly muddies the waters even more.
> I'd rather we had a better plan. From that POV I like what Matthew Wilcox
> suggested for this which is to steal the necessary # of entries off the list.

Actually what Matthew suggested doesn't make a difference here. That method always steal the first free page blocks, and sure can be changed to take more. But all these can be achieved via kmalloc by the caller which is more prudent and makes the code more straightforward. I think we don't need to take that risk unless the MM folks strongly endorse that approach.

The max size of the kmalloc-ed memory is 4MB, which gives us the limitation that the max free memory to report is 2TB. Back to the motivation of this work, the cloud guys want to use this optimization to accelerate their guest live migration. 2TB guests are not common in today's clouds. When huge guests become common in the future, we can easily tweak this API to fill hints into scattered buffer (e.g. several 4MB arrays passed to this API) instead of one as in this version.

This limitation doesn't cause any issue from functionality perspective. For the extreme case like a 100TB guest live migration which is theoretically possible today, this optimization helps skip 2TB of its free memory. This result is that it may reduce only 2% live migration time, but still better than not skipping the 2TB (if not using the feature).

So, for the first release of this feature, I think it is better to have the simpler and more straightforward solution as we have now, and clearly document why it can report up to 2TB free memory.


 
> If that doesn't fly, we can allocate out of the loop and just retry with more
> pages.
> 
> > On the other hand, large guests being large mostly because the guests need
> to use large memory. In that case, they usually won't have that much free
> memory to report.
> 
> And following this logic small guests don't have a lot of memory to report at
> all.
> Could you remind me why are we considering this optimization then?

If there is a 3TB guest, it is 3TB not 2TB mostly because it would need to use e.g. 2.5TB memory from time to time. In the worst case, it only has 0.5TB free memory to report, but reporting 0.5TB with this optimization is better than no optimization. (and the current 2TB limitation isn't a limitation for the 3TB guest in this case)

Best,
Wei
