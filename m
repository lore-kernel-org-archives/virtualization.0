From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] drm/virtio: use virtio_max_dma_size
Date: Sat, 10 Aug 2019 01:22:00 -0700
Message-ID: <20190810082200.GC30426__27376.6034327977$1565425333$gmane$org@infradead.org>
References: <20190808153445.27177-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190808153445.27177-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 08, 2019 at 05:34:45PM +0200, Gerd Hoffmann wrote:
> We must make sure our scatterlist segments are not too big, otherwise
> we might see swiotlb failures (happens with sev, also reproducable with
> swiotlb=force).

Btw, any chance I could also draft you to replace the remaining
abuses of swiotlb_max_segment and swiotlb_nr_tbl in drm with proper
dma level interface?
