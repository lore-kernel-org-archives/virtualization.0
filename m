From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: virtio scsi host draft specification, v3
Date: Thu, 09 Jun 2011 08:59:27 +0200
Message-ID: <4DF06F4F.8050308__1119.68518835983$1307602954$gmane$org@redhat.com>
References: <4DEE2B15.4090809@redhat.com> <87lixbgax9.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87lixbgax9.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christoph Hellwig <chellwig@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 06/09/2011 01:28 AM, Rusty Russell wrote:
>> >  after some preliminary discussion on the QEMU mailing list, I present a
>> >  draft specification for a virtio-based SCSI host (controller, HBA, you
>> >  name it).
>
> OK, I'm impressed.  This is very well written and it doesn't make any of
> the obvious mistakes wrt. virtio.

Thanks very much, and thanks to those who corrected my early mistakes.

> I assume you have an implementation, as well?

Unfortunately not; "we're working on it", which means I should start in 
July when I come back from vacation.

Do you prefer to wait for one before I make a patch to the LyX source? 
In the meanwhile, can you reserve a subsystem ID for me?

Paolo
