From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date: Fri, 14 Feb 2020 15:06:41 +0100
Message-ID: <20200214140641.GB31689@dhcp22.suse.cz>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-4-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200205163402.42627-4-david@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Tyler Sanderson <tysand@google.com>, linux-mm@kvack.org, Nadav Amit <namit@vmware.com>, David Rientjes <rientjes@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed 05-02-20 17:34:02, David Hildenbrand wrote:
> Commit 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker")
> changed the behavior when deflation happens automatically. Instead of
> deflating when called by the OOM handler, the shrinker is used.
> 
> However, the balloon is not simply some slab cache that should be
> shrunk when under memory pressure. The shrinker does not have a concept of
> priorities, so this behavior cannot be configured.

Adding a priority to the shrinker doesn't sound like a big problem to
me. Shrinkers already get shrink_control data structure already and
priority could be added there.

> There was a report that this results in undesired side effects when
> inflating the balloon to shrink the page cache. [1]
> 	"When inflating the balloon against page cache (i.e. no free memory
> 	 remains) vmscan.c will both shrink page cache, but also invoke the
> 	 shrinkers -- including the balloon's shrinker. So the balloon
> 	 driver allocates memory which requires reclaim, vmscan gets this
> 	 memory by shrinking the balloon, and then the driver adds the
> 	 memory back to the balloon. Basically a busy no-op."
> 
> The name "deflate on OOM" makes it pretty clear when deflation should
> happen - after other approaches to reclaim memory failed, not while
> reclaiming. This allows to minimize the footprint of a guest - memory
> will only be taken out of the balloon when really needed.
> 
> Especially, a drop_slab() will result in the whole balloon getting
> deflated - undesired.

Could you explain why some more? drop_caches shouldn't be really used in
any production workloads and if somebody really wants all the cache to
be dropped then why is balloon any different?

-- 
Michal Hocko
SUSE Labs
