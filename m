From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Date: Sat, 8 Feb 2020 21:32:54 +0900
Message-ID: <345addae-0945-2f49-52cf-8e53446e63b2@i-love.sakura.ne.jp>
References: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: tysand@google.com, mst@redhat.com, david@redhat.com, alexander.h.duyck@linux.intel.com, rientjes@google.com, mhocko@kernel.org, namit@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

On 2020/02/06 17:01, Wei Wang wrote:
> There are cases that users want to shrink balloon pages after the
> pagecache depleted. The conservative_shrinker lets the shrinker
> shrink balloon pages when all the pagecache has been reclaimed.
> 
> @@ -796,6 +800,10 @@ static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,
>  {
>  	unsigned long pages_freed = 0;
>  
> +	/* Balloon pages only gets shrunk when the pagecache depleted */
> +	if (conservative_shrinker && global_node_page_state(NR_FILE_PAGES))
> +		return 0;
> +

Is this NUMA aware? Can "node-A's NR_FILE_PAGES is already 0 and node-B's
NR_FILE_PAGES is not 0, but allocation request which triggered this shrinker
wants to allocate from only node-B" happen? Can some thread keep this shrinker
defunctional by keep increasing NR_FILE_PAGES?

Is this patch from "Re: Balloon pressuring page cache" thread? I hope that
the guest could start reclaiming memory based on host's request (like OOM
notifier chain) which is issued when host thinks that host is getting close
to OOM and thus guests should start returning their unused memory to host.
Maybe "periodically (e.g. 5 minutes)" in addition to "upon close to OOM
condition" is also possible.
