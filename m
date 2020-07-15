From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 6/7] ifcvf: replace irq_request/free with helpers in vDPA
 core.
Date: Wed, 15 Jul 2020 06:01:29 -0400
Message-ID: <20200715055538-mutt-send-email-mst@kernel.org>
References: <1594565366-3195-1-git-send-email-lingshan.zhu@intel.com>
 <1594565366-3195-6-git-send-email-lingshan.zhu@intel.com>
 <c7d4eca1-b65a-b795-dfa6-fe7658716cb1@redhat.com>
 <f6fc09e2-7a45-aaa5-2b4a-f1f963c5ce2c@intel.com>
 <09e67c20-dda1-97a2-1858-6a543c64fba6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <09e67c20-dda1-97a2-1858-6a543c64fba6@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>, alex.williamson@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com, wanpengli@tencent.com, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, netdev@vger.kernel.org, dan.daly@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 15, 2020 at 04:40:17PM +0800, Jason Wang wrote:
> 
> On 2020/7/13 下午6:22, Zhu, Lingshan wrote:
> > 
> > 
> > On 7/13/2020 4:33 PM, Jason Wang wrote:
> > > 
> > > On 2020/7/12 下午10:49, Zhu Lingshan wrote:
> > > > This commit replaced irq_request/free() with helpers in vDPA
> > > > core, so that it can request/free irq and setup irq offloading
> > > > on order.
> > > > 
> > > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > > ---
> > > >   drivers/vdpa/ifcvf/ifcvf_main.c | 11 ++++++-----
> > > >   1 file changed, 6 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c
> > > > b/drivers/vdpa/ifcvf/ifcvf_main.c
> > > > index f5a60c1..65b84e1 100644
> > > > --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> > > > +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> > > > @@ -47,11 +47,12 @@ static void ifcvf_free_irq(struct
> > > > ifcvf_adapter *adapter, int queues)
> > > >   {
> > > >       struct pci_dev *pdev = adapter->pdev;
> > > >       struct ifcvf_hw *vf = &adapter->vf;
> > > > +    struct vdpa_device *vdpa = &adapter->vdpa;
> > > >       int i;
> > > >           for (i = 0; i < queues; i++)
> > > > -        devm_free_irq(&pdev->dev, vf->vring[i].irq, &vf->vring[i]);
> > > > +        vdpa_free_vq_irq(&pdev->dev, vdpa, vf->vring[i].irq, i,
> > > > &vf->vring[i]);
> > > >         ifcvf_free_irq_vectors(pdev);
> > > >   }
> > > > @@ -60,6 +61,7 @@ static int ifcvf_request_irq(struct
> > > > ifcvf_adapter *adapter)
> > > >   {
> > > >       struct pci_dev *pdev = adapter->pdev;
> > > >       struct ifcvf_hw *vf = &adapter->vf;
> > > > +    struct vdpa_device *vdpa = &adapter->vdpa;
> > > >       int vector, i, ret, irq;
> > > >         ret = pci_alloc_irq_vectors(pdev, IFCVF_MAX_INTR,
> > > > @@ -73,6 +75,7 @@ static int ifcvf_request_irq(struct
> > > > ifcvf_adapter *adapter)
> > > >            pci_name(pdev));
> > > >       vector = 0;
> > > >       irq = pci_irq_vector(pdev, vector);
> > > > +    /* config interrupt */
> > > 
> > > 
> > > Unnecessary changes.
> > This is to show we did not setup this irq offloading for config
> > interrupt, only setup irq offloading for data vq. But can remove this
> > since we have config_msix_name in code to show what it is
> 
> 
> Btw, any reason for not making config interrupt work for irq offloading? I
> don't see any thing that blocks this.
> 
> Thanks

Well config accesses all go through userspace right?
Doing config interrupt directly would just be messy ...


> 
> > Thanks BR Zhu Lingshan
> > > 
