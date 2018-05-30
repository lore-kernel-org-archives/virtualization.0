From: "Duyck, Alexander H" <alexander.h.duyck@intel.com>
Subject: Re: [virtio-dev] [PATCH] virtio_pci: support enabling VFs
Date: Wed, 30 May 2018 16:26:30 +0000
Message-ID: <1527697588.16245.136.camel__131.420829757367$1527697496$gmane$org@intel.com>
References: <20180530085521.26583-1-tiwei.bie@intel.com>
	<CAKgT0UcRZd5ajpTyC3KMvNFACVAb6D8A9Tss3m0r+UdamvVeRA@mail.gmail.com>
	<20180530192215-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180530192215-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-ID: <27BDE5CE4F9BBE428A5669147C2A00EF@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "mst@redhat.com" <mst@redhat.com>, "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Wang,
	Zhihong" <zhihong.wang@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "Rustad,
	Mark D" <mark.d.rustad@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2018-05-30 at 19:22 +0300, Michael S. Tsirkin wrote:
> On Wed, May 30, 2018 at 09:10:57AM -0700, Alexander Duyck wrote:
> > On Wed, May 30, 2018 at 1:55 AM, Tiwei Bie <tiwei.bie@intel.com> wrote:
> > > There is a new feature bit allocated in virtio spec to
> > > support SR-IOV (Single Root I/O Virtualization):
> > > 
> > > https://github.com/oasis-tcs/virtio-spec/issues/11
> > > 
> > > This patch enables the support for this feature bit in
> > > virtio driver.
> > > 
> > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > 
> > So from a quick glance it looks like we are leaving SR-IOV enabled if
> > the driver is removed. Do we want to have that behavior or should we
> > be adding the code to disable SR-IOV and free the VFs on driver
> > removal?
> 
> Could pci core handle it for us somehow?

Maybe, but it would require changes to the pci core to do it.

The problem is some drivers want to leave the VFs there since the PF
doesn't really do anything, or they have the option of essentially
putting the VFs into a standby state when the PF is gone.

My main concern is do we care if VFs are allocated and then somebody
removes the driver and binds a different driver to the interface? If
not then this code and be left as is, but I just wanted to be certain
since I know this isn't just enabling SR-IOV we are having to do a
number of other checks against the virtio device.
