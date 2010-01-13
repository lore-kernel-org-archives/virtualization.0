From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 18/31] virtio: console: Buffer data that comes from the
	host
Date: Thu, 14 Jan 2010 09:45:12 +1030
Message-ID: <201001140945.12345.rusty@rustcorp.com.au>
References: <1261492481-19817-1-git-send-email-amit.shah@redhat.com>
	<201001132143.32464.rusty@rustcorp.com.au>
	<20100113112452.GA24002@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100113112452.GA24002@amit-x200.redhat.com>
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

On Wed, 13 Jan 2010 09:54:52 pm Amit Shah wrote:
> On (Wed) Jan 13 2010 [21:43:32], Rusty Russell wrote:
> > On Wed, 13 Jan 2010 04:41:48 pm Amit Shah wrote:
> > > On (Mon) Jan 04 2010 [15:17:17], Amit Shah wrote:
> > > > On (Mon) Jan 04 2010 [19:45:30], Rusty Russell wrote:
> > > > > On Wed, 23 Dec 2009 01:04:28 am Amit Shah wrote:
> > > > > > The console could be flooded with data from the host; handle this
> > > > > > situation by buffering the data.
> > > > > 
> > > > > Is this still true?  If we only add_buf when we're ready, surely the host
> > > > > can't flood us with one virtqueue per port?
> > > > 
> > > > I guess I meant something completely different. This message is
> > > > definitely misleading and I'll re-word it.
> > > > 
> > > > You're right; we don't need the 'guest throttling' feature that was
> > > > needed earlier.
> > > 
> > > BTW I meant this series doesn't have the guest throttling feature.
> > > 
> > > Rusty, did you just have this comment for the series? If yes, I'll just
> > > re-send this patch with a fixed description.
> > 
> > I don't see why we ever allocate more than one incoming buffer though?
> 
> To prevent against a fast host app sending data to a slow guest
> consumer.
> 
> Also, we use the in_vq for the buffering, so the number of buffers is
> limited by the queue size that's declared by the host.

But if the guest only ever registers one input buffer at a time, we get the
same effect.  And it means we use less memory.  And our code is simpler.

Similar with output.

Cheers,
Rusty.
