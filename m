From: Christoph Hellwig <hch@infradead.org>
Subject: Re: virtio scsi host draft specification, v3
Date: Wed, 29 Jun 2011 06:03:41 -0400
Message-ID: <20110629100341.GC22900__31011.438862379$1309341857$gmane$org@infradead.org>
References: <4DEE2B15.4090809@redhat.com> <4DF21447.6090005@suse.de>
	<20110612075140.GB11941@redhat.com> <4E0AE0FE.2090905@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4E0AE0FE.2090905@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christoph Hellwig <chellwig@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 29, 2011 at 10:23:26AM +0200, Paolo Bonzini wrote:
> I agree here, in fact I misread Hannes's comment as "if a driver
> uses more than one queue it is responsibility of the driver to
> ensure strict request ordering".  If you send requests to different
> queues, you know that those requests are independent.  I don't think
> anything else is feasible in the virtio framework.

That doesn't really fit very well with the SAM model.  If we want
to use multiple queues for a single LUN it has to be transparent to
the SCSI command stream.  Then again I don't quite see the use for
that anyway.
