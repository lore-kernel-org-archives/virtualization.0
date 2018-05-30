From: "Duyck, Alexander H" <alexander.h.duyck@intel.com>
Subject: Re: [PATCH] virtio_pci: support enabling VFs
Date: Wed, 30 May 2018 16:54:35 +0000
Message-ID: <1527699273.29907.2.camel__22762.2082028121$1527699180$gmane$org@intel.com>
References: <20180530085521.26583-1-tiwei.bie@intel.com>
	<20180530192010-mutt-send-email-mst@kernel.org>
	<414C18B1-30FA-4AC0-B47D-F0FBF9832737@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <414C18B1-30FA-4AC0-B47D-F0FBF9832737@intel.com>
Content-Language: en-US
Content-ID: <EE63E1D03CDD854B8989945BAE9C2E54@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Rustad, Mark D" <mark.d.rustad@intel.com>, "mst@redhat.com" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Wang,
	Zhihong" <zhihong.wang@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2018-05-30 at 09:44 -0700, Rustad, Mark D wrote:
> On May 30, 2018, at 9:22 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> > > +static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int  
> > > num_vfs)
> > > +{
> > > +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> > > +	struct virtio_device *vdev = &vp_dev->vdev;
> > > +	int (*sriov_configure)(struct pci_dev *pci_dev, int num_vfs);
> > > +
> > > +	if (!(vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK))
> > > +		return -EBUSY;
> > > +
> > > +	if (!__virtio_test_bit(vdev, VIRTIO_F_SR_IOV))
> > > +		return -EINVAL;
> > > +
> > > +	sriov_configure = pci_sriov_configure_simple;
> > > +	if (sriov_configure == NULL)
> > > +		return -ENOENT;
> > 
> > BTW what is all this trickery in aid of?
> 
> When SR-IOV support is not compiled into the kernel,  
> pci_sriov_configure_simple is #defined as NULL. This allows it to compile  
> in that case, even though there is utterly no way for it to be called in  
> that case. It is an alternative to #ifs in the code.

Why even have the call though? I would wrap all of this in an #ifdef
and strip it out since you couldn't support SR-IOV if it isn't present
in the kernel anyway.
