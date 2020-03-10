From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date: Tue, 10 Mar 2020 17:25:25 -0400
Message-ID: <20200310172114-mutt-send-email-mst@kernel.org>
References: <20200310113854.11515-1-david@redhat.com>
 <alpine.DEB.2.21.2003101204590.90377@chino.kir.corp.google.com>
 <890da35b-1ac2-9c2e-b42d-96d24d3e0f4c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <890da35b-1ac2-9c2e-b42d-96d24d3e0f4c@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtualization@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Tyler Sanderson <tysand@google.com>, Wei Wang <wei.w.wang@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Nadav Amit <namit@vmware.com>, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 10, 2020 at 08:13:19PM +0100, David Hildenbrand wrote:
> > Should this have:
> > 
> > Cc: stable@vger.kernel.org # 4.19+
> 
> I guess as nothing will actually "crash" it's not worth stable.


No - it's a regression, it would be a stable candidate from that POV.
The issue is the patch size - stable rules say:

 - It cannot be bigger than 100 lines, with context.

This is about 200 lines with context.
In practice Fixes: is enough to make a bunch of downstreams pick it up.

-- 
MST
