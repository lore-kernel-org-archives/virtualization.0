From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 1/2] virtio_mmio: add cleanup for virtio_mmio_probe
Date: Thu, 7 Dec 2017 12:08:58 +0100
Message-ID: <20171207120858.5a6b67bf.cohuck@redhat.com>
References: <cover.1512568542.git.zhangweiping@didichuxing.com>
	<9fc4a1dd52c99edfccdf4c710445ed9a43aad66a.1512568542.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <9fc4a1dd52c99edfccdf4c710445ed9a43aad66a.1512568542.git.zhangweiping@didichuxing.com>
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

On Wed, 6 Dec 2017 21:59:16 +0800
weiping zhang <zhangweiping@didichuxing.com> wrote:

> As mentioned at drivers/base/core.c:
> /*
>  * NOTE: _Never_ directly free @dev after calling this function, even
>  * if it returned an error! Always use put_device() to give up the
>  * reference initialized in this function instead.
>  */
> so we don't free vm_dev until vm_dev.dev.release be called.
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
>  drivers/virtio/virtio_mmio.c | 51 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 41 insertions(+), 10 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
