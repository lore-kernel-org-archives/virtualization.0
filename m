From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 4/4] virtio_remoteproc: correct put_device
	virtio_device.dev
Date: Fri, 22 Dec 2017 14:40:47 +0100
Message-ID: <20171222144047.3951aef6.cohuck@redhat.com>
References: <742b7e56647f9a1c9fbf0bbc0dc5b93742382371.1513825904.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <742b7e56647f9a1c9fbf0bbc0dc5b93742382371.1513825904.git.zhangweiping@didichuxing.com>
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
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, bjorn.andersson@linaro.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 21 Dec 2017 20:40:58 +0800
weiping zhang <zhangweiping@didichuxing.com> wrote:

> rproc_virtio_dev_release will be called iff virtio_device.dev's
> reference count drops to 0. Here we just put vdev.dev, and then
> rproc->dev's cleanup will be done in rproc_virtio_dev_release.
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
>  drivers/remoteproc/remoteproc_virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
