From: San Mehat <san@google.com>
Subject: Re: [RFC 0/0] Introducing a generic socket offload framework
Date: Fri, 19 Aug 2011 07:58:29 -0700
Message-ID: <CAPi7mHp==JPA-0vNZ+xWRzOuJYUxsUL3UY=o=VtMUsB-YcFHwQ__43767.2715321698$1313770243$gmane$org@mail.gmail.com>
References: <20110818220756.5C93E5C80B@san.sea.corp.google.com>
	<1313758185.16299.43.camel@mojatatu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1313758185.16299.43.camel@mojatatu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jhs@mojatatu.com
Cc: mst@redhat.com, netdev@vger.kernel.org, miche@google.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, digitaleric@google.com, mikew@google.com, maccarro@google.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 19, 2011 at 5:49 AM, jamal <hadi@cyberus.ca> wrote:
>
> On Thu, 2011-08-18 at 15:07 -0700, San Mehat wrote:
> > TL;DR
> > -----
> > In this RFC we propose the introduction of the concept of hardware sock=
et
> > offload to the Linux kernel. Patches will accompany this RFC in a few d=
ays,
> > but we felt we had enough on the design to solicit constructive discuss=
ion
> > from the community at-large.
> >
>
> [..]
>
> > ALTERNATIVE STRATEGIES
> > ----------------------
> >
> > An alternative strategy for providing similar functionality involves ei=
ther
> > modifying glibc or using LD_PRELOAD tricks to intercept socket calls. W=
e were
> > forced to rule this out due to the complexity (and fragility) involved =
with
> > attempting to maintain a general solution compatible across various
> > distributions where platform-libraries differ.
>
> Above should have been in your TL;DR;->
>
> LD_PRELOAD is also horrible because of the granularity of the socket
> calls;
> Having things in the kernel and specifically tagging socket as needing
> this feature is much much more manageable.
>
> Tying things to virtualization may miss the big picture because there
> are many other use cases for intercepting socket calls, example:
> Samir Bellabes <sam@synack.fr> has been trying to get what he refers to
> as "personal firewall" (equivalent to the silly windows firewall) which
> prompts the user "ping from blah, do you want to allow a response?"
> That requires intercepting send/recv calls, prompt the user in possibly
> some pop-up and act based on response. It requires looking at content.
> He is trying to use selinux for that interface,
> but i think this would be the right abstraction.

I agree; there's no reason this needs to be tied to virtualization -
it was just the
driving force behind the design. I will generalize the backend interface ty=
pes

> I hope you plan to support send/recv.

yes

> I also hope you add support for SOCK_RAW (and maybe SOCK_PACKET).

Can you explain a good use-case for SOCK_RAW in this type of
environment? We were noodling it around locally and couldn't come up
with one that we needed to support.

>
> Q: If you want this to be transparent to the apps, who/what is doing
> the tagging of SOCK_HWASSIST? clearly not the app if you dont want to
> change it.

The decision of whether to tag a socket or not is made by the 'hardware'

>
> I like the uri abstraction if it doesnt come at the expense of the
> app transparency.
>

Thank you

-san

> cheers,
> jamal
>



--
San Mehat=A0|=A0Staff Software Engineer=A0|=A0san@google.com=A0|=A0415-366-=
6172
