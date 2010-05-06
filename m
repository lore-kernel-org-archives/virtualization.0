From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [Qemu-devel] question on virtio
Date: Thu, 6 May 2010 17:43:31 +0100
Message-ID: <20100506164331.GF28512__45663.8547512286$1273164264$gmane$org@shareable.org>
References: <20100505110947.GA27872@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100505110947.GA27872@redhat.com>
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> Hi!
> I see this in virtio_ring.c:
> 
>         /* Put entry in available array (but don't update avail->idx *
> 	   until they do sync). */
> 
> Why is it done this way?
> It seems that updating the index straight away would be simpler, while
> this might allow the host to specilatively look up the buffer and handle
> it, without waiting for the kick.

Even better, if the host updates a location containing which index it
has seen recently, you can avoid the kick entirely during sustained
flows - just like your recent patch to avoid sending irqs to the
guest.

-- Jamie
