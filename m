From: Vasily Averin <vvs@virtuozzo.com>
Subject: Re: [PATCH 1/1] drm/qxl: add mutex_lock/mutex_unlock to ensure the
 order in which resources are released
Date: Sun, 26 Apr 2020 10:51:27 +0300
Message-ID: <5488290f-fe60-874e-2b18-0327e877fdbc@virtuozzo.com>
References: <20200418063917.26278-1-caizhaopeng () uniontech ! com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200418063917.26278-1-caizhaopeng () uniontech ! com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Caicai <caizhaopeng@uniontech.com>, Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhangyueqian <zhangyueqian@uniontech.com>
List-Id: virtualization@lists.linuxfoundation.org

On 4/18/20 9:39 AM, Caicai wrote:
> When a qxl resource is released, the list that needs to be released is
> fetched from the linked list ring and cleared. When you empty the list,
> instead of trying to determine whether the ttm buffer object for each
> qxl in the list is locked, you release the qxl object and remove the
> element from the list until the list is empty. It was found that the
> linked list was cleared first, and that the lock on the corresponding
> ttm Bo for the QXL had not been released, so that the new qxl could not
> be locked when it used the TTM. By adding an additional mutex to ensure
> timing, qxl elements are not allowed to be removed from the list until
> ttm Bo's lock is released

> @@ -241,7 +243,11 @@ int qxl_garbage_collect(struct qxl_device *qdev)
>  			}
>  			id = next_id;
>  
> +			mutex_lock(&release->async_release_mutex);
> +
>  			qxl_release_free(qdev, release);
> +
> +			mutex_unlock(&release->async_release_mutex);
It does not work,
release was freed inside qxl_release_free() so you cannot access here any its fields

>  			++i;
>  		}
>  	}
