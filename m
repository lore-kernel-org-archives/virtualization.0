From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [PATCH v1] virtio: support VIRTIO_F_IO_BARRIER
Date: Thu, 10 May 2018 18:39:41 +0800
Message-ID: <20180510103941.znxka65iluybktuq__31868.2407647886$1525948648$gmane$org@debian>
References: <20180504045915.17693-1-tiwei.bie@intel.com>
	<20180510095317.GO1296@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180510095317.GO1296@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, zhihong.wang@intel.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 10, 2018 at 10:53:17AM +0100, Stefan Hajnoczi wrote:
> On Fri, May 04, 2018 at 12:59:15PM +0800, Tiwei Bie wrote:
> > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> > index 308e2096291f..9fb519a9df28 100644
> > --- a/include/uapi/linux/virtio_config.h
> > +++ b/include/uapi/linux/virtio_config.h
> > @@ -49,7 +49,7 @@
> >   * transport being used (eg. virtio_ring), the rest are per-device feature
> >   * bits. */
> >  #define VIRTIO_TRANSPORT_F_START	28
> > -#define VIRTIO_TRANSPORT_F_END		34
> > +#define VIRTIO_TRANSPORT_F_END		37
> 
> Have you updated "2.2 Feature Bits" in the VIRTIO spec?
> 
> In 1.0 it says:
> 
>  24 to 32
>     Feature bits reserved for extensions to the queue and feature negotiation mechanisms
> 
> This information is out-of-date.
> 

No. In the latest spec draft, it's 24 to 33. And it
becomes out-of-date since VIRTIO_F_RING_PACKED(34)
and VIRTIO_F_IN_ORDER(35) were introduced. Do you
want me to update it in the IO_BARRIER patch or do
you want me to update it in a new patch?

Best regards,
Tiwei Bie
