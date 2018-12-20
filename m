From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: 4.20-rc6: WARNING: CPU: 30 PID: 197360 at
	net/core/flow_dissector.c:764 __skb_flow_dissect
Date: Thu, 20 Dec 2018 09:41:59 -0500
Message-ID: <CAF=yD-Kfnc2mrJnPawTinhkpARK3Xf9Pmq6rZ__tMsLtZbmhww__28807.0477116436$1545334041$gmane$org@mail.gmail.com>
References: <ba519cd8-ab88-2868-f6d0-be321d8df0be@de.ibm.com>
	<20181220091207.GA25942@splinter>
	<CAF=yD-LJe_YjH-ssVb1c+yvEvKSDgBzUFMD8NxWKCKOEJPw30w@mail.gmail.com>
	<20181220141609.GA861@splinter>
	<CAF=yD-K6Y=Jt=KNLOtg-_c32bnp__c_3RM4XvO6Q-Zye-nd4=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAF=yD-K6Y=Jt=KNLOtg-_c32bnp__c_3RM4XvO6Q-Zye-nd4=A@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ido Schimmel <idosch@idosch.org>
Cc: Willem de Bruijn <willemb@google.com>, Michael S Tsirkin <mst@redhat.com>, Network Development <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 20, 2018 at 9:34 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Thu, Dec 20, 2018 at 9:16 AM Ido Schimmel <idosch@idosch.org> wrote:
> >
> > On Thu, Dec 20, 2018 at 09:04:25AM -0500, Willem de Bruijn wrote:
> > > On Thu, Dec 20, 2018 at 6:15 AM Ido Schimmel <idosch@idosch.org> wrote:
> > > >
> > > > +Willem
> > > >
> > > > On Thu, Dec 20, 2018 at 08:45:40AM +0100, Christian Borntraeger wrote:
> > > > > Folks,
> > > > >
> > > > > I got this warning today. I cant tell when and why this happened, so I do not know yet how to reproduce.
> > > > > Maybe someone has a quick idea.
> > > > >
> > > > > [85109.572032] WARNING: CPU: 30 PID: 197360 at net/core/flow_dissector.c:764 __skb_flow_dissect+0x1f0/0x1318
> > > >
> > > > I managed to trigger this warning as well the other day, but from a
> > > > different call path:
> > > >
> > > > [280155.348610]  fib_multipath_hash+0x28c/0x2d0
> > > > [280155.348613]  ? fib_multipath_hash+0x28c/0x2d0
> > > > [280155.348619]  fib_select_path+0x241/0x32f
> > > > [280155.348622]  ? __fib_lookup+0x6a/0xb0
> > > > [280155.348626]  ip_route_output_key_hash_rcu+0x650/0xa30
> > > > [280155.348631]  ? __alloc_skb+0x9b/0x1d0
> > > > [280155.348634]  inet_rtm_getroute+0x3f7/0xb80
> > >
> > > inet_rtm_getroute builds a new packet with inet_rtm_getroute_build_skb
> > > here without dev or sk.
> >
> > Ack
> >
> > >
> > > > Problem is the synthesized skb for output route resolution does not have
> > > > skb->dev or skb->sk set. When a multipath route is hit and
> > > > net.ipv4.fib_multipath_hash_policy is set the flow dissector is called
> > > > with this skb and the warning is triggered.
> > > >
> > > > I plan to fix it by setting skb->dev to net->loopback_dev.
> > >
> > > The device can be chosen based on iif in inet_rtm_getroute? A first
> > > thought, I don't know this code very well.
> >
> > Yes, but iif is for input routes. I'm talking about output routes.
> >
> > > Let me know if you want me to take a stab at that patch. IPv6 probably
> > > will need the same.
> >
> > Yes, I'll try it now and post later today if everything is OK. IPv6 is
> > using flow info and not an skb, so no problem there. I also checked
> > other getroute implementations and none of them call into the flow
> > dissector with an skb, so I think we're fine.
> >
> > >
> > > > I assume we
> > > > want to keep this warning to prevent call paths which will otherwise
> > > > silently fallback to standard flow dissector instead of the BPF one.
> > >
> > > Indeed, the warning is there to sniff out paths that do not follow
> > > what I thought was an invariant. If there are too many exceptions, I
> > > may have to revisit that assumption. But for now, let's see if we can
> > > address these edge cases.
> >
> > Ack
> >
> > >
> > > > I'm not familiar with tap code, so someone else will need to patch this
> > > > case, but it looks like:
> > > >
> > > > tap_sendmsg()
> > > >     tap_get_user()
> > > >         skb_probe_transport_header()
> > > >             skb_flow_dissect_flow_keys_basic()
> > > >                 __skb_flow_dissect()
> > > >
> > > > skb->dev is only set later in the code.
> > >
> > > tap_get_user uses sock_alloc_send_pskb (through tap_alloc_skb) to
> > > allocate the skb. So skb->sk should be set at the time of
> > > skb_probe_transport_header. I'm not sure how this path triggers the
> > > warning.
> >
> > Maybe it's:
> >
> > tap_sendmsg()
> >     tap_get_user_xdp()
> >         build_skb()
> >             skb_probe_transport_header()
> >                 skb_flow_dissect_flow_keys_basic()
> >                     __skb_flow_dissect()
>
> Oh, indeed. I completely overlooked that path.
>
> I will call skb_set_owner_w there and will audit the other users of build_skb.

Uhm, no, that may not be the right solution if these packets may
be injected into the receive path. This also affects the tun device
through tun_xdp_one, which calls netif_receive_skb.

I'll need to take a closer look. Other approach is to move the
assignment skb->dev = tap->dev earlier.
