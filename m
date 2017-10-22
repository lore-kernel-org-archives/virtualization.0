From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 0/3] Virtio-balloon Improvement
Date: Sun, 22 Oct 2017 06:19:56 +0300
Message-ID: <20171022061307-mutt-send-email-mst__3645.21205560795$1508642430$gmane$org@kernel.org>
References: <1508500466-21165-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1508500466-21165-1-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: penguin-kernel@I-love.SAKURA.ne.jp, linux-mm@kvack.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mhocko@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 20, 2017 at 07:54:23PM +0800, Wei Wang wrote:
> This patch series intends to summarize the recent contributions made by
> Michael S. Tsirkin, Tetsuo Handa, Michal Hocko etc. via reporting and
> discussing the related deadlock issues on the mailinglist. Please check
> each patch for details.
> 
> >From a high-level point of view, this patch series achieves:
> 1) eliminate the deadlock issue fundamentally caused by the inability
> to run leak_balloon and fill_balloon concurrently;

We need to think about this carefully. Is it an issue that
leak can now bypass fill? It seems that we can now
try to leak a page before fill was seen by host,
but I did not look into it deeply.

I really like my patch for this better at least for
current kernel. I agree we need to work more on 2+3.

> 2) enable OOM to release more than 256 inflated pages; and

Does just this help enough? How about my patch + 2?
Tetsuo, what do you think?

> 3) stop inflating when the guest is under severe memory pressure
> (i.e. OOM).

But when do we finally inflate?  Question is how does host know it needs
to resend an interrupt, and when should it do it?


> Here is an example of the benefit brought by this patch series:
> The guest sets virtio_balloon.oom_pages=100000. When the host requests
> to inflate 7.9G of an 8G idle guest, the guest can still run normally
> since OOM can guarantee at least 100000 pages (400MB) for the guest.
> Without the above patches, the guest will kill all the killable
> processes and fall into kernel panic finally.
> 
> Wei Wang (3):
>   virtio-balloon: replace the coarse-grained balloon_lock
>   virtio-balloon: deflate up to oom_pages on OOM
>   virtio-balloon: stop inflating when OOM occurs
> 
>  drivers/virtio/virtio_balloon.c | 149 ++++++++++++++++++++++++----------------
>  1 file changed, 91 insertions(+), 58 deletions(-)
> 
> -- 
> 2.7.4
