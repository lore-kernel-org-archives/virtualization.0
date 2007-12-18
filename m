From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 21/21] [PATCH] finish processor.h integration
Date: Tue, 18 Dec 2007 16:43:19 +0100
Message-ID: <20071218154319.GA11369@elte.hu>
References: <11979320401316-git-send-email-gcosta@redhat.com>
	<11979320451308-git-send-email-gcosta@redhat.com>
	<1197932050948-git-send-email-gcosta@redhat.com>
	<11979320551036-git-send-email-gcosta@redhat.com>
	<11979320603229-git-send-email!-gcosta@redhat.com>
	<11979320653161-git-send-email-gcosta@redhat.com>
	<11979320693300-git-send-email-gcosta@redhat.com>
	<20071218131932.GA9457@elte.hu> <20071218133818.GA9941@elte.hu>
	<4767CFC5.3010703@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4767CFC5.3010703@redhat.com>
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


* Glauber de Oliveira Costa <gcosta@redhat.com> wrote:

>> here the problem is apparently caused by your patch, a careless 
>> 'unification' of include file sections. 32-bit had this:
>
> Point is this patches do unification, but they are not just that, as 
> you can see. I am attempting to cleanup headers that appears not to be 
> used, [...]

do cleanups and unification in _separate_ patches. We do not want to 
change a SINGLE LINE OF SOURCE CODE in a patch that says "unify" and 
moves a block of code from one file to another, ok? If you see some 
obvious cleanups do it in pre or post patches (whichever looks more 
logical). That makes it totally bisectable and i can drop the bogus 
cleanup patch instead of having to drop a full unification patch.

	Ingo
