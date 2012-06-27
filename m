From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Add a page cache-backed balloon device driver.
Date: Wed, 27 Jun 2012 12:26:55 +0930
Message-ID: <87lij91myw.fsf@rustcorp.com.au>
References: <1340742778-11282-1-git-send-email-fes@google.com>
	<20120626214106.GC14054@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120626214106.GC14054@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Frank Swiderski <fes@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, riel@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mikew@google.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 27 Jun 2012 00:41:06 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Jun 26, 2012 at 01:32:58PM -0700, Frank Swiderski wrote:
> > This implementation of a virtio balloon driver uses the page cache to
> > "store" pages that have been released to the host.  The communication
> > (outside of target counts) is one way--the guest notifies the host when
> > it adds a page to the page cache, allowing the host to madvise(2) with
> > MADV_DONTNEED.  Reclaim in the guest is therefore automatic and implicit
> > (via the regular page reclaim).  This means that inflating the balloon
> > is similar to the existing balloon mechanism, but the deflate is
> > different--it re-uses existing Linux kernel functionality to
> > automatically reclaim.
> > 
> > Signed-off-by: Frank Swiderski <fes@google.com>
> 
> I'm pondering this:
> 
> Should it really be a separate driver/device ID?
> If it behaves the same from host POV, maybe it
> should be up to the guest how to inflate/deflate
> the balloon internally?

Well, it shouldn't steal ID 10, either way :)  Either use a completely
bogus number, or ask for an id.

But AFAICT this should be a an alternate driver of for the same device:
it's not really a separate device, is it?

Cheers,
Rusty.
