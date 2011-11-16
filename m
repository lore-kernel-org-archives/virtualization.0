From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2 RFC] virtio-spec: flexible configuration layout
Date: Wed, 16 Nov 2011 09:21:38 +0200
Message-ID: <20111116072137.GF5433@redhat.com>
References: <8739e7uy87.fsf@rustcorp.com.au>
	<20111102233110.GA20289@redhat.com>
	<20111108214021.GA4538@redhat.com>
	<20111109195901.GA28155@redhat.com> <1320870287.3730.6.camel@lappy>
	<20111109205208.GA28599@redhat.com>
	<1320872248.3730.11.camel@lappy> <87aa83qoao.fsf@rustcorp.com.au>
	<CA+1xoqeH3ErNCELD+NoJHz=eH6FtxersUffoJSj0yQx2o=4g0g@mail.gmail.com>
	<87aa7xos3n.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87aa7xos3n.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, penberg@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Amit Shah <amit.shah@redhat.com>, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 16, 2011 at 10:28:52AM +1030, Rusty Russell wrote:
> On Fri, 11 Nov 2011 09:39:13 +0200, Sasha Levin <levinsasha928@gmail.com>=
 wrote:
> > On Fri, Nov 11, 2011 at 6:24 AM, Rusty Russell <rusty@rustcorp.com.au> =
wrote:
> > > (2) There's no huge win in keeping the same layout. =A0Let's make some
> > > =A0 =A0cleanups. =A0There are more users ahead of us then behind us (I
> > > =A0 =A0hope!).
> > =

> > Actually, if we already do cleanups, here are two more suggestions:
> > =

> > 1. Make 64bit features a one big 64bit block, instead of having 32bits
> > in one place and 32 in another.
> > 2. Remove the reserved fields out of the config (the ones that were
> > caused by moving the ISR and the notifications out).
> =

> Yes, those were exactly what I was thinking.  I left it vague because
> there might be others you can see if we're prepared to abandon the
> current format.
> =

> Cheers,
> Rusty.

Yes but driver code doesn't get any cleaner by moving the fields.
And in fact, the legacy support makes the code messier.
What are the advantages?

-- =

MST
