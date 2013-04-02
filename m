From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH] tcm_vhost: Use ACCESS_ONCE for vs->vs_tpg[target] access
Date: Tue, 02 Apr 2013 16:42:10 -0700
Message-ID: <1364946130.3898.226.camel@haakon2.linux-iscsi.org>
References: <1364916697-13212-1-git-send-email-asias@redhat.com>
	<20130402153933.GA27410@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130402153933.GA27410@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2013-04-02 at 18:39 +0300, Michael S. Tsirkin wrote:
> On Tue, Apr 02, 2013 at 11:31:37PM +0800, Asias He wrote:
> > In vhost_scsi_handle_vq:
> > 
> >       tv_tpg = vs->vs_tpg[target];
> >       if (!tv_tpg) {
> >               ....
> >               return
> >       }
> > 
> >       tv_cmd = vhost_scsi_allocate_cmd(tv_tpg, &v_req,
> > 
> > 1) vs->vs_tpg[target] might change after the NULL check and 2) the above
> > line might access tv_tpg from vs->vs_tpg[target]. To prevent 2), use
> > ACCESS_ONCE. Thanks mst for catching this up!
> > 
> > Signed-off-by: Asias He <asias@redhat.com>
> 
> OK this might be ok for 3.9.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Nicholas can you pick this up pls?
> 

Applying to target-pending/master now.

> For 3.10 I still think it's best to get rid of it
> and stick vs->vs_tpg in vq->private_data.
> 

Your call here.  Given that vhost-scsi-pci code + Seabios w/ virtio-scsi
enabled will be broken without Asias's two extra vq->private_data and
initialize vq->last_used_idx changes on the list, they will certainly
need to hit 3.9.x code once your happy to ACK for v3.10.

Asias, I assume you'll be updating this soon..?

--nab
