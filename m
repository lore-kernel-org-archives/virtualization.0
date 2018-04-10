From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RESEND net] vhost: fix vhost_vq_access_ok() log check
Date: Tue, 10 Apr 2018 09:05:11 +0800
Message-ID: <CAJSP0QXn2jfScW0TYU89792x7jjaPBQjTgQXeGO0nVmKVG1z1Q__1142.43684006414$1523322212$gmane$org@mail.gmail.com>
References: <20180409131021.5132-1-stefanha@redhat.com>
	<20180409174731-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180409174731-mutt-send-email-mst@kernel.org>
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
Cc: kvm <kvm@vger.kernel.org>, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 10, 2018 at 3:40 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
>
> Commit d65026c6c62e7d9616c8ceb5a53b68bcdc050525 ("vhost: validate log
> when IOTLB is enabled") introduced a regression.  The logic was
> originally:
>
>   if (vq->iotlb)
>       return 1;
>   return A && B;
>
> After the patch the short-circuit logic for A was inverted:
>
>   if (A || vq->iotlb)
>       return A;
>   return B;
>
> The correct logic is:
>
>   if (!A || vq->iotlb)
>       return A;
>   return B;
>
> Reported-by: syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> ---
>  drivers/vhost/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

NACK

I will send a v2 with cleaner logic as suggested by Linus.

Stefan
