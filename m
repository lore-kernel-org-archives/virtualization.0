From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH 2/3] vhost-scsi: new device supporting the tcm_vhost
	Linux kernel module
Date: Wed, 27 Mar 2013 23:28:56 -0700
Message-ID: <1364452136.17698.89.camel__36787.3346353464$1364452174$gmane$org@haakon2.linux-iscsi.org>
References: <1364421586-29857-1-git-send-email-nab@linux-iscsi.org>
	<1364421586-29857-3-git-send-email-nab@linux-iscsi.org>
	<20130327222856.GC12518@redhat.com>
	<1364424342.17698.31.camel@haakon2.linux-iscsi.org>
	<20130327225021.GA12858@redhat.com> <20130327225349.GA12927@redhat.com>
	<1364426662.17698.41.camel@haakon2.linux-iscsi.org>
	<20130328061919.GA16678@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130328061919.GA16678@redhat.com>
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
Cc: kvm-devel <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2013-03-28 at 08:19 +0200, Michael S. Tsirkin wrote:
> On Wed, Mar 27, 2013 at 04:24:22PM -0700, Nicholas A. Bellinger wrote:
> > On Thu, 2013-03-28 at 00:53 +0200, Michael S. Tsirkin wrote:
> > > On Thu, Mar 28, 2013 at 12:50:21AM +0200, Michael S. Tsirkin wrote:
> > > > On Wed, Mar 27, 2013 at 03:45:42PM -0700, Nicholas A. Bellinger wrote:
> > > > > On Thu, 2013-03-28 at 00:28 +0200, Michael S. Tsirkin wrote:
> > > > > > On Wed, Mar 27, 2013 at 09:59:45PM +0000, Nicholas A. Bellinger wrote:
> > > > > > > From: Paolo Bonzini <pbonzini@redhat.com>
> > > > > > > 
> > > > > > > The WWPN specified in configfs is passed to "-device vhost-scsi-pci".
> > > > > > > The tgpt field of the SET_ENDPOINT ioctl is obsolete now, so it is not
> > > > > > > available from the QEMU command-line.  Instead, I hardcode it to zero.
> > > > > > > 
> > > > > > > Changes in V4:
> > > > > > >    - Set event_idx=off by default (nab, thanks asias)
> > > > > > 
> > > > > > Why? What's going on here?
> > > > > > 
> > > > > 
> > > > > Not disabling event_idx by default, or disabling from the command line
> > > > > ends up resulting in ->handle_kick() not getting called for subsequent
> > > > > commands..
> > > > > 
> > > > > I spent some time trying to track this down recently with no luck, and
> > > > > AFAICT it's always been required in order for vhost-scsi to function.
> > > > 
> > > > Hmm this is a bug in kernel then. A better work-around is
> > > > to disable EVENT_IDX in kernel. Let's do it for 3.9?
> > > 
> > > But before we do, can you check that SET_FEATURES is
> > > called with this bit set if you enable event_idx?
> > > If not that's your bug then ...
> > > 
> > 
> > Ok, SET_FEATURES is currently not setting any bits at all based upon
> > vhost_dev->features, so it looks like a vhost-scsi-pci bug..
> > 
> > 
> 
> If you call SET_FEATURES, does it start working even without
> disabling EVENT_IDX in kernel?
> 

Unfortunately, no.  The same strangeness persists unless event_idx=off
is passed, or EVENT_IDX is disabled in the kernel and stripped off with
the vhost_scsi_get_features() patch.
