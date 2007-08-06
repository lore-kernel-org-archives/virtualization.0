From: "pradeep singh" <pradeep.rautela@gmail.com>
Subject: Re: [Q]lguest git repo location?
Date: Mon, 6 Aug 2007 12:27:41 +0530
Message-ID: <a901b49a0708052357v5ef19020sa674f0d1c3c44b05@mail.gmail.com>
References: <a901b49a0708040714n52d83eb4ub39d5b76acb1032b@mail.gmail.com>
	<1186361208.32112.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1186361208.32112.29.camel@localhost.localdomain>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization-list <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Thank you Rusty.

Best Regards
--pradeep
On 8/6/07, Rusty Russell <rusty@rustcorp.com.au> wrote:
> On Sat, 2007-08-04 at 19:44 +0530, pradeep singh wrote:
> > HI Rusty,
> >
> > I wanted to play with lguest. As it was recently merge upstream by
> > Linus, i took a look and the location looks like driver/lguest*.
> >
> > Unfortunately my local git repo cannot get the 2.6.23-rc2 changes from
> > upstream somehow :-/.[duh... says "Cannot get the repository state
> > from http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git"].
> > i do not know what i am doing wrong.
> >
> > Coming back to point -
> > Do you maintain a lguest git repository somewhere? So that i can clone
> > it and experiment with it?
>
> Hi Pradeep!
>
>         I don't keep a git repository; I keep some patches which fits my
> working style better.  However, the 2.6.23-rc2 tree should work with
> this one patch:
> ==
> Lguest drivers need to default to "Y" otherwise they're never selected
> for new builds.  We don't bother prompting, because they're less than
> 4k combined.
>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>
> ---
>  drivers/lguest/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)
>
> ===================================================================
> --- a/drivers/lguest/Kconfig
> +++ b/drivers/lguest/Kconfig
> @@ -21,8 +21,10 @@ config LGUEST_GUEST
>
>  config LGUEST_NET
>         tristate
> +       default y
>         depends on LGUEST_GUEST && NET
>
>  config LGUEST_BLOCK
>         tristate
> +       default y
>         depends on LGUEST_GUEST && BLOCK
>
>
>


-- 
Pradeep
