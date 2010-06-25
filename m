From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] virtio: Support releasing lock during kick
Date: Fri, 25 Jun 2010 12:39:21 +0930
Message-ID: <201006251239.23224.rusty__34759.9627370529$1277435399$gmane$org@rustcorp.com.au>
References: <1277328242-10685-1-git-send-email-stefanha@linux.vnet.ibm.com>
	<4C2286BE.40808@codemonkey.ws>
	<AANLkTim6CH_NruBFqK6fIkMkKpAuCIef50mHfldMtNH9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTim6CH_NruBFqK6fIkMkKpAuCIef50mHfldMtNH9@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 24 Jun 2010 03:00:30 pm Stefan Hajnoczi wrote:
> On Wed, Jun 23, 2010 at 11:12 PM, Anthony Liguori <anthony@codemonkey.ws> wrote:
> > Shouldn't it be possible to just drop the lock before invoking
> > virtqueue_kick() and reacquire it afterwards?  There's nothing in that
> > virtqueue_kick() path that the lock is protecting AFAICT.
> 
> No, that would lead to a race condition because vq->num_added is
> modified by both virtqueue_add_buf_gfp() and virtqueue_kick().
> Without a lock held during virtqueue_kick() another vcpu could add
> bufs while vq->num_added is used and cleared by virtqueue_kick():

Right, this dovetails with another proposed change (was it Michael?)
where we would update the avail idx inside add_buf, rather than waiting
until kick.  This means a barrier inside add_buf, but that's probably
fine.

If we do that, then we don't need a lock on virtqueue_kick.

Michael, thoughts?

Thanks,
Rusty.
