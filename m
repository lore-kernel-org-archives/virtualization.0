From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC 2/3] virtio_net: fix tx capacity checks using new API
Date: Thu, 02 Jun 2011 11:40:26 +0930
Message-ID: <87vcwphtkd.fsf__14783.9183606722$1306987127$gmane$org@rustcorp.com.au>
References: <cover.1306921434.git.mst@redhat.com>
	<110045d5bf250e6ed9c739f8cc6adbbf54e3cc9c.1306921434.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <110045d5bf250e6ed9c739f8cc6adbbf54e3cc9c.1306921434.git.mst@redhat.com>
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
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 1 Jun 2011 12:49:54 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> In the (rare) case where new descriptors are used
> while virtio_net enables vq callback for the TX vq,
> virtio_net uses the number of sg entries in the skb it frees to
> calculate how many descriptors in the ring have just been made
> available.  But this value is an overestimate: with indirect buffers
> each skb only uses one descriptor entry, meaning we may wake the queue
> only to find we still can't transmit anything.

This is a bit misleading.

The value is an overestimate, but so is the requirement for
2+MAX_SKB_FRAGS, *unless* we suddenly drop into direct mode due to OOM.

Thanks,
Rusty.
