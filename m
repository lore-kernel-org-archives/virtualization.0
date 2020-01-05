From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/2] virtio-balloon: initialize all vq callbacks
Date: Sun, 5 Jan 2020 08:25:16 -0500
Message-ID: <20200105082433-mutt-send-email-mst__46557.7084616356$1578230740$gmane$org@kernel.org>
References: <20200103184044.73568-1-dverkamp@chromium.org>
 <286AC319A985734F985F78AFA26841F73E39205A@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <286AC319A985734F985F78AFA26841F73E39205A@shsmsx102.ccr.corp.intel.com>
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
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jan 05, 2020 at 12:24:11PM +0000, Wang, Wei W wrote:
> On Saturday, January 4, 2020 2:41 AM, Daniel Verkamp wrote:
> > Subject: [PATCH v2 1/2] virtio-balloon: initialize all vq callbacks
> > 
> > Ensure that elements of the callbacks array that correspond to unavailable
> > features are set to NULL; previously, they would be left uninitialized.
> > 
> > Since the corresponding names array elements were explicitly set to NULL,
> > the uninitialized callback pointers would not actually be dereferenced;
> > however, the uninitialized callbacks elements would still be read in 
> > vp_find_vqs_msix() and used to calculate the number of MSI-X vectors
> > required.
> 
> The above description doesn't seem true after your second patch gets applied.
>  
> > Cc: stable@vger.kernel.org
> > Fixes: 86a559787e6f ("virtio-balloon:
> > VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> > ---
> > 
> > v1:
> > https://lists.linuxfoundation.org/pipermail/virtualization/2019-December/04
> > 4829.html
> > 
> > Changes from v1:
> > - Clarified "array" in commit message to "callbacks array"
> > 
> >  drivers/virtio/virtio_balloon.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index 93f995f6cf36..8e400ece9273 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -475,7 +475,9 @@ static int init_vqs(struct virtio_balloon *vb)
> >  	names[VIRTIO_BALLOON_VQ_INFLATE] = "inflate";
> >  	callbacks[VIRTIO_BALLOON_VQ_DEFLATE] = balloon_ack;
> >  	names[VIRTIO_BALLOON_VQ_DEFLATE] = "deflate";
> > +	callbacks[VIRTIO_BALLOON_VQ_STATS] = NULL;
> >  	names[VIRTIO_BALLOON_VQ_STATS] = NULL;
> > +	callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
> 
> Could you remove other redundant NULL initialization well?
> https://lists.linuxfoundation.org/pipermail/virtualization/2019-December/044837.html
> 
> Best,
> Wei

I queued as is, can be tweaked by a patch on top.

-- 
MST
