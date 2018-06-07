From: Dmitry Vyukov via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: KMSAN: uninit-value in _copy_to_iter (2)
Date: Thu, 7 Jun 2018 18:25:35 +0200
Message-ID: <CACT4Y+btyLi+z09EO0JU-7AS_OfRbWiZvGn-KP9fndevh+xFNw@mail.gmail.com>
References: <000000000000a5b2b1056a86e98c@google.com>
	<000000000000cf4578056ab12452@google.com>
	<20180607183627-mutt-send-email-mst@kernel.org>
Reply-To: Dmitry Vyukov <dvyukov@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000e8e79a056e0fbcf6"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180607183627-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, avagin <avagin@openvz.org>, KVM list <kvm@vger.kernel.org>, netdev <netdev@vger.kernel.org>, Matthew Dawson <matthew@mjdsystems.ca>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Eric Dumazet <edumazet@google.com>, Al Viro <viro@zeniv.linux.org.uk>, Ding Tianhong <dingtianhong@huawei.com>, syzbot <syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>, "Reshetova,
	Elena" <elena.reshetova@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

--000000000000e8e79a056e0fbcf6
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 7, 2018 at 5:38 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> #syz test: https://github.com/google/kmsan.git/master d2d741e5d1898dfde1a75ea3d29a9a3e2edf0617

Hi Michael,

We need:

#syz test: https://github.com/google/kmsan.git master

here. Please see
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
for more info.

Please also add the Reported-by tag when mailing the patch for review.

Thanks

> Subject: vhost: fix info leak
>
> Fixes: CVE-2018-1118
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index f0be5f35ab28..9beefa6ed1ce 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2345,6 +2345,9 @@ struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>         struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
>         if (!node)
>                 return NULL;
> +
> +       /* Make sure all padding within the structure is initialized. */
> +       memset(&node->msg, 0, sizeof node->msg);
>         node->vq = vq;
>         node->msg.type = type;
>         return node;
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20180607183627-mutt-send-email-mst%40kernel.org.
> For more options, visit https://groups.google.com/d/optout.

--000000000000e8e79a056e0fbcf6
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ji4r5e8p0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3Qu
YwppbmRleCBmMGJlNWYzNWFiMjguLjliZWVmYTZlZDFjZSAxMDA2NDQKLS0tIGEvZHJpdmVycy92
aG9zdC92aG9zdC5jCisrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwpAQCAtMjM0NSw2ICsyMzQ1
LDkgQEAgc3RydWN0IHZob3N0X21zZ19ub2RlICp2aG9zdF9uZXdfbXNnKHN0cnVjdCB2aG9zdF92
aXJ0cXVldWUgKnZxLCBpbnQgdHlwZSkKIAlzdHJ1Y3Qgdmhvc3RfbXNnX25vZGUgKm5vZGUgPSBr
bWFsbG9jKHNpemVvZiAqbm9kZSwgR0ZQX0tFUk5FTCk7CiAJaWYgKCFub2RlKQogCQlyZXR1cm4g
TlVMTDsKKworCS8qIE1ha2Ugc3VyZSBhbGwgcGFkZGluZyB3aXRoaW4gdGhlIHN0cnVjdHVyZSBp
cyBpbml0aWFsaXplZC4gKi8KKwltZW1zZXQoJm5vZGUtPm1zZywgMCwgc2l6ZW9mIG5vZGUtPm1z
Zyk7CiAJbm9kZS0+dnEgPSB2cTsKIAlub2RlLT5tc2cudHlwZSA9IHR5cGU7CiAJcmV0dXJuIG5v
ZGU7Cgo=
--000000000000e8e79a056e0fbcf6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--000000000000e8e79a056e0fbcf6--
