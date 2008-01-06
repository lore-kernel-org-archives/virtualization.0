From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 0/16] lguest: introduce vcpu structure
Date: Sun, 6 Jan 2008 15:33:53 -0200
Message-ID: <5d6222a80801060933h7bc0d158h6e3b445c3db43291__5338.75549813292$1199640975$gmane$org@mail.gmail.com>
References: <11981576363806-git-send-email-gcosta@redhat.com>
	<200712261054.46261.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200712261054.46261.rusty@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Dec 25, 2007 9:54 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> On Friday 21 December 2007 00:33:40 Glauber de Oliveira Costa wrote:
> > this patch makes room for the vcpu structure in lguest, already used in
> > this very same way at lguest64. It's the first part of our plan to
> > have lguest and lguest64 unified too.
>
> Hi Glauber!
>
>     These patches look really solid, thanks!  A few minor things, then I'll
> apply them and push them for 2.6.25.

Thanks for all comments. I was in vacations until today, and I'll
repost a new version that address all your comments
soon (that's why I'm not answering each of them individually now, have
to look carefully)

>     My only question is whether we should go further and vpu-ify routines like
> lgread and kill_guest, so that we can avoid more "lg" temporary variables...
Essentially, they don't need it, because they only touch
globally-visible variables (visible to the guest).
So it's more of an stylish thing. Using the vcpu in the signature can
have only one harm:
It needs the caller to also have a pointer to a vcpu, so we may end up
using it everywhere, like a domino fall.

Alternatively, in such functions that don't currently receive a vcpu
(nor they need to), we can convention to always pass
lg->vcpus[0] to lgread, kill_guest, etc. Which one do you prefer?

> > When two dogs hang out, you don't have new puppies right in the other day.
> > Some time has to be elapsed. They have to grow first. In this same spirit,
> > having these patches _do not_ mean smp guests can be launched (yet)
> > Much more work is to come, but this is the basic infrastructure.
>
> OK, that made me laugh...
\o/
> Thanks!
> Rusty.
>
>



-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
