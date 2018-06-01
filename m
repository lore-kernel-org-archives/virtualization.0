From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [PATCH v2] virtio: update the comments for transport features
Date: Fri, 1 Jun 2018 19:22:50 +0800
Message-ID: <20180601112250.GA11839__31973.1404343203$1527852056$gmane$org@debian>
References: <20180601105950.10632-1-tiwei.bie@intel.com>
	<20180601131647.5d02da18.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180601131647.5d02da18.cohuck@redhat.com>
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

On Fri, Jun 01, 2018 at 01:16:47PM +0200, Cornelia Huck wrote:
> On Fri,  1 Jun 2018 18:59:50 +0800
> Tiwei Bie <tiwei.bie@intel.com> wrote:
> 
> > The existing comments for transport features are out dated.
> 
> s/out dated/outdated/

Thanks for catching this typo!

> 
[...]
> > +/*
> > + * Virtio feature bits VIRTIO_TRANSPORT_F_START through
> > + * VIRTIO_TRANSPORT_F_END are reserved for the transport
> > + * being used (e.g. virtio_ring, virtio_pci etc.), the
> > + * rest are per-device feature bits.
> > + */
> >  #define VIRTIO_TRANSPORT_F_START	28
> >  #define VIRTIO_TRANSPORT_F_END		38
> >  
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thanks for your review!

Best regards,
Tiwei Bie
