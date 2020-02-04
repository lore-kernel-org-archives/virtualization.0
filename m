From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Balloon pressuring page cache
Date: Tue, 4 Feb 2020 11:50:19 -0500
Message-ID: <20200204114336-mutt-send-email-mst@kernel.org>
References: <75d4594f-0864-5172-a0f8-f97affedb366@redhat.com>
 <286AC319A985734F985F78AFA26841F73E3F8A02@shsmsx102.ccr.corp.intel.com>
 <CAJuQAmqcayaNuG19fKCuux=YVO3+VcN-qrXvobgKMykogeMkzA@mail.gmail.com>
 <20200203080520-mutt-send-email-mst@kernel.org>
 <5ac131de8e3b7fc1fafd05a61feb5f6889aeb917.camel@linux.intel.com>
 <c836a8d1-c5cc-eb8b-84ed-027070b77bf8@redhat.com>
 <539B606A-A0CA-4AA4-B99A-759C874A1EF8@vmware.com>
 <d69eafb4-ad0d-1617-9248-ea4fc776da58@redhat.com>
 <20200204033657-mutt-send-email-mst@kernel.org>
 <ce93331c-0099-dda7-e00f-126bf7826a40@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <ce93331c-0099-dda7-e00f-126bf7826a40@redhat.com>
Content-Disposition: inline
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
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Tyler Sanderson <tysand@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Nadav Amit <namit@vmware.com>, David Rientjes <rientjes@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 04, 2020 at 03:30:19PM +0100, David Hildenbrand wrote:
> On 04.02.20 09:40, Michael S. Tsirkin wrote:
> > On Tue, Feb 04, 2020 at 09:35:21AM +0100, David Hildenbrand wrote:
> >>>>> I would say reverting probably makes sense. I'm not sure there is much
> >>>>> value to having a shrinker running deflation when you are actively trying
> >>>>> to increase the balloon. It would make more sense to wait until you are
> >>>>> actually about to start hitting oom.
> >>>>
> >>>> I think the shrinker makes sense for free page hinting feature
> >>>> (everything on free_page_list).
> >>>>
> >>>> So instead of only reverting, I think we should split it up and always
> >>>> register the shrinker for VIRTIO_BALLOON_F_FREE_PAGE_HINT and the OOM
> >>>> notifier (as before) for VIRTIO_BALLOON_F_MUST_TELL_HOST.
> >>
> >> s/VIRTIO_BALLOON_F_MUST_TELL_HOST/VIRTIO_BALLOON_F_DEFLATE_ON_OOM/
> >>
> >> :)
> > 
> > Well VIRTIO_BALLOON_F_MUST_TELL_HOST is also broken by shrinker
> > with VIRTIO_BALLOON_F_FREE_PAGE_HINT as that code adds buffers
> > but does not wait for them to be used even with VIRTIO_BALLOON_F_MUST_TELL_HOST.
> > We never noticed because QEMU does not advertize
> > VIRTIO_BALLOON_F_MUST_TELL_HOST.
> 
> So, I am trying to understand how the code is intended to work, but I
> am afraid I am missing something (or to rephrase: I think I found a BUG :) and
> there is lack of proper documentation about this feature).
> 
> a) We allocate pages and add them to the list as long as we are told to do so.
>    We send these pages to the host one by one.
> b) We free all pages once we get a STOP signal. Until then, we keep pages allocated.
> c) When called via the shrinker, we want to free pages from the list, even
> though the hypervisor did not notify us to do so.
> 
> 
> Issue 1: When we unload the balloon driver in the guest in an unlucky event,
> we won't free the pages. We are missing something like (if I am not wrong):
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index b1d2068fa2bd..e2b0925e1e83 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -929,6 +929,10 @@ static void remove_common(struct virtio_balloon *vb)
>                 leak_balloon(vb, vb->num_pages);
>         update_balloon_size(vb);
>  
> +       /* There might be free pages that are being reported: release them. */
> +       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> +               return_free_pages_to_mm(vb, ULONG_MAX);
> +
>         /* Now we reset the device so we can clean up the queues. */
>         vb->vdev->config->reset(vb->vdev);


Indeed.

> 
> Issue 2: When called via the shrinker, (but also to fix Issue 1), it could be
> that we do have VIRTIO_BALLOON_F_MUST_TELL_HOST. I assume this means
> (-ENOCLUE) that we have to wait until the hypervisor notifies us via the STOP? Or
> for which event do we have to wait? Because there is no way to *tell host* here
> that we want to reuse a page. The hypervisor will *tell us* when we can reuse pages.
> For the shrinker it is simple: Don't use the shrinker with
> VIRTIO_BALLOON_F_MUST_TELL_HOST :) . But to fix Issue 1, we *would* have to wait
> until we get a STOP signal. That is not really possible because it might
> take an infinite amount of time.
> 
> Michael, any clue on which event we have to wait with
> VIRTIO_BALLOON_F_MUST_TELL_HOST? IMHO, I don't think
> VIRTIO_BALLOON_F_MUST_TELL_HOST applies to VIRTIO_BALLOON_F_FREE_PAGE_HINT and
> we'd better document that. It introduces complexity with no clear benefit.

I meant that we must wait for host to see the hint. Signalled via using
the buffer.  But maybe that's too far in the meaning from
VIRTIO_BALLOON_F_MUST_TELL_HOST and we need a separate new flag for
that. Then current code won't be broken (yay!) but we need to
document another flag that's pretty similar.

> 
> -- 
> Thanks,
> 
> David / dhildenb
