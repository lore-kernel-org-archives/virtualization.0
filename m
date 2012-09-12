From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Add a page cache-backed balloon device driver.
Date: Wed, 12 Sep 2012 14:55:08 +0930
Message-ID: <87ligfdd8r.fsf@rustcorp.com.au>
References: <1340742778-11282-1-git-send-email-fes@google.com>
	<20120910090521.GB18544@redhat.com>
	<CAGTjWtBa5jW6+y1k6zZmD9TUNHBgv8WRbO_iy7huY_dJSumStw@mail.gmail.com>
	<20120910195931.GD20721@redhat.com>
	<CAGTjWtCiqjkR_Ze=0-ebO08+eziz6c8TXLb+O1iiArRQeSE6zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAGTjWtCiqjkR_Ze=0-ebO08+eziz6c8TXLb+O1iiArRQeSE6zw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mike Waychison <mikew@google.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Frank Swiderski <fes@google.com>, Andrea Arcangeli <aarcange@redhat.com>, Rik van Riel <riel@redhat.com>, kvm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Mike Waychison <mikew@google.com> writes:
> On Mon, Sep 10, 2012 at 3:59 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Mon, Sep 10, 2012 at 01:37:06PM -0400, Mike Waychison wrote:
>>> On Mon, Sep 10, 2012 at 5:05 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>> > On Tue, Jun 26, 2012 at 01:32:58PM -0700, Frank Swiderski wrote:
>>> >> This implementation of a virtio balloon driver uses the page cache to
>>> >> "store" pages that have been released to the host.  The communication
>>> >> (outside of target counts) is one way--the guest notifies the host when
>>> >> it adds a page to the page cache, allowing the host to madvise(2) with
>>> >> MADV_DONTNEED.  Reclaim in the guest is therefore automatic and implicit
>>> >> (via the regular page reclaim).  This means that inflating the balloon
>>> >> is similar to the existing balloon mechanism, but the deflate is
>>> >> different--it re-uses existing Linux kernel functionality to
>>> >> automatically reclaim.
>>> >>
>>> >> Signed-off-by: Frank Swiderski <fes@google.com>
>>>
>>> Hi Michael,
>>>
>>> I'm very sorry that Frank and I have been silent on these threads.
>>> I've been out of the office and Frank has been been swamped :)
>>>
>>> I'll take a stab at answering some of your questions below, and
>>> hopefully we can end up on the same page.

Hi Mike, Frank, Michael,

        Thanks for the explanation and discussion.  I like that this
implementation is more dynamic: the guest can use more pages for a while
(and the balloon kthread will furiously start trying to grab more pages
to give back).  This part is a completely reasonable implementation, and
more sophisticated that what we have.

It doesn't *quite* meet the spec, because we don't notify the host when
we pull a page from the balloon, but I think that is quite possible.  If
this is a performance waster, we should add a "SILENT_DEFLATE" feature
to tell the driver that it doesn't need to, though we should stll
support the !SILENT_DEFLATE case.

And Michael: thanks again for doing the heavy lifting on this!

Cheers,
Rusty.
