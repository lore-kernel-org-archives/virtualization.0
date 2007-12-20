From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 13/15] move patching code to arch-specific file.
Date: Thu, 20 Dec 2007 21:33:12 +0100
Message-ID: <20071220203312.GA21251__38227.2967407063$1198182929$gmane$org@elte.hu>
References: <1198181224677-git-send-email-gcosta@redhat.com>
	<11981812412879-git-send-email-gcosta@redhat.com>
	<11981812771615-git-send-email-gcosta@redhat.com>
	<1198181309285-git-send-email-gcosta@redhat.com>
	<11981813192341-git-send-email-gcosta@redhat.com>
	<11981813292926-git-send-email-gcosta@redhat.com>
	<11981813384090-git-send-email-gcosta@redhat.com>
	<1198181348746-git-send-email-gcosta@redhat.com>
	<11981813592589-git-send-email-gcosta@redhat.com>
	<20071220203148.GA20826@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071220203148.GA20826@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Ingo Molnar <mingo@elte.hu> wrote:

> this patch adds the paravirt_patch_32.o:
> 
> > -obj-$(CONFIG_PARAVIRT)		+= paravirt.o
> > +obj-$(CONFIG_PARAVIRT)		+= paravirt.o paravirt_patch_32.o
> 
> but does not add that file nor any other rule to build that target, so 
> it fails to build with the attached config:
> 
> make[1]: *** No rule to make target 
>  `arch/x86/kernel/paravirt_patch_32.o', needed by 
>  `arch/x86/kernel/built-in.o'.  Stop.

if it's just that single missing file then please send me a patch that 
adds that file and i'll add it to this patch. (instead of resending the 
whole series)

	Ingo
