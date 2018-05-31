From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [PATCH] virtio_pci: support enabling VFs
Date: Thu, 31 May 2018 11:20:49 +0800
Message-ID: <20180531032049.GB15516__26420.3151957647$1527736713$gmane$org@debian>
References: <20180530085521.26583-1-tiwei.bie@intel.com>
	<20180530192010-mutt-send-email-mst@kernel.org>
	<414C18B1-30FA-4AC0-B47D-F0FBF9832737@intel.com>
	<1527699273.29907.2.camel@intel.com>
	<5063D90B-7955-4F1E-85A2-D8AFD661ACB7@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5063D90B-7955-4F1E-85A2-D8AFD661ACB7@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, "Rustad, Mark D" <mark.d.rustad@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Wang,
	Zhihong" <zhihong.wang@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 31, 2018 at 01:11:37AM +0800, Rustad, Mark D wrote:
> On May 30, 2018, at 9:54 AM, Duyck, Alexander H
> <alexander.h.duyck@intel.com> wrote:
> 
> > On Wed, 2018-05-30 at 09:44 -0700, Rustad, Mark D wrote:
> > > On May 30, 2018, at 9:22 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > 
> > > > > +static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int
> > > > > num_vfs)
> > > > > +{
> > > > > +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> > > > > +	struct virtio_device *vdev = &vp_dev->vdev;
> > > > > +	int (*sriov_configure)(struct pci_dev *pci_dev, int num_vfs);
> > > > > +
> > > > > +	if (!(vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK))
> > > > > +		return -EBUSY;
> > > > > +
> > > > > +	if (!__virtio_test_bit(vdev, VIRTIO_F_SR_IOV))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	sriov_configure = pci_sriov_configure_simple;
> > > > > +	if (sriov_configure == NULL)
> > > > > +		return -ENOENT;
> > > > 
> > > > BTW what is all this trickery in aid of?
> > > 
> > > When SR-IOV support is not compiled into the kernel,
> > > pci_sriov_configure_simple is #defined as NULL. This allows it to compile
> > > in that case, even though there is utterly no way for it to be called in
> > > that case. It is an alternative to #ifs in the code.
> > 
> > Why even have the call though? I would wrap all of this in an #ifdef
> > and strip it out since you couldn't support SR-IOV if it isn't present
> > in the kernel anyway.
> 
> I am inclined to agree. In this case, the presence of #ifdefs I think would
> be clearer. As written, someone will want to get rid of the pointer only to
> create a build problem when SR-IOV is not configured.

In my opinion, maybe it would be better to make
pci_sriov_configure_simple() always available
just like other sriov functions.

Based on the comments in the original patch:

https://patchwork.kernel.org/patch/10353197/
"""
+/* this is expected to be used as a function pointer, just define as NULL */
+#define pci_sriov_configure_simple NULL
"""

This function could be defined as NULL just because
it was expected to be used as a function pointer.
But actually it could be called directly as a
function, just like this case.

So I prefer to make this function always available
just like other sriov functions.

Best regards,
Tiwei Bie
