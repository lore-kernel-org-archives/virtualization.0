From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: virtio scsi host draft specification, v3
Date: Wed, 29 Jun 2011 12:35:51 +0200
Message-ID: <4E0B0007.3050901__43739.9495429874$1309343799$gmane$org@redhat.com>
References: <4DEE2B15.4090809@redhat.com> <4DF21447.6090005@suse.de>
	<20110612075140.GB11941@redhat.com> <4E0AE0FE.2090905@redhat.com>
	<20110629100341.GC22900@infradead.org>
	<4E0AF925.2050707@redhat.com> <20110629103139.GC16757@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110629103139.GC16757@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <chellwig@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Christoph Hellwig <hch@infradead.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 06/29/2011 12:31 PM, Michael S. Tsirkin wrote:
> On Wed, Jun 29, 2011 at 12:06:29PM +0200, Paolo Bonzini wrote:
>> On 06/29/2011 12:03 PM, Christoph Hellwig wrote:
>>>>   I agree here, in fact I misread Hannes's comment as "if a driver
>>>>   uses more than one queue it is responsibility of the driver to
>>>>   ensure strict request ordering".  If you send requests to different
>>>>   queues, you know that those requests are independent.  I don't think
>>>>   anything else is feasible in the virtio framework.
>>>
>>> That doesn't really fit very well with the SAM model.  If we want
>>> to use multiple queues for a single LUN it has to be transparent to
>>> the SCSI command stream.  Then again I don't quite see the use for
>>> that anyway.
>>
>> Agreed, I see a use for multiple queues (MSI-X), but not for
>> multiple queues shared by a single LUN.
>
> Then let's make it explicit in the spec?

What, forbid it or say ordering is not guaranteed?  The latter is 
already explicit with the wording suggested in the thread.

Paolo
