From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] kernel: better document the
 use_mm/unuse_mm API contract
Date: Thu, 16 Apr 2020 08:43:41 +0200
Message-ID: <20200416064341.GB300290@kroah.com>
References: <20200416053158.586887-1-hch@lst.de>
 <20200416053158.586887-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20200416053158.586887-3-hch@lst.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Felipe Balbi <balbi@kernel.org>, amd-gfx@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>, intel-gvt-dev@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>, linux-usb@vger.kernel.org, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, intel-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 16, 2020 at 07:31:57AM +0200, Christoph Hellwig wrote:
> Switch the function documentation to kerneldoc comments, and add
> WARN_ON_ONCE asserts that the calling thread is a kernel thread and
> does not have ->mm set (or has ->mm set in the case of unuse_mm).
> 
> Also give the functions a kthread_ prefix to better document the
> use case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org> [usb]
