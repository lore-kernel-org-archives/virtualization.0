From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 1/4] virtio: split device_register into
	device_initialize and device_add
Date: Fri, 22 Dec 2017 14:39:12 +0100
Message-ID: <20171222143912.29cba36f.cohuck@redhat.com>
References: <0a8c1c071eef26bc4dfdf796778fd590d0f8e7e7.1513825904.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0a8c1c071eef26bc4dfdf796778fd590d0f8e7e7.1513825904.git.zhangweiping@didichuxing.com>
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

On Thu, 21 Dec 2017 20:39:50 +0800
weiping zhang <zhangweiping@didichuxing.com> wrote:

> In order to make caller do a simple cleanup, we split device_register
> into device_initialize and device_add. device_initialize always succeeds,
> so the caller can always use put_device when register_virtio_device faild.
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  drivers/virtio/virtio.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
