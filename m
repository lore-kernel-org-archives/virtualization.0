From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: Balloon pressuring page cache
Date: Wed, 5 Feb 2020 06:49:23 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73E41F0F0@shsmsx102.ccr.corp.intel.com>
References: <91270a68-ff48-88b0-219c-69801f0c252f@redhat.com>
 <CAJuQAmoaK0Swytu2Os_SQRfG5_LqiCPaDa9yatatm9MtfncNTQ@mail.gmail.com>
 <75d4594f-0864-5172-a0f8-f97affedb366@redhat.com>
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
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Tyler Sanderson <tysand@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Nadav Amit <namit@vmware.com>, David Rientjes <rientjes@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday, February 4, 2020 10:30 PM, David Hildenbrand wrote:
> So, I am trying to understand how the code is intended to work, but I am
> afraid I am missing something (or to rephrase: I think I found a BUG :) and
> there is lack of proper documentation about this feature).
> 
> a) We allocate pages and add them to the list as long as we are told to do
> so.
>    We send these pages to the host one by one.
> b) We free all pages once we get a STOP signal. Until then, we keep pages
> allocated.

Yes. Either host sends to the guest a STOP cmd or when the guest fails to allocate a page (meaning that all the possible free pages are taken already),
the reporting ends.

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
> @@ -929,6 +929,10 @@ static void remove_common(struct virtio_balloon
> *vb)
>                 leak_balloon(vb, vb->num_pages);
>         update_balloon_size(vb);
> 
> +       /* There might be free pages that are being reported: release them.
> */
> +       if (virtio_has_feature(vb->vdev,
> VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> +               return_free_pages_to_mm(vb, ULONG_MAX);
> +
>         /* Now we reset the device so we can clean up the queues. */
>         vb->vdev->config->reset(vb->vdev);


Right, thanks!

> 
> 
> Issue 2: When called via the shrinker, (but also to fix Issue 1), it could be that
> we do have VIRTIO_BALLOON_F_MUST_TELL_HOST. 

I don't think it is an issue here.
MUST_TELL_HOST is for the ballooning pages, where pages are offered to host to _USE_.
For free page hint, as the name already suggests, it's just a _HINT_ , so in whatever use case,
the host should not take the page to use. So the guest doesn't need to tell host and wait.

Back to the implementation of virtio_balloon_shrinker_scan, which I don't see an issue so far:
shrink_free_pages just return pages to mm without waiting for the ack from host
shrink_balloon_pages goes through leak_balloon which tell_host before release the balloon pages.

Best,
Wei
