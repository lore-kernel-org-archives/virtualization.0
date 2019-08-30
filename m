From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/virtio: Use vmalloc for command buffer allocations.
Date: Fri, 30 Aug 2019 08:08:57 +0200
Message-ID: <20190830060857.tzrzgoi2hrmchdi5__23235.8601105929$1567145455$gmane$org@sirius.home.kraxel.org>
References: <20190829212417.257397-1-davidriley@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190829212417.257397-1-davidriley@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Riley <davidriley@chromium.org>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

>  {
>  	if (vbuf->resp_size > MAX_INLINE_RESP_SIZE)
>  		kfree(vbuf->resp_buf);
> -	kfree(vbuf->data_buf);
> +	kvfree(vbuf->data_buf);

if (is_vmalloc_addr(vbuf->data_buf)) ...

needed here I gues?

> +/* Create sg_table from a vmalloc'd buffer. */
> +static struct sg_table *vmalloc_to_sgt(char *data, uint32_t size)

Hmm, isn't there an existing function for that?
I'd be surprised if virtio-gpu is the first driver needing this ...

And it case there really isn't one this should probably added to the
vmalloc or scatterlist code, not the virtio-gpu driver.

cheers,
  Gerd
