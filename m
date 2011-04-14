From: Rusty Russell <rusty@ozlabs.org>
Subject: Re: [RFC][PATCH] virtio balloon: kill tell-host-first logic
Date: Thu, 14 Apr 2011 21:07:41 +0930
Message-ID: <878vvdawsa.fsf__1554.74729040197$1302905929$gmane$org@rustcorp.com.au>
References: <20110407174325.ED21C82B@kernel>
	<20110411110131.GA23123@redhat.com>
	<1302559871.7286.16749.camel@nimitz>
	<20110412054330.GH26678@amit-x200.redhat.com>
	<1302625352.8321.2126.camel@nimitz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1302625352.8321.2126.camel@nimitz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Hansen <dave@linux.vnet.ibm.com>, Amit Shah <amit.shah@redhat.com>
Cc: Anthony Liguori <aliguori@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 12 Apr 2011 09:22:32 -0700, Dave Hansen <dave@linux.vnet.ibm.com> wrote:
> On Tue, 2011-04-12 at 11:13 +0530, Amit Shah wrote:
> > Sure, the only contention was on the commit message, where you stated
> > modern qemus set this... qemu doesn't, and it should.  Care to do a
> > patch for that? 
> 
> If Rusty hasn't pushed the commit out anywhere, we can still amend the
> commit.  Otherwise, we're in a _bit_ of a pickle since you can't patch
> git logs. :)

I only use git to send patches to Linus, and even if I did, I certainly
wouldn't try to publish an non-rebasing tree for exactly this reason.

So send me the new commit, or just the new message...

Thanks,
Rusty.
