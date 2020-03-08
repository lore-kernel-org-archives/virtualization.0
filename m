From: Tyler Sanderson via Virtualization
 <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date: Sat, 7 Mar 2020 20:47:25 -0800
Message-ID: <CAJuQAmphPcfew1v_EOgAdSFiprzjiZjmOf3iJDmFX0gD6b9TYQ@mail.gmail.com>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-4-david@redhat.com>
 <f31eff75-b328-de41-c2cc-e55471aa27d8@redhat.com>
 <20200216044641-mutt-send-email-mst@kernel.org>
 <CAJuQAmqmOQMx3A8g81pnFLyTZ5E5joSCEGG5fBwPOBH7crdi2w@mail.gmail.com>
Reply-To: Tyler Sanderson <tysand@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000ef877305a05095e9"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJuQAmqmOQMx3A8g81pnFLyTZ5E5joSCEGG5fBwPOBH7crdi2w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Nadav Amit <namit@vmware.com>, David Rientjes <rientjes@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

--000000000000ef877305a05095e9
Content-Type: text/plain; charset="UTF-8"

Tested-by: Tyler Sanderson <tysand@google.com>

Test setup: VM with 16 CPU, 64GB RAM. Running Debian 10. We have a 42
GB file full of random bytes that we continually cat to /dev/null.
This fills the page cache as the file is read. Meanwhile we trigger
the balloon to inflate, with a target size of 53 GB. This setup causes
the balloon inflation to pressure the page cache as the page cache is
also trying to grow. Afterwards we shrink the balloon back to zero (so
total deflate = total inflate).

Without patch (kernel 4.19.0-5):
Inflation never reaches the target until we stop the "cat file >
/dev/null" process. Total inflation time was 542 seconds. The longest
period that made no net forward progress was 315 seconds (see attached
graph).
Result of "grep balloon /proc/vmstat" after the test:
balloon_inflate 154828377
balloon_deflate 154828377

With patch (kernel 5.6.0-rc4+):
Total inflation duration was 63 seconds. No deflate-queue activity
occurs when pressuring the page-cache.
Result of "grep balloon /proc/vmstat" after the test:
balloon_inflate 12968539
balloon_deflate 12968539

Conclusion: This patch fixes the issue. In the test it reduced
inflate/deflate activity by 12x, and reduced inflation time by 8.6x.
But more importantly, if we hadn't killed the "grep balloon
/proc/vmstat" process then, without the patch, the inflation process
would never reach the target.

Attached is a png of a graph showing the problematic behavior without
this patch. It shows deflate-queue activity increasing linearly while
balloon size stays constant over the course of more than 8 minutes of
the test.


On Thu, Feb 20, 2020 at 7:29 PM Tyler Sanderson <tysand@google.com> wrote:
>
> Testing this patch is on my short-term TODO list, but I wasn't able to get to it this week. It is prioritized.
>
> In the meantime, I can anecdotally vouch that kernels before 4.19, the ones using the OOM notifier callback, have roughly 10x faster balloon inflation when pressuring the cache. So I anticipate this patch will return to that state and help my use case.
>
> I will try to post official measurements of this patch next week.
>
> On Sun, Feb 16, 2020 at 1:47 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Fri, Feb 14, 2020 at 10:51:43AM +0100, David Hildenbrand wrote:
>> > On 05.02.20 17:34, David Hildenbrand wrote:
>> > > Commit 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker")
>> > > changed the behavior when deflation happens automatically. Instead of
>> > > deflating when called by the OOM handler, the shrinker is used.
>> > >
>> > > However, the balloon is not simply some slab cache that should be
>> > > shrunk when under memory pressure. The shrinker does not have a concept of
>> > > priorities, so this behavior cannot be configured.
>> > >
>> > > There was a report that this results in undesired side effects when
>> > > inflating the balloon to shrink the page cache. [1]
>> > >     "When inflating the balloon against page cache (i.e. no free memory
>> > >      remains) vmscan.c will both shrink page cache, but also invoke the
>> > >      shrinkers -- including the balloon's shrinker. So the balloon
>> > >      driver allocates memory which requires reclaim, vmscan gets this
>> > >      memory by shrinking the balloon, and then the driver adds the
>> > >      memory back to the balloon. Basically a busy no-op."
>> > >
>> > > The name "deflate on OOM" makes it pretty clear when deflation should
>> > > happen - after other approaches to reclaim memory failed, not while
>> > > reclaiming. This allows to minimize the footprint of a guest - memory
>> > > will only be taken out of the balloon when really needed.
>> > >
>> > > Especially, a drop_slab() will result in the whole balloon getting
>> > > deflated - undesired. While handling it via the OOM handler might not be
>> > > perfect, it keeps existing behavior. If we want a different behavior, then
>> > > we need a new feature bit and document it properly (although, there should
>> > > be a clear use case and the intended effects should be well described).
>> > >
>> > > Keep using the shrinker for VIRTIO_BALLOON_F_FREE_PAGE_HINT, because
>> > > this has no such side effects. Always register the shrinker with
>> > > VIRTIO_BALLOON_F_FREE_PAGE_HINT now. We are always allowed to reuse free
>> > > pages that are still to be processed by the guest. The hypervisor takes
>> > > care of identifying and resolving possible races between processing a
>> > > hinting request and the guest reusing a page.
>> > >
>> > > In contrast to pre commit 71994620bb25 ("virtio_balloon: replace oom
>> > > notifier with shrinker"), don't add a moodule parameter to configure the
>> > > number of pages to deflate on OOM. Can be re-added if really needed.
>> > > Also, pay attention that leak_balloon() returns the number of 4k pages -
>> > > convert it properly in virtio_balloon_oom_notify().
>> > >
>> > > Note1: using the OOM handler is frowned upon, but it really is what we
>> > >        need for this feature.
>> > >
>> > > Note2: without VIRTIO_BALLOON_F_MUST_TELL_HOST (iow, always with QEMU) we
>> > >        could actually skip sending deflation requests to our hypervisor,
>> > >        making the OOM path *very* simple. Besically freeing pages and
>> > >        updating the balloon. If the communication with the host ever
>> > >        becomes a problem on this call path.
>> > >
>> >
>> > @Michael, how to proceed with this?
>> >
>>
>> I'd like to see some reports that this helps people.
>> e.g. a tested-by tag.
>>
>> > --
>> > Thanks,
>> >
>> > David / dhildenb
>>

--000000000000ef877305a05095e9
Content-Type: image/png; name="without_patch.png"
Content-Disposition: attachment; filename="without_patch.png"
Content-Transfer-Encoding: base64
Content-ID: <f_k7iikwfd0>
X-Attachment-Id: f_k7iikwfd0

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
--000000000000ef877305a05095e9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--000000000000ef877305a05095e9--
