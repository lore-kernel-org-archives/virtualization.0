From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: virtio scsi host draft specification, v3
Date: Fri, 01 Jul 2011 08:41:12 +0200
Message-ID: <4E0D6C08.1040201__31728.6118785434$1309502547$gmane$org@redhat.com>
References: <1504884387.187692.1307716550265.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>	<4DF71E28.6070009@suse.de>	<4E0AE36B.9010500@redhat.com>
	<BANLkTik2AXXkWvV23OP1eDdLirP2N0PC3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTik2AXXkWvV23OP1eDdLirP2N0PC3A@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Christoph Hellwig <chellwig@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 06/29/2011 11:39 AM, Stefan Hajnoczi wrote:
> > >  Of course, when doing so we would be lose the ability to freely remap
> > >  LUNs. But then remapping LUNs doesn't gain you much imho.
> > >  Plus you could always use qemu block backend here if you want
> > >  to hide the details.
> >
> >  And you could always use the QEMU block backend with scsi-generic if you
> >  want to remap LUNs, instead of true passthrough via the kernel target.
>
> IIUC the in-kernel target always does remapping.  It passes through
> individual LUNs rather than entire targets and you pick LU Numbers to
> map to the backing storage (which may or may not be a SCSI
> pass-through device).  Nicholas Bellinger can confirm whether this is
> correct.

But then I don't understand.  If you pick LU numbers both with the 
in-kernel target and with QEMU, you do not need to use e.g. WWPNs with 
fiber channel, because we are not passing through the details of the 
transport protocol (one day we might have virtio-fc, but more likely 
not).  So the LUNs you use might as well be represented by hierarchical 
LUNs.

Using NPIV with KVM would be done by mapping the same virtual N_Port ID 
in the host(s) to the same LU number in the guest.  You might already do 
this now with virtio-blk, in fact.

Put in another way: the virtio-scsi device is itself a SCSI target, so 
yes, there is a single target port identifier in virtio-scsi.  But this 
SCSI target just passes requests down to multiple real targets, and so 
will let you do ALUA and all that.

Of course if I am dead wrong please correct me.

Paolo
