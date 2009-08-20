From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv3 0/4] qemu-kvm: vhost net support
Date: Thu, 20 Aug 2009 10:03:21 +0300
Message-ID: <20090820070321.GA5448__10815.9959120259$1250751982$gmane$org@redhat.com>
References: <20090817123701.GA10700@redhat.com>
	<7162ab20908181354g653ecd2ch3b3dc36ca16babff@mail.gmail.com>
	<20090818210411.GD20393@redhat.com>
	<7162ab20908181411q4209d1f7v64b263712fd74852@mail.gmail.com>
	<7162ab20908181423l65f30744vc9a968c0e546a361@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <7162ab20908181423l65f30744vc9a968c0e546a361@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alex Williamson <alex.williamson@hp.com>
Cc: avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 18, 2009 at 03:23:02PM -0600, Alex Williamson wrote:
> On Tue, Aug 18, 2009 at 3:11 PM, Alex Williamson<alex.williamson@hp.com> =
wrote:
> > On Tue, Aug 18, 2009 at 3:04 PM, Michael S. Tsirkin<mst@redhat.com> wro=
te:
> >> Did you assign ip address in host by any chance? You don't want that.
> >
> > Nope, just up on the host, no IP:
> >
> > eth10 =A0 =A0 Link encap:Ethernet =A0HWaddr 00:17:a4:77:a4:08
> > =A0 =A0 =A0 =A0 =A0inet6 addr: fe80::217:a4ff:fe77:a408/64 Scope:Link
> > =A0 =A0 =A0 =A0 =A0UP BROADCAST RUNNING MULTICAST =A0MTU:1500 =A0Metric=
:1
> > =A0 =A0 =A0 =A0 =A0RX packets:22446487 errors:0 dropped:0 overruns:0 fr=
ame:0
> > =A0 =A0 =A0 =A0 =A0TX packets:4529008 errors:0 dropped:0 overruns:0 car=
rier:0
> > =A0 =A0 =A0 =A0 =A0collisions:0 txqueuelen:1000
> > =A0 =A0 =A0 =A0 =A0RX bytes:1492187453 (1.3 GiB) =A0TX bytes:2972806236=
 (2.7 GiB)
> > =A0 =A0 =A0 =A0 =A0Memory:fbae0000-fbb00000
> >
> =

> Hmm, I lose the dupe and get pretty respectable tcp_rr rates if I use
> the host as my target IP, is the issue maybe isolated to off-box
> communication?

I think the duplicates are our best hint that something's wrong at this
point. Let's try to see where do they come from.

What is it exactly that you see? This ping is external box to guest,
correct? Is it the external box that gets duplicates or the guest?
What happens when you ping the other way?
What does tcpdump show on both sides when you ping?

A couple of extra datapoints to check:
- What if you assign a different IP to the host (in the same subnet) and
  try external guest to host?
- Is the card in promisc mode? What if you disable promisc mode?

Also, it seems that you have an external bridge that sends your outgoing
packets back to you. Is that right?

Thanks!

> tcp_stream is still worse than userspace though.
> =

> Alex
