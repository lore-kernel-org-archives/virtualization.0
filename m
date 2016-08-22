From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] CodingStyle: add some more error handling guidelines
Date: Mon, 22 Aug 2016 17:53:02 +0300
Message-ID: <20160822174355-mutt-send-email-mst__24387.5478547581$1471877593$gmane$org@kernel.org>
References: <1471874251-7721-1-git-send-email-mst@redhat.com>
	<20160822081617.386db8cd@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160822081617.386db8cd@lwn.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Julia Lawall <julia.lawall@lip6.fr>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 22, 2016 at 08:16:17AM -0600, Jonathan Corbet wrote:
> On Mon, 22 Aug 2016 16:57:46 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > commit commit ea04036032edda6f771c1381d03832d2ed0f6c31 ("CodingStyle:
> > add some more error handling guidelines") suggests never naming goto
> > labels after the goto location - that is the error that is handled.
> > 
> > But it's actually pretty common and IMHO it's a reasonable style
> > provided each error gets its own label, and each label comes after the
> > matching cleanup:
> > 
> >                 foo = kmalloc(SIZE, GFP_KERNEL);
> >                 if (!foo)
> >                         goto err_foo;
> > 
> >                 foo->bar = kmalloc(SIZE, GFP_KERNEL);
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
> 
> Hmm, I've never encountered that style, but I've never gone looking for it
> either.  I find it a little confusing to detach a label from the code it
> will run.  Is this really something we want to encourage?  I kind of think
> this one needs some acks before I can consider it.

The point is really naming label for the part of init that failed
(and so needs to be skipped), rather than the part that will run.
Adding empty lines is not the point - does it look better like this?


                foo = kmalloc(SIZE, GFP_KERNEL);
                if (!foo)
                        goto err_foo;

                foo->bar = kmalloc(SIZE, GFP_KERNEL);
                if (!foo->bar)
                        goto err_bar;
                ...

                kfree(foo->bar);
        err_bar:
                kfree(foo);
        err_foo:
                return ret;




I don't know whether there are examples outside code that
I wrote myself, e.g. in vhost_dev_set_owner. I find
that it's helpful since it avoids churn if more
allocations are added.


> > diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
> > index 16917ac..e4d76c3 100644
> > --- a/tools/virtio/ringtest/main.h
> > +++ b/tools/virtio/ringtest/main.h
> > @@ -80,7 +80,9 @@ extern unsigned ring_size;
> >  
> >  /* Is there a portable way to do this? */
> >  #if defined(__x86_64__) || defined(__i386__)
> > -#define cpu_relax() asm ("rep; nop" ::: "memory")
> > +#define cpu_relax() do { \
> > +	asm ("rep; nop" ::: "memory"); \
> > +} while (0)
> >  #else
> >  #define cpu_relax() assert(0)
> >  #endif
> 
> This hunk seems somehow unrelated, either that or I really haven't
> understood the proposal :)
> 
> jon

Ouch, that's unrelated, sorry.

-- 
MST
