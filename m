From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Memory corruption in powerpc guests with virtio_balloon (was Re:
	[PATCH v3] virtio_balloon: fix deadlock on OOM)
Date: Sun, 03 Dec 2017 21:04:40 +1100
Message-ID: <87lgikw2iv.fsf@concordia.ellerman.id.au>
References: <1510154064-9709-1-git-send-email-mst@redhat.com>
	<87o9nid3zn.fsf@concordia.ellerman.id.au>
	<20171201164129-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171201164129-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Fri, Dec 01, 2017 at 11:31:08PM +1100, Michael Ellerman wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > fill_balloon doing memory allocations under balloon_lock
>> > can cause a deadlock when leak_balloon is called from
>> > virtballoon_oom_notify and tries to take same lock.
...
>> 
>> 
>> Somehow this commit seems to be killing powerpc guests.
...
>
> Thanks for the report!
> A fix was just posted:
> virtio_balloon: fix increment of vb->num_pfns in fill_balloon()
>
> Would appreciate testing.

Yep that fixes it. Thanks.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
