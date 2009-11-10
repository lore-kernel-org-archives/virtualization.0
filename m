From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 8/8] virtio: console: struct ports for multiple ports per
	device.
Date: Tue, 10 Nov 2009 23:44:02 +1030
Message-ID: <200911102344.03087.rusty@rustcorp.com.au>
References: <1257834450..rusty@rustcorp.com.au>
	<200911101727.03491.rusty@rustcorp.com.au>
	<20091110072414.GA17361@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091110072414.GA17361@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 10 Nov 2009 05:54:14 pm Amit Shah wrote:
> > 2) Do we really need more than input buffer at a time?  If not, it's easy to
> >    generalize the input callback.  This will be slow, but shouldn't be a
> >    problem.
> 
> In my testing of a vnc clipboard copy/paste, the vnc client only sent the
> clipboard data once and didn't bother about retransmitting if write()
> returned < len. It's a problem with the vnc client I used (tigervnc, which is
> based off tightvnc) though but adding that support would hurt?

Well, input buffer == read, output buffer == write.  But same deal.

And sure, simplest implementation would just return a short read/write.
But we can certainly loop inside our ->write and wait until all the data is
written, too (document why, maybe with O_NONBLOCK not looping).

> >    This should be really easy to construct, and for input in the !multiport
> >    path we can fake one up.  We ignore CONTINUES on input since we don't have
> >    a userspace API which understands framing (we'd need recvmsg).
> 
> The header should only be sent (and expected) in the multiport case, so
> this won't matter when the .._F_MULTIPORT feature is not found.

Yeah, but our code might be neater if we "always" have a header internally;
only one place would need to branch.  Obviously we have to see, but I was
thinking ahead.

> > 4) Hook it all together with the new feature bit.
> 
> I've actually split it into 4 feature bits:
> MULTIPORT means multiple ports and a header
> THROTTLE to save host and guest from OOM
> CACHING to allow ports to buffer data even after the char device is
>   closed
> UNPLUG to allow port unplug
> 
> (I added these as part of the splitting effort because they're now in
> individual patches)

OK, though I'm not adverse to partial feature implementations during a
consecutive patch series.
Technically, it's EXPERIMENTAL, so we can do stuff like that :)

Cheers,
Rusty.
