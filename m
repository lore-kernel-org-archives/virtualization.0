From: Andrew Jones <drjones@redhat.com>
Subject: Re: [Xen-devel] [PATCH] blkfront: don't change to closing if we're
	busy
Date: Fri, 17 Feb 2012 17:52:54 +0100
Message-ID: <20120217165253.GA17397@turtle.usersys.redhat.com>
References: <1329394629-10299-1-git-send-email-drjones@redhat.com>
	<7bc7b30a-158e-411a-8eac-9650790c0bec@zmail17.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <7bc7b30a-158e-411a-8eac-9650790c0bec@zmail17.collab.prod.int.phx2.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: xen-devel@lists.xensource.com
Cc: jeremy@goop.org, virtualization@lists.linux-foundation.org, konrad wilk <konrad.wilk@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 16, 2012 at 12:33:32PM -0500, Andrew Jones wrote:
> Hmm, I should maybe self-nack this. The bug that led me to writing
> it is likely only with older tooling, such as RHEL5's. The problem
> was if you attempted to detach a mounted disk twice, then the second
> time it would succeed. The guest had flipped to Closing on the first
> try, and thus didn't issue an error to xenbus on the second. I see

Actually, it's even worse than I thought. Just a single attempt to
detach the device will cause the guest grief (with RHEL5's tools
anyway). Once xenbus shows the device is in the Closing state, then
tasks accessing the device may hang.

> The reason I only say maybe self-nack though, is because this state
> change seemed to be thrown in with another fix[1]. I'm not sure if
> the new behavior on legacy hosts was considered or not. If not, then
> we can consider it now. Do we want to have deferred asynch detaches
> over protecting the guest from multiple detach calls on legacy hosts?
> 

I guess we can keep the feature and protect the guest with a patch like
I'll send in a moment. It doesn't really work for me with a RHEL5 host
though. The deferred close works from the pov of the guest, but the
state of the block device gets left in Closed after the guest unmounts
it, and then RHEL5's tools can't detach/reattach it. If the deferred
close ever worked on other Xen hosts though, then I don't believe this
patch would break it, and it will also keep the guest safe when run on
hosts that don't treat state=Closing the way it currently expects.

Drew
