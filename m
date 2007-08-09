From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 25/25] [PATCH] add paravirtualization support for x86_64
Date: Thu, 9 Aug 2007 16:26:09 +0200
Message-ID: <200708091626.09316.ak__10214.269362814$1186669758$gmane$org@suse.de>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<200708081200.13669.ak@suse.de> <46BAB9DD.5030400@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46BAB9DD.5030400@goop.org>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org


> This has to match the normal C calling convention though, doesn't it?

Native cli/sti/save/restore_flags are all only assembly and can be easily
(in fact more easily than in C) written as pure assembler functions. Then
you can use whatever calling convention you want.

While some paravirt implementations may have more complicated implementations
i guess it's still a reasonable requirement to make them simple enough 
in pure assembler. If not they can use a trampoline, but that's hopefully
not needed.

-Andi
