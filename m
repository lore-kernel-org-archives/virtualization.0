From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 13/15] move patching code to arch-specific file.
Date: Thu, 20 Dec 2007 22:26:51 +0100
Message-ID: <20071220212651.GA11897__35253.6552156836$1198186259$gmane$org@elte.hu>
References: <11981812771615-git-send-email-gcosta@redhat.com>
	<1198181309285-git-send-email-gcosta@redhat.com>
	<11981813192341-git-send-email-gcosta@redhat.com>
	<11981813292926-git-send-email-gcosta@redhat.com>
	<11981813384090-git-send-email-gcosta@redhat.com>
	<1198181348746-git-send-email-gcosta@redhat.com>
	<11981813592589-git-send-email-gcosta@redhat.com>
	<20071220203148.GA20826@elte.hu> <20071220203312.GA21251@elte.hu>
	<5d6222a80712201322t46591ce2n5cf3248aa2e1dd26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5d6222a80712201322t46591ce2n5cf3248aa2e1dd26@mail.gmail.com>
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
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Glauber de Oliveira Costa <glommer@gmail.com> wrote:

> > > make[1]: *** No rule to make target
> > >  `arch/x86/kernel/paravirt_patch_32.o', needed by
> > >  `arch/x86/kernel/built-in.o'.  Stop.
> >
> > if it's just that single missing file then please send me a patch that
> > adds that file and i'll add it to this patch. (instead of resending the
> > whole series)
> 
> Yeah, I must have forgotten to git-add it. It was building here fine, 
> because I clearly have the file locally ;-)
> 
> I'm attaching a new patch that replaces just this one.

thanks, this did the trick, it builds fine now.

	Ingo
