From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 13/21] [PATCH] change bitwise operations to get a void
	parameter.
Date: Tue, 18 Dec 2007 16:18:42 +1100
Message-ID: <200712181618.43852.rusty__1504.14577587998$1197955238$gmane$org@rustcorp.com.au>
References: <11979319641796-git-send-email-gcosta@redhat.com>
	<11979320252102-git-send-email-gcosta@redhat.com>
	<11979320302030-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11979320302030-git-send-email-gcosta@redhat.com>
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
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, mingo@elte.hu, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 18 December 2007 09:52:36 Glauber de Oliveira Costa wrote:
> This patch changes the bitwise operations in bitops.h to get
> a void pointers as a parameter. Before this patch, a lot of warnings
> can be seen. They're gone after it.

No, this is a backwards step!  These warnings are important for 
non-arch-specific code: I fought hard to get them made into unsigned longs.

But I'm happy for this to be applied as is, then I'll grab the git tree, 
revert it and fix the warnings...

Rusty.
