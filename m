From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/16] lguest: introduce vcpu structure
Date: Mon, 7 Jan 2008 11:53:57 +1100
Message-ID: <200801071153.57710.rusty__15888.8552141891$1199667364$gmane$org@rustcorp.com.au>
References: <11981576363806-git-send-email-gcosta@redhat.com>
	<200712261054.46261.rusty@rustcorp.com.au>
	<5d6222a80801060933h7bc0d158h6e3b445c3db43291@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80801060933h7bc0d158h6e3b445c3db43291@mail.gmail.com>
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
To: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 07 January 2008 04:33:53 Glauber de Oliveira Costa wrote:
> On Dec 25, 2007 9:54 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> >     My only question is whether we should go further and vpu-ify routines
> > like lgread and kill_guest, so that we can avoid more "lg" temporary
> > variables...
>
> Essentially, they don't need it, because they only touch
> globally-visible variables (visible to the guest).
> So it's more of an stylish thing. Using the vcpu in the signature can
> have only one harm:
> It needs the caller to also have a pointer to a vcpu, so we may end up
> using it everywhere, like a domino fall.
>
> Alternatively, in such functions that don't currently receive a vcpu
> (nor they need to), we can convention to always pass
> lg->vcpus[0] to lgread, kill_guest, etc. Which one do you prefer?

I'm happy with a domino effect.  I don't want to see lg->vcpus[0] *anywhere* 
though, because it's non-futureproof.

When I looked through these patches it seems to me that we should accept that 
vcpu is now the basic guest unit, and lg exists to serve it.  Otherwise I 
think you can see the bones of the old UP code poking through, and that's 
ugly.

Thanks!
Rusty.
