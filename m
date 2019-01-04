From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 2/2] virtio: document virtio_config_ops restrictions
Date: Fri, 4 Jan 2019 13:48:55 +0100
Message-ID: <20190104134855.72418c51.cohuck@redhat.com>
References: <20190103160804.21438-1-cohuck@redhat.com>
	<20190103160804.21438-3-cohuck@redhat.com>
	<20190103182849.7b0b0f0b@oc2783563651>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190103182849.7b0b0f0b@oc2783563651>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 3 Jan 2019 18:28:49 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu,  3 Jan 2019 17:08:04 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > Some transports (e.g. virtio-ccw) implement virtio operations that
> > seem to be a simple read/write as something more involved that
> > cannot be done from an atomic context.
> > 
> > Give at least a hint about that.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  include/linux/virtio_config.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index 7087ef946ba7..987b6491b946 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -12,6 +12,11 @@ struct irq_affinity;
> >  
> >  /**
> >   * virtio_config_ops - operations for configuring a virtio device
> > + * Note: Do not assume that a transport implements all of the operations
> > + *       getting/setting a value as a simple read/write! Generally speaking,
> > + *       any of @get/@set, @get_status/@set_status, or @get_features/
> > + *       @finalize_features are NOT safe to be called from an atomic
> > + *       context.  
> 
> I think the only exception is @bus_name (and maybe @generation, I don't
> know) because it does not have to 'speak' with the hypervisor. If a
> transport operation has to 'speak' with the hypervisor, we do it by
> making it interpret a channel program. That means not safe to be called
> form atomic context. Or am I missing something?

I explicitly singled out the listed callbacks because they read/write a
value and there might be more to them than meets the eye. I would
assume that nobody expects calling e.g. find_vqs (allocating queues)
from an atomic context to be a good idea :) Maybe I should do
s/Generally speaking/In particular/ ?

That said, it's only a hint; we should add might_sleep as well to
interfaces where it makes sense.
