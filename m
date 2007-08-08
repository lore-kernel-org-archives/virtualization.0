From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 25/25] [PATCH] add paravirtualization support for x86_64
Date: Wed, 8 Aug 2007 07:58:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708080754230.5921__16910.5050423697$1186574511$gmane$org@gandalf.stny.rr.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<1186546847263-git-send-email-gcosta@redhat.com>
	<11865468513077-git-send-email-gcosta@redhat.com>
	<200708081200.13669.ak@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708081200.13669.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org


On Wed, 8 Aug 2007, Andi Kleen wrote:

> Strictly you would at least need a !X86_VSMP dependency, but
> with the vsmp change i requested that will be unnecessary
>
> Is this really synced with the latest version of the i386 code?

Glauber started the paravirt ops 64 a second time around, from scratch
using the PVOPS of i386 as a base. But since we couldn't just take a the
PVOPS patch from i386 and apply it to x86_64, this was mainly done by
looking at i386 code and massaging it for x86_64. Somethings may have
slipped (and we may have been looking at different versions of PVOPS).
It's not easy trying to keep up with a moving target ;-)

-- Steve
