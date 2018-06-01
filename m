From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [virtio-dev] [PATCH] virtio: update the comments for transport
	features
Date: Fri, 1 Jun 2018 18:52:14 +0800
Message-ID: <20180601105214.GA9250__5195.85038205168$1527850220$gmane$org@debian>
References: <20180601102217.21628-1-tiwei.bie@intel.com>
	<20180601124552.6a188454.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180601124552.6a188454.cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 01, 2018 at 12:45:52PM +0200, Cornelia Huck wrote:
> On Fri,  1 Jun 2018 18:22:17 +0800
> Tiwei Bie <tiwei.bie@intel.com> wrote:
> 
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > ---
> > This patch is generated on top of below patch:
> > https://lists.oasis-open.org/archives/virtio-dev/201805/msg00212.html
> > 
> >  include/uapi/linux/virtio_config.h | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> > index b7c1f4e7d59e..479affd903e9 100644
> > --- a/include/uapi/linux/virtio_config.h
> > +++ b/include/uapi/linux/virtio_config.h
> > @@ -45,9 +45,12 @@
> >  /* We've given up on this device. */
> >  #define VIRTIO_CONFIG_S_FAILED		0x80
> >  
> > -/* Some virtio feature bits (currently bits 28 through 32) are reserved for the
> > - * transport being used (eg. virtio_ring), the rest are per-device feature
> > - * bits. */
> > +/*
> > + * Some virtio feature bits (currently bits VIRTIO_TRANSPORT_F_START
> > + * through VIRTIO_TRANSPORT_F_END) are reserved for the transport being
> 
> It will always be bits up to VIRTIO_TRANSPORT_F_END, no? So you can drop
> the "currently"?
> 
> Or reword as "Virtio feature bits VIRTIO_TRANSPORT_F_START through
> VIRTIO_TRANSPORT_F_END are reserved..."?

I will do it. Thanks for the suggestion!

Best regards,
Tiwei Bie
