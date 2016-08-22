From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] CodingStyle: add some more error handling guidelines
Date: Mon, 22 Aug 2016 17:23:04 +0300
Message-ID: <20160822142304.GD4129@mwanda>
References: <1471874251-7721-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1471874251-7721-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 22, 2016 at 04:57:46PM +0300, Michael S. Tsirkin wrote:
> commit commit ea04036032edda6f771c1381d03832d2ed0f6c31 ("CodingStyle:
> add some more error handling guidelines") suggests never naming goto
> labels after the goto location - that is the error that is handled.
> 
> But it's actually pretty common and IMHO it's a reasonable style
> provided each error gets its own label, and each label comes after the
> matching cleanup:
> 
>                 foo = kmalloc(SIZE, GFP_KERNEL);
>                 if (!foo)
>                         goto err_foo;

Come-from labels are a common anti-pattern.  The don't add any
information if you are reading a function from start to end/top to
bottom.  Imagine if we named all functions after then functions which
called them.  This is the same concept.

What does goto err_foo tell you?  Nothing...  But goto err_free_bar
tells you exactly what it does.

Creating a new label for each goto means you can search easily,
I suppose, but jumping down to the bottom of the function and then back
up disrupts the flow.  We're not really using the name itself in that
case, we're just treating the text as a opaque search string and not
meaningful for its own sake.

I see a lot of error handling bugs where people get confused or often
they just decide that error handling is too complicated and they leave
it out.  But error handling is really simple to write correctly if you
follow a few simple rules.

1) Don't just use one out label for everything.  Doing multiple things
   makes the code more complicated and bug prone.
2) Don't free things which haven't been allocated.
3) Unwind in the reverse order that you allocated things.
4) Use meaningful names which tell what the goto does.
5) If there is an if statement in allocation code, then put an mirror if
   statement in the unwind code.

regards,
dan carpenter
