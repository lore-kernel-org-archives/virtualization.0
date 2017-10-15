From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH] virtio: avoid possible OOM lockup at
	virtballoon_oom_notify()
Date: Sun, 15 Oct 2017 14:38:48 +0900
Message-ID: <201710151438.FAD86443.tOOFHVOSFQJLMF__39517.3679957681$1508045978$gmane$org@I-love.SAKURA.ne.jp>
References: <1507632457-4611-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<20171013162134-mutt-send-email-mst@kernel.org>
	<201710140141.JFF26087.FLQHOFOOtFMVSJ@I-love.SAKURA.ne.jp>
	<20171015030921-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171015030921-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: linux-mm@kvack.org, virtualization@lists.linux-foundation.org, mhocko@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> > > 
> > > The proper fix isn't that hard - just avoid allocations under lock.
> > > 
> > > Patch posted, pls take a look.
> > 
> > Your patch allocates pages in order to inflate the balloon, but
> > your patch will allow leak_balloon() to deflate the balloon.
> > How deflating the balloon (i.e. calling leak_balloon()) makes sense
> > when allocating pages for inflating the balloon (i.e. calling
> > fill_balloon()) ?
> 
> The idea is that fill_balloon is allocating memory with __GFP_NORETRY
> so it will avoid disruptive actions like the OOM killer.
> Under pressure it will normally fail and retry in half a second or so.
> 
> Calling leak_balloon in that situation could benefit the system as a whole.
> 
> I might be misunderstanding the meaning of the relevant GFP flags,
> pls correct me if I'm wrong.

Would you answer to below question by "yes"/"no" ?

  If leak_balloon() is called via out_of_memory(), leak_balloon()
  will decrease "struct virtio_balloon"->num_pages.
  But, is "struct virtio_balloon_config"->num_pages updated when
  leak_balloon() is called via out_of_memory() ?

Below explanation assumes that your answer is "no".

I consider that fill_balloon() is using __GFP_NORETRY is a bug.
Consider an extreme situation that guest1 is started with 8192MB
memory and then guest1's memory is reduced to 128MB by

  virsh qemu-monitor-command --domain guest1 --hmp 'balloon 128'

when VIRTIO_BALLOON_F_DEFLATE_ON_OOM was not negotiated.
Of course, 128MB would be too small to operate guest1 properly.
Since update_balloon_size_func() continues calling fill_balloon()
until guest1's memory is reduced to 128MB, you will see flooding of
"puff" messages (and guest1 is practically unusable because all CPU
resource will be wasted for unsuccessful memory reclaim attempts)
unless the OOM killer is invoked.

What this patch is trying to handle is a situation when
VIRTIO_BALLOON_F_DEFLATE_ON_OOM was negotiated. Once
update_balloon_size_func() started calling fill_balloon(),
update_balloon_size_func() will continue calling fill_balloon()
until guest1's memory is reduced to 128MB, won't it?

Since fill_balloon() uses __GFP_IO | __GFP_FS, fill_balloon() can
indirectly trigger out_of_memory() despite __GFP_NORETRY is specified.

When update_balloon_size_func() is running for calling fill_balloon(),
calling leak_balloon() will increase number of pages to fill which
fill_balloon() is supposed to fill. Leaking some pages from leak_balloon()
via blocking_notifier_call_chain() callback could avoid invocation of the
OOM killer for that specific moment, but it bounces back to us later because
number of pages to allocate later (note that update_balloon_size_func() is
running for calling fill_balloon()) is increased by leak_balloon().

Thus, I don't think that avoid invoking the OOM killer by calling leak_balloon()
makes sense when update_balloon_size_func() is running for calling fill_balloon().
And this patch tries to detect it by replacing mutex_lock() with mutex_trylock().

> Well the point of this flag is that when it's acked,
> host knows that it's safe to inflate the balloon
> to a large portion of guest memory and this won't
> cause an OOM situation.

Assuming that your answer to the question is "no", I don't think it is
safe to inflate the balloon to a large portion of guest memory, for once
update_balloon_size_func() started calling fill_balloon(),
update_balloon_size_func() can not stop calling fill_balloon() even when
blocking_notifier_call_chain() callback called leak_balloon() because
"struct virtio_balloon_config"->num_pages will not be updated when
blocking_notifier_call_chain() callback called leak_balloon().
