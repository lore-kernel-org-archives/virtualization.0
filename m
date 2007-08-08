From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 25/25] [PATCH] add paravirtualization support for x86_64
Date: Thu, 09 Aug 2007 09:18:57 +1000
Message-ID: <1186615137.17470.100.camel__10769.0055192963$1186617901$gmane$org@localhost.localdomain>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<1186546847263-git-send-email-gcosta@redhat.com>
	<11865468513077-git-send-email-gcosta@redhat.com>
	<200708081200.13669.ak@suse.de>
	<5d6222a80708080749t35c5c0ceo8b3b8f0cce50c666@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80708080749t35c5c0ceo8b3b8f0cce50c666@mail.gmail.com>
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
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-08-08 at 11:49 -0300, Glauber de Oliveira Costa wrote:
> On 8/8/07, Andi Kleen <ak@suse.de> wrote:
> > > +EXPORT_SYMBOL(paravirt_ops);
> >
> > Definitely _GPL at least.
> Sure.

We ended up making it EXPORT_SYMBOL in i386 because every driver wants
to save and restore interrupt state.

But questionably-licensed drivers might be less of a concern on x86-64.

Cheers,
Rusty.
