From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/6] i915/gvt/kvm: a NULL ->mm does not mean a thread is a
 kthread
Date: Sat, 4 Apr 2020 13:05:52 +0300
Message-ID: <0fb3cce8-fa3d-5c97-1eba-0f359797eea2@cogentembedded.com>
References: <20200404094101.672954-1-hch@lst.de>
 <20200404094101.672954-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20200404094101.672954-3-hch@lst.de>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>, Felipe Balbi <balbi@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-usb@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

Hello!

On 04.04.2020 12:40, Christoph Hellwig wrote:

> Use the proper API instead.
> 
> Fixes: f440c8a572d7 ("drm/i915/gvt/kvmgt: read/write GPA via KVM API")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/gpu/drm/i915/gvt/kvmgt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
> index 074c4efb58eb..5848400620b4 100644
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -2037,7 +2037,7 @@ static int kvmgt_rw_gpa(unsigned long handle, unsigned long gpa,
>   	struct kvmgt_guest_info *info;
>   	struct kvm *kvm;
>   	int idx, ret;
> -	bool kthread = current->mm == NULL;
> +	bool kthread = (current->flags & PF_KTHREAD);

    Don't need the parens.

[...]

MBR, Sergei
