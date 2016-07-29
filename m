From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v3] virtio_blk: Fix a slient kernel panic
Date: Fri, 29 Jul 2016 09:26:34 +0100
Message-ID: <CAJSP0QUZ-=va4yOLMciG0V0L9N+XcDAcc82vVfdTw=RY-UXVcw@mail.gmail.com>
References: <1468902762-43268-1-git-send-email-mnfhuang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1468902762-43268-1-git-send-email-mnfhuang@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Minfei Huang <mnfhuang@gmail.com>
Cc: Minfei Huang <minfei.hmf@alibaba-inc.com>, fanc.fnst@cn.fujitsu.com, linux-kernel <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Minfei Huang <mnghuan@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 19, 2016 at 5:32 AM, Minfei Huang <mnfhuang@gmail.com> wrote:
> From: Minfei Huang <mnghuan@gmail.com>
>
> We do a lot of memory allocation in function init_vq, and don't handle
> the allocation failure properly. Then this function will return 0,
> although initialization fails due to lacking memory. At that moment,
> kernel will panic in guest machine, if virtio is used to drive disk.
>
> To fix this bug, we should take care of allocation failure, and return
> correct value to let caller know what happen.
>
> Tested-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> Signed-off-by: Minfei Huang <minfei.hmf@alibaba-inc.com>
> Signed-off-by: Minfei Huang <mnghuan@gmail.com>
> ---
> v2:
> - Remove useless initialisation to NULL
> v1:
> - Refactor the patch to make code more readable
> ---
>  drivers/block/virtio_blk.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
