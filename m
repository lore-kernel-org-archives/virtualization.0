From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/10] Integrate msr.h
Date: Tue, 4 Dec 2007 15:09:39 +0100
Message-ID: <20071204140939.GA16328__6364.12187382138$1196777565$gmane$org@elte.hu>
References: <11967666042130-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <11967666042130-git-send-email-gcosta@redhat.com>
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
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Glauber de Oliveira Costa <gcosta@redhat.com> wrote:

> Hello,
> 
> This series of patches integrates msr.h header. What it really does, 
> is a series of steps to allow us to get rid of duplicate code between 
> i386 and x86_64 versions
> 
> With this done, achieving paravirt for x86_64 gets really easy, just a 
> couple of extra code.

thanks, the patches look certainly sane and i've picked them up into 
x86.git. A quick build & boot test was successful on both 64-bit and 
32-bit, with paravirt on/off. I've pushed out the latest tree into the 
'mm' branch of:

   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/linux-2.6-x86.git

minor nit: some of your patches had scripts/checkpatch.pl failures, 
could you try to fix them up? (If possible then as a follow-up second 
patch series.) Thanks!

[ btw., how far away are you from having Kconfig selectable 64-bit
  paravirt support? Just curious :-) ]

	Ingo
