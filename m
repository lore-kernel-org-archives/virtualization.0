From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
	passthru device
Date: Fri, 23 Feb 2018 15:59:04 -0800
Message-ID: <20180223155904.27b11865@xeon-e3>
References: <20180220201410.GF2031@nanopsycho>
	<20180220143356.3467084d@cakuba.netronome.com>
	<20180221095159.GA1996@nanopsycho>
	<CAKgT0UdyhrVr=pYZb=AJq9sWWUVb_BadbJTcqY1AwHHTw8cmQw@mail.gmail.com>
	<20180221161105.GC1996@nanopsycho>
	<CAKgT0Ud+6eiY7ycyju1SToeatH1R7KBDcUOqjn9Pu2k5uOr5Wg@mail.gmail.com>
	<20180221165848.GD1996@nanopsycho>
	<CAKgT0UeZS_SzNfiMX3ujy+a9WZWySVdyTpyQ=b=RJJrAG3JO=w@mail.gmail.com>
	<20180221193832.GE1996@nanopsycho>
	<CAKgT0Ud--R7Mw1_jFckskhGmGLZgZbTZ24TuvJ+UWvm_MAQR9w@mail.gmail.com>
	<20180222081115.GC1994@nanopsycho>
	<CAKgT0UeVhPOgRM0J6fyGDAJrTnqjc6AtC8+_UMs=hojZAajtdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAKgT0UeVhPOgRM0J6fyGDAJrTnqjc6AtC8+_UMs=hojZAajtdg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 22 Feb 2018 13:30:12 -0800
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> > Again, I undertand your motivation. Yet I don't like your solution.
> > But if the decision is made to do this in-driver bonding. I would like
> > to see it baing done some generic way:
> > 1) share the same "in-driver bonding core" code with netvsc
> >    put to net/core.
> > 2) the "in-driver bonding core" will strictly limit the functionality,
> >    like active-backup mode only, one vf, one backup, vf netdev type
> >    check (so noone could enslave a tap or anything else)
> > If user would need something more, he should employ team/bond.  

Sharing would be good, but netvsc world would really like to only have
one visible network device.
