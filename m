From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 12/28] virtio: console: Buffer data that comes in from the
	host
Date: Thu, 3 Dec 2009 09:24:23 +1030
Message-ID: <200912030924.23783.rusty@rustcorp.com.au>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<200912021414.20206.rusty@rustcorp.com.au>
	<20091202092406.GB28265@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091202092406.GB28265@amit-x200.redhat.com>
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
Cc: Shirley Ma <mashirle@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2 Dec 2009 07:54:06 pm Amit Shah wrote:
> On (Wed) Dec 02 2009 [14:14:20], Rusty Russell wrote:
> > On Sat, 28 Nov 2009 05:20:35 pm Amit Shah wrote:
> > > The console could be flooded with data from the host; handle
> > > this situation by buffering the data.
> > 
> > All this complexity makes me really wonder if we should just
> > have the host say the max # ports it will ever use, and just do this
> > really dumbly.  Yes, it's a limitation, but it'd be much simpler.
> 
> As in make sure the max nr ports is less than 255 and have per-port vqs?
> And then the buffering will be done inside the vqs themselves?

Well < 128 (two vqs per port).  The config would say (with a feature bit)
how many vq pairs there are.  If we want expect sparse port numbers, it can
also provide an array mapping the vq pairs to the port number (65535 or
something meaning unused).  In practice I suspect 4 or 8 will be plenty
for now.

That makes hotplugging ports pretty simple: change the array, ping
config_changed.

Or we could abandon numbers and just use the names; I don't mind (we still
need a way to figure out what ports are active I guess, maybe a bitmap in
the config?)

But we get the vq buffering and flow control for free with this approach.

Cheers,
Rusty.
