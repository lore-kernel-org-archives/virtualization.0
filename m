From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] vhost: fix vhost_vq_access_ok() log check
Date: Mon, 9 Apr 2018 09:52:13 -0700
Message-ID: <CA+55aFzJ_JPtU5SjAHHv--p3ZcAw4gVidxvrLLZF7w+kbHCNdg__17829.43492658$1523292630$gmane$org@mail.gmail.com>
References: <20180409131021.5132-1-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180409131021.5132-1-stefanha@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, syzkaller-bugs@googlegroups.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 9, 2018 at 6:10 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> @@ -1246,7 +1246,7 @@ int vhost_vq_access_ok(struct vhost_virtqueue *vq)
>  {
>         int ret = vq_log_access_ok(vq, vq->log_base);
>
> -       if (ret || vq->iotlb)
> +       if (!ret || vq->iotlb)
>                 return ret;

That logic is still very non-obvious.

This code already had one bug because of an odd illegible test
sequence. Let's not keep the crazy code.

Why not just do the *obvious* thing, and get rid of "ret" entirely,
and make the damn thing return a boolean, and then just write it all
as

    /* Caller should have vq mutex and device mutex */
    bool vhost_vq_access_ok(struct vhost_virtqueue *vq)
    {
            if (!vq_log_access_ok(vq, vq->log_base))
                    return false;

            if (vq->iotlb || vq_access_ok(vq, vq->num, vq->desc,
vq->avail, vq->used);
    }

which makes the logic obvious: if vq_log_access_ok() fails, then then
vhost_vq_access_ok() fails unconditionally.

Otherwise, we need to have an iotlb, or a successful vq_access_ok() check.

Doesn't that all make more sense, and avoid the insane "ret" value use
that is really quite subtle?

                    Linus
