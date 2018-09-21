From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost/scsi: truncate T10 PI iov_iter to prot_bytes
Date: Fri, 21 Sep 2018 13:57:32 -0400
Message-ID: <20180921135710-mutt-send-email-mst@kernel.org>
References: <20180822192153.24217-1-gedwards@ddn.com>
	<20180921174912.GA19193@psuche>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180921174912.GA19193@psuche>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Edwards <gedwards@ddn.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mike Christie <mchristi@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 21, 2018 at 11:49:12AM -0600, Greg Edwards wrote:
> On Wed, Aug 22, 2018 at 01:21:53PM -0600, Greg Edwards wrote:
> > Commands with protection information included were not truncating the
> > protection iov_iter to the number of protection bytes in the command.
> > This resulted in vhost_scsi mis-calculating the size of the protection
> > SGL in vhost_scsi_calc_sgls(), and including both the protection and
> > data SG entries in the protection SGL.
> >
> > Fixes: 09b13fa8c1a1 ("vhost/scsi: Add ANY_LAYOUT support in vhost_scsi_handle_vq")
> > Signed-off-by: Greg Edwards <gedwards@ddn.com>
> 
> 
> Any thoughts on this patch?


Paolo could you comment on the virtio-scsi aspects pls?

> 
> > ---
> >  drivers/vhost/scsi.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > index 76f8d649147b..cbe0ea26c1ff 100644
> > --- a/drivers/vhost/scsi.c
> > +++ b/drivers/vhost/scsi.c
> > @@ -964,7 +964,8 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
> >  				prot_bytes = vhost32_to_cpu(vq, v_req_pi.pi_bytesin);
> >  			}
> >  			/*
> > -			 * Set prot_iter to data_iter, and advance past any
> > +			 * Set prot_iter to data_iter and truncate it to
> > +			 * prot_bytes, and advance data_iter past any
> >  			 * preceeding prot_bytes that may be present.
> >  			 *
> >  			 * Also fix up the exp_data_len to reflect only the
> > @@ -973,6 +974,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
> >  			if (prot_bytes) {
> >  				exp_data_len -= prot_bytes;
> >  				prot_iter = data_iter;
> > +				iov_iter_truncate(&prot_iter, prot_bytes);
> >  				iov_iter_advance(&data_iter, prot_bytes);
> >  			}
> >  			tag = vhost64_to_cpu(vq, v_req_pi.tag);
> > --
> > 2.17.1
