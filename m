From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] virtio_balloon: Adjust label in virtballoon_probe
Date: Mon, 17 Feb 2020 09:37:25 +0100
Message-ID: <c02f5eb2-386a-33d0-338f-afc4f8049c95@redhat.com>
References: <20200216004039.23464-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200216004039.23464-1-natechancellor@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
List-Id: virtualization@lists.linuxfoundation.org

On 16.02.20 01:40, Nathan Chancellor wrote:
> Clang warns when CONFIG_BALLOON_COMPACTION is unset:
> 
> ../drivers/virtio/virtio_balloon.c:963:1: warning: unused label
> 'out_del_vqs' [-Wunused-label]
> out_del_vqs:
> ^~~~~~~~~~~~
> 1 warning generated.
> 
> Move the label within the preprocessor block since it is only used when
> CONFIG_BALLOON_COMPACTION is set.
> 
> Fixes: 1ad6f58ea936 ("virtio_balloon: Fix memory leaks on errors in virtballoon_probe()")
> Link: https://github.com/ClangBuiltLinux/linux/issues/886
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/virtio/virtio_balloon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 7bfe365d9372..341458fd95ca 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -959,8 +959,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  	iput(vb->vb_dev_info.inode);
>  out_kern_unmount:
>  	kern_unmount(balloon_mnt);
> -#endif
>  out_del_vqs:
> +#endif
>  	vdev->config->del_vqs(vdev);
>  out_free_vb:
>  	kfree(vb);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
