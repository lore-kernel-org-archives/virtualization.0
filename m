From: San Mehat <san@google.com>
Subject: Re: [RFC 0/0] Introducing a generic socket offload framework
Date: Thu, 18 Aug 2011 16:18:47 -0700
Message-ID: <CAPi7mHqV6Pgk5tSt+fJn_2aEZKZbO=aO78JXgw7MvDaW0musoQ__45446.4610237212$1313769946$gmane$org@mail.gmail.com>
References: <20110818220756.5C93E5C80B@san.sea.corp.google.com>
	<20110818235719.50365b0b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110818235719.50365b0b@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mst@redhat.com, netdev@vger.kernel.org, miche@google.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, digitaleric@google.com, mikew@google.com, maccarro@google.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 18, 2011 at 3:57 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> The Berkeley sockets coprocessor is a virtual PCI device which has the a=
bility
>> to offload socket activity from an unmodified application at the BSD soc=
kets
>
> Ok I think there is an important question here. Why is this being
> designed for a specific virtual interface. Unix has always had the notion
> that socket operations can be in part generic and that you can pass a
> properly designed program a socket without any notion of what it is for.

Sorry Alan if I wasn't clear, but I'm not quite sure what you're asking...

If you're asking 'why have you only spec'ed out a virtual interface
for this' then
my answer would be 'but of course you could design this in real hardware and
have a proper driver :)'. If you'd prefer that I call that out
specifically I'm happy to do so.

I have no desire to change the 'genericness' of sockets.. just the
opposite - i wish to
introduce the notion that sockets (can be) completely generic (when
offloaded) as far as
the guest is concerned.

>
>> Lastly, pushing socket processing back into the host allows for host-side
>> control of the network protocols used, which limits the potential conges=
tion
>> problems that can arise when various guests are using their own congesti=
on
>> control algorithms.
>
> Does that not depend which side does the congestion and who parcels out
> buffers ?

It does, and it does.

>
>> Since we wish to allow these paravirtualized sockets to coexist peaceful=
ly with
>> the existing Linux socket system, we've chosen to introduce the idea tha=
t a
>> socket can at some point transition from being managed by the O/S socket=
 system
>> to a more enlightened 'hardware assisted' socket. The transition is mana=
ged by
>> a 'socket coprocessor' component which intercepts and gets first right of
>> refusal on handling certain global socket calls (connect, sendto, bind, =
etc...).
>> In this initial design, the policy on whether to transition a socket or =
not is
>> made by the virtual hardware, although we understand that further measur=
ement
>> into operation latency is warranted.
>
> Q: whay happens about in process socket syscalls in another thread ?
> Thats always been the ugly in these cases either by intercepting or by
> swapping file operations on an object.
>
>> =A0* SOCK_HWASSIST
>> =A0 =A0 Indicates socket operations are handled by hardware
>
> This guest only view means you can't use the abstraction for local
> sockets too.
>

To be honest, the way we're attempting to integrate is in such a way
that you *could*
offload AF_LOCAL sockets...  but that world gets a bit too much like
the 'Twilight Zone'
for my current linkings..

>> In order to support a variety of socket address families, addresses are
>> converted from their native socket family to an opaque string. Our initi=
al
>> design formats these strings as URIs. The currently supported conversion=
s are:
>
> That makes a lot of sense to me, because its a well understood
> abstraction and you can offload other stuff to this kind of generic
> socket including things like http protocol acceleration, SSL and so on.
>
> Plus its always been annoying that you can't open a socket, but a URI
> interface solves that...

Indeed.

>
>> =A0* We don't handle SOCK_SEQPACKET, SOCK_RAW, SOCK_RDM, or SOCK_PACKET =
sockets.
>
> But there is no reason SEQPACKET and RDM couldn't be added I assume?

No reason I can think of - we just did not have a specific requirement
for it at the time.

>
> Ok other questions
>
> Suppose instead you just add an abstracted socket interface of
>
> =A0 =A0 =A0 =A0AF_SOMETHING, PF_URI

Mike Waychison and I were saving the 'PF_URI' discussion for a future
date, but indeed
we're on the same wave-length :). Our initial requirements are for an
'extremely minimal
burden of support' on the userspace environments, so we decided to
open up a separate
discussion on PF_URI

>
> it would be easy to convert programs. It would be easier to write
> properly generic programs. It would be easy write some small helpers that
> are a good deal less insane than the existing inet ones. At that point
> you could turn the problem on its head. Instead of 'borrowing' sockets
> for a fairly specific concept of hw assist you ask the reverse question,
> who can accelerate this URI be it some kind of virtual machine interface,
> something funky like raw data over infiniband, or plain old 'use the
> TCP/IP stack'.

Completely agree.

>
> Your decision making code is going to be interesting but it only has to
> make the decision once in simple cases.

Yup.

>
> And yes there is still the complicated cases such as 'the routing table
> has changed from vitual host to via siberia now what' but I don't believe
> your proposal addresses that either.

Can you be more specific? If you mean solving the 'keeping your tcp connect=
ions
open to non virtual endpoints across a migration (or whatever)' then
no it doesn't :)

>
> Alan
>

Thanks man,

-san


-- =

San Mehat=A0|=A0Staff Software Engineer=A0|=A0san@google.com=A0|=A0415-366-=
6172
