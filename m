From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH 0/5] vhost-scsi: Add support for host virtualized target
Date: Tue, 29 Jan 2013 11:19:48 -0800
Message-ID: <1359487188.23290.1434.camel__33112.9899750978$1359487217$gmane$org@haakon2.linux-iscsi.org>
References: <1347000499-28701-1-git-send-email-nab@linux-iscsi.org>
	<20130117164314.GA19458@redhat.com>
	<1358456841.18551.48.camel@haakon2.linux-iscsi.org>
	<20130121085034.GA31047@redhat.com> <510676B5.4070209@redhat.com>
	<20130128131133.GA15108@redhat.com> <51067D33.5080609@redhat.com>
	<20130128133609.GB15108@redhat.com> <51067E38.7040000@redhat.com>
	<20130128133952.GC15108@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130128133952.GC15108@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Hi MST, Paolo & Co,

On Mon, 2013-01-28 at 15:39 +0200, Michael S. Tsirkin wrote:
> On Mon, Jan 28, 2013 at 02:33:44PM +0100, Paolo Bonzini wrote:
> > Il 28/01/2013 14:36, Michael S. Tsirkin ha scritto:
> > > On Mon, Jan 28, 2013 at 02:29:23PM +0100, Paolo Bonzini wrote:
> > >> Il 28/01/2013 14:11, Michael S. Tsirkin ha scritto:
> > >>>> I asked for a standalone device because the configuration mechanism
> > >>>> (configfs vs. command-line) and the feature set are completely
> > >>>> different.  Unlike virtio-net, it's not possible to switch one to the
> > >>>> other at run time.
> > >>>
> > >>> Exactly the same applies to any other frontend option.
> > >>> For example if you have two qemu instances with
> > >>> different num_queues values you can not migrate one
> > >>> to the other.
> > >>> So in this sense it is not different from any other
> > >>> frontend option, right?
> > >>
> > >> Indeed, in this sense it is not.
> > >>
> > >> Actually in this case migrating one to the other could succeed, and make
> > >> all disks disappear on the destination (because of the different
> > >> configuration mechanism).  That however could be overcome with vhost=on
> > >> registering a migration blocker.
> > > 
> > > Or better add a subsection if vhost is set: vhost=on to vhost=on
> > > can migrate, right?
> > 
> > I think it's not yet supported by the kernel.  You have no guarantee
> > that I/O is quiescent at the time the VM starts on the destination.
> > You'd need a ioctl to do the equivalent of bdrv_drain_all().
> > 
> > Once you have that, a subsection would do the job, yes.
> > 
> > Paolo
> 
> OK once that's in it would be easy to probe for.
> 
> > >> I won't really block the patch with the vhost=on/off frontend option if
> > >> it is properly done (e.g. the QEMU SCSI bus should not be created for
> > >> vhost=on) and minimally invasive to the non-vhost code.
> > >>

So what's the verdict here..?  Shall I respin the vhost-scsi patches
against qemu.git HEAD to make it in before Friday's cutoff for v1.4..?

Also, I'm not exactly sure what's involved with a vhost=on/off frontend
option discussed above, so if you or Paolo could handle this bit it
would be very helpful.

:)

--nab
