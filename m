From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: virtio scsi host draft specification, v3
Date: Wed, 29 Jun 2011 10:33:47 +0200
Message-ID: <4E0AE36B.9010500__19341.9010531672$1309336479$gmane$org@redhat.com>
References: <1504884387.187692.1307716550265.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
	<4DF71E28.6070009@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4DF71E28.6070009@suse.de>
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
Cc: Christoph Hellwig <chellwig@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 06/14/2011 10:39 AM, Hannes Reinecke wrote:
> If, however, we decide to expose some details about the backend, we
> could be using the values from the backend directly.
> EG we could be forwarding the SCSI target port identifier here
> (if backed by real hardware) or creating our own SAS-type
> identifier when backed by qemu block. Then we could just query
> the backend via a new command on the controlq
> (eg 'list target ports') and wouldn't have to worry about any protocol
> specific details here.

Besides the controlq command, which I can certainly add, this is 
actually quite similar to what I had in mind (though my plan likely 
would not have worked because I was expecting hierarchical LUNs used 
uniformly).  So, "list target ports" would return a set of LUN values to 
which you can send REPORT LUNS, or something like that?  I suppose that 
if you're using real hardware as the backing storage the in-kernel 
target can provide that.

For the QEMU backend I'd keep hierarchical LUNs, though of course one 
could add a FC or SAS bus to QEMU, each implementing its own identifier 
scheme.

If I understand it correctly, it should remain possible to use a single 
host for both pass-through and emulated targets.

Would you draft the command structure, so I can incorporate it into the 
spec?

> Of course, when doing so we would be lose the ability to freely remap
> LUNs. But then remapping LUNs doesn't gain you much imho.
> Plus you could always use qemu block backend here if you want
> to hide the details.

And you could always use the QEMU block backend with scsi-generic if you 
want to remap LUNs, instead of true passthrough via the kernel target.

Paolo
