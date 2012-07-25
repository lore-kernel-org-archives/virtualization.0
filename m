From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 1/9] notifier: add validity check and notify function
Date: Wed, 25 Jul 2012 08:53:29 +0200
Message-ID: <500F97E9.4070508__41964.4494810656$1343199225$gmane$org@redhat.com>
References: <1343169246-17636-1-git-send-email-nab@linux-iscsi.org>
	<1343169246-17636-2-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1343169246-17636-2-git-send-email-nab@linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: Jens Axboe <axboe@kernel.dk>, Anthony Liguori <aliguori@us.ibm.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Il 25/07/2012 00:33, Nicholas A. Bellinger ha scritto:
> +int event_notifier_notify(EventNotifier *e)
> +{
> +    uint64_t value = 1;
> +    int r;
> +
> +    assert(event_notifier_valid(e));
> +    r = write(e->fd, &value, sizeof(value));
> +    if (r < 0) {
> +        return -errno;
> +    }
> +    assert(r == sizeof(value));
> +    return 0;
> +}

Note we now have event_notifier_set.

> +#define EVENT_NOTIFIER_INITIALIZER ((EventNotifier){ .fd = -1 })

This is problematic when your event notifier is inside a struct, because
it is extremely easy to forget the initializer.  You have to initialize
them yourself.  Also, the right thing to test is not whether the
notifier is initialized; it is whether the notifier is actually checked
in QEMU's select() loop.

So, I would prefer avoiding event_notifier_valid and just use a boolean
(in virtio_queue_set_host_notifier_fd_handler and
virtio_queue_set_guest_notifier_fd_handler) to track whether the
notifiers are in use.

Paolo
