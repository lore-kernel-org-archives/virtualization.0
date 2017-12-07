From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 2/2] virtio_mmio: add cleanup for virtio_mmio_remove
Date: Thu, 7 Dec 2017 12:09:42 +0100
Message-ID: <20171207120942.15d45279.cohuck@redhat.com>
References: <cover.1512568542.git.zhangweiping@didichuxing.com>
	<1a62b93b539bcde52f629314f04193928f02693e.1512568542.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1a62b93b539bcde52f629314f04193928f02693e.1512568542.git.zhangweiping@didichuxing.com>
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

On Wed, 6 Dec 2017 21:59:32 +0800
weiping zhang <zhangweiping@didichuxing.com> wrote:

> cleanup all resource allocated by virtio_mmio_probe.
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
>  drivers/virtio/virtio_mmio.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
