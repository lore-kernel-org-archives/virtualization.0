From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 4/4] drm/virtio: Use IDAs more efficiently
Date: Wed, 26 Sep 2018 09:04:55 -0700
Message-ID: <20180926160455.GA20337__17993.3209241883$1537977777$gmane$org@bombadil.infradead.org>
References: <20180926160031.15721-1-willy@infradead.org>
	<20180926160031.15721-5-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180926160031.15721-5-willy@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 26, 2018 at 09:00:31AM -0700, Matthew Wilcox wrote:
> @@ -59,6 +59,7 @@ static int virtio_gpu_context_create(struct virtio_gpu_device *vgdev,
>  
>  	if (handle < 0)
>  		return handle;
> +	handle++;
>  	virtio_gpu_cmd_context_create(vgdev, handle, nlen, name);
>  	return handle;
>  }

Uh.  This line is missing.

-       int handle = ida_alloc_min(&vgdev->ctx_id_ida, 1, GFP_KERNEL);
+       int handle = ida_alloc(&vgdev->ctx_id_ida, GFP_KERNEL);

It'll be there in v2 ;-)
