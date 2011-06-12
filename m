From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtio scsi host draft specification, v3
Date: Sun, 12 Jun 2011 10:51:41 +0300
Message-ID: <20110612075140.GB11941__24002.3914062933$1307865164$gmane$org@redhat.com>
References: <4DEE2B15.4090809@redhat.com>
 <4DF21447.6090005@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4DF21447.6090005@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <chellwig@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 10, 2011 at 02:55:35PM +0200, Hannes Reinecke wrote:
> >Device operation: request queues
> >--------------------------------
> >
> >The driver queues requests to an arbitrary request queue, and they are
> >used by the device on that same queue.
> >
> What about request ordering?
> If requests are placed on arbitrary queues you'll inevitably run on
> locking issues to ensure strict request ordering.
> I would add here:
> 
> If a device uses more than one queue it is the responsibility of the
> device to ensure strict request ordering.

Maybe I misunderstand - how can this be the responsibility of
the device if the device does not get the information about
the original ordering of the requests?

For example, if the driver is crazy enough to put
all write requests on one queue and all barriers
on another one, how is the device supposed to ensure
ordering?

-- 
MST
