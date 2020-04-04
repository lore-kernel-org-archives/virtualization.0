From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH 5/6] kernel: better document the
 use_mm/unuse_mm API contract
Date: Sat, 4 Apr 2020 16:07:31 +0300
Message-ID: <8c1e6600-bee3-d074-28e6-813a6dbf5fd0@gmail.com>
References: <20200404094101.672954-1-hch@lst.de>
 <20200404094101.672954-6-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20200404094101.672954-6-hch@lst.de>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Felipe Balbi <balbi@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, intel-gvt-dev@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, intel-gfx@lists.freedesktop.org, io-uring@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 04/04/2020 12:41, Christoph Hellwig wrote:
> Switch the function documentation to kerneldoc comments, and add
> WARN_ON_ONCE asserts that the calling thread is a kernel thread and
> does not have ->mm set (or has ->mm set in the case of unuse_mm).
> 
> Also give the functions a kthread_ prefix to better document the
> use case.
> 

io_uring and io-wq bits LGTM.

> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
...
> -/*
> - * unuse_mm
> - *	Reverses the effect of use_mm, i.e. releases the
> - *	specified mm context which was earlier taken on
> - *	by the calling kernel thread
> - *	(Note: this routine is intended to be called only
> - *	from a kernel thread context)
> +/**
> + * kthread_use_mm - reverse the effect of kthread_use_mm()

s/kthread_use_mm/kthread_unuse_mm/
for the first one

> + * @mm: address space to operate on
>   */
> -void unuse_mm(struct mm_struct *mm)
> +void kthread_unuse_mm(struct mm_struct *mm)
>  {

-- 
Pavel Begunkov
