From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Tue, 28 May 2013 20:32:57 +0300
Message-ID: <20130528173257.GC30296@redhat.com>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87bo7vvxej.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 28, 2013 at 12:15:16PM -0500, Anthony Liguori wrote:
> > @@ -455,6 +462,226 @@ static void virtio_pci_config_write(void *opaque, hwaddr addr,
> >      }
> >  }
> >  
> > +static uint64_t virtio_pci_config_common_read(void *opaque, hwaddr addr,
> > +                                              unsigned size)
> > +{
> > +    VirtIOPCIProxy *proxy = opaque;
> > +    VirtIODevice *vdev = proxy->vdev;
> > +
> > +    uint64_t low = 0xffffffffull;
> > +
> > +    switch (addr) {
> > +    case offsetof(struct virtio_pci_common_cfg, device_feature_select):
> > +        return proxy->device_feature_select;
> 
> Oh dear no...  Please use defines like the rest of QEMU.

Any good reason not to use offsetof?
I see about 138 examples in qemu.

Anyway, that's the way Rusty wrote it in the kernel header -
I started with defines.
If you convince Rusty to switch I can switch too,
but I prefer reusing same structures as linux even if
for now I've given up on reusing same headers.


> >From a QEMU pov, take a look at:
> 
> https://github.com/aliguori/qemu/commit/587c35c1a3fe90f6af0f97927047ef4d3182a659
> 
> And:
> 
> https://github.com/aliguori/qemu/commit/01ba80a23cf2eb1e15056f82b44b94ec381565cb
> 
> Which lets virtio-pci be subclassable and then remaps the config space to
> BAR2.


Interesting. Have the spec anywhere?
You are saying this is going to conflict because
of BAR2 usage, yes?

So let's only do this virtio-fb only for new layout, so we don't need
to maintain compatibility. In particular, we are working
on making memory BAR access fast for virtio devices
in a generic way. At the moment they are measureably slower
than PIO on x86.


> Haven't looked at the proposed new ring layout yet.
> 
> Regards,

No new ring layout. It's new config layout.


-- 
MST
