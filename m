From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Date: Thu, 6 Feb 2020 04:31:01 -0500
Message-ID: <20200206042824-mutt-send-email-mst@kernel.org>
References: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
 <20200206035749-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F73E4238A5@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F73E4238A5@shsmsx102.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "tysand@google.com" <tysand@google.com>, "david@redhat.com" <david@redhat.com>, "alexander.h.duyck@linux.intel.com" <alexander.h.duyck@linux.intel.com>, "rientjes@google.com" <rientjes@google.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "namit@vmware.com" <namit@vmware.com>, "penguin-kernel@i-love.sakura.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 06, 2020 at 09:27:04AM +0000, Wang, Wei W wrote:
> On Thursday, February 6, 2020 5:04 PM, Michael S. Tsirkin wrote:
> > virtio_balloon_shrinker_count(struct shrinker *shrinker,
> > >  					struct virtio_balloon, shrinker);
> > >  	unsigned long count;
> > >
> > > -	count = vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
> > > +	if (conservative_shrinker && global_node_page_state(NR_FILE_PAGES))
> > 
> > I'd rather have an API for that in mm/. In particular, do we want other
> > shrinkers to run, not just pagecache? To pick an example I'm familiar
> > with, kvm mmu cache for nested virt?
> 
> We could make it extendable:
> 
> #define BALLOON_SHRINKER_AFTER_PAGE_CACHE	(1 << 0)
> #define BALLOON_SHRINKER_AFTER_KVM_MMU_CACHE	(1 << 1)
> ...
> 
> uint64_t conservative_shrinker;
> if ((conservative_shrinker | BALLOON_SHRINKER_AFTER_PAGE_CACHE) && global_node_page_state(NR_FILE_PAGES))
> 	return 0;
> 
> For now, we probably only need BALLOON_SHRINKER_AFTER_PAGE_CACHE.
> 
> Best,
> Wei

How about just making this a last resort thing to be compatible with
existing hypervisors? if someone wants to change behaviour
that really should use a feature bit ...

-- 
MST
