From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 12/28] virtio: console: Buffer data that comes in from the
	host
Date: Tue, 8 Dec 2009 11:46:10 +1030
Message-ID: <200912081146.11158.rusty@rustcorp.com.au>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<20091203034325.GA5340@amit-x200.redhat.com>
	<20091204110246.GA16363@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091204110246.GA16363@amit-x200.redhat.com>
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
Cc: Shirley Ma <mashirle@us.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 4 Dec 2009 09:32:46 pm Amit Shah wrote:
> On (Thu) Dec 03 2009 [09:13:25], Amit Shah wrote:
> > On (Thu) Dec 03 2009 [09:24:23], Rusty Russell wrote:
> > > On Wed, 2 Dec 2009 07:54:06 pm Amit Shah wrote:
> > > > On (Wed) Dec 02 2009 [14:14:20], Rusty Russell wrote:
> > > > > On Sat, 28 Nov 2009 05:20:35 pm Amit Shah wrote:
> > > > > > The console could be flooded with data from the host; handle
> > > > > > this situation by buffering the data.
> > > > > 
> > > > > All this complexity makes me really wonder if we should just
> > > > > have the host say the max # ports it will ever use, and just do this
> > > > > really dumbly.  Yes, it's a limitation, but it'd be much simpler.
> > > > 
> > > > As in make sure the max nr ports is less than 255 and have per-port vqs?
> > > > And then the buffering will be done inside the vqs themselves?
> > > 
> > > Well < 128 (two vqs per port).  The config would say (with a feature bit)
> > > how many vq pairs there are.
> > 
> > Sure. This was how the previous versions behaved as well.
> 
> I forgot one detail:
> 
> http://www.mail-archive.com/virtualization@lists.linux-foundation.org/msg06079.html
> 
> Some API changes are needed to pre-declare the number of vqs and the
> selectively enable them as ports get added.

Couldn't we make it that all vqs *exist*, they're just unused unless the
bitmap (or whatever) indicates?

Thanks,
Rusty.
