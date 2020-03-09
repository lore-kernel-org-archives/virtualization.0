From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date: Mon, 9 Mar 2020 06:24:24 -0400
Message-ID: <20200309062311-mutt-send-email-mst@kernel.org>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-4-david@redhat.com>
 <f31eff75-b328-de41-c2cc-e55471aa27d8@redhat.com>
 <20200216044641-mutt-send-email-mst@kernel.org>
 <CAJuQAmqmOQMx3A8g81pnFLyTZ5E5joSCEGG5fBwPOBH7crdi2w@mail.gmail.com>
 <CAJuQAmphPcfew1v_EOgAdSFiprzjiZjmOf3iJDmFX0gD6b9TYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuQAmphPcfew1v_EOgAdSFiprzjiZjmOf3iJDmFX0gD6b9TYQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tyler Sanderson <tysand@google.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtualization@lists.linux-foundation.org, Wei Wang <wei.w.wang@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, David Rientjes <rientjes@google.com>, Nadav Amit <namit@vmware.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Mar 07, 2020 at 08:47:25PM -0800, Tyler Sanderson wrote:
> Tested-by: Tyler Sanderson <tysand@google.com>
> 
> Test setup: VM with 16 CPU, 64GB RAM. Running Debian 10. We have a 42
> GB file full of random bytes that we continually cat to /dev/null.
> This fills the page cache as the file is read. Meanwhile we trigger
> the balloon to inflate, with a target size of 53 GB. This setup causes
> the balloon inflation to pressure the page cache as the page cache is
> also trying to grow. Afterwards we shrink the balloon back to zero (so
> total deflate = total inflate).
> 
> Without patch (kernel 4.19.0-5):
> Inflation never reaches the target until we stop the "cat file >
> /dev/null" process. Total inflation time was 542 seconds. The longest
> period that made no net forward progress was 315 seconds (see attached
> graph).
> Result of "grep balloon /proc/vmstat" after the test:
> balloon_inflate 154828377
> balloon_deflate 154828377
> 
> With patch (kernel 5.6.0-rc4+):
> Total inflation duration was 63 seconds. No deflate-queue activity
> occurs when pressuring the page-cache.
> Result of "grep balloon /proc/vmstat" after the test:
> balloon_inflate 12968539
> balloon_deflate 12968539
> 
> Conclusion: This patch fixes the issue. In the test it reduced
> inflate/deflate activity by 12x, and reduced inflation time by 8.6x.
> But more importantly, if we hadn't killed the "grep balloon
> /proc/vmstat" process then, without the patch, the inflation process
> would never reach the target.
> 
> Attached is a png of a graph showing the problematic behavior without
> this patch. It shows deflate-queue activity increasing linearly while
> balloon size stays constant over the course of more than 8 minutes of
> the test.

OK this is now queued for -next. Tyler thanks a lot for the detailed
test report - it's really awesome! I included it in the commit log in
full so that if we need to come back to this it's easy to reproduce the
testing.

-- 
MST
