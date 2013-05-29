From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 29 May 2013 13:08:09 +0300
Message-ID: <20130529100809.GO4472@redhat.com>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au> <20130529082440.GE4472@redhat.com>
	<CAFEAcA_ezTD_mg7tVOM5P4Od3VxOxPB6eKWTUknY3Fh=Gq6V6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAFEAcA_ezTD_mg7tVOM5P4Od3VxOxPB6eKWTUknY3Fh=Gq6V6g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 29, 2013 at 10:00:33AM +0100, Peter Maydell wrote:
> On 29 May 2013 09:24, Michael S. Tsirkin <mst@redhat.com> wrote:
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index f4db224..fd09ea7 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -467,51 +467,70 @@ static uint64_t virtio_pci_config_common_read(void *opaque, hwaddr addr,
> >  {
> >      VirtIOPCIProxy *proxy = opaque;
> >      VirtIODevice *vdev = proxy->vdev;
> > +    struct virtio_pci_common_cfg cfg;
> >
> >      uint64_t low = 0xffffffffull;
> >
> >      switch (addr) {
> >      case offsetof(struct virtio_pci_common_cfg, device_feature_select):
> > +        assert(size == sizeof cfg.device_feature_select);
> >          return proxy->device_feature_select;
> 
> Asserting is definitely the wrong thing here, since the
> guest can trigger it.

So?

It's a driver bug. It can reset or crash guest with the same effect,
and it likely will if we let it continue.
assert makes sure we don't let it escalate into some
hard to debug security problem.


> If you really want to use offsetof like this you're
> going to need to decorate the structs with QEMU_PACKED.
> 
> thanks
> -- PMM

Nope.
These structs are carefully designed not to have any padding.

And if there was a bug and there was some padding, we still
can't fix it with PACKED because this structure
is used to interact with the guest code which does not
have the packed attribute.

-- 
MST
