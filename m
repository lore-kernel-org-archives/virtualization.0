From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [virtio-dev] RE: [PATCH v1 0/2] Virtio: fix some vq allocation
	issues
Date: Wed, 2 Jan 2019 14:23:38 +0100
Message-ID: <20190102142338.15bfe876.cohuck__8286.04321363873$1546435307$gmane$org@redhat.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
	<c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
	<286AC319A985734F985F78AFA26841F73DEEA8E9@shsmsx102.ccr.corp.intel.com>
	<20181230070600.512bbb8b@oc2783563651>
	<286AC319A985734F985F78AFA26841F73DEEC8DF@shsmsx102.ccr.corp.intel.com>
	<20190101004019.7f20aafa@oc2783563651>
	<20190102105314.0b4e2485.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190102105314.0b4e2485.cohuck@redhat.com>
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
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2 Jan 2019 10:53:14 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 1 Jan 2019 00:40:19 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:

> > As I said, at the moment I don't have a preference regarding the fix,
> > partly because I'm not sure if "reading config inside the handler" is OK
> > or not. Maybe Connie or Michael can help us here. I'm however sure that
> > commit 86a5597 "virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT"
> > breaks virtio-balloon with the ccw transport (i.e. effectively breaks 
> > virtio-balloon on s390): it used to work before and does not work
> > after.  
> 
> Yes, that's unfortunate.
> 
> > 
> > AFAICT tweaking the balloon code may be simpler than tweaking the
> > virtio-ccw (transport code). ccw_io_helper() relies on getting
> > an interrupt when the issued IO is done. If virtio-ccw is buggy, it
> > needs to be fixed, but I'm not sure it is.  
> 
> I would not call virtio-ccw buggy, but it has some constraints that
> virtio-pci apparently doesn't have (and which did not show up so far;
> e.g. virtio-blk schedules a work item on config change, so there's no
> deadlock there.)
> 
> One way to get out of that constraint (don't interact with the config
> space directly in the config changed handler) would be to schedule a
> work item in virtio-ccw that calls virtio_config_changed() for the
> device. My understanding is that delaying the notification to a work
> queue would be fine.

Unfortunately, calling virtio_config_changed() from a work item is not
enough: That function takes the config_lock, and the virtio-ccw code to
get the config both needs to allocate some memory and call schedule :/

The best option really seems to be
- have virtio-balloon move the handling of the config change onto a
  workqueue or something like that, and
- document that you cannot read/write the virtio config space from an
  atomic context

Unless someone has a better idea?
