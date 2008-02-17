From: "Glauber Costa" <glommer@gmail.com>
Subject: Re: [PATCH 4/5] [PATCH] introduce paravirt helpers
Date: Sun, 17 Feb 2008 18:56:56 -0200
Message-ID: <5d6222a80802171256l6e178eb8h1080bfd5a6b95ef3__5880.31032025373$1203282202$gmane$org@mail.gmail.com>
References: <1202757365-18634-1-git-send-email-gcosta@redhat.com>
	<1202757365-18634-2-git-send-email-gcosta@redhat.com>
	<1202757365-18634-3-git-send-email-gcosta@redhat.com>
	<1202757365-18634-4-git-send-email-gcosta@redhat.com>
	<20080217180509.GW6006@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080217180509.GW6006@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: ehabkost@redhat.com, shai@scalemp.com, linux-kernel@vger.kernel.org, Glauber Costa <gcosta@redhat.com>, chrisw@sous-sol.org, kiran@scalemp.com, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Feb 17, 2008 4:05 PM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Glauber Costa <gcosta@redhat.com> wrote:
>
> >  config X86_VSMP
> >       bool "Support for ScaleMP vSMP"
> >       depends on X86_64 && PCI
> > -      help
> > +     select PARAVIRT
> > +     help
>
> hm, what's the idea here?

guys from scalemp can probably give a better picture if needed,
but in a nutshell, there are two aspects involved with the vsmp
support. The first one
is special L1 alignments, and the second, specialized irq handling routines.

Only the second one is paravirt in itself, and are the ones addressed
in this patch.
The specialized routines now goes through paravirt ops. So when using
a vsmp machine,
paravirt has to be selected, in order to enable such functions.

-- 
Glauber  Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
