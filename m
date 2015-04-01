From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/6] virtio_balloon: transitional interface
Date: Wed, 1 Apr 2015 15:00:58 +0200
Message-ID: <20150401132526-mutt-send-email-mst@redhat.com>
References: <1427831230-28044-1-git-send-email-mst@redhat.com>
	<1427831230-28044-2-git-send-email-mst@redhat.com>
	<87mw2sy0fo.fsf@rustcorp.com.au>
	<20150401094236-mutt-send-email-mst@redhat.com>
	<87h9t06w3h.fsf@rustcorp.com.au>
	<20150401113300-mutt-send-email-mst@redhat.com>
	<20150401122244.5a033ff5.cornelia.huck@de.ibm.com>
	<20150401122413-mutt-send-email-mst@redhat.com>
	<20150401125748.2ec33b97.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150401125748.2ec33b97.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 01, 2015 at 12:57:48PM +0200, Cornelia Huck wrote:
> On Wed, 1 Apr 2015 12:28:30 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Apr 01, 2015 at 12:22:44PM +0200, Cornelia Huck wrote:
> > > On Wed, 1 Apr 2015 11:43:46 +0200
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > 
> > > > On Wed, Apr 01, 2015 at 07:53:14PM +1030, Rusty Russell wrote:
> > > > > "Michael S. Tsirkin" <mst@redhat.com> writes:
> > > > > > On Wed, Apr 01, 2015 at 02:17:23PM +1030, Rusty Russell wrote:
> > > > > >> I would leave the device *exactly* as is, ugly structure packing and
> > > > > >> all.
> > > > > >
> > > > > > But why?  It's going to be used for years, might as well make it clean?
> > > > > 
> > > > > Because the only spec which currently exists says to do that.
> > > > 
> > > > OK but the only spec which currently exists also says it's a legacy only
> > > > device, so driver must not set VERSION_1.  So surely, we can make minor
> > > > changes when VERSION_1 is set, like we did for other devices.
> > > 
> > > But we don't plan to replace the other devices, so it makes sense to do
> > > some changes for 1.0.
> > 
> > I'm not sure what the above says. Do you agree with
> > making minor changes in device behaviour?
> 
> The other way around.
> 
> > Also to be clear, I think this is 1.1 material.
> 
> Btw, I'd really like to see your proposed spec updates.

Just sent.

> > 
> > > > 
> > > > Let me post the latest patches I'm working on,
> > > > see what you think then.
> > > > 
> > > > >  We do
> > > > > need a new virtio memballoon spec, but it'll look nothing like this
> > > > > anyway.
> > > > > 
> > > > > Cheers,
> > > > > Rusty.
> > > > 
> > > > I think it's going to have significantly different semantics, too,
> > > > so not much value in making that one work with current
> > > > drivers, right?
> > > > 
> > > 
> > > So why not just keep virtio-balloon as-is and just specify endianness
> > > etc. for 1.0? Keeps the old drivers going without hacks,
> > > and we can
> > > start with a fresh driver for the new virtio-balloon.
> > 
> > Well it doesn't really, we need cpu_to_virtio in a bunch of
> > places anyway.
> 
> Of course, but what about keeping changes minimal?
> > 
> > So I kind of prefer making it clean, even just to avoid setting a bad
> > example for other devices.
> > 
> > Let me post the new patch where it's all fixed in a cleaner way, and
> > everyone can discuss whether it's too much work.
> > 
