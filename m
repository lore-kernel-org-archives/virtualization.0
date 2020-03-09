From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date: Mon, 9 Mar 2020 10:03:14 +0100
Message-ID: <86453fed-1f39-dfcc-33c6-54241478e2ab@redhat.com>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-4-david@redhat.com>
 <f31eff75-b328-de41-c2cc-e55471aa27d8@redhat.com>
 <20200216044641-mutt-send-email-mst@kernel.org>
 <CAJuQAmqmOQMx3A8g81pnFLyTZ5E5joSCEGG5fBwPOBH7crdi2w@mail.gmail.com>
 <CAJuQAmphPcfew1v_EOgAdSFiprzjiZjmOf3iJDmFX0gD6b9TYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJuQAmphPcfew1v_EOgAdSFiprzjiZjmOf3iJDmFX0gD6b9TYQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tyler Sanderson <tysand@google.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtualization@lists.linux-foundation.org, Wei Wang <wei.w.wang@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, David Rientjes <rientjes@google.com>, Nadav Amit <namit@vmware.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 08.03.20 05:47, Tyler Sanderson wrote:
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

Thanks a lot for the extended test!

-- 
Thanks,

David / dhildenb
