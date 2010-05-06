From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC] virtio: put last seen used index into ring itself
Date: Thu, 6 May 2010 12:01:34 +0930
Message-ID: <201005061201.35223.rusty__17916.5063811981$1273113125$gmane$org@rustcorp.com.au>
References: <20100505205814.GA7090@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100505205814.GA7090@redhat.com>
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
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 6 May 2010 06:28:14 am Michael S. Tsirkin wrote:
> Rusty,
> this is a simplified form of a patch you posted in the past.
> I have a vhost patch that, using this feature, shows external
> to host bandwidth grow from 5 to 7 GB/s, by avoiding
> an interrupt in the window after previous interrupt
> was sent and before interrupts were disabled for the vq.
> With vhost under some external to host loads I see
> this window being hit about 30% sometimes.

Fascinating.  So you use this to guess if the guest is still processing?
I haven't thought about it hard, but is that racy?

Obviously happy to apply this when you finalize it.

Thanks!
Rusty.
