From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH v3 0/5] Add a vhost RPMsg API
Date: Fri, 5 Jun 2020 08:34:35 +0200
Message-ID: <20200605063435.GA32302@ubuntu>
References: <20200527180541.5570-1-guennadi.liakhovetski@linux.intel.com>
 <20200604151917-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200604151917-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, kvm@vger.kernel.org, linux-remoteproc@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, virtualization@lists.linux-foundation.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, sound-open-firmware@alsa-project.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael,

Thanks for your review.

On Thu, Jun 04, 2020 at 03:23:37PM -0400, Michael S. Tsirkin wrote:
> On Wed, May 27, 2020 at 08:05:36PM +0200, Guennadi Liakhovetski wrote:
> > v3:
> > - address several checkpatch warnings
> > - address comments from Mathieu Poirier
> > 
> > v2:
> > - update patch #5 with a correct vhost_dev_init() prototype
> > - drop patch #6 - it depends on a different patch, that is currently
> >   an RFC
> > - address comments from Pierre-Louis Bossart:
> >   * remove "default n" from Kconfig
> > 
> > Linux supports RPMsg over VirtIO for "remote processor" /AMP use
> > cases. It can however also be used for virtualisation scenarios,
> > e.g. when using KVM to run Linux on both the host and the guests.
> > This patch set adds a wrapper API to facilitate writing vhost
> > drivers for such RPMsg-based solutions. The first use case is an
> > audio DSP virtualisation project, currently under development, ready
> > for review and submission, available at
> > https://github.com/thesofproject/linux/pull/1501/commits
> > A further patch for the ADSP vhost RPMsg driver will be sent
> > separately for review only since it cannot be merged without audio
> > patches being upstreamed first.
> 
> 
> RPMsg over virtio has several problems. One is that it's
> not specced at all. Before we add more stuff, I'd like so
> see at least an attempt at describing what it's supposed to do.

Sure, I can work on this with the original authors of the virtio-rpmsg 
implementation.

> Another it's out of line with 1.0 spec passing guest
> endian data around. Won't work if host and guest
> endian-ness do not match. Should pass eveything in LE and
> convert.

Yes, I have to fix this, thanks.

> It's great to see it's seeing active development finally.
> Do you think you will have time to address these?

Sure, I'll try to take care of them.

Thanks
Guennadi

> > Guennadi Liakhovetski (5):
> >   vhost: convert VHOST_VSOCK_SET_RUNNING to a generic ioctl
> >   vhost: (cosmetic) remove a superfluous variable initialisation
> >   rpmsg: move common structures and defines to headers
> >   rpmsg: update documentation
> >   vhost: add an RPMsg API
> > 
> >  Documentation/rpmsg.txt          |   6 +-
> >  drivers/rpmsg/virtio_rpmsg_bus.c |  78 +-------
> >  drivers/vhost/Kconfig            |   7 +
> >  drivers/vhost/Makefile           |   3 +
> >  drivers/vhost/rpmsg.c            | 382 +++++++++++++++++++++++++++++++++++++++
> >  drivers/vhost/vhost.c            |   2 +-
> >  drivers/vhost/vhost_rpmsg.h      |  74 ++++++++
> >  include/linux/virtio_rpmsg.h     |  81 +++++++++
> >  include/uapi/linux/rpmsg.h       |   3 +
> >  include/uapi/linux/vhost.h       |   4 +-
> >  10 files changed, 559 insertions(+), 81 deletions(-)
> >  create mode 100644 drivers/vhost/rpmsg.c
> >  create mode 100644 drivers/vhost/vhost_rpmsg.h
> >  create mode 100644 include/linux/virtio_rpmsg.h
> > 
> > -- 
> > 1.9.3
> 
