From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH] tcm_vhost: Add hotplug/hotunplug support
Date: Thu, 07 Mar 2013 14:45:48 -0800
Message-ID: <1362696348.7905.242.camel__49991.219273261$1362696381$gmane$org@haakon2.linux-iscsi.org>
References: <1362475027-12018-1-git-send-email-asias@redhat.com>
	<20130305121125.GA823@redhat.com> <5135F150.1060206@redhat.com>
	<20130305143416.GG2256@redhat.com>
	<1362523912.7905.208.camel@haakon2.linux-iscsi.org>
	<51375270.7060703@redhat.com>  <20130307005555.GD8785@hj.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130307005555.GD8785@hj.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2013-03-07 at 08:55 +0800, Asias He wrote:
> On Wed, Mar 06, 2013 at 03:28:00PM +0100, Paolo Bonzini wrote:
> > Il 05/03/2013 23:51, Nicholas A. Bellinger ha scritto:
> > > For making progress with Paolo's vhost-scsi branch on my side, this was
> > > still being blocked by bios boot hangs:
> > > 
> > > http://www.spinics.net/lists/target-devel/msg03830.html
> > > 
> > > Paolo & Co, any ideas on the latter..?
> > 
> > Nope.  Asias, do you have time to look at it?  Only patches 3 and 4 in
> > that series are needed, they are at
> > 
> > http://article.gmane.org/gmane.comp.emulators.qemu/192143
> > http://article.gmane.org/gmane.comp.emulators.qemu/192147
> > 
> > (vhost_scsi_set_endpoint and vhost_scsi_clear_endpoint need to be
> > integrated in vhost_scsi_start and vhost_scsi_stop).
> 
> Okay. I will take a look. I am CC'ing Dominik Dingel, he might be
> interested in.
> 
> Nicholas, could you share the code where you left (on top of Paolo's),
> so I can start from.
> 

Sure.  Pushing this code to k.o qemu-kvm.git/vhost-scsi-paolo, with the
extra local patches:

vhost-scsi/virtio-scsi: Add backend guest masking support
vhost-scsi: Bump ABI_VERSION to 1

Thanks!

--nab
