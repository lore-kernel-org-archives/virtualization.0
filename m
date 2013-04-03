From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH] vhost: Add vhost_commit callback for SeaBIOS ROM
	region re-mapping
Date: Wed, 03 Apr 2013 13:23:24 -0700
Message-ID: <1365020604.11833.15.camel__22546.3684801527$1365020654$gmane$org@haakon2.linux-iscsi.org>
References: <1364980511-25122-1-git-send-email-nab@linux-iscsi.org>
	<20130403094911.GB18179@redhat.com> <515BFF16.4000503@redhat.com>
	<20130403103438.GA18725@redhat.com>  <515C05CB.6010505@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <515C05CB.6010505@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2013-04-03 at 12:34 +0200, Paolo Bonzini wrote:
> Il 03/04/2013 12:34, Michael S. Tsirkin ha scritto:
> > > Applied to the SCSI branch, thanks.
> > 
> > Is the rest of vhost-scsi there now?
> 
> No, but it will be shortly. :)
> 

Hi Paolo,

Just a heads up that PATCH-v2 for vhost-scsi-pci does not apply cleanly
against the latest qemu.git/master.  Let me know if your OK with fixing
the fuzz, or would prefer a -v3 re-spin before for applying to SCSI
branch.  

Also, please include the uninitialized VQs checks that MST recently
ACK'ed here:
virtio/vhost: Add checks for uninitialized VQs
http://www.spinics.net/lists/target-devel/msg04298.html

Btw, has the SCSI branch been pushed to a public repo..?

--nab
