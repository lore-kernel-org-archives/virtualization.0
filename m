From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3 9/9] virtio: console: prevent use-after-free of port
	name in port unplug
Date: Thu, 01 Aug 2013 10:29:35 +0930
Message-ID: <87ob9i445k.fsf@rustcorp.com.au>
References: <cover.1374759439.git.amit.shah@redhat.com>
	<83c058bc32c4e377a75235120885aec7dfd223c7.1374759439.git.amit.shah@redhat.com>
	<871u6i6k2e.fsf@rustcorp.com.au> <20130731081029.GB27354@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130731081029.GB27354@grmbl.mre>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah <amit.shah@redhat.com> writes:
> On (Mon) 29 Jul 2013 [14:26:09], Rusty Russell wrote:
>> Amit Shah <amit.shah@redhat.com> writes:
>> > Remove the debugfs path before freeing port->name, to prevent a possible
>> > use-after-free.
>> >
>> > Reported-by: Jason Wang <jasowang@redhat.com>
>> > Signed-off-by: Amit Shah <amit.shah@redhat.com>
>> 
>> Applied,
>> Rusty.
>
> Hey Rusty, I don't see this patch in your virtio-next branch:
>
> https://git.kernel.org/cgit/linux/kernel/git/rusty/linux.git/log/?h=virtio-next
>
> The others are present there.  Looks like this one got missed?

Actually, it's in my pending-rebases branch, since it requireds things
from the fixes branch.  Once the fixes branch has gone to Linus (this
week) I will merge it into the virtio-next branch then apply this on
top.

It's generally considered bad form to merge into -next branches, but
it's allowed for cases like this.  But I want to make sure no changes to
fixes are required before I merge it, hence the delay for some exposure
in linux-next.

Cheers,
Rusty.
