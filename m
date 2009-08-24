From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost net: performance with ping benchmark
Date: Tue, 25 Aug 2009 00:21:37 +0300
Message-ID: <20090824212137.GA9835__9127.55463873527$1251149348$gmane$org@redhat.com>
References: <20090824081240.GA3415@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090824081240.GA3415@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 24, 2009 at 11:12:41AM +0300, Michael S. Tsirkin wrote:
> At Rusty's suggestion, I tested vhost base performance with ping.
> Results below, and seem to be what you'd expect.

Rusty, any chance you could look at the code?  Is it in reasonable
shape? I think it makes sense to merge it through you. What do you
think?  One comment on file placement: I put files under a separate
vhost directory to avoid confusion with virtio-net which runs in guest.
Does this sound sane?  Also, can a minimal version (without TSO, tap or
any other features) be merged upstream first so that features can be
added later? Or do we have to wait until it's more full featured?
Finally, can it reasonably make 2.6.32, or you think it needs more time
out of tree?

Thanks very much,

-- 
MST
