From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
Date: Thu, 12 Jul 2018 19:34:16 +0800
Message-ID: <5B473CB8.1050306__11803.4749328674$1531394897$gmane$org@intel.com>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
	<1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
	<CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
	<5B455D50.90902@intel.com>
	<CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com>
	<20180711092152.GE20050@dhcp22.suse.cz>
	<CA+55aFwku2tDH4+rfaC67xc4-cEwSrXgnQaci=e2id5ZCRE9JQ@mail.gmail.com>
	<5B46BB46.2080802@intel.com>
	<CA+55aFxyv=EUAJFUSio=k+pm3ddteojshP7Radjia5ZRgm53zQ@mail.gmail.com>
	<5B46C258.40601@intel.com> <20180712081317.GD32648@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180712081317.GD32648@dhcp22.suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michal Hocko <mhocko@kernel.org>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, Rik van Riel <riel@redhat.com>, quan.xu0@gmail.com, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, liliang.opensource@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, linux-mm <linux-mm@kvack.org>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, nilal@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 07/12/2018 04:13 PM, Michal Hocko wrote:
> On Thu 12-07-18 10:52:08, Wei Wang wrote:
>> On 07/12/2018 10:30 AM, Linus Torvalds wrote:
>>> On Wed, Jul 11, 2018 at 7:17 PM Wei Wang <wei.w.wang@intel.com> wrote:
>>>> Would it be better to remove __GFP_THISNODE? We actually want to get all
>>>> the guest free pages (from all the nodes).
>>> Maybe. Or maybe it would be better to have the memory balloon logic be
>>> per-node? Maybe you don't want to remove too much memory from one
>>> node? I think it's one of those "play with it" things.
>>>
>>> I don't think that's the big issue, actually. I think the real issue
>>> is how to react quickly and gracefully to "oops, I'm trying to give
>>> memory away, but now the guest wants it back" while you're in the
>>> middle of trying to create that 2TB list of pages.
>> OK. virtio-balloon has already registered an oom notifier
>> (virtballoon_oom_notify). I plan to add some control there. If oom happens,
>> - stop the page allocation;
>> - immediately give back the allocated pages to mm.
> Please don't. Oom notifier is an absolutely hideous interface which
> should go away sooner or later (I would much rather like the former) so
> do not build a new logic on top of it. I would appreciate if you
> actually remove the notifier much more.
>
> You can give memory back from the standard shrinker interface. If we are
> reaching low reclaim priorities then we are struggling to reclaim memory
> and then you can start returning pages back.

OK. Just curious why oom notifier is thought to be hideous, and has it 
been a consensus?

Best,
Wei
