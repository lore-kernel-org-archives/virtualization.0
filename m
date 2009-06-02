From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/4] virtio_net: don't free buffers in xmit ring
Date: Tue, 2 Jun 2009 23:37:33 +0930
Message-ID: <200906022337.33799.rusty__48352.5284835652$1243952160$gmane$org@rustcorp.com.au>
References: <200905292346.24141.rusty@rustcorp.com.au>
	<1243930422.9146.60.camel@blaa> <1243942902.9146.216.camel@blaa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1243942902.9146.216.camel@blaa>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2 Jun 2009 09:11:42 pm Mark McLoughlin wrote:
> On Tue, 2009-06-02 at 09:13 +0100, Mark McLoughlin wrote:
> > I think skb_orphan() is enough to prevent this, is it?
>
> Oops, I meant:
>
>   I don't think skb_orphan() is enough to prevent this, is it?

Yes, point taken.  No, it's not.  We could add nf_reset here too, which would 
be perfectly sane.

I'm tempted to avoid the question marks hanging over generic skb_orphan for 
now, and just do skb_orphan & nf_reset at the head of our driver.

Then look at making skb_orphan do nf_reset.  It makes sense, but I'd have to 
audit all the callers.

Thanks.
Rusty.
