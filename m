From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] CodingStyle: add some more error handling guidelines
Date: Tue, 23 Aug 2016 14:58:32 +0300
Message-ID: <20160823115832.GG4129@mwanda>
References: <1471874251-7721-1-git-send-email-mst@redhat.com>
	<87mvk3vjbg.fsf@miraculix.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87mvk3vjbg.fsf@miraculix.mork.no>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Julia Lawall <julia.lawall@lip6.fr>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 23, 2016 at 01:03:15PM +0200, Bj=F8rn Mork wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> =

> >                 foo =3D kmalloc(SIZE, GFP_KERNEL);
> >                 if (!foo)
> >                         goto err_foo;
> >
> >                 foo->bar =3D kmalloc(SIZE, GFP_KERNEL);
> >                 if (!foo->bar)
> >                         goto err_bar;
> >                 ...
> >
> >                 kfree(foo->bar);
> >         err_bar:
> >
> >                 kfree(foo);
> >         err_foo:
> >
> >                 return ret;
> =

> =

> I believe the CodingStyle already contain far too much personal style to
> be useful as real style guide.  FWIW, I prefer a single error label, at
> the "cost" of additional tests in the error path:
> =

> =

>                  foo =3D kmalloc(SIZE, GFP_KERNEL);
>                  if (!foo)
>                          goto err;
>                  foo->bar =3D kmalloc(SIZE, GFP_KERNEL);
>                  if (!foo->bar)
>                          goto err;
>                  ...
>  		 if (ret)
> 			goto err;
>                  return 0;
>       err:
>                  if (foo)
>                         kfree(foo->bar);
>                  kfree(foo);
>                  return ret;
> =

> =

> The advantage is that I don't have to manage X different labels,
> ensuring that they have the order is correct if some part of the
> function is refactored etc.  That tends to get too complicated for my
> simple brain. And since the error path is rarely tested, complicated
> equals buggy.

Empirically, that style is *way* more bug prone.  I call these bugs "One
Err Bugs".  It's one of the most common types of bugs I deal with from
static analysis.

The order is not hard.  It's just the reverse order from how it was
allocated.  Hike up the mountain, then if you get stuck hike back down
using the exact same path.  Then at the end, you basically have written
your ->remove()  function so it's a bonus.

> =

> My sample will of course trigger all those nice "optimizing the error
> path" patches, but I ignore those anyway so that's not a big deal.

That's not my fault.  :/  I have tried over and over and over to tell
that guy to stop sending patches but everyone else encourages him.  I
feel like it should be a rule that if you introduce bugs, you should be
told to stop sending cleanup patches until you have fixed enough bugs to
redeem yourself.

regards,
dan carpenter
