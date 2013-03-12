From: Asias He <asias@redhat.com>
Subject: Re: [PATCH V2 0/6] tcm_vhost hotplug/hotunplug support and
	locking/flushing fix
Date: Tue, 12 Mar 2013 10:31:09 +0800
Message-ID: <20130312023109.GF1480@hj.localdomain>
References: <1362709307-12554-1-git-send-email-asias@redhat.com>
	<20130311120327.GE23359@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130311120327.GE23359@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 11, 2013 at 02:03:27PM +0200, Michael S. Tsirkin wrote:
> On Fri, Mar 08, 2013 at 10:21:41AM +0800, Asias He wrote:
> > Changes in v2:
> > - Remove code duplication in tcm_vhost_{hotplug,hotunplug}
> > - Fix racing of vs_events_nr
> > - Add flush fix patch to this series
> > Asias He (6):
> >   tcm_vhost: Add missed lock in vhost_scsi_clear_endpoint()
> >   tcm_vhost: Introduce tcm_vhost_check_feature()
> >   tcm_vhost: Introduce tcm_vhost_check_endpoint()
> >   tcm_vhost: Fix vs->vs_endpoint checking in vhost_scsi_handle_vq()
> >   tcm_vhost: Add hotplug/hotunplug support
> >   tcm_vhost: Flush vhost_work in vhost_scsi_flush()
> > 
> 
> Are all these patches bugfixes?

Nope.

> Please don't add any more features in kernel until qemu starts using
> this driver. 

Why? Why should qemu prevent from improving the driver and the benefit
to the other user of the driver? Kvm tool is already using it since last
Aug. This adds the missing disk hotplug support to kvm tool. Plus, this
is not a pure "feature", it is designed in virtio-scsi spec. 

> We put it in kernel after at the KVM forum it looked like
> everyone agrees it's useful and qemu and kvmtool will use it, but it has
> been in kernel since July and qemu patches are still outstanding.

I am working on the qemu bits where Paolo and Nicholas left.

> If only part of the patches are bugfixes could you please separate them
> out and submit for 3.9?

I will separate patch 2 and 5 for hotplug support and others for
bugfixes.

> Thanks,
> 
> >  drivers/vhost/tcm_vhost.c | 243 ++++++++++++++++++++++++++++++++++++++++++++--
> >  drivers/vhost/tcm_vhost.h |  10 ++
> >  2 files changed, 247 insertions(+), 6 deletions(-)
> > 
> > -- 
> > 1.8.1.4

-- 
Asias
