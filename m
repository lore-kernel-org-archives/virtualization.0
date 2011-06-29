From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: virtio scsi host draft specification, v3
Date: Wed, 29 Jun 2011 10:23:26 +0200
Message-ID: <4E0AE0FE.2090905__6963.15245372734$1309335876$gmane$org@redhat.com>
References: <4DEE2B15.4090809@redhat.com> <4DF21447.6090005@suse.de>
	<20110612075140.GB11941@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110612075140.GB11941@redhat.com>
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
Cc: Christoph Hellwig <chellwig@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 06/12/2011 09:51 AM, Michael S. Tsirkin wrote:
>> >
>> >  If a device uses more than one queue it is the responsibility of the
>> >  device to ensure strict request ordering.
> Maybe I misunderstand - how can this be the responsibility of
> the device if the device does not get the information about
> the original ordering of the requests?
>
> For example, if the driver is crazy enough to put
> all write requests on one queue and all barriers
> on another one, how is the device supposed to ensure
> ordering?

I agree here, in fact I misread Hannes's comment as "if a driver uses 
more than one queue it is responsibility of the driver to ensure strict 
request ordering".  If you send requests to different queues, you know 
that those requests are independent.  I don't think anything else is 
feasible in the virtio framework.

Paolo
