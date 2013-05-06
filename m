From: Asias He <asias@redhat.com>
Subject: Re: [PATCH v2 00/11] vhost cleanups
Date: Mon, 6 May 2013 21:19:13 +0800
Message-ID: <20130506131913.GA12160@hj.localdomain>
References: <1367829509-5371-1-git-send-email-asias@redhat.com>
	<20130506100746.GA16938@redhat.com>
	<20130506120526.GA7701@hj.localdomain>
	<20130506131535.GA14821@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130506131535.GA14821@redhat.com>
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
Cc: target-devel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 06, 2013 at 04:15:35PM +0300, Michael S. Tsirkin wrote:
> On Mon, May 06, 2013 at 08:05:26PM +0800, Asias He wrote:
> > On Mon, May 06, 2013 at 01:07:46PM +0300, Michael S. Tsirkin wrote:
> > > On Mon, May 06, 2013 at 04:38:18PM +0800, Asias He wrote:
> > > > MST, This is on top of [PATCH 0/2] vhost-net fix ubuf.
> > > 
> > > Okay, how about making EVENT_IDX work for virtio-scsi?
> > > I'm guessing it's some messup with feature negotiation,
> > > that's what all event-idx bugs came down to so far.
> > 
> > Yes, IIRC, EVENT_IDX works for vhost-scsi now. Will cook a patch to
> > enable it. It should go 3.10, right?
> 
> If it's early in the cycle, I think it can.

Well, let's queue it for 3.11.

> > > > Asias He (11):
> > > >   vhost: Remove vhost_enable_zcopy in vhost.h
> > > >   vhost: Move VHOST_NET_FEATURES to net.c
> > > >   vhost: Make vhost a separate module
> > > >   vhost: Remove comments for hdr in vhost.h
> > > >   vhost: Simplify dev->vqs[i] access
> > > >   vhost-net: Cleanup vhost_ubuf and vhost_zcopy
> > > >   vhost-scsi: Remove unnecessary forward struct vhost_scsi declaration
> > > >   vhost-scsi: Rename struct vhost_scsi *s to *vs
> > > >   vhost-scsi: Make func indention more consistent
> > > >   vhost-scsi: Rename struct tcm_vhost_tpg *tv_tpg to *tpg
> > > >   vhost-scsi: Rename struct tcm_vhost_cmd *tv_cmd to *cmd
> > > > 
> > > >  drivers/vhost/Kconfig  |   8 +
> > > >  drivers/vhost/Makefile |   3 +-
> > > >  drivers/vhost/net.c    |  64 ++++---
> > > >  drivers/vhost/scsi.c   | 470 ++++++++++++++++++++++++++-----------------------
> > > >  drivers/vhost/vhost.c  |  86 +++++++--
> > > >  drivers/vhost/vhost.h  |  11 +-
> > > >  6 files changed, 361 insertions(+), 281 deletions(-)
> > > > 
> > > > -- 
> > > > 1.8.1.4
> > 
> > -- 
> > Asias

-- 
Asias
