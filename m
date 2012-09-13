From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH 0/5] vhost-scsi: Add support for host virtualized target
Date: Thu, 13 Sep 2012 13:12:09 -0700
Message-ID: <1347567129.7359.14.camel__29663.2885504097$1347567152$gmane$org@haakon2.linux-iscsi.org>
References: <1347000499-28701-1-git-send-email-nab@linux-iscsi.org>
	<504EBFD5.6050203@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <504EBFD5.6050203@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2012-09-11 at 12:36 +0800, Asias He wrote:
> Hello Nicholas,
> 

Hello Asias!

> On 09/07/2012 02:48 PM, Nicholas A. Bellinger wrote:
> > From: Nicholas Bellinger <nab@linux-iscsi.org>
> > 
> > Hello Anthony & Co,
> > 
> > This is the fourth installment to add host virtualized target support for
> > the mainline tcm_vhost fabric driver using Linux v3.6-rc into QEMU 1.3.0-rc.
> > 
> > The series is available directly from the following git branch:
> > 
> >    git://git.kernel.org/pub/scm/virt/kvm/nab/qemu-kvm.git vhost-scsi-for-1.3
> > 
> > Note the code is cut against yesterday's QEMU head, and dispite the name
> > of the tree is based upon mainline qemu.org git code + has thus far been
> > running overnight with > 100K IOPs small block 4k workloads using v3.6-rc2+
> > based target code with RAMDISK_DR backstores.
> 
> Are you still seeing the performance degradation discussed in the thread
> 
>  "vhost-scsi port to v1.1.0 + MSI-X performance regression"
> 

So the performance regression reported here with QEMU v1.2-rc +
virtio-scsi ended up being related to virtio interrupts being delivered
across multiple CPUs.

After explicitly setting the IRQ affinity of the virtio0-request MSI-X
vector to a specific CPU, the small block (4k) mixed random I/O
performance jumped back up to the expected ~100K IOPs for a single LUN.

FYI, I just tried this again with the most recent QEMU v1.2.50 (v1.3-rc)
code, and both cases appear to be performing as expected once again
regardless of the explicit IRQ affinity setting.

--nab
