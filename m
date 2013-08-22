From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] tracing/events: Add bounce tracing to swiotbl-xen
Date: Thu, 22 Aug 2013 18:02:09 -0400
Message-ID: <20130822180209.07a2bd00@gandalf.local.home>
References: <1377208048-8963-1-git-send-email-zoltan.kiss@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1377208048-8963-1-git-send-email-zoltan.kiss@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zoltan Kiss <zoltan.kiss@citrix.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 22 Aug 2013 22:47:28 +0100
Zoltan Kiss <zoltan.kiss@citrix.com> wrote:


>  /*
>   * Used to do a quick range check in swiotlb_tbl_unmap_single and
>   * swiotlb_tbl_sync_single_*, to see if the memory was in fact allocated by this
> @@ -358,6 +362,9 @@ dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>  	/*
>  	 * Oh well, have to allocate and map a bounce buffer.
>  	 */
> +
> +	trace_bounced(dev, dev_addr, size, swiotlb_force);

Please use a more specific name. "bounce" is too generic. I know
tracepoints are grouped by systems, but its easier for tools to just
state a tracepoint name than the system:event pair.

trace_xen_bounced()
 or
trace_swiotlb_bounced()

Something other than just "bounced".

Thanks!

-- Steve

> +
>  	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir);
>  	if (map == SWIOTLB_MAP_ERROR)
>  		return DMA_ERROR_CODE;
