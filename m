From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0/25][V3] pvops_64 last round (hopefully)
Date: Wed, 15 Aug 2007 11:04:51 -0700
Message-ID: <46C34043.1060203__30654.2219281711$1187201404$gmane$org@goop.org>
References: <11871821854176-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11871821854176-git-send-email-gcosta@redhat.com>
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
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Glauber de Oliveira Costa wrote:
> This is hopefully the last iteration of the pvops64 patch.
>
> From the last version, we have only one change, which is include/asm-x86_64/processor.h: There were still one survivor in raw asm.
> Also, git screwed me up for some reason, and the 25th patch was missing the new files, paravirt.{c,h}. (although I do remember having git-add'ed it, but who knows...)
>
> Andrew, could you please push it to -mm ?

Hm, I have a patch here to refactor the pv-ops interface into smaller
pieces.  It needs a respin against 32-bit, and obviously 64-bit should
be equivalent.  Its mostly a moving things around patch rather than a
big semantic change, so changing the users of the interface is fairly
straightforward.  I'll post it shortly, but if everyone agrees that its
the way we want to go, we should probably start out with it on 64-bit.

    J
