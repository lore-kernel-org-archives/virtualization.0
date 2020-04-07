From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [GIT PULL v2] vhost: cleanups and fixes
Date: Tue, 7 Apr 2020 06:08:43 -0400
Message-ID: <20200407060741-mutt-send-email-mst@kernel.org>
References: <20200407055334-mutt-send-email-mst@kernel.org>
 <00a7ce5f-8fb4-8c3e-7113-9a422682abdf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00a7ce5f-8fb4-8c3e-7113-9a422682abdf@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexander.h.duyck@linux.intel.com, eperezma@redhat.com, jasowang@redhat.com, lingshan.zhu@intel.com, mhocko@kernel.org, namit@vmware.com, rdunlap@infradead.org, rientjes@google.com, tiwei.bie@intel.com, tysand@google.com, wei.w.wang@intel.com, xiao.w.wang@intel.com, yuri.benditovich@daynix.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 07, 2020 at 11:56:59AM +0200, David Hildenbrand wrote:
> On 07.04.20 11:53, Michael S. Tsirkin wrote:
> > Changes from PULL v1:
> > 	reverted a commit that was also in Andrew Morton's tree,
> > 	to resolve a merge conflict:
> > 	this is what Stephen Rothwell was doing to resolve it
> > 	in linux-next.
> > 
> > 
> > Now that many more architectures build vhost, a couple of these (um, and
> > arm with deprecated oabi) have reported build failures with randconfig,
> > however fixes for that need a bit more discussion/testing and will be
> > merged separately.
> > 
> > Not a regression - these previously simply didn't have vhost at all.
> > Also, there's some DMA API code in the vdpa simulator is hacky - if no
> > solution surfaces soon we can always disable it before release:
> > it's not a big deal either way as it's just test code.
> > 
> > 
> > The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:
> > 
> >   Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> > 
> > for you to fetch changes up to 835a6a649d0dd1b1f46759eb60fff2f63ed253a7:
> > 
> >   virtio-balloon: Revert "virtio-balloon: Switch back to OOM handler for VIRTIO_BALLOON_F_DEFLATE_ON_OOM" (2020-04-07 05:44:57 -0400)
> > 
> > ----------------------------------------------------------------
> > virtio: fixes, vdpa
> > 
> > Some bug fixes.
> > The new vdpa subsystem with two first drivers.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ----------------------------------------------------------------
> > David Hildenbrand (1):
> >       virtio-balloon: Switch back to OOM handler for VIRTIO_BALLOON_F_DEFLATE_ON_OOM
> 
> ^ stale leftover in this message only I assume

No - I did not rebase since I did not want to invalidate all the testing
people did, just tacked a revert on top.  So this commit is there
together with its revert.


> 
> -- 
> Thanks,
> 
> David / dhildenb
