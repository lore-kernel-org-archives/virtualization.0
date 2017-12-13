From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 2/3] virtio: use put_device instead of kfree
Date: Wed, 13 Dec 2017 09:27:27 +0100
Message-ID: <20171213092727.78c4432f.cohuck@redhat.com>
References: <cover.1513083885.git.zhangweiping@didichuxing.com>
	<11026fc88be1033d7ce5bc8ecb9b355d27d82075.1513083885.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11026fc88be1033d7ce5bc8ecb9b355d27d82075.1513083885.git.zhangweiping@didichuxing.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: weiping zhang <zhangweiping@didichuxing.com>
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 12 Dec 2017 21:24:33 +0800
weiping zhang <zhangweiping@didichuxing.com> wrote:

> As mentioned at drivers/base/core.c:
> /*
>  * NOTE: _Never_ directly free @dev after calling this function, even
>  * if it returned an error! Always use put_device() to give up the
>  * reference initialized in this function instead.
>  */
> so we don't free vp_vdev until vp_vdev.dev.release be called.
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
>  drivers/misc/mic/vop/vop_main.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
