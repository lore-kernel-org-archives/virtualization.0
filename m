From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] finish processor.h integration
Date: Tue, 18 Dec 2007 22:32:43 +0100
Message-ID: <200712182232.45685.elendil__45880.3684953184$1198015998$gmane$org@planet.nl>
References: <1198008293639-git-send-email-gcosta@redhat.com>
	<E1J4jSf-00024X-GN@faramir.fjphome.nl>
	<5d6222a80712181300l707035e7mdb8a6e0d7a5ddca8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80712181300l707035e7mdb8a6e0d7a5ddca8@mail.gmail.com>
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
To: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, ak@suse.de, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 18 December 2007, Glauber de Oliveira Costa wrote:
> On Dec 18, 2007 6:54 PM, Frans Pop <elendil@planet.nl> wrote:
> > Glauber de Oliveira Costa wrote:
> > > What's left in processor_32.h and processor_64.h cannot be cleanly
> > > integrated. However, it's just a couple of definitions. They are
> > > moved to processor.h around ifdefs, and the original files are
> > > deleted. Note that there's much less headers included in the final
> > > version.
> >
> > Either I must be missing something or this patch was corrupted somehow.
>
> neither.
> Note the else in the middle. It's just a mistake in the comment.

Wouldn't an explicit second #ifdef block be a lot clearer (and improve 
maintainability) in this case?

An #else can easily be overlooked among other preprocessor commands or when 
#ifdefs get nested.
