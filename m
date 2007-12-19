From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH] finish processor.h integration
Date: Wed, 19 Dec 2007 00:56:01 -0200
Message-ID: <5d6222a80712181856l4f24104ei38ecd2e9f0c6422e__36118.3332199745$1198033097$gmane$org@mail.gmail.com>
References: <1198008293639-git-send-email-gcosta@redhat.com>
	<E1J4jSf-00024X-GN@faramir.fjphome.nl>
	<5d6222a80712181300l707035e7mdb8a6e0d7a5ddca8@mail.gmail.com>
	<200712182232.45685.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200712182232.45685.elendil@planet.nl>
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
To: Frans Pop <elendil@planet.nl>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, ak@suse.de, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Dec 18, 2007 7:32 PM, Frans Pop <elendil@planet.nl> wrote:
> On Tuesday 18 December 2007, Glauber de Oliveira Costa wrote:
> > On Dec 18, 2007 6:54 PM, Frans Pop <elendil@planet.nl> wrote:
> > > Glauber de Oliveira Costa wrote:
> > > > What's left in processor_32.h and processor_64.h cannot be cleanl=
y
> > > > integrated. However, it's just a couple of definitions. They are
> > > > moved to processor.h around ifdefs, and the original files are
> > > > deleted. Note that there's much less headers included in the fina=
l
> > > > version.
> > >
> > > Either I must be missing something or this patch was corrupted some=
how.
> >
> > neither.
> > Note the else in the middle. It's just a mistake in the comment.
>
> Wouldn't an explicit second #ifdef block be a lot clearer (and improve
> maintainability) in this case?
>
> An #else can easily be overlooked among other preprocessor commands or =
when
> #ifdefs get nested.
>
I don't think so. a if-then-else kind of construction is very common,
well expected, and heavily used in kernel.
But even if I=B4m not right, this is functionally correct, and can be
addressed in a later cleanup patch if you really want to.


--=20
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
