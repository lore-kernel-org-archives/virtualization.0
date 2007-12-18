From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 13/21] [PATCH] change bitwise operations to get a void
	parameter.
Date: Tue, 18 Dec 2007 10:40:52 -0200
Message-ID: <5d6222a80712180440l72faa8fere9588ea6894cf1cb__8132.97906793213$1197981786$gmane$org@mail.gmail.com>
References: <11979319641796-git-send-email-gcosta@redhat.com>
	<11979320252102-git-send-email-gcosta@redhat.com>
	<11979320302030-git-send-email-gcosta@redhat.com>
	<200712181618.43852.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200712181618.43852.rusty@rustcorp.com.au>
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
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Dec 18, 2007 3:18 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> On Tuesday 18 December 2007 09:52:36 Glauber de Oliveira Costa wrote:
> > This patch changes the bitwise operations in bitops.h to get
> > a void pointers as a parameter. Before this patch, a lot of warnings
> > can be seen. They're gone after it.
>
> No, this is a backwards step!  These warnings are important for
> non-arch-specific code: I fought hard to get them made into unsigned longs.
>
> But I'm happy for this to be applied as is, then I'll grab the git tree,
> revert it and fix the warnings...
>
Even before my processor.h patches, there are a lot of warnings caused by this.
If Ingo does not mind getting more warnings, I can drop this patch
entirely, and you (or someone else)
can fix them later on.


-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
